Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0904C468E17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhLEXY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241175AbhLEXY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638746459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+r8VDO075HP3zY5B8NZqLYXy1hXR8gsbRnN4JJ18dY=;
        b=PrOE0q/7JFeMMQmR7A4uih2zl5jPBfjFJx7YMO6H1Zzagz1zo3qm/WxaNE9eLJkBdliMNa
        itze89seAaLslL9c0ZA16oAJ+B0rcqx7muwLBVvVuGgYAdefV643ZN5RsxwVRTgj47fg1z
        XFknvOyUYXlAfHaGGUv3bHiDEvbrBx4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-WYXFBnyCP5yLz8FKmx27Yg-1; Sun, 05 Dec 2021 18:20:58 -0500
X-MC-Unique: WYXFBnyCP5yLz8FKmx27Yg-1
Received: by mail-ed1-f69.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so6823061edx.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 15:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+r8VDO075HP3zY5B8NZqLYXy1hXR8gsbRnN4JJ18dY=;
        b=vBtvmHXzYpVrnUAcscZCaoNgXzxauXGBOzH7jmwpPksJWp/dd2+pQbfzY6En4BbTTd
         Z/sBfc6hK+WzxmX+QcdwViuaaflArAIkWgNeWcmmBwR2u0yPLt8DV2VavaVOTBftvBUE
         1+LXuYkX6ejmTrEsQUBUKTUI99hzkP1nOarTiwpC9+oM13VPSilqFUACPIEZ02Mv989f
         xDQiuzdWSgjEitND5qhk6Zufuz5kxfzZVbAgPmPB+T5WlJooZNTMvWGG47hxfxxng2pW
         VsD0RzLdcLDemR+qD2xy7UGj5DLMSPpslWH2lXHImcl8Tb182K4GtrLXhc6yhv6ak4kG
         sNlw==
X-Gm-Message-State: AOAM530jBj1VYYsyf4NnTzQGoFWvq4MfAbZ30qVLP5MFw5Y9zqUeTNgs
        G+7sy9YaH1XkCUTmExuX3ySP0wAChKME+t1WrNo4SsMPdznOfocWCaq1oyEtblsB4lgYXvp3x6f
        HIM4a8wGEHrBrNzRRV8ezUFDT
X-Received: by 2002:a17:906:7954:: with SMTP id l20mr40354543ejo.143.1638746456622;
        Sun, 05 Dec 2021 15:20:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm5sYLGG4jFUaEKDdQCUn3GYHBw5P5kiuWLPV47yXPG1h8/cMyCT4splGY5KyGGBnycIYFyg==
X-Received: by 2002:a17:906:7954:: with SMTP id l20mr40354524ejo.143.1638746456409;
        Sun, 05 Dec 2021 15:20:56 -0800 (PST)
Received: from krava.redhat.com ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id t20sm6623963edv.81.2021.12.05.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:20:56 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 3/3] ftrace/samples: Add module to test multi direct modify interface
Date:   Mon,  6 Dec 2021 00:20:36 +0100
Message-Id: <20211205232036.51996-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211205232036.51996-1-jolsa@kernel.org>
References: <20211205232036.51996-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding ftrace-direct-multi-modify.ko kernel module that uses
modify_ftrace_direct_multi API. The core functionality is taken
from ftrace-direct-modify.ko kernel module and changed to fit
multi direct interface.

The init function creates kthread that periodically calls
modify_ftrace_direct_multi to change the trampoline address
for the direct ftrace_ops. The ftrace trace_pipe then shows
trace from both trampolines.

Also adding SAMPLE_FTRACE_MULTI_DIRECT to enable build of
direct multi interface sample modules. It's used in Makefile,
but not defined at the moment.

Same as for ftrace-direct-multi.ko, the new module is enabled
only for x86_64, so there's no need to ifdef the inlined assembly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 samples/Kconfig                             |   8 ++
 samples/ftrace/Makefile                     |   1 +
 samples/ftrace/ftrace-direct-multi-modify.c | 105 ++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 samples/ftrace/ftrace-direct-multi-modify.c

diff --git a/samples/Kconfig b/samples/Kconfig
index bec3528aa2de..38daae5a06b5 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -31,6 +31,14 @@ config SAMPLE_FTRACE_DIRECT
 	  This builds an ftrace direct function example
 	  that hooks to wake_up_process and prints the parameters.
 
+config SAMPLE_FTRACE_MULTI_DIRECT
+	tristate "Build register_ftrace_direct_multi() examples"
+	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
+	depends on HAVE_SAMPLE_FTRACE_MULTI_DIRECT
+	help
+	  This builds an ftrace direct multi function examples
+	  that hooks trampolines to multiple functions.
+
 config SAMPLE_TRACE_ARRAY
         tristate "Build sample module for kernel access to Ftrace instancess"
 	depends on EVENT_TRACING && m
diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index e8a3f8520a44..027d375890f8 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
 obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace-direct-multi.o
+obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace-direct-multi-modify.o
 
 CFLAGS_sample-trace-array.o := -I$(src)
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
new file mode 100644
index 000000000000..ba309cb33c77
--- /dev/null
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/ftrace.h>
+
+void my_direct_func1(unsigned long ip)
+{
+	trace_printk("my direct func1 ip %lx\n", ip);
+}
+
+void my_direct_func2(unsigned long ip)
+{
+	trace_printk("my direct func2 ip %lx\n", ip);
+}
+
+extern void my_tramp1(void *);
+extern void my_tramp2(void *);
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	pushq %rdi\n"
+"	movq 8(%rbp), %rdi\n"
+"	call my_direct_func1\n"
+"	popq %rdi\n"
+"	leave\n"
+"	ret\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+"	.type		my_tramp2, @function\n"
+"\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	pushq %rdi\n"
+"	movq 8(%rbp), %rdi\n"
+"	call my_direct_func2\n"
+"	popq %rdi\n"
+"	leave\n"
+"	ret\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+static unsigned long my_tramp = (unsigned long)my_tramp1;
+static unsigned long tramps[2] = {
+	(unsigned long)my_tramp1,
+	(unsigned long)my_tramp2,
+};
+
+static struct ftrace_ops direct;
+
+static int simple_thread(void *arg)
+{
+	static int t;
+	int ret = 0;
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(2 * HZ);
+
+		if (ret)
+			continue;
+		t ^= 1;
+		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
+		if (!ret)
+			my_tramp = tramps[t];
+		WARN_ON_ONCE(ret);
+	}
+
+	return 0;
+}
+
+static struct task_struct *simple_tsk;
+
+static int __init ftrace_direct_multi_init(void)
+{
+	int ret;
+
+	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
+	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
+
+	ret = register_ftrace_direct_multi(&direct, my_tramp);
+
+	if (!ret)
+		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
+	return ret;
+}
+
+static void __exit ftrace_direct_multi_exit(void)
+{
+	kthread_stop(simple_tsk);
+	unregister_ftrace_direct_multi(&direct, my_tramp);
+}
+
+module_init(ftrace_direct_multi_init);
+module_exit(ftrace_direct_multi_exit);
+
+MODULE_AUTHOR("Jiri Olsa");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
+MODULE_LICENSE("GPL");
-- 
2.33.1

