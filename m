Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCDE505D53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346873AbiDRRPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346820AbiDRRPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:15:08 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0CA21263
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id be5so12815211plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zoZQxmtb8wh8rIrYIwJh8EMCnLpoLNcQ3bLBdyTYQ6w=;
        b=oGePhJ4CL//kwxYgrL7T7zj0lNgwSohAJEPCTFN2QQEJnJn5Pp66ypPFowafWAlYDl
         uLeT7zCb7k+aar64pu4/2c2306Ut4jcNmn34NZI3na7reYJKjwNdJTF1RgrWj8jYj2cu
         kpHLzdpHj4gx5TJg44hXhNBfUnGai8YQlj8/Id+UbZCwx2oYkKqxjxfEOBVvfQPtgVu0
         DviuhV5Tnf8/GwojjvmUAw8AGrCIjYUUa98K3dNB/qYpkQUOPAa6MR+//mnVw4YrTRQo
         J+5gSqU1UwamONsNn/oBbkv1C+Pp56celep1KU5sWr20BJVJXeLFzXMWtAuGAdLxdFfH
         yzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoZQxmtb8wh8rIrYIwJh8EMCnLpoLNcQ3bLBdyTYQ6w=;
        b=16YL/5h7UEfsFXF0TrVcif8bGrCN5hVW792AwnpcEIUp9nrn/r1GUASrVpBcQhNppG
         /BSO/ztNW1+1gMS52t4pO9tBoyQd9iO8eDS4QWXzN2Xv71ZkF1FajfWGAR9kUZf/HNIy
         vKNYZjVWOLYFj8NiM2mqdDNRX83CDAyp4cEKhaIxiwYc/ODnOgpTImjKAgLC2vsXoyqR
         gA+rTPEckQahCPsQYmwu7R3O4A073e30H+KpA4DRXeQWc6PWBjenTTH2cQqn1akSEpeo
         0f4msouur4OnQ9WCHB82GsZO1oA0zVWN2G2fftsSCP7JNLudGZjgAG4j0ZLAFLOchj8/
         Cc9A==
X-Gm-Message-State: AOAM532tacV+XO81QNWLJTcDogdOKlHASzbMX70UqXdlQBuZNUpbkSLf
        UXD5/7DBCYvCWExIOAeqcrc=
X-Google-Smtp-Source: ABdhPJyYTfhMqf837S2fuUtQSWU6SysAvp5Z7RY2vZSt/y/eY/bblzWbZV44btEVv4w2YhKfxN4w1Q==
X-Received: by 2002:a17:902:8c81:b0:156:7fee:643b with SMTP id t1-20020a1709028c8100b001567fee643bmr11866552plo.59.1650301948714;
        Mon, 18 Apr 2022 10:12:28 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3f09:380c:8f11:5a8a])
        by smtp.gmail.com with ESMTPSA id e16-20020a63ee10000000b0039d1c7e80bcsm13637138pgi.75.2022.04.18.10.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:12:28 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/5] xtensa: use abi_* register names in the kernel exit code
Date:   Mon, 18 Apr 2022 10:12:03 -0700
Message-Id: <20220418171205.2413168-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
References: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
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

Using plain register names is prone to errors when code is changed and
new calls are added between the register load and use. Change plain
register names to abi_* names in the call-heavy part of the kernel exit
code to clearly indicate what's supposed to be preserved and what's not.
Re-align code while at it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S | 82 +++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index c85597a734aa..d09f2c38ba84 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -462,11 +462,11 @@ KABI_W	or	a3, a3, a2
 	 * exception handler and call the exception handler.
 	 */
 
-	l32i	abi_arg1, a1, PT_EXCCAUSE	# pass EXCCAUSE
-	rsr	abi_tmp0, excsave1
-	addx4	abi_tmp0, abi_arg1, abi_tmp0
-	l32i	abi_tmp0, abi_tmp0, EXC_TABLE_DEFAULT	# load handler
-	mov	abi_arg0, a1			# pass stack frame
+	l32i		abi_arg1, a1, PT_EXCCAUSE	# pass EXCCAUSE
+	rsr		abi_tmp0, excsave1
+	addx4		abi_tmp0, abi_arg1, abi_tmp0
+	l32i		abi_tmp0, abi_tmp0, EXC_TABLE_DEFAULT	# load handler
+	mov		abi_arg0, a1			# pass stack frame
 
 	/* Call the second-level handler */
 
@@ -477,23 +477,23 @@ KABI_W	or	a3, a3, a2
 common_exception_return:
 
 #if XTENSA_FAKE_NMI
-	l32i	abi_tmp0, a1, PT_EXCCAUSE
-	movi	abi_tmp1, EXCCAUSE_MAPPED_NMI
-	l32i	abi_saved1, a1, PT_PS
-	beq	abi_tmp0, abi_tmp1, .Lrestore_state
+	l32i		abi_tmp0, a1, PT_EXCCAUSE
+	movi		abi_tmp1, EXCCAUSE_MAPPED_NMI
+	l32i		abi_saved1, a1, PT_PS
+	beq		abi_tmp0, abi_tmp1, .Lrestore_state
 #endif
 .Ltif_loop:
-	irq_save a2, a3
+	irq_save	abi_tmp0, abi_tmp1
 #ifdef CONFIG_TRACE_IRQFLAGS
 	abi_call	trace_hardirqs_off
 #endif
 
 	/* Jump if we are returning from kernel exceptions. */
 
-	l32i	abi_saved1, a1, PT_PS
-	GET_THREAD_INFO(a2, a1)
-	l32i	a4, a2, TI_FLAGS
-	_bbci.l	abi_saved1, PS_UM_BIT, .Lexit_tif_loop_kernel
+	l32i		abi_saved1, a1, PT_PS
+	GET_THREAD_INFO(abi_tmp0, a1)
+	l32i		abi_saved0, abi_tmp0, TI_FLAGS
+	_bbci.l		abi_saved1, PS_UM_BIT, .Lexit_tif_loop_kernel
 
 	/* Specific to a user exception exit:
 	 * We need to check some flags for signal handling and rescheduling,
@@ -502,75 +502,77 @@ common_exception_return:
 	 * Note that we don't disable interrupts here. 
 	 */
 
-	_bbsi.l	a4, TIF_NEED_RESCHED, .Lresched
-	movi	a2, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL
-	bnone	a4, a2, .Lexit_tif_loop_user
+	_bbsi.l		abi_saved0, TIF_NEED_RESCHED, .Lresched
+	movi		abi_tmp0, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL
+	bnone		abi_saved0, abi_tmp0, .Lexit_tif_loop_user
 
-	l32i	a4, a1, PT_DEPC
-	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, .Lrestore_state
+	l32i		abi_tmp0, a1, PT_DEPC
+	bgeui		abi_tmp0, VALID_DOUBLE_EXCEPTION_ADDRESS, .Lrestore_state
 
 	/* Call do_signal() */
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	abi_call	trace_hardirqs_on
 #endif
-	rsil	a2, 0
-	mov	abi_arg0, a1
+	rsil		abi_tmp0, 0
+	mov		abi_arg0, a1
 	abi_call	do_notify_resume	# int do_notify_resume(struct pt_regs*)
-	j	.Ltif_loop
+	j		.Ltif_loop
 
 .Lresched:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	abi_call	trace_hardirqs_on
 #endif
-	rsil	a2, 0
+	rsil		abi_tmp0, 0
 	abi_call	schedule	# void schedule (void)
-	j	.Ltif_loop
+	j		.Ltif_loop
 
 .Lexit_tif_loop_kernel:
 #ifdef CONFIG_PREEMPTION
-	_bbci.l	a4, TIF_NEED_RESCHED, .Lrestore_state
+	_bbci.l		abi_saved0, TIF_NEED_RESCHED, .Lrestore_state
 
 	/* Check current_thread_info->preempt_count */
 
-	l32i	a4, a2, TI_PRE_COUNT
-	bnez	a4, .Lrestore_state
+	l32i		abi_tmp1, abi_tmp0, TI_PRE_COUNT
+	bnez		abi_tmp1, .Lrestore_state
 	abi_call	preempt_schedule_irq
 #endif
-	j	.Lrestore_state
+	j		.Lrestore_state
 
 .Lexit_tif_loop_user:
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-	_bbci.l	a4, TIF_DB_DISABLED, 1f
+	_bbci.l		abi_saved0, TIF_DB_DISABLED, 1f
 	abi_call	restore_dbreak
 1:
 #endif
 #ifdef CONFIG_DEBUG_TLB_SANITY
-	l32i	a4, a1, PT_DEPC
-	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, .Lrestore_state
+	l32i		abi_tmp0, a1, PT_DEPC
+	bgeui		abi_tmp0, VALID_DOUBLE_EXCEPTION_ADDRESS, .Lrestore_state
 	abi_call	check_tlb_sanity
 #endif
 
 .Lrestore_state:
 #ifdef CONFIG_TRACE_IRQFLAGS
-	extui	a4, abi_saved1, PS_INTLEVEL_SHIFT, PS_INTLEVEL_WIDTH
-	bgei	a4, LOCKLEVEL, 1f
+	extui		abi_tmp0, abi_saved1, PS_INTLEVEL_SHIFT, PS_INTLEVEL_WIDTH
+	bgei		abi_tmp0, LOCKLEVEL, 1f
 	abi_call	trace_hardirqs_on
 1:
 #endif
-	/* Restore optional registers. */
+	/*
+	 * Restore optional registers.
+	 * abi_arg* are used as temporary registers here.
+	 */
 
-	load_xtregs_opt a1 a2 a4 a5 a6 a7 PT_XTREGS_OPT
+	load_xtregs_opt a1 abi_tmp0 abi_arg0 abi_arg1 abi_arg2 abi_arg3 PT_XTREGS_OPT
 
 	/* Restore SCOMPARE1 */
 
 #if XCHAL_HAVE_S32C1I
-	l32i    a2, a1, PT_SCOMPARE1
-	wsr     a2, scompare1
+	l32i		abi_tmp0, a1, PT_SCOMPARE1
+	wsr		abi_tmp0, scompare1
 #endif
-	wsr	abi_saved1, ps		/* disable interrupts */
-
-	_bbci.l	abi_saved1, PS_UM_BIT, kernel_exception_exit
+	wsr		abi_saved1, ps		/* disable interrupts */
+	_bbci.l		abi_saved1, PS_UM_BIT, kernel_exception_exit
 
 user_exception_exit:
 
-- 
2.30.2

