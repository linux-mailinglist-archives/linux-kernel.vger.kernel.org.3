Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613935688C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiGFMxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiGFMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:53:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95824F26
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:53:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y18so5565575plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jts1Y9JMpVL0If8P8yimWr5loe4E0VIqYItcqhdJT04=;
        b=J5h7sC+wpA1ej0AY7GGFDGcLzlBfbS2jtjQAtEj3EooYLMSkvj+E/iH7Ihp5W/wj/U
         5av2KGOQdc8rZFtYkRx2Ww0Ty5D2u9A2G7dZfNfbS7wy/za51jTXhMuKYfj+XqabLgs/
         EtJmN4yrr1ag0rJ9mDGzrgjDPQDiRCkguqDAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jts1Y9JMpVL0If8P8yimWr5loe4E0VIqYItcqhdJT04=;
        b=m9sycG7hxzb4F5OzyOS6kgSK/lyt+PVnKSVOwsSF51lhPbP915C1bQDvA45isVsXjV
         W7eisjFOg/WLvMG7h4XyV+wro2GUL3lwegd6+bUaBCTOkuZr0C8Cj8pRY6C1Tfze4dg2
         wgzmVyfZl4P5DciTu3Vp+NC44klJtuzAOiFmT7VeZ/AZsVhWrCJzK7hmJdAancYg8QtF
         NRPp+TAlzIYJBw8ifB8VQCXnFe7ZXPlL1fMKnh8spADyJiW8c7Ex6z2a7IebQOWnchQi
         fHMxY8ko/zbT6noKEWDGx31p64V4DqhlH6pCqRBFf4fz6Lqd1RTtfI2tTvcL4FmI78bl
         FvYQ==
X-Gm-Message-State: AJIora+nK/wd1mMbAcI+LvaMZlna+XyuxallvcdqZVm/Z4h5PPbLRZjt
        94gfLIP8vNLLmTCoj2+0v8Tshw==
X-Google-Smtp-Source: AGRyM1t3rkNRA6Pzf7Rhejl5i6Yk/NJFrroHb1CZ1jTGwinOP7wTDoxpkRm6jtCxnL+OTuJWRwSxKw==
X-Received: by 2002:a17:903:41d0:b0:16a:55e0:6c3d with SMTP id u16-20020a17090341d000b0016a55e06c3dmr47794830ple.21.1657111989582;
        Wed, 06 Jul 2022 05:53:09 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5300:b974:1680:1bd])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b0016a6cd546d6sm25640127ple.251.2022.07.06.05.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:53:09 -0700 (PDT)
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
Subject: [PATCH v2 3/4] drm/bridge: anx7625: Fix NULL pointer crash when using edp-panel
Date:   Wed,  6 Jul 2022 20:52:53 +0800
Message-Id: <20220706125254.2474095-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220706125254.2474095-1-hsinyi@chromium.org>
References: <20220706125254.2474095-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index fcf07a037c2c8..aded20b9e25b1 100644
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

