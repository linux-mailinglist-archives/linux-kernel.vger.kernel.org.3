Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0054508ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379706AbiDTObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiDTObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:31:37 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB544759;
        Wed, 20 Apr 2022 07:28:50 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 4393CCD147;
        Wed, 20 Apr 2022 14:24:59 +0000 (UTC)
Received: from melee.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id A9FA940005;
        Wed, 20 Apr 2022 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650464695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=psA6iM1Q1qYNvi/shbhgNJN0YpWI69oasIrc52R//8o=;
        b=A/LejFrbDQbZww+XzPBLIe1NZDFAmF0mLv3HgI/lp8NT9R+TGZAq+lZtkrvy2cVXA39zQc
        4ZfzRm3N9yVtW14/5VowhX8K073TIwMENBpfPLOsFhyEOrrD5VKpMg6rBG4+TLbUChvkGo
        xl4OMwPCKahsIL0gPeTj/gKMcGQpyybc6RlDmAXVILD7HbcmB+EBYyL9V2Uc/nOfKWJIrV
        BLEwV+qUHyY+X7vgaC4cgnB0YQgJY8ikxtdFEGWXZ/oDP6OLQXjGyaGDKsyCa2rCV24OGp
        XQxOaq4I5ZkwyQiz9ePqRoF5TqPjzciiuYqrIXuxUnzp1q6KVb/NnH5hr5LBYQ==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-gpio@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: rockchip: fix RK3308 pinmux bits
Date:   Wed, 20 Apr 2022 16:24:31 +0200
Message-Id: <20220420142432.248565-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the pinmuxing bits described in rk3308_mux_recalced_data are wrong,
pointing to non-existing registers.

Fix the entire table.

Also add a comment in front of each entry with the same string that appears
in the datasheet to make the table easier to compare with the docs.

This fix has been tested on real hardware for the gpio3b3_sel entry.

Fixes: 7825aeb7b208 ("pinctrl: rockchip: add rk3308 SoC support")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 45 ++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index a1b598b86aa9..65fa305b5f59 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -457,95 +457,110 @@ static  struct rockchip_mux_recalced_data rk3128_mux_recalced_data[] = {
 
 static struct rockchip_mux_recalced_data rk3308_mux_recalced_data[] = {
 	{
+		/* gpio1b6_sel */
 		.num = 1,
 		.pin = 14,
 		.reg = 0x28,
 		.bit = 12,
 		.mask = 0xf
 	}, {
+		/* gpio1b7_sel */
 		.num = 1,
 		.pin = 15,
 		.reg = 0x2c,
 		.bit = 0,
 		.mask = 0x3
 	}, {
+		/* gpio1c2_sel */
 		.num = 1,
 		.pin = 18,
 		.reg = 0x30,
 		.bit = 4,
 		.mask = 0xf
 	}, {
+		/* gpio1c3_sel */
 		.num = 1,
 		.pin = 19,
 		.reg = 0x30,
 		.bit = 8,
 		.mask = 0xf
 	}, {
+		/* gpio1c4_sel */
 		.num = 1,
 		.pin = 20,
 		.reg = 0x30,
 		.bit = 12,
 		.mask = 0xf
 	}, {
+		/* gpio1c5_sel */
 		.num = 1,
 		.pin = 21,
 		.reg = 0x34,
 		.bit = 0,
 		.mask = 0xf
 	}, {
+		/* gpio1c6_sel */
 		.num = 1,
 		.pin = 22,
 		.reg = 0x34,
 		.bit = 4,
 		.mask = 0xf
 	}, {
+		/* gpio1c7_sel */
 		.num = 1,
 		.pin = 23,
 		.reg = 0x34,
 		.bit = 8,
 		.mask = 0xf
 	}, {
+		/* gpio3b4_sel */
 		.num = 3,
 		.pin = 12,
 		.reg = 0x68,
 		.bit = 8,
 		.mask = 0xf
 	}, {
+		/* gpio3b5_sel */
 		.num = 3,
 		.pin = 13,
 		.reg = 0x68,
 		.bit = 12,
 		.mask = 0xf
 	}, {
+		/* gpio2a2_sel */
 		.num = 2,
 		.pin = 2,
-		.reg = 0x608,
-		.bit = 0,
-		.mask = 0x7
+		.reg = 0x40,
+		.bit = 4,
+		.mask = 0x3
 	}, {
+		/* gpio2a3_sel */
 		.num = 2,
 		.pin = 3,
-		.reg = 0x608,
-		.bit = 4,
-		.mask = 0x7
+		.reg = 0x40,
+		.bit = 6,
+		.mask = 0x3
 	}, {
+		/* gpio2c0_sel */
 		.num = 2,
 		.pin = 16,
-		.reg = 0x610,
-		.bit = 8,
-		.mask = 0x7
+		.reg = 0x50,
+		.bit = 0,
+		.mask = 0x3
 	}, {
+		/* gpio3b2_sel */
 		.num = 3,
 		.pin = 10,
-		.reg = 0x610,
-		.bit = 0,
-		.mask = 0x7
+		.reg = 0x68,
+		.bit = 4,
+		.mask = 0x3
 	}, {
+		/* gpio3b3_sel */
 		.num = 3,
 		.pin = 11,
-		.reg = 0x610,
-		.bit = 4,
-		.mask = 0x7
+		.reg = 0x68,
+		.bit = 6,
+		.mask = 0x3
 	},
 };
 
-- 
2.25.1

