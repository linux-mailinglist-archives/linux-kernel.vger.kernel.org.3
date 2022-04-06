Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90114F6296
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiDFPEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiDFPDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:03:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069C22EBCF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:50:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649245642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GGGwAwrWiyNwGxUpG3qe2KvKg8MMCn5ZExvB7exl/rI=;
        b=v7Tl38YAqGYS03eVlXxebqIuB1eLVRuh61b4fZoim6gC8ZhNbPdv1ZuX7qpTO3vVdcpdCL
        cs6rbPQo/JS7CnlpYpP0PKrzaVc+AXFHPRvNZp2cWcZjgL0JScFQmhFkP9nNvZm8C+XyyL
        tcdGZpzGqW0KIzPfRzuNPloCLKias+KxUuCYK4MCNo8wHxn+igl+V6TJeUqWgV/D6UcH7M
        vEcgxV/nHQp7OW+pP5RcssjX9O56PgaIHZKgcjOiOPpkUOMeNtuUnifnlfyBSio0bMTwpU
        +4qnRAQzGttFzVawSectehSJaPmGXa2m5SXq3BsEmZn2eYNZiqnebrQ2SibsUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649245642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GGGwAwrWiyNwGxUpG3qe2KvKg8MMCn5ZExvB7exl/rI=;
        b=42Ttx2tXjyiYodVtcoQsbLYfJ3i/+JPrnjkbSb+T3Iv0B2CO5gBNsqZRLpSGOEjC/QjfEe
        GTu+qZBE1q+SN1CQ==
To:     Daniel Vacek <neelx@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] apic: fix timer base macro definitions
In-Reply-To: <20220202140244.1681140-1-neelx@redhat.com>
References: <20220202140244.1681140-1-neelx@redhat.com>
Date:   Wed, 06 Apr 2022 13:47:21 +0200
Message-ID: <874k361liu.ffs@tglx>
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

Daniel,

On Wed, Feb 02 2022 at 15:02, Daniel Vacek wrote:
> I was wondering if the aliasing of APIC_TIMER_BASE_TMBASE and
> APIC_LVT_TIMER_TSCDEADLINE was intentional or we need to << 19?

That's intentional. This is only used for the !lapic_is_integrated()
case, which is the ancient i82489DX.

Something like the below should make this more clear.

Thanks,

        tglx
---
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
