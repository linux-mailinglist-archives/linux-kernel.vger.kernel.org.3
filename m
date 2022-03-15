Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06A74D993B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347493AbiCOKrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347300AbiCOKpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1336331;
        Tue, 15 Mar 2022 03:43:59 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341037;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fG5GG4La4zUUGgDWhcXGVC5Xs1nNxZkXXfVuJN5yqM=;
        b=kxUbrQTSMXFv3a1kq3Unn9YNvKcRKGuntctye1UNti3dYOH8vn4VNUPzfs2NHYQAi0dBRw
        zBWvzzdls1+d2VlWntdCABSJfcn2RV/CRur7caj3jtoYEXaq77TEU+l9OPM4dYqu0u5DhG
        BiqHTKujA7tvQSjpxbsDvXZjHFd4CHkl4XmzO23O2YUOfP0cbIST8948LhYeasTk5c0ZG6
        Uxj3fZuNxF/Edr5kR5yaJvpV3c+V4nneSdgJw+Xg+ud1Om6kIgO7TxC22PgWdi+3iE52P+
        blpP+W3aVBAf+npLgDMcC6+vGYm8hq/x0sru98jVllfrmeUPyCY/DDi9Xdw1tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341037;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fG5GG4La4zUUGgDWhcXGVC5Xs1nNxZkXXfVuJN5yqM=;
        b=5THxSxk4TeL4rOF+Gt6cYxYlUYoz2HVlkJyDTVHEnPP0QbW24m+HE8fD9XXDqKOIdCFS8Q
        GhwLeZjtwdG6bXBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternative: Simplify int3_selftest_ip
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.700456643@infradead.org>
References: <20220308154318.700456643@infradead.org>
MIME-Version: 1.0
Message-ID: <164734103676.16921.14487033480420940559.tip-bot2@tip-bot2>
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

Commit-ID:     99c95c5d4f1027130d555fdb27b576520894827d
Gitweb:        https://git.kernel.org/tip/99c95c5d4f1027130d555fdb27b576520894827d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:40 +01:00

x86/alternative: Simplify int3_selftest_ip

Similar to ibt_selftest_ip, apply the same pattern.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.700456643@infradead.org
---
 arch/x86/kernel/alternative.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b4470ea..14d1003 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -719,7 +719,7 @@ asm (
 "	.popsection\n"
 );
 
-extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
+extern void int3_selftest_ip(void); /* defined in asm below */
 
 static int __init
 int3_exception_notify(struct notifier_block *self, unsigned long val, void *data)
@@ -733,14 +733,15 @@ int3_exception_notify(struct notifier_block *self, unsigned long val, void *data
 	if (val != DIE_INT3)
 		return NOTIFY_DONE;
 
-	if (regs->ip - INT3_INSN_SIZE != int3_selftest_ip)
+	if (regs->ip - INT3_INSN_SIZE != (unsigned long)&int3_selftest_ip)
 		return NOTIFY_DONE;
 
 	int3_emulate_call(regs, (unsigned long)&int3_magic);
 	return NOTIFY_STOP;
 }
 
-static void __init int3_selftest(void)
+/* Must be noinline to ensure uniqueness of int3_selftest_ip. */
+static noinline void __init int3_selftest(void)
 {
 	static __initdata struct notifier_block int3_exception_nb = {
 		.notifier_call	= int3_exception_notify,
@@ -753,18 +754,10 @@ static void __init int3_selftest(void)
 	/*
 	 * Basically: int3_magic(&val); but really complicated :-)
 	 *
-	 * Stick the address of the INT3 instruction into int3_selftest_ip,
-	 * then trigger the INT3, padded with NOPs to match a CALL instruction
-	 * length.
+	 * INT3 padded with NOP to CALL_INSN_SIZE. The int3_exception_nb
+	 * notifier above will emulate CALL for us.
 	 */
-	asm volatile ("1: int3; nop; nop; nop; nop\n\t"
-		      ".pushsection .init.data,\"aw\"\n\t"
-		      ".align " __ASM_SEL(4, 8) "\n\t"
-		      ".type int3_selftest_ip, @object\n\t"
-		      ".size int3_selftest_ip, " __ASM_SEL(4, 8) "\n\t"
-		      "int3_selftest_ip:\n\t"
-		      __ASM_SEL(.long, .quad) " 1b\n\t"
-		      ".popsection\n\t"
+	asm volatile ("int3_selftest_ip: int3; nop; nop; nop; nop\n\t"
 		      : ASM_CALL_CONSTRAINT
 		      : __ASM_SEL_RAW(a, D) (&val)
 		      : "memory");
