Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E6599C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349125AbiHSMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349088AbiHSMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:52:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F451D86FD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:52:44 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JBix0S020060;
        Fri, 19 Aug 2022 07:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=RZL29OjwV5PFxm0BnfsgDRypvNSBM+O0AcZH0B1Zgog=;
 b=dZ1WRbqZloKqN3voZMe++m5y9GJG2p2TAwN0L3RptPXJ2lZAKzNNMhIXXA6pwLX4L3lB
 K2SEMqizp9pBhnhN4JreqlEWbFIUFFBX7QzVi8hXExZWG2MEsqRUCZ1iL2fgCTIDCPau
 19vt2q5YGYzmjbhvdsv7md6uT3j30Rg2KqvzI7ajUbNp9dBkRfGgwEeowFEHqsa1WS6y
 88Qjbf+P6TvIS1hxRHdOcepvl9PAq7nb94f3KxijLeA63QiHuPkQFz5FlSWXQm4r00tk
 6ZTa9CQhOJqsFd2GLWsu+GKW7hF+epPErEPBT4EL8/yCXW0Ysyk5thUHGgutGRXaKjRW iA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpfuvn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 07:52:37 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 19 Aug
 2022 07:52:35 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Fri, 19 Aug 2022 07:52:35 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ED07211DA;
        Fri, 19 Aug 2022 12:52:34 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 09/12] ASoC: cs42l42: Split I2C identity into separate module
Date:   Fri, 19 Aug 2022 13:52:27 +0100
Message-ID: <20220819125230.42731-10-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220819125230.42731-1-rf@opensource.cirrus.com>
References: <20220819125230.42731-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: h6HfXATwKNChB_7E_GkkkiA8PxbIwRlS
X-Proofpoint-GUID: h6HfXATwKNChB_7E_GkkkiA8PxbIwRlS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the I2C bus driver definition and probe()/remove() into a
separate module so that a Soundwire build of CS42L42 support does
not have a spurious dependency on I2C.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig       |   8 ++-
 sound/soc/codecs/Makefile      |   4 +-
 sound/soc/codecs/cs42l42-i2c.c | 107 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l42.c     | 111 ++++++---------------------------
 sound/soc/codecs/cs42l42.h     |  15 +++++
 5 files changed, 152 insertions(+), 93 deletions(-)
 create mode 100644 sound/soc/codecs/cs42l42-i2c.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d16b4efb88a7..9f6f0f97cfb9 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -690,9 +690,15 @@ config SND_SOC_CS35L45_I2C
 	  Enable support for Cirrus Logic CS35L45 smart speaker amplifier
 	  with I2C control.
 
+config SND_SOC_CS42L42_CORE
+	tristate
+
 config SND_SOC_CS42L42
-	tristate "Cirrus Logic CS42L42 CODEC"
+	tristate "Cirrus Logic CS42L42 CODEC (I2C)"
 	depends on I2C
+	select REGMAP
+	select REGMAP_I2C
+	select SND_SOC_CS42L42_CORE
 
 config SND_SOC_CS42L51
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 92fd441d426a..d91f3c1fc2b3 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -65,6 +65,7 @@ snd-soc-cs35l45-objs := cs35l45.o
 snd-soc-cs35l45-spi-objs := cs35l45-spi.o
 snd-soc-cs35l45-i2c-objs := cs35l45-i2c.o
 snd-soc-cs42l42-objs := cs42l42.o
+snd-soc-cs42l42-i2c-objs := cs42l42-i2c.o
 snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o
 snd-soc-cs42l52-objs := cs42l52.o
@@ -419,7 +420,8 @@ obj-$(CONFIG_SND_SOC_CS35L45_TABLES)	+= snd-soc-cs35l45-tables.o
 obj-$(CONFIG_SND_SOC_CS35L45)	+= snd-soc-cs35l45.o
 obj-$(CONFIG_SND_SOC_CS35L45_SPI)	+= snd-soc-cs35l45-spi.o
 obj-$(CONFIG_SND_SOC_CS35L45_I2C)	+= snd-soc-cs35l45-i2c.o
-obj-$(CONFIG_SND_SOC_CS42L42)	+= snd-soc-cs42l42.o
+obj-$(CONFIG_SND_SOC_CS42L42_CORE)	+= snd-soc-cs42l42.o
+obj-$(CONFIG_SND_SOC_CS42L42)	+= snd-soc-cs42l42-i2c.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS42L51_I2C)	+= snd-soc-cs42l51-i2c.o
 obj-$(CONFIG_SND_SOC_CS42L52)	+= snd-soc-cs42l52.o
diff --git a/sound/soc/codecs/cs42l42-i2c.c b/sound/soc/codecs/cs42l42-i2c.c
new file mode 100644
index 000000000000..5f01b6adc17e
--- /dev/null
+++ b/sound/soc/codecs/cs42l42-i2c.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cs42l42-i2c.c -- CS42L42 ALSA SoC audio driver for I2C
+ *
+ * Copyright 2016, 2022 Cirrus Logic, Inc.
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "cs42l42.h"
+
+static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
+{
+	struct device *dev = &i2c_client->dev;
+	struct cs42l42_private *cs42l42;
+	struct regmap *regmap;
+	int ret;
+
+	cs42l42 = devm_kzalloc(dev, sizeof(*cs42l42), GFP_KERNEL);
+	if (!cs42l42)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
+		return ret;
+	}
+
+	cs42l42->dev = dev;
+	cs42l42->regmap = regmap;
+	cs42l42->irq = i2c_client->irq;
+
+	ret = cs42l42_common_probe(cs42l42, &cs42l42_soc_component, &cs42l42_dai);
+	if (ret)
+		return ret;
+
+	return cs42l42_init(cs42l42);
+}
+
+static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(&i2c_client->dev);
+
+	cs42l42_common_remove(cs42l42);
+
+	return 0;
+}
+
+static int __maybe_unused cs42l42_i2c_resume(struct device *dev)
+{
+	int ret;
+
+	ret = cs42l42_resume(dev);
+	if (ret)
+		return ret;
+
+	cs42l42_resume_restore(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cs42l42_i2c_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l42_i2c_resume)
+};
+
+static const struct of_device_id __maybe_unused cs42l42_of_match[] = {
+	{ .compatible = "cirrus,cs42l42", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs42l42_of_match);
+
+static const struct acpi_device_id __maybe_unused cs42l42_acpi_match[] = {
+	{"10134242", 0,},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, cs42l42_acpi_match);
+
+static const struct i2c_device_id cs42l42_id[] = {
+	{"cs42l42", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, cs42l42_id);
+
+static struct i2c_driver cs42l42_i2c_driver = {
+	.driver = {
+		.name = "cs42l42",
+		.pm = &cs42l42_i2c_pm_ops,
+		.of_match_table = of_match_ptr(cs42l42_of_match),
+		.acpi_match_table = ACPI_PTR(cs42l42_acpi_match),
+		},
+	.id_table = cs42l42_id,
+	.probe_new = cs42l42_i2c_probe,
+	.remove = cs42l42_i2c_remove,
+};
+
+module_i2c_driver(cs42l42_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC CS42L42 I2C driver");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SND_SOC_CS42L42_CORE);
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a98b4e6a1f05..7f16de593424 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -15,7 +15,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -377,7 +376,7 @@ static const struct regmap_range_cfg cs42l42_page_range = {
 	.window_len = 256,
 };
 
-static const struct regmap_config cs42l42_regmap = {
+const struct regmap_config cs42l42_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -395,6 +394,7 @@ static const struct regmap_config cs42l42_regmap = {
 	.use_single_read = true,
 	.use_single_write = true,
 };
+EXPORT_SYMBOL_NS_GPL(cs42l42_regmap, SND_SOC_CS42L42_CORE);
 
 static DECLARE_TLV_DB_SCALE(adc_tlv, -9700, 100, true);
 static DECLARE_TLV_DB_SCALE(mixer_tlv, -6300, 100, true);
@@ -581,7 +581,7 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
 	return 0;
 }
 
-static const struct snd_soc_component_driver cs42l42_soc_component = {
+const struct snd_soc_component_driver cs42l42_soc_component = {
 	.set_jack		= cs42l42_set_jack,
 	.dapm_widgets		= cs42l42_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(cs42l42_dapm_widgets),
@@ -592,6 +592,7 @@ static const struct snd_soc_component_driver cs42l42_soc_component = {
 	.idle_bias_on		= 1,
 	.endianness		= 1,
 };
+EXPORT_SYMBOL_NS_GPL(cs42l42_soc_component, SND_SOC_CS42L42_CORE);
 
 /* Switch to SCLK. Atomic delay after the write to allow the switch to complete. */
 static const struct reg_sequence cs42l42_to_sclk_seq[] = {
@@ -1101,7 +1102,7 @@ static const struct snd_soc_dai_ops cs42l42_ops = {
 	.mute_stream	= cs42l42_mute_stream,
 };
 
-static struct snd_soc_dai_driver cs42l42_dai = {
+struct snd_soc_dai_driver cs42l42_dai = {
 		.name = "cs42l42",
 		.playback = {
 			.stream_name = "Playback",
@@ -1121,6 +1122,7 @@ static struct snd_soc_dai_driver cs42l42_dai = {
 		.symmetric_sample_bits = 1,
 		.ops = &cs42l42_ops,
 };
+EXPORT_SYMBOL_NS_GPL(cs42l42_dai, SND_SOC_CS42L42_CORE);
 
 static void cs42l42_manual_hs_type_detect(struct cs42l42_private *cs42l42)
 {
@@ -2116,7 +2118,7 @@ static const struct reg_sequence __maybe_unused cs42l42_shutdown_seq[] = {
 	REG_SEQ0(CS42L42_PWR_CTL1,		0xFF)
 };
 
-static int __maybe_unused cs42l42_suspend(struct device *dev)
+int cs42l42_suspend(struct device *dev)
 {
 	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
 	unsigned int reg;
@@ -2176,8 +2178,9 @@ static int __maybe_unused cs42l42_suspend(struct device *dev)
 	return 0;
 
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_suspend, SND_SOC_CS42L42_CORE);
 
-static int __maybe_unused cs42l42_resume(struct device *dev)
+int cs42l42_resume(struct device *dev)
 {
 	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
 	int ret;
@@ -2203,8 +2206,9 @@ static int __maybe_unused cs42l42_resume(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_resume, SND_SOC_CS42L42_CORE);
 
-static void __maybe_unused cs42l42_resume_restore(struct device *dev)
+void cs42l42_resume_restore(struct device *dev)
 {
 	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
 
@@ -2221,6 +2225,7 @@ static void __maybe_unused cs42l42_resume_restore(struct device *dev)
 
 	dev_dbg(dev, "System resumed\n");
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_resume_restore, SND_SOC_CS42L42_CORE);
 
 static int __maybe_unused cs42l42_i2c_resume(struct device *dev)
 {
@@ -2235,9 +2240,9 @@ static int __maybe_unused cs42l42_i2c_resume(struct device *dev)
 	return 0;
 }
 
-static int cs42l42_common_probe(struct cs42l42_private *cs42l42,
-				const struct snd_soc_component_driver *component_drv,
-				struct snd_soc_dai_driver *dai)
+int cs42l42_common_probe(struct cs42l42_private *cs42l42,
+			 const struct snd_soc_component_driver *component_drv,
+			 struct snd_soc_dai_driver *dai)
 {
 	int ret, i;
 
@@ -2312,8 +2317,9 @@ static int cs42l42_common_probe(struct cs42l42_private *cs42l42,
 
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_common_probe, SND_SOC_CS42L42_CORE);
 
-static int cs42l42_init(struct cs42l42_private *cs42l42)
+int cs42l42_init(struct cs42l42_private *cs42l42)
 {
 	unsigned int reg;
 	int devid, ret;
@@ -2389,8 +2395,9 @@ static int cs42l42_init(struct cs42l42_private *cs42l42)
 				cs42l42->supplies);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_init, SND_SOC_CS42L42_CORE);
 
-static void cs42l42_common_remove(struct cs42l42_private *cs42l42)
+void cs42l42_common_remove(struct cs42l42_private *cs42l42)
 {
 	if (cs42l42->irq)
 		free_irq(cs42l42->irq, cs42l42);
@@ -2408,85 +2415,7 @@ static void cs42l42_common_remove(struct cs42l42_private *cs42l42)
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
 }
-
-static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
-{
-	struct device *dev = &i2c_client->dev;
-	struct cs42l42_private *cs42l42;
-	struct regmap *regmap;
-	int ret;
-
-	cs42l42 = devm_kzalloc(dev, sizeof(struct cs42l42_private), GFP_KERNEL);
-	if (!cs42l42)
-		return -ENOMEM;
-
-	regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
-		return ret;
-	}
-
-	cs42l42->dev = dev;
-	cs42l42->regmap = regmap;
-	cs42l42->irq = i2c_client->irq;
-
-	ret = cs42l42_common_probe(cs42l42, &cs42l42_soc_component, &cs42l42_dai);
-	if (ret)
-		return ret;
-
-	return cs42l42_init(cs42l42);
-}
-
-static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
-{
-	struct cs42l42_private *cs42l42 = dev_get_drvdata(&i2c_client->dev);
-
-	cs42l42_common_remove(cs42l42);
-
-	return 0;
-}
-
-static const struct dev_pm_ops cs42l42_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l42_i2c_resume)
-};
-
-#ifdef CONFIG_OF
-static const struct of_device_id cs42l42_of_match[] = {
-	{ .compatible = "cirrus,cs42l42", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, cs42l42_of_match);
-#endif
-
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id cs42l42_acpi_match[] = {
-	{"10134242", 0,},
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, cs42l42_acpi_match);
-#endif
-
-static const struct i2c_device_id cs42l42_id[] = {
-	{"cs42l42", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, cs42l42_id);
-
-static struct i2c_driver cs42l42_i2c_driver = {
-	.driver = {
-		.name = "cs42l42",
-		.pm = &cs42l42_pm_ops,
-		.of_match_table = of_match_ptr(cs42l42_of_match),
-		.acpi_match_table = ACPI_PTR(cs42l42_acpi_match),
-		},
-	.id_table = cs42l42_id,
-	.probe_new = cs42l42_i2c_probe,
-	.remove = cs42l42_i2c_remove,
-};
-
-module_i2c_driver(cs42l42_i2c_driver);
+EXPORT_SYMBOL_NS_GPL(cs42l42_common_remove, SND_SOC_CS42L42_CORE);
 
 MODULE_DESCRIPTION("ASoC CS42L42 driver");
 MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 4ee61136080d..942054434afd 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -20,6 +20,8 @@
 #include <linux/regulator/consumer.h>
 #include <sound/jack.h>
 #include <sound/cs42l42.h>
+#include <sound/soc-component.h>
+#include <sound/soc-dai.h>
 
 struct  cs42l42_private {
 	struct regmap *regmap;
@@ -49,4 +51,17 @@ struct  cs42l42_private {
 	bool init_done;
 };
 
+extern const struct regmap_config cs42l42_regmap;
+extern const struct snd_soc_component_driver cs42l42_soc_component;
+extern struct snd_soc_dai_driver cs42l42_dai;
+
+int cs42l42_suspend(struct device *dev);
+int cs42l42_resume(struct device *dev);
+void cs42l42_resume_restore(struct device *dev);
+int cs42l42_common_probe(struct cs42l42_private *cs42l42,
+			 const struct snd_soc_component_driver *component_drv,
+			 struct snd_soc_dai_driver *dai);
+int cs42l42_init(struct cs42l42_private *cs42l42);
+void cs42l42_common_remove(struct cs42l42_private *cs42l42);
+
 #endif /* __CS42L42_H__ */
-- 
2.30.2

