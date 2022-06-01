Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42422539F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350633AbiFAITQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350601AbiFAIS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:18:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392742BB0F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:18:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1370516pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xeMLg+35N7hSrKTKnxWGY/ydjeaKMZYeAKhgclNfW00=;
        b=QnX8EAqj1NdSiodi34RQfAUVxRFwDNNVr9xsWDQow2cE5INydMl18CERAzjA7RQN9L
         iyrE/btER8fTucQ5/nH8nOa+GoOQ9wwDukPAOPagcGYHZmiKcSWDkDl3u3+Kw0OY8n8L
         b9x8pOz1UR8mWvMu4W3ha9pWcmlyQb2tDBHP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xeMLg+35N7hSrKTKnxWGY/ydjeaKMZYeAKhgclNfW00=;
        b=pVe9j7KXJyRst5XXCg2VzcTa3G9ROthPHwnCsC9/MOafrq+IyGb2xCtLBbdF9HdCMQ
         CFji8sJGm9tHUpr/edO+7gHjOlCutWIR8nKAUhxLP5PkfIrhCIhCTeCBVzjMuH/ab7+u
         sBVKmOAMdRDqB+p+BCU7xv9H8qOaGifW2RkHM5/xhmBWsrs8fR4iK901OzB0kKNzgu2x
         izve1T5JEOqpi+LMaij/0i35N9ySaWTPNgknpXUBBLQL+qotBjY1eRpCumXcpDra94/e
         VSaHbfKsYIulntnNegvqqXCl3SjBwiPI5N0TxbzrPjDJdi+0eLP4ZlBxzEzqWsGIuSRa
         1K9g==
X-Gm-Message-State: AOAM533UEj1G5MoB/LC5prmzXgq0APSjKinfsg1ynX8OFryL3gLgFwgd
        l6VGYreyvDme7V0JoFnWqCPm2g==
X-Google-Smtp-Source: ABdhPJzLVGMo42m5euNK4kp07ZocNgWlb4mGFb+T8VtJCH8enEAQQ9fbe9dx6N+5RtJX12cxrzs+SA==
X-Received: by 2002:a17:90b:4ac9:b0:1e3:1dca:d995 with SMTP id mh9-20020a17090b4ac900b001e31dcad995mr11560854pjb.111.1654071535681;
        Wed, 01 Jun 2022 01:18:55 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b0050dc7628182sm824680pfo.92.2022.06.01.01.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:18:55 -0700 (PDT)
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
Subject: [PATCH 7/8] drm/panel: elida-kd35t133: Implement .get_orientation callback
Date:   Wed,  1 Jun 2022 16:18:22 +0800
Message-Id: <20220601081823.1038797-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601081823.1038797-1-hsinyi@chromium.org>
References: <20220601081823.1038797-1-hsinyi@chromium.org>
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

