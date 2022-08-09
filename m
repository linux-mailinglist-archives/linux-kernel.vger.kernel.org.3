Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B1A58DB44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbiHIPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244403AbiHIPiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:38:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB7D2BEE
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:38:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7FCCB37939;
        Tue,  9 Aug 2022 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660059480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VObGXJnhnoDSIPgMZhC923HWrzseeRJvAyPp+XoAb6k=;
        b=clih0VG1UJhU+Iw5Ozaa3mAEYS7tDb/hMJCB+bljiy8mmj7EAmeta1/Wyr3rq4RzjIvkVr
        nGdotng3h4I+/TcN4BS6oPBmVfWUodejNgo/J++psD4St1a4IVJLu0e7sWJ07sJClMYHpR
        6M9T82OIP7cg228/qqYKLZg79cZs3ZQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F5AB13AA1;
        Tue,  9 Aug 2022 15:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k28QFVh/8mJZbQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 09 Aug 2022 15:38:00 +0000
Date:   Tue, 9 Aug 2022 17:37:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <YvJ/V2bor9Q3P6ov@dhcp22.suse.cz>
References: <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
 <YupFSpXOrcfXJNya@dhcp22.suse.cz>
 <YuqNToCACD8kKBG+@MiWiFi-R3L-srv>
 <YuqOrJKcgfamdXkk@dhcp22.suse.cz>
 <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
 <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
 <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
 <Yuu1EyC95XL98XNI@dhcp22.suse.cz>
 <Yu0OWLbzLxCkSGVJ@MiWiFi-R3L-srv>
 <Yu1VTAxd9/jP/iEk@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu1VTAxd9/jP/iEk@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here we go again.
---
From 1dc9d7504624b273de47a88a9907f43533bfe08e Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 25 Mar 2022 13:25:59 +0100
Subject: [PATCH] dma/pool: do not complain if DMA pool is not allocated

we have a system complainging about order-10 allocation for the DMA pool.

[   14.017417][    T1] swapper/0: page allocation failure: order:10, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0-7
[   14.017429][    T1] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.14.21-150400.22-default #1 SLE15-SP4 0b6a6578ade2de5c4a0b916095dff44f76ef1704
[   14.017434][    T1] Hardware name: XXXX
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
[...]
[   14.018026][    T1] Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   14.018035][    T1] lowmem_reserve[]: 0 0 0 0 0
[   14.018339][    T1] Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 0*64kB 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 160kB

The usable memory in the DMA zone is obviously too small for the pool
pre-allocation. The allocation failure raises concern by admins because
this is considered an error state.

In fact the preallocation itself doesn't expose any actual problem. It
is not even clear whether anybody is ever going to use this pool. If yes
then a warning will be triggered anyway.

Silence the warning to prevent confusion and bug reports.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 4d40dcce7604..1bf6de398986 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -205,7 +205,7 @@ static int __init dma_atomic_pool_init(void)
 		ret = -ENOMEM;
 	if (has_managed_dma()) {
 		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA);
+						GFP_KERNEL | GFP_DMA | __GFP_NOWARN);
 		if (!atomic_pool_dma)
 			ret = -ENOMEM;
 	}
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
