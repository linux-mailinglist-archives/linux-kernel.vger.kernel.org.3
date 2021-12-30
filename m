Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A87E4820ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 00:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbhL3X4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 18:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbhL3X4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 18:56:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6FFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 15:56:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso14047685wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 15:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HquMs86R/2fSeMwrKiFYntNswT/jyW+k3LeVZxsjHFc=;
        b=aimcO/TVd9nLXP7KRWG9TSbEhFtB8BJ5Ypa/LerWNZpYC2h0L6iZj56Qz+jlNG/BSg
         sM2L9k0hfACJB+f7Ajp5KiZ1YrA5/8Vmq0Kc5vaw8oGvx9aLt2yogvggS3NTJG49fFG6
         jmAJdNj6c2tAIwVzkLMd3J/HbVaaXrywKXtbBgYY6xxuptnuO8Bn+ydOZALpWnwADh7m
         ch5pyVOD5DK4H3c2OpUu0WNBzzb8I5KyjOnu1nLuN/1daBe4GCq3bF2vvZ6p3JUQGPv4
         uglLVhg+sEbUcUJ+BAEA1RpeqORqdNISz3VL764tRkg7+WpbzedShoj/K++apOlwPiJ5
         EQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HquMs86R/2fSeMwrKiFYntNswT/jyW+k3LeVZxsjHFc=;
        b=6PtKvSGf8WgjtgAC9Es5oxCiLBL7qHP+SKKD0oNmUvzKWF3ETubNcSdlsgLrCYIKLG
         FVYM9W3EFC1X/xmXCV5l0lRo+JMrL4NRnl99qVmkzcKPlEiT2T/f9QCLA45L8Aqly5uX
         vdb2lgEYuIRTD5kzmKiq4HgIYZj3vlddjZMvM59XHh5HNlU7vlZDl/STMZUgjgl/3ISd
         Eu/FdHiZth3EjeUsG9g8b/IuuZlGxJQSw5oQyk+mxbhqK5xdE5U+KE9lNhaMzcTLX5ZR
         LTK0xCRGTD2lSGWJVcGjPhF/E6y3Yd87/CPS1/QpbPjPyc3+eLsEp3E167QFbFAx81+Z
         Wtgg==
X-Gm-Message-State: AOAM531YQHys2PzjZzUMDUORNC7dgYVq9BbnzyQSt1XdML5zPUANrRfM
        t/0qQ2AoOouFH4qFkNr59MY=
X-Google-Smtp-Source: ABdhPJxsbq3CsAbIef75T6kasQUgh1BPtxbFzJI3LjtCD4VpZZEwaW683xGiB2wbopwaPfTSrv4Kcg==
X-Received: by 2002:a05:600c:4ed1:: with SMTP id g17mr19264564wmq.112.1640908575690;
        Thu, 30 Dec 2021 15:56:15 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c015-2400-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c015:2400:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id f16sm35137581wmg.27.2021.12.30.15.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:56:15 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] drm/meson: Fix error handling when afbcd.ops->init fails
Date:   Fri, 31 Dec 2021 00:55:15 +0100
Message-Id: <20211230235515.1627522-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230235515.1627522-1-martin.blumenstingl@googlemail.com>
References: <20211230235515.1627522-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When afbcd.ops->init fails we need to free the struct drm_device. Also
all errors which come after afbcd.ops->init was successful need to exit
the AFBCD, just like meson_drv_unbind() does.

Fixes: d1b5e41e13a7e9 ("drm/meson: Add AFBCD module driver")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index b919271a6e50..26aeaf0ab86e 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -302,42 +302,42 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (priv->afbcd.ops) {
 		ret = priv->afbcd.ops->init(priv);
 		if (ret)
-			return ret;
+			goto free_drm;
 	}
 
 	/* Encoder Initialization */
 
 	ret = meson_encoder_cvbs_init(priv);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	if (has_components) {
 		ret = component_bind_all(drm->dev, drm);
 		if (ret) {
 			dev_err(drm->dev, "Couldn't bind all components\n");
-			goto free_drm;
+			goto exit_afbcd;
 		}
 	}
 
 	ret = meson_encoder_hdmi_init(priv);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	ret = meson_plane_create(priv);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	ret = meson_overlay_create(priv);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	ret = meson_crtc_create(priv);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	ret = request_irq(priv->vsync_irq, meson_irq, 0, drm->driver->name, drm);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	drm_mode_config_reset(drm);
 
@@ -355,6 +355,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 
 uninstall_irq:
 	free_irq(priv->vsync_irq, drm);
+exit_afbcd:
+	if (priv->afbcd.ops)
+		priv->afbcd.ops->exit(priv);
 free_drm:
 	drm_dev_put(drm);
 
-- 
2.34.1

