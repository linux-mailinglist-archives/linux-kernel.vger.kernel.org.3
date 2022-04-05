Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F344F5037
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiDFBMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457877AbiDEQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:55:05 -0400
Received: from 14.mo581.mail-out.ovh.net (14.mo581.mail-out.ovh.net [178.33.251.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586BC326E9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:53:06 -0700 (PDT)
Received: from player734.ha.ovh.net (unknown [10.110.171.5])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id E660823BE0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:42 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player734.ha.ovh.net (Postfix) with ESMTPSA id 85D1D28FEBF99;
        Tue,  5 Apr 2022 16:35:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R004d61553c7-e202-4547-945e-565ecbb11848,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     M R Swami Reddy <mr.swami.reddy@ti.com>,
        Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: lm49xxx: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:35:33 +0200
Message-Id: <20220405163533.2157401-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8060880383069685382
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 sound/soc/codecs/isabelle.c | 5 ++---
 sound/soc/codecs/lm49453.c  | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index 1d86b6a0eb9d..39be31e1282e 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -1108,8 +1108,7 @@ static const struct regmap_config isabelle_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int isabelle_i2c_probe(struct i2c_client *i2c,
-			      const struct i2c_device_id *id)
+static int isabelle_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap *isabelle_regmap;
 	int ret = 0;
@@ -1144,7 +1143,7 @@ static struct i2c_driver isabelle_i2c_driver = {
 	.driver = {
 		.name = "isabelle",
 	},
-	.probe = isabelle_i2c_probe,
+	.probe_new = isabelle_i2c_probe,
 	.id_table = isabelle_i2c_id,
 };
 
diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 973d781b4b6a..bd0078e4499b 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1412,8 +1412,7 @@ static const struct regmap_config lm49453_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int lm49453_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int lm49453_i2c_probe(struct i2c_client *i2c)
 {
 	struct lm49453_priv *lm49453;
 	int ret = 0;
@@ -1458,7 +1457,7 @@ static struct i2c_driver lm49453_i2c_driver = {
 	.driver = {
 		.name = "lm49453",
 	},
-	.probe = lm49453_i2c_probe,
+	.probe_new = lm49453_i2c_probe,
 	.remove = lm49453_i2c_remove,
 	.id_table = lm49453_i2c_id,
 };
-- 
2.27.0

