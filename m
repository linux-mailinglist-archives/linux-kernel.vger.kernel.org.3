Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5184DEA8F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244096AbiCSUOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244087AbiCSUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:14:45 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7251F15FC0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:13:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id o23so7525643pgk.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/cV7qJ16DWSkZlNHaTe1Nqv3dWTXEeckbQVdchkeZo=;
        b=nA15HzkC3M0c2AdPxE9s4JUmlf3Q1fTP6PWnzi6e/2qTe0iEi4h4bCiyNU+DE4dHAJ
         MaNqshL3RZn4gkVtzfU3ikVLnTdT/LEEE6UGv+sas1supwCsj8XHVXaLC3QxgSpQxeC7
         ZntI/hsQVikdRIaTMu+Ey7eoVAAJvMc6DJ8EgXxY5sgALVAsYH4UiuFdrefTaP0Sfl4s
         qOQIrnRFo+8KdSCCRefMWaiXJyli1uoPWu2Bu4Y8Ui7BmMTZlbVsYRRXbm9FJjVWshPY
         drAV0LgnFeTDyLtCAsraMhZg1RUNq7bIVN8Kx8NTgZlfxIyi9gR7hKoHC6TXqrRF6lsr
         mV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/cV7qJ16DWSkZlNHaTe1Nqv3dWTXEeckbQVdchkeZo=;
        b=waVHpu7xQVtf7za2tDUrhWhigb+xTQHOoteHjrNrxAGhnzTaP7hNzjYmzynMLHrgTe
         mTxHGivNaVZT7UwHdTYMBcLgdOqfwUTu5RsuGX5qnbgvMkiMeNuhgBgAUoNy5Mit+Zxo
         N0NG+KTOTnz+koOTpBwjk/KM/60xZ+5zgEoI1Z6EMzxX5uTZbEybuw3YxvuO2DvesIUs
         YJeQrD9p8AM6Y5qb+RfzaiFifuAqFT1wboFgS01Jqy29QnxpXO8ksIyYrsnr9K+tXXrC
         630AHToJo4pZ5SKNQitNUIC2n1R8gi9p8+s8D9Ngki72euptpXbWmsAjJuB21s2h6TrD
         j+yg==
X-Gm-Message-State: AOAM53266TU/8odawBw7ffp4rxF56bBQL5NBnUcSrbTf+xRgpVzHvEXY
        CoBcoyacfIyGC9+K633D4/E=
X-Google-Smtp-Source: ABdhPJwIelhKb5RcW2pBHleiw9HZLpPSh6C+9kl5brgF7fhtuw3dACDZyQEegmakByP0A7n8j9ySnw==
X-Received: by 2002:a62:520f:0:b0:4fa:6439:1bed with SMTP id g15-20020a62520f000000b004fa64391bedmr12453388pfb.76.1647720802961;
        Sat, 19 Mar 2022 13:13:22 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:951a:ad0c:e44c:ff47])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a199000b001bf4b1b268bsm11286612pji.44.2022.03.19.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:13:22 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: clean up kernel exit assembly code
Date:   Sat, 19 Mar 2022 13:13:10 -0700
Message-Id: <20220319201310.3006788-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use numeric labels for complex branching logic. Mark each branch
with named local label and use them. Rearrange exit back to kernel mode
to avoid conditional label definition.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S | 50 +++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 8d671898d582..6b6eff658795 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -491,9 +491,9 @@ common_exception_return:
 	l32i	abi_tmp0, a1, PT_EXCCAUSE
 	movi	abi_tmp1, EXCCAUSE_MAPPED_NMI
 	l32i	abi_saved1, a1, PT_PS
-	beq	abi_tmp0, abi_tmp1, 4f
+	beq	abi_tmp0, abi_tmp1, .Lrestore_state
 #endif
-1:
+.Ltif_loop:
 	irq_save a2, a3
 #ifdef CONFIG_TRACE_IRQFLAGS
 	abi_call	trace_hardirqs_off
@@ -504,7 +504,7 @@ common_exception_return:
 	l32i	abi_saved1, a1, PT_PS
 	GET_THREAD_INFO(a2, a1)
 	l32i	a4, a2, TI_FLAGS
-	_bbci.l	abi_saved1, PS_UM_BIT, 6f
+	_bbci.l	abi_saved1, PS_UM_BIT, .Lexit_tif_loop_kernel
 
 	/* Specific to a user exception exit:
 	 * We need to check some flags for signal handling and rescheduling,
@@ -513,12 +513,12 @@ common_exception_return:
 	 * Note that we don't disable interrupts here. 
 	 */
 
-	_bbsi.l	a4, TIF_NEED_RESCHED, 3f
+	_bbsi.l	a4, TIF_NEED_RESCHED, .Lresched
 	movi	a2, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL
-	bnone	a4, a2, 5f
+	bnone	a4, a2, .Lexit_tif_loop_user
 
-2:	l32i	a4, a1, PT_DEPC
-	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, 4f
+	l32i	a4, a1, PT_DEPC
+	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, .Lrestore_state
 
 	/* Call do_signal() */
 
@@ -528,42 +528,41 @@ common_exception_return:
 	rsil	a2, 0
 	mov	abi_arg0, a1
 	abi_call	do_notify_resume	# int do_notify_resume(struct pt_regs*)
-	j	1b
-
-3:	/* Reschedule */
+	j	.Ltif_loop
 
+.Lresched:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	abi_call	trace_hardirqs_on
 #endif
 	rsil	a2, 0
 	abi_call	schedule	# void schedule (void)
-	j	1b
+	j	.Ltif_loop
 
+.Lexit_tif_loop_kernel:
 #ifdef CONFIG_PREEMPTION
-6:
-	_bbci.l	a4, TIF_NEED_RESCHED, 4f
+	_bbci.l	a4, TIF_NEED_RESCHED, .Lrestore_state
 
 	/* Check current_thread_info->preempt_count */
 
 	l32i	a4, a2, TI_PRE_COUNT
-	bnez	a4, 4f
+	bnez	a4, .Lrestore_state
 	abi_call	preempt_schedule_irq
-	j	4f
 #endif
+	j	.Lrestore_state
 
-5:
+.Lexit_tif_loop_user:
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-	_bbci.l	a4, TIF_DB_DISABLED, 7f
+	_bbci.l	a4, TIF_DB_DISABLED, 1f
 	abi_call	restore_dbreak
-7:
+1:
 #endif
 #ifdef CONFIG_DEBUG_TLB_SANITY
 	l32i	a4, a1, PT_DEPC
-	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, 4f
+	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, .Lrestore_state
 	abi_call	check_tlb_sanity
 #endif
-6:
-4:
+
+.Lrestore_state:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	extui	a4, abi_saved1, PS_INTLEVEL_SHIFT, PS_INTLEVEL_WIDTH
 	bgei	a4, LOCKLEVEL, 1f
@@ -601,7 +600,7 @@ user_exception_exit:
 	rsr	a1, depc		# restore stack pointer
 	l32i	a2, a1, PT_WMASK	# register frames saved (in bits 4...9)
 	rotw	-1			# we restore a4..a7
-	_bltui	a6, 16, 1f		# only have to restore current window?
+	_bltui	a6, 16, .Lclear_regs	# only have to restore current window?
 
 	/* The working registers are a0 and a3.  We are restoring to
 	 * a4..a7.  Be careful not to destroy what we have just restored.
@@ -613,18 +612,19 @@ user_exception_exit:
 	mov	a2, a6
 	mov	a3, a5
 
-2:	rotw	-1			# a0..a3 become a4..a7
+1:	rotw	-1			# a0..a3 become a4..a7
 	addi	a3, a7, -4*4		# next iteration
 	addi	a2, a6, -16		# decrementing Y in WMASK
 	l32i	a4, a3, PT_AREG_END + 0
 	l32i	a5, a3, PT_AREG_END + 4
 	l32i	a6, a3, PT_AREG_END + 8
 	l32i	a7, a3, PT_AREG_END + 12
-	_bgeui	a2, 16, 2b
+	_bgeui	a2, 16, 1b
 
 	/* Clear unrestored registers (don't leak anything to user-land */
 
-1:	rsr	a0, windowbase
+.Lclear_regs:
+	rsr	a0, windowbase
 	rsr	a3, sar
 	sub	a3, a0, a3
 	beqz	a3, 2f
-- 
2.30.2

