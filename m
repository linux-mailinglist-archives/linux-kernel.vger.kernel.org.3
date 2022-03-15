Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276BB4D993C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347353AbiCOKqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347266AbiCOKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FB833E05;
        Tue, 15 Mar 2022 03:43:50 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wSbh0Isr6f6GhNiCHqlwTTKpJ3n6qCgbiX3p6rE8r8=;
        b=C4ZmKleIMtXo3G5NP5xreM+KEc+EM2lUtWVYoM/0alHuvc4ykqRxLD3A0tcTpryb/m4aUi
        ZqtR3JSCipAlekW6Q5CsHvTvU7N4rA2WRvaJc+iuqSHi3h3NMy/34cOVOdVdWmPt2bVXEJ
        iDD9eWj7PDM3O+kbBSmnYHSijPL6H1qve2XKI+o7lG0oXBQd22h46o2VTCR8C1+SypKxQ/
        ZRFCm7ZwZe6zjOFpJ3L5ElRfK7m3taI4MxnKQxqFU4W8VBOpstEZK1BDCJBACkGrYXCplx
        PkxwLVofDJXKN2LsaBFQOQBsooRJzUybMK6aJZ3iIsjgmsjjeUjIYJMN0sETXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wSbh0Isr6f6GhNiCHqlwTTKpJ3n6qCgbiX3p6rE8r8=;
        b=Aep2PmT1mmh6bccUvACcFaWKUTWn0Jwjab7tJtRiE7dy88gBSTeaMvCQ1tzzjagevi4+b7
        eEHbqOCUt5k4rFBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Mark __invalid_creds() __noreturn
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Yi9gOW9f1GGwwUD6@hirez.programming.kicks-ass.net>
References: <Yi9gOW9f1GGwwUD6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164734102762.16921.16778856567952494696.tip-bot2@tip-bot2>
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

Commit-ID:     105cd68596392cfe15056a891b0723609dcad247
Gitweb:        https://git.kernel.org/tip/105cd68596392cfe15056a891b0723609dcad247
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Mar 2022 17:58:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:44 +01:00

x86: Mark __invalid_creds() __noreturn

vmlinux.o: warning: objtool: ksys_unshare()+0x36c: unreachable instruction

0000 0000000000067040 <ksys_unshare>:
...
0364    673a4:	4c 89 ef             	mov    %r13,%rdi
0367    673a7:	e8 00 00 00 00       	call   673ac <ksys_unshare+0x36c>	673a8: R_X86_64_PLT32	__invalid_creds-0x4
036c    673ac:	e9 28 ff ff ff       	jmp    672d9 <ksys_unshare+0x299>
0371    673b1:	41 bc f4 ff ff ff    	mov    $0xfffffff4,%r12d
0377    673b7:	e9 80 fd ff ff       	jmp    6713c <ksys_unshare+0xfc>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Yi9gOW9f1GGwwUD6@hirez.programming.kicks-ass.net
---
 include/linux/cred.h  | 2 +-
 kernel/cred.c         | 2 +-
 tools/objtool/check.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index fcbc688..9ed9232 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -176,7 +176,7 @@ extern int set_cred_ucounts(struct cred *);
  * check for validity of credentials
  */
 #ifdef CONFIG_DEBUG_CREDENTIALS
-extern void __invalid_creds(const struct cred *, const char *, unsigned);
+extern void __noreturn __invalid_creds(const struct cred *, const char *, unsigned);
 extern void __validate_process_creds(struct task_struct *,
 				     const char *, unsigned);
 
diff --git a/kernel/cred.c b/kernel/cred.c
index 933155c..e10c15f 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -870,7 +870,7 @@ static void dump_invalid_creds(const struct cred *cred, const char *label,
 /*
  * report use of invalid credentials
  */
-void __invalid_creds(const struct cred *cred, const char *file, unsigned line)
+void __noreturn __invalid_creds(const struct cred *cred, const char *file, unsigned line)
 {
 	printk(KERN_ERR "CRED: Invalid credentials\n");
 	printk(KERN_ERR "CRED: At %s:%u\n", file, line);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9896562..0c857e7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -183,6 +183,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"cpu_bringup_and_idle",
 		"do_group_exit",
 		"stop_this_cpu",
+		"__invalid_creds",
 	};
 
 	if (!func)
