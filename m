Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0841858E5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiHJEGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiHJEFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:05:18 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35014A199
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:05:13 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10cf9f5b500so16470663fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ndd7GVOJq64yRB5q+nG+1O8Ki0y0Qk32lK28P7SYTeg=;
        b=ZICWcSO7UDTKte7hQmLufWNHbm5eqdJVlyaH3TLo+ctWq28fKrJE54I9E37Jk/KaGE
         UotXhHPN2sdiq2ezO8M9+JMZPM4BNPIswPeXzP04u5N8NESOt0lplh3yunlPFnNj4Jhw
         9ch3NJOKSU2FPI0BSUSJin6xrz+wEod8as13ejYGnJEP5uPfREhI86AHPOwBxjDrtMAO
         uTRsEPM0nKzgr0+oyhXOV9QXG/cWpYLoKwVm8w51qJmHCUi8idsnucBZA39C4te+xOU8
         dRIEIbc24LOUBYcl4mqoy4DoZAI13672TXZ8fSSbOwM8S3x1tmi4ImI1CI4piZQ17rB5
         +u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ndd7GVOJq64yRB5q+nG+1O8Ki0y0Qk32lK28P7SYTeg=;
        b=T4gg9KJ26fAVjiEj6nAli5YYhWLT294r7dc/wbY+pH9j926KjrqnLl63dQaiXlIua+
         X47PimuWog3HtmZcGpmy+RaeYN6esMuta2KNKrRbcFAOSce+wCtrfYXOBYmRwYMp085Z
         NLU5TSUfNwVsaxZryAbjyErnEGhKC/FFB1yIvIpH2+7d3w4kR7W0OOC3X/kJzxoeZ3jq
         t+h+I5JLB9gut5tqx61Tjp36unJ9/jhPBIV9s6XxmK3pzJz41zzF9LOgblm6wO0xDUbp
         comWmZIRTb8Nv/ieJ6fwrQK4J/ijzrN5LB3AUgZM9XmaNIGU81elYK8yod3ZBdcLZl1b
         Ap/Q==
X-Gm-Message-State: ACgBeo00I20SZlGiaaPH7GTZ5gGSzf4fKD7OWFsd8pWMExl8Ok4O5cwL
        bl9n4sx8CVcN78pDokMjEsuQoMgHzDVOOA==
X-Google-Smtp-Source: AA6agR5DLkTSzdsowisb+O8eZGxuq561vdngF37Prt7DIl5waI3gba3oSw8Fj+0kjL3Ah7KRHQvo8A==
X-Received: by 2002:a05:6870:ec93:b0:10e:75ae:8177 with SMTP id eo19-20020a056870ec9300b0010e75ae8177mr686789oab.234.1660104312359;
        Tue, 09 Aug 2022 21:05:12 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q6-20020a056830440600b00616dfd2c859sm449027otv.59.2022.08.09.21.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 21:05:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] phy: qcom: edp: Introduce support for DisplayPort
Date:   Tue,  9 Aug 2022 21:07:44 -0700
Message-Id: <20220810040745.3582985-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220810040745.3582985-1-bjorn.andersson@linaro.org>
References: <20220810040745.3582985-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eDP phy can be used to drive either eDP or DP output, with some
minor variations in some of the configuration and seemingly a need for
implementing swing and pre_emphasis calibration.

Introduce a config object, indicating if the phy is operating in eDP or
DP mode and swing/pre-emphasis calibration to support this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 80 +++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 32614fb838b5..301ac422d2fe 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -70,8 +70,19 @@
 
 #define TXn_TRAN_DRVR_EMP_EN                    0x0078
 
+struct qcom_edp_cfg {
+	bool is_dp;
+
+	/* DP PHY swing and pre_emphasis tables */
+	const u8 (*swing_hbr_rbr)[4][4];
+	const u8 (*swing_hbr3_hbr2)[4][4];
+	const u8 (*pre_emphasis_hbr_rbr)[4][4];
+	const u8 (*pre_emphasis_hbr3_hbr2)[4][4];
+};
+
 struct qcom_edp {
 	struct device *dev;
+	const struct qcom_edp_cfg *cfg;
 
 	struct phy *phy;
 
@@ -92,7 +103,9 @@ struct qcom_edp {
 static int qcom_edp_phy_init(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
+	const struct qcom_edp_cfg *cfg = edp->cfg;
 	int ret;
+	u8 cfg8;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(edp->supplies), edp->supplies);
 	if (ret)
@@ -117,6 +130,13 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
 	       edp->edp + DP_PHY_PD_CTL);
 
+	if (cfg && cfg->is_dp)
+		cfg8 = 0xb7;
+	else
+		cfg8 = 0x37;
+
+	writel(0xfc, edp->edp + DP_PHY_MODE);
+
 	writel(0x00, edp->edp + DP_PHY_AUX_CFG0);
 	writel(0x13, edp->edp + DP_PHY_AUX_CFG1);
 	writel(0x24, edp->edp + DP_PHY_AUX_CFG2);
@@ -125,7 +145,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	writel(0x26, edp->edp + DP_PHY_AUX_CFG5);
 	writel(0x0a, edp->edp + DP_PHY_AUX_CFG6);
 	writel(0x03, edp->edp + DP_PHY_AUX_CFG7);
-	writel(0x37, edp->edp + DP_PHY_AUX_CFG8);
+	writel(cfg8, edp->edp + DP_PHY_AUX_CFG8);
 	writel(0x03, edp->edp + DP_PHY_AUX_CFG9);
 
 	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
@@ -142,14 +162,60 @@ static int qcom_edp_phy_init(struct phy *phy)
 	return ret;
 }
 
+static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configure_opts_dp *dp_opts)
+{
+	const struct qcom_edp_cfg *cfg = edp->cfg;
+	unsigned int v_level = 0;
+	unsigned int p_level = 0;
+	u8 ldo_config;
+	u8 swing;
+	u8 emph;
+	int i;
+
+	if (!cfg)
+		return 0;
+
+	for (i = 0; i < dp_opts->lanes; i++) {
+		v_level = max(v_level, dp_opts->voltage[i]);
+		p_level = max(p_level, dp_opts->pre[i]);
+	}
+
+	if (dp_opts->link_rate <= 2700) {
+		swing = (*cfg->swing_hbr_rbr)[v_level][p_level];
+		emph = (*cfg->pre_emphasis_hbr_rbr)[v_level][p_level];
+	} else {
+		swing = (*cfg->swing_hbr3_hbr2)[v_level][p_level];
+		emph = (*cfg->pre_emphasis_hbr3_hbr2)[v_level][p_level];
+	}
+
+	if (swing == 0xff || emph == 0xff)
+		return -EINVAL;
+
+	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+
+	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
+	writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
+	writel(emph, edp->tx0 + TXn_TX_EMP_POST1_LVL);
+
+	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
+	writel(swing, edp->tx1 + TXn_TX_DRV_LVL);
+	writel(emph, edp->tx1 + TXn_TX_EMP_POST1_LVL);
+
+	return 0;
+}
+
 static int qcom_edp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	const struct phy_configure_opts_dp *dp_opts = &opts->dp;
 	struct qcom_edp *edp = phy_get_drvdata(phy);
+	int ret = 0;
 
 	memcpy(&edp->dp_opts, dp_opts, sizeof(*dp_opts));
 
-	return 0;
+	if (dp_opts->set_voltages)
+		ret = qcom_edp_set_voltages(edp, dp_opts);
+
+	return ret;
 }
 
 static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
@@ -315,7 +381,9 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp)
 static int qcom_edp_phy_power_on(struct phy *phy)
 {
 	const struct qcom_edp *edp = phy_get_drvdata(phy);
+	const struct qcom_edp_cfg *cfg = edp->cfg;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
+	u8 ldo_config;
 	int timeout;
 	int ret;
 	u32 val;
@@ -332,8 +400,11 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	if (timeout)
 		return timeout;
 
-	writel(0x01, edp->tx0 + TXn_LDO_CONFIG);
-	writel(0x01, edp->tx1 + TXn_LDO_CONFIG);
+
+	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+
+	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
+	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
 	writel(0x00, edp->tx0 + TXn_LANE_MODE_1);
 	writel(0x00, edp->tx1 + TXn_LANE_MODE_1);
 
@@ -635,6 +706,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	edp->dev = dev;
+	edp->cfg = of_device_get_match_data(&pdev->dev);
 
 	edp->edp = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(edp->edp))
-- 
2.35.1

