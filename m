Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE904D557B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344796AbiCJXep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344765AbiCJXee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:34:34 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10F14995A;
        Thu, 10 Mar 2022 15:33:31 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id w27so12202876lfa.5;
        Thu, 10 Mar 2022 15:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNHUR7Fg5QDGRpIarkWskOSy3y0TrjYuLGHsjzBlRAo=;
        b=RgjjRRL8vTnLx718/GHYrc9VVGlYnPye9SLzsUhauHMZB/R4QhkJpyPxHTKHUxcFKx
         DGyDEa8unqoy9Hnt4x9sUs25uQen4ZZewehtQwzKm94GYD3pg9NBzn2mo/QaZj3rH3Q4
         GZjnK3qet1lSx8aipexnVPiialVpVr55kQtaLstu+oSaBKtYLQZZC6zE+9B18/oF7nLp
         wL0hgy+Bn8yFBAW/eJr2QUIju2A5A0uzGxkgumcDu8PlpUejxk/g3Sj3Es0pIWPABmCE
         kfYOMy6n4uLxy1l7NrnaLNC5gNrydh9UafUEYy02QmGo0ype0H7SJWD8CR20A4m57iTi
         5B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNHUR7Fg5QDGRpIarkWskOSy3y0TrjYuLGHsjzBlRAo=;
        b=3gJpUtTTVMtVpIu9/Irxd8UhiKfWoWCOrFDcuHKfW57XHz5nsAtV3U8X537KUp9rxm
         VUA2ktFMhdlOPNHIL25ITBdPJyJIPljCesOPUn2X0JrAoc0lUnmDbULJaKyoABjoPaR3
         6NkhbVCZl7L6aK5MB4RN6GzZhNKXx7Uymi9vBmcCJQJomHh679XJwz6gaj6pq1Z77kh8
         9qWlIwqmn1PnvNkyORIirHy7KB5pDwQvbIjNCLWV6O3EF14D40NnlMcWYjhj8J1JXBE8
         j2zp6U7nM4I/89T1HgIha1ApZ8qJ60YT6MTiW3DNOqyU3GppGiKYnpW3aX+vDUNhfbLd
         8jzA==
X-Gm-Message-State: AOAM533mFk/IcEmodbUJrIlmmb4F1cGS8emLUpH+14OVgOgApmM0HVjO
        a/SQKA/hAbSUKrCqp3Fci1w=
X-Google-Smtp-Source: ABdhPJwPVfkQTtHAoOKm9M7ZSL/CeumUC6EL5tdqExgWenSqW3DqIdtgkCnbpDyjZg8VxvzdDCEQWg==
X-Received: by 2002:a05:6512:ac3:b0:443:d3e3:db0a with SMTP id n3-20020a0565120ac300b00443d3e3db0amr4491196lfu.298.1646955209984;
        Thu, 10 Mar 2022 15:33:29 -0800 (PST)
Received: from dell.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id s5-20020ac24645000000b00448628b8462sm598481lfo.249.2022.03.10.15.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:33:29 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Paul Walmsley <paul@pwsan.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 2/4] ARM: OMAP1: clock: Remove noop code
Date:   Fri, 11 Mar 2022 00:33:05 +0100
Message-Id: <20220310233307.99220-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310233307.99220-1-jmkrzyszt@gmail.com>
References: <20220310233307.99220-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some OMAP1 clock code bits that have no effect:
- crystal_type variable is set to 0 but never changed, then
  crystal_type == 2 condition is never true and ck_ref.rate never set to
  19200000,
- clk->ops->allow_idle() is called from omap_clk_enable_autoidle_all() but
  that op is not configured for any clock, then the function does nothing
  and the op field is not needed,
- ENABLE_ON_INIT flag is set for some clocks but is never checked by any
  code, then not needed.
Drop that code.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/clock.c      | 17 -----------------
 arch/arm/mach-omap1/clock.h      |  3 ---
 arch/arm/mach-omap1/clock_data.c |  8 +-------
 3 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 5622ad487c8b..da74c09a71de 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -798,22 +798,6 @@ void clk_unregister(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_unregister);
 
-int omap_clk_enable_autoidle_all(void)
-{
-	struct clk *c;
-	unsigned long flags;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-
-	list_for_each_entry(c, &clocks, node)
-		if (c->ops->allow_idle)
-			c->ops->allow_idle(c);
-
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return 0;
-}
-
 /*
  * Low level helpers
  */
@@ -871,7 +855,6 @@ static int __init clk_disable_unused(void)
 	return 0;
 }
 late_initcall(clk_disable_unused);
-late_initcall(omap_clk_enable_autoidle_all);
 #endif
 
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 7bebd488f1be..8025e4a22469 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -53,7 +53,6 @@ struct omap_clk {
 struct clkops {
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
-	void			(*allow_idle)(struct clk *);
 };
 
 /*
@@ -64,7 +63,6 @@ struct clkops {
 #define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
 #define CLOCK_IDLE_CONTROL	(1 << 1)
 #define CLOCK_NO_IDLE_PARENT	(1 << 2)
-#define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
 
 /**
  * struct clk - OMAP struct clk
@@ -135,7 +133,6 @@ extern void clk_unregister(struct clk *clk);
 extern void propagate_rate(struct clk *clk);
 extern unsigned long followparent_recalc(struct clk *clk);
 unsigned long omap_fixed_divisor_recalc(struct clk *clk);
-extern int omap_clk_enable_autoidle_all(void);
 
 extern const struct clkops clkops_null;
 
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 3ebcd96efbff..d55e4af7932e 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -93,8 +93,7 @@ static struct arm_idlect1_clk ck_dpll1out = {
 		.name		= "ck_dpll1out",
 		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IDLE_CONTROL | ENABLE_REG_32BIT |
-				  ENABLE_ON_INIT,
+		.flags		= CLOCK_IDLE_CONTROL | ENABLE_REG_32BIT,
 		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
@@ -147,7 +146,6 @@ static struct clk arm_gpio_ck = {
 	.name		= "ick",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
-	.flags		= ENABLE_ON_INIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 	.enable_bit	= EN_GPIOCK,
 	.recalc		= &followparent_recalc,
@@ -317,7 +315,6 @@ static struct clk tc2_ck = {
 	.name		= "tc2_ck",
 	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
-	.flags		= ENABLE_ON_INIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
 	.enable_bit	= EN_TC2_CK,
 	.recalc		= &followparent_recalc,
@@ -763,7 +760,6 @@ u32 cpu_mask;
 int __init omap1_clk_init(void)
 {
 	struct omap_clk *c;
-	int crystal_type = 0; /* Default 12 MHz */
 	u32 reg;
 
 #ifdef CONFIG_DEBUG_LL
@@ -811,8 +807,6 @@ int __init omap1_clk_init(void)
 
 	if (cpu_is_omap7xx())
 		ck_ref.rate = 13000000;
-	if (cpu_is_omap16xx() && crystal_type == 2)
-		ck_ref.rate = 19200000;
 
 	pr_info("Clocks: ARM_SYSST: 0x%04x DPLL_CTL: 0x%04x ARM_CKCTL: 0x%04x\n",
 		omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
-- 
2.35.1

