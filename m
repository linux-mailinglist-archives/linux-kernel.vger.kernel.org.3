Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70A44FC058
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347844AbiDKPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347803AbiDKPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:23:35 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DB43B3E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:21:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m33-20020a05600c3b2100b0038ec0218103so1081602wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bScrnygALRi5vTrh1+NEViI6Wv9mGSCg+5NQG0F9hNU=;
        b=nbUlIipH447q4p1olQkERIU5utdBTNQHTWPMFDAkNy2NItph72BhUi1iPTdKXoK8q3
         ndq1dhXVf/bQkIm7s/u+CC2wZ8vaTGwKE4FiWga8d3pJDKR9u0e1s5qzjvVAGW796ZDs
         AVf5TP434mnO1UPvySossJuBDChpNQ7aS/WQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bScrnygALRi5vTrh1+NEViI6Wv9mGSCg+5NQG0F9hNU=;
        b=byEYSZsO9oWS3zQqJAboFgvFSfiYguCBXTha1q2/zCLFqTbWGN4x4WNBVAO+JFntOV
         tqjG1GNQx+AhyHLjbwUCgmWxzLdZczrDiYaKJFBhHgomi6Bwk64LzBmCR801wwwZQr3Q
         zWm6wm0kQ361JigXTTKnz/U5z+AwCb5fyt1mRkicXqx/ktZPpI7p8GouyqV1l76WsafZ
         mMiNoGA2lZT1e2rERPaAFFmZB20CS8Kh8NKl4/g3zdIfbyGr9IDeC2bP/5be4SRzapCU
         4LO8CjylgLku3/nv2D9NPdUOY6MdcRW8wA9ANR4+T6yc0xvw06SjRKOYcRxCOjODmNqX
         b6tw==
X-Gm-Message-State: AOAM5308/2YZAb7zByPAk637rgS2jCXUs1qXnyhnRZGRs+KMkeP3TFqG
        7cfOw1JpdwqZ7NX1HR+z9O0Jxw==
X-Google-Smtp-Source: ABdhPJzczSgt8EiKjb99yes0LTdyZkyH+uu1QJ1RmijAByejxq91exHGaEDjuIqrhJkNPcRpyO1EAQ==
X-Received: by 2002:a05:600c:1990:b0:38e:a8c9:f32f with SMTP id t16-20020a05600c199000b0038ea8c9f32fmr15105198wmq.35.1649690478709;
        Mon, 11 Apr 2022 08:21:18 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm19512832wrb.63.2022.04.11.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:21:18 -0700 (PDT)
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
Subject: [PATCH v3 2/4] drivers: pwm: pwm-cros-ec: add channel type support
Date:   Mon, 11 Apr 2022 15:21:12 +0000
Message-Id: <20220411152114.2165933-3-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
In-Reply-To: <20220411152114.2165933-1-fabiobaltieri@chromium.org>
References: <20220411152114.2165933-1-fabiobaltieri@chromium.org>
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

To use it, define the node with the "google,cros-ec-pwm-type"
compatible.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---
 drivers/pwm/pwm-cros-ec.c | 109 ++++++++++++++++++++++++++++++--------
 1 file changed, 86 insertions(+), 23 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 5e29d9c682c3..83c33958d52b 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -6,23 +6,30 @@
  */
 
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
 
+#include <dt-bindings/mfd/cros_ec.h>
+
+#define OF_CROS_EC_PWM_TYPE ((void *)1)
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
@@ -58,14 +65,31 @@ static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
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
 
@@ -75,14 +99,25 @@ static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
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
@@ -102,8 +137,17 @@ static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
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
@@ -133,7 +177,7 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	duty_cycle = state->enabled ? state->duty_cycle : 0;
 
-	ret = cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
+	ret = cros_ec_pwm_set_duty(ec_pwm, pwm->hwpwm, duty_cycle);
 	if (ret < 0)
 		return ret;
 
@@ -149,7 +193,7 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
 	int ret;
 
-	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
+	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
 	if (ret < 0) {
 		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
 		return;
@@ -204,13 +248,13 @@ static const struct pwm_ops cros_ec_pwm_ops = {
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
@@ -232,10 +276,27 @@ static int cros_ec_num_pwms(struct cros_ec_device *ec)
 	return U8_MAX;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id cros_ec_pwm_of_match[] = {
+	{
+		.compatible = "google,cros-ec-pwm",
+	},
+	{
+		.compatible = "google,cros-ec-pwm-type",
+		.data = OF_CROS_EC_PWM_TYPE,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
+#else
+#define cros_ec_pwm_of_match NULL
+#endif
+
 static int cros_ec_pwm_probe(struct platform_device *pdev)
 {
 	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
+	const struct of_device_id *id;
 	struct cros_ec_pwm_device *ec_pwm;
 	struct pwm_chip *chip;
 	int ret;
@@ -251,17 +312,27 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	chip = &ec_pwm->chip;
 	ec_pwm->ec = ec;
 
+	id = of_match_device(cros_ec_pwm_of_match, dev);
+	if (id && id->data == OF_CROS_EC_PWM_TYPE)
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
@@ -285,14 +356,6 @@ static int cros_ec_pwm_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id cros_ec_pwm_of_match[] = {
-	{ .compatible = "google,cros-ec-pwm" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
-#endif
-
 static struct platform_driver cros_ec_pwm_driver = {
 	.probe = cros_ec_pwm_probe,
 	.remove = cros_ec_pwm_remove,
-- 
2.35.1.1178.g4f1659d476-goog

