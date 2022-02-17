Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD24BA0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbiBQNTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:19:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiBQNTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:19:03 -0500
Received: from unicorn.mansr.com (unicorn.mansr.com [IPv6:2001:8b0:ca0d:8d8e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747852AE727
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:18:47 -0800 (PST)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 84F8A15360;
        Thu, 17 Feb 2022 13:18:45 +0000 (GMT)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 4EB30219C0A; Thu, 17 Feb 2022 13:18:45 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: sunxi: do not print error message for EPROBE_DEFER
Date:   Thu, 17 Feb 2022 13:17:37 +0000
Message-Id: <20220217131737.10931-1-mans@mansr.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid printing an error message if getting a regulator fails with
EPROBE_DEFER.  This can happen if, for example, a regulator supplying
one of the main banks is controlled by a PL pin.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index e42a3a0005a7..534c42ee0718 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -777,11 +777,10 @@ static int sunxi_pmx_request(struct pinctrl_dev *pctldev, unsigned offset)
 
 	snprintf(supply, sizeof(supply), "vcc-p%c", 'a' + bank);
 	reg = regulator_get(pctl->dev, supply);
-	if (IS_ERR(reg)) {
-		dev_err(pctl->dev, "Couldn't get bank P%c regulator\n",
-			'A' + bank);
-		return PTR_ERR(reg);
-	}
+	if (IS_ERR(reg))
+		return dev_err_probe(pctl->dev, PTR_ERR(reg),
+				     "Couldn't get bank P%c regulator\n",
+				     'A' + bank);
 
 	ret = regulator_enable(reg);
 	if (ret) {
-- 
2.35.1

