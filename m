Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F734F469F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242121AbiDEUhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457977AbiDERCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:02:32 -0400
Received: from 9.mo584.mail-out.ovh.net (9.mo584.mail-out.ovh.net [46.105.40.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC57B2E9C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:00:32 -0700 (PDT)
Received: from player771.ha.ovh.net (unknown [10.108.1.181])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 183F62353B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:00:31 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id 9880C293E39E0;
        Tue,  5 Apr 2022 17:00:25 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R0067464f05e-4097-4c7c-a65a-96236ca073ef,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 14/14] ASoC: uda1380: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:58:36 +0200
Message-Id: <20220405165836.2165310-15-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405165836.2165310-1-steve@sk2.org>
References: <20220405165836.2165310-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8479715150873462406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeelledvfeeiiedutdefveekgeeuheekkedvffegvdehudegkefgjeejkefgueegnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
 sound/soc/codecs/uda1380.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 13060a9a2388..b5004842520b 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -739,8 +739,7 @@ static const struct snd_soc_component_driver soc_component_dev_uda1380 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int uda1380_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int uda1380_i2c_probe(struct i2c_client *i2c)
 {
 	struct uda1380_platform_data *pdata = i2c->dev.platform_data;
 	struct uda1380_priv *uda1380;
@@ -800,7 +799,7 @@ static struct i2c_driver uda1380_i2c_driver = {
 		.name =  "uda1380-codec",
 		.of_match_table = uda1380_of_match,
 	},
-	.probe =    uda1380_i2c_probe,
+	.probe_new = uda1380_i2c_probe,
 	.id_table = uda1380_i2c_id,
 };
 
-- 
2.27.0

