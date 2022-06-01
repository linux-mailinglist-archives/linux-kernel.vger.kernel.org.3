Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3650153A128
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbiFAJr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351490AbiFAJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:47:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5BD49F9C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:47:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g184so1433797pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bk6C27QNmt1+4+7KncB4viIiej/sMiUgOSBQvF7TcyY=;
        b=K5lzcMPBYc5vuIuvnrMLXcNHgjTQKop5EOpt+HwdgnFoFJa+hd9QbbKDaVebbKacZL
         OSwO3h44qdUkHgpNO01ZFKqIrpb7gnBjvepEql6SNrM5QPse6iv7B8DP6j5GEimsSfcl
         7rLDinsDAlwVs0ZKykx56OzMFZvwhVG+tu1e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bk6C27QNmt1+4+7KncB4viIiej/sMiUgOSBQvF7TcyY=;
        b=D6iN786dN+s8cjSYGyCjEhsbIcnmzY7DzA7FQp06yzQVQ7qHlyd6rMZkIaV/NoJSIC
         kRLY47H2H/x8zVwSAsGvQl8IzYYsKHd8vV4dyUAvw5dBGwBPX4Ye86+cDmJTuYQFFFfX
         5uRjoJO6+m6LUy+kUhGBUREZ0CHmae/e/mpX1pDeq1wy9HEicOWWZ1sxnT0cG3krHY94
         cb6+uJiiyrEQAl4a+VDQoDEw9nTV+TUwj/h8OXssp7tnb9qwunHUkTC7qvGSU+x129RI
         RkIRXnlqlufAsNd5M7y9BCNSCqufXUq56m+tEBmTwK27fOiKiEkaOvoi9uqJMI6723Dp
         M8cQ==
X-Gm-Message-State: AOAM530pZevceAO5VvZY/8IFgrs/0Ou6wG6Xg2o3wzEchPkZIz0RmaJI
        iWkRvQ3Cvru7ZxT8aGDye5HstA==
X-Google-Smtp-Source: ABdhPJy780kRALjc91F0vxW4FURBQqFFfjKK3ZprK5u2ZLrMWSj311aX4pckzJCj6vHag0BcmbL/+Q==
X-Received: by 2002:a05:6a00:2386:b0:519:1ff1:d723 with SMTP id f6-20020a056a00238600b005191ff1d723mr28880889pfc.21.1654076827998;
        Wed, 01 Jun 2022 02:47:07 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a0018aa00b0050dc762815esm1039494pfh.56.2022.06.01.02.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 02:47:07 -0700 (PDT)
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
Subject: [PATCH v2 7/8] drm/panel: elida-kd35t133: Implement .get_orientation callback
Date:   Wed,  1 Jun 2022 17:46:36 +0800
Message-Id: <20220601094637.1200634-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601094637.1200634-1-hsinyi@chromium.org>
References: <20220601094637.1200634-1-hsinyi@chromium.org>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/panel/panel-elida-kd35t133.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index 80227617a4d6..079ed71f660c 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -222,10 +222,18 @@ static int kd35t133_get_modes(struct drm_panel *panel,
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

