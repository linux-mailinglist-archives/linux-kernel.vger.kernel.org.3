Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE34F83A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243519AbiDGPkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiDGPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:40:14 -0400
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 08:38:14 PDT
Received: from 4.mo561.mail-out.ovh.net (4.mo561.mail-out.ovh.net [178.33.46.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE3DC6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:38:13 -0700 (PDT)
Received: from player796.ha.ovh.net (unknown [10.111.208.131])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id BA73123EE2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:20:30 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id DD6AA293301E3;
        Thu,  7 Apr 2022 15:20:22 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G0034263be14-6f21-4a81-963b-ca0d4b4f9814,
                    5995496A90EC26C6A3824F4C00BBD29EFE55D398) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 08/10] clk: si544: use i2c_match_id and simple i2c probe
Date:   Thu,  7 Apr 2022 17:18:29 +0200
Message-Id: <20220407151831.2371706-9-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220407151831.2371706-1-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 89509043186730630
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejkedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 drivers/clk/clk-si544.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-si544.c b/drivers/clk/clk-si544.c
index d9ec9086184d..089786907641 100644
--- a/drivers/clk/clk-si544.c
+++ b/drivers/clk/clk-si544.c
@@ -451,11 +451,19 @@ static const struct regmap_config si544_regmap_config = {
 	.volatile_reg = si544_regmap_is_volatile,
 };
 
-static int si544_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static const struct i2c_device_id si544_id[] = {
+	{ "si544a", si544a },
+	{ "si544b", si544b },
+	{ "si544c", si544c },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, si544_id);
+
+static int si544_probe(struct i2c_client *client)
 {
 	struct clk_si544 *data;
 	struct clk_init_data init;
+	const struct i2c_device_id *id = i2c_match_id(si544_id, client);
 	int err;
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
@@ -499,14 +507,6 @@ static int si544_probe(struct i2c_client *client,
 	return 0;
 }
 
-static const struct i2c_device_id si544_id[] = {
-	{ "si544a", si544a },
-	{ "si544b", si544b },
-	{ "si544c", si544c },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, si544_id);
-
 static const struct of_device_id clk_si544_of_match[] = {
 	{ .compatible = "silabs,si544a" },
 	{ .compatible = "silabs,si544b" },
@@ -520,7 +520,7 @@ static struct i2c_driver si544_driver = {
 		.name = "si544",
 		.of_match_table = clk_si544_of_match,
 	},
-	.probe		= si544_probe,
+	.probe_new	= si544_probe,
 	.id_table	= si544_id,
 };
 module_i2c_driver(si544_driver);
-- 
2.27.0

