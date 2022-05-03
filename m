Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABD7518CC8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbiECTEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbiECTEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:04:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9412B269;
        Tue,  3 May 2022 12:01:06 -0700 (PDT)
Date:   Tue, 03 May 2022 19:01:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651604465;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMzq850vNfHhv+MvNguNCyeAr1+CeQZ1FuzBSbLtguk=;
        b=g7EfAS++xoY5/xdPL2MUqi5CXf2mAFbuQgaqXsSNqpcDq2K2hWlNMu+VWSUVQdJrnpK2dn
        bIm8MNvFQ5lFrNs/P/UI4j4xWGSldsbcyscXogFNSuk6TkCH+VDlkY/Quj+z3iamgkMx/j
        oYP+CwXtIyfthwdliFo6FxPzPlQFrJAnwuvALFqyRJgpGFrQ7xoxT0RqIfyWCtmQbyzTo5
        y+/LPz2hyv1pxwzjMg3mr+mU7aNxIY/KIsgikzSYY0Mo5fGhl0RPtrqmbBLc3BfmtuKLJk
        py5oU/+ms0QOCYx8J4W4unAvMurWdnhlmPh8K+ek4QpEi4cWaH5sYy+gl9gOew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651604465;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMzq850vNfHhv+MvNguNCyeAr1+CeQZ1FuzBSbLtguk=;
        b=gr0CKgfDfwUR8cBsLraVBvHUF4v5gpvPDIK297EvZs5Ias+5W2uccTppcks+YiWzmyyMS4
        4CPOMshyEgtvOdCg==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Move CLD to the start of the idtentry macro
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220503032107.680190-5-jiangshanlai@gmail.com>
References: <20220503032107.680190-5-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <165160446427.4207.18135528397275142825.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     c64cc2802a784ecfd25d39945e57e7a147854a5b
Gitweb:        https://git.kernel.org/tip/c64cc2802a784ecfd25d39945e57e7a147854a5b
Author:        Lai Jiangshan <jiangshan.ljs@antgroup.com>
AuthorDate:    Thu, 21 Apr 2022 22:10:51 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 03 May 2022 12:17:16 +02:00

x86/entry: Move CLD to the start of the idtentry macro

Move it after CLAC.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220503032107.680190-5-jiangshanlai@gmail.com
---
 arch/x86/entry/entry_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b1cef3b..ab6ab6d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -371,6 +371,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ENDBR
 	ASM_CLAC
+	cld
 
 	.if \has_error_code == 0
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -439,6 +440,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
+	cld
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
@@ -495,6 +497,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
+	cld
 
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
@@ -557,6 +560,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ENDBR
 	ASM_CLAC
+	cld
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
@@ -882,7 +886,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -1000,7 +1003,6 @@ SYM_CODE_END(paranoid_exit)
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
-	cld
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1134,6 +1136,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	ASM_CLAC
+	cld
 
 	/* Use %rdx as our temp variable throughout */
 	pushq	%rdx
@@ -1153,7 +1156,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	swapgs
-	cld
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
