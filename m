Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA6A502DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355785AbiDOQUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbiDOQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:20:40 -0400
Received: from 18.mo581.mail-out.ovh.net (18.mo581.mail-out.ovh.net [188.165.56.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECADD9D4EE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:18:10 -0700 (PDT)
Received: from player788.ha.ovh.net (unknown [10.109.146.163])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id CC68E21373
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:38:59 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player788.ha.ovh.net (Postfix) with ESMTPSA id 6079629867051;
        Fri, 15 Apr 2022 15:38:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R003578593f1-443d-463e-8331-d38840e060bb,
                    77125C2C2681624F8512B69FC7A1C9B53E6602B4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 5/6] ASoC: tas*: use i2c_match_id and simple i2c probe
Date:   Fri, 15 Apr 2022 17:38:16 +0200
Message-Id: <20220415153817.141364-6-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415153817.141364-1-steve@sk2.org>
References: <20220415153817.141364-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10489727957861238406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejkeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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

The i2c id tables are moved up before the probe function, as
suggested by Wolfram Sang, except where the existing code already had
a declaration for the of_device_id table.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 sound/soc/codecs/tas2562.c | 25 +++++++++++++------------
 sound/soc/codecs/tas571x.c | 11 +++++++----
 sound/soc/codecs/tas5720.c | 21 +++++++++++----------
 3 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 10302552195e..e62a3da16aed 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -754,17 +754,27 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 	return ret;
 }
 
-static int tas2562_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static const struct i2c_device_id tas2562_id[] = {
+	{ "tas2562", TAS2562 },
+	{ "tas2563", TAS2563 },
+	{ "tas2564", TAS2564 },
+	{ "tas2110", TAS2110 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tas2562_id);
+
+static int tas2562_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct tas2562_data *data;
 	int ret;
+	const struct i2c_device_id *id;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	id = i2c_match_id(tas2562_id, client);
 	data->client = client;
 	data->dev = &client->dev;
 	data->model_id = id->driver_data;
@@ -792,15 +802,6 @@ static int tas2562_probe(struct i2c_client *client,
 
 }
 
-static const struct i2c_device_id tas2562_id[] = {
-	{ "tas2562", TAS2562 },
-	{ "tas2563", TAS2563 },
-	{ "tas2564", TAS2564 },
-	{ "tas2110", TAS2110 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, tas2562_id);
-
 #ifdef CONFIG_OF
 static const struct of_device_id tas2562_of_match[] = {
 	{ .compatible = "ti,tas2562", },
@@ -817,7 +818,7 @@ static struct i2c_driver tas2562_i2c_driver = {
 		.name = "tas2562",
 		.of_match_table = of_match_ptr(tas2562_of_match),
 	},
-	.probe = tas2562_probe,
+	.probe_new = tas2562_probe,
 	.id_table = tas2562_id,
 };
 
diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index a3e682376946..dd289774efb2 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -774,9 +774,9 @@ static struct snd_soc_dai_driver tas571x_dai = {
 };
 
 static const struct of_device_id tas571x_of_match[] __maybe_unused;
+static const struct i2c_device_id tas571x_i2c_id[];
 
-static int tas571x_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int tas571x_i2c_probe(struct i2c_client *client)
 {
 	struct tas571x_private *priv;
 	struct device *dev = &client->dev;
@@ -791,8 +791,11 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 	of_id = of_match_device(tas571x_of_match, dev);
 	if (of_id)
 		priv->chip = of_id->data;
-	else
+	else {
+		const struct i2c_device_id *id =
+			i2c_match_id(tas571x_i2c_id, client);
 		priv->chip = (void *) id->driver_data;
+	}
 
 	priv->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(priv->mclk) && PTR_ERR(priv->mclk) != -ENOENT) {
@@ -914,7 +917,7 @@ static struct i2c_driver tas571x_i2c_driver = {
 		.name = "tas571x",
 		.of_match_table = of_match_ptr(tas571x_of_match),
 	},
-	.probe = tas571x_i2c_probe,
+	.probe_new = tas571x_i2c_probe,
 	.remove = tas571x_i2c_remove,
 	.id_table = tas571x_i2c_id,
 };
diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index 9ff644ddb470..17034abef568 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -633,12 +633,19 @@ static struct snd_soc_dai_driver tas5720_dai[] = {
 	},
 };
 
-static int tas5720_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static const struct i2c_device_id tas5720_id[] = {
+	{ "tas5720", TAS5720 },
+	{ "tas5722", TAS5722 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tas5720_id);
+
+static int tas5720_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct tas5720_data *data;
 	const struct regmap_config *regmap_config;
+	const struct i2c_device_id *id;
 	int ret;
 	int i;
 
@@ -646,6 +653,7 @@ static int tas5720_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
+	id = i2c_match_id(tas5720_id, client);
 	data->tas5720_client = client;
 	data->devtype = id->driver_data;
 
@@ -704,13 +712,6 @@ static int tas5720_probe(struct i2c_client *client,
 	return 0;
 }
 
-static const struct i2c_device_id tas5720_id[] = {
-	{ "tas5720", TAS5720 },
-	{ "tas5722", TAS5722 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, tas5720_id);
-
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id tas5720_of_match[] = {
 	{ .compatible = "ti,tas5720", },
@@ -725,7 +726,7 @@ static struct i2c_driver tas5720_i2c_driver = {
 		.name = "tas5720",
 		.of_match_table = of_match_ptr(tas5720_of_match),
 	},
-	.probe = tas5720_probe,
+	.probe_new = tas5720_probe,
 	.id_table = tas5720_id,
 };
 
-- 
2.27.0

