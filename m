Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757284F51B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846875AbiDFCK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572916AbiDERUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:20:10 -0400
Received: from 1.mo560.mail-out.ovh.net (1.mo560.mail-out.ovh.net [46.105.63.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD7525E1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:18:11 -0700 (PDT)
Received: from player771.ha.ovh.net (unknown [10.108.1.239])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 743AC23DB2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:59:53 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id 2A535293E3788;
        Tue,  5 Apr 2022 16:59:48 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006ed33b081-15f6-42bd-a177-fdee9279753c,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 07/14] ASoC: nau8*: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:58:29 +0200
Message-Id: <20220405165836.2165310-8-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405165836.2165310-1-steve@sk2.org>
References: <20220405165836.2165310-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8469300576108250758
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeelledvfeeiiedutdefveekgeeuheekkedvffegvdehudegkefgjeejkefgueegnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
 sound/soc/codecs/nau8540.c | 5 ++---
 sound/soc/codecs/nau8810.c | 5 ++---
 sound/soc/codecs/nau8821.c | 5 ++---
 sound/soc/codecs/nau8822.c | 5 ++---
 sound/soc/codecs/nau8824.c | 5 ++---
 sound/soc/codecs/nau8825.c | 5 ++---
 6 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index ace96995fedc..347c715e22a4 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -823,8 +823,7 @@ static const struct regmap_config nau8540_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(nau8540_reg_defaults),
 };
 
-static int nau8540_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+static int nau8540_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct nau8540 *nau8540 = dev_get_platdata(dev);
@@ -874,7 +873,7 @@ static struct i2c_driver nau8540_i2c_driver = {
 		.name = "nau8540",
 		.of_match_table = of_match_ptr(nau8540_of_ids),
 	},
-	.probe = nau8540_i2c_probe,
+	.probe_new = nau8540_i2c_probe,
 	.id_table = nau8540_i2c_ids,
 };
 module_i2c_driver(nau8540_i2c_driver);
diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index 13676b544f58..7b3b1e4ac246 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -869,8 +869,7 @@ static const struct snd_soc_component_driver nau8810_component_driver = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int nau8810_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int nau8810_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct nau8810 *nau8810 = dev_get_platdata(dev);
@@ -916,7 +915,7 @@ static struct i2c_driver nau8810_i2c_driver = {
 		.name = "nau8810",
 		.of_match_table = of_match_ptr(nau8810_of_match),
 	},
-	.probe =    nau8810_i2c_probe,
+	.probe_new = nau8810_i2c_probe,
 	.id_table = nau8810_i2c_id,
 };
 
diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index d67dc27890a9..ce4e7f46bb06 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -1626,8 +1626,7 @@ static int nau8821_setup_irq(struct nau8821 *nau8821)
 	return 0;
 }
 
-static int nau8821_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+static int nau8821_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct nau8821 *nau8821 = dev_get_platdata(&i2c->dev);
@@ -1703,7 +1702,7 @@ static struct i2c_driver nau8821_driver = {
 		.of_match_table = of_match_ptr(nau8821_of_ids),
 		.acpi_match_table = ACPI_PTR(nau8821_acpi_match),
 	},
-	.probe = nau8821_i2c_probe,
+	.probe_new = nau8821_i2c_probe,
 	.remove = nau8821_i2c_remove,
 	.id_table = nau8821_i2c_ids,
 };
diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index 58123390c7a3..66bbd8f4f1ad 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -1083,8 +1083,7 @@ static const struct regmap_config nau8822_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(nau8822_reg_defaults),
 };
 
-static int nau8822_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int nau8822_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct nau8822 *nau8822 = dev_get_platdata(dev);
@@ -1141,7 +1140,7 @@ static struct i2c_driver nau8822_i2c_driver = {
 		.name = "nau8822",
 		.of_match_table = of_match_ptr(nau8822_of_match),
 	},
-	.probe =    nau8822_i2c_probe,
+	.probe_new = nau8822_i2c_probe,
 	.id_table = nau8822_i2c_id,
 };
 module_i2c_driver(nau8822_i2c_driver);
diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index d0dd1542f78a..2a7c93508535 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1910,8 +1910,7 @@ const char *nau8824_components(void)
 }
 EXPORT_SYMBOL_GPL(nau8824_components);
 
-static int nau8824_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+static int nau8824_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct nau8824 *nau8824 = dev_get_platdata(dev);
@@ -1985,7 +1984,7 @@ static struct i2c_driver nau8824_i2c_driver = {
 		.of_match_table = of_match_ptr(nau8824_of_ids),
 		.acpi_match_table = ACPI_PTR(nau8824_acpi_match),
 	},
-	.probe = nau8824_i2c_probe,
+	.probe_new = nau8824_i2c_probe,
 	.id_table = nau8824_i2c_ids,
 };
 module_i2c_driver(nau8824_i2c_driver);
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 7734bc35ab21..20e45a337b8f 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2613,8 +2613,7 @@ static int nau8825_setup_irq(struct nau8825 *nau8825)
 	return 0;
 }
 
-static int nau8825_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+static int nau8825_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct nau8825 *nau8825 = dev_get_platdata(&i2c->dev);
@@ -2703,7 +2702,7 @@ static struct i2c_driver nau8825_driver = {
 		.of_match_table = of_match_ptr(nau8825_of_ids),
 		.acpi_match_table = ACPI_PTR(nau8825_acpi_match),
 	},
-	.probe = nau8825_i2c_probe,
+	.probe_new = nau8825_i2c_probe,
 	.remove = nau8825_i2c_remove,
 	.id_table = nau8825_i2c_ids,
 };
-- 
2.27.0

