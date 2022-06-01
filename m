Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B9A539F35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350639AbiFAITG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350560AbiFAISu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:18:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B13D24F07
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:18:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so1089880plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8d1zMyQL8ZiF08W1HsnKeLAzP5rqfEzV2IbS5Izuy0=;
        b=ksf8bG7XN7niA4y9qzTxWIPlIOFWTcLTSarHP02vVmoXUREl/ysj2VMRvOMzVquSZp
         74rYEsAYHeD9oNsiY+Xk9dezvNSEy8kQ9/ge4tXgXhzEPSugxwLbmLq5cKfe5XNIvu2k
         xkG1RIDytD/qALPSRIQ2XcJksj/Vu4jDPblQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8d1zMyQL8ZiF08W1HsnKeLAzP5rqfEzV2IbS5Izuy0=;
        b=SOyactO+x0KRECkSTyHzD/w6kO+Nm2CJUrkQKMM2a0v76mFF6kZCi9NJBJfDCKpe6o
         EqtVEYcmW3iU8NhykJsTfkzw6zLWUGVvxfYUlCZTPhh2v4v3W0CZ0XNPPwFSYLOs9gtD
         MFH4Z3vfKTjC649NyGEcZlOsWU3ux/Y2Ks2IEdzKx+yOQWAP3tAIqM3ruoLL5bDEMWwb
         MRl77f4N6qSinzsaO4QGfPW/ZScQb5RuxSdV5jEKczWUlTtFo/EYjmphi1Tmsivz5FGk
         rYm6NFBFU7XsW9HS7RUjdTh/nJjIA+rDpEpv9DFocItVaPKljSyjZOuKAWUoWC+yMMGG
         qkTw==
X-Gm-Message-State: AOAM530xBoKIP3mWc9ILw1WnwPzZnRFv//Q6+VS0Dy8SFsHSpVpKP6jI
        fdsfMLri1OA8JIzr6RTO9jkvig==
X-Google-Smtp-Source: ABdhPJzu2dskjcB1Tt4UKMFKzdt9KMOK3CIoubeiISeLw+ntZYQQClm4pmYrRg1PPV6+tb9enszBDA==
X-Received: by 2002:a17:90a:14a6:b0:1dc:f64f:ff2c with SMTP id k35-20020a17090a14a600b001dcf64fff2cmr33347670pja.161.1654071528928;
        Wed, 01 Jun 2022 01:18:48 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b0050dc7628182sm824680pfo.92.2022.06.01.01.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:18:48 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] drm/panel: panel-simple: Implement .get_orientation callback
Date:   Wed,  1 Jun 2022 16:18:20 +0800
Message-Id: <20220601081823.1038797-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601081823.1038797-1-hsinyi@chromium.org>
References: <20220601081823.1038797-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To return the orientation property to drm/kms driver.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a34f4198a534..54e78d978dcb 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -434,6 +434,14 @@ static int panel_simple_get_timings(struct drm_panel *panel,
 	return p->desc->num_timings;
 }
 
+static enum drm_panel_orientation panel_simple_get_orientation(struct drm_panel *panel)
+{
+       struct panel_simple *p = to_panel_simple(panel);
+
+       return p->orientation;
+}
+
+
 static const struct drm_panel_funcs panel_simple_funcs = {
 	.disable = panel_simple_disable,
 	.unprepare = panel_simple_unprepare,
@@ -441,6 +449,7 @@ static const struct drm_panel_funcs panel_simple_funcs = {
 	.enable = panel_simple_enable,
 	.get_modes = panel_simple_get_modes,
 	.get_timings = panel_simple_get_timings,
+	.get_orientation = panel_simple_get_orientation,
 };
 
 static struct panel_desc panel_dpi;
-- 
2.36.1.255.ge46751e96f-goog

