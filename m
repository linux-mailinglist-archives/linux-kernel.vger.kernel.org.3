Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631CA4F4C53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578099AbiDEXS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572984AbiDERkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:40:13 -0400
Received: from 16.mo561.mail-out.ovh.net (16.mo561.mail-out.ovh.net [188.165.56.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35592B8202
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:38:14 -0700 (PDT)
Received: from player771.ha.ovh.net (unknown [10.110.115.164])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 8E9CB23B0B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:00:09 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id 18863293E387E;
        Tue,  5 Apr 2022 17:00:04 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R00643f7ca1c-cfdc-4bdb-9e7b-5dcba98903d2,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 10/14] ASoC: tas*: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:58:32 +0200
Message-Id: <20220405165836.2165310-11-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405165836.2165310-1-steve@sk2.org>
References: <20220405165836.2165310-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8473804174955742854
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeelledvfeeiiedutdefveekgeeuheekkedvffegvdehudegkefgjeejkefgueegnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
 sound/soc/codecs/tas2552.c | 5 ++---
 sound/soc/codecs/tas2764.c | 5 ++---
 sound/soc/codecs/tas2770.c | 5 ++---
 sound/soc/codecs/tas5086.c | 5 ++---
 sound/soc/codecs/tas6424.c | 5 ++---
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 700baa6314aa..b5c9c61ff5a8 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -681,8 +681,7 @@ static const struct regmap_config tas2552_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int tas2552_probe(struct i2c_client *client,
-			   const struct i2c_device_id *id)
+static int tas2552_probe(struct i2c_client *client)
 {
 	struct device *dev;
 	struct tas2552_data *data;
@@ -764,7 +763,7 @@ static struct i2c_driver tas2552_i2c_driver = {
 		.of_match_table = of_match_ptr(tas2552_of_match),
 		.pm = &tas2552_pm,
 	},
-	.probe = tas2552_probe,
+	.probe_new = tas2552_probe,
 	.remove = tas2552_i2c_remove,
 	.id_table = tas2552_id,
 };
diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 9265af41c235..d395feffb30b 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -621,8 +621,7 @@ static int tas2764_parse_dt(struct device *dev, struct tas2764_priv *tas2764)
 	return 0;
 }
 
-static int tas2764_i2c_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int tas2764_i2c_probe(struct i2c_client *client)
 {
 	struct tas2764_priv *tas2764;
 	int result;
@@ -678,7 +677,7 @@ static struct i2c_driver tas2764_i2c_driver = {
 		.name   = "tas2764",
 		.of_match_table = of_match_ptr(tas2764_of_match),
 	},
-	.probe      = tas2764_i2c_probe,
+	.probe_new  = tas2764_i2c_probe,
 	.id_table   = tas2764_i2c_id,
 };
 module_i2c_driver(tas2764_i2c_driver);
diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c5ea3b115966..c1dbd978d550 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -672,8 +672,7 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 	return 0;
 }
 
-static int tas2770_i2c_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int tas2770_i2c_probe(struct i2c_client *client)
 {
 	struct tas2770_priv *tas2770;
 	int result;
@@ -739,7 +738,7 @@ static struct i2c_driver tas2770_i2c_driver = {
 		.name   = "tas2770",
 		.of_match_table = of_match_ptr(tas2770_of_match),
 	},
-	.probe      = tas2770_i2c_probe,
+	.probe_new  = tas2770_i2c_probe,
 	.id_table   = tas2770_i2c_id,
 };
 module_i2c_driver(tas2770_i2c_driver);
diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 7831c96d0d83..5c0df3cd4832 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -911,8 +911,7 @@ static const struct regmap_config tas5086_regmap = {
 	.reg_write		= tas5086_reg_write,
 };
 
-static int tas5086_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int tas5086_i2c_probe(struct i2c_client *i2c)
 {
 	struct tas5086_private *priv;
 	struct device *dev = &i2c->dev;
@@ -994,7 +993,7 @@ static struct i2c_driver tas5086_i2c_driver = {
 		.of_match_table = of_match_ptr(tas5086_dt_ids),
 	},
 	.id_table	= tas5086_i2c_id,
-	.probe		= tas5086_i2c_probe,
+	.probe_new	= tas5086_i2c_probe,
 	.remove		= tas5086_i2c_remove,
 };
 
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 59543d392110..f06d2ad613f8 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -682,8 +682,7 @@ static const struct of_device_id tas6424_of_ids[] = {
 MODULE_DEVICE_TABLE(of, tas6424_of_ids);
 #endif
 
-static int tas6424_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int tas6424_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct tas6424_data *tas6424;
@@ -805,7 +804,7 @@ static struct i2c_driver tas6424_i2c_driver = {
 		.name = "tas6424",
 		.of_match_table = of_match_ptr(tas6424_of_ids),
 	},
-	.probe = tas6424_i2c_probe,
+	.probe_new = tas6424_i2c_probe,
 	.remove = tas6424_i2c_remove,
 	.id_table = tas6424_i2c_ids,
 };
-- 
2.27.0

