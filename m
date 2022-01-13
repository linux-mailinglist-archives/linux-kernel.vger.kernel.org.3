Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C260548D2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiAMHcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiAMHcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:32:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DECC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 23:32:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a1-20020a17090a688100b001b3fd52338eso8737430pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 23:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=du7UtZTksojdMdJU3Db9bmQRhjFxVrsUPN0QxzhmRfQ=;
        b=XRWcnUSui98p33/sm26qBbm54SzZ5iNXYwDIcVdlfutHdp+FoBy9DGkBxVpyY1qhqe
         F7tIH3HNM2cBotmLWDmhP9RiKfRNuuIkg5LKMAQ1YUFRU3ZgzZdcEaZ+A2lEnBR9RFSW
         9tcWf7RSJa+K+GpQPptN80vS5ud6XPJCKCZZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=du7UtZTksojdMdJU3Db9bmQRhjFxVrsUPN0QxzhmRfQ=;
        b=inqmwkYci6cNODN4T2vWlRADptX+jxVVYMvozfACFVE+h409WucE0hR1RRpeoxKAtF
         thRz39UtMQsIwUzKBEIYPmuu/b3oWu8oM5sO2LtD721prRJ6ro/ZMc6bEu5mvieR6yod
         Cj9ILkykIf2kMfXR4fpWcrjHCtKMZ36r3hE/AnZeF9hqiZk+WnbdsJtRPoARi09h/1NJ
         vRb2bx1Z71CUeIL1laVGSHpa6lEuoMK/0t6EHnj9ywnpHx51J61oUv6Kn10ZrCw8lycm
         ZEZy50szZrafUMjowJfZcpvEWL4GizxV4Khl0qRHvGhg8329HEq9rc44g333RK74+U0e
         Gcnw==
X-Gm-Message-State: AOAM530l0Ma3ZXhYaAC7DoaeI0O+vz90ogf8HtsnonivTsQVH+O6t2mm
        n1sPOiBolhtdBu5AR9aTHRToig==
X-Google-Smtp-Source: ABdhPJzVfQyp3OrIqmUib4qqArq4Pah8l2B6psdTAz7f/amb43BdGKeleLHCVHWdiaVpTaelcbMCrg==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr3756416pjb.126.1642059124107;
        Wed, 12 Jan 2022 23:32:04 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:3ced:e0da:4852:430c])
        by smtp.gmail.com with ESMTPSA id om3sm7747701pjb.49.2022.01.12.23.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 23:32:03 -0800 (PST)
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
Subject: [PATCH v2 1/3] drm/bridge: anx7625: Convert to use devm_kzalloc
Date:   Thu, 13 Jan 2022 15:31:56 +0800
Message-Id: <20220113073158.2171673-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
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

