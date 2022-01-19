Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2DC493CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355615AbiASPR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355336AbiASPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:17:57 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48446C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:17:57 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e8so2497014plh.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Tc7nnQFnAv/x3r/yYMhvZGN3p803fSMZ3UHYukD4rU=;
        b=RI+4W/YKXDryDOyJcLD+b6qOqNtxW2ng67ZkKebLb0N9NnWQXgt4iuVKIkdfsvu1m7
         CrdkKjecym5szZkx6UP81WRtMQAE+lxk9zua+xcnWuxRXh07iMDBn/QSuo2W3ZjIJJll
         muU0ysGPe3hCkwjn/nf2x4d+gJcI80Tck+zOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Tc7nnQFnAv/x3r/yYMhvZGN3p803fSMZ3UHYukD4rU=;
        b=MUZNKoJvSjbtUtuAG+pUTyoNTu6IjaBJLXmKMgo7rN3xwub+2Cfmu+UvFIGW+W9h6b
         wMvxtLeepiemxbu98h6f0/Qt6VCFb/edePrVVH62yDUHbWmxvcqtrdqh+olMQVJXDRxx
         jP2YlPVlOaZTW3vFSuuSf/tFUcCMEEEaVYgWSaqjBkbKuTbzI6zRUA6IemT5jspdjJ3Z
         sU6uBTvVWZB4mzIfXGWMqT1nOj6+xjCC0BOF6qGDFJH1aciZ0lKUetKaUtshZKbHcJ5p
         t1zzrTDHlsXJfI4l7c7RC5ppPXKyMIQA5TH6OEjWIZmQq2WXKHT0kHHYFrG+PeiNgLZJ
         t2iw==
X-Gm-Message-State: AOAM532o3TRHMYqnd03gnE+7dmAJeMojpXPfh6VY4BG/OT4zOoKPVept
        dCxy927yrA+9STpFLbLP9cwSZA==
X-Google-Smtp-Source: ABdhPJzXbx2jwpii7zYjlTlogLTziYjpPQfkpQBSImL6a9fsiG8UTMq3BznOyeDF4GJ+8xR5veOHzw==
X-Received: by 2002:a17:902:8693:b0:148:a2e7:fb5a with SMTP id g19-20020a170902869300b00148a2e7fb5amr32680524plo.155.1642605476443;
        Wed, 19 Jan 2022 07:17:56 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ab3b:7ccf:392:3f04])
        by smtp.gmail.com with ESMTPSA id ip14sm6731596pjb.11.2022.01.19.07.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:17:55 -0800 (PST)
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
Subject: [PATCH v5 1/4] drm/bridge: anx7625: send DPCD command to downstream
Date:   Wed, 19 Jan 2022 23:17:48 +0800
Message-Id: <20220119151751.986185-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Ji <xji@analogixsemi.com>

Send DPCD command to downstream before anx7625 power down,
let downstream monitor enter into standby mode.

Signed-off-by: Xin Ji <xji@analogixsemi.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v3->v4:
Use common DP_AUX_NATIVE_READ/WRITE

Previously in:
https://patchwork.kernel.org/project/dri-devel/patch/1f36f8bf0a48fb2bba17bacec23700e58c1d407d.1641891874.git.xji@analogixsemi.com/
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 42 +++++++++++++++++++----
 drivers/gpu/drm/bridge/analogix/anx7625.h |  2 --
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 76662fce4ce61d..17b23940549a42 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -129,6 +129,23 @@ static int anx7625_reg_write(struct anx7625_data *ctx,
 	return ret;
 }
 
+static int anx7625_reg_block_write(struct anx7625_data *ctx,
+				   struct i2c_client *client,
+				   u8 reg_addr, u8 len, u8 *buf)
+{
+	int ret;
+	struct device *dev = &client->dev;
+
+	i2c_access_workaround(ctx, client);
+
+	ret = i2c_smbus_write_i2c_block_data(client, reg_addr, len, buf);
+	if (ret < 0)
+		dev_err(dev, "write i2c block failed id=%x\n:%x",
+			client->addr, reg_addr);
+
+	return ret;
+}
+
 static int anx7625_write_or(struct anx7625_data *ctx,
 			    struct i2c_client *client,
 			    u8 offset, u8 mask)
@@ -214,8 +231,8 @@ static int wait_aux_op_finish(struct anx7625_data *ctx)
 	return 0;
 }
 
-static int anx7625_aux_dpcd_read(struct anx7625_data *ctx,
-				 u32 address, u8 len, u8 *buf)
+static int anx7625_aux_dpcd_trans(struct anx7625_data *ctx, u8 op,
+				  u32 address, u8 len, u8 *buf)
 {
 	struct device *dev = &ctx->client->dev;
 	int ret;
@@ -231,8 +248,7 @@ static int anx7625_aux_dpcd_read(struct anx7625_data *ctx,
 	addrm = (address >> 8) & 0xFF;
 	addrh = (address >> 16) & 0xFF;
 
-	cmd = DPCD_CMD(len, DPCD_READ);
-	cmd = ((len - 1) << 4) | 0x09;
+	cmd = DPCD_CMD(len, op);
 
 	/* Set command and length */
 	ret = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
@@ -246,6 +262,9 @@ static int anx7625_aux_dpcd_read(struct anx7625_data *ctx,
 	ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
 				 AP_AUX_ADDR_19_16, addrh);
 
+	if (op == DP_AUX_NATIVE_WRITE)
+		ret |= anx7625_reg_block_write(ctx, ctx->i2c.rx_p0_client,
+					       AP_AUX_BUFF_START, len, buf);
 	/* Enable aux access */
 	ret |= anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
 				AP_AUX_CTRL_STATUS, AP_AUX_CTRL_OP_EN);
@@ -255,14 +274,17 @@ static int anx7625_aux_dpcd_read(struct anx7625_data *ctx,
 		return -EIO;
 	}
 
-	usleep_range(2000, 2100);
-
 	ret = wait_aux_op_finish(ctx);
 	if (ret) {
 		dev_err(dev, "aux IO error: wait aux op finish.\n");
 		return ret;
 	}
 
+	/* Write done */
+	if (op == DP_AUX_NATIVE_WRITE)
+		return 0;
+
+	/* Read done, read out dpcd data */
 	ret = anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
 				     AP_AUX_BUFF_START, len, buf);
 	if (ret < 0) {
@@ -845,7 +867,7 @@ static int anx7625_hdcp_enable(struct anx7625_data *ctx)
 	}
 
 	/* Read downstream capability */
-	anx7625_aux_dpcd_read(ctx, 0x68028, 1, &bcap);
+	anx7625_aux_dpcd_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
 	if (!(bcap & 0x01)) {
 		pr_warn("downstream not support HDCP 1.4, cap(%x).\n", bcap);
 		return 0;
@@ -918,6 +940,7 @@ static void anx7625_dp_stop(struct anx7625_data *ctx)
 {
 	struct device *dev = &ctx->client->dev;
 	int ret;
+	u8 data;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "stop dp output\n");
 
@@ -929,6 +952,11 @@ static void anx7625_dp_stop(struct anx7625_data *ctx)
 	ret |= anx7625_write_and(ctx, ctx->i2c.tx_p2_client, 0x08, 0x7f);
 
 	ret |= anx7625_video_mute_control(ctx, 1);
+
+	dev_dbg(dev, "notify downstream enter into standby\n");
+	/* Downstream monitor enter into standby mode */
+	data = 2;
+	ret |= anx7625_aux_dpcd_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
 	if (ret < 0)
 		DRM_DEV_ERROR(dev, "IO error : mute video fail\n");
 
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 56165f5b254c14..64a8ab56529404 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -242,8 +242,6 @@
 
 #define AP_AUX_COMMAND	0x27  /* com+len */
 #define LENGTH_SHIFT	4
-#define DPCD_READ	0x09
-#define DPCD_WRITE	0x08
 #define DPCD_CMD(len, cmd)	((((len) - 1) << LENGTH_SHIFT) | (cmd))
 
 /* Bit 0&1: 3D video structure */
-- 
2.34.1.703.g22d0c6ccf7-goog

