Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C894E793F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376972AbiCYQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbiCYQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:50:26 -0400
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Mar 2022 09:48:51 PDT
Received: from 19.mo582.mail-out.ovh.net (19.mo582.mail-out.ovh.net [188.165.56.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12391515AD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:48:50 -0700 (PDT)
Received: from player761.ha.ovh.net (unknown [10.110.103.115])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id EA78822EBE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:48:48 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player761.ha.ovh.net (Postfix) with ESMTPSA id 82CB728CE20A0;
        Fri, 25 Mar 2022 16:48:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-96R001a2f62d42-041c-440c-a3cb-cab1ba91dce3,
                    BADA89D67C65793922B9C036380C8ED9CA508D09) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: ada*, ssm*: use simple i2c probe function
Date:   Fri, 25 Mar 2022 17:48:28 +0100
Message-Id: <20220325164828.1209201-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17469462957791151750
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudehuddgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejiedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 sound/soc/codecs/adau1372-i2c.c | 4 ++--
 sound/soc/codecs/adau1373.c     | 5 ++---
 sound/soc/codecs/adau1701.c     | 5 ++---
 sound/soc/codecs/adau7118-i2c.c | 5 ++---
 sound/soc/codecs/adav803.c      | 5 ++---
 sound/soc/codecs/ssm2518.c      | 5 ++---
 sound/soc/codecs/ssm4567.c      | 5 ++---
 7 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/adau1372-i2c.c b/sound/soc/codecs/adau1372-i2c.c
index fc87a76ff1ee..8ed0ffdedbc9 100644
--- a/sound/soc/codecs/adau1372-i2c.c
+++ b/sound/soc/codecs/adau1372-i2c.c
@@ -14,7 +14,7 @@
 
 #include "adau1372.h"
 
-static int adau1372_i2c_probe(struct i2c_client *client, const struct i2c_device_id *id)
+static int adau1372_i2c_probe(struct i2c_client *client)
 {
 	return adau1372_probe(&client->dev,
 		devm_regmap_init_i2c(client, &adau1372_regmap_config), NULL);
@@ -30,7 +30,7 @@ static struct i2c_driver adau1372_i2c_driver = {
 	.driver = {
 		.name = "adau1372",
 	},
-	.probe = adau1372_i2c_probe,
+	.probe_new = adau1372_i2c_probe,
 	.id_table = adau1372_i2c_ids,
 };
 module_i2c_driver(adau1372_i2c_driver);
diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 46128aaceae9..a9032b5c8d78 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1473,8 +1473,7 @@ static const struct snd_soc_component_driver adau1373_component_driver = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int adau1373_i2c_probe(struct i2c_client *client,
-			      const struct i2c_device_id *id)
+static int adau1373_i2c_probe(struct i2c_client *client)
 {
 	struct adau1373 *adau1373;
 	int ret;
@@ -1508,7 +1507,7 @@ static struct i2c_driver adau1373_i2c_driver = {
 	.driver = {
 		.name = "adau1373",
 	},
-	.probe = adau1373_i2c_probe,
+	.probe_new = adau1373_i2c_probe,
 	.id_table = adau1373_i2c_id,
 };
 
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index dba9af753188..98768e5300f0 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -785,8 +785,7 @@ static const struct regmap_config adau1701_regmap = {
 	.reg_read		= adau1701_reg_read,
 };
 
-static int adau1701_i2c_probe(struct i2c_client *client,
-			      const struct i2c_device_id *id)
+static int adau1701_i2c_probe(struct i2c_client *client)
 {
 	struct adau1701 *adau1701;
 	struct device *dev = &client->dev;
@@ -878,7 +877,7 @@ static struct i2c_driver adau1701_i2c_driver = {
 		.name	= "adau1701",
 		.of_match_table	= of_match_ptr(adau1701_dt_ids),
 	},
-	.probe		= adau1701_i2c_probe,
+	.probe_new	= adau1701_i2c_probe,
 	.id_table	= adau1701_i2c_id,
 };
 
diff --git a/sound/soc/codecs/adau7118-i2c.c b/sound/soc/codecs/adau7118-i2c.c
index aa7afb3b826d..afed48401b25 100644
--- a/sound/soc/codecs/adau7118-i2c.c
+++ b/sound/soc/codecs/adau7118-i2c.c
@@ -48,8 +48,7 @@ static const struct regmap_config adau7118_regmap_config = {
 	.volatile_reg = adau7118_volatile,
 };
 
-static int adau7118_probe_i2c(struct i2c_client *i2c,
-			      const struct i2c_device_id *id)
+static int adau7118_probe_i2c(struct i2c_client *i2c)
 {
 	struct regmap *map;
 
@@ -79,7 +78,7 @@ static struct i2c_driver adau7118_driver = {
 		.name = "adau7118",
 		.of_match_table = adau7118_of_match,
 	},
-	.probe = adau7118_probe_i2c,
+	.probe_new = adau7118_probe_i2c,
 	.id_table = adau7118_id,
 };
 module_i2c_driver(adau7118_driver);
diff --git a/sound/soc/codecs/adav803.c b/sound/soc/codecs/adav803.c
index 0f565b851ea5..bf181bbaabed 100644
--- a/sound/soc/codecs/adav803.c
+++ b/sound/soc/codecs/adav803.c
@@ -19,8 +19,7 @@ static const struct i2c_device_id adav803_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adav803_id);
 
-static int adav803_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int adav803_probe(struct i2c_client *client)
 {
 	return adav80x_bus_probe(&client->dev,
 		devm_regmap_init_i2c(client, &adav80x_regmap_config));
@@ -30,7 +29,7 @@ static struct i2c_driver adav803_driver = {
 	.driver = {
 		.name = "adav803",
 	},
-	.probe = adav803_probe,
+	.probe_new = adav803_probe,
 	.id_table = adav803_id,
 };
 module_i2c_driver(adav803_driver);
diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index 09449c6c4024..83acbdbb8e0d 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -735,8 +735,7 @@ static const struct regmap_config ssm2518_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(ssm2518_reg_defaults),
 };
 
-static int ssm2518_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+static int ssm2518_i2c_probe(struct i2c_client *i2c)
 {
 	struct ssm2518_platform_data *pdata = i2c->dev.platform_data;
 	struct ssm2518 *ssm2518;
@@ -815,7 +814,7 @@ static struct i2c_driver ssm2518_driver = {
 		.name = "ssm2518",
 		.of_match_table = of_match_ptr(ssm2518_dt_ids),
 	},
-	.probe = ssm2518_i2c_probe,
+	.probe_new = ssm2518_i2c_probe,
 	.id_table = ssm2518_i2c_ids,
 };
 module_i2c_driver(ssm2518_driver);
diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 811b1a2c404a..08ced09ef001 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -444,8 +444,7 @@ static const struct regmap_config ssm4567_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(ssm4567_reg_defaults),
 };
 
-static int ssm4567_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+static int ssm4567_i2c_probe(struct i2c_client *i2c)
 {
 	struct ssm4567 *ssm4567;
 	int ret;
@@ -502,7 +501,7 @@ static struct i2c_driver ssm4567_driver = {
 		.of_match_table = of_match_ptr(ssm4567_of_match),
 		.acpi_match_table = ACPI_PTR(ssm4567_acpi_match),
 	},
-	.probe = ssm4567_i2c_probe,
+	.probe_new = ssm4567_i2c_probe,
 	.id_table = ssm4567_i2c_ids,
 };
 module_i2c_driver(ssm4567_driver);
-- 
2.27.0

