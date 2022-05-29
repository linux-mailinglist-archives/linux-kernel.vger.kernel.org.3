Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F96537214
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiE2SG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiE2SGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:06:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFCD64BDE;
        Sun, 29 May 2022 11:06:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o9so5273468wmd.0;
        Sun, 29 May 2022 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLHIukUkBNLikfr8LE6F72H0XZdEF3+8TPuvOmboOcI=;
        b=q6YRGtUng7jTkgFIREYfFdNMXaXc3P/uwUc9qSBoZKxuyCw7l9jTzi5W2AAcOvD6nn
         /T6j5Bq7P/HYp6ji4bNfI5vzhNnbfHvau154Xm+d2uxrYH9FTex5S/wAoLIcJUz18mW8
         nWjIxJpWln62W+4JDsScVJKb4oR/jvGGZnLQA5Yk6Cam0YNn/EwPcA/A04rjuvwTcwaB
         tpoSyjwvbi3hFwYbRI1HAL/AjrFFBcLfI85nltNYcPWYEHUggzfswV2ZxJF9JIO2yzx4
         UH0x5VayizSceebBExn13LXAXZWEqrzzXdfO55E5kmD+ncZeNz8LXJOJ4gqtm6yIWaBb
         1icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLHIukUkBNLikfr8LE6F72H0XZdEF3+8TPuvOmboOcI=;
        b=hwQzXpbuYqRnN9GVKf0y5urgi6aGFV1HfQ6FkKzYHzDqQYM0y93VBv3pJW4aI8n+KT
         bLanUX2GMI8IujdruOcCHuE10Lgx7Y672XIaK7BGjpbTTMkoEqCO17b2gF+G9QLmz1kW
         UPljTdmYg0kMjtzl/DCZiKUGlv7+4oc7b8f0OnMfkLD9tG66Krt/KYDlKrKYugl52Bc7
         5uc+iT4rUYYrio9ZoyRpBTIgluuY5u9+xwKHUljHiHh2NNP0F2iNusjMPU0kH8jx7j+z
         n/IYyFUnRpM32c1+wAY/rVk0QcCwqDMZnlyWaUxhqAkPvgz6jv3N00au7zyMTp8MF2XD
         Z0+A==
X-Gm-Message-State: AOAM531WCWTKYmeK3xP8HiVTJg2ccGwzYASIg/C7V3aXJGuiCKVRpyZc
        mMA+jMBwpQj9NybmYjwo5Dc=
X-Google-Smtp-Source: ABdhPJyb8iSO3fSTkbzE+IIpm38NksmGKQfy6w3HWePmJnmCZHhAX1WitMykwPHY4y48ln0tkpZdKw==
X-Received: by 2002:a05:600c:4f09:b0:397:788b:33af with SMTP id l9-20020a05600c4f0900b00397788b33afmr15812702wmq.94.1653847572455;
        Sun, 29 May 2022 11:06:12 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id q7-20020a056000136700b002100f2e6a7dsm7008516wrz.93.2022.05.29.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 11:06:12 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ruhel <clamor95@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] drm/panel: simple: Add support for HannStar HSD101PWW2 panel
Date:   Sun, 29 May 2022 21:05:48 +0300
Message-Id: <20220529180548.9942-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529180548.9942-1-clamor95@gmail.com>
References: <20220529180548.9942-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition of the HannStar HSD101PWW2 Rev0-A00/A01 LCD
SuperIPS+ HD panel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a34f4198a534..915b7cecf451 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1928,6 +1928,31 @@ static const struct panel_desc hannstar_hsd100pxn1 = {
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
@@ -3834,6 +3859,9 @@ static const struct of_device_id platform_of_match[] = {
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
2.25.1

