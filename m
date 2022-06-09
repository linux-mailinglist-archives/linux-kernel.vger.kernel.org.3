Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E228544316
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiFIFX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiFIFXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:23:55 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFA902BDC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:23:53 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7FED21E80D77;
        Thu,  9 Jun 2022 13:23:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jCP6kaEhXpd7; Thu,  9 Jun 2022 13:23:15 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B11D01E80D16;
        Thu,  9 Jun 2022 13:23:15 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     luto@kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] x86: fpu_clone function is changed to return type void
Date:   Thu,  9 Jun 2022 13:23:42 +0800
Message-Id: <20220609052342.1088435-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is used to reduce the number of eax calls, improve the execution
efficiency, and use the same return type as fpu__drop and other
functions.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/x86/include/asm/fpu/sched.h | 2 +-
 arch/x86/kernel/fpu/core.c       | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index b2486b2cbc6e..ca29fd8550ed 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -11,7 +11,7 @@
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 extern void fpu__drop(struct fpu *fpu);
-extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal);
+extern void  fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal);
 extern void fpu_flush_thread(void);
 
 /*
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 0531d6a06df5..416dcdba992a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -556,7 +556,7 @@ static inline void fpu_inherit_perms(struct fpu *dst_fpu)
 }
 
 /* Clone current's FPU state on fork */
-int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
+void fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
 {
 	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
@@ -567,7 +567,7 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
 	fpstate_reset(dst_fpu);
 
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
-		return 0;
+		return;
 
 	/*
 	 * Enforce reload for user space tasks and prevent kernel threads
@@ -583,7 +583,7 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
 		/* Clear out the minimal state */
 		memcpy(&dst_fpu->fpstate->regs, &init_fpstate.regs,
 		       init_fpstate_copy_size());
-		return 0;
+		return;
 	}
 
 	/*
@@ -618,8 +618,6 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
 
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
-
-	return 0;
 }
 
 /*
-- 
2.18.2

