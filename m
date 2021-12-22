Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8488847CE58
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbhLVIeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhLVId7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:33:59 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13EFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:33:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y7so1394002plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=uFcfCCmLqz8Ms/S5ZFwbRJf6FXCon9mx/P6+leniJPQ=;
        b=B/nkD+RxzYrTMpj8qHYjiPlo4H+XGTRQ2FJOCbXw5tBLjZf3eIPKBeZUbEp3wqrXTf
         qA4O6ILyyipfaMzln1Ql1RyjNzMnDY0Q9NZMWjl2zBYK/gc4Uw7oTYZ9f50LTZcyJZbx
         fKL6LsmOTpsuuB4P83hgzOyupp8G6k83XMs2XGQ2eQXO+DfKs8rL4UcchCoFIhy/uWx0
         ltKMut+O+kStkILq+1dQtYVGrfHKqXANNoXaQt0meh9cbw1UxtnrxY3fpNULqIjbRF0H
         TZbU4IgdlykCUCqXNPIDUIw7LCk/4mzZAemU6RxsDRd3f4JlWVecsVRn7agQZOtO21ZL
         MGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uFcfCCmLqz8Ms/S5ZFwbRJf6FXCon9mx/P6+leniJPQ=;
        b=H3JzFx6baAPWvL0b2+lEnZCyuaRYB/89yuB+RLuhUELvTtkBZDl+shaFfjUP1VtXcH
         kGEyIzns2hAMlf587faWj+4qLaNUUBxSxMozllOXR2uUrjRuPVK00ady0mPWYnOAIcFj
         3kZL1sSqyTktAF7hbVU4D6BCqcydzWXEHIyXBpT5+LJ4IQ0TIkQBeHdUVYfOsoNBdfzK
         BwsTA/QcRWATS3Tm6WRWha11qSJZYDHB6zvKlAOclDDVRY+lHEhDFqmvuNC2Z2Fvy/l8
         jdjxuV9RtIPvuRBggi7MSbmU5gOx2VBjsdoSNfq72ebYjmm+M8nbHh/T62Hj8Kd4NaBx
         d6xw==
X-Gm-Message-State: AOAM533L/4Rc/SrigMuWyMzHEf0lJ6mWrxjv9BdKyIrdHxpY5+7eM/8x
        fFs+YFE/TBiue+vL8/EJ++Q=
X-Google-Smtp-Source: ABdhPJz4Gg5MNWXZ2x4Pdz7qJw2MGvY6mrzL2Qo8Pu1nl2B4Y+FUIpjLupqql4K7XOj4av6NIV3TLg==
X-Received: by 2002:a17:90a:f405:: with SMTP id ch5mr189965pjb.32.1640162038482;
        Wed, 22 Dec 2021 00:33:58 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id w76sm1518693pff.21.2021.12.22.00.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:33:58 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, Sam Ravnborg <sam@ravnborg.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Fix null vs IS_ERR() checking in anx7625_register_i2c_dummy_clients
Date:   Wed, 22 Dec 2021 08:33:48 +0000
Message-Id: <20211222083350.18514-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since i2c_new_client_device() function return error pointers.
The i2c_new_dummy_device() function does not return NULL, It returns error
pointers too. Using IS_ERR() to check the return value to fix this.

Fixes: 8bdfc5dae4e3("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 32 ++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 1a871f6b6822..eb72aa6aedd6 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1637,40 +1637,54 @@ static const struct drm_bridge_funcs anx7625_bridge_funcs = {
 static int anx7625_register_i2c_dummy_clients(struct anx7625_data *ctx,
 					      struct i2c_client *client)
 {
+	int err = 0;
+
 	ctx->i2c.tx_p0_client = i2c_new_dummy_device(client->adapter,
 						     TX_P0_ADDR >> 1);
-	if (!ctx->i2c.tx_p0_client)
-		return -ENOMEM;
+	if (IS_ERR(ctx->i2c.tx_p0_client))
+		return PTR_ERR(ctx->i2c.tx_p0_client);
 
 	ctx->i2c.tx_p1_client = i2c_new_dummy_device(client->adapter,
 						     TX_P1_ADDR >> 1);
-	if (!ctx->i2c.tx_p1_client)
+	if (IS_ERR(ctx->i2c.tx_p1_client)) {
+		err = PTR_ERR(ctx->i2c.tx_p1_client);
 		goto free_tx_p0;
+	}
 
 	ctx->i2c.tx_p2_client = i2c_new_dummy_device(client->adapter,
 						     TX_P2_ADDR >> 1);
-	if (!ctx->i2c.tx_p2_client)
+	if (IS_ERR(ctx->i2c.tx_p2_client)) {
+		err = PTR_ERR(ctx->i2c.tx_p2_client);
 		goto free_tx_p1;
+	}
 
 	ctx->i2c.rx_p0_client = i2c_new_dummy_device(client->adapter,
 						     RX_P0_ADDR >> 1);
-	if (!ctx->i2c.rx_p0_client)
+	if (IS_ERR(ctx->i2c.rx_p0_client)) {
+		err = PTR_ERR(ctx->i2c.rx_p0_client);
 		goto free_tx_p2;
+	}
 
 	ctx->i2c.rx_p1_client = i2c_new_dummy_device(client->adapter,
 						     RX_P1_ADDR >> 1);
-	if (!ctx->i2c.rx_p1_client)
+	if (IS_ERR(ctx->i2c.rx_p1_client)) {
+		err = PTR_ERR(ctx->i2c.rx_p1_client);
 		goto free_rx_p0;
+	}
 
 	ctx->i2c.rx_p2_client = i2c_new_dummy_device(client->adapter,
 						     RX_P2_ADDR >> 1);
-	if (!ctx->i2c.rx_p2_client)
+	if (IS_ERR(ctx->i2c.rx_p2_client)) {
+		err = PTR_ERR(ctx->i2c.rx_p2_client);
 		goto free_rx_p1;
+	}
 
 	ctx->i2c.tcpc_client = i2c_new_dummy_device(client->adapter,
 						    TCPC_INTERFACE_ADDR >> 1);
-	if (!ctx->i2c.tcpc_client)
+	if (IS_ERR(ctx->i2c.tcpc_client)) {
+		err = PTR_ERR(ctx->i2c.tcpc_client);
 		goto free_rx_p2;
+	}
 
 	return 0;
 
@@ -1687,7 +1701,7 @@ static int anx7625_register_i2c_dummy_clients(struct anx7625_data *ctx,
 free_tx_p0:
 	i2c_unregister_device(ctx->i2c.tx_p0_client);
 
-	return -ENOMEM;
+	return err;
 }
 
 static void anx7625_unregister_i2c_dummy_clients(struct anx7625_data *ctx)
-- 
2.17.1

