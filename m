Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96CA4F4929
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391235AbiDEWFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457950AbiDERBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:01:22 -0400
Received: from 6.mo560.mail-out.ovh.net (6.mo560.mail-out.ovh.net [87.98.165.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6493A51E46
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:59:23 -0700 (PDT)
Received: from player771.ha.ovh.net (unknown [10.109.156.133])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 58ADD23B90
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:59:21 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id F24EE293E366C;
        Tue,  5 Apr 2022 16:59:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R0069cd6cc63-6d12-4d77-a5d0-44e51e431b9e,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 01/14] ASoC: ak4*: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:58:23 +0200
Message-Id: <20220405165836.2165310-2-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405165836.2165310-1-steve@sk2.org>
References: <20220405165836.2165310-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8460293375399265926
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeelledvfeeiiedutdefveekgeeuheekkedvffegvdehudegkefgjeejkefgueegnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 sound/soc/codecs/ak4118.c | 5 ++---
 sound/soc/codecs/ak4535.c | 5 ++---
 sound/soc/codecs/ak4641.c | 5 ++---
 sound/soc/codecs/ak4671.c | 5 ++---
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/ak4118.c b/sound/soc/codecs/ak4118.c
index 2e6bafd2a821..5c4a78c16733 100644
--- a/sound/soc/codecs/ak4118.c
+++ b/sound/soc/codecs/ak4118.c
@@ -356,8 +356,7 @@ static const struct regmap_config ak4118_regmap = {
 	.max_register = AK4118_REG_MAX - 1,
 };
 
-static int ak4118_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int ak4118_i2c_probe(struct i2c_client *i2c)
 {
 	struct ak4118_priv *ak4118;
 	int ret;
@@ -416,7 +415,7 @@ static struct i2c_driver ak4118_i2c_driver = {
 		.of_match_table = of_match_ptr(ak4118_of_match),
 	},
 	.id_table = ak4118_id_table,
-	.probe  = ak4118_i2c_probe,
+	.probe_new = ak4118_i2c_probe,
 };
 
 module_i2c_driver(ak4118_i2c_driver);
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 91e7a57c43da..cc803e730c6e 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -405,8 +405,7 @@ static const struct snd_soc_component_driver soc_component_dev_ak4535 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int ak4535_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int ak4535_i2c_probe(struct i2c_client *i2c)
 {
 	struct ak4535_priv *ak4535;
 	int ret;
@@ -441,7 +440,7 @@ static struct i2c_driver ak4535_i2c_driver = {
 	.driver = {
 		.name = "ak4535",
 	},
-	.probe =    ak4535_i2c_probe,
+	.probe_new = ak4535_i2c_probe,
 	.id_table = ak4535_i2c_id,
 };
 
diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 04aef0e72aa5..d8d9cc712d67 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -548,8 +548,7 @@ static const struct regmap_config ak4641_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int ak4641_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int ak4641_i2c_probe(struct i2c_client *i2c)
 {
 	struct ak4641_platform_data *pdata = i2c->dev.platform_data;
 	struct ak4641_priv *ak4641;
@@ -632,7 +631,7 @@ static struct i2c_driver ak4641_i2c_driver = {
 	.driver = {
 		.name = "ak4641",
 	},
-	.probe =    ak4641_i2c_probe,
+	.probe_new = ak4641_i2c_probe,
 	.remove =   ak4641_i2c_remove,
 	.id_table = ak4641_i2c_id,
 };
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index e9d1251c4265..60edcbe56014 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -629,8 +629,7 @@ static const struct regmap_config ak4671_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int ak4671_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int ak4671_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
 	int ret;
@@ -657,7 +656,7 @@ static struct i2c_driver ak4671_i2c_driver = {
 	.driver = {
 		.name = "ak4671-codec",
 	},
-	.probe = ak4671_i2c_probe,
+	.probe_new = ak4671_i2c_probe,
 	.id_table = ak4671_i2c_id,
 };
 
-- 
2.27.0

