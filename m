Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2E46C6BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhLGVgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhLGVgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:36:37 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407B5C061574;
        Tue,  7 Dec 2021 13:33:07 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so2889830pja.1;
        Tue, 07 Dec 2021 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oCxmc2ej0Y/Ed8/aAbKAC0n9cpxkgcI673PvTj7o1sY=;
        b=pbmlkckfurvf0+NIJVyrntWM7ZMxo2fbrFyWznIZHMALZ7PBz3A9yn+/Jcm7FvMx1B
         q/iuTpDIjJMgU9PSELetS27WnKGmZJaXtawbXMWWxo9uwpKpPEqTas3CmRhHkRh84Scc
         7lU/s6IcVFKoW5wTvJ6nJZ9Ni8Nhd6pBtYS1eoxVuLju3/80NoqHVpwC779F42ebqqG/
         tVLWNsJun8oeXGElY2K+J33f2JgRh8672qupum5VgVdIkx+kidd/rjyolzlP2Jjh6tzK
         GsxDEK+44Hux1h649VcoM7gV6rAPLWmV0XLeh2Ob5iaQzQuwUbffClVeYtO1xBS5JnLk
         i5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oCxmc2ej0Y/Ed8/aAbKAC0n9cpxkgcI673PvTj7o1sY=;
        b=UerQx+QwWGRyyebfJJOi+xIP4j3TAIriAMixu+2SGQocXedYC9XvbfTJnILKMUlLjX
         Y9GRgQHRqOvV0TFEZteRBVjuTsJxKgShbM3uzYH9PYgI7FX++RYNfo59GZ5G6EuLpjjS
         rCza85rCE4e5ceQumz+PJCwSOvDcZZEOzoD4v1tJodOZm5G4/e7/gaF22WJiFJKddO2F
         uXor5w6HV1T1xFnRnFJwVqyTh1neHq08MVH6dBjkigjCs+3mdV6ErPLLSpNgg839XW7U
         IsvmNMWMklaFE4bsBVgfLuoWPKbmpLltrixlKbVdIzDQMAm/aMK2w/UEWh5vimi04otq
         Y9Uw==
X-Gm-Message-State: AOAM530Ok04sxBnM8jLnxxThiM6kgjpNHQcUsrmil70F/rv4jpfuY4eg
        sf39QKUEnfFbMqgYX24y7o6ONuNgbSo=
X-Google-Smtp-Source: ABdhPJxaO4/o0nOR2am6/HBVYxqg7nice2KJEduPQPwyw1KkwFkHWY3MDRx6Sm5wgSl4EUokY3ZCaw==
X-Received: by 2002:a17:902:e8d4:b0:143:88c2:e2c9 with SMTP id v20-20020a170902e8d400b0014388c2e2c9mr54786033plg.12.1638912786683;
        Tue, 07 Dec 2021 13:33:06 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id f4sm699999pfg.34.2021.12.07.13.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:33:05 -0800 (PST)
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
Subject: [PATCH v2] drm/bridge: sn65dsi86: defer if there is no dsi host
Date:   Tue,  7 Dec 2021 13:38:29 -0800
Message-Id: <20211207213830.625890-1-robdclark@gmail.com>
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
---
v2: Drop DRM_ERROR() in favor of drm_err_probe() and shift around the
    spot where we report the error

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 02b490671f8f..8f1321ca819e 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -714,10 +714,8 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
 	};
 
 	host = of_find_mipi_dsi_host_by_node(pdata->host_node);
-	if (!host) {
-		DRM_ERROR("failed to find dsi host\n");
-		return -ENODEV;
-	}
+	if (!host)
+		return -EPROBE_DEFER;
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
@@ -1267,8 +1265,10 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 	drm_bridge_add(&pdata->bridge);
 
 	ret = ti_sn_attach_host(pdata);
-	if (ret)
+	if (ret) {
+		dev_err_probe(pdata->dev, ret, "failed to attach dsi host");
 		goto err_remove_bridge;
+	}
 
 	return 0;
 
-- 
2.33.1

