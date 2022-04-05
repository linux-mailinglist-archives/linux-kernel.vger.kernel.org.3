Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054924F4C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449177AbiDEXXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384305AbiDEOR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:17:58 -0400
X-Greylist: delayed 1853 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 06:03:59 PDT
Received: from 9.mo576.mail-out.ovh.net (9.mo576.mail-out.ovh.net [46.105.56.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1802E9FF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:03:58 -0700 (PDT)
Received: from player728.ha.ovh.net (unknown [10.110.208.168])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 01D1124343
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:03:56 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 7CD252915D273;
        Tue,  5 Apr 2022 13:03:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G002d773a4cb-285b-473c-8abd-4f59883b3bf9,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: rt*: use simple i2c probe function
Date:   Tue,  5 Apr 2022 15:03:26 +0200
Message-Id: <20220405130326.2107293-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4484459332856678022
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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
 sound/soc/codecs/rt1011.c     | 5 ++---
 sound/soc/codecs/rt1015.c     | 5 ++---
 sound/soc/codecs/rt1016.c     | 5 ++---
 sound/soc/codecs/rt1019.c     | 5 ++---
 sound/soc/codecs/rt1305.c     | 5 ++---
 sound/soc/codecs/rt1308.c     | 5 ++---
 sound/soc/codecs/rt274.c      | 5 ++---
 sound/soc/codecs/rt286.c      | 5 ++---
 sound/soc/codecs/rt298.c      | 5 ++---
 sound/soc/codecs/rt5514.c     | 5 ++---
 sound/soc/codecs/rt5616.c     | 5 ++---
 sound/soc/codecs/rt5631.c     | 5 ++---
 sound/soc/codecs/rt5640.c     | 5 ++---
 sound/soc/codecs/rt5645.c     | 5 ++---
 sound/soc/codecs/rt5651.c     | 5 ++---
 sound/soc/codecs/rt5659.c     | 5 ++---
 sound/soc/codecs/rt5660.c     | 5 ++---
 sound/soc/codecs/rt5663.c     | 5 ++---
 sound/soc/codecs/rt5665.c     | 5 ++---
 sound/soc/codecs/rt5668.c     | 5 ++---
 sound/soc/codecs/rt5670.c     | 5 ++---
 sound/soc/codecs/rt5682-i2c.c | 5 ++---
 sound/soc/codecs/rt5682s.c    | 5 ++---
 23 files changed, 46 insertions(+), 69 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index b62301a6281f..08dbaef84d4e 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -2433,8 +2433,7 @@ static int rt1011_parse_dp(struct rt1011_priv *rt1011, struct device *dev)
 	return 0;
 }
 
-static int rt1011_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt1011_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt1011_priv *rt1011;
 	int ret;
@@ -2485,7 +2484,7 @@ static struct i2c_driver rt1011_i2c_driver = {
 		.of_match_table = of_match_ptr(rt1011_of_match),
 		.acpi_match_table = ACPI_PTR(rt1011_acpi_match)
 	},
-	.probe = rt1011_i2c_probe,
+	.probe_new = rt1011_i2c_probe,
 	.shutdown = rt1011_i2c_shutdown,
 	.id_table = rt1011_i2c_id,
 };
diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 6a27dfacd81c..7a06f2654afb 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -1113,8 +1113,7 @@ static void rt1015_parse_dt(struct rt1015_priv *rt1015, struct device *dev)
 		&rt1015->pdata.power_up_delay_ms);
 }
 
-static int rt1015_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+static int rt1015_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt1015_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt1015_priv *rt1015;
@@ -1172,7 +1171,7 @@ static struct i2c_driver rt1015_i2c_driver = {
 		.of_match_table = of_match_ptr(rt1015_of_match),
 		.acpi_match_table = ACPI_PTR(rt1015_acpi_match),
 	},
-	.probe = rt1015_i2c_probe,
+	.probe_new = rt1015_i2c_probe,
 	.shutdown = rt1015_i2c_shutdown,
 	.id_table = rt1015_i2c_id,
 };
diff --git a/sound/soc/codecs/rt1016.c b/sound/soc/codecs/rt1016.c
index 9845cdddcb4c..e31c4736627f 100644
--- a/sound/soc/codecs/rt1016.c
+++ b/sound/soc/codecs/rt1016.c
@@ -631,8 +631,7 @@ static const struct acpi_device_id rt1016_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt1016_acpi_match);
 #endif
 
-static int rt1016_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+static int rt1016_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt1016_priv *rt1016;
 	int ret;
@@ -685,7 +684,7 @@ static struct i2c_driver rt1016_i2c_driver = {
 		.of_match_table = of_match_ptr(rt1016_of_match),
 		.acpi_match_table = ACPI_PTR(rt1016_acpi_match),
 	},
-	.probe = rt1016_i2c_probe,
+	.probe_new = rt1016_i2c_probe,
 	.shutdown = rt1016_i2c_shutdown,
 	.id_table = rt1016_i2c_id,
 };
diff --git a/sound/soc/codecs/rt1019.c b/sound/soc/codecs/rt1019.c
index 80b7ca0e4e1e..d45d14fe5c42 100644
--- a/sound/soc/codecs/rt1019.c
+++ b/sound/soc/codecs/rt1019.c
@@ -558,8 +558,7 @@ static const struct acpi_device_id rt1019_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt1019_acpi_match);
 #endif
 
-static int rt1019_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+static int rt1019_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt1019_priv *rt1019;
 	int ret;
@@ -599,7 +598,7 @@ static struct i2c_driver rt1019_i2c_driver = {
 		.of_match_table = of_match_ptr(rt1019_of_match),
 		.acpi_match_table = ACPI_PTR(rt1019_acpi_match),
 	},
-	.probe = rt1019_i2c_probe,
+	.probe_new = rt1019_i2c_probe,
 	.id_table = rt1019_i2c_id,
 };
 module_i2c_driver(rt1019_i2c_driver);
diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index a9c473537a91..58d97e3c5087 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -1117,8 +1117,7 @@ static void rt1305_calibrate(struct rt1305_priv *rt1305)
 	regcache_cache_bypass(rt1305->regmap, false);
 }
 
-static int rt1305_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt1305_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt1305_priv *rt1305;
 	int ret;
@@ -1172,7 +1171,7 @@ static struct i2c_driver rt1305_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt1305_acpi_match)
 #endif
 	},
-	.probe = rt1305_i2c_probe,
+	.probe_new = rt1305_i2c_probe,
 	.shutdown = rt1305_i2c_shutdown,
 	.id_table = rt1305_i2c_id,
 };
diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
index c555b77b3c5c..eec2b1760408 100644
--- a/sound/soc/codecs/rt1308.c
+++ b/sound/soc/codecs/rt1308.c
@@ -814,8 +814,7 @@ static void rt1308_efuse(struct rt1308_priv *rt1308)
 	regmap_write(rt1308->regmap, RT1308_PVDD_OFFSET_CTL, 0x10000000);
 }
 
-static int rt1308_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt1308_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt1308_priv *rt1308;
 	int ret;
@@ -864,7 +863,7 @@ static struct i2c_driver rt1308_i2c_driver = {
 		.of_match_table = of_match_ptr(rt1308_of_match),
 		.acpi_match_table = ACPI_PTR(rt1308_acpi_match),
 	},
-	.probe = rt1308_i2c_probe,
+	.probe_new = rt1308_i2c_probe,
 	.shutdown = rt1308_i2c_shutdown,
 	.id_table = rt1308_i2c_id,
 };
diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 0d3773c576f8..ab093bdb5552 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1114,8 +1114,7 @@ static const struct acpi_device_id rt274_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt274_acpi_match);
 #endif
 
-static int rt274_i2c_probe(struct i2c_client *i2c,
-			   const struct i2c_device_id *id)
+static int rt274_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt274_priv *rt274;
 
@@ -1227,7 +1226,7 @@ static struct i2c_driver rt274_i2c_driver = {
 		   .of_match_table = of_match_ptr(rt274_of_match),
 #endif
 		   },
-	.probe = rt274_i2c_probe,
+	.probe_new = rt274_i2c_probe,
 	.remove = rt274_i2c_remove,
 	.id_table = rt274_i2c_id,
 };
diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index caa720884e3e..ad8ea1fa7c23 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1134,8 +1134,7 @@ static const struct dmi_system_id dmi_dell[] = {
 	{ }
 };
 
-static int rt286_i2c_probe(struct i2c_client *i2c,
-			   const struct i2c_device_id *id)
+static int rt286_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt286_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt286_priv *rt286;
@@ -1271,7 +1270,7 @@ static struct i2c_driver rt286_i2c_driver = {
 		   .name = "rt286",
 		   .acpi_match_table = ACPI_PTR(rt286_acpi_match),
 		   },
-	.probe = rt286_i2c_probe,
+	.probe_new = rt286_i2c_probe,
 	.remove = rt286_i2c_remove,
 	.id_table = rt286_i2c_id,
 };
diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index c592c40a7ab3..c291786dc82d 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1176,8 +1176,7 @@ static const struct dmi_system_id force_combo_jack_table[] = {
 	{ }
 };
 
-static int rt298_i2c_probe(struct i2c_client *i2c,
-			   const struct i2c_device_id *id)
+static int rt298_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt298_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt298_priv *rt298;
@@ -1314,7 +1313,7 @@ static struct i2c_driver rt298_i2c_driver = {
 		   .name = "rt298",
 		   .acpi_match_table = ACPI_PTR(rt298_acpi_match),
 		   },
-	.probe = rt298_i2c_probe,
+	.probe_new = rt298_i2c_probe,
 	.remove = rt298_i2c_remove,
 	.id_table = rt298_i2c_id,
 };
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 577680df7052..1b9263460142 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1252,8 +1252,7 @@ static __maybe_unused int rt5514_i2c_resume(struct device *dev)
 	return 0;
 }
 
-static int rt5514_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5514_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5514_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5514_priv *rt5514;
@@ -1330,7 +1329,7 @@ static struct i2c_driver rt5514_i2c_driver = {
 		.of_match_table = of_match_ptr(rt5514_of_match),
 		.pm = &rt5514_i2_pm_ops,
 	},
-	.probe = rt5514_i2c_probe,
+	.probe_new = rt5514_i2c_probe,
 	.id_table = rt5514_i2c_id,
 };
 module_i2c_driver(rt5514_i2c_driver);
diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 8e6414468a87..37f1bf552eff 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1337,8 +1337,7 @@ static const struct of_device_id rt5616_of_match[] = {
 MODULE_DEVICE_TABLE(of, rt5616_of_match);
 #endif
 
-static int rt5616_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int rt5616_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5616_priv *rt5616;
 	unsigned int val;
@@ -1408,7 +1407,7 @@ static struct i2c_driver rt5616_i2c_driver = {
 		.name = "rt5616",
 		.of_match_table = of_match_ptr(rt5616_of_match),
 	},
-	.probe = rt5616_i2c_probe,
+	.probe_new = rt5616_i2c_probe,
 	.remove = rt5616_i2c_remove,
 	.shutdown = rt5616_i2c_shutdown,
 	.id_table = rt5616_i2c_id,
diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 38356ea2bd6e..c941e878471c 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1699,8 +1699,7 @@ static const struct regmap_config rt5631_regmap_config = {
 	.use_single_write = true,
 };
 
-static int rt5631_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5631_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5631_priv *rt5631;
 	int ret;
@@ -1732,7 +1731,7 @@ static struct i2c_driver rt5631_i2c_driver = {
 		.name = "rt5631",
 		.of_match_table = of_match_ptr(rt5631_i2c_dt_ids),
 	},
-	.probe = rt5631_i2c_probe,
+	.probe_new = rt5631_i2c_probe,
 	.remove   = rt5631_i2c_remove,
 	.id_table = rt5631_i2c_id,
 };
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 30c2e7cb7ed2..12da2bea1a7b 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2927,8 +2927,7 @@ static int rt5640_parse_dt(struct rt5640_priv *rt5640, struct device_node *np)
 	return 0;
 }
 
-static int rt5640_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5640_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5640_priv *rt5640;
 	int ret;
@@ -3006,7 +3005,7 @@ static struct i2c_driver rt5640_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5640_acpi_match),
 		.of_match_table = of_match_ptr(rt5640_of_match),
 	},
-	.probe = rt5640_i2c_probe,
+	.probe_new = rt5640_i2c_probe,
 	.id_table = rt5640_i2c_id,
 };
 module_i2c_driver(rt5640_i2c_driver);
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 197c56047947..1518eb7e9201 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3855,8 +3855,7 @@ static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
 	return 0;
 }
 
-static int rt5645_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5645_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5645_platform_data *pdata = NULL;
 	const struct dmi_system_id *dmi_data;
@@ -4183,7 +4182,7 @@ static struct i2c_driver rt5645_i2c_driver = {
 		.of_match_table = of_match_ptr(rt5645_of_match),
 		.acpi_match_table = ACPI_PTR(rt5645_acpi_match),
 	},
-	.probe = rt5645_i2c_probe,
+	.probe_new = rt5645_i2c_probe,
 	.remove = rt5645_i2c_remove,
 	.shutdown = rt5645_i2c_shutdown,
 	.id_table = rt5645_i2c_id,
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index f302c25688d1..d11d201b1d03 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -2209,8 +2209,7 @@ MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
  * Note this function MUST not look at device-properties, see the comment
  * above rt5651_apply_properties().
  */
-static int rt5651_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5651_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5651_priv *rt5651;
 	int ret;
@@ -2281,7 +2280,7 @@ static struct i2c_driver rt5651_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5651_acpi_match),
 		.of_match_table = of_match_ptr(rt5651_of_match),
 	},
-	.probe = rt5651_i2c_probe,
+	.probe_new = rt5651_i2c_probe,
 	.id_table = rt5651_i2c_id,
 };
 module_i2c_driver(rt5651_i2c_driver);
diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index e1503c2eee81..6efa90f46362 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4093,8 +4093,7 @@ static void rt5659_intel_hd_header_probe_setup(struct rt5659_priv *rt5659)
 		RT5659_IL_IRQ_MASK, RT5659_IL_IRQ_EN);
 }
 
-static int rt5659_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5659_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5659_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5659_priv *rt5659;
@@ -4342,7 +4341,7 @@ static struct i2c_driver rt5659_i2c_driver = {
 		.of_match_table = of_match_ptr(rt5659_of_match),
 		.acpi_match_table = ACPI_PTR(rt5659_acpi_match),
 	},
-	.probe = rt5659_i2c_probe,
+	.probe_new = rt5659_i2c_probe,
 	.shutdown = rt5659_i2c_shutdown,
 	.id_table = rt5659_i2c_id,
 };
diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 3b50fb29864e..d5f9926625d2 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -1266,8 +1266,7 @@ static int rt5660_parse_dt(struct rt5660_priv *rt5660, struct device *dev)
 	return 0;
 }
 
-static int rt5660_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5660_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5660_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5660_priv *rt5660;
@@ -1343,7 +1342,7 @@ static struct i2c_driver rt5660_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5660_acpi_match),
 		.of_match_table = of_match_ptr(rt5660_of_match),
 	},
-	.probe = rt5660_i2c_probe,
+	.probe_new = rt5660_i2c_probe,
 	.id_table = rt5660_i2c_id,
 };
 module_i2c_driver(rt5660_i2c_driver);
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 3a8fba101b20..e51eed8a79ab 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3490,8 +3490,7 @@ static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
 	return 0;
 }
 
-static int rt5663_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5663_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5663_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5663_priv *rt5663;
@@ -3737,7 +3736,7 @@ static struct i2c_driver rt5663_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5663_acpi_match),
 		.of_match_table = of_match_ptr(rt5663_of_match),
 	},
-	.probe = rt5663_i2c_probe,
+	.probe_new = rt5663_i2c_probe,
 	.remove = rt5663_i2c_remove,
 	.shutdown = rt5663_i2c_shutdown,
 	.id_table = rt5663_i2c_id,
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 33e889802ff8..4a8d62e1dd2b 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4757,8 +4757,7 @@ static void rt5665_calibrate_handler(struct work_struct *work)
 	rt5665_calibrate(rt5665);
 }
 
-static int rt5665_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5665_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5665_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5665_priv *rt5665;
@@ -4970,7 +4969,7 @@ static struct i2c_driver rt5665_i2c_driver = {
 		.of_match_table = of_match_ptr(rt5665_of_match),
 		.acpi_match_table = ACPI_PTR(rt5665_acpi_match),
 	},
-	.probe = rt5665_i2c_probe,
+	.probe_new = rt5665_i2c_probe,
 	.shutdown = rt5665_i2c_shutdown,
 	.id_table = rt5665_i2c_id,
 };
diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 5b12cbf2ba21..01566f036ca1 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2453,8 +2453,7 @@ static void rt5668_calibrate(struct rt5668_priv *rt5668)
 
 }
 
-static int rt5668_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5668_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5668_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5668_priv *rt5668;
@@ -2620,7 +2619,7 @@ static struct i2c_driver rt5668_i2c_driver = {
 		.of_match_table = of_match_ptr(rt5668_of_match),
 		.acpi_match_table = ACPI_PTR(rt5668_acpi_match),
 	},
-	.probe = rt5668_i2c_probe,
+	.probe_new = rt5668_i2c_probe,
 	.shutdown = rt5668_i2c_shutdown,
 	.id_table = rt5668_i2c_id,
 };
diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index ce7684752bb0..8a97f6db04d5 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -3046,8 +3046,7 @@ const char *rt5670_components(void)
 }
 EXPORT_SYMBOL_GPL(rt5670_components);
 
-static int rt5670_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5670_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5670_priv *rt5670;
 	int ret;
@@ -3334,7 +3333,7 @@ static struct i2c_driver rt5670_i2c_driver = {
 		.name = "rt5670",
 		.acpi_match_table = ACPI_PTR(rt5670_acpi_match),
 	},
-	.probe = rt5670_i2c_probe,
+	.probe_new = rt5670_i2c_probe,
 	.remove   = rt5670_i2c_remove,
 	.id_table = rt5670_i2c_id,
 };
diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 20fc0f3766de..3f72f6093436 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -118,8 +118,7 @@ static void rt5682_i2c_disable_regulators(void *data)
 	regulator_bulk_disable(ARRAY_SIZE(rt5682->supplies), rt5682->supplies);
 }
 
-static int rt5682_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int rt5682_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5682_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5682_priv *rt5682;
@@ -335,7 +334,7 @@ static struct i2c_driver rt5682_i2c_driver = {
 		.acpi_match_table = rt5682_acpi_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-	.probe = rt5682_i2c_probe,
+	.probe_new = rt5682_i2c_probe,
 	.remove = rt5682_i2c_remove,
 	.shutdown = rt5682_i2c_shutdown,
 	.id_table = rt5682_i2c_id,
diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 1cba8ec7cedb..70086747c585 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -3029,8 +3029,7 @@ static void rt5682s_i2c_disable_regulators(void *data)
 	regulator_bulk_disable(ARRAY_SIZE(rt5682s->supplies), rt5682s->supplies);
 }
 
-static int rt5682s_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int rt5682s_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5682s_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5682s_priv *rt5682s;
@@ -3214,7 +3213,7 @@ static struct i2c_driver rt5682s_i2c_driver = {
 		.acpi_match_table = rt5682s_acpi_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-	.probe = rt5682s_i2c_probe,
+	.probe_new = rt5682s_i2c_probe,
 	.remove = rt5682s_i2c_remove,
 	.shutdown = rt5682s_i2c_shutdown,
 	.id_table = rt5682s_i2c_id,
-- 
2.27.0

