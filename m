Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17E4EDA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiCaNAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiCaNAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:00:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23735B3D0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:58:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so1662828wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnERuxTpwmIqEKkUGAva/36LeD27jpDMYFwmiCf/45o=;
        b=FDWRdxI76mF4dLFtAAI648zdVhUOPFc4EVL9mY55Hm8emhvXspwcut4lQ9hEQy7dYM
         nRPYfpRFT2MhWNStKi8Sx07jD6TkYplFoo4hWr2bIKq17j2bRTJlcmQ7unT1iku9BJdg
         hzkgzU/NuG7/dYPo4boPHAaDmyUB7fPBGe+1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnERuxTpwmIqEKkUGAva/36LeD27jpDMYFwmiCf/45o=;
        b=7cX1WGbHwwzLnTzabEXH1nG1REzEO557k8Juf8n4gEEFFxfcCVlWIj+0vTL+9lu9OF
         Z0ES88PG7dHtdAyx6a8pItqIvLZCwidWMvf/H7hpP9oFDxr77FolxFJMdefUk4Jul94X
         t36HS9ApLrVga40yObFMKUHlFTLJFvyS5v6lcyLLlTMrR3dg3YnRMR6v1bkJntE6FiT/
         4CY1+0DbiemkVglUKCf/8qFhzNSseLCeQs/ByCHCjfibvj3jVR2rCEhe7kMoa2BnHz0m
         kH0C2prSNhaAO8M8pGCrz61c6g56VicM2p4nno4fTIgMyrXvGOIVjkT8g8ScDMVtek1I
         bAqg==
X-Gm-Message-State: AOAM532Hnq7deobHZjvxjwtrRi2Say6FWwaSqaUFbzi5sXwHd23oQqNw
        rWGx9twlG8QHARN5nVo+RNa3Bw==
X-Google-Smtp-Source: ABdhPJzVVIAmiHVnmlyTZI1yKGbj6Wos/oqQ1UVDOn2sfEpc7PpD6rwUeidkI6nuuNVCsPWGYpWsHA==
X-Received: by 2002:a05:600c:5120:b0:38c:d121:4738 with SMTP id o32-20020a05600c512000b0038cd1214738mr4870920wms.32.1648731503476;
        Thu, 31 Mar 2022 05:58:23 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038c9249ffdesm8230695wmq.9.2022.03.31.05.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:58:23 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH v2 2/4] drivers: pwm: pwm-cros-ec: add channel type support
Date:   Thu, 31 Mar 2022 12:58:16 +0000
Message-Id: <20220331125818.3776912-3-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
In-Reply-To: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
References: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---
 drivers/pwm/pwm-cros-ec.c | 80 +++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 5e29d9c682c3..051791f5d024 100644
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
@@ -251,17 +292,26 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	chip = &ec_pwm->chip;
 	ec_pwm->ec = ec;
 
+	ec_pwm->use_pwm_type = of_property_read_bool(
+			dev->of_node, "google,use-pwm-type");
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
-- 
2.35.1.1021.g381101b075-goog

