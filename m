Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6947D536A64
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355714AbiE1Cx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355608AbiE1Cw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E4C880C6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D3F6B82690
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49397C385A9;
        Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZP-000LRh-CI;
        Fri, 27 May 2022 22:52:51 -0400
Message-ID: <20220528025251.216039824@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li kunyu <kunyu@nfschina.com>
Subject: [for-next][PATCH 14/23] ftrace: Remove return value of ftrace_arch_modify_*()
References: <20220528025028.850906216@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li kunyu <kunyu@nfschina.com>

All instances of the function ftrace_arch_modify_prepare() and
  ftrace_arch_modify_post_process() return zero. There's no point in
  checking their return value. Just have them be void functions.

Link: https://lkml.kernel.org/r/20220518023639.4065-1-kunyu@nfschina.com

Signed-off-by: Li kunyu <kunyu@nfschina.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/arm/kernel/ftrace.c   |  6 ++----
 arch/riscv/kernel/ftrace.c |  6 ++----
 arch/s390/kernel/ftrace.c  |  3 +--
 arch/x86/kernel/ftrace.c   |  6 ++----
 include/linux/ftrace.h     |  4 ++--
 kernel/trace/ftrace.c      | 16 ++++------------
 6 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 83cc068586bc..a0b6d1e3812f 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -79,16 +79,14 @@ static unsigned long __ref adjust_address(struct dyn_ftrace *rec,
 	return (unsigned long)&ftrace_regs_caller_from_init;
 }
 
-int ftrace_arch_code_modify_prepare(void)
+void ftrace_arch_code_modify_prepare(void)
 {
-	return 0;
 }
 
-int ftrace_arch_code_modify_post_process(void)
+void ftrace_arch_code_modify_post_process(void)
 {
 	/* Make sure any TLB misses during machine stop are cleared. */
 	flush_tlb_all();
-	return 0;
 }
 
 static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr,
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4716f4cdc038..2086f6585773 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -12,16 +12,14 @@
 #include <asm/patch.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
+void ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
 {
 	mutex_lock(&text_mutex);
-	return 0;
 }
 
-int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
+void ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
 {
 	mutex_unlock(&text_mutex);
-	return 0;
 }
 
 static int ftrace_check_current_call(unsigned long hook_pos,
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 1852d46babb1..416b5a94353d 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -225,14 +225,13 @@ void arch_ftrace_update_code(int command)
 	ftrace_modify_all_code(command);
 }
 
-int ftrace_arch_code_modify_post_process(void)
+void ftrace_arch_code_modify_post_process(void)
 {
 	/*
 	 * Flush any pre-fetched instructions on all
 	 * CPUs to make the new code visible.
 	 */
 	text_poke_sync_lock();
-	return 0;
 }
 
 #ifdef CONFIG_MODULES
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 1e31c7d21597..73d2719ed12c 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -37,7 +37,7 @@
 
 static int ftrace_poke_late = 0;
 
-int ftrace_arch_code_modify_prepare(void)
+void ftrace_arch_code_modify_prepare(void)
     __acquires(&text_mutex)
 {
 	/*
@@ -47,10 +47,9 @@ int ftrace_arch_code_modify_prepare(void)
 	 */
 	mutex_lock(&text_mutex);
 	ftrace_poke_late = 1;
-	return 0;
 }
 
-int ftrace_arch_code_modify_post_process(void)
+void ftrace_arch_code_modify_post_process(void)
     __releases(&text_mutex)
 {
 	/*
@@ -61,7 +60,6 @@ int ftrace_arch_code_modify_post_process(void)
 	text_poke_finish();
 	ftrace_poke_late = 0;
 	mutex_unlock(&text_mutex);
-	return 0;
 }
 
 static const char *ftrace_nop_replace(void)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 4816b7e11047..a5f74f6e7e4e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -449,8 +449,8 @@ static inline void stack_tracer_enable(void) { }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-int ftrace_arch_code_modify_prepare(void);
-int ftrace_arch_code_modify_post_process(void);
+void ftrace_arch_code_modify_prepare(void);
+void ftrace_arch_code_modify_post_process(void);
 
 enum ftrace_bug_type {
 	FTRACE_BUG_UNKNOWN,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 737e895e2aad..852c731cbd9a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2704,18 +2704,16 @@ ftrace_nop_initialize(struct module *mod, struct dyn_ftrace *rec)
  * archs can override this function if they must do something
  * before the modifying code is performed.
  */
-int __weak ftrace_arch_code_modify_prepare(void)
+void __weak ftrace_arch_code_modify_prepare(void)
 {
-	return 0;
 }
 
 /*
  * archs can override this function if they must do something
  * after the modifying code is performed.
  */
-int __weak ftrace_arch_code_modify_post_process(void)
+void __weak ftrace_arch_code_modify_post_process(void)
 {
-	return 0;
 }
 
 void ftrace_modify_all_code(int command)
@@ -2801,12 +2799,7 @@ void __weak arch_ftrace_update_code(int command)
 
 static void ftrace_run_update_code(int command)
 {
-	int ret;
-
-	ret = ftrace_arch_code_modify_prepare();
-	FTRACE_WARN_ON(ret);
-	if (ret)
-		return;
+	ftrace_arch_code_modify_prepare();
 
 	/*
 	 * By default we use stop_machine() to modify the code.
@@ -2816,8 +2809,7 @@ static void ftrace_run_update_code(int command)
 	 */
 	arch_ftrace_update_code(command);
 
-	ret = ftrace_arch_code_modify_post_process();
-	FTRACE_WARN_ON(ret);
+	ftrace_arch_code_modify_post_process();
 }
 
 static void ftrace_run_modify_code(struct ftrace_ops *ops, int command,
-- 
2.35.1
