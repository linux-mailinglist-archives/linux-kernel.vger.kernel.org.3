Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559335444CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbiFIH2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbiFIH2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:28:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF814A27E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:28:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id bo5so20374900pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G916ndi6znAFvnEdjgirXsQTXINNxUlsFrUsl3kkHpM=;
        b=Ab/Ic+N3PYzvVY9rC4wLHn0KuEQnNGOKYgz5k7NDX1sDl+NPwdPDWR2BTqZJmMuyl7
         pJCNL0LMj1LMqRy0fVBiGW/q7oiDb1RPX14nYbfqbrOyJwmIWOPP49WI3ESH+OQb3CwZ
         BdcdiPGm/oVRjmwfOeH/hiY03hlkzKvGPKMWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G916ndi6znAFvnEdjgirXsQTXINNxUlsFrUsl3kkHpM=;
        b=seXR6CXTFXm7w6hgFjE9zq/KU0CEV7Z4Wd7n4CxrrRXoh0bvdgDusYA9m5K5ldBkTW
         ySGjyrluPGmr9ADWNNoBLpF4II2o962S3/psBYFCX7Caib7NXc9m3lV5pIQu8DxieToD
         NTmlcceTEn3c4yVxpRE0UKYSJrF2ijJ/c44dEytDpaqKQRx+e4Hvt8YliuI8gPggBUOj
         HiieI1WRnVZSym6ChpgGeqFJhQzfV/6r95wG0VqJfEsf2MLIpKjXdHC0vJNN77rGhtwb
         0/FwKBuYtxzJEXaTA/UKG4ON7pQ/Bi+zzQQ13ar/jLE70aFqw/9GkcMomrdg2jVPRJyh
         bw1w==
X-Gm-Message-State: AOAM533DppWkBET7FKi8dhBzof+T+g2F8sXjgH3IF/XzV4pnsfpTexJT
        QnsvP6ZGzZxWNXoQyDnmwRIYnw==
X-Google-Smtp-Source: ABdhPJye6fPlx4aQdZZkt+w0q0qfXmG0AQ+D0AlqoMudVOh6zefu4Y7cFZKkoiaVOrEQnuzP7CFd/g==
X-Received: by 2002:a63:2cd7:0:b0:3fe:1c0a:75ce with SMTP id s206-20020a632cd7000000b003fe1c0a75cemr9121819pgs.602.1654759681962;
        Thu, 09 Jun 2022 00:28:01 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5119:d95b:c6cd:77fb])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm15312221plb.276.2022.06.09.00.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:28:01 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/8] drm/panel: elida-kd35t133: Implement .get_orientation callback
Date:   Thu,  9 Jun 2022 15:27:21 +0800
Message-Id: <20220609072722.3488207-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609072722.3488207-1-hsinyi@chromium.org>
References: <20220609072722.3488207-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To return the orientation property to drm/kms driver.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/panel/panel-elida-kd35t133.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index 80227617a4d6e..fa613d1d7a8ff 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -217,15 +217,27 @@ static int kd35t133_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = mode->width_mm;
 	connector->display_info.height_mm = mode->height_mm;
 	drm_mode_probed_add(connector, mode);
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, ctx->orientation);
 
 	return 1;
 }
 
+static enum drm_panel_orientation kd35t133_get_orientation(struct drm_panel *panel)
+{
+       struct kd35t133 *ctx = panel_to_kd35t133(panel);
+
+       return ctx->orientation;
+}
+
 static const struct drm_panel_funcs kd35t133_funcs = {
 	.unprepare	= kd35t133_unprepare,
 	.prepare	= kd35t133_prepare,
 	.get_modes	= kd35t133_get_modes,
+	.get_orientation = kd35t133_get_orientation,
 };
 
 static int kd35t133_probe(struct mipi_dsi_device *dsi)
-- 
2.36.1.255.ge46751e96f-goog

