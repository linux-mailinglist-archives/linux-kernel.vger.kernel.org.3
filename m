Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BED5426FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiFHD6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiFHD5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:57:38 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6C824B61C;
        Tue,  7 Jun 2022 18:08:00 -0700 (PDT)
X-QQ-mid: bizesmtp75t1654650379tjnj372u
Received: from localhost.localdomain ( [182.148.15.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 08 Jun 2022 09:06:14 +0800 (CST)
X-QQ-SSF: 01000000000000209000000A0000000
X-QQ-FEAT: 78zNK54033KQhLuSK7j6I1w7EDLGvXYfDxi4XCOlfhXsQByUpReHk1I2tUbsu
        eV8SZ+LwWUUDTRLLCrQf1I1DOkIB8QbBui0v56C7yxyho/OkKMrwM+QV7TCnfbKfrT4bhbk
        fcBahmNefnax2dSkIlXmKTI3jGDH99UQNoC0UKr+vJ1tA/r2ZpF0gjkb1Xnf5bsNn9kdfW7
        3433rk3I9A0Sn4MOqXBmNdBeUx0k+Lo9eDtQ+Tubs8j5EINRXQfK6cTXBwwrh4Uq8ErBMy3
        E8qbLhkWfNE5pYmBi52nnPRiAv3s/XLesZfFoFeRcHqDMEoMU77FlmyNX4NgZdKotY2w==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] pwm: atmel-tcb: use 'unsigned int' instead of 'unsigned'
Date:   Wed,  8 Jun 2022 09:06:07 +0800
Message-Id: <20220608010607.19469-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_XBL,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the 'unsigned' with 'unsigned int' which is more accurate.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/pwm/pwm-atmel-tcb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 3977a0f9d132..d6977e4e71f3 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -35,9 +35,9 @@
 
 struct atmel_tcb_pwm_device {
 	enum pwm_polarity polarity;	/* PWM polarity */
-	unsigned div;			/* PWM clock divider */
-	unsigned duty;			/* PWM duty expressed in clk cycles */
-	unsigned period;		/* PWM period expressed in clk cycles */
+	unsigned int div;			/* PWM clock divider */
+	unsigned int duty;			/* PWM duty expressed in clk cycles */
+	unsigned int period;		/* PWM period expressed in clk cycles */
 };
 
 struct atmel_tcb_channel {
@@ -85,7 +85,7 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm;
-	unsigned cmr;
+	unsigned int cmr;
 	int ret;
 
 	tcbpwm = devm_kzalloc(chip->dev, sizeof(*tcbpwm), GFP_KERNEL);
@@ -150,7 +150,7 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
-	unsigned cmr;
+	unsigned int cmr;
 	enum pwm_polarity polarity = tcbpwm->polarity;
 
 	/*
@@ -295,9 +295,9 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct atmel_tcb_pwm_device *atcbpwm = NULL;
 	int i = 0;
 	int slowclk = 0;
-	unsigned period;
-	unsigned duty;
-	unsigned rate = clk_get_rate(tcbpwmc->clk);
+	unsigned int period;
+	unsigned int duty;
+	unsigned int rate = clk_get_rate(tcbpwmc->clk);
 	unsigned long long min;
 	unsigned long long max;
 
-- 
2.36.1

