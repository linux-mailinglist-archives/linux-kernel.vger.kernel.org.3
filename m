Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44946B13F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhLGDMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:12:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233094AbhLGDME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638846515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=uYJk8sZNBvqI2TY4p7XM11abhtDaYRbwAT1TVDU3vqk=;
        b=MltMNBP8MaWcqsD8VMwgZf4ZaDjV/dblP3/LY34Ef4vpDPFCVbvSg+/Hd7DNH+ncIs+maW
        LqqXhecsjmbCvTZ51FRsJazok5Ufi6zffKP3oGZWLu4XNKRIrR6a39N4c94T59YQXL5Shu
        zsGz0c9n5RCfdCg4cFNrzNIKuyIkMSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-e7M3Njl3PLOnd8yyWBWbnQ-1; Mon, 06 Dec 2021 22:08:31 -0500
X-MC-Unique: e7M3Njl3PLOnd8yyWBWbnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E471006AA0;
        Tue,  7 Dec 2021 03:08:29 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0F7419C59;
        Tue,  7 Dec 2021 03:08:21 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH RESEND v2 4/5] dma/pool: create dma atomic pool only if dma zone has managed pages
Date:   Tue,  7 Dec 2021 11:07:49 +0800
Message-Id: <20211207030750.30824-5-bhe@redhat.com>
In-Reply-To: <20211207030750.30824-1-bhe@redhat.com>
References: <20211207030750.30824-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently three dma atomic pools are initialized as long as the relevant
kernel codes are built in. While in kdump kernel of x86_64, this is not
right when trying to create atomic_pool_dma, because there's no managed
pages in DMA zone. In the case, DMA zone only has low 1M memory presented
and locked down by memblock allocator. So no pages are added into buddy
of DMA zone. Please check commit f1d4d47c5851 ("x86/setup: Always reserve
the first 1M of RAM").

Then in kdump kernel of x86_64, it always prints below failure message:

 DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
 swapper/0: page allocation failure: order:5, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc3+ #1
 Call Trace:
  dump_stack+0x7f/0xa1
  warn_alloc.cold+0x72/0xd6
  ? _raw_spin_unlock_irq+0x24/0x40
  ? __alloc_pages_direct_compact+0x90/0x1b0
  __alloc_pages_slowpath.constprop.0+0xf29/0xf50
  ? __cond_resched+0x16/0x50
  ? prepare_alloc_pages.constprop.0+0x19d/0x1b0
  __alloc_pages+0x24d/0x2c0
  ? __dma_atomic_pool_init+0x93/0x93
  alloc_page_interleave+0x13/0xb0
  atomic_pool_expand+0x118/0x210
  ? __dma_atomic_pool_init+0x93/0x93
  __dma_atomic_pool_init+0x45/0x93
  dma_atomic_pool_init+0xdb/0x176
  do_one_initcall+0x67/0x320
  ? rcu_read_lock_sched_held+0x3f/0x80
  kernel_init_freeable+0x290/0x2dc
  ? rest_init+0x24f/0x24f
  kernel_init+0xa/0x111
  ret_from_fork+0x22/0x30
 Mem-Info:
 ......
 DMA: failed to allocate 128 KiB GFP_KERNEL|GFP_DMA pool for atomic allocation
 DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations

Here, let's check if DMA zone has managed pages, then create atomic_pool_dma
if yes. Otherwise just skip it.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org
---
 kernel/dma/pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 5a85804b5beb..00df3edd6c5d 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -206,7 +206,7 @@ static int __init dma_atomic_pool_init(void)
 						    GFP_KERNEL);
 	if (!atomic_pool_kernel)
 		ret = -ENOMEM;
-	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
+	if (has_managed_dma()) {
 		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
 						GFP_KERNEL | GFP_DMA);
 		if (!atomic_pool_dma)
@@ -229,7 +229,7 @@ static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
 	if (prev == NULL) {
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
 			return atomic_pool_dma32;
-		if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
+		if (atomic_pool_dma && (gfp & GFP_DMA))
 			return atomic_pool_dma;
 		return atomic_pool_kernel;
 	}
-- 
2.17.2

