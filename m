Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5B4B804B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbiBPFdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:33:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBPFdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:33:31 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7DF9DD71
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:33:18 -0800 (PST)
X-QQ-mid: bizesmtp47t1644989585t4nrygss
Received: from localhost.localdomain (unknown [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 16 Feb 2022 13:33:04 +0800 (CST)
X-QQ-SSF: 01400000002000B0L000B00A0000000
X-QQ-FEAT: uE/0zJO4PKhyiCZI8PSclB0vhfQ0ySIMiwHanVescs2Nt8Jexk1wVJm1RK8MP
        W7KMd5giGhHNLpVTJLy8piHAU4dbOK0yyDOpOGiyxH0acaKrpEVW89Gfd2v9hSVwprNJ3ui
        YjmlIXgj3AQ11XOmQMKD0yGACsFZQ1z5LrtPl3RWbWyG2GQ8rVRlbSaszQLRy4JlJ0n4P5p
        sNaasX5qZPwNRyA3+bxx7bL4njFcBBnPKkn5IWAfpcNCVEf6rXZrRfBkQZYTzCsqYWQXXtF
        JVU/7Zqz6SY03ZPLVjBJzyIxrIB1A1Zx0VvdFVEOW0JNFlQ+7XtJ5I/i9041nDJq5TvcNkW
        av4AVkx1y9esNw0TRo=
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     dmitry.torokhov@gmail.com
Cc:     krzysztof.kozlowski@canonical.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] input: max77693-haptic: Make use of the helper function dev_err_probe()
Date:   Wed, 16 Feb 2022 13:33:02 +0800
Message-Id: <20220216053302.20190-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_pwm_get() can return -EPROBE_DEFER if the pwm regulator is not
ready yet. Use dev_err_probe() for pwm regulator resources
to indicate the deferral reason when waiting for the
resource to come up.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/input/misc/max77693-haptic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 4369d3c04d38..787ea6d0d64d 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -325,11 +325,9 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 
 	/* Get pwm and regulatot for haptic device */
 	haptic->pwm_dev = devm_pwm_get(&pdev->dev, NULL);
-	if (IS_ERR(haptic->pwm_dev)) {
-		dev_err(&pdev->dev, "failed to get pwm device\n");
-		return PTR_ERR(haptic->pwm_dev);
-	}
-
+	if (IS_ERR(haptic->pwm_dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(haptic->pwm_dev),
+				"failed to get pwm device\n");
 	/*
 	 * FIXME: pwm_apply_args() should be removed when switching to the
 	 * atomic PWM API.
-- 
2.20.1



