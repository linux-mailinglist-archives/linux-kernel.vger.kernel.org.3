Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F14F833A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbiDGPaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344753AbiDGPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:30:42 -0400
Received: from 9.mo583.mail-out.ovh.net (9.mo583.mail-out.ovh.net [178.32.96.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D1C19
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:28:29 -0700 (PDT)
Received: from player796.ha.ovh.net (unknown [10.109.146.106])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 2E87E243DF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:20:07 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id AB6C7293300E7;
        Thu,  7 Apr 2022 15:20:00 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G0034c962ea5-ae9c-4d67-a931-d80837463e79,
                    5995496A90EC26C6A3824F4C00BBD29EFE55D398) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 05/10] clk: si514: use simple i2c probe function
Date:   Thu,  7 Apr 2022 17:18:26 +0200
Message-Id: <20220407151831.2371706-6-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220407151831.2371706-1-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 83035121023354502
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejkedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c probe function here doesn't use the id information provided in
its second argument, so the single-parameter i2c probe function
("probe_new") can be used instead.

This avoids scanning the identifier tables during probes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/clk/clk-si514.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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
-- 
2.27.0

