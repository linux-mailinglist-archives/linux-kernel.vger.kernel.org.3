Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631524D670E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350412AbiCKREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350508AbiCKREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:04:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F983A9E2D;
        Fri, 11 Mar 2022 09:02:56 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u10so13865582wra.9;
        Fri, 11 Mar 2022 09:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KiSvK38EPX6IVw+/gJKjYTTFER6OlFDYV3XuPizh+2g=;
        b=dJrdpXbi1ieqXcKznn34JXk9xzc67TmYjP8NXFPUXoIeeIP7fqdcHlOklMZsSaPgbe
         GH2G5UJ/L+YO8MeG+bPzdG+Zs3rShAK8CwChUApF2aiL+6egodxALBWB/hjXYj0ULVr3
         Pw+C3gfqgexfYWl50GPK7NjcuEkBMLBVFAyjPMy81msdRnl7046d9JOq63nHJodGJyG4
         RZfd3cO1u4BobBkzlqin62HHgUNGDOxNaY120pvpZOmmWC70kxAbuFhxwfLiHKTH+QXz
         IHwdxQ7gmMPVY6HCV4ukcW/y0D+eZKhzw49MaBho4M9LWzvz2ksvSSjolgbGWX06DUrn
         rFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KiSvK38EPX6IVw+/gJKjYTTFER6OlFDYV3XuPizh+2g=;
        b=47yxGo4abgT+FN5vuXmhA7rt85N0Cs35LZ3HPm1rmhvjmOczGZ+CQUivQ+VqiZ0MMZ
         lpNh5Xn0RVv051S8GAmmhBk3UCwNAXhLheR5j5bay4dNbM+tSU5WkSgrJi0Qn114/B00
         Fbbp0TjTmx90BE6qjUNV9EjuQGRmTDaoOXS9xqkMJYJV1DROgH6gnkkxaUpgMeFSviy5
         yQlVskvkInfc0rfZvu5/3cO0X1QVXtGq/nbrUnskxVu6Zot1ZxyJCBvPFIkKziNAKnN5
         kA4CaOfFtNf1aGANpYx9yluDTmn9hpm/Ov3N/CEMo2a7Y7SZ+en5DMYGFFKjHtWVUFaW
         2eJQ==
X-Gm-Message-State: AOAM5323B7THukIOzb62M8Rp4WGdIwW9g4ZW1hE30/qb8CnLBilvFnh6
        aqEH3GjTTF6WL+wJaDKrsuCxzDeuTmgX6g==
X-Google-Smtp-Source: ABdhPJwPnjc3HOL4XSz1enAFUL5SNxjwRzu+E5z3cJ0n7FThhGsOGpHCgIu0/GEzLI89lBHJ5xtwFA==
X-Received: by 2002:adf:f28c:0:b0:1f1:e5e5:28c0 with SMTP id k12-20020adff28c000000b001f1e5e528c0mr8114030wro.417.1647018174849;
        Fri, 11 Mar 2022 09:02:54 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm14067733wmp.13.2022.03.11.09.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:02:54 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v4 1/4] drm/ingenic : add ingenic_drm_bridge_atomic_enable
Date:   Fri, 11 Mar 2022 18:02:37 +0100
Message-Id: <20220311170240.173846-2-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311170240.173846-1-cbranchereau@gmail.com>
References: <20220311170240.173846-1-cbranchereau@gmail.com>
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
2.35.1

