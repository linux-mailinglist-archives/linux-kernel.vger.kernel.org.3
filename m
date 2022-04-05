Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BD04F4EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836355AbiDFAfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457742AbiDEQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:38:28 -0400
Received: from 20.mo582.mail-out.ovh.net (20.mo582.mail-out.ovh.net [178.32.124.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E67D3737
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:36:29 -0700 (PDT)
Received: from player696.ha.ovh.net (unknown [10.108.1.191])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 413FE23E49
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:36:28 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id DB1AA1EFDEA11;
        Tue,  5 Apr 2022 16:36:22 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G005435116ba-5cdd-4ff3-a179-c77177e0e200,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: pcm3060: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:36:18 +0200
Message-Id: <20220405163618.2158090-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8073828232917059206
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheileeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 sound/soc/codecs/pcm3060-i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm3060-i2c.c b/sound/soc/codecs/pcm3060-i2c.c
index abcdeb922201..2388098eeca3 100644
--- a/sound/soc/codecs/pcm3060-i2c.c
+++ b/sound/soc/codecs/pcm3060-i2c.c
@@ -10,8 +10,7 @@
 
 #include "pcm3060.h"
 
-static int pcm3060_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int pcm3060_i2c_probe(struct i2c_client *i2c)
 {
 	struct pcm3060_priv *priv;
 
@@ -50,7 +49,7 @@ static struct i2c_driver pcm3060_i2c_driver = {
 #endif /* CONFIG_OF */
 	},
 	.id_table = pcm3060_i2c_id,
-	.probe = pcm3060_i2c_probe,
+	.probe_new = pcm3060_i2c_probe,
 };
 
 module_i2c_driver(pcm3060_i2c_driver);
-- 
2.27.0

