Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6664FA1C5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbiDICje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbiDICjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:39:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF7C4E30
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:37:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so13461512pjn.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 19:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0vkhOKP2WO4l+2v+2Aab0a42a4DeGq9/d4Qga0dGC0=;
        b=hThmm8Tk9cX40rfcqSsr2lGFlhGgxb2P8Eetaye5fzRTF/IFvfQeF1jvqlMQZgfHUQ
         SrTeTmXH5D3Gj21g9TkpAnQhB+IQn+V46EgcKgNjb4t/g01DIAFFOW7mb0jVTMq2IfXG
         ykMvJusi6OBpqfOLef7rb1cFe2KYgZ0Zl7Frw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0vkhOKP2WO4l+2v+2Aab0a42a4DeGq9/d4Qga0dGC0=;
        b=8DJKray6KXjuHjvRg/RQRcoR70QlsPLnsHYbMTeMVcV+3utAaKMN+/UrY3ngPHOW7M
         tuQd5QUplVNYQybErI0fk5r8LdWV8VthwPznTgCXQTjNtIpSJ1e0bOXS4R0R9SGyeRbH
         r8EWwIgMOLMepSeuM9uHp7tnmiU3j8EdULUFWaXc3eg2O8EoSuN8l0BtM0kkmA6kZ/FS
         UeOvWXSxozYYsinxeZbD+GJqhZBva0Rk4d6TA8mJ3TC5fwLm/OgyvQ1pIEZ/COHBJGi5
         CKEKoiFfdz1Az28JoS4XNIhmnax9kuEVH0lFLX5MnApoQrTZFWpYR1PYIoxXf8EUjlby
         7Ktw==
X-Gm-Message-State: AOAM531HlFFI7jbNAhL1ElIZXAtQdYuxRT218aL/FBcWKLZVZM4j6hgR
        E6JLGlMl8SttYNGE8y66VHXISw==
X-Google-Smtp-Source: ABdhPJxKvoKVhufhkWMurahdK3NmXOgJqw5lH1XIAJAyg/5vhbrKM2A8tweygpDFe/vJs9KLnxJWtw==
X-Received: by 2002:a17:902:e74a:b0:153:f956:1cf5 with SMTP id p10-20020a170902e74a00b00153f9561cf5mr21563664plf.138.1649471832923;
        Fri, 08 Apr 2022 19:37:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:17db:64e:48d4:a4e])
        by smtp.gmail.com with ESMTPSA id 188-20020a6215c5000000b0050597294893sm759999pfv.124.2022.04.08.19.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 19:37:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/6] drm/panel: atna33xc20: Take advantage of is_hpd_asserted() in struct drm_dp_aux
Date:   Fri,  8 Apr 2022 19:36:27 -0700
Message-Id: <20220408193536.RFC.5.I9ee239f6b95b944c8fa030f300ad222a7af9899d@changeid>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
In-Reply-To: <20220409023628.2104952-1-dianders@chromium.org>
References: <20220409023628.2104952-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add support for being able to read the HPD pin even if it's
hooked directly to the controller. This will let us take away the
waiting in the AUX transfer functions of the eDP controller drivers.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 35 +++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 20666b6217e7..f72bdd7ff7a1 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -30,6 +30,7 @@ struct atana33xc20_panel {
 
 	struct regulator *supply;
 	struct gpio_desc *el_on3_gpio;
+	struct drm_dp_aux *aux;
 
 	struct edid *edid;
 
@@ -76,6 +77,19 @@ static int atana33xc20_suspend(struct device *dev)
 	return 0;
 }
 
+static bool atana33xc20_can_read_hpd(struct atana33xc20_panel *p)
+{
+	return !p->no_hpd && (p->hpd_gpio || p->aux->is_hpd_asserted);
+}
+
+static bool panel_edp_read_hpd(struct atana33xc20_panel *p)
+{
+	if (p->hpd_gpio)
+		return gpiod_get_value_cansleep(p->hpd_gpio);
+
+	return p->aux->is_hpd_asserted(p->aux);
+}
+
 static int atana33xc20_resume(struct device *dev)
 {
 	struct atana33xc20_panel *p = dev_get_drvdata(dev);
@@ -92,17 +106,24 @@ static int atana33xc20_resume(struct device *dev)
 
 	/*
 	 * Handle HPD. Note: if HPD is hooked up to a dedicated pin on the
-	 * eDP controller then "no_hpd" will be false _and_ "hpd_gpio" will be
-	 * NULL. It's up to the controller driver to wait for HPD after
-	 * preparing the panel in that case.
+	 * eDP controller then it's possible that "no_hpd" will be false _and_
+	 * atana33xc20_can_read_hpd() will return false. It's up to the
+	 * controller driver to wait for HPD after preparing the panel in that
+	 * case.
 	 */
 	if (p->no_hpd) {
 		/* T3 VCC to HPD high is max 200 ms */
 		msleep(200);
-	} else if (p->hpd_gpio) {
-		ret = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
+	} else if (atana33xc20_can_read_hpd(p)) {
+		/*
+		 * Even though max HPD is 200 ms, we give an extra long timeout
+		 * of 500 ms here. Why? ps8640 is crazy and the bridge chip
+		 * driver itself has over 200 ms of delay if it needs to
+		 * do the pm_runtime resume of the bridge chip to read the HPD.
+		 */
+		ret = readx_poll_timeout(panel_edp_read_hpd, p,
 					 hpd_asserted, hpd_asserted,
-					 1000, 200000);
+					 1000, 500000);
 		if (!hpd_asserted)
 			dev_warn(dev, "Timeout waiting for HPD\n");
 	}
@@ -263,6 +284,8 @@ static int atana33xc20_probe(struct dp_aux_ep_device *aux_ep)
 		return -ENOMEM;
 	dev_set_drvdata(dev, panel);
 
+	panel->aux = aux_ep->aux;
+
 	panel->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(panel->supply))
 		return dev_err_probe(dev, PTR_ERR(panel->supply),
-- 
2.35.1.1178.g4f1659d476-goog

