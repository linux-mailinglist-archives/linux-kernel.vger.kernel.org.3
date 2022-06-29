Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E0756055A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiF2QG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiF2QGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:06:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FAE10FC3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:06:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x138so12866014pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwimkmoBK2vJGij8UUnRV6t0uOjwq6dnkWSCt3UmvOg=;
        b=BC5StwdHRdfpkrXcfq8wY3aIGaAhCJid7IBMUYBfsZOf8zWHOeEV0BSDhwzF/NrkbI
         SFlILCqtdZyXrtspikiixxiWQLdx4BK6wpQqysFkp6JaD0MAJma06YXNl9bbG7aOFAH/
         Od9MGSrXh/UJ4SM7eHK/kp2xn4FhNKJUFQQ7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwimkmoBK2vJGij8UUnRV6t0uOjwq6dnkWSCt3UmvOg=;
        b=wHmnkxQUz7OCsxSLprTgdJ6X9MT0qvcg/4gUaUViogdeFt/xc+BfsvOemh4faDMpil
         6FR7mo2foFA0vTn1Lzn4pLSMQceiJhMlJCczr2NO8ybp6/ByCPG8PgXwtDepvDCxXIQ3
         d80TYGNEiEWFh0Ux/sgwPCC/NOOiES5KrO58uHDEAi/keebkhaGGs/EzaJ4hw6BMJUwW
         STI8jBTyroIecEqxv3S2NqEW00aZ4z+8PC/BC3F//jcX4e8RUUQZoln82rFUPjcuo/Dx
         W5lQ0ka9l8LgM/LCDZl5dzMqdC75mxO4nZfEnJMBcjQucaibWK6Pj2QZUWJtxkHvPDez
         xNIQ==
X-Gm-Message-State: AJIora+o+BBzMuS+RC8EcoI6VGipvDU12y0MlrwlXtSAkdmbt2av057F
        +IHIX5X1d3L9rq9iP15yy6UaLw==
X-Google-Smtp-Source: AGRyM1tYJfwH/bSAlF+6S8zoDJUYsVl0BO11qvOxodSG+nzG1h/rZYNyVFyxZf87MyrFiLdtW/8Nlg==
X-Received: by 2002:a05:6a00:1f94:b0:527:a8f4:9811 with SMTP id bg20-20020a056a001f9400b00527a8f49811mr9529367pfb.71.1656518768201;
        Wed, 29 Jun 2022 09:06:08 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9841:721:7d8b:4502])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902e3d300b00163f8ddf160sm11495350ple.161.2022.06.29.09.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:06:07 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>, Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/bridge: anx7625: Fix NULL pointer crash when using edp-panel
Date:   Thu, 30 Jun 2022 00:05:49 +0800
Message-Id: <20220629160550.433980-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629160550.433980-1-hsinyi@chromium.org>
References: <20220629160550.433980-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move devm_of_dp_aux_populate_ep_devices() after pm runtime and i2c setup
to avoid NULL pointer crash.

edp-panel probe (generic_edp_panel_probe) calls pm_runtime_get_sync() to
read EDID. At this time, bridge should have pm runtime enabled and i2c
clients ready.

Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid through aux channel")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 478f5af381c7d..59ddeba33652b 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2590,14 +2590,6 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	platform->aux.dev = dev;
 	platform->aux.transfer = anx7625_aux_transfer;
 	drm_dp_aux_init(&platform->aux);
-	devm_of_dp_aux_populate_ep_devices(&platform->aux);
-
-	ret = anx7625_parse_dt(dev, pdata);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			DRM_DEV_ERROR(dev, "fail to parse DT : %d\n", ret);
-		goto free_wq;
-	}
 
 	if (anx7625_register_i2c_dummy_clients(platform, client) != 0) {
 		ret = -ENOMEM;
@@ -2613,6 +2605,15 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	if (ret)
 		goto free_wq;
 
+	devm_of_dp_aux_populate_ep_devices(&platform->aux);
+
+	ret = anx7625_parse_dt(dev, pdata);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			DRM_DEV_ERROR(dev, "fail to parse DT : %d\n", ret);
+		goto free_wq;
+	}
+
 	if (!platform->pdata.low_power_mode) {
 		anx7625_disable_pd_protocol(platform);
 		pm_runtime_get_sync(dev);
-- 
2.37.0.rc0.161.g10f37bed90-goog

