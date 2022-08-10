Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6896858E5FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiHJEF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiHJEFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:05:15 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA5B625F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:05:12 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10e615a36b0so16481972fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cH3gEx8fSSVvttzCeah2rBVrmjrn0CZnJ9l69q/KYmY=;
        b=NGQOnE3UkKSNmdlloSP6/pskV7F60rjNepp4GAstvay9+NQ7eYpEi6HgRaf1dbOEW5
         sRM6H78LrFfMKuPQQ+kx67Wfu/ZPeoRcnsjjESolzEdPGGMCiYspMtHEWtWwHRJgZq0b
         CRSWEKuKc6OtJOEFslLDbl1caYV5rwSRjIwYXCc7nOZCbOALE43rAV3RtZFgBgo4pY5H
         3p+uT5hht5KlPtCw14hqylZKyAbBVVAEWn1htr8XdOs0ebwYe9Szu89rDOGjHmr6bXpJ
         4CP/2x5ob1XGTWykZRg4oG1z56IOCO/uL16cvv4xzIaick+Hb9Jh1j3Eve2ApeKeLFGQ
         +eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cH3gEx8fSSVvttzCeah2rBVrmjrn0CZnJ9l69q/KYmY=;
        b=Cu+uCfrIDwyOs/n9NaT/PaC2hwp7err3qqS79ONuvP+RdzpHCEM9vrKju7lNUsM7L0
         rQmEq6ZU3y66cwcyU8aCWErtOPxUfsHMpux76aaPbM4wFNhIanPAON393Gasqnf+cR6O
         zYvsP9ybARt3nvgfeLzQo159IrR9qg1guFe6zW+L1icQp1ZoEoPlREwk2CmTHFzY/yMT
         X/wmky6mUrVHBZVeowsJXQaSJPJ0DWeYZAziO/LQ5bUtvhQIQnZvLXK4QcshLvvU2mnB
         2CgNLpfHapRNRLOY3akQn+wQGvbtk4rxRVyt49mFFU+Xb0DDBUaJUfuVYFvXG0C5sLLX
         kp+Q==
X-Gm-Message-State: ACgBeo2SC7mRoheM1zXkIiS31eKYrqheM9yOhNTS0UFV2Y0jxQ2hZCcN
        CBxcTDfxZm7EUR+uCZBCtPyv7w==
X-Google-Smtp-Source: AA6agR6o2ARcIuuuo86XC0au9dC67ExmDYqSy3iCxd08Q8BeQdcm35NOsnIDmRNUKCYcLUn4xlkntg==
X-Received: by 2002:a05:6870:310e:b0:113:a9bf:57e7 with SMTP id v14-20020a056870310e00b00113a9bf57e7mr668647oaa.219.1660104311205;
        Tue, 09 Aug 2022 21:05:11 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q6-20020a056830440600b00616dfd2c859sm449027otv.59.2022.08.09.21.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 21:05:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] phy: qcom: edp: Perform lane configuration
Date:   Tue,  9 Aug 2022 21:07:43 -0700
Message-Id: <20220810040745.3582985-4-bjorn.andersson@linaro.org>
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

The TRANSCIEVER_BIAS_EN, HIGHZ_DRVR_EN and PHY_CFG_1 registers are used
for lane configuration, with the currently hard coded configuration
being a mix of 2 and 4 lane (effectively 2-lane).

Properly implement lane configuration for 1, 2 and 4 lanes.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 32 ++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 41aa28291cea..32614fb838b5 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -315,9 +315,11 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp)
 static int qcom_edp_phy_power_on(struct phy *phy)
 {
 	const struct qcom_edp *edp = phy_get_drvdata(phy);
+	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
 	int timeout;
 	int ret;
 	u32 val;
+	u8 cfg1;
 
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
@@ -398,11 +400,31 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	writel(0x1f, edp->tx0 + TXn_TX_DRV_LVL);
 	writel(0x1f, edp->tx1 + TXn_TX_DRV_LVL);
 
-	writel(0x4, edp->tx0 + TXn_HIGHZ_DRVR_EN);
-	writel(0x3, edp->tx0 + TXn_TRANSCEIVER_BIAS_EN);
-	writel(0x4, edp->tx1 + TXn_HIGHZ_DRVR_EN);
-	writel(0x0, edp->tx1 + TXn_TRANSCEIVER_BIAS_EN);
-	writel(0x3, edp->edp + DP_PHY_CFG_1);
+	if (edp->dp_opts.lanes == 1) {
+		bias0_en = 0x01;
+		bias1_en = 0x00;
+		drvr0_en = 0x06;
+		drvr1_en = 0x07;
+		cfg1 = 0x1;
+	} else if (edp->dp_opts.lanes == 2) {
+		bias0_en = 0x03;
+		bias1_en = 0x00;
+		drvr0_en = 0x04;
+		drvr1_en = 0x07;
+		cfg1 = 0x3;
+	} else {
+		bias0_en = 0x03;
+		bias1_en = 0x03;
+		drvr0_en = 0x04;
+		drvr1_en = 0x04;
+		cfg1 = 0xf;
+	}
+
+	writel(drvr0_en, edp->tx0 + TXn_HIGHZ_DRVR_EN);
+	writel(bias0_en, edp->tx0 + TXn_TRANSCEIVER_BIAS_EN);
+	writel(drvr1_en, edp->tx1 + TXn_HIGHZ_DRVR_EN);
+	writel(bias1_en, edp->tx1 + TXn_TRANSCEIVER_BIAS_EN);
+	writel(cfg1, edp->edp + DP_PHY_CFG_1);
 
 	writel(0x18, edp->edp + DP_PHY_CFG);
 	usleep_range(100, 1000);
-- 
2.35.1

