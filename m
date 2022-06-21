Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EB8553A93
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353274AbiFUTaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiFUTa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:30:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D93729C9A;
        Tue, 21 Jun 2022 12:30:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u12so29583428eja.8;
        Tue, 21 Jun 2022 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnWXDyTUMc2gqSaHRzgdH012TpPm8aEL9lBTlAQRJqE=;
        b=A492Q7eYDXfdZl9SVvXlbo7WE7FizUZjkt+u6tZaX2S2g/rDnyMjwx+ylQGADHxTXZ
         uvJL21VYdwj6XTiDWc5Vsh6K5M8Ycr1+FHt1kzsK/PHWL/+Hq2WWyfdb2NM6DhKAIBBw
         n7bDmJnuuzHTaq7AmsyedqfqIai6PNyp+z8f/H9wha8MDh4uTu6Y8S9gX2PCL10/5UCA
         8M29EI211+W1tHWw0EanxSGucgdbIZbDC/R6VDJCy1awbGjhpvm7ioTU/F60qZgQwm5f
         jtXTeVncRB/cjlBNPS9fR9Llh+jNcJcYm1L0a/yc/EBZaYtGz7OX2OrbM3S+J7CG7g6f
         G0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnWXDyTUMc2gqSaHRzgdH012TpPm8aEL9lBTlAQRJqE=;
        b=Fec2d0Q3KCNW08xEoNFbTixroLe5hk5leOSu5v/4T7EJrUD51shnOWE0iAK4fOX6Vy
         qgJbWpL75Y0OdBE8OX2VN+GrMfmBrBEJ014jBJZuAiNZ3INJqvV6u8Vf+i/EH7MZObwH
         6EIzcUUa2NC2a/X4eJXaGOvQ6QOdVFTWTBJ/T3VccoOJ8O8KlCNzHSTHZvvJJoDVVv8Z
         RUnW+3x0+AoW3tJm+UR5D9AGdlUAb0Wh8d9QPUCx3Avg3cdQTBcg3zh+MaMRcWKzjLMU
         1fCxTa4TkzL4gN/LmhqAsi/WTrg55ZcZTA7zG8pDvP3YQbTe1KSuwQOs8GFSjX0YULPD
         x7tQ==
X-Gm-Message-State: AJIora/BMYeRlCnAuBlJ0KjmBzz/7zchghZ7noT4SXFJa0UcZc1UZacj
        oFyBG1yOFoF6MaXt4ZRsysc=
X-Google-Smtp-Source: AGRyM1tXnaLGE5IoQGs5Rzqv1q19b6/BG+6+w8VW0VJdB1bLCkiR1sXCvfGyNjsr79G19TggwGaqHQ==
X-Received: by 2002:a17:907:c1d:b0:70f:469a:3d73 with SMTP id ga29-20020a1709070c1d00b0070f469a3d73mr26977317ejc.248.1655839825583;
        Tue, 21 Jun 2022 12:30:25 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-158.xnet.hr. [88.207.99.158])
        by smtp.googlemail.com with ESMTPSA id f5-20020a1709064dc500b00706287ba061sm8020586ejw.180.2022.06.21.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:30:25 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 3/3] phy: qcom-qmp-pcie: add IPQ8074 PCIe Gen3 QMP PHY support
Date:   Tue, 21 Jun 2022 21:30:20 +0200
Message-Id: <20220621193020.1630180-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621193020.1630180-1-robimarko@gmail.com>
References: <20220621193020.1630180-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has 2 different single lane PCIe PHY-s, one Gen2 and one Gen3.
Gen2 one is already supported, so add the support for the Gen3 one.
It uses the same register layout as IPQ6018.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Remove parsing QMP pipe clock rate from DT, and instead use the rate
as set in the PHY config

Changes in v2:
* Rebase onto next-20220621 to apply on the refactored driver
* Remove non existant has_phy_com_ctrl and has_lane_rst
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 160 +++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 4dc4d4f8547e..103a08c778e9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -450,6 +450,133 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG_L(QPHY_START_CTRL, 0x3),
 };
 
+static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP_EN, 0x42),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_RESETSM_CNTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER2, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x21),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE0, 0x355),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE0, 0x35555),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE0, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE0, 0x1a0a),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE0, 0xb),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE0, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV, 0xa),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TIMER, 0xa),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE1, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x2),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE1, 0x2aa),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x2aaab),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE1, 0x3414),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE1, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE1, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE1, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE1, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE0, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE1, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
+};
+
+static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_TX0_RES_CODE_LANE_OFFSET_TX, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_TX0_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_TX0_HIGHZ_DRVR_EN, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_TX0_LANE_MODE_1, 0x06),
+};
+
+static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_RX0_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_SIGDET_ENABLES, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_SIGDET_DEGLITCH_CNTRL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_EQU_ADAPTOR_CNTRL2, 0xe),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_EQU_ADAPTOR_CNTRL3, 0x4),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_EQU_ADAPTOR_CNTRL4, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_UCDR_PI_CONTROLS, 0x70),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x73),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_10_LOW, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_10_HIGH, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_10_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_10_HIGH3, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_10_HIGH4, 0xb1),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_01_LOW, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_01_HIGH, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_01_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_01_HIGH3, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_01_HIGH4, 0xb1),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_00_LOW, 0xf0),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_00_HIGH, 0x2),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_00_HIGH2, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_00_HIGH3, 0xd3),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_MODE_00_HIGH4, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_UCDR_FO_GAIN, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_RX0_UCDR_SO_GAIN, 0x02),
+};
+
+static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(PCS_COM_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(PCS_COM_FLL_CNT_VAL_L, 0x9),
+	QMP_PHY_INIT_CFG(PCS_COM_FLL_CNT_VAL_H_TOL, 0x42),
+	QMP_PHY_INIT_CFG(PCS_COM_FLL_MAN_CODE, 0x40),
+	QMP_PHY_INIT_CFG(PCS_COM_FLL_CNTRL1, 0x01),
+	QMP_PHY_INIT_CFG(PCS_COM_P2U3_WAKEUP_DLY_TIME_AUXCLK_H, 0x0),
+	QMP_PHY_INIT_CFG(PCS_COM_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x1),
+	QMP_PHY_INIT_CFG(PCS_PCIE_OSC_DTCT_ACTIONS, 0x0),
+	QMP_PHY_INIT_CFG(PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
+	QMP_PHY_INIT_CFG(PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
+	QMP_PHY_INIT_CFG(PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
+	QMP_PHY_INIT_CFG(PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
+	QMP_PHY_INIT_CFG(PCS_PCIE_EQ_CONFIG1, 0x11),
+	QMP_PHY_INIT_CFG(PCS_PCIE_EQ_CONFIG2, 0xb),
+	QMP_PHY_INIT_CFG(PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
+	QMP_PHY_INIT_CFG(PCS_PCIE_OSC_DTCT_CONFIG2, 0x52),
+	QMP_PHY_INIT_CFG(PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x50),
+	QMP_PHY_INIT_CFG(PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x1a),
+	QMP_PHY_INIT_CFG(PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x6),
+	QMP_PHY_INIT_CFG(PCS_COM_G12S1_TXDEEMPH_M3P5DB, 0x10),
+	QMP_PHY_INIT_CFG(PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
+	QMP_PHY_INIT_CFG(PCS_COM_RX_DCC_CAL_CONFIG, 0x01),
+	QMP_PHY_INIT_CFG(PCS_COM_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(PCS_COM_REFGEN_REQ_CONFIG1, 0x0d),
+};
+
 static const struct qmp_phy_init_tbl sdm845_qmp_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
@@ -1426,6 +1553,36 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.pipe_clock_rate	= 125000000,
 };
 
+static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
+	.type			= PHY_TYPE_PCIE,
+	.nlanes			= 1,
+
+	.serdes_tbl		= ipq8074_pcie_gen3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_serdes_tbl),
+	.tx_tbl			= ipq8074_pcie_gen3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
+	.rx_tbl			= ipq8074_pcie_gen3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_rx_tbl),
+	.pcs_tbl		= ipq8074_pcie_gen3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_gen3_pcs_tbl),
+	.clk_list		= ipq8074_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
+	.reset_list		= ipq8074_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(ipq8074_pciephy_reset_l),
+	.vreg_list		= NULL,
+	.num_vregs		= 0,
+	.regs			= ipq_pciephy_gen3_regs_layout,
+
+	.start_ctrl		= SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 250000000,
+};
+
 static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 	.type			= PHY_TYPE_PCIE,
 	.nlanes			= 1,
@@ -2279,6 +2436,9 @@ static const struct of_device_id qcom_qmp_phy_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,ipq8074-qmp-pcie-phy",
 		.data = &ipq8074_pciephy_cfg,
+	}, {
+		.compatible = "qcom,ipq8074-qmp-gen3-pcie-phy",
+		.data = &ipq8074_pciephy_gen3_cfg,
 	}, {
 		.compatible = "qcom,ipq6018-qmp-pcie-phy",
 		.data = &ipq6018_pciephy_cfg,
-- 
2.36.1

