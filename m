Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17574E9F20
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245293AbiC1SpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiC1SpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:45:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929CEFFF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:43:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648493002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jiQi0QWhnZscVOAnkzHFyqDUSzKwYEoPntptVT51RM=;
        b=KeEUa5rBvEGAFy7q3gZ42iI6G2809OCplOwFSOJVH9kY1w0/TPxPcfEKK5HefLK9d0U8iq
        LOwPdQ6DFTOJkoKxHcZj/WhhSSgGHnAOGvy30VNoanrIpaYRbp8PQ1G4sWNA/A0vecoWHJ
        whCXVTyWioyJXUEay2RJBrvmbiarqJ/IY5eRAPy4ABW+nccmCgO3dRyraCnnCLo2riBSop
        4FY/OF0OalEpfR2wnWcgsgqJbU11ZAF3g25xnZvqZpxzYhdjIce8gXVFwoszj0KTW/Z4Nn
        r917FIwe8g9JFyi/6mAyLdFsAHRgN840N8Zx61fkHZ3ZSqC6OQ3Nkl+bRcnLzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648493002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jiQi0QWhnZscVOAnkzHFyqDUSzKwYEoPntptVT51RM=;
        b=HwiNzNBPBdXBPflq4oWoQqsbiVumUsrRE0vc8bSlo741ZrxyJ9uYRaF29GrwtnZerRX2Lb
        rPItsfG0/vrydYBg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [patch V2 7/7] x86/fpu/xstate: Consolidate size calculations
In-Reply-To: <20220324134623.736990161@linutronix.de>
References: <20220324134548.432837672@linutronix.de>
 <20220324134623.736990161@linutronix.de>
Date:   Mon, 28 Mar 2022 20:43:21 +0200
Message-ID: <87o81pgbp2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the offset calculation to do the size calculation which avoids yet
another series of CPUID instructions for each invocation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix the FP/SSE only case which missed to take the xstate header into
    account. Reported-by: kernel test robot <oliver.sang@intel.com>
---
 arch/x86/kernel/fpu/xstate.c |   49 +++++++------------------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -385,25 +385,6 @@ static void __init setup_init_fpu_buf(vo
 	fxsave(&init_fpstate.regs.fxsave);
 }
 
-static int xfeature_uncompacted_offset(int xfeature_nr)
-{
-	u32 eax, ebx, ecx, edx;
-
-	/*
-	 * Only XSAVES supports supervisor states and it uses compacted
-	 * format. Checking a supervisor state's uncompacted offset is
-	 * an error.
-	 */
-	if (XFEATURE_MASK_SUPERVISOR_ALL & BIT_ULL(xfeature_nr)) {
-		WARN_ONCE(1, "No fixed offset for xstate %d\n", xfeature_nr);
-		return -1;
-	}
-
-	CHECK_XFEATURE(xfeature_nr);
-	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
-	return ebx;
-}
-
 int xfeature_size(int xfeature_nr)
 {
 	u32 eax, ebx, ecx, edx;
@@ -581,29 +562,15 @@ static bool __init check_xstate_against_
 
 static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 {
-	unsigned int size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
-	int i;
+	unsigned int topmost = fls64(xfeatures) -  1;
+	unsigned int offset = xstate_offsets[topmost];
 
-	for_each_extended_xfeature(i, xfeatures) {
-		/* Align from the end of the previous feature */
-		if (xfeature_is_aligned64(i))
-			size = ALIGN(size, 64);
-		/*
-		 * In compacted format the enabled features are packed,
-		 * i.e. disabled features do not occupy space.
-		 *
-		 * In non-compacted format the offsets are fixed and
-		 * disabled states still occupy space in the memory buffer.
-		 */
-		if (!compacted)
-			size = xfeature_uncompacted_offset(i);
-		/*
-		 * Add the feature size even for non-compacted format
-		 * to make the end result correct
-		 */
-		size += xfeature_size(i);
-	}
-	return size;
+	if (topmost <= XFEATURE_SSE)
+		return sizeof(struct xregs_state);
+
+	if (compacted)
+		offset = xfeature_get_offset(xfeatures, topmost);
+	return offset + xstate_sizes[topmost];
 }
 
 /*
