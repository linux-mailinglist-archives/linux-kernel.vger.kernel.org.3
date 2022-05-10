Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA735225E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiEJUxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiEJUxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:53:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FC551E56
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:53:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x12so15592479pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+HZZAVCUgB4PR5HOSv738zuWZd6viwdct4jZ4FZSIU0=;
        b=oWmYD10TXbpQiIJ/xzCl7IxKeJeRGHnNIYoe2NzGF8Z40b9A089yZu2d/GnlCuSqdo
         q6ZIKf55c1K3Q602V8ZhCPmbryBHAVSR29GFjetx8dPxfxwpeelua5Oe9dNh49PzFRnz
         msgXH2br9qxGT5GVAPoL2u6hWcb2Le2llWrms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+HZZAVCUgB4PR5HOSv738zuWZd6viwdct4jZ4FZSIU0=;
        b=zaHvWK9yqUyWMXK1OBqIuhPixkx/xCluM31oICWK00bF4ovvW1jpfrU+kYNj4xLKbW
         //jz4x12vE6LGAfubYxw1J+o+RzNRqFIPgFPHWphrjiMvk+IeUbmHDD/Zt3KLdvZdAjf
         5TkDPVhRx3pMFEIY0ooQ5ZmoVvxzqusyCM9AuGsq0uujXu9GqiZFuQd8HpCvfhBKSmIO
         PXvMZiCesG4G3jZX/vSGvatWciJ/6es8LrBeNP7wC8Hefatw/5Zzh+gW07z7hNmi/dHF
         hEmY37nv+Xakzoo9doT758POJ1RRpjx4I7S6uaDd/g3sUEC9ZFBCT/vneXsn42AfuVs4
         AcBQ==
X-Gm-Message-State: AOAM533AjBZnHA0WafTJ3LYr6iPen+ktLC3Rah7GGF3GoxppP3Mgo+Q/
        oe9bgr68XhOyuAjuXinYDsJ9bQ==
X-Google-Smtp-Source: ABdhPJx51SH/5x8d1+7L4D8y1N7o70vXFdfzujmC9MaUWLZcKl14rafYh/2Xs1SSzWyvWcqe2COx9Q==
X-Received: by 2002:a62:d0c5:0:b0:50d:a467:3cc8 with SMTP id p188-20020a62d0c5000000b0050da4673cc8mr22146677pfg.81.1652215985737;
        Tue, 10 May 2022 13:53:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6f08:624c:c762:d238])
        by smtp.gmail.com with ESMTPSA id lr10-20020a17090b4b8a00b001d2edf4b513sm92975pjb.56.2022.05.10.13.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:53:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     quic_abhinavk@quicinc.com, robdclark@gmail.com,
        swboyd@chromium.org, quic_aravindh@quicinc.com,
        ville.syrjala@linux.intel.com, tzimmermann@suse.de,
        linux-arm-msm@vger.kernel.org, jani.nikula@linux.intel.com,
        quic_sbillaka@quicinc.com, dmitry.baryshkov@linaro.org,
        freedreno@lists.freedesktop.org, quic_khsieh@quicinc.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/probe-helper: Default to 640x480 if no EDID
Date:   Tue, 10 May 2022 13:51:11 -0700
Message-Id: <20220510135101.v2.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're unable to read the EDID for a display because it's corrupt /
bogus / invalid then we'll add a set of standard modes for the
display. When userspace looks at these modes it doesn't really have a
good concept for which mode to pick and it'll likely pick the highest
resolution one by default. That's probably not ideal because the modes
were purely guesses on the part of the Linux kernel.

Let's instead set 640x480 as the "preferred" mode when we have no EDID.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Note that this is the second of two related and similar-sounding but
different patches. See also ("drm/probe-helper: For DP, add 640x480 if
all other modes are bad") [1]. I'm hoping to land _both_ of the
patches since they address different issues. This patch addresses the
case of a corrupt EDID and having 640x480 be the default in the
"guessed" modes. The other patch handles the case where the EDID
_isn't_ corrupt but all the modes listed can't be made with the
existing situations. The two patches can land in either order.

Also note that I didn't carry any Tested-by / Reviewed-by tags since
the patch is now quite different.

[1] https://lore.kernel.org/r/20220510131309.v2.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid

Changes in v2:
- Don't modify drm_add_modes_noedid() 'cause that'll break others
- Set 640x480 as preferred in drm_helper_probe_single_connector_modes()

 drivers/gpu/drm/drm_probe_helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 682359512996..1fbb9a8c315c 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -516,8 +516,17 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		count = drm_add_override_edid_modes(connector);
 
 	if (count == 0 && (connector->status == connector_status_connected ||
-			   connector->status == connector_status_unknown))
+			   connector->status == connector_status_unknown)) {
 		count = drm_add_modes_noedid(connector, 1024, 768);
+
+		/*
+		 * Give userspace a hint that we don't have a lot of confidence
+		 * in these modes (we totally guessed) by marking 640x480 as
+		 * preferred. This is low clock rate and incredibly common as
+		 * a failsafe mode.
+		 */
+		drm_set_preferred_mode(connector, 640, 480);
+	}
 	count += drm_helper_probe_add_cmdline_mode(connector);
 	if (count == 0)
 		goto prune;
-- 
2.36.0.550.gb090851708-goog

