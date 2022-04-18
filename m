Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E804505D34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiDRRBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbiDRRBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:01:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F128528A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:58:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bx5so13455696pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CC9jkjjrl6o9e+m2QrQyEFgI0n/S9yVQ8H3riU8oA9o=;
        b=Iau0mJqjglK3h0t7SvYSqp8QbKm1ztccvyDYYCkGRp1Gg2143E8UHix/S4JXpHIWoG
         aq5ZJOv2CUXljCg0Mkrv4S83zRDopc5d90yk1EeUX/wPSZcF54Sm3l1RQCKgEgT/F736
         gxq+Why9Hajy2zn0MMbZMdqabTgKFyIcCKsXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CC9jkjjrl6o9e+m2QrQyEFgI0n/S9yVQ8H3riU8oA9o=;
        b=6TC7HJArcIe+9Q52cihB9QJ+EHy53InzrBDvCp+njHIDnULKz2SZBYF9qDIwyh+kah
         RqJPlH9PXEIyEkEW0bdIdp3SEv2i6LRCHgR5Mat6AC2LsF3FkB7WIoJi4q708zEDVgIA
         naw3Jxf5inor+vwXvgNStbwg9B7tSL5qOj8iW/2pbgkuWASh2dyltDIB0Ao36HWO2lsv
         3ytvsuncWWbALl0n+6FfEZxVwTvzxltmWx5155XS2UBhKfDzutmHgP7XTYuxCeqt0XKc
         JwKPMpvt3KG23RYS6jcqif6D4T0/7oL7vWJ3o1YQU/NVujAOGi5LFFOlN7FJ14SOVF8G
         FKbQ==
X-Gm-Message-State: AOAM533dAf+X6lKJxM55uszwszy3X9ul/7PkdPSZB4BUv7VoYE5ju9d/
        mHJnz583mrkw76o+byd1wkZKig==
X-Google-Smtp-Source: ABdhPJxMrpFLO1E/CkQC+viUKJbZKgLwOm1B4sMWpkvC80G70lohY/cBOdd8j8PgCo/0uJ7i+KBbvQ==
X-Received: by 2002:a17:90b:4d0a:b0:1d1:7bd:cb00 with SMTP id mw10-20020a17090b4d0a00b001d107bdcb00mr17354367pjb.242.1650301116542;
        Mon, 18 Apr 2022 09:58:36 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:94f4:f90:c59f:129b])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a150800b001cbaf536a3esm17700980pja.18.2022.04.18.09.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:58:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] drm/panel-edp: Take advantage of wait_hpd_asserted() in struct drm_dp_aux
Date:   Mon, 18 Apr 2022 09:56:40 -0700
Message-Id: <20220418095557.v2.2.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418165642.2218514-1-dianders@chromium.org>
References: <20220418165642.2218514-1-dianders@chromium.org>
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

Let's add support for being able to read the HPD pin even if it's
hooked directly to the controller. This will allow us to get more
accurate delays also lets us take away the waiting in the AUX transfer
functions of the eDP controller drivers.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Change is_hpd_asserted() to wait_hpd_asserted()

 drivers/gpu/drm/panel/panel-edp.c | 33 +++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 1732b4f56e38..086e0bf52fb9 100644
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
2.36.0.rc0.470.gd361397f0d-goog

