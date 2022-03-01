Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6D4C8F23
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiCAPch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiCAPcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:32:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E2E3A5FD;
        Tue,  1 Mar 2022 07:31:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e10so3548411wro.13;
        Tue, 01 Mar 2022 07:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDRCVh5+XHKQRRsWU/rtw+qyV3P2V1tvxwx8uNiM2Wo=;
        b=ce1Hox9vXtU7g1le6ez42Cj/ssKLMW6nGrcr/uB0iDTb/MDVJsnJXQoHSC5rHgl+5i
         DAc6sNbZi95M/TVCFOLrnrsJYQV7A3Pgr1e4BoCU43lRxRA9JYBKucunni2jemFJDbAC
         N+jxuloV8BjUpdmIL3Rw4iyb3GhENTSQIh9mIPVouXZR+d7Mx5bQCYXGfWM7ipvt3Tiu
         enSebDhjrn0dUHtO+k+H7rjT4EEUdZVH30Lk1wclkezDPaw/ba2F4K0FoqNY/b/mQ90N
         W1S3xNDRNncPhwNGkOuZWGcfUU931dJsXdUNJXXqlUoBd6QhDx2bOz7yzJFy/2jMDLN8
         6ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDRCVh5+XHKQRRsWU/rtw+qyV3P2V1tvxwx8uNiM2Wo=;
        b=CmyEG/dDTd1u9c85Ass118C4XYMRWf1Ug4Yf4pllqUUuATdXj7vIc9O+Yg2MjOf/ks
         qOw5XV1nuusYscXNBpL5sInW4p758HBmurcn4uqjlMWjkwO4RptI4j65c2pUQ1hxQf5F
         wxSaXkMU5l7LcnN0myLe82OcxxdDY5lzEhXVX+fHlU9bKa+bymVAne3AXqh2M8sgymgP
         aG2Zmg3id2GybZi5TIA9lGdpLO3b9kyT9KdZYRTeVfWhCcP89wSC/WR5kvHkMSrGZ/PK
         oYxILn33HG0e0DGR5UoGLjR+AIHA5+2MblzN6S2e6H4OI42pFh3Jn2uyFqsqDGN8OEj2
         yobQ==
X-Gm-Message-State: AOAM531E+CXHRSuuqNN6lOrJsmSFZoq/2yiRfSS7lVq7SkDkSNVZVCGE
        KnxG4fy8uy2ISGnDVmF4EF8=
X-Google-Smtp-Source: ABdhPJww8ezFvFTZCiOJGaO+xHqi7NqeGALhULxNZ2PyqqENxuTM8qcDz9xkgik4kvuIQVvmpIS17g==
X-Received: by 2002:a05:6000:1c15:b0:1f0:216:1c64 with SMTP id ba21-20020a0560001c1500b001f002161c64mr3305267wrb.366.1646148709348;
        Tue, 01 Mar 2022 07:31:49 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c4e0d00b003816cb4892csm5797377wmq.0.2022.03.01.07.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:31:48 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v1 3/3] drm/panel : innolux-ej030na and abt-y030xx067a : add .enable and .disable
Date:   Tue,  1 Mar 2022 16:31:22 +0100
Message-Id: <20220301153122.20660-4-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220301153122.20660-1-cbranchereau@gmail.com>
References: <20220301153122.20660-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the introduction of bridge_atomic_enable in the ingenic
drm driver, the crtc is enabled between .prepare and .enable, if
it exists.

Add it so the backlight is only enabled after the crtc is, to avoid
graphical issues.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c  | 23 ++++++++++++--
 drivers/gpu/drm/panel/panel-innolux-ej030na.c | 31 ++++++++++++++++---
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
index f043b484055b..b5736344e3ec 100644
--- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
+++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
@@ -183,8 +183,6 @@ static int y030xx067a_prepare(struct drm_panel *panel)
 		goto err_disable_regulator;
 	}
 
-	msleep(120);
-
 	return 0;
 
 err_disable_regulator:
@@ -202,6 +200,25 @@ static int y030xx067a_unprepare(struct drm_panel *panel)
 	return 0;
 }
 
+static int y030xx067a_enable(struct drm_panel *panel)
+{
+	if (panel->backlight) {
+		/* Wait for the picture to be ready before enabling backlight */
+		msleep(120);
+	}
+
+	return 0;
+}
+
+static int y030xx067a_disable(struct drm_panel *panel)
+{
+	struct y030xx067a *priv = to_y030xx067a(panel);
+
+	regmap_clear_bits(priv->map, 0x06, REG06_XPSAVE);
+
+	return 0;
+}
+
 static int y030xx067a_get_modes(struct drm_panel *panel,
 				struct drm_connector *connector)
 {
@@ -239,6 +256,8 @@ static int y030xx067a_get_modes(struct drm_panel *panel,
 static const struct drm_panel_funcs y030xx067a_funcs = {
 	.prepare	= y030xx067a_prepare,
 	.unprepare	= y030xx067a_unprepare,
+	.enable		= y030xx067a_enable,
+	.disable	= y030xx067a_disable,
 	.get_modes	= y030xx067a_get_modes,
 };
 
diff --git a/drivers/gpu/drm/panel/panel-innolux-ej030na.c b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
index c558de3f99be..6de7370185cd 100644
--- a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
+++ b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
@@ -80,8 +80,6 @@ static const struct reg_sequence ej030na_init_sequence[] = {
 	{ 0x47, 0x08 },
 	{ 0x48, 0x0f },
 	{ 0x49, 0x0f },
-
-	{ 0x2b, 0x01 },
 };
 
 static int ej030na_prepare(struct drm_panel *panel)
@@ -109,8 +107,6 @@ static int ej030na_prepare(struct drm_panel *panel)
 		goto err_disable_regulator;
 	}
 
-	msleep(120);
-
 	return 0;
 
 err_disable_regulator:
@@ -128,6 +124,31 @@ static int ej030na_unprepare(struct drm_panel *panel)
 	return 0;
 }
 
+static int ej030na_enable(struct drm_panel *panel)
+{
+	struct ej030na *priv = to_ej030na(panel);
+
+	/* standby off */
+	regmap_write(priv->map, 0x2b, 0x01);
+
+	if (panel->backlight) {
+		/* Wait for the picture to be ready before enabling backlight */
+		msleep(120);
+	}
+
+	return 0;
+}
+
+static int ej030na_disable(struct drm_panel *panel)
+{
+	struct ej030na *priv = to_ej030na(panel);
+
+	/* standby on */
+	regmap_write(priv->map, 0x2b, 0x00);
+
+	return 0;
+}
+
 static int ej030na_get_modes(struct drm_panel *panel,
 			     struct drm_connector *connector)
 {
@@ -165,6 +186,8 @@ static int ej030na_get_modes(struct drm_panel *panel,
 static const struct drm_panel_funcs ej030na_funcs = {
 	.prepare	= ej030na_prepare,
 	.unprepare	= ej030na_unprepare,
+	.enable		= ej030na_enable,
+	.disable	= ej030na_disable,
 	.get_modes	= ej030na_get_modes,
 };
 
-- 
2.34.1

