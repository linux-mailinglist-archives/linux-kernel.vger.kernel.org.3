Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1164D29DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiCIH4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiCIH4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567AB164D02;
        Tue,  8 Mar 2022 23:55:01 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812499;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrRfzXMiNTO1Ivbj0UalHDmUZRrd8YsS4YwXuudGaGI=;
        b=avFCjmhAsM3ZbvrmscZj4gSk8zsurnUyboHrpPJYaqdnxfkHP3maogSqMNcEWZc8ajIQxJ
        yXpuZJldOrUUo9PyJ3qpyFg5CNgCpSIVLFgGKm0nt07JBx4JAntfo3boDiABUytWIc9ZdC
        PfrIGhsaQr4cEKc1kpN5+L7bF4OiByeSf+KFpXwUMjURyi/aXrsb4wa+qGoS/Kp9xv6oWu
        zPxYP9rhu5/4jmUe6hEemS7tE7awtRtb6xTNeQVu39oKChGukwQagMR02E87pMTTU2FK3y
        NSSHSAFN0Mbt3NXerS7AR9cpwQ1KliER73kxd9UWFej29yHQxWr2H/T2Xjcyxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812499;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrRfzXMiNTO1Ivbj0UalHDmUZRrd8YsS4YwXuudGaGI=;
        b=s/AJkfU7feG+yDYqd1ODx9U2Ki3uQfIjmNXSRQgamG9FRFlBgXcHXRSQ2O7NE7U0gAHCFG
        WFRxCJeqNV/tJhDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,ftrace: Add ENDBR to samples/ftrace
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.523421433@infradead.org>
References: <20220308154318.523421433@infradead.org>
MIME-Version: 1.0
Message-ID: <164681249889.16921.49890055498398607.tip-bot2@tip-bot2>
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

Commit-ID:     cba7a74a1b138c2b7379c88fbbe7c6b94d5bd180
Gitweb:        https://git.kernel.org/tip/cba7a74a1b138c2b7379c88fbbe7c6b94d5bd180
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:33 +01:00

x86/ibt,ftrace: Add ENDBR to samples/ftrace

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.523421433@infradead.org
---
 samples/ftrace/ftrace-direct-modify.c       |  5 +++++
 samples/ftrace/ftrace-direct-multi-modify.c | 10 +++++++---
 samples/ftrace/ftrace-direct-multi.c        |  5 ++++-
 samples/ftrace/ftrace-direct-too.c          |  3 +++
 samples/ftrace/ftrace-direct.c              |  3 +++
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 2c7c318..39146fa 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -24,20 +24,25 @@ static unsigned long my_ip = (unsigned long)schedule;
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	call my_direct_func1\n"
 "	leave\n"
 "	.size		my_tramp1, .-my_tramp1\n"
 	ASM_RET
+
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	call my_direct_func2\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 6f43a39..65aa94d 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -22,11 +22,14 @@ extern void my_tramp2(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
@@ -34,12 +37,13 @@ asm (
 "	call my_direct_func1\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp1, .-my_tramp1\n"
+
 "	.type		my_tramp2, @function\n"
-"\n"
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
@@ -47,7 +51,7 @@ asm (
 "	call my_direct_func2\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
 );
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 2fafc9a..41ded7c 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -17,11 +17,14 @@ extern void my_tramp(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
@@ -29,7 +32,7 @@ asm (
 "	call my_direct_func\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index c93fb0e..6690468 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -19,11 +19,14 @@ extern void my_tramp(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 8b551e5..e8f1e44 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -16,11 +16,14 @@ extern void my_tramp(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
