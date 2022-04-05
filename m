Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0D84F47A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356877AbiDEVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457760AbiDEQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:42:56 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 09:40:56 PDT
Received: from 5.mo583.mail-out.ovh.net (5.mo583.mail-out.ovh.net [87.98.173.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48BDDFFBD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:40:56 -0700 (PDT)
Received: from player715.ha.ovh.net (unknown [10.108.20.144])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 6067823F18
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:40:54 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id F12DC2900AE2A;
        Tue,  5 Apr 2022 16:40:48 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R002e7e3a593-6777-45c4-9110-c0244ab646ae,
                    8BB3F008109FF1ACF458F8D30695C50246D29715) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: sgtl5000: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:40:31 +0200
Message-Id: <20220405164031.2160888-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8148700579943122566
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeduhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
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
 sound/soc/codecs/sgtl5000.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 8eebf27d0ea2..2aa48aef6a97 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1579,8 +1579,7 @@ static void sgtl5000_fill_defaults(struct i2c_client *client)
 	}
 }
 
-static int sgtl5000_i2c_probe(struct i2c_client *client,
-			      const struct i2c_device_id *id)
+static int sgtl5000_i2c_probe(struct i2c_client *client)
 {
 	struct sgtl5000_priv *sgtl5000;
 	int ret, reg, rev;
@@ -1821,7 +1820,7 @@ static struct i2c_driver sgtl5000_i2c_driver = {
 		.name = "sgtl5000",
 		.of_match_table = sgtl5000_dt_ids,
 	},
-	.probe = sgtl5000_i2c_probe,
+	.probe_new = sgtl5000_i2c_probe,
 	.remove = sgtl5000_i2c_remove,
 	.id_table = sgtl5000_id,
 };
-- 
2.27.0

