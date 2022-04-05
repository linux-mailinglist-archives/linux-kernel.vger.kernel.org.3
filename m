Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45534F4691
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355179AbiDEUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457966AbiDERCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:02:04 -0400
Received: from 1.mo576.mail-out.ovh.net (1.mo576.mail-out.ovh.net [178.33.251.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE71A8165F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:00:05 -0700 (PDT)
Received: from player771.ha.ovh.net (unknown [10.110.115.178])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 1B5CD23ED8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:00:04 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id BF89D293E3800;
        Tue,  5 Apr 2022 16:59:58 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006437fb18a-a5e4-41d7-ba4a-0e7824ff30f8,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 09/14] ASoC: sta*: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:58:31 +0200
Message-Id: <20220405165836.2165310-10-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405165836.2165310-1-steve@sk2.org>
References: <20220405165836.2165310-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8472396801019709062
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeelledvfeeiiedutdefveekgeeuheekkedvffegvdehudegkefgjeejkefgueegnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
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
 sound/soc/codecs/sta32x.c | 5 ++---
 sound/soc/codecs/sta350.c | 5 ++---
 sound/soc/codecs/sta529.c | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 86528b930de8..0ba6eab991c4 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -1094,8 +1094,7 @@ static int sta32x_probe_dt(struct device *dev, struct sta32x_priv *sta32x)
 }
 #endif
 
-static int sta32x_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int sta32x_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct sta32x_priv *sta32x;
@@ -1175,7 +1174,7 @@ static struct i2c_driver sta32x_i2c_driver = {
 		.name = "sta32x",
 		.of_match_table = of_match_ptr(st32x_dt_ids),
 	},
-	.probe =    sta32x_i2c_probe,
+	.probe_new = sta32x_i2c_probe,
 	.id_table = sta32x_i2c_id,
 };
 
diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
index 75d3b0618ab5..1fb370fc0ae3 100644
--- a/sound/soc/codecs/sta350.c
+++ b/sound/soc/codecs/sta350.c
@@ -1187,8 +1187,7 @@ static int sta350_probe_dt(struct device *dev, struct sta350_priv *sta350)
 }
 #endif
 
-static int sta350_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int sta350_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct sta350_priv *sta350;
@@ -1263,7 +1262,7 @@ static struct i2c_driver sta350_i2c_driver = {
 		.name = "sta350",
 		.of_match_table = of_match_ptr(st350_dt_ids),
 	},
-	.probe =    sta350_i2c_probe,
+	.probe_new = sta350_i2c_probe,
 	.remove =   sta350_i2c_remove,
 	.id_table = sta350_i2c_id,
 };
diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 97b5f34027c0..d90e5512a731 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -337,8 +337,7 @@ static const struct regmap_config sta529_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(sta529_reg_defaults),
 };
 
-static int sta529_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int sta529_i2c_probe(struct i2c_client *i2c)
 {
 	struct sta529 *sta529;
 	int ret;
@@ -381,7 +380,7 @@ static struct i2c_driver sta529_i2c_driver = {
 		.name = "sta529",
 		.of_match_table = sta529_of_match,
 	},
-	.probe		= sta529_i2c_probe,
+	.probe_new	= sta529_i2c_probe,
 	.id_table	= sta529_i2c_id,
 };
 
-- 
2.27.0

