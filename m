Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF814B52AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354868AbiBNOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:04:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354856AbiBNODz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:03:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E21B4A3C3;
        Mon, 14 Feb 2022 06:03:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6C8D31F437D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644847427;
        bh=wFNgkqGiONoneW7J7GAtmcWU3v7pj9r5c0V0Os6wFU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUG+pRD5LFzg0JNUMPwO8D3H1M9GSWqUTPtDByjaPj95ISZWa4Pvs4Fd0wkQWzBcF
         dgJ9fdDzLdJWCXfJpfvfH2uipWAipJtTSKdsA1t6BXNN57RCoE1+ixwBUXhBtR89Bx
         d6hz0MguCsVR07zG1aERD8kW7FKTrABhs41a7UPhKe+3IdEkWw74KtSXTsuK3Dqsfr
         HLz0KaN1BN25jpW0Wz2QihHbm2uHudnjZ45SCZX7g3TzIcsGBI+M93VuT7/Q+HMv70
         YV2qBURT/u4kLKpL9GGXBcF5PW6mL1hGoRoxkh3OItUGA2hF9Kzvwz2L+ENRnV/dKo
         i2hKFQGJ7l7Jg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 3/3] pwm: pwm-mediatek: Beautify error messages text
Date:   Mon, 14 Feb 2022 15:03:39 +0100
Message-Id: <20220214140339.112500-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220214140339.112500-1-angelogioacchino.delregno@collabora.com>
References: <20220214140339.112500-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a cherry-on-top cleanup, make error messages clearer to read
by changing instances of "clock: XXXX failed" to a more readable
"Failed to get XXXX clock". Also add "of" to unsupported period
error.

This is purely a cosmetic change; no "real" functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pwm/pwm-mediatek.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 6b39f3d69e41..568b13a48717 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -146,7 +146,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
 		pwm_mediatek_clk_disable(chip, pwm);
-		dev_err(chip->dev, "period %d not supported\n", period_ns);
+		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
 		return -EINVAL;
 	}
 
@@ -229,12 +229,12 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	pc->clk_top = devm_clk_get(&pdev->dev, "top");
 	if (IS_ERR(pc->clk_top))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_top),
-				     "clock: top failed\n");
+				     "Failed to get top clock\n");
 
 	pc->clk_main = devm_clk_get(&pdev->dev, "main");
 	if (IS_ERR(pc->clk_main))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_main),
-				     "clock: main failed\n");
+				     "Failed to get main clock\n");
 
 	for (i = 0; i < pc->soc->num_pwms; i++) {
 		char name[8];
@@ -244,7 +244,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 		pc->clk_pwms[i] = devm_clk_get(&pdev->dev, name);
 		if (IS_ERR(pc->clk_pwms[i]))
 			return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_pwms[i]),
-					     "clock: %s failed\n", name);
+					     "Failed to get %s clock\n", name);
 	}
 
 	pc->chip.dev = &pdev->dev;
-- 
2.33.1

