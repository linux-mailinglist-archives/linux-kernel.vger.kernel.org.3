Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395A8520849
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiEIXWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiEIXW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:22:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B051327
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:18:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so594054pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 16:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3MsMPfbPAtt+LUx5QQOJPDQW/jqUKRczHTmbnCnNlo=;
        b=Lo3FcdLeWFTsfpLIEtHet1p83g9yEAUTRFUUlVA9jNybAnhR0ACD66qvwx/Sni7Xvr
         KOJFXQJJ8qK8OXYOYI4LF9vvQDnot8Nf0A1g/XQ2GznnKufeBlILgR3GcQlp7RGJ0Ebk
         clgZZ1EnekJLzRptH/+bl1z/QggljRTkX5di4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3MsMPfbPAtt+LUx5QQOJPDQW/jqUKRczHTmbnCnNlo=;
        b=YRBqtU7d1OhO2Ch6qyPKGkcwfHNTngAmztMIMw6Hop/TQzgLbJ0ajXv+y6oKhf3u8J
         5TSvXd3Kty0eGuhq324wjS78cdGmgFMeQ1ZoCMHlgUAJ7zezTUNxGfTVhzZ7+w8KYzvp
         TH2adDX/uOCMUWi2l6cGhOtwV/B93eOhij+q8zaeD0ptlFAwMfMbqANVRYqO4G1dwmuK
         BJQBe6Uv966dsFPAlhfRvYd9TKm3Div8aTZEGrw6HtSnHNnbnqexo7jbdUwZkBuCsKtN
         DfPS57FD3JZBOS5KOSFgW6cxa4k89O3xVuhdW9IuTFOWmAd/HY4jmThZHRtrTcMoWeJX
         81NA==
X-Gm-Message-State: AOAM531RsQCzHGbeAYwMGPjQUeN9V+zaPf6/HyaMNRX1Gkx3Ua8EDTi7
        sNIaARX4z6pPk4OYgVhT7G9eQg==
X-Google-Smtp-Source: ABdhPJwQCABxWhyzWje58moI3QY+RTSGkK5L/8OY0DPvxKxKjVGkEKQ2u55xzo2aEXZeNm94nOeQKw==
X-Received: by 2002:a17:902:f708:b0:153:839f:bf2c with SMTP id h8-20020a170902f70800b00153839fbf2cmr18252580plo.113.1652138313471;
        Mon, 09 May 2022 16:18:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:e0c:1ed:8d0b:2894])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902edcd00b0015ed003552fsm371045plk.293.2022.05.09.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 16:18:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-msm@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: Document the power requirements for DP AUX transfers
Date:   Mon,  9 May 2022 16:18:09 -0700
Message-Id: <20220509161733.v2.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing DP AUX transfers there are two actors that need to be
powered in order for the DP AUX transfer to work: the DP source and
the DP sink. Commit bacbab58f09d ("drm: Mention the power state
requirement on side-channel operations") added some documentation
saying that the DP source is required to power itself up (if needed)
to do AUX transfers. However, that commit doesn't talk anything about
the DP sink.

For full fledged DP the sink isn't really a problem. It's expected
that if an external DP monitor isn't plugged in that attempting to do
AUX transfers won't work. It's also expected that if a DP monitor is
plugged in (and thus asserting HPD) then AUX transfers will work.

When we're looking at eDP, however, things are less obvious. Let's add
some documentation about expectations. Here's what we'll say:

1. We don't expect the DP AUX transfer function to power on an eDP
panel. If an eDP panel is physically connected but powered off then it
makes sense for the transfer to fail.

2. We'll document that the official way to power on a panel is via the
bridge chain, specifically by making sure that the panel's prepare
function has been called (which is called by
panel_bridge_pre_enable()). It's already specified in the kernel doc
of drm_panel_prepare() that this is the way to power the panel on and
also that after this call "it is possible to communicate with any
integrated circuitry via a command bus."

3. We'll also document that for code running in the panel driver
itself that it is legal for the panel driver to power itself up
however it wants (it doesn't need to officially call
drm_panel_pre_enable()) and then it can do AUX bus transfers. This is
currently the way that edp-panel works when it's running atop the DP
AUX bus.

NOTE: there was much discussion of all of this in response to v1 [1]
of this patch. A summary of that is:
* With the Intel i195 driver, apparently eDP panels do get powered
  up. We won't forbid this but it is expected that code that wants to
  run on a variety of platforms should ensure that the drm_panel's
  prepare() function has been called.
* There is at least a reasonable amount of agreement that the
  transfer() functions itself shouldn't be responsible for powering
  the panel. It's proposed that if we need the DP AUX dev nodes to be
  robust for eDP that the code handling the DP AUX dev nodes could
  handle powering the panel by ensuring that the panel's prepare()
  call was made. Potentially drm_dp_aux_dev_get_by_minor() could be a
  good place to do this. This is left as a future exercise. Until
  that's fixed the DP AUX dev nodes for eDP are probably best just
  used for debugging.
* If a panel could be in PSR and DP AUX via the dev node needs to be
  reliable then we need to be able to pull the panel out of PSR. On
  i915 this is also apparently handled as part of the transfer()
  function.

[1] https://lore.kernel.org/r/20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
Hopefully I've resolved everything here to everyone's
satisfaction. There's no crazy hurry here. I'll give this a week or so
and then land it on drm-misc if there is no additional discussion.

Changes in v2:
- Updated wording as per discussion on v1.
- Updated commit message as per discussion on v1.
- Add pointer to v1 discussion for future reference.

 include/drm/display/drm_dp_helper.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index dca40a045dd6..dc3c02225fcf 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -370,9 +370,19 @@ struct drm_dp_aux {
 	 * helpers assume this is the case.
 	 *
 	 * Also note that this callback can be called no matter the
-	 * state @dev is in. Drivers that need that device to be powered
-	 * to perform this operation will first need to make sure it's
-	 * been properly enabled.
+	 * state @dev is in and also no matter what state the panel is
+	 * in. It's expected:
+	 * - If the @dev providing the AUX bus is currently unpowered then
+	 *   it will power itself up for the transfer.
+	 * - If we're on eDP (using a drm_panel) and the panel is not in a
+	 *   state where it can respond (it's not powered or it's in a
+	 *   low power state) then this function may return an error, but
+	 *   not crash. It's up to the caller of this code to make sure that
+	 *   the panel is powered on if getting an error back is not OK. If a
+	 *   drm_panel driver is initiating a DP AUX transfer it may power
+	 *   itself up however it wants. All other code should ensure that
+	 *   the pre_enable() bridge chain (which eventually calls the
+	 *   drm_panel prepare function) has powered the panel.
 	 */
 	ssize_t (*transfer)(struct drm_dp_aux *aux,
 			    struct drm_dp_aux_msg *msg);
-- 
2.36.0.512.ge40c2bad7a-goog

