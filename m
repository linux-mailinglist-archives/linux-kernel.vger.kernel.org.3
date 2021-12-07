Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2561646C6F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhLGVz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhLGVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:55:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C62C061574;
        Tue,  7 Dec 2021 13:52:28 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so2888294pjc.4;
        Tue, 07 Dec 2021 13:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWWlWBGNAUNv1KS12feNK4ETJNpX4Xg6FQdVVzeu2xo=;
        b=Nm8DEfD4BkjVJuM8yaT5XZV5pFjaFUtE+3Gm3h/q/n34uOXG753dgC+aSxkBYkgV0m
         1oqaKPjIzutHgzAKMvSylxYQ/fs4BkOzPpL1yuMOxGtHf0PvyNwWZ11d9GYAO/5u63iu
         fZDh0owzBw6rmtpH1CnUNiXcHs0BLB+HqjQ5WF3GkEZmwJb+8Cdkipf/GnFOmyjdMCXt
         fw2LWQN74aKyZq9W/s+JK5guLzWs46xtOV7eA7pQbeE2IzF5Nnvn6P8HLiIh43EY0r4N
         qO7O/yQtH3DEYPf6nZ0hUkhn1/48R9g6vAb8+J/eQzOiDqgdhc72KAH+ZusJNfO3BTRA
         tKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWWlWBGNAUNv1KS12feNK4ETJNpX4Xg6FQdVVzeu2xo=;
        b=QwwWiwuv7aGnrjU1C6xnuO5ZOW1NAH041LihaTGnKionaOrVzhODjPgfZILguSdMPo
         s8iGIJAUoaC8P5cxtVW3vfixq6FR1i32tBS2fOwkVO6M1jRWc0WxE8sgqDZrPmara2q1
         rdQATiYjk52B7DmVocf/IIzq3RtQsvEgVDDFrVXjsTS1krffl5zKwhhdcudJrILwQPzC
         JuQarqut6qpv4bwxddjpQO57Go3ost9n7627rlFFXJHpZ6GD/HL3ZsnZutqA3FxLLdp+
         ykWwkbzzHorV9xmQdoEwAcdyAPkeL9Fsy+VkuHMP2ugYAFlHNLTDP3xJc/S24ya5XYVn
         FkSA==
X-Gm-Message-State: AOAM5304Mh/KcIDtj84/cz1V88Sc6Sdr/dA2lZ85jRK/d//bAjPaq0vk
        D2dbUc2wrC/TsGMZTFHvRFg=
X-Google-Smtp-Source: ABdhPJy4TxAKrkAuyTggCB3UfPBVw9hJa8a9UlhxxAwhC9f/AOhv3iTYP40Y8B2LXIbBsxxvX4Gx8Q==
X-Received: by 2002:a17:90a:9a8e:: with SMTP id e14mr2104949pjp.231.1638913947604;
        Tue, 07 Dec 2021 13:52:27 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id z16sm454496pgl.29.2021.12.07.13.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:52:26 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drm/bridge: sn65dsi86: defer if there is no dsi host
Date:   Tue,  7 Dec 2021 13:57:52 -0800
Message-Id: <20211207215753.635841-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Otherwise we don't get another shot at it if the bridge probes before
the dsi host is registered.  It seems like this is what *most* (but not
all) of the other bridges do.

It looks like this was missed in the conversion to attach dsi host at
probe time.

Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
v2: Drop DRM_ERROR() in favor of drm_err_probe() and shift around the
    spot where we report the error
v3: Add \n and cull error msgs a bit further

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 02b490671f8f..c2928a6409b1 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -714,16 +714,12 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
 	};
 
 	host = of_find_mipi_dsi_host_by_node(pdata->host_node);
-	if (!host) {
-		DRM_ERROR("failed to find dsi host\n");
-		return -ENODEV;
-	}
+	if (!host)
+		return -EPROBE_DEFER;
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
-	if (IS_ERR(dsi)) {
-		DRM_ERROR("failed to create dsi device\n");
+	if (IS_ERR(dsi))
 		return PTR_ERR(dsi);
-	}
 
 	/* TODO: setting to 4 MIPI lanes always for now */
 	dsi->lanes = 4;
@@ -740,10 +736,8 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
 	pdata->dsi = dsi;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
-	if (ret < 0) {
-		DRM_ERROR("failed to attach dsi to host\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
@@ -1267,8 +1261,10 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 	drm_bridge_add(&pdata->bridge);
 
 	ret = ti_sn_attach_host(pdata);
-	if (ret)
+	if (ret) {
+		dev_err_probe(pdata->dev, ret, "failed to attach dsi host\n");
 		goto err_remove_bridge;
+	}
 
 	return 0;
 
-- 
2.33.1

