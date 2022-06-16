Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8486954DD42
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiFPIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359763AbiFPIqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669B55DBF2;
        Thu, 16 Jun 2022 01:46:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AB3F61D58;
        Thu, 16 Jun 2022 08:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AA5C34114;
        Thu, 16 Jun 2022 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369171;
        bh=grmOOJEABOUWSLsmON0N5vfx4AsyJeKk/lzSYDXQuAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTY3ENwZTwWJjVFmf3d8cZapqdgKg04KqBmzF7ZSEizxdHvP6TVJb6ZfFcqm/L0J9
         SJy7P8n1/fj09JBIS/zn1oEWF4WP4P1geag7MfWfWChIriJzUf+O7Z1qBm8gBUn/jm
         mLJ8rvkEAbnXNf68FvaapWWYxCmWE/Mr7LBiLn0uK7w7FLp4uTyBflfE3ArR9Nmo8n
         oEFeYeU6QBYXGLD76hHai2iGUPSPOlIf/4aBGYItuyyxk2ke4j2Ogq1VfYGX9Px7CD
         Oc/pnKkvws43h0JqfyHkxjS9mV7ldrrJbIlnxnxwaAo21H41RcKaB3WyOKIv0Gim2i
         wCvzBKrggFEiQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V4 12/20] rv/reactor: Add the printk reactor
Date:   Thu, 16 Jun 2022 10:44:54 +0200
Message-Id: <338533d97b25ccedb862691d866cfcc8e0b69cb3.1655368610.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
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

Sample reactor that printks the reaction message.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/rv/Kconfig          |  8 ++++++
 kernel/trace/rv/Makefile         |  3 ++-
 kernel/trace/rv/reactor_printk.c | 43 ++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 kernel/trace/rv/reactor_printk.c

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index fba2ace2a22b..be8e3dab0a52 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -52,4 +52,12 @@ config RV_REACTORS
 	  tracing reactions, printing the monitor output via tracepoints,
 	  but other reactions can be added (on-demand) via this interface.
 
+config RV_REACT_PRINTK
+	bool "Printk reactor"
+	depends on RV_REACTORS
+	default y if RV_REACTORS
+	help
+	  Enables the printk reactor. The printk reactor emmits a printk()
+	  message if an exception is found.
+
 endif # RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index af0ff9a46418..a13c750a35c1 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_RV) += rv.o
-obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
+obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
+obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
new file mode 100644
index 000000000000..6a7bbf3fc03f
--- /dev/null
+++ b/kernel/trace/rv/reactor_printk.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Printk RV reactor:
+ *   Prints the exception msg to the kernel message log.
+ *
+ * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
+ *
+ */
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+
+static void rv_printk_reaction(char *msg)
+{
+	printk_deferred(msg);
+}
+
+struct rv_reactor rv_printk = {
+	.name = "printk",
+	.description = "prints the exception msg to the kernel message log",
+	.react = rv_printk_reaction
+};
+
+int register_react_printk(void)
+{
+	rv_register_reactor(&rv_printk);
+	return 0;
+}
+
+void unregister_react_printk(void)
+{
+	rv_unregister_reactor(&rv_printk);
+}
+
+module_init(register_react_printk);
+module_exit(unregister_react_printk);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Daniel Bristot de Oliveira");
+MODULE_DESCRIPTION("printk rv reactor: printk if an exception is hit");
-- 
2.35.1

