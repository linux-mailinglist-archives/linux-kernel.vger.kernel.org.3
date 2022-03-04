Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF0B4CCE00
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiCDGrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbiCDGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:47:47 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Mar 2022 22:46:57 PST
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A2D18DA95;
        Thu,  3 Mar 2022 22:46:57 -0800 (PST)
IronPort-SDR: yw/kl5ucYqtKfEOU0+STPvlOgazcPv6PxvvuTNQbUT0KAwXEjZT3JlOai2tdh2OkYrDYg/7BjG
 mh8O+eGxCw7zpv7AnnFvcmM9VY5ccd0VyEat/BaA3LNWjBVUqo7SOcVFSD8TwWZcla2prVP8o3
 uu/C4Nut7bK039lVYlXn3ltaYTbMlArWnPo34dj4cJ5PJh5cVNOIOLs95OLBotdJ1TiQuGNWKD
 KplTjVIdKqK7/7qOHzto9qzLRhMpzSYKf3V/PoCnEim4uzKNe4TqHbHEMA7plMyVL0GE5zWl5O
 fLhOC+XkcQIzZ82otRrKAEdB
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="64906697"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; 
   d="scan'208";a="64906697"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2022 15:45:50 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 47ED8C68A5;
        Fri,  4 Mar 2022 15:45:49 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id DF1EF1428B;
        Fri,  4 Mar 2022 15:45:47 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id 616B64007DEED;
        Fri,  4 Mar 2022 15:45:47 +0900 (JST)
From:   Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
To:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-serial@vger.kernel.org, sumit.garg@linaro.org
Cc:     arnd@arndb.de, olof@lixom.net, catalin.marinas@arm.com,
        will@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, peterz@infradead.org,
        hasegawa-hitomi@fujitsu.com
Subject: [PATCH v2 1/2] tty/sysrq: Make sysrq handler NMI aware
Date:   Fri,  4 Mar 2022 15:43:23 +0900
Message-Id: <20220304064324.331217-2-hasegawa-hitomi@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220304064324.331217-1-hasegawa-hitomi@fujitsu.com>
References: <20220304064324.331217-1-hasegawa-hitomi@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Allow a magic sysrq to be triggered from an NMI context. This is done
via marking some sysrq actions as NMI safe. Safe actions will be allowed
to run from NMI context whilst that cannot run from an NMI will be queued
as irq_work for later processing.

The major use-case is to add NMI debugging capabilities to the kernel
in order to debug scenarios such as:
- Primary CPU is stuck in deadlock with interrupts disabled and hence
  doesn't honor serial device interrupt. So having magic sysrq triggered
  as an NMI is helpful for debugging.
- Always enabled NMI based magic sysrq irrespective of whether the serial
  TTY port is active or not.
- Apart from UART interrupts, it allows magic sysrq to be triggered from
  a diagnostic NMI interrupt on systems such as A64FX.

A particular sysrq handler is only marked as NMI safe in case the handler
isn't contending for any synchronization primitives as in NMI context
they are expected to cause deadlocks. Note that the debug sysrq do not
contend for any synchronization primitives. It does call kgdb_breakpoint()
to provoke a trap but that trap handler should be NMI safe on
architectures that implement an NMI.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
---
 drivers/tty/sysrq.c       | 45 ++++++++++++++++++++++++++++++++++++++-
 include/linux/sysrq.h     |  1 +
 kernel/debug/debug_core.c |  1 +
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index bbfd004449b5..40cd492fe6ec 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -51,6 +51,7 @@
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/rcupdate.h>
+#include <linux/irq_work.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -112,6 +113,7 @@ static const struct sysrq_key_op sysrq_loglevel_op = {
 	.help_msg	= "loglevel(0-9)",
 	.action_msg	= "Changing Loglevel",
 	.enable_mask	= SYSRQ_ENABLE_LOG,
+	.nmi_safe	= true,
 };
 
 #ifdef CONFIG_VT
@@ -159,6 +161,7 @@ static const struct sysrq_key_op sysrq_crash_op = {
 	.help_msg	= "crash(c)",
 	.action_msg	= "Trigger a crash",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 
 static void sysrq_handle_reboot(int key)
@@ -172,6 +175,7 @@ static const struct sysrq_key_op sysrq_reboot_op = {
 	.help_msg	= "reboot(b)",
 	.action_msg	= "Resetting",
 	.enable_mask	= SYSRQ_ENABLE_BOOT,
+	.nmi_safe	= true,
 };
 
 const struct sysrq_key_op *__sysrq_reboot_op = &sysrq_reboot_op;
@@ -219,6 +223,7 @@ static const struct sysrq_key_op sysrq_showlocks_op = {
 	.handler	= sysrq_handle_showlocks,
 	.help_msg	= "show-all-locks(d)",
 	.action_msg	= "Show Locks Held",
+	.nmi_safe	= true,
 };
 #else
 #define sysrq_showlocks_op (*(const struct sysrq_key_op *)NULL)
@@ -291,6 +296,7 @@ static const struct sysrq_key_op sysrq_showregs_op = {
 	.help_msg	= "show-registers(p)",
 	.action_msg	= "Show Regs",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 
 static void sysrq_handle_showstate(int key)
@@ -328,6 +334,7 @@ static const struct sysrq_key_op sysrq_ftrace_dump_op = {
 	.help_msg	= "dump-ftrace-buffer(z)",
 	.action_msg	= "Dump ftrace buffer",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 #else
 #define sysrq_ftrace_dump_op (*(const struct sysrq_key_op *)NULL)
@@ -566,6 +573,32 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
 		sysrq_key_table[i] = op_p;
 }
 
+static int sysrq_nmi_key = -1;
+
+static void sysrq_do_irq_work(struct irq_work *work)
+{
+	const struct sysrq_key_op *op_p;
+	int orig_suppress_printk;
+
+	orig_suppress_printk = suppress_printk;
+	suppress_printk = 0;
+
+	rcu_sysrq_start();
+	rcu_read_lock();
+
+	op_p = __sysrq_get_key_op(sysrq_nmi_key);
+	if (op_p)
+		op_p->handler(sysrq_nmi_key);
+
+	rcu_read_unlock();
+	rcu_sysrq_end();
+
+	suppress_printk = orig_suppress_printk;
+	sysrq_nmi_key = -1;
+}
+
+static DEFINE_IRQ_WORK(sysrq_irq_work, sysrq_do_irq_work);
+
 void __handle_sysrq(int key, bool check_mask)
 {
 	const struct sysrq_key_op *op_p;
@@ -573,6 +606,10 @@ void __handle_sysrq(int key, bool check_mask)
 	int orig_suppress_printk;
 	int i;
 
+	/* Skip sysrq handling if one already in progress */
+	if (sysrq_nmi_key != -1)
+		return;
+
 	orig_suppress_printk = suppress_printk;
 	suppress_printk = 0;
 
@@ -596,7 +633,13 @@ void __handle_sysrq(int key, bool check_mask)
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
 			pr_info("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
-			op_p->handler(key);
+
+			if (in_nmi() && !op_p->nmi_safe) {
+				sysrq_nmi_key = key;
+				irq_work_queue(&sysrq_irq_work);
+			} else {
+				op_p->handler(key);
+			}
 		} else {
 			pr_info("This sysrq operation is disabled.\n");
 			console_loglevel = orig_log_level;
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 3a582ec7a2f1..630b5b9dc225 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -34,6 +34,7 @@ struct sysrq_key_op {
 	const char * const help_msg;
 	const char * const action_msg;
 	const int enable_mask;
+	const bool nmi_safe;
 };
 
 #ifdef CONFIG_MAGIC_SYSRQ
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index da06a5553835..53b56114f59b 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -978,6 +978,7 @@ static const struct sysrq_key_op sysrq_dbg_op = {
 	.handler	= sysrq_handle_dbg,
 	.help_msg	= "debug(g)",
 	.action_msg	= "DEBUG",
+	.nmi_safe	= true,
 };
 #endif
 
-- 
2.27.0

