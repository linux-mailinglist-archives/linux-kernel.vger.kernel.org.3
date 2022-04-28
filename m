Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A005130DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiD1KIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiD1KHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:07:06 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F8434BC;
        Thu, 28 Apr 2022 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651139797; x=1682675797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QplCjvmIZQdhDrIUwsGK+u+vwQWD5oz5DRbIoplQm/c=;
  b=fqHhHjgLDq5Daw3IjltwDN/yd6tG1KZ1XHPVGXC9yQHzNcQm35C8DBN5
   mg5Y2+31sBOlB6/hgTNOMFCTudu7q94Hxc4F78IAOIzXJEFiAMmGUc+jL
   VtnITXsAcLZu2ZBoJ5mq2gl1GCr1rna49UJdsgjy77GebxSTxYPdGNOj1
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 Apr 2022 02:56:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 02:56:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 02:56:21 -0700
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 02:56:17 -0700
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCHv12 5/9] lib: Add register read/write tracing support
Date:   Thu, 28 Apr 2022 15:25:28 +0530
Message-ID: <9827bae40f6f319f294d06859c9e3c7442f067f2.1651139070.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1651139070.git.quic_saipraka@quicinc.com>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prasad Sodagudi <psodagud@codeaurora.org>

Generic MMIO read/write i.e., __raw_{read,write}{b,l,w,q} accessors
are typically used to read/write from/to memory mapped registers
and can cause hangs or some undefined behaviour in following few
cases,

* If the access to the register space is unclocked, for example: if
  there is an access to multimedia(MM) block registers without MM
  clocks.

* If the register space is protected and not set to be accessible from
  non-secure world, for example: only EL3 (EL: Exception level) access
  is allowed and any EL2/EL1 access is forbidden.

* If xPU(memory/register protection units) is controlling access to
  certain memory/register space for specific clients.

and more...

Such cases usually results in instant reboot/SErrors/NOC or interconnect
hangs and tracing these register accesses can be very helpful to debug
such issues during initial development stages and also in later stages.

So use ftrace trace events to log such MMIO register accesses which
provides rich feature set such as early enablement of trace events,
filtering capability, dumping ftrace logs on console and many more.

Sample output:

rwmmio_write: __qcom_geni_serial_console_write+0x160/0x1e0 width=32 val=0xa0d5d addr=0xfffffbfffdbff700
rwmmio_post_write: __qcom_geni_serial_console_write+0x160/0x1e0 width=32 val=0xa0d5d addr=0xfffffbfffdbff700
rwmmio_read: qcom_geni_serial_poll_bit+0x94/0x138 width=32 addr=0xfffffbfffdbff610
rwmmio_post_read: qcom_geni_serial_poll_bit+0x94/0x138 width=32 val=0x0 addr=0xfffffbfffdbff610

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Co-developed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 arch/Kconfig                  |  3 ++
 arch/arm64/Kconfig            |  1 +
 include/trace/events/rwmmio.h | 97 +++++++++++++++++++++++++++++++++++
 lib/Kconfig                   |  7 +++
 lib/Makefile                  |  2 +
 lib/trace_readwrite.c         | 47 +++++++++++++++++
 6 files changed, 157 insertions(+)
 create mode 100644 include/trace/events/rwmmio.h
 create mode 100644 lib/trace_readwrite.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 31c4fdc4a4ba..5e7aa17ed609 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1369,6 +1369,9 @@ config ARCH_HAS_ELFCORE_COMPAT
 config ARCH_HAS_PARANOID_L1D_FLUSH
 	bool
 
+config ARCH_HAVE_TRACE_MMIO_ACCESS
+	bool
+
 config DYNAMIC_SIGFRAME
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 20ea89d9ac2f..926e1a252b6f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -48,6 +48,7 @@ config ARM64
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_ELF_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_TRACE_MMIO_ACCESS
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
diff --git a/include/trace/events/rwmmio.h b/include/trace/events/rwmmio.h
new file mode 100644
index 000000000000..82edee9bf716
--- /dev/null
+++ b/include/trace/events/rwmmio.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rwmmio
+
+#if !defined(_TRACE_RWMMIO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RWMMIO_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(rwmmio_rw_template,
+
+	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
+
+	TP_ARGS(caller, val, width, addr),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, caller)
+		__field(unsigned long, addr)
+		__field(u64, val)
+		__field(u8, width)
+	),
+
+	TP_fast_assign(
+		__entry->caller = caller;
+		__entry->val = val;
+		__entry->addr = (unsigned long)(void *)addr;
+		__entry->width = width;
+	),
+
+	TP_printk("%pS width=%d val=%#llx addr=%#lx",
+		(void *)(unsigned long)__entry->caller, __entry->width,
+		__entry->val, __entry->addr)
+);
+
+DEFINE_EVENT(rwmmio_rw_template, rwmmio_write,
+	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
+	TP_ARGS(caller, val, width, addr)
+);
+
+DEFINE_EVENT(rwmmio_rw_template, rwmmio_post_write,
+	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
+	TP_ARGS(caller, val, width, addr)
+);
+
+TRACE_EVENT(rwmmio_read,
+
+	TP_PROTO(unsigned long caller, u8 width, const volatile void __iomem *addr),
+
+	TP_ARGS(caller, width, addr),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, caller)
+		__field(unsigned long, addr)
+		__field(u8, width)
+	),
+
+	TP_fast_assign(
+		__entry->caller = caller;
+		__entry->addr = (unsigned long)(void *)addr;
+		__entry->width = width;
+	),
+
+	TP_printk("%pS width=%d addr=%#lx",
+		 (void *)(unsigned long)__entry->caller, __entry->width, __entry->addr)
+);
+
+TRACE_EVENT(rwmmio_post_read,
+
+	TP_PROTO(unsigned long caller, u64 val, u8 width, const volatile void __iomem *addr),
+
+	TP_ARGS(caller, val, width, addr),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, caller)
+		__field(unsigned long, addr)
+		__field(u64, val)
+		__field(u8, width)
+	),
+
+	TP_fast_assign(
+		__entry->caller = caller;
+		__entry->val = val;
+		__entry->addr = (unsigned long)(void *)addr;
+		__entry->width = width;
+	),
+
+	TP_printk("%pS width=%d val=%#llx addr=%#lx",
+		 (void *)(unsigned long)__entry->caller, __entry->width,
+		 __entry->val, __entry->addr)
+);
+
+#endif /* _TRACE_RWMMIO_H */
+
+#include <trace/define_trace.h>
diff --git a/lib/Kconfig b/lib/Kconfig
index 087e06b4cdfd..5e2fd075724f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -118,6 +118,13 @@ config INDIRECT_IOMEM_FALLBACK
 	  mmio accesses when the IO memory address is not a registered
 	  emulated region.
 
+config TRACE_MMIO_ACCESS
+	bool "Register read/write tracing"
+	depends on TRACING && ARCH_HAVE_TRACE_MMIO_ACCESS
+	help
+	  Create tracepoints for MMIO read/write operations. These trace events
+	  can be used for logging all MMIO read/write operations.
+
 source "lib/crypto/Kconfig"
 
 config CRC_CCITT
diff --git a/lib/Makefile b/lib/Makefile
index 6b9ffc1bd1ee..3df7d24e65d2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -151,6 +151,8 @@ lib-y += logic_pio.o
 
 lib-$(CONFIG_INDIRECT_IOMEM) += logic_iomem.o
 
+obj-$(CONFIG_TRACE_MMIO_ACCESS) += trace_readwrite.o
+
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
 obj-$(CONFIG_BTREE) += btree.o
diff --git a/lib/trace_readwrite.c b/lib/trace_readwrite.c
new file mode 100644
index 000000000000..88637038b30c
--- /dev/null
+++ b/lib/trace_readwrite.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Register read and write tracepoints
+ *
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/ftrace.h>
+#include <linux/module.h>
+#include <asm-generic/io.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/rwmmio.h>
+
+#ifdef CONFIG_TRACE_MMIO_ACCESS
+void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+		    unsigned long caller_addr)
+{
+	trace_rwmmio_write(caller_addr, val, width, addr);
+}
+EXPORT_SYMBOL_GPL(log_write_mmio);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_write);
+
+void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+			 unsigned long caller_addr)
+{
+	trace_rwmmio_post_write(caller_addr, val, width, addr);
+}
+EXPORT_SYMBOL_GPL(log_post_write_mmio);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_post_write);
+
+void log_read_mmio(u8 width, const volatile void __iomem *addr,
+		   unsigned long caller_addr)
+{
+	trace_rwmmio_read(caller_addr, width, addr);
+}
+EXPORT_SYMBOL_GPL(log_read_mmio);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_read);
+
+void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
+			unsigned long caller_addr)
+{
+	trace_rwmmio_post_read(caller_addr, val, width, addr);
+}
+EXPORT_SYMBOL_GPL(log_post_read_mmio);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_post_read);
+#endif /* CONFIG_TRACE_MMIO_ACCESS */
-- 
2.33.1

