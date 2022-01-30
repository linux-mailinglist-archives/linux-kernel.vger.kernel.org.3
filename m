Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB694A38E6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 21:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356096AbiA3UPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 15:15:49 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:42867 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiA3UPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 15:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643573748; x=1675109748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=nlceKRR9XYG+70HrS2RmpUq7A6HORpYsEV0OXmBraE8=;
  b=XVrSm8A+s1oeFdaS80Ym7ftzf423ubsu+2Lmg+zITtvS0asdNfPQNxXA
   WWEiI7/i5k5+JqxqQQEkosgAKerHgnqTIjWmX6cTyo5UFzINQ542ugWL2
   JuIjfmhRcsaNFUStGWE43heikeck7GO7NMp73gnLc8AAsfoKL8dvTsWHV
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 Jan 2022 12:15:48 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Jan 2022 12:15:46 -0800
X-QCInternal: smtphost
Received: from rajeevny-linux.qualcomm.com ([10.204.66.121])
  by ironmsg02-blr.qualcomm.com with ESMTP; 31 Jan 2022 01:45:23 +0530
Received: by rajeevny-linux.qualcomm.com (Postfix, from userid 2363605)
        id 709A521AD2; Mon, 31 Jan 2022 01:45:23 +0530 (IST)
From:   Rajeev Nandan <quic_rajeevny@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Rajeev Nandan <quic_rajeevny@quicinc.com>,
        linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, robh@kernel.org, quic_abhinavk@quicinc.com,
        quic_kalyant@quicinc.com, quic_mkrishn@quicinc.com,
        jonathan@marek.ca, dmitry.baryshkov@linaro.org, airlied@linux.ie,
        daniel@ffwll.ch, swboyd@chromium.org
Subject: [v5 2/3] drm/msm/dsi: Add dsi phy tuning configuration support
Date:   Mon, 31 Jan 2022 01:45:18 +0530
Message-Id: <1643573719-32095-3-git-send-email-quic_rajeevny@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643573719-32095-1-git-send-email-quic_rajeevny@quicinc.com>
References: <1643573719-32095-1-git-send-email-quic_rajeevny@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MSM DSI PHY tuning configuration. Current design is
to support drive strength and drive level/amplitude tuning for
10nm PHY version, but this can be extended to other PHY versions.

Signed-off-by: Rajeev Nandan <quic_rajeevny@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

Changes in v2:
 - New.
 - Split into generic code and 10nm-specific part (Dmitry Baryshkov)

Changes in v3:
 - s/ops.tuning_cfg_init/ops.parse_dt_properties
   To parse phy version specific DT properties (Dmitry Baryshkov)
 - Address comments for phy tuning data structure (Dmitry Baryshkov)

No change since v4

 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 6 ++++++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 8c65ef6..fcbca76 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -739,6 +739,12 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (phy->cfg->ops.parse_dt_properties) {
+		ret = phy->cfg->ops.parse_dt_properties(phy);
+		if (ret)
+			goto fail;
+	}
+
 	ret = dsi_phy_regulator_init(phy);
 	if (ret)
 		goto fail;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index b91303a..9e08081 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -25,6 +25,7 @@ struct msm_dsi_phy_ops {
 	void (*save_pll_state)(struct msm_dsi_phy *phy);
 	int (*restore_pll_state)(struct msm_dsi_phy *phy);
 	bool (*set_continuous_clock)(struct msm_dsi_phy *phy, bool enable);
+	int (*parse_dt_properties)(struct msm_dsi_phy *phy);
 };
 
 struct msm_dsi_phy_cfg {
@@ -81,6 +82,8 @@ struct msm_dsi_dphy_timing {
 #define DSI_PIXEL_PLL_CLK		1
 #define NUM_PROVIDED_CLKS		2
 
+#define DSI_LANE_MAX			5
+
 struct msm_dsi_phy {
 	struct platform_device *pdev;
 	void __iomem *base;
@@ -98,6 +101,7 @@ struct msm_dsi_phy {
 
 	struct msm_dsi_dphy_timing timing;
 	const struct msm_dsi_phy_cfg *cfg;
+	void *tuning_cfg;
 
 	enum msm_dsi_phy_usecase usecase;
 	bool regulator_ldo_mode;
-- 
2.7.4

