Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A904716D3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhLKViN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhLKViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:38:09 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63DDC061751;
        Sat, 11 Dec 2021 13:38:08 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b19so16718376ljr.12;
        Sat, 11 Dec 2021 13:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5cqVCk6ynWp5U/3Ep3k4Mo6eL6tir3HlEgYMajRnK4=;
        b=OtOehzc58gi64fYKYGJoUhU9yfbyw5erXeRGj9xZ//qaRQtR/innknOTIwss8QsRxX
         uGrRsJb1d2E1wcxH24VILEMMrLn1C7j8APXpVN46pIqXdDi2mV9JNYr8kvFW5gclVsnp
         gB7fo6UO6vmMJLx+RSgX2mlXCjUtYTsC6052zSOKM6SoQLtgE2TKjEI2+f57zJbU5DB2
         nGPFYks1dvbnGj2fOGSBnIVTrY9ReXqb1ibf4JQuUBIsFJ83exRIGGkAclUCfctQlk2C
         bazsgZ0gsuj3/VWLwhZFT/JlQJKDdfjmO1KjsoZTOZMNuvxsYDUhfvoQSVBJPmJsFCKW
         6G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5cqVCk6ynWp5U/3Ep3k4Mo6eL6tir3HlEgYMajRnK4=;
        b=pdcs83GMWl/gJonYvsy8lDlYbfMZlzlbmGenBpApz5H8YLJy31xQDKn/2hTiEkDfS4
         kNxsSpnlxBm+zGsscrpUpEKj3kuabVjZCJ9Fx7Bh58YCTfuI2Wg4BT/tS60iFL35f/GO
         /YZXLhurmCc59In1rHZsn5Xoc+9EyQH/QxYzIS8Dwa79aX/UehH5Br2AkvAIiX7RwB+7
         yaNkWs7d7fgBcyQaTeRxQ0T2PR8diMr2+xvHAOVMcLXqkncLT4f52NxZnl7wgey/m8Q5
         GT4KA5ZI8BvpYt26d1a9NKeYoLagZ31hYqGGLr4L5J1xCTtascoEuIhX9j1lnPi2dbOS
         0UaQ==
X-Gm-Message-State: AOAM530ngBQkVmHgp9WF/GaOu/YLZm9rGV92ME0+Nnar8ZvHA3Z+sI9x
        58GMorUOK075l32f1zAw/EE=
X-Google-Smtp-Source: ABdhPJxK+AF0es5MIQf67gn1WgcvNfNMLLw8QZninH5UxBgKlGqTHB3Q6eB1OovkgWAQD7IxOF9O5w==
X-Received: by 2002:a2e:2242:: with SMTP id i63mr20232363lji.448.1639258687039;
        Sat, 11 Dec 2021 13:38:07 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id w14sm786844ljj.7.2021.12.11.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:38:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/panel: simple: Add support for HannStar HSD101PWW2 panel
Date:   Sun, 12 Dec 2021 00:36:53 +0300
Message-Id: <20211211213653.17700-4-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211213653.17700-1-digetx@gmail.com>
References: <20211211213653.17700-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Svyatoslav Ryhel <clamor95@gmail.com>

Add definition of the HannStar HSD101PWW2 Rev0-A00/A01 LCD
SuperIPS+ HD panel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index dde033066f3d..f86378ff32a5 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1927,6 +1927,31 @@ static const struct panel_desc hannstar_hsd100pxn1 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing hannstar_hsd101pww2_timing = {
+	.pixelclock = { 64300000, 71100000, 82000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 1, 1, 10 },
+	.hback_porch = { 1, 1, 10 },
+	.hsync_len = { 58, 158, 661 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 1, 1, 10 },
+	.vback_porch = { 1, 1, 10 },
+	.vsync_len = { 1, 21, 203 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc hannstar_hsd101pww2 = {
+	.timings = &hannstar_hsd101pww2_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode hitachi_tx23d38vm0caa_mode = {
 	.clock = 33333,
 	.hdisplay = 800,
@@ -3775,6 +3800,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "hannstar,hsd100pxn1",
 		.data = &hannstar_hsd100pxn1,
+	}, {
+		.compatible = "hannstar,hsd101pww2",
+		.data = &hannstar_hsd101pww2,
 	}, {
 		.compatible = "hit,tx23d38vm0caa",
 		.data = &hitachi_tx23d38vm0caa
-- 
2.33.1

