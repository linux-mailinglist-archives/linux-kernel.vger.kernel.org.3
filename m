Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61E498507
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbiAXQku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:40:50 -0500
Received: from foss.arm.com ([217.140.110.172]:40074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243800AbiAXQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:40:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65E95113E;
        Mon, 24 Jan 2022 08:40:25 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80B043F793;
        Mon, 24 Jan 2022 08:40:24 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, konrad@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tientzu@chromium.org, guozhengkui@vivo.com
Subject: [PATCH 2/3] swiotlb: Tidy up includes
Date:   Mon, 24 Jan 2022 16:40:18 +0000
Message-Id: <57acdf35aa8a66e40ba99d97713ed97b2e40a1f6.1643028164.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1643028164.git.robin.murphy@arm.com>
References: <cover.1643028164.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWIOTLB's includes have become a great big mess. Restore some order by
consolidating the random different blocks, sorting alphabetically, and
purging some clearly unnecessary entries - linux/io.h is now included
unconditionally, so need not be duplicated in the restricted DMA pool
case; similarly, linux/io.h subsumes asm/io.h; and by now it's a
mystery why asm/dma.h was ever here at all.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/swiotlb.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index bdce89e053bd..f56d6504903c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -21,38 +21,33 @@
 #define pr_fmt(fmt) "software IO TLB: " fmt
 
 #include <linux/cache.h>
+#include <linux/cc_platform.h>
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
-#include <linux/mm.h>
 #include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+#include <linux/iommu-helper.h>
+#include <linux/init.h>
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/pfn.h>
+#include <linux/scatterlist.h>
+#include <linux/set_memory.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/swiotlb.h>
-#include <linux/pfn.h>
 #include <linux/types.h>
-#include <linux/ctype.h>
-#include <linux/highmem.h>
-#include <linux/gfp.h>
-#include <linux/scatterlist.h>
-#include <linux/cc_platform.h>
-#include <linux/set_memory.h>
-#include <linux/debugfs.h>
 #ifdef CONFIG_DMA_RESTRICTED_POOL
-#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #endif
 
-#include <asm/io.h>
-#include <asm/dma.h>
-
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/memblock.h>
-#include <linux/iommu-helper.h>
-
 #define CREATE_TRACE_POINTS
 #include <trace/events/swiotlb.h>
 
-- 
2.28.0.dirty

