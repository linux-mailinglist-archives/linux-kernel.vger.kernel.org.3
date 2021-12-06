Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59C46A3E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbhLFSY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345394AbhLFSY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638814857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YbRtPvzc16br9g4VZ+Y8k/er1BXtD8Aa3EFubEeVd8U=;
        b=VX854XU98sOJXtuWV8SpOq9nPZXb3tcBCJaz/gHqFV5dP2iQ32/V+o6Mj542nL4hxrUh6R
        xb7si5BYblcrbTn3mdNgJzkNfvqiJUOkJcEDemo9mnEjakkOo/g6sskkSvFAadpMmj7rVM
        yEkRz+qz/WrSF6DHc7Sgh7P4Q7O7X0o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-366-mh0_KvSsMc-fNzpWXKQrJg-1; Mon, 06 Dec 2021 13:20:53 -0500
X-MC-Unique: mh0_KvSsMc-fNzpWXKQrJg-1
Received: by mail-ed1-f71.google.com with SMTP id c1-20020aa7c741000000b003e7bf1da4bcso8987534eds.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbRtPvzc16br9g4VZ+Y8k/er1BXtD8Aa3EFubEeVd8U=;
        b=7GJfVTIK7shEFqv/LPX6b13U3qD7VXXToeRmkD6HH/LNogNqf6UsEqqMyGBIAhRC0k
         54zqUllST5GLMqMHSD5k4P24CjddxEGDojPVQGMlan4ECl+ZAh48eEOj6irE54qqexEp
         RKT56uRli4U8OzmIC/ao3b+pviHR9AZ7Dm8XKicGnvnHS4u6l40Jbdbwl/ALOXIklRgD
         m2KirDT29X5eIyqcOgQ8Akvpvqu1iK84SwUU/6/RXn7BOCWlM9DWEAK1AYlvKXrvF4Ie
         IXV+oEi52i4nIBln1NfngZSpCoMUymmEYaFIryqNrWrlATwOxysrxaRw1Qgy8OpfZ6mo
         t8cg==
X-Gm-Message-State: AOAM531Gnri429AyvHKgnDZ4rnMFVcftNIR7fpIrW8SqIeUN2g6Rc3J7
        y5b1MAcXcH+vjiBDBvLGwlmYQ8kG50ydq8oV6D7bjth3ZADHUekFpMsG/6ixek/Feu7OHgqEEkD
        xPTBbaXT1JJelVAsVyMf0qMAO
X-Received: by 2002:a17:907:1689:: with SMTP id hc9mr45710124ejc.445.1638814852089;
        Mon, 06 Dec 2021 10:20:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzINpQOpQH672m+0uFuZPDdVgt6qBX6mJAT6J8UByHekpAeePLCFqzH1wYR05wGmL1mWL2svQ==
X-Received: by 2002:a17:907:1689:: with SMTP id hc9mr45710103ejc.445.1638814851864;
        Mon, 06 Dec 2021 10:20:51 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id e7sm8667569edk.3.2021.12.06.10.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:20:51 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 3/3] ftrace/samples: Add module to test multi direct modify interface
Date:   Mon,  6 Dec 2021 19:20:32 +0100
Message-Id: <20211206182032.87248-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211206182032.87248-1-jolsa@kernel.org>
References: <20211206182032.87248-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 samples/ftrace/Makefile                     |   1 +
 samples/ftrace/ftrace-direct-multi-modify.c | 152 ++++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 samples/ftrace/ftrace-direct-multi-modify.c

diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index b9198e2eef28..faf8cdb79c5f 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace-direct-multi.o
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace-direct-multi-modify.o
 
 CFLAGS_sample-trace-array.o := -I$(src)
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
new file mode 100644
index 000000000000..91bc42a7adb9
--- /dev/null
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/ftrace.h>
+#include <asm/asm-offsets.h>
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
+#ifdef CONFIG_X86_64
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
+#endif /* CONFIG_X86_64 */
+
+#ifdef CONFIG_S390
+
+asm (
+"       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp1, @function\n"
+"       .globl          my_tramp1\n"
+"   my_tramp1:"
+"       lgr             %r1,%r15\n"
+"       stmg            %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       stg             %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       aghi            %r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"       stg             %r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"       lgr             %r2,%r0\n"
+"       brasl           %r14,my_direct_func1\n"
+"       aghi            %r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"       lmg             %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       lg              %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       lgr             %r1,%r0\n"
+"       br              %r1\n"
+"       .size           my_tramp1, .-my_tramp1\n"
+"\n"
+"       .type           my_tramp2, @function\n"
+"       .globl          my_tramp2\n"
+"   my_tramp2:"
+"       lgr             %r1,%r15\n"
+"       stmg            %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       stg             %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       aghi            %r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"       stg             %r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"       lgr             %r2,%r0\n"
+"       brasl           %r14,my_direct_func2\n"
+"       aghi            %r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"       lmg             %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       lg              %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       lgr             %r1,%r0\n"
+"       br              %r1\n"
+"       .size           my_tramp2, .-my_tramp2\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_S390 */
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

