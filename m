Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9524D2790
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiCIBzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiCIBzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:55:10 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66AF9E032;
        Tue,  8 Mar 2022 17:54:10 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:34660.93913698
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-39.156.73.14 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 0F014100132;
        Wed,  9 Mar 2022 09:53:43 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id 5628fe8fc4034f1fac611907918a9439 for johan@kernel.org;
        Wed, 09 Mar 2022 09:54:09 CST
X-Transaction-ID: 5628fe8fc4034f1fac611907918a9439
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, elder@ieee.org
Cc:     Song Chen <chensong_2000@189.cn>
Subject: [PATCH v4] staging: greybus: introduce pwm_ops::apply
Date:   Wed,  9 Mar 2022 09:59:34 +0800
Message-Id: <1646791174-30557-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce newer .apply function in pwm_ops to
replace legacy operations,like enable, disable,
config and set_polarity.

This guarantees atomic changes of the pwm
controller configuration and also reduces the
size of the driver.

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

v4:
1, explain why legacy operations are replaced.
2, cap the value of period and duty to U32_MAX
---
 drivers/staging/greybus/pwm.c | 59 +++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 891a6a672378..3add3032678b 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -204,43 +204,54 @@ static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
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
 
-static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-			       enum pwm_polarity polarity)
-{
-	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
+	if (!state->enabled) {
+		if (enabled)
+			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
+		return 0;
+	}
 
-	return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
-};
+	/* set period and duty cycle*/
+	if (period > U32_MAX)
+		period = U32_MAX;
 
-static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
+	if (duty_cycle > period)
+		duty_cycle = period;
 
-	return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
-};
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

