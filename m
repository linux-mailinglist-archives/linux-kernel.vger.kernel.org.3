Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1359B2AC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiHUIG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiHUIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:06:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BF1A385
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BB3AB80B87
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC20C433C1;
        Sun, 21 Aug 2022 08:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661069177;
        bh=dY8LHUVIja4HPuVDN76CpARIU1ikxp+3ytP8QwkWi4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unQjdLghyl5M04pIvOPQzV6qTI5d+9MEZh7hJZ9uqJRma8mvTs9CNZBWEhFVDajCs
         R5SSF3+8KXV2eOXi6wRQJuspn1W+2ToYPdKseXL4J25+upY5mKuRJPOACqkCSexu5F
         i7AqE52Xmss5hU4k49iG1E/AU9z4z3KQmVpPPdBF/czGY75zI2t9u93WmSOxDwEdWc
         T/V1M6tNcTvPlRL14/h4k7kteP9xvxfEL85J/8dCTRNe9VwQHaN3uW8nvnOUpOnbZw
         EIm/QdQg0K4tW9nNMtgRz/g/w85K9gRk20G6dUY8tOzoB0YEk7iLD0DCxiD4kBoo7/
         sQN1GXXOmX7Ew==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH v2 1/3] habanalabs: define trace events
Date:   Sun, 21 Aug 2022 11:06:06 +0300
Message-Id: <20220821080608.27486-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220821080608.27486-1-ogabbay@kernel.org>
References: <20220821080608.27486-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
Changes in v2:
 - don't specify 1 or 0 when assigning to bool
 - print string of true/false instead of 1/0
 
 MAINTAINERS                                   |  1 +
 .../misc/habanalabs/common/habanalabs_drv.c   |  3 +
 include/trace/events/habanalabs.h             | 90 +++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 include/trace/events/habanalabs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..5ce91ab67cb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8883,6 +8883,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
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
index 000000000000..09ca516e1624
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
+		__entry->flush_pte = flush_pte;
+	),
+
+	TP_printk("%s: vaddr: %#llx, paddr: %#llx, psize: %#x, flush: %s",
+		__get_str(dname),
+		__entry->virt_addr,
+		__entry->phys_addr,
+		__entry->page_size,
+		__entry->flush_pte ? "true" : "false")
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

