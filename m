Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B4859BBD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiHVIlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiHVIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:41:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771592CE38
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:41:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 286CE1FA97;
        Mon, 22 Aug 2022 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661157662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EzR9tGV0YlhEOmfruAvW0cXww15mvI4CUK6MB+b2qr4=;
        b=c9tnZuvOiAIP+UjwwtTDj3xbTxNkduqeaspvVvPR/kbF1R0gqgZtAeavLjMbud4oj3DN02
        TFlOeGlUPsgibjQbyttZNh2L/iRRwoKemWKQrkqgUtjAgH5eyaA1OZSQqLv59/HhZS9X8d
        hHTEARc7L0roosGDLlf9FxP76SukgNk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 066B31332D;
        Mon, 22 Aug 2022 08:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m2M4Ox1BA2MQXQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 22 Aug 2022 08:41:01 +0000
Date:   Mon, 22 Aug 2022 10:41:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <YwNBHbYXpatJHD0K@dhcp22.suse.cz>
References: <20220817060647.1032426-1-hch@lst.de>
 <20220817060647.1032426-4-hch@lst.de>
 <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz>
 <20220821104416.GC30530@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821104416.GC30530@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 21-08-22 12:44:16, Christoph Hellwig wrote:
> On Wed, Aug 17, 2022 at 02:53:47PM +0200, Michal Hocko wrote:
> > Yes this is much more reasonable estimation. Especially for the DMA
> > zone. I still believe some downscaling would make sense but as said
> > earlier nothing to really insist on. Also you likely want to have
> > pr_warn for non-poppulated DMA zone as pointed in other thread[1].
> 
> So I think the warning would be useful, but how do we detect that the
> zone should exist and is empty vs the case where it doesn't even
> exist based on a runtime decision?

ZONE_DMA existance is not runtime controlable (at least on x86). We only
have 2 possible cases. There is no memory released into the page
allocator (zone_managed_pages == 0) because the physical memory range
has been reserved during early boot or it has been consumed by somebody.

From the DMA pool allocator they are effectively the same case because
the pool fails to allocate. From the reporting POV those cases could be
arguably different because the later case can report the meminfo while
the !managed case doesn't have much to report about except for "You do
not have anything there". TBH I am not really sure whether the full
meminfo report is all that useful because there is not much you can
learn from that anyway. The full report looks like this

: [   14.017417][    T1] swapper/0: page allocation failure: order:10, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0-7
: [   14.017429][    T1] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.14.21-150400.22-default #1 SLE15-SP4 0b6a6578ade2de5c4a0b916095dff44f76ef1704
: [   14.017434][    T1] Hardware name: FUJITSU PRIMEQUEST 2800E3/D3752, BIOS PRIMEQUEST 2000 Series BIOS Version 01.52 11/23/2021
: [   14.017437][    T1] Call Trace:
: [   14.017444][    T1]  <TASK>
: [   14.017449][    T1]  dump_stack_lvl+0x45/0x57
: [   14.017469][    T1]  warn_alloc+0xfe/0x160
: [   14.017490][    T1]  __alloc_pages_slowpath.constprop.112+0xc27/0xc60
: [   14.017497][    T1]  ? rdinit_setup+0x2b/0x2b
: [   14.017509][    T1]  ? rdinit_setup+0x2b/0x2b
: [   14.017512][    T1]  __alloc_pages+0x2d5/0x320
: [   14.017517][    T1]  alloc_page_interleave+0xf/0x70
: [   14.017531][    T1]  atomic_pool_expand+0x4a/0x200
: [   14.017541][    T1]  ? rdinit_setup+0x2b/0x2b
: [   14.017544][    T1]  __dma_atomic_pool_init+0x44/0x90
: [   14.017556][    T1]  dma_atomic_pool_init+0xad/0x13f
: [   14.017560][    T1]  ? __dma_atomic_pool_init+0x90/0x90
: [   14.017562][    T1]  do_one_initcall+0x41/0x200
: [   14.017581][    T1]  kernel_init_freeable+0x236/0x298
: [   14.017589][    T1]  ? rest_init+0xd0/0xd0
: [   14.017596][    T1]  kernel_init+0x16/0x120
: [   14.017599][    T1]  ret_from_fork+0x22/0x30
: [   14.017604][    T1]  </TASK>
: [   14.017605][    T1] Mem-Info:
: [   14.017956][    T1] active_anon:0 inactive_anon:0 isolated_anon:0
: [   14.017956][    T1]  active_file:0 inactive_file:0 isolated_file:0
: [   14.017956][    T1]  unevictable:0 dirty:0 writeback:0
: [   14.017956][    T1]  slab_reclaimable:876 slab_unreclaimable:30300
: [   14.017956][    T1]  mapped:0 shmem:0 pagetables:12 bounce:0
: [   14.017956][    T1]  free:3170151735 free_pcp:6868 free_cma:0
: [   14.017962][    T1] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:7200kB pagetables:4kB all_unreclaimable? no
: [   14.017969][    T1] Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6728kB pagetables:16kB all_unreclaimable? no
: [   14.017973][    T1] Node 2 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6800kB pagetables:0kB all_unreclaimable? no
: [   14.017977][    T1] Node 3 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6960kB pagetables:0kB all_unreclaimable? no
: [   14.017982][    T1] Node 4 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6656kB pagetables:0kB all_unreclaimable? no
: [   14.017985][    T1] Node 5 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6784kB pagetables:24kB all_unreclaimable? no
: [   14.017989][    T1] Node 6 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:6928kB pagetables:4kB all_unreclaimable? no
: [   14.017994][    T1] Node 7 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:7072kB pagetables:0kB all_unreclaimable? no
: [   14.018026][    T1] Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
: [   14.018035][    T1] lowmem_reserve[]: 0 0 0 0 0
: [   14.018063][    T1] Node 0 DMA32 free:0kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1313380kB managed:1154392kB mlocked:0kB bounce:0kB free_pcp:216kB local_pcp:0kB free_cma:0kB
: [   14.018070][    T1] lowmem_reserve[]: 0 0 0 0 0
: [   14.018098][    T1] Node 0 Normal free:1583344560kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1609039872kB managed:1583858824kB mlocked:0kB bounce:0kB free_pcp:12692kB local_pcp:256kB free_cma:0kB
: [   14.018105][    T1] lowmem_reserve[]: 0 0 0 0 0
: [   14.018132][    T1] Node 1 Normal free:1585397152kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585429652kB mlocked:0kB bounce:0kB free_pcp:1772kB local_pcp:76kB free_cma:0kB
: [   14.018138][    T1] lowmem_reserve[]: 0 0 0 0 0
: [   14.018161][    T1] Node 2 Normal free:1585394152kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585429652kB mlocked:0kB bounce:0kB free_pcp:2292kB local_pcp:48kB free_cma:0kB
: [   14.018166][    T1] lowmem_reserve[]: 0 0 0 0 0
: [   14.018191][    T1] Node 3 Normal free:1585394052kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585429652kB mlocked:0kB bounce:0kB free_pcp:2336kB local_pcp:0kB free_cma:0kB
: [   14.018197][    T1] lowmem_reserve[]: 0 0 0 0 0
: [   14.018232][    T1] Node 4 Normal free:1585397584kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585429652kB mlocked:0kB bounce:0kB free_pcp:1764kB local_pcp:68kB free_cma:0kB
: [   14.018238][    T1] lowmem_reserve[]: 0 0 0 0 0
: [   14.018264][    T1] Node 5 Normal free:1585349060kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585386604kB mlocked:0kB bounce:0kB free_pcp:1924kB local_pcp:32kB free_cma:0kB
: [   14.018270][    T1] lowmem_reserve[]: 0 0 0 0 0
: [   14.018300][    T1] Node 6 Normal free:1585395340kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1585429652kB mlocked:0kB bounce:0kB free_pcp:2160kB local_pcp:72kB free_cma:0kB
: [   14.018305][    T1] lowmem_reserve[]: 0 0 0 0 0
: [   14.018330][    T1] Node 7 Normal free:1584934880kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1610612736kB managed:1584970756kB mlocked:0kB bounce:0kB free_pcp:2316kB local_pcp:100kB free_cma:0kB
: [   14.018335][    T1] lowmem_reserve[]: 0 0 0 0 0
: [   14.018339][    T1] Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 0*64kB 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 160kB
: [   14.018352][    T1] Node 0 DMA32: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
: [   14.018361][    T1] Node 0 Normal: 1*4kB (U) 1*8kB (M) 0*16kB 1*32kB (E) 1*64kB (U) 2*128kB (ME) 2*256kB (ME) 2*512kB (UM) 1*1024kB (E) 0*2048kB 386558*4096kB (M) = 1583344492kB
: [   14.018377][    T1] Node 1 Normal: 17*4kB (UM) 1*8kB (U) 2*16kB (UM) 2*32kB (UE) 1*64kB (E) 2*128kB (UM) 3*256kB (UME) 2*512kB (ME) 1*1024kB (E) 2*2048kB (ME) 387058*4096kB (M) = 1585396972kB
: [   14.018393][    T1] Node 2 Normal: 44*4kB (UM) 1*8kB (U) 1*16kB (M) 1*32kB (U) 2*64kB (UE) 3*128kB (UME) 3*256kB (UME) 2*512kB (UM) 0*1024kB 3*2048kB (UME) 387057*4096kB (M) = 1585394152kB
: [   14.018409][    T1] Node 3 Normal: 37*4kB (UM) 0*8kB 1*16kB (M) 1*32kB (U) 1*64kB (E) 3*128kB (UME) 3*256kB (UME) 2*512kB (ME) 0*1024kB 3*2048kB (UME) 387057*4096kB (M) = 1585394052kB
: [   14.018423][    T1] Node 4 Normal: 43*4kB (UM) 1*8kB (E) 2*16kB (UM) 1*32kB (E) 2*64kB (UE) 1*128kB (M) 3*256kB (UME) 3*512kB (UME) 1*1024kB (E) 2*2048kB (ME) 387058*4096kB (M) = 1585397492kB
: [   14.018438][    T1] Node 5 Normal: 27*4kB (UM) 0*8kB 1*16kB (M) 0*32kB 1*64kB (E) 2*128kB (ME) 2*256kB (UM) 3*512kB (UME) 2*1024kB (UE) 2*2048kB (ME) 387046*4096kB (M) = 1585349052kB
: [   14.018451][    T1] Node 6 Normal: 46*4kB (UM) 0*8kB 2*16kB (UM) 0*32kB 2*64kB (UE) 2*128kB (UM) 2*256kB (UM) 1*512kB (M) 2*1024kB (UE) 3*2048kB (UME) 387057*4096kB (M) = 1585395288kB
: [   14.018465][    T1] Node 7 Normal: 30*4kB (UM) 3*8kB (UME) 0*16kB 2*32kB (ME) 2*64kB (ME) 2*128kB (ME) 1*256kB (U) 2*512kB (UM) 2*1024kB (ME) 2*2048kB (UE) 386945*4096kB (M) = 1584934736kB
: [   14.018480][    T1] 0 total pagecache pages
: [   14.018483][    T1] 0 pages in swap cache
: [   14.018484][    T1] Swap cache stats: add 0, delete 0, find 0/0
: [   14.018486][    T1] Free swap  = 0kB
: [   14.018487][    T1] Total swap = 0kB
: [   14.018488][    T1] 3221164600 pages RAM
: [   14.018489][    T1] 0 pages HighMem/MovableOnly
: [   14.018490][    T1] 50531051 pages reserved
: [   14.018491][    T1] 0 pages cma reserved
: [   14.018492][    T1] 0 pages hwpoisoned

From that the only useful information for me as the MM developer would
be 
: swapper/0: page allocation failure: order:10, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0-7

because this tells me that this is 4MB request
[...]
: Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB

because this tells me that the zone is populated (managed is 16MB) but mostly consumed (free == 160kB)

and 
: Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 0*64kB 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 160kB

because this would tell me whether the zone was fragmented to satisfy the
allocation if free would be large enough to cover the request (not in
this case)

We could improve the reporting here and drop all the nodes which do not
have DMA zone populated which would shrink the overall size. On the
other hand there are parts which are not all that interesting in this
case but useful they are useful in most other situations - i.e. the
stack trace or cumulative stats.

IMHO it would be more useful to have something like this instead. This
would reduce the output to the 
Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 0*64kB 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 160kB
for all nodes, which should tell the whole story because it would tell
both the fragmentation as well as the lack of memory case.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7898e29bcfb5..5e16a899c620 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1828,6 +1828,7 @@ extern void pagefault_out_of_memory(void);
 #define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
 
 extern void show_free_areas(unsigned int flags, nodemask_t *nodemask);
+extern void show_zone_free_area(struct zone *zone);
 
 #ifdef CONFIG_MMU
 extern bool can_do_mlock(void);
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 2a6c71311a17..a4b125a7ae90 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -197,14 +197,27 @@ static struct gen_pool * __init __maybe_unused zone_pool_init(int zone_idx,
 {
 	struct pglist_data *pgdat;
 	unsigned long nr_pages = 0;
+	struct gen_pool *pool;
+	size_t pool_size = 0;
 
 	for_each_online_pgdat(pgdat)
 		nr_pages += zone_managed_pages(&pgdat->node_zones[zone_idx]);
 
-	if (!nr_pages)
-		return NULL;
+	/*
+	 * memory failure report can be pretty noisy so limit the report to
+	 * necessary minumum
+	 * */
+	if (nr_pages) {
+		pool_size = calculate_pool_size(nr_pages);
+		pool = __dma_atomic_pool_init(pool_size, gfp | __GFP_NOWARN);
+	}
 
-	return __dma_atomic_pool_init(calculate_pool_size(nr_pages), gfp);
+	if (!pool) {
+		pr_info("Failed to pre-allocate pool to %lu pages\n", pool_size);
+		for_each_online_pgdat(pgdat)
+			show_zone_free_area(&pgdat->node_zones[zone_idx]);
+	}
+	return pool
 }
 
 static int __init dma_atomic_pool_init(void)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b5b14b78c4fd..49ff8f156b7a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5926,6 +5926,38 @@ static void show_migration_types(unsigned char type)
 	printk(KERN_CONT "(%s) ", tmp);
 }
 
+void show_zone_free_area(struct zone *zone)
+{
+	unsigned int order;
+	unsigned long nr[MAX_ORDER], flags, total = 0;
+	unsigned char types[MAX_ORDER];
+
+	show_node(zone);
+	printk(KERN_CONT "%s: ", zone->name);
+
+	spin_lock_irqsave(&zone->lock, flags);
+	for (order = 0; order < MAX_ORDER; order++) {
+		struct free_area *area = &zone->free_area[order];
+		int type;
+
+		nr[order] = area->nr_free;
+		total += nr[order] << order;
+
+		types[order] = 0;
+		for (type = 0; type < MIGRATE_TYPES; type++) {
+			if (!free_area_empty(area, type))
+				types[order] |= 1 << type;
+		}
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+	for (order = 0; order < MAX_ORDER; order++) {
+		printk(KERN_CONT "%lu*%lukB ",
+		       nr[order], K(1UL) << order);
+		if (nr[order])
+			show_migration_types(types[order]);
+	}
+	printk(KERN_CONT "= %lukB\n", K(total));
+}
 /*
  * Show free area list (used inside shift_scroll-lock stuff)
  * We also calculate the percentage fragmentation. We do this by counting the
@@ -6093,37 +6125,9 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 	}
 
 	for_each_populated_zone(zone) {
-		unsigned int order;
-		unsigned long nr[MAX_ORDER], flags, total = 0;
-		unsigned char types[MAX_ORDER];
-
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
-		show_node(zone);
-		printk(KERN_CONT "%s: ", zone->name);
-
-		spin_lock_irqsave(&zone->lock, flags);
-		for (order = 0; order < MAX_ORDER; order++) {
-			struct free_area *area = &zone->free_area[order];
-			int type;
-
-			nr[order] = area->nr_free;
-			total += nr[order] << order;
-
-			types[order] = 0;
-			for (type = 0; type < MIGRATE_TYPES; type++) {
-				if (!free_area_empty(area, type))
-					types[order] |= 1 << type;
-			}
-		}
-		spin_unlock_irqrestore(&zone->lock, flags);
-		for (order = 0; order < MAX_ORDER; order++) {
-			printk(KERN_CONT "%lu*%lukB ",
-			       nr[order], K(1UL) << order);
-			if (nr[order])
-				show_migration_types(types[order]);
-		}
-		printk(KERN_CONT "= %lukB\n", K(total));
+		show_zone_free_area(zone);
 	}
 
 	hugetlb_show_meminfo();
-- 
Michal Hocko
SUSE Labs
