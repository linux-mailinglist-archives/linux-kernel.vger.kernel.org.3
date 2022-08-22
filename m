Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74D59BB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiHVITv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiHVITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:19:49 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6998F1DA72;
        Mon, 22 Aug 2022 01:19:45 -0700 (PDT)
X-QQ-mid: bizesmtp79t1661156333tn1skwkr
Received: from localhost.localdomain ( [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 16:18:52 +0800 (CST)
X-QQ-SSF: 01400000002000D0U000B00A0000000
X-QQ-FEAT: abDNkBO9wxGSSTXraPu2eHWuksMIwlUpD0v3GkNTcQZh7Wdc/Fr0iBTHZKnOE
        NXeDfgC69XIwvzXui9ShjI/mipkDaSqfvKmfaGM4CISezq40clj1tmVOENDzf9j+1mlXo7f
        Qi/ngMCE4t/2piN6qAueBA/fNKLqN1B/wILObQCby95uuG+rs4KL0VBAL6z9urAJCRBP4LZ
        lmD/1RJEDyipWN/5IrJ42lY6+RGmitY1n3M9vd8qTYw5u4LefxeROAmT0GQhi/2qB5th4cp
        XrY4vTzaHSffTYBrJ0LY+1xHef+vQ6p53zD4Vxi71Z5AgnNJwbkVmwW7bvHg63TdaGPiHVd
        QlYaFEJUY78MbAzsygTxNn7+QscQfipg7EqoSO+3klEAD6fB+XR9Vi7CK1VTw==
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     thierry.reding@gmail.com, heiko@sntech.de
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATH v5] pwm: rockchip: Convert to use dev_err_probe()
Date:   Mon, 22 Aug 2022 16:18:48 +0800
Message-Id: <20220822081848.5126-1-zhaoxiao@uniontech.com>
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
 v5: delete the redundant ret and %d.
 drivers/pwm/pwm-rockchip.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index f3647b317152..a5af859217c1 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -328,22 +328,16 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	else
 		pc->pclk = pc->clk;
 
-	if (IS_ERR(pc->pclk)) {
-		ret = PTR_ERR(pc->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(pc->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pc->pclk), "Can't get APB clk\n");
 
 	ret = clk_prepare_enable(pc->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Can't prepare enable PWM clk\n");
 
 	ret = clk_prepare_enable(pc->pclk);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare enable APB clk: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "Can't prepare enable APB clk\n");
 		goto err_clk;
 	}
 
@@ -360,7 +354,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 		goto err_pclk;
 	}
 
-- 
2.20.1

