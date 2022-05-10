Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8F852254F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiEJUOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiEJUOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:14:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953411ADA5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:14:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v11so112891pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EzCqYX0EcAnW/iCkUeOk0GkKHb4Fvl7h4vQ2bns/5yY=;
        b=VzIZvP9gugPrAqVQj0bxx18Ci/S+CaP2uu85Y+I5aOI77mqgMrm5dZNZjJp8NYjIOI
         1CmHD5JR7I0ggMm1UwplHAK5Yh91KeSFU/Z4fBj0Ond/7+hB6KsN09KHMrp6hm9Pl+GK
         eF5M/vQmR1H7M19aaM1tgKgkEeHjyyi2pjuIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EzCqYX0EcAnW/iCkUeOk0GkKHb4Fvl7h4vQ2bns/5yY=;
        b=gE+uRs8BwYpBd5QbpcksmijDxjkCzT46i2fQcvAYvc5hywFzKFacuAxLxMUMZZPRTp
         6PoA0N8D6wGXg3X/ltgpk3e9tLJSZxWY2bQhc+KBW+LlDU4I0p5BrbmhD4uv+DyK3Y99
         eV1GaEFLEIXSau2+8kXPNuFZRML1WC+z7vDpdE+rWpAcbEt4C5c2LUofNedn2vvJYDla
         L6txs/AhmDTlwRkcdlj8W1L5RCU/niwVRN7a3mxbv2zsFHXvC4Le6oHpUPvGdfGje0De
         CzWELaQybDQdyxKFAa49IObF9wZ02U2c+l8GQb/JnTG1vweIgH8YvToXZbOKw7hKqA7I
         pxTw==
X-Gm-Message-State: AOAM533+3doRVFpa/IyWePBUpRGnRr7gQI1UykSauaoGQoUCVj7+Lrjz
        IBEwJg3BEmcWFEWtDMjTRQv6jw==
X-Google-Smtp-Source: ABdhPJyTD+9hTeZ+4Lyf3CqPIny6pCSqUrlEzkAKzzbRIGD7qEh75gbouGsB+MWgDJmc/eEA7sTYYw==
X-Received: by 2002:a63:184c:0:b0:3c5:fd55:1e9e with SMTP id 12-20020a63184c000000b003c5fd551e9emr17872032pgy.315.1652213644106;
        Tue, 10 May 2022 13:14:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6f08:624c:c762:d238])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902704800b0015e8d4eb247sm26605plt.145.2022.05.10.13.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:14:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     quic_khsieh@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_sbillaka@quicinc.com, quic_aravindh@quicinc.com,
        freedreno@lists.freedesktop.org, ville.syrjala@linux.intel.com,
        quic_abhinavk@quicinc.com, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        tzimmermann@suse.de, Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/probe-helper: For DP, add 640x480 if all other modes are bad
Date:   Tue, 10 May 2022 13:13:34 -0700
Message-Id: <20220510131309.v2.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220510131309.v2.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
References: <20220510131309.v2.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
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

As per Displayport spec section 5.2.1.2 ("Video Timing Format") says
that all detachable sinks shall support 640x480 @60Hz as a fail safe
mode.

A DP compliance test expected us to utilize the above fact when all
modes it presented to the DP source were not achievable. It presented
only modes that would be achievable with more lanes and/or higher
speeds than we had available and expected that when we couldn't do
that then we'd fall back to 640x480 even though it didn't advertise
this size.

In order to pass the compliance test (and also support any users who
might fall into a similar situation with their display), we need to
add 640x480 into the list of modes. However, we don't want to add
640x480 all the time. Despite the fact that the DP spec says all sinks
_shall support_ 640x480, they're not guaranteed to support it
_well_. Continuing to read the spec you can see that the display is
not required to really treat 640x480 equal to all the other modes. It
doesn't need to scale or anything--just display the pixels somehow for
failsafe purposes. It should also be noted that it's not hard to find
a display hooked up via DisplayPort that _doesn't_ support 640x480 at
all. The HP ZR30w screen I'm sitting in front of has a native DP port
and doesn't work at 640x480. I also plugged in a tiny 800x480 HDMI
display via a DP to HDMI adapter and that screen definitely doesn't
support 640x480.

As a compromise solution, let's only add the 640x480 mode if:
* We're on DP.
* All other modes have been pruned.

This acknowledges that 640x480 might not be the best mode to use but,
since sinks are _supposed_ to support it, we will at least fall back
to it if there's nothing else.

Note that we _don't_ add higher resolution modes like 1024x768 in this
case. We only add those modes for a failed EDID read where we have no
idea what's going on. In the case where we've pruned all modes then
instead we only want 640x480 which is the only defined "Fail Safe"
resolution.

This patch originated in response to Kuogee Hsieh's patch [1].

[1] https://lore.kernel.org/r/1650671124-14030-1-git-send-email-quic_khsieh@quicinc.com

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

Changes in v2:
- Two underscores for __drm_helper_update_and_validate().
- Return err and use WARN_ON instead of returning a bool.

 drivers/gpu/drm/drm_probe_helper.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index ff3dd9a5da70..871b3d19a153 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -476,7 +476,6 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 	const struct drm_connector_helper_funcs *connector_funcs =
 		connector->helper_private;
 	int count = 0, ret;
-	bool verbose_prune = true;
 	enum drm_connector_status old_status;
 	struct drm_modeset_acquire_ctx ctx;
 
@@ -556,8 +555,8 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] disconnected\n",
 			connector->base.id, connector->name);
 		drm_connector_update_edid_property(connector, NULL);
-		verbose_prune = false;
-		goto prune;
+		drm_mode_prune_invalid(dev, &connector->modes, false);
+		goto exit;
 	}
 
 	count = (*connector_funcs->get_modes)(connector);
@@ -582,9 +581,28 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		WARN_ON(ret);
 	}
 
-prune:
-	drm_mode_prune_invalid(dev, &connector->modes, verbose_prune);
+	drm_mode_prune_invalid(dev, &connector->modes, true);
 
+	/*
+	 * Displayport spec section 5.2.1.2 ("Video Timing Format") says that
+	 * all detachable sinks shall support 640x480 @60Hz as a fail safe
+	 * mode. If all modes were pruned, perhaps because they need more
+	 * lanes or a higher pixel clock than available, at least try to add
+	 * in 640x480.
+	 */
+	if (list_empty(&connector->modes) &&
+	    connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
+		count = drm_add_modes_noedid(connector, 640, 480);
+		ret = __drm_helper_update_and_validate(connector, maxX, maxY, &ctx);
+		if (ret == -EDEADLK) {
+			drm_modeset_backoff(&ctx);
+			goto retry;
+		}
+		WARN_ON(ret);
+		drm_mode_prune_invalid(dev, &connector->modes, true);
+	}
+
+exit:
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-- 
2.36.0.550.gb090851708-goog

