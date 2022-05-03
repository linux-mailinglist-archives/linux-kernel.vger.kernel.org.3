Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F1517C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiECDYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiECDYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:24:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7331222
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:20:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a11so13769498pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 20:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWDAJ1Qy8kTssfxxRg0WHjshQinm3EhF18pt1sufO9Y=;
        b=TAiC/zyrxBX9SqMU1DDy9Sxt5L4RS6IA7H2pvjursJmu3PEHSSd56aFVd+t86iGmQa
         N6XZwDIvfh1L0g6HcPLcXnsH/pu3o1aBSudWxGcQsgdSK7hoK8H7+SHad2QSnwnv/Ory
         aNmUC9J6G9Ejnf+HKD+YqB7UW3iXTOmjnjSCWhvoXYbuFx4g9JeRR4gEZBEDpwKeCCMu
         wVa+uSEOF4L87F0FSKkP/Kjh8XU/jUA8yBy1SZaFWZTyx26/qjxPdc4wdJKO52WKb2lj
         XzTrI3BE7evc4oxnB6l8cVjv9QODG4bl5ONcR8CA1Ze1Y1s0g9w0C0PDKPkLdCYzxmKC
         VUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWDAJ1Qy8kTssfxxRg0WHjshQinm3EhF18pt1sufO9Y=;
        b=IBFePCwCnG5vCsjgiYAcyHpg6qr0k6Yudl3+3rihViqWlIbc+5TDfsX0e3MenqO1CS
         z0RduGIBCgkYzyEnYeRngOs8eawVbTONreWIGHG0c9JHmnkoJrfM6GANxmncHlmC2hAU
         w2c5GP0qSX3CvJYSHElGqMHOdd5twvByieOZR+KD8i7wX2O/rYv4WGqtDb20sbUHLXQg
         DH3GYmfwcD8FoMimG+mT/QnNADzHtH2AqG/UwdwZO9qG1UpFyFgyE4rbGIzTlol0IKfP
         wGjMrSgUUtRBfb1Ze0kQ6QZ2tEY1hoxg6VOzzOJqpmi4djdm3FvS0zB1u4Blq2zTrkQ3
         u2Dg==
X-Gm-Message-State: AOAM531YNUKm2O2mhdnpCweS1jKTDnQwZvRlyGrPxokDILr/x73NAwbN
        pt6Y2Csa2+T1wJ+BCxUTehKhrU+2GWM=
X-Google-Smtp-Source: ABdhPJzn2FwJe7lQZYHbqR8cUASuvRxAE09Hn9KskTR7Rk4WW2OZ5y/YN10qgZcW8du284vM7/NffQ==
X-Received: by 2002:a65:6955:0:b0:380:64fd:a2dd with SMTP id w21-20020a656955000000b0038064fda2ddmr11930352pgq.383.1651548045134;
        Mon, 02 May 2022 20:20:45 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902edc300b0015e8d4eb269sm5374266plk.179.2022.05.02.20.20.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 20:20:44 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V7 2/6] x86/entry: Switch the stack after error_entry() returns
Date:   Tue,  3 May 2022 11:21:03 +0800
Message-Id: <20220503032107.680190-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220503032107.680190-1-jiangshanlai@gmail.com>
References: <20220503032107.680190-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

error_entry() calls sync_regs(), and fixup_bad_iret() before sync_regs()
if it is a fault from bad IRET, to copy the pt_regs to the kernel stack
and switches the kernel stack directly after sync_regs().

But error_entry() itself is also a function call, so the code has to
stash the address error_entry() is going to return to, in %r12 and
makes the work complicated.

Move the code of switching stack after error_entry() and get rid of the
need to handle the return address.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ecbfca3cc18c..ca3e99e08a44 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -326,6 +326,8 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
+	movq	%rax, %rsp			/* switch to the task stack if from userspace */
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
@@ -1002,14 +1004,10 @@ SYM_CODE_START_LOCAL(error_entry)
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
+	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 .Lerror_entry_from_usermode_after_swapgs:
 	/* Put us onto the real thread stack. */
-	popq	%r12				/* save return addr in %12 */
-	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
 	call	sync_regs
-	movq	%rax, %rsp			/* switch stack */
-	ENCODE_FRAME_POINTER
-	pushq	%r12
 	RET
 
 	/*
@@ -1041,6 +1039,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	RET
 
 .Lbstep_iret:
@@ -1061,12 +1060,9 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * Pretend that the exception came from user mode: set up pt_regs
 	 * as if we faulted immediately after IRET.
 	 */
-	popq	%r12				/* save return addr in %12 */
-	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
+	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	call	fixup_bad_iret
-	mov	%rax, %rsp
-	ENCODE_FRAME_POINTER
-	pushq	%r12
+	mov	%rax, %rdi
 	jmp	.Lerror_entry_from_usermode_after_swapgs
 SYM_CODE_END(error_entry)
 
-- 
2.19.1.6.gb485710b

