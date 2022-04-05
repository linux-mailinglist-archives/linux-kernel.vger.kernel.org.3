Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3344F4A71
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456459AbiDEWp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572991AbiDERm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:42:26 -0400
Received: from 1.mo560.mail-out.ovh.net (1.mo560.mail-out.ovh.net [46.105.63.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE597B91A9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:40:27 -0700 (PDT)
Received: from player691.ha.ovh.net (unknown [10.108.4.183])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 9372423A32
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:40:26 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player691.ha.ovh.net (Postfix) with ESMTPSA id 271F5293C8F1F;
        Tue,  5 Apr 2022 17:40:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G004618b8f4f-e2e9-40cb-b8ab-e15530b48acd,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Wolfram Sang <wsa@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2] ASoC: wm8731: use simple i2c probe function
Date:   Tue,  5 Apr 2022 19:39:52 +0200
Message-Id: <20220405173952.2180743-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9154129193012921990
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrieeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
Changes since v1:
  - rebased on sound/for-next instead of v5.18-rc1
---
 sound/soc/codecs/wm8731-i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8731-i2c.c b/sound/soc/codecs/wm8731-i2c.c
index c70f5db891e7..fdf03bf91606 100644
--- a/sound/soc/codecs/wm8731-i2c.c
+++ b/sound/soc/codecs/wm8731-i2c.c
@@ -23,8 +23,7 @@ static const struct of_device_id wm8731_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8731_of_match);
 
-static int wm8731_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8731_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8731_priv *wm8731;
 	int ret;
@@ -58,7 +57,7 @@ static struct i2c_driver wm8731_i2c_driver = {
 		.name = "wm8731",
 		.of_match_table = wm8731_of_match,
 	},
-	.probe =    wm8731_i2c_probe,
+	.probe_new = wm8731_i2c_probe,
 	.id_table = wm8731_i2c_id,
 };
 

base-commit: b66751b6e3591eafe5c9cbabd68a45731b0083e3
-- 
2.27.0

