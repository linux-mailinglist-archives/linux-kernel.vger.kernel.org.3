Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28754DDBAD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiCRObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbiCRObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:31:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5AE54190
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:29:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n15so7100570plh.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54VbEK3zT/tw2zu0eSh8jL8lMaaZrl/LxM/7ysPzMto=;
        b=NpCNdcyetSIK9dwAjgNBvUltYDUF0AvVnVrqyAb5hLNDvZBYAk87F9B1X1X6m9bp+h
         NIZug8FiE3gqmtxFXJQ6yLgV34XsFSzgHnJw5NhEwce6exm+S1aSiD7NnXaDrtzumyZ1
         1e7u4J5ekDxAGGJ1TniU9iopv+2VuvoB38XdN2Dyl/CahFLEZYNFiFRjPNDCw2376A9g
         3ItRuHsOU1babWjsmwQMV1lFHmZgVpR6RDMxLqeiOxyTqLXqa+jLxCTowkFVXwVni6T6
         Lpnj+XcCeuGM3bmJUQsa3elGqhHcHNwMfsHC44uR9iqPSm7yu63UGEGafDWDj0s9tLcj
         Qzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54VbEK3zT/tw2zu0eSh8jL8lMaaZrl/LxM/7ysPzMto=;
        b=Uhlt3jHJz4CAh2J8mP06tJFVHL7BIIozqFD+SvPse9Dd9hVT5Q63VURkV6u+v94ewq
         6feSenouPFDvo01Bj48+Ai466hptxLfLyiYGCF2lKkEIScfcHOTBOYgi/dcyS16K3PgV
         q0IyHfmMWs92ze8KyZ5YL9KPEctfT00PKEEycNWlTZQ+H7vgaAKSblx68foDaTz89rmn
         wR1lHw0V1hI3ym3or5dVgaRsqjlK4Feylf/ZYA8lEpW3SyXN1O+rl/7yE7XUIXQg9UCW
         goza1U7LKK0X4u/pUN5VxRRUpW/nZv3DTJHWQ65ppi//+kfFDoL9sQrhjNCd+DH8OCPu
         viiQ==
X-Gm-Message-State: AOAM5316TR/vuXpKxPe/zK1gXnhG3ysroTgjjMbN/cYhQHAwdtIKZGng
        QeEOCyFMUzzCtmXVnD+5B1rVgCLoPyk=
X-Google-Smtp-Source: ABdhPJyz4sNXr2jwVkwN9Bi1CZU8BenYDOHQHWQhPSPW0RFSs6JnJDqXIowzVeT3/+b07qK+FfwMbg==
X-Received: by 2002:a17:902:dad2:b0:151:f895:9c31 with SMTP id q18-20020a170902dad200b00151f8959c31mr10510832plx.93.1647613792214;
        Fri, 18 Mar 2022 07:29:52 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id t8-20020a056a00138800b004f724e9fb3esm10100869pfg.89.2022.03.18.07.29.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:29:51 -0700 (PDT)
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
Subject: [PATCH V4 2/7] x86/entry: Switch the stack after error_entry() returns
Date:   Fri, 18 Mar 2022 22:30:11 +0800
Message-Id: <20220318143016.124387-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220318143016.124387-1-jiangshanlai@gmail.com>
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
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

error_entry() calls sync_regs() to settle/copy the pt_regs and switches
the stack directly after sync_regs().  But error_entry() itself is also
a function call, the switching has to handle the return address of it
together, which causes the work complicated and tangly.

Switching to the stack after error_entry() makes the code simpler and
intuitive.

The behavior/logic is unchanged:
  1) (opt) feed fixup_bad_iret() with the pt_regs pushed by ASM code
  2) (opt) fixup_bad_iret() moves the partial pt_regs up
  3) feed sync_regs() with the pt_regs pushed by ASM code or returned
     by fixup_bad_iret()
  4) sync_regs() copies the whole pt_regs to kernel stack if needed
  5) after error_entry() and switching %rsp, it is in kernel stack with
     the pt_regs

Changes only in calling:
  Old code switches to copied pt_regs immediately twice in
  error_entry() while new code switches to the copied pt_regs only
  once after error_entry() returns.
  It is correct since sync_regs() doesn't need to be called close
  to the pt_regs it handles.

  Old code stashes the return-address of error_entry() in a scratch
  register and new code doesn't stash it.
  It relies on the fact that fixup_bad_iret() and sync_regs() don't
  corrupt the return-address of error_entry() on the stack.  But even
  the old code also relies on the fact that fixup_bad_iret() and
  sync_regs() don't corrupt the return-address of themselves.
  They are the same reliances and are assured.

After this change, error_entry() will not do fancy things with the stack
except when in the prolog which will be fixed in the next patch ("move
PUSH_AND_CLEAR_REGS out of error_entry").  This patch and the next patch
can't be swapped because the next patch relies on this patch's stopping
fiddling with the return-address of error_entry(), otherwise the objtool
would complain.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e9d896717ab4..8eff3e6b1687 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -326,6 +326,8 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
+	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
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

