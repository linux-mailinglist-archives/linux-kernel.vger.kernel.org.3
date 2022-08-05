Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEED858AD25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiHEPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiHEPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:41:50 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F202715A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:41:48 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10cf9f5b500so3350742fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lOl/GNDv/KDZqcxla19dOB87ZLzXemHoorThzLeF0nk=;
        b=SEg2h8EVLAfFh7GhldRUFlAwtZoATfI03IG9hm1z4XE4v5EpzjDBGOCLaq2Tra2uM3
         Z/W8+5F2Iyx4aIttXSjr1k33Uvt9OeoHkJ+IeKybmB5ARUPYN7HoU2LoOI+hXYkMR1vo
         rXJRVGq7y/KqWHVdL7njjI6ji/KFmZFLgg4BejAgcPPLGxQR0irCMnGvSLDG4iSQgj3X
         5FV+XK8hjXV6qEpYIqfN9ASatNMKYP/vHlpEGyXuZahlH9Ar41d2Pgr1UMK6c+2y7DtM
         3CLYwZcPacIcYKdAVIsZLo6EhRJp8KPO49vHBwBAJlpvE5bVP6RpBtB0ADO46+mV5N11
         RfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lOl/GNDv/KDZqcxla19dOB87ZLzXemHoorThzLeF0nk=;
        b=k7SqwNjMoriosLgI1HIeR5zIxgvY6+a9YGRrLbOPZbeswvZhXARwVnOiPaJP62sw/E
         HiwIsZiAAZp9XEJAN25TGLHh4Er/uxnModGHana64yYK5SbAd0eH1gO6mmjQLzwlNdk2
         Libp6uSks7Eboqq1Wvl4+9odMKp+35TUc0vBn4S+rSJoK93s6uQhOI08UutU+gozB4LD
         YzWkBaHcGVFeRTsprAD5GHHgsbwkRrMDLVHE1coFy4JVakgOCaHxzwobu+fLp8oLeKh1
         b9czmJDmShpspktsmUJi91VLdXJH6zL1Tl3+wlatMJ/ycfERjKmKl+WmYhsNhljG32Fn
         3oOA==
X-Gm-Message-State: ACgBeo1AluBsB8lXfUs8E9BzMThDwyHv/huOliJlhH6ywp4/EAzaYcYN
        06S7VHEv6DZYLLeluxzUnimBbw==
X-Google-Smtp-Source: AA6agR7S++p3NhUJDcoiw3cYSM27nFYZSPnG8O9ctA346/+CKhxkqi2xphHJwmSQ1ttlZUzT9zVrtQ==
X-Received: by 2002:a05:6870:5591:b0:10e:20d0:b2cb with SMTP id n17-20020a056870559100b0010e20d0b2cbmr6746473oao.12.1659714108120;
        Fri, 05 Aug 2022 08:41:48 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l15-20020a4a854f000000b004357c1d1efasm753500ooh.21.2022.08.05.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:41:47 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: [PATCH] phy: qcom: edp: Postpone clk_set_rate until the PLL is up
Date:   Fri,  5 Aug 2022 08:44:32 -0700
Message-Id: <20220805154432.546740-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
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

When the platform was booted with the involved clocks enabled the
clk_set_rate() of the link and pixel clocks will perculate to the
children, which will fail to update because the PHY driver has just shut
down the PLL.

Postpone the clock rate updates until the PLL is back online to avoid
reconfiguring the clocks while the PLL is not ticking.

Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 7e3570789845..b66b83c388ed 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -272,31 +272,30 @@ static int qcom_edp_configure_pll(const struct qcom_edp *edp)
 	return 0;
 }
 
-static int qcom_edp_set_vco_div(const struct qcom_edp *edp)
+static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel_freq)
 {
 	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
-	unsigned long pixel_freq;
 	u32 vco_div;
 
 	switch (dp_opts->link_rate) {
 	case 1620:
 		vco_div = 0x1;
-		pixel_freq = 1620000000UL / 2;
+		*pixel_freq = 1620000000UL / 2;
 		break;
 
 	case 2700:
 		vco_div = 0x1;
-		pixel_freq = 2700000000UL / 2;
+		*pixel_freq = 2700000000UL / 2;
 		break;
 
 	case 5400:
 		vco_div = 0x2;
-		pixel_freq = 5400000000UL / 4;
+		*pixel_freq = 5400000000UL / 4;
 		break;
 
 	case 8100:
 		vco_div = 0x0;
-		pixel_freq = 8100000000UL / 6;
+		*pixel_freq = 8100000000UL / 6;
 		break;
 
 	default:
@@ -306,15 +305,13 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp)
 
 	writel(vco_div, edp->edp + DP_PHY_VCO_DIV);
 
-	clk_set_rate(edp->dp_link_hw.clk, dp_opts->link_rate * 100000);
-	clk_set_rate(edp->dp_pixel_hw.clk, pixel_freq);
-
 	return 0;
 }
 
 static int qcom_edp_phy_power_on(struct phy *phy)
 {
 	const struct qcom_edp *edp = phy_get_drvdata(phy);
+	unsigned long pixel_freq;
 	int timeout;
 	int ret;
 	u32 val;
@@ -363,7 +360,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	writel(0x01, edp->tx1 + TXn_TRAN_DRVR_EMP_EN);
 	writel(0x04, edp->tx1 + TXn_TX_BAND);
 
-	ret = qcom_edp_set_vco_div(edp);
+	ret = qcom_edp_set_vco_div(edp, &pixel_freq);
 	if (ret)
 		return ret;
 
@@ -409,8 +406,15 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 
 	writel(0x19, edp->edp + DP_PHY_CFG);
 
-	return readl_poll_timeout(edp->edp + DP_PHY_STATUS,
-				  val, val & BIT(1), 500, 10000);
+	ret = readl_poll_timeout(edp->edp + DP_PHY_STATUS,
+				 val, val & BIT(1), 500, 10000);
+	if (ret)
+		return ret;
+
+	clk_set_rate(edp->dp_link_hw.clk, edp->dp_opts.link_rate * 100000);
+	clk_set_rate(edp->dp_pixel_hw.clk, pixel_freq);
+
+	return 0;
 }
 
 static int qcom_edp_phy_power_off(struct phy *phy)
-- 
2.35.1

