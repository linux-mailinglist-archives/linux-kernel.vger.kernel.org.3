Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9035225AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiEJUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiEJUnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:43:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D152A0A63;
        Tue, 10 May 2022 13:43:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i10so66143lfg.13;
        Tue, 10 May 2022 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjdss2nDLwTNuuaVgZiKsX3zSboMMew4d/2NFU3vAvY=;
        b=dNSTjHEou78efjVQDZSF5xKhdufKPu0FPhaijaVB6PNcvXextvCJazQhEaa+Sr7dvK
         stcTpMC0bqq7DCIIMPQJR6LUZjI4f8FVT9fajtdbdtmFC8dyVCAhKl1DnDfhJoL+6vAP
         X8obXslZQTwoP4Fj+rKcHBa3AAMOoFL99htU7HD8cCO2/Ytx+CaZxGeBq2XH/++5jQPi
         u964htH01eIC8ayJE8r3Abr6KHZT8zr6tjaEcdZs07yragttLOswLRPBVZcrJXk7VwE1
         1FvvhyXt+NbmPmc+XyRraSBZHrzKuH93ZnybcxUlq0bgDO0Fb/fdgVKkbVMgcTJXv/Bk
         AxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjdss2nDLwTNuuaVgZiKsX3zSboMMew4d/2NFU3vAvY=;
        b=AxjXXAhb2Bvb/QNWhRIVLmPsK80eaNs8g2pOCS7oB/Jyq2V/r9YW2KYB2FqobuK/HQ
         IdQV/J8FflywsB2vcr8bYXqVCMjG7cuSjk8X7Nupke5fz3+U5366MUyCsdCQ6vkhAZbB
         XV3SMNIdirrr7tNoXdE68gkzN6e3UANK+GxdUu2Uwl2+/PCQC339lIV62T9JKvNCso3m
         nt4P9xQKRbsV5KOq5anJdkVRc7j3IJSJk1tACtloB7eQS3GKrFuaey2dvhymO8QIcMD8
         plgOS2GhhPEcWFkSsLAUnmNx6foniUAxShbmRXR3vZVxXvARkSS9r1qQ5OKgdlXliuUT
         u6mw==
X-Gm-Message-State: AOAM53338BWP81anVu+qb0NCUGZRsT5LP07No81SSBBK6N8UMGJ5sMG8
        BNbeQht8a8zqioWTxiI5VDM4Q1osdhY=
X-Google-Smtp-Source: ABdhPJwLOJTxRIuT+ffLy8rAJ16AGYPcZ4VaS2+jMJIGEtDE+09rH7E3kdOnw1mneeYjtGnTGbjfXw==
X-Received: by 2002:a05:6512:3390:b0:472:1a4d:ad14 with SMTP id h16-20020a056512339000b004721a4dad14mr17763054lfg.521.1652215416724;
        Tue, 10 May 2022 13:43:36 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 10-20020ac25f4a000000b0047255d210f0sm12318lfz.31.2022.05.10.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:43:36 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/5] proximity: vl53l0x: Handle the reset GPIO
Date:   Tue, 10 May 2022 23:42:55 +0300
Message-Id: <20220510204256.8874-5-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510204256.8874-1-markuss.broks@gmail.com>
References: <20220510204256.8874-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the GPIO connected to the XSHUT/RST_N pin of VL53L0X.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 74aeb2548ef6..47022bc1504e 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -43,6 +44,7 @@ struct vl53l0x_data {
 	struct i2c_client *client;
 	struct completion completion;
 	struct regulator *vdd_supply;
+	struct gpio_desc *reset_gpio;
 };
 
 static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
@@ -192,6 +194,8 @@ static void vl53l0x_power_off(void *_data)
 {
 	struct vl53l0x_data *data = _data;
 
+	gpiod_set_value_cansleep(data->reset_gpio, 1);
+
 	regulator_disable(data->vdd_supply);
 }
 
@@ -203,6 +207,8 @@ static int vl53l0x_power_on(struct vl53l0x_data *data)
 	if (ret)
 		return ret;
 
+	gpiod_set_value_cansleep(data->reset_gpio, 0);
+
 	usleep_range(3200, 5000);
 
 	return 0;
@@ -232,6 +238,11 @@ static int vl53l0x_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
 				     "Unable to get VDD regulator\n");
 
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
+				     "Cannot get reset GPIO\n");
+
 	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
 	if (error)
 		return dev_err_probe(&client->dev, error,
-- 
2.35.1

