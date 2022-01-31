Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638054A4DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbiAaSNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbiAaSMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:12:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B347C06173D;
        Mon, 31 Jan 2022 10:12:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b9so28574041lfq.6;
        Mon, 31 Jan 2022 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLMbzDUhFlSgdQoGKuc6SBBSjoGSeYRwJlFPN5QbfOY=;
        b=ANUFXXwX2YcLIAHhlsl8gAwz4wWPRA0Xx6q0Cv81zIz5wxJM4NrZe/HyWIbPQjJzXb
         /Ae30/sQTePYIB1p0u2pi3tKoqYV6Dna792X5FrDgwvqpE9819OyUyh/yWihNn437W6n
         kjCAVMA9nf+RdayheNYrtzvlYt2UMHthAt5A1vrvjYZXo4RGA3C+EvmA1VOPklpCo0kp
         6BJR3VL+I+S31HtHQ1LbV8yWxRw4mChptQnljGTR8prEEnKG/lR430wqhE5bKanqwMLI
         5fSXMiWU4bt9r5g40pgWoI9dxPTJXlcvNVD83cMZ+oIsjCS46iGnU6I6qBbcZiOlQqH2
         7XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLMbzDUhFlSgdQoGKuc6SBBSjoGSeYRwJlFPN5QbfOY=;
        b=j22m5TKnFJCHUsNzAYioDAHuNphmdJ1ZIvxl2rOj1G1RHG7q9IP9WnSUd4/Tut0drj
         yaBcxvefwOXAhSiUGgbFDb108GwSdrKxMoSihLeUtMmzhLgmTdZSQmP5OGzh2OyZ7yyA
         sHe8ifyvKnEqUnwOsC53WqYhGYnCjM8uxkFWEQaPilVkJoJ7jjO3VM22hS/2a4SxUKuX
         U9odtO6248cMpUf0CWcpw7LEe7aEyoEbK86vxaUrmYo/vjZeKSW8eHI9zp/2gwdGNAtS
         dbiUi1MBbZFN326qfCHx89AiCSvunJaI61tpzbFEVXjpCri0DrnxvZ4VVMDWr0ma1mrB
         AaWA==
X-Gm-Message-State: AOAM531sClG3exyIw5Z0efatjvz5SLALZmcxZHHfOGOxLNncdYh93kSc
        imltwSjynQAj5MQpQ5OlJoA=
X-Google-Smtp-Source: ABdhPJymMyjm5MduvH4M1VM7ckT6HH+iAiDsfRx9j23P6J5bCMxDdCIzNtS/+4EYF/aS/385tkmtcg==
X-Received: by 2002:a19:5219:: with SMTP id m25mr17005211lfb.502.1643652753919;
        Mon, 31 Jan 2022 10:12:33 -0800 (PST)
Received: from localhost.localdomain (109-252-138-136.dynamic.spd-mgts.ru. [109.252.138.136])
        by smtp.gmail.com with ESMTPSA id r17sm3391297lfg.237.2022.01.31.10.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:12:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] drm/panel: simple: Add support for HannStar HSD101PWW2 panel
Date:   Mon, 31 Jan 2022 21:12:08 +0300
Message-Id: <20220131181208.27101-4-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131181208.27101-1-digetx@gmail.com>
References: <20220131181208.27101-1-digetx@gmail.com>
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

