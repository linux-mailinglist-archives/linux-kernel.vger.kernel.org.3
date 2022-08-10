Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB058E52E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiHJDJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiHJDJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:09:29 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309807E330
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:09:28 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10e6bdbe218so16319475fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=o9OOX4mTumeWxGfGIlGSIHTnrvS7ZQdKXUpha8Z8G0Q=;
        b=mvbuZ5hQummlWWhg00HRmOlySExapbkSXpopIHAchaI/l9L9Owj7hr2qdU5nu87Igc
         dacKD61RGtwXYkr0sTVXKXrzgY3xvTHgQ+Lehcnhpyl2BwARsLcdWLkj6tPImLHYI1zh
         cL7jXyavKoPjc5kysLDJyu3m3eg4+DmwUPGGctCCUcQnwfinQ3/d0LrTn4ASKeKfGpCq
         xRO846gyQce4nRdTzGcYnC/phkrGLEZSEK90f4uiatkv8JrR+dSRhsmbWPMAbvSylrKY
         s3JpJzu7CL87x3xOiech525P0Kp+9Q8O6dNN16WRy9nYEqKsUX93//4DLHwMmiG8ERU1
         ofng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=o9OOX4mTumeWxGfGIlGSIHTnrvS7ZQdKXUpha8Z8G0Q=;
        b=0UNUuHRx45M4bFH/K/KVWfdteVZuoeMOcKxAMNNvwwQLI2YIxcbis3ytUyj08F6CKO
         yOdneQlpOqJ9JZ9Zd49GW5LSzEMfgR8EUR4jGQDdSt72EBaD9Rh21ngQ27N4217JxW/X
         0c5vXwJhbQGSFijOjSwjubiKYWr8tfC42e0qeCOfV9vGhXguYx1kjIO5lQjyqXW8+3vh
         ThKz4/8PJX63YQdfBl0axw1uwe7RGnG9Tw1Vt8XoXRLygqUWeHMgl6nve+TldCTLVZ3W
         DAHGiYay2biAQcoTRFzb30EkrPkNfjSv6B+12qPgFPP2QnAadvAbs6yOzghNXLgMfx8+
         Dw2Q==
X-Gm-Message-State: ACgBeo1/B7bAiqREbK3lrk06WJH7pMOYZONAhmH7DJjaf1Deg0STUU6R
        IZt3enSLfG4dsYUNpdr4YRFNSA==
X-Google-Smtp-Source: AA6agR7iTviPqVEw9B40nZ6Lak0B2tK8eToZFcYqTh1tYtSeNKzqauHW0s6cZwkBd15XPi75I7n/EA==
X-Received: by 2002:a05:6871:7a7:b0:10d:3fb6:b632 with SMTP id o39-20020a05687107a700b0010d3fb6b632mr599519oap.237.1660100967558;
        Tue, 09 Aug 2022 20:09:27 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id ba41-20020a056870c5a900b00101c76f7831sm3586268oab.24.2022.08.09.20.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:09:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: qualcomm: phy-qcom-qmp: add support for combo USB3+DP phy on SDM845
Date:   Tue,  9 Aug 2022 22:09:26 -0500
Message-Id: <20220810030926.2794179-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.37.1
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Define configuration to be used by combo USB3 + DisplayPort phy on
SDM845 SoC family. It closely follows sc7180, however like the main USB3
phy it uses the qmp_v3_usb3phy_cfg config.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 41 +++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 4b1828976104..e9722d8aae59 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -903,6 +903,43 @@ static const struct qmp_phy_combo_cfg sc7180_usb3dpphy_cfg = {
 	.dp_cfg			= &sc7180_dpphy_cfg,
 };
 
+static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
+	.type			= PHY_TYPE_USB3,
+	.nlanes			= 1,
+
+	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
+	.tx_tbl			= qmp_v3_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_tx_tbl),
+	.rx_tbl			= qmp_v3_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_rx_tbl),
+	.pcs_tbl		= qmp_v3_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_pcs_tbl),
+	.clk_list		= qmp_v3_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
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
+static const struct qmp_phy_combo_cfg sdm845_usb3dpphy_cfg = {
+	.usb_cfg                = &sdm845_usb3phy_cfg,
+	.dp_cfg                 = &sc7180_dpphy_cfg,
+};
+
 static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -2441,6 +2478,10 @@ static const struct of_device_id qcom_qmp_combo_phy_of_match_table[] = {
 		.compatible = "qcom,sc7180-qmp-usb3-dp-phy",
 		.data = &sc7180_usb3dpphy_cfg,
 	},
+	{
+		.compatible = "qcom,sdm845-qmp-usb3-dp-phy",
+		.data = &sdm845_usb3dpphy_cfg,
+	},
 	{
 		.compatible = "qcom,sm8250-qmp-usb3-dp-phy",
 		.data = &sm8250_usb3dpphy_cfg,
-- 
2.37.1

