Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33046486669
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbiAFPAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbiAFPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:00:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8BDC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 07:00:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C770B82229
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBDDC36AED;
        Thu,  6 Jan 2022 15:00:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n5UFE-000sLs-5B;
        Thu, 06 Jan 2022 10:00:00 -0500
Message-ID: <20220106150000.000909083@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 06 Jan 2022 09:57:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-linus][PATCH 1/3] ftrace/samples: Add missing prototypes direct functions
References: <20220106145716.663267282@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

There's another compilation fail (first here [1]) reported by kernel
test robot for W=1 clang build:

  >> samples/ftrace/ftrace-direct-multi-modify.c:7:6: warning: no previous
  prototype for function 'my_direct_func1' [-Wmissing-prototypes]
     void my_direct_func1(unsigned long ip)

Direct functions in ftrace direct sample modules need to have prototypes
defined. They are already global in order to be visible for the inline
assembly, so there's no problem.

The kernel test robot reported just error for ftrace-direct-multi-modify,
but I got same errors also for the rest of the modules touched by this patch.

[1] 67d4f6e3bf5d ftrace/samples: Add missing prototype for my_direct_func

Link: https://lkml.kernel.org/r/20211219135317.212430-1-jolsa@kernel.org

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e1067a07cfbc ("ftrace/samples: Add module to test multi direct modify interface")
Fixes: ae0cc3b7e7f5 ("ftrace/samples: Add a sample module that implements modify_ftrace_direct()")
Fixes: 156473a0ff4f ("ftrace: Add another example of register_ftrace_direct() use case")
Fixes: b06457c83af6 ("ftrace: Add sample module that uses register_ftrace_direct()")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 samples/ftrace/ftrace-direct-modify.c       | 3 +++
 samples/ftrace/ftrace-direct-multi-modify.c | 3 +++
 samples/ftrace/ftrace-direct-too.c          | 3 +++
 samples/ftrace/ftrace-direct.c              | 2 ++
 4 files changed, 11 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 690e4a9ff333..2877cb053a82 100644
--- a/samples/ftrace/ftrace-direct-modify.c
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
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 91bc42a7adb9..6f43a39decd0 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -4,6 +4,9 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
+extern void my_direct_func1(unsigned long ip);
+extern void my_direct_func2(unsigned long ip);
+
 void my_direct_func1(unsigned long ip)
 {
 	trace_printk("my direct func1 ip %lx\n", ip);
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 6e0de725bf22..b97e5ed46233 100644
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
-- 
2.33.0
