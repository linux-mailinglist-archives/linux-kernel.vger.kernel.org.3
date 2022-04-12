Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039FB4FE9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiDLU6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiDLU5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:57:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252414FFE9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:53:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649795661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9PaeO1yoTw7dvGZZ0PRc0hGx0cBmvj6WVa7+40BVJ4E=;
        b=XlUVorIwjmIFMIc+DkdX5cA6QBXTWo/HOZTZegAyPCsN4FoHEzNXFRgqyzFz4nmuuhAveg
        jBdiBiTvHh4SNEySyFonWBCS20QMIgOaFr9SSleFaguouFXjTzSuU2Kh2GGKF2pmX2AG1o
        HqgQrb8JuPW2/JHcEV2il0q7ZalIY4YFBT35ROA/hl6ZGJxJSbMd3OJ7MITqH4R56HiwA3
        MeOp/2K1Ak8OmAPlH9k1Ne9eqCKcNwj2VqbN12SqvSMc8v3h2cQnuz2W1voxL6V4IfYy+j
        Hd+82VUzQb3sRakCTT/55y6FCCLmQZL5DnmmVyO1f6pVuimwKx++38efDe11mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649795661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9PaeO1yoTw7dvGZZ0PRc0hGx0cBmvj6WVa7+40BVJ4E=;
        b=5rToMQK6B0RWVR9lVSmCh/M6NtlPCg382vXe6QDeihkgUjU1hmslw5DRZ3yrFPNS36L/+h
        og2C/vIlWKT6UDBQ==
To:     Daniel Vacek <neelx@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/apic: Clarify i82489DX bit overlap in APIC_LVT0
In-Reply-To: <CACjP9X_A7aLmvypyOz1UrXM571gx_X5q7=w-1j+G+MSbCteiEw@mail.gmail.com>
References: <20220202140244.1681140-1-neelx@redhat.com>
 <874k361liu.ffs@tglx>
 <CACjP9X_A7aLmvypyOz1UrXM571gx_X5q7=w-1j+G+MSbCteiEw@mail.gmail.com>
Date:   Tue, 12 Apr 2022 22:34:21 +0200
Message-ID: <87ee22f3ci.ffs@tglx>
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

Daniel stumbled over the undocumented bit overlap of the i82498DX external
APIC and the TSC deadline timer configuration bit in modern APICs.

Remove the i82489DX macro maze, use a i82489DX specific define in the apic
code and document the overlap in a comment.

Reported-by: Daniel Vacek <neelx@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apicdef.h |    6 ------
 arch/x86/kernel/apic/apic.c    |   11 ++++++++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

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
@@ -340,8 +343,14 @@ static void __setup_APIC_LVTT(unsigned i
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
