Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BB34A38C7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiA3T46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:56:58 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:63832 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiA3T44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643572616; x=1675108616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XRXliMuiPFNwmvhx92801gMtOUDYTx33EDunVRYqLRU=;
  b=psE0/6kTs+qeqVe/f0K4x8UuFl+D1dpDB0M/oJ39d4DSHiWZmksc+JVT
   dtq41JkeejbxZiCchyKoC2GmzKUk0vZmR9at4GhXbY9XCJpF9ak7v9Toc
   8Yyc65pEqe977lOZJJIfcJ7OyWSFqKeanUc5wN/2ivBLayx+Da8cQ6d14
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 Jan 2022 11:56:56 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Jan 2022 11:56:54 -0800
X-QCInternal: smtphost
Received: from rajeevny-linux.qualcomm.com ([10.204.66.121])
  by ironmsg02-blr.qualcomm.com with ESMTP; 31 Jan 2022 01:26:33 +0530
Received: by rajeevny-linux.qualcomm.com (Postfix, from userid 2363605)
        id 9407E21ACE; Mon, 31 Jan 2022 01:26:32 +0530 (IST)
From:   Rajeev Nandan <quic_rajeevny@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Rajeev Nandan <quic_rajeevny@quicinc.com>,
        linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, robh@kernel.org, quic_abhinavk@quicinc.com,
        quic_kalyant@quicinc.com, quic_mkrishn@quicinc.com,
        jonathan@marek.ca, dmitry.baryshkov@linaro.org, airlied@linux.ie,
        daniel@ffwll.ch, swboyd@chromium.org
Subject: [v4 3/3] drm/msm/dsi: Add 10nm dsi phy tuning configuration support
Date:   Mon, 31 Jan 2022 01:26:26 +0530
Message-Id: <1643572586-21331-4-git-send-email-quic_rajeevny@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643572586-21331-1-git-send-email-quic_rajeevny@quicinc.com>
References: <1643572586-21331-1-git-send-email-quic_rajeevny@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock and data lanes of the DSI PHY have a calibration circuitry
feature. As per the MSM DSI PHY tuning guidelines, the drive strength
tuning can be done by adjusting rescode offset for hstop/hsbot, and
the drive level tuning can be done by adjusting the LDO output level
for the HSTX drive.

Signed-off-by: Rajeev Nandan <quic_rajeevny@quicinc.com>
---

Changes in v2:
 - Split into generic code and 10nm-specific part (Dmitry Baryshkov)
 - Fix the backward compatibility (Dmitry Baryshkov)

Changes in v3:
 - Address comments for phy tuning data structure (Dmitry Baryshkov)
 - Make changes as per updated dt-bindings

Changes in v4:
 - Return error in case of out of range values (Dmitry Baryshkov)
 - Return error if dt property is present but parsing is failing


 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c | 118 +++++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
index d8128f5..0a0246c 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
@@ -83,6 +83,18 @@ struct dsi_pll_10nm {
 
 #define to_pll_10nm(x)	container_of(x, struct dsi_pll_10nm, clk_hw)
 
+/**
+ * struct dsi_phy_10nm_tuning_cfg - Holds 10nm PHY tuning config parameters.
+ * @rescode_offset_top: Offset for pull-up legs rescode.
+ * @rescode_offset_bot: Offset for pull-down legs rescode.
+ * @vreg_ctrl: vreg ctrl to drive LDO level
+ */
+struct dsi_phy_10nm_tuning_cfg {
+	u8 rescode_offset_top[DSI_LANE_MAX];
+	u8 rescode_offset_bot[DSI_LANE_MAX];
+	u8 vreg_ctrl;
+};
+
 /*
  * Global list of private DSI PLL struct pointers. We need this for bonded DSI
  * mode, where the master PLL's clk_ops needs access the slave's private data
@@ -747,6 +759,7 @@ static void dsi_phy_hw_v3_0_lane_settings(struct msm_dsi_phy *phy)
 	int i;
 	u8 tx_dctrl[] = { 0x00, 0x00, 0x00, 0x04, 0x01 };
 	void __iomem *lane_base = phy->lane_base;
+	struct dsi_phy_10nm_tuning_cfg *tuning_cfg = phy->tuning_cfg;
 
 	if (phy->cfg->quirks & DSI_PHY_10NM_QUIRK_OLD_TIMINGS)
 		tx_dctrl[3] = 0x02;
@@ -775,10 +788,13 @@ static void dsi_phy_hw_v3_0_lane_settings(struct msm_dsi_phy *phy)
 		dsi_phy_write(lane_base + REG_DSI_10nm_PHY_LN_CFG2(i), 0x0);
 		dsi_phy_write(lane_base + REG_DSI_10nm_PHY_LN_CFG3(i),
 			      i == 4 ? 0x80 : 0x0);
-		dsi_phy_write(lane_base +
-			      REG_DSI_10nm_PHY_LN_OFFSET_TOP_CTRL(i), 0x0);
-		dsi_phy_write(lane_base +
-			      REG_DSI_10nm_PHY_LN_OFFSET_BOT_CTRL(i), 0x0);
+
+		/* platform specific dsi phy drive strength adjustment */
+		dsi_phy_write(lane_base + REG_DSI_10nm_PHY_LN_OFFSET_TOP_CTRL(i),
+				tuning_cfg->rescode_offset_top[i]);
+		dsi_phy_write(lane_base + REG_DSI_10nm_PHY_LN_OFFSET_BOT_CTRL(i),
+				tuning_cfg->rescode_offset_bot[i]);
+
 		dsi_phy_write(lane_base + REG_DSI_10nm_PHY_LN_TX_DCTRL(i),
 			      tx_dctrl[i]);
 	}
@@ -799,6 +815,7 @@ static int dsi_10nm_phy_enable(struct msm_dsi_phy *phy,
 	u32 const timeout_us = 1000;
 	struct msm_dsi_dphy_timing *timing = &phy->timing;
 	void __iomem *base = phy->base;
+	struct dsi_phy_10nm_tuning_cfg *tuning_cfg = phy->tuning_cfg;
 	u32 data;
 
 	DBG("");
@@ -834,8 +851,9 @@ static int dsi_10nm_phy_enable(struct msm_dsi_phy *phy,
 	/* Select MS1 byte-clk */
 	dsi_phy_write(base + REG_DSI_10nm_PHY_CMN_GLBL_CTRL, 0x10);
 
-	/* Enable LDO */
-	dsi_phy_write(base + REG_DSI_10nm_PHY_CMN_VREG_CTRL, 0x59);
+	/* Enable LDO with platform specific drive level/amplitude adjustment */
+	dsi_phy_write(base + REG_DSI_10nm_PHY_CMN_VREG_CTRL,
+		      tuning_cfg->vreg_ctrl);
 
 	/* Configure PHY lane swap (TODO: we need to calculate this) */
 	dsi_phy_write(base + REG_DSI_10nm_PHY_CMN_LANE_CFG0, 0x21);
@@ -922,6 +940,92 @@ static void dsi_10nm_phy_disable(struct msm_dsi_phy *phy)
 	DBG("DSI%d PHY disabled", phy->id);
 }
 
+static int dsi_10nm_phy_parse_dt(struct msm_dsi_phy *phy)
+{
+	struct device *dev = &phy->pdev->dev;
+	struct dsi_phy_10nm_tuning_cfg *tuning_cfg;
+	s8 offset_top[DSI_LANE_MAX] = { 0 }; /* No offset */
+	s8 offset_bot[DSI_LANE_MAX] = { 0 }; /* No offset */
+	u32 ldo_level = 400; /* 400mV */
+	u8 level;
+	int ret, i;
+
+	tuning_cfg = devm_kzalloc(dev, sizeof(*tuning_cfg), GFP_KERNEL);
+	if (!tuning_cfg)
+		return -ENOMEM;
+
+	/* Drive strength adjustment parameters */
+	ret = of_property_read_u8_array(dev->of_node, "qcom,phy-rescode-offset-top",
+					offset_top, DSI_LANE_MAX);
+	if (ret && ret != -EINVAL) {
+		DRM_DEV_ERROR(dev, "failed to parse qcom,phy-rescode-offset-top, %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < DSI_LANE_MAX; i++) {
+		if (offset_top[i] < -32 || offset_top[i] > 31) {
+			DRM_DEV_ERROR(dev,
+				"qcom,phy-rescode-offset-top value %d is not in range [-32..31]\n",
+				offset_top[i]);
+			return -EINVAL;
+		}
+		tuning_cfg->rescode_offset_top[i] = 0x3f & offset_top[i];
+	}
+
+	ret = of_property_read_u8_array(dev->of_node, "qcom,phy-rescode-offset-bot",
+					offset_bot, DSI_LANE_MAX);
+	if (ret && ret != -EINVAL) {
+		DRM_DEV_ERROR(dev, "failed to parse qcom,phy-rescode-offset-bot, %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < DSI_LANE_MAX; i++) {
+		if (offset_bot[i] < -32 || offset_bot[i] > 31) {
+			DRM_DEV_ERROR(dev,
+				"qcom,phy-rescode-offset-bot value %d is not in range [-32..31]\n",
+				offset_bot[i]);
+			return -EINVAL;
+		}
+		tuning_cfg->rescode_offset_bot[i] = 0x3f & offset_bot[i];
+	}
+
+	/* Drive level/amplitude adjustment parameters */
+	ret = of_property_read_u32(dev->of_node, "qcom,phy-drive-ldo-level", &ldo_level);
+	if (ret && ret != -EINVAL) {
+		DRM_DEV_ERROR(dev, "failed to parse qcom,phy-drive-ldo-level, %d\n", ret);
+		return ret;
+	}
+
+	switch (ldo_level) {
+	case 375:
+		level = 0;
+		break;
+	case 400:
+		level = 1;
+		break;
+	case 425:
+		level = 2;
+		break;
+	case 450:
+		level = 3;
+		break;
+	case 475:
+		level = 4;
+		break;
+	case 500:
+		level = 5;
+		break;
+	default:
+		DRM_DEV_ERROR(dev, "qcom,phy-drive-ldo-level %d is not supported\n");
+		return -EINVAL;
+	}
+	tuning_cfg->vreg_ctrl = 0x58 | (0x7 & level);
+
+	phy->tuning_cfg = tuning_cfg;
+
+	return 0;
+}
+
 const struct msm_dsi_phy_cfg dsi_phy_10nm_cfgs = {
 	.has_phy_lane = true,
 	.reg_cfg = {
@@ -936,6 +1040,7 @@ const struct msm_dsi_phy_cfg dsi_phy_10nm_cfgs = {
 		.pll_init = dsi_pll_10nm_init,
 		.save_pll_state = dsi_10nm_pll_save_state,
 		.restore_pll_state = dsi_10nm_pll_restore_state,
+		.parse_dt_properties = dsi_10nm_phy_parse_dt,
 	},
 	.min_pll_rate = 1000000000UL,
 	.max_pll_rate = 3500000000UL,
@@ -957,6 +1062,7 @@ const struct msm_dsi_phy_cfg dsi_phy_10nm_8998_cfgs = {
 		.pll_init = dsi_pll_10nm_init,
 		.save_pll_state = dsi_10nm_pll_save_state,
 		.restore_pll_state = dsi_10nm_pll_restore_state,
+		.parse_dt_properties = dsi_10nm_phy_parse_dt,
 	},
 	.min_pll_rate = 1000000000UL,
 	.max_pll_rate = 3500000000UL,
-- 
2.7.4

