Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44445502D88
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355745AbiDOQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355741AbiDOQPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:15:43 -0400
X-Greylist: delayed 2075 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Apr 2022 09:13:13 PDT
Received: from 17.mo561.mail-out.ovh.net (17.mo561.mail-out.ovh.net [87.98.178.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15029681F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:13:13 -0700 (PDT)
Received: from player760.ha.ovh.net (unknown [10.110.208.22])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id B09CB23D6E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:06:44 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id DDC8E2986A8E3;
        Fri, 15 Apr 2022 16:06:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G0046e4cf2e4-4eda-47c3-9e45-5448747ece0e,
                    77125C2C2681624F8512B69FC7A1C9B53E6602B4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 1/7] ASoC: ak*: use i2c_match_id and simple i2c probe
Date:   Fri, 15 Apr 2022 18:06:07 +0200
Message-Id: <20220415160613.148882-2-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415160613.148882-1-steve@sk2.org>
References: <20220415160613.148882-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10958383795147736710
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 sound/soc/codecs/ak4613.c | 10 ++++++----
 sound/soc/codecs/ak4642.c |  8 +++++---
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 03b829930769..55e773f92122 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -876,8 +876,7 @@ static void ak4613_parse_of(struct ak4613_priv *priv,
 	AK4613_CONFIG_SDTI_set(priv, sdti_num);
 }
 
-static int ak4613_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int ak4613_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct device_node *np = dev->of_node;
@@ -888,8 +887,11 @@ static int ak4613_i2c_probe(struct i2c_client *i2c,
 	regmap_cfg = NULL;
 	if (np)
 		regmap_cfg = of_device_get_match_data(dev);
-	else
+	else {
+		const struct i2c_device_id *id =
+			i2c_match_id(ak4613_i2c_id, i2c);
 		regmap_cfg = (const struct regmap_config *)id->driver_data;
+	}
 
 	if (!regmap_cfg)
 		return -EINVAL;
@@ -927,7 +929,7 @@ static struct i2c_driver ak4613_i2c_driver = {
 		.name = "ak4613-codec",
 		.of_match_table = ak4613_of_match,
 	},
-	.probe		= ak4613_i2c_probe,
+	.probe_new	= ak4613_i2c_probe,
 	.remove		= ak4613_i2c_remove,
 	.id_table	= ak4613_i2c_id,
 };
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index c284dcc5af76..3c20ff5595eb 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -630,8 +630,8 @@ static struct clk *ak4642_of_parse_mcko(struct device *dev)
 #endif
 
 static const struct of_device_id ak4642_of_match[];
-static int ak4642_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static const struct i2c_device_id ak4642_i2c_id[];
+static int ak4642_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct device_node *np = dev->of_node;
@@ -651,6 +651,8 @@ static int ak4642_i2c_probe(struct i2c_client *i2c,
 		if (of_id)
 			drvdata = of_id->data;
 	} else {
+		const struct i2c_device_id *id =
+			i2c_match_id(ak4642_i2c_id, i2c);
 		drvdata = (const struct ak4642_drvdata *)id->driver_data;
 	}
 
@@ -697,7 +699,7 @@ static struct i2c_driver ak4642_i2c_driver = {
 		.name = "ak4642-codec",
 		.of_match_table = ak4642_of_match,
 	},
-	.probe		= ak4642_i2c_probe,
+	.probe_new	= ak4642_i2c_probe,
 	.id_table	= ak4642_i2c_id,
 };
 
-- 
2.27.0

