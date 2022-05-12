Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B95524C59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353524AbiELMEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346106AbiELMEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:04:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E24822A89A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:04:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652357049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mBUFGiwJrTupzlyljDPpfU9QdnVzlS3VBS2Q9muwb4=;
        b=WPPkmJKhE4369rT9PVqD/phY8cS+3TRzv1xhZDd6rdskxCpWj0riQlPPw1WsN8R42bRCDI
        J62tdUvjW9dGk+yhVBu7qP8Kr5fiBhiNAt6YBT/J4nuFRs8A6vGbeOjRQ1dfkwg5xo1PuZ
        5P7YrVAIdJe8aL+VTzejC0U4FkDyseKU7E2FyNKlKMF6Nr1wHsr4IB4Aiu/uF6AfJx4NHT
        XxjXxamJY/eC7vhU3MgIukrPOz+0yHdOZk2LDyWKMxfRHvr3FdHuo3pYhvH4UTr4Yu18BS
        H2RlDw4WcU+caYSGXT1QWuxXMPNXjYdqCPeGX9zBzYxzpXy6ldyXaZYShTNEKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652357049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mBUFGiwJrTupzlyljDPpfU9QdnVzlS3VBS2Q9muwb4=;
        b=Q9qpJEdA4CL7lj+p+j+jAPa2XYo6ZageQ6B7mN55RjjFN4fEoL5OmvBvekPtxxBRmFrxLv
        7dnfLtIm24AEGWBQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J. Lu" <hjl.tools@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/prctl: Remove pointless task argument
In-Reply-To: <87o803vtzp.ffs@tglx>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
 <87o803vtzp.ffs@tglx>
Date:   Thu, 12 May 2022 14:04:08 +0200
Message-ID: <87lev7vtxj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions invoked via do_arch_prctl_common() can only operate on
the current task and none of these function uses the task argument.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/api.h |    3 +--
 arch/x86/include/asm/proto.h   |    3 +--
 arch/x86/kernel/fpu/xstate.c   |    5 +----
 arch/x86/kernel/process.c      |    9 ++++-----
 arch/x86/kernel/process_32.c   |    2 +-
 arch/x86/kernel/process_64.c   |    4 ++--
 6 files changed, 10 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -162,7 +162,6 @@ static inline bool fpstate_is_confidenti
 }
 
 /* prctl */
-struct task_struct;
-extern long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2);
+extern long fpu_xstate_prctl(int option, unsigned long arg2);
 
 #endif /* _ASM_X86_FPU_API_H */
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -38,7 +38,6 @@ void x86_configure_nx(void);
 
 extern int reboot_force;
 
-long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long arg2);
+long do_arch_prctl_common(int option, unsigned long arg2);
 
 #endif /* _ASM_X86_PROTO_H */
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1705,16 +1705,13 @@ EXPORT_SYMBOL_GPL(xstate_get_guest_group
  * e.g. for AMX which requires XFEATURE_XTILE_CFG(17) and
  * XFEATURE_XTILE_DATA(18) this would be XFEATURE_XTILE_DATA(18).
  */
-long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2)
+long fpu_xstate_prctl(int option, unsigned long arg2)
 {
 	u64 __user *uptr = (u64 __user *)arg2;
 	u64 permitted, supported;
 	unsigned long idx = arg2;
 	bool guest = false;
 
-	if (tsk != current)
-		return -EPERM;
-
 	switch (option) {
 	case ARCH_GET_XCOMP_SUPP:
 		supported = fpu_user_cfg.max_features |	fpu_user_cfg.legacy_features;
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -332,7 +332,7 @@ static int get_cpuid_mode(void)
 	return !test_thread_flag(TIF_NOCPUID);
 }
 
-static int set_cpuid_mode(struct task_struct *task, unsigned long cpuid_enabled)
+static int set_cpuid_mode(unsigned long cpuid_enabled)
 {
 	if (!boot_cpu_has(X86_FEATURE_CPUID_FAULT))
 		return -ENODEV;
@@ -983,20 +983,19 @@ unsigned long __get_wchan(struct task_st
 	return addr;
 }
 
-long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long arg2)
+long do_arch_prctl_common(int option, unsigned long arg2)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
-		return set_cpuid_mode(task, arg2);
+		return set_cpuid_mode(arg2);
 	case ARCH_GET_XCOMP_SUPP:
 	case ARCH_GET_XCOMP_PERM:
 	case ARCH_REQ_XCOMP_PERM:
 	case ARCH_GET_XCOMP_GUEST_PERM:
 	case ARCH_REQ_XCOMP_GUEST_PERM:
-		return fpu_xstate_prctl(task, option, arg2);
+		return fpu_xstate_prctl(option, arg2);
 	}
 
 	return -EINVAL;
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -219,5 +219,5 @@ EXPORT_SYMBOL_GPL(start_thread);
 
 SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
-	return do_arch_prctl_common(current, option, arg2);
+	return do_arch_prctl_common(option, arg2);
 }
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -844,7 +844,7 @@ SYSCALL_DEFINE2(arch_prctl, int, option,
 
 	ret = do_arch_prctl_64(current, option, arg2);
 	if (ret == -EINVAL)
-		ret = do_arch_prctl_common(current, option, arg2);
+		ret = do_arch_prctl_common(option, arg2);
 
 	return ret;
 }
@@ -852,7 +852,7 @@ SYSCALL_DEFINE2(arch_prctl, int, option,
 #ifdef CONFIG_IA32_EMULATION
 COMPAT_SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
-	return do_arch_prctl_common(current, option, arg2);
+	return do_arch_prctl_common(option, arg2);
 }
 #endif
 
