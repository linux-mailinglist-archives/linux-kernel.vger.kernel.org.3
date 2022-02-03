Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5E4A85E1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351049AbiBCOKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351034AbiBCOKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:10:34 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9ECC06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:10:34 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id e28so2334410pfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 06:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1kno40kXqd5oHnIK3ylT4ecdPILvrVqPlIbaZeuMIA=;
        b=drsICCKIjZX+H+10whVsgZJFA1+0cYNv1js2APo/s1v8pCpku3jVbowqxbuOJFdyPZ
         eCFF9GBNQFMrryrGmg0o1+bH+hqaVaAjf9PWtFX92GX5YXdMVtzUeaEmI12HIzIJ3hVA
         qqdKLTx3O493QIoXDmIdHviLYtcBRB2ANndEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1kno40kXqd5oHnIK3ylT4ecdPILvrVqPlIbaZeuMIA=;
        b=BsYR29MdeJVni+sN6p/6cGSUqhvzueef5hIGvkC88K3K9n3qx8NRND/aUxoop1/zu7
         gPzwMWRZxHFnnD4DAOlDceJWNMOZFcR5lv+njv3/G7PwVihBi6PqDbFp1/lSEg3+J0ke
         HKimlEc/PTcDnN2rSrqP5lGWgCWCF8jd0tkclq6G6lSWfi3HIgIh+saZFlNEUzLggpSr
         QLbH64EAqXsQJ5xLANs4/eAwCz6y/uH7j5xz6xLJBsZHI1xFBgHqh+nMsgO5QGqTbALL
         qAHpoNv/yKY80FMDxaPAT3Mz6iuIAzl3DQfy6oZiotWzkgkwsobLYESPEu5WTxLvz+BS
         hRxQ==
X-Gm-Message-State: AOAM532nIbgJHsa6P+MnP0/ftJj5YPZ7lBPxdFtjqeKI017GlXUYx4zz
        vf3SkVcf8NtBQDOnvQxgn0ZfEw==
X-Google-Smtp-Source: ABdhPJw++DYqdL6VXabn9xYbAD0hZxWkFqsafO1u5OC5tXWjzCylo5+MwrUwxx4aTE7IaEP2FXKcXQ==
X-Received: by 2002:a63:6b02:: with SMTP id g2mr4627954pgc.526.1643897433413;
        Thu, 03 Feb 2022 06:10:33 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cbdf:65ae:127:f762])
        by smtp.gmail.com with ESMTPSA id w11sm29532818pfu.50.2022.02.03.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:10:32 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v6 2/4] drm/bridge: anx7625: Convert to use devm_kzalloc
Date:   Thu,  3 Feb 2022 22:10:21 +0800
Message-Id: <20220203141023.570180-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220203141023.570180-1-hsinyi@chromium.org>
References: <20220203141023.570180-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kzalloc instead of kzalloc and drop kfree(). Let the memory
handled by driver detach.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Xin Ji <xji@analogixsemi.com>
---
v2->v3: remove kfree() in anx7625_i2c_remove().
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 17b23940549a42..b7e3373994b480 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2515,7 +2515,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	platform = kzalloc(sizeof(*platform), GFP_KERNEL);
+	platform = devm_kzalloc(dev, sizeof(*platform), GFP_KERNEL);
 	if (!platform) {
 		DRM_DEV_ERROR(dev, "fail to allocate driver data\n");
 		return -ENOMEM;
@@ -2527,7 +2527,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
 			DRM_DEV_ERROR(dev, "fail to parse DT : %d\n", ret);
-		goto free_platform;
+		return ret;
 	}
 
 	platform->client = client;
@@ -2552,7 +2552,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	if (!platform->hdcp_workqueue) {
 		dev_err(dev, "fail to create work queue\n");
 		ret = -ENOMEM;
-		goto free_platform;
+		return ret;
 	}
 
 	platform->pdata.intp_irq = client->irq;
@@ -2637,9 +2637,6 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	if (platform->hdcp_workqueue)
 		destroy_workqueue(platform->hdcp_workqueue);
 
-free_platform:
-	kfree(platform);
-
 	return ret;
 }
 
@@ -2666,7 +2663,6 @@ static int anx7625_i2c_remove(struct i2c_client *client)
 	if (platform->pdata.audio_en)
 		anx7625_unregister_audio(platform);
 
-	kfree(platform);
 	return 0;
 }
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

