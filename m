Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2C539F2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350579AbiFAITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350555AbiFAISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:18:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C7F2BB0F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:18:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so5460280pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdPl/Tf6jL9+D3LT0u150RT4I6KqqkA79M7TaHGqeRs=;
        b=T8iFrxlGkDnezem3qfebm9nWuH2n0YbQw2LTIT85bYvGyWqfRsYh5tWeX+uuL2GHHH
         Hcig0S6hO3U8bdSdxwGUJaC69Ku95h6my1S7xZvpIT5ALq/Aas+WyotltbQtw+44YRVo
         5AksVCmgz8eam66xN85U5ePqXAjiMGHFnFSek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdPl/Tf6jL9+D3LT0u150RT4I6KqqkA79M7TaHGqeRs=;
        b=ucWpZTXcjiH0zToFvwQHxE6S3w+x5xdRKpQhBZs6elC9e5FJjl+CoufOMl/ebXVAXA
         +l8Jj0cOovdaBr4O8NWpN93zerm+AqM9ecdq5gqJ8BcH4318Hx8EDG2qB3tdiMhkif/7
         Yfb6AAka7FSAp7DkmzT7ZTQm6KpYE/9JGmNBlI49GUV3UuMBm2vgcO9s+hPq9IIvvLZX
         7+c/Bfy1XSZQJVk4ofyK9rCYwRxi9x9eC+PC6Z6ENMHm3wceyxzI6xz8jfE2clb31j2B
         08k6i4aRu7+3MJhsPhGx7IdOGDgwDFg2b0lSv5e/CwytAG051PyXoFpB6eASOX7fZk2L
         7GBQ==
X-Gm-Message-State: AOAM530ojkSDWkFJO+oiReTg8XizRzCptyHkJ5Zfoqq2jtzLRRqbMOA4
        l56m54tJpf1FwcsbxFo9XkV1zg==
X-Google-Smtp-Source: ABdhPJxKELhOFU4LHTDmNuq52nBBrczXLmtFgK6gdtzyOHFSGBG4Ze/wn5pXmjLWXZGt7iwaLDo+WQ==
X-Received: by 2002:a17:90a:5b0b:b0:1e2:8e28:1a61 with SMTP id o11-20020a17090a5b0b00b001e28e281a61mr25453869pji.187.1654071525517;
        Wed, 01 Jun 2022 01:18:45 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b0050dc7628182sm824680pfo.92.2022.06.01.01.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:18:45 -0700 (PDT)
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
Subject: [PATCH 4/8] drm/panel: lvds: Implement .get_orientation callback
Date:   Wed,  1 Jun 2022 16:18:19 +0800
Message-Id: <20220601081823.1038797-5-hsinyi@chromium.org>
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
 drivers/gpu/drm/panel/panel-lvds.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 27a1c9923b09..dc50f73d400f 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -107,10 +107,18 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
+static enum drm_panel_orientation panel_lvds_get_orientation,(struct drm_panel *panel)
+{
+       struct panel_lvds *lvds = to_panel_lvds(panel);
+
+       return lvds->orientation;
+}
+
 static const struct drm_panel_funcs panel_lvds_funcs = {
 	.unprepare = panel_lvds_unprepare,
 	.prepare = panel_lvds_prepare,
 	.get_modes = panel_lvds_get_modes,
+	.get_orientation = panel_lvds_get_orientation,
 };
 
 static int panel_lvds_parse_dt(struct panel_lvds *lvds)
-- 
2.36.1.255.ge46751e96f-goog

