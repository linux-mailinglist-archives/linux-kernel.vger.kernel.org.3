Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B245688C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiGFMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiGFMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:53:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037F222BF2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:53:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso9932342pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwMB+k9IGlD1nBJyNrEkLFj2csDbu5Qc4SyaeENoXs4=;
        b=VLocBcR67BH55CFePg7A7u3NRm1n4ardKuomKvCqMEuZ1qS29FEGTPbwhupBegRGGV
         pEFJtFTMkb/b2XpBQPLTY7Oe7jtGOopiYkTJgulNCbmKKEnHW5FeZDiPqZmAKO0i8WqZ
         Lm9yqq7WX9rKKbs4KFq6mTwidKV/MGZxvUBHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwMB+k9IGlD1nBJyNrEkLFj2csDbu5Qc4SyaeENoXs4=;
        b=8DN111YYF+J7DiJhMss06d3PPSXS84PQIPHTTzP6jMVGKbVEoV9a6t43W/svm8ZBEI
         VMZ6GhVJl23ZydOgjoQLQL07fS4zRm2VoR4BL4HyPGnvj9EX/HX8cQP2AZ4a5NM2dHj7
         rK0mnVMnClqkek2Sb56mMUF3oG++NBarwvzP5oCkAZ+rGBMZVw1sbHCbUKNcsluhHY9r
         DkM0EbZdQUi2dTLSJIp6AbCX7H1gvYJb0MMLOJTHMBD9BfPZhElvIQ+UesbHnMXwAINd
         f7dzPFhFO0KgWDEWErTEWfdl90xSClARZzvsIfej2u4i+GIuNVwqKXfyOtN5PyEQqfoK
         NPKg==
X-Gm-Message-State: AJIora943Hp6TBFnR7Z5ybEuEHHVoy/9iW80YAx2bNqbBNNCE1kG3P6u
        5d7jq3ZCb14/ekbTwBPL8An0+A==
X-Google-Smtp-Source: AGRyM1vRXlvrOK3qxEFCRY5ntUjBQ+I/TKLHMNestZ/71lmAhunY5e/klvvWxIOHDet94pd164yMmQ==
X-Received: by 2002:a17:90a:178b:b0:1ef:7c85:8070 with SMTP id q11-20020a17090a178b00b001ef7c858070mr25348020pja.233.1657111984407;
        Wed, 06 Jul 2022 05:53:04 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5300:b974:1680:1bd])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b0016a6cd546d6sm25640127ple.251.2022.07.06.05.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:53:04 -0700 (PDT)
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
Subject: [PATCH v2 1/4] drm/bridge: anx7625: Convert to devm_i2c_new_dummy_device()
Date:   Wed,  6 Jul 2022 20:52:51 +0800
Message-Id: <20220706125254.2474095-2-hsinyi@chromium.org>
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

Simplify the resource management.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Xin Ji <xji@analogixsemi.com>
---
v1->v2:
Fix indent.
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 96 +++++++----------------
 1 file changed, 27 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 3710fa9ee0acd..ab346d32d8735 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2436,82 +2436,44 @@ static const struct drm_bridge_funcs anx7625_bridge_funcs = {
 static int anx7625_register_i2c_dummy_clients(struct anx7625_data *ctx,
 					      struct i2c_client *client)
 {
-	int err = 0;
+	struct device *dev = &ctx->client->dev;
 
-	ctx->i2c.tx_p0_client = i2c_new_dummy_device(client->adapter,
-						     TX_P0_ADDR >> 1);
+	ctx->i2c.tx_p0_client = devm_i2c_new_dummy_device(dev, client->adapter,
+							  TX_P0_ADDR >> 1);
 	if (IS_ERR(ctx->i2c.tx_p0_client))
 		return PTR_ERR(ctx->i2c.tx_p0_client);
 
-	ctx->i2c.tx_p1_client = i2c_new_dummy_device(client->adapter,
-						     TX_P1_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.tx_p1_client)) {
-		err = PTR_ERR(ctx->i2c.tx_p1_client);
-		goto free_tx_p0;
-	}
+	ctx->i2c.tx_p1_client = devm_i2c_new_dummy_device(dev, client->adapter,
+							  TX_P1_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.tx_p1_client))
+		return PTR_ERR(ctx->i2c.tx_p1_client);
 
-	ctx->i2c.tx_p2_client = i2c_new_dummy_device(client->adapter,
-						     TX_P2_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.tx_p2_client)) {
-		err = PTR_ERR(ctx->i2c.tx_p2_client);
-		goto free_tx_p1;
-	}
+	ctx->i2c.tx_p2_client = devm_i2c_new_dummy_device(dev, client->adapter,
+							  TX_P2_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.tx_p2_client))
+		return PTR_ERR(ctx->i2c.tx_p2_client);
 
-	ctx->i2c.rx_p0_client = i2c_new_dummy_device(client->adapter,
-						     RX_P0_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.rx_p0_client)) {
-		err = PTR_ERR(ctx->i2c.rx_p0_client);
-		goto free_tx_p2;
-	}
+	ctx->i2c.rx_p0_client = devm_i2c_new_dummy_device(dev, client->adapter,
+							  RX_P0_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.rx_p0_client))
+		return PTR_ERR(ctx->i2c.rx_p0_client);
 
-	ctx->i2c.rx_p1_client = i2c_new_dummy_device(client->adapter,
-						     RX_P1_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.rx_p1_client)) {
-		err = PTR_ERR(ctx->i2c.rx_p1_client);
-		goto free_rx_p0;
-	}
+	ctx->i2c.rx_p1_client = devm_i2c_new_dummy_device(dev, client->adapter,
+							  RX_P1_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.rx_p1_client))
+		return PTR_ERR(ctx->i2c.rx_p1_client);
 
-	ctx->i2c.rx_p2_client = i2c_new_dummy_device(client->adapter,
-						     RX_P2_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.rx_p2_client)) {
-		err = PTR_ERR(ctx->i2c.rx_p2_client);
-		goto free_rx_p1;
-	}
+	ctx->i2c.rx_p2_client = devm_i2c_new_dummy_device(dev, client->adapter,
+							  RX_P2_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.rx_p2_client))
+		return PTR_ERR(ctx->i2c.rx_p2_client);
 
-	ctx->i2c.tcpc_client = i2c_new_dummy_device(client->adapter,
-						    TCPC_INTERFACE_ADDR >> 1);
-	if (IS_ERR(ctx->i2c.tcpc_client)) {
-		err = PTR_ERR(ctx->i2c.tcpc_client);
-		goto free_rx_p2;
-	}
+	ctx->i2c.tcpc_client = devm_i2c_new_dummy_device(dev, client->adapter,
+							 TCPC_INTERFACE_ADDR >> 1);
+	if (IS_ERR(ctx->i2c.tcpc_client))
+		return PTR_ERR(ctx->i2c.tcpc_client);
 
 	return 0;
-
-free_rx_p2:
-	i2c_unregister_device(ctx->i2c.rx_p2_client);
-free_rx_p1:
-	i2c_unregister_device(ctx->i2c.rx_p1_client);
-free_rx_p0:
-	i2c_unregister_device(ctx->i2c.rx_p0_client);
-free_tx_p2:
-	i2c_unregister_device(ctx->i2c.tx_p2_client);
-free_tx_p1:
-	i2c_unregister_device(ctx->i2c.tx_p1_client);
-free_tx_p0:
-	i2c_unregister_device(ctx->i2c.tx_p0_client);
-
-	return err;
-}
-
-static void anx7625_unregister_i2c_dummy_clients(struct anx7625_data *ctx)
-{
-	i2c_unregister_device(ctx->i2c.tx_p0_client);
-	i2c_unregister_device(ctx->i2c.tx_p1_client);
-	i2c_unregister_device(ctx->i2c.tx_p2_client);
-	i2c_unregister_device(ctx->i2c.rx_p0_client);
-	i2c_unregister_device(ctx->i2c.rx_p1_client);
-	i2c_unregister_device(ctx->i2c.rx_p2_client);
-	i2c_unregister_device(ctx->i2c.tcpc_client);
 }
 
 static int __maybe_unused anx7625_runtime_pm_suspend(struct device *dev)
@@ -2723,8 +2685,6 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	if (!platform->pdata.low_power_mode)
 		pm_runtime_put_sync_suspend(&client->dev);
 
-	anx7625_unregister_i2c_dummy_clients(platform);
-
 free_wq:
 	if (platform->workqueue)
 		destroy_workqueue(platform->workqueue);
@@ -2754,8 +2714,6 @@ static int anx7625_i2c_remove(struct i2c_client *client)
 	if (!platform->pdata.low_power_mode)
 		pm_runtime_put_sync_suspend(&client->dev);
 
-	anx7625_unregister_i2c_dummy_clients(platform);
-
 	if (platform->pdata.audio_en)
 		anx7625_unregister_audio(platform);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

