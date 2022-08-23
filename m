Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC659DF16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354214AbiHWLZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357421AbiHWLUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:20:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442AB66A63
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:22:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5FE3E34242;
        Tue, 23 Aug 2022 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661246551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=7MALDZdKlPD1qJhPRnp+mwvr3buPuhYiou9jp8o4OZY=;
        b=Pkp3VSe2XQ8B934eUPHE5Sge/GF6CcrvyU92rx15kmOptdqu1u1ukcVNUL90w1ziDqgfdx
        4PSZCN6OAK46j2Ju+HyxCyJ6uCDVGpFrf3owzRceIqH2rsFPk2B3vNREZRFeZlAuPseGhM
        QAoSbFbVvY7DJRGIv29xjTOXeWkfwSs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 460B413AB7;
        Tue, 23 Aug 2022 09:22:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f4+YEFecBGO3cAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 23 Aug 2022 09:22:31 +0000
Date:   Tue, 23 Aug 2022 11:22:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] mm: reduce noise in show_mem for lowmem allocations
Message-ID: <YwScVmVofIZkopkF@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
while discussing early DMA pool pre-allocation failure with Christoph
[1] I have realized that the allocation failure warning is rather noisy
for constrained allocations like GFP_DMA{32}. Those zones are usually
not populated on all nodes very often as their memory ranges are
constrained.

This is an attempt to reduce the ballast that doesn't provide any
relevant information for those allocation failures investigation.
Please note that I have only compile tested it (in my default config
setup) and I am throwing it mostly to see what people think about it.

[1] http://lkml.kernel.org/r/20220817060647.1032426-1-hch@lst.de
--- 
From 94a76853bd097a424d637f2935552c64c173787f Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Tue, 23 Aug 2022 11:05:07 +0200
Subject: [RFC PATCH] mm: reduce noise in show_mem for lowmem allocations

GFP_DMA or GFP_DMA32 allocation failures can be quite noisy with a lot
of pointless information:
[   14.017417][    T1] swapper/0: page allocation failure: order:10, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0-7
[   14.017429][    T1] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.14.21-150400.22-default #1 SLE15-SP4 0b6a6578ade2de5c4a0b916095dff44f76ef1704
[   14.017434][    T1] Hardware name: XXXXXXX
[   14.017437][    T1] Call Trace:
[   14.017444][    T1]  <TASK>
[   14.017449][    T1]  dump_stack_lvl+0x45/0x57
[   14.017469][    T1]  warn_alloc+0xfe/0x160
[   14.017490][    T1]  __alloc_pages_slowpath.constprop.112+0xc27/0xc60
[   14.017497][    T1]  ? rdinit_setup+0x2b/0x2b
[   14.017509][    T1]  ? rdinit_setup+0x2b/0x2b
[   14.017512][    T1]  __alloc_pages+0x2d5/0x320
[   14.017517][    T1]  alloc_page_interleave+0xf/0x70
[   14.017531][    T1]  atomic_pool_expand+0x4a/0x200
[   14.017541][    T1]  ? rdinit_setup+0x2b/0x2b
[   14.017544][    T1]  __dma_atomic_pool_init+0x44/0x90
[   14.017556][    T1]  dma_atomic_pool_init+0xad/0x13f
[   14.017560][    T1]  ? __dma_atomic_pool_init+0x90/0x90
[   14.017562][    T1]  do_one_initcall+0x41/0x200
[   14.017581][    T1]  kernel_init_freeable+0x236/0x298
[   14.017589][    T1]  ? rest_init+0xd0/0xd0
[   14.017596][    T1]  kernel_init+0x16/0x120
[   14.017599][    T1]  ret_from_fork+0x22/0x30
[   14.017604][    T1]  </TASK>
[   14.017605][    T1] Mem-Info:
[   14.017956][    T1] active_anon:0 inactive_anon:0 isolated_anon:0
[   14.017956][    T1]  active_file:0 inactive_file:0 isolated_file:0
[   14.017956][    T1]  unevictable:0 dirty:0 writeback:0
[   14.017956][    T1]  slab_reclaimable:876 slab_unreclaimable:30300
[   14.017956][    T1]  mapped:0 shmem:0 pagetables:12 bounce:0
[   14.017956][    T1]  free:3170151735 free_pcp:6868 free_cma:0
[   14.017962][    T1] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:7200kB pagetables:4kB all_unreclaimable? no
[   14.017969][    T1] Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6728kB pagetables:16kB all_unreclaimable? no
[   14.017973][    T1] Node 2 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6800kB pagetables:0kB all_unreclaimable? no
[   14.017977][    T1] Node 3 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6960kB pagetables:0kB all_unreclaimable? no
[   14.017982][    T1] Node 4 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6656kB pagetables:0kB all_unreclaimable? no
[   14.017985][    T1] Node 5 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6784kB pagetables:24kB all_unreclaimable? no
[   14.017989][    T1] Node 6 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6928kB pagetables:4kB all_unreclaimable? no
[   14.017994][    T1] Node 7 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:7072kB pagetables:0kB all_unreclaimable? no
[   14.018026][    T1] Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   14.018035][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018063][    T1] Node 0 DMA32 free:0kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1313380kB managed:1154392kB mlocked:0kB bounce:0kB free_pcp:216kB local_pcp:0kB free_cma:0kB
[   14.018070][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018098][    T1] Node 0 Normal free:1583344560kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1609039872kB managed:1583858824kB mlocked:0kB bounce:0kB free_pcp:12692kB local_pcp:256kB free_cma:0kB
[   14.018105][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018132][    T1] Node 1 Normal free:1585397152kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585429652kB mlocked:0kB bounce:0kB free_pcp:1772kB local_pcp:76kB free_cma:0kB
[   14.018138][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018161][    T1] Node 2 Normal free:1585394152kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585429652kB mlocked:0kB bounce:0kB free_pcp:2292kB local_pcp:48kB free_cma:0kB
[   14.018166][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018191][    T1] Node 3 Normal free:1585394052kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585429652kB mlocked:0kB bounce:0kB free_pcp:2336kB local_pcp:0kB free_cma:0kB
[   14.018197][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018232][    T1] Node 4 Normal free:1585397584kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585429652kB mlocked:0kB bounce:0kB free_pcp:1764kB local_pcp:68kB free_cma:0kB
[   14.018238][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018264][    T1] Node 5 Normal free:1585349060kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585386604kB mlocked:0kB bounce:0kB free_pcp:1924kB local_pcp:32kB free_cma:0kB
[   14.018270][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018300][    T1] Node 6 Normal free:1585395340kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585429652kB mlocked:0kB bounce:0kB free_pcp:2160kB local_pcp:72kB free_cma:0kB
[   14.018305][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018330][    T1] Node 7 Normal free:1584934880kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1584970756kB mlocked:0kB bounce:0kB free_pcp:2316kB local_pcp:100kB free_cma:0kB
[   14.018335][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018339][    T1] Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 0*64kB 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 160kB
[   14.018352][    T1] Node 0 DMA32: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
[   14.018361][    T1] Node 0 Normal: 1*4kB (U) 1*8kB (M) 0*16kB 1*32kB (E) 1*64kB (U) 2*128kB (ME) 2*256kB (ME) 2*512kB (UM) 1*1024kB (E) 0*2048kB 386558*4096kB (M) = 1583344492kB
[   14.018377][    T1] Node 1 Normal: 17*4kB (UM) 1*8kB (U) 2*16kB (UM) 2*32kB (UE) 1*64kB (E) 2*128kB (UM) 3*256kB (UME) 2*512kB (ME) 1*1024kB (E) 2*2048kB (ME) 387058*4096kB (M) = 1585396972kB
[   14.018393][    T1] Node 2 Normal: 44*4kB (UM) 1*8kB (U) 1*16kB (M) 1*32kB (U) 2*64kB (UE) 3*128kB (UME) 3*256kB (UME) 2*512kB (UM) 0*1024kB 3*2048kB (UME) 387057*4096kB (M) = 1585394152kB
[   14.018409][    T1] Node 3 Normal: 37*4kB (UM) 0*8kB 1*16kB (M) 1*32kB (U) 1*64kB (E) 3*128kB (UME) 3*256kB (UME) 2*512kB (ME) 0*1024kB 3*2048kB (UME) 387057*4096kB (M) = 1585394052kB
[   14.018423][    T1] Node 4 Normal: 43*4kB (UM) 1*8kB (E) 2*16kB (UM) 1*32kB (E) 2*64kB (UE) 1*128kB (M) 3*256kB (UME) 3*512kB (UME) 1*1024kB (E) 2*2048kB (ME) 387058*4096kB (M) = 1585397492kB
[   14.018438][    T1] Node 5 Normal: 27*4kB (UM) 0*8kB 1*16kB (M) 0*32kB 1*64kB (E) 2*128kB (ME) 2*256kB (UM) 3*512kB (UME) 2*1024kB (UE) 2*2048kB (ME) 387046*4096kB (M) = 1585349052kB
[   14.018451][    T1] Node 6 Normal: 46*4kB (UM) 0*8kB 2*16kB (UM) 0*32kB 2*64kB (UE) 2*128kB (UM) 2*256kB (UM) 1*512kB (M) 2*1024kB (UE) 3*2048kB (UME) 387057*4096kB (M) = 1585395288kB
[   14.018465][    T1] Node 7 Normal: 30*4kB (UM) 3*8kB (UME) 0*16kB 2*32kB (ME) 2*64kB (ME) 2*128kB (ME) 1*256kB (U) 2*512kB (UM) 2*1024kB (ME) 2*2048kB (UE) 386945*4096kB (M) = 1584934736kB
[   14.018480][    T1] 0 total pagecache pages
[   14.018483][    T1] 0 pages in swap cache
[   14.018484][    T1] Swap cache stats: add 0, delete 0, find 0/0
[   14.018486][    T1] Free swap  = 0kB
[   14.018487][    T1] Total swap = 0kB
[   14.018488][    T1] 3221164600 pages RAM
[   14.018489][    T1] 0 pages HighMem/MovableOnly
[   14.018490][    T1] 50531051 pages reserved
[   14.018491][    T1] 0 pages cma reserved
[   14.018492][    T1] 0 pages hwpoisoned

All but node0 are really completely irrelevant for this allocation
because they do not have ZONE_DMA yet it swamps the log and makes it
harder to visually inspect.

Address this by providing gfp_maks parameter to show_mem and filter the
output to only those zones/nodes which are relevant for the allocation.
That means nodes which have at least one managed zone which is usable
for the allocation (zone_idx(zone) <= gfp_zone(gfp_mask)).
The resulting output for the same failure would become:
[...]
[   14.017605][    T1] Mem-Info:
[   14.017956][    T1] active_anon:0 inactive_anon:0 isolated_anon:0
[   14.017956][    T1]  active_file:0 inactive_file:0 isolated_file:0
[   14.017956][    T1]  unevictable:0 dirty:0 writeback:0
[   14.017956][    T1]  slab_reclaimable:876 slab_unreclaimable:30300
[   14.017956][    T1]  mapped:0 shmem:0 pagetables:12 bounce:0
[   14.017956][    T1]  free:3170151735 free_pcp:6868 free_cma:0
[   14.017962][    T1] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:7200kB pagetables:4kB all_unreclaimable? no
[   14.018026][    T1] Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   14.018035][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018339][    T1] Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 0*64kB 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 160kB
[   14.018480][    T1] 0 total pagecache pages
[   14.018483][    T1] 0 pages in swap cache
[   14.018484][    T1] Swap cache stats: add 0, delete 0, find 0/0
[   14.018486][    T1] Free swap  = 0kB
[   14.018487][    T1] Total swap = 0kB
[   14.018488][    T1] 3221164600 pages RAM
[   14.018489][    T1] 0 pages HighMem/MovableOnly
[   14.018490][    T1] 50531051 pages reserved
[   14.018491][    T1] 0 pages cma reserved
[   14.018492][    T1] 0 pages hwpoisoned

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 drivers/tty/sysrq.c       |  2 +-
 drivers/tty/vt/keyboard.c |  2 +-
 include/linux/mm.h        |  4 ++--
 init/initramfs.c          |  2 +-
 kernel/panic.c            |  2 +-
 lib/show_mem.c            |  4 ++--
 mm/nommu.c                |  6 +++---
 mm/oom_kill.c             |  2 +-
 mm/page_alloc.c           | 22 ++++++++++++++++++++--
 9 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index d2b2720db6ca..c6b2b42d2367 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -342,7 +342,7 @@ static const struct sysrq_key_op sysrq_ftrace_dump_op = {
 
 static void sysrq_handle_showmem(int key)
 {
-	show_mem(0, NULL);
+	show_mem(0, NULL, GFP_HIGHUSER_MOVABLE);
 }
 static const struct sysrq_key_op sysrq_showmem_op = {
 	.handler	= sysrq_handle_showmem,
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index be8313cdbac3..9ceeea531cf6 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -606,7 +606,7 @@ static void fn_scroll_back(struct vc_data *vc)
 
 static void fn_show_mem(struct vc_data *vc)
 {
-	show_mem(0, NULL);
+	show_mem(0, NULL, GFP_HIGHUSER_MOVABLE);
 }
 
 static void fn_show_state(struct vc_data *vc)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7898e29bcfb5..e0d0ac52770c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1827,7 +1827,7 @@ extern void pagefault_out_of_memory(void);
  */
 #define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
 
-extern void show_free_areas(unsigned int flags, nodemask_t *nodemask);
+extern void show_free_areas(unsigned int flags, nodemask_t *nodemask, gfp_t gfp_mask);
 
 #ifdef CONFIG_MMU
 extern bool can_do_mlock(void);
@@ -2563,7 +2563,7 @@ extern void calculate_min_free_kbytes(void);
 extern int __meminit init_per_zone_wmark_min(void);
 extern void mem_init(void);
 extern void __init mmap_init(void);
-extern void show_mem(unsigned int flags, nodemask_t *nodemask);
+extern void show_mem(unsigned int flags, nodemask_t *nodemask, gfp_t gfp_mask);
 extern long si_mem_available(void);
 extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
diff --git a/init/initramfs.c b/init/initramfs.c
index 18229cfe8906..ec966cb78363 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -63,7 +63,7 @@ static void panic_show_mem(const char *fmt, ...)
 {
 	va_list args;
 
-	show_mem(0, NULL);
+	show_mem(0, NULL, GFP_HIGHUSER_MOVABLE);
 	va_start(args, fmt);
 	panic(fmt, args);
 	va_end(args);
diff --git a/kernel/panic.c b/kernel/panic.c
index a3308af28a21..ba5f7691d15c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -187,7 +187,7 @@ static void panic_print_sys_info(bool console_flush)
 		show_state();
 
 	if (panic_print & PANIC_PRINT_MEM_INFO)
-		show_mem(0, NULL);
+		show_mem(0, NULL, GFP_HIGHUSER_MOVABLE);
 
 	if (panic_print & PANIC_PRINT_TIMER_INFO)
 		sysrq_timer_list_show();
diff --git a/lib/show_mem.c b/lib/show_mem.c
index 1c26c14ffbb9..b97461a6c4bb 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -8,13 +8,13 @@
 #include <linux/mm.h>
 #include <linux/cma.h>
 
-void show_mem(unsigned int filter, nodemask_t *nodemask)
+void show_mem(unsigned int filter, nodemask_t *nodemask, gfp_t gfp_mask)
 {
 	pg_data_t *pgdat;
 	unsigned long total = 0, reserved = 0, highmem = 0;
 
 	printk("Mem-Info:\n");
-	show_free_areas(filter, nodemask);
+	show_free_areas(filter, nodemask, gfp_mask);
 
 	for_each_online_pgdat(pgdat) {
 		int zoneid;
diff --git a/mm/nommu.c b/mm/nommu.c
index 9d7afc2d959e..46cff4a51fa0 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1047,7 +1047,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 enomem:
 	pr_err("Allocation of length %lu from process %d (%s) failed\n",
 	       len, current->pid, current->comm);
-	show_free_areas(0, NULL);
+	show_free_areas(0, NULL, GFP_KERNEL);
 	return -ENOMEM;
 }
 
@@ -1270,13 +1270,13 @@ unsigned long do_mmap(struct file *file,
 	kmem_cache_free(vm_region_jar, region);
 	pr_warn("Allocation of vma for %lu byte allocation from process %d failed\n",
 			len, current->pid);
-	show_free_areas(0, NULL);
+	show_free_areas(0, NULL, GFP_KERNEL);
 	return -ENOMEM;
 
 error_getting_region:
 	pr_warn("Allocation of vm region for %lu byte allocation from process %d failed\n",
 			len, current->pid);
-	show_free_areas(0, NULL);
+	show_free_areas(0, NULL, GFP_KERNEL);
 	return -ENOMEM;
 }
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3c6cf9e3cd66..ffeaad3b348d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -461,7 +461,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 	if (is_memcg_oom(oc))
 		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
-		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
+		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask, oc->gfp_mask);
 		if (should_dump_unreclaim_slab())
 			dump_unreclaimable_slab();
 	}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b5b14b78c4fd..208e3f8b38f8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4248,7 +4248,7 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 	if (!in_task() || !(gfp_mask & __GFP_DIRECT_RECLAIM))
 		filter &= ~SHOW_MEM_FILTER_NODES;
 
-	show_mem(filter, nodemask);
+	show_mem(filter, nodemask, gfp_mask);
 }
 
 void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
@@ -5926,6 +5926,15 @@ static void show_migration_types(unsigned char type)
 	printk(KERN_CONT "(%s) ", tmp);
 }
 
+static bool node_has_managed_zones(pg_data_t *pgdat, int max_zone_idx)
+{
+	int zone_idx;
+	for (zone_idx = 0; zone_idx <= max_zone_idx; zone_idx++)
+		if (zone_managed_pages(pgdat->node_zones + zone_idx))
+			return true;
+	return false;
+}
+
 /*
  * Show free area list (used inside shift_scroll-lock stuff)
  * We also calculate the percentage fragmentation. We do this by counting the
@@ -5935,14 +5944,17 @@ static void show_migration_types(unsigned char type)
  * SHOW_MEM_FILTER_NODES: suppress nodes that are not allowed by current's
  *   cpuset.
  */
-void show_free_areas(unsigned int filter, nodemask_t *nodemask)
+void show_free_areas(unsigned int filter, nodemask_t *nodemask, gfp_t gfp_mask)
 {
 	unsigned long free_pcp = 0;
+	int max_zone_idx = gfp_zone(gfp_mask);
 	int cpu;
 	struct zone *zone;
 	pg_data_t *pgdat;
 
 	for_each_populated_zone(zone) {
+		if (zone_idx(zone) > max_zone_idx)
+			continue;
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
 
@@ -5980,6 +5992,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 	for_each_online_pgdat(pgdat) {
 		if (show_mem_node_skip(filter, pgdat->node_id, nodemask))
 			continue;
+		if (!node_has_managed_zones(pgdat, max_zone_idx))
+			continue;
 
 		printk("Node %d"
 			" active_anon:%lukB"
@@ -6036,6 +6050,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 	for_each_populated_zone(zone) {
 		int i;
 
+		if (zone_idx(zone) > max_zone_idx)
+			continue;
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
 
@@ -6097,6 +6113,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		unsigned long nr[MAX_ORDER], flags, total = 0;
 		unsigned char types[MAX_ORDER];
 
+		if (zone_idx(zone) > max_zone_idx)
+			continue;
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
 		show_node(zone);
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
