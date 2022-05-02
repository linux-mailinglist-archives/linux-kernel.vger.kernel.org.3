Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A1516989
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 05:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350279AbiEBDEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiEBDE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:04:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A96226D1
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 20:00:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i17so2342004pla.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 20:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O7gKyynvZWkfht2JXbyXRR/jvC6dDIWgun6EvwbLg/8=;
        b=E8lG3Ioo4VCBh+4xLGqrKmE/dg87+yKKD1R4RtVzZLUnPGtUCSKk0jb0C5Qk+vPYTq
         y5p/NUX2Y7YMNFCSkyJSDSkUrQWTl47VE6onTbKZV3BYIUP9vS1vr13y9ubkJ/6kA3EP
         /w1QfBFGdJYB4RuebibX5M2BRtuXWBIu7tDPRhi4ktG80V1B8dhPCY4X4957xEACbJ5R
         PSM3T1uPiCe5KDoVvmcsFijH8RKRqkWdoyGE2s+oEHQIuXX71+xOw9zGWCEBhdON5h+d
         P6rBEf+rckQt41geZOloUnm//6r4w7kVF1VAbkntT06JIItEJSFEXXzSJMnT6bUgPkEt
         tQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O7gKyynvZWkfht2JXbyXRR/jvC6dDIWgun6EvwbLg/8=;
        b=R1O24qtc+4gSzIcCaJtALRI+eRMVqs8d3zgoWwKt+e9Lx9C+CleWcw92gRlInZ0vzW
         E8SCFqL6qByS0MtuCZQh32ttkJDQIYTYzCTZYJUORBDzd9pq0Gwy5NSJPhKYNzLNHjKC
         D87eDq/FUTfa7WCedeUwhY84U4UqzHb8xynFvHTkpu/UJ845TrkQ1lv5Dolf0rmXWDQ3
         hG4u1BcHGaozT0xp3tT/wNSJ7nAdh862kx8PVrPsKFYX0MmTrMSl9iXfGvgq7Mporny2
         iI1lGWjW9BfZ7SRTMFCbV1ayMUtklU3CixEcVwTs50JKTmdBztbutudPKqNZLmPMrVpN
         p3Rg==
X-Gm-Message-State: AOAM531JTMQ7s3Hi6/XtjqNb6figpJptaiebsvth18/yvlGdJP00Qz/Y
        0dyMFciow8HlSc92c7fQszjSnnxBf6M=
X-Google-Smtp-Source: ABdhPJxA3t/KmO/TP6MCCHWQJaGU/IgPcPtSg49yi1VX2Mks0uQcKYrhiRGOzVK+kiV1WXMLjrk4Pw==
X-Received: by 2002:a17:90a:9914:b0:1db:d10f:1fcf with SMTP id b20-20020a17090a991400b001dbd10f1fcfmr15800591pjp.241.1651460457714;
        Sun, 01 May 2022 20:00:57 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:fa8:c0d6:ea14:bd48])
        by smtp.gmail.com with ESMTPSA id a37-20020a634d25000000b003c14af505ecsm10332051pgb.4.2022.05.01.20.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 20:00:57 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: clean up labels in the kernel entry assembly
Date:   Sun,  1 May 2022 20:00:50 -0700
Message-Id: <20220502030050.1695978-1-jcmvbkbc@gmail.com>
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

Don't use numeric labels for long jumps, use named local labels instead.
Avoid conditional label definition.
No functional changes.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S | 100 ++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 7852481d779c..3224b4ceca34 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -169,28 +169,26 @@ _user_exception:
 
 	/* Save only live registers. */
 
-UABI_W	_bbsi.l	a2, 1, 1f
+UABI_W	_bbsi.l	a2, 1, .Lsave_window_registers
 	s32i	a4, a1, PT_AREG4
 	s32i	a5, a1, PT_AREG5
 	s32i	a6, a1, PT_AREG6
 	s32i	a7, a1, PT_AREG7
-UABI_W	_bbsi.l	a2, 2, 1f
+UABI_W	_bbsi.l	a2, 2, .Lsave_window_registers
 	s32i	a8, a1, PT_AREG8
 	s32i	a9, a1, PT_AREG9
 	s32i	a10, a1, PT_AREG10
 	s32i	a11, a1, PT_AREG11
-UABI_W	_bbsi.l	a2, 3, 1f
+UABI_W	_bbsi.l	a2, 3, .Lsave_window_registers
 	s32i	a12, a1, PT_AREG12
 	s32i	a13, a1, PT_AREG13
 	s32i	a14, a1, PT_AREG14
 	s32i	a15, a1, PT_AREG15
 
 #if defined(USER_SUPPORT_WINDOWED)
-	_bnei	a2, 1, 1f		# only one valid frame?
+	/* If only one valid frame skip saving regs. */
 
-	/* Only one valid frame, skip saving regs. */
-
-	j	2f
+	beqi	a2, 1, common_exception
 
 	/* Save the remaining registers.
 	 * We have to save all registers up to the first '1' from
@@ -199,8 +197,8 @@ UABI_W	_bbsi.l	a2, 3, 1f
 	 * All register frames starting from the top field to the marked '1'
 	 * must be saved.
 	 */
-
-1:	addi	a3, a2, -1		# eliminate '1' in bit 0: yyyyxxww0
+.Lsave_window_registers:
+	addi	a3, a2, -1		# eliminate '1' in bit 0: yyyyxxww0
 	neg	a3, a3			# yyyyxxww0 -> YYYYXXWW1+1
 	and	a3, a3, a2		# max. only one bit is set
 
@@ -241,7 +239,7 @@ UABI_W	_bbsi.l	a2, 3, 1f
 
 	/* We are back to the original stack pointer (a1) */
 #endif
-2:	/* Now, jump to the common exception handler. */
+	/* Now, jump to the common exception handler. */
 
 	j	common_exception
 
@@ -795,7 +793,7 @@ ENDPROC(kernel_exception)
 ENTRY(debug_exception)
 
 	rsr	a0, SREG_EPS + XCHAL_DEBUGLEVEL
-	bbsi.l	a0, PS_EXCM_BIT, 1f	# exception mode
+	bbsi.l	a0, PS_EXCM_BIT, .Ldebug_exception_in_exception	# exception mode
 
 	/* Set EPC1 and EXCCAUSE */
 
@@ -814,10 +812,10 @@ ENTRY(debug_exception)
 
 	/* Switch to kernel/user stack, restore jump vector, and save a0 */
 
-	bbsi.l	a2, PS_UM_BIT, 2f	# jump if user mode
-
+	bbsi.l	a2, PS_UM_BIT, .Ldebug_exception_user	# jump if user mode
 	addi	a2, a1, -16 - PT_KERNEL_SIZE	# assume kernel stack
-3:
+
+.Ldebug_exception_continue:
 	l32i	a0, a3, DT_DEBUG_SAVE
 	s32i	a1, a2, PT_AREG1
 	s32i	a0, a2, PT_AREG0
@@ -845,10 +843,12 @@ ENTRY(debug_exception)
 	bbsi.l	a2, PS_UM_BIT, _user_exception
 	j	_kernel_exception
 
-2:	rsr	a2, excsave1
+.Ldebug_exception_user:
+	rsr	a2, excsave1
 	l32i	a2, a2, EXC_TABLE_KSTK	# load kernel stack pointer
-	j	3b
+	j	.Ldebug_exception_continue
 
+.Ldebug_exception_in_exception:
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	/* Debug exception while in exception mode. This may happen when
 	 * window overflow/underflow handler or fast exception handler hits
@@ -856,8 +856,8 @@ ENTRY(debug_exception)
 	 * breakpoints, single-step faulting instruction and restore data
 	 * breakpoints.
 	 */
-1:
-	bbci.l	a0, PS_UM_BIT, 1b	# jump if kernel mode
+
+	bbci.l	a0, PS_UM_BIT, .Ldebug_exception_in_exception	# jump if kernel mode
 
 	rsr	a0, debugcause
 	bbsi.l	a0, DEBUGCAUSE_DBREAK_BIT, .Ldebug_save_dbreak
@@ -901,7 +901,7 @@ ENTRY(debug_exception)
 	rfi	XCHAL_DEBUGLEVEL
 #else
 	/* Debug exception while in exception mode. Should not happen. */
-1:	j	1b	// FIXME!!
+	j	.Ldebug_exception_in_exception	// FIXME!!
 #endif
 
 ENDPROC(debug_exception)
@@ -1630,12 +1630,13 @@ ENTRY(fast_second_level_miss)
 
 	GET_CURRENT(a1,a2)
 	l32i	a0, a1, TASK_MM		# tsk->mm
-	beqz	a0, 9f
+	beqz	a0, .Lfast_second_level_miss_no_mm
 
-8:	rsr	a3, excvaddr		# fault address
+.Lfast_second_level_miss_continue:
+	rsr	a3, excvaddr		# fault address
 	_PGD_OFFSET(a0, a3, a1)
 	l32i	a0, a0, 0		# read pmdval
-	beqz	a0, 2f
+	beqz	a0, .Lfast_second_level_miss_no_pmd
 
 	/* Read ptevaddr and convert to top of page-table page.
 	 *
@@ -1678,12 +1679,13 @@ ENTRY(fast_second_level_miss)
 	addi	a3, a3, DTLB_WAY_PGD
 	add	a1, a1, a3		# ... + way_number
 
-3:	wdtlb	a0, a1
+.Lfast_second_level_miss_wdtlb:
+	wdtlb	a0, a1
 	dsync
 
 	/* Exit critical section. */
-
-4:	rsr	a3, excsave1
+.Lfast_second_level_miss_skip_wdtlb:
+	rsr	a3, excsave1
 	movi	a0, 0
 	s32i	a0, a3, EXC_TABLE_FIXUP
 
@@ -1707,19 +1709,21 @@ ENTRY(fast_second_level_miss)
 	esync
 	rfde
 
-9:	l32i	a0, a1, TASK_ACTIVE_MM	# unlikely case mm == 0
-	bnez	a0, 8b
+.Lfast_second_level_miss_no_mm:
+	l32i	a0, a1, TASK_ACTIVE_MM	# unlikely case mm == 0
+	bnez	a0, .Lfast_second_level_miss_continue
 
 	/* Even more unlikely case active_mm == 0.
 	 * We can get here with NMI in the middle of context_switch that
 	 * touches vmalloc area.
 	 */
 	movi	a0, init_mm
-	j	8b
+	j	.Lfast_second_level_miss_continue
 
+.Lfast_second_level_miss_no_pmd:
 #if (DCACHE_WAY_SIZE > PAGE_SIZE)
 
-2:	/* Special case for cache aliasing.
+	/* Special case for cache aliasing.
 	 * We (should) only get here if a clear_user_page, copy_user_page
 	 * or the aliased cache flush functions got preemptively interrupted 
 	 * by another task. Re-establish temporary mapping to the 
@@ -1729,24 +1733,24 @@ ENTRY(fast_second_level_miss)
 	/* We shouldn't be in a double exception */
 
 	l32i	a0, a2, PT_DEPC
-	bgeui	a0, VALID_DOUBLE_EXCEPTION_ADDRESS, 2f
+	bgeui	a0, VALID_DOUBLE_EXCEPTION_ADDRESS, .Lfast_second_level_miss_slow
 
 	/* Make sure the exception originated in the special functions */
 
 	movi	a0, __tlbtemp_mapping_start
 	rsr	a3, epc1
-	bltu	a3, a0, 2f
+	bltu	a3, a0, .Lfast_second_level_miss_slow
 	movi	a0, __tlbtemp_mapping_end
-	bgeu	a3, a0, 2f
+	bgeu	a3, a0, .Lfast_second_level_miss_slow
 
 	/* Check if excvaddr was in one of the TLBTEMP_BASE areas. */
 
 	movi	a3, TLBTEMP_BASE_1
 	rsr	a0, excvaddr
-	bltu	a0, a3, 2f
+	bltu	a0, a3, .Lfast_second_level_miss_slow
 
 	addi	a1, a0, -TLBTEMP_SIZE
-	bgeu	a1, a3, 2f
+	bgeu	a1, a3, .Lfast_second_level_miss_slow
 
 	/* Check if we have to restore an ITLB mapping. */
 
@@ -1772,19 +1776,19 @@ ENTRY(fast_second_level_miss)
 
 	mov	a0, a6
 	movnez	a0, a7, a3
-	j	3b
+	j	.Lfast_second_level_miss_wdtlb
 
 	/* ITLB entry. We only use dst in a6. */
 
 1:	witlb	a6, a1
 	isync
-	j	4b
+	j	.Lfast_second_level_miss_skip_wdtlb
 
 
 #endif	// DCACHE_WAY_SIZE > PAGE_SIZE
 
-
-2:	/* Invalid PGD, default exception handling */
+	/* Invalid PGD, default exception handling */
+.Lfast_second_level_miss_slow:
 
 	rsr	a1, depc
 	s32i	a1, a2, PT_AREG2
@@ -1824,12 +1828,13 @@ ENTRY(fast_store_prohibited)
 
 	GET_CURRENT(a1,a2)
 	l32i	a0, a1, TASK_MM		# tsk->mm
-	beqz	a0, 9f
+	beqz	a0, .Lfast_store_no_mm
 
-8:	rsr	a1, excvaddr		# fault address
+.Lfast_store_continue:
+	rsr	a1, excvaddr		# fault address
 	_PGD_OFFSET(a0, a1, a3)
 	l32i	a0, a0, 0
-	beqz	a0, 2f
+	beqz	a0, .Lfast_store_slow
 
 	/*
 	 * Note that we test _PAGE_WRITABLE_BIT only if PTE is present
@@ -1839,8 +1844,8 @@ ENTRY(fast_store_prohibited)
 	_PTE_OFFSET(a0, a1, a3)
 	l32i	a3, a0, 0		# read pteval
 	movi	a1, _PAGE_CA_INVALID
-	ball	a3, a1, 2f
-	bbci.l	a3, _PAGE_WRITABLE_BIT, 2f
+	ball	a3, a1, .Lfast_store_slow
+	bbci.l	a3, _PAGE_WRITABLE_BIT, .Lfast_store_slow
 
 	movi	a1, _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_HW_WRITE
 	or	a3, a3, a1
@@ -1868,7 +1873,6 @@ ENTRY(fast_store_prohibited)
 	l32i	a2, a2, PT_DEPC
 
 	bgeui	a2, VALID_DOUBLE_EXCEPTION_ADDRESS, 1f
-
 	rsr	a2, depc
 	rfe
 
@@ -1878,10 +1882,12 @@ ENTRY(fast_store_prohibited)
 	esync
 	rfde
 
-9:	l32i	a0, a1, TASK_ACTIVE_MM	# unlikely case mm == 0
-	j	8b
+.Lfast_store_no_mm:
+	l32i	a0, a1, TASK_ACTIVE_MM	# unlikely case mm == 0
+	j	.Lfast_store_continue
 
-2:	/* If there was a problem, handle fault in C */
+	/* If there was a problem, handle fault in C */
+.Lfast_store_slow:
 	rsr	a1, excvaddr
 	pdtlb	a0, a1
 	bbci.l	a0, DTLB_HIT_BIT, 1f
-- 
2.30.2

