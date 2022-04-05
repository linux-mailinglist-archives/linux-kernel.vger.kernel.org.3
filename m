Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6164F4C40
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573500AbiDEXPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443114AbiDEPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:38:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E836F1456FE;
        Tue,  5 Apr 2022 06:54:41 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2356jiGE029879;
        Tue, 5 Apr 2022 08:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=e2hCdDZFBBOFb3RQrYREEN0pvwsueeEZYcYj9XVY67E=;
 b=LOnPXjUkMJh+0R5DzSIdV76uSa4k5mxgdsgvxl9tiSiINwjo05pwhATj970hivrNbwlq
 k2uehm1RCIlieuYREnxZu6rxWiTe09OvxNXcyhfp46mM/fDp4wjD0Rasa1pxruPOEcKD
 XittRhm+OaNO0Yxp5ORJJULrWJF4rQ32+Rpwwkop+ddDoPOqmxhwiu9nXaiZO/C7g10f
 uuR9ruZVZ6R9Sm2sS6Dx/7b83H9Yl/nhj82xLl3Gp4owbfKTe1mlI8bxlU3pRlhczfOH
 7TuxT8YQSXqxKG9XYd6YTDXSE7ecB4BXTwQc6fRexAEauAfjKR6yR/cOrkgNvleljIL6 1w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f6kw2brws-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Apr 2022 08:54:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 14:54:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 5 Apr 2022 14:54:25 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.88])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C3C9C458;
        Tue,  5 Apr 2022 13:54:24 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 5/5] ASoC: cs35l45: Add driver for Cirrus Logic CS35L45 Smart Amp
Date:   Tue, 5 Apr 2022 14:54:19 +0100
Message-ID: <20220405135419.1230088-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405135419.1230088-1-rf@opensource.cirrus.com>
References: <20220405135419.1230088-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yJHkzbr7SxpZXXkZd878JdaUwKl2FgWd
X-Proofpoint-GUID: yJHkzbr7SxpZXXkZd878JdaUwKl2FgWd
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Schulman <james.schulman@cirrus.com>

The CS35L45 is a 15 V Boosted Mono Class D Amplifier with DSP
Speaker Protection and Adaptive Battery Management.

This initial driver provides standard non-boosted audio operation
without the DSP.

Signed-off-by: James Schulman <james.schulman@cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig          |  30 ++
 sound/soc/codecs/Makefile         |   8 +
 sound/soc/codecs/cs35l45-i2c.c    |  72 ++++
 sound/soc/codecs/cs35l45-spi.c    |  72 ++++
 sound/soc/codecs/cs35l45-tables.c | 202 +++++++++
 sound/soc/codecs/cs35l45.c        | 693 ++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l45.h        | 217 ++++++++++
 7 files changed, 1294 insertions(+)
 create mode 100644 sound/soc/codecs/cs35l45-i2c.c
 create mode 100644 sound/soc/codecs/cs35l45-spi.c
 create mode 100644 sound/soc/codecs/cs35l45-tables.c
 create mode 100644 sound/soc/codecs/cs35l45.c
 create mode 100644 sound/soc/codecs/cs35l45.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 21db336375ad..33edfd0ff079 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -65,6 +65,8 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_CS35L36
 	imply SND_SOC_CS35L41_SPI
 	imply SND_SOC_CS35L41_I2C
+	imply SND_SOC_CS35L45_I2C
+	imply SND_SOC_CS35L45_SPI
 	imply SND_SOC_CS42L42
 	imply SND_SOC_CS42L51_I2C
 	imply SND_SOC_CS42L52
@@ -656,6 +658,34 @@ config SND_SOC_CS35L41_I2C
 	select SND_SOC_CS35L41
 	select REGMAP_I2C
 
+config SND_SOC_CS35L45_TABLES
+	tristate
+
+config SND_SOC_CS35L45
+	tristate
+
+config SND_SOC_CS35L45_SPI
+	tristate "Cirrus Logic CS35L45 CODEC (SPI)"
+	depends on SPI_MASTER
+	select REGMAP
+	select REGMAP_SPI
+	select SND_SOC_CS35L45_TABLES
+	select SND_SOC_CS35L45
+	help
+	  Enable support for Cirrus Logic CS35L45 smart speaker amplifier
+	  with SPI control.
+
+config SND_SOC_CS35L45_I2C
+	tristate "Cirrus Logic CS35L45 CODEC (I2C)"
+	depends on I2C
+	select REGMAP
+	select REGMAP_I2C
+	select SND_SOC_CS35L45_TABLES
+	select SND_SOC_CS35L45
+	help
+	  Enable support for Cirrus Logic CS35L45 smart speaker amplifier
+	  with I2C control.
+
 config SND_SOC_CS42L42
 	tristate "Cirrus Logic CS42L42 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 46a100b200b9..57e651532749 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -60,6 +60,10 @@ snd-soc-cs35l41-lib-objs := cs35l41-lib.o
 snd-soc-cs35l41-objs := cs35l41.o
 snd-soc-cs35l41-spi-objs := cs35l41-spi.o
 snd-soc-cs35l41-i2c-objs := cs35l41-i2c.o
+snd-soc-cs35l45-tables-objs := cs35l45-tables.o
+snd-soc-cs35l45-objs := cs35l45.o
+snd-soc-cs35l45-spi-objs := cs35l45-spi.o
+snd-soc-cs35l45-i2c-objs := cs35l45-i2c.o
 snd-soc-cs42l42-objs := cs42l42.o
 snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o
@@ -406,6 +410,10 @@ obj-$(CONFIG_SND_SOC_CS35L41)	+= snd-soc-cs35l41.o
 obj-$(CONFIG_SND_SOC_CS35L41_LIB)	+= snd-soc-cs35l41-lib.o
 obj-$(CONFIG_SND_SOC_CS35L41_SPI)	+= snd-soc-cs35l41-spi.o
 obj-$(CONFIG_SND_SOC_CS35L41_I2C)	+= snd-soc-cs35l41-i2c.o
+obj-$(CONFIG_SND_SOC_CS35L45_TABLES)	+= snd-soc-cs35l45-tables.o
+obj-$(CONFIG_SND_SOC_CS35L45)	+= snd-soc-cs35l45.o
+obj-$(CONFIG_SND_SOC_CS35L45_SPI)	+= snd-soc-cs35l45-spi.o
+obj-$(CONFIG_SND_SOC_CS35L45_I2C)	+= snd-soc-cs35l45-i2c.o
 obj-$(CONFIG_SND_SOC_CS42L42)	+= snd-soc-cs42l42.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS42L51_I2C)	+= snd-soc-cs42l51-i2c.o
diff --git a/sound/soc/codecs/cs35l45-i2c.c b/sound/soc/codecs/cs35l45-i2c.c
new file mode 100644
index 000000000000..18ebf1e14b91
--- /dev/null
+++ b/sound/soc/codecs/cs35l45-i2c.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+//
+// cs35l45-i2c.c -- CS35L45 I2C driver
+//
+// Copyright 2019-2022 Cirrus Logic, Inc.
+//
+// Author: James Schulman <james.schulman@cirrus.com>
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#include "cs35l45.h"
+
+static int cs35l45_i2c_probe(struct i2c_client *client)
+{
+	struct cs35l45_private *cs35l45;
+	struct device *dev = &client->dev;
+	int ret;
+
+	cs35l45 = devm_kzalloc(dev, sizeof(struct cs35l45_private), GFP_KERNEL);
+	if (!cs35l45)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, cs35l45);
+	cs35l45->regmap = devm_regmap_init_i2c(client, &cs35l45_i2c_regmap);
+	if (IS_ERR(cs35l45->regmap)) {
+		ret = PTR_ERR(cs35l45->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	cs35l45->dev = dev;
+
+	return cs35l45_probe(cs35l45);
+}
+
+static int cs35l45_i2c_remove(struct i2c_client *client)
+{
+	struct cs35l45_private *cs35l45 = i2c_get_clientdata(client);
+
+	return cs35l45_remove(cs35l45);
+}
+
+static const struct of_device_id cs35l45_of_match[] = {
+	{ .compatible = "cirrus,cs35l45" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cs35l45_of_match);
+
+static const struct i2c_device_id cs35l45_id_i2c[] = {
+	{ "cs35l45", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs35l45_id_i2c);
+
+static struct i2c_driver cs35l45_i2c_driver = {
+	.driver = {
+		.name		= "cs35l45",
+		.of_match_table = cs35l45_of_match,
+		.pm		= &cs35l45_pm_ops,
+	},
+	.id_table	= cs35l45_id_i2c,
+	.probe_new	= cs35l45_i2c_probe,
+	.remove		= cs35l45_i2c_remove,
+};
+module_i2c_driver(cs35l45_i2c_driver);
+
+MODULE_DESCRIPTION("I2C CS35L45 driver");
+MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/codecs/cs35l45-spi.c b/sound/soc/codecs/cs35l45-spi.c
new file mode 100644
index 000000000000..445f57ff1fcd
--- /dev/null
+++ b/sound/soc/codecs/cs35l45-spi.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+//
+// cs35l45-spi.c -- CS35L45 SPI driver
+//
+// Copyright 2019-2022 Cirrus Logic, Inc.
+//
+// Author: James Schulman <james.schulman@cirrus.com>
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "cs35l45.h"
+
+static int cs35l45_spi_probe(struct spi_device *spi)
+{
+	struct cs35l45_private *cs35l45;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	cs35l45 = devm_kzalloc(dev, sizeof(struct cs35l45_private), GFP_KERNEL);
+	if (cs35l45 == NULL)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, cs35l45);
+	cs35l45->regmap = devm_regmap_init_spi(spi, &cs35l45_spi_regmap);
+	if (IS_ERR(cs35l45->regmap)) {
+		ret = PTR_ERR(cs35l45->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	cs35l45->dev = dev;
+
+	return cs35l45_probe(cs35l45);
+}
+
+static void cs35l45_spi_remove(struct spi_device *spi)
+{
+	struct cs35l45_private *cs35l45 = spi_get_drvdata(spi);
+
+	cs35l45_remove(cs35l45);
+}
+
+static const struct of_device_id cs35l45_of_match[] = {
+	{ .compatible = "cirrus,cs35l45" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cs35l45_of_match);
+
+static const struct spi_device_id cs35l45_id_spi[] = {
+	{ "cs35l45", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, cs35l45_id_spi);
+
+static struct spi_driver cs35l45_spi_driver = {
+	.driver = {
+		.name		= "cs35l45",
+		.of_match_table = cs35l45_of_match,
+		.pm		= &cs35l45_pm_ops,
+	},
+	.id_table	= cs35l45_id_spi,
+	.probe		= cs35l45_spi_probe,
+	.remove		= cs35l45_spi_remove,
+};
+module_spi_driver(cs35l45_spi_driver);
+
+MODULE_DESCRIPTION("SPI CS35L45 driver");
+MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/codecs/cs35l45-tables.c b/sound/soc/codecs/cs35l45-tables.c
new file mode 100644
index 000000000000..95d5b3606448
--- /dev/null
+++ b/sound/soc/codecs/cs35l45-tables.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+//
+// cs35l45-tables.c -- CS35L45 ALSA SoC audio driver
+//
+// Copyright 2019-2022 Cirrus Logic, Inc.
+//
+// Author: James Schulman <james.schulman@cirrus.com>
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "cs35l45.h"
+
+static const struct reg_sequence cs35l45_patch[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x00000044,			0x00000055 },
+	{ 0x00000044,			0x000000AA },
+	{ 0x00006480,			0x0830500A },
+	{ 0x00007C60,			0x1000850B },
+	{ CS35L45_BOOST_OV_CFG,		0x007000D0 },
+	{ CS35L45_LDPM_CONFIG,		0x0001B636 },
+	{ 0x00002C08,			0x00000009 },
+	{ 0x00006850,			0x0A30FFC4 },
+	{ 0x00003820,			0x00040100 },
+	{ 0x00003824,			0x00000000 },
+	{ 0x00007CFC,			0x62870004 },
+	{ 0x00007C60,			0x1001850B },
+	{ 0x00000040,			0x00000000 },
+	{ 0x00000044,			0x00000000 },
+	{ CS35L45_BOOST_CCM_CFG,	0xF0000003 },
+	{ CS35L45_BOOST_DCM_CFG,	0x08710220 },
+	{ CS35L45_ERROR_RELEASE,	0x00200000 },
+};
+
+int cs35l45_apply_patch(struct cs35l45_private *cs35l45)
+{
+	return regmap_register_patch(cs35l45->regmap, cs35l45_patch,
+				     ARRAY_SIZE(cs35l45_patch));
+}
+EXPORT_SYMBOL_GPL(cs35l45_apply_patch);
+
+static const struct reg_default cs35l45_defaults[] = {
+	{ CS35L45_BLOCK_ENABLES,		0x00003323 },
+	{ CS35L45_BLOCK_ENABLES2,		0x00000010 },
+	{ CS35L45_REFCLK_INPUT,			0x00000510 },
+	{ CS35L45_GLOBAL_SAMPLE_RATE,		0x00000003 },
+	{ CS35L45_ASP_ENABLES1,			0x00000000 },
+	{ CS35L45_ASP_CONTROL1,			0x00000028 },
+	{ CS35L45_ASP_CONTROL2,			0x18180200 },
+	{ CS35L45_ASP_CONTROL3,			0x00000002 },
+	{ CS35L45_ASP_FRAME_CONTROL1,		0x03020100 },
+	{ CS35L45_ASP_FRAME_CONTROL2,		0x00000004 },
+	{ CS35L45_ASP_FRAME_CONTROL5,		0x00000100 },
+	{ CS35L45_ASP_DATA_CONTROL1,		0x00000018 },
+	{ CS35L45_ASP_DATA_CONTROL5,		0x00000018 },
+	{ CS35L45_DACPCM1_INPUT,		0x00000008 },
+	{ CS35L45_ASPTX1_INPUT,			0x00000018 },
+	{ CS35L45_ASPTX2_INPUT,			0x00000019 },
+	{ CS35L45_ASPTX3_INPUT,			0x00000020 },
+	{ CS35L45_ASPTX4_INPUT,			0x00000028 },
+	{ CS35L45_ASPTX5_INPUT,			0x00000048 },
+	{ CS35L45_AMP_PCM_CONTROL,		0x00100000 },
+};
+
+static bool cs35l45_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS35L45_DEVID ... CS35L45_OTPID:
+	case CS35L45_SFT_RESET:
+	case CS35L45_GLOBAL_ENABLES:
+	case CS35L45_BLOCK_ENABLES:
+	case CS35L45_BLOCK_ENABLES2:
+	case CS35L45_ERROR_RELEASE:
+	case CS35L45_REFCLK_INPUT:
+	case CS35L45_GLOBAL_SAMPLE_RATE:
+	case CS35L45_ASP_ENABLES1:
+	case CS35L45_ASP_CONTROL1:
+	case CS35L45_ASP_CONTROL2:
+	case CS35L45_ASP_CONTROL3:
+	case CS35L45_ASP_FRAME_CONTROL1:
+	case CS35L45_ASP_FRAME_CONTROL2:
+	case CS35L45_ASP_FRAME_CONTROL5:
+	case CS35L45_ASP_DATA_CONTROL1:
+	case CS35L45_ASP_DATA_CONTROL5:
+	case CS35L45_DACPCM1_INPUT:
+	case CS35L45_ASPTX1_INPUT:
+	case CS35L45_ASPTX2_INPUT:
+	case CS35L45_ASPTX3_INPUT:
+	case CS35L45_ASPTX4_INPUT:
+	case CS35L45_ASPTX5_INPUT:
+	case CS35L45_AMP_PCM_CONTROL:
+	case CS35L45_AMP_PCM_HPF_TST:
+	case CS35L45_IRQ1_EINT_4:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs35l45_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS35L45_DEVID ... CS35L45_OTPID:
+	case CS35L45_SFT_RESET:
+	case CS35L45_GLOBAL_ENABLES:
+	case CS35L45_ERROR_RELEASE:
+	case CS35L45_AMP_PCM_HPF_TST:	/* not cachable */
+	case CS35L45_IRQ1_EINT_4:
+		return true;
+	default:
+		return false;
+	}
+}
+
+const struct regmap_config cs35l45_i2c_regmap = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = CS35L45_LASTREG,
+	.reg_defaults = cs35l45_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs35l45_defaults),
+	.volatile_reg = cs35l45_volatile_reg,
+	.readable_reg = cs35l45_readable_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_GPL(cs35l45_i2c_regmap);
+
+const struct regmap_config cs35l45_spi_regmap = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.pad_bits = 16,
+	.reg_stride = 4,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = CS35L45_LASTREG,
+	.reg_defaults = cs35l45_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs35l45_defaults),
+	.volatile_reg = cs35l45_volatile_reg,
+	.readable_reg = cs35l45_readable_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_GPL(cs35l45_spi_regmap);
+
+static const struct {
+	u8 cfg_id;
+	u32 freq;
+} cs35l45_pll_refclk_freq[] = {
+	{ 0x0C,   128000 },
+	{ 0x0F,   256000 },
+	{ 0x11,   384000 },
+	{ 0x12,   512000 },
+	{ 0x15,   768000 },
+	{ 0x17,  1024000 },
+	{ 0x19,  1411200 },
+	{ 0x1B,  1536000 },
+	{ 0x1C,  2116800 },
+	{ 0x1D,  2048000 },
+	{ 0x1E,  2304000 },
+	{ 0x1F,  2822400 },
+	{ 0x21,  3072000 },
+	{ 0x23,  4233600 },
+	{ 0x24,  4096000 },
+	{ 0x25,  4608000 },
+	{ 0x26,  5644800 },
+	{ 0x27,  6000000 },
+	{ 0x28,  6144000 },
+	{ 0x29,  6350400 },
+	{ 0x2A,  6912000 },
+	{ 0x2D,  7526400 },
+	{ 0x2E,  8467200 },
+	{ 0x2F,  8192000 },
+	{ 0x30,  9216000 },
+	{ 0x31, 11289600 },
+	{ 0x33, 12288000 },
+	{ 0x37, 16934400 },
+	{ 0x38, 18432000 },
+	{ 0x39, 22579200 },
+	{ 0x3B, 24576000 },
+};
+
+unsigned int cs35l45_get_clk_freq_id(unsigned int freq)
+{
+	int i;
+
+	if (freq == 0)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l45_pll_refclk_freq); ++i) {
+		if (cs35l45_pll_refclk_freq[i].freq == freq)
+			return cs35l45_pll_refclk_freq[i].cfg_id;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(cs35l45_get_clk_freq_id);
+
+MODULE_DESCRIPTION("ASoC CS35L45 driver tables");
+MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
new file mode 100644
index 000000000000..7822626d3693
--- /dev/null
+++ b/sound/soc/codecs/cs35l45.c
@@ -0,0 +1,693 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+//
+// cs35l45.c - CS35L45 ALSA SoC audio driver
+//
+// Copyright 2019-2022 Cirrus Logic, Inc.
+//
+// Author: James Schulman <james.schulman@cirrus.com>
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "cs35l45.h"
+
+static int cs35l45_global_en_ev(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cs35l45_private *cs35l45 = snd_soc_component_get_drvdata(component);
+
+	dev_dbg(cs35l45->dev, "%s event : %x\n", __func__, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_write(cs35l45->regmap, CS35L45_GLOBAL_ENABLES,
+			     CS35L45_GLOBAL_EN_MASK);
+
+		usleep_range(CS35L45_POST_GLOBAL_EN_US, CS35L45_POST_GLOBAL_EN_US + 100);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		usleep_range(CS35L45_PRE_GLOBAL_DIS_US, CS35L45_PRE_GLOBAL_DIS_US + 100);
+
+		regmap_write(cs35l45->regmap, CS35L45_GLOBAL_ENABLES, 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const char * const cs35l45_asp_tx_txt[] = {
+	"Zero", "ASP_RX1", "ASP_RX2",
+	"VMON", "IMON", "ERR_VOL",
+	"VDD_BATTMON", "VDD_BSTMON",
+	"Interpolator", "IL_TARGET",
+};
+
+static const unsigned int cs35l45_asp_tx_val[] = {
+	CS35L45_PCM_SRC_ZERO, CS35L45_PCM_SRC_ASP_RX1, CS35L45_PCM_SRC_ASP_RX2,
+	CS35L45_PCM_SRC_VMON, CS35L45_PCM_SRC_IMON, CS35L45_PCM_SRC_ERR_VOL,
+	CS35L45_PCM_SRC_VDD_BATTMON, CS35L45_PCM_SRC_VDD_BSTMON,
+	CS35L45_PCM_SRC_INTERPOLATOR, CS35L45_PCM_SRC_IL_TARGET,
+};
+
+static const struct soc_enum cs35l45_asp_tx_enums[] = {
+	SOC_VALUE_ENUM_SINGLE(CS35L45_ASPTX1_INPUT, 0, CS35L45_PCM_SRC_MASK,
+			      ARRAY_SIZE(cs35l45_asp_tx_txt), cs35l45_asp_tx_txt,
+			      cs35l45_asp_tx_val),
+	SOC_VALUE_ENUM_SINGLE(CS35L45_ASPTX2_INPUT, 0, CS35L45_PCM_SRC_MASK,
+			      ARRAY_SIZE(cs35l45_asp_tx_txt), cs35l45_asp_tx_txt,
+			      cs35l45_asp_tx_val),
+	SOC_VALUE_ENUM_SINGLE(CS35L45_ASPTX3_INPUT, 0, CS35L45_PCM_SRC_MASK,
+			      ARRAY_SIZE(cs35l45_asp_tx_txt), cs35l45_asp_tx_txt,
+			      cs35l45_asp_tx_val),
+	SOC_VALUE_ENUM_SINGLE(CS35L45_ASPTX4_INPUT, 0, CS35L45_PCM_SRC_MASK,
+			      ARRAY_SIZE(cs35l45_asp_tx_txt), cs35l45_asp_tx_txt,
+			      cs35l45_asp_tx_val),
+	SOC_VALUE_ENUM_SINGLE(CS35L45_ASPTX5_INPUT, 0, CS35L45_PCM_SRC_MASK,
+			      ARRAY_SIZE(cs35l45_asp_tx_txt), cs35l45_asp_tx_txt,
+			      cs35l45_asp_tx_val),
+};
+
+static const char * const cs35l45_dac_txt[] = {
+	"Zero", "ASP_RX1", "ASP_RX2"
+};
+
+static const unsigned int cs35l45_dac_val[] = {
+	CS35L45_PCM_SRC_ZERO, CS35L45_PCM_SRC_ASP_RX1, CS35L45_PCM_SRC_ASP_RX2
+};
+
+static const struct soc_enum cs35l45_dacpcm_enums[] = {
+	SOC_VALUE_ENUM_SINGLE(CS35L45_DACPCM1_INPUT, 0, CS35L45_PCM_SRC_MASK,
+			      ARRAY_SIZE(cs35l45_dac_txt), cs35l45_dac_txt,
+			      cs35l45_dac_val),
+};
+
+static const struct snd_kcontrol_new cs35l45_asp_muxes[] = {
+	SOC_DAPM_ENUM("ASP_TX1 Source", cs35l45_asp_tx_enums[0]),
+	SOC_DAPM_ENUM("ASP_TX2 Source", cs35l45_asp_tx_enums[1]),
+	SOC_DAPM_ENUM("ASP_TX3 Source", cs35l45_asp_tx_enums[2]),
+	SOC_DAPM_ENUM("ASP_TX4 Source", cs35l45_asp_tx_enums[3]),
+	SOC_DAPM_ENUM("ASP_TX5 Source", cs35l45_asp_tx_enums[4]),
+};
+
+static const struct snd_kcontrol_new cs35l45_dac_muxes[] = {
+	SOC_DAPM_ENUM("DACPCM1 Source", cs35l45_dacpcm_enums[0]),
+};
+
+static const struct snd_soc_dapm_widget cs35l45_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("GLOBAL_EN", SND_SOC_NOPM, 0, 0,
+			    cs35l45_global_en_ev,
+			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_SUPPLY("ASP_EN", CS35L45_BLOCK_ENABLES2, CS35L45_ASP_EN_SHIFT, 0, NULL, 0),
+
+	SND_SOC_DAPM_SIGGEN("VMON_SRC"),
+	SND_SOC_DAPM_SIGGEN("IMON_SRC"),
+	SND_SOC_DAPM_SIGGEN("VDD_BATTMON_SRC"),
+	SND_SOC_DAPM_SIGGEN("VDD_BSTMON_SRC"),
+	SND_SOC_DAPM_SIGGEN("ERR_VOL"),
+	SND_SOC_DAPM_SIGGEN("AMP_INTP"),
+	SND_SOC_DAPM_SIGGEN("IL_TARGET"),
+	SND_SOC_DAPM_ADC("VMON", NULL, CS35L45_BLOCK_ENABLES, CS35L45_VMON_EN_SHIFT, 0),
+	SND_SOC_DAPM_ADC("IMON", NULL, CS35L45_BLOCK_ENABLES, CS35L45_IMON_EN_SHIFT, 0),
+	SND_SOC_DAPM_ADC("VDD_BATTMON", NULL, CS35L45_BLOCK_ENABLES,
+			 CS35L45_VDD_BATTMON_EN_SHIFT, 0),
+	SND_SOC_DAPM_ADC("VDD_BSTMON", NULL, CS35L45_BLOCK_ENABLES,
+			 CS35L45_VDD_BSTMON_EN_SHIFT, 0),
+
+	SND_SOC_DAPM_AIF_IN("ASP_RX1", NULL, 0, CS35L45_ASP_ENABLES1, CS35L45_ASP_RX1_EN_SHIFT, 0),
+	SND_SOC_DAPM_AIF_IN("ASP_RX2", NULL, 1, CS35L45_ASP_ENABLES1, CS35L45_ASP_RX2_EN_SHIFT, 0),
+
+	SND_SOC_DAPM_AIF_OUT("ASP_TX1", NULL, 0, CS35L45_ASP_ENABLES1, CS35L45_ASP_TX1_EN_SHIFT, 0),
+	SND_SOC_DAPM_AIF_OUT("ASP_TX2", NULL, 1, CS35L45_ASP_ENABLES1, CS35L45_ASP_TX2_EN_SHIFT, 0),
+	SND_SOC_DAPM_AIF_OUT("ASP_TX3", NULL, 2, CS35L45_ASP_ENABLES1, CS35L45_ASP_TX3_EN_SHIFT, 0),
+	SND_SOC_DAPM_AIF_OUT("ASP_TX4", NULL, 3, CS35L45_ASP_ENABLES1, CS35L45_ASP_TX4_EN_SHIFT, 0),
+	SND_SOC_DAPM_AIF_OUT("ASP_TX5", NULL, 3, CS35L45_ASP_ENABLES1, CS35L45_ASP_TX5_EN_SHIFT, 0),
+
+	SND_SOC_DAPM_MUX("ASP_TX1 Source", SND_SOC_NOPM, 0, 0, &cs35l45_asp_muxes[0]),
+	SND_SOC_DAPM_MUX("ASP_TX2 Source", SND_SOC_NOPM, 0, 0, &cs35l45_asp_muxes[1]),
+	SND_SOC_DAPM_MUX("ASP_TX3 Source", SND_SOC_NOPM, 0, 0, &cs35l45_asp_muxes[2]),
+	SND_SOC_DAPM_MUX("ASP_TX4 Source", SND_SOC_NOPM, 0, 0, &cs35l45_asp_muxes[3]),
+	SND_SOC_DAPM_MUX("ASP_TX5 Source", SND_SOC_NOPM, 0, 0, &cs35l45_asp_muxes[4]),
+
+	SND_SOC_DAPM_MUX("DACPCM1 Source", SND_SOC_NOPM, 0, 0, &cs35l45_dac_muxes[0]),
+
+	SND_SOC_DAPM_OUT_DRV("AMP", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("SPK"),
+};
+
+#define CS35L45_ASP_MUX_ROUTE(name) \
+	{ name" Source", "ASP_RX1",	 "ASP_RX1" }, \
+	{ name" Source", "ASP_RX2",	 "ASP_RX2" }, \
+	{ name" Source", "VMON",	 "VMON" }, \
+	{ name" Source", "IMON",	 "IMON" }, \
+	{ name" Source", "ERR_VOL",	 "ERR_VOL" }, \
+	{ name" Source", "VDD_BATTMON",	 "VDD_BATTMON" }, \
+	{ name" Source", "VDD_BSTMON",	 "VDD_BSTMON" }, \
+	{ name" Source", "Interpolator", "AMP_INTP" }, \
+	{ name" Source", "IL_TARGET",	 "IL_TARGET" }
+
+#define CS35L45_DAC_MUX_ROUTE(name) \
+	{ name" Source", "ASP_RX1",	"ASP_RX1" }, \
+	{ name" Source", "ASP_RX2",	"ASP_RX2" }
+
+static const struct snd_soc_dapm_route cs35l45_dapm_routes[] = {
+	/* Feedback */
+	{ "VMON", NULL, "VMON_SRC" },
+	{ "IMON", NULL, "IMON_SRC" },
+	{ "VDD_BATTMON", NULL, "VDD_BATTMON_SRC" },
+	{ "VDD_BSTMON", NULL, "VDD_BSTMON_SRC" },
+
+	{ "Capture", NULL, "ASP_TX1"},
+	{ "Capture", NULL, "ASP_TX2"},
+	{ "Capture", NULL, "ASP_TX3"},
+	{ "Capture", NULL, "ASP_TX4"},
+	{ "Capture", NULL, "ASP_TX5"},
+	{ "ASP_TX1", NULL, "ASP_TX1 Source"},
+	{ "ASP_TX2", NULL, "ASP_TX2 Source"},
+	{ "ASP_TX3", NULL, "ASP_TX3 Source"},
+	{ "ASP_TX4", NULL, "ASP_TX4 Source"},
+	{ "ASP_TX5", NULL, "ASP_TX5 Source"},
+
+	{ "ASP_TX1", NULL, "ASP_EN" },
+	{ "ASP_TX2", NULL, "ASP_EN" },
+	{ "ASP_TX3", NULL, "ASP_EN" },
+	{ "ASP_TX4", NULL, "ASP_EN" },
+	{ "ASP_TX1", NULL, "GLOBAL_EN" },
+	{ "ASP_TX2", NULL, "GLOBAL_EN" },
+	{ "ASP_TX3", NULL, "GLOBAL_EN" },
+	{ "ASP_TX4", NULL, "GLOBAL_EN" },
+	{ "ASP_TX5", NULL, "GLOBAL_EN" },
+
+	CS35L45_ASP_MUX_ROUTE("ASP_TX1"),
+	CS35L45_ASP_MUX_ROUTE("ASP_TX2"),
+	CS35L45_ASP_MUX_ROUTE("ASP_TX3"),
+	CS35L45_ASP_MUX_ROUTE("ASP_TX4"),
+	CS35L45_ASP_MUX_ROUTE("ASP_TX5"),
+
+	/* Playback */
+	{ "ASP_RX1", NULL, "Playback" },
+	{ "ASP_RX2", NULL, "Playback" },
+	{ "ASP_RX1", NULL, "ASP_EN" },
+	{ "ASP_RX2", NULL, "ASP_EN" },
+
+	{ "AMP", NULL, "DACPCM1 Source"},
+	{ "AMP", NULL, "GLOBAL_EN"},
+
+	CS35L45_DAC_MUX_ROUTE("DACPCM1"),
+
+	{ "SPK", NULL, "AMP"},
+};
+
+static const DECLARE_TLV_DB_SCALE(cs35l45_dig_pcm_vol_tlv, -10225, 25, true);
+
+static const struct snd_kcontrol_new cs35l45_controls[] = {
+	/* Ignore bit 0: it is beyond the resolution of TLV_DB_SCALE */
+	SOC_SINGLE_S_TLV("Digital PCM Volume",
+			 CS35L45_AMP_PCM_CONTROL,
+			 CS35L45_AMP_VOL_PCM_SHIFT + 1,
+			 -409, 48,
+			 (CS35L45_AMP_VOL_PCM_WIDTH - 1) - 1,
+			 0, cs35l45_dig_pcm_vol_tlv),
+};
+
+static int cs35l45_set_pll(struct cs35l45_private *cs35l45, unsigned int freq)
+{
+	unsigned int val;
+	int freq_id;
+
+	freq_id = cs35l45_get_clk_freq_id(freq);
+	if (freq_id < 0) {
+		dev_err(cs35l45->dev, "Invalid freq: %u\n", freq);
+		return -EINVAL;
+	}
+
+	regmap_read(cs35l45->regmap, CS35L45_REFCLK_INPUT, &val);
+	val = (val & CS35L45_PLL_REFCLK_FREQ_MASK) >> CS35L45_PLL_REFCLK_FREQ_SHIFT;
+	if (val == freq_id)
+		return 0;
+
+	regmap_set_bits(cs35l45->regmap, CS35L45_REFCLK_INPUT, CS35L45_PLL_OPEN_LOOP_MASK);
+	regmap_update_bits(cs35l45->regmap, CS35L45_REFCLK_INPUT,
+			   CS35L45_PLL_REFCLK_FREQ_MASK,
+			   freq_id << CS35L45_PLL_REFCLK_FREQ_SHIFT);
+	regmap_clear_bits(cs35l45->regmap, CS35L45_REFCLK_INPUT, CS35L45_PLL_REFCLK_EN_MASK);
+	regmap_clear_bits(cs35l45->regmap, CS35L45_REFCLK_INPUT, CS35L45_PLL_OPEN_LOOP_MASK);
+	regmap_set_bits(cs35l45->regmap, CS35L45_REFCLK_INPUT, CS35L45_PLL_REFCLK_EN_MASK);
+
+	return 0;
+}
+
+static int cs35l45_asp_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct cs35l45_private *cs35l45 = snd_soc_component_get_drvdata(codec_dai->component);
+	unsigned int asp_fmt, fsync_inv, bclk_inv;
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
+		break;
+	default:
+		dev_err(cs35l45->dev, "Invalid DAI clocking\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		asp_fmt = CS35l45_ASP_FMT_DSP_A;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		asp_fmt = CS35L45_ASP_FMT_I2S;
+		break;
+	default:
+		dev_err(cs35l45->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_IF:
+		fsync_inv = 1;
+		bclk_inv = 0;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		fsync_inv = 0;
+		bclk_inv = 1;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		fsync_inv = 1;
+		bclk_inv = 1;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		fsync_inv = 0;
+		bclk_inv = 0;
+		break;
+	default:
+		dev_warn(cs35l45->dev, "Invalid DAI clock polarity\n");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(cs35l45->regmap, CS35L45_ASP_CONTROL2,
+			   CS35L45_ASP_FMT_MASK |
+			   CS35L45_ASP_FSYNC_INV_MASK |
+			   CS35L45_ASP_BCLK_INV_MASK,
+			   (asp_fmt << CS35L45_ASP_FMT_SHIFT) |
+			   (fsync_inv << CS35L45_ASP_FSYNC_INV_SHIFT) |
+			   (bclk_inv << CS35L45_ASP_BCLK_INV_SHIFT));
+
+	return 0;
+}
+
+static int cs35l45_asp_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct cs35l45_private *cs35l45 = snd_soc_component_get_drvdata(dai->component);
+	unsigned int asp_width, asp_wl, global_fs, slot_multiple, asp_fmt;
+	int bclk;
+
+	switch (params_rate(params)) {
+	case 44100:
+		global_fs = CS35L45_44P100_KHZ;
+		break;
+	case 48000:
+		global_fs = CS35L45_48P0_KHZ;
+		break;
+	case 88200:
+		global_fs = CS35L45_88P200_KHZ;
+		break;
+	case 96000:
+		global_fs = CS35L45_96P0_KHZ;
+		break;
+	default:
+		dev_warn(cs35l45->dev, "Unsupported sample rate (%d)\n",
+			 params_rate(params));
+		return -EINVAL;
+	}
+
+	regmap_update_bits(cs35l45->regmap, CS35L45_GLOBAL_SAMPLE_RATE,
+			   CS35L45_GLOBAL_FS_MASK,
+			   global_fs << CS35L45_GLOBAL_FS_SHIFT);
+
+	asp_wl = params_width(params);
+
+	if (cs35l45->slot_width)
+		asp_width = cs35l45->slot_width;
+	else
+		asp_width = params_width(params);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_update_bits(cs35l45->regmap, CS35L45_ASP_CONTROL2,
+				   CS35L45_ASP_WIDTH_RX_MASK,
+				   asp_width << CS35L45_ASP_WIDTH_RX_SHIFT);
+
+		regmap_update_bits(cs35l45->regmap, CS35L45_ASP_DATA_CONTROL5,
+				   CS35L45_ASP_WL_MASK,
+				   asp_wl << CS35L45_ASP_WL_SHIFT);
+	} else {
+		regmap_update_bits(cs35l45->regmap, CS35L45_ASP_CONTROL2,
+				   CS35L45_ASP_WIDTH_TX_MASK,
+				   asp_width << CS35L45_ASP_WIDTH_TX_SHIFT);
+
+		regmap_update_bits(cs35l45->regmap, CS35L45_ASP_DATA_CONTROL1,
+				   CS35L45_ASP_WL_MASK,
+				   asp_wl << CS35L45_ASP_WL_SHIFT);
+	}
+
+	if (cs35l45->sysclk_set)
+		return 0;
+
+	/* I2S always has an even number of channels */
+	regmap_read(cs35l45->regmap, CS35L45_ASP_CONTROL2, &asp_fmt);
+	asp_fmt = (asp_fmt & CS35L45_ASP_FMT_MASK) >> CS35L45_ASP_FMT_SHIFT;
+	if (asp_fmt == CS35L45_ASP_FMT_I2S)
+		slot_multiple = 2;
+	else
+		slot_multiple = 1;
+
+	bclk = snd_soc_tdm_params_to_bclk(params, asp_width,
+					  cs35l45->slot_count, slot_multiple);
+
+	return cs35l45_set_pll(cs35l45, bclk);
+}
+
+static int cs35l45_asp_set_tdm_slot(struct snd_soc_dai *dai,
+				    unsigned int tx_mask, unsigned int rx_mask,
+				    int slots, int slot_width)
+{
+	struct cs35l45_private *cs35l45 = snd_soc_component_get_drvdata(dai->component);
+
+	if (slot_width && ((slot_width < 16) || (slot_width > 128)))
+		return -EINVAL;
+
+	cs35l45->slot_width = slot_width;
+	cs35l45->slot_count = slots;
+
+	return 0;
+}
+
+static int cs35l45_asp_set_sysclk(struct snd_soc_dai *dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct cs35l45_private *cs35l45 = snd_soc_component_get_drvdata(dai->component);
+	int ret;
+
+	if (clk_id != 0) {
+		dev_err(cs35l45->dev, "Invalid clk_id %d\n", clk_id);
+		return -EINVAL;
+	}
+
+	cs35l45->sysclk_set = false;
+	if (freq == 0)
+		return 0;
+
+	ret = cs35l45_set_pll(cs35l45, freq);
+	if (ret < 0)
+		return -EINVAL;
+
+	cs35l45->sysclk_set = true;
+
+	return 0;
+}
+
+static int cs35l45_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct cs35l45_private *cs35l45 = snd_soc_component_get_drvdata(dai->component);
+	unsigned int global_fs, val, hpf_tune;
+
+	if (mute)
+		return 0;
+
+	regmap_read(cs35l45->regmap, CS35L45_GLOBAL_SAMPLE_RATE, &global_fs);
+	global_fs = (global_fs & CS35L45_GLOBAL_FS_MASK) >> CS35L45_GLOBAL_FS_SHIFT;
+	switch (global_fs) {
+	case CS35L45_44P100_KHZ:
+		hpf_tune = CS35L45_HPF_44P1;
+		break;
+	case CS35L45_88P200_KHZ:
+		hpf_tune = CS35L45_HPF_88P2;
+		break;
+	default:
+		hpf_tune = CS35l45_HPF_DEFAULT;
+		break;
+	}
+
+	regmap_read(cs35l45->regmap, CS35L45_AMP_PCM_HPF_TST, &val);
+	if (val != hpf_tune) {
+		struct reg_sequence hpf_override_seq[] = {
+			{ 0x00000040,			0x00000055 },
+			{ 0x00000040,			0x000000AA },
+			{ 0x00000044,			0x00000055 },
+			{ 0x00000044,			0x000000AA },
+			{ CS35L45_AMP_PCM_HPF_TST,	hpf_tune },
+			{ 0x00000040,			0x00000000 },
+			{ 0x00000044,			0x00000000 },
+		};
+		regmap_multi_reg_write(cs35l45->regmap, hpf_override_seq,
+				       ARRAY_SIZE(hpf_override_seq));
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops cs35l45_asp_dai_ops = {
+	.set_fmt = cs35l45_asp_set_fmt,
+	.hw_params = cs35l45_asp_hw_params,
+	.set_tdm_slot = cs35l45_asp_set_tdm_slot,
+	.set_sysclk = cs35l45_asp_set_sysclk,
+	.mute_stream = cs35l45_mute_stream,
+};
+
+static struct snd_soc_dai_driver cs35l45_dai[] = {
+	{
+		.name = "cs35l45",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = CS35L45_RATES,
+			.formats = CS35L45_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 5,
+			.rates = CS35L45_RATES,
+			.formats = CS35L45_FORMATS,
+		},
+		.symmetric_rate = true,
+		.symmetric_sample_bits = true,
+		.ops = &cs35l45_asp_dai_ops,
+	},
+};
+
+static const struct snd_soc_component_driver cs35l45_component = {
+	.dapm_widgets = cs35l45_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(cs35l45_dapm_widgets),
+
+	.dapm_routes = cs35l45_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(cs35l45_dapm_routes),
+
+	.controls = cs35l45_controls,
+	.num_controls = ARRAY_SIZE(cs35l45_controls),
+
+	.name = "cs35l45",
+};
+
+static int __maybe_unused cs35l45_runtime_suspend(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	regcache_cache_only(cs35l45->regmap, true);
+
+	dev_dbg(cs35l45->dev, "Runtime suspended\n");
+
+	return 0;
+}
+
+static int __maybe_unused cs35l45_runtime_resume(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(cs35l45->dev, "Runtime resume\n");
+
+	regcache_cache_only(cs35l45->regmap, false);
+	ret = regcache_sync(cs35l45->regmap);
+	if (ret != 0)
+		dev_warn(cs35l45->dev, "regcache_sync failed: %d\n", ret);
+
+	/* Clear global error status */
+	regmap_clear_bits(cs35l45->regmap, CS35L45_ERROR_RELEASE, CS35L45_GLOBAL_ERR_RLS_MASK);
+	regmap_set_bits(cs35l45->regmap, CS35L45_ERROR_RELEASE, CS35L45_GLOBAL_ERR_RLS_MASK);
+	regmap_clear_bits(cs35l45->regmap, CS35L45_ERROR_RELEASE, CS35L45_GLOBAL_ERR_RLS_MASK);
+	return ret;
+}
+
+static int cs35l45_apply_property_config(struct cs35l45_private *cs35l45)
+{
+	unsigned int val;
+
+	if (device_property_read_u32(cs35l45->dev,
+				     "cirrus,asp-sdout-hiz-ctrl", &val) == 0) {
+		regmap_update_bits(cs35l45->regmap, CS35L45_ASP_CONTROL3,
+				   CS35L45_ASP_DOUT_HIZ_CTRL_MASK,
+				   val << CS35L45_ASP_DOUT_HIZ_CTRL_SHIFT);
+	}
+
+	return 0;
+}
+
+static int cs35l45_initialize(struct cs35l45_private *cs35l45)
+{
+	struct device *dev = cs35l45->dev;
+	unsigned int dev_id[5];
+	unsigned int sts;
+	int ret;
+
+	ret = regmap_read_poll_timeout(cs35l45->regmap, CS35L45_IRQ1_EINT_4, sts,
+				       (sts & CS35L45_OTP_BOOT_DONE_STS_MASK),
+				       1000, 5000);
+	if (ret < 0) {
+		dev_err(cs35l45->dev, "Timeout waiting for OTP boot\n");
+		return ret;
+	}
+
+	ret = regmap_bulk_read(cs35l45->regmap, CS35L45_DEVID, dev_id, ARRAY_SIZE(dev_id));
+	if (ret) {
+		dev_err(cs35l45->dev, "Get Device ID failed: %d\n", ret);
+		return ret;
+	}
+
+	switch (dev_id[0]) {
+	case 0x35A450:
+		break;
+	default:
+		dev_err(cs35l45->dev, "Bad DEVID 0x%x\n", dev_id[0]);
+		return -ENODEV;
+	}
+
+	dev_info(cs35l45->dev, "Cirrus Logic CS35L45: REVID %02X OTPID %02X\n",
+		 dev_id[1], dev_id[4]);
+
+	regmap_write(cs35l45->regmap, CS35L45_IRQ1_EINT_4,
+		     CS35L45_OTP_BOOT_DONE_STS_MASK | CS35L45_OTP_BUSY_MASK);
+
+	ret = cs35l45_apply_patch(cs35l45);
+	if (ret < 0) {
+		dev_err(dev, "Failed to apply init patch %d\n", ret);
+		return ret;
+	}
+
+	/* Default to boost bypass */
+	regmap_update_bits(cs35l45->regmap, CS35L45_BLOCK_ENABLES, CS35L45_BST_EN_MASK,
+			   CS35L45_BST_DISABLE_FET_ON << CS35L45_BST_EN_SHIFT);
+
+	ret = cs35l45_apply_property_config(cs35l45);
+	if (ret < 0)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(cs35l45->dev, 3000);
+	pm_runtime_use_autosuspend(cs35l45->dev);
+	pm_runtime_set_active(cs35l45->dev);
+	pm_runtime_enable(cs35l45->dev);
+
+	return 0;
+}
+
+int cs35l45_probe(struct cs35l45_private *cs35l45)
+{
+	struct device *dev = cs35l45->dev;
+	int ret;
+
+	cs35l45->vdd_batt = devm_regulator_get(dev, "vdd-batt");
+	if (IS_ERR(cs35l45->vdd_batt))
+		return dev_err_probe(dev, PTR_ERR(cs35l45->vdd_batt),
+				     "Failed to request vdd-batt\n");
+
+	cs35l45->vdd_a = devm_regulator_get(dev, "vdd-a");
+	if (IS_ERR(cs35l45->vdd_a))
+		return dev_err_probe(dev, PTR_ERR(cs35l45->vdd_a),
+				     "Failed to request vdd-a\n");
+
+	/* VDD_BATT must always be enabled before other supplies */
+	ret = regulator_enable(cs35l45->vdd_batt);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable vdd-batt\n");
+
+	ret = regulator_enable(cs35l45->vdd_a);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable vdd-a\n");
+
+	/* If reset is shared only one instance can claim it */
+	cs35l45->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cs35l45->reset_gpio)) {
+		ret = PTR_ERR(cs35l45->reset_gpio);
+		cs35l45->reset_gpio = NULL;
+		if (ret == -EBUSY) {
+			dev_dbg(dev, "Reset line busy, assuming shared reset\n");
+		} else {
+			dev_err_probe(dev, ret, "Failed to get reset GPIO\n");
+			goto err;
+		}
+	}
+
+	if (cs35l45->reset_gpio) {
+		usleep_range(CS35L45_RESET_HOLD_US, CS35L45_RESET_HOLD_US + 100);
+		gpiod_set_value_cansleep(cs35l45->reset_gpio, 1);
+	}
+
+	usleep_range(CS35L45_RESET_US, CS35L45_RESET_US + 100);
+
+	ret = cs35l45_initialize(cs35l45);
+	if (ret < 0)
+		goto err_reset;
+
+	ret = devm_snd_soc_register_component(dev, &cs35l45_component,
+					      cs35l45_dai,
+					      ARRAY_SIZE(cs35l45_dai));
+	if (ret < 0)
+		goto err_reset;
+
+	return 0;
+
+err_reset:
+	gpiod_set_value_cansleep(cs35l45->reset_gpio, 0);
+err:
+	regulator_disable(cs35l45->vdd_a);
+	regulator_disable(cs35l45->vdd_batt);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs35l45_probe);
+
+int cs35l45_remove(struct cs35l45_private *cs35l45)
+{
+	pm_runtime_disable(cs35l45->dev);
+
+	gpiod_set_value_cansleep(cs35l45->reset_gpio, 0);
+	regulator_disable(cs35l45->vdd_a);
+	/* VDD_BATT must be the last to power-off */
+	regulator_disable(cs35l45->vdd_batt);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs35l45_remove);
+
+const struct dev_pm_ops cs35l45_pm_ops = {
+	SET_RUNTIME_PM_OPS(cs35l45_runtime_suspend, cs35l45_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_GPL(cs35l45_pm_ops);
+
+MODULE_DESCRIPTION("ASoC CS35L45 driver");
+MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/codecs/cs35l45.h b/sound/soc/codecs/cs35l45.h
new file mode 100644
index 000000000000..4e266d19cd1c
--- /dev/null
+++ b/sound/soc/codecs/cs35l45.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * cs35l45.h - CS35L45 ALSA SoC audio driver
+ *
+ * Copyright 2019-2022 Cirrus Logic, Inc.
+ *
+ * Author: James Schulman <james.schulman@cirrus.com>
+ *
+ */
+
+#ifndef CS35L45_H
+#define CS35L45_H
+
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define CS35L45_DEVID				0x00000000
+#define CS35L45_REVID				0x00000004
+#define CS35L45_RELID				0x0000000C
+#define CS35L45_OTPID				0x00000010
+#define CS35L45_SFT_RESET			0x00000020
+#define CS35L45_GLOBAL_ENABLES			0x00002014
+#define CS35L45_BLOCK_ENABLES			0x00002018
+#define CS35L45_BLOCK_ENABLES2			0x0000201C
+#define CS35L45_ERROR_RELEASE			0x00002034
+#define CS35L45_REFCLK_INPUT			0x00002C04
+#define CS35L45_GLOBAL_SAMPLE_RATE		0x00002C0C
+#define CS35L45_BOOST_CCM_CFG			0x00003808
+#define CS35L45_BOOST_DCM_CFG			0x0000380C
+#define CS35L45_BOOST_OV_CFG			0x0000382C
+#define CS35L45_ASP_ENABLES1			0x00004800
+#define CS35L45_ASP_CONTROL1			0x00004804
+#define CS35L45_ASP_CONTROL2			0x00004808
+#define CS35L45_ASP_CONTROL3			0x0000480C
+#define CS35L45_ASP_FRAME_CONTROL1		0x00004810
+#define CS35L45_ASP_FRAME_CONTROL2		0x00004814
+#define CS35L45_ASP_FRAME_CONTROL5		0x00004820
+#define CS35L45_ASP_DATA_CONTROL1		0x00004830
+#define CS35L45_ASP_DATA_CONTROL5		0x00004840
+#define CS35L45_DACPCM1_INPUT			0x00004C00
+#define CS35L45_ASPTX1_INPUT			0x00004C20
+#define CS35L45_ASPTX2_INPUT			0x00004C24
+#define CS35L45_ASPTX3_INPUT			0x00004C28
+#define CS35L45_ASPTX4_INPUT			0x00004C2C
+#define CS35L45_ASPTX5_INPUT			0x00004C30
+#define CS35L45_LDPM_CONFIG			0x00006404
+#define CS35L45_AMP_PCM_CONTROL			0x00007000
+#define CS35L45_AMP_PCM_HPF_TST			0x00007004
+#define CS35L45_IRQ1_EINT_4			0x0000E01C
+#define CS35L45_LASTREG				0x0000E01C
+
+/* SFT_RESET */
+#define CS35L45_SOFT_RESET_TRIGGER		0x5A000000
+
+/* GLOBAL_ENABLES */
+#define CS35L45_GLOBAL_EN_SHIFT			0
+#define CS35L45_GLOBAL_EN_MASK			BIT(0)
+
+/* BLOCK_ENABLES */
+#define CS35L45_IMON_EN_SHIFT			13
+#define CS35L45_VMON_EN_SHIFT			12
+#define CS35L45_VDD_BSTMON_EN_SHIFT		9
+#define CS35L45_VDD_BATTMON_EN_SHIFT		8
+#define CS35L45_BST_EN_SHIFT			4
+#define CS35L45_BST_EN_MASK			GENMASK(5, 4)
+
+#define CS35L45_BST_DISABLE_FET_ON              0x01
+
+/* BLOCK_ENABLES2 */
+#define CS35L45_ASP_EN_SHIFT			27
+
+/* ERROR_RELEASE */
+#define CS35L45_GLOBAL_ERR_RLS_MASK		BIT(11)
+
+/* REFCLK_INPUT */
+#define CS35L45_PLL_FORCE_EN_SHIFT		16
+#define CS35L45_PLL_FORCE_EN_MASK		BIT(16)
+#define CS35L45_PLL_OPEN_LOOP_SHIFT		11
+#define CS35L45_PLL_OPEN_LOOP_MASK		BIT(11)
+#define CS35L45_PLL_REFCLK_FREQ_SHIFT		5
+#define CS35L45_PLL_REFCLK_FREQ_MASK		GENMASK(10, 5)
+#define CS35L45_PLL_REFCLK_EN_SHIFT		4
+#define CS35L45_PLL_REFCLK_EN_MASK		BIT(4)
+#define CS35L45_PLL_REFCLK_SEL_SHIFT		0
+#define CS35L45_PLL_REFCLK_SEL_MASK		GENMASK(2, 0)
+
+#define CS35L45_PLL_REFCLK_SEL_BCLK		0x0
+
+/* GLOBAL_SAMPLE_RATE */
+#define CS35L45_GLOBAL_FS_SHIFT			0
+#define CS35L45_GLOBAL_FS_MASK			GENMASK(4, 0)
+
+#define CS35L45_48P0_KHZ			0x03
+#define CS35L45_96P0_KHZ			0x04
+#define CS35L45_44P100_KHZ			0x0B
+#define CS35L45_88P200_KHZ			0x0C
+
+/* ASP_ENABLES_1 */
+#define CS35L45_ASP_RX2_EN_SHIFT		17
+#define CS35L45_ASP_RX1_EN_SHIFT		16
+#define CS35L45_ASP_TX5_EN_SHIFT		4
+#define CS35L45_ASP_TX4_EN_SHIFT		3
+#define CS35L45_ASP_TX3_EN_SHIFT		2
+#define CS35L45_ASP_TX2_EN_SHIFT		1
+#define CS35L45_ASP_TX1_EN_SHIFT		0
+
+/* ASP_CONTROL2 */
+#define CS35L45_ASP_WIDTH_RX_SHIFT		24
+#define CS35L45_ASP_WIDTH_RX_MASK		GENMASK(31, 24)
+#define CS35L45_ASP_WIDTH_TX_SHIFT		16
+#define CS35L45_ASP_WIDTH_TX_MASK		GENMASK(23, 16)
+#define CS35L45_ASP_FMT_SHIFT			8
+#define CS35L45_ASP_FMT_MASK			GENMASK(10, 8)
+#define CS35L45_ASP_BCLK_INV_SHIFT		6
+#define CS35L45_ASP_BCLK_INV_MASK		BIT(6)
+#define CS35L45_ASP_FSYNC_INV_SHIFT		2
+#define CS35L45_ASP_FSYNC_INV_MASK		BIT(2)
+
+#define CS35l45_ASP_FMT_DSP_A			0
+#define CS35L45_ASP_FMT_I2S			2
+
+/* ASP_CONTROL3 */
+#define CS35L45_ASP_DOUT_HIZ_CTRL_SHIFT		0
+#define CS35L45_ASP_DOUT_HIZ_CTRL_MASK		GENMASK(1, 0)
+
+/* ASP_FRAME_CONTROL1 */
+#define CS35L45_ASP_TX4_SLOT_SHIFT		24
+#define CS35L45_ASP_TX4_SLOT_MASK		GENMASK(29, 24)
+#define CS35L45_ASP_TX3_SLOT_SHIFT		16
+#define CS35L45_ASP_TX3_SLOT_MASK		GENMASK(21, 16)
+#define CS35L45_ASP_TX2_SLOT_SHIFT		8
+#define CS35L45_ASP_TX2_SLOT_MASK		GENMASK(13, 8)
+#define CS35L45_ASP_TX1_SLOT_SHIFT		0
+#define CS35L45_ASP_TX1_SLOT_MASK		GENMASK(5, 0)
+
+#define CS35L45_ASP_TX_ALL_SLOTS		(CS35L45_ASP_TX4_SLOT_MASK | \
+						CS35L45_ASP_TX3_SLOT_MASK  | \
+						CS35L45_ASP_TX2_SLOT_MASK  | \
+						CS35L45_ASP_TX1_SLOT_MASK)
+/* ASP_FRAME_CONTROL5 */
+#define CS35L45_ASP_RX2_SLOT_SHIFT		8
+#define CS35L45_ASP_RX2_SLOT_MASK		GENMASK(13, 8)
+#define CS35L45_ASP_RX1_SLOT_SHIFT		0
+#define CS35L45_ASP_RX1_SLOT_MASK		GENMASK(5, 0)
+
+#define CS35L45_ASP_RX_ALL_SLOTS		(CS35L45_ASP_RX2_SLOT_MASK | \
+						CS35L45_ASP_RX1_SLOT_MASK)
+
+/* ASP_DATA_CONTROL1 */
+/* ASP_DATA_CONTROL5 */
+#define CS35L45_ASP_WL_SHIFT			0
+#define CS35L45_ASP_WL_MASK			GENMASK(5, 0)
+
+/* AMP_PCM_CONTROL */
+#define CS35L45_AMP_VOL_PCM_SHIFT		0
+#define CS35L45_AMP_VOL_PCM_WIDTH		11
+
+/* AMP_PCM_HPF_TST */
+#define CS35l45_HPF_DEFAULT			0x00000000
+#define CS35L45_HPF_44P1			0x000108BD
+#define CS35L45_HPF_88P2			0x0001045F
+
+/* IRQ1_EINT_4 */
+#define CS35L45_OTP_BOOT_DONE_STS_MASK		BIT(1)
+#define CS35L45_OTP_BUSY_MASK			BIT(0)
+
+/* Mixer sources */
+#define CS35L45_PCM_SRC_MASK			0x7F
+#define CS35L45_PCM_SRC_ZERO			0x00
+#define CS35L45_PCM_SRC_ASP_RX1			0x08
+#define CS35L45_PCM_SRC_ASP_RX2			0x09
+#define CS35L45_PCM_SRC_VMON			0x18
+#define CS35L45_PCM_SRC_IMON			0x19
+#define CS35L45_PCM_SRC_ERR_VOL			0x20
+#define CS35L45_PCM_SRC_CLASSH_TGT		0x21
+#define CS35L45_PCM_SRC_VDD_BATTMON		0x28
+#define CS35L45_PCM_SRC_VDD_BSTMON		0x29
+#define CS35L45_PCM_SRC_TEMPMON			0x3A
+#define CS35L45_PCM_SRC_INTERPOLATOR		0x40
+#define CS35L45_PCM_SRC_IL_TARGET		0x48
+
+#define CS35L45_RESET_HOLD_US			2000
+#define CS35L45_RESET_US			2000
+#define CS35L45_POST_GLOBAL_EN_US		5000
+#define CS35L45_PRE_GLOBAL_DIS_US		3000
+
+#define CS35L45_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S24_3LE| \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
+#define CS35L45_RATES (SNDRV_PCM_RATE_44100 | \
+		       SNDRV_PCM_RATE_48000 | \
+		       SNDRV_PCM_RATE_88200 | \
+		       SNDRV_PCM_RATE_96000)
+
+struct cs35l45_private {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
+	struct regulator *vdd_batt;
+	struct regulator *vdd_a;
+	bool initialized;
+	bool sysclk_set;
+	u8 slot_width;
+	u8 slot_count;
+};
+
+extern const struct dev_pm_ops cs35l45_pm_ops;
+extern const struct regmap_config cs35l45_i2c_regmap;
+extern const struct regmap_config cs35l45_spi_regmap;
+int cs35l45_apply_patch(struct cs35l45_private *cs43l45);
+unsigned int cs35l45_get_clk_freq_id(unsigned int freq);
+int cs35l45_probe(struct cs35l45_private *cs35l45);
+int cs35l45_remove(struct cs35l45_private *cs35l45);
+
+#endif /* CS35L45_H */
-- 
2.30.2

