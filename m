Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790414E7BE0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiCYRal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344037AbiCYR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:29:56 -0400
X-Greylist: delayed 86401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Mar 2022 10:28:21 PDT
Received: from 3.mo583.mail-out.ovh.net (3.mo583.mail-out.ovh.net [46.105.40.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACAF13CE9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:28:19 -0700 (PDT)
Received: from player794.ha.ovh.net (unknown [10.109.138.16])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 2921D24C4E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:19:21 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player794.ha.ovh.net (Postfix) with ESMTPSA id 9D5F9258D1F1A;
        Fri, 25 Mar 2022 17:19:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G003659f3854-5bd9-4f7a-9f05-7da53b41d8b6,
                    1702D5D0C6B5DF16716081994498F990499A02DA) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Wolfram Sang <wsa@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: da7218: use i2c_match_id and simple i2c probe
Date:   Fri, 25 Mar 2022 18:19:04 +0100
Message-Id: <20220325171904.1223539-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17985406590459610758
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudehuddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the ongoing i2c transition to the simple probe
("probe_new"), this patch uses i2c_match_id to retrieve the
driver_data for the probed device. The id parameter is thus no longer
necessary and the simple probe can be used instead.

This patch follows the model set by da7218_of_get_id().

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 sound/soc/codecs/da7218.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index ea426d986d4c..a5d7c350a3de 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -3258,8 +3258,19 @@ static const struct regmap_config da7218_regmap_config = {
  * I2C layer
  */
 
-static int da7218_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static const struct i2c_device_id da7218_i2c_id[];
+
+static inline int da7218_i2c_get_id(struct i2c_client *i2c)
+{
+	const struct i2c_device_id *id = i2c_match_id(da7218_i2c_id, i2c);
+
+	if (id)
+		return (uintptr_t)id->driver_data;
+	else
+		return -EINVAL;
+}
+
+static int da7218_i2c_probe(struct i2c_client *i2c)
 {
 	struct da7218_priv *da7218;
 	int ret;
@@ -3273,7 +3284,7 @@ static int da7218_i2c_probe(struct i2c_client *i2c,
 	if (i2c->dev.of_node)
 		da7218->dev_id = da7218_of_get_id(&i2c->dev);
 	else
-		da7218->dev_id = id->driver_data;
+		da7218->dev_id = da7218_i2c_get_id(i2c);
 
 	if ((da7218->dev_id != DA7217_DEV_ID) &&
 	    (da7218->dev_id != DA7218_DEV_ID)) {
@@ -3311,7 +3322,7 @@ static struct i2c_driver da7218_i2c_driver = {
 		.name = "da7218",
 		.of_match_table = da7218_of_match,
 	},
-	.probe		= da7218_i2c_probe,
+	.probe_new	= da7218_i2c_probe,
 	.id_table	= da7218_i2c_id,
 };
 
-- 
2.27.0

