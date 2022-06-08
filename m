Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78386542C95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiFHKGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiFHKFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:05:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7809B19592F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:48:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so7091045pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HCnyXhOafzmcP69v2HLalUicns4RO/ZQ4qvjS6XyGk=;
        b=TKlka2JWr44ssLLTx/ABCtjfqthwug/PJ8osEPhlEiu9s3s0R2eFiNlLU2VVBCK2oY
         spEI6IcIC0Y7RuS5XIz/7AcpSgMzg9RJ+pNYuGhUAVQ+QcbzhgLC4+gLDblo9s8kXDwj
         LwKR6/SQt8R+YXpVbDMufrMBVQbFsJS6qxt74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HCnyXhOafzmcP69v2HLalUicns4RO/ZQ4qvjS6XyGk=;
        b=3S2l9R7VVrsBO6E3WXyWckl1XmJYU8A5xPsW2gR011ZaHSE430bE1TPKF9pTHPwSJA
         Zp2Ja/p70KcU2MFoLxbPfVkftydU9YjYVWN2USC1puoyDHd9R/zg1cNoNT6ndzAD0ehN
         rz1D4kdJifQEZN5QtbWiVG7lgnrppfUWaRvVQDLn4ek2pEOZGVNR+7mwiZMTBA4eXRaJ
         Ym6FhOfHk6snH43nv2t38XWLc3bkfKRnJfKE8PiQcDbgDbuFIJ5BQtPjEKukmBoYy1tS
         8nShIKxwU45IqgPPm+JfkjNmNDw8HlUl+9oAfdXK7Z8sL9iZkudvaD0JPbT+GPdAo0zN
         9Pyw==
X-Gm-Message-State: AOAM532YVqv3jBE0XlwtJg/mRwBGznjqERO4tNaFhVwPDvtZZQrC6Vxu
        IHtzpRviO1I3YS/Ldbg2sf41oQ==
X-Google-Smtp-Source: ABdhPJziscByCaE36IM356mQcufbuxFzgH4ydP6X03lbRU/92TTGOXEDQhe7TphA6EcNjWJhBZO09g==
X-Received: by 2002:a17:90b:1d8e:b0:1e6:74da:97b4 with SMTP id pf14-20020a17090b1d8e00b001e674da97b4mr37453886pjb.147.1654681720998;
        Wed, 08 Jun 2022 02:48:40 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c46b:e7b1:f6c8:5eb8])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a950a00b001e28e80a8d6sm13584038pjo.38.2022.06.08.02.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:48:40 -0700 (PDT)
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
Subject: [PATCH v6 6/8] drm/panel: ili9881c: Implement .get_orientation callback
Date:   Wed,  8 Jun 2022 17:48:14 +0800
Message-Id: <20220608094816.2898692-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220608094816.2898692-1-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org>
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
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index ba30d11547ad..58d6798c25ed 100644
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

