Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E043D53E098
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 06:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiFFEuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 00:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFFEuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 00:50:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB05C2F1F32
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 21:47:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so4907459pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 21:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGnDD5r5M3UXCU6BZiTbTzLZsBiSocgUQfxs0cDS1G4=;
        b=l30rCOLic8LaKGIFsKhI6vz67rGgjxbrO3jiCldFNIW8I5OkLf9aDeJzRGh8jMUXQr
         SdCvlbgXiwhwr5/BW2rNXyL5J0Ps9u1DEZr8MjIpgqYLPWpvNzo7Yl+yZKxpXm2JIANR
         IIiMhDTbZV4a5Cc7egdsQqqF+o3IIyQ41+HPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGnDD5r5M3UXCU6BZiTbTzLZsBiSocgUQfxs0cDS1G4=;
        b=UgbquxQb1V6Lz7ZXR1KVCtotfAyYAjGyHHKDtKpC5KBeaFZ6Wn0pU8pW4LCWEaAmLK
         kRhRuZZDCA/8HHR6uQJrokgDtjmzAcelKAWBO/UIjaFqdWE56E/Nk4ZzGQjtJGZoXU36
         VZ/91cD5c2Mvb1bpj6ueqf87nw5HA1x/C8iGwG0oh1yT0Qo1QgJF1Sgjd9wKALwAr0iL
         D0Q1kvm2MiS9Cuvh8JCZsN12Pyxt21v3bczaczj0xPK/KkBZtHjPJDVLLwbEmlSLg42x
         UmJ9qi0scOdRQmj7s2rUhkKaWU4G6hPUi5UrW39/S59k0QdvpIiWGYMKfy4RKU+7RR7X
         cluA==
X-Gm-Message-State: AOAM533tnqrJdRrUM21Xraaio73Feq78tCDzt1HxG+A45b0QcieAWu6h
        CdSaO1Ul4lKg/GiYkqmCZ+OEQg==
X-Google-Smtp-Source: ABdhPJzbBbErXs2PWbpEsxPCivcXPl2J9WhwCBQUubS9o01KqgtcAIWDGinwPaxoXPioh5PpozS7CA==
X-Received: by 2002:a17:902:c407:b0:163:df01:bbbc with SMTP id k7-20020a170902c40700b00163df01bbbcmr22376780plk.4.1654490854118;
        Sun, 05 Jun 2022 21:47:34 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ced3:b110:401b:b32c])
        by smtp.gmail.com with ESMTPSA id t190-20020a6381c7000000b003db7de758besm9718609pgd.5.2022.06.05.21.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 21:47:33 -0700 (PDT)
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
Subject: [PATCH v3 2/8] drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
Date:   Mon,  6 Jun 2022 12:47:14 +0800
Message-Id: <20220606044720.945964-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606044720.945964-1-hsinyi@chromium.org>
References: <20220606044720.945964-1-hsinyi@chromium.org>
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
---
v2->v3: add comments for notice.
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 1be150ac758f..a9cd07234179 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1511,16 +1511,30 @@ static int boe_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = boe->desc->size.width_mm;
 	connector->display_info.height_mm = boe->desc->size.height_mm;
 	connector->display_info.bpc = boe->desc->bpc;
+	/*
+	 * drm drivers are expected to call drm_panel_get_orientation() to get
+	 * panel's orientation then drm_connector_set_panel_orientation() to
+	 * set the property before drm_dev_register(). Otherwise there will be
+	 * a WARN_ON if orientation is set after drm is registered.
+	 */
 	drm_connector_set_panel_orientation(connector, boe->orientation);
 
 	return 1;
 }
 
+static enum drm_panel_orientation boe_panel_get_orientation(struct drm_panel *panel)
+{
+	struct boe_panel *boe = to_boe_panel(panel);
+
+	return boe->orientation;
+}
+
 static const struct drm_panel_funcs boe_panel_funcs = {
 	.unprepare = boe_panel_unprepare,
 	.prepare = boe_panel_prepare,
 	.enable = boe_panel_enable,
 	.get_modes = boe_panel_get_modes,
+	.get_orientation = boe_panel_get_orientation,
 };
 
 static int boe_panel_add(struct boe_panel *boe)
-- 
2.36.1.255.ge46751e96f-goog

