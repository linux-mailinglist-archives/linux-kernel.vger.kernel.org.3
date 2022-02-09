Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4804AEA9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiBIGuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiBIGuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:50:09 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 22:50:08 PST
Received: from qq.com (smtpbg466.qq.com [59.36.132.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D7C05BE0F;
        Tue,  8 Feb 2022 22:50:07 -0800 (PST)
X-QQ-mid: bizesmtp51t1644389278t06ihfgi
Received: from localhost.localdomain (unknown [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 09 Feb 2022 14:47:56 +0800 (CST)
X-QQ-SSF: 01400000002000B0L000B00B0000000
X-QQ-FEAT: Mzskoac49OiRqor/bSHn4umbrQSvw0UKBD4nJJ/lyJz0uP3GIwPADWl5uJjQ1
        HdOtWS9OwKXzU16Sbyo7j8bb9xQjDfVnrQARrOxVFmJJXtSZR2QK8omzJHk16tIDMYBQOfU
        UCYPBlbkepQghmINujg6l1joXb6915+kTo6HJOTLcXg5FedM3PUUqCzn84DJxxvSnXs5jxB
        uJmvz26Y59l0Gc1uJbMZeQ8kYSvYhVNa+V2HgpeBIllaAcpLsM9BwNX5AGXjDM9PLspsR4Q
        9khnLA36wEbbbCeABvJs3NSIIK20XdtqFpLu/C46wKIpwUBK0nsRUHek+gtWcmLBhhXuVgT
        iFUl5NLs7S4YKBJjGo=
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] pwm: vt8500: Rename variable pointing to driver private data
Date:   Wed,  9 Feb 2022 14:47:55 +0800
Message-Id: <20220209064755.7287-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Status quo is that variables of type struct vt8500_chip * are named
"pwm", "chip" or "pc". The two formers are all not optimal because
usually only struct pwm_device * variables are named "pwm" and "chip" is
usually used for variabled of type struct pwm_chip *.

So consistently use the same and non-conflicting name "pc".

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/pwm/pwm-vt8500.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 7170a315535b..fc0a572f7d06 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -235,7 +235,7 @@ MODULE_DEVICE_TABLE(of, vt8500_pwm_dt_ids);
 
 static int vt8500_pwm_probe(struct platform_device *pdev)
 {
-	struct vt8500_chip *chip;
+	struct vt8500_chip *pc;
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
@@ -244,48 +244,48 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
+	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
+	if (pc == NULL)
 		return -ENOMEM;
 
-	chip->chip.dev = &pdev->dev;
-	chip->chip.ops = &vt8500_pwm_ops;
-	chip->chip.npwm = VT8500_NR_PWMS;
+	pc->chip.dev = &pdev->dev;
+	pc->chip.ops = &vt8500_pwm_ops;
+	pc->chip.npwm = VT8500_NR_PWMS;
 
-	chip->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(chip->clk)) {
+	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pc->clk)) {
 		dev_err(&pdev->dev, "clock source not specified\n");
-		return PTR_ERR(chip->clk);
+		return PTR_ERR(pc->clk);
 	}
 
-	chip->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(chip->base))
-		return PTR_ERR(chip->base);
+	pc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pc->base))
+		return PTR_ERR(pc->base);
 
-	ret = clk_prepare(chip->clk);
+	ret = clk_prepare(pc->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to prepare clock\n");
 		return ret;
 	}
 
-	ret = pwmchip_add(&chip->chip);
+	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip\n");
-		clk_unprepare(chip->clk);
+		clk_unprepare(pc->clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, chip);
+	platform_set_drvdata(pdev, pc);
 	return ret;
 }
 
 static int vt8500_pwm_remove(struct platform_device *pdev)
 {
-	struct vt8500_chip *chip = platform_get_drvdata(pdev);
+	struct vt8500_chip *pc = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&chip->chip);
+	pwmchip_remove(&pc->chip);
 
-	clk_unprepare(chip->clk);
+	clk_unprepare(pc->clk);
 
 	return 0;
 }
-- 
2.20.1



