Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EFB4F4BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbiDEXEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457700AbiDEQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:36:18 -0400
X-Greylist: delayed 13570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 09:34:18 PDT
Received: from 7.mo583.mail-out.ovh.net (7.mo583.mail-out.ovh.net [178.32.124.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B5065D3A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:34:16 -0700 (PDT)
Received: from player728.ha.ovh.net (unknown [10.111.208.112])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 70E2722CEB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:34:15 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 53C7D2918CC09;
        Tue,  5 Apr 2022 16:34:04 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R00216734794-6a76-4f86-9128-4ef53b3b435f,
                    8BB3F008109FF1ACF458F8D30695C50246D29715) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Steven Eckhoff <steven.eckhoff.opensource@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: tscs*: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:34:00 +0200
Message-Id: <20220405163400.2156631-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8036392060513846918
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 sound/soc/codecs/tscs42xx.c | 5 ++---
 sound/soc/codecs/tscs454.c  | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 5b63e017a43b..4fb0bb01bcdc 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -1409,8 +1409,7 @@ static const struct reg_sequence tscs42xx_patch[] = {
 static char const * const src_names[TSCS42XX_PLL_SRC_CNT] = {
 	"xtal", "mclk1", "mclk2"};
 
-static int tscs42xx_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int tscs42xx_i2c_probe(struct i2c_client *i2c)
 {
 	struct tscs42xx *tscs42xx;
 	int src;
@@ -1505,7 +1504,7 @@ static struct i2c_driver tscs42xx_i2c_driver = {
 		.name = "tscs42xx",
 		.of_match_table = tscs42xx_of_match,
 	},
-	.probe =    tscs42xx_i2c_probe,
+	.probe_new = tscs42xx_i2c_probe,
 	.id_table = tscs42xx_i2c_id,
 };
 
diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index 7e1826d6f06f..b34a8b516484 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -3400,8 +3400,7 @@ static struct snd_soc_dai_driver tscs454_dais[] = {
 static char const * const src_names[] = {
 	"xtal", "mclk1", "mclk2", "bclk"};
 
-static int tscs454_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int tscs454_i2c_probe(struct i2c_client *i2c)
 {
 	struct tscs454 *tscs454;
 	int src;
@@ -3474,7 +3473,7 @@ static struct i2c_driver tscs454_i2c_driver = {
 		.name = "tscs454",
 		.of_match_table = tscs454_of_match,
 	},
-	.probe =    tscs454_i2c_probe,
+	.probe_new = tscs454_i2c_probe,
 	.id_table = tscs454_i2c_id,
 };
 
-- 
2.27.0

