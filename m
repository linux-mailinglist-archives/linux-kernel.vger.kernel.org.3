Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2FD4A3C07
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347815AbiAaAAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245559AbiAaAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:00:04 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DA5C061714;
        Sun, 30 Jan 2022 16:00:04 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a28so23342377lfl.7;
        Sun, 30 Jan 2022 16:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLMbzDUhFlSgdQoGKuc6SBBSjoGSeYRwJlFPN5QbfOY=;
        b=RK73TNDnpRXvhBX8A5kt8T9bMKrFqOWo89YfW3gK2p/ab1wByjnGog7fEXd3UVT+C3
         rHoNnE2KHQTRVgXgEbxLf8rq2dfS7RN2uauA94bDVKW9t7hI2Itkv6D/Uq9pEptbrU4B
         MvyYxY9eImtQTwr9x1xgphwI65LXw+PgF4X53+7EbnHJ6VlxsKylOfKocaC1+hwE8j+Y
         g8DqFpkq2bE3Fa6cxe4EJMV5QFxB9EbJQREG6E6dm9HB8VwRdFbjW8VZEaPRMYWxh0Fi
         xS0fx3jW1XZkk9AdVDpBkuIL04m469ZyC/8J5X48ZOiIy9CvayEu9GPYKAk+UziJs7Sz
         EAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLMbzDUhFlSgdQoGKuc6SBBSjoGSeYRwJlFPN5QbfOY=;
        b=thpKcpWyhgXMSg+5kKL5nRUwZQ87iPz9cl8n5ttetspjfZH0OdJ2mFllM2pR/8utm2
         6bMaQvo7KJTN5H2SYMnYEZLsYQfErx65ggenwwsw2/2sepwOmRulprLCgQH5pepM/1NL
         DB7LLLeEUs28wGsH/l02kvMa97IG8VXWyDYoUaU3hqumQp4ea5BIB+GYctD5lnwc/hsl
         RgEUgdwxxmi8atRwnnM5g+dfcfRwYjK5uMXSp9JPuxaJkPxG/PUO5nGGVyTslIL624mL
         D6AyJKtN1B2Rdbn4HU4op2vzEP/c3G8g5gZ8vvdN6SOoA0psxyfHigmpn5ucmI1llSG3
         fhHw==
X-Gm-Message-State: AOAM531p9vl/1V5madiUdhP58V+eyjcGr8MN8gCwUlgEnfK+Q5nM9DqO
        ZS94iSZB6xfmI7TIwovshAY=
X-Google-Smtp-Source: ABdhPJzQA1KKnOEKivxU5yFBm8z9Pa+/47HYUYIyiKAkcrhL57RR7avlrclppEY2U8tedf0Iy3kCEg==
X-Received: by 2002:a05:6512:1587:: with SMTP id bp7mr13852830lfb.671.1643587202164;
        Sun, 30 Jan 2022 16:00:02 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id e7sm3443193lfb.17.2022.01.30.16.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 16:00:01 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] drm/panel: simple: Add support for HannStar HSD101PWW2 panel
Date:   Mon, 31 Jan 2022 02:59:45 +0300
Message-Id: <20220130235945.22746-4-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130235945.22746-1-digetx@gmail.com>
References: <20220130235945.22746-1-digetx@gmail.com>
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
index 9e46db5e359c..1bfa2d1b61fd 100644
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
@@ -3802,6 +3827,9 @@ static const struct of_device_id platform_of_match[] = {
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
2.34.1

