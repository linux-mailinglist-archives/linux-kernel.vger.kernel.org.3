Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59178502D82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355725AbiDOQJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355731AbiDOQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:09:48 -0400
Received: from 14.mo581.mail-out.ovh.net (14.mo581.mail-out.ovh.net [178.33.251.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF649D4F4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:07:18 -0700 (PDT)
Received: from player760.ha.ovh.net (unknown [10.108.16.30])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id EC8D324076
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:07:16 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id 2C08B2986A9D0;
        Fri, 15 Apr 2022 16:07:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G004e75f73f7-ba6f-4611-9337-3f47a91ff516,
                    77125C2C2681624F8512B69FC7A1C9B53E6602B4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 6/7] ASoC: tlv320*: use i2c_match_id and simple i2c probe
Date:   Fri, 15 Apr 2022 18:06:12 +0200
Message-Id: <20220415160613.148882-7-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415160613.148882-1-steve@sk2.org>
References: <20220415160613.148882-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10967390995997951622
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the ongoing i2c transition to the simple probe
("probe_new"), this patch uses i2c_match_id to retrieve the
driver_data for the probed device. The id parameter is thus no longer
necessary and the simple probe can be used instead.

In the context of an i2c probe, i2c_match_id with the module id table
and the probed client never returns null, so removing the null check
on the i2c_device_id pointer is safe.

The i2c id tables are moved up before the probe function, as
suggested by Wolfram Sang, except where the existing code already had
a declaration for the of_device_id table.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 sound/soc/codecs/tlv320adc3xxx.c     | 21 +++++++++---------
 sound/soc/codecs/tlv320aic31xx.c     | 32 ++++++++++++++--------------
 sound/soc/codecs/tlv320aic32x4-i2c.c | 11 ++++++----
 sound/soc/codecs/tlv320aic3x-i2c.c   | 25 +++++++++++-----------
 4 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index ae18982ac310..a5e9f80cfa32 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -1337,11 +1337,18 @@ static const struct snd_soc_component_driver soc_component_dev_adc3xxx = {
 	.num_dapm_routes	= ARRAY_SIZE(adc3xxx_intercon),
 };
 
-static int adc3xxx_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static const struct i2c_device_id adc3xxx_i2c_id[] = {
+	{ "tlv320adc3001", ADC3001 },
+	{ "tlv320adc3101", ADC3101 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, adc3xxx_i2c_id);
+
+static int adc3xxx_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct adc3xxx *adc3xxx = NULL;
+	const struct i2c_device_id *id;
 	int ret;
 
 	adc3xxx = devm_kzalloc(dev, sizeof(struct adc3xxx), GFP_KERNEL);
@@ -1394,6 +1401,7 @@ static int adc3xxx_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, adc3xxx);
 
+	id = i2c_match_id(adc3xxx_i2c_id, i2c);
 	adc3xxx->type = id->driver_data;
 
 	/* Reset codec chip */
@@ -1436,19 +1444,12 @@ static const struct of_device_id tlv320adc3xxx_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tlv320adc3xxx_of_match);
 
-static const struct i2c_device_id adc3xxx_i2c_id[] = {
-	{ "tlv320adc3001", ADC3001 },
-	{ "tlv320adc3101", ADC3101 },
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, adc3xxx_i2c_id);
-
 static struct i2c_driver adc3xxx_i2c_driver = {
 	.driver = {
 		   .name = "tlv320adc3xxx-codec",
 		   .of_match_table = tlv320adc3xxx_of_match,
 		  },
-	.probe = adc3xxx_i2c_probe,
+	.probe_new = adc3xxx_i2c_probe,
 	.remove = adc3xxx_i2c_remove,
 	.id_table = adc3xxx_i2c_id,
 };
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 8331dc26bcd2..b2e59581c17a 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1628,11 +1628,24 @@ static void aic31xx_configure_ocmv(struct aic31xx_priv *priv)
 	}
 }
 
-static int aic31xx_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static const struct i2c_device_id aic31xx_i2c_id[] = {
+	{ "tlv320aic310x", AIC3100 },
+	{ "tlv320aic311x", AIC3110 },
+	{ "tlv320aic3100", AIC3100 },
+	{ "tlv320aic3110", AIC3110 },
+	{ "tlv320aic3120", AIC3120 },
+	{ "tlv320aic3111", AIC3111 },
+	{ "tlv320dac3100", DAC3100 },
+	{ "tlv320dac3101", DAC3101 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aic31xx_i2c_id);
+
+static int aic31xx_i2c_probe(struct i2c_client *i2c)
 {
 	struct aic31xx_priv *aic31xx;
 	unsigned int micbias_value = MICBIAS_2_0V;
+	const struct i2c_device_id *id = i2c_match_id(aic31xx_i2c_id, i2c);
 	int i, ret;
 
 	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
@@ -1729,26 +1742,13 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 				ARRAY_SIZE(aic31xx_dai_driver));
 }
 
-static const struct i2c_device_id aic31xx_i2c_id[] = {
-	{ "tlv320aic310x", AIC3100 },
-	{ "tlv320aic311x", AIC3110 },
-	{ "tlv320aic3100", AIC3100 },
-	{ "tlv320aic3110", AIC3110 },
-	{ "tlv320aic3120", AIC3120 },
-	{ "tlv320aic3111", AIC3111 },
-	{ "tlv320dac3100", DAC3100 },
-	{ "tlv320dac3101", DAC3101 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, aic31xx_i2c_id);
-
 static struct i2c_driver aic31xx_i2c_driver = {
 	.driver = {
 		.name	= "tlv320aic31xx-codec",
 		.of_match_table = of_match_ptr(tlv320aic31xx_of_match),
 		.acpi_match_table = ACPI_PTR(aic31xx_acpi_match),
 	},
-	.probe		= aic31xx_i2c_probe,
+	.probe_new	= aic31xx_i2c_probe,
 	.id_table	= aic31xx_i2c_id,
 };
 module_i2c_driver(aic31xx_i2c_driver);
diff --git a/sound/soc/codecs/tlv320aic32x4-i2c.c b/sound/soc/codecs/tlv320aic32x4-i2c.c
index ed70e3d9baf2..0645239901b1 100644
--- a/sound/soc/codecs/tlv320aic32x4-i2c.c
+++ b/sound/soc/codecs/tlv320aic32x4-i2c.c
@@ -17,9 +17,9 @@
 #include "tlv320aic32x4.h"
 
 static const struct of_device_id aic32x4_of_id[];
+static const struct i2c_device_id aic32x4_i2c_id[];
 
-static int aic32x4_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int aic32x4_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap *regmap;
 	struct regmap_config config;
@@ -35,7 +35,10 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 
 		oid = of_match_node(aic32x4_of_id, i2c->dev.of_node);
 		dev_set_drvdata(&i2c->dev, (void *)oid->data);
-	} else if (id) {
+	} else {
+		const struct i2c_device_id *id;
+
+		id = i2c_match_id(aic32x4_i2c_id, i2c);
 		dev_set_drvdata(&i2c->dev, (void *)id->driver_data);
 	}
 
@@ -70,7 +73,7 @@ static struct i2c_driver aic32x4_i2c_driver = {
 		.name = "tlv320aic32x4",
 		.of_match_table = aic32x4_of_id,
 	},
-	.probe =    aic32x4_i2c_probe,
+	.probe_new = aic32x4_i2c_probe,
 	.remove =   aic32x4_i2c_remove,
 	.id_table = aic32x4_i2c_id,
 };
diff --git a/sound/soc/codecs/tlv320aic3x-i2c.c b/sound/soc/codecs/tlv320aic3x-i2c.c
index 2f272bc3f5da..7bd9ce08bb7b 100644
--- a/sound/soc/codecs/tlv320aic3x-i2c.c
+++ b/sound/soc/codecs/tlv320aic3x-i2c.c
@@ -17,10 +17,21 @@
 
 #include "tlv320aic3x.h"
 
-static int aic3x_i2c_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
+static const struct i2c_device_id aic3x_i2c_id[] = {
+	{ "tlv320aic3x", AIC3X_MODEL_3X },
+	{ "tlv320aic33", AIC3X_MODEL_33 },
+	{ "tlv320aic3007", AIC3X_MODEL_3007 },
+	{ "tlv320aic3104", AIC3X_MODEL_3104 },
+	{ "tlv320aic3106", AIC3X_MODEL_3106 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
+
+static int aic3x_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap *regmap;
 	struct regmap_config config;
+	const struct i2c_device_id *id = i2c_match_id(aic3x_i2c_id, i2c);
 
 	config = aic3x_regmap;
 	config.reg_bits = 8;
@@ -37,16 +48,6 @@ static int aic3x_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-static const struct i2c_device_id aic3x_i2c_id[] = {
-	{ "tlv320aic3x", AIC3X_MODEL_3X },
-	{ "tlv320aic33", AIC3X_MODEL_33 },
-	{ "tlv320aic3007", AIC3X_MODEL_3007 },
-	{ "tlv320aic3104", AIC3X_MODEL_3104 },
-	{ "tlv320aic3106", AIC3X_MODEL_3106 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
-
 static const struct of_device_id aic3x_of_id[] = {
 	{ .compatible = "ti,tlv320aic3x", },
 	{ .compatible = "ti,tlv320aic33" },
@@ -62,7 +63,7 @@ static struct i2c_driver aic3x_i2c_driver = {
 		.name = "tlv320aic3x",
 		.of_match_table = aic3x_of_id,
 	},
-	.probe = aic3x_i2c_probe,
+	.probe_new = aic3x_i2c_probe,
 	.remove = aic3x_i2c_remove,
 	.id_table = aic3x_i2c_id,
 };
-- 
2.27.0

