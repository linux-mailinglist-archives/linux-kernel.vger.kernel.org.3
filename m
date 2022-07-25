Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A99580668
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiGYVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbiGYVWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:22:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497992409B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:22:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h8so17683773wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLJDCEZOSO09uHC0EIl0ioxzdsPrI8cGXE/RKjzgT00=;
        b=iFluN75da0EkdFy+pq5t7KY/FRp1rsIvnbYBtoZ39ZhwRcSVL9LrUKeKcdRDEPqG4x
         ibqwXnDbk9bK3rKV5y6RRa3W4+BdIZcPivdjm5oBA/PFYZI3696ObVEp64Kuj7zwrKix
         823ZvpJ1R96M5czPGp6ZRufs47Vp775IZZWwr1QD7BZUh8AmOYmRAFbMW0sj3SLXnGB5
         3ebIqnkZrKIaBmWpDB3L5c9Q81XlnKQbnGwdqwVWmlEbMumJ0Vda1eITFQBm+33bTVZL
         s/r9UymS+lbx34KquXYJhwC5+pKh5MIJI4f0tneY+GIWk8Hc7ThzpDFMjtpe6M6COL/n
         K6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLJDCEZOSO09uHC0EIl0ioxzdsPrI8cGXE/RKjzgT00=;
        b=tlRH3qFEHm3H9Q1M+IFBA9Vvwcc5M0FgwqRpbS4mACnzEAhSzwnzMojKSS0dS4aTna
         msJEkFXONSQSkM9hL4AblJAmpvMhnpDsVmjcM/sodgxNmu8G+bdtjTp3OPsyGHENOnul
         Y0tI05ois1iotuOi5uVM+lrJAD7E6Bi1p0xzAzFGLz57lkPJAfbJJh6qPD8+m+Jfj3xz
         r+PDWL2HLdHMwDcF/c5V45pbmzobRQ20l6BQ4IaBML2WeSjvjj92qDIjKXrq3/0NiwrA
         qoVA+fc5jFxlqIH+4tGGBpasoG2pditMmi70Nt4Zmp4H0gVX3casfEPWz3V9Nrop/wPU
         N4Cw==
X-Gm-Message-State: AJIora8h/ht95DqEt0V9CdJAjA/nFhS1o7Y47HPNJ1dTr65fnE4nyV1t
        870F0TBU9fjjFV5X1rezb4MEug==
X-Google-Smtp-Source: AGRyM1t1yf5dz9S4EMhX506LJqGUnXc4ZIZvwcpFX6LNG9OL+S18HR2BiGWeuX+uAo8QtJ9tTUWuCg==
X-Received: by 2002:adf:a51a:0:b0:21d:86b9:f41e with SMTP id i26-20020adfa51a000000b0021d86b9f41emr8756930wrb.217.1658784130418;
        Mon, 25 Jul 2022 14:22:10 -0700 (PDT)
Received: from localhost.localdomain (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600011cd00b0021d6924b777sm12656348wrx.115.2022.07.25.14.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:22:10 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [[PATCH v2] 7/9] pwm: dwc: add timer clock
Date:   Mon, 25 Jul 2022 22:21:38 +0100
Message-Id: <20220725212140.741644-7-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725212140.741644-1-ben.dooks@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a configurable clock base rate for the pwm as when being built
for non-PCI the block may be sourced from an internal clock.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
--
v2:
  - removed the ifdef and merged the other clock patch in here
---
 drivers/pwm/pwm-dwc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 235cb730c888..9067f32869f8 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
@@ -35,7 +36,6 @@
 #define DWC_TIMERS_COMP_VERSION	0xac
 
 #define DWC_TIMERS_TOTAL	8
-#define DWC_CLK_PERIOD_NS	10
 
 /* Timer Control Register */
 #define DWC_TIM_CTRL_EN		BIT(0)
@@ -54,6 +54,8 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
+	struct clk *clk;
+	unsigned int clk_ns;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
@@ -96,13 +98,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * periods and check are the result within HW limits between 1 and
 	 * 2^32 periods.
 	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
+	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	low = tmp - 1;
 
 	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    DWC_CLK_PERIOD_NS);
+				    dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	high = tmp - 1;
@@ -177,12 +179,12 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
 	duty += 1;
-	duty *= DWC_CLK_PERIOD_NS;
+	duty *= dwc->clk_ns;
 	state->duty_cycle = duty;
 
 	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 	period += 1;
-	period *= DWC_CLK_PERIOD_NS;
+	period *= dwc->clk_ns;
 	period += duty;
 	state->period = period;
 
@@ -205,6 +207,7 @@ static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	if (!dwc)
 		return NULL;
 
+	dwc->clk_ns = 10;
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
@@ -336,6 +339,14 @@ static int dwc_pwm_plat_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(dwc->base),
 				     "failed to map IO\n");
 
+	dwc->clk = devm_clk_get(dev, "timer");
+	if (IS_ERR(dwc->clk))
+		return dev_err_probe(dev, PTR_ERR(dwc->clk),
+				     "failed to get timer clock\n");
+
+	clk_prepare_enable(dwc->clk);
+	dwc->clk_ns = 1000000000 / clk_get_rate(dwc->clk);
+
 	ret = pwmchip_add(&dwc->chip);
 	if (ret)
 		return ret;
@@ -347,6 +358,7 @@ static int dwc_pwm_plat_remove(struct platform_device *pdev)
 {
 	struct dwc_pwm *dwc = platform_get_drvdata(pdev);
 
+	clk_disable_unprepare(dwc->clk);
 	pwmchip_remove(&dwc->chip);
 	return 0;
 }
-- 
2.35.1

