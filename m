Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDF546B347
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhLGG72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:59:28 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59773 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230222AbhLGG7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638860153; x=1670396153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1nUnV5mzr0UUgWO49+HCRYwC09u7OGYGsX39lACDWWc=;
  b=Psx1rWWGOXDiF9lWU+OFM5+d20xLTbGtMG0M7i8cgWLYAiMTUkbqh1mB
   jHBjWCX1bvTNAqN7L5c6hOxdIF5DBsgIbnLUexN5jnbm2MGRvZqPkgqpY
   PXXOl4ri3FqvEPX5LvEU5vPHmA0qf2QY2af+nqNIVdiFIgC/b1CAyGZ43
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 22:55:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 22:55:50 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 22:55:42 -0800
Received: from blr-ubuntu-311.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 22:55:38 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCHv6 4/5] tracing: Add register read/write tracing support
Date:   Tue, 7 Dec 2021 12:24:48 +0530
Message-ID: <76983c26d889df7252a17017a48754163fb6b0d5.1638858747.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638858746.git.quic_saipraka@quicinc.com>
References: <cover.1638858746.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
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
 arch/Kconfig                   |   3 +
 arch/arm64/Kconfig             |   1 +
 include/trace/events/rwmmio.h  | 112 +++++++++++++++++++++++++++++++++
 kernel/trace/Kconfig           |   7 +++
 kernel/trace/Makefile          |   1 +
 kernel/trace/trace_readwrite.c |  47 ++++++++++++++
 6 files changed, 171 insertions(+)
 create mode 100644 include/trace/events/rwmmio.h
 create mode 100644 kernel/trace/trace_readwrite.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 26b8ed11639d..8980e1c25212 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1299,6 +1299,9 @@ config ARCH_HAS_ELFCORE_COMPAT
 config ARCH_HAS_PARANOID_L1D_FLUSH
 	bool
 
+config ARCH_HAVE_TRACE_MMIO_ACCESS
+	bool
+
 config DYNAMIC_SIGFRAME
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..25d1b0fca488 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -46,6 +46,7 @@ config ARM64
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_ELF_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_TRACE_MMIO_ACCESS
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
diff --git a/include/trace/events/rwmmio.h b/include/trace/events/rwmmio.h
new file mode 100644
index 000000000000..f66397007258
--- /dev/null
+++ b/include/trace/events/rwmmio.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rwmmio
+
+#if !defined(_TRACE_RWMMIO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RWMMIO_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(rwmmio_write,
+
+	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
+
+	TP_ARGS(caller, val, width, addr),
+
+	TP_STRUCT__entry(
+		__field(u64, caller)
+		__field(u64, val)
+		__field(u64, addr)
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
+	TP_printk("%pS width=%d val=%#llx addr=%#llx",
+		(void *)(unsigned long)__entry->caller, __entry->width,
+		__entry->val, __entry->addr)
+);
+
+TRACE_EVENT(rwmmio_post_write,
+
+	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
+
+	TP_ARGS(caller, val, width, addr),
+
+	TP_STRUCT__entry(
+		__field(u64, caller)
+		__field(u64, val)
+		__field(u64, addr)
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
+	TP_printk("%pS width=%d val=%#llx addr=%#llx",
+		(void *)(unsigned long)__entry->caller, __entry->width,
+		__entry->val, __entry->addr)
+);
+
+TRACE_EVENT(rwmmio_read,
+
+	TP_PROTO(unsigned long caller, u8 width, const volatile void __iomem *addr),
+
+	TP_ARGS(caller, width, addr),
+
+	TP_STRUCT__entry(
+		__field(u64, caller)
+		__field(u64, addr)
+		__field(u8, width)
+	),
+
+	TP_fast_assign(
+		__entry->caller = caller;
+		__entry->addr = (unsigned long)(void *)addr;
+		__entry->width = width;
+	),
+
+	TP_printk("%pS width=%d addr=%#llx",
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
+		__field(u64, caller)
+		__field(u64, val)
+		__field(u64, addr)
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
+	TP_printk("%pS width=%d val=%#llx addr=%#llx",
+		 (void *)(unsigned long)__entry->caller, __entry->width,
+		 __entry->val, __entry->addr)
+);
+
+#endif /* _TRACE_RWMMIO_H */
+
+#include <trace/define_trace.h>
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 420ff4bc67fd..2b09a863e07a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -95,6 +95,13 @@ config RING_BUFFER_ALLOW_SWAP
 	 Allow the use of ring_buffer_swap_cpu.
 	 Adds a very slight overhead to tracing when enabled.
 
+config TRACE_MMIO_ACCESS
+	bool "Register read/write tracing"
+	depends on TRACING && ARCH_HAVE_TRACE_MMIO_ACCESS
+	help
+	  Create tracepoints for MMIO read/write operations. These trace events
+	  can be used for logging all MMIO read/write operations.
+
 config PREEMPTIRQ_TRACEPOINTS
 	bool
 	depends on TRACE_PREEMPT_TOGGLE || TRACE_IRQFLAGS
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index bedc5caceec7..a3d16e1a5abd 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -99,5 +99,6 @@ obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
+obj-$(CONFIG_TRACE_MMIO_ACCESS) += trace_readwrite.o
 
 libftrace-y := ftrace.o
diff --git a/kernel/trace/trace_readwrite.c b/kernel/trace/trace_readwrite.c
new file mode 100644
index 000000000000..10ebe3c9687a
--- /dev/null
+++ b/kernel/trace/trace_readwrite.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Register read and write tracepoints
+ *
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
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

