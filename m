Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516EC48515F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiAEKse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiAEKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:48:33 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBB9C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:48:33 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 200so35194667pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 02:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=nBmNBAQ4hWVtra8c2jSUbNZPXDwdJxy3lN7QmYn/eTU=;
        b=FrtT2pI+Irbd3Aj5ERh5/QdY2C+8WwZYcvyoiDoOBHzPkv5svtVS9sDDfWwsvvNclT
         q08BZAfQ7cv8v89JJHnEY+LZijGtgJ9287Oqrt1pI4DC46DgPM3M4ZxwkDZwrBpkE+8q
         Qqo+CRHXSwiLUAAUsTqalYkrecvWqX83vUgKlXDaFMbPDuEVNrRtFA/TBcCNtY/y48Ff
         vf2aiXH+truLbK6Ny003rLCWMbAal1vU/HK3eUlpZRyuGbraQDqGYLXJf8faOlkJ4IuI
         ga/+PAGCXBjg//NJlNF2sRIf8aS8fjS2qlbadbgR8DFyWfs0i9FKhyhWD+N/6lm+oGN4
         Zfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nBmNBAQ4hWVtra8c2jSUbNZPXDwdJxy3lN7QmYn/eTU=;
        b=1o9BCBg0//HCJEx4ZL/wl3+gB52JOyoKlv1RUnRH5JjByrwepRut+PI4o8YfSUrohh
         kgi5+SKIALKjWJrsb5Seezk9LUxHAYUw40We0S1Xu4wVvB8iLOnlh3M/waph57xbhvuF
         f9gB6BqTBWFX2eMJfqJOGoPDPdRNAMRyEFgZh2QP10NvSjpsvdRS8g7kUuq08K8J2Qqf
         8xjTfpY8UTBozZBssvxTbtV9l2+U6AA/TH6o5V14Bbm1tgIxRfclTpcJR8CZLltqHQmY
         QURFPXEljE3rzQzBckOiyFKErQKLaiRke7WK3zuW4x0xH6DJM6E3r4lfprFnFUxMM0Gu
         k2ig==
X-Gm-Message-State: AOAM532tUMs5p0Tq8JJFHg6tQmt0fIDQ9IHAK/yk6G6LcezshCgJxjj2
        A/342raBcaSwjzDMaOmgqgQ=
X-Google-Smtp-Source: ABdhPJyRYj9zO9mX7/fkJBF4fCaILWvFlHOwDxKg4WhdQkF5WcUHW0h4c7JZWHsQOCyNDd96N6HP2Q==
X-Received: by 2002:a05:6a00:198a:b0:4bb:4621:f074 with SMTP id d10-20020a056a00198a00b004bb4621f074mr54759563pfl.69.1641379713067;
        Wed, 05 Jan 2022 02:48:33 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 27sm34878181pgx.81.2022.01.05.02.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 02:48:32 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: nwl-dsi: Fix PM disable depth imbalance in nwl_dsi_probe
Date:   Wed,  5 Jan 2022 10:48:26 +0000
Message-Id: <20220105104826.1418-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
Thus a pairing decrement is needed on the error handling
path to keep it balanced according to context.

Fixes: 44cfc62 ("drm/bridge: Add NWL MIPI DSI host controller support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index a7389a0facfb..fc3ad9fab867 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -1206,6 +1206,7 @@ static int nwl_dsi_probe(struct platform_device *pdev)
 
 	ret = nwl_dsi_select_input(dsi);
 	if (ret < 0) {
+		pm_runtime_disable(dev);
 		mipi_dsi_host_unregister(&dsi->dsi_host);
 		return ret;
 	}
-- 
2.17.1

