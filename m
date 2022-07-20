Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E7A57B7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiGTNo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGTNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:44:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E2056B94
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l5j/XUYVJV6TzECVxoFZvugNE6eLacXjE6R0TC4Xphc=; b=Y6gFdpVOD4RZ4eeS/V3NhKMoj4
        Fj3T1FF8cKMNTykO1VNn0+uXJQiOaRxP6U5w5Tq61kCTbaeaKCsmyen5rQtSDmovtuikALa/OV8zu
        hFPjgUVJHHlkvAYZhWWqDPYOuUdl7WqxgXE7leesb35cJDzLdwDdU5SEbI1DiW4VXIewGijLB3dUk
        nV/kggbFgEHJK0/wcQlxIBHL0MsM+I5mgyDxzTg0S+EftlnjWnOGIjukCCZW/vtZ5c5mRmkYeZhTP
        h7Wg1pUnY9sJhR0+mVpv0Tyew1imcuk2vnVvTsENaQ8RZNCcl0ShrNbJEE7nweGRl8kA5L5SRkv5o
        s7yQtnQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEA0K-005Kip-0v; Wed, 20 Jul 2022 13:44:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4911A980BBE; Wed, 20 Jul 2022 15:44:43 +0200 (CEST)
Date:   Wed, 20 Jul 2022 15:44:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, jpoimboe@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>, tannerlove@google.com,
        maheshb@google.com
Subject: [PATCH] x86/extable: Fix ex_handler_msr() print condition
Message-ID: <YtgGy7nX/Yly6F5c@worktop.programming.kicks-ass.net>
References: <CABPqkBRVF9qmxKFgmjZpzN3tx=U+_8udECMLHs7BrtzfPwmuhQ@mail.gmail.com>
 <YqyVFsbviKjVGGZ9@worktop.programming.kicks-ass.net>
 <CABPqkBRRFhPcYL25TX6H7vWN=VKNR2+8e2_sO01Pka_R625Lqw@mail.gmail.com>
 <CABPqkBSsTEGdBEqDgBXYAKWh1UpvUDYSXRpDD1KSm+JWV2eAUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSsTEGdBEqDgBXYAKWh1UpvUDYSXRpDD1KSm+JWV2eAUw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 03:48:56PM +0300, Stephane Eranian wrote:

> Tested-by: Stephane Eranian <eranian@google.com>

Thanks, I'll queue the below.

---
Subject: x86/extable: Fix ex_handler_msr() print condition
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 17 Jun 2022 16:52:06 +0200

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
 arch/x86/mm/extable.c     |   16 +++++++++-------
 include/linux/once_lite.h |   20 ++++++++++++++++----
 2 files changed, 25 insertions(+), 11 deletions(-)

--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -94,16 +94,18 @@ static bool ex_handler_copy(const struct
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
 
