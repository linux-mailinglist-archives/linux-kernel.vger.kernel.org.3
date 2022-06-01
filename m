Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5653A12C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351364AbiFAJrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351410AbiFAJq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:46:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F93BA9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:46:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t2so1303767pld.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBqJiw5iICb15XSMEIziFVB5wuNumdiuBxaQCMR6NjU=;
        b=AQSKii1jvRtBpq0Lrpj8ovAJqJPE2589nykaQe03mHf8JaCrY3Z4O1XawIEbsR/4UU
         PxLNY93/gtlAHrORYa+QAoX+Tb6aPH+1e2spp2tc7pfScCEf8S8gOf1+2pzvef6Lvi4o
         Vs3SdULDuc7uOWfaH/zRnk8xF0Wbjb+VseM+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBqJiw5iICb15XSMEIziFVB5wuNumdiuBxaQCMR6NjU=;
        b=gyp8MS/tNFcJaWBSAfN8l8UycZYy5ivbsle4wFP2XcJpB6Okt/fuxWDhiIQerUmejw
         3CPt9RF73gJCNkrhrU5Jn/+AhmSPtk4c6NdAc54tLwKLeizGwqUHCWtXwUTWQdfp9/7l
         iPeLp9Pkpw1l2go/ZZwwqchoowh5RKUlZlKuCHHb1yB7Je+vMgPMYy2sOuuyrwUiK3Tt
         C4gtTnyEyOne1mbyJ79EYtiMprpcTQDaay+LBCQssP69PRAxLumqtXwtMPb4JWEdQ1zS
         rutn5oePiPeEB191+uo5qeqbEM7e60HGjxqpYj+gXeae503S/2JOzmhWQOuk+C/yy50z
         InDw==
X-Gm-Message-State: AOAM533OouG8yIskliOljNz6+lM/k7ccmuz2owPEVjQKVmUGD0c+Dpha
        FxTNuX7CYh9O6UAjDrw7zw9aZA==
X-Google-Smtp-Source: ABdhPJw72ka+6aqP/KnDSsfh0kJMmqQ6I49pRZC2aCEKoh72sgZsPQ9ORjmrG0OhkVOV4FFUNg74Gg==
X-Received: by 2002:a17:90a:6308:b0:1de:fb6c:5944 with SMTP id e8-20020a17090a630800b001defb6c5944mr33599246pjj.60.1654076814431;
        Wed, 01 Jun 2022 02:46:54 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a0018aa00b0050dc762815esm1039494pfh.56.2022.06.01.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 02:46:54 -0700 (PDT)
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
Subject: [PATCH v2 3/8] drm/panel: panel-edp: Implement .get_orientation callback
Date:   Wed,  1 Jun 2022 17:46:32 +0800
Message-Id: <20220601094637.1200634-4-hsinyi@chromium.org>
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
 drivers/gpu/drm/panel/panel-edp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 1732b4f56e38..a2133581a72d 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -609,6 +609,13 @@ static int panel_edp_get_timings(struct drm_panel *panel,
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
@@ -637,6 +644,7 @@ static const struct drm_panel_funcs panel_edp_funcs = {
 	.prepare = panel_edp_prepare,
 	.enable = panel_edp_enable,
 	.get_modes = panel_edp_get_modes,
+	.get_orientation = panel_edp_get_orientation,
 	.get_timings = panel_edp_get_timings,
 	.debugfs_init = panel_edp_debugfs_init,
 };
-- 
2.36.1.255.ge46751e96f-goog

