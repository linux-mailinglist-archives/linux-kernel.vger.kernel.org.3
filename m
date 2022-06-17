Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82D54F9AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382884AbiFQOwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382593AbiFQOwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:52:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445ED41611
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G4AnqWACppeg9bBHgdGkT1GET6BfWkp9HpS86zAfg54=; b=NsP6V3fPC0mZxJhJCiW9GMp3pu
        TQ9/d5W4gWOpsVhUFeILg/vHYralItAh5fIHvMmabefmn3eVIjaCTF7JR6iSU8U1tJkC55N5GdSyS
        Gfc2VjCELKnLxmJd6I188QkdZ8zsBs9Ldqdyk42THEm2TolzYGRFhAmRBHqjOBIm3osrQ5J6FvcbG
        taUNClZ2d2VOubVbkA/XxJZoJTmHUihaofPmRedqkopZ6DAMzlWV3y8bvQKIapV0ituwL5Jsmxjau
        jVRcI26pFAEFsMRUgVToi9TSmUabKF0L5FnlASIa0VG8HF9HCvvwrn8Nlzlk8o0ieNLtA8yFYhQo5
        ztMCLTUg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2DKS-008iO0-TS; Fri, 17 Jun 2022 14:52:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F93E9816B5; Fri, 17 Jun 2022 16:52:06 +0200 (CEST)
Date:   Fri, 17 Jun 2022 16:52:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, jpoimboe@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] pr_warn_once() issue in x86 MSR extable code
Message-ID: <YqyVFsbviKjVGGZ9@worktop.programming.kicks-ass.net>
References: <CABPqkBRVF9qmxKFgmjZpzN3tx=U+_8udECMLHs7BrtzfPwmuhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRVF9qmxKFgmjZpzN3tx=U+_8udECMLHs7BrtzfPwmuhQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 02:08:52PM +0300, Stephane Eranian wrote:
> Hi,
> 
> Some changes to the way invalid MSR accesses are reported by the kernel is
> causing some problems with messages printed on the console.
> 
> We have seen several cases of ex_handler_msr() printing invalid MSR
> accesses once but
> the callstack multiple times causing confusion on the console.
> 
> The last time the exception MSR code was modified (5.16) by PeterZ was:
> 
>   d52a7344bdfa x86/msr: Remove .fixup usage:
> 
>   if (!safe && wrmsr &&  pr_warn_once("unchecked MSR access error: ..."))
>                show_stack_regs(regs);
> 
> Note that this code pattern was also present, though in a different
> form, before this commit.
> 
> The problem here is that another earlier commit (5.13):
> 
> a358f40600b3 once: implement DO_ONCE_LITE for non-fast-path "do once"
> functionality
> 
> Modifies all the pr_*_once() calls to always return true claiming that
> no caller is ever
> checking the return value of the functions.
> 
> This is why we are seeing the callstack printed without the associated
> printk() msg.
> 
> I believe that having the pr_*_once() functions return true the first
> time they are called
> is useful especially when extra information, such as callstack, must
> be printed to help
> track the origin of the problem.
> 
> The exception handling code seems to be the only place where the
> return value is checked
> for pr_warn_once(). A minimal change would be to create another
> version of that function
> that calls DO_ONCE() instead of DO_ONCE_LITE(), e.g., pr_warn_once_return().
> 
> I can post a patch to that effect if we all agree on the approach.
> 
> Thanks.

How about something like this?

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index dba2197c05c3..331310c29349 100644
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
index 861e606b820f..63c3bbcef694 100644
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
 		if (unlikely(__ret_do_once && !__already_done)) {	\
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
 
