Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE3854BD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357359AbiFNVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbiFNVyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:54:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE5255B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:54:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d13so8819032plh.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65Y41kdawwG1n+2uI4rvZLnKQNlAIFaOOfNmllqQLv8=;
        b=EdN0uGZ3OZRMm5vATmxr2x7Q5Cqn1/DD3mCxrzY/7OzjM2t7U4pHdEYKoigjkl//R6
         6KHpMtFP09kwukqqwTCO+MB0yRbh6qqhSZDR3PUAKoMnDXxjd/G04PPSJ9tJa6HHQOHE
         Fps7YmaMWDzhf+p0hG/bCMP/LfAC/qOt3cNeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65Y41kdawwG1n+2uI4rvZLnKQNlAIFaOOfNmllqQLv8=;
        b=gB7XPL0US5+MXJxcAsN9c+nHzAk0a5MLoErsUUD3XIy4Lnsvh5bXlJZph3x0bSJcl8
         yOdJOt0U3Pgy2jJyHP3Dp9OcikvUwLXLuMAweX0S3mVIWnjrd3k8ZpkK39T2WH7bYTvT
         bhAFCjvtWAPZXLmiiLXHmx/0Yfh/cNZ1hOmuFkkNUBy/CAyN5u9AW7dp5H6/5S4n5R8b
         4hh9yO9T3DRJmkULvNMjNKs+nBcUb5NzbTimNW/ViAChrYJs/VgHX1qM8yN3zTKbyNKU
         ZyyIoEDjBnZOn5P16Fm2qcfK+ahRYP+a0BZx4EBMi2wg2fapBkHAsYoxQ8JNq5F0uaVy
         tAwg==
X-Gm-Message-State: AJIora+Tk3T6sYXXp5Nis6yNOteXQ6H8jAwU2+ggz90qh7clcdCp73BQ
        eqUEakRXDaKQE3sGpDgRIUN/sA==
X-Google-Smtp-Source: AGRyM1uthElZF57fyUFL/+OiAZrcfH8RH/6cIit8YmMun/0EwOG0PbFroYO/GhXjJ2LU/4JIZrnS/w==
X-Received: by 2002:a17:902:ec84:b0:167:6f74:ba76 with SMTP id x4-20020a170902ec8400b001676f74ba76mr6121089plg.17.1655243680141;
        Tue, 14 Jun 2022 14:54:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f355:be2d:74b7:3c7c])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b0016641a646cbsm7668968pli.218.2022.06.14.14.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:54:39 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] drm/dp: Add wait_hpd_asserted() callback to struct drm_dp_aux
Date:   Tue, 14 Jun 2022 14:54:15 -0700
Message-Id: <20220614145327.v4.1.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614215418.910948-1-dianders@chromium.org>
References: <20220614215418.910948-1-dianders@chromium.org>
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

Sometimes it's useful for users of the DP AUX bus (like panels) to be
able to poll HPD. Let's add a callback that allows DP AUX busses
drivers to provide this.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

Changes in v4:
- Comments now explain that we may wait longer due to debouncing.
- Rebased to handle the fact that the stuct moved files.

Changes in v2:
- Change is_hpd_asserted() to wait_hpd_asserted()

 include/drm/display/drm_dp_helper.h | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index c5f8f45511ed..db0fe9f8a612 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -389,6 +389,36 @@ struct drm_dp_aux {
 	ssize_t (*transfer)(struct drm_dp_aux *aux,
 			    struct drm_dp_aux_msg *msg);
 
+	/**
+	 * @wait_hpd_asserted: wait for HPD to be asserted
+	 *
+	 * This is mainly useful for eDP panels drivers to wait for an eDP
+	 * panel to finish powering on. This is an optional function.
+	 *
+	 * This function will efficiently wait for the HPD signal to be
+	 * asserted. The `wait_us` parameter that is passed in says that we
+	 * know that the HPD signal is expected to be asserted within `wait_us`
+	 * microseconds. This function could wait for longer than `wait_us` if
+	 * the logic in the DP controller has a long debouncing time. The
+	 * important thing is that if this function returns success that the
+	 * DP controller is ready to send AUX transactions.
+	 *
+	 * This function returns 0 if HPD was asserted or -ETIMEDOUT if time
+	 * expired and HPD wasn't asserted. This function should not print
+	 * timeout errors to the log.
+	 *
+	 * The semantics of this function are designed to match the
+	 * readx_poll_timeout() function. That means a `wait_us` of 0 means
+	 * to wait forever. Like readx_poll_timeout(), this function may sleep.
+	 *
+	 * NOTE: this function specifically reports the state of the HPD pin
+	 * that's associated with the DP AUX channel. This is different from
+	 * the HPD concept in much of the rest of DRM which is more about
+	 * physical presence of a display. For eDP, for instance, a display is
+	 * assumed always present even if the HPD pin is deasserted.
+	 */
+	int (*wait_hpd_asserted)(struct drm_dp_aux *aux, unsigned long wait_us);
+
 	/**
 	 * @i2c_nack_count: Counts I2C NACKs, used for DP validation.
 	 */
-- 
2.36.1.476.g0c4daa206d-goog

