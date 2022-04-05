Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1764F4880
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378979AbiDEVlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391814AbiDEPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:35:12 -0400
Received: from 11.mo582.mail-out.ovh.net (11.mo582.mail-out.ovh.net [188.165.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905041403D6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:43:06 -0700 (PDT)
Received: from player786.ha.ovh.net (unknown [10.111.172.14])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 0282B23D81
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:24:50 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player786.ha.ovh.net (Postfix) with ESMTPSA id 36D5F29188CB7;
        Tue,  5 Apr 2022 12:24:45 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G003aad7794a-8148-46b1-bddb-b3047077a168,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Wolfram Sang <wsa@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2] ASoC: wm*: use simple i2c probe function
Date:   Tue,  5 Apr 2022 14:24:11 +0200
Message-Id: <20220405122411.2096387-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3824119034900874886
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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

wm8731.c is excluded and will be submitted separately.

This avoids scanning the identifier tables during probes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
Changes since v2:
  - rebased on v5.18-rc1
  - dropped changes to sound/soc/codecs/wm8731.c
---
 sound/soc/codecs/wm1250-ev1.c | 5 ++---
 sound/soc/codecs/wm2000.c     | 5 ++---
 sound/soc/codecs/wm2200.c     | 5 ++---
 sound/soc/codecs/wm5100.c     | 5 ++---
 sound/soc/codecs/wm8510.c     | 5 ++---
 sound/soc/codecs/wm8523.c     | 5 ++---
 sound/soc/codecs/wm8580.c     | 5 ++---
 sound/soc/codecs/wm8711.c     | 5 ++---
 sound/soc/codecs/wm8728.c     | 5 ++---
 sound/soc/codecs/wm8737.c     | 5 ++---
 sound/soc/codecs/wm8741.c     | 5 ++---
 sound/soc/codecs/wm8750.c     | 5 ++---
 sound/soc/codecs/wm8753.c     | 5 ++---
 sound/soc/codecs/wm8776.c     | 5 ++---
 sound/soc/codecs/wm8804-i2c.c | 5 ++---
 sound/soc/codecs/wm8900.c     | 5 ++---
 sound/soc/codecs/wm8903.c     | 5 ++---
 sound/soc/codecs/wm8940.c     | 5 ++---
 sound/soc/codecs/wm8955.c     | 5 ++---
 sound/soc/codecs/wm8960.c     | 5 ++---
 sound/soc/codecs/wm8961.c     | 5 ++---
 sound/soc/codecs/wm8962.c     | 5 ++---
 sound/soc/codecs/wm8971.c     | 5 ++---
 sound/soc/codecs/wm8974.c     | 5 ++---
 sound/soc/codecs/wm8978.c     | 5 ++---
 sound/soc/codecs/wm8983.c     | 5 ++---
 sound/soc/codecs/wm8988.c     | 5 ++---
 sound/soc/codecs/wm8990.c     | 5 ++---
 sound/soc/codecs/wm8991.c     | 5 ++---
 sound/soc/codecs/wm8993.c     | 5 ++---
 sound/soc/codecs/wm8995.c     | 5 ++---
 sound/soc/codecs/wm8996.c     | 5 ++---
 sound/soc/codecs/wm9081.c     | 5 ++---
 sound/soc/codecs/wm9090.c     | 5 ++---
 34 files changed, 68 insertions(+), 102 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index d6ffe99550fe..b6366dea15a6 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -192,8 +192,7 @@ static void wm1250_ev1_free(struct i2c_client *i2c)
 		gpio_free_array(wm1250->gpios, ARRAY_SIZE(wm1250->gpios));
 }
 
-static int wm1250_ev1_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *i2c_id)
+static int wm1250_ev1_probe(struct i2c_client *i2c)
 {
 	int id, board, rev, ret;
 
@@ -247,7 +246,7 @@ static struct i2c_driver wm1250_ev1_i2c_driver = {
 	.driver = {
 		.name = "wm1250-ev1",
 	},
-	.probe =    wm1250_ev1_probe,
+	.probe_new = wm1250_ev1_probe,
 	.remove =   wm1250_ev1_remove,
 	.id_table = wm1250_ev1_i2c_id,
 };
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 72e165cc6443..075ee852eb72 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -807,8 +807,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm2000 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int wm2000_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *i2c_id)
+static int wm2000_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm2000_priv *wm2000;
 	struct wm2000_platform_data *pdata;
@@ -941,7 +940,7 @@ static struct i2c_driver wm2000_i2c_driver = {
 	.driver = {
 		.name = "wm2000",
 	},
-	.probe = wm2000_i2c_probe,
+	.probe_new = wm2000_i2c_probe,
 	.id_table = wm2000_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 8863b533f9c4..1cd544580c83 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2176,8 +2176,7 @@ static const unsigned int wm2200_mic_ctrl_reg[] = {
 	WM2200_IN3L_CONTROL,
 };
 
-static int wm2200_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm2200_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm2200_pdata *pdata = dev_get_platdata(&i2c->dev);
 	struct wm2200_priv *wm2200;
@@ -2489,7 +2488,7 @@ static struct i2c_driver wm2200_i2c_driver = {
 		.name = "wm2200",
 		.pm = &wm2200_pm,
 	},
-	.probe =    wm2200_i2c_probe,
+	.probe_new = wm2200_i2c_probe,
 	.remove =   wm2200_i2c_remove,
 	.id_table = wm2200_i2c_id,
 };
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 9cab01ee4ee9..a89870918174 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2411,8 +2411,7 @@ static const unsigned int wm5100_mic_ctrl_reg[] = {
 	WM5100_IN4L_CONTROL,
 };
 
-static int wm5100_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm5100_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm5100_pdata *pdata = dev_get_platdata(&i2c->dev);
 	struct wm5100_priv *wm5100;
@@ -2713,7 +2712,7 @@ static struct i2c_driver wm5100_i2c_driver = {
 		.name = "wm5100",
 		.pm = &wm5100_pm,
 	},
-	.probe =    wm5100_i2c_probe,
+	.probe_new = wm5100_i2c_probe,
 	.remove =   wm5100_i2c_remove,
 	.id_table = wm5100_i2c_id,
 };
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index a18e2290b8c8..c6439d25006b 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -646,8 +646,7 @@ static struct spi_driver wm8510_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8510_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8510_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8510_priv *wm8510;
 	int ret;
@@ -680,7 +679,7 @@ static struct i2c_driver wm8510_i2c_driver = {
 		.name = "wm8510",
 		.of_match_table = wm8510_of_match,
 	},
-	.probe =    wm8510_i2c_probe,
+	.probe_new = wm8510_i2c_probe,
 	.id_table = wm8510_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index c8b50aac6c18..ba35a0221dc8 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -443,8 +443,7 @@ static const struct regmap_config wm8523_regmap = {
 	.volatile_reg = wm8523_volatile_register,
 };
 
-static int wm8523_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8523_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8523_priv *wm8523;
 	unsigned int val;
@@ -529,7 +528,7 @@ static struct i2c_driver wm8523_i2c_driver = {
 		.name = "wm8523",
 		.of_match_table = wm8523_of_match,
 	},
-	.probe =    wm8523_i2c_probe,
+	.probe_new = wm8523_i2c_probe,
 	.id_table = wm8523_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 85ad2f03cfd0..84020195314d 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -996,8 +996,7 @@ static const struct of_device_id wm8580_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8580_of_match);
 
-static int wm8580_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8580_i2c_probe(struct i2c_client *i2c)
 {
 	const struct of_device_id *of_id;
 	struct wm8580_priv *wm8580;
@@ -1051,7 +1050,7 @@ static struct i2c_driver wm8580_i2c_driver = {
 		.name = "wm8580",
 		.of_match_table = wm8580_of_match,
 	},
-	.probe =    wm8580_i2c_probe,
+	.probe_new = wm8580_i2c_probe,
 	.id_table = wm8580_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index bc4d161c59e5..b68a1ebcd061 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -432,8 +432,7 @@ static struct spi_driver wm8711_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8711_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int wm8711_i2c_probe(struct i2c_client *client)
 {
 	struct wm8711_priv *wm8711;
 	int ret;
@@ -466,7 +465,7 @@ static struct i2c_driver wm8711_i2c_driver = {
 		.name = "wm8711",
 		.of_match_table = wm8711_of_match,
 	},
-	.probe =    wm8711_i2c_probe,
+	.probe_new = wm8711_i2c_probe,
 	.id_table = wm8711_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 2cd58d133899..119ff0a1bb35 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -273,8 +273,7 @@ static struct spi_driver wm8728_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8728_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8728_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8728_priv *wm8728;
 	int ret;
@@ -307,7 +306,7 @@ static struct i2c_driver wm8728_i2c_driver = {
 		.name = "wm8728",
 		.of_match_table = wm8728_of_match,
 	},
-	.probe =    wm8728_i2c_probe,
+	.probe_new = wm8728_i2c_probe,
 	.id_table = wm8728_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 7a3f9fbe8d53..5778091d1c09 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -606,8 +606,7 @@ static const struct regmap_config wm8737_regmap = {
 };
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8737_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8737_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8737_priv *wm8737;
 	int ret, i;
@@ -651,7 +650,7 @@ static struct i2c_driver wm8737_i2c_driver = {
 		.name = "wm8737",
 		.of_match_table = wm8737_of_match,
 	},
-	.probe =    wm8737_i2c_probe,
+	.probe_new = wm8737_i2c_probe,
 	.id_table = wm8737_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 0e3994326936..871e2c5421b8 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -565,8 +565,7 @@ static int wm8741_set_pdata(struct device *dev, struct wm8741_priv *wm8741)
 }
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8741_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8741_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8741_priv *wm8741;
 	int ret, i;
@@ -618,7 +617,7 @@ static struct i2c_driver wm8741_i2c_driver = {
 		.name = "wm8741",
 		.of_match_table = wm8741_of_match,
 	},
-	.probe =    wm8741_i2c_probe,
+	.probe_new = wm8741_i2c_probe,
 	.id_table = wm8741_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 9491817020d8..1426fc1f7c5a 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -780,8 +780,7 @@ static struct spi_driver wm8750_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8750_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8750_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8750_priv *wm8750;
 	struct regmap *regmap;
@@ -815,7 +814,7 @@ static struct i2c_driver wm8750_i2c_driver = {
 		.name = "wm8750",
 		.of_match_table = wm8750_of_match,
 	},
-	.probe =    wm8750_i2c_probe,
+	.probe_new = wm8750_i2c_probe,
 	.id_table = wm8750_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index deaa54be6268..931134d334ec 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1552,8 +1552,7 @@ static struct spi_driver wm8753_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8753_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8753_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8753_priv *wm8753;
 	int ret;
@@ -1592,7 +1591,7 @@ static struct i2c_driver wm8753_i2c_driver = {
 		.name = "wm8753",
 		.of_match_table = wm8753_of_match,
 	},
-	.probe =    wm8753_i2c_probe,
+	.probe_new = wm8753_i2c_probe,
 	.id_table = wm8753_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 554acf56130c..f164cb6744c4 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -490,8 +490,7 @@ static struct spi_driver wm8776_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8776_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8776_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8776_priv *wm8776;
 	int ret;
@@ -525,7 +524,7 @@ static struct i2c_driver wm8776_i2c_driver = {
 		.name = "wm8776",
 		.of_match_table = wm8776_of_match,
 	},
-	.probe =    wm8776_i2c_probe,
+	.probe_new = wm8776_i2c_probe,
 	.id_table = wm8776_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8804-i2c.c b/sound/soc/codecs/wm8804-i2c.c
index f97a75e64166..04dc9fb5afb4 100644
--- a/sound/soc/codecs/wm8804-i2c.c
+++ b/sound/soc/codecs/wm8804-i2c.c
@@ -14,8 +14,7 @@
 
 #include "wm8804.h"
 
-static int wm8804_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8804_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap *regmap;
 
@@ -62,7 +61,7 @@ static struct i2c_driver wm8804_i2c_driver = {
 		.of_match_table = of_match_ptr(wm8804_of_match),
 		.acpi_match_table = ACPI_PTR(wm8804_acpi_match),
 	},
-	.probe = wm8804_i2c_probe,
+	.probe_new = wm8804_i2c_probe,
 	.remove = wm8804_i2c_remove,
 	.id_table = wm8804_i2c_id
 };
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index bf3a4415a85f..84a3daf0c11e 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1261,8 +1261,7 @@ static struct spi_driver wm8900_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8900_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8900_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8900_priv *wm8900;
 	int ret;
@@ -1299,7 +1298,7 @@ static struct i2c_driver wm8900_i2c_driver = {
 	.driver = {
 		.name = "wm8900",
 	},
-	.probe =    wm8900_i2c_probe,
+	.probe_new = wm8900_i2c_probe,
 	.remove =   wm8900_i2c_remove,
 	.id_table = wm8900_i2c_id,
 };
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 75f30154c809..ddcef11dce7c 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1981,8 +1981,7 @@ static int wm8903_set_pdata_from_of(struct i2c_client *i2c,
 	return 0;
 }
 
-static int wm8903_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8903_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8903_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct wm8903_priv *wm8903;
@@ -2214,7 +2213,7 @@ static struct i2c_driver wm8903_i2c_driver = {
 		.name = "wm8903",
 		.of_match_table = wm8903_of_match,
 	},
-	.probe =    wm8903_i2c_probe,
+	.probe_new = wm8903_i2c_probe,
 	.remove =   wm8903_i2c_remove,
 	.id_table = wm8903_i2c_id,
 };
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 440d048ef0c0..99b4524f53d8 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -750,8 +750,7 @@ static const struct regmap_config wm8940_regmap = {
 	.volatile_reg = wm8940_volatile_register,
 };
 
-static int wm8940_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8940_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8940_priv *wm8940;
 	int ret;
@@ -783,7 +782,7 @@ static struct i2c_driver wm8940_i2c_driver = {
 	.driver = {
 		.name = "wm8940",
 	},
-	.probe =    wm8940_i2c_probe,
+	.probe_new = wm8940_i2c_probe,
 	.id_table = wm8940_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 513df47bd87d..80e3cbd704ee 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -968,8 +968,7 @@ static const struct regmap_config wm8955_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(wm8955_reg_defaults),
 };
 
-static int wm8955_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8955_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8955_priv *wm8955;
 	int ret;
@@ -1005,7 +1004,7 @@ static struct i2c_driver wm8955_i2c_driver = {
 	.driver = {
 		.name = "wm8955",
 	},
-	.probe =    wm8955_i2c_probe,
+	.probe_new = wm8955_i2c_probe,
 	.id_table = wm8955_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ca7660f4bb05..92fcd335c5de 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1410,8 +1410,7 @@ static void wm8960_set_pdata_from_of(struct i2c_client *i2c,
 				   ARRAY_SIZE(pdata->hp_cfg));
 }
 
-static int wm8960_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8960_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8960_data *pdata = dev_get_platdata(&i2c->dev);
 	struct wm8960_priv *wm8960;
@@ -1509,7 +1508,7 @@ static struct i2c_driver wm8960_i2c_driver = {
 		.name = "wm8960",
 		.of_match_table = wm8960_of_match,
 	},
-	.probe =    wm8960_i2c_probe,
+	.probe_new = wm8960_i2c_probe,
 	.remove =   wm8960_i2c_remove,
 	.id_table = wm8960_i2c_id,
 };
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index ef80d9fc1eec..69eb731dbf4b 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -911,8 +911,7 @@ static const struct regmap_config wm8961_regmap = {
 	.readable_reg = wm8961_readable,
 };
 
-static int wm8961_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8961_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8961_priv *wm8961;
 	unsigned int val;
@@ -977,7 +976,7 @@ static struct i2c_driver wm8961_i2c_driver = {
 	.driver = {
 		.name = "wm8961",
 	},
-	.probe =    wm8961_i2c_probe,
+	.probe_new = wm8961_i2c_probe,
 	.id_table = wm8961_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 2c41d31956aa..079ad5b24ac5 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3555,8 +3555,7 @@ static int wm8962_set_pdata_from_of(struct i2c_client *i2c,
 	return PTR_ERR_OR_ZERO(pdata->mclk);
 }
 
-static int wm8962_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8962_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8962_pdata *pdata = dev_get_platdata(&i2c->dev);
 	struct wm8962_priv *wm8962;
@@ -3892,7 +3891,7 @@ static struct i2c_driver wm8962_i2c_driver = {
 		.of_match_table = wm8962_of_match,
 		.pm = &wm8962_pm,
 	},
-	.probe =    wm8962_i2c_probe,
+	.probe_new = wm8962_i2c_probe,
 	.remove =   wm8962_i2c_remove,
 	.id_table = wm8962_i2c_id,
 };
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index ddf0e2f5e66a..8a289b048e66 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -672,8 +672,7 @@ static const struct regmap_config wm8971_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int wm8971_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8971_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8971_priv *wm8971;
 
@@ -702,7 +701,7 @@ static struct i2c_driver wm8971_i2c_driver = {
 	.driver = {
 		.name = "wm8971",
 	},
-	.probe =    wm8971_i2c_probe,
+	.probe_new = wm8971_i2c_probe,
 	.id_table = wm8971_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index fdc68ab49742..a8d7809f3f64 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -685,8 +685,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm8974 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int wm8974_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8974_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8974_priv *priv;
 	struct regmap *regmap;
@@ -725,7 +724,7 @@ static struct i2c_driver wm8974_i2c_driver = {
 		.name = "wm8974",
 		.of_match_table = wm8974_of_match,
 	},
-	.probe =    wm8974_i2c_probe,
+	.probe_new = wm8974_i2c_probe,
 	.id_table = wm8974_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 7091e1a9d516..141f50bfec68 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1020,8 +1020,7 @@ static const struct regmap_config wm8978_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(wm8978_reg_defaults),
 };
 
-static int wm8978_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8978_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8978_priv *wm8978;
 	int ret;
@@ -1074,7 +1073,7 @@ static struct i2c_driver wm8978_i2c_driver = {
 		.name = "wm8978",
 		.of_match_table = wm8978_of_match,
 	},
-	.probe =    wm8978_i2c_probe,
+	.probe_new = wm8978_i2c_probe,
 	.id_table = wm8978_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index d8ed22a9caac..ae89554d47bc 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -1035,8 +1035,7 @@ static struct spi_driver wm8983_spi_driver = {
 #endif
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8983_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8983_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8983_priv *wm8983;
 	int ret;
@@ -1070,7 +1069,7 @@ static struct i2c_driver wm8983_i2c_driver = {
 	.driver = {
 		.name = "wm8983",
 	},
-	.probe = wm8983_i2c_probe,
+	.probe_new = wm8983_i2c_probe,
 	.id_table = wm8983_i2c_id
 };
 #endif
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 1d2f881bbcae..27538d6598cf 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -872,8 +872,7 @@ static struct spi_driver wm8988_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8988_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8988_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8988_priv *wm8988;
 	int ret;
@@ -907,7 +906,7 @@ static struct i2c_driver wm8988_i2c_driver = {
 	.driver = {
 		.name = "wm8988",
 	},
-	.probe =    wm8988_i2c_probe,
+	.probe_new = wm8988_i2c_probe,
 	.id_table = wm8988_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 938940777e5d..c9448a59c872 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1220,8 +1220,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm8990 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int wm8990_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8990_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8990_priv *wm8990;
 	int ret;
@@ -1249,7 +1248,7 @@ static struct i2c_driver wm8990_i2c_driver = {
 	.driver = {
 		.name = "wm8990",
 	},
-	.probe =    wm8990_i2c_probe,
+	.probe_new = wm8990_i2c_probe,
 	.id_table = wm8990_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 16bc8609d0d2..998bc89bb7e1 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1257,8 +1257,7 @@ static const struct regmap_config wm8991_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int wm8991_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8991_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8991_priv *wm8991;
 	unsigned int val;
@@ -1325,7 +1324,7 @@ static struct i2c_driver wm8991_i2c_driver = {
 	.driver = {
 		.name = "wm8991",
 	},
-	.probe = wm8991_i2c_probe,
+	.probe_new = wm8991_i2c_probe,
 	.id_table = wm8991_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index c4f41692b806..f4da77ec9d6c 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1624,8 +1624,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm8993 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int wm8993_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8993_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8993_priv *wm8993;
 	unsigned int reg;
@@ -1745,7 +1744,7 @@ static struct i2c_driver wm8993_i2c_driver = {
 	.driver = {
 		.name = "wm8993",
 	},
-	.probe =    wm8993_i2c_probe,
+	.probe_new = wm8993_i2c_probe,
 	.remove =   wm8993_i2c_remove,
 	.id_table = wm8993_i2c_id,
 };
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index b896d9c5bea0..ea9727446707 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -2231,8 +2231,7 @@ static struct spi_driver wm8995_spi_driver = {
 #endif
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8995_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8995_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8995_priv *wm8995;
 	int ret;
@@ -2270,7 +2269,7 @@ static struct i2c_driver wm8995_i2c_driver = {
 	.driver = {
 		.name = "wm8995",
 	},
-	.probe = wm8995_i2c_probe,
+	.probe_new = wm8995_i2c_probe,
 	.id_table = wm8995_i2c_id
 };
 #endif
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 197ae7d84a49..f7bb27d1c76d 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2755,8 +2755,7 @@ static struct snd_soc_dai_driver wm8996_dai[] = {
 	},
 };
 
-static int wm8996_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8996_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8996_priv *wm8996;
 	int ret, i;
@@ -3091,7 +3090,7 @@ static struct i2c_driver wm8996_i2c_driver = {
 	.driver = {
 		.name = "wm8996",
 	},
-	.probe =    wm8996_i2c_probe,
+	.probe_new = wm8996_i2c_probe,
 	.remove =   wm8996_i2c_remove,
 	.id_table = wm8996_i2c_id,
 };
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 4a667ee82fe2..87b58448cea7 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1299,8 +1299,7 @@ static const struct regmap_config wm9081_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int wm9081_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm9081_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm9081_priv *wm9081;
 	unsigned int reg;
@@ -1373,7 +1372,7 @@ static struct i2c_driver wm9081_i2c_driver = {
 	.driver = {
 		.name = "wm9081",
 	},
-	.probe =    wm9081_i2c_probe,
+	.probe_new = wm9081_i2c_probe,
 	.remove =   wm9081_i2c_remove,
 	.id_table = wm9081_i2c_id,
 };
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index e0231a54609c..1bae81a7d390 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -561,8 +561,7 @@ static const struct regmap_config wm9090_regmap = {
 };
 
 
-static int wm9090_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm9090_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm9090_priv *wm9090;
 	unsigned int reg;
@@ -619,7 +618,7 @@ static struct i2c_driver wm9090_i2c_driver = {
 	.driver = {
 		.name = "wm9090",
 	},
-	.probe = wm9090_i2c_probe,
+	.probe_new = wm9090_i2c_probe,
 	.id_table = wm9090_id,
 };
 

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.27.0

