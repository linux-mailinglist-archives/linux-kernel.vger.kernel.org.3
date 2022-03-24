Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54694E645A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350590AbiCXNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350591AbiCXNsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:48:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FFFA94D9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:47:17 -0700 (PDT)
Message-ID: <20220324134623.736990161@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648129636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R6A5qasfkCP1yilN3Hx1CqR1fLfcwGqb+MZxXGRxBLk=;
        b=BUwWnm++qyFfkfypVTGJcfty77bat2cZNnIS5b82BWBviYGp5UPe6KuR2MJQKx3uh37vid
        NbfmjvslxGzTO7nYXj65CWwXcR3evAWa68bKcYZk8YtmMmHicXI1E0LJd52CAEBiXA0quf
        56OIUDl/GNxbWE6FDU+Crdpfa2ItQBvMlcSDdso2tffBEXChz6RjEt3/SKm/0eUaacTFY5
        l/tmK903vuESeFxXdeth3esrhBXVo6uZyBEf1a+0gaPf+BrBWSlNoV6Cffxin31eODbS4O
        7uv09KMl/8nIZNstLriQNPPlaFm1fFpNmnyNVYhVL0auICTe9KHBeQTtPDyYrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648129636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R6A5qasfkCP1yilN3Hx1CqR1fLfcwGqb+MZxXGRxBLk=;
        b=uhku3XA5lZTnxAOLGPuoRxWvdslUdVxMWjjkv45KcVkPta+muLG5Rnj8fRC4NE+q0r5PRy
        iq6KGsGndBtZeJCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [patch 7/7] x86/fpu/xstate: Consolidate size calculations
References: <20220324134548.432837672@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 24 Mar 2022 14:47:16 +0100 (CET)
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
 arch/x86/kernel/fpu/xstate.c |   46 ++++---------------------------------------
 1 file changed, 5 insertions(+), 41 deletions(-)

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
@@ -581,29 +562,12 @@ static bool __init check_xstate_against_
 
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
+	if (compacted)
+		offset = xfeature_get_offset(xfeatures, topmost);
+	return offset + xstate_sizes[topmost];
 }
 
 /*

