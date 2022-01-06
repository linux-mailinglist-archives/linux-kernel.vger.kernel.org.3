Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B469486B7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbiAFU6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbiAFU6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:58:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63CC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:58:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAA8AB823E1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 20:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3197FC36AE5;
        Thu,  6 Jan 2022 20:58:44 +0000 (UTC)
Date:   Thu, 6 Jan 2022 15:58:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [GIT PULL] tracing: Minor fixes
Message-ID: <20220106155842.57b7b4f3@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

Three minor tracing fixes:

- Fix missing prototypes in sample module for direct functions

- Fix check of valid buffer in get_trace_buf()

- Fix annotations of percpu pointers.


Please pull the latest trace-v5.16-rc8 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16-rc8

Tag SHA1: a5f34af45294b31f67d1e62e4fcd63c130abdec1
Head SHA1: f28439db470cca8b6b082239314e9fd10bd39034


Jiri Olsa (1):
      ftrace/samples: Add missing prototypes direct functions

Naveen N. Rao (2):
      tracing: Fix check for trace_percpu_buffer validity in get_trace_buf()
      tracing: Tag trace_percpu_buffer as a percpu pointer

----
 kernel/trace/trace.c                        | 6 +++---
 samples/ftrace/ftrace-direct-modify.c       | 3 +++
 samples/ftrace/ftrace-direct-multi-modify.c | 3 +++
 samples/ftrace/ftrace-direct-too.c          | 3 +++
 samples/ftrace/ftrace-direct.c              | 2 ++
 5 files changed, 14 insertions(+), 3 deletions(-)
---------------------------
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 88de94da596b..78ea542ce3bc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3207,7 +3207,7 @@ struct trace_buffer_struct {
 	char buffer[4][TRACE_BUF_SIZE];
 };
 
-static struct trace_buffer_struct *trace_percpu_buffer;
+static struct trace_buffer_struct __percpu *trace_percpu_buffer;
 
 /*
  * This allows for lockless recording.  If we're nested too deeply, then
@@ -3217,7 +3217,7 @@ static char *get_trace_buf(void)
 {
 	struct trace_buffer_struct *buffer =
this_cpu_ptr(trace_percpu_buffer); 
-	if (!buffer || buffer->nesting >= 4)
+	if (!trace_percpu_buffer || buffer->nesting >= 4)
 		return NULL;
 
 	buffer->nesting++;
@@ -3236,7 +3236,7 @@ static void put_trace_buf(void)
 
 static int alloc_percpu_trace_buffer(void)
 {
-	struct trace_buffer_struct *buffers;
+	struct trace_buffer_struct __percpu *buffers;
 
 	if (trace_percpu_buffer)
 		return 0;
diff --git a/samples/ftrace/ftrace-direct-modify.c
b/samples/ftrace/ftrace-direct-modify.c index 690e4a9ff333..2877cb053a82
100644 --- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -4,6 +4,9 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
+extern void my_direct_func1(void);
+extern void my_direct_func2(void);
+
 void my_direct_func1(void)
 {
 	trace_printk("my direct func1\n");
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c
b/samples/ftrace/ftrace-direct-multi-modify.c index
91bc42a7adb9..6f43a39decd0 100644 ---
a/samples/ftrace/ftrace-direct-multi-modify.c +++
b/samples/ftrace/ftrace-direct-multi-modify.c @@ -4,6 +4,9 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
+extern void my_direct_func1(unsigned long ip);
+extern void my_direct_func2(unsigned long ip);
+
 void my_direct_func1(unsigned long ip)
 {
 	trace_printk("my direct func1 ip %lx\n", ip);
diff --git a/samples/ftrace/ftrace-direct-too.c
b/samples/ftrace/ftrace-direct-too.c index 6e0de725bf22..b97e5ed46233 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -5,6 +5,9 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
+extern void my_direct_func(struct vm_area_struct *vma,
+			   unsigned long address, unsigned int flags);
+
 void my_direct_func(struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index a30aa42ec76a..c918b13edb49 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -5,6 +5,8 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
+extern void my_direct_func(struct task_struct *p);
+
 void my_direct_func(struct task_struct *p)
 {
 	trace_printk("waking up %s-%d\n", p->comm, p->pid);
