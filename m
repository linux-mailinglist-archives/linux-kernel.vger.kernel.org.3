Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F8353F90F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbiFGJGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbiFGJGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:06:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47205D80B4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:06:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso3065543pjk.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYeDQhf6C4qNcR/ypeqIeNKvzW6/RJ1frKBoLaPHIDU=;
        b=e5GUX3w98mXidj6PktAsCCs+1jtyi7CTkOjk4ZtoYHy7DxEANDLibad2GC3quOwOrm
         UVZoqe81WqocOq5NEs/kaeH0rl1kjIlsj08svMQHfMdKvx5CkRYStIBgMRcuCypTHAy0
         URnedot666T8TmTtSlzzLt0YKeJ/9f/LZz9XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYeDQhf6C4qNcR/ypeqIeNKvzW6/RJ1frKBoLaPHIDU=;
        b=ifVmLeDoJMwZ5MatZ6DNpJ0q7TzlzZTaToT2nfxxWV+M6CjFB+9FzLGQPZ0eghXgCT
         JRNpPjP7XYadBkoJ/GLtDOlWn6OqNyY96ejw4dB+EvVbpUX4xGKnGFahPOg7wfB+jlkS
         PcyK58fXiLebgdwPtmy88oSCSZQ/qF3GUzaJZHv/Pi8qahRVZ8Ww7Vjf28p3B76opdms
         tMhzTqwWxVhofvgFSHoLx4VpxUqFGblLZEklh5N28Byz4WFNxDzE7qCPTQ/lzf1O6u/v
         +I4FUBN15J4ZK/HFdTdanyRXoRdw9I8YlCm0pHOSrW+2yXFacQpIYv92Axc4agy52lFO
         1uMQ==
X-Gm-Message-State: AOAM533hAxyOvUhFWGb93n8oIcc8FR7p1K1GXZmc8s3U7qxyE9FWQY6k
        pqu5ITpIGeb/1wg77fjkjM6Diw==
X-Google-Smtp-Source: ABdhPJzeaeZzletu7cyNw10d23dKyONDwXP2r/qWUVnyVfAreMR1Ry/RctWwZMxAUZbcnT+OV3SZpQ==
X-Received: by 2002:a17:90b:3c4e:b0:1e3:36c8:8496 with SMTP id pm14-20020a17090b3c4e00b001e336c88496mr40678398pjb.82.1654592765731;
        Tue, 07 Jun 2022 02:06:05 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40b7:55ce:10ee:c7a0])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7947b000000b0051c0fe8fb8csm4507010pfq.95.2022.06.07.02.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:06:05 -0700 (PDT)
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
Subject: [PATCH v5 3/8] drm/panel: panel-edp: Implement .get_orientation callback
Date:   Tue,  7 Jun 2022 17:05:44 +0800
Message-Id: <20220607090549.2345795-4-hsinyi@chromium.org>
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

