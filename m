Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4404D63EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbiCKOms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346607AbiCKOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:42:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E18CDBF;
        Fri, 11 Mar 2022 06:40:58 -0800 (PST)
Date:   Fri, 11 Mar 2022 14:40:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647009657;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d31r8wTn8h3Sl16eJtem9/DzCXEnrJZYgsbgAyz5g0M=;
        b=JqSJtnkgkbjOIO9yScpX07mC6JY6mRkfFHoCyFKdra20jradN1y2X14ysHd0gOcpP04lP+
        QFdD4f8HCuSBB58LnJyJ5kBC+8+VYmD6B/fz1HB1aL0BNY9yUm+1kVZPSOKLHTnbnaT8nH
        D5zXB02ATGmUYPGg0mIOF4U412vS5shMVADzX09ce2cyPjKOUyQLoAQwCJdeOX2AvwLFNm
        aeSfLW/9EYdqrwyraBj6aGWP/ZbcHy0i7pRwqKUMZz7VX5H6ypW0VjRvK5KK17KWHvdwiv
        ggyXxwyRYxpBcH4aQf0RAS0Ley1Y6Faw/UAVdgX7zWcGdJooJ8L5k81LMoASzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647009657;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d31r8wTn8h3Sl16eJtem9/DzCXEnrJZYgsbgAyz5g0M=;
        b=/1ewpK7i9vAF7LrR8bPHYqSvxcNmHm6GxTBwS5NImT7QHpC3NK0G3nrHZ0Dm+nGCLU9gYE
        GN0ChRpjqUbia/Dw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Fix {int3,ibt}_selftest() vs LTO
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        David Laight <David.Laight@aculab.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YinP49gEl2zUVekz@hirez.programming.kicks-ass.net>
References: <YinP49gEl2zUVekz@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164700965635.16921.2130693129403753558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c7d90e15b8950009d0d4e8f3503b09b2ea6d527c
Gitweb:        https://git.kernel.org/tip/c7d90e15b8950009d0d4e8f3503b09b2ea6d527c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Mar 2022 11:16:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Mar 2022 13:05:08 +01:00

x86: Fix {int3,ibt}_selftest() vs LTO

Both these selftests define a symbol in inline asm which goes
side-ways if the asm gets duplicated due to inlining. Nick actually
saw this happen with a Clang LTO build.

Mark the two selftests noinline to ensure this cannot happen, as
suggestd by David.

While there, update the comment for int3_selftest() and increase coding
style consistency between the two.

Fixes: 103c0093ceb6 ("x86/ibt: Add IBT feature, MSR and #CP handling")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: David Laight <David.Laight@aculab.com>,
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com> # llvm build, non-IBT boot
Link: https://lkml.kernel.org/r/YinP49gEl2zUVekz@hirez.programming.kicks-ass.net
---
 arch/x86/kernel/alternative.c | 8 ++++----
 arch/x86/kernel/traps.c       | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d6c41f8..820c43a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -781,7 +781,8 @@ int3_exception_notify(struct notifier_block *self, unsigned long val, void *data
 	return NOTIFY_STOP;
 }
 
-static void __init int3_selftest(void)
+/* Must be noinline to ensure uniqueness of int3_selftest_ip. */
+static noinline void __init int3_selftest(void)
 {
 	static __initdata struct notifier_block int3_exception_nb = {
 		.notifier_call	= int3_exception_notify,
@@ -794,9 +795,8 @@ static void __init int3_selftest(void)
 	/*
 	 * Basically: int3_magic(&val); but really complicated :-)
 	 *
-	 * Stick the address of the INT3 instruction into int3_selftest_ip,
-	 * then trigger the INT3, padded with NOPs to match a CALL instruction
-	 * length.
+	 * INT3 padded with NOP to CALL_INSN_SIZE. The int3_exception_nb
+	 * notifier above will emulate CALL for us.
 	 */
 	asm volatile ("int3_selftest_ip:\n\t"
 		      ANNOTATE_NOENDBR
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 89fb299..755c23b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -213,7 +213,7 @@ DEFINE_IDTENTRY(exc_overflow)
 
 static __ro_after_init bool ibt_fatal = true;
 
-void ibt_selftest_ip(void); /* code label defined in asm below */
+extern void ibt_selftest_ip(void); /* code label defined in asm below */
 
 enum cp_error_code {
 	CP_EC        = (1 << 15) - 1,
@@ -237,7 +237,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
 	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
 		return;
 
-	if (unlikely(regs->ip == (unsigned long)ibt_selftest_ip)) {
+	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
 		regs->ax = 0;
 		return;
 	}
@@ -251,7 +251,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
 	BUG();
 }
 
-bool ibt_selftest(void)
+/* Must be noinline to ensure uniqueness of ibt_selftest_ip. */
+noinline bool ibt_selftest(void)
 {
 	unsigned long ret;
 
