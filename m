Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA958E633
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiHJEUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiHJEUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:20:32 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F4861107
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:20:30 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10ec41637b3so16484350fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Z3E2a56lQNlxeNkCPk02hVu6NmVC7Nm6/7MlMe1CEvI=;
        b=jMHmdxFtm8pXwtWqDZS/7ZXA7eNp3typUtOFf1Wbqvpy6EidfKM0KWMXeOh1vBHHTM
         mRVVK3RJojReE/X2z43+9e2Ah+TkrVTMalmQuOxC5rkNlIbOUxmmkhiDSMHfKR6cZiXN
         COeB91FTJf2wVGh74vrrUP4o/9zaI16dQdnaUZ1vLiNKfVMIuB3dYHGMHJNUdj5X7fyb
         5EPgz54H483MlyCBGlm/rz/zJFQS7EKD/GAlZDChP2kHNHCaXmUvJit6VQgfBbTAWTkX
         uunUNXYf25GjnGXGgD1ppRiFmYA4oIZbuMqFvY8X8G+/oFHceJz51jec2vDfyEO08sYv
         dS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Z3E2a56lQNlxeNkCPk02hVu6NmVC7Nm6/7MlMe1CEvI=;
        b=eGbyG3KYoJX6OyP8Toe0Bcp16iJh+M32XLWzY7OlUP/6irh+Q8aWeEA7Y9FWaXePJo
         p0mpetX7jRN5umIBVQCY20fn/d5GjwA/6gBbQpeXY9LC/8HkpkIBDtXm/YoCoCN03a/8
         k/MlH3ZUTEHGNwCNs7T/HWXZOtthIH5MYaXwMjzGUD8blb1QIijkPAlQaQ0V/T11ZHtq
         rpz+FIq3Engup/NqvOksW2e4RjMrFT3WWTNmjB9JCCHyEH/sx+GsfsknGl90IIuQI2ue
         V9EDKq8FqBR8vd50MHrgdBR9mBG+mKhimvjjOv+mSky/4CMDxOFihlZedJCv+JnDePD1
         ItaA==
X-Gm-Message-State: ACgBeo203Ya4l8ZjP1vWYkVyPr5/vBY+Ni/FhGq9rfrqHGmESVX92wNF
        C6sF58Sob8DaSHTdtsBFGPKK7w==
X-Google-Smtp-Source: AA6agR7QVX4Fl6NyeHu3bVWbxEWQpYlppoFon8dkG2fzWdqYnYJQGD6TvU0dOnWszrfUv+XuEf3wGg==
X-Received: by 2002:a05:6870:a98b:b0:10e:64dc:197c with SMTP id ep11-20020a056870a98b00b0010e64dc197cmr663798oab.273.1660105229739;
        Tue, 09 Aug 2022 21:20:29 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id ba41-20020a056870c5a900b00101c76f7831sm3622747oab.24.2022.08.09.21.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 21:20:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] phy: qcom-qmp-combo: Add sc8280xp USB/DP combo phys
Date:   Tue,  9 Aug 2022 21:23:03 -0700
Message-Id: <20220810042303.3583194-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220810042303.3583194-1-bjorn.andersson@linaro.org>
References: <20220810042303.3583194-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC8280P has two copies of an USB/DP compbo PHY, add support for this
to the Qualcomm QMP PHY driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 343 +++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h    |   1 +
 .../phy-qcom-qmp-qserdes-txrx-v5_5nm.h        | 333 +++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   1 +
 4 files changed, 674 insertions(+), 4 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_5nm.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index c6ddb0be1045..a4dc1e40262f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -606,6 +606,160 @@ static const struct qmp_phy_init_tbl qmp_v4_dp_tx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TX_EMP_POST1_LVL, 0x20),
 };
 
+static const struct qmp_phy_init_tbl qmp_v5_dp_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_ENABLE1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_BUF_ENABLE, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CMN_CONFIG, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORE_CLK_EN, 0x1f),
+};
+
+static const struct qmp_phy_init_tbl qmp_v5_5nm_dp_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_LANE_MODE_3, 0x51),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_VMODE_CTRL1, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_PRE_STALL_LDO_BOOST_EN, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_INTERFACE_SELECT, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_CLKBUF_ENABLE, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_RESET_TSYNC_EN, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_TRAN_DRVR_EMP_EN, 0xf),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_PARRATE_REC_DETECT_IDLE_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_RES_CODE_LANE_OFFSET_RX, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_TX_BAND, 0x01),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb43dp_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE0, 0xfd),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1, 0xfd),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MSB_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MSB_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE0, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE0, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE1, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE1_MODE0, 0xd4),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE2_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE1_MODE1, 0xd4),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE2_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x13),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORE_CLK_EN, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_CONFIG, 0x76),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE0, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE1, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAXVAL2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SVS_MODE_CLK_SEL, 0x0a),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb43dp_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_LANE_MODE_2, 0xc2),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_LANE_MODE_3, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_TX_RES_CODE_LANE_OFFSET_RX, 0x0a),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb43dp_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_SIGDET_ENABLES, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B0, 0xd2),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B1, 0xd2),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B2, 0xdb),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B3, 0x21),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B5, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B6, 0x45),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B7, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE2_B0, 0x6b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE2_B1, 0x63),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE2_B2, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE2_B3, 0x23),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE2_B4, 0x35),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE2_B5, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE2_B6, 0x8e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_MODE_RATE2_B7, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_IVCM_CAL_CODE_OVERRIDE, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_IVCM_CAL_CTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_SUMMER_CAL_SPD_MODE, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_UCDR_PI_CONTROLS, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_UCDR_SB2_GAIN2_RATE2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_RX_IVCM_POSTCAL_OFFSET, 0x7c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_VGA_CAL_CNTRL1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_VGA_CAL_MAN_VAL, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_DFE_DAC_ENABLE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_DFE_3, 0x45),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_GM_CAL, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_UCDR_FO_GAIN_RATE2, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_UCDR_SO_GAIN_RATE2, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_5NM_RX_Q_PI_INTRINSIC_BIAS_RATE32, 0x3f),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb43dp_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_CONFIG, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+};
 
 /* list of regulators */
 struct qmp_regulator_data {
@@ -646,6 +800,34 @@ static const u8 qmp_dp_v3_voltage_swing_hbr_rbr[4][4] = {
 	{ 0x1f, 0xff, 0xff, 0xff }
 };
 
+static const u8 qmp_dp_v5_pre_emphasis_hbr3_hbr2[4][4] = {
+	{ 0x20, 0x2c, 0x35, 0x3b },
+	{ 0x22, 0x2e, 0x36, 0xff },
+	{ 0x22, 0x31, 0xff, 0xff },
+	{ 0x24, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v5_voltage_swing_hbr3_hbr2[4][4] = {
+	{ 0x22, 0x32, 0x36, 0x3a },
+	{ 0x29, 0x39, 0x3f, 0xff },
+	{ 0x30, 0x3f, 0xff, 0xff },
+	{ 0x3f, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v5_pre_emphasis_hbr_rbr[4][4] = {
+	{ 0x20, 0x2d, 0x34, 0x3a },
+	{ 0x20, 0x2e, 0x35, 0xff },
+	{ 0x20, 0x2e, 0xff, 0xff },
+	{ 0x24, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v5_voltage_swing_hbr_rbr[4][4] = {
+	{ 0x28, 0x2f, 0x36, 0x3f },
+	{ 0x31, 0x3e, 0x3f, 0xff },
+	{ 0x36, 0x3f, 0xff, 0xff },
+	{ 0x3f, 0xff, 0xff, 0xff }
+};
+
 struct qmp_phy;
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
@@ -818,6 +1000,8 @@ static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_phy *qphy);
 static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy);
 static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_phy *qphy);
 
+static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_phy *qphy);
+
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
 {
 	u32 reg;
@@ -1023,6 +1207,83 @@ static const struct qmp_phy_combo_cfg sc8180x_usb3dpphy_cfg = {
 	.dp_cfg			= &sc8180x_dpphy_cfg,
 };
 
+static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
+	.type			= PHY_TYPE_USB3,
+	.nlanes			= 1,
+
+	.serdes_tbl		= sc8280xp_usb43dp_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_serdes_tbl),
+	.tx_tbl			= sc8280xp_usb43dp_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_tx_tbl),
+	.rx_tbl			= sc8280xp_usb43dp_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_rx_tbl),
+	.pcs_tbl		= sc8280xp_usb43dp_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_pcs_tbl),
+	.clk_list		= qmp_v4_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+
+	.start_ctrl		= SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN,
+	.phy_status		= PHYSTATUS,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
+	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
+
+	.has_phy_dp_com_ctrl	= true,
+	.is_dual_lane_phy	= true,
+};
+
+static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
+	.type			= PHY_TYPE_DP,
+	.nlanes			= 1,
+
+	.serdes_tbl		= qmp_v5_dp_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(qmp_v5_dp_serdes_tbl),
+	.tx_tbl			= qmp_v5_5nm_dp_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(qmp_v5_5nm_dp_tx_tbl),
+
+	.serdes_tbl_rbr		= qmp_v4_dp_serdes_tbl_rbr,
+	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_rbr),
+	.serdes_tbl_hbr		= qmp_v4_dp_serdes_tbl_hbr,
+	.serdes_tbl_hbr_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_hbr),
+	.serdes_tbl_hbr2	= qmp_v4_dp_serdes_tbl_hbr2,
+	.serdes_tbl_hbr2_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_hbr2),
+	.serdes_tbl_hbr3	= qmp_v4_dp_serdes_tbl_hbr3,
+	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_hbr3),
+
+	.swing_hbr_rbr		= &qmp_dp_v5_voltage_swing_hbr_rbr,
+	.pre_emphasis_hbr_rbr	= &qmp_dp_v5_pre_emphasis_hbr_rbr,
+	.swing_hbr3_hbr2	= &qmp_dp_v5_voltage_swing_hbr3_hbr2,
+	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v5_pre_emphasis_hbr3_hbr2,
+
+	.clk_list		= qmp_v4_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+
+	.has_phy_dp_com_ctrl	= true,
+	.is_dual_lane_phy	= true,
+
+	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
+	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
+	.configure_dp_phy = qcom_qmp_v5_phy_configure_dp_phy,
+	.calibrate_dp_phy = qcom_qmp_v4_dp_phy_calibrate,
+};
+
+static const struct qmp_phy_combo_cfg sc8280xp_usb43dpphy_combo_cfg = {
+	.usb_cfg		= &sc8280xp_usb43dp_usb_cfg,
+	.dp_cfg			= &sc8280xp_usb43dp_dp_cfg,
+};
+
 static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -1442,18 +1703,16 @@ static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_phy *qphy)
 			QSERDES_V4_TX_TX_EMP_POST1_LVL);
 }
 
-static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
+static int qcom_qmp_v45_phy_configure_dp_phy(struct qmp_phy *qphy)
 {
 	const struct qmp_phy_dp_clks *dp_clks = qphy->dp_clks;
 	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
 	u32 phy_vco_div, status;
 	unsigned long pixel_freq;
-	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
-	bool reverse;
 
 	writel(0x0f, qphy->pcs + QSERDES_V4_DP_PHY_CFG_1);
 
-	reverse = qcom_qmp_phy_combo_configure_dp_mode(qphy);
+	qcom_qmp_phy_combo_configure_dp_mode(qphy);
 
 	writel(0x13, qphy->pcs + QSERDES_DP_PHY_AUX_CFG1);
 	writel(0xa4, qphy->pcs + QSERDES_DP_PHY_AUX_CFG2);
@@ -1531,6 +1790,21 @@ static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
 			10000))
 		return -ETIMEDOUT;
 
+	return 0;
+}
+
+static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
+{
+	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
+	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
+	bool reverse = false;
+	u32 status;
+	int ret;
+
+	ret = qcom_qmp_v45_phy_configure_dp_phy(qphy);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * At least for 7nm DP PHY this has to be done after enabling link
 	 * clock.
@@ -1581,6 +1855,63 @@ static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
 	return 0;
 }
 
+static int qcom_qmp_v5_phy_configure_dp_phy(struct qmp_phy *qphy)
+{
+	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
+	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
+	bool reverse = false;
+	u32 status;
+	int ret;
+
+	ret = qcom_qmp_v45_phy_configure_dp_phy(qphy);
+	if (ret < 0)
+		return ret;
+
+	if (dp_opts->lanes == 1) {
+		bias0_en = reverse ? 0x3e : 0x1a;
+		drvr0_en = reverse ? 0x13 : 0x10;
+		bias1_en = reverse ? 0x15 : 0x3e;
+		drvr1_en = reverse ? 0x10 : 0x13;
+	} else if (dp_opts->lanes == 2) {
+		bias0_en = reverse ? 0x3f : 0x15;
+		drvr0_en = 0x10;
+		bias1_en = reverse ? 0x15 : 0x3f;
+		drvr1_en = 0x10;
+	} else {
+		bias0_en = 0x3f;
+		bias1_en = 0x3f;
+		drvr0_en = 0x10;
+		drvr1_en = 0x10;
+	}
+
+	writel(drvr0_en, qphy->tx + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
+	writel(bias0_en, qphy->tx + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
+	writel(drvr1_en, qphy->tx2 + QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN);
+	writel(bias1_en, qphy->tx2 + QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN);
+
+	writel(0x18, qphy->pcs + QSERDES_DP_PHY_CFG);
+	udelay(2000);
+	writel(0x19, qphy->pcs + QSERDES_DP_PHY_CFG);
+
+	if (readl_poll_timeout(qphy->pcs + QSERDES_V4_DP_PHY_STATUS,
+			status,
+			((status & BIT(1)) > 0),
+			500,
+			10000))
+		return -ETIMEDOUT;
+
+	writel(0x0a, qphy->tx + QSERDES_V5_5NM_TX_TX_POL_INV);
+	writel(0x0a, qphy->tx2 + QSERDES_V5_5NM_TX_TX_POL_INV);
+
+	writel(0x27, qphy->tx + QSERDES_V5_5NM_TX_TX_DRV_LVL);
+	writel(0x27, qphy->tx2 + QSERDES_V5_5NM_TX_TX_DRV_LVL);
+
+	writel(0x20, qphy->tx + QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL);
+	writel(0x20, qphy->tx2 + QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL);
+
+	return 0;
+}
+
 /*
  * We need to calibrate the aux setting here as many times
  * as the caller tries
@@ -2471,6 +2802,10 @@ static const struct of_device_id qcom_qmp_combo_phy_of_match_table[] = {
 		.compatible = "qcom,sc8180x-qmp-usb3-dp-phy",
 		.data = &sc8180x_usb3dpphy_cfg,
 	},
+	{
+		.compatible = "qcom,sc8280xp-qmp-usb43dp-phy",
+		.data = &sc8280xp_usb43dpphy_combo_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_qmp_combo_phy_of_match_table);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
index e1f2faa2493d..04f260711ea1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
@@ -18,6 +18,7 @@
 #define QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_H		0x194
 #define QPHY_V5_PCS_RATE_SLEW_CNTRL1			0x198
 #define QPHY_V5_PCS_CDR_RESET_TIME			0x1b0
+#define QPHY_V5_PCS_RX_CONFIG				0x1b0
 #define QPHY_V5_PCS_ALIGN_DETECT_CONFIG1		0x1c0
 #define QPHY_V5_PCS_ALIGN_DETECT_CONFIG2		0x1c4
 #define QPHY_V5_PCS_PCS_TX_RX_CONFIG			0x1d0
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_5nm.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_5nm.h
new file mode 100644
index 000000000000..a1c088bd5158
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_5nm.h
@@ -0,0 +1,333 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V5_5NM_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V5_5NM_H_
+
+/* Only for QMP V5 5NM PHY - TX registers */
+#define QSERDES_V5_5NM_TX_RES_CODE_LANE_OFFSET_TX		0x30
+#define QSERDES_V5_5NM_TX_RES_CODE_LANE_OFFSET_RX		0x34
+#define QSERDES_V5_5NM_TX_LANE_MODE_1				0x78
+#define QSERDES_V5_5NM_TX_LANE_MODE_2				0x7c
+#define QSERDES_V5_5NM_TX_LANE_MODE_3				0x80
+#define QSERDES_V5_5NM_TX_BIST_MODE_LANENO			0x00
+#define QSERDES_V5_5NM_TX_BIST_INVERT				0x04
+#define QSERDES_V5_5NM_TX_CLKBUF_ENABLE				0x08
+#define QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL			0x0c
+#define QSERDES_V5_5NM_TX_TX_IDLE_LVL_LARGE_AMP			0x10
+#define QSERDES_V5_5NM_TX_TX_DRV_LVL				0x14
+#define QSERDES_V5_5NM_TX_TX_DRV_LVL_OFFSET			0x18
+#define QSERDES_V5_5NM_TX_RESET_TSYNC_EN			0x1c
+#define QSERDES_V5_5NM_TX_PRE_STALL_LDO_BOOST_EN		0x20
+#define QSERDES_V5_5NM_TX_LPB_EN				0x24
+#define QSERDES_V5_5NM_TX_RES_CODE_LANE_TX			0x28
+#define QSERDES_V5_5NM_TX_RES_CODE_LANE_RX			0x2c
+#define QSERDES_V5_5NM_TX_RES_CODE_LANE_OFFSET_TX		0x30
+#define QSERDES_V5_5NM_TX_RES_CODE_LANE_OFFSET_RX		0x34
+#define QSERDES_V5_5NM_TX_PERL_LENGTH1				0x38
+#define QSERDES_V5_5NM_TX_PERL_LENGTH2				0x3c
+#define QSERDES_V5_5NM_TX_SERDES_BYP_EN_OUT			0x40
+#define QSERDES_V5_5NM_TX_DEBUG_BUS_SEL				0x44
+#define QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN			0x48
+#define QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN				0x4c
+#define QSERDES_V5_5NM_TX_TX_POL_INV				0x50
+#define QSERDES_V5_5NM_TX_PARRATE_REC_DETECT_IDLE_EN		0x54
+#define QSERDES_V5_5NM_TX_BIST_PATTERN1				0x58
+#define QSERDES_V5_5NM_TX_BIST_PATTERN2				0x5c
+#define QSERDES_V5_5NM_TX_BIST_PATTERN3				0x60
+#define QSERDES_V5_5NM_TX_BIST_PATTERN4				0x64
+#define QSERDES_V5_5NM_TX_BIST_PATTERN5				0x68
+#define QSERDES_V5_5NM_TX_BIST_PATTERN6				0x6c
+#define QSERDES_V5_5NM_TX_BIST_PATTERN7				0x70
+#define QSERDES_V5_5NM_TX_BIST_PATTERN8				0x74
+#define QSERDES_V5_5NM_TX_LANE_MODE_1				0x78
+#define QSERDES_V5_5NM_TX_LANE_MODE_2				0x7c
+#define QSERDES_V5_5NM_TX_LANE_MODE_3				0x80
+#define QSERDES_V5_5NM_TX_ATB_SEL1				0x84
+#define QSERDES_V5_5NM_TX_ATB_SEL2				0x88
+#define QSERDES_V5_5NM_TX_RCV_DETECT_LVL			0x8c
+#define QSERDES_V5_5NM_TX_RCV_DETECT_LVL_2			0x90
+#define QSERDES_V5_5NM_TX_PRBS_SEED1				0x94
+#define QSERDES_V5_5NM_TX_PRBS_SEED2				0x98
+#define QSERDES_V5_5NM_TX_PRBS_SEED3				0x9c
+#define QSERDES_V5_5NM_TX_PRBS_SEED4				0xa0
+#define QSERDES_V5_5NM_TX_RESET_GEN				0xa4
+#define QSERDES_V5_5NM_TX_RESET_GEN_MUXES			0xa8
+#define QSERDES_V5_5NM_TX_TRAN_DRVR_EMP_EN			0xac
+#define QSERDES_V5_5NM_TX_VMODE_CTRL1				0xb0
+#define QSERDES_V5_5NM_TX_ALOG_OBSV_BUS_CTRL_1			0xb4
+#define QSERDES_V5_5NM_TX_BIST_STATUS				0xb8
+#define QSERDES_V5_5NM_TX_BIST_ERROR_COUNT1			0xbc
+#define QSERDES_V5_5NM_TX_BIST_ERROR_COUNT2			0xc0
+#define QSERDES_V5_5NM_TX_ALOG_OBSV_BUS_STATUS_1		0xc4
+#define QSERDES_V5_5NM_TX_LANE_DIG_CONFIG			0xc8
+#define QSERDES_V5_5NM_TX_PI_QEC_CTRL				0xcc
+#define QSERDES_V5_5NM_TX_PRE_EMPH				0xd0
+#define QSERDES_V5_5NM_TX_SW_RESET				0xd4
+#define QSERDES_V5_5NM_TX_TX_BAND				0xd8
+#define QSERDES_V5_5NM_TX_SLEW_CNTL0				0xdc
+#define QSERDES_V5_5NM_TX_SLEW_CNTL1				0xe0
+#define QSERDES_V5_5NM_TX_INTERFACE_SELECT			0xe4
+#define QSERDES_V5_5NM_TX_DIG_BKUP_CTRL				0xe8
+#define QSERDES_V5_5NM_TX_DEBUG_BUS0				0xec
+#define QSERDES_V5_5NM_TX_DEBUG_BUS1				0xf0
+#define QSERDES_V5_5NM_TX_DEBUG_BUS2				0xf4
+#define QSERDES_V5_5NM_TX_DEBUG_BUS3				0xf8
+#define QSERDES_V5_5NM_TX_TX_BKUP_RO_BUS			0xfc
+
+/* Only for QMP V5 5NM PHY - RX registers */
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_FO_GAIN_RATE0		0x000
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_FO_GAIN_RATE1		0x004
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_FO_GAIN_RATE2		0x008
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_FO_GAIN_RATE3		0x00c
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_SO_GAIN_RATE0		0x010
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_SO_GAIN_RATE1		0x014
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_SO_GAIN_RATE2		0x018
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_SO_GAIN_RATE3		0x01c
+#define QSERDES_V5_5NM_RX_UCDR_SO_SATURATION			0x020
+#define QSERDES_V5_5NM_RX_UCDR_FO_TO_SO_DELAY			0x024
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_LOW_RATE0		0x028
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE0	0x02c
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_LOW_RATE1		0x030
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE1	0x034
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_LOW_RATE2		0x038
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE2	0x03c
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_LOW_RATE3		0x040
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE3	0x044
+#define QSERDES_V5_5NM_RX_UCDR_PI_CTRL1				0x048
+#define QSERDES_V5_5NM_RX_UCDR_PI_CTRL2				0x04c
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH1_RATE0		0x050
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH1_RATE1		0x054
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH1_RATE2		0x058
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH1_RATE3		0x05c
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH2_RATE0		0x060
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH2_RATE1		0x064
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH2_RATE2		0x068
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH2_RATE3		0x06c
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN1_RATE0			0x070
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN1_RATE1			0x074
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN1_RATE2			0x078
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN1_RATE3			0x07c
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN2_RATE0			0x080
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN2_RATE1			0x084
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN2_RATE2			0x088
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN2_RATE3			0x08c
+#define QSERDES_V5_5NM_RX_RXCLK_DIV2_CTRL			0x090
+#define QSERDES_V5_5NM_RX_RX_BAND				0x094
+#define QSERDES_V5_5NM_RX_RX_TERM_BW				0x098
+#define QSERDES_V5_5NM_RX_UCDR_FO_GAIN_RATE0			0x09c
+#define QSERDES_V5_5NM_RX_UCDR_FO_GAIN_RATE1			0x0a0
+#define QSERDES_V5_5NM_RX_UCDR_FO_GAIN_RATE2			0x0a4
+#define QSERDES_V5_5NM_RX_UCDR_FO_GAIN_RATE3			0x0a8
+#define QSERDES_V5_5NM_RX_UCDR_SO_GAIN_RATE0			0x0ac
+#define QSERDES_V5_5NM_RX_UCDR_SO_GAIN_RATE1			0x0b0
+#define QSERDES_V5_5NM_RX_UCDR_SO_GAIN_RATE2			0x0b4
+#define QSERDES_V5_5NM_RX_UCDR_SO_GAIN_RATE3			0x0b8
+#define QSERDES_V5_5NM_RX_UCDR_PI_CONTROLS			0x0bc
+#define QSERDES_V5_5NM_RX_UCDR_PD_DATA_FILTER_ENABLES		0x0c0
+#define QSERDES_V5_5NM_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE0		0x0c4
+#define QSERDES_V5_5NM_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE1		0x0c8
+#define QSERDES_V5_5NM_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE2		0x0cc
+#define QSERDES_V5_5NM_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3		0x0d0
+#define QSERDES_V5_5NM_RX_AUX_CONTROL				0x0d4
+#define QSERDES_V5_5NM_RX_AUXDATA_TB				0x0d8
+#define QSERDES_V5_5NM_RX_RCLK_AUXDATA_SEL			0x0dc
+#define QSERDES_V5_5NM_RX_EOM_CTRL				0x0e0
+#define QSERDES_V5_5NM_RX_AC_JTAG_ENABLE			0x0e4
+#define QSERDES_V5_5NM_RX_AC_JTAG_INITP				0x0e8
+#define QSERDES_V5_5NM_RX_AC_JTAG_INITN				0x0ec
+#define QSERDES_V5_5NM_RX_AC_JTAG_LVL				0x0f0
+#define QSERDES_V5_5NM_RX_AC_JTAG_MODE				0x0f4
+#define QSERDES_V5_5NM_RX_AC_JTAG_RESET				0x0f8
+#define QSERDES_V5_5NM_RX_RX_RCVR_IQ_EN				0x0fc
+#define QSERDES_V5_5NM_RX_RX_Q_EN_RATES				0x100
+#define QSERDES_V5_5NM_RX_RX_IDAC_I0_DC_OFFSETS			0x104
+#define QSERDES_V5_5NM_RX_RX_IDAC_I0BAR_DC_OFFSETS		0x108
+#define QSERDES_V5_5NM_RX_RX_IDAC_I1_DC_OFFSETS			0x10c
+#define QSERDES_V5_5NM_RX_RX_IDAC_I1BAR_DC_OFFSETS		0x110
+#define QSERDES_V5_5NM_RX_RX_IDAC_Q_DC_OFFSETS			0x114
+#define QSERDES_V5_5NM_RX_RX_IDAC_QBAR_DC_OFFSETS		0x118
+#define QSERDES_V5_5NM_RX_RX_IDAC_A_DC_OFFSETS			0x11c
+#define QSERDES_V5_5NM_RX_RX_IDAC_ABAR_DC_OFFSETS		0x120
+#define QSERDES_V5_5NM_RX_RX_IDAC_EN				0x124
+#define QSERDES_V5_5NM_RX_RX_IDAC_ENABLES			0x128
+#define QSERDES_V5_5NM_RX_RX_IDAC_SIGN				0x12c
+#define QSERDES_V5_5NM_RX_RX_IVCM_CAL_CODE_OVERRIDE		0x130
+#define QSERDES_V5_5NM_RX_RX_IVCM_CAL_CTRL1			0x134
+#define QSERDES_V5_5NM_RX_RX_IVCM_CAL_CTRL2			0x138
+#define QSERDES_V5_5NM_RX_RX_IVCM_POSTCAL_OFFSET		0x13c
+#define QSERDES_V5_5NM_RX_RX_SUMMER_CAL_SPD_MODE		0x140
+#define QSERDES_V5_5NM_RX_RX_HIGHZ_PARRATE			0x144
+#define QSERDES_V5_5NM_RX_RX_TERM_AC_BYPASS_DC_COUPLE_OFFSET	0x148
+#define QSERDES_V5_5NM_RX_DFE_1					0x14c
+#define QSERDES_V5_5NM_RX_DFE_2					0x150
+#define QSERDES_V5_5NM_RX_DFE_3					0x154
+#define QSERDES_V5_5NM_RX_DFE_4					0x158
+#define QSERDES_V5_5NM_RX_DFE_TAP3_CTRL				0x15c
+#define QSERDES_V5_5NM_RX_DFE_TAP3_MANVAL_KTAP			0x160
+#define QSERDES_V5_5NM_RX_DFE_TAP4_CTRL				0x164
+#define QSERDES_V5_5NM_RX_DFE_TAP4_MANVAL_KTAP			0x168
+#define QSERDES_V5_5NM_RX_DFE_TAP5_CTRL				0x16c
+#define QSERDES_V5_5NM_RX_DFE_TAP5_MANVAL_KTAP			0x170
+#define QSERDES_V5_5NM_RX_TX_ADPT_CTRL				0x174
+#define QSERDES_V5_5NM_RX_DFE_DAC_ENABLE1			0x178
+#define QSERDES_V5_5NM_RX_DFE_DAC_ENABLE2			0x17c
+#define QSERDES_V5_5NM_RX_TX_ADAPT_PRE_THRESH1			0x180
+#define QSERDES_V5_5NM_RX_TX_ADAPT_PRE_THRESH2			0x184
+#define QSERDES_V5_5NM_RX_TX_ADAPT_POST_THRESH1			0x188
+#define QSERDES_V5_5NM_RX_TX_ADAPT_POST_THRESH2			0x18c
+#define QSERDES_V5_5NM_RX_TX_ADAPT_MAIN_THRESH1			0x190
+#define QSERDES_V5_5NM_RX_TX_ADAPT_MAIN_THRESH2			0x194
+#define QSERDES_V5_5NM_RX_VGA_CAL_CNTRL1			0x198
+#define QSERDES_V5_5NM_RX_VGA_CAL_CNTRL2			0x19c
+#define QSERDES_V5_5NM_RX_VGA_CAL_MAN_VAL			0x1a0
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_CNTRL1			0x1a4
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_CNTRL2			0x1a8
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_MAN_VAL_RATE0		0x1ac
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_MAN_VAL_RATE1		0x1b0
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_MAN_VAL_RATE2		0x1b4
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_MAN_VAL_RATE3		0x1b8
+#define QSERDES_V5_5NM_RX_GM_CAL				0x1bc
+#define QSERDES_V5_5NM_RX_RX_VGA_GAIN2_BLK1			0x1c0
+#define QSERDES_V5_5NM_RX_RX_VGA_GAIN2_BLK2			0x1c4
+#define QSERDES_V5_5NM_RX_RX_EQU_ADAPTOR_CNTRL2			0x1c8
+#define QSERDES_V5_5NM_RX_RX_EQU_ADAPTOR_CNTRL3			0x1cc
+#define QSERDES_V5_5NM_RX_RX_EQU_ADAPTOR_CNTRL4			0x1d0
+#define QSERDES_V5_5NM_RX_RX_IDAC_TSETTLE_LOW			0x1d4
+#define QSERDES_V5_5NM_RX_RX_EQ_OFFSET_LSB			0x1d8
+#define QSERDES_V5_5NM_RX_RX_EQ_OFFSET_MSB			0x1dc
+#define QSERDES_V5_5NM_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x1e0
+#define QSERDES_V5_5NM_RX_RX_OFFSET_ADAPTOR_CNTRL2		0x1e4
+#define QSERDES_V5_5NM_RX_SIGDET_ENABLES			0x1e8
+#define QSERDES_V5_5NM_RX_SIGDET_CNTRL				0x1ec
+#define QSERDES_V5_5NM_RX_SIGDET_LVL				0x1f0
+#define QSERDES_V5_5NM_RX_SIGDET_DEGLITCH_CNTRL			0x1f4
+#define QSERDES_V5_5NM_RX_CDR_FREEZE_UP_DN			0x1f8
+#define QSERDES_V5_5NM_RX_CDR_RESET_OVERRIDE			0x1fc
+#define QSERDES_V5_5NM_RX_RX_INTERFACE_MODE			0x200
+#define QSERDES_V5_5NM_RX_JITTER_GEN_MODE			0x204
+#define QSERDES_V5_5NM_RX_SJ_AMP1				0x208
+#define QSERDES_V5_5NM_RX_SJ_AMP2				0x20c
+#define QSERDES_V5_5NM_RX_SJ_PER1				0x210
+#define QSERDES_V5_5NM_RX_SJ_PER2				0x214
+#define QSERDES_V5_5NM_RX_PPM_OFFSET1				0x218
+#define QSERDES_V5_5NM_RX_PPM_OFFSET2				0x21c
+#define QSERDES_V5_5NM_RX_SIGN_PPM_PERIOD1			0x220
+#define QSERDES_V5_5NM_RX_SIGN_PPM_PERIOD2			0x224
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B0			0x228
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B1			0x22c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B2			0x230
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B3			0x234
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B4			0x238
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B5			0x23c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B6			0x240
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B7			0x244
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B0			0x248
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B1			0x24c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B2			0x250
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B3			0x254
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B4			0x258
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B5			0x25c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B6			0x260
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B7			0x264
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B0			0x268
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B1			0x26c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B2			0x270
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B3			0x274
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B4			0x278
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B5			0x27c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B6			0x280
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B7			0x284
+#define QSERDES_V5_5NM_RX_PHPRE_CTRL				0x288
+#define QSERDES_V5_5NM_RX_PHPRE_INITVAL				0x28c
+#define QSERDES_V5_5NM_RX_DFE_EN_TIMER				0x290
+#define QSERDES_V5_5NM_RX_DFE_CTLE_POST_CAL_OFFSET		0x294
+#define QSERDES_V5_5NM_RX_DCC_CTRL1				0x298
+#define QSERDES_V5_5NM_RX_DCC_CTRL2				0x29c
+#define QSERDES_V5_5NM_RX_DCC_OFFSET				0x2a0
+#define QSERDES_V5_5NM_RX_DCC_CMUX_POSTCAL_OFFSET		0x2a4
+#define QSERDES_V5_5NM_RX_DCC_CMUX_CAL_CTRL1			0x2a8
+#define QSERDES_V5_5NM_RX_DCC_CMUX_CAL_CTRL2			0x2ac
+#define QSERDES_V5_5NM_RX_ALOG_OBSV_BUS_CTRL_1			0x2b0
+#define QSERDES_V5_5NM_RX_RX_MARG_CTRL1				0x2b4
+#define QSERDES_V5_5NM_RX_RX_MARG_CTRL2				0x2b8
+#define QSERDES_V5_5NM_RX_RX_MARG_CTRL3				0x2bc
+#define QSERDES_V5_5NM_RX_RX_MARG_CTRL_4			0x2c0
+#define QSERDES_V5_5NM_RX_RX_MARG_CFG_RATE_0_1			0x2c4
+#define QSERDES_V5_5NM_RX_RX_MARG_CFG_RATE_2_3			0x2c8
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_CTRL1			0x2cc
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_CTRL2			0x2d0
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH1_RATE210	0x2d4
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH1_RATE3		0x2d8
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH2_RATE210	0x2dc
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH2_RATE3		0x2e0
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH3_RATE210	0x2e4
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH3_RATE3		0x2e8
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH4_RATE210	0x2ec
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH4_RATE3		0x2f0
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH5_RATE210	0x2f4
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH5_RATE3		0x2f8
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH6_RATE210	0x2fc
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH6_RATE3		0x300
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH7_RATE210	0x304
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH7_RATE3		0x308
+#define QSERDES_V5_5NM_RX_Q_PI_INTRINSIC_BIAS_RATE10		0x30c
+#define QSERDES_V5_5NM_RX_Q_PI_INTRINSIC_BIAS_RATE32		0x310
+#define QSERDES_V5_5NM_RX_RX_MARG_VERTICAL_CTRL			0x314
+#define QSERDES_V5_5NM_RX_RX_MARG_VERTICAL_CODE			0x318
+#define QSERDES_V5_5NM_RX_RES_CODE_THRESH_HIGH_AND_BYP		0x31c
+#define QSERDES_V5_5NM_RX_RES_CODE_THRESH_LOW			0x320
+#define QSERDES_V5_5NM_RX_RX_BKUP_CTRL1				0x324
+#define QSERDES_V5_5NM_RX_RX_BKUP_CTRL2				0x328
+#define QSERDES_V5_5NM_RX_RX_BKUP_CTRL3				0x32c
+#define QSERDES_V5_5NM_RX_PI_CTRL1				0x330
+#define QSERDES_V5_5NM_RX_PI_CTRL2				0x334
+#define QSERDES_V5_5NM_RX_PI_QUAD				0x338
+#define QSERDES_V5_5NM_RX_QPI_CTRL1				0x33c
+#define QSERDES_V5_5NM_RX_QPI_CTRL2				0x340
+#define QSERDES_V5_5NM_RX_QPI_QUAD				0x344
+#define QSERDES_V5_5NM_RX_IDATA1				0x348
+#define QSERDES_V5_5NM_RX_IDATA2				0x34c
+#define QSERDES_V5_5NM_RX_IDATA3				0x350
+#define QSERDES_V5_5NM_RX_AC_JTAG_OUTP				0x354
+#define QSERDES_V5_5NM_RX_AC_JTAG_OUTN				0x358
+#define QSERDES_V5_5NM_RX_RX_SIGDET				0x35c
+#define QSERDES_V5_5NM_RX_ALOG_OBSV_BUS_STATUS_1		0x360
+#define QSERDES_V5_5NM_RX_READ_EQCODE				0x364
+#define QSERDES_V5_5NM_RX_READ_OFFSETCODE			0x368
+#define QSERDES_V5_5NM_RX_IA_ERROR_COUNTER_LOW			0x36c
+#define QSERDES_V5_5NM_RX_IA_ERROR_COUNTER_HIGH			0x370
+#define QSERDES_V5_5NM_RX_VGA_READ_CODE				0x374
+#define QSERDES_V5_5NM_RX_VTHRESH_READ_CODE			0x378
+#define QSERDES_V5_5NM_RX_DFE_TAP1_READ_CODE			0x37c
+#define QSERDES_V5_5NM_RX_DFE_TAP2_READ_CODE			0x380
+#define QSERDES_V5_5NM_RX_DFE_TAP3_READ_CODE			0x384
+#define QSERDES_V5_5NM_RX_DFE_TAP4_READ_CODE			0x388
+#define QSERDES_V5_5NM_RX_DFE_TAP5_READ_CODE			0x38c
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_I0			0x390
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_I0BAR			0x394
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_I1			0x398
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_I1BAR			0x39c
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_Q				0x3a0
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_QBAR			0x3a4
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_A				0x3a8
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_ABAR			0x3ac
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_SM_ON			0x3b0
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_SIGNERROR			0x3b4
+#define QSERDES_V5_5NM_RX_IVCM_CAL_STATUS			0x3b8
+#define QSERDES_V5_5NM_RX_IVCM_CAL_DEBUG_STATUS			0x3bc
+#define QSERDES_V5_5NM_RX_DCC_CAL_STATUS			0x3c0
+#define QSERDES_V5_5NM_RX_DCC_READ_CODE_STATUS			0x3c4
+#define QSERDES_V5_5NM_RX_RX_MARG_DEBUG1_STATUS			0x3c8
+#define QSERDES_V5_5NM_RX_RX_MARG_DEBUG2_STATUS			0x3cc
+#define QSERDES_V5_5NM_RX_RX_MARG_READ_CODE_STATUS		0x3d0
+#define QSERDES_V5_5NM_RX_EOM_ERR_CNT_LSB_STATUS		0x3d4
+#define QSERDES_V5_5NM_RX_EOM_ERR_CNT_MSB_STATUS		0x3d8
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_TUNE_STATUS		0x3dc
+#define QSERDES_V5_5NM_RX_RX_BKUP_READ_BUS1_STATUS		0x3e0
+#define QSERDES_V5_5NM_RX_RX_BKUP_READ_BUS2_STATUS		0x3e4
+#define QSERDES_V5_5NM_RX_RX_BKUP_READ_BUS3_STATUS		0x3e8
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index b139c8af5e8b..26274e3c0cf9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -19,6 +19,7 @@
 #include "phy-qcom-qmp-qserdes-com-v5.h"
 #include "phy-qcom-qmp-qserdes-txrx-v5.h"
 #include "phy-qcom-qmp-qserdes-txrx-v5_20.h"
+#include "phy-qcom-qmp-qserdes-txrx-v5_5nm.h"
 
 #include "phy-qcom-qmp-qserdes-pll.h"
 
-- 
2.35.1

