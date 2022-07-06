Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C455F5688BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiGFMx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiGFMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:53:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C79255A9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:53:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 5so7695505plk.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpU/47CIGfcMKZ4E2aqoCQ1BOqNCcamkTX7gRfUbreo=;
        b=N4/8r99A/+2PtNfA6zKC7zYa6daai8aymv0oo3OLKvNL1LFMgLq9MqhuNCRPZ3Orxk
         9zvYKc6A5GGxS5wljKrCbsmwjwHl6kAnoYdQMXqFdMF7SXJW4lvoOmGOpHB6cWTmBgbP
         vttKZCao/XCM9jfG6jGi8vO8rWAAtlO5bajew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpU/47CIGfcMKZ4E2aqoCQ1BOqNCcamkTX7gRfUbreo=;
        b=EmFY6ABkNsHpq67KkEGiiJ/E1FTlz9EVeEwm1qYmytSoqcDkM0RO0Z6TVFoCYaobRe
         IWpeokP6yCTUXJ0ZiM/8Lwow2S93oZG/cnsj0DirBQwXunkmTbDsczX2zbcuf9CA1s3Z
         GNeLtdfXwWQ95nbYerSp/ia830eu2arxlwFnjA/crkjTkadcIzZP/k9HENfiflMlSLAc
         UaCjSW95HwVvAkVGpCx8N38kuyR3tle6xQa/OQq28/BX+NoxFsMOV7+edbCb457uyB6J
         mWw3JKfeNS3OEiTwQR6Cr7NaoLmAdxPNgE0QoAsOy4AlhtXxC5oqzdBRaB9Lkiayllyi
         ju3Q==
X-Gm-Message-State: AJIora+THBupUrg5MkSLmmdHbD2AzU94u5kH5zqZbvd27XfmLQkBe7dy
        ixGGg2j+Lva2tWJ/aNOFTfJsBw==
X-Google-Smtp-Source: AGRyM1vPZy1bE7pCVFrwvF6JhtLpJ3e5q30yrQdoFZdI6S+SjkzAjaWd6jRhqaEDx5rYAAusjkJdSg==
X-Received: by 2002:a17:902:d50d:b0:16b:ff69:35 with SMTP id b13-20020a170902d50d00b0016bff690035mr4257876plg.160.1657111992179;
        Wed, 06 Jul 2022 05:53:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5300:b974:1680:1bd])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b0016a6cd546d6sm25640127ple.251.2022.07.06.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:53:11 -0700 (PDT)
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
Subject: [PATCH v2 4/4] drm/bridge: anx7625: Add wait_hpd_asserted() callback
Date:   Wed,  6 Jul 2022 20:52:54 +0800
Message-Id: <20220706125254.2474095-5-hsinyi@chromium.org>
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

Move hpd polling check into wait_hpd_asserted() callback. For the cases
that aux transfer function wasn't used, do hpd polling check after pm
runtime resume, which will power on the bridge.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Xin Ji <xji@analogixsemi.com>
---
v1->v2: fix indent.
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 33 ++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index aded20b9e25b1..d1f1d525aeb6d 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1443,23 +1443,24 @@ static int anx7625_read_hpd_status_p0(struct anx7625_data *ctx)
 	return anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, SYSTEM_STSTUS);
 }
 
-static void anx7625_hpd_polling(struct anx7625_data *ctx)
+static int _anx7625_hpd_polling(struct anx7625_data *ctx,
+				unsigned long wait_us)
 {
 	int ret, val;
 	struct device *dev = &ctx->client->dev;
 
 	/* Interrupt mode, no need poll HPD status, just return */
 	if (ctx->pdata.intp_irq)
-		return;
+		return 0;
 
 	ret = readx_poll_timeout(anx7625_read_hpd_status_p0,
 				 ctx, val,
 				 ((val & HPD_STATUS) || (val < 0)),
-				 5000,
-				 5000 * 100);
+				 wait_us / 100,
+				 wait_us);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "no hpd.\n");
-		return;
+		return ret;
 	}
 
 	DRM_DEV_DEBUG_DRIVER(dev, "system status: 0x%x. HPD raise up.\n", val);
@@ -1472,6 +1473,23 @@ static void anx7625_hpd_polling(struct anx7625_data *ctx)
 
 	if (!ctx->pdata.panel_bridge && ctx->bridge_attached)
 		drm_helper_hpd_irq_event(ctx->bridge.dev);
+
+	return 0;
+}
+
+static int anx7625_wait_hpd_asserted(struct drm_dp_aux *aux,
+				     unsigned long wait_us)
+{
+	struct anx7625_data *ctx = container_of(aux, struct anx7625_data, aux);
+	struct device *dev = &ctx->client->dev;
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	ret = _anx7625_hpd_polling(ctx, wait_us);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
 }
 
 static void anx7625_remove_edid(struct anx7625_data *ctx)
@@ -1741,6 +1759,7 @@ static struct edid *anx7625_get_edid(struct anx7625_data *ctx)
 	}
 
 	pm_runtime_get_sync(dev);
+	_anx7625_hpd_polling(ctx, 5000 * 100);
 	edid_num = sp_tx_edid_read(ctx, p_edid->edid_raw_data);
 	pm_runtime_put_sync(dev);
 
@@ -2378,6 +2397,7 @@ static void anx7625_bridge_atomic_enable(struct drm_bridge *bridge,
 	ctx->connector = connector;
 
 	pm_runtime_get_sync(dev);
+	_anx7625_hpd_polling(ctx, 5000 * 100);
 
 	anx7625_dp_start(ctx);
 }
@@ -2497,7 +2517,6 @@ static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
 	mutex_lock(&ctx->lock);
 
 	anx7625_power_on_init(ctx);
-	anx7625_hpd_polling(ctx);
 
 	mutex_unlock(&ctx->lock);
 
@@ -2589,6 +2608,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	platform->aux.name = "anx7625-aux";
 	platform->aux.dev = dev;
 	platform->aux.transfer = anx7625_aux_transfer;
+	platform->aux.wait_hpd_asserted = anx7625_wait_hpd_asserted;
 	drm_dp_aux_init(&platform->aux);
 
 	if (anx7625_register_i2c_dummy_clients(platform, client) != 0) {
@@ -2617,6 +2637,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	if (!platform->pdata.low_power_mode) {
 		anx7625_disable_pd_protocol(platform);
 		pm_runtime_get_sync(dev);
+		_anx7625_hpd_polling(platform, 5000 * 100);
 	}
 
 	/* Add work function */
-- 
2.37.0.rc0.161.g10f37bed90-goog

