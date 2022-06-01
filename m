Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316F2539F40
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350641AbiFAITM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350574AbiFAISx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:18:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D899664D0F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:18:52 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v15so1205325pgk.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M55jesM2/bLrZTqeLQbPue+qYepgHtq5DKFSuhycS2c=;
        b=aYfb6XQeGN+agxPiXMc5cMMCvRMycYKm3pjxf5IuRCdZkzxHVMNiMARTXTzWZUQPQG
         RTyI09JGjcklxzXAbDnf/Di/q40nfaQ7S4bgFQVenhFqddaJnUPtH0xkmzLf3rpgk7MS
         mME6bPb0/mloYpW/tF0wiOlWADxaQd/hVTSug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M55jesM2/bLrZTqeLQbPue+qYepgHtq5DKFSuhycS2c=;
        b=DH+T8Deo/xQZH+g6zVCPPzf6E9q7Br+Xi0h3ypPp6WpoLkzN2IGWU+5q8UIS16l6Um
         KsmuKBgLISqbT/AYF9vRpHIX4Txgx5RsrzhYy7UYYNrXOt6HSsnZvcWODpEe4FeJIiqs
         /3pWDbSkroDNXRzdaKlAICryIm5fkkCdQbK+UFR7jizQPBai096H5RMVFrHRSgAHJuCk
         KQdb1Ye+rbOw+6ZSFk23NMtUvt+utdtsp0bKzi7tlXtT2kMgO1kxpjYqChta0OIrp8cL
         tWrm79tQ5Kr9lk/LgK4C2tlJSRf8RqhCihCGpu6qPoKdQbz5UfFFz+DMv9lVYp3FRPq4
         aKHA==
X-Gm-Message-State: AOAM530BDQoaUEWH75dlfc8i24OzM2cP2e2kjPElMyoxHCNS4KlgLHIk
        BodKe7iyvKkXwZN8bbK4PM+GkA==
X-Google-Smtp-Source: ABdhPJw1updJCiw3Qsgmdq3tUxrZNaTrj9u2SGii7IU9H10RIUQW1QdPFu5jUXYEGA9RVz0ZD8Btpw==
X-Received: by 2002:a05:6a00:a03:b0:51b:5131:704e with SMTP id p3-20020a056a000a0300b0051b5131704emr13202436pfh.53.1654071532308;
        Wed, 01 Jun 2022 01:18:52 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b0050dc7628182sm824680pfo.92.2022.06.01.01.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:18:51 -0700 (PDT)
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
Subject: [PATCH 6/8] drm/panel: ili9881c: Implement .get_orientation callback
Date:   Wed,  1 Jun 2022 16:18:21 +0800
Message-Id: <20220601081823.1038797-7-hsinyi@chromium.org>
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

