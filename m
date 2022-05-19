Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3430652C9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiESCOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiESCN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:13:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64228CCFA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:13:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p12so3884244pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wyq2Los7z2YQuHxhySTXRtJAk+YnndZRPaJjpNvCr8w=;
        b=TuSEjTsgu8bKEUlEZySSXPqZJGxx9GeOlFB46KJun0qNXIigT6+gPEJytAlE1OHo2M
         W9IDT/qkArhUDBp8R5Zpm1qhWdFBaEkxdge9VuHMgmkMmztr+MxKnmIzAAgDneGp+iuy
         nvc0wvvp+FjoTm+CROi5sRElaQ+xPqyrAom47a4Lgna5CzuSswFLcWZh4L6Q25H1pAmc
         ZDD0drYe0vUxbB+ufugyCnz5HuYuDqx1AZqDi0uQ2j8g+OIl125UqGx+YWK7IhUtj73K
         g7fdCgigLGx4NwErdAz8GiL9pAwsCphuDNIn0JCWSPIJ+u5sZ5Udw7KI+Fwe3jcwHyXC
         g3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wyq2Los7z2YQuHxhySTXRtJAk+YnndZRPaJjpNvCr8w=;
        b=qHPrQx40BA9vCV+FEE/QYCNAZMU+hobECIXHFoGcOENi6/fMnJgB3NaD4b+JNi7kEl
         Mj57N0tue1osDKE9i4NnNSFAyzr5SBAkKvWhIQWRDc/UmF3UvoW04zT7kMJFkWtftWti
         zQ/eWqXACiCk6kQz+n/SKZXUrfLN5RVqZONLyndA31nWczNwbO4sUiCWgr7/KRU+jT2Y
         /Lsnz7YunWqNjAcAQtcfnzVMRMkzoOO+s2fbGh/bJNsi7Uvom4GS/+UggDzcZ4zVW2OF
         wdYfWPRNrRLcDgmAe3LxNg3xtB3+w59/GH0xeyKP0JAmTMYBNTDb5D/uM3kGVo1+xWyc
         KaMQ==
X-Gm-Message-State: AOAM530pOK27Gh5O+4LtrZPH6obQ8M64XypkxhZJHdVuThfo5+bpkFpK
        ue0hyYW6aOplOycfTMyfar4=
X-Google-Smtp-Source: ABdhPJwGOU545bZP0+XM7ca6pZFSklswcp3GoMluQyeKnLw0Q6vv6iMHjVJ7EUNsyjg6yaSoor1f2w==
X-Received: by 2002:a63:d813:0:b0:3f5:f9d8:7cce with SMTP id b19-20020a63d813000000b003f5f9d87ccemr2001690pgh.585.1652926435270;
        Wed, 18 May 2022 19:13:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:8697:c74:ab15:730:f5f3])
        by smtp.gmail.com with ESMTPSA id je4-20020a170903264400b0015ebb3bf277sm2366603plb.238.2022.05.18.19.13.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 May 2022 19:13:54 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com,
        ritchie_hsieh@richtek.com, allen_lin@richtek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH 2/2] ASoC: rt9120: Use pm_runtime and regcache to optimize 'pwdnn' logic
Date:   Thu, 19 May 2022 10:13:38 +0800
Message-Id: <1652926418-8519-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652926418-8519-1-git-send-email-u0084500@gmail.com>
References: <1652926418-8519-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

From the datasheet, the only way to meet the lowest power consumption is
to pull low the 'pwdnn' gpio. But if it is low, IC will keep in
reset state, all registers reset to default.

And the power consumption is listed below
1. amp off and 'pwdnn' high => idle state, PVDD = 1mA, DVDD = 7mA
2. amp off and 'pwdnn' low  => shutdown state, PVDD < 20uA, DVDD < 15uA

It's the large difference for the consumption current

This fix is to use pm_runtime and regcache to handle 'pwdnn' gpio
control.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rt9120.c | 111 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 105 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt9120.c b/sound/soc/codecs/rt9120.c
index 94d42be..da495bd 100644
--- a/sound/soc/codecs/rt9120.c
+++ b/sound/soc/codecs/rt9120.c
@@ -7,6 +7,7 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <sound/pcm.h>
@@ -75,6 +76,7 @@ enum {
 struct rt9120_data {
 	struct device *dev;
 	struct regmap *regmap;
+	struct gpio_desc *pwdnn_gpio;
 	int chip_idx;
 };
 
@@ -160,6 +162,8 @@ static int rt9120_codec_probe(struct snd_soc_component *comp)
 
 	snd_soc_component_init_regmap(comp, data->regmap);
 
+	pm_runtime_get_sync(comp->dev);
+
 	/* Internal setting */
 	if (data->chip_idx == CHIP_IDX_RT9120S) {
 		snd_soc_component_write(comp, RT9120_REG_INTERCFG, 0xde);
@@ -167,6 +171,9 @@ static int rt9120_codec_probe(struct snd_soc_component *comp)
 	} else
 		snd_soc_component_write(comp, RT9120_REG_INTERNAL0, 0x04);
 
+	pm_runtime_mark_last_busy(comp->dev);
+	pm_runtime_put(comp->dev);
+
 	return 0;
 }
 
@@ -338,6 +345,18 @@ static const struct regmap_access_table rt9120_wr_table = {
 	.n_yes_ranges = ARRAY_SIZE(rt9120_wr_yes_ranges),
 };
 
+static bool rt9120_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0x00 ... 0x01:
+	case 0x10:
+	case 0x30 ... 0x40:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int rt9120_get_reg_size(unsigned int reg)
 {
 	switch (reg) {
@@ -397,14 +416,49 @@ static int rt9120_reg_write(void *context, unsigned int reg, unsigned int val)
 	return i2c_smbus_write_i2c_block_data(i2c, reg, size, rawp + offs);
 }
 
+static const struct reg_default rt9120_reg_defaults[] = {
+	{ .reg = 0x02, .def = 0x02 },
+	{ .reg = 0x03, .def = 0xf2 },
+	{ .reg = 0x04, .def = 0x01 },
+	{ .reg = 0x05, .def = 0xc0 },
+	{ .reg = 0x06, .def = 0x28 },
+	{ .reg = 0x07, .def = 0x04 },
+	{ .reg = 0x08, .def = 0xff },
+	{ .reg = 0x09, .def = 0x01 },
+	{ .reg = 0x0a, .def = 0x01 },
+	{ .reg = 0x0b, .def = 0x00 },
+	{ .reg = 0x0c, .def = 0x04 },
+	{ .reg = 0x11, .def = 0x30 },
+	{ .reg = 0x12, .def = 0x08 },
+	{ .reg = 0x13, .def = 0x12 },
+	{ .reg = 0x14, .def = 0x09 },
+	{ .reg = 0x15, .def = 0x00 },
+	{ .reg = 0x20, .def = 0x7ff },
+	{ .reg = 0x21, .def = 0x180 },
+	{ .reg = 0x22, .def = 0x180 },
+	{ .reg = 0x23, .def = 0x00 },
+	{ .reg = 0x24, .def = 0x80 },
+	{ .reg = 0x25, .def = 0x180 },
+	{ .reg = 0x26, .def = 0x640 },
+	{ .reg = 0x27, .def = 0x180 },
+	{ .reg = 0x63, .def = 0x5e },
+	{ .reg = 0x65, .def = 0x66 },
+	{ .reg = 0x6c, .def = 0xe0 },
+	{ .reg = 0xf8, .def = 0x44 },
+};
+
 static const struct regmap_config rt9120_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 32,
 	.max_register = RT9120_REG_DIGCFG,
+	.reg_defaults = rt9120_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(rt9120_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
 
 	.reg_read = rt9120_reg_read,
 	.reg_write = rt9120_reg_write,
 
+	.volatile_reg = rt9120_volatile_reg,
 	.wr_table = &rt9120_wr_table,
 	.rd_table = &rt9120_rd_table,
 };
@@ -450,7 +504,6 @@ static int rt9120_do_register_reset(struct rt9120_data *data)
 static int rt9120_probe(struct i2c_client *i2c)
 {
 	struct rt9120_data *data;
-	struct gpio_desc *pwdnn_gpio;
 	struct regulator *dvdd_supply;
 	int dvdd_supply_volt, ret;
 
@@ -461,12 +514,12 @@ static int rt9120_probe(struct i2c_client *i2c)
 	data->dev = &i2c->dev;
 	i2c_set_clientdata(i2c, data);
 
-	pwdnn_gpio = devm_gpiod_get_optional(&i2c->dev, "pwdnn",
-					     GPIOD_OUT_HIGH);
-	if (IS_ERR(pwdnn_gpio)) {
+	data->pwdnn_gpio = devm_gpiod_get_optional(&i2c->dev, "pwdnn",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(data->pwdnn_gpio)) {
 		dev_err(&i2c->dev, "Failed to initialize 'pwdnn' gpio\n");
-		return PTR_ERR(pwdnn_gpio);
-	} else if (pwdnn_gpio) {
+		return PTR_ERR(data->pwdnn_gpio);
+	} else if (data->pwdnn_gpio) {
 		dev_dbg(&i2c->dev, "'pwdnn' from low to high, wait chip on\n");
 		msleep(RT9120_CHIPON_WAITMS);
 	}
@@ -508,11 +561,55 @@ static int rt9120_probe(struct i2c_client *i2c)
 		}
 	}
 
+	pm_runtime_set_autosuspend_delay(&i2c->dev, 1000);
+	pm_runtime_use_autosuspend(&i2c->dev);
+	pm_runtime_set_active(&i2c->dev);
+	pm_runtime_mark_last_busy(&i2c->dev);
+	pm_runtime_enable(&i2c->dev);
+
 	return devm_snd_soc_register_component(&i2c->dev,
 					       &rt9120_component_driver,
 					       &rt9120_dai, 1);
 }
 
+static int rt9120_remove(struct i2c_client *i2c)
+{
+	pm_runtime_disable(&i2c->dev);
+	pm_runtime_set_suspended(&i2c->dev);
+	return 0;
+}
+
+static int __maybe_unused rt9120_runtime_suspend(struct device *dev)
+{
+	struct rt9120_data *data = dev_get_drvdata(dev);
+
+	if (data->pwdnn_gpio) {
+		regcache_cache_only(data->regmap, true);
+		regcache_mark_dirty(data->regmap);
+		gpiod_set_value(data->pwdnn_gpio, 0);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused rt9120_runtime_resume(struct device *dev)
+{
+	struct rt9120_data *data = dev_get_drvdata(dev);
+
+	if (data->pwdnn_gpio) {
+		gpiod_set_value(data->pwdnn_gpio, 1);
+		msleep(RT9120_CHIPON_WAITMS);
+		regcache_cache_only(data->regmap, false);
+		regcache_sync(data->regmap);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops rt9120_pm_ops = {
+	SET_RUNTIME_PM_OPS(rt9120_runtime_suspend, rt9120_runtime_resume, NULL)
+};
+
 static const struct of_device_id __maybe_unused rt9120_device_table[] = {
 	{ .compatible = "richtek,rt9120", },
 	{ }
@@ -523,8 +620,10 @@ static struct i2c_driver rt9120_driver = {
 	.driver = {
 		.name = "rt9120",
 		.of_match_table = rt9120_device_table,
+		.pm = &rt9120_pm_ops,
 	},
 	.probe_new = rt9120_probe,
+	.remove = rt9120_remove,
 };
 module_i2c_driver(rt9120_driver);
 
-- 
2.7.4

