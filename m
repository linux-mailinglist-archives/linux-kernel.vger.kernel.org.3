Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484AA502D80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355722AbiDOQJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355100AbiDOQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:09:33 -0400
Received: from 7.mo575.mail-out.ovh.net (7.mo575.mail-out.ovh.net [46.105.63.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC5A8BE31
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:07:04 -0700 (PDT)
Received: from player760.ha.ovh.net (unknown [10.110.103.18])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 1953D25615
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:07:03 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id 866D12986A96D;
        Fri, 15 Apr 2022 16:06:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G004712937d1-ea39-4cd2-a334-326f8b3c9a7c,
                    77125C2C2681624F8512B69FC7A1C9B53E6602B4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 4/7] ASoC: pcm186x: use i2c_match_id and simple i2c probe
Date:   Fri, 15 Apr 2022 18:06:10 +0200
Message-Id: <20220415160613.148882-5-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415160613.148882-1-steve@sk2.org>
References: <20220415160613.148882-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10963450345294235270
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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
 sound/soc/codecs/pcm186x-i2c.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/pcm186x-i2c.c b/sound/soc/codecs/pcm186x-i2c.c
index f8382b74391d..932c8d41c3ea 100644
--- a/sound/soc/codecs/pcm186x-i2c.c
+++ b/sound/soc/codecs/pcm186x-i2c.c
@@ -22,9 +22,18 @@ static const struct of_device_id pcm186x_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, pcm186x_of_match);
 
-static int pcm186x_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static const struct i2c_device_id pcm186x_i2c_id[] = {
+	{ "pcm1862", PCM1862 },
+	{ "pcm1863", PCM1863 },
+	{ "pcm1864", PCM1864 },
+	{ "pcm1865", PCM1865 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcm186x_i2c_id);
+
+static int pcm186x_i2c_probe(struct i2c_client *i2c)
 {
+	const struct i2c_device_id *id = i2c_match_id(pcm186x_i2c_id, i2c);
 	const enum pcm186x_type type = (enum pcm186x_type)id->driver_data;
 	int irq = i2c->irq;
 	struct regmap *regmap;
@@ -36,17 +45,8 @@ static int pcm186x_i2c_probe(struct i2c_client *i2c,
 	return pcm186x_probe(&i2c->dev, type, irq, regmap);
 }
 
-static const struct i2c_device_id pcm186x_i2c_id[] = {
-	{ "pcm1862", PCM1862 },
-	{ "pcm1863", PCM1863 },
-	{ "pcm1864", PCM1864 },
-	{ "pcm1865", PCM1865 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, pcm186x_i2c_id);
-
 static struct i2c_driver pcm186x_i2c_driver = {
-	.probe		= pcm186x_i2c_probe,
+	.probe_new	= pcm186x_i2c_probe,
 	.id_table	= pcm186x_i2c_id,
 	.driver		= {
 		.name	= "pcm186x",
-- 
2.27.0

