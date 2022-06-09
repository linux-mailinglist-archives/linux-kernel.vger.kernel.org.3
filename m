Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591835444D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbiFIH1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiFIH1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:27:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220815D335
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:27:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c18so12759036pgh.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3gA/gCwNifa063k5zO2io8sIa7XPaHVQ/76HnmkOsg=;
        b=NMwQPNA8GcvOzDm4isJzui7YhPgnhg1xX3kh0UaVTH2jfU4mkwDoRC0quvFK4/QecR
         arfnWRpveJ0pUy0K4Zn7eItprSorYSdiUF0DxIYSzy+sPVzUfh/4UU+9GQWFSrnbBwol
         4dws/dn+SgtfP55mhYaY5yVIN0hIRkMuNotpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3gA/gCwNifa063k5zO2io8sIa7XPaHVQ/76HnmkOsg=;
        b=DotP2SXrqWAVfjf9xcO0Pm5fs25GNx8+n0zpk3YgBXD6Zke1YZHlaaPcBCTEZG4R05
         e/RDCZfe5Xme3JMxYcGtwtl9X36/9WijPou+Oox3FNUXzf1DGSTpPvhz8D+hEllNUP5Z
         vEn3fh+to1scoYHwlXzApCMITlMHjchhl72V2PASlXHyWL0TJc+yB6mYZXcT8A1mIahA
         scttfM5AzgF6vxl/BSJ0Bty5GFmM3S2a30sTPQYkpjnliuFVnAK5B3eP8K6FITt0ii46
         +7xR3VbvaMMenlZHahKafBYX0g6Si6CrPN5FGtw/fj/ukP1g/orXpbwgeqonMJTNd11T
         gFCg==
X-Gm-Message-State: AOAM532t/GyMoH+qHecd8IEdEMgUXYcSldYnvdPxA7LjPDdssWJqBNwa
        GDkQYcyZxmPJlFt6oXX7wffHPQ==
X-Google-Smtp-Source: ABdhPJxNBX/FBxOUBMeGOirfu/EQZDMrKKnPoYbe2fo82dpTd1VenDY+rtKnkXplac6gWM5VzUu+0Q==
X-Received: by 2002:a05:6a00:15d3:b0:51c:1a20:f8d8 with SMTP id o19-20020a056a0015d300b0051c1a20f8d8mr19746114pfu.57.1654759667464;
        Thu, 09 Jun 2022 00:27:47 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5119:d95b:c6cd:77fb])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm15312221plb.276.2022.06.09.00.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:27:47 -0700 (PDT)
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
Subject: [PATCH v7 3/8] drm/panel: panel-edp: Implement .get_orientation callback
Date:   Thu,  9 Jun 2022 15:27:17 +0800
Message-Id: <20220609072722.3488207-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609072722.3488207-1-hsinyi@chromium.org>
References: <20220609072722.3488207-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To return the orientation property to drm/kms driver.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index c96014464355c..ee622c1dd5322 100644
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

