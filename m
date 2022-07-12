Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ADA571670
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiGLKBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiGLKBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:01:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B19AAB1D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:01:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a5so10418250wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHCGiaNr3aif8aeEvr8zpBcHltb8NjCKc/JcHxgZJu4=;
        b=IgHIXIjFgQgQSr38iFd2NoGvaTsv8OWBBcDc1sH7Yt2b1NuYSMQAyJbpTJC2s14o4L
         Fqx98/EIwCObU8Bx6syIyhLUrlXgYCPfqtWeq4juQylZldpIVxurpNrvT5GyLoDNRFOd
         ZNic2PKz0YaV/SJs4S7M/+N7FXsOzJDmeYvdYiIKGuJX/YmvZIyyXsCYM5fK1fxP6/ao
         dATG/yeBF+02SlN/lDJVEd3UNTRO3q9IDsGzchl6vgqJfngTXCcl31t7H8LZcueM5pq6
         bQru6KHHQ+C8mvYuC+W0qTbno/0hrdSDPbpcCYTvBuQ4H51zLt+UfezIlf+pXXuQNVXp
         TJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHCGiaNr3aif8aeEvr8zpBcHltb8NjCKc/JcHxgZJu4=;
        b=Es/BUgSCsS4IrcjSTSsPRNb1NzhW9/sBw8Hhv9YE4eNG80670Ig6/4Hb7WvWq7hpSa
         EgvGe12kTdS7/EYA1G4qUbWpJnntVsK3z+UllM1mm2BwR+S2pn8HYLxUTohi6MWZhvw6
         DJfk4rzGxOi1RquACkX1ojFA5Z5tQcKuelKgE70Ct1vJKDNii4wsl7v4z/h38Jqx3Nch
         B1dRmXZne9tnhJdv4y00o7bLty47iqVRpJa8YuNQy+yBa08xV1gQyGQgWjdRy/dBmpHX
         qkMZN+7LFQOLRYZ/mxKmaCNZNUeXm6h6GfVTasY2Eta67U/sDZ05SGkRQwCGREZh08cG
         rCBw==
X-Gm-Message-State: AJIora8gj88Xorhe4wyB9yETwSth89WMRgiFOLr/Eo3GVrevtHMGUkUZ
        09BvDG+zm5T56gQrEXXTJ0n96A==
X-Google-Smtp-Source: AGRyM1sd3/yMZeWKXTHC3/S81sz6aQwLxkVeorSU+2ptnUvfZ35T3sWpgQgcJOgbphAa08l7M8nAkA==
X-Received: by 2002:adf:f345:0:b0:21d:6a26:6d8f with SMTP id e5-20020adff345000000b0021d6a266d8fmr21644792wrp.538.1657620080841;
        Tue, 12 Jul 2022 03:01:20 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id u9-20020a7bc049000000b0039747cf8354sm8895314wmc.39.2022.07.12.03.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:01:20 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 6/7] pwm: dwc: remove the CONFIG_OF in timer clock
Date:   Tue, 12 Jul 2022 11:01:12 +0100
Message-Id: <20220712100113.569042-7-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712100113.569042-1-ben.dooks@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should probably change from the #ifdef added earlier in
49a0f4692a8752c7b03cb26d54282bee5c8c71bb ("wm: dwc: add timer clock")
and just have it always in the dwc data so if we have a system with
both PCI and OF probing it should work

-- consider merging with original patch
---
 drivers/pwm/pwm-dwc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index aa0486b89bdd..6a4364a5d137 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -37,12 +37,6 @@
 
 #define DWC_TIMERS_TOTAL	8
 
-#ifndef CONFIG_OF
-#define DWC_CLK_PERIOD_NS	10
-#else
-#define DWC_CLK_PERIOD_NS	dwc->clk_ns
-#endif
-
 /* Timer Control Register */
 #define DWC_TIM_CTRL_EN		BIT(0)
 #define DWC_TIM_CTRL_MODE	BIT(1)
@@ -104,13 +98,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * periods and check are the result within HW limits between 1 and
 	 * 2^32 periods.
 	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
+	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	low = tmp - 1;
 
 	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    DWC_CLK_PERIOD_NS);
+				    dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	high = tmp - 1;
@@ -185,12 +179,12 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
 	duty += 1;
-	duty *= DWC_CLK_PERIOD_NS;
+	duty *= dwc->clk_ns;
 	state->duty_cycle = duty;
 
 	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 	period += 1;
-	period *= DWC_CLK_PERIOD_NS;
+	period *= dwc->clk_ns;
 	period += duty;
 	state->period = period;
 
@@ -213,6 +207,7 @@ static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	if (!dwc)
 		return NULL;
 
+	dwc->clk_ns = 10;
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
-- 
2.35.1

