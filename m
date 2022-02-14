Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69C44B4E37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350878AbiBNLW5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:22:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244212AbiBNLWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:22:23 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B9B43818D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:58:10 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-0G0PgSf2Me27bKhlbURrpw-1; Mon, 14 Feb 2022 05:47:31 -0500
X-MC-Unique: 0G0PgSf2Me27bKhlbURrpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2728018B613A;
        Mon, 14 Feb 2022 10:47:29 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E781F26DFB;
        Mon, 14 Feb 2022 10:47:24 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [RFC V2 13/21] rv/reactor: Add the panic reactor
Date:   Mon, 14 Feb 2022 11:45:04 +0100
Message-Id: <170ee4f4601b34a8ad25fa9a4f3626368c51e211.1644830251.git.bristot@kernel.org>
In-Reply-To: <cover.1644830251.git.bristot@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
index 490f1417def9..7940898a0504 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -45,4 +45,12 @@ config RV_REACT_PRINTK
 	  Enables the printk reactor. The printk reactor emmits a printk()
 	  message if an exception is found.
 
+config RV_REACT_PANIC
+	tristate "Panic reactor"
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
index 000000000000..538cd3846a4e
--- /dev/null
+++ b/kernel/trace/rv/reactor_panic.c
@@ -0,0 +1,44 @@
+/*
+ * Panic RV reactor:
+ *   Prints the exception msg to the kernel message log and panic().
+ *
+ * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0
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
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Daniel Bristot de Oliveira");
+MODULE_DESCRIPTION("panic rv reactor: panic if an exception is found");
-- 
2.33.1

