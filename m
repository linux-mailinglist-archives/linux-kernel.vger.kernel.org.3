Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD357319F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiGMIzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiGMIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D2F2BBD34
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657702509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WV1sbMysUWTQnUXeMzoIvswvu0vFM2B1lJ+VzkW+y6k=;
        b=S9D55GZJ2OLWkFWmunxUDzlDMQXh7dK20gfO2uGVdpspuaYQZOS3+8WHRGRy6qB+u+BnLI
        L+dzCWkQc31TvCJYKe920Rcnm2uaDQMOP9azg5z97B0kmfTTdX3IMPVZI0tVJ2yQWTVjHD
        5Iq80AeOf770p/ypIl6n2Xf24xm9y1A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-bHn4V4EWNaSrmv6yOGRjUw-1; Wed, 13 Jul 2022 04:55:05 -0400
X-MC-Unique: bHn4V4EWNaSrmv6yOGRjUw-1
Received: by mail-ej1-f72.google.com with SMTP id qa41-20020a17090786a900b00722f313a60eso3116186ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WV1sbMysUWTQnUXeMzoIvswvu0vFM2B1lJ+VzkW+y6k=;
        b=tQ6wpFfR3cya8bkvpq0YtWiLNy+dHmsWzr+d+NPJI8mkDfxSjMu0dWAOTveE0jeJo7
         iZiEiBKEQTyxDslNhJythYFSboZzeJAVwH+iXLdU+2pOfyh7xDUWBuhA4nQo7NtsJxC2
         Mi/+pBgwy5N4KIc7GMVxX1vfQlnkyNbkuwZrIEqLUuSUiQPri4cgyUpbcxQrGOk8bEc6
         QGyoZOLngmChg5MKAGW0cAvI7x3gw4R6Uj+N3YOnf3H1I4v5wpXMqcHh20gdzyQt8qJm
         OwrCEUWxtKlJGQKldviI9XVuv3zC71vYeSFlgaIyRWm04rfwEAsqXmtMuyIIqgGubiWZ
         qKJA==
X-Gm-Message-State: AJIora/cR2R7duzwHBZM5M/nEBlbQVZ+KPx9GDzKcoK9jSiTHyeFEbNu
        XRzVlfP7+yCtfVl011b0MNpAlEpG9CAjKEJQ0Ii4GCKV9iSovnydDeTNCpzKDc/Dm7OYFQLRI6D
        UbztZFfiqwyVyOgBuQfeyUPcc
X-Received: by 2002:a17:907:7631:b0:72b:3a31:6cb8 with SMTP id jy17-20020a170907763100b0072b3a316cb8mr2299322ejc.372.1657702504862;
        Wed, 13 Jul 2022 01:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vHJQ1hmybqbUFHi9JfLGHPMl0bUlQL3+VPHCXCzTLWDo10p5guo24wdgNWCe9I5IOJ7jM9Pg==
X-Received: by 2002:a17:907:7631:b0:72b:3a31:6cb8 with SMTP id jy17-20020a170907763100b0072b3a316cb8mr2299307ejc.372.1657702504715;
        Wed, 13 Jul 2022 01:55:04 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id e2-20020a056402088200b0042dcbc3f302sm7547655edy.36.2022.07.13.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:55:04 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     emma@anholt.net, mripard@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 1/3] drm/vc4: plane: use drm managed resources
Date:   Wed, 13 Jul 2022 10:54:58 +0200
Message-Id: <20220713085500.1970589-2-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713085500.1970589-1-dakr@redhat.com>
References: <20220713085500.1970589-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate the plane object with drmm_universal_plane_alloc() in order to
tie the release action to the underlying struct drm_device, where all
the userspace visible stuff is attached to, rather than to struct device.

This can prevent potential use-after free issues on driver unload or
EPROBE_DEFERRED backoff.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 1e866dc00ac3..0d88de31aa9c 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1469,7 +1469,6 @@ struct drm_plane *vc4_plane_init(struct drm_device *dev,
 	struct vc4_plane *vc4_plane;
 	u32 formats[ARRAY_SIZE(hvs_formats)];
 	int num_formats = 0;
-	int ret = 0;
 	unsigned i;
 	static const uint64_t modifiers[] = {
 		DRM_FORMAT_MOD_BROADCOM_VC4_T_TILED,
@@ -1480,11 +1479,6 @@ struct drm_plane *vc4_plane_init(struct drm_device *dev,
 		DRM_FORMAT_MOD_INVALID
 	};
 
-	vc4_plane = devm_kzalloc(dev->dev, sizeof(*vc4_plane),
-				 GFP_KERNEL);
-	if (!vc4_plane)
-		return ERR_PTR(-ENOMEM);
-
 	for (i = 0; i < ARRAY_SIZE(hvs_formats); i++) {
 		if (!hvs_formats[i].hvs5_only || vc4->is_vc5) {
 			formats[num_formats] = hvs_formats[i].drm;
@@ -1492,13 +1486,14 @@ struct drm_plane *vc4_plane_init(struct drm_device *dev,
 		}
 	}
 
+	vc4_plane = drmm_universal_plane_alloc(dev, struct vc4_plane, base, 0,
+					       &vc4_plane_funcs, formats,
+					       num_formats, modifiers, type,
+					       NULL);
+	if (!vc4_plane)
+		return ERR_CAST(vc4_plane);
+
 	plane = &vc4_plane->base;
-	ret = drm_universal_plane_init(dev, plane, 0,
-				       &vc4_plane_funcs,
-				       formats, num_formats,
-				       modifiers, type, NULL);
-	if (ret)
-		return ERR_PTR(ret);
 
 	if (vc4->is_vc5)
 		drm_plane_helper_add(plane, &vc5_plane_helper_funcs);
-- 
2.36.1

