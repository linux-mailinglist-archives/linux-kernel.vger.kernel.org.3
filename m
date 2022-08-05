Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C911158AE73
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbiHEQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbiHEQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:50:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81528E01
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:50:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m41-20020a05600c3b2900b003a4e094256eso1545695wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yBJp61T732NhGvuYuS8ssmWnNYi45D7jFrvNVeym7no=;
        b=LUgQeOOwftQJP0tKGwJY1ZErHDgZUvn4JHdWsZOolJMRDJPF33KXTjxkBQjFIU0GQt
         YfEAVlMNTTy2rCodHHTHKM4yTERMMIimuLasIyIRLPe69kjbnSvZlV0qVFiR+oMnEKE5
         eM/NYISQApci32tIh1y2eBx50mc8+03wgBXPGkWtW8+zqmwgshsy+8CQMUXtS+ChE9Vn
         IyOE5RiHl0iEsfROzcLquyDInSs2SVs6oOT8OdFCzMzEU4085GX6Wf5ci9eACkF4ZUBK
         i3hpu2/Y0JFdLpwd0x+hvDfPGl9S9S/BhS7oyqaZExY/jnlhHxROpw+JkyCejYVww/Ik
         dL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yBJp61T732NhGvuYuS8ssmWnNYi45D7jFrvNVeym7no=;
        b=iymediTGUSmXXLORHXZS/O68fTPVl5OkuUvttj8334t91w/BvN2/U6KP7K3TagSvJN
         SGuk3LGujp5VmDqyogN68Slq7rGBZpW0UxxVFk8A1C2iQTtUBBd6S9sWwKE8lsacSL+I
         wHeTCdwI/I+d6Rp5bIYxK+bYeaUMIJHRXTRHFnjbw7jHcASbDYyQPfexX8EW1M9Sd3PP
         Kkyfi7bySAhnf/8tCoIC+iA4q4JggTIrSKiOi/sXmAn89fUzOlLCFYW6Q0cEplYdppCE
         vIblWzMCSdCg0R9bjaCEkCMNKa2kLqzeuocElmsKF3jyMlsEqgNc51Yx4BxdSK4P8c1t
         pYbA==
X-Gm-Message-State: ACgBeo1M/e2AG60Ze+erUgONGjEA7tyqQINIMz2A/K9fWBKQ1umr6sum
        xilwx1/2wRkHr3ZR+mqYiDCm6g==
X-Google-Smtp-Source: AA6agR4PJ6FvfUDry8dDMg/k/gZ2UHnGi7IpK1O00WLhlYJzCF6UAcvJhmmLLVY1R3TAfAXGSTClqw==
X-Received: by 2002:a05:600c:a18f:b0:3a5:174e:d650 with SMTP id id15-20020a05600ca18f00b003a5174ed650mr3463797wmb.47.1659718249542;
        Fri, 05 Aug 2022 09:50:49 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm11325374wmc.34.2022.08.05.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:50:49 -0700 (PDT)
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
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 8/8] pwm: dwc: add PWM bit unset in get_state call
Date:   Fri,  5 Aug 2022 17:50:33 +0100
Message-Id: <20220805165033.140958-9-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805165033.140958-1-ben.dooks@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
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
 drivers/pwm/pwm-dwc.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 5edfb8f8acbf..49e666be7afd 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -171,23 +171,35 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
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
+		duty = ld;
+		duty += 1;
+		duty *= dwc->clk_ns;
+
+		period = ld2;
+		period += 1;
+		period *= dwc->clk_ns;
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

