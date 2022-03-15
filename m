Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71584D9576
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbiCOHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbiCOHkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:40:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFE64B436
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d18so435506plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0gDUXrqZ+nZHPdsNhy8A8CfRPW/VJ+6u8PwNWHKT0g=;
        b=gzDJU2XyoAB7vgBY0WkAweA4XmIRJiiuz9wDjw5nnuFd3BB3OH6IZiTEnC5ZlYvHkv
         QJrHKsEjrStcKjUkI0bOCnFB2UJ34eK1vlp9a5RhxXosHaFewLS5D5Gfu2LA0qd64UuB
         /0xAr/oL5X/bESct9B8KapvEzJMT/87Kah+VaKAmWhYKQTvzy/LWBU7mRDxmsK8IpskV
         EozS+jKKPYtF6Wx9msUbs16zg6TnBvADPHlA75h5FyLUnCxMs7UZwjJ7t1L76AgjHNdQ
         XfBy9hGgxsffWioSrPTaQIKdL0ncbQBRCBr4rmcbUp7pEnQFUAANnV8F4CS1FiamkJiX
         8lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0gDUXrqZ+nZHPdsNhy8A8CfRPW/VJ+6u8PwNWHKT0g=;
        b=epjxblG9l3m43fb7UVnu7JDRM2hI2HYKks39ATx4rxHA/bg6/MnT4kL783qnIJi4r3
         VL+1impAHW8l7EtcNZdKmCai0C9UUS6t1Ahs6gUVFZMxQNW2ko5RlGfokSlHnSZ6Rp6T
         qNAOqcxGzBSw/YvHpbGdz72lXOxGUmukNKylmWlNpW+4B28Vqi7MAX1E8U1Gqb7KQwCo
         oGMYToJb4AT6IHjKaG8fmcjZ9Nsrz4me+lmAump8KmbpTrUTgQxYebb9KSRN6MncxxJd
         Epm0POdEWpnTGmrS6JzaDOUZSSNpcKOl2bSsyj92+W+6SYoMMhe+0X+O/YYPlfv8E3Uf
         7Obg==
X-Gm-Message-State: AOAM533/GtMlLdWhEGLhLaQzHEECdTGNfO62eng4SCMePR7o/+rHbIES
        NaSCQJ/EMszS3+hnlvSty7J/sQGGBag=
X-Google-Smtp-Source: ABdhPJwM5pMM7p6QT9TCfZfJ5nqAqoYAOrmb1vwPZzsp0gHOvvoR/3Qy1mlHRG8/JWxl93tlpe/G3Q==
X-Received: by 2002:a17:90b:1d07:b0:1c6:35d1:4416 with SMTP id on7-20020a17090b1d0700b001c635d14416mr2357341pjb.210.1647329974849;
        Tue, 15 Mar 2022 00:39:34 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id p186-20020a62d0c3000000b004f6fa49c4b9sm21834511pfg.218.2022.03.15.00.39.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 00:39:34 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 3/7] x86/entry: Switch the stack after error_entry() returns
Date:   Tue, 15 Mar 2022 15:39:45 +0800
Message-Id: <20220315073949.7541-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220315073949.7541-1-jiangshanlai@gmail.com>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
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
index 37505331b7f1..7768cdd0c7ed 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -326,6 +326,8 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
+	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
@@ -1014,14 +1016,10 @@ SYM_CODE_START_LOCAL(error_entry)
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
@@ -1053,6 +1051,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	RET
 
 .Lbstep_iret:
@@ -1073,12 +1072,9 @@ SYM_CODE_START_LOCAL(error_entry)
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

