Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA19599C57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349173AbiHSMxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349107AbiHSMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:52:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EBDDD76A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:52:49 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J5opPp018534;
        Fri, 19 Aug 2022 07:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=YPyYO+awQHghfR5w93OJCOFA7k5aAerbXnMIQeWLp5A=;
 b=K9j16F6ezJxWBt/sadmesYYpHAHoAOIPeLtmUGURT/5PgKSZIxUrTZV/UnpjNwqnY06y
 EKABZs5pJ48biDn2UK7d3ptKSkLNFvHwb9+arnBf0yYuShNYPA8Q992fwcmAxBrpKZWn
 2L2yyMDlJqDaAh0UCWr+YSrxCotDbLQpNg2msFqI2obQnl25WpnhM0pOODE5E5f/ogZc
 ILMGR5RtggrlUUw5rarDEjTMz1bkf/cOKo72heNM8VSirF9x8+OPEBR/QtqPaHP1w0Hs
 fl+zBgL1zrxqri7aGrqP19Jg8Tobb7vjGjqLI+OUfC5xNnJPdzA2KtMVhxLmbea9zNA1 EA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hx9c1yrtp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 07:52:38 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 19 Aug
 2022 07:52:34 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Fri, 19 Aug 2022 07:52:34 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C185AB16;
        Fri, 19 Aug 2022 12:52:34 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 06/12] ASoC: cs42l42: Split probe() and remove() into stages
Date:   Fri, 19 Aug 2022 13:52:24 +0100
Message-ID: <20220819125230.42731-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220819125230.42731-1-rf@opensource.cirrus.com>
References: <20220819125230.42731-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FKvqLhMu-RBxZOc4NIsvBBQcU5Mrtsnf
X-Proofpoint-GUID: FKvqLhMu-RBxZOc4NIsvBBQcU5Mrtsnf
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for adding Soundwire the probe must be split into three
parts:

1) The bus-specific probe
2) Common bus-agnostic probe steps
3) Initialization of the peripheral registers

Step (3) must be separate because on Soundwire devices the probe must
enable power supplies and release reset so that the peripheral can be
enumerated by the bus, but it isn't possible to access registers until
enumeration has completed.

The call to devm_snd_soc_register_component() must be done at stage (2)
so that it can EPROBE_DEFER if necessary. In Soundwire systems stage (3)
is not a probe event so a deferral at this stage would not result in
re-probing dependencies.

A new init_done flag indicates that the chip has been identified and
initialized. This is used to prevent cs42l42_remove(), cs42l42_suspend(),
cs42l42_restore() and cs42l42_irq_thread() from attempting register
accesses if the chip was not successfully initialized. Although this
cannot happen on I2C, because the entire probe would fail, it is
possible on Soundwire if probe succeeds but the cs42l42 is never
enumerated.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 122 +++++++++++++++++++++++++------------
 sound/soc/codecs/cs42l42.h |   2 +
 2 files changed, 84 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 4c81bda6b593..8c5909a43df6 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1641,7 +1641,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	unsigned int i;
 
 	mutex_lock(&cs42l42->irq_lock);
-	if (cs42l42->suspended) {
+	if (cs42l42->suspended || !cs42l42->init_done) {
 		mutex_unlock(&cs42l42->irq_lock);
 		return IRQ_NONE;
 	}
@@ -2215,28 +2215,13 @@ static int __maybe_unused cs42l42_resume(struct device *dev)
 	return 0;
 }
 
-static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
+static int cs42l42_common_probe(struct cs42l42_private *cs42l42)
 {
-	struct cs42l42_private *cs42l42;
-	int ret, i, devid;
-	unsigned int reg;
-
-	cs42l42 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l42_private),
-			       GFP_KERNEL);
-	if (!cs42l42)
-		return -ENOMEM;
+	int ret, i;
 
-	cs42l42->dev = &i2c_client->dev;
-	i2c_set_clientdata(i2c_client, cs42l42);
+	dev_set_drvdata(cs42l42->dev, cs42l42);
 	mutex_init(&cs42l42->irq_lock);
 
-	cs42l42->regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
-	if (IS_ERR(cs42l42->regmap)) {
-		ret = PTR_ERR(cs42l42->regmap);
-		dev_err(cs42l42->dev, "regmap_init() failed: %d\n", ret);
-		return ret;
-	}
-
 	BUILD_BUG_ON(ARRAY_SIZE(cs42l42_supply_names) != ARRAY_SIZE(cs42l42->supplies));
 	for (i = 0; i < ARRAY_SIZE(cs42l42->supplies); i++)
 		cs42l42->supplies[i].supply = cs42l42_supply_names[i];
@@ -2273,8 +2258,8 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
 	/* Request IRQ if one was specified */
-	if (i2c_client->irq) {
-		ret = request_threaded_irq(i2c_client->irq,
+	if (cs42l42->irq) {
+		ret = request_threaded_irq(cs42l42->irq,
 					   NULL, cs42l42_irq_thread,
 					   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
 					   "cs42l42", cs42l42);
@@ -2287,6 +2272,32 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 		}
 	}
 
+	/* Register codec now so it can EPROBE_DEFER */
+	ret = devm_snd_soc_register_component(cs42l42->dev,
+					      &soc_component_dev_cs42l42,
+					      &cs42l42_dai, 1);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+
+err:
+	if (cs42l42->irq)
+		free_irq(cs42l42->irq, cs42l42);
+
+err_disable_noirq:
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+err_disable_noreset:
+	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
+
+	return ret;
+}
+
+static int cs42l42_init(struct cs42l42_private *cs42l42)
+{
+	unsigned int reg;
+	int devid, ret;
+
 	/* initialize codec */
 	devid = cirrus_read_device_id(cs42l42->regmap, CS42L42_DEVID_AB);
 	if (devid < 0) {
@@ -2336,15 +2347,15 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	/* Setup headset detection */
 	cs42l42_setup_hs_type_detect(cs42l42);
 
+	/*
+	 * Set init_done before unmasking interrupts so any triggered
+	 * immediately will be handled.
+	 */
+	cs42l42->init_done = true;
+
 	/* Mask/Unmask Interrupts */
 	cs42l42_set_interrupt_masks(cs42l42);
 
-	/* Register codec for machine driver */
-	ret = devm_snd_soc_register_component(cs42l42->dev,
-			&soc_component_dev_cs42l42, &cs42l42_dai, 1);
-	if (ret < 0)
-		goto err_shutdown;
-
 	return 0;
 
 err_shutdown:
@@ -2353,34 +2364,65 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	regmap_write(cs42l42->regmap, CS42L42_PWR_CTL1, 0xff);
 
 err_disable:
-	if (i2c_client->irq)
-		free_irq(i2c_client->irq, cs42l42);
-
-err_disable_noirq:
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
-err_disable_noreset:
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
 				cs42l42->supplies);
 	return ret;
 }
 
-static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
+static void cs42l42_common_remove(struct cs42l42_private *cs42l42)
 {
-	struct cs42l42_private *cs42l42 = i2c_get_clientdata(i2c_client);
-
-	if (i2c_client->irq)
-		free_irq(i2c_client->irq, cs42l42);
+	if (cs42l42->irq)
+		free_irq(cs42l42->irq, cs42l42);
 
 	/*
 	 * The driver might not have control of reset and power supplies,
 	 * so ensure that the chip internals are powered down.
 	 */
-	regmap_write(cs42l42->regmap, CS42L42_CODEC_INT_MASK, 0xff);
-	regmap_write(cs42l42->regmap, CS42L42_TSRS_PLUG_INT_MASK, 0xff);
-	regmap_write(cs42l42->regmap, CS42L42_PWR_CTL1, 0xff);
+	if (cs42l42->init_done) {
+		regmap_write(cs42l42->regmap, CS42L42_CODEC_INT_MASK, 0xff);
+		regmap_write(cs42l42->regmap, CS42L42_TSRS_PLUG_INT_MASK, 0xff);
+		regmap_write(cs42l42->regmap, CS42L42_PWR_CTL1, 0xff);
+	}
 
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
+}
+
+static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
+{
+	struct device *dev = &i2c_client->dev;
+	struct cs42l42_private *cs42l42;
+	struct regmap *regmap;
+	int ret;
+
+	cs42l42 = devm_kzalloc(dev, sizeof(struct cs42l42_private), GFP_KERNEL);
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
+	ret = cs42l42_common_probe(cs42l42);
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
 
 	return 0;
 }
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 2e4e01f9e389..4ee61136080d 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -29,6 +29,7 @@ struct  cs42l42_private {
 	struct completion pdn_done;
 	struct snd_soc_jack *jack;
 	struct mutex irq_lock;
+	int irq;
 	int pll_config;
 	u32 sclk;
 	u8 plug_state;
@@ -45,6 +46,7 @@ struct  cs42l42_private {
 	u8 stream_use;
 	bool hp_adc_up_pending;
 	bool suspended;
+	bool init_done;
 };
 
 #endif /* __CS42L42_H__ */
-- 
2.30.2

