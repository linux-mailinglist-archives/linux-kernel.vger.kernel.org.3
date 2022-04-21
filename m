Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8278350A1C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389053AbiDUONj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389136AbiDUONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:13:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8536D3969A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z16so5123078pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWDAJ1Qy8kTssfxxRg0WHjshQinm3EhF18pt1sufO9Y=;
        b=ARPhf0+NIPljSItpJM/3qj1GaiPnpOIQ5yiVhM1As9J7K+JOxJfNF20z3PkzsiOwYd
         Yo8LecDRlqngIlzqPbzLcoRlEKg1uaTK2BI1fzyBuWTLYxpxGu7Gc05Ln3q/TP3e9Dce
         3f8ROuCrT9qDT1gwWUzZULiehRFjdhHnqmj/AGdMiUZMh/EYVDXY9xEdYfOiNcwpM2et
         laP1GRGLV1fhKfmZJyufXp20C79TS6IGDKus+0roiaZ1DTGQr+B+ilSZYXwpY6ahAl5E
         gLk4P+pI2M2CXedHrafGP9HxxCxdGBItw1lXxv0EvUR4N70W/Z0LgQjzW+zeSVxv7xms
         Iy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWDAJ1Qy8kTssfxxRg0WHjshQinm3EhF18pt1sufO9Y=;
        b=GuFDVdz1u5MbOe4XoswgWk1hF6Pgm5bDgvbDlzobgZAmIhE7+zNdqNAROS20I3BbJT
         Ao9SIy5HLVSOY9f+3uB+/QJdULENWdvBFXdMoc/pGy3C06SwhZJ9tJEHDhhYL4vcS1FT
         q1pimgy4cAGQFN1hXVAiSu7WaJt7qELUNb4b5Aeq+H0KQAC5lmLVLA5FhymWFA8ju0It
         67hKErN7xfZjnNK/iezCETiTnNwbjqnUeoVLa0ZwYCmDx69SuqP8WqTb1qM9ug4adGlM
         +c5JdhOtebbmZIX9ppnnCbU4SERH3isWgkxMv4p3rqfmUdKzRn0yBu/AUF856LaZNBFu
         OnZw==
X-Gm-Message-State: AOAM5316otuJwLZphdfc+FSRxAsRSpxYcWjDlH/KwnGuxbfeBlUijvxY
        CiOSOwsbC7V3Y7G/zy7p1FIkB+/X2Ro=
X-Google-Smtp-Source: ABdhPJzFYS2iztHsIYjhhFQF6BoLF2p9jFo0suVT8qTBXhqQw2Ler+RCk+rJWsrVfl3sGRT8kmCulw==
X-Received: by 2002:a62:170b:0:b0:50a:6901:b633 with SMTP id 11-20020a62170b000000b0050a6901b633mr24003552pfx.34.1650550223798;
        Thu, 21 Apr 2022 07:10:23 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm23261881pfw.144.2022.04.21.07.10.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:10:23 -0700 (PDT)
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
Subject: [PATCH V6 2/8] x86/entry: Switch the stack after error_entry() returns
Date:   Thu, 21 Apr 2022 22:10:49 +0800
Message-Id: <20220421141055.316239-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220421141055.316239-1-jiangshanlai@gmail.com>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

