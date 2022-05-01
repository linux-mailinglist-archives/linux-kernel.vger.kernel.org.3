Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466D351669E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353092AbiEARbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiEARbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:31:35 -0400
Received: from 10.mo584.mail-out.ovh.net (10.mo584.mail-out.ovh.net [188.165.33.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C8BE12
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:28:09 -0700 (PDT)
Received: from player774.ha.ovh.net (unknown [10.109.138.76])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 3503E229E0
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:10:40 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player774.ha.ovh.net (Postfix) with ESMTPSA id 851C529E9FA78;
        Sun,  1 May 2022 17:10:35 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-95G0012a755f93-ac22-4b2f-9ace-e5b21267d47b,
                    5040CBFF384BEDF7422707969F5457AB1E143173) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v3] ASoC: tpa6130: use i2c_match_id and simple i2c probe
Date:   Sun,  1 May 2022 19:10:09 +0200
Message-Id: <20220501171009.45060-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13767504061568288390
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepleegteeujeffjeefjeevhfdtudefjefgteelgedtudekleeiledvvdetudevjedtnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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

The i2c id table is moved up before the probe function, as suggested
by Wolfram Sang.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
Changes since v2: added missing probe_new change.

Changes since v1: two missing files were added (in the overall patch
series).
---
 sound/soc/codecs/tpa6130a2.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index e2d7ae615c52..8c00db32996b 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -209,13 +209,20 @@ static const struct regmap_config tpa6130a2_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int tpa6130a2_probe(struct i2c_client *client,
-			   const struct i2c_device_id *id)
+static const struct i2c_device_id tpa6130a2_id[] = {
+	{ "tpa6130a2", TPA6130A2 },
+	{ "tpa6140a2", TPA6140A2 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tpa6130a2_id);
+
+static int tpa6130a2_probe(struct i2c_client *client)
 {
 	struct device *dev;
 	struct tpa6130a2_data *data;
 	struct tpa6130a2_platform_data *pdata = client->dev.platform_data;
 	struct device_node *np = client->dev.of_node;
+	const struct i2c_device_id *id;
 	const char *regulator;
 	unsigned int version;
 	int ret;
@@ -244,6 +251,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 
+	id = i2c_match_id(tpa6130a2_id, client);
 	data->id = id->driver_data;
 
 	if (data->power_gpio >= 0) {
@@ -297,13 +305,6 @@ static int tpa6130a2_probe(struct i2c_client *client,
 			&tpa6130a2_component_driver, NULL, 0);
 }
 
-static const struct i2c_device_id tpa6130a2_id[] = {
-	{ "tpa6130a2", TPA6130A2 },
-	{ "tpa6140a2", TPA6140A2 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, tpa6130a2_id);
-
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id tpa6130a2_of_match[] = {
 	{ .compatible = "ti,tpa6130a2", },
@@ -318,7 +319,7 @@ static struct i2c_driver tpa6130a2_i2c_driver = {
 		.name = "tpa6130a2",
 		.of_match_table = of_match_ptr(tpa6130a2_of_match),
 	},
-	.probe = tpa6130a2_probe,
+	.probe_new = tpa6130a2_probe,
 	.id_table = tpa6130a2_id,
 };
 

base-commit: 180e66c028cbce98f297962db188965efc7546d7
-- 
2.30.2

