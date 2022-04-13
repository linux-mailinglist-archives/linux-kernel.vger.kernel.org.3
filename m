Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014E44FFB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbiDMQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiDMQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:47:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC633DF6D;
        Wed, 13 Apr 2022 09:44:53 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:44:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649868291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEoInKY3J+Q/dILU0EoFdzYnt/qm3sY3315BF2UtcZ4=;
        b=nzuGbfdxOIl53bG2GGnznOWnomzesAcXD8owfpyYlCUE5zXnnw9OQzf88BQwUFiBI/T63K
        7r/OIagOeRe8QrQNiZz5sjWD0D75nNwFnybwOVKkyEqRbGmZOLgqRfy8I1fjbFGiZr9Svm
        dm8dZaVXrEIn8Ji5b81aUwn0FdRzMaBMi/IdwjnCfMag2N0QInPXud1NPZ2LI5XgVi5bKl
        78ZOkEKzA9iV3UvITFQQstB6QISY7Do/CgIpQsudZ06QSPEpgMjlWCUD12lAzSTk2opQ9z
        rNWwDmHDKOCNoqEBEqz4AF9iPC7qgf50yl9HhBvIqugmJ0keoaV8iVi4+SvtlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649868291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEoInKY3J+Q/dILU0EoFdzYnt/qm3sY3315BF2UtcZ4=;
        b=4ECKEncz0SYx5X0oD2nzBsxcjMHvsTROZ6c3iMVOmiK4rsU1Y/Gd8osjPltC57IrwqyzAa
        rl2JeXvDhlXbv4Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Clarify i82489DX bit overlap in APIC_LVT0
Cc:     Daniel Vacek <neelx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87ee22f3ci.ffs@tglx>
References: <87ee22f3ci.ffs@tglx>
MIME-Version: 1.0
Message-ID: <164986829019.4207.675217037499219017.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     daf3af4705ba8f49d33ea9b7bafdc9fd9efd49e0
Gitweb:        https://git.kernel.org/tip/daf3af4705ba8f49d33ea9b7bafdc9fd9efd49e0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 Apr 2022 22:34:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 Apr 2022 18:39:48 +02:00

x86/apic: Clarify i82489DX bit overlap in APIC_LVT0

Daniel stumbled over the bit overlap of the i82498DX external APIC and the
TSC deadline timer configuration bit in modern APICs, which is neither
documented in the code nor in the current SDM. Maciej provided links to
the original i82489DX/486 documentation. See Link.

Remove the i82489DX macro maze, use a i82489DX specific define in the apic
code and document the overlap in a comment.

Reported-by: Daniel Vacek <neelx@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/r/87ee22f3ci.ffs@tglx
---
 arch/x86/include/asm/apicdef.h |  6 ------
 arch/x86/kernel/apic/apic.c    | 11 ++++++++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index 5716f22..92035eb 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -95,12 +95,6 @@
 #define	APIC_LVTTHMR	0x330
 #define	APIC_LVTPC	0x340
 #define	APIC_LVT0	0x350
-#define		APIC_LVT_TIMER_BASE_MASK	(0x3 << 18)
-#define		GET_APIC_TIMER_BASE(x)		(((x) >> 18) & 0x3)
-#define		SET_APIC_TIMER_BASE(x)		(((x) << 18))
-#define		APIC_TIMER_BASE_CLKIN		0x0
-#define		APIC_TIMER_BASE_TMBASE		0x1
-#define		APIC_TIMER_BASE_DIV		0x2
 #define		APIC_LVT_TIMER_ONESHOT		(0 << 17)
 #define		APIC_LVT_TIMER_PERIODIC		(1 << 17)
 #define		APIC_LVT_TIMER_TSCDEADLINE	(2 << 17)
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b70344b..13819bf 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -320,6 +320,9 @@ int lapic_get_maxlvt(void)
 #define APIC_DIVISOR 16
 #define TSC_DIVISOR  8
 
+/* i82489DX specific */
+#define		I82489DX_BASE_DIVIDER		(((0x2) << 18))
+
 /*
  * This function sets up the local APIC timer, with a timeout of
  * 'clocks' APIC bus clock. During calibration we actually call
@@ -340,8 +343,14 @@ static void __setup_APIC_LVTT(unsigned int clocks, int oneshot, int irqen)
 	else if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
 		lvtt_value |= APIC_LVT_TIMER_TSCDEADLINE;
 
+	/*
+	 * The i82489DX APIC uses bit 18 and 19 for the base divider.  This
+	 * overlaps with bit 18 on integrated APICs, but is not documented
+	 * in the SDM. No problem though. i82489DX equipped systems do not
+	 * have TSC deadline timer.
+	 */
 	if (!lapic_is_integrated())
-		lvtt_value |= SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
+		lvtt_value |= I82489DX_BASE_DIVIDER;
 
 	if (!irqen)
 		lvtt_value |= APIC_LVT_MASKED;
