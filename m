Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298C54C7A52
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiB1U0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiB1U0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:26:38 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB04580DF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:25:59 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id c1so12516172pgk.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYJS0+baIpj8rNk1gxFjQtSNQLz0w5fW/GZ4P6Cva34=;
        b=NtBj2377xC9UwhgXdBGz78ZGGbAgv+utx1c/2FxM08P9KP+6cQCgHNSCuUa6K2g/ot
         wLF0mQ2Tzf0O/FdNrPPV8s8rvp7/x0FZBKLgJVqg2mi3PjsAQP1PqggPaJun9dTCOqau
         Tz+PbS0+pVtyzDyGcZHoOtWHeUVJzr9f3TuDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYJS0+baIpj8rNk1gxFjQtSNQLz0w5fW/GZ4P6Cva34=;
        b=Jg3P1ulfNTQoOep3XMSEiP1Jbou7Q5SCHMB1+gSaFy2cN1946kExk91/QgknFRjOL5
         9dvPJLXBdM6iQU8Z+HD+pRRWkMl+4ovjr1jXMiaQyJDJwnFnTVMIU+U5n2SpFOmXKtuY
         PuHUrybkgZGWVnsK+OEQMc9Zd0wSHmrn2wmargDHR750KwjM3/ljB0PRj7qsst16Cz4f
         Zbw5ZcfqTNNgfT6VX0N8fIHP7YEQKASm8HRLjOPYwcDgjPMdCdMLhvDRoNDR5SNPKsda
         XRXBwuL7dBIGxRjEWKFtOq47QIHH+S0mKBIXBgSFMwkYQ/aAsho/hCBL9TvLBHzfL0Qy
         8daQ==
X-Gm-Message-State: AOAM533v9Mj7wxkxwJpkMXNR/bleeLhSJCasCcKgeBkUiA49eXTa3Lry
        MwQnH/7dPPb4Vnu5ZDdKMikCig==
X-Google-Smtp-Source: ABdhPJzA2n4xckiPWFfvi2ErCa67YVQqABCW741BDbD621t4ro8ENXSJcL3UE0iJi9/RyWEl4pHfeA==
X-Received: by 2002:a63:1003:0:b0:378:7d70:2ec5 with SMTP id f3-20020a631003000000b003787d702ec5mr8779623pgl.351.1646079958576;
        Mon, 28 Feb 2022 12:25:58 -0800 (PST)
Received: from localhost ([2620:15c:202:201:ba66:7507:a6af:82f1])
        by smtp.gmail.com with UTF8SMTPSA id p10-20020a056a000b4a00b004e12fd48035sm14633629pfo.96.2022.02.28.12.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:25:58 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Liu Ying <victor.liu@oss.nxp.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] drm/atomic: Force bridge self-refresh-exit on CRTC switch
Date:   Mon, 28 Feb 2022 12:25:32 -0800
Message-Id: <20220228122522.v2.2.Ic15a2ef69c540aee8732703103e2cff51fb9c399@changeid>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
In-Reply-To: <20220228202532.869740-1-briannorris@chromium.org>
References: <20220228202532.869740-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Change in v2:

- Drop "->enable" condition; this could possibly be "->active" to
  reflect the intended hardware state, but it also is a little
  over-specific. We want to make a transition through "disabled" any
  time we're exiting PSR at the same time as a CRTC switch.
  (Thanks Liu Ying)

Cc: Liu Ying <victor.liu@oss.nxp.com>
Cc: <stable@vger.kernel.org>
Fixes: 1452c25b0e60 ("drm: Add helpers to kick off self refresh mode in drivers")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9603193d2fa1..987e4b212e9f 100644
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
+	if (old_state->self_refresh_active &&
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
2.35.1.574.g5d30c73bfb-goog

