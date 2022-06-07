Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709A53F911
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiFGJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbiFGJGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:06:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A865D2471
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:06:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o6so9228032plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hkt2l/tO7WYacCl3ivjTi6HGPHGi5NrMwDGXS9zHi3w=;
        b=HKI56lq5igyQeKgyyIqASr2VCu3+pT9siwjRtEo3q3xCuBFlEAce2uIG1aG3NqbRxx
         Bi3f+3QlYQIFoTudRE/CoNXXS60RYvhisuyogmtBpm8JNYPyLJm93E7hUNq0bPE7E3wr
         MzH+y1JYIRGuCPOgZlP7fGUe+7MJkLeNMCFkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hkt2l/tO7WYacCl3ivjTi6HGPHGi5NrMwDGXS9zHi3w=;
        b=JqDbnLpjSO/Z+4hk5NfZIFojwP5U0gsTsrHSVmPsQVe7rm+2LITFCQ1shz0NjGukfw
         g4C4yfTqZZs5j48MX5rgeShQaElYS8cEXoipRhc1dDZfgagKAxvZHJ4dCt6mGoodexkB
         8I5hnoto1xtZWs50O98LCnPqNGCm4iZSACy9lBDmxBw20WTuiCKTIvHLveULZ+A7Y/ah
         CugOxcKrVY8ti8uHTBDiB6ARbIFVZOF0Pr1tp/WrHYvmd0RQM5q+bKEBXp8pnFVUYb3P
         fdgMBSxSoCZoEzLXtl5x+0CUnvI6bJqffRvtq79E4bsswj0pIQ2Jz8qgPbZDrBvt+Dfc
         8Egg==
X-Gm-Message-State: AOAM533cZirIN+kaILpWQLvU+STYJ6e+3iZF3nonAZkqczkRpAz9ayWa
        q9G0Cd9SnEwbHJxtgaP9U1ErAQ==
X-Google-Smtp-Source: ABdhPJwQgiNLMIZtppqeYqzT8XKH3y3+vFRRwA/niksJDMFoL3S6gwS/5deq8RA1segUx7+d/t8x4A==
X-Received: by 2002:a17:902:d4cf:b0:167:735a:e7a1 with SMTP id o15-20020a170902d4cf00b00167735ae7a1mr12121479plg.161.1654592772767;
        Tue, 07 Jun 2022 02:06:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40b7:55ce:10ee:c7a0])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7947b000000b0051c0fe8fb8csm4507010pfq.95.2022.06.07.02.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:06:12 -0700 (PDT)
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
Subject: [PATCH v5 5/8] drm/panel: panel-simple: Implement .get_orientation callback
Date:   Tue,  7 Jun 2022 17:05:46 +0800
Message-Id: <20220607090549.2345795-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607090549.2345795-1-hsinyi@chromium.org>
References: <20220607090549.2345795-1-hsinyi@chromium.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
v4->v5:
sort callbacks.
---
 drivers/gpu/drm/panel/panel-simple.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4a2e580a2f7b..b4b919525189 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -411,7 +411,10 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 	/* add hard-coded panel modes */
 	num += panel_simple_get_non_edid_modes(p, connector);
 
-	/* set up connector's "panel orientation" property */
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, p->orientation);
 
 	return num;
@@ -434,12 +437,21 @@ static int panel_simple_get_timings(struct drm_panel *panel,
 	return p->desc->num_timings;
 }
 
+static enum drm_panel_orientation panel_simple_get_orientation(struct drm_panel *panel)
+{
+       struct panel_simple *p = to_panel_simple(panel);
+
+       return p->orientation;
+}
+
+
 static const struct drm_panel_funcs panel_simple_funcs = {
 	.disable = panel_simple_disable,
 	.unprepare = panel_simple_unprepare,
 	.prepare = panel_simple_prepare,
 	.enable = panel_simple_enable,
 	.get_modes = panel_simple_get_modes,
+	.get_orientation = panel_simple_get_orientation,
 	.get_timings = panel_simple_get_timings,
 };
 
-- 
2.36.1.255.ge46751e96f-goog

