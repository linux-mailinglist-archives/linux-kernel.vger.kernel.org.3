Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A974F4C23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576027AbiDEXKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458143AbiDERKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:10:17 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 10:08:15 PDT
Received: from 10.mo576.mail-out.ovh.net (10.mo576.mail-out.ovh.net [46.105.73.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD926C1DA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:08:13 -0700 (PDT)
Received: from player771.ha.ovh.net (unknown [10.111.172.191])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id A322523CC8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:00:25 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id 3AE23293E39B6;
        Tue,  5 Apr 2022 17:00:20 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006bbcc4550-8b60-44cb-b1ac-2dcbc4224a37,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 13/14] ASoC: ts3a227e: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:58:35 +0200
Message-Id: <20220405165836.2165310-14-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405165836.2165310-1-steve@sk2.org>
References: <20220405165836.2165310-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8478307775260690054
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeelledvfeeiiedutdefveekgeeuheekkedvffegvdehudegkefgjeejkefgueegnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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
 sound/soc/codecs/ts3a227e.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 962f5d48378a..d8ab0810fceb 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -282,8 +282,7 @@ static int ts3a227e_parse_device_property(struct ts3a227e *ts3a227e,
 	return 0;
 }
 
-static int ts3a227e_i2c_probe(struct i2c_client *i2c,
-			      const struct i2c_device_id *id)
+static int ts3a227e_i2c_probe(struct i2c_client *i2c)
 {
 	struct ts3a227e *ts3a227e;
 	struct device *dev = &i2c->dev;
@@ -389,7 +388,7 @@ static struct i2c_driver ts3a227e_driver = {
 		.of_match_table = of_match_ptr(ts3a227e_of_match),
 		.acpi_match_table = ACPI_PTR(ts3a227e_acpi_match),
 	},
-	.probe = ts3a227e_i2c_probe,
+	.probe_new = ts3a227e_i2c_probe,
 	.id_table = ts3a227e_i2c_ids,
 };
 module_i2c_driver(ts3a227e_driver);
-- 
2.27.0

