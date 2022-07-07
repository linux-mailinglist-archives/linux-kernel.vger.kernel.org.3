Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F3569F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiGGKNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiGGKNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:13:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45CA186CA;
        Thu,  7 Jul 2022 03:13:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d2so31612633ejy.1;
        Thu, 07 Jul 2022 03:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYMK3ln+pSNgbS7KOrXcaQql59e3lfO5o9Vh/Disa6M=;
        b=PkzgqtL+vZLBFMzGyIXyV4k2GfwuU0yGbZQKU0a/i7SaSARX5OiimigD7PaJ68hrar
         3w+cv3iVuOGFTg+RO2eCc3lIiNIcGGGqcdD/ONQ2FFLmK8TLPgIT/mxaNADhiTKgGK13
         PkLGshvr7iBsShkigGpCEEITnNgEMPrgh5OqanjnVgrvMDeGQVagt5y4WUHVkAA5vO7O
         kcCDnC5Xe7Zq/AZQagkxNRoQGZ44DdM6VGujE3jm4UqCzdZopNWYynQB7AbuwM0VpL9h
         hFV/HJW8d7ZbnGPFqJkBqQ20szoswTN8ddDht7K6TJp56FHjgNE2qlOWcVMbnYtYl7Us
         WXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYMK3ln+pSNgbS7KOrXcaQql59e3lfO5o9Vh/Disa6M=;
        b=IHiMSJOJydaulIB2EQfnNu1z9NyoOVwfKcvwompxJHSSdyKGf5p82JjcFibXd9baDm
         zbj51TVqTzzkcYhXXgOZ0ZKDcIhBOcj1130A8hw+/06n1ImPO66nRrtLirVSb/gi79Mr
         XHTr0hSArF1WPbuuaFuLxz8QHpoQH2M9a2YmgJ79mgIO0D2IRJ42cOwVhF3T0yqZaLn4
         kuI1pt1HYNdvXe4mEsXrEu/IgMwuOsWaVTLGhaIDRvmewW/XHpZGqCncaicY8gOoQA6/
         QmaTzm1CTg6tLcdqxdNtOpNGRpO3WJphEss+v3K8u1xBGWQwBpMuzNU7MO++2qDmZtOD
         zowg==
X-Gm-Message-State: AJIora8wFirCgS9o/oRJNym9rARZCZ9PDXaQwJGFOVsLOOIyaW6wLpJo
        AuDHsyiLbZNihCMiflrkho0iF9ywNMo=
X-Google-Smtp-Source: AGRyM1ujARNnAsVPV+Fm+AtrZ7Mo+yZ5WWvQKCrAnn5s0STr+OV2uejbh/obWPVhinrfGHMNu0pyfQ==
X-Received: by 2002:a17:907:dab:b0:726:8ec4:7219 with SMTP id go43-20020a1709070dab00b007268ec47219mr43602000ejc.260.1657188813173;
        Thu, 07 Jul 2022 03:13:33 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id kv12-20020a17090778cc00b0072ac3f06615sm6235747ejc.133.2022.07.07.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:13:32 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 2/3] clk: qcom: lcc-ipq806x: add reset definition
Date:   Thu,  7 Jul 2022 12:13:25 +0200
Message-Id: <20220707101326.30880-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707101326.30880-1-ansuelsmth@gmail.com>
References: <20220707101326.30880-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset definition for lcc-ipq806x.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
v3:
 - Added review tag
v2:
 - Fix Sob tag

 drivers/clk/qcom/lcc-ipq806x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index 1a2be4aeb31d..ba90bebba597 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -22,6 +22,7 @@
 #include "clk-branch.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "reset.h"
 
 static struct clk_pll pll4 = {
 	.l_reg = 0x4,
@@ -405,6 +406,10 @@ static struct clk_regmap *lcc_ipq806x_clks[] = {
 	[AHBIX_CLK] = &ahbix_clk.clkr,
 };
 
+static const struct qcom_reset_map lcc_ipq806x_resets[] = {
+	[LCC_PCM_RESET] = { 0x54, 13 },
+};
+
 static const struct regmap_config lcc_ipq806x_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -417,6 +422,8 @@ static const struct qcom_cc_desc lcc_ipq806x_desc = {
 	.config = &lcc_ipq806x_regmap_config,
 	.clks = lcc_ipq806x_clks,
 	.num_clks = ARRAY_SIZE(lcc_ipq806x_clks),
+	.resets = lcc_ipq806x_resets,
+	.num_resets = ARRAY_SIZE(lcc_ipq806x_resets),
 };
 
 static const struct of_device_id lcc_ipq806x_match_table[] = {
-- 
2.36.1

