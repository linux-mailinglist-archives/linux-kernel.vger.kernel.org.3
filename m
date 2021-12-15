Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631B1475FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbhLORzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhLORzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:55:54 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8CAC061574;
        Wed, 15 Dec 2021 09:55:54 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q16so20722177pgq.10;
        Wed, 15 Dec 2021 09:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZ3LpjtL0YwyX+2dJ2ef+7lZVvlqJTjbm/p+yQNc6As=;
        b=ln+w3Wmc1irEPAgq4GSqmPmrFaT74X8U/B0ctUo+WElfqKyG7EbYw6e0Ij2mAFl+mN
         cSMgK6H0EGR/Hcbzo82ViMs6m2V9JUC3n94U+bqPi9OT24jgKu5JnIBFXVBjf84Zi6B9
         u9HkSFArVI6eBh4mTgCjGY62ulMTVx2kRczh39eVZZHmKP62Z5eQIuoqlUuMsVro+vtD
         WRFCPF3e3CGo4Z7XJh4vpg6/JNxRY/ZvECW4BBl0z/lxZiLLkKJR+9VQKfJ9sFRVUf1i
         fgI1HoEpOOIwbV1zfqE3RAU3oubbG2iAhm7IF4LoVG9GDGeXR5GEzRnjl9n6pmHg3XxB
         IDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZ3LpjtL0YwyX+2dJ2ef+7lZVvlqJTjbm/p+yQNc6As=;
        b=XcNMptvwChqCcs9tCg9nUATu8ffBogR/a8PKL8unat6SPucaIRxLArZxTYUAH3T8NU
         4Ng8w9Os33qOf/1ygNEBHZrmHxPYciLTo1El6QgxGW918ZSPJKZCXpBuuqBIfX7++mqK
         ly6XMFYJD83YXmf6kDFXLT9407l+PC2z4WITtC67souXz5PxXhebiusMrtC+rfx5yqVN
         gAL6ws8L97YzIpzX1NfowbFgO5wsKQ1P5hlOQoLVfJBv937+qxDqrJW8FO9cyn27fZGH
         SWDJHYOH+biAZC/EUQ5mMaS8ToP0yp3LTYzz3RnI9Dq0FD2oSEB+GHILz0eSXPCjggRk
         CCuA==
X-Gm-Message-State: AOAM531+6KK8XiuuCfkvHuMMtIwLzRRgptzH4HCSi75WheVRoYRKFlti
        BWBXOr/A3qSr2XkZsC8YoP0=
X-Google-Smtp-Source: ABdhPJxDFJaT/pQWOIsDrLIBG60oATcp+dgTrUx2Pl/YVvoNcVC6KPYi9NxgjPfjNu8ZRmlkuK5yPw==
X-Received: by 2002:a63:5c64:: with SMTP id n36mr8707927pgm.61.1639590954046;
        Wed, 15 Dec 2021 09:55:54 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id t8sm3041723pgk.66.2021.12.15.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:55:52 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Don't use autosuspend for display
Date:   Wed, 15 Dec 2021 09:59:02 -0800
Message-Id: <20211215175910.1744151-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

No functional change, as we only actually enable autosuspend for the GPU
device.  But lets not encourage thinking that autosuspend is a good idea
for anything display related.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c     | 8 ++++----
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c  | 2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c    | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 5b4bb722f750..6b3ced4aaaf5 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2020,7 +2020,7 @@ void msm_dsi_host_xfer_restore(struct mipi_dsi_host *host,
 	/* TODO: unvote for bus bandwidth */
 
 	cfg_hnd->ops->link_clk_disable(msm_host);
-	pm_runtime_put_autosuspend(&msm_host->pdev->dev);
+	pm_runtime_put(&msm_host->pdev->dev);
 }
 
 int msm_dsi_host_cmd_tx(struct mipi_dsi_host *host,
@@ -2252,7 +2252,7 @@ int msm_dsi_host_enable(struct mipi_dsi_host *host)
 	 */
 	/* if (msm_panel->mode == MSM_DSI_CMD_MODE) {
 	 *	dsi_link_clk_disable(msm_host);
-	 *	pm_runtime_put_autosuspend(&msm_host->pdev->dev);
+	 *	pm_runtime_put(&msm_host->pdev->dev);
 	 * }
 	 */
 	msm_host->enabled = true;
@@ -2344,7 +2344,7 @@ int msm_dsi_host_power_on(struct mipi_dsi_host *host,
 
 fail_disable_clk:
 	cfg_hnd->ops->link_clk_disable(msm_host);
-	pm_runtime_put_autosuspend(&msm_host->pdev->dev);
+	pm_runtime_put(&msm_host->pdev->dev);
 fail_disable_reg:
 	dsi_host_regulator_disable(msm_host);
 unlock_ret:
@@ -2371,7 +2371,7 @@ int msm_dsi_host_power_off(struct mipi_dsi_host *host)
 	pinctrl_pm_select_sleep_state(&msm_host->pdev->dev);
 
 	cfg_hnd->ops->link_clk_disable(msm_host);
-	pm_runtime_put_autosuspend(&msm_host->pdev->dev);
+	pm_runtime_put(&msm_host->pdev->dev);
 
 	dsi_host_regulator_disable(msm_host);
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 0b2ae5c15240..c2ed177717c7 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -602,7 +602,7 @@ static int dsi_phy_enable_resource(struct msm_dsi_phy *phy)
 static void dsi_phy_disable_resource(struct msm_dsi_phy *phy)
 {
 	clk_disable_unprepare(phy->ahb_clk);
-	pm_runtime_put_autosuspend(&phy->pdev->dev);
+	pm_runtime_put(&phy->pdev->dev);
 }
 
 static const struct of_device_id dsi_phy_dt_match[] = {
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 211b73dddf65..68fba4bf7212 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -69,7 +69,7 @@ static void power_off(struct drm_bridge *bridge)
 	if (ret)
 		DRM_DEV_ERROR(dev->dev, "failed to disable pwr regulator: %d\n", ret);
 
-	pm_runtime_put_autosuspend(&hdmi->pdev->dev);
+	pm_runtime_put(&hdmi->pdev->dev);
 }
 
 #define AVI_IFRAME_LINE_NUMBER 1
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
index 1cda7bf23b3b..75605ddac7c4 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
@@ -205,7 +205,7 @@ void msm_hdmi_hpd_disable(struct hdmi_bridge *hdmi_bridge)
 	msm_hdmi_set_mode(hdmi, false);
 
 	enable_hpd_clocks(hdmi, false);
-	pm_runtime_put_autosuspend(dev);
+	pm_runtime_put(dev);
 
 	ret = gpio_config(hdmi, false);
 	if (ret)
@@ -260,7 +260,7 @@ static enum drm_connector_status detect_reg(struct hdmi *hdmi)
 	hpd_int_status = hdmi_read(hdmi, REG_HDMI_HPD_INT_STATUS);
 
 	enable_hpd_clocks(hdmi, false);
-	pm_runtime_put_autosuspend(&hdmi->pdev->dev);
+	pm_runtime_put(&hdmi->pdev->dev);
 
 	return (hpd_int_status & HDMI_HPD_INT_STATUS_CABLE_DETECTED) ?
 			connector_status_connected : connector_status_disconnected;
-- 
2.33.1

