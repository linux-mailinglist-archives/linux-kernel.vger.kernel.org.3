Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC0596481
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbiHPVPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiHPVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:15:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52523895C3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n7so2849310wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=phcPBaGxOFAemR9YFsCDrE8yrlHvz+AvjsJ/jn+/KmI=;
        b=D2LBTNDmEF2+Dr1NzlXFxUrarWUqPPataJ7eBvvm12Ez5MuwP9UXnt3hAVGjut9uaW
         10d7KRwvsmRnkblDnIGWGr9woJ/rSO57iN7N5bCNHYrBAjuOcatAK7hi/r7iiB72izxY
         gMkFSK3VpssRb6tFteFowVmh6kBf31UNSAwgB1Upw/iNMmHfIbtzmtvkFRiiry/5CKFL
         JK/gdsnf6uNRrgEMoZnOzMRaAtyONnn1gbXy3s6RP+bPuE6EuuyZ4zgaW5Aj/063xIJE
         iTwG2P79SecEn4QjY+LjHcn/8Hxsv7H5NiNOOMNWaYxGk5kF4CnT/S9F8CfZzq3EjblN
         ErxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=phcPBaGxOFAemR9YFsCDrE8yrlHvz+AvjsJ/jn+/KmI=;
        b=kbvkjIIFJw37HqRK7Vio4LvpF6Pi3FlaKK4kFzvySxfHKo5BUAxZ17tM8wJY7AqVj3
         2VZzUFreDTtXTOzqm2c8tzTMoWayL/tlfU9EVAhuQkzONY272zxibDwHWKD/4LgnfiQ2
         yU2jd40TKOYYU8phgCnRF+7J2r7J5RyoZKU9USgK+0HuR2a44vJRgOO7mApkC6uKmiDY
         PiavmvsrDyrdiA7cteiMkref3rCHeZY/fwZ7yXgTb+/9WC3ExAgOIm3eS/FfigniGRLA
         Z7a/ZNICTXjJGS0PlJCcUDlzB2dYAYpS6Y3gbh+ROc4zGyaKO+3Ff7YtdBlFUQpk7jaH
         HFnA==
X-Gm-Message-State: ACgBeo3BfikGxDGI+vFdeJHalNVrUoTUwqKjLP/az/h3WOVxz5NF+GyB
        5dTLWZxtUwFAjqjW0G8NnUolrw==
X-Google-Smtp-Source: AA6agR7I7O5srqcLe0uvZsPtmDixINs6HcsyX4Rz7ZRgeDlHqmucBoGATsBy2Nq2Jzcldqq8Kaujkw==
X-Received: by 2002:a5d:4b87:0:b0:21e:ffa6:a3a6 with SMTP id b7-20020a5d4b87000000b0021effa6a3a6mr12289683wrt.418.1660684504334;
        Tue, 16 Aug 2022 14:15:04 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:15:04 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [RFC v4 10/10] pwm: dwc: add PWM bit unset in get_state call
Date:   Tue, 16 Aug 2022 22:14:54 +0100
Message-Id: <20220816211454.237751-11-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we are not in PWM mode, then the output is technically a 50%
output based on a single timer instead of the high-low based on
the two counters. Add a check for the PWM mode in dwc_pwm_get_state()
and if DWC_TIM_CTRL_PWM is not set, then return a 50% cycle.

This may only be an issue on initialisation, as the rest of the
code currently assumes we're always going to have the extended
PWM mode using two counters.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v4:
 - fixed review comment on mulit-line calculations
---
 drivers/pwm/pwm-dwc.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 1251620ab771..5ef0fe7ea3e9 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -121,23 +121,30 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	u64 duty, period;
+	u32 ctrl, ld, ld2;
 
 	pm_runtime_get_sync(chip->dev);
 
-	state->enabled = !!(dwc_pwm_readl(dwc,
-				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
+	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
+	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
+	ld2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 
-	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
-	duty += 1;
-	duty *= dwc->clk_ns;
-	state->duty_cycle = duty;
+	state->enabled = !!(ctrl & DWC_TIM_CTRL_EN);
 
-	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
-	period += 1;
-	period *= dwc->clk_ns;
-	period += duty;
-	state->period = period;
+	/* If we're not in PWM, technically the output is a 50-50
+	 * based on the timer load-count only.
+	 */
+	if (ctrl & DWC_TIM_CTRL_PWM) {
+		duty = (ld + 1) * dwc->clk_ns;
+		period = (ld2 + 1)  * dwc->clk_ns;
+		period += duty;
+	} else {
+		duty = (ld + 1) * dwc->clk_ns;
+		period = duty * 2;
+	}
 
+	state->period = period;
+	state->duty_cycle = duty;
 	state->polarity = PWM_POLARITY_INVERSED;
 
 	pm_runtime_put_sync(chip->dev);
-- 
2.35.1

