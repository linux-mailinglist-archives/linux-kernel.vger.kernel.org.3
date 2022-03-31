Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167014ED65B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiCaJCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiCaJCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:02:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F38167CF;
        Thu, 31 Mar 2022 02:00:56 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:00:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648717254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEAqvCapACp6bhWkL/Soobe3BYb171DsTFfV6Wasy6g=;
        b=szkhxR0S0XOdxt2SG9rXpln0R0IOd/8WvCzU/fQIBjRemh/8ArNGL9me8QFhQirZrYiXBi
        Mul0rZBOO+rlcMhmmpTP3sRSbHkNPavPeLz6+xcb46gD6gPMXdp7dLFAezr/LH4OWAuUVD
        LWjRUb+wwWeajDAkz49BV9Po6THpQiQDnMyW2vSjkTnYaGSTiDTwkVRy4Wsb2pKl295jHd
        lYj9CEMGq/QqYPmONEelTf/spjHa7rtmKnXAV5qG+9oBXXNvyYdqrzUMOotDNKdVZclCJK
        YvuG1jI35RVRRA7ML375USnw24bQWATioReuvVaQVf3onxQIcJuNW2hlGIi5QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648717254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEAqvCapACp6bhWkL/Soobe3BYb171DsTFfV6Wasy6g=;
        b=cYp+RglHezp9v9Ia1f2Ebr/Uqn3Qv+jpfd6vTB45XJJH0Fu2+0aZ5hllw/LNjFXdqVMeeH
        +Kj7uYuYyMQvCaDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu/xstate: Consolidate size calculations
Cc:     kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87o81pgbp2.ffs@tglx>
References: <87o81pgbp2.ffs@tglx>
MIME-Version: 1.0
Message-ID: <164871725283.389.1793591339458620875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d6d6d50f1e801a790a242c80eeda261e36c43b7b
Gitweb:        https://git.kernel.org/tip/d6d6d50f1e801a790a242c80eeda261e36c43b7b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 28 Mar 2022 20:43:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Mar 2022 12:04:09 +02:00

x86/fpu/xstate: Consolidate size calculations

Use the offset calculation to do the size calculation which avoids yet
another series of CPUID instructions for each invocation.

  [ Fix the FP/SSE only case which missed to take the xstate
    header into account, as
    Reported-by: kernel test robot <oliver.sang@intel.com> ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/87o81pgbp2.ffs@tglx
---
 arch/x86/kernel/fpu/xstate.c | 49 +++++------------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 5ac934b..39e1c86 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -385,25 +385,6 @@ static void __init setup_init_fpu_buf(void)
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
@@ -581,29 +562,15 @@ static bool __init check_xstate_against_struct(int nr)
 
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
