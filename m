Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0299151C4C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381846AbiEEQMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381783AbiEEQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:12:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75355C87E;
        Thu,  5 May 2022 09:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54B76B82C77;
        Thu,  5 May 2022 16:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB7DC385AC;
        Thu,  5 May 2022 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766895;
        bh=04e05OAKWC2KY4pkzZtKCOzJ9fpqL4EQCIgXq+rMlvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIHxHyN9YW2suHkYlCm4RYTGhWew76GPFITeEsy9Angkqk2Z9w44YXhf8cNL+ze7h
         SL43xpSDL0Dmsqr04V68YD/r1vNejQZDFWwYn8PpHy43v2eWo8OG2ShjzqEa5QSN9Q
         bJUmU9fTogLy80j0nLCXDXW63NE4o8lhZT8x5GE2LiAL4LyQM8OKUOyk91XburhoFl
         i+2vdqjoZhtrmFI5uTt9q3Om3PASY24DyHKTAxqhXw0/8sIQyGUgGuyzfL2p/atfPc
         dxhsSgwIFzU/baSL10TZ0tWNXZ7tzZvSMinx/KAuUlYAsUHB9jrl+p78Gv1YU7d4t+
         a3QfGeIgPrg+Q==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
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
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [RFC V3 13/20] rv/reactor: Add the panic reactor
Date:   Thu,  5 May 2022 18:06:53 +0200
Message-Id: <37da65fd7f07334fdd71cb747decf4947f53e8f7.1651766361.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651766361.git.bristot@kernel.org>
References: <cover.1651766361.git.bristot@kernel.org>
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

Sample reactor that panics the system when an exception is found. This
is useful both to capture a vmcore, or to fail-safe a critical system.

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
 kernel/trace/rv/Kconfig         |  8 ++++++
 kernel/trace/rv/Makefile        |  1 +
 kernel/trace/rv/reactor_panic.c | 44 +++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 kernel/trace/rv/reactor_panic.c

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 8c54ae473846..a2999c37c037 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -45,4 +45,12 @@ config RV_REACT_PRINTK
 	  Enables the printk reactor. The printk reactor emmits a printk()
 	  message if an exception is found.
 
+config RV_REACT_PANIC
+	bool "Panic reactor"
+	depends on RV_REACTORS
+	default y if RV_REACTORS
+	help
+	  Enables the panic reactor. The panic reactor emmits a printk()
+	  message if an exception is found and panic()s the system.
+
 endif # RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index d86ceb103ef2..1f5747f065ce 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_RV_MON_WIP) += monitor_wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitor_wwnr/wwnr.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
+obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
new file mode 100644
index 000000000000..9d8d78a337a3
--- /dev/null
+++ b/kernel/trace/rv/reactor_panic.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Panic RV reactor:
+ *   Prints the exception msg to the kernel message log and panic().
+ *
+ * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
+ *
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
+struct rv_reactor rv_panic = {
+	.name = "panic",
+	.description = "panic the system if an exception is found.",
+	.react = rv_panic_reaction
+};
+
+int register_react_panic(void)
+{
+	rv_register_reactor(&rv_panic);
+	return 0;
+}
+
+void unregister_react_panic(void)
+{
+	rv_unregister_reactor(&rv_panic);
+}
+
+module_init(register_react_panic);
+module_exit(unregister_react_panic);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Daniel Bristot de Oliveira");
+MODULE_DESCRIPTION("panic rv reactor: panic if an exception is found");
-- 
2.35.1

