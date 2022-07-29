Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D2584E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiG2Jlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiG2Jk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:40:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579517C1B1;
        Fri, 29 Jul 2022 02:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0647BB8270B;
        Fri, 29 Jul 2022 09:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23480C4347C;
        Fri, 29 Jul 2022 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659087627;
        bh=b8X+BFzH2iCZK+xpE2p+40Q5LRHdNFPjgm8yK8trTBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QeHeJ8s+6pafXdao7/owo8n9jZhvY4Y9okbI92hUti3u2yunW2LZ30ScOVFilHB2Z
         6iFaxa4LYns+Xw0BDf1dypr84xzl+pgETtsfx/wTkL8xe6LuisAWk9SOwgAqBoQEWy
         i+8NVn0MXePlsPtskbMk+wiicurGzDon9grkLBfvkPF9ElEsaT+X21pDAPXPQTO8Rp
         CMhL9SiX5tEqXlWw32HpaI8EFnuxDHsHdI+zVwmqfF9DOazMUNrk7LmJ52PuhZt2yv
         mU85srS0N74786oRq7uSgfLewh9547jiAG+sdfm3kBOdOFE8x/Pqv83AiVAQtjOQ3g
         sayvBoL5D4QGw==
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
Subject: [PATCH V9 16/16] rv/reactor: Add the panic reactor
Date:   Fri, 29 Jul 2022 11:38:55 +0200
Message-Id: <729aae3aba95f35738b8f8180e626d747d1d9da2.1659052063.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659052063.git.bristot@kernel.org>
References: <cover.1659052063.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sample reactor that panics the system when an exception is found. This
is useful both to capture a vmcore, or to fail-safe a critical system.

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
 kernel/trace/rv/Kconfig         |  8 ++++++
 kernel/trace/rv/Makefile        |  1 +
 kernel/trace/rv/reactor_panic.c | 43 +++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 kernel/trace/rv/reactor_panic.c

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index e82d5015e6ab..831779607e84 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -68,3 +68,11 @@ config RV_REACT_PRINTK
 	help
 	  Enables the printk reactor. The printk reactor emits a printk()
 	  message if an exception is found.
+
+config RV_REACT_PANIC
+	bool "Panic reactor"
+	depends on RV_REACTORS
+	default y
+	help
+	  Enables the panic reactor. The panic reactor emits a printk()
+	  message if an exception is found and panic()s the system.
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index a13c750a35c1..963d14875b45 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
+obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
new file mode 100644
index 000000000000..b698d05dd069
--- /dev/null
+++ b/kernel/trace/rv/reactor_panic.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+ *
+ * Panic RV reactor:
+ *   Prints the exception msg to the kernel message log and panic().
+ */
+
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+
+static void rv_panic_reaction(char *msg)
+{
+	panic(msg);
+}
+
+static struct rv_reactor rv_panic = {
+	.name = "panic",
+	.description = "panic the system if an exception is found.",
+	.react = rv_panic_reaction
+};
+
+static int register_react_panic(void)
+{
+	rv_register_reactor(&rv_panic);
+	return 0;
+}
+
+static void unregister_react_panic(void)
+{
+	rv_unregister_reactor(&rv_panic);
+}
+
+module_init(register_react_panic);
+module_exit(unregister_react_panic);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Daniel Bristot de Oliveira");
+MODULE_DESCRIPTION("panic rv reactor: panic if an exception is found.");
-- 
2.35.1

