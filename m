Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5CB53F910
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiFGJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbiFGJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:06:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC728DE326
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:06:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so4118915pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URQgL2yUP1UPEGjFj3Vtkw+GlIVy5pPiHox/tAieZas=;
        b=KkdhkZR0WaPbNGFjnV5JiCzsW/4Td/Y1uAFcoXb7bs6qedkwYqr4useNkOhECnjn51
         Aq3h7Q9o6cOxgUZHsiYDmtF1268mVFmhpOCB/F3QQ8y02faY5NkR3KYqvXQzUO7cqmiO
         2nqtwa7AfOlK/1DOFkxqwBsRQTuz59g/WYL28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URQgL2yUP1UPEGjFj3Vtkw+GlIVy5pPiHox/tAieZas=;
        b=izMxLWkCXvk0CR7CpyNK9rXVAWfYE67qpAg3bIeheEaDi2awLRIiG9aCFkI/f67qxZ
         DaG2+i2lujXntfboPMTvoE0hi0Q9SctvRm5IuTpwqTXyvFRPa7LYIV/0V9Cbv9cPv7h5
         rW1c1MiyotDU9AnnN2gHdjoK4nAhAjNBfDJcmzzNYQPhsRgLcgO0HVmIZ2JXMUSwfMTE
         3uAJ4H2laUCTmM7rjtII7qpes+Wam9pdNjUTSfk+BInrDo0fYH0WapElPfI2Ooog45+B
         DHIh0S0Ye2oSGKLe28wgUskQnKbWIz86+s4KyZT383JrGR/YaRJMRFeSaZdfFW3yEiKa
         oedA==
X-Gm-Message-State: AOAM530W0n6LWrMXUlKNb4XR2cX0F4B19Vvnx6atghwkQVy170gq6+PM
        Eb9/uiRv6j4PzP1dfuAqCZbAvQ==
X-Google-Smtp-Source: ABdhPJxUb/prMt/A7sRaNQTJtn9oWDj3rVo1IOvfLfcAgTaDday8s3jr1NXmj+cqqrwS88WfrUyMFA==
X-Received: by 2002:a17:90a:8b93:b0:1e2:728b:1fa9 with SMTP id z19-20020a17090a8b9300b001e2728b1fa9mr31329972pjn.167.1654592769235;
        Tue, 07 Jun 2022 02:06:09 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40b7:55ce:10ee:c7a0])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7947b000000b0051c0fe8fb8csm4507010pfq.95.2022.06.07.02.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:06:08 -0700 (PDT)
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
Subject: [PATCH v5 4/8] drm/panel: lvds: Implement .get_orientation callback
Date:   Tue,  7 Jun 2022 17:05:45 +0800
Message-Id: <20220607090549.2345795-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607090549.2345795-1-hsinyi@chromium.org>
References: <20220607090549.2345795-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/panel/panel-lvds.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index f11252fb00fe..7a4fedc63e8e 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -99,15 +99,28 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
 	drm_display_info_set_bus_formats(&connector->display_info,
 					 &lvds->bus_format, 1);
 	connector->display_info.bus_flags = lvds->bus_flags;
+
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, lvds->orientation);
 
 	return 1;
 }
 
+static enum drm_panel_orientation panel_lvds_get_orientation(struct drm_panel *panel)
+{
+       struct panel_lvds *lvds = to_panel_lvds(panel);
+
+       return lvds->orientation;
+}
+
 static const struct drm_panel_funcs panel_lvds_funcs = {
 	.unprepare = panel_lvds_unprepare,
 	.prepare = panel_lvds_prepare,
 	.get_modes = panel_lvds_get_modes,
+	.get_orientation = panel_lvds_get_orientation,
 };
 
 static int panel_lvds_parse_dt(struct panel_lvds *lvds)
-- 
2.36.1.255.ge46751e96f-goog

