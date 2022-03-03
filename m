Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B24CC3A2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiCCRZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiCCRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:25:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C091719E026
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:24:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ay10so8921786wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ls9wtjKYLj4Hrf28Z+jhrJUB0UPCL2pVKG+9il9xBMw=;
        b=np2zAnpjMIqsdkfxo/fkvM/eHFjijTVV2oc2VB2wXnLbcPj/CZbi9jPdNBlc0VQBAV
         tt5VEjePWc9atcrUwAoTEFgi435wlNXiHGp+8GRE1Hwiy6VxqK2WnjTmmQW2KJVjy1Me
         CehXzLAkKiVM4VnBZs5w6ggj9hjzcKC4E4nYVmh8a+718i9SdlAbvHGzuqszpLWTH7JR
         WEcD1zvOFHlNZ2iDP6qmpzS8oUPNd1fw6z5NUe6427gDY2MsVj+zZvit/q+Mo0W8FX7O
         BnS30xKYsMYmsaoJkfyDQJx+ContJK+QZoiKhddCtOHXCKbf7JkhUguWPtg2Z7boy1vR
         TDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ls9wtjKYLj4Hrf28Z+jhrJUB0UPCL2pVKG+9il9xBMw=;
        b=lkxG4jwbMIiAPybJF2/7VR3ehyVLYRJaSMgZ6rfq2FVjv8fKoiMe/VEx0f7vFDO3e4
         zkLht+aVJGJCSb7Y4DLECNBRUZhh0KHvnmrOJDy9eEzoREMOdcEqqEFOkx50wogQNIaU
         ZJoxecUhwh//cGywZmZkxVzc+8U0ZoxFtP//GuouL7vpH9/q7tAsFVWY7UzVxmGaKn+8
         QMyBohMr8CR8gFfwbLP9tkSUm4+Pdc+HHorKBvH0POHwYoI3zRDpeoSaC0NYtlrzB66r
         LbbEpQJlKIfeyea88Y1JpK3yMcUwuIvh+/jUkVjgl2kFZWYzVtNsMatbJBUZhqJBSbuz
         vZsA==
X-Gm-Message-State: AOAM531/zU95wXi7UTP/3QVNdi8RtpPIdijKWH8lc9p1g27W0UlxQbi+
        z1upcXKxXr5uikVRqsngUUs=
X-Google-Smtp-Source: ABdhPJz2u46vSdsRNfknxhbYenuQ8ABIT7APAs++tsCg9FhykB/A7oF11/3IOfy3ynvopQr5WVlrWQ==
X-Received: by 2002:a5d:6c6a:0:b0:1ef:e5b6:ebe with SMTP id r10-20020a5d6c6a000000b001efe5b60ebemr14117768wrz.502.1646328277256;
        Thu, 03 Mar 2022 09:24:37 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b003814673f202sm10298928wmr.47.2022.03.03.09.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:24:36 -0800 (PST)
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
Subject: [PATCH drm-misc-next 1/2] drm/simple-kms: Drop format_mod_supported function
Date:   Thu,  3 Mar 2022 18:24:17 +0100
Message-Id: <20220303172418.12565-2-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/drm_simple_kms_helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 72989ed1baba..2c6aa67c6956 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -284,13 +284,6 @@ static void drm_simple_kms_plane_cleanup_fb(struct drm_plane *plane,
 	pipe->funcs->cleanup_fb(pipe, state);
 }
 
-static bool drm_simple_kms_format_mod_supported(struct drm_plane *plane,
-						uint32_t format,
-						uint64_t modifier)
-{
-	return modifier == DRM_FORMAT_MOD_LINEAR;
-}
-
 static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
 	.prepare_fb = drm_simple_kms_plane_prepare_fb,
 	.cleanup_fb = drm_simple_kms_plane_cleanup_fb,
@@ -339,7 +332,6 @@ static const struct drm_plane_funcs drm_simple_kms_plane_funcs = {
 	.reset			= drm_simple_kms_plane_reset,
 	.atomic_duplicate_state	= drm_simple_kms_plane_duplicate_state,
 	.atomic_destroy_state	= drm_simple_kms_plane_destroy_state,
-	.format_mod_supported   = drm_simple_kms_format_mod_supported,
 };
 
 /**
-- 
2.25.1

