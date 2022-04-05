Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2374F49DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451624AbiDEWaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458146AbiDERKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:10:17 -0400
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 10:08:18 PDT
Received: from 4.mo575.mail-out.ovh.net (4.mo575.mail-out.ovh.net [46.105.59.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664EC81648
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:08:17 -0700 (PDT)
Received: from player771.ha.ovh.net (unknown [10.108.16.160])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 371112376A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:00:20 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id D300B293E393F;
        Tue,  5 Apr 2022 17:00:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R00631340dfc-6f6e-4f91-9fd8-9d7b05e15ce0,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 12/14] ASoC: tlv320*: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:58:34 +0200
Message-Id: <20220405165836.2165310-13-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405165836.2165310-1-steve@sk2.org>
References: <20220405165836.2165310-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8476900402881857158
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeelledvfeeiiedutdefveekgeeuheekkedvffegvdehudegkefgjeejkefgueegnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
 sound/soc/codecs/tlv320adcx140.c   | 5 ++---
 sound/soc/codecs/tlv320aic23-i2c.c | 5 ++---
 sound/soc/codecs/tlv320dac33.c     | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 32b120d624b2..0b06fbb14171 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -1083,8 +1083,7 @@ static const struct of_device_id tlv320adcx140_of_match[] = {
 MODULE_DEVICE_TABLE(of, tlv320adcx140_of_match);
 #endif
 
-static int adcx140_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int adcx140_i2c_probe(struct i2c_client *i2c)
 {
 	struct adcx140_priv *adcx140;
 	int ret;
@@ -1143,7 +1142,7 @@ static struct i2c_driver adcx140_i2c_driver = {
 		.name	= "tlv320adcx140-codec",
 		.of_match_table = of_match_ptr(tlv320adcx140_of_match),
 	},
-	.probe		= adcx140_i2c_probe,
+	.probe_new	= adcx140_i2c_probe,
 	.id_table	= adcx140_i2c_id,
 };
 module_i2c_driver(adcx140_i2c_driver);
diff --git a/sound/soc/codecs/tlv320aic23-i2c.c b/sound/soc/codecs/tlv320aic23-i2c.c
index dbb8f969274c..1f97673a1cc0 100644
--- a/sound/soc/codecs/tlv320aic23-i2c.c
+++ b/sound/soc/codecs/tlv320aic23-i2c.c
@@ -16,8 +16,7 @@
 
 #include "tlv320aic23.h"
 
-static int tlv320aic23_i2c_probe(struct i2c_client *i2c,
-				 const struct i2c_device_id *i2c_id)
+static int tlv320aic23_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap *regmap;
 
@@ -48,7 +47,7 @@ static struct i2c_driver tlv320aic23_i2c_driver = {
 		   .name = "tlv320aic23-codec",
 		   .of_match_table = of_match_ptr(tlv320aic23_of_match),
 		   },
-	.probe = tlv320aic23_i2c_probe,
+	.probe_new = tlv320aic23_i2c_probe,
 	.id_table = tlv320aic23_id,
 };
 
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 48572d66cb3b..66f1d1cd6cf0 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1463,8 +1463,7 @@ static struct snd_soc_dai_driver dac33_dai = {
 	.ops = &dac33_dai_ops,
 };
 
-static int dac33_i2c_probe(struct i2c_client *client,
-			   const struct i2c_device_id *id)
+static int dac33_i2c_probe(struct i2c_client *client)
 {
 	struct tlv320dac33_platform_data *pdata;
 	struct tlv320dac33_priv *dac33;
@@ -1566,7 +1565,7 @@ static struct i2c_driver tlv320dac33_i2c_driver = {
 	.driver = {
 		.name = "tlv320dac33-codec",
 	},
-	.probe		= dac33_i2c_probe,
+	.probe_new	= dac33_i2c_probe,
 	.remove		= dac33_i2c_remove,
 	.id_table	= tlv320dac33_i2c_id,
 };
-- 
2.27.0

