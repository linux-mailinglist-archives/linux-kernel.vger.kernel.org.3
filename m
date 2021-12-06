Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D13469F1A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391387AbhLFPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359666AbhLFP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:29:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EE8C08ED88
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:18:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t9so23130098wrx.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MkCaFX+fKMkid7uldA1xTiH54uM3PwF9W50eMPDqnD0=;
        b=x7YBCjtnHCTyGoUBYVloHKXSHr0qwFxm3+zrzuM0KiPj/qPIq+fygoGPbDTtxrQseP
         d5iydHCAR/B6UHC+LLEDBFZ7IHsuYCqD+xH9pXzzXNSKVeCAd5/Gh5h/kFhKwUuzUzzw
         uFy1jyxA9+yvxe8a+kgs+/CGmZy1LHH205pR6NaOv5U2GTj56Pz5aoTsZorlcVkMxdmE
         cIsv3Uja19VRdJNpT85JMIpA1L5R+Tsoun0UmJgh2mQplQNOCeJITZVNzOrjeIovCsb5
         /4FRrhfaAPtNbFJSuGCSs5a0P04S1khThJg8K+2mwPMhD9BaEJWyErdiEWv8Huwmg6Ry
         SkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkCaFX+fKMkid7uldA1xTiH54uM3PwF9W50eMPDqnD0=;
        b=EKtF7mBtTbgZRHk2xmWp/zCkDgz1yu3t/AkQpXAhxmmT+pw/JuzsD8s8NLveWFHgK4
         AqvClMDtbNZCVFigLiEQg37PktI/bltSaWy2oFbfWb0qGyzX7gVIOJULW9qXMQLQyOBT
         Pxg5UWfJe5+WpInnkumY4ARy3ROQjQvD/7rkJxnbJDDSJff0wpAZNp2X4eJOYRGuCma6
         wdviccmNiUd7ZyiTohoFUTItZg3j7HJcO8IsEKuhTd6d57adTksbhjax9Zyhdz1Tr/YM
         HWebbg5FaC1Gl0FFC8LHfapZL9q0lk+8Rb95v1BMlXLJiUI2vJs9UHvXQIAnyUt/5Kib
         q5SA==
X-Gm-Message-State: AOAM531nVUllIvuBLzUoOfm8AaurOdv+Xk3RAp4MJNs+aKNj/RE/f/gZ
        bKCWZCpzhSLATrlHMCrJbBVO1A==
X-Google-Smtp-Source: ABdhPJyqtqdoPeBZrnWvucRAqfeoe3NjuU7FHu9Tm2FywsmMWbmQnYPvTUO1v8TXY6/flwDnNTUaKw==
X-Received: by 2002:adf:c5d1:: with SMTP id v17mr43227869wrg.571.1638803898602;
        Mon, 06 Dec 2021 07:18:18 -0800 (PST)
Received: from xps7590.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id t8sm11784871wrv.30.2021.12.06.07.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:18:18 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v4 1/2] media: camss: csiphy: Move to hardcode CSI Clock Lane number
Date:   Mon,  6 Dec 2021 16:18:10 +0100
Message-Id: <20211206151811.39271-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206151811.39271-1-robert.foss@linaro.org>
References: <20211206151811.39271-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM ISPs do not support having a programmable CSI Clock Lane number.

In order to accurately reflect this, the different CSIPHY HW versions
need to have their own register layer for computing lane masks.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../qcom/camss/camss-csiphy-2ph-1-0.c         | 19 +++++++++++++++--
 .../qcom/camss/camss-csiphy-3ph-1-0.c         | 17 ++++++++++++++-
 .../media/platform/qcom/camss/camss-csiphy.c  | 21 +------------------
 .../media/platform/qcom/camss/camss-csiphy.h  |  7 +++++++
 4 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
index 30b454c369ab..cd4a8c369234 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
@@ -16,6 +16,7 @@
 
 #define CAMSS_CSI_PHY_LNn_CFG2(n)		(0x004 + 0x40 * (n))
 #define CAMSS_CSI_PHY_LNn_CFG3(n)		(0x008 + 0x40 * (n))
+#define		CAMSS_CSI_PHY_LN_CLK		1
 #define CAMSS_CSI_PHY_GLBL_RESET		0x140
 #define CAMSS_CSI_PHY_GLBL_PWR_CFG		0x144
 #define CAMSS_CSI_PHY_GLBL_IRQ_CMD		0x164
@@ -26,6 +27,19 @@
 #define CAMSS_CSI_PHY_GLBL_T_INIT_CFG0		0x1ec
 #define CAMSS_CSI_PHY_T_WAKEUP_CFG0		0x1f4
 
+static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
+{
+	u8 lane_mask;
+	int i;
+
+	lane_mask = 1 << CAMSS_CSI_PHY_LN_CLK;
+
+	for (i = 0; i < lane_cfg->num_data; i++)
+		lane_mask |= 1 << lane_cfg->data[i].pos;
+
+	return lane_mask;
+}
+
 static void csiphy_hw_version_read(struct csiphy_device *csiphy,
 				   struct device *dev)
 {
@@ -105,7 +119,7 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
 
 	for (i = 0; i <= c->num_data; i++) {
 		if (i == c->num_data)
-			l = c->clk.pos;
+			l = CAMSS_CSI_PHY_LN_CLK;
 		else
 			l = c->data[i].pos;
 
@@ -129,7 +143,7 @@ static void csiphy_lanes_disable(struct csiphy_device *csiphy,
 
 	for (i = 0; i <= c->num_data; i++) {
 		if (i == c->num_data)
-			l = c->clk.pos;
+			l = CAMSS_CSI_PHY_LN_CLK;
 		else
 			l = c->data[i].pos;
 
@@ -167,6 +181,7 @@ static irqreturn_t csiphy_isr(int irq, void *dev)
 }
 
 const struct csiphy_hw_ops csiphy_ops_2ph_1_0 = {
+	.get_lane_mask = csiphy_get_lane_mask,
 	.hw_version_read = csiphy_hw_version_read,
 	.reset = csiphy_reset,
 	.lanes_enable = csiphy_lanes_enable,
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index e318c822ab04..cde6b3a10b9e 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -43,6 +43,7 @@
 #define CSIPHY_3PH_LNn_CSI_LANE_CTRL15_SWI_SOT_SYMBOL	0xb8
 
 #define CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(n)	(0x800 + 0x4 * (n))
+#define CSIPHY_3PH_CMN_CSI_COMMON_CTRL5_CLK_ENABLE	BIT(7)
 #define CSIPHY_3PH_CMN_CSI_COMMON_CTRL6_COMMON_PWRDN_B	BIT(0)
 #define CSIPHY_3PH_CMN_CSI_COMMON_CTRL6_SHOW_REV_ID	BIT(1)
 #define CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(n)	(0x8b0 + 0x4 * (n))
@@ -320,6 +321,19 @@ static void csiphy_gen2_config_lanes(struct csiphy_device *csiphy,
 	}
 }
 
+static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
+{
+	u8 lane_mask;
+	int i;
+
+	lane_mask = CSIPHY_3PH_CMN_CSI_COMMON_CTRL5_CLK_ENABLE;
+
+	for (i = 0; i < lane_cfg->num_data; i++)
+		lane_mask |= 1 << lane_cfg->data[i].pos;
+
+	return lane_mask;
+}
+
 static void csiphy_lanes_enable(struct csiphy_device *csiphy,
 				struct csiphy_config *cfg,
 				s64 link_freq, u8 lane_mask)
@@ -331,7 +345,7 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
 
 	settle_cnt = csiphy_settle_cnt_calc(link_freq, csiphy->timer_clk_rate);
 
-	val = BIT(c->clk.pos);
+	val = CSIPHY_3PH_CMN_CSI_COMMON_CTRL5_CLK_ENABLE;
 	for (i = 0; i < c->num_data; i++)
 		val |= BIT(c->data[i].pos * 2);
 
@@ -397,6 +411,7 @@ static void csiphy_lanes_disable(struct csiphy_device *csiphy,
 }
 
 const struct csiphy_hw_ops csiphy_ops_3ph_1_0 = {
+	.get_lane_mask = csiphy_get_lane_mask,
 	.hw_version_read = csiphy_hw_version_read,
 	.reset = csiphy_reset,
 	.lanes_enable = csiphy_lanes_enable,
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 24eec16197e7..ac7e96e6b7cd 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -229,25 +229,6 @@ static int csiphy_set_power(struct v4l2_subdev *sd, int on)
 	return 0;
 }
 
-/*
- * csiphy_get_lane_mask - Calculate CSI2 lane mask configuration parameter
- * @lane_cfg - CSI2 lane configuration
- *
- * Return lane mask
- */
-static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
-{
-	u8 lane_mask;
-	int i;
-
-	lane_mask = 1 << lane_cfg->clk.pos;
-
-	for (i = 0; i < lane_cfg->num_data; i++)
-		lane_mask |= 1 << lane_cfg->data[i].pos;
-
-	return lane_mask;
-}
-
 /*
  * csiphy_stream_on - Enable streaming on CSIPHY module
  * @csiphy: CSIPHY device
@@ -261,7 +242,7 @@ static int csiphy_stream_on(struct csiphy_device *csiphy)
 {
 	struct csiphy_config *cfg = &csiphy->cfg;
 	s64 link_freq;
-	u8 lane_mask = csiphy_get_lane_mask(&cfg->csi2->lane_cfg);
+	u8 lane_mask = csiphy->ops->get_lane_mask(&cfg->csi2->lane_cfg);
 	u8 bpp = csiphy_get_bpp(csiphy->formats, csiphy->nformats,
 				csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
 	u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
index d71b8bc6ec00..1c14947f92d3 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.h
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
@@ -45,6 +45,13 @@ struct csiphy_config {
 struct csiphy_device;
 
 struct csiphy_hw_ops {
+	/*
+	 * csiphy_get_lane_mask - Calculate CSI2 lane mask configuration parameter
+	 * @lane_cfg - CSI2 lane configuration
+	 *
+	 * Return lane mask
+	 */
+	u8 (*get_lane_mask)(struct csiphy_lanes_cfg *lane_cfg);
 	void (*hw_version_read)(struct csiphy_device *csiphy,
 				struct device *dev);
 	void (*reset)(struct csiphy_device *csiphy);
-- 
2.32.0

