Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0657C052
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiGTWzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiGTWze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:55:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A25DFC3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:55:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d10so74825pfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSlwSpM/RFiBLpdzeATmea7o0OG6kZ7GYHU5wp1rngY=;
        b=gB4GPXG4iY+V2+bioCq4/os5vYlp3ZjPzZK8+UYaGDJI75zmFqrY8MXRZoUO52IoF4
         2l5c/FH66IiCAXvRB4/Z61r4FW1TrTdETWgIkD9QgRl6FFAmIY1wSpJRFDp9xXFZINmr
         dvuDCobmfEJvMqoz7pUTETNu3Hz4LccHuaIL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSlwSpM/RFiBLpdzeATmea7o0OG6kZ7GYHU5wp1rngY=;
        b=d6eZgPyfzueZ8XIZcpSF5OSj02mZL64LsPgOSaKYoXDGGULBjQep/u2MoGGPMlg74s
         Xgsh9J/44X+msers1nafZFh7sLHLk9kEj3a0lr873VCbQORaZCFvf9Xeytow7P5gF1qd
         nvbUNdjGKvh5vGxSb4N+vja3lLilQ36h09NQlE2viXKiays7MkbGVw8ARY0pNjxmvoNp
         CK5pKMXdXmFFAprWvt+KDTuMv7iUEYLG48I+8ONIm0WNbSlGjPsvhBFWAI0D5hGZh0d+
         CyZApzY62DeemTRdDzYC1NHiUJFc7oHMeyjXCJSSeO+Q3CbD/AtVKBNu4xAH1/HUNLig
         ZS3w==
X-Gm-Message-State: AJIora+sbY+mtRheswtqOWwjDQMEnWKgmvLrYufXgkJlUWHWUd0g0bF7
        GsyFV/vom33NxPGD5ogmN40pCg==
X-Google-Smtp-Source: AGRyM1sXQSL9d0r50j0Fqiq/8+L8y7tx1Be20r1+RbJnQehSYo8iJQXgj/fXzMF2++YnAsLP5XpV2A==
X-Received: by 2002:a05:6a00:e85:b0:52b:5db8:f3df with SMTP id bo5-20020a056a000e8500b0052b5db8f3dfmr22842365pfb.14.1658357733349;
        Wed, 20 Jul 2022 15:55:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:fdb4:f565:8767:5019])
        by smtp.gmail.com with ESMTPSA id b17-20020a170903229100b0016bef6f6903sm94624plh.72.2022.07.20.15.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:55:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     ville.syrjala@linux.intel.com, sam@ravnborg.org,
        robdclark@gmail.com, linus.walleij@linaro.org,
        thierry.reding@gmail.com, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] drm/panel-edp: Allow overriding the eDP EDID
Date:   Wed, 20 Jul 2022 15:55:00 -0700
Message-Id: <20220720155445.RFC.1.I2999ac2d08643f0c2f3fe916cca86f8c832c8142@changeid>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that writing to `/sys/kernel/debug/dri/*/eDP*/edid_override`
wasn't working for me. I could see the new EDID take effect in
`/sys/class/drm/card*-eDP*/edid` but userspace wasn't seeing it..

The problem was that panel-edp was caching the EDID that it read and
using that over and over again.

Let's change panel-edp to look at the EDID that's stored in the
connector. This is still a cache, which is important since this
function is called multiple times and readin the EDID is slow, but
this property is automatically updated by drm_get_edid() (which reads
the EDID) and also updated when writing the edid_override in debugfs.

Fixes: 63358e24ee79 ("drm/panel: panel-simple: Cache the EDID as long as we retain power")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3626469c4cc2..12241c1e32f7 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -226,8 +226,6 @@ struct panel_edp {
 
 	const struct edp_panel_entry *detected_panel;
 
-	struct edid *edid;
-
 	struct drm_display_mode override_mode;
 
 	enum drm_panel_orientation orientation;
@@ -580,11 +578,19 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 	if (p->ddc) {
 		pm_runtime_get_sync(panel->dev);
 
-		if (!p->edid)
-			p->edid = drm_get_edid(connector, p->ddc);
+		if (!connector->edid_blob_ptr) {
+			/*
+			 * We read the EDID and then immediately free it,
+			 * relying on the side effect of drm_get_edid() to store
+			 * a copy in connector->edid_blob_ptr. We always use
+			 * the copy cached in the connector since that allows
+			 * the edid_override to work.
+			 */
+			kfree(drm_get_edid(connector, p->ddc));
+		}
 
-		if (p->edid)
-			num += drm_add_edid_modes(connector, p->edid);
+		if (connector->edid_blob_ptr)
+			num += drm_add_edid_modes(connector, connector->edid_blob_ptr->data);
 
 		pm_runtime_mark_last_busy(panel->dev);
 		pm_runtime_put_autosuspend(panel->dev);
@@ -926,9 +932,6 @@ static int panel_edp_remove(struct device *dev)
 	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
 		put_device(&panel->ddc->dev);
 
-	kfree(panel->edid);
-	panel->edid = NULL;
-
 	return 0;
 }
 
-- 
2.37.0.170.g444d1eabd0-goog

