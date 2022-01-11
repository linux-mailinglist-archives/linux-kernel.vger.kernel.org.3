Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857D148AC6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349424AbiAKL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbiAKL1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:27:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF73C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:27:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id pj2so16654424pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUFyLMV0GWlHVuW18MQAch8BvfbkZ5RjN4y5TyCoTS8=;
        b=AxaAg6kIlLkHQsgU8s3+5BYRqH+T7qGlAtHcFXe/nZyZkWuSeaVPkIwI8bHC+dhMRP
         1TmsCCmbgdLsM1HIGsw5+p1nIoKOGkCPC6d1pdWxel81y8Nq9g8Cf3BiaSAy7TAAO3qY
         hBhizOVeYiVZB07OGNLxxkMaddMOMswIkjjyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUFyLMV0GWlHVuW18MQAch8BvfbkZ5RjN4y5TyCoTS8=;
        b=h8AsgqVBDj+KGpu2JkIRAIWjjrA1ltFv+VzmnZziPSc/r3vB+AZSUdn8kWuEcojv8p
         zWHNxfhJ/s685Q8Z5IB7zvjrsklqqLGaxumCasyfk4ZJGFLQcF5nkALV4bujMynDXE4s
         nR6f7yNjChDx9dX97KSxLORQBDC4CPHHLZ+11V8+RI5lil71Ppb6QAQu2BtYH8PBg2x4
         dizj8nJMZ/zoyOygpwLR72oyAPAvzNTs/0Qo8/jPolMgp3dAtE//YgZ+kuFNROPFcWkG
         0W1xsWAA9R02VqE7On3GYTJewUFjBUCdpKT4SN0P0tMTtPBepoBgNdWSZQyZD5J7TYAY
         DgaQ==
X-Gm-Message-State: AOAM530IzJI3aCs11doQda9VPMUVZmYZ0//GQsRbJKV4/Fjr8kvdhl+Y
        xUN2SwqhFocNAVH8Tu8wIrKMRw==
X-Google-Smtp-Source: ABdhPJwADokKLYG31oJnwFzrI95A99W/MQk1LAj6PUhOiImevr2TrxdzpObC4qORur6heDHtrep/+Q==
X-Received: by 2002:aa7:8642:0:b0:4be:9b5a:d4db with SMTP id a2-20020aa78642000000b004be9b5ad4dbmr4045759pfo.64.1641900426453;
        Tue, 11 Jan 2022 03:27:06 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a41:eba5:ec46:f86c])
        by smtp.gmail.com with ESMTPSA id d12sm10664856pfv.172.2022.01.11.03.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:27:06 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 1/3] drm/bridge: anx7625: Convert to use devm_kzalloc
Date:   Tue, 11 Jan 2022 19:26:59 +0800
Message-Id: <20220111112701.1064458-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kzalloc instead of kzalloc and drop kfree(). Let the memory
handled by driver detach.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 0b858c78abe8b6..dbe708eb3bcf11 100644
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
 
-- 
2.34.1.575.g55b058a8bb-goog

