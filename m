Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9FC4D66BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350563AbiCKQsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350626AbiCKQsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:48:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072DB1D304B;
        Fri, 11 Mar 2022 08:47:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so11532873pjb.5;
        Fri, 11 Mar 2022 08:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6Q+Wy2M2brgiF/jdgtaKyNivMY4ZkvvX6XkJeHu/zI=;
        b=Fyfp4x7Lot+g1T5t1Ox4uN3lNJkJ59db/xybcnAZMVDp16IL/y3IiHKyITK83+bncm
         qPdFt/TIYRkqaY6ELYB8MEqNq/SkSBxlxIxgHNJ9jaUU8Wuapx5UYOtxO/YEaQInE11d
         a4JLHA2sgMqHg+3S2Hf2ycffh0MV6ie90RnAfzpMr71+HXlWlJoWIjGuWjfFkfrbuKY9
         55xYMfRweGUZB2lwNh6ayTfAB1Rl+qROSgWhGgVNhEnavXyBqQ5gWUB5/ZZ8TH+tAO8b
         IfzTSn4cYHbpZeZF9o1TsQPxt//CDjXMly07qW2viwJCrv49k1aw4S1iYy9vK+d7x1r4
         5ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6Q+Wy2M2brgiF/jdgtaKyNivMY4ZkvvX6XkJeHu/zI=;
        b=6bd86uRLiK3NVA+ogeOc0oSHsGKAQLuw8FEr0ylMtGE7REQkPHWFNA0qqI8Y0t61Oa
         vxNxHJqn0uQwOhFJG5fahdtVf2LinDNHKp837G9w1b3hzmnjmbrcdP59xTpBhIqAid50
         aBrVO0QpSShn00UPNwPAzIq0t4jU3z2uew2mDeJjztnzcr35A29prg0bo8cLkUK1PoQk
         +Oh5RFkPyYHgeqLpwQA6lXB2AIQo2WXHN/Djs1Gr7XUfG6u/5lo/OMrombxizqWz3dmj
         nBtREGSvAiUJlFB8HNbSPQ08MzcSPi1x2x76PX+Nv8IDs+52JMwUpkD5gbQUoyYLCu1X
         I2DQ==
X-Gm-Message-State: AOAM530ses1LUihwXVdpdU3eqCT1hBhdX1eCd65fjWrAxho1QEIGCN/6
        2vOh6bi0MS6YTFCuZFm0ImWFW4/RG7Djlg==
X-Google-Smtp-Source: ABdhPJxvL+CyBzCW//WyQ9LEBtxEx0blbI1bnXWJJJDwPsmYinq4gQwEA7VyFUKQUh9SXmpUaIpv5g==
X-Received: by 2002:a17:90b:3807:b0:1bf:6c8e:f9d1 with SMTP id mq7-20020a17090b380700b001bf6c8ef9d1mr22332812pjb.186.1647017241456;
        Fri, 11 Mar 2022 08:47:21 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm11107869pfx.81.2022.03.11.08.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:47:21 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 7/7] iio: adc: sc27xx: add Ump9620 ADC suspend and resume pm support
Date:   Sat, 12 Mar 2022 00:46:28 +0800
Message-Id: <20220311164628.378849-8-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311164628.378849-1-gengcixi@gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
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

From: Cixi Geng <cixi.geng1@unisoc.com>

Ump9620 ADC suspend and resume pm optimization, configuration
0x6490_ 0350(PAD_ CLK26M_ SINOUT_ PMIC_ 1P8 ) bit 8.

Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 88 ++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index e9b680e9c275..b038b1dfc91f 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -11,6 +11,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 /* PMIC global registers definition */
 #define SC2730_MODULE_EN		0x1808
@@ -83,6 +84,9 @@
 /* ADC default channel reference voltage is 2.8V */
 #define SC27XX_ADC_REFVOL_VDD28		2800000
 
+/* 10s delay before suspending the ADC IP */
+#define SC27XX_ADC_AUTOSUSPEND_DELAY	10000
+
 enum sc27xx_pmic_type {
 	SC27XX_ADC,
 	SC2721_ADC,
@@ -96,6 +100,7 @@ enum ump96xx_scale_cal {
 };
 
 struct sc27xx_adc_data {
+	struct iio_dev *indio_dev;
 	struct device *dev;
 	struct regulator *volref;
 	struct regmap *regmap;
@@ -605,6 +610,9 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 		return ret;
 	}
 
+	if (data->var_data->pmic_type == UMP9620_ADC)
+		pm_runtime_get_sync(data->indio_dev->dev.parent);
+
 	/*
 	 * According to the sc2721 chip data sheet, the reference voltage of
 	 * specific channel 30 and channel 31 in ADC module needs to be set from
@@ -688,6 +696,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 		}
 	}
 
+	if (data->var_data->pmic_type == UMP9620_ADC) {
+		pm_runtime_mark_last_busy(data->indio_dev->dev.parent);
+		pm_runtime_put_autosuspend(data->indio_dev->dev.parent);
+	}
+
 	hwspin_unlock_raw(data->hwlock);
 
 	if (!ret)
@@ -927,9 +940,11 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 
 	/* Enable 26MHz crvstal oscillator wait cycles for UMP9620 ADC */
 	if (data->var_data->pmic_type == UMP9620_ADC) {
-		ret = regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
-					 UMP9620_XTL_WAIT_CTRL0_EN,
-					 UMP9620_XTL_WAIT_CTRL0_EN);
+		pm_runtime_get(data->dev);
+		if (ret) {
+			dev_err(data->dev, "failed to set the UMP9620 ADC clk26m bit8 on IP\n");
+			goto clean_adc_clk26m_bit8;
+		}
 	}
 
 	/* Enable ADC work clock */
@@ -971,6 +986,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	regmap_update_bits(data->regmap, data->var_data->module_en,
 			   SC27XX_MODULE_ADC_EN, 0);
 
+clean_adc_clk26m_bit8:
+	if (data->var_data->pmic_type == UMP9620_ADC)
+		pm_runtime_put(data->dev);
+
 	return ret;
 }
 
@@ -1069,6 +1088,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, indio_dev);
+
 	sc27xx_data = iio_priv(indio_dev);
 
 	sc27xx_data->regmap = dev_get_regmap(dev->parent, NULL);
@@ -1111,7 +1132,10 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 		}
 	}
 
+	sc27xx_data->dev = dev;
 	sc27xx_data->var_data = pdata;
+	sc27xx_data->indio_dev = indio_dev;
+
 	sc27xx_data->var_data->init_scale(sc27xx_data);
 
 	ret = sc27xx_adc_enable(sc27xx_data);
@@ -1126,14 +1150,35 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	indio_dev->dev.parent = dev;
 	indio_dev->name = dev_name(dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &sc27xx_info;
 	indio_dev->channels = sc27xx_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
+
+	if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
+		pm_runtime_set_autosuspend_delay(dev,
+						 SC27XX_ADC_AUTOSUSPEND_DELAY);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_set_suspended(dev);
+		pm_runtime_enable(dev);
+		pm_runtime_get(dev);
+	}
+
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "could not register iio (ADC)");
+		goto err_iio_register;
+	}
+
+	return 0;
+
+err_iio_register:
+	if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
+		pm_runtime_put(dev);
+		pm_runtime_disable(dev);
+	}
 
 	return ret;
 }
@@ -1148,11 +1193,46 @@ static const struct of_device_id sc27xx_adc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
 
+static int sc27xx_adc_runtime_suspend(struct device *dev)
+{
+	struct sc27xx_adc_data *sc27xx_data = iio_priv(dev_get_drvdata(dev));
+
+	/* clean the UMP9620 ADC clk26m bit8 on IP */
+	if (sc27xx_data->var_data->pmic_type == UMP9620_ADC)
+		regmap_update_bits(sc27xx_data->regmap, UMP9620_XTL_WAIT_CTRL0,
+				UMP9620_XTL_WAIT_CTRL0_EN, 0);
+
+	return 0;
+}
+
+static int sc27xx_adc_runtime_resume(struct device *dev)
+{
+	int ret = 0;
+	struct sc27xx_adc_data *sc27xx_data = iio_priv(dev_get_drvdata(dev));
+
+	/* set the UMP9620 ADC clk26m bit8 on IP */
+	if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
+		ret = regmap_update_bits(sc27xx_data->regmap, UMP9620_XTL_WAIT_CTRL0,
+				UMP9620_XTL_WAIT_CTRL0_EN, UMP9620_XTL_WAIT_CTRL0_EN);
+		if (ret) {
+			dev_err(dev, "failed to set the UMP9620 ADC clk26m bit8 on IP\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops sc27xx_adc_pm_ops = {
+	SET_RUNTIME_PM_OPS(sc27xx_adc_runtime_suspend, sc27xx_adc_runtime_resume, NULL)
+};
+
 static struct platform_driver sc27xx_adc_driver = {
 	.probe = sc27xx_adc_probe,
 	.driver = {
 		.name = "sc27xx-adc",
 		.of_match_table = sc27xx_adc_of_match,
+		.pm	= &sc27xx_adc_pm_ops,
 	},
 };
 
-- 
2.25.1

