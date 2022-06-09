Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC95444D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiFIH21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbiFIH2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:28:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34D1156B7D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:27:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e9so10110893pju.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7MRkR8auhgUPzxY/AhWyDzJkPMHJW4gIp7+t1KlPCE=;
        b=l7ZtrVUBq2GYXh2+SH235Ub+vP7lWLaHmSegb5FpWeD2UBMVxBbbSg+yfXe8Ha0sHa
         sRrJmsQrI/ZCdxQ+/mkSj46cerzBPD3JKq3Y5+z0BBzUgbEQ/2VS82VzI3LUsJM4QZbp
         QiY5PgrIjbT2MZf10Yl5LRotp6JHblUn1MP+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7MRkR8auhgUPzxY/AhWyDzJkPMHJW4gIp7+t1KlPCE=;
        b=YFR6AqQGvzj96AU+i2ELl92y/CDvYx8TwgHXtjTsyrf3jjjWFBbQOaqcK5vdu6WtJQ
         OOWotb2dSiArStPKA8fTvu01Ldq4Av66jfM9Y3rGKRT1s95b6iTakbkjqyiDWqNTt82H
         N4P+yKAuBgiC9P8JM810wxn0MJU314M3rd+XZJ7TE5wIeSNHkRencLsWci9cyrbpcskt
         mssr8fPqb0I+j0IIxewiIDcerDa7FZBIO/uj7sfMc59blTbWZErCWYcoJHPCN3JTIv28
         3aMz0gwAg6nMqdu5q0SPdxC1J4eG8qIXCU7fBzWEBUk2seypmmZNgKTwGOBwEWB+cMxW
         sUYg==
X-Gm-Message-State: AOAM532picc8PSrPRRa19zIVzksBQJXEoGMEbdjvi50x2ESi8F7hbWGe
        2FoqTg7B1TyyQLMtM3kc3C0IzA==
X-Google-Smtp-Source: ABdhPJz4dqkjFokdBYRKpv24v7t0WqPiApCHL3ML7AXlrOqT/NAZMvUv0SYaTx3mNhk2+YTvTonvkA==
X-Received: by 2002:a17:902:74c3:b0:167:6811:40 with SMTP id f3-20020a17090274c300b0016768110040mr25200983plt.120.1654759678228;
        Thu, 09 Jun 2022 00:27:58 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5119:d95b:c6cd:77fb])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm15312221plb.276.2022.06.09.00.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:27:57 -0700 (PDT)
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
Subject: [PATCH v7 6/8] drm/panel: ili9881c: Implement .get_orientation callback
Date:   Thu,  9 Jun 2022 15:27:20 +0800
Message-Id: <20220609072722.3488207-7-hsinyi@chromium.org>
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
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index ba30d11547ade..58d6798c25ed8 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -853,17 +853,29 @@ static int ili9881c_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = mode->width_mm;
 	connector->display_info.height_mm = mode->height_mm;
 
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, ctx->orientation);
 
 	return 1;
 }
 
+static enum drm_panel_orientation ili9881c_get_orientation(struct drm_panel *panel)
+{
+       struct ili9881c *ctx = panel_to_ili9881c(panel);
+
+       return ctx->orientation;
+}
+
 static const struct drm_panel_funcs ili9881c_funcs = {
 	.prepare	= ili9881c_prepare,
 	.unprepare	= ili9881c_unprepare,
 	.enable		= ili9881c_enable,
 	.disable	= ili9881c_disable,
 	.get_modes	= ili9881c_get_modes,
+	.get_orientation = ili9881c_get_orientation,
 };
 
 static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
-- 
2.36.1.255.ge46751e96f-goog

