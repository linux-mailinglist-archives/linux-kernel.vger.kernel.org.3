Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80E5B169C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiIHIOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiIHINg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:13:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E859D9EBE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:13:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l65so17147763pfl.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jD1WgCeSA8uWA865ybZkInzC4AA4C89F3a1ntZPiE8k=;
        b=gRx+CxMIiN6H9pj7fPVTKTaBOZuCbadXfe/izl78J7zwh9G/F/ZZfhDRPAR4KUqpIT
         tzTV7y+tG4VbrnkuhCTSDnVuChYd1LK08RhOcWwdzZIjw2AGCjLp9xz3DJj7dl2RNmhS
         laBZg/+nT7AZB8IzBfjPX3AwryZn3ulbsNQ5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jD1WgCeSA8uWA865ybZkInzC4AA4C89F3a1ntZPiE8k=;
        b=ZRTyGuNKbudMGgBlgNjVO6JFy7iYHP4Zn2dASuFOveN1y/2w0DedpMC2DiSinDm2bb
         OVcPZ7A6gWQIP3SwI3+IJTAH2NacKXOKNoCtk6+Q4o1hOQ344kbPlg4TAbpThHQ/auQ0
         HhWfHfa+K8jRxmLMz4cDazm7BR8rU6EANU0FbSAuzSW7eaOimINGMTEWf+nG4hc3Y/jQ
         TtyVRPx8y4I06bn2bOOe+p7shYh+/4+dVsDzarmVybIowKOH+gdUfAk1xgYMtP2wpgJM
         fYXPtv0nkJdMJ3COa71L9tQ9LpLN5nE+DV5SaJ+FhQNeTlRZps4zo2NEIv6YQLXfFmfE
         NMgQ==
X-Gm-Message-State: ACgBeo2c1vcFfy+VDPAiWp35KHF0FEnTrbXkqb+23m7g5nwY6OZBWgmd
        jOuGnyQecIfCDXYGElp7zQZsvQ==
X-Google-Smtp-Source: AA6agR5pAxhOg42yEVQWiNBTst6BWefRDET/Dw+fjQjsfFbYbib4gMXfhh2kApJRsESI7zxngjveLQ==
X-Received: by 2002:a63:6683:0:b0:42b:1d69:a0ff with SMTP id a125-20020a636683000000b0042b1d69a0ffmr6965140pgc.475.1662624796587;
        Thu, 08 Sep 2022 01:13:16 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:5237:c185:9b01:8955])
        by smtp.gmail.com with ESMTPSA id z22-20020aa79496000000b0052d4cb47339sm14159702pfk.151.2022.09.08.01.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:13:16 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH 2/2] drm/bridge: it6505: Add pre_enable/post_disable callback
Date:   Thu,  8 Sep 2022 16:12:58 +0800
Message-Id: <20220908081259.503236-3-treapking@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220908081259.503236-1-treapking@chromium.org>
References: <20220908081259.503236-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add atomic_pre_enable and atomic_post_disable callback to make sure the
bridge is not powered off until atomic_post_disable is called. This
prevents a power leakage when it6505 is powered off, but the upstream
DRM bridge is still sending display signals.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 drivers/gpu/drm/bridge/ite-it6505.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 9d37660545fb..f5eea138ace4 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2984,6 +2984,28 @@ static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
 	}
 }
 
+static void it6505_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					    struct drm_bridge_state *old_state)
+{
+	struct it6505 *it6505 = bridge_to_it6505(bridge);
+	struct device *dev = &it6505->client->dev;
+
+	DRM_DEV_DEBUG_DRIVER(dev, "start");
+
+	pm_runtime_get_sync(dev);
+}
+
+static void it6505_bridge_atomic_post_disable(struct drm_bridge *bridge,
+					      struct drm_bridge_state *old_state)
+{
+	struct it6505 *it6505 = bridge_to_it6505(bridge);
+	struct device *dev = &it6505->client->dev;
+
+	DRM_DEV_DEBUG_DRIVER(dev, "start");
+
+	pm_runtime_put_sync(dev);
+}
+
 static enum drm_connector_status
 it6505_bridge_detect(struct drm_bridge *bridge)
 {
@@ -3018,6 +3040,8 @@ static const struct drm_bridge_funcs it6505_bridge_funcs = {
 	.mode_valid = it6505_bridge_mode_valid,
 	.atomic_enable = it6505_bridge_atomic_enable,
 	.atomic_disable = it6505_bridge_atomic_disable,
+	.atomic_pre_enable = it6505_bridge_atomic_pre_enable,
+	.atomic_post_disable = it6505_bridge_atomic_post_disable,
 	.detect = it6505_bridge_detect,
 	.get_edid = it6505_bridge_get_edid,
 };
-- 
2.37.2.789.g6183377224-goog

