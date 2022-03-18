Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B0C4DD62D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiCRIar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiCRIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:30:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D33264F54
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:29:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w4so6433188ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wk/pqrVyJD3dZfuBlDvR3gvRx5qETAjydlq9k9fo89I=;
        b=MBv2nbtC77uuFP6FO9vF3JJunvP31eEWqLFqoiGIM3/E0+IkznfVBrTBIuGgXWfVv9
         5TBZHlNgegYmt3aqmPENYo8GhMqjeRQgRc3d1sr5+ApsSsOS0LqCL96pxslRickdXpwV
         ZNw9ExgEXTLbAqCs2ncXkhyskWqy7wd4OrW7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wk/pqrVyJD3dZfuBlDvR3gvRx5qETAjydlq9k9fo89I=;
        b=kNmRXg5S13aYOu47/O0xzwWBw1nuztQdkfP8h3rpTDwqYSAU4M56dY0hMm2HiLMnwJ
         6vJ8HgDOCpKTKx2KwM1oFDfzm27kLPJNayxQK3SP/2TiNn24XV6uq8Y03IpJxxjyTBkP
         k780zvU/BadLTcd2YLIFswUO1Sf6fDYEbSDjQBAJNdymrIJI9TJOHg5TfVDX+/FSqhx4
         sNyL1cgYwkNgV41wXZD6X1aHnHGQxbEFl0bwfF7SVRMC+Kz9r6aJ1bv4e9BUNTJpiqLs
         PbTUvcHemt7NCgzW3gvypXTG9PHEFgq8lQ+OW9u5qWUUbDoaCRbZt14KoYqZjCSGyr8D
         EtOA==
X-Gm-Message-State: AOAM531rLMm54mWENJNbB3fQSrakrlGI6SzxU5d9EXbpMlDNMyNhUOWy
        I3gV6Uibqq/L1TOvgYmZi6Es8g==
X-Google-Smtp-Source: ABdhPJxZr+WrsVRD3EBe7ULBmlgFiXmGvjfKG8gVhn0pmPIZv9TgokVPdh4o8x0PeMOmdu3PzI1t6Q==
X-Received: by 2002:a17:902:e944:b0:14e:dc4f:f099 with SMTP id b4-20020a170902e94400b0014edc4ff099mr9105752pll.161.1647592161915;
        Fri, 18 Mar 2022 01:29:21 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:435a:ce78:7223:1e88])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00084200b004f761a7287dsm9404044pfk.131.2022.03.18.01.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 01:29:21 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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
Subject: [PATCH v9 3/4] drm/msm: init panel orientation property
Date:   Fri, 18 Mar 2022 15:48:24 +0800
Message-Id: <20220318074825.3359978-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220318074825.3359978-1-hsinyi@chromium.org>
References: <20220318074825.3359978-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 0c1b7dde377c..b5dc86ebcab9 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -627,6 +627,10 @@ struct drm_connector *msm_dsi_manager_connector_init(u8 id)
 	connector->interlace_allowed = 0;
 	connector->doublescan_allowed = 0;
 
+	ret = drm_connector_init_panel_orientation_property(connector);
+	if (ret)
+		goto fail;
+
 	drm_connector_attach_encoder(connector, msm_dsi->encoder);
 
 	ret = msm_dsi_manager_panel_init(connector, id);
-- 
2.35.1.894.gb6a874cedc-goog

