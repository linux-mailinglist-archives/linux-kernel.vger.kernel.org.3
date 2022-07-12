Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E97A57166F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiGLKBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiGLKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:01:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F0FAAB18
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:01:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z12so10426266wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZyJv2zFUmg4QquL9UqGaB1TK6MGzGz+Frm2iCfAVgA=;
        b=WziFWnCRBPfyZ/tqPo+m7FiZ9a47XCjVsrsEUrDNxz/yQvcVeCD05OvbPwZYfAJEVx
         i60KaTPD5SOEhQ3J8wCAzMcJ3HiOW+nvpUhqkFyAOEYRfiF6MMymR/ZiwjJJvQlk7x+j
         dFQQdA631rvmACdDJZysY0ElKhHfu+Dt6aCwayb9mCBBFy2tQjnIlhUtzlTciL7/6f6S
         17i3nhbfswF5P4hZfCdYPoFQuLubQ6a0GP3viwsieVlbphmZ6cunXCzFOoaQZ8gfOilB
         j+1SDtaaqtu/7vogKheRhu98kYcN/m+IUbZ9ANkhQRN+uKxn3iy+2U1vmyAVJEk95dON
         MdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZyJv2zFUmg4QquL9UqGaB1TK6MGzGz+Frm2iCfAVgA=;
        b=ErRW/Xh7MVmzxU+tNwjSEw9w2AkQWym2NnctysVCxq7glRm6MelJ/Wyti+Z4+4drMQ
         wTg3RkT5Nx85rK7ChIks4hKmBqpGeHHXHlnxpQiQOeSM2N6TOugayHpso4Q+ZAaA0bl1
         wyCZUMMWwhRfOZ1cw735lEXIylDRzIkoynU7dO6jTY0zlF3XV4Om+pLGIdAyFzjW/HMy
         n+HAd9OQ9SJdJ4jvfPNh/WGOv0dlGLTunzZ1ztZNvZ594MTQ/FROJPEG0BqJn/I82zOf
         EwR+Ko2LkJXNQ4oOdy/LAOsMOaeHOa2iCDMWo6rGhKAE7TwACO5PbOP2OfnKnxSZHFx2
         i59g==
X-Gm-Message-State: AJIora+7PaPmpm5rO860M4ztrzTHZ8RtW98A0xaAA6W70i8FIozB/nZm
        YR+tg0FhrbhOuW5V5C99tRVmZg==
X-Google-Smtp-Source: AGRyM1vb9XGZw20RRG3ffTCm0hF13Hml13jWLnufuFljUi+alp3nE82x3/d9CwYKg/qcVhy+KcNTcg==
X-Received: by 2002:a5d:4fd1:0:b0:21d:64c6:8b0f with SMTP id h17-20020a5d4fd1000000b0021d64c68b0fmr21583322wrw.250.1657620080164;
        Tue, 12 Jul 2022 03:01:20 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id u9-20020a7bc049000000b0039747cf8354sm8895314wmc.39.2022.07.12.03.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:01:19 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 5/7] pwm: dwc: add timer clock
Date:   Tue, 12 Jul 2022 11:01:11 +0100
Message-Id: <20220712100113.569042-6-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712100113.569042-1-ben.dooks@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a configurable clock base rate for the pwm as when
being built for non-PCI the block may be sourced from
an internal clock.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 235cb730c888..aa0486b89bdd 100644
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
@@ -35,7 +36,12 @@
 #define DWC_TIMERS_COMP_VERSION	0xac
 
 #define DWC_TIMERS_TOTAL	8
+
+#ifndef CONFIG_OF
 #define DWC_CLK_PERIOD_NS	10
+#else
+#define DWC_CLK_PERIOD_NS	dwc->clk_ns
+#endif
 
 /* Timer Control Register */
 #define DWC_TIM_CTRL_EN		BIT(0)
@@ -54,6 +60,8 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
+	struct clk *clk;
+	unsigned int clk_ns;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
@@ -336,6 +344,14 @@ static int dwc_pwm_plat_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(dwc->base),
 				     "failed to map IO\n");
 
+	dwc->clk = devm_clk_get(dev, "timer");
+	if (IS_ERR(dwc->clk))
+		return dev_err_probe(dev, PTR_ERR(dwc->clk),
+				     "failed to get timer clock\n");
+
+	clk_prepare_enable(dwc->clk);
+	dwc->clk_ns = 1000000000 /clk_get_rate(dwc->clk);
+
 	ret = pwmchip_add(&dwc->chip);
 	if (ret)
 		return ret;
@@ -347,6 +363,7 @@ static int dwc_pwm_plat_remove(struct platform_device *pdev)
 {
 	struct dwc_pwm *dwc = platform_get_drvdata(pdev);
 
+	clk_disable_unprepare(dwc->clk);
 	pwmchip_remove(&dwc->chip);
 	return 0;
 }
-- 
2.35.1

