Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D80C53BDB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbiFBSBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbiFBSB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:01:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D12B2E91
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:01:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o10so7264626edi.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBkaCoK6wuMtRbb6NmA5F8dDDK95iOEjJpqmo1bo7RU=;
        b=ZpoxLgXU602v2G/Xd3ivQRZ3M5INDPN8DNhTpEgbihmrZIwuUIQqjuMUHGGYehz9i3
         BfZBBrYZOWM6IaNyFU6E+00dNVzVwDW6xwpedw6ki5XAVrDxxGz2ed6hU/XGmtytfyPB
         4zRcXaWVMFaa35F65YMuli1Y3LV03vybRbLGb6zXrnspwuyBUo/70qIA6d6VZEpWVDaw
         l94LfOOUOoIYIOS/OQSX7/VXgosmyXrdT6pwhA+QRqMG2BP3Gv4kVP52VonZiD0z357m
         h79lWxSqNiv4A/PCv3ur4CfXuyDHDvBA0ZB3GOQMI2VmT6CDzqlAIFXnoECb4Q5VjLrW
         BCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBkaCoK6wuMtRbb6NmA5F8dDDK95iOEjJpqmo1bo7RU=;
        b=VPaacYsrm0lncisndJpj1Hj5zuqVKp2wuSnpwFzLVzuAMVrHiUIermL36FtDbGKBja
         zLP46ign5TVdgjWF2+ydMyhnuPfrH17A9TF//w3fY2jthQTp/glwQM3heAXv1/A5AkFl
         0yx4y9h1u5DdN2oNrxia6THR7VdvbIuKG2k8GGP29VbJIUdgYTNozZDHYG+z2oqp7Yxp
         AEBj921QlC2R/RK25GD2RmI2/lSFnMLMQi0pX0zjWzU2IbZbjN5BxeFVOxaFNkCeUFjl
         a+de/SUtTWiCm0aFzAAk1Eq+/P7nm8Ap2XfVgulz5YlKe5fNBFPMF0FhV7Fljg3Fdfud
         DG4A==
X-Gm-Message-State: AOAM5336/YEVIACipjT0ycVRA6nmhm4p6ap7efUnIyS031rlYGtH3O4m
        VP/UwZaaeGqdwMfMHARgJ9g=
X-Google-Smtp-Source: ABdhPJzDb6Kdk0KW4bBqFxqLDw7MsjqgvypVVZTxyU0DlHbSHwe3R6lMclgq9JGCWeJgyKNpDQ/LrA==
X-Received: by 2002:a05:6402:1007:b0:428:beb6:f483 with SMTP id c7-20020a056402100700b00428beb6f483mr6742760edu.391.1654192887279;
        Thu, 02 Jun 2022 11:01:27 -0700 (PDT)
Received: from orangepi3.mydomain.example ([195.234.74.2])
        by smtp.gmail.com with ESMTPSA id kx16-20020a170907775000b00706e8ac43b8sm1972348ejc.199.2022.06.02.11.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 11:01:24 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, megi@xff.cz
Cc:     Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH] drm/sun4i: sun8i: Add the ability to keep scaler enabled for VI layer
Date:   Thu,  2 Jun 2022 18:01:18 +0000
Message-Id: <20220602180118.66170-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.30.2
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

According to DE2.0/DE3.0 manual VI scaler enable register is double
buffered, but de facto it doesn't, or the hardware has the shadow
register latching issues which causes single-frame picture corruption
after changing the state of scaler enable register.

Allow the user to keep the scaler always enabled, preventing the UI
glitches on the transition from scaled to unscaled state.

NOTE:
UI layer scaler has more registers with double-buffering issue and can't
be workarounded in the same manner.

You may find a python test and a demo video for this issue at [1]

[1]: https://github.com/GloDroid/glodroid_tests/issues/4
Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 12 ++++++++++++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  4 +++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 71ab0a00b4de..15cad0330f66 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -27,6 +27,18 @@
 #include "sun8i_vi_layer.h"
 #include "sunxi_engine.h"
 
+/* According to DE2.0/DE3.0 manual VI scaler enable register is double
+ * buffered, but de facto it doesn't, or the hardware has the shadow
+ * register latching issues which causes single-frame picture corruption
+ * after changing the state of scaler enable register.
+ * Allow the user to keep the scaler always enabled, preventing the UI
+ * glitches on the transition from scaled to unscaled state.
+ */
+int sun8i_vi_keep_scaler_enabled;
+MODULE_PARM_DESC(keep_vi_scaler_enabled,
+		 "Keep VI scaler enabled (1 = enabled, 0 = disabled (default))");
+module_param_named(keep_vi_scaler_enabled, sun8i_vi_keep_scaler_enabled, int, 0644);
+
 struct de2_fmt_info {
 	u32	drm_fmt;
 	u32	de2_fmt;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 662ba1018cc4..f005ab883503 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -17,6 +17,8 @@
 #include "sun8i_vi_layer.h"
 #include "sun8i_vi_scaler.h"
 
+extern int sun8i_vi_keep_scaler_enabled;
+
 static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
 				  int overlay, bool enable, unsigned int zpos)
 {
@@ -149,7 +151,7 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	 */
 	subsampled = format->hsub > 1 || format->vsub > 1;
 
-	if (insize != outsize || subsampled || hphase || vphase) {
+	if (insize != outsize || subsampled || hphase || vphase || sun8i_vi_keep_scaler_enabled) {
 		unsigned int scanline, required;
 		struct drm_display_mode *mode;
 		u32 hscale, vscale, fps;
-- 
2.30.2

