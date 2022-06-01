Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3927539F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350567AbiFAISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348447AbiFAISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:18:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F4628720
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:18:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a10so1326358pju.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmbEut7AQ7/Bf3HWTLDsZtp4DOqAEomrHS3HpyZ9OO4=;
        b=igURx3teJeErCLwWW62RZUsTiA0yqJqs5g1N0ySEf7hYZ0aQu17UQuOLGN0K/bQkFv
         oIayxg9GbTmWrLSfdAVeYA/N/zIJ+CTzhRi6uQdSzkNPBbyiIFACjzza0SYrv17UUtQv
         aeGqsnM/aIpZfOz7ZST/lSBoAilfn+Kv/UZw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmbEut7AQ7/Bf3HWTLDsZtp4DOqAEomrHS3HpyZ9OO4=;
        b=kCRR2lGQbnERs/1faILfUKJ+FUPsoypeRKYmFxE5HsKleJi5UljKOAsFn+OTro51tk
         YJoICOyp5b/lnkFsTTt7msrb6YHOCrWVKz6FmAFVqAHgQulbc6blwQ88Z8XzEWF3tep8
         5TVScRKXIWp5mgnmk8BmEZb0/izAfuHCykH9ZUh70OXx/k9kz/WTOKPEj2UlHkBP/FdG
         iq9VuGDV6WUhnDI8p1Q2+LZZHDb55uHhrR+h//OhVMay1kd3vL34yWfVG/lBxARV/Vw6
         aYenDqgjN4i0or946sSinylIIsaH2uz90byNTQzG3tPQQerX3Gt78UILb/WQzQVxNN/Z
         yXcA==
X-Gm-Message-State: AOAM531y7g12+w5smht6RYKxVU9073BXBTXvVNUMGUgYh1qdS0EWKZVH
        hfY20UqWF6FLmO0s7O0CcPysxQ==
X-Google-Smtp-Source: ABdhPJzAOTg2fw10j7HFjvrblLTUzc60T5jBHgR4OhGqZldKydmmJeCI6jBogTpq8SWmmOAAjGhg6w==
X-Received: by 2002:a17:90b:4f44:b0:1e4:b161:f9f6 with SMTP id pj4-20020a17090b4f4400b001e4b161f9f6mr3465677pjb.43.1654071518643;
        Wed, 01 Jun 2022 01:18:38 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b0050dc7628182sm824680pfo.92.2022.06.01.01.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:18:38 -0700 (PDT)
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
Subject: [PATCH 2/8] drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
Date:   Wed,  1 Jun 2022 16:18:17 +0800
Message-Id: <20220601081823.1038797-3-hsinyi@chromium.org>
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
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 1be150ac758f..0f1c9b685da3 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1516,11 +1516,19 @@ static int boe_panel_get_modes(struct drm_panel *panel,
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

