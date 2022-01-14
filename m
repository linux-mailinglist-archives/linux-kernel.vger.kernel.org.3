Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10E848F186
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 21:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbiANUiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 15:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiANUiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 15:38:00 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5398DC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 12:38:00 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id e3so31208744lfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 12:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUGzTTyriTXZ8n39Zh2yraY+YbTAIxFn2aNWIIs8oNQ=;
        b=lHnbPLnlJnWZf4BOMgmL2WqcLhiNaGPR/dRyJ+W4VokrCg0QyE0qjyGQzu70znnfRN
         JgnFwglHtOeXECzW+ZZgqy0HEoSeFG5lKatmVX0JLcK5El8sDxc/Ct8e5poffUjcdpcE
         DMt1jsK2b2xhzdqlUCuoCjI69QqxErIeO3636yS7B7BiWp56sJzMi39LWt2YiSAgPyfQ
         W/J8cKN7U2ztZfhK34tF9fzmwv7A2tHK3bY77Mp+lgO3GhAb6TM3w9H79V+Rjf0Mfc5z
         ocNlQgM9I0QO7kTjTNPSGLMy/pb7iz77FLe9OZ5JsnfCR1SEs9GYj4XY/xnRWn60RcHB
         gHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUGzTTyriTXZ8n39Zh2yraY+YbTAIxFn2aNWIIs8oNQ=;
        b=3t0Io/jRkdEsZj2Dur/8SGr7bbqttDqqWcCQ4cgtmdX1ST/+7rfuRM3e8GXZkUB0wc
         7KqorlBKLTsAzMRR6o9u7cQSBc018p4ZM6Q2j8AngpPr1bH7KxSrWB05UJfM7mgL271Y
         C500KqhbqIGrS/yAuUtsR2OdKUNIK4p7sjUt5M2Vw6rqBwR33nEx3QDJZ7I7bY5GV5gy
         MByTGzvbRLoMBB4auGKg12IPt+C5jodSUae7mT8jIwslq/T0XuEswCgoe4ottX6w9qlR
         04bQatbYv0MBcD91IOBnc5YBLGgJYKOmCbci98U2/YGhNZab9V49XG4DGzvb9FlkGTIx
         u+6Q==
X-Gm-Message-State: AOAM530j5dauWCnlf6FZU9S5Du+k4yy5/i5PHxhLXs2hrRXgTTmd/lH/
        URpeEhVZADARbivvk+zOcDm2Qw==
X-Google-Smtp-Source: ABdhPJyeB8FDojDbTY19RElb4UtHYMamhY3DprjLgedvmvQQCZDyifUK3I/wm9pcJvBq8VX6y1Z4jA==
X-Received: by 2002:a05:6512:3044:: with SMTP id b4mr1614836lfb.7.1642192678674;
        Fri, 14 Jan 2022 12:37:58 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id c3sm371492lff.261.2022.01.14.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 12:37:58 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: samsung: Remove EINT handler for Exynos850 ALIVE and CMGP gpios
Date:   Fri, 14 Jan 2022 22:37:57 +0200
Message-Id: <20220114203757.4860-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ALIVE and GPIO_CMGP blocks in Exynos850 SoC don't have EINT
capabilities (like EINT_SVC register), and there are no corresponding
interrupts wired to GIC. Instead those blocks have wake-up interrupts
for each pin. The ".eint_gpio_init" callbacks were specified by mistake
for these blocks, when porting pinctrl code from downstream kernel. That
leads to error messages like this:

    samsung-pinctrl 11850000.pinctrl: irq number not available

Remove ".eint_gpio_init" for pinctrl_alive and pinctrl_gpmc to fix this
error. This change doesn't affect proper interrupt handling for related
pins, as all those pins are handled in ".eint_wkup_init".

Fixes: cdd3d945dcec ("pinctrl: samsung: Add Exynos850 SoC specific data")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index 2e490e7696f4..4102ce955bd7 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -585,13 +585,11 @@ static const struct samsung_pin_ctrl exynos850_pin_ctrl[] __initconst = {
 		/* pin-controller instance 0 ALIVE data */
 		.pin_banks	= exynos850_pin_banks0,
 		.nr_banks	= ARRAY_SIZE(exynos850_pin_banks0),
-		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
 	}, {
 		/* pin-controller instance 1 CMGP data */
 		.pin_banks	= exynos850_pin_banks1,
 		.nr_banks	= ARRAY_SIZE(exynos850_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
 	}, {
 		/* pin-controller instance 2 AUD data */
-- 
2.30.2

