Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18C854BD16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357947AbiFNVyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352995AbiFNVym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:54:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEB42251F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:54:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so297187pjm.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwX0A/0Dxcjuy9zRSFxAY+0IKc5Dbas55VbNobVwPJc=;
        b=CSv9NkEHHzkwLhmuXSgOOHqRPc31dwtBa3/7oUsRLH0ubS19jeVHMW6b5KZcE6XzBA
         FeCH7ES5/xJCaRRVyr9usmVB1jKYuKfsYiZLWsWFLGRNR/Mot8qZEIm4Z6uvbIqvfk6+
         15XBa1ozkpPIxqYJJUSfgJX449FeHmFTesIS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwX0A/0Dxcjuy9zRSFxAY+0IKc5Dbas55VbNobVwPJc=;
        b=1HnBvfSp674pcZOBVPtK2UJDpKXbnpFTOxdAoNlpyijEkAyQkuKESBt5XjR9VJsHmm
         ziTTKzlZfy/mGTy+BzNxO4Yq/58UYPHfgkP/pzxxEqQDlUUgH2jkSRzFbmau1qkNCNom
         DawPHntIIc6aWKUAtNPWeDb6yFe0MpDlJQgvhUAN7KaVPuYdpq77/3ueBkwfHvz2CrD2
         kVqgJFRIUFcOyUw4R75GOvqJxvQV2JJQyv8DC10bvZU8f/38GPSEFE5KdrzPPUXRg826
         oeN4ZOBWu9KfDlyQFP6Uvxh5nUIHn1/Ap9hoeua2p9n86HeLuqqhyTUAFf5rHHZHUbQC
         8oXQ==
X-Gm-Message-State: AJIora9HoQzJXFm7d50YToezeM5YxpHSDQ3uTAUqAMdeaXOoMBFDS1wo
        WkQh24baLDMxCDDvk7/iwzP/sA==
X-Google-Smtp-Source: AGRyM1tHNbZg3tUer/X0adYqmmmBkipXJYdJHb+DnbzGyZ3+LncrF6Fbyslgnj8PvfBaB3VMuzImyQ==
X-Received: by 2002:a17:90a:4503:b0:1ea:4718:829f with SMTP id u3-20020a17090a450300b001ea4718829fmr6431527pjg.103.1655243681464;
        Tue, 14 Jun 2022 14:54:41 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f355:be2d:74b7:3c7c])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b0016641a646cbsm7668968pli.218.2022.06.14.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:54:41 -0700 (PDT)
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
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] drm/panel-edp: Take advantage of wait_hpd_asserted() in struct drm_dp_aux
Date:   Tue, 14 Jun 2022 14:54:16 -0700
Message-Id: <20220614145327.v4.2.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid>
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

Let's add support for being able to read the HPD pin even if it's
hooked directly to the controller. This will allow us to get more
accurate delays also lets us take away the waiting in the AUX transfer
functions of the eDP controller drivers.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

(no changes since v2)

Changes in v2:
- Change is_hpd_asserted() to wait_hpd_asserted()

 drivers/gpu/drm/panel/panel-edp.c | 33 +++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index c96014464355..ce5821132151 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -417,6 +417,11 @@ static int panel_edp_get_hpd_gpio(struct device *dev, struct panel_edp *p)
 	return 0;
 }
 
+static bool panel_edp_can_read_hpd(struct panel_edp *p)
+{
+	return !p->no_hpd && (p->hpd_gpio || (p->aux && p->aux->wait_hpd_asserted));
+}
+
 static int panel_edp_prepare_once(struct panel_edp *p)
 {
 	struct device *dev = p->base.dev;
@@ -441,17 +446,21 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 	if (delay)
 		msleep(delay);
 
-	if (p->hpd_gpio) {
+	if (panel_edp_can_read_hpd(p)) {
 		if (p->desc->delay.hpd_absent)
 			hpd_wait_us = p->desc->delay.hpd_absent * 1000UL;
 		else
 			hpd_wait_us = 2000000;
 
-		err = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
-					 hpd_asserted, hpd_asserted,
-					 1000, hpd_wait_us);
-		if (hpd_asserted < 0)
-			err = hpd_asserted;
+		if (p->hpd_gpio) {
+			err = readx_poll_timeout(gpiod_get_value_cansleep,
+						 p->hpd_gpio, hpd_asserted,
+						 hpd_asserted, 1000, hpd_wait_us);
+			if (hpd_asserted < 0)
+				err = hpd_asserted;
+		} else {
+			err = p->aux->wait_hpd_asserted(p->aux, hpd_wait_us);
+		}
 
 		if (err) {
 			if (err != -ETIMEDOUT)
@@ -532,18 +541,22 @@ static int panel_edp_enable(struct drm_panel *panel)
 	/*
 	 * If there is a "prepare_to_enable" delay then that's supposed to be
 	 * the delay from HPD going high until we can turn the backlight on.
-	 * However, we can only count this if HPD is handled by the panel
-	 * driver, not if it goes to a dedicated pin on the controller.
+	 * However, we can only count this if HPD is readable by the panel
+	 * driver.
+	 *
 	 * If we aren't handling the HPD pin ourselves then the best we
 	 * can do is assume that HPD went high immediately before we were
-	 * called (and link training took zero time).
+	 * called (and link training took zero time). Note that "no-hpd"
+	 * actually counts as handling HPD ourselves since we're doing the
+	 * worst case delay (in prepare) ourselves.
 	 *
 	 * NOTE: if we ever end up in this "if" statement then we're
 	 * guaranteed that the panel_edp_wait() call below will do no delay.
 	 * It already handles that case, though, so we don't need any special
 	 * code for it.
 	 */
-	if (p->desc->delay.prepare_to_enable && !p->hpd_gpio && !p->no_hpd)
+	if (p->desc->delay.prepare_to_enable &&
+	    !panel_edp_can_read_hpd(p) && !p->no_hpd)
 		delay = max(delay, p->desc->delay.prepare_to_enable);
 
 	if (delay)
-- 
2.36.1.476.g0c4daa206d-goog

