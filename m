Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890884FE0E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354026AbiDLMt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355156AbiDLMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:48:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0E17E20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id be5so10644267plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m76DlOnMkrs3Z3EokaOUMbfkFeUFvtm1mHdRPM+LTLI=;
        b=nkdKW4+uIivnulUOM7VrrCeoXgzFDZDIWMHNSu1OpQTkC0IlzT557HJSvgfpkWhnFU
         7OFAvtCOxam/oPY9Vms/3yyyZRddfc8bsqf1MwesABnSEIeVYUo3BTG6qpUs+wm1x4pY
         NpEBdSXZc7EpEkh1KlOrDR7X6c9DKgPEmxpB/AQRcuPDh4xdHVsMEIJtraS7XH4NDFtn
         5Pmk/76+CCDXLLwRr2cJvcw+8D+XhMC1ZKlHE/WpUnBGXfp1LC6RWJxQ9a/tNvY7MO3Z
         X+c4BkGgRbFTQbJNjvCGfjiml9Sg7Iax4bS0W7fv4hrrFIHsl5MPJUI0xP0u27V7Um0i
         p5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m76DlOnMkrs3Z3EokaOUMbfkFeUFvtm1mHdRPM+LTLI=;
        b=ISyCGvd55G/a59qIgpdD5GKc/q75MTOAY6EJLfPV+7Nclrm/q8ZwszOcqQTVUcpYbF
         +89fGfnAiCoX5l8A9fMRMrnKUOjSmqxeH08T1JzP9ZANjg/9WZEeXIsDQCIrw8LMtW4d
         iGrIipDn/6rHSSshThJI3c+HHRLgvn0fqmbybjruxes1ydUJd+/oXoasUlPYnna+RwQW
         +kwqRL/89AkApf60BRnVYHhiSaCXkyi2lnNkMRr2MGhnWahu4wjfk2hzNHCrMlr7jBGR
         wFlCjWJ20yIdIZg0o9mcNVHCZpFjZ8uT9vFGULnFrpKYODmqL1glvfSZjslF+LHVxPMr
         9hpg==
X-Gm-Message-State: AOAM533+YTwMnVeNOsfFz7OpJWnvbI0/ln7szyd1upXesLkFnhjJIFOC
        UGM9xjZ2mNVU63D+Ta7kNq+N7RpwpUw=
X-Google-Smtp-Source: ABdhPJxk/xVs2QDTp3erfZ5PqAWWKalL7g7NK4E9pjBykM8olG8Izjrvb/wrMReK8q9SrLhc/jCfPg==
X-Received: by 2002:a17:90b:383:b0:1cb:b7f1:9c69 with SMTP id ga3-20020a17090b038300b001cbb7f19c69mr4725735pjb.220.1649765709363;
        Tue, 12 Apr 2022 05:15:09 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id e14-20020a62aa0e000000b00505c05545f8sm7032389pff.108.2022.04.12.05.15.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:15:08 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 2/7] x86/entry: Switch the stack after error_entry() returns
Date:   Tue, 12 Apr 2022 20:15:36 +0800
Message-Id: <20220412121541.4595-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220412121541.4595-1-jiangshanlai@gmail.com>
References: <20220412121541.4595-1-jiangshanlai@gmail.com>
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
index e9d896717ab4..e1efc56fbcd4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -326,6 +326,8 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
+	movq	%rax, %rsp			/* switch to the task stack if from userspace */
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
@@ -999,14 +1001,10 @@ SYM_CODE_START_LOCAL(error_entry)
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
@@ -1038,6 +1036,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	RET
 
 .Lbstep_iret:
@@ -1058,12 +1057,9 @@ SYM_CODE_START_LOCAL(error_entry)
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

