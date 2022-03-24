Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243B04E68AA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352648AbiCXSaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbiCXSaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:30:00 -0400
X-Greylist: delayed 4197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 11:28:23 PDT
Received: from 17.mo584.mail-out.ovh.net (17.mo584.mail-out.ovh.net [46.105.41.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC2A1102
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:28:21 -0700 (PDT)
Received: from player761.ha.ovh.net (unknown [10.108.4.98])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 129A124A92
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 17:09:51 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player761.ha.ovh.net (Postfix) with ESMTPSA id B45E328C421ED;
        Thu, 24 Mar 2022 17:09:47 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G0025265364e-40e9-46d8-84d7-bc7edcd87a9c,
                    78FFD8E4238D9337B8F0C8EEA79873C5FE5514E5) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] auxdisplay: lcd2s: use simple i2c probe function
Date:   Thu, 24 Mar 2022 18:09:29 +0100
Message-Id: <20220324170929.542348-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11951990462367827590
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejiedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 drivers/auxdisplay/lcd2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index 2578b2d45439..0c64b46dbb71 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -286,8 +286,7 @@ static const struct charlcd_ops lcd2s_ops = {
 	.redefine_char	= lcd2s_redefine_char,
 };
 
-static int lcd2s_i2c_probe(struct i2c_client *i2c,
-				const struct i2c_device_id *id)
+static int lcd2s_i2c_probe(struct i2c_client *i2c)
 {
 	struct charlcd *lcd;
 	struct lcd2s_data *lcd2s;
@@ -370,7 +369,7 @@ static struct i2c_driver lcd2s_i2c_driver = {
 		.of_match_table = of_match_ptr(lcd2s_of_table),
 #endif
 	},
-	.probe = lcd2s_i2c_probe,
+	.probe_new = lcd2s_i2c_probe,
 	.remove = lcd2s_i2c_remove,
 	.id_table = lcd2s_i2c_id,
 };
-- 
2.27.0

