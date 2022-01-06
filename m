Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660CA4864CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbiAFNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiAFNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:00:37 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3071FC061212;
        Thu,  6 Jan 2022 05:00:37 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u20so2442095pfi.12;
        Thu, 06 Jan 2022 05:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BCEbtMO4Db9LtL4mgdS/D+5sz3z9VJ62Q3rxgA7RPSQ=;
        b=lR7YB3kWnQOCWY53lPlHHOCYyKPFn+qN+Ev+gd0WdkVOsFTtm0IUIupxigM9ygvBjU
         b5daRWbbsrD0XP75dsvbAKPrTSF3qth52/6JN0aB8UnTuIJ6qt7sSAqir6oz7gbP+HIY
         sPvKpsWEEl+iOHep7Wc9Mp10oyBAzOLSk3G3VlfwFwXoaoCzEeLcJdzhHQ6DYTz/czaQ
         WHOocrmCHVlMb8lKcBRF6XdEVN82x8/n7IdKhNHDxlutTDDkhRmj+hjm3DeI90jEpf9s
         FerYZzWbEysRDGuMgJm9Klc85e3SF4wF7+2bPfB8OnFNQbDczzm+Cs2VO4+N2R9rXyER
         Rg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BCEbtMO4Db9LtL4mgdS/D+5sz3z9VJ62Q3rxgA7RPSQ=;
        b=GLa0RluI4QMPibumEC1gJwZCMQ0Q5PEaYZQmSgK7s4pEFp01EXmmhfS2JCenwdLgc5
         UeYEqcTs9q7RbQZNmeak4wL9hw28HomL75DcoR6MtyzooSrWHhvMNYaWJXJ13fIecGh2
         8MkzSksD34V0hev3ulZlguCBQvZEJanWK2F7NasM9QwiNqnD87nspxaWsIMwwkxSuCP3
         jqz7tJ5AB4hrKKx4E+BxOO7pz5rYmAUYRLZBZw9dbmgSl+s3HytoBEejt6xsXG70K13m
         VUQvr+mykym4xf2IByH2MjrG8+Vm2g8N4eNOF3adTLB0DxhqNnWsGm3yn7uR2KhdMTGL
         yslg==
X-Gm-Message-State: AOAM532fLtjxBbXkMvHRO/MhZfJaGxb0QTsgFSjtcwS9wqkDviWBgE1C
        SUt5LwySfDUrm3RJ5FVK1+g=
X-Google-Smtp-Source: ABdhPJyNAdJ+DF9D/ZwkHyWT1O+3FZVY2mqncQqWumWZ3F8gZQNW4EdaaIDmMED9QjPpyMZfvYDM7g==
X-Received: by 2002:a63:395:: with SMTP id 143mr52514306pgd.181.1641474036677;
        Thu, 06 Jan 2022 05:00:36 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g14sm2052583pgp.76.2022.01.06.05.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 05:00:36 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] iio: adc: sc27xx: add Ump9620 ADC suspend and resume pm support
Date:   Thu,  6 Jan 2022 20:59:47 +0800
Message-Id: <20220106125947.139523-8-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106125947.139523-1-gengcixi@gmail.com>
References: <20220106125947.139523-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Ump9620 ADC suspend and resume pm optimization, configuration
0x6490_ 0350(PAD_ CLK26M_ SINOUT_ PMIC_ 1P8 ) bit 8.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 103 ++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 68b967f32498..cecda8d53474 100644
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
@@ -618,6 +622,9 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 		return ret;
 	}
 
+	if (data->var_data->pmic_type == UMP9620_ADC)
+		pm_runtime_get_sync(data->indio_dev->dev.parent);
+
 	/*
 	 * According to the sc2721 chip data sheet, the reference voltage of
 	 * specific channel 30 and channel 31 in ADC module needs to be set from
@@ -700,6 +707,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 		}
 	}
 
+	if (data->var_data->pmic_type == UMP9620_ADC) {
+		pm_runtime_mark_last_busy(data->indio_dev->dev.parent);
+		pm_runtime_put_autosuspend(data->indio_dev->dev.parent);
+	}
+
 	hwspin_unlock_raw(data->hwlock);
 
 	if (!ret)
@@ -947,6 +959,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 		ret = regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
 					 UMP9620_XTL_WAIT_CTRL0_EN,
 					 UMP9620_XTL_WAIT_CTRL0_EN);
+		if (ret) {
+			dev_err(data->dev, "failed to set the UMP9620 ADC clk26m bit8 on IP\n");
+			goto clean_adc_clk26m_bit8;
+		}
 	}
 
 	/* Enable ADC work clock */
@@ -988,6 +1004,11 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	regmap_update_bits(data->regmap, data->var_data->module_en,
 			   SC27XX_MODULE_ADC_EN, 0);
 
+clean_adc_clk26m_bit8:
+	if (data->var_data->pmic_type == UMP9620_ADC)
+		regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
+				UMP9620_XTL_WAIT_CTRL0_EN, 0);
+
 	return ret;
 }
 
@@ -1086,6 +1107,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, indio_dev);
+
 	sc27xx_data = iio_priv(indio_dev);
 
 	sc27xx_data->regmap = dev_get_regmap(dev->parent, NULL);
@@ -1126,7 +1149,10 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 		}
 	}
 
+	sc27xx_data->dev = dev;
 	sc27xx_data->var_data = pdata;
+	sc27xx_data->indio_dev = indio_dev;
+
 	sc27xx_data->var_data->init_scale(sc27xx_data);
 
 	ret = sc27xx_adc_enable(sc27xx_data);
@@ -1137,18 +1163,39 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(dev, sc27xx_adc_disable, sc27xx_data);
 	if (ret) {
+		sc27xx_adc_disable(sc27xx_data);
 		dev_err(dev, "failed to add ADC disable action\n");
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
@@ -1163,11 +1210,65 @@ static const struct of_device_id sc27xx_adc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
 
+static int sc27xx_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct sc27xx_adc_data *sc27xx_data = iio_priv(indio_dev);
+
+	if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
+		pm_runtime_put(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+
+		/* set the UMP9620 ADC clk26m bit8 on IP */
+		regmap_update_bits(sc27xx_data->regmap, UMP9620_XTL_WAIT_CTRL0,
+				UMP9620_XTL_WAIT_CTRL0_EN, 0);
+	}
+
+	return 0;
+}
+
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
+	.runtime_suspend = &sc27xx_adc_runtime_suspend,
+	.runtime_resume = &sc27xx_adc_runtime_resume,
+};
+
 static struct platform_driver sc27xx_adc_driver = {
 	.probe = sc27xx_adc_probe,
+	.remove = sc27xx_adc_remove,
 	.driver = {
 		.name = "sc27xx-adc",
 		.of_match_table = sc27xx_adc_of_match,
+		.pm	= &sc27xx_adc_pm_ops,
 	},
 };
 
-- 
2.25.1

