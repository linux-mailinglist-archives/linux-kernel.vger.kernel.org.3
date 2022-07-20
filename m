Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39D557C054
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiGTWzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiGTWzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:55:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D2EDFC3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:55:35 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f65so17742619pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfUE+cSNEtFx7X3OfqY7F2z53bGolaQzVRJ+UxpNcns=;
        b=JreBijM0Zx3z1FeOJ4sjrvlAWVhPxr0u4D7TSynFWTArdPKjcMRfBxWf6vnelNq5qV
         /xJmgqRObH67ZEIpq52R62o0QFA41kFFZWVY0q+bUF81/jQEmoI+NqKwBivdTVCmf8yn
         uyGrSqow+TS1DarHgvArPNcU67VJwEiyxfsCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfUE+cSNEtFx7X3OfqY7F2z53bGolaQzVRJ+UxpNcns=;
        b=tMkEwYPvRMubnPBpn+o7tqUA0x3PY5Imyg/mcK4YuKdfNx9wRoAvSPBzSTKayJxK2r
         REAFalODz/9+MBRzieWOq4e+Q0Fm1T8lJSyb8mVhosKnjn5DZvIHGvEo15EbfMfjwYvE
         wFgREUO5u95CD2Tw25sfX+X+NJys/stoaa5Z8MlOAUanHOr0zDnwnAulDQ5KaARhXeJS
         sBjnT0p1ER1Ny3UVB3XT+GyQQ64eiWEl9fQQWn5mvPG1+FvWHgFrGl+rBbF/vBdFiSJh
         Ya4ORqk0ueAI++eqHWO69nXsc+a9M1zn5KJ40e1fh3l06lcvaIWVg4zsPJjVYYClxCR3
         hXPQ==
X-Gm-Message-State: AJIora9753x7C+tYVq1w4aPFhSme0wCD+TJ2xLCiucZ9ctNGXUHKslLd
        aUjKPzI+yKjNlDBNRmj4aDyjVw==
X-Google-Smtp-Source: AGRyM1t1LRRJLcm8o8jvBZdEX6oMCYvXxe+JFPIRGMOW5cNzmXCt4VIlo0E6RIXocHRD8ZMa6PlM2Q==
X-Received: by 2002:a05:6a00:240a:b0:528:5bbc:aa1b with SMTP id z10-20020a056a00240a00b005285bbcaa1bmr40941766pfh.70.1658357735107;
        Wed, 20 Jul 2022 15:55:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:fdb4:f565:8767:5019])
        by smtp.gmail.com with ESMTPSA id b17-20020a170903229100b0016bef6f6903sm94624plh.72.2022.07.20.15.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:55:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     ville.syrjala@linux.intel.com, sam@ravnborg.org,
        robdclark@gmail.com, linus.walleij@linaro.org,
        thierry.reding@gmail.com, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] drm/panel: atna33xc20: Allow overriding the eDP EDID
Date:   Wed, 20 Jul 2022 15:55:01 -0700
Message-Id: <20220720155445.RFC.2.I7457deb5f3ac09c27a6ec19a4c7ad2a0b52788da@changeid>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220720155445.RFC.1.I2999ac2d08643f0c2f3fe916cca86f8c832c8142@changeid>
References: <20220720155445.RFC.1.I2999ac2d08643f0c2f3fe916cca86f8c832c8142@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atna33xc20 has the same problem as panel-edp where it was caching
the EDID. Let's copy the fix over. See the patch ("drm/panel-edp:
Allow overriding the eDP EDID")

NOTE: the question will of course be asked why we've got a copy of
this code. panel-samsung-atna33xc20 was purposely _copied_ from the
generic eDP panel code in response to worries that the generic code
was becoming a tangled mess (described as panel-panacea).

It should also be noted that at some point I attempted to move the
EDID caching into the core [1] but was told not to.

[1] https://lore.kernel.org/all/20210329195255.v2.9.Ia7e9bb7cf6c51d960b9455fb0fa447cc68ece99d@changeid/

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../gpu/drm/panel/panel-samsung-atna33xc20.c    | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 5a8b978c6415..2ae62cd7c416 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -18,6 +18,7 @@
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_property.h>
 
 /* T3 VCC to HPD high is max 200 ms */
 #define HPD_MAX_MS	200
@@ -36,8 +37,6 @@ struct atana33xc20_panel {
 	struct gpio_desc *el_on3_gpio;
 	struct drm_dp_aux *aux;
 
-	struct edid *edid;
-
 	ktime_t powered_off_time;
 	ktime_t powered_on_time;
 	ktime_t el_on3_off_time;
@@ -241,15 +240,19 @@ static int atana33xc20_prepare(struct drm_panel *panel)
 static int atana33xc20_get_modes(struct drm_panel *panel,
 				 struct drm_connector *connector)
 {
-	struct atana33xc20_panel *p = to_atana33xc20(panel);
 	struct dp_aux_ep_device *aux_ep = to_dp_aux_ep_dev(panel->dev);
 	int num = 0;
 
 	pm_runtime_get_sync(panel->dev);
 
-	if (!p->edid)
-		p->edid = drm_get_edid(connector, &aux_ep->aux->ddc);
-	num = drm_add_edid_modes(connector, p->edid);
+	/*
+	 * We read the EDID and then immediately free it, relying on the side
+	 * effect of drm_get_edid() to store a copy in connector->edid_blob_ptr.
+	 * We always use the copy cached in the connector since that allows the
+	 * edid_override to work.
+	 */
+	kfree(drm_get_edid(connector, &aux_ep->aux->ddc));
+	num = drm_add_edid_modes(connector, connector->edid_blob_ptr->data);
 
 	pm_runtime_mark_last_busy(panel->dev);
 	pm_runtime_put_autosuspend(panel->dev);
@@ -339,8 +342,6 @@ static void atana33xc20_remove(struct dp_aux_ep_device *aux_ep)
 	drm_panel_remove(&panel->base);
 	drm_panel_disable(&panel->base);
 	drm_panel_unprepare(&panel->base);
-
-	kfree(panel->edid);
 }
 
 static void atana33xc20_shutdown(struct dp_aux_ep_device *aux_ep)
-- 
2.37.0.170.g444d1eabd0-goog

