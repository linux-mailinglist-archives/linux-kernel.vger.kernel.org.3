Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41D65998C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348174AbiHSJbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347903AbiHSJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:31:03 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D7F23DD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:31:01 -0700 (PDT)
X-QQ-mid: bizesmtp86t1660901192tain063a
Received: from localhost.localdomain ( [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 19 Aug 2022 17:26:30 +0800 (CST)
X-QQ-SSF: 01400000002000D0U000B00A0000000
X-QQ-FEAT: KIY2vMteGsnLesbcnYjO65jCSDMXx38WD8izJS76jGYwSKVCwA35iceBJxy+n
        F03JnHqpKpDl+JOk+nQf9fpPVGDczqT2LwpJaRDpuaKdMrWIOQbkfd2OxU+cohX9hNEexS3
        0QI8oLQUxC1chmMtILtdMBfD6DJrW58+4JDLEY1EFgJk9qKpJZKJmPFV+P+ovZFVW2n2P0W
        aGOrQRRRKAJNgbZpeMJJB1lc4dGfZsAzD3jc1oWa3n5DXOY19cPadqY6yg7DTQcC1xyJAV9
        xHjhrlfuWCDw26mSK5de6fiky0axYAm4Pb6xn2tl5DlN6xMoPsyssjLANwekyLIm0bDtKYl
        R9haxOMkA0/1CXf9fjh2bdjE5vcTis+CVqaCbUSD+ZMWOsmOlcP6MSFHUjzNQ==
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     thierry.reding@gmail.com, heiko@sntech.de
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH v4] pwm: rockchip: Convert to use dev_err_probe()
Date:   Fri, 19 Aug 2022 17:26:27 +0800
Message-Id: <20220819092627.19416-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's fine to call dev_err_probe() in ->probe() when error code is known.
Convert the driver to use dev_err_probe().

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 v4: add the missing dev_err function.
 drivers/pwm/pwm-rockchip.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index f3647b317152..e6ee14c6a159 100644
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
+		dev_err_probe(&pdev->dev, ret, "Can't prepare enable APB clk: %d\n", ret);
 		goto err_clk;
 	}
 
@@ -360,7 +354,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed: %d\n", ret);
 		goto err_pclk;
 	}
 
-- 
2.20.1


