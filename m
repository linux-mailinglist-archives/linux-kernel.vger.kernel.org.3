Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB549228C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbiARJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240750AbiARJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:20:11 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E352C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:20:11 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u11so18627478plh.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3q9wkMinheXrqXy/yp63auEPN8EtJaQhX9gCBlzKxgs=;
        b=aK2MDPeSWHHwrY//afMrQLweMQ/RyKgAzoZfk/ZzlXXfqJg6DzJjaAF7Afq6nR6xKn
         FA0J3a1IxoYd4QbSJXwdD+TS1H2RCzNXzWIhJbsXnkcnpL0zUEZEr7rTiOSRrm9cyMb4
         uiWExIlSi++fDL7WGEZ8vh5ANpKjA5VmhH0Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3q9wkMinheXrqXy/yp63auEPN8EtJaQhX9gCBlzKxgs=;
        b=vcN1KjxMltfgWjmeR2kdb9K72/9AorRUX+F7UETA7DmXdviazrTYGbfEESWeaEk3rY
         srNmPLzyzdHKpl3EExTmDu7qdm0avtPJ/rhg4u7vohRktBxid/9FUuiIlteM9/bGTsmi
         ccIYb94ctoDBaALMOAWz3A5OcMWSG/4CfhTKERGRvg0UChJlKjcyFteztz7xdlgYicTH
         4KMazsKsitVP9lPZ7fxaXH8Uo4lgINUXtqqCyBHKfyhMnuEE98QjlhIaoY5ogRo/iTJW
         uf/Y5+R9qHWQXRPAYPEBK+UsRNOy9pdlOq/xijlb8FJJpSt2LDKX+Tivf6SJgclLytKs
         v1+w==
X-Gm-Message-State: AOAM531V22e27OZZZBa7BZuTjEmynzWaQj1niQznUBP4lBLYbrOHERu3
        wrZhTdMRsqrVgHbK5ui46tSNbQ==
X-Google-Smtp-Source: ABdhPJzUUIoYrADArPB2qee5422yaGuvsUv4wN5fx07v7yPnixxhBxxfZXpwkmV8u8H984h7eE2TtA==
X-Received: by 2002:a17:90a:380b:: with SMTP id w11mr29582367pjb.113.1642497610547;
        Tue, 18 Jan 2022 01:20:10 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:4448:8072:97f1:64dd])
        by smtp.gmail.com with ESMTPSA id y1sm14691501pgs.4.2022.01.18.01.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 01:20:10 -0800 (PST)
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
Subject: [PATCH v4 2/4] drm/bridge: anx7625: Convert to use devm_kzalloc
Date:   Tue, 18 Jan 2022 17:20:00 +0800
Message-Id: <20220118092002.4267-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118092002.4267-1-hsinyi@chromium.org>
References: <20220118092002.4267-1-hsinyi@chromium.org>
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
2.34.1.703.g22d0c6ccf7-goog

