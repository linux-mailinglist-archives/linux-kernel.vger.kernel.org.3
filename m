Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB50E4E68F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352776AbiCXS74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243939AbiCXS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:59:52 -0400
X-Greylist: delayed 4195 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 11:58:17 PDT
Received: from 4.mo576.mail-out.ovh.net (4.mo576.mail-out.ovh.net [46.105.42.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F770220F7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:58:15 -0700 (PDT)
Received: from player779.ha.ovh.net (unknown [10.111.208.135])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4F31C246A4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:29:19 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player779.ha.ovh.net (Postfix) with ESMTPSA id E876028AC2CB3;
        Thu, 24 Mar 2022 16:29:11 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G003cab070b8-3fe0-45c6-ae9b-e73783c827e2,
                    78FFD8E4238D9337B8F0C8EEA79873C5FE5514E5) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Max Filippov <jcmvbkbc@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] clk: use simple i2c probe function
Date:   Thu, 24 Mar 2022 17:29:04 +0100
Message-Id: <20220324162904.530140-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11267724796347713158
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejjeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/clk/clk-cdce706.c   | 5 ++---
 drivers/clk/clk-cs2000-cp.c | 5 ++---
 drivers/clk/clk-max9485.c   | 5 ++---
 drivers/clk/clk-si514.c     | 5 ++---
 drivers/clk/clk-si5341.c    | 5 ++---
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk-cdce706.c b/drivers/clk/clk-cdce706.c
index c91e9096b070..5467d941ddfd 100644
--- a/drivers/clk/clk-cdce706.c
+++ b/drivers/clk/clk-cdce706.c
@@ -627,8 +627,7 @@ of_clk_cdce_get(struct of_phandle_args *clkspec, void *data)
 	return &cdce->clkout[idx].hw;
 }
 
-static int cdce706_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int cdce706_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	struct cdce706_dev_data *cdce;
@@ -692,7 +691,7 @@ static struct i2c_driver cdce706_i2c_driver = {
 		.name	= "cdce706",
 		.of_match_table = of_match_ptr(cdce706_dt_match),
 	},
-	.probe		= cdce706_probe,
+	.probe_new	= cdce706_probe,
 	.remove		= cdce706_remove,
 	.id_table	= cdce706_id,
 };
diff --git a/drivers/clk/clk-cs2000-cp.c b/drivers/clk/clk-cs2000-cp.c
index 92bc4aca0f95..db9746a604ad 100644
--- a/drivers/clk/clk-cs2000-cp.c
+++ b/drivers/clk/clk-cs2000-cp.c
@@ -504,8 +504,7 @@ static int cs2000_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int cs2000_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int cs2000_probe(struct i2c_client *client)
 {
 	struct cs2000_priv *priv;
 	struct device *dev = &client->dev;
@@ -555,7 +554,7 @@ static struct i2c_driver cs2000_driver = {
 		.pm	= &cs2000_pm_ops,
 		.of_match_table = cs2000_of_match,
 	},
-	.probe		= cs2000_probe,
+	.probe_new	= cs2000_probe,
 	.remove		= cs2000_remove,
 	.id_table	= cs2000_id,
 };
diff --git a/drivers/clk/clk-max9485.c b/drivers/clk/clk-max9485.c
index 5e80f3d090f3..5f85b0a32872 100644
--- a/drivers/clk/clk-max9485.c
+++ b/drivers/clk/clk-max9485.c
@@ -254,8 +254,7 @@ max9485_of_clk_get(struct of_phandle_args *clkspec, void *data)
 	return &drvdata->hw[idx].hw;
 }
 
-static int max9485_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int max9485_i2c_probe(struct i2c_client *client)
 {
 	struct max9485_driver_data *drvdata;
 	struct device *dev = &client->dev;
@@ -377,7 +376,7 @@ static struct i2c_driver max9485_driver = {
 		.pm		= &max9485_pm_ops,
 		.of_match_table	= max9485_dt_ids,
 	},
-	.probe = max9485_i2c_probe,
+	.probe_new = max9485_i2c_probe,
 	.id_table = max9485_i2c_ids,
 };
 module_i2c_driver(max9485_driver);
diff --git a/drivers/clk/clk-si514.c b/drivers/clk/clk-si514.c
index 364b62b9928d..4481c4303534 100644
--- a/drivers/clk/clk-si514.c
+++ b/drivers/clk/clk-si514.c
@@ -327,8 +327,7 @@ static const struct regmap_config si514_regmap_config = {
 	.volatile_reg = si514_regmap_is_volatile,
 };
 
-static int si514_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static int si514_probe(struct i2c_client *client)
 {
 	struct clk_si514 *data;
 	struct clk_init_data init;
@@ -394,7 +393,7 @@ static struct i2c_driver si514_driver = {
 		.name = "si514",
 		.of_match_table = clk_si514_of_match,
 	},
-	.probe		= si514_probe,
+	.probe_new	= si514_probe,
 	.remove		= si514_remove,
 	.id_table	= si514_id,
 };
diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index f7b41366666e..55b0fa6b9c1d 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1545,8 +1545,7 @@ static const struct attribute *si5341_attributes[] = {
 	NULL
 };
 
-static int si5341_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static int si5341_probe(struct i2c_client *client)
 {
 	struct clk_si5341 *data;
 	struct clk_init_data init;
@@ -1835,7 +1834,7 @@ static struct i2c_driver si5341_driver = {
 		.name = "si5341",
 		.of_match_table = clk_si5341_of_match,
 	},
-	.probe		= si5341_probe,
+	.probe_new	= si5341_probe,
 	.remove		= si5341_remove,
 	.id_table	= si5341_id,
 };

base-commit: b47d5a4f6b8d42f8a8fbe891b36215e4fddc53be
-- 
2.27.0

