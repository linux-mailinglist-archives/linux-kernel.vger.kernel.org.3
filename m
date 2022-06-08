Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7773B542C98
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiFHKGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiFHKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:05:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A9F195910
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:48:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d13so1519426plh.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYeDQhf6C4qNcR/ypeqIeNKvzW6/RJ1frKBoLaPHIDU=;
        b=PC2Lf+u82p33uAaLxsXBYJ5HR2k1jQ6H+aVDwMbLLghVBr2zDl0OupdsKQJX49uHlU
         jghqbYWRYx6nQjD4D/zcrT57r9Z1nUyag0neqj0aXKiuTekODbs3teUCdmSgDnmW6Gj4
         HkfsrRM9CHzuMRJnbG3uPkwoM/Cze2d1WnxpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYeDQhf6C4qNcR/ypeqIeNKvzW6/RJ1frKBoLaPHIDU=;
        b=uXmEvn2HRVzbhCKqNs6KKc3CVExrjLrz4ANVTtzwDWxQ0Xp1pzcUS5GTpvNT9fU9hn
         y6J5UEbVL9gyz2yNyPnJg2XxEi4oElMef1A5JYQb97rGA2gwEcTEc3X5sfMiYMAko/WU
         ZmLUb+6boMLiB8OoTwJu5LguE/OYhmiU/a1XH1QOqJ6CD/8E1hsWaEX4xNk2L5kf26sp
         zeeALGLuWFIACcT/taF0vlzoahxd/IDhOIFLr/syX1h9fbL89PbqbgBSWw+4FGUvkGcM
         5TU8SqLbh6Xp1VGE/V5QS16UXFKuJLmpdqP9V8w4wlqIn2woP8R66Vi0RpLc9cm9BpoE
         Q2hg==
X-Gm-Message-State: AOAM532Wr+nqnDy3uZIWG65feIw65RSq3+RrgiWUdfCiFY20KtPI9PP8
        /rs1lYCqb20q07toMG6NC9yXNc1EUrrymg==
X-Google-Smtp-Source: ABdhPJwCus0/AHl/dRscJRgIX7poTraTPgZla5QlFjXvawXiC6yhcifPPOgD8PTJrjHmTVrLJxUjpg==
X-Received: by 2002:a05:6a00:170b:b0:51b:cf4b:9187 with SMTP id h11-20020a056a00170b00b0051bcf4b9187mr31051182pfc.15.1654681711868;
        Wed, 08 Jun 2022 02:48:31 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c46b:e7b1:f6c8:5eb8])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a950a00b001e28e80a8d6sm13584038pjo.38.2022.06.08.02.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:48:31 -0700 (PDT)
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
Subject: [PATCH v6 3/8] drm/panel: panel-edp: Implement .get_orientation callback
Date:   Wed,  8 Jun 2022 17:48:11 +0800
Message-Id: <20220608094816.2898692-4-hsinyi@chromium.org>
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
 drivers/gpu/drm/panel/panel-edp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index c96014464355..ee622c1dd532 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -586,7 +586,10 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 	else if (!num)
 		dev_warn(p->base.dev, "No display modes\n");
 
-	/* set up connector's "panel orientation" property */
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, p->orientation);
 
 	return num;
@@ -609,6 +612,13 @@ static int panel_edp_get_timings(struct drm_panel *panel,
 	return p->desc->num_timings;
 }
 
+static enum drm_panel_orientation panel_edp_get_orientation(struct drm_panel *panel)
+{
+	struct panel_edp *p = to_panel_edp(panel);
+
+       return p->orientation;
+}
+
 static int detected_panel_show(struct seq_file *s, void *data)
 {
 	struct drm_panel *panel = s->private;
@@ -637,6 +647,7 @@ static const struct drm_panel_funcs panel_edp_funcs = {
 	.prepare = panel_edp_prepare,
 	.enable = panel_edp_enable,
 	.get_modes = panel_edp_get_modes,
+	.get_orientation = panel_edp_get_orientation,
 	.get_timings = panel_edp_get_timings,
 	.debugfs_init = panel_edp_debugfs_init,
 };
-- 
2.36.1.255.ge46751e96f-goog

