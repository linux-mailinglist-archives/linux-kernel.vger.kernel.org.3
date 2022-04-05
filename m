Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471554F49BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241419AbiDEWZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458147AbiDERKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:10:19 -0400
Received: from 8.mo576.mail-out.ovh.net (8.mo576.mail-out.ovh.net [46.105.56.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523652E2A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:08:18 -0700 (PDT)
Received: from player771.ha.ovh.net (unknown [10.111.172.14])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 2263623D36
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:59:32 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id C1050293E36B7;
        Tue,  5 Apr 2022 16:59:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R00643b1e07f-95df-4e95-9a98-f3cede4a735b,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 03/14] ASoC: es83*: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:58:25 +0200
Message-Id: <20220405165836.2165310-4-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405165836.2165310-1-steve@sk2.org>
References: <20220405165836.2165310-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8463108128444155526
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeelledvfeeiiedutdefveekgeeuheekkedvffegvdehudegkefgjeejkefgueegnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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
 sound/soc/codecs/es8316.c     | 5 ++---
 sound/soc/codecs/es8328-i2c.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index ff33eab6f9de..4407166bb338 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -789,8 +789,7 @@ static const struct regmap_config es8316_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int es8316_i2c_probe(struct i2c_client *i2c_client,
-			    const struct i2c_device_id *id)
+static int es8316_i2c_probe(struct i2c_client *i2c_client)
 {
 	struct device *dev = &i2c_client->dev;
 	struct es8316_priv *es8316;
@@ -852,7 +851,7 @@ static struct i2c_driver es8316_i2c_driver = {
 		.acpi_match_table	= ACPI_PTR(es8316_acpi_match),
 		.of_match_table		= of_match_ptr(es8316_of_match),
 	},
-	.probe		= es8316_i2c_probe,
+	.probe_new	= es8316_i2c_probe,
 	.id_table	= es8316_i2c_id,
 };
 module_i2c_driver(es8316_i2c_driver);
diff --git a/sound/soc/codecs/es8328-i2c.c b/sound/soc/codecs/es8328-i2c.c
index 6b0df0d750dc..68072e99fcc7 100644
--- a/sound/soc/codecs/es8328-i2c.c
+++ b/sound/soc/codecs/es8328-i2c.c
@@ -29,8 +29,7 @@ static const struct of_device_id es8328_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, es8328_of_match);
 
-static int es8328_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int es8328_i2c_probe(struct i2c_client *i2c)
 {
 	return es8328_probe(&i2c->dev,
 			devm_regmap_init_i2c(i2c, &es8328_regmap_config));
@@ -41,7 +40,7 @@ static struct i2c_driver es8328_i2c_driver = {
 		.name		= "es8328",
 		.of_match_table = es8328_of_match,
 	},
-	.probe    = es8328_i2c_probe,
+	.probe_new = es8328_i2c_probe,
 	.id_table = es8328_id,
 };
 
-- 
2.27.0

