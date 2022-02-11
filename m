Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160E64B2508
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiBKL5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:57:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349762AbiBKL53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:57:29 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4178F6C;
        Fri, 11 Feb 2022 03:57:13 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:58202.55775679
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.43 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id A2F6C10013E;
        Fri, 11 Feb 2022 19:57:10 +0800 (CST)
Received: from  ([123.150.8.43])
        by gateway-153622-dep-749df8664c-cv9r2 with ESMTP id 08b197ad565642579980e12aa57bf63f for johan@kernel.org;
        Fri, 11 Feb 2022 19:57:12 CST
X-Transaction-ID: 08b197ad565642579980e12aa57bf63f
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.43
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Song Chen <chensong_2000@189.cn>
Subject: [PATCH v2] staging: greybus: introduce pwm_ops::apply
Date:   Fri, 11 Feb 2022 20:02:27 +0800
Message-Id: <1644580947-8529-1-git-send-email-chensong_2000@189.cn>
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

Introduce apply in pwm_ops to replace legacy operations,
like enable, disable, config and set_polarity.

Signed-off-by: Song Chen <chensong_2000@189.cn>

---
V2:
1, define duty_cycle and period as u64 in gb_pwm_config_operation.
2, define duty and period as u64 in gb_pwm_config_request.
3, disable before configuring duty and period if the eventual goal
   is a disabled state.
---
 drivers/staging/greybus/pwm.c             | 61 ++++++++++++-----------
 include/linux/greybus/greybus_protocols.h |  4 +-
 2 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 891a6a672378..03c69db5b9be 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -89,7 +89,7 @@ static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
 }
 
 static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
-				   u8 which, u32 duty, u32 period)
+				   u8 which, u64 duty, u64 period)
 {
 	struct gb_pwm_config_request request;
 	struct gbphy_device *gbphy_dev;
@@ -99,8 +99,8 @@ static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
 		return -EINVAL;
 
 	request.which = which;
-	request.duty = cpu_to_le32(duty);
-	request.period = cpu_to_le32(period);
+	request.duty = duty;
+	request.period = period;
 
 	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
 	ret = gbphy_runtime_get_sync(gbphy_dev);
@@ -204,43 +204,46 @@ static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
 }
 
-static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			 int duty_ns, int period_ns)
+static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			const struct pwm_state *state)
 {
+	int err;
+	bool enabled = pwm->state.enabled;
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
+	err = gb_pwm_config_operation(pwmc, pwm->hwpwm, state->duty_cycle, state->period);
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
 
diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
index aeb8f9243545..81a6f16de098 100644
--- a/include/linux/greybus/greybus_protocols.h
+++ b/include/linux/greybus/greybus_protocols.h
@@ -812,8 +812,8 @@ struct gb_pwm_deactivate_request {
 
 struct gb_pwm_config_request {
 	__u8	which;
-	__le32	duty;
-	__le32	period;
+	__u64	duty;
+	__u64	period;
 } __packed;
 
 struct gb_pwm_polarity_request {
-- 
2.25.1

