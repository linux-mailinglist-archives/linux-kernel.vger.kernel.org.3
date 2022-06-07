Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E2554237A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444830AbiFHBIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383454AbiFGVxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:53:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AC2244F42
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:11:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y196so16326889pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9v+zfN+LDZJBzv64yfNd1oezlZ5d8K5Q7FPfZj4YOs=;
        b=MqSRLcI9BH2Og5WEHOEXrEXxc6/IJDbQEKpVB/xaJSTHPdJt6e6mTgYsBo2p5JHUm3
         4qza7GyCwvpG8ZDUtQWYZxg8BOfd5cdXnHg10Bdc4zD98BIgxoSEzeYnnIBiXglepADs
         iVqV5Epkav9UXLpkGqTq9CUPDvw+gGhPbyFoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9v+zfN+LDZJBzv64yfNd1oezlZ5d8K5Q7FPfZj4YOs=;
        b=uyIptZKBgEZVylla+OE/JXQ6R1rSQ/eUD1gE9amZfXrWSqmX9mrjYbJFf81BXL2wAR
         l8Wq+MDkZIeU7gjA4QxdQscwSTzridTeYBbX5A4dex+VULULuSuuUdEAx3AP8w6yc319
         Rq/GX91GhEHhi8dqS3Q5ncgNi9f7lVEQSfgC0zuTtUqAldsDFQ0rSr0+p8FN69QlRCHa
         9kUSMCaVvw0zeun/KBucZ4b/lHrhRsJ/U0BLHcRXbuZtxO7aWx2S3OhbwrrX1pvV0Y0x
         +Qxtcikwsm4Y4u/XU3GZTOUDcrbGQt98CTylQJ3TLfvo0t3NW+xpr+pZZJ2nFjygHrqL
         fY1A==
X-Gm-Message-State: AOAM530b32ArYWXUGf1XPrzIZrmWadxvdkneI2MdTXYu7i8HLIPK0jJE
        4BP9J/zJyAB47VCKUMN0cifb8z9tV6QcEg==
X-Google-Smtp-Source: ABdhPJy42YNTwejMbajhVemlLo4iEhdSYP1Ea5z93nYnnsV1N64UMZ1hkHmT1boNizeLbkEDtlqzDg==
X-Received: by 2002:a63:fa56:0:b0:3fc:d3d2:ceac with SMTP id g22-20020a63fa56000000b003fcd3d2ceacmr26639313pgk.99.1654629103599;
        Tue, 07 Jun 2022 12:11:43 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g29-20020aa79ddd000000b0050dc762819esm13236084pfq.120.2022.06.07.12.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:11:43 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Pin-Yen Lin <treapking@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH 7/7] drm/bridge: anx7625: Add typec_mux_set callback function
Date:   Tue,  7 Jun 2022 19:00:25 +0000
Message-Id: <20220607190131.1647511-8-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607190131.1647511-1-pmalani@chromium.org>
References: <20220607190131.1647511-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pin-Yen Lin <treapking@chromium.org>

Add the callback function when the driver receives state
changes of the Type-C port. The callback function configures the
crosspoint switch of the anx7625 bridge chip, which can change the
output pins of the signals according to the port state.

Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 58 +++++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h | 13 +++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index d41a21103bd3..2c308d12fab2 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -15,6 +15,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 #include <linux/workqueue.h>
 
@@ -2582,9 +2583,66 @@ static void anx7625_runtime_disable(void *data)
 	pm_runtime_disable(data);
 }
 
+static void anx7625_set_crosspoint_switch(struct anx7625_data *ctx,
+					  enum typec_orientation orientation)
+{
+	if (orientation == TYPEC_ORIENTATION_NORMAL) {
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
+				  SW_SEL1_SSRX_RX1 | SW_SEL1_DPTX0_RX2);
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
+				  SW_SEL2_SSTX_TX1 | SW_SEL2_DPTX1_TX2);
+	} else if (orientation == TYPEC_ORIENTATION_REVERSE) {
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
+				  SW_SEL1_SSRX_RX2 | SW_SEL1_DPTX0_RX1);
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
+				  SW_SEL2_SSTX_TX2 | SW_SEL2_DPTX1_TX1);
+	}
+}
+
+static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
+{
+	if (ctx->typec_ports[0].dp_connected && ctx->typec_ports[1].dp_connected)
+		/* Both ports available, do nothing to retain the current one. */
+		return;
+	else if (ctx->typec_ports[0].dp_connected)
+		anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_NORMAL);
+	else if (ctx->typec_ports[1].dp_connected)
+		anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_REVERSE);
+}
+
 static int anx7625_typec_mux_set(struct typec_mux_dev *mux,
 				 struct typec_mux_state *state)
 {
+	struct anx7625_port_data *data = typec_mux_get_drvdata(mux);
+	struct anx7625_data *ctx = data->ctx;
+	struct device *dev = &ctx->client->dev;
+
+	bool old_dp_connected = (ctx->typec_ports[0].dp_connected ||
+				 ctx->typec_ports[1].dp_connected);
+	bool new_dp_connected;
+
+	if (ctx->num_typec_switches == 1)
+		return 0;
+
+	dev_dbg(dev, "mux_set dp_connected: c0=%d, c1=%d\n",
+		ctx->typec_ports[0].dp_connected, ctx->typec_ports[1].dp_connected);
+
+	data->dp_connected = (state->alt && state->alt->svid == USB_TYPEC_DP_SID &&
+			      state->alt->mode == USB_TYPEC_DP_MODE);
+
+	new_dp_connected = (ctx->typec_ports[0].dp_connected ||
+			    ctx->typec_ports[1].dp_connected);
+
+	/* dp on, power on first */
+	if (!old_dp_connected && new_dp_connected)
+		pm_runtime_get_sync(dev);
+
+	anx7625_typec_two_ports_update(ctx);
+
+	/* dp off, power off last */
+	if (old_dp_connected && !new_dp_connected)
+		pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 76cfc64f7574..7d6c6fdf9a3a 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -55,6 +55,18 @@
 #define HPD_STATUS_CHANGE 0x80
 #define HPD_STATUS 0x80
 
+#define TCPC_SWITCH_0 0xB4
+#define SW_SEL1_DPTX0_RX2 BIT(0)
+#define SW_SEL1_DPTX0_RX1 BIT(1)
+#define SW_SEL1_SSRX_RX2 BIT(4)
+#define SW_SEL1_SSRX_RX1 BIT(5)
+
+#define TCPC_SWITCH_1 0xB5
+#define SW_SEL2_DPTX1_TX2 BIT(0)
+#define SW_SEL2_DPTX1_TX1 BIT(1)
+#define SW_SEL2_SSTX_TX2 BIT(4)
+#define SW_SEL2_SSTX_TX1 BIT(5)
+
 /******** END of I2C Address 0x58 ********/
 
 /***************************************************************/
@@ -444,6 +456,7 @@ struct anx7625_i2c_client {
 };
 
 struct anx7625_port_data {
+	bool dp_connected;
 	struct typec_mux_dev *typec_mux;
 	struct anx7625_data *ctx;
 };
-- 
2.36.1.255.ge46751e96f-goog

