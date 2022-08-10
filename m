Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0E058E62F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiHJEUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiHJEU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:20:29 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B6E61107
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:20:28 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10ec41637b3so16484289fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aTVS8f/JSGyOOMcrFh4jL8jY1rjH9L8QtIyJGu4bZbg=;
        b=UbDArE4Pm+4oFBPvXUjJE4EoZgtYV9m3CueDS2qdf8YWgi+l42QLpZ68A4Lv9o7tqH
         07FFDU/PBmRCnKboo2CsnrevXhfuIDSqxTJuHnzXZbQfP2UJO4BVvN4GVu8DLNEv1D/T
         0uj8XPWKSyIbIr6I5CSzukQEMizAk/5tAvzOX4hpiHn9532MpmnU1wkXCz0c/2S8Kbgq
         lF8m34ROzx6z9l8jf+iSgAlvIOhVFqJjX8uZQyjdn7ei8cMgrFumxxRcXvx7s7n9RP+2
         8sAuLc3PyPf40YmqOIt8KYfYa4RM8nV5gjZq499vEmmMdoZngOse8NQ60sG47y9K0J1/
         dhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aTVS8f/JSGyOOMcrFh4jL8jY1rjH9L8QtIyJGu4bZbg=;
        b=QLUfdm9pJDm7wuoZEZyElb64LQ42d3xBvbNNKINXUDV5v639e78oH/9+Z5RwJ0HJF0
         HE1MXv2+eGoHwNCbAcZO8Th1MOsVna8TdKGsi9fIfByhrGqqEJbYbcOQcHd13fFO9HZq
         OsqNDpNo43BvaUuEqKGb41SkhK0eXzqsuJFq4blwMXWqVYO2kMfpqfCPr45qdZmvOXdz
         OAQ/0/4I78B0Ar209sJxaCBL00niMcGtFLAgHnHwefIljLi++ltS9V4zPVSNwuFKewtg
         nOYjcz10oMfn6fEN8P6+b0OSGdSNyjN+hVVt+A8QbDAL8aceCwny4666DaLWWPnfTn9L
         9v2Q==
X-Gm-Message-State: ACgBeo14JoNQ6Z1jNxNG+b2iPrpuLmgfpY6sMxzoGftR8xcnKCZtlPid
        7sEZEEZ/ejFn/27+s7jDs945Hw==
X-Google-Smtp-Source: AA6agR4UKF+PdbNUWHpNnCTV5ClF7spXKeVP1b6Jdvjb7hAcOkhJl5oQPyj45SrN8yVoTmlba9+meQ==
X-Received: by 2002:a05:6870:959b:b0:115:856b:4444 with SMTP id k27-20020a056870959b00b00115856b4444mr667224oao.114.1660105227440;
        Tue, 09 Aug 2022 21:20:27 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id ba41-20020a056870c5a900b00101c76f7831sm3622747oab.24.2022.08.09.21.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 21:20:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] phy: qcom-qmp-combo: Parameterize swing and pre_emphasis tables
Date:   Tue,  9 Aug 2022 21:23:01 -0700
Message-Id: <20220810042303.3583194-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220810042303.3583194-1-bjorn.andersson@linaro.org>
References: <20220810042303.3583194-1-bjorn.andersson@linaro.org>
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

The swing and pre-emphasis tables differ between different PHY versions,
or perhaps between different platforms. In particular in order to
introduce SC8280XP these tables needs to be replaced.

Make it possible to specify these tables per PHY config.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 86 ++++++++++++++---------
 1 file changed, 54 insertions(+), 32 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 4b1828976104..c6ddb0be1045 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -618,6 +618,34 @@ static struct qmp_regulator_data qmp_phy_vreg_l[] = {
 	{ .name = "vdda-pll", .enable_load = 36000 },
 };
 
+static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[4][4] = {
+	{ 0x00, 0x0c, 0x15, 0x1a },
+	{ 0x02, 0x0e, 0x16, 0xff },
+	{ 0x02, 0x11, 0xff, 0xff },
+	{ 0x04, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v3_voltage_swing_hbr3_hbr2[4][4] = {
+	{ 0x02, 0x12, 0x16, 0x1a },
+	{ 0x09, 0x19, 0x1f, 0xff },
+	{ 0x10, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v3_pre_emphasis_hbr_rbr[4][4] = {
+	{ 0x00, 0x0c, 0x14, 0x19 },
+	{ 0x00, 0x0b, 0x12, 0xff },
+	{ 0x00, 0x0b, 0xff, 0xff },
+	{ 0x04, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v3_voltage_swing_hbr_rbr[4][4] = {
+	{ 0x08, 0x0f, 0x16, 0x1f },
+	{ 0x11, 0x1e, 0x1f, 0xff },
+	{ 0x19, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff }
+};
+
 struct qmp_phy;
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
@@ -649,6 +677,12 @@ struct qmp_phy_cfg {
 	const struct qmp_phy_init_tbl *serdes_tbl_hbr3;
 	int serdes_tbl_hbr3_num;
 
+	/* DP PHY swing and pre_emphasis tables */
+	const u8 (*swing_hbr_rbr)[4][4];
+	const u8 (*swing_hbr3_hbr2)[4][4];
+	const u8 (*pre_emphasis_hbr_rbr)[4][4];
+	const u8 (*pre_emphasis_hbr3_hbr2)[4][4];
+
 	/* DP PHY callbacks */
 	int (*configure_dp_phy)(struct qmp_phy *qphy);
 	void (*configure_dp_tx)(struct qmp_phy *qphy);
@@ -881,6 +915,11 @@ static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
 	.serdes_tbl_hbr3	= qmp_v3_dp_serdes_tbl_hbr3,
 	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_hbr3),
 
+	.swing_hbr_rbr		= &qmp_dp_v3_voltage_swing_hbr_rbr,
+	.pre_emphasis_hbr_rbr	= &qmp_dp_v3_pre_emphasis_hbr_rbr,
+	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
+	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
+
 	.clk_list		= qmp_v3_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
 	.reset_list		= sc7180_usb3phy_reset_l,
@@ -957,6 +996,11 @@ static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
 	.serdes_tbl_hbr3	= qmp_v4_dp_serdes_tbl_hbr3,
 	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_hbr3),
 
+	.swing_hbr_rbr		= &qmp_dp_v3_voltage_swing_hbr_rbr,
+	.pre_emphasis_hbr_rbr	= &qmp_dp_v3_pre_emphasis_hbr_rbr,
+	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
+	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
+
 	.clk_list		= qmp_v3_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
 	.reset_list		= sc7180_usb3phy_reset_l,
@@ -1032,6 +1076,11 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
 	.serdes_tbl_hbr3	= qmp_v4_dp_serdes_tbl_hbr3,
 	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_hbr3),
 
+	.swing_hbr_rbr		= &qmp_dp_v3_voltage_swing_hbr_rbr,
+	.pre_emphasis_hbr_rbr	= &qmp_dp_v3_pre_emphasis_hbr_rbr,
+	.swing_hbr3_hbr2	= &qmp_dp_v3_voltage_swing_hbr3_hbr2,
+	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v3_pre_emphasis_hbr3_hbr2,
+
 	.clk_list		= qmp_v4_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
 	.reset_list		= msm8996_usb3phy_reset_l,
@@ -1169,38 +1218,11 @@ static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_phy *qphy)
 	       qphy->pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
-static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[4][4] = {
-	{ 0x00, 0x0c, 0x15, 0x1a },
-	{ 0x02, 0x0e, 0x16, 0xff },
-	{ 0x02, 0x11, 0xff, 0xff },
-	{ 0x04, 0xff, 0xff, 0xff }
-};
-
-static const u8 qmp_dp_v3_voltage_swing_hbr3_hbr2[4][4] = {
-	{ 0x02, 0x12, 0x16, 0x1a },
-	{ 0x09, 0x19, 0x1f, 0xff },
-	{ 0x10, 0x1f, 0xff, 0xff },
-	{ 0x1f, 0xff, 0xff, 0xff }
-};
-
-static const u8 qmp_dp_v3_pre_emphasis_hbr_rbr[4][4] = {
-	{ 0x00, 0x0c, 0x14, 0x19 },
-	{ 0x00, 0x0b, 0x12, 0xff },
-	{ 0x00, 0x0b, 0xff, 0xff },
-	{ 0x04, 0xff, 0xff, 0xff }
-};
-
-static const u8 qmp_dp_v3_voltage_swing_hbr_rbr[4][4] = {
-	{ 0x08, 0x0f, 0x16, 0x1f },
-	{ 0x11, 0x1e, 0x1f, 0xff },
-	{ 0x19, 0x1f, 0xff, 0xff },
-	{ 0x1f, 0xff, 0xff, 0xff }
-};
-
 static int qcom_qmp_phy_combo_configure_dp_swing(struct qmp_phy *qphy,
 		unsigned int drv_lvl_reg, unsigned int emp_post_reg)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
+	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	unsigned int v_level = 0, p_level = 0;
 	u8 voltage_swing_cfg, pre_emphasis_cfg;
 	int i;
@@ -1211,11 +1233,11 @@ static int qcom_qmp_phy_combo_configure_dp_swing(struct qmp_phy *qphy,
 	}
 
 	if (dp_opts->link_rate <= 2700) {
-		voltage_swing_cfg = qmp_dp_v3_voltage_swing_hbr_rbr[v_level][p_level];
-		pre_emphasis_cfg = qmp_dp_v3_pre_emphasis_hbr_rbr[v_level][p_level];
+		voltage_swing_cfg = (*cfg->swing_hbr_rbr)[v_level][p_level];
+		pre_emphasis_cfg = (*cfg->pre_emphasis_hbr_rbr)[v_level][p_level];
 	} else {
-		voltage_swing_cfg = qmp_dp_v3_voltage_swing_hbr3_hbr2[v_level][p_level];
-		pre_emphasis_cfg = qmp_dp_v3_pre_emphasis_hbr3_hbr2[v_level][p_level];
+		voltage_swing_cfg = (*cfg->swing_hbr3_hbr2)[v_level][p_level];
+		pre_emphasis_cfg = (*cfg->pre_emphasis_hbr3_hbr2)[v_level][p_level];
 	}
 
 	/* TODO: Move check to config check */
-- 
2.35.1

