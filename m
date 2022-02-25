Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755CD4C40F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiBYJK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiBYJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:10:56 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BD2A252917;
        Fri, 25 Feb 2022 01:10:23 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.43:41026.848260822
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.43 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 387FD1001B5;
        Fri, 25 Feb 2022 17:10:21 +0800 (CST)
Received: from  ([123.150.8.43])
        by gateway-153622-dep-749df8664c-nmrf6 with ESMTP id 75c1cd44fa064a4c95e0a92083346293 for johan@kernel.org;
        Fri, 25 Feb 2022 17:10:22 CST
X-Transaction-ID: 75c1cd44fa064a4c95e0a92083346293
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.43
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, elder@ieee.org
Cc:     Song Chen <chensong_2000@189.cn>
Subject: [PATCH v3] staging: greybus: introduce pwm_ops::apply
Date:   Fri, 25 Feb 2022 17:16:01 +0800
Message-Id: <1645780561-18481-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce apply in pwm_ops to replace legacy operations,
like enable, disable, config and set_polarity.

Signed-off-by: Song Chen <chensong_2000@189.cn>

---
v2:
1, define duty_cycle and period as u64 in gb_pwm_config_operation.
2, define duty and period as u64 in gb_pwm_config_request.
3, disable before configuring duty and period if the eventual goal
   is a disabled state.

v3:
Regarding duty_cycle and period, I read more discussion in this thread,
min, warn or -EINVAL, seems no perfect way acceptable for everyone.
How about we limit their value to INT_MAX and throw a warning at the
same time when they are wrong?
---
 drivers/staging/greybus/pwm.c | 66 +++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 891a6a672378..3ec5bc54d616 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -204,43 +204,57 @@ static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
 }
 
-static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			 int duty_ns, int period_ns)
+static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			const struct pwm_state *state)
 {
+	int err;
+	bool enabled = pwm->state.enabled;
+	u64 period = state->period;
+	u64 duty_cycle = state->duty_cycle;
 	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 
-	return gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_ns, period_ns);
-};
-
-static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-			       enum pwm_polarity polarity)
-{
-	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
-
-	return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
-};
+	/* set polarity */
+	if (state->polarity != pwm->state.polarity) {
+		if (enabled) {
+			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
+			enabled = false;
+		}
+		err = gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, state->polarity);
+		if (err)
+			return err;
+	}
 
-static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
+	if (!state->enabled) {
+		if (enabled)
+			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
+		return 0;
+	}
 
-	return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
-};
+	/* set period and duty cycle*/
+	if (period > INT_MAX) {
+		period = INT_MAX;
+		dev_warn(chip->dev, "period is %llu ns, out of range\n", state->period);
+	}
+	if (duty_cycle > INT_MAX) {
+		duty_cycle = INT_MAX;
+		dev_warn(chip->dev,
+			 "duty cycle is %llu ns, out of range\n", state->duty_cycle);
+	}
+	err = gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_cycle, period);
+	if (err)
+		return err;
 
-static void gb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
+	/* enable/disable */
+	if (!enabled)
+		return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
 
-	gb_pwm_disable_operation(pwmc, pwm->hwpwm);
-};
+	return 0;
+}
 
 static const struct pwm_ops gb_pwm_ops = {
 	.request = gb_pwm_request,
 	.free = gb_pwm_free,
-	.config = gb_pwm_config,
-	.set_polarity = gb_pwm_set_polarity,
-	.enable = gb_pwm_enable,
-	.disable = gb_pwm_disable,
+	.apply = gb_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.25.1

