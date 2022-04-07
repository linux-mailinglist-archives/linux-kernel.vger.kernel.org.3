Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF64F833D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbiDGPal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiDGPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:30:36 -0400
X-Greylist: delayed 168324 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 08:28:30 PDT
Received: from 15.mo583.mail-out.ovh.net (15.mo583.mail-out.ovh.net [178.33.107.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECEAC6E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:28:30 -0700 (PDT)
Received: from player796.ha.ovh.net (unknown [10.110.171.136])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 6793324403
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:20:22 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id 8208729330148;
        Thu,  7 Apr 2022 15:20:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G0034497206b-6a9c-4c63-891e-297cf9db652a,
                    5995496A90EC26C6A3824F4C00BBD29EFE55D398) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 07/10] clk: si5351: use i2c_match_id and simple i2c probe
Date:   Thu,  7 Apr 2022 17:18:28 +0200
Message-Id: <20220407151831.2371706-8-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220407151831.2371706-1-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 87257243844511366
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejkedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/clk/clk-si5351.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 93fa8c9e11be..b9f088c4ba2f 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1367,9 +1367,18 @@ si53351_of_clk_get(struct of_phandle_args *clkspec, void *data)
 }
 #endif /* CONFIG_OF */
 
-static int si5351_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static const struct i2c_device_id si5351_i2c_ids[] = {
+	{ "si5351a", SI5351_VARIANT_A },
+	{ "si5351a-msop", SI5351_VARIANT_A3 },
+	{ "si5351b", SI5351_VARIANT_B },
+	{ "si5351c", SI5351_VARIANT_C },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, si5351_i2c_ids);
+
+static int si5351_i2c_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_match_id(si5351_i2c_ids, client);
 	enum si5351_variant variant = (enum si5351_variant)id->driver_data;
 	struct si5351_platform_data *pdata;
 	struct si5351_driver_data *drvdata;
@@ -1649,21 +1658,12 @@ static int si5351_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id si5351_i2c_ids[] = {
-	{ "si5351a", SI5351_VARIANT_A },
-	{ "si5351a-msop", SI5351_VARIANT_A3 },
-	{ "si5351b", SI5351_VARIANT_B },
-	{ "si5351c", SI5351_VARIANT_C },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, si5351_i2c_ids);
-
 static struct i2c_driver si5351_driver = {
 	.driver = {
 		.name = "si5351",
 		.of_match_table = of_match_ptr(si5351_dt_ids),
 	},
-	.probe = si5351_i2c_probe,
+	.probe_new = si5351_i2c_probe,
 	.remove = si5351_i2c_remove,
 	.id_table = si5351_i2c_ids,
 };
-- 
2.27.0

