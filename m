Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B42573ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiGMVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiGMVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:19:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661AC274;
        Wed, 13 Jul 2022 14:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F02BB821E4;
        Wed, 13 Jul 2022 21:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BECC385A2;
        Wed, 13 Jul 2022 21:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657747143;
        bh=maqTOq57CU0Gu7D9sz/7jcCos8xbkyoHRdXzVvz9mDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=skPddDG2zpd2xwIraRB+s63Bp54L0NxKgTTC/VlLG2wx18uQYSWjmJnPQAkO/8CYb
         d66PO+DY1pD0kJzHOCoE1n+s04e2kWnJFihsLKt+MmiC9pgApbvQ1WTQEhNShisvFE
         jhiy451NBgZtNKSIFLHyrQYx4yiZI0wWPnYeJFnsI42ww2vNMWZXAs4jA08JV3V8mI
         57QuY+ygo/siU5Mw3zPA+SktWtVQ58Lmv9KUIBPf+KX7lm2cs0x21M+rpRE0Vv+X1e
         UNfRnvjTJwpJ+wSq6CdtrHH+W2Z9d1ZBH5VkE2KaC48jBWMJCeqkErqChvj0PtZ685
         Xw3Z3ppyYNhlA==
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
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V5 15/16] rv/reactor: Add the printk reactor
Date:   Wed, 13 Jul 2022 23:17:31 +0200
Message-Id: <5fcf3d21b51bc4c1a6d2968cfd0c60fdbc1d471b.1657745645.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657745645.git.bristot@kernel.org>
References: <cover.1657745645.git.bristot@kernel.org>
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

A reactor that printks the reaction message.

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
Cc: Tao Zhou <tao.zhou@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/rv/Kconfig          |  8 ++++++
 kernel/trace/rv/Makefile         |  3 ++-
 kernel/trace/rv/reactor_printk.c | 42 ++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 kernel/trace/rv/reactor_printk.c

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index d8c40fd67e88..f1d92d431130 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -63,3 +63,11 @@ config RV_REACTORS
 	  on the model's execution. By default, the monitors have
 	  tracing reactions, printing the monitor output via tracepoints,
 	  but other reactions can be added (on-demand) via this interface.
+
+config RV_REACT_PRINTK
+	bool "Printk reactor"
+	depends on RV_REACTORS
+	default y
+	help
+	  Enables the printk reactor. The printk reactor emits a printk()
+	  message if an exception is found.
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
index 000000000000..aca11a818966
--- /dev/null
+++ b/kernel/trace/rv/reactor_printk.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+ *
+ * Printk RV reactor:
+ *   Prints the exception msg to the kernel message log.
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

