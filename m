Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799D157C6D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiGUIwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiGUIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:52:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8578B62A5C;
        Thu, 21 Jul 2022 01:52:03 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:52:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658393522;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/5wZ+MtEyeurMIzj9L3QrvkOyWzl+x+6Bpcv+IWBN8=;
        b=IN2Spu0QIkH/ib3nJPI2l8dm39XuJFGg+FAi1vuMLvVwksK0Bh4cQ0WZ/jgCL6nXDEucP1
        gqrRqV7YGrjg58Ei4tEDFs34Zgzz9FRxnehPqcH4Ejl34DdPbMsOiR1/IJRk9+ae+OCcBX
        ZftMdRwdtWJFONF22iV4BPo/tW92TqUNxesA0QZOseD4zYrpfEO55zL4TnxxqUbV5yi4VT
        D2Uqupg33whioQAApqwoO4NE6Hp/usayAi8YH3pTfVrIqjFLsJQl+TGCiz30qNQNREjyeU
        73wnG11U5WsXp6boMH6K2qb4kzOz+vdcEEWImOVuqO3vqTnDQkNN7jWDbhP32w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658393522;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/5wZ+MtEyeurMIzj9L3QrvkOyWzl+x+6Bpcv+IWBN8=;
        b=DOY+7LuNGhPFvroxt3sNbrQ0cSP8Oid56wfoax76YlbQBUrl3o7Pen1DL2tP3ViRp5ZvGm
        6GBIfTS3DKll0GBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/extable: Fix ex_handler_msr() print condition
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YqyVFsbviKjVGGZ9@worktop.programming.kicks-ass.net>
References: <YqyVFsbviKjVGGZ9@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165839352078.15455.154258296152260339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a1a5482a2c6e38a3ebed32e571625c56a8cc41a6
Gitweb:        https://git.kernel.org/tip/a1a5482a2c6e38a3ebed32e571625c56a8cc41a6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 17 Jun 2022 16:52:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Jul 2022 10:39:42 +02:00

x86/extable: Fix ex_handler_msr() print condition

On Fri, Jun 17, 2022 at 02:08:52PM +0300, Stephane Eranian wrote:
> Some changes to the way invalid MSR accesses are reported by the
> kernel is causing some problems with messages printed on the
> console.
>
> We have seen several cases of ex_handler_msr() printing invalid MSR
> accesses once but the callstack multiple times causing confusion on
> the console.

> The problem here is that another earlier commit (5.13):
>
> a358f40600b3 ("once: implement DO_ONCE_LITE for non-fast-path "do once" functionality")
>
> Modifies all the pr_*_once() calls to always return true claiming
> that no caller is ever checking the return value of the functions.
>
> This is why we are seeing the callstack printed without the
> associated printk() msg.

Extract the ONCE_IF(cond) part into __ONCE_LTE_IF() and use that to
implement DO_ONCE_LITE_IF() and fix the extable code.

Fixes: a358f40600b3 ("once: implement DO_ONCE_LITE for non-fast-path "do once" functionality")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/r/YqyVFsbviKjVGGZ9@worktop.programming.kicks-ass.net
---
 arch/x86/mm/extable.c     | 16 +++++++++-------
 include/linux/once_lite.h | 20 ++++++++++++++++----
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index dba2197..331310c 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -94,16 +94,18 @@ static bool ex_handler_copy(const struct exception_table_entry *fixup,
 static bool ex_handler_msr(const struct exception_table_entry *fixup,
 			   struct pt_regs *regs, bool wrmsr, bool safe, int reg)
 {
-	if (!safe && wrmsr &&
-	    pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
-			 (unsigned int)regs->cx, (unsigned int)regs->dx,
-			 (unsigned int)regs->ax,  regs->ip, (void *)regs->ip))
+	if (__ONCE_LITE_IF(!safe && wrmsr)) {
+		pr_warn("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
+			(unsigned int)regs->cx, (unsigned int)regs->dx,
+			(unsigned int)regs->ax,  regs->ip, (void *)regs->ip);
 		show_stack_regs(regs);
+	}
 
-	if (!safe && !wrmsr &&
-	    pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
-			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
+	if (__ONCE_LITE_IF(!safe && !wrmsr)) {
+		pr_warn("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
+			(unsigned int)regs->cx, regs->ip, (void *)regs->ip);
 		show_stack_regs(regs);
+	}
 
 	if (!wrmsr) {
 		/* Pretend that the read succeeded and returned 0. */
diff --git a/include/linux/once_lite.h b/include/linux/once_lite.h
index 861e606..b7bce49 100644
--- a/include/linux/once_lite.h
+++ b/include/linux/once_lite.h
@@ -9,15 +9,27 @@
  */
 #define DO_ONCE_LITE(func, ...)						\
 	DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
-#define DO_ONCE_LITE_IF(condition, func, ...)				\
+
+#define __ONCE_LITE_IF(condition)					\
 	({								\
 		static bool __section(".data.once") __already_done;	\
-		bool __ret_do_once = !!(condition);			\
+		bool __ret_cond = !!(condition);			\
+		bool __ret_once = false;				\
 									\
-		if (unlikely(__ret_do_once && !__already_done)) {	\
+		if (unlikely(__ret_cond && !__already_done)) {		\
 			__already_done = true;				\
-			func(__VA_ARGS__);				\
+			__ret_once = true;				\
 		}							\
+		unlikely(__ret_once);					\
+	})
+
+#define DO_ONCE_LITE_IF(condition, func, ...)				\
+	({								\
+		bool __ret_do_once = !!(condition);			\
+									\
+		if (__ONCE_LITE_IF(__ret_do_once))			\
+			func(__VA_ARGS__);				\
+									\
 		unlikely(__ret_do_once);				\
 	})
 
