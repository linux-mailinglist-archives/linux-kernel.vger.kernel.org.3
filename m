Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7004B8058
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbiBPFrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:47:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344669AbiBPFrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:47:16 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7BEEA744
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:47:02 -0800 (PST)
X-QQ-mid: bizesmtp69t1644990406twzmpbu1
Received: from localhost.localdomain (unknown [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 16 Feb 2022 13:46:45 +0800 (CST)
X-QQ-SSF: 01400000002000B0L000B00A0000000
X-QQ-FEAT: ufm+TBkikDO1VZy/15PSXYMTP/JwUeYpZvePpZiDrnel/O2Z3RiU8kZYgLbgI
        qf0l8KcYiQQerIVQaI6RKOZaI7QxizFji90ExM6tF9FuUieGV9jgmRxLM7eRVqsynxievBF
        hz3Fa9wkkN8JUCuG2lqavc/CdPZO+h4i/yBzKT1iE8b47xeA4T96spFsnwppaR1yldekV01
        NyBJWzXUdZfOxpYrVo5iluSuZAfB7nSLTHKhWPdFaAhj2wzAEsQhRZznv0DOim1HA0MJZ6M
        bP+G2UEWXorBFUu/p2j3BzNQHuNfqpvVqILKRXW+J7DP8Pud/gyUkD0nQMOH4oEhcQ0LOPs
        4Y83nfmU3BTLWLdlxK+LTtotdHIlL86KZ4bFACP
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     dmitry.torokhov@gmail.com
Cc:     support.opensource@diasemi.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] input: da7280: Make use of the helper function dev_err_probe()
Date:   Wed, 16 Feb 2022 13:46:43 +0800
Message-Id: <20220216054643.21829-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
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
 drivers/input/misc/da7280.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
index b08610d6e575..16b364a4ef5e 100644
--- a/drivers/input/misc/da7280.c
+++ b/drivers/input/misc/da7280.c
@@ -1165,12 +1165,9 @@ static int da7280_probe(struct i2c_client *client,
 
 	if (haptics->const_op_mode == DA7280_PWM_MODE) {
 		haptics->pwm_dev = devm_pwm_get(dev, NULL);
-		error = PTR_ERR_OR_ZERO(haptics->pwm_dev);
-		if (error) {
-			if (error != -EPROBE_DEFER)
-				dev_err(dev, "Unable to request PWM: %d\n",
-					error);
-			return error;
+		if (IS_ERR(haptics->pwm_dev))
+			return dev_err_probe(dev, PTR_ERR(haptics->pwm_dev),
+					"Unable to request PWM\n");
 		}
 
 		/* Sync up PWM state and ensure it is off. */
-- 
2.20.1



