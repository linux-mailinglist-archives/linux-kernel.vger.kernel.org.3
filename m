Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396F34D612A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348511AbiCKMGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348488AbiCKMGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:06:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5261AEEF1;
        Fri, 11 Mar 2022 04:05:02 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j26so12658975wrb.1;
        Fri, 11 Mar 2022 04:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KiSvK38EPX6IVw+/gJKjYTTFER6OlFDYV3XuPizh+2g=;
        b=GNguAO2uWN1UiBD/ylQEmPI0linSOxq65vNJ4T2z3R5+fEmDZoq6hXxq70BBAXOM8d
         9jHO/T0ps948vFcdHFwXQL5ege3egCE7kVaTo9Y3rRNLS55+ZswYsvDqQgNTsFhY+zlR
         J7dzD4VhW1JLdfVthqo12kC/QkGBS/6rkX+8JAQQKp2Q6xwEMRaGEDPViyU0qg1DBGQr
         1L4ePKpzsWp/k+vNGnU6N0bEyQkySAD//GnAygLwOLliPYE7PcZ2z6Khq7lWJ4KekLkc
         g3HfhTwMFTUyiAWrtNOnu/xy1csw7jY1kl4pOf32phhkudVRhcUy14IFrDsvEM23yIW9
         TDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KiSvK38EPX6IVw+/gJKjYTTFER6OlFDYV3XuPizh+2g=;
        b=ffh+CUcsawCMPPHkGN5a8xygfivEZg7IB7lOQJETwgq27Swa75nvN5UOlNe+PSx8zK
         vTD0wLqXZ3fAxZJkok/XadvU/+dGkYT5R6LnCxyDLX787SQhqv1KOxLugPEK8TnoFJNc
         +XlYmmnfOuQ6xTY47OiswGXlXA44c6Hhng3+0AXawWBuvuGxlsCzAw58QyflWsf1YQTY
         Rs2ern3aQPHDf9Ap7IFpF431yff3MECpaHl5sZ6Lnu5DR6CI9BifLG4qWeMxdlno/c4C
         vgrtjQOuzi6wn2O4kklbaVtbbj6mvRUXjEdrc+RYHYhL3PP3hyncAOhFnTWY+K1VIDKk
         mIIQ==
X-Gm-Message-State: AOAM533kVs2yeMaquwi0atFnMHtRSGXOme/a2gMhMQRBXSndjZvKuZBW
        U1mR2tRa4VxG7NgO3batI9M=
X-Google-Smtp-Source: ABdhPJwbUy9EJ8y4TPRZVO6VLPrG+JBb0cYYUa3n3u+USWarkc+Gm0UpIRbkOjkNqhToCzHXPkWIrg==
X-Received: by 2002:adf:8bd4:0:b0:1ed:c1f8:3473 with SMTP id w20-20020adf8bd4000000b001edc1f83473mr7474689wra.435.1647000301055;
        Fri, 11 Mar 2022 04:05:01 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm6595223wrr.88.2022.03.11.04.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 04:05:00 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/4] drm/ingenic : add ingenic_drm_bridge_atomic_enable
Date:   Fri, 11 Mar 2022 13:04:50 +0100
Message-Id: <20220311120453.163297-2-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311120453.163297-1-cbranchereau@gmail.com>
References: <20220311120453.163297-1-cbranchereau@gmail.com>
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

