Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9884A4B7B77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244913AbiBOXzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:55:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244902AbiBOXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:55:06 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235AEF65FE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:54:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v8-20020a17090a634800b001bb78857ccdso2550056pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XCMuYxh+2di03JYmyV8dujrYzv3SXhYvMBvZiel5/fo=;
        b=ccxhsBMFOCVfhgnoeerlnPe9CGG4uxGXLAYEhClhIyCP3tNpTcHx/x+JN4ucRCwQL2
         WqY6MYRiz8wL1xuFwwtTVnDt4SsyShQuW1OnmDwEiIOaAiSnJKUYtZyf5HqPE0WTprMn
         +7Llc0763f37U4Tbbu48tie2OA6UAMwycMI/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCMuYxh+2di03JYmyV8dujrYzv3SXhYvMBvZiel5/fo=;
        b=kS/dOkSMPXJvnYrtaU3kkYBxuuEyE7wPSyGHnt7IL/yITxwOkA4ISScWkJGLrYC/uu
         BYPfii2jFI9Cl1UtMqqIv2aSzoMgy/uKmb5Hd+e+ppDO0TX0Ov0kZjO3LkqNqt12lYIi
         3RreBdYo1A2wjql4ZVpajRZkk83ISLHBPCp2wZjqrgJRJmyu3XKfsAv6swQ0LA9OPAdS
         1gfKUSP8pZvzUsBaz46qTI3R1vs8avO3Cjwl7V+bdBIfqzGGz5E4NDjG0UEap8LVUGOJ
         AiEpmg5Ma1Tund1jg1VRIBpk8gxw2l0ArJVjg4LFy+V5pVUKHL0KJz8OgXpxtrJYXWpM
         9Hyg==
X-Gm-Message-State: AOAM533EipWg0yBetcO9o+sEijKHWnKZFeEd/FtpCHmci+mkFIxpnaYq
        +9dG7Ri/9NkGZRY9E9izOpbBLg==
X-Google-Smtp-Source: ABdhPJx6l/DF/88bJJ5I6OrdrZ57LWHcn7N2oIe+IhY40ktSvgddR6j7CB8zOcFwdg0ZCwoVNOcHcQ==
X-Received: by 2002:a17:90b:4a02:b0:1b8:d3c7:7a2b with SMTP id kk2-20020a17090b4a0200b001b8d3c77a2bmr7163388pjb.194.1644969295688;
        Tue, 15 Feb 2022 15:54:55 -0800 (PST)
Received: from localhost ([2620:15c:202:201:97ca:4b5:7d22:b276])
        by smtp.gmail.com with UTF8SMTPSA id a12sm38166601pfv.18.2022.02.15.15.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 15:54:55 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
        Brian Norris <briannorris@chromium.org>, stable@vger.kernel.org
Subject: [PATCH 2/2] drm/atomic: Force bridge self-refresh-exit on CRTC switch
Date:   Tue, 15 Feb 2022 15:54:20 -0800
Message-Id: <20220215155417.2.Ic15a2ef69c540aee8732703103e2cff51fb9c399@changeid>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220215235420.1284208-1-briannorris@chromium.org>
References: <20220215235420.1284208-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to change which CRTC is in use for a given
connector/encoder/bridge while we're in self-refresh without fully
disabling the connector/encoder/bridge along the way. This can confuse
the bridge encoder/bridge, because
(a) it needs to track the SR state (trying to perform "active"
    operations while the panel is still in SR can be Bad(TM)); and
(b) it tracks the SR state via the CRTC state (and after the switch, the
    previous SR state is lost).

Thus, we need to either somehow carry the self-refresh state over to the
new CRTC, or else force an encoder/bridge self-refresh transition during
such a switch.

I choose the latter, so we disable the encoder (and exit PSR) before
attaching it to the new CRTC (where we can continue to assume a clean
(non-self-refresh) state).

This fixes PSR issues seen on Rockchip RK3399 systems with
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c.

Cc: <stable@vger.kernel.org>
Fixes: 1452c25b0e60 ("drm: Add helpers to kick off self refresh mode in drivers")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/drm_atomic_helper.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9603193d2fa1..74161d007894 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1011,9 +1011,19 @@ crtc_needs_disable(struct drm_crtc_state *old_state,
 		return drm_atomic_crtc_effectively_active(old_state);
 
 	/*
-	 * We need to run through the crtc_funcs->disable() function if the CRTC
-	 * is currently on, if it's transitioning to self refresh mode, or if
-	 * it's in self refresh mode and needs to be fully disabled.
+	 * We need to disable bridge(s) and CRTC if we're transitioning out of
+	 * self-refresh and changing CRTCs at the same time, because the
+	 * bridge tracks self-refresh status via CRTC state.
+	 */
+	if (old_state->self_refresh_active && new_state->enable &&
+	    old_state->crtc != new_state->crtc)
+		return true;
+
+	/*
+	 * We also need to run through the crtc_funcs->disable() function if
+	 * the CRTC is currently on, if it's transitioning to self refresh
+	 * mode, or if it's in self refresh mode and needs to be fully
+	 * disabled.
 	 */
 	return old_state->active ||
 	       (old_state->self_refresh_active && !new_state->active) ||
-- 
2.35.1.265.g69c8d7142f-goog

