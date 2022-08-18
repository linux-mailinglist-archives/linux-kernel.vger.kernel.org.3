Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3554597F96
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbiHRHzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243928AbiHRHzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:55:47 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4D35A89B;
        Thu, 18 Aug 2022 00:55:45 -0700 (PDT)
X-QQ-mid: bizesmtp84t1660809306tfbj0d7x
Received: from localhost.localdomain ( [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 18 Aug 2022 15:55:04 +0800 (CST)
X-QQ-SSF: 01400000002000D0U000B00A0000000
X-QQ-FEAT: swyrzWPvyR126b+3X45NGrMtYKOIt069w4aDNOSi6iisZMf2/tX68YoUumWdU
        dYtu6KOzDzJp5DTHprLCLdTDk/HozhmpvMBqO50ftUSwnZ1sEFsZzUY+9P+BnMWGgmIRf0J
        Pi+oXlJurIxQ4+Tp0mNse+USKqXdq/BeQ/c5FoaIOncNBctTd6orLUGUU7UONotXwlUmi/X
        5b3blDEg4Qk0h+3VS7CmGAn/LfYKvk9f4fLpioRYrxAfe+Yebwkfor6t7znjPu0hSN/NyGA
        Leh0PteLePdOFDYWTU0d0NK4S2i7QyB12JHw7Qgks7Lidg1ps0FZfxlH9yMMsvzOzGsfpwk
        m/yZizGAVWtsrZo0rlk683Cd6cpHIqk4mulVFef0SvOq99CblVLwx8k/X47uw==
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     thierry.reding@gmail.com, heiko@sntech.de
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH v2] pwm: rockchip: Convert to use dev_err_probe()
Date:   Thu, 18 Aug 2022 15:55:03 +0800
Message-Id: <20220818075503.18442-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's fine to call dev_err_probe() in ->probe() when error code is known.
Convert the driver to use dev_err_probe().

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 v2: remove the %d in the message.

 drivers/pwm/pwm-rockchip.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index f3647b317152..c6e088c1a6bf 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -330,16 +330,12 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 	if (IS_ERR(pc->pclk)) {
 		ret = PTR_ERR(pc->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
-		return ret;
+		return dev_err_probe(&pdev->dev, ret, "Can't get APB clk\n");
 	}
 
 	ret = clk_prepare_enable(pc->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		dev_err_probe(&pdev->dev, ret, "Can't prepare enable PWM clk\n");
 
 	ret = clk_prepare_enable(pc->pclk);
 	if (ret) {
-- 
2.20.1

