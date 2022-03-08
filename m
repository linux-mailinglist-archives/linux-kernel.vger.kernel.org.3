Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D764D18B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbiCHNIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiCHNHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:07:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B857948316;
        Tue,  8 Mar 2022 05:06:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x15so28425981wru.13;
        Tue, 08 Mar 2022 05:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kABsl8nFckhHhGe72PdD4LYbj+x9bM4gFy/8W5Qq+ys=;
        b=CeNbbGSqvyasiw3aKrSWBu+ByZiMzoj0xOyu80rURPjmzSMameTQ41nAx19Gr6BGiR
         rvKB/ErAp7bOr0L8qDoNIYLdOEAUvQYU12U8QGY6McoiVecBP+DzZa+EojmmHKqfFfaF
         d570wz2HMUlTB6yeNWfcoM1b3TwXxa5eEphl++JfoJN7aUPEW3OIeG0yJmV/w+gSBthD
         msrX+vxehJVzaksBhyXTJcNdefwZzeGDEmoyRcJtaNiXOajJpX7bZKpn/+OMF6rPTOpD
         28Dj0H0G9MuiLhBVAylZLydjWTQ941HvZ9fNALjvr7IbBKx3Jz/pkIxYmaNVXRtncmSi
         onoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kABsl8nFckhHhGe72PdD4LYbj+x9bM4gFy/8W5Qq+ys=;
        b=iAypBLL3QnbcxJMKBaeZ5FwaTy7NYf/N2ih/G0ohOvZFf/jXqwxJAX/awYYiSHHqnV
         DeIbfJGjuRaEWZnmtHMFNLumsNv2zA/lK5ADlWMGu6OV1g0H84dwrSJHib6ExiqeLyoH
         9uj9eZXHmSLhSoQbQQklUxpazytfmoaFO0FOh1ZxLboIfrnsQTQIHRSYPeie2BklQuKT
         +Q4JFI0I/wvGRFcs84ZDi9XTPl94+8QrhyEVcD6C2o/gmdZg2bS2hwCUSp4F+SLQpn7G
         cpIF/OnqM+dfHAeNanKJRqB73PdTsbDnlSxaNwCY2yuAs1NrOi4wsKckPC7IUN1OotW0
         usAg==
X-Gm-Message-State: AOAM532QIGmiSyxZQ62zlJo/fnq0ZUaSmG0D43WXjXL3QdFIO/9eO72r
        80tAVWXYU5EqqUcNIi22dBg=
X-Google-Smtp-Source: ABdhPJyQTsNDK4VxbuzBVRU4ohQD6eHLp6t1D2aSuYrQhwZeUjA0ogkAH1NuopdvNJL7wd5OE6WbLw==
X-Received: by 2002:a5d:5850:0:b0:1f0:2d5b:dc35 with SMTP id i16-20020a5d5850000000b001f02d5bdc35mr12095290wrf.344.1646744815193;
        Tue, 08 Mar 2022 05:06:55 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b003899d50f01csm2129159wms.6.2022.03.08.05.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:06:54 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] drm/ingenic : add ingenic_drm_bridge_atomic_enable
Date:   Tue,  8 Mar 2022 14:06:40 +0100
Message-Id: <20220308130643.260683-2-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308130643.260683-1-cbranchereau@gmail.com>
References: <20220308130643.260683-1-cbranchereau@gmail.com>
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

This allows the CRTC to be enabled after panels have slept out,
and before their display is turned on, solving a graphical bug
on the newvision nv3502c

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index dcf44cb00821..51512f41263e 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -226,6 +226,18 @@ static int ingenic_drm_update_pixclk(struct notifier_block *nb,
 	}
 }
 
+static void ingenic_drm_bridge_atomic_enable(struct drm_bridge *bridge,
+					     struct drm_bridge_state *old_bridge_state)
+{
+	struct ingenic_drm *priv = drm_device_get_priv(bridge->dev);
+
+	regmap_write(priv->map, JZ_REG_LCD_STATE, 0);
+
+	regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
+			   JZ_LCD_CTRL_ENABLE | JZ_LCD_CTRL_DISABLE,
+			   JZ_LCD_CTRL_ENABLE);
+}
+
 static void ingenic_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 					   struct drm_atomic_state *state)
 {
@@ -237,17 +249,11 @@ static void ingenic_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 	if (WARN_ON(IS_ERR(priv_state)))
 		return;
 
-	regmap_write(priv->map, JZ_REG_LCD_STATE, 0);
-
 	/* Set addresses of our DMA descriptor chains */
 	next_id = priv_state->use_palette ? HWDESC_PALETTE : 0;
 	regmap_write(priv->map, JZ_REG_LCD_DA0, dma_hwdesc_addr(priv, next_id));
 	regmap_write(priv->map, JZ_REG_LCD_DA1, dma_hwdesc_addr(priv, 1));
 
-	regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
-			   JZ_LCD_CTRL_ENABLE | JZ_LCD_CTRL_DISABLE,
-			   JZ_LCD_CTRL_ENABLE);
-
 	drm_crtc_vblank_on(crtc);
 }
 
@@ -968,6 +974,7 @@ static const struct drm_encoder_helper_funcs ingenic_drm_encoder_helper_funcs =
 
 static const struct drm_bridge_funcs ingenic_drm_bridge_funcs = {
 	.attach			= ingenic_drm_bridge_attach,
+	.atomic_enable		= ingenic_drm_bridge_atomic_enable,
 	.atomic_check		= ingenic_drm_bridge_atomic_check,
 	.atomic_reset		= drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
-- 
2.34.1

