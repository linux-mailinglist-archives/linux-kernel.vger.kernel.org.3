Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024CD4E7C89
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiCYUHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiCYUH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:07:27 -0400
Received: from 2.mo582.mail-out.ovh.net (2.mo582.mail-out.ovh.net [46.105.76.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6459A4CD55
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:03:05 -0700 (PDT)
Received: from player693.ha.ovh.net (unknown [10.110.103.132])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id E1FB024C1B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:25:24 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player693.ha.ovh.net (Postfix) with ESMTPSA id 4EAC428C06071;
        Fri, 25 Mar 2022 16:25:19 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-107S001dc4f81cd-8fd0-4ac5-9c7a-b78267933b18,
                    1702D5D0C6B5DF16716081994498F990499A02DA) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Wolfram Sang <wsa@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: wm*: use i2c_match_id and simple i2c probe
Date:   Fri, 25 Mar 2022 17:25:15 +0100
Message-Id: <20220325162515.1204107-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17074272088474289798
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudehuddgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheileefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 sound/soc/codecs/wm8904.c | 9 ++++++---
 sound/soc/codecs/wm8985.c | 8 +++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index a02a77fef360..04bb8e392497 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2162,8 +2162,9 @@ static const struct of_device_id wm8904_of_match[] = {
 MODULE_DEVICE_TABLE(of, wm8904_of_match);
 #endif
 
-static int wm8904_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static const struct i2c_device_id wm8904_i2c_id[];
+
+static int wm8904_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8904_priv *wm8904;
 	unsigned int val;
@@ -2197,6 +2198,8 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 			return -EINVAL;
 		wm8904->devtype = (enum wm8904_type)match->data;
 	} else {
+		const struct i2c_device_id *id =
+			i2c_match_id(wm8904_i2c_id, i2c);
 		wm8904->devtype = id->driver_data;
 	}
 
@@ -2328,7 +2331,7 @@ static struct i2c_driver wm8904_i2c_driver = {
 		.name = "wm8904",
 		.of_match_table = of_match_ptr(wm8904_of_match),
 	},
-	.probe =    wm8904_i2c_probe,
+	.probe_new = wm8904_i2c_probe,
 	.id_table = wm8904_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index a7e01106fbc0..cf2c32eac773 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1167,10 +1167,12 @@ static struct spi_driver wm8985_spi_driver = {
 #endif
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8985_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static const struct i2c_device_id wm8985_i2c_id[];
+
+static int wm8985_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8985_priv *wm8985;
+	const struct i2c_device_id *id = i2c_match_id(wm8985_i2c_id, i2c);
 	int ret;
 
 	wm8985 = devm_kzalloc(&i2c->dev, sizeof *wm8985, GFP_KERNEL);
@@ -1205,7 +1207,7 @@ static struct i2c_driver wm8985_i2c_driver = {
 	.driver = {
 		.name = "wm8985",
 	},
-	.probe = wm8985_i2c_probe,
+	.probe_new = wm8985_i2c_probe,
 	.id_table = wm8985_i2c_id
 };
 #endif
-- 
2.27.0

