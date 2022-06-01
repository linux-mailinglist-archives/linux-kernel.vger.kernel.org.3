Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D873953A127
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbiFAJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351441AbiFAJrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:47:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32492ED7B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:47:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y189so1466793pfy.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/72CEn/8tEBsrCbwpSKpFCIgi9sYAXiNEhikH0IRpA=;
        b=OS+nvMctRYsuTwiXTJRqbgZKnlvrlKjvQu63bS3tE+z2ocwPpH+8Be8ETuIRFu1Bpm
         lzFSCn4cLpLN4zoriukqzBwgN/EobgeDfPFSG3Zm2uEEqlCB8YTCxRZ92yS+SNWZeqPD
         ZWiz7cFBMmKJ8XT1LNNfAPpMY17jnT59h3r1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/72CEn/8tEBsrCbwpSKpFCIgi9sYAXiNEhikH0IRpA=;
        b=GUpn1o9ebwwPsrfRiHVyucna7nJkLk3HDfLBPBVI3sMhetYMqoe2Mkv69o38rYxscX
         oV6lt8cpWMBI3dJJTQwNb1qGv0DyQ3WaIjt/FZ151G/hTLobvq1lafLzPoTOWsGFmidy
         qMzF5kj2hY8otHcxRCDcQFXbZ099u9nsoEBZthnbM/t2zMPhm7WvW9IwqnzdTiGFqouB
         FYxaSiobl2WsBdlRI4UsYkNo8DGg6ppRiUlm08HD3drZv1oBeIsHMYozNVy1NT86oBg2
         o8thps4wt9V37QE42Of4ydf5sfQRPszOdvd3bHuYwQIiig0/F647sh8YHkwhvLTqawOW
         MkDw==
X-Gm-Message-State: AOAM532NWD3yuSrf2DI6vYloywtzF4WNcPi3ZjD0phIYTs4Dg9+tR24S
        KBXDycHZqZiMmVYWMafnMdHFmA==
X-Google-Smtp-Source: ABdhPJyQ5pLVueYfHXGuwinz70Ri9IG7lJaHjQY79NIVs7H7BxNtxvVzpvSC7OIOWWsYFbqCZuKYlw==
X-Received: by 2002:a63:341:0:b0:3fc:824e:86bf with SMTP id 62-20020a630341000000b003fc824e86bfmr4498754pgd.140.1654076824594;
        Wed, 01 Jun 2022 02:47:04 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a0018aa00b0050dc762815esm1039494pfh.56.2022.06.01.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 02:47:04 -0700 (PDT)
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
Subject: [PATCH v2 6/8] drm/panel: ili9881c: Implement .get_orientation callback
Date:   Wed,  1 Jun 2022 17:46:35 +0800
Message-Id: <20220601094637.1200634-7-hsinyi@chromium.org>
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
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index ba30d11547ad..238b6a75d2ed 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -858,12 +858,20 @@ static int ili9881c_get_modes(struct drm_panel *panel,
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

