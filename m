Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A5148F2C2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiANXCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiANXCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:02:31 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3336C06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:02:30 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i17so4052105pfk.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0lN8KgwngdIWQtX+1YBYkcWtXacsAROFK0Re0Isayk=;
        b=JVAC7svkA82CIskoX9XxpEfg+B8GFkTpb3ivSbFZgI/HPbD7sY7z1Mp2/N0DGlMyj1
         4kRKb6WX3EXTB1GWlBwz1HHIo/SBYne1AVVReufn7082hSWgZV8LusfLssbZ+nO+QZMF
         zfKkrjxjOuZUoKGjf2YwUeV1EFcNl2i1ZeX5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0lN8KgwngdIWQtX+1YBYkcWtXacsAROFK0Re0Isayk=;
        b=itnQpSGGWS8iVww0pJnnz9PeWmOp8jEurwS4uYmbKywNBOqThciYhp1msczQXhCvhz
         EDdb4+vRJRK+eLgNd6VtV+X7Xb68P+NEyZFvCaatY2cGRpcWeVN3JOfaWc6xNuAxTpgf
         /BUJwHdlR+s8cSFiOgqhGXk7a6veYKn8n83XlgEzZlfVVmsx74rvY9/V1Ibqwj4rZLa1
         a8lvf0I4BOfZLTu7OWYkfvozASNDcWuHBV3Z/L5fZrkCnbZmZxjEiJ9F7LoKa1fD6GF3
         VbaWTNSZjDM/9bADrbuK6MFfpWiomKGXc70vzbdLMxBDffRXoMkHUwI0AB7+CVSDmqpn
         o/kA==
X-Gm-Message-State: AOAM530DQTnZlDxYYoVhrt1Sn7vPVMEi9CkymiP39KhPGkdmQzxoF9fu
        jnjR6s7UrQcsbhligujvBD7oXQ==
X-Google-Smtp-Source: ABdhPJxEEE2CEn37OnjZYtyIw2or9NSfWoMKhSqZ32s/6jckTLsVQCguVm+8geqnseEdUH1GvQWwKw==
X-Received: by 2002:a62:1b49:0:b0:4be:f4a5:14a6 with SMTP id b70-20020a621b49000000b004bef4a514a6mr10888650pfb.31.1642201350433;
        Fri, 14 Jan 2022 15:02:30 -0800 (PST)
Received: from localhost ([2620:15c:202:201:76ab:ede1:503d:1c39])
        by smtp.gmail.com with UTF8SMTPSA id j14sm6719717pfu.15.2022.01.14.15.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 15:02:29 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/3] drm/rockchip: cdn-dp: Support HDMI codec plug-change callback
Date:   Fri, 14 Jan 2022 15:02:08 -0800
Message-Id: <20220114150129.v2.2.I20d754a1228aa5c51a18c8eb15a2c60dec25b639@changeid>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220114230209.4091727-1-briannorris@chromium.org>
References: <20220114230209.4091727-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some audio servers like to monitor a jack device (perhaps combined with
EDID, for audio-presence info) to determine DP/HDMI audio presence.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 28 ++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 16497c31d9f9..edd6a1fc46cd 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -586,6 +586,13 @@ static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
 	return drm_dp_channel_eq_ok(link_status, min(port->lanes, sink_lanes));
 }
 
+static void cdn_dp_audio_handle_plugged_change(struct cdn_dp_device *dp,
+					       bool plugged)
+{
+	if (dp->codec_dev)
+		dp->plugged_cb(dp->codec_dev, plugged);
+}
+
 static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 {
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
@@ -641,6 +648,9 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 		DRM_DEV_ERROR(dp->dev, "Failed to valid video %d\n", ret);
 		goto out;
 	}
+
+	cdn_dp_audio_handle_plugged_change(dp, true);
+
 out:
 	mutex_unlock(&dp->lock);
 }
@@ -651,6 +661,8 @@ static void cdn_dp_encoder_disable(struct drm_encoder *encoder)
 	int ret;
 
 	mutex_lock(&dp->lock);
+	cdn_dp_audio_handle_plugged_change(dp, false);
+
 	if (dp->active) {
 		ret = cdn_dp_disable(dp);
 		if (ret) {
@@ -846,11 +858,27 @@ static int cdn_dp_audio_get_eld(struct device *dev, void *data,
 	return 0;
 }
 
+static int cdn_dp_audio_hook_plugged_cb(struct device *dev, void *data,
+					hdmi_codec_plugged_cb fn,
+					struct device *codec_dev)
+{
+	struct cdn_dp_device *dp = dev_get_drvdata(dev);
+
+	mutex_lock(&dp->lock);
+	dp->plugged_cb = fn;
+	dp->codec_dev = codec_dev;
+	cdn_dp_audio_handle_plugged_change(dp, dp->connected);
+	mutex_unlock(&dp->lock);
+
+	return 0;
+}
+
 static const struct hdmi_codec_ops audio_codec_ops = {
 	.hw_params = cdn_dp_audio_hw_params,
 	.audio_shutdown = cdn_dp_audio_shutdown,
 	.mute_stream = cdn_dp_audio_mute_stream,
 	.get_eld = cdn_dp_audio_get_eld,
+	.hook_plugged_cb = cdn_dp_audio_hook_plugged_cb,
 	.no_capture_mute = 1,
 };
 
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index 81ac9b658a70..d808a9de45ed 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -10,6 +10,7 @@
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
+#include <sound/hdmi-codec.h>
 
 #include "rockchip_drm_drv.h"
 
@@ -101,5 +102,8 @@ struct cdn_dp_device {
 
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	bool sink_has_audio;
+
+	hdmi_codec_plugged_cb plugged_cb;
+	struct device *codec_dev;
 };
 #endif  /* _CDN_DP_CORE_H */
-- 
2.34.1.703.g22d0c6ccf7-goog

