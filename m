Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A995537724
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiE3ITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiE3ITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:19:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC6C6D1A2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:19:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a10so1075933pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DngeuiJs1gkZdqFRMCVvHoL93k8N7yG0MeWJK9ZEK3k=;
        b=IqL1Mg8WnZDtXb3yyaSQRaeibgzLzDCSjzxs2JJ81/LU/mT9HMq1woD+CE/FphDXTH
         GnabHy2Ip2oVOYcPjiQ1WwYT2VtY4CQG3boKYbVWHxYOBjBrj1GEcBMoB1z1qeA4GCV1
         8WB0hTYwZDmiOgIt5tnLdJsOq3i7hVAzVDu9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DngeuiJs1gkZdqFRMCVvHoL93k8N7yG0MeWJK9ZEK3k=;
        b=0OO3n8VpIk3uH4exozLra6aDiFfMCF8/TsedOJZIHDMTzE7pD1gbm3ukwjZi2Eb2j1
         vJyvLdkzviPIe8+QRCXlt5giB399V/E40UVEGezgOsYWzUOlEoc9dvGhpNSObAJ5rWHY
         yNDvS+rCbkMwJ2YIohd+b0j3lTwKUyhMeXHOgkB/wZ1NlZZk/jwVCEJZx3BXPLauO6kN
         RZ4Yop6Tz4X8BDTkAEKzIP5swEpIuEWcItB8Lf/H7cklBBzPaMK1rModrt0NAu/jdpbO
         60qCxUTdLsjD4svwja9Km71Wq87GeKWoxnTCdQidjIrdptmidfxeV0VXwSfK7CxHSyry
         ShVA==
X-Gm-Message-State: AOAM5330FvOcnO1U71IKVDJzHnkFtzJTvnhMz/3e93aqiUUl21heSlfw
        WoXJT4pkhVQHkQbIoEqcGexW8Q==
X-Google-Smtp-Source: ABdhPJwMisSwwoUx/1CnfaxFxra5CHlr+0BrN6Jv+hKSLKGk6/BuFuOZ6hgtXERtcSsiW+uir2UNtw==
X-Received: by 2002:a17:90a:6941:b0:1e2:f37a:f889 with SMTP id j1-20020a17090a694100b001e2f37af889mr5209221pjm.160.1653898773678;
        Mon, 30 May 2022 01:19:33 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ae1c:3d63:abec:1097])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902f64100b001618b70dcc9sm8537900plg.101.2022.05.30.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:19:33 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Simon Ser <contact@emersion.fr>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v10 3/4] drm/msm: init panel orientation property
Date:   Mon, 30 May 2022 16:19:09 +0800
Message-Id: <20220530081910.3947168-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220530081910.3947168-1-hsinyi@chromium.org>
References: <20220530081910.3947168-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init panel orientation property after connector is initialized. Let the
panel driver decides the orientation value later.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index cb84d185d73a..16ad3d8fab4d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -669,6 +669,10 @@ struct drm_connector *msm_dsi_manager_connector_init(u8 id)
 	connector->interlace_allowed = 0;
 	connector->doublescan_allowed = 0;
 
+	ret = drm_connector_init_panel_orientation_property(connector);
+	if (ret)
+		goto fail;
+
 	drm_connector_attach_encoder(connector, msm_dsi->encoder);
 
 	ret = msm_dsi_manager_panel_init(connector, id);
-- 
2.36.1.124.g0e6072fb45-goog

