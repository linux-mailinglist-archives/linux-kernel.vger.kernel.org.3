Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36D958FB80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiHKLkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiHKLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D1926106
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41747612CB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57569C433D7;
        Thu, 11 Aug 2022 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660218006;
        bh=Z4qaRS2jDH1FfZ/YS8lbGKxY62ovUELq+Igus94QIo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNK1wq1zBKZV7iIrv9+dfXQG9IdsrrStB38yqyMV5buuOPWHohrq8jQGa88pVRsqi
         rbZNHtk0jV0iASP3FTrDhmyYlHZCrisxkw4GbYkq5SfXaj5cUjVxVBPAjMDW4wjiKk
         r2T2yGj2n3MQbabYqNA/lS1upxV6SabcebC0I/az22+M5CXpcS7JwqKQpBpBsV/+4C
         uCfWlNLmGT28hxAdT8nM9YFXlWiUnaZs+WgGPiLwRSsynIWjIOBHgjSsD1z88WxamY
         BpUUJ4TpKRXnSMT9MxZWkqb0FIPW1ok0Z6AA77o4DPhmnK8TI5CZNbKVDoPEu1eNbe
         sdDaqATYq0LTw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/3] habanalabs: define trace events
Date:   Thu, 11 Aug 2022 14:39:51 +0300
Message-Id: <20220811113953.1963412-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811113953.1963412-1-ogabbay@kernel.org>
References: <20220811113953.1963412-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

This patch adds trace events for habanalabs driver to gain all the
benefits such an infrastructure can supply.

The following events were added:
- MMU map/unmap: to be able to track driver's memory allocations
- DMA alloc/free: to track our DMA allocation

the above trace points in conjunction will help us map the device memory
usage as well as to be able to track memory violations.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Acked-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 MAINTAINERS                                   |  1 +
 .../misc/habanalabs/common/habanalabs_drv.c   |  3 +
 include/trace/events/habanalabs.h             | 90 +++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 include/trace/events/habanalabs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b7221f4143cb..7b2fc3463cae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8873,6 +8873,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
 F:	Documentation/ABI/testing/debugfs-driver-habanalabs
 F:	Documentation/ABI/testing/sysfs-driver-habanalabs
 F:	drivers/misc/habanalabs/
+F:	include/trace/events/habanalabs.h
 F:	include/uapi/misc/habanalabs.h
 
 HACKRF MEDIA DRIVER
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 8026793d9083..e12148428731 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -14,6 +14,9 @@
 #include <linux/aer.h>
 #include <linux/module.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/habanalabs.h>
+
 #define HL_DRIVER_AUTHOR	"HabanaLabs Kernel Driver Team"
 
 #define HL_DRIVER_DESC		"Driver for HabanaLabs's AI Accelerators"
diff --git a/include/trace/events/habanalabs.h b/include/trace/events/habanalabs.h
new file mode 100644
index 000000000000..4fb592247ae8
--- /dev/null
+++ b/include/trace/events/habanalabs.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2021 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM habanalabs
+
+#if !defined(_TRACE_HABANALABS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HABANALABS_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(habanalabs_mmu_template,
+	TP_PROTO(struct device *dev, u64 virt_addr, u64 phys_addr, u32 page_size, bool flush_pte),
+
+	TP_ARGS(dev, virt_addr, phys_addr, page_size, flush_pte),
+
+	TP_STRUCT__entry(
+		__string(dname, dev_name(dev))
+		__field(u64, virt_addr)
+		__field(u64, phys_addr)
+		__field(u32, page_size)
+		__field(u8, flush_pte)
+	),
+
+	TP_fast_assign(
+		__assign_str(dname, dev_name(dev));
+		__entry->virt_addr = virt_addr;
+		__entry->phys_addr = phys_addr;
+		__entry->page_size = page_size;
+		__entry->flush_pte = flush_pte ? 1 : 0;
+	),
+
+	TP_printk("%s: vaddr: %#llx, paddr: %#llx, psize: %#x, flush: %u",
+		__get_str(dname),
+		__entry->virt_addr,
+		__entry->phys_addr,
+		__entry->page_size,
+		__entry->flush_pte)
+);
+
+DEFINE_EVENT(habanalabs_mmu_template, habanalabs_mmu_map,
+	TP_PROTO(struct device *dev, u64 virt_addr, u64 phys_addr, u32 page_size, bool flush_pte),
+	TP_ARGS(dev, virt_addr, phys_addr, page_size, flush_pte));
+
+DEFINE_EVENT(habanalabs_mmu_template, habanalabs_mmu_unmap,
+	TP_PROTO(struct device *dev, u64 virt_addr, u64 phys_addr, u32 page_size, bool flush_pte),
+	TP_ARGS(dev, virt_addr, phys_addr, page_size, flush_pte));
+
+DECLARE_EVENT_CLASS(habanalabs_dma_alloc_template,
+	TP_PROTO(struct device *dev, u64 cpu_addr, u64 dma_addr, size_t size),
+
+	TP_ARGS(dev, cpu_addr, dma_addr, size),
+
+	TP_STRUCT__entry(
+		__string(dname, dev_name(dev))
+		__field(u64, cpu_addr)
+		__field(u64, dma_addr)
+		__field(u32, size)
+	),
+
+	TP_fast_assign(
+		__assign_str(dname, dev_name(dev));
+		__entry->cpu_addr = cpu_addr;
+		__entry->dma_addr = dma_addr;
+		__entry->size = size;
+	),
+
+	TP_printk("%s: cpu_addr: %#llx, dma_addr: %#llx, size: %#x",
+		__get_str(dname),
+		__entry->cpu_addr,
+		__entry->dma_addr,
+		__entry->size)
+);
+
+DEFINE_EVENT(habanalabs_dma_alloc_template, habanalabs_dma_alloc,
+	TP_PROTO(struct device *dev, u64 cpu_addr, u64 dma_addr, size_t size),
+	TP_ARGS(dev, cpu_addr, dma_addr, size));
+
+DEFINE_EVENT(habanalabs_dma_alloc_template, habanalabs_dma_free,
+	TP_PROTO(struct device *dev, u64 cpu_addr, u64 dma_addr, size_t size),
+	TP_ARGS(dev, cpu_addr, dma_addr, size));
+
+#endif /* if !defined(_TRACE_HABANALABS_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.25.1

