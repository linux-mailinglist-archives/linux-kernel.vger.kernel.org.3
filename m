Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1246AF29
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354182AbhLGAdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344456AbhLGAdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:33:07 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E76C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:29:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y7so8248522plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KwSNWNmS5A3o/1YUiJZz0ef7pg3vZf37AUR9Jx7txiA=;
        b=j5TPG5D6iGGlUhUGkz7lWoOFUl5Zcy1I25YFqtVQzQMd9hRvxHo1g8FJghAKUzJwyn
         qQ9W1va6XU4ulE3fo6MjQcXlsVdrZfbY24YqeqzgelWwCLDS2lLgtFm4n4T/Rv3efjcO
         TgoCHgwehFBceoxjK1ztr3yugEkMOttl+KZIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KwSNWNmS5A3o/1YUiJZz0ef7pg3vZf37AUR9Jx7txiA=;
        b=2w5eYiIRb5I8HzN5AbRaR6OWHNvSeLgm6nFMrXK0/Yn7rGek22FPFijK0bErG0ymhY
         LUkXoGr8xYxms4vBA/IQT5sNoPOSAZNwcVrgkI3qWFxFtLIaZIb2j9WXIJD6peQBEOm7
         FqUEg4FbCNDpgMr+Tc2IKaI/B9Pm7DHLCAac2hBYEQ0S3dPg8eAdGEfHDv/tCdSdvMV8
         5+a69tWMAtBE+hxbMZPjMtoScfyoUsAkh55faedXu75SOUWNewFFwKv8FZikpDOfUfrh
         AguXOkzmZXHadUcnzQq+98OiZM+SR3rbUX/WV7R5mM+qpH5JNhqL8+zkIMTfrCCc0eYE
         OVLA==
X-Gm-Message-State: AOAM533aKb/tiQYjh9tuOw418EynmIocLNZIS4T3356aVVpJZLTYgPaC
        a6MqaFJV7+4jUPb5sxnTvZ92kg==
X-Google-Smtp-Source: ABdhPJy4GyDRBHTZ2ZmWGQRiCTI+9pVPBVlT1KvfSYKm8ucP4rQoWfP/6Hqa+/0WzTjprT3f1yzInQ==
X-Received: by 2002:a17:902:bb97:b0:144:d5cb:969f with SMTP id m23-20020a170902bb9700b00144d5cb969fmr47338882pls.36.1638836978293;
        Mon, 06 Dec 2021 16:29:38 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:a783:e7e8:acf6:96a5])
        by smtp.gmail.com with ESMTPSA id b8sm13141154pfr.213.2021.12.06.16.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 16:29:38 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Lyude Paul <lyude@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: parade-ps8640: Add backpointer to drm_device in drm_dp_aux
Date:   Mon,  6 Dec 2021 16:29:16 -0800
Message-Id: <20211206162907.1.I1f5d1eba741e4663050ec1b8e39a753f6e42e38b@changeid>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we added the support for the AUX channel in commit 13afcdd7277e
("drm/bridge: parade-ps8640: Add support for AUX channel") we forgot
to set "drm_dev" to avoid the warning splat at the beginning of
drm_dp_aux_register(). Since everything was working I guess I never
noticed the splat when testing against mainline. In any case, it's
easy to fix. This is basically just like commit 6cba3fe43341 ("drm/dp:
Add backpointer to drm_device in drm_dp_aux") but just for the
parade-ps8640.

Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX channel")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 26898042ba3d..818704bf5e86 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -449,6 +449,7 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
 		return -EINVAL;
 
+	ps_bridge->aux.drm_dev = bridge->dev;
 	ret = drm_dp_aux_register(&ps_bridge->aux);
 	if (ret) {
 		dev_err(dev, "failed to register DP AUX channel: %d\n", ret);
-- 
2.34.1.400.ga245620fadb-goog

