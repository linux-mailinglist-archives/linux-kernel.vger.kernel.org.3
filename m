Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB1E4898F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiAJM6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:58:24 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:61254 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343550AbiAJM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641819370; x=1673355370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9t/Xu5PgIegcYhMGwAj50Sze7qm72rRfmBmOT9p3+WU=;
  b=GV9zXUy1cNZMsS06f5tr4z7tzyBa2XRV0r/J4AFgRDuWbgQEUBPFNbOG
   rnqd+jQ7o+alpZvbBsOvvKzHqn/kSgBDNIqaYVSa2wjkVTSeRp06zeRdw
   6oo3tbOM/9BvK52vQ9I0CekLYFTwEihWpIsYKgK5sibBHnvSyqP5oUnok
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 10 Jan 2022 04:56:09 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Jan 2022 04:56:07 -0800
X-QCInternal: smtphost
Received: from rajeevny-linux.qualcomm.com ([10.204.66.121])
  by ironmsg02-blr.qualcomm.com with ESMTP; 10 Jan 2022 18:25:47 +0530
Received: by rajeevny-linux.qualcomm.com (Postfix, from userid 2363605)
        id 4373A219F1; Mon, 10 Jan 2022 18:25:46 +0530 (IST)
From:   Rajeev Nandan <quic_rajeevny@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Rajeev Nandan <quic_rajeevny@quicinc.com>,
        linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, robh@kernel.org, quic_abhinavk@quicinc.com,
        quic_kalyant@quicinc.com, quic_mkrishn@quicinc.com,
        jonathan@marek.ca, dmitry.baryshkov@linaro.org, airlied@linux.ie,
        daniel@ffwll.ch, swboyd@chromium.org
Subject: [v2 2/3] drm/msm/dsi: Add dsi phy tuning configuration support
Date:   Mon, 10 Jan 2022 18:25:36 +0530
Message-Id: <1641819337-17037-3-git-send-email-quic_rajeevny@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641819337-17037-1-git-send-email-quic_rajeevny@quicinc.com>
References: <1641819337-17037-1-git-send-email-quic_rajeevny@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MSM DSI PHY tuning configuration. Current design is
to support drive strength and drive level/amplitude tuning for
10nm PHY version, but this can be extended to other PHY versions.

Signed-off-by: Rajeev Nandan <quic_rajeevny@quicinc.com>
---

Changes in v2:
 - New.
 - Split into generic code and 10nm-specific part (Dmitry Baryshkov)

 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c |  3 +++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 8c65ef6..ee3739d 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -739,6 +739,9 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (phy->cfg->ops.tuning_cfg_init)
+		phy->cfg->ops.tuning_cfg_init(phy);
+
 	ret = dsi_phy_regulator_init(phy);
 	if (ret)
 		goto fail;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index b91303a..b559a2b 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -25,6 +25,7 @@ struct msm_dsi_phy_ops {
 	void (*save_pll_state)(struct msm_dsi_phy *phy);
 	int (*restore_pll_state)(struct msm_dsi_phy *phy);
 	bool (*set_continuous_clock)(struct msm_dsi_phy *phy, bool enable);
+	void (*tuning_cfg_init)(struct msm_dsi_phy *phy);
 };
 
 struct msm_dsi_phy_cfg {
@@ -81,6 +82,20 @@ struct msm_dsi_dphy_timing {
 #define DSI_PIXEL_PLL_CLK		1
 #define NUM_PROVIDED_CLKS		2
 
+#define DSI_LANE_MAX			5
+
+/**
+ * struct msm_dsi_phy_tuning_cfg - Holds PHY tuning config parameters.
+ * @rescode_offset_top: Offset for pull-up legs rescode.
+ * @rescode_offset_bot: Offset for pull-down legs rescode.
+ * @vreg_ctrl: vreg ctrl to drive LDO level
+ */
+struct msm_dsi_phy_tuning_cfg {
+	u8 rescode_offset_top[DSI_LANE_MAX];
+	u8 rescode_offset_bot[DSI_LANE_MAX];
+	u8 vreg_ctrl;
+};
+
 struct msm_dsi_phy {
 	struct platform_device *pdev;
 	void __iomem *base;
@@ -98,6 +113,7 @@ struct msm_dsi_phy {
 
 	struct msm_dsi_dphy_timing timing;
 	const struct msm_dsi_phy_cfg *cfg;
+	struct msm_dsi_phy_tuning_cfg tuning_cfg;
 
 	enum msm_dsi_phy_usecase usecase;
 	bool regulator_ldo_mode;
-- 
2.7.4

