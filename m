Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7B94C8F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiCAPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiCAPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:32:29 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451325FF24;
        Tue,  1 Mar 2022 07:31:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p9so21084887wra.12;
        Tue, 01 Mar 2022 07:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kABsl8nFckhHhGe72PdD4LYbj+x9bM4gFy/8W5Qq+ys=;
        b=Y3t0gFOybWi0MCei9ZUc6VbMi31QOTaeoMi0EEuB9EGC8sXZVldqOJmDzlxTlRAKhr
         sHJAuqEiWaDoxD8VxLmmZj9TBDOQlMYzaZ2hkOB3rx+KPUygSYGFzYt0RPHK8bBjlXMy
         tXJZxdv8M4GQzCp4EX8K17PD+n6qyDiWQawvs3wLUtkPHy25dQSjBLhYjsqPF7/DgVPr
         N0gkSCJTvnYALhOOcAIECIXyB39CT3+kUoyVs95Y6salojTsWXvJcptr2hOpA5Lbx+Ps
         hlHN3GXJq06VPtv8B3Y767p8ClFl6VftI6aMw8vzYPD4HVlpmMkJdl2L7dKBogLTrsSS
         Jj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kABsl8nFckhHhGe72PdD4LYbj+x9bM4gFy/8W5Qq+ys=;
        b=YjJXXHADj+Fl1koxc843DGJtMCn7GtrcJNRJHjmTfRkHoUGPihgqBRKpeSvO+r0Tye
         Q3OFzHaAJQxiVtIBz1Z8QcKSLe4wQsWATA4CQqR20ul8T/+uZpznAMgHCYEgw7SaGdjx
         CvtvyB08IhRAzXlWTxsWEcGqFOIi50v0frz7j6a9zZlEl8okG7N7Xn5TnjXXCXU3ZJaY
         0gf+7BOBXLUeRZOkJa26X4acXOo1kiRdATROwVlDGuP26KMwlGM+flj2ZD26EjbJDcN0
         LWycgDx2qnujFWcH/+K3/FV5Mlee9LH0J7YC2I7STlx+hqqGE78xw0SG0HDsB1Hd/NBI
         xTzA==
X-Gm-Message-State: AOAM531iZhPCRaSQMCJ2jh3tOrwiuyaFbyFMqzYHleEHLG8ZuE8sJrwK
        9uU+JDVDORjZ70uRb6++ZMY=
X-Google-Smtp-Source: ABdhPJzIkkJjFN+Ll7MM/KbLuKabD6lSAVrRlRI0D/yR4BBSZY9LHIvA4txOSvNmXtoPjUKKd4ipDg==
X-Received: by 2002:adf:e6c7:0:b0:1ed:9f7c:c99e with SMTP id y7-20020adfe6c7000000b001ed9f7cc99emr19458323wrm.0.1646148705791;
        Tue, 01 Mar 2022 07:31:45 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c4e0d00b003816cb4892csm5797377wmq.0.2022.03.01.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:31:45 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v1 1/3] drm/ingenic : add ingenic_drm_bridge_atomic_enable
Date:   Tue,  1 Mar 2022 16:31:20 +0100
Message-Id: <20220301153122.20660-2-cbranchereau@gmail.com>
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

