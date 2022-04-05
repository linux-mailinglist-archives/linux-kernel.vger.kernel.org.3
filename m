Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AE34F4048
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiDEU37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457952AbiDERB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:01:27 -0400
Received: from 14.mo582.mail-out.ovh.net (14.mo582.mail-out.ovh.net [46.105.56.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6561E65838
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:59:28 -0700 (PDT)
Received: from player771.ha.ovh.net (unknown [10.108.16.30])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id BB1DE23A1E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:59:26 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id 575A6293E3695;
        Tue,  5 Apr 2022 16:59:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006b3e2e77b-2407-4228-94bb-9a20ade0f9bf,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 02/14] ASoC: cx2072x: use simple i2c probe function
Date:   Tue,  5 Apr 2022 18:58:24 +0200
Message-Id: <20220405165836.2165310-3-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405165836.2165310-1-steve@sk2.org>
References: <20220405165836.2165310-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8461700752417785478
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeelledvfeeiiedutdefveekgeeuheekkedvffegvdehudegkefgjeejkefgueegnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
 sound/soc/codecs/cx2072x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 1f5c57fab1d8..0d3a00434c6d 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -1626,8 +1626,7 @@ static int __maybe_unused cx2072x_runtime_resume(struct device *dev)
 	return clk_prepare_enable(cx2072x->mclk);
 }
 
-static int cx2072x_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int cx2072x_i2c_probe(struct i2c_client *i2c)
 {
 	struct cx2072x_priv *cx2072x;
 	unsigned int ven_id, rev_id;
@@ -1710,7 +1709,7 @@ static struct i2c_driver cx2072x_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(cx2072x_acpi_match),
 		.pm = &cx2072x_runtime_pm,
 	},
-	.probe = cx2072x_i2c_probe,
+	.probe_new = cx2072x_i2c_probe,
 	.remove = cx2072x_i2c_remove,
 	.id_table = cx2072x_i2c_id,
 };
-- 
2.27.0

