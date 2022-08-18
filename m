Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D686597F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiHRHXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbiHRHXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:23:35 -0400
X-Greylist: delayed 91376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 00:23:31 PDT
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F461DAB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:23:30 -0700 (PDT)
X-QQ-mid: bizesmtp90t1660807358thkgk558
Received: from localhost.localdomain ( [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 18 Aug 2022 15:22:36 +0800 (CST)
X-QQ-SSF: 01400000002000D0U000B00A0000000
X-QQ-FEAT: eCJvJF4ptHBiBmR9azarm3lgcJ4dN65tE+tjAFsTWkhYPsqr/69XgUGBD+grm
        yR7HtMUrVdsfxz2r73Dl3qSc+ZIzIxF7xdtYffxYAUwW+v1GB93w9ae0izDtxWhoGpHfRgI
        yyjhBmJb1PyglhGtlONaCLJEEKFFVDixfKO9hMEA9KNsIXHvOqiY9uwtJLukLTdD1Y2vkV2
        u1bTHEohr7O9wO9llyQiSb/7nGsYSLa0o0JfFa8AiGyzrb8YLM3I49D+Imkehu68pVryty6
        YGrvsfsXi8k0kxfekvlptbZDoO0riJcwg+IAHsYDVdMUeGn1OAi/xFvlFOk50fE32l+wthU
        wtxq7ZE5iTdFNjs0z88xZpSMOR9V8WEj4wwUS2dLLIuRztK1aXx9if4iNPFew==
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     thierry.reding@gmail.com, narmstrong@baylibre.com,
        khilman@baylibre.com
Cc:     u.kleine-koenig@pengutronix.de, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] pwm: meson: Simplify probe function with dev_err_probe()
Date:   Thu, 18 Aug 2022 15:22:34 +0800
Message-Id: <20220818072234.9640-1-zhaoxiao@uniontech.com>
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

Switch to dev_err_probe() to remove all dev_err() -> return repeated
patterns, simplifying and shortening the probe function.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/pwm/pwm-meson.c | 53 ++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 57112f438c6d..43ce8d9a33d2 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -126,20 +126,16 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	if (channel->clk_parent) {
 		err = clk_set_parent(channel->clk, channel->clk_parent);
-		if (err < 0) {
-			dev_err(dev, "failed to set parent %s for %s: %d\n",
+		if (err < 0)
+			return dev_err_probe(dev, err, "failed to set parent %s for %s\n",
 				__clk_get_name(channel->clk_parent),
-				__clk_get_name(channel->clk), err);
-			return err;
-		}
+				__clk_get_name(channel->clk));
 	}
 
 	err = clk_prepare_enable(channel->clk);
-	if (err < 0) {
-		dev_err(dev, "failed to enable clock %s: %d\n",
-			__clk_get_name(channel->clk), err);
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to enable clock %s\n",
+			__clk_get_name(channel->clk));
 
 	return 0;
 }
@@ -166,24 +162,18 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		duty = period - duty;
 
 	fin_freq = clk_get_rate(channel->clk);
-	if (fin_freq == 0) {
-		dev_err(meson->chip.dev, "invalid source clock frequency\n");
-		return -EINVAL;
-	}
+	if (fin_freq == 0)
+		return dev_err_probe(meson->chip.dev, -EINVAL, "invalid source clock frequency\n");
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
 
 	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
-	if (pre_div > MISC_CLK_DIV_MASK) {
-		dev_err(meson->chip.dev, "unable to get period pre_div\n");
-		return -EINVAL;
-	}
+	if (pre_div > MISC_CLK_DIV_MASK)
+		return dev_err_probe(meson->chip.dev, -EINVAL, "unable to get period pre_div\n");
 
 	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
-	if (cnt > 0xffff) {
-		dev_err(meson->chip.dev, "unable to get period cnt\n");
-		return -EINVAL;
-	}
+	if (cnt > 0xffff)
+		return dev_err_probe(meson->chip.dev, -EINVAL, "unable to get period cnt\n");
 
 	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
 		pre_div, cnt);
@@ -200,10 +190,8 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		/* Then check is we can have the duty with the same pre_div */
 		duty_cnt = div64_u64(fin_freq * (u64)duty,
 				     NSEC_PER_SEC * (pre_div + 1));
-		if (duty_cnt > 0xffff) {
-			dev_err(meson->chip.dev, "unable to get duty cycle\n");
-			return -EINVAL;
-		}
+		if (duty_cnt > 0xffff)
+			return dev_err_probe(meson->chip.dev, -EINVAL, "unable to get duty cycle\n");
 
 		dev_dbg(meson->chip.dev, "duty=%u pre_div=%u duty_cnt=%u\n",
 			duty, pre_div, duty_cnt);
@@ -509,11 +497,8 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		channel->mux.hw.init = &init;
 
 		channel->clk = devm_clk_register(dev, &channel->mux.hw);
-		if (IS_ERR(channel->clk)) {
-			err = PTR_ERR(channel->clk);
-			dev_err(dev, "failed to register %s: %d\n", name, err);
-			return err;
-		}
+		if (IS_ERR(channel->clk))
+			return dev_err_probe(dev, PTR_ERR(channel->clk), "failed to register %s\n", name);
 
 		snprintf(name, sizeof(name), "clkin%u", i);
 
@@ -550,10 +535,8 @@ static int meson_pwm_probe(struct platform_device *pdev)
 		return err;
 
 	err = devm_pwmchip_add(&pdev->dev, &meson->chip);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", err);
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(&pdev->dev, err, "failed to register PWM chip\n");
 
 	return 0;
 }
-- 
2.20.1

