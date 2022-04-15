Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AEC502D27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiDOPl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355582AbiDOPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:41:14 -0400
Received: from 2.mo561.mail-out.ovh.net (2.mo561.mail-out.ovh.net [46.105.75.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C53F5FF39
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:38:44 -0700 (PDT)
Received: from player788.ha.ovh.net (unknown [10.111.208.246])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 42C5121DA2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:38:43 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player788.ha.ovh.net (Postfix) with ESMTPSA id 73BFA29866FCD;
        Fri, 15 Apr 2022 15:38:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R0030be502f0-0fbd-48b4-bf4f-31be7de196f1,
                    77125C2C2681624F8512B69FC7A1C9B53E6602B4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 2/6] ASoC: alc56*: use i2c_match_id and simple i2c probe
Date:   Fri, 15 Apr 2022 17:38:13 +0200
Message-Id: <20220415153817.141364-3-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415153817.141364-1-steve@sk2.org>
References: <20220415153817.141364-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10485224359175095942
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejkeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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

The i2c id tables are moved up before the probe function, as
suggested by Wolfram Sang.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 sound/soc/codecs/alc5623.c | 24 +++++++++++++-----------
 sound/soc/codecs/alc5632.c | 20 +++++++++++---------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index b10357a6d655..8e6235d2c544 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -968,14 +968,21 @@ static const struct regmap_config alc5623_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static const struct i2c_device_id alc5623_i2c_table[] = {
+	{"alc5621", 0x21},
+	{"alc5622", 0x22},
+	{"alc5623", 0x23},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, alc5623_i2c_table);
+
 /*
  * ALC5623 2 wire address is determined by A1 pin
  * state during powerup.
  *    low  = 0x1a
  *    high = 0x1b
  */
-static int alc5623_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int alc5623_i2c_probe(struct i2c_client *client)
 {
 	struct alc5623_platform_data *pdata;
 	struct alc5623_priv *alc5623;
@@ -983,6 +990,7 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 	unsigned int vid1, vid2;
 	int ret;
 	u32 val32;
+	const struct i2c_device_id *id;
 
 	alc5623 = devm_kzalloc(&client->dev, sizeof(struct alc5623_priv),
 			       GFP_KERNEL);
@@ -1009,6 +1017,8 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 	}
 	vid2 >>= 8;
 
+	id = i2c_match_id(alc5623_i2c_table, client);
+
 	if ((vid1 != 0x10ec) || (vid2 != id->driver_data)) {
 		dev_err(&client->dev, "unknown or wrong codec\n");
 		dev_err(&client->dev, "Expected %x:%lx, got %x:%x\n",
@@ -1060,14 +1070,6 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static const struct i2c_device_id alc5623_i2c_table[] = {
-	{"alc5621", 0x21},
-	{"alc5622", 0x22},
-	{"alc5623", 0x23},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, alc5623_i2c_table);
-
 #ifdef CONFIG_OF
 static const struct of_device_id alc5623_of_match[] = {
 	{ .compatible = "realtek,alc5623", },
@@ -1082,7 +1084,7 @@ static struct i2c_driver alc5623_i2c_driver = {
 		.name = "alc562x-codec",
 		.of_match_table = of_match_ptr(alc5623_of_match),
 	},
-	.probe = alc5623_i2c_probe,
+	.probe_new = alc5623_i2c_probe,
 	.id_table = alc5623_i2c_table,
 };
 
diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 6d7af3736a91..641bdfddae16 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1092,18 +1092,24 @@ static const struct regmap_config alc5632_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static const struct i2c_device_id alc5632_i2c_table[] = {
+	{"alc5632", 0x5c},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, alc5632_i2c_table);
+
 /*
  * alc5632 2 wire address is determined by A1 pin
  * state during powerup.
  *    low  = 0x1a
  *    high = 0x1b
  */
-static int alc5632_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int alc5632_i2c_probe(struct i2c_client *client)
 {
 	struct alc5632_priv *alc5632;
 	int ret, ret1, ret2;
 	unsigned int vid1, vid2;
+	const struct i2c_device_id *id;
 
 	alc5632 = devm_kzalloc(&client->dev,
 			 sizeof(struct alc5632_priv), GFP_KERNEL);
@@ -1129,6 +1135,8 @@ static int alc5632_i2c_probe(struct i2c_client *client,
 
 	vid2 >>= 8;
 
+	id = i2c_match_id(alc5632_i2c_table, client);
+
 	if ((vid1 != 0x10EC) || (vid2 != id->driver_data)) {
 		dev_err(&client->dev,
 		"Device is not a ALC5632: VID1=0x%x, VID2=0x%x\n", vid1, vid2);
@@ -1161,12 +1169,6 @@ static int alc5632_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static const struct i2c_device_id alc5632_i2c_table[] = {
-	{"alc5632", 0x5c},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, alc5632_i2c_table);
-
 #ifdef CONFIG_OF
 static const struct of_device_id alc5632_of_match[] = {
 	{ .compatible = "realtek,alc5632", },
@@ -1181,7 +1183,7 @@ static struct i2c_driver alc5632_i2c_driver = {
 		.name = "alc5632",
 		.of_match_table = of_match_ptr(alc5632_of_match),
 	},
-	.probe = alc5632_i2c_probe,
+	.probe_new = alc5632_i2c_probe,
 	.id_table = alc5632_i2c_table,
 };
 
-- 
2.27.0

