Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7EE53F90D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiFGJGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiFGJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:06:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669D6D80B4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:06:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f9so3849723plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkC4wQn3+nXU7dST9FaxB+QRGREtiwsJHA3bRU8iD1Q=;
        b=KBM2BBQMMLkgUMsyR9jAjWANoeklgbSZu54h1hNjBmSk+dJ8U+LkBMOQU9IEslajqr
         IMWKVu3kPIKAiCJEzAlwxvBzAZUNCr9GzM0AXvUMoGO3F/K9fF3Irci+SpskTJtYvYsm
         XH6CtIIBAipgd4VblS3HvTpbYCYgpm9EN69YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkC4wQn3+nXU7dST9FaxB+QRGREtiwsJHA3bRU8iD1Q=;
        b=LgjqVqNICv0lp7IC7HItU4lbB3Na7qnrdoBRcLTxNhz5NP4rkQATTkDWWdh2TaekLG
         ENs7+6Bg5CYyT7gvg81Q5KrYc53d6X5GYy3WaNnpzw9fv89OZjo+u/IgVqfno/Hkg7UM
         LOmcJqXIuDFjg+tUUc9EO97FiANdDXHl9JwX3eCzmEWKSUP0A01706vpl9LOr49ayc+c
         g7n+cZBI7WLk67iNb7G9GMIgFarnbX3iB6E1QRx4ryvyRJKFwtTPQnTsVV0Gcrz+sMwn
         S491O8b31nycZf0RqFdfbOPbeMwm7J2Flsg5oGuHvzirosQ3LHfOzWtfpmMoNCZanCvP
         waAw==
X-Gm-Message-State: AOAM531HTbEtJUYL/OiniaexKzOdufymSkIWZH32O9xeeiKMFav/6Ctv
        uT7qmF4hzjc+2RgX0njzl6OGLP85VPfHdQ==
X-Google-Smtp-Source: ABdhPJxtMveNapxOscHpOj1UN38se05kULc+7JDGp1azNMKPpid/CV/xKFokwk5MP3Wyrs0aUn69hA==
X-Received: by 2002:a17:902:6a85:b0:163:d764:e1a9 with SMTP id n5-20020a1709026a8500b00163d764e1a9mr28522297plk.50.1654592762305;
        Tue, 07 Jun 2022 02:06:02 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40b7:55ce:10ee:c7a0])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7947b000000b0051c0fe8fb8csm4507010pfq.95.2022.06.07.02.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:06:01 -0700 (PDT)
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
Subject: [PATCH v5 2/8] drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
Date:   Tue,  7 Jun 2022 17:05:43 +0800
Message-Id: <20220607090549.2345795-3-hsinyi@chromium.org>
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
v4->v5:
Move the usage text from caller to function doc. Leave todo instead.
Same for other panel patches.
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 1be150ac758f..07f722f33fc5 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1511,16 +1511,28 @@ static int boe_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = boe->desc->size.width_mm;
 	connector->display_info.height_mm = boe->desc->size.height_mm;
 	connector->display_info.bpc = boe->desc->bpc;
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
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

