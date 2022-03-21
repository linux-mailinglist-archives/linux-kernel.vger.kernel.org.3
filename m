Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9104E27CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347978AbiCUNi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347860AbiCUNir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:38:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF53C11F78E;
        Mon, 21 Mar 2022 06:37:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h4so2766924wrc.13;
        Mon, 21 Mar 2022 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C7ur1ssTUbHNpecbbbCU94tMoZ1fCbXzPQjfgyWqqxg=;
        b=T070mISsGNQa6RHk1dvm7QAfEGtCL8QdJrl2jjSnGDB6cwq2T9wm74b4gFuuuJlMKT
         2nTxKTsyhsMZ0uvuXyO559/Aq3xhzUs99+G0yudWaQ5o0OyMWNSef1QKfPkUrLfTEah5
         3JdeOMHFOhs9VAxy7jhmLl68/uKjUa/lOkQ2H6c373zvP+94m9x61dLxPj3jyWYE67HV
         S3xp7ejlINrtQxXGa6PJS9joqNSBQRIadcOUcKu+CvxWe/QnvrYG1LQ3FDtSmGrQmmS8
         CBmCy6nrfzqAwRDiRRvD9vz0aorR2mINGePL0dEp2hicWhfcotQ4SKy3kBgcaHiubTKM
         kABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C7ur1ssTUbHNpecbbbCU94tMoZ1fCbXzPQjfgyWqqxg=;
        b=phN75rF3k5IuHIiWhjUMBW9ovpp/oOR9tAFrIWc5Uf6LOWU0T4JROD7JoBezeiuow8
         8Xn2C9db/OPP14a+xQDwGy/2wts+EUjD1cXEd5afK8DlASDW7cje62UuzQhkBpMRdrmy
         9YqbqTRSFhGDwEa9gHRu4zPsWGQampbPcsDysiic+tqlvmd7KZnjBA1tQ2mtLWP3ozzo
         siSKSgxW9VHlSCF3QWcnHOYbXTetGRrq8Oa/MSL/LSiIuMsXrgD4YEb2JkYpkiXN4bhb
         +DsNh6PvjX6lostOt72pOxUvH/Ay9AljaQ6a2O5jaH15Z8SSc+njrTgKt1HZarFxy1hu
         5mdg==
X-Gm-Message-State: AOAM530fF1VtppX1Zh58vVcL06HlpCsFeD+T7+fGEbxMfGzs34BDnDp9
        kZ/zPM427C95vJ5zhGaG99c8Yat1mPtYBA==
X-Google-Smtp-Source: ABdhPJwWZt9Ny/5MMoWri+0K296W3KYZx1PnQurYTeD4TmtqWAgVUE/0FAd2tN/N/WuCLsgov0xN5A==
X-Received: by 2002:a5d:4804:0:b0:203:d59b:e83 with SMTP id l4-20020a5d4804000000b00203d59b0e83mr18685188wrq.696.1647869840048;
        Mon, 21 Mar 2022 06:37:20 -0700 (PDT)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b00203f8c96bcesm7969426wrv.49.2022.03.21.06.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:37:19 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v5 3/3] drm/panel : innolux-ej030na and abt-y030xx067a : add .enable and .disable
Date:   Mon, 21 Mar 2022 14:36:51 +0100
Message-Id: <20220321133651.291592-4-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321133651.291592-1-cbranchereau@gmail.com>
References: <20220321133651.291592-1-cbranchereau@gmail.com>
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
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c  | 31 +++++++++++++++++--
 drivers/gpu/drm/panel/panel-innolux-ej030na.c | 31 ++++++++++++++++---
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
index f043b484055b..ddfacaeac1d4 100644
--- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
+++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
@@ -140,7 +140,7 @@ static const struct reg_sequence y030xx067a_init_sequence[] = {
 	{ 0x03, REG03_VPOSITION(0x0a) },
 	{ 0x04, REG04_HPOSITION1(0xd2) },
 	{ 0x05, REG05_CLIP | REG05_NVM_VREFRESH | REG05_SLBRCHARGE(0x2) },
-	{ 0x06, REG06_XPSAVE | REG06_NT },
+	{ 0x06, REG06_NT },
 	{ 0x07, 0 },
 	{ 0x08, REG08_PANEL(0x1) | REG08_CLOCK_DIV(0x2) },
 	{ 0x09, REG09_SUB_BRIGHT_R(0x20) },
@@ -183,8 +183,6 @@ static int y030xx067a_prepare(struct drm_panel *panel)
 		goto err_disable_regulator;
 	}
 
-	msleep(120);
-
 	return 0;
 
 err_disable_regulator:
@@ -202,6 +200,30 @@ static int y030xx067a_unprepare(struct drm_panel *panel)
 	return 0;
 }
 
+static int y030xx067a_enable(struct drm_panel *panel)
+{
+
+	struct y030xx067a *priv = to_y030xx067a(panel);
+
+	regmap_set_bits(priv->map, 0x06, REG06_XPSAVE);
+
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
@@ -239,6 +261,8 @@ static int y030xx067a_get_modes(struct drm_panel *panel,
 static const struct drm_panel_funcs y030xx067a_funcs = {
 	.prepare	= y030xx067a_prepare,
 	.unprepare	= y030xx067a_unprepare,
+	.enable		= y030xx067a_enable,
+	.disable	= y030xx067a_disable,
 	.get_modes	= y030xx067a_get_modes,
 };
 
@@ -246,6 +270,7 @@ static const struct regmap_config y030xx067a_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0x15,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int y030xx067a_probe(struct spi_device *spi)
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
2.35.1

