Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D9B502D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355706AbiDOQJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiDOQJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:09:28 -0400
Received: from 10.mo550.mail-out.ovh.net (10.mo550.mail-out.ovh.net [178.32.96.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF438A307
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:06:59 -0700 (PDT)
Received: from player760.ha.ovh.net (unknown [10.111.172.135])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 8D26D24153
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:06:57 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id 489522986A932;
        Fri, 15 Apr 2022 16:06:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G0043f5dd12a-890b-4a28-832d-898a6081a301,
                    77125C2C2681624F8512B69FC7A1C9B53E6602B4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 3/7] ASoC: max980*: use i2c_match_id and simple i2c probe
Date:   Fri, 15 Apr 2022 18:06:09 +0200
Message-Id: <20220415160613.148882-4-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415160613.148882-1-steve@sk2.org>
References: <20220415160613.148882-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10962042969681856134
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
suggested by Wolfram Sang.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 sound/soc/codecs/max98088.c | 21 +++++++++++----------
 sound/soc/codecs/max98090.c | 23 ++++++++++++-----------
 sound/soc/codecs/max98095.c | 19 ++++++++++---------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 429717d4ac5a..5ef2e1279ee7 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1737,11 +1737,18 @@ static const struct snd_soc_component_driver soc_component_dev_max98088 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int max98088_i2c_probe(struct i2c_client *i2c,
-			      const struct i2c_device_id *id)
+static const struct i2c_device_id max98088_i2c_id[] = {
+       { "max98088", MAX98088 },
+       { "max98089", MAX98089 },
+       { }
+};
+MODULE_DEVICE_TABLE(i2c, max98088_i2c_id);
+
+static int max98088_i2c_probe(struct i2c_client *i2c)
 {
        struct max98088_priv *max98088;
        int ret;
+       const struct i2c_device_id *id;
 
        max98088 = devm_kzalloc(&i2c->dev, sizeof(struct max98088_priv),
 			       GFP_KERNEL);
@@ -1757,6 +1764,7 @@ static int max98088_i2c_probe(struct i2c_client *i2c,
 		if (PTR_ERR(max98088->mclk) == -EPROBE_DEFER)
 			return PTR_ERR(max98088->mclk);
 
+	id = i2c_match_id(max98088_i2c_id, i2c);
        max98088->devtype = id->driver_data;
 
        i2c_set_clientdata(i2c, max98088);
@@ -1767,13 +1775,6 @@ static int max98088_i2c_probe(struct i2c_client *i2c,
        return ret;
 }
 
-static const struct i2c_device_id max98088_i2c_id[] = {
-       { "max98088", MAX98088 },
-       { "max98089", MAX98089 },
-       { }
-};
-MODULE_DEVICE_TABLE(i2c, max98088_i2c_id);
-
 #if defined(CONFIG_OF)
 static const struct of_device_id max98088_of_match[] = {
 	{ .compatible = "maxim,max98088" },
@@ -1788,7 +1789,7 @@ static struct i2c_driver max98088_i2c_driver = {
 		.name = "max98088",
 		.of_match_table = of_match_ptr(max98088_of_match),
 	},
-	.probe  = max98088_i2c_probe,
+	.probe_new = max98088_i2c_probe,
 	.id_table = max98088_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index b45ec35cd63c..4058e147413c 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2529,8 +2529,14 @@ static const struct regmap_config max98090_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int max98090_i2c_probe(struct i2c_client *i2c,
-				 const struct i2c_device_id *i2c_id)
+static const struct i2c_device_id max98090_i2c_id[] = {
+	{ "max98090", MAX98090 },
+	{ "max98091", MAX98091 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max98090_i2c_id);
+
+static int max98090_i2c_probe(struct i2c_client *i2c)
 {
 	struct max98090_priv *max98090;
 	const struct acpi_device_id *acpi_id;
@@ -2552,7 +2558,9 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 			return -EINVAL;
 		}
 		driver_data = acpi_id->driver_data;
-	} else if (i2c_id) {
+	} else {
+		const struct i2c_device_id *i2c_id =
+			i2c_match_id(max98090_i2c_id, i2c);
 		driver_data = i2c_id->driver_data;
 	}
 
@@ -2659,13 +2667,6 @@ static const struct dev_pm_ops max98090_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(NULL, max98090_resume)
 };
 
-static const struct i2c_device_id max98090_i2c_id[] = {
-	{ "max98090", MAX98090 },
-	{ "max98091", MAX98091 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, max98090_i2c_id);
-
 #ifdef CONFIG_OF
 static const struct of_device_id max98090_of_match[] = {
 	{ .compatible = "maxim,max98090", },
@@ -2690,7 +2691,7 @@ static struct i2c_driver max98090_i2c_driver = {
 		.of_match_table = of_match_ptr(max98090_of_match),
 		.acpi_match_table = ACPI_PTR(max98090_acpi_match),
 	},
-	.probe  = max98090_i2c_probe,
+	.probe_new = max98090_i2c_probe,
 	.shutdown = max98090_i2c_shutdown,
 	.remove = max98090_i2c_remove,
 	.id_table = max98090_i2c_id,
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 4977b00ddf5f..7bca99fa61b5 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2106,11 +2106,17 @@ static const struct snd_soc_component_driver soc_component_dev_max98095 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int max98095_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static const struct i2c_device_id max98095_i2c_id[] = {
+	{ "max98095", MAX98095 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max98095_i2c_id);
+
+static int max98095_i2c_probe(struct i2c_client *i2c)
 {
 	struct max98095_priv *max98095;
 	int ret;
+	const struct i2c_device_id *id;
 
 	max98095 = devm_kzalloc(&i2c->dev, sizeof(struct max98095_priv),
 				GFP_KERNEL);
@@ -2126,6 +2132,7 @@ static int max98095_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	id = i2c_match_id(max98095_i2c_id, i2c);
 	max98095->devtype = id->driver_data;
 	i2c_set_clientdata(i2c, max98095);
 	max98095->pdata = i2c->dev.platform_data;
@@ -2136,12 +2143,6 @@ static int max98095_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static const struct i2c_device_id max98095_i2c_id[] = {
-	{ "max98095", MAX98095 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, max98095_i2c_id);
-
 #ifdef CONFIG_OF
 static const struct of_device_id max98095_of_match[] = {
 	{ .compatible = "maxim,max98095", },
@@ -2155,7 +2156,7 @@ static struct i2c_driver max98095_i2c_driver = {
 		.name = "max98095",
 		.of_match_table = of_match_ptr(max98095_of_match),
 	},
-	.probe  = max98095_i2c_probe,
+	.probe_new = max98095_i2c_probe,
 	.id_table = max98095_i2c_id,
 };
 
-- 
2.27.0

