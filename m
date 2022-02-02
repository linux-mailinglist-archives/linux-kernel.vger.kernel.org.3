Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0B14A7572
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345766AbiBBQGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345719AbiBBQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:06:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84360C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 08:06:11 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c9so18699189plg.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1kno40kXqd5oHnIK3ylT4ecdPILvrVqPlIbaZeuMIA=;
        b=eCNIwVf1UszjQp3t8C03ncVpIjOPernL3qKHVwkQsOmZHmZ5zYbbw4HGs6R6qk+yNR
         2+M6RnlBh2+Y9CpyHWGAB0+/VD+JS3y0Fv5iCfPNRglL02xg61DMAbTDG/3AMXAwo+Pg
         bBpCJKzHuH/425GXGj4MSFv8xlc9QVlOj4bIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1kno40kXqd5oHnIK3ylT4ecdPILvrVqPlIbaZeuMIA=;
        b=VHoTQNVgVJU5//iNXfGmHvT4nfdLpW4hDxrPQs7RB3KGbyglyvhLjAErCXvGBcXIqt
         oLOxnRodGGc2JpXgzRZAwy8Wp2VUlUVmbdRWFSvVNOJTxN5KT2dg0xlp1RdqArgUi33B
         wGCSrKcwcLWMPT1uC1pcVb+dWkAWvhpPjAAS7oyU/X2OPK88rF/Mng+Of8KKwCduhQZr
         wVp0o09JzWua2SSHo6xVVQ2bpvd0Dz5DjZQFdaIGWSf0oBTXLUClSAls64nEq9dMy37j
         FTwdp8RLhvVelBO4JCEq80I0ESPi1ROB6Vn/qnPe0y6vqhwUBQuc+PmAcL8+DYirITzE
         rVlg==
X-Gm-Message-State: AOAM531Wv5UNN1NNAH0kKDZm+MGZylEvKrXoTxeji58yK7KU+0hQn3Kp
        FSv4497gjSOZ0lE6V60WzjgYdkxCCWiKPA==
X-Google-Smtp-Source: ABdhPJzUD24F/TZr17nwIVcYrxd8vfKzfmfXbAlOcbW8sRVyKwgtR4FkwC/X7OzrDzLeJS8OW/QmfA==
X-Received: by 2002:a17:90b:380f:: with SMTP id mq15mr8912309pjb.66.1643817970945;
        Wed, 02 Feb 2022 08:06:10 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:7ce0:466c:be86:774])
        by smtp.gmail.com with ESMTPSA id g5sm14722397pgc.51.2022.02.02.08.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 08:06:10 -0800 (PST)
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
Subject: [PATCH RESEND v5 2/4] drm/bridge: anx7625: Convert to use devm_kzalloc
Date:   Thu,  3 Feb 2022 00:06:00 +0800
Message-Id: <20220202160602.440792-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202160602.440792-1-hsinyi@chromium.org>
References: <20220202160602.440792-1-hsinyi@chromium.org>
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

