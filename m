Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CDF4B3AE2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiBMKez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:34:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiBMKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:34:50 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CAE5D679
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:34:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so16143982pja.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XlBwl7o2DNhygikLmKSXtkQRcDcWt/TKcyEWF2to5rk=;
        b=VAAPmWcvaHNUdrS2u53/VaEJDPb9prLyiHuw80d7g6QMuXnIKY50lvgl2QrHuDGpx+
         XH7B5g/EPetbCInq7yCPXlCwSvmjuDrYU0SF6499sCxwSFHw0BsYSammHG+XCsC8uGDo
         LdGckrvNCOE16ID/se/afR6GDAqSd0Hv1ATyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XlBwl7o2DNhygikLmKSXtkQRcDcWt/TKcyEWF2to5rk=;
        b=SuJzN8jyWTPXITkKy3apxbAtboLjsH86rAJbmCSfkZokXjP0NkpbIg61kzBc+c+H4U
         SrqOqePSwd1QVwBZBU3A1Gn/jUTjVK4RtojuS3w/gX/pvS9hkuCy6RWn2JSt2taOnwzI
         +175MP4F7/PR4Y9aaNEkoVkKPhSas9Ko9ASGxFks1Pe1mLKzazsyuI0rqt+puY8NYLxd
         ILUkdagztcud8pcPB+CvPnwC3Cme4gCWUBjzTAxSaRcahyeAmHZv/c90KE6V2VwWbey7
         Y5uMLymZ034XUOjtwJ5XrXtKXBAfGK/NfUvcS9VTpkBmIMXgF60fg4oLJEgHp1QfxfJu
         xV3A==
X-Gm-Message-State: AOAM531HHxpU2Vt7XQ1hUUcv5B5x3wcl1Nnu/9bRbSTIiaDrHr1m6031
        bPKdZW9zz3sq/e9dQS8H9Oa/cw==
X-Google-Smtp-Source: ABdhPJx94pETzDPyGgDuZhPH83OhmsRPB3UaRsFJltfeL30LyGvKcouT89u1M5Mn4hHkMLPS7/2rwQ==
X-Received: by 2002:a17:902:7281:: with SMTP id d1mr9449746pll.26.1644748485459;
        Sun, 13 Feb 2022 02:34:45 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:3653:bf18:8571:5f26])
        by smtp.gmail.com with ESMTPSA id n85sm1589407pfd.142.2022.02.13.02.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 02:34:45 -0800 (PST)
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
Subject: [PATCH v7 2/4] drm/bridge: anx7625: Convert to use devm_kzalloc
Date:   Sun, 13 Feb 2022 18:34:35 +0800
Message-Id: <20220213103437.3363848-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220213103437.3363848-1-hsinyi@chromium.org>
References: <20220213103437.3363848-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.35.1.265.g69c8d7142f-goog

