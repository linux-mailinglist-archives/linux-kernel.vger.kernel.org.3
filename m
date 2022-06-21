Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0057D553A90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353938AbiFUTa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353900AbiFUTa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:30:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D72B273;
        Tue, 21 Jun 2022 12:30:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z19so3911056edb.11;
        Tue, 21 Jun 2022 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wdHBkj+4ZdkV/uUFyg2QTppwSfxAOXkl09rOiaLgUXs=;
        b=dLzY7d6dJY68lARzRFWqIRmufc21HOmI8w11oARO3czwKsRXiBJ+rW8BNh+s2Ss7q/
         R2Ha7Jvro/JjRGT43SiijsW8Zxep66KGQov30/vTcRPlvj+OojYYR6/+ndrLb/7FmAU9
         0qunuPM0gZ8eG1JW1O+FSTjJq1uuZa2zHvGqvNDbHRPJzXeImG0JFrB8BjkG40NCvCQy
         Qhh2urMTxaSpwgedSRz83ug/yy05XrY1waMxPZ/GJ2Y8Nz+2RPJpJ/fhy2tfYAiZCwOm
         ySisZ3ghDFfaLFmUW/Ycx+WAGM7+2BfmE+OJQd2pw+W2QCgdeYVnQsnxMtLc2zqpoieF
         821g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wdHBkj+4ZdkV/uUFyg2QTppwSfxAOXkl09rOiaLgUXs=;
        b=wRwbbVAr+bcOKkslrP9WiCqUzAJGKfpeulLj4l7x6lq4yijFZpg1aboUEfg79WKmN4
         hh4jPXvD+RVEOIIsPKw9YZDgtdbPdv76G7AThFr8bnvSArOZYo6Il5hkA1HDWXndksP5
         x+T6cfCHMLhWoIRM4Shn6tSQAXhsN7QIywa+MBmjOLI29X4/dza5uPunVq4CSzJn7MbL
         MDPb0Zy/nMO+0INbtXazk3BIeyWbuUI7ovKLDcPFCRYrnv8nwRDAPyJZL+1lkv3xcNkI
         uCEGjz+7LplseAYw9Uo143vrppZa/vVi7mROcfh8qc6e/PwLymB+yZQCO2EokVUJmcLt
         COog==
X-Gm-Message-State: AJIora///xcErUFKEBK1GUAWefGsXxvA0Yz+plNOkXU1po2J+Ve4yq4I
        6LoZSs0NEtUIsJgrRoHY7z0=
X-Google-Smtp-Source: AGRyM1si+I5bosOC9QK73GZXOx1sWqFcTOU6m3eCUm6K/R01xsSrdGFR1yLNvFylmZXSPCeveAZoZA==
X-Received: by 2002:a05:6402:e9f:b0:435:644e:4a7d with SMTP id h31-20020a0564020e9f00b00435644e4a7dmr27800636eda.114.1655839823310;
        Tue, 21 Jun 2022 12:30:23 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-158.xnet.hr. [88.207.99.158])
        by smtp.googlemail.com with ESMTPSA id f5-20020a1709064dc500b00706287ba061sm8020586ejw.180.2022.06.21.12.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:30:22 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 1/3] phy: qcom-qmp-pcie: make pipe clock rate configurable
Date:   Tue, 21 Jun 2022 21:30:18 +0200
Message-Id: <20220621193020.1630180-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

IPQ8074 Gen3 PCIe PHY uses 250MHz as the pipe clock rate instead of 125MHz
like every other PCIe QMP PHY does, so make it configurable as part of the
qmp_phy_cfg.

Set all of the current configs to use 125MHz as currently done.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 28 ++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index b2cd0cf965d8..4dc4d4f8547e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1284,6 +1284,9 @@ struct qmp_phy_cfg {
 
 	/* true, if PHY has secondary tx/rx lanes to be configured */
 	bool is_dual_lane_phy;
+
+	/* QMP PHY pipe clock interface rate */
+	unsigned long pipe_clock_rate;
 };
 
 /**
@@ -1419,6 +1422,8 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
@@ -1447,6 +1452,8 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
@@ -1478,6 +1485,8 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
@@ -1507,6 +1516,8 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
@@ -1546,6 +1557,8 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
@@ -1586,6 +1599,8 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
@@ -1611,6 +1626,8 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 	.start_ctrl             = SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS,
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
@@ -1641,6 +1658,8 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
@@ -1673,6 +1692,8 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
@@ -1704,6 +1725,8 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
@@ -1736,6 +1759,8 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= 995,		/* us */
 	.pwrdn_delay_max	= 1005,		/* us */
+
+	.pipe_clock_rate	= 125000000,
 };
 
 static void qcom_qmp_phy_pcie_configure_lane(void __iomem *base,
@@ -2121,8 +2146,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 
 	init.ops = &clk_fixed_rate_ops;
 
-	/* controllers using QMP phys use 125MHz pipe clock interface */
-	fixed->fixed_rate = 125000000;
+	fixed->fixed_rate = qmp->phys[0]->cfg->pipe_clock_rate;
 	fixed->hw.init = &init;
 
 	ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
-- 
2.36.1

