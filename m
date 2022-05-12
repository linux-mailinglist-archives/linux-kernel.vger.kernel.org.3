Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876D7524B05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352982AbiELLIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352975AbiELLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:08:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F795AA66;
        Thu, 12 May 2022 04:08:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d15so8413239lfk.5;
        Thu, 12 May 2022 04:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rn+hZ1SORWL9uzL+yqm22z/NAwpZAv/juhns1YUGhh8=;
        b=ajU/1KslDh5E/JvduAifp/STGz5uzWKx00qJ8v53ttzKhbo9OG3iAW8XCQ+nAxTqzd
         ObDea9lIRsmxwKOXsIMP66Yn6U+ir+TM4Sw9TWaHTHVkfxN4BC5L0PI6JPVUKV1Z6oKf
         a/fIv2yTNeSqMgk8CNEBbkqEag6f2sa4BV5zj5LT9gQ+mzqJcz1p597Op10gRczAymH6
         7bA3+DYGB8baVyqOGzlnSTNSmmHa9aex1za0ujck3B1c5QkN5C3c8K7kJKwEbOta4KAt
         Abxlk3XfUP5hAusIpx3qweO7sZcvk8jQI/6RscwjcXixXBqEMX1YQ1BiARkaC51R9IcK
         lZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rn+hZ1SORWL9uzL+yqm22z/NAwpZAv/juhns1YUGhh8=;
        b=pxVqao5/5kNTe2oa7d2Z/2lQMytftfMZ2ZNM8x48Lep40OwkrSOlKRqNZ2jVFKpUrr
         YqoMHPwYjHQduGoJFvpRRsr8mb9FcUSyQveM+g0AOiBFOXmOWtkZA4ZvWcqdKK+L+cMH
         oolwuKAgrL+SxCkW+OAmY9QrOrkPO52DiE0vtmXCiBSUreQ496XBMnXaFLAKem6MwN1I
         9bAbkt6NxUam0Po2Ut78j93D3C0zeKseu4PQcFcFDU46+Fhm/A3n7W+JnPPIB+l8A4u3
         2xU+/RgQEMAJUUWxU9r3Kbyaqz7qd+YcD06jfovJRoKAiHrZAkMqTCybYehqgq+C89Iu
         mkuQ==
X-Gm-Message-State: AOAM532nEYgIZqF9LuM6KyMOJj9ZdzFpsY8EYo0AAFkxyKvawI8pBlv9
        oi7Hzfei9UPq3cBrGH1gHn05j/MKBiexqA==
X-Google-Smtp-Source: ABdhPJzenfz08JbIBgzG3TB5G7pZLDp9lLFOqPJZCCjMTNdZga3+bPCbT4u8p3xtmKlv/5XCyKf+/Q==
X-Received: by 2002:a05:6512:3d1d:b0:472:625d:b21e with SMTP id d29-20020a0565123d1d00b00472625db21emr23991992lfv.366.1652353695101;
        Thu, 12 May 2022 04:08:15 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i25-20020a056512007900b004725b99d2fdsm734883lfo.164.2022.05.12.04.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:08:14 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
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
Subject: [PATCH v3 3/5] proximity: vl53l0x: Handle the VDD regulator
Date:   Thu, 12 May 2022 14:07:55 +0300
Message-Id: <20220512110757.5297-4-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512110757.5297-1-markuss.broks@gmail.com>
References: <20220512110757.5297-1-markuss.broks@gmail.com>
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

Handle the regulator supplying the VDD pin of VL53L0X.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 37 +++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 12a3e2eff464..d8523e3981e8 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -43,6 +43,7 @@
 struct vl53l0x_data {
 	struct i2c_client *client;
 	struct completion completion;
+	struct regulator *vdd_supply;
 };
 
 static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
@@ -192,10 +193,31 @@ static const struct iio_info vl53l0x_info = {
 	.read_raw = vl53l0x_read_raw,
 };
 
+static void vl53l0x_power_off(void *_data)
+{
+	struct vl53l0x_data *data = _data;
+
+	regulator_disable(data->vdd_supply);
+}
+
+static int vl53l0x_power_on(struct vl53l0x_data *data)
+{
+	int ret;
+
+	ret = regulator_enable(data->vdd_supply);
+	if (ret)
+		return ret;
+
+	usleep_range(3200, 5000);
+
+	return 0;
+}
+
 static int vl53l0x_probe(struct i2c_client *client)
 {
 	struct vl53l0x_data *data;
 	struct iio_dev *indio_dev;
+	int error;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -210,6 +232,21 @@ static int vl53l0x_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EOPNOTSUPP;
 
+	data->vdd_supply = devm_regulator_get_optional(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
+				     "Unable to get VDD regulator\n");
+
+	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
+	if (error)
+		return dev_err_probe(&client->dev, error,
+				     "Failed to install poweroff action\n");
+
+	error = vl53l0x_power_on(data);
+	if (error)
+		return dev_err_probe(&client->dev, error,
+				     "Failed to power on the chip\n");
+
 	indio_dev->name = "vl53l0x";
 	indio_dev->info = &vl53l0x_info;
 	indio_dev->channels = vl53l0x_channels;
-- 
2.36.1

