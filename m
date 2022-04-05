Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE37F4F4DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583107AbiDEXvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452904AbiDEPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:55:41 -0400
X-Greylist: delayed 8707 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 07:58:07 PDT
Received: from 4.mo583.mail-out.ovh.net (4.mo583.mail-out.ovh.net [178.33.111.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D2D371B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:58:04 -0700 (PDT)
Received: from player688.ha.ovh.net (unknown [10.111.172.22])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 0B28224B9A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:32:58 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player688.ha.ovh.net (Postfix) with ESMTPSA id 7DBA2291068A7;
        Tue,  5 Apr 2022 12:32:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G00552102515-f355-46c0-857e-560b28840b63,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Wolfram Sang <wsa@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: wm8731: use simple i2c probe function
Date:   Tue,  5 Apr 2022 14:32:36 +0200
Message-Id: <20220405123236.2099063-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3961197347742844550
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 sound/soc/codecs/wm8731.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 5d4949c2ec9b..c430f169eb24 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -723,8 +723,7 @@ static struct spi_driver wm8731_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if IS_ENABLED(CONFIG_I2C)
-static int wm8731_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8731_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8731_priv *wm8731;
 	int ret;
@@ -788,7 +787,7 @@ static struct i2c_driver wm8731_i2c_driver = {
 		.name = "wm8731",
 		.of_match_table = wm8731_of_match,
 	},
-	.probe =    wm8731_i2c_probe,
+	.probe_new = wm8731_i2c_probe,
 	.id_table = wm8731_i2c_id,
 };
 #endif
-- 
2.27.0

