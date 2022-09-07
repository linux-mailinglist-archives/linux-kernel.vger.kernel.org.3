Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D165B057A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIGNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIGNjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:39:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44A869E883
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:38:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EAF31042;
        Wed,  7 Sep 2022 06:38:44 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34BD13F7B4;
        Wed,  7 Sep 2022 06:38:37 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@infradead.org
Cc:     m.szyprowski@samsung.com, iommu@lists.linux.dev,
        dongli.zhang@oracle.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: Don't panic!
Date:   Wed,  7 Sep 2022 14:38:33 +0100
Message-Id: <fe2bb33caac173c2b17c819503acef739f763ad1.1662557586.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panics in swiotlb are relics of a bygone era, some of them
inadvertently inherited from a memblock refactor, and all of them
unnecessary since they are in places that may also fail gracefully
anyway.

Convert the panics in swiotlb_init_remap() into non-fatal warnings
more consistent with the other bail-out paths there and in
swiotlb_init_late() (but don't bother trying to roll anything back,
since if anything does actually fail that early, the aim is merely to
keep going as far as possible to get more diagnostic information out
of the inevitably-dying kernel). It's not for SWIOTLB to decide that the
system is terminally compromised just because there *might* turn out to
be one or more 32-bit devices that might want to make streaming DMA
mappings, especially since we already handle the no-buffer case later
if it turns out someone did want it.

Similarly though, downgrade that panic in swiotlb_tbl_map_single(),
since even if we do get to that point it's an overly extreme reaction.
It makes little difference to the DMA API caller whether a mapping fails
because the buffer is full or because there is no buffer, and once again
it's not for SWIOTLB to presume that any particular DMA mapping is so
fundamental to the operation of the system that it must be terminal if
it could never succeed. Even if the caller handles failure by futilely
retrying forever, a single stuck thread is considerably less impactful
to the user than a needless panic.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Based on dma/for-next with the revert already applied

 kernel/dma/swiotlb.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0ef6b12f961d..11579a3be2b5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -346,22 +346,27 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		memblock_free(tlb, PAGE_ALIGN(bytes));
 
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
-		if (nslabs < IO_TLB_MIN_SLABS)
-			panic("%s: Failed to remap %zu bytes\n",
-			      __func__, bytes);
-		goto retry;
+		if (nslabs >= IO_TLB_MIN_SLABS)
+			goto retry;
+
+		pr_warn("%s: Failed to remap %zu bytes\n", __func__, bytes);
+		return;
 	}
 
 	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
 	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
-	if (!mem->slots)
-		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
-		      __func__, alloc_size, PAGE_SIZE);
+	if (!mem->slots) {
+		pr_warn("%s: Failed to allocate %zu bytes align=0x%lx\n",
+			__func__, alloc_size, PAGE_SIZE);
+		return;
+	}
 
 	mem->areas = memblock_alloc(array_size(sizeof(struct io_tlb_area),
 		default_nareas), SMP_CACHE_BYTES);
-	if (!mem->areas)
-		panic("%s: Failed to allocate mem->areas.\n", __func__);
+	if (!mem->areas) {
+		pr_warn("%s: Failed to allocate mem->areas.\n", __func__);
+		return;
+	}
 
 	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false,
 				default_nareas);
@@ -731,8 +736,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	int index;
 	phys_addr_t tlb_addr;
 
-	if (!mem || !mem->nslabs)
-		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
+	if (!mem || !mem->nslabs) {
+		dev_warn_ratelimited(dev,
+			"Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
 
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
-- 
2.36.1.dirty

