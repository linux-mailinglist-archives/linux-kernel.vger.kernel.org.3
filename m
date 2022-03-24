Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229244E67EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346473AbiCXRjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbiCXRjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:39:47 -0400
X-Greylist: delayed 1793 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 10:38:14 PDT
Received: from 2.mo561.mail-out.ovh.net (2.mo561.mail-out.ovh.net [46.105.75.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102496EB29
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:38:12 -0700 (PDT)
Received: from player158.ha.ovh.net (unknown [10.108.20.52])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 81A6F245BB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:59:13 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player158.ha.ovh.net (Postfix) with ESMTPSA id 027C128BA44A3;
        Thu, 24 Mar 2022 16:59:07 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G003bf81b195-8d89-4a74-bcfe-1482886f0cef,
                    78FFD8E4238D9337B8F0C8EEA79873C5FE5514E5) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] clk: use i2c_match_id and simple i2c probe
Date:   Thu, 24 Mar 2022 17:59:04 +0100
Message-Id: <20220324165904.538861-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11772690904623974022
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhduheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 drivers/clk/clk-cdce925.c | 8 +++++---
 drivers/clk/clk-si5351.c  | 8 +++++---
 drivers/clk/clk-si544.c   | 8 +++++---
 drivers/clk/clk-si570.c   | 8 +++++---
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index 308b353815e1..b5495ff3a950 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -634,11 +634,13 @@ static struct regmap_bus regmap_cdce925_bus = {
 	.read = cdce925_regmap_i2c_read,
 };
 
-static int cdce925_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static const struct i2c_device_id cdce925_id[];
+
+static int cdce925_probe(struct i2c_client *client)
 {
 	struct clk_cdce925_chip *data;
 	struct device_node *node = client->dev.of_node;
+	const struct i2c_device_id *id = i2c_match_id(cdce925_id, client);
 	const char *parent_name;
 	const char *pll_clk_name[MAX_NUMBER_OF_PLLS] = {NULL,};
 	struct clk_init_data init;
@@ -837,7 +839,7 @@ static struct i2c_driver cdce925_driver = {
 		.name = "cdce925",
 		.of_match_table = of_match_ptr(clk_cdce925_of_match),
 	},
-	.probe		= cdce925_probe,
+	.probe_new	= cdce925_probe,
 	.id_table	= cdce925_id,
 };
 module_i2c_driver(cdce925_driver);
diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 93fa8c9e11be..3db5e97c62c0 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1367,9 +1367,11 @@ si53351_of_clk_get(struct of_phandle_args *clkspec, void *data)
 }
 #endif /* CONFIG_OF */
 
-static int si5351_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static const struct i2c_device_id si5351_i2c_ids[];
+
+static int si5351_i2c_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_match_id(si5351_i2c_ids, client);
 	enum si5351_variant variant = (enum si5351_variant)id->driver_data;
 	struct si5351_platform_data *pdata;
 	struct si5351_driver_data *drvdata;
@@ -1663,7 +1665,7 @@ static struct i2c_driver si5351_driver = {
 		.name = "si5351",
 		.of_match_table = of_match_ptr(si5351_dt_ids),
 	},
-	.probe = si5351_i2c_probe,
+	.probe_new = si5351_i2c_probe,
 	.remove = si5351_i2c_remove,
 	.id_table = si5351_i2c_ids,
 };
diff --git a/drivers/clk/clk-si544.c b/drivers/clk/clk-si544.c
index d9ec9086184d..7a0c28b71b7b 100644
--- a/drivers/clk/clk-si544.c
+++ b/drivers/clk/clk-si544.c
@@ -451,11 +451,13 @@ static const struct regmap_config si544_regmap_config = {
 	.volatile_reg = si544_regmap_is_volatile,
 };
 
-static int si544_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static const struct i2c_device_id si544_id[];
+
+static int si544_probe(struct i2c_client *client)
 {
 	struct clk_si544 *data;
 	struct clk_init_data init;
+	const struct i2c_device_id *id = i2c_match_id(si544_id, client);
 	int err;
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
@@ -520,7 +522,7 @@ static struct i2c_driver si544_driver = {
 		.name = "si544",
 		.of_match_table = clk_si544_of_match,
 	},
-	.probe		= si544_probe,
+	.probe_new	= si544_probe,
 	.id_table	= si544_id,
 };
 module_i2c_driver(si544_driver);
diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
index eea50121718a..779fe72054fd 100644
--- a/drivers/clk/clk-si570.c
+++ b/drivers/clk/clk-si570.c
@@ -398,11 +398,13 @@ static const struct regmap_config si570_regmap_config = {
 	.volatile_reg = si570_regmap_is_volatile,
 };
 
-static int si570_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static const struct i2c_device_id si570_id[];
+
+static int si570_probe(struct i2c_client *client)
 {
 	struct clk_si570 *data;
 	struct clk_init_data init;
+	const struct i2c_device_id *id = i2c_match_id(si570_id, client);
 	u32 initial_fout, factory_fout, stability;
 	bool skip_recall;
 	int err;
@@ -518,7 +520,7 @@ static struct i2c_driver si570_driver = {
 		.name = "si570",
 		.of_match_table = clk_si570_of_match,
 	},
-	.probe		= si570_probe,
+	.probe_new	= si570_probe,
 	.remove		= si570_remove,
 	.id_table	= si570_id,
 };
-- 
2.27.0

