Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB602479B48
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 15:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhLROSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 09:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbhLROSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 09:18:09 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08541C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 06:18:09 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d10so10822646lfg.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 06:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auxYJ2BKTuDQuwL3Oq9CPgu8Cwlz0DrWZeXsLWkxy0M=;
        b=rL18nRNyiOr3fP3R19O9F2zoyqfc/31j6VOgKLcRpHfku2yBWODIiZxBMFel7Z34A5
         cNm15z+xbIkPqxANFJmsBl6x7AowOTCvbjFsP41GTUZWGwNKzsgLGd5hTwrreQAOKxb5
         gKI42SobLFrZD4pSV+VOlfMOEncfUWSHw83Un5MwKgj66l630EedLV+zEE0UiYovDM6o
         teJdSJGE1mUD6wSA0EK1F+GQTA6pRnW/Jtzc1YHKtOao8oCtTJJdw+vbpMbDSRHZHXcr
         fjNv2wpoYT/oRKd+8M3QkLCNZhmhzZVnZSlr8Rvc613NSaCO1JjBt3g3zpENbRVhnmE4
         ex3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auxYJ2BKTuDQuwL3Oq9CPgu8Cwlz0DrWZeXsLWkxy0M=;
        b=jJwjz3FmZFm3WiLXQpHdF3F5wZbNt2s1yVhk/1PXrqAQcnF4Bzg53YFxETXgPRRVyX
         Sp3Q7+G1xZBwVUi8pM183cJVZ5A3+L0WPat5e2RYOBKIO6i1DEn3KvHM+tGocKlo5hpQ
         B90Iu7E/FgAvw5WaJQrv78oKJDYIZ9tQHC4mI13j8P+76igH5VXCGzs20M/T8jlKJ1cU
         S6fMBddsXOPYLE+b34l9W2oEd5ffvOkrYIXdfywbI5l7raBBlSrCNmcVZC70uEN/rtTM
         rknBRh9UXqKQe9NiUeqTEteiFbcXmyUqZMHxrswkfpJdJ6C+J6JQAqsvyXINShOOc7eT
         1nJg==
X-Gm-Message-State: AOAM530hdO12HkzHgcQLPWaG7RNpdvk/VM4Y0p32koM9M2vsNNoH2jrj
        MQc6I7p5ak6j3Lh9oL3E8KY06g==
X-Google-Smtp-Source: ABdhPJxFV+weVRLQH1+ZEg00zQC1Kg/HRqvYQdoMxn1z4VM8w20kTjuRhds+f7FRtiDnK2kgw0PIEg==
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr6788856lfq.525.1639837087290;
        Sat, 18 Dec 2021 06:18:07 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id o11sm1952040ljc.100.2021.12.18.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 06:18:06 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] phy: qcom-qmp: Add SM8450 PCIe1 PHY support
Date:   Sat, 18 Dec 2021 17:17:55 +0300
Message-Id: <20211218141754.503661-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211218141754.503661-1-dmitry.baryshkov@linaro.org>
References: <20211218141754.503661-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two different PCIe PHYs on SM8450, one having one lane (v5)
and another with two lanes (v5.20). This commit adds support for the
second PCIe phy.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 153 ++++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h |  70 +++++++++++++
 2 files changed, 223 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 19c17678b999..021e7f439e69 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -2957,6 +2957,124 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen3x1_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
 };
 
+static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE0, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1, 0x97),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x46),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_CFG, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0xd0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MISC1, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORE_CLK_EN, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MODE, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_DC_LEVEL_CTRL, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_LANE_MODE_2, 0xf6),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_TX, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_RX, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_PI_CONTROLS, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B1, 0xcc),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B3, 0xcc),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B5, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B6, 0x29),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B0, 0xc5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B1, 0xad),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B2, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B3, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B4, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B5, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B6, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B0, 0xc7),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B1, 0xef),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B3, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B4, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B5, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B6, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_PHPRE_CTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_0_1, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_2_3, 0x37),
+
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_3, 0x05),
+
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE3, 0x1f),
+
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH4_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH5_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH6_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE210, 0x1f),
+
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE3, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_VGA_CAL_MAN_VAL, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_IDAC_SAOFFSET, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_DAC_ENABLE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_GM_CAL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH2, 0x1f),
+};
+
+/* Register names should be validated, they might be different for this PHY */
+static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG2, 0x16),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG3, 0x22),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_G3S2_PRE_GAIN, 0x2e),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0x99),
+};
+
+static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_EQ_CONFIG5, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_EQ_CONFIG1, 0x16),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_RX_MARGINING_CONFIG3, 0x28),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN, 0x2e),
+};
+
 struct qmp_phy;
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
@@ -4238,6 +4356,38 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.pwrdn_delay_max	= 1005,		/* us */
 };
 
+static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
+	.type = PHY_TYPE_PCIE,
+	.nlanes = 2,
+
+	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_serdes_tbl),
+	.tx_tbl			= sm8450_qmp_gen4x2_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_tx_tbl),
+	.rx_tbl			= sm8450_qmp_gen4x2_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_rx_tbl),
+	.pcs_tbl		= sm8450_qmp_gen4x2_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_tbl),
+	.pcs_misc_tbl		= sm8450_qmp_gen4x2_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_misc_tbl),
+	.clk_list		= sdm845_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.start_ctrl             = SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS_4_20,
+
+	.is_dual_lane_phy	= true,
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
 static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -5899,6 +6049,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8450-qmp-gen3x1-pcie-phy",
 		.data = &sm8450_qmp_gen3x1_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8450-qmp-gen4x2-pcie-phy",
+		.data = &sm8450_qmp_gen4x2_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sm8450-qmp-ufs-phy",
 		.data = &sm8450_ufsphy_cfg,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index eeeef8d40876..06b2556ed93a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -1077,6 +1077,7 @@
 #define QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0		0x028
 #define QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1		0x030
 #define QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1		0x034
+#define QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN		0x044
 #define QSERDES_V5_COM_CLK_ENABLE1			0x048
 #define QSERDES_V5_COM_SYSCLK_BUF_ENABLE		0x050
 #define QSERDES_V5_COM_PLL_IVCO				0x058
@@ -1088,6 +1089,7 @@
 #define QSERDES_V5_COM_PLL_CCTRL_MODE1			0x088
 #define QSERDES_V5_COM_SYSCLK_EN_SEL			0x094
 #define QSERDES_V5_COM_LOCK_CMP_EN			0x0a4
+#define QSERDES_V5_COM_LOCK_CMP_CFG			0x0a8
 #define QSERDES_V5_COM_LOCK_CMP1_MODE0			0x0ac
 #define QSERDES_V5_COM_LOCK_CMP2_MODE0			0x0b0
 #define QSERDES_V5_COM_LOCK_CMP1_MODE1			0x0b4
@@ -1109,7 +1111,13 @@
 #define QSERDES_V5_COM_CLK_SELECT			0x154
 #define QSERDES_V5_COM_HSCLK_SEL			0x158
 #define QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL		0x15c
+#define QSERDES_V5_COM_CORECLK_DIV_MODE0		0x168
 #define QSERDES_V5_COM_CORECLK_DIV_MODE1		0x16c
+#define QSERDES_V5_COM_CORE_CLK_EN			0x174
+#define QSERDES_V5_COM_CMN_CONFIG			0x17c
+#define QSERDES_V5_COM_CMN_MISC1			0x19c
+#define QSERDES_V5_COM_CMN_MODE				0x1a4
+#define QSERDES_V5_COM_VCO_DC_LEVEL_CTRL		0x1a8
 #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x1ac
 #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x1b0
 #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x1b4
@@ -1134,6 +1142,12 @@
 #define QSERDES_V5_TX_PWM_GEAR_3_DIVIDER_BAND0_1	0x180
 #define QSERDES_V5_TX_PWM_GEAR_4_DIVIDER_BAND0_1	0x184
 
+/* Only for QMP V5_20 PHY - TX registers */
+#define QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_TX	0x30
+#define QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_RX	0x34
+#define QSERDES_V5_20_TX_LANE_MODE_1			0x78
+#define QSERDES_V5_20_TX_LANE_MODE_2			0x7c
+
 /* Only for QMP V5 PHY - RX registers */
 #define QSERDES_V5_RX_UCDR_FO_GAIN			0x008
 #define QSERDES_V5_RX_UCDR_SO_GAIN			0x014
@@ -1190,10 +1204,58 @@
 #define QSERDES_V5_RX_DCC_CTRL1				0x1a8
 #define QSERDES_V5_RX_VTH_CODE				0x1b0
 
+/* Only for QMP V5_20 PHY - RX registers */
+#define QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE2		0x008
+#define QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE3		0x00c
+#define QSERDES_V5_20_RX_UCDR_PI_CONTROLS		0x020
+#define QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_0_1	0x02c
+#define QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_2_3	0x030
+#define QSERDES_V5_20_RX_RX_IDAC_SAOFFSET		0x07c
+#define QSERDES_V5_20_RX_DFE_3				0x090
+#define QSERDES_V5_20_RX_DFE_DAC_ENABLE1		0x0b4
+#define QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH1		0x0c4
+#define QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH2		0x0c8
+#define QSERDES_V5_20_RX_VGA_CAL_MAN_VAL		0x0dc
+#define QSERDES_V5_20_RX_GM_CAL				0x0ec
+#define QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL4		0x108
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B1		0x164
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B2		0x168
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B3		0x16c
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B5		0x174
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B6		0x178
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B0		0x17c
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B1		0x180
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B2		0x184
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B3		0x188
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B4		0x18c
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B5		0x190
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B6		0x194
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B0		0x198
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B1		0x19c
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B2		0x1a0
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B3		0x1a4
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B4		0x1a8
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B5		0x1ac
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B6		0x1b0
+#define QSERDES_V5_20_RX_PHPRE_CTRL			0x1b4
+#define QSERDES_V5_20_RX_DFE_CTLE_POST_CAL_OFFSET	0x1c0
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE210	0x1f4
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE3	0x1f8
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE210	0x1fc
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE3	0x200
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE210	0x204
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE3	0x208
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH4_RATE3	0x210
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH5_RATE3	0x218
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH6_RATE3	0x220
+
 /* Only for QMP V5 PHY - USB/PCIe PCS registers */
 #define QPHY_V5_PCS_REFGEN_REQ_CONFIG1			0x0dc
+#define QPHY_V5_PCS_G3S2_PRE_GAIN			0x170
 #define QPHY_V5_PCS_RX_SIGDET_LVL			0x188
 #define QPHY_V5_PCS_RATE_SLEW_CNTRL1			0x198
+#define QPHY_V5_PCS_EQ_CONFIG2				0x1e0
+#define QPHY_V5_PCS_EQ_CONFIG3				0x1e4
 
 /* Only for QMP V5 PHY - PCS_PCIE registers */
 #define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE		0x20
@@ -1201,6 +1263,14 @@
 #define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
 #define QPHY_V5_PCS_PCIE_EQ_CONFIG2			0xa8
 
+/* Only for QMP V5_20 PHY - PCIe PCS registers */
+#define QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE	0x01c
+#define QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS		0x090
+#define QPHY_V5_20_PCS_PCIE_EQ_CONFIG1			0x0a0
+#define QPHY_V5_20_PCS_PCIE_G4_EQ_CONFIG5		0x108
+#define QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN			0x15c
+#define QPHY_V5_20_PCS_PCIE_RX_MARGINING_CONFIG3	0x184
+
 /* Only for QMP V5 PHY - UFS PCS registers */
 #define QPHY_V5_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB	0x00c
 #define QPHY_V5_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB	0x010
-- 
2.34.1

