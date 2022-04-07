Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C2B4F82AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbiDGPWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbiDGPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:21:59 -0400
X-Greylist: delayed 166844 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 08:19:56 PDT
Received: from 1.mo581.mail-out.ovh.net (1.mo581.mail-out.ovh.net [178.33.45.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23F41FAA3C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:19:56 -0700 (PDT)
Received: from player796.ha.ovh.net (unknown [10.111.172.176])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 7D83123291
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:19:46 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id CD8F02932FFCF;
        Thu,  7 Apr 2022 15:19:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G0036ce79144-b56c-4add-9154-6fb98c6ebeca,
                    5995496A90EC26C6A3824F4C00BBD29EFE55D398) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 02/10] clk: cdce925: use i2c_match_id and simple i2c probe
Date:   Thu,  7 Apr 2022 17:18:23 +0200
Message-Id: <20220407151831.2371706-3-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220407151831.2371706-1-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 77124144948741766
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejkedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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
 drivers/clk/clk-cdce925.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index 308b353815e1..ef9a2d44e40c 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -634,11 +634,20 @@ static struct regmap_bus regmap_cdce925_bus = {
 	.read = cdce925_regmap_i2c_read,
 };
 
-static int cdce925_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static const struct i2c_device_id cdce925_id[] = {
+	{ "cdce913", CDCE913 },
+	{ "cdce925", CDCE925 },
+	{ "cdce937", CDCE937 },
+	{ "cdce949", CDCE949 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cdce925_id);
+
+static int cdce925_probe(struct i2c_client *client)
 {
 	struct clk_cdce925_chip *data;
 	struct device_node *node = client->dev.of_node;
+	const struct i2c_device_id *id = i2c_match_id(cdce925_id, client);
 	const char *parent_name;
 	const char *pll_clk_name[MAX_NUMBER_OF_PLLS] = {NULL,};
 	struct clk_init_data init;
@@ -814,15 +823,6 @@ static int cdce925_probe(struct i2c_client *client,
 	return err;
 }
 
-static const struct i2c_device_id cdce925_id[] = {
-	{ "cdce913", CDCE913 },
-	{ "cdce925", CDCE925 },
-	{ "cdce937", CDCE937 },
-	{ "cdce949", CDCE949 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, cdce925_id);
-
 static const struct of_device_id clk_cdce925_of_match[] = {
 	{ .compatible = "ti,cdce913" },
 	{ .compatible = "ti,cdce925" },
@@ -837,7 +837,7 @@ static struct i2c_driver cdce925_driver = {
 		.name = "cdce925",
 		.of_match_table = of_match_ptr(clk_cdce925_of_match),
 	},
-	.probe		= cdce925_probe,
+	.probe_new	= cdce925_probe,
 	.id_table	= cdce925_id,
 };
 module_i2c_driver(cdce925_driver);
-- 
2.27.0

