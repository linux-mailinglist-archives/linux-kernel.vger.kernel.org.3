Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F7A487207
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbiAGFNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiAGFNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:13:40 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C8C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 21:13:40 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id w27so4911638qkj.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 21:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4YlYdRUHGlLiiQ3VXQXTVfg4lQw9QYkhPvgea7FlC8=;
        b=N/y/y/EHxEci4XvpnpvpI6v8Xu2DGOUHAei2/EsJq+rFxmhm60oqo5oZeLoPfYgnPv
         /BPU20Kl5Odd+NQx6h/B17Zx0XHtdNmCI8A7NWBRs00VKy56dSneh94BAZSeN0N5xwqY
         ok2vaDOxPi8ynmIFNdp2YgzcxxkmhUBjchE/pzxa6HZKTUAnz2v+QVTF7eBkrObpPcS8
         T4Gi2WsW2z4eN+Q2MqM2xn1LJzBcq3Gq2o8mJEtyZvMe8U+Ku7fwjx7NcVHdSoE15TYr
         JSte3P1IY4nMkLRTdfhDsQDLblkZ7zC2QUC8SHQz4+iIkAaCtp1ArZGq67gobwVRhPI8
         mbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4YlYdRUHGlLiiQ3VXQXTVfg4lQw9QYkhPvgea7FlC8=;
        b=G8mrLiKu6p5f+M/ORcbafI7AQdho4E16HrIvjgr1UplIMIwSjHZE6RBmmG0nZcjpNg
         fTZTj3Fyjs0Rfy4QaCTD64RxIq/oGe6YfQuH2yky+nF/LNCzoP92+aQMc3qXY1C5MPiW
         ILlFn1RR/1jU3DZyuxUPEmZW5orFzph5CdOzth+QnOkCGt14iXlAT/gxguMOS464l9gy
         sfrSNfvtjtnurNpwt1dl7L1gNqSuG8OcFMCTtGOHn6CrJYQUSVG9akDN64wMBhuN6wxf
         JYxj6Q+tnpL1a/VZ33Qk9pjTkQdADy7isLoEsbY5csBXfdJo/b/7Pp3KMzq1of+PjxJA
         MvwA==
X-Gm-Message-State: AOAM531Z3hpIWaIq9ymGeB7AnId7ZDP7qy6wbCR+ZJGO9Q7l+AgPbebb
        mScv2Gm2R7hTG9QtnbjO3m0=
X-Google-Smtp-Source: ABdhPJyvrG0dAS+i8966pG6Ryu2TFjEn2HRKyJzBrPj+Kb8AR4vH67Yu5haOKp5YOL38YMqTO+Jp2Q==
X-Received: by 2002:a05:620a:284d:: with SMTP id h13mr43231424qkp.330.1641532419604;
        Thu, 06 Jan 2022 21:13:39 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id d15sm1651461qka.3.2022.01.06.21.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:13:39 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Peter Geis <pgwipeout@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/panel: feiyang-fy07024di26a30d: make reset gpio optional
Date:   Fri,  7 Jan 2022 00:13:33 -0500
Message-Id: <20220107051335.3812535-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107051335.3812535-1-pgwipeout@gmail.com>
References: <20220107051335.3812535-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some implementations do not use the reset signal, instead tying it to dvdd.
Make the reset gpio optional to permit this.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index 581661b506f8..1c88d752b14e 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -65,7 +65,8 @@ static int feiyang_prepare(struct drm_panel *panel)
 	/* T3 (dvdd rise + avdd start + avdd rise) T3 >= 20ms */
 	msleep(20);
 
-	gpiod_set_value(ctx->reset, 0);
+	if (ctx->reset)
+		gpiod_set_value(ctx->reset, 0);
 
 	/*
 	 * T5 + T6 (avdd rise + video & logic signal rise)
@@ -73,7 +74,8 @@ static int feiyang_prepare(struct drm_panel *panel)
 	 */
 	msleep(20);
 
-	gpiod_set_value(ctx->reset, 1);
+	if (ctx->reset)
+		gpiod_set_value(ctx->reset, 1);
 
 	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
 	msleep(200);
@@ -126,7 +128,8 @@ static int feiyang_unprepare(struct drm_panel *panel)
 	/* T13 (backlight fall + video & logic signal fall) T13 >= 200ms */
 	msleep(200);
 
-	gpiod_set_value(ctx->reset, 0);
+	if (ctx->reset)
+		gpiod_set_value(ctx->reset, 0);
 
 	regulator_disable(ctx->avdd);
 
@@ -211,7 +214,7 @@ static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
 		return PTR_ERR(ctx->avdd);
 	}
 
-	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset)) {
 		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
 		return PTR_ERR(ctx->reset);
-- 
2.32.0

