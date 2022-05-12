Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C905245D4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350431AbiELGbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350425AbiELGay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:30:54 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E147B7C3;
        Wed, 11 May 2022 23:30:44 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 83DB51E80D04;
        Thu, 12 May 2022 14:25:10 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SAyNUW6O05i9; Thu, 12 May 2022 14:25:07 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4E9E91E80D22;
        Thu, 12 May 2022 14:25:07 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux@armlinux.org.uk,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] kernel: Ftrace seems to have functions to improve performance through optimization
Date:   Thu, 12 May 2022 14:30:17 +0800
Message-Id: <20220512063017.57412-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, it is found that two functions could be optimized, and the
performance may be improved.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
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
index 4f1d2f5e7263..35a899f136fe 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2707,18 +2707,16 @@ ftrace_nop_initialize(struct module *mod, struct dyn_ftrace *rec)
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
@@ -2804,12 +2802,7 @@ void __weak arch_ftrace_update_code(int command)
 
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
@@ -2819,8 +2812,7 @@ static void ftrace_run_update_code(int command)
 	 */
 	arch_ftrace_update_code(command);
 
-	ret = ftrace_arch_code_modify_post_process();
-	FTRACE_WARN_ON(ret);
+	ftrace_arch_code_modify_post_process();
 }
 
 static void ftrace_run_modify_code(struct ftrace_ops *ops, int command,
-- 
2.18.2

