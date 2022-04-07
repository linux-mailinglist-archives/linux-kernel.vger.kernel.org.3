Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45A94F8334
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbiDGPaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiDGPaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:30:14 -0400
Received: from 2.mo561.mail-out.ovh.net (2.mo561.mail-out.ovh.net [46.105.75.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11EE120
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:28:13 -0700 (PDT)
Received: from player796.ha.ovh.net (unknown [10.108.1.68])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id CEF4724009
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:20:39 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id B079E29330215;
        Thu,  7 Apr 2022 15:20:30 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G003da191969-9655-4f56-b741-88365d4a5fb6,
                    5995496A90EC26C6A3824F4C00BBD29EFE55D398) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 09/10] clk: si570: use i2c_match_id and simple i2c probe
Date:   Thu,  7 Apr 2022 17:18:30 +0200
Message-Id: <20220407151831.2371706-10-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220407151831.2371706-1-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 92042318176945798
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejkedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 drivers/clk/clk-si570.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
index eea50121718a..1ff8f32f734d 100644
--- a/drivers/clk/clk-si570.c
+++ b/drivers/clk/clk-si570.c
@@ -398,11 +398,20 @@ static const struct regmap_config si570_regmap_config = {
 	.volatile_reg = si570_regmap_is_volatile,
 };
 
-static int si570_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static const struct i2c_device_id si570_id[] = {
+	{ "si570", si57x },
+	{ "si571", si57x },
+	{ "si598", si59x },
+	{ "si599", si59x },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, si570_id);
+
+static int si570_probe(struct i2c_client *client)
 {
 	struct clk_si570 *data;
 	struct clk_init_data init;
+	const struct i2c_device_id *id = i2c_match_id(si570_id, client);
 	u32 initial_fout, factory_fout, stability;
 	bool skip_recall;
 	int err;
@@ -495,15 +504,6 @@ static int si570_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id si570_id[] = {
-	{ "si570", si57x },
-	{ "si571", si57x },
-	{ "si598", si59x },
-	{ "si599", si59x },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, si570_id);
-
 static const struct of_device_id clk_si570_of_match[] = {
 	{ .compatible = "silabs,si570" },
 	{ .compatible = "silabs,si571" },
@@ -518,7 +518,7 @@ static struct i2c_driver si570_driver = {
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

