Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF6E4B1CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347608AbiBKCiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:38:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347581AbiBKCiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:38:20 -0500
X-Greylist: delayed 61944 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 18:38:19 PST
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6885D55AD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:38:19 -0800 (PST)
X-QQ-mid: bizesmtp35t1644547068t7uhb17w
Received: from localhost.localdomain (unknown [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Feb 2022 10:37:46 +0800 (CST)
X-QQ-SSF: 01400000000000B0L000000A0000000
X-QQ-FEAT: ssdqv2V8ieI4r0S/p/YIMoSud1356wu151e25RfpCyjzft2pptpo8AIv5mrI4
        Sz02K8iYTa8le6LOEpsZDZ4D68OqmW1R+ji4QFcTTcMOwgyou/aJtEJdMYQkBvNuIEZEfQ4
        JBH8JtMoiX3Ty12FxOMHQoV4I/cpNxYCvFfr5lCrhGYHr2QBSBxRTW7pXNd/1OlXRTXLifR
        DOmy8sC8Bt/lwoFA1FHSULOrmbWX/cQRiG5hLK1UFMvwv3UuT3IdHAxMRcvG0Ux0vulkGDx
        NvcrA45edZnwni8P50Eto5c4WKfZaDkWNSrJJGSrxM5qVcDgEv7wqWVUj1hQ6srF2k3MI5C
        MXucQWSbw/f7uz/6OAh8OZJBdkp4w==
X-QQ-GoodBg: 1
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH v2] pwm: vt8500: Rename variable pointing to driver private data
Date:   Fri, 11 Feb 2022 10:37:41 +0800
Message-Id: <20220211023741.24061-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Status quo is that variables of type struct vt8500_chip * are named
"vt8500", "chip". Because usually only struct pwm_device * variables
are named "pwm" and "chip" is usually used for variabled of type
struct pwm_chip *.

So consistently use the same and non-conflicting name "vt8500".

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 v2: Rename the "chip" to "vt8500" for variable of type struct vt8500_chip *.
 drivers/pwm/pwm-vt8500.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 7170a315535b..f1ff9940b37c 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -235,7 +235,7 @@ MODULE_DEVICE_TABLE(of, vt8500_pwm_dt_ids);
 
 static int vt8500_pwm_probe(struct platform_device *pdev)
 {
-	struct vt8500_chip *chip;
+	struct vt8500_chip *vt8500;
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
@@ -244,48 +244,48 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
+	vt8500 = devm_kzalloc(&pdev->dev, sizeof(*vt8500), GFP_KERNEL);
+	if (vt8500 == NULL)
 		return -ENOMEM;
 
-	chip->chip.dev = &pdev->dev;
-	chip->chip.ops = &vt8500_pwm_ops;
-	chip->chip.npwm = VT8500_NR_PWMS;
+	vt8500->chip.dev = &pdev->dev;
+	vt8500->chip.ops = &vt8500_pwm_ops;
+	vt8500->chip.npwm = VT8500_NR_PWMS;
 
-	chip->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(chip->clk)) {
+	vt8500->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(vt8500->clk)) {
 		dev_err(&pdev->dev, "clock source not specified\n");
-		return PTR_ERR(chip->clk);
+		return PTR_ERR(vt8500->clk);
 	}
 
-	chip->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(chip->base))
-		return PTR_ERR(chip->base);
+	vt8500->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(vt8500->base))
+		return PTR_ERR(vt8500->base);
 
-	ret = clk_prepare(chip->clk);
+	ret = clk_prepare(vt8500->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to prepare clock\n");
 		return ret;
 	}
 
-	ret = pwmchip_add(&chip->chip);
+	ret = pwmchip_add(&vt8500->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip\n");
-		clk_unprepare(chip->clk);
+		clk_unprepare(vt8500->clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, chip);
+	platform_set_drvdata(pdev, vt8500);
 	return ret;
 }
 
 static int vt8500_pwm_remove(struct platform_device *pdev)
 {
-	struct vt8500_chip *chip = platform_get_drvdata(pdev);
+	struct vt8500_chip *vt8500 = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&chip->chip);
+	pwmchip_remove(&vt8500->chip);
 
-	clk_unprepare(chip->clk);
+	clk_unprepare(vt8500->clk);
 
 	return 0;
 }
-- 
2.20.1



