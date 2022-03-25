Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02644E79B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353372AbiCYRPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiCYRO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:14:58 -0400
Received: from 1.mo575.mail-out.ovh.net (1.mo575.mail-out.ovh.net [46.105.41.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE21C3467B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:13:22 -0700 (PDT)
Received: from player789.ha.ovh.net (unknown [10.109.138.52])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 414C521B3E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:55:13 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player789.ha.ovh.net (Postfix) with ESMTPSA id D329128CEF96E;
        Fri, 25 Mar 2022 16:55:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R00332e83cac-f456-466e-9f3b-ffe79ad02fc6,
                    1702D5D0C6B5DF16716081994498F990499A02DA) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: ad1*, ada*, ssm*: use i2c_match_id and simple i2c probe
Date:   Fri, 25 Mar 2022 17:54:52 +0100
Message-Id: <20220325165452.1212975-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17577830821228611206
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudehuddgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejkeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 sound/soc/codecs/ad193x-i2c.c   | 6 +++---
 sound/soc/codecs/adau1761-i2c.c | 8 +++++---
 sound/soc/codecs/adau1781-i2c.c | 8 +++++---
 sound/soc/codecs/adau1977-i2c.c | 8 +++++---
 sound/soc/codecs/ssm2602-i2c.c  | 8 +++++---
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/ad193x-i2c.c b/sound/soc/codecs/ad193x-i2c.c
index 3d509a65e4ca..4cb8d87f9011 100644
--- a/sound/soc/codecs/ad193x-i2c.c
+++ b/sound/soc/codecs/ad193x-i2c.c
@@ -20,10 +20,10 @@ static const struct i2c_device_id ad193x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad193x_id);
 
-static int ad193x_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int ad193x_i2c_probe(struct i2c_client *client)
 {
 	struct regmap_config config;
+	const struct i2c_device_id *id = i2c_match_id(ad193x_id, client);
 
 	config = ad193x_regmap_config;
 	config.val_bits = 8;
@@ -38,7 +38,7 @@ static struct i2c_driver ad193x_i2c_driver = {
 	.driver = {
 		.name = "ad193x",
 	},
-	.probe    = ad193x_i2c_probe,
+	.probe_new = ad193x_i2c_probe,
 	.id_table = ad193x_id,
 };
 module_i2c_driver(ad193x_i2c_driver);
diff --git a/sound/soc/codecs/adau1761-i2c.c b/sound/soc/codecs/adau1761-i2c.c
index c8fce37e5cfa..0683caf86aea 100644
--- a/sound/soc/codecs/adau1761-i2c.c
+++ b/sound/soc/codecs/adau1761-i2c.c
@@ -14,10 +14,12 @@
 
 #include "adau1761.h"
 
-static int adau1761_i2c_probe(struct i2c_client *client,
-	const struct i2c_device_id *id)
+static const struct i2c_device_id adau1761_i2c_ids[];
+
+static int adau1761_i2c_probe(struct i2c_client *client)
 {
 	struct regmap_config config;
+	const struct i2c_device_id *id = i2c_match_id(adau1761_i2c_ids, client);
 
 	config = adau1761_regmap_config;
 	config.val_bits = 8;
@@ -59,7 +61,7 @@ static struct i2c_driver adau1761_i2c_driver = {
 		.name = "adau1761",
 		.of_match_table = of_match_ptr(adau1761_i2c_dt_ids),
 	},
-	.probe = adau1761_i2c_probe,
+	.probe_new = adau1761_i2c_probe,
 	.remove = adau1761_i2c_remove,
 	.id_table = adau1761_i2c_ids,
 };
diff --git a/sound/soc/codecs/adau1781-i2c.c b/sound/soc/codecs/adau1781-i2c.c
index 1c476429ad99..e046de0ebcc7 100644
--- a/sound/soc/codecs/adau1781-i2c.c
+++ b/sound/soc/codecs/adau1781-i2c.c
@@ -14,10 +14,12 @@
 
 #include "adau1781.h"
 
-static int adau1781_i2c_probe(struct i2c_client *client,
-	const struct i2c_device_id *id)
+static const struct i2c_device_id adau1781_i2c_ids[];
+
+static int adau1781_i2c_probe(struct i2c_client *client)
 {
 	struct regmap_config config;
+	const struct i2c_device_id *id = i2c_match_id(adau1781_i2c_ids, client);
 
 	config = adau1781_regmap_config;
 	config.val_bits = 8;
@@ -55,7 +57,7 @@ static struct i2c_driver adau1781_i2c_driver = {
 		.name = "adau1781",
 		.of_match_table = of_match_ptr(adau1781_i2c_dt_ids),
 	},
-	.probe = adau1781_i2c_probe,
+	.probe_new = adau1781_i2c_probe,
 	.remove = adau1781_i2c_remove,
 	.id_table = adau1781_i2c_ids,
 };
diff --git a/sound/soc/codecs/adau1977-i2c.c b/sound/soc/codecs/adau1977-i2c.c
index 82a49c85d536..9f137a0634d5 100644
--- a/sound/soc/codecs/adau1977-i2c.c
+++ b/sound/soc/codecs/adau1977-i2c.c
@@ -14,10 +14,12 @@
 
 #include "adau1977.h"
 
-static int adau1977_i2c_probe(struct i2c_client *client,
-	const struct i2c_device_id *id)
+static const struct i2c_device_id adau1977_i2c_ids[];
+
+static int adau1977_i2c_probe(struct i2c_client *client)
 {
 	struct regmap_config config;
+	const struct i2c_device_id *id = i2c_match_id(adau1977_i2c_ids, client);
 
 	config = adau1977_regmap_config;
 	config.val_bits = 8;
@@ -40,7 +42,7 @@ static struct i2c_driver adau1977_i2c_driver = {
 	.driver = {
 		.name = "adau1977",
 	},
-	.probe = adau1977_i2c_probe,
+	.probe_new = adau1977_i2c_probe,
 	.id_table = adau1977_i2c_ids,
 };
 module_i2c_driver(adau1977_i2c_driver);
diff --git a/sound/soc/codecs/ssm2602-i2c.c b/sound/soc/codecs/ssm2602-i2c.c
index afab81383d3a..3c85772901f5 100644
--- a/sound/soc/codecs/ssm2602-i2c.c
+++ b/sound/soc/codecs/ssm2602-i2c.c
@@ -13,15 +13,17 @@
 
 #include "ssm2602.h"
 
+static const struct i2c_device_id ssm2602_i2c_id[];
+
 /*
  * ssm2602 2 wire address is determined by GPIO5
  * state during powerup.
  *    low  = 0x1a
  *    high = 0x1b
  */
-static int ssm2602_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int ssm2602_i2c_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_match_id(ssm2602_i2c_id, client);
 	return ssm2602_probe(&client->dev, id->driver_data,
 		devm_regmap_init_i2c(client, &ssm2602_regmap_config));
 }
@@ -47,7 +49,7 @@ static struct i2c_driver ssm2602_i2c_driver = {
 		.name = "ssm2602",
 		.of_match_table = ssm2602_of_match,
 	},
-	.probe = ssm2602_i2c_probe,
+	.probe_new = ssm2602_i2c_probe,
 	.id_table = ssm2602_i2c_id,
 };
 module_i2c_driver(ssm2602_i2c_driver);
-- 
2.27.0

