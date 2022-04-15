Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2E502D81
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355738AbiDOQJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355728AbiDOQJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:09:54 -0400
Received: from 14.mo581.mail-out.ovh.net (14.mo581.mail-out.ovh.net [178.33.251.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF049D4D9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:07:26 -0700 (PDT)
Received: from player760.ha.ovh.net (unknown [10.110.115.113])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id DC9C924083
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:07:24 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id F21A82986A9F0;
        Fri, 15 Apr 2022 16:07:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G004a5dd2735-609b-4c2a-8ba0-a2006ce0080b,
                    77125C2C2681624F8512B69FC7A1C9B53E6602B4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 7/7] ASoC: tpa6130: use i2c_match_id and simple i2c probe
Date:   Fri, 15 Apr 2022 18:06:13 +0200
Message-Id: <20220415160613.148882-8-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415160613.148882-1-steve@sk2.org>
References: <20220415160613.148882-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10969642794601186950
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 sound/soc/codecs/tpa6130a2.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index e2d7ae615c52..5bc486283fde 100644
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
-- 
2.27.0

