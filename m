Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46453E625
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiFFPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbiFFPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:03 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42AD304B40
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:25:01 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c18so4838374pgh.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pK8Pia3oWcO6LvRo8JULHgdKZyhIvY64SIstYz7E0T8=;
        b=j8KrEYwzpTl5wHCO3UxGm1TqLbk/MMUjBXH7zs5T2HtQD/NymmchMMT2FhwajxbvDA
         /NGiGjbOKNhODqs6sZLzSOIu7dkS7XzlyhcmJNGvmaouF1zHr6tpgxhRc544Z15q2oF9
         L+qG4WbV8zWJL+HU6jxVCj6uINhkvLcAgNEFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pK8Pia3oWcO6LvRo8JULHgdKZyhIvY64SIstYz7E0T8=;
        b=mJ7wJB8yItLHqGxGvAH6/lcHp8dY9mUhsEqUHjs9KpU/2aXcuupori+hjzYepNDzML
         nK3nrg68rH/mfiO9GkPUoM0JgUOUG0gF0A9n/LqLkbp02+ko+uKL4GdZNXfoZH5eKtBh
         OhZPSJJ845JpRYTM+xf2dksXkr38dlmKKHXbr9M0WuwuAhUkq4iiF2IqwYQkX+S+7orb
         OZTtZF++L2kWDhmNCnnSkXpJ5T/sXTSm4OFh8whJdaQmyZWkDJkBOTcsFUYaUhlz4eO0
         Y3ITbxjdf2qa9L+yTrA37ldygDqQQppL8ATC/09+ZhPBHgsHPu2/TogosFeWNN4ec3Ar
         Sitg==
X-Gm-Message-State: AOAM5311J+4UzbowlUrU7Tcnn8sLWPjSY+n8DZtwXIrowliJ0i6urkqY
        ttd1wWvk+HCTwp3b6atkxFrPqQ==
X-Google-Smtp-Source: ABdhPJze2xpVhRS2YvADrwZ5t2z07QcQ7pjO+EuDJqVX6Oxw8Uzy747DsOh3B4OxKDgctHwtGwZUxg==
X-Received: by 2002:a05:6a00:338e:b0:51b:c452:4210 with SMTP id cm14-20020a056a00338e00b0051bc4524210mr24166501pfb.69.1654529101396;
        Mon, 06 Jun 2022 08:25:01 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0a:5e4:e24:c8c4])
        by smtp.gmail.com with ESMTPSA id h1-20020a655181000000b003fbaae74971sm10749306pgq.72.2022.06.06.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:25:01 -0700 (PDT)
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
Subject: [PATCH v4 7/8] drm/panel: elida-kd35t133: Implement .get_orientation callback
Date:   Mon,  6 Jun 2022 23:24:30 +0800
Message-Id: <20220606152431.1889185-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606152431.1889185-1-hsinyi@chromium.org>
References: <20220606152431.1889185-1-hsinyi@chromium.org>
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
 drivers/gpu/drm/panel/panel-elida-kd35t133.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index 80227617a4d6..fa85a288afdc 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -217,15 +217,29 @@ static int kd35t133_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = mode->width_mm;
 	connector->display_info.height_mm = mode->height_mm;
 	drm_mode_probed_add(connector, mode);
+	/*
+	 * drm drivers are expected to call drm_panel_get_orientation() to get
+	 * panel's orientation then drm_connector_set_panel_orientation() to
+	 * set the property before drm_dev_register(). Otherwise there will be
+	 * a WARN_ON if orientation is set after drm is registered.
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

