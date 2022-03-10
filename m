Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51774D3FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiCJD2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiCJD2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:28:08 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8006DFFFB5;
        Wed,  9 Mar 2022 19:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646882828; x=1678418828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iUKiNPXgupodxa6sIHxCYeH6kkcxR6+5JY3HHNORkgk=;
  b=O1PWtydLoPgxDr87FIS4tKMcSQ+HslEn3L+RUeauzk7KaRbCbufOXrVI
   bSuTL8ujXb5fTlP7RTahI2EmGklOXaPrNTGeWFbzndx9kHo2geokNT6py
   IVmiwkE4u/aMJyBOUs2vXAn3eCRFu7q/75jmNZ4UFvYsLlJCpXgU/fNqG
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Mar 2022 19:27:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:27:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 19:27:07 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 19:27:03 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>
Subject: [PATCHv6] tty: hvc: dcc: Bind driver to CPU core0 for reads and writes
Date:   Thu, 10 Mar 2022 08:56:36 +0530
Message-ID: <20220310032636.7286-1-quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shanker Donthineni <shankerd@codeaurora.org>

Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
reads/writes from/to DCC on secondary cores. Each core has its
own DCC device registers, so when a core reads or writes from/to DCC,
it only accesses its own DCC device. Since kernel code can run on
any core, every time the kernel wants to write to the console, it
might write to a different DCC.

In SMP mode, Trace32 creates multiple windows, and each window shows
the DCC output only from that core's DCC. The result is that console
output is either lost or scattered across windows.

Selecting this option will enable code that serializes all console
input and output to core 0. The DCC driver will create input and
output FIFOs that all cores will use. Reads and writes from/to DCC
are handled by a workqueue that runs only core 0.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Acked-by: Adam Wallis <awallis@codeaurora.org>
Signed-off-by: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Elliot Berman <eberman@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---

Changes in v6:
 * Disable CPU hotplug when CONFIG_HVC_DCC_SERIALIZE_SMP=y.

Changes in v5:
 * Use get_cpu() and put_cpu() for CPU id check in preemptible context.
 * Revert back to build time Kconfig.
 * Remove unnecessary hotplug locks, they result in sleeping in atomic context bugs.
 * Add a comment for the spinlock.

Changes in v4:
 * Use module parameter for runtime choice of enabling this feature.
 * Use hotplug locks to avoid race between cpu online check and work schedule.
 * Remove ifdefs and move to common ops.
 * Remove unnecessary check for this configuration.
 * Use macros for buf size instead of magic numbers.
 * v3 - https://lore.kernel.org/lkml/20211213141013.21464-1-quic_saipraka@quicinc.com/

Changes in v3:
 * Handle case where core0 is not online.

Changes in v2:
 * Checkpatch warning fixes.
 * Use of IS_ENABLED macros instead of ifdefs.

---
 drivers/tty/hvc/Kconfig   |  20 +++++
 drivers/tty/hvc/hvc_dcc.c | 175 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 192 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 8d60e0ff67b4..62560cd0c04d 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -87,6 +87,26 @@ config HVC_DCC
 	  driver. This console is used through a JTAG only on ARM. If you don't have
 	  a JTAG then you probably don't want this option.
 
+config HVC_DCC_SERIALIZE_SMP
+	bool "Use DCC only on CPU core 0"
+	depends on SMP && HVC_DCC
+	help
+	  Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
+	  reads/writes from/to DCC on more than one CPU core. Each core has its
+	  own DCC device registers, so when a CPU core reads or writes from/to
+	  DCC, it only accesses its own DCC device. Since kernel code can run on
+	  any CPU core, every time the kernel wants to write to the console, it
+	  might write to a different DCC.
+
+	  In SMP mode, Trace32 creates multiple windows, and each window shows
+	  the DCC output only from that core's DCC. The result is that console
+	  output is either lost or scattered across windows.
+
+	  Selecting this option will enable code that serializes all console
+	  input and output to CPU core 0. The DCC driver will create input and
+	  output FIFOs that all cores will use. Reads and writes from/to DCC
+	  are handled by a workqueue that runs only CPU core 0.
+
 config HVC_RISCV_SBI
 	bool "RISC-V SBI console support"
 	depends on RISCV_SBI_V01
diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 8e0edb7d93fd..e87b82e873d7 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -2,9 +2,14 @@
 /* Copyright (c) 2010, 2014 The Linux Foundation. All rights reserved.  */
 
 #include <linux/console.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/init.h>
+#include <linux/kfifo.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
 
 #include <asm/dcc.h>
 #include <asm/processor.h>
@@ -15,6 +20,15 @@
 #define DCC_STATUS_RX		(1 << 30)
 #define DCC_STATUS_TX		(1 << 29)
 
+#define DCC_INBUF_SIZE		128
+#define DCC_OUTBUF_SIZE		1024
+
+/* Lock to serialize access to DCC fifo */
+static DEFINE_SPINLOCK(dcc_lock);
+
+static DEFINE_KFIFO(inbuf, unsigned char, DCC_INBUF_SIZE);
+static DEFINE_KFIFO(outbuf, unsigned char, DCC_OUTBUF_SIZE);
+
 static void dcc_uart_console_putchar(struct uart_port *port, int ch)
 {
 	while (__dcc_getstatus() & DCC_STATUS_TX)
@@ -67,24 +81,176 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
 	return i;
 }
 
+/*
+ * Check if the DCC is enabled. If CONFIG_HVC_DCC_SERIALIZE_SMP is enabled,
+ * then we assume then this function will be called first on core0. That way,
+ * dcc_core0_available will be true only if it's available on core0.
+ */
 static bool hvc_dcc_check(void)
 {
 	unsigned long time = jiffies + (HZ / 10);
+	static bool dcc_core0_available;
+
+	/*
+	 * If we're not on core 0, but we previously confirmed that DCC is
+	 * active, then just return true.
+	 */
+	int cpu = get_cpu();
+
+	if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP) && cpu && dcc_core0_available) {
+		put_cpu();
+		return true;
+	}
+
+	put_cpu();
 
 	/* Write a test character to check if it is handled */
 	__dcc_putchar('\n');
 
 	while (time_is_after_jiffies(time)) {
-		if (!(__dcc_getstatus() & DCC_STATUS_TX))
+		if (!(__dcc_getstatus() & DCC_STATUS_TX)) {
+			dcc_core0_available = true;
 			return true;
+		}
 	}
 
 	return false;
 }
 
+/*
+ * Workqueue function that writes the output FIFO to the DCC on core 0.
+ */
+static void dcc_put_work(struct work_struct *work)
+{
+	unsigned char ch;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&dcc_lock, irqflags);
+
+	/* While there's data in the output FIFO, write it to the DCC */
+	while (kfifo_get(&outbuf, &ch))
+		hvc_dcc_put_chars(0, &ch, 1);
+
+	/* While we're at it, check for any input characters */
+	while (!kfifo_is_full(&inbuf)) {
+		if (!hvc_dcc_get_chars(0, &ch, 1))
+			break;
+		kfifo_put(&inbuf, ch);
+	}
+
+	spin_unlock_irqrestore(&dcc_lock, irqflags);
+}
+
+static DECLARE_WORK(dcc_pwork, dcc_put_work);
+
+/*
+ * Workqueue function that reads characters from DCC and puts them into the
+ * input FIFO.
+ */
+static void dcc_get_work(struct work_struct *work)
+{
+	unsigned char ch;
+	unsigned long irqflags;
+
+	/*
+	 * Read characters from DCC and put them into the input FIFO, as
+	 * long as there is room and we have characters to read.
+	 */
+	spin_lock_irqsave(&dcc_lock, irqflags);
+
+	while (!kfifo_is_full(&inbuf)) {
+		if (!hvc_dcc_get_chars(0, &ch, 1))
+			break;
+		kfifo_put(&inbuf, ch);
+	}
+	spin_unlock_irqrestore(&dcc_lock, irqflags);
+}
+
+static DECLARE_WORK(dcc_gwork, dcc_get_work);
+
+/*
+ * Write characters directly to the DCC if we're on core 0 and the FIFO
+ * is empty, or write them to the FIFO if we're not.
+ */
+static int hvc_dcc0_put_chars(u32 vt, const char *buf, int count)
+{
+	int len;
+	unsigned long irqflags;
+
+	if (!IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))
+		return hvc_dcc_put_chars(vt, buf, count);
+
+	spin_lock_irqsave(&dcc_lock, irqflags);
+	if (smp_processor_id() || (!kfifo_is_empty(&outbuf))) {
+		len = kfifo_in(&outbuf, buf, count);
+		spin_unlock_irqrestore(&dcc_lock, irqflags);
+
+		/*
+		 * We just push data to the output FIFO, so schedule the
+		 * workqueue that will actually write that data to DCC.
+		 * CPU hotplug is disabled so CPU0 cannot be offlined
+		 * after the cpu online check.
+		 */
+		if (cpu_online(0))
+			schedule_work_on(0, &dcc_pwork);
+
+		return len;
+	}
+
+	/*
+	 * If we're already on core 0, and the FIFO is empty, then just
+	 * write the data to DCC.
+	 */
+	len = hvc_dcc_put_chars(vt, buf, count);
+	spin_unlock_irqrestore(&dcc_lock, irqflags);
+
+	return len;
+}
+
+/*
+ * Read characters directly from the DCC if we're on core 0 and the FIFO
+ * is empty, or read them from the FIFO if we're not.
+ */
+static int hvc_dcc0_get_chars(u32 vt, char *buf, int count)
+{
+	int len;
+	unsigned long irqflags;
+
+	if (!IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))
+		return hvc_dcc_get_chars(vt, buf, count);
+
+	spin_lock_irqsave(&dcc_lock, irqflags);
+
+	if (smp_processor_id() || (!kfifo_is_empty(&inbuf))) {
+		len = kfifo_out(&inbuf, buf, count);
+		spin_unlock_irqrestore(&dcc_lock, irqflags);
+
+		/*
+		 * If the FIFO was empty, there may be characters in the DCC
+		 * that we haven't read yet.  Schedule a workqueue to fill
+		 * the input FIFO, so that the next time this function is
+		 * called, we'll have data. CPU hotplug is disabled so CPU0
+		 * cannot be offlined after the cpu online check.
+		 */
+		if (!len && cpu_online(0))
+			schedule_work_on(0, &dcc_gwork);
+
+		return len;
+	}
+
+	/*
+	 * If we're already on core 0, and the FIFO is empty, then just
+	 * read the data from DCC.
+	 */
+	len = hvc_dcc_get_chars(vt, buf, count);
+	spin_unlock_irqrestore(&dcc_lock, irqflags);
+
+	return len;
+}
+
 static const struct hv_ops hvc_dcc_get_put_ops = {
-	.get_chars = hvc_dcc_get_chars,
-	.put_chars = hvc_dcc_put_chars,
+	.get_chars = hvc_dcc0_get_chars,
+	.put_chars = hvc_dcc0_put_chars,
 };
 
 static int __init hvc_dcc_console_init(void)
@@ -108,6 +274,9 @@ static int __init hvc_dcc_init(void)
 	if (!hvc_dcc_check())
 		return -ENODEV;
 
+	if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))
+		cpu_hotplug_disable();
+
 	p = hvc_alloc(0, 0, &hvc_dcc_get_put_ops, 128);
 
 	return PTR_ERR_OR_ZERO(p);

base-commit: 6705cd745adbbeac6b13002c7a30060f7b2568a5
-- 
2.33.1

