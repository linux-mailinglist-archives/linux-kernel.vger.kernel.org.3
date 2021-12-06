Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44F469179
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhLFIdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:33:09 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:51386 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbhLFIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638779376; x=1670315376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kqACiaVmjaL6Age8CxwxqWrq1fHtddje7g34eg/Z5Rc=;
  b=zHcye8PbgqPwqzFxGbznPW/N1QAqGxtD8tmjXWm/lZeBFjtndQYkHDZ1
   ac0FVBLyyUzvCNXt26rHxyihzt3GY1kq9n8dcCXO7hXcNnHgN5nzYub03
   f4QRxTy4yXTfE8St4LsMZzfcBjtZBFTFXq/nsWKfqLxXDhCUNvdtVmqxT
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 Dec 2021 00:29:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 00:29:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 00:29:34 -0800
Received: from blr-ubuntu-311.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 00:29:30 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Marc Zyngier" <maz@kernel.org>
CC:     gregkh <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>
Subject: [PATCHv5 3/4] tracing: Add register read/write tracing support
Date:   Mon, 6 Dec 2021 13:58:05 +0530
Message-ID: <e088f4b4021f2e56093c7f73e77f556059e114b7.1638275062.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638275062.git.quic_saipraka@quicinc.com>
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
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

rwmmio_read: qcom_geni_serial_poll_bit+0xe4/0x108 width=32 addr=0xfffffbfffdbff610
rwmmio_write: qcom_geni_serial_wr_char+0x78/0x80 width=32 val=0x2020205b addr=0xfffffbfffdbff700
rwmmio_write: __qcom_geni_serial_console_write+0x130/0x198 width=32 val=0x40000000 addr=0xfffffbfffdbff618
rwmmio_read: qcom_geni_serial_poll_bit+0xe4/0x108 width=32 addr=0xfffffbfffdbff610

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
[saiprakash: Rewrote commit msg and trace event field edits]
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 include/trace/events/rwmmio.h  | 69 ++++++++++++++++++++++++++++++++++
 kernel/trace/Kconfig           |  7 ++++
 kernel/trace/Makefile          |  1 +
 kernel/trace/trace_readwrite.c | 29 ++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 include/trace/events/rwmmio.h
 create mode 100644 kernel/trace/trace_readwrite.c

diff --git a/include/trace/events/rwmmio.h b/include/trace/events/rwmmio.h
new file mode 100644
index 000000000000..a73bbaa1edd6
--- /dev/null
+++ b/include/trace/events/rwmmio.h
@@ -0,0 +1,69 @@
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
+	TP_PROTO(unsigned long caller, unsigned long parent, u64 val,
+		 u8 width, volatile void __iomem *addr),
+
+	TP_ARGS(caller, parent, val, width, addr),
+
+	TP_STRUCT__entry(
+		__field(u64, caller)
+		__field(u64, parent)
+		__field(u64, val)
+		__field(u64, addr)
+		__field(u8, width)
+	),
+
+	TP_fast_assign(
+		__entry->caller = caller;
+		__entry->parent = parent;
+		__entry->val = val;
+		__entry->addr = (unsigned long)(void *)addr;
+		__entry->width = width;
+	),
+
+	TP_printk("%pS <- %pS width=%d val=%#llx addr=%#llx",
+		(void *)(unsigned long)__entry->caller, (void *)(unsigned long)__entry->parent,
+		__entry->width,	__entry->val, __entry->addr)
+);
+
+TRACE_EVENT(rwmmio_read,
+
+	TP_PROTO(unsigned long caller, unsigned long parent, u8 width,
+		 const volatile void __iomem *addr),
+
+	TP_ARGS(caller, parent, width, addr),
+
+	TP_STRUCT__entry(
+		__field(u64, caller)
+		__field(u64, parent)
+		__field(u64, addr)
+		__field(u8, width)
+	),
+
+	TP_fast_assign(
+		__entry->caller = caller;
+		__entry->parent = parent;
+		__entry->addr = (unsigned long)(void *)addr;
+		__entry->width = width;
+	),
+
+	TP_printk("%pS <- %pS width=%d addr=%#llx",
+		 (void *)(unsigned long)__entry->caller, (void *)(unsigned long)__entry->parent,
+		 __entry->width, __entry->addr)
+);
+
+#endif /* _TRACE_RWMMIO_H */
+
+#include <trace/define_trace.h>
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 420ff4bc67fd..9f55bcc51de1 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -95,6 +95,13 @@ config RING_BUFFER_ALLOW_SWAP
 	 Allow the use of ring_buffer_swap_cpu.
 	 Adds a very slight overhead to tracing when enabled.
 
+config TRACE_MMIO_ACCESS
+	bool "Register read/write tracing"
+	depends on TRACING
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
index 000000000000..5ecf84dc6c13
--- /dev/null
+++ b/kernel/trace/trace_readwrite.c
@@ -0,0 +1,29 @@
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
+void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr)
+{
+	trace_rwmmio_write(CALLER_ADDR0, CALLER_ADDR1, val, width, addr);
+}
+EXPORT_SYMBOL_GPL(log_write_mmio);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_write);
+
+void log_read_mmio(u8 width, const volatile void __iomem *addr)
+{
+	trace_rwmmio_read(CALLER_ADDR0, CALLER_ADDR1, width, addr);
+}
+EXPORT_SYMBOL_GPL(log_read_mmio);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_read);
+#endif /* CONFIG_TRACE_MMIO_ACCESS */
-- 
2.33.1

