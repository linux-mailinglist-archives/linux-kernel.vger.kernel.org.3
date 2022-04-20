Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A681D508A99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379488AbiDTOTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380283AbiDTOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:18:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9B943AE9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:16:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r187-20020a1c44c4000000b0038ccb70e239so3785363wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObecURUna9Qwp1jlmemsZMBt2OPXmb3XIGOTXF8U8Dg=;
        b=lWkesEjNpEMRFzzmw5mznQmKLYgm0N2fxvFB59LDEX0uBuR4/Y0Y1AdPMcarWTboXw
         ZXNkCHP3VPUQFHaGIfKKRO+c+s/Nab6N0jjv4hI6vERXlzjp5JShhl43S0xetpflEO7z
         llsRZBfwYDZuadM9j1syMMUBLT8ohr809s84Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObecURUna9Qwp1jlmemsZMBt2OPXmb3XIGOTXF8U8Dg=;
        b=yFGgZ7vNuAoAmF7no3LNZP72OEhSiNjEA146pjlk/MRL1Zx7nqF6I8O9OenqO0Qyba
         8TCRugpnbkQolSf6h3Q7V7kl982RWzO1KaGtpaPiRtwXrL8EwiFJNEa3VdVc72f/jIL6
         cEsvpkRFRsZIytsVlxZ+iWDTpa84YoU5SGELyfk6BjnbbC4rfRudYl1t8SfC6/gjkn9h
         v7p3NsyCrwusdjAgyV7G0u1cK3pISOjwekwqUgc+aBbn64h/rkMG4ODSeQ2rLLM6bk8D
         ClJ5Gy6MKdR7MXiBpZ97yekK1LSbvVpLJXBzkeUHdvtxS8LN6gSZa3V62ShaGEe5W0HG
         ncLg==
X-Gm-Message-State: AOAM531gbAtjzSoI2CHy1Jzc5hT4SQb0iGANJ7yn89VZ7ohYq8XYIZ1c
        JsvUA7/8A+IfwxVq3hnK+Wuspg==
X-Google-Smtp-Source: ABdhPJzI3RZrAS55TPGVfRyM82Jjk72vfI9ZUmQqB6WLQLVpiVXgPr1Z9oTCCSf2Eehukff/l2jVlw==
X-Received: by 2002:a05:600c:5025:b0:38f:f782:253c with SMTP id n37-20020a05600c502500b0038ff782253cmr4089853wmr.42.1650464160897;
        Wed, 20 Apr 2022 07:16:00 -0700 (PDT)
Received: from localhost.localdomain ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b0020aa790a258sm12447wra.8.2022.04.20.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:16:00 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v5 2/4] pwm: pwm-cros-ec: add channel type support
Date:   Wed, 20 Apr 2022 14:15:54 +0000
Message-Id: <20220420141556.681212-3-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220420141556.681212-1-fabiobaltieri@chromium.org>
References: <20220420141556.681212-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for EC_PWM_TYPE_DISPLAY_LIGHT and EC_PWM_TYPE_KB_LIGHT pwm
types to the PWM cros_ec_pwm driver. This allows specifying one of these
PWM channel by functionality, and let the EC firmware pick the correct
channel, thus abstracting the hardware implementation from the kernel
driver.

To use it, define the node with the "google,cros-ec-pwm-type"
compatible.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/pwm/pwm-cros-ec.c | 82 ++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 5e29d9c682c3..7f10f56c3eb6 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -12,17 +12,21 @@
 #include <linux/pwm.h>
 #include <linux/slab.h>
 
+#include <dt-bindings/mfd/cros_ec.h>
+
 /**
  * struct cros_ec_pwm_device - Driver data for EC PWM
  *
  * @dev: Device node
  * @ec: Pointer to EC device
  * @chip: PWM controller chip
+ * @use_pwm_type: Use PWM types instead of generic channels
  */
 struct cros_ec_pwm_device {
 	struct device *dev;
 	struct cros_ec_device *ec;
 	struct pwm_chip chip;
+	bool use_pwm_type;
 };
 
 /**
@@ -58,14 +62,31 @@ static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	kfree(channel);
 }
 
-static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
+static int cros_ec_dt_type_to_pwm_type(u8 dt_index, u8 *pwm_type)
 {
+	switch (dt_index) {
+	case CROS_EC_PWM_DT_KB_LIGHT:
+		*pwm_type = EC_PWM_TYPE_KB_LIGHT;
+		return 0;
+	case CROS_EC_PWM_DT_DISPLAY_LIGHT:
+		*pwm_type = EC_PWM_TYPE_DISPLAY_LIGHT;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cros_ec_pwm_set_duty(struct cros_ec_pwm_device *ec_pwm, u8 index,
+				u16 duty)
+{
+	struct cros_ec_device *ec = ec_pwm->ec;
 	struct {
 		struct cros_ec_command msg;
 		struct ec_params_pwm_set_duty params;
 	} __packed buf;
 	struct ec_params_pwm_set_duty *params = &buf.params;
 	struct cros_ec_command *msg = &buf.msg;
+	int ret;
 
 	memset(&buf, 0, sizeof(buf));
 
@@ -75,14 +96,25 @@ static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
 	msg->outsize = sizeof(*params);
 
 	params->duty = duty;
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
+
+	if (ec_pwm->use_pwm_type) {
+		ret = cros_ec_dt_type_to_pwm_type(index, &params->pwm_type);
+		if (ret) {
+			dev_err(ec->dev, "Invalid PWM type index: %d\n", index);
+			return ret;
+		}
+		params->index = 0;
+	} else {
+		params->pwm_type = EC_PWM_TYPE_GENERIC;
+		params->index = index;
+	}
 
 	return cros_ec_cmd_xfer_status(ec, msg);
 }
 
-static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
+static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm, u8 index)
 {
+	struct cros_ec_device *ec = ec_pwm->ec;
 	struct {
 		struct cros_ec_command msg;
 		union {
@@ -102,8 +134,17 @@ static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
 	msg->insize = sizeof(*resp);
 	msg->outsize = sizeof(*params);
 
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
+	if (ec_pwm->use_pwm_type) {
+		ret = cros_ec_dt_type_to_pwm_type(index, &params->pwm_type);
+		if (ret) {
+			dev_err(ec->dev, "Invalid PWM type index: %d\n", index);
+			return ret;
+		}
+		params->index = 0;
+	} else {
+		params->pwm_type = EC_PWM_TYPE_GENERIC;
+		params->index = index;
+	}
 
 	ret = cros_ec_cmd_xfer_status(ec, msg);
 	if (ret < 0)
@@ -133,7 +174,7 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	duty_cycle = state->enabled ? state->duty_cycle : 0;
 
-	ret = cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
+	ret = cros_ec_pwm_set_duty(ec_pwm, pwm->hwpwm, duty_cycle);
 	if (ret < 0)
 		return ret;
 
@@ -149,7 +190,7 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
 	int ret;
 
-	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
+	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
 	if (ret < 0) {
 		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
 		return;
@@ -204,13 +245,13 @@ static const struct pwm_ops cros_ec_pwm_ops = {
  * of PWMs it supports directly, so we have to read the pwm duty cycle for
  * subsequent channels until we get an error.
  */
-static int cros_ec_num_pwms(struct cros_ec_device *ec)
+static int cros_ec_num_pwms(struct cros_ec_pwm_device *ec_pwm)
 {
 	int i, ret;
 
 	/* The index field is only 8 bits */
 	for (i = 0; i <= U8_MAX; i++) {
-		ret = cros_ec_pwm_get_duty(ec, i);
+		ret = cros_ec_pwm_get_duty(ec_pwm, i);
 		/*
 		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
 		 * responses; everything else is treated as an error.
@@ -236,6 +277,7 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 {
 	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
 	struct cros_ec_pwm_device *ec_pwm;
 	struct pwm_chip *chip;
 	int ret;
@@ -251,17 +293,26 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	chip = &ec_pwm->chip;
 	ec_pwm->ec = ec;
 
+	if (of_device_is_compatible(np, "google,cros-ec-pwm-type"))
+		ec_pwm->use_pwm_type = true;
+
 	/* PWM chip */
 	chip->dev = dev;
 	chip->ops = &cros_ec_pwm_ops;
 	chip->of_xlate = cros_ec_pwm_xlate;
 	chip->of_pwm_n_cells = 1;
-	ret = cros_ec_num_pwms(ec);
-	if (ret < 0) {
-		dev_err(dev, "Couldn't find PWMs: %d\n", ret);
-		return ret;
+
+	if (ec_pwm->use_pwm_type) {
+		chip->npwm = CROS_EC_PWM_DT_COUNT;
+	} else {
+		ret = cros_ec_num_pwms(ec_pwm);
+		if (ret < 0) {
+			dev_err(dev, "Couldn't find PWMs: %d\n", ret);
+			return ret;
+		}
+		chip->npwm = ret;
 	}
-	chip->npwm = ret;
+
 	dev_dbg(dev, "Probed %u PWMs\n", chip->npwm);
 
 	ret = pwmchip_add(chip);
@@ -288,6 +339,7 @@ static int cros_ec_pwm_remove(struct platform_device *dev)
 #ifdef CONFIG_OF
 static const struct of_device_id cros_ec_pwm_of_match[] = {
 	{ .compatible = "google,cros-ec-pwm" },
+	{ .compatible = "google,cros-ec-pwm-type" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
-- 
2.36.0.rc0.470.gd361397f0d-goog

