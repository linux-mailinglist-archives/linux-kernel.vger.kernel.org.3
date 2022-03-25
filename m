Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E59A4E7DD5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiCYTwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiCYTw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:52:26 -0400
Received: from 9.mo584.mail-out.ovh.net (9.mo584.mail-out.ovh.net [46.105.40.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07011F0C97
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:38:11 -0700 (PDT)
Received: from player696.ha.ovh.net (unknown [10.111.208.144])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 3B79D2032A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:13:01 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 846491E9E3715;
        Fri, 25 Mar 2022 17:12:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-107S001b4973733-a1dc-4256-830c-89df02ef1730,
                    1702D5D0C6B5DF16716081994498F990499A02DA) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Wolfram Sang <wsa@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: da[79]*: use simple i2c probe function
Date:   Fri, 25 Mar 2022 18:12:43 +0100
Message-Id: <20220325171243.1218003-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17878446097844110982
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudehuddgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheileeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c probe functions here don't use the id information provided in
their second argument, so the single-parameter i2c probe function
("probe_new") can be used instead.

This avoids scanning the identifier tables during probes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 sound/soc/codecs/da7210.c | 5 ++---
 sound/soc/codecs/da7213.c | 5 ++---
 sound/soc/codecs/da7219.c | 5 ++---
 sound/soc/codecs/da732x.c | 5 ++---
 sound/soc/codecs/da9055.c | 5 ++---
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 8af344b2fdbf..3fa3042e4424 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1206,8 +1206,7 @@ static const struct regmap_config da7210_regmap_config_i2c = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int da7210_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int da7210_i2c_probe(struct i2c_client *i2c)
 {
 	struct da7210_priv *da7210;
 	int ret;
@@ -1250,7 +1249,7 @@ static struct i2c_driver da7210_i2c_driver = {
 	.driver = {
 		.name = "da7210",
 	},
-	.probe		= da7210_i2c_probe,
+	.probe_new	= da7210_i2c_probe,
 	.id_table	= da7210_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 3ab89387b4e6..2e645dc60eda 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1946,8 +1946,7 @@ static const char *da7213_supply_names[DA7213_NUM_SUPPLIES] = {
 	[DA7213_SUPPLY_VDDIO] = "VDDIO",
 };
 
-static int da7213_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int da7213_i2c_probe(struct i2c_client *i2c)
 {
 	struct da7213_priv *da7213;
 	int i, ret;
@@ -2040,7 +2039,7 @@ static struct i2c_driver da7213_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(da7213_acpi_match),
 		.pm = &da7213_pm,
 	},
-	.probe		= da7213_i2c_probe,
+	.probe_new	= da7213_i2c_probe,
 	.id_table	= da7213_i2c_id,
 };
 
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 13009d08b09a..a28d3601b932 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2649,8 +2649,7 @@ static const struct snd_soc_component_driver soc_component_dev_da7219 = {
  * I2C layer
  */
 
-static int da7219_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int da7219_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct da7219_priv *da7219;
@@ -2705,7 +2704,7 @@ static struct i2c_driver da7219_i2c_driver = {
 		.of_match_table = of_match_ptr(da7219_of_match),
 		.acpi_match_table = ACPI_PTR(da7219_acpi_match),
 	},
-	.probe		= da7219_i2c_probe,
+	.probe_new	= da7219_i2c_probe,
 	.remove		= da7219_i2c_remove,
 	.id_table	= da7219_i2c_id,
 };
diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 42d6a3fc3af5..f14cddf23f42 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1506,8 +1506,7 @@ static const struct snd_soc_component_driver soc_component_dev_da732x = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int da732x_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int da732x_i2c_probe(struct i2c_client *i2c)
 {
 	struct da732x_priv *da732x;
 	unsigned int reg;
@@ -1562,7 +1561,7 @@ static struct i2c_driver da732x_i2c_driver = {
 	.driver		= {
 		.name	= "da7320",
 	},
-	.probe		= da732x_i2c_probe,
+	.probe_new	= da732x_i2c_probe,
 	.remove		= da732x_i2c_remove,
 	.id_table	= da732x_i2c_id,
 };
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index a9676b261129..9d8c8adc5d76 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1473,8 +1473,7 @@ static const struct regmap_config da9055_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int da9055_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int da9055_i2c_probe(struct i2c_client *i2c)
 {
 	struct da9055_priv *da9055;
 	struct da9055_platform_data *pdata = dev_get_platdata(&i2c->dev);
@@ -1533,7 +1532,7 @@ static struct i2c_driver da9055_i2c_driver = {
 		.name = "da9055-codec",
 		.of_match_table = of_match_ptr(da9055_of_match),
 	},
-	.probe		= da9055_i2c_probe,
+	.probe_new	= da9055_i2c_probe,
 	.id_table	= da9055_i2c_id,
 };
 
-- 
2.27.0

