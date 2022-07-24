Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA55557F652
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGXSYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiGXSX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:23:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0975B7EC;
        Sun, 24 Jul 2022 11:23:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v12so11451010edc.10;
        Sun, 24 Jul 2022 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYMK3ln+pSNgbS7KOrXcaQql59e3lfO5o9Vh/Disa6M=;
        b=kg6JW3Tsw5TXpT9N+4jAaIS+MFnQ0wdx7CYqONWiYX14H8tR2kxdVRBQcVWggf/3eT
         DYK1thgELMP4d5dgwU87Yjm/soU+oSMx8Q6R0u6HlUPDei2McmS45WTPDC64xkQ7BDOg
         mdPiKiHsAD7fqjmqbYYRVxYtG5qgvzCykyrvSLaqmbTMGJdXqJO6m/ZWw7STI8OzJ8ow
         3pwCP/Su87VT5WCCMiokdnPtHVBvmyzCnSaKnsOxfPk4OmxQLC8+ETnlu44HbwruTA0a
         kiZKsHLJW/PCmMCkCbPTIe6gy9u5vjLlD0YuWdvZhte80S+pHrpyp6TQlb+L0BIaLQbd
         DR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYMK3ln+pSNgbS7KOrXcaQql59e3lfO5o9Vh/Disa6M=;
        b=F5o9Mh3TYi/fBCJMmsr0kiMFqJNESLoVpUyrD6+X+yKiyxJAGueQwDiLvemGPMGybo
         2YRsA+JBxLjtIVYQ6EITxFn+FmKpAl1nBMRlMiCvVzCHUfBidwPfN8v3vcoMhmYSSjBX
         DTW98ift2ibzqM4dyC0wLxZgJaj6/mustTCvUk3dAWDpzB1qsl6A8DYTYdF08BZWo6Fs
         mIRS9xBH4Vyz/8w5QkV1FzezOtjKupcLhtySY1y14XALI8F3gpPFg19BbIGCgrCFa4Ve
         ozI/x3VBJUdxsY7vj02Po1S944rULJDkQb2yqvgtqGRQlMtJ1btFnbydORdZR1suLmEu
         GCUA==
X-Gm-Message-State: AJIora+mJSGb/pAinIyjSL47a+uODlGEwkwrKo6MkI8HzsZqHXDso5G5
        oo3jCgnjvEeTIQMjf1N14jA=
X-Google-Smtp-Source: AGRyM1umQoiV0+D3J2Dz7WNv37jIb/A+X3rH9IHWlLTxpMudH9U6gohvqsjcAo7PRYyDBWUCBchquA==
X-Received: by 2002:a05:6402:2691:b0:43a:d26b:f949 with SMTP id w17-20020a056402269100b0043ad26bf949mr9903786edd.92.1658687037519;
        Sun, 24 Jul 2022 11:23:57 -0700 (PDT)
Received: from localhost.localdomain ([5.171.121.144])
        by smtp.googlemail.com with ESMTPSA id kw24-20020a170907771800b0072b609d9a36sm502680ejc.16.2022.07.24.11.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 11:23:57 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 2/4] clk: qcom: lcc-ipq806x: add reset definition
Date:   Sun, 24 Jul 2022 20:23:27 +0200
Message-Id: <20220724182329.9891-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220724182329.9891-1-ansuelsmth@gmail.com>
References: <20220724182329.9891-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

