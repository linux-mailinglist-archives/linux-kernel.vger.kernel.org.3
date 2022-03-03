Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7B4CC3A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiCCRZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiCCRZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:25:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C2619E039
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:24:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id x15so8890494wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krlo5s1H1nq87wng/O6VqLU57YxMUUe2fMcieUmiq1Q=;
        b=OD0dV5gPLfQvYYRZAc5cVAP6tZg8/nyZg70DG4K7bqyasRT/tRRkrd98KW5Vr9rHkA
         /VbO/PDAkx+i0y9V7AbxUdsOny2BiXIUvt+I8KhXaX3eES8endopgsxHOHe8gb+sX6hd
         wXo0f0brHlGvDcuC1vfupeL9bEd7B9hYp6yT29bFqyXqaXuvWTlE5dn5/620iPm5kcZO
         jNTIEYhUrCnXsHwIXcCgKUM+2X2yJuUtb82Bis/LBEd8nawPmEbmkSCA+/sZEg821AeX
         bSIOKpRVv1HHWondZjBMo5Y6DV1iTkdtykN2gLmIz+3ejiSI7pEZc2hLBMQDJ0f0QX56
         9syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krlo5s1H1nq87wng/O6VqLU57YxMUUe2fMcieUmiq1Q=;
        b=495y7hLS87spxO17hlYdbuLu4OhcfB+1rIw4zjmnC5XCVsJZshGqXqV7UQ4fMdrJUg
         ZcAlg9Vgf0EyaPehvWfZz7JbpYbHx4xTU6+IN03FcLcBQsrcFmjXN8gQYFAUXDFT4WME
         akAF52oq1XIZtQV23SGs7hW+8I/V8LtqaYarAREGi7b5Nkz/OGTkAkkQd6yLfyPKc2qH
         gDc7aEqc1bi2vFBy7YK0rk+PqExjblFjzKG+uAXvkN4vEdJh9NRC4FA+6UCzwa4eEHe9
         tj29RVh4s3Djt8kVlfE1AGCOUULeXccqcjkSf3Vn23HWmF4DPBzUe0Rh/XTUlIKi9Y+w
         sKmw==
X-Gm-Message-State: AOAM530nWtcrTSix2E7U557srl+iBAkpLr0c724sLSeOr0Ca3JZ0URrs
        e9t+fjixwaqrFfHF4Q4kF9M=
X-Google-Smtp-Source: ABdhPJxCSYXo9SsS/ztE96ehrjJTQOpq2jfebSApjHnWjpv/ubUMDvDXTC0ED453w5xxSfXXqFMLtg==
X-Received: by 2002:a5d:4dce:0:b0:1ed:9fd1:53a2 with SMTP id f14-20020a5d4dce000000b001ed9fd153a2mr27031845wru.212.1646328284912;
        Thu, 03 Mar 2022 09:24:44 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b003814673f202sm10298928wmr.47.2022.03.03.09.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:24:44 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     marex@denx.de
Cc:     stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, contact@emersion.fr,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH drm-misc-next 2/2] drm: mxsfb: Drop format_mod_supported function
Date:   Thu,  3 Mar 2022 18:24:18 +0100
Message-Id: <20220303172418.12565-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303172418.12565-1-jose.exposito89@gmail.com>
References: <20220303172418.12565-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The "drm_plane_funcs.format_mod_supported" can be removed in favor of
the default implementation.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Reviewed-by: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index 0655582ae8ed..df32e1c3cc5d 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -554,13 +554,6 @@ static void mxsfb_plane_overlay_atomic_update(struct drm_plane *plane,
 	writel(ctrl, mxsfb->base + LCDC_AS_CTRL);
 }
 
-static bool mxsfb_format_mod_supported(struct drm_plane *plane,
-				       uint32_t format,
-				       uint64_t modifier)
-{
-	return modifier == DRM_FORMAT_MOD_LINEAR;
-}
-
 static const struct drm_plane_helper_funcs mxsfb_plane_primary_helper_funcs = {
 	.atomic_check = mxsfb_plane_atomic_check,
 	.atomic_update = mxsfb_plane_primary_atomic_update,
@@ -572,7 +565,6 @@ static const struct drm_plane_helper_funcs mxsfb_plane_overlay_helper_funcs = {
 };
 
 static const struct drm_plane_funcs mxsfb_plane_funcs = {
-	.format_mod_supported	= mxsfb_format_mod_supported,
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-- 
2.25.1

