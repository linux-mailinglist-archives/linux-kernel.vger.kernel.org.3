Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719C3505D32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbiDRRBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240655AbiDRRBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:01:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A71928D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:58:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so14586869pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1QFnxHD7U+Ao84z0nfTT0ExEc1/lOyohaOkN2UcR24=;
        b=CZbSmX/i5jES+5RWi+JOQsTJ2Htdbaoh7NlFmpocxP9XJuCHQj17CZXDzULn6D0fJG
         BXEBtnF6OUJcmQdxRkGDdkfYv2lUHKb2IGR8K4BpW7neWgAsyfcPK2xKLcEtZinPGwSy
         PnuNQocQ/bQF5MGtIvlphUKzBsHaJYDutd6TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1QFnxHD7U+Ao84z0nfTT0ExEc1/lOyohaOkN2UcR24=;
        b=JtJtT5oujD0VdJe1FHJdl3XJYV+h/xKn83bOLjlVOqkMr/LV3B0oG4k73HMCigVm7P
         rz23Ypd98+/7M1BJwKcgjXcIiv/mBBalFYVz5cRnajTJ4lzwxf5BHA92nCxafz5tKP2J
         8LiSSC8aPJ59RJtl/zFege2i8H7xZZgEAEUxv/fdXtUyc+sVBbebnaVKTeEz75RaXpDW
         0xv5IkMkMc6hV1+u58dTLTLdFwPUuq8y/WSv/O4LH4Slj+WkvdKVKFOOzY5M6noJBDUB
         fkypYzmtsJtBYkUbUAyI7xAwF2ZueWqv0yCs2b6A7FqdNyOU8kzkuF3KgTfD8JzswWMR
         I4qg==
X-Gm-Message-State: AOAM5329ct6akHYQweWk0+razp1Jh1Aif3OiP8CV3cE5+np0ZiXKheEg
        T9GrlEu4CVXzQKyaAZ42gaO1Ig==
X-Google-Smtp-Source: ABdhPJwLdYhma2u6XQc+ES5orztwhXRFtVhZ1lMWtpfsGvAB78t7vY39NXx+5ntfYDoatZnLspf7yw==
X-Received: by 2002:a17:90b:1891:b0:1d2:66e1:62b2 with SMTP id mn17-20020a17090b189100b001d266e162b2mr11793459pjb.56.1650301118033;
        Mon, 18 Apr 2022 09:58:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:94f4:f90:c59f:129b])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a150800b001cbaf536a3esm17700980pja.18.2022.04.18.09.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:58:37 -0700 (PDT)
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
Subject: [PATCH v2 3/4] drm/panel: atna33xc20: Take advantage of wait_hpd_asserted() in struct drm_dp_aux
Date:   Mon, 18 Apr 2022 09:56:41 -0700
Message-Id: <20220418095557.v2.3.I9ee239f6b95b944c8fa030f300ad222a7af9899d@changeid>
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
hooked directly to the controller. This will let us take away the
waiting in the AUX transfer functions of the eDP controller drivers.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Change is_hpd_asserted() to wait_hpd_asserted()

 .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 38 ++++++++++++-------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 20666b6217e7..7f9af3e9aeb8 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -19,6 +19,10 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_panel.h>
 
+/* T3 VCC to HPD high is max 200 ms */
+#define HPD_MAX_MS	200
+#define HPD_MAX_US	(HPD_MAX_MS * 1000)
+
 struct atana33xc20_panel {
 	struct drm_panel base;
 	bool prepared;
@@ -30,6 +34,7 @@ struct atana33xc20_panel {
 
 	struct regulator *supply;
 	struct gpio_desc *el_on3_gpio;
+	struct drm_dp_aux *aux;
 
 	struct edid *edid;
 
@@ -90,20 +95,25 @@ static int atana33xc20_resume(struct device *dev)
 		return ret;
 	p->powered_on_time = ktime_get();
 
-	/*
-	 * Handle HPD. Note: if HPD is hooked up to a dedicated pin on the
-	 * eDP controller then "no_hpd" will be false _and_ "hpd_gpio" will be
-	 * NULL. It's up to the controller driver to wait for HPD after
-	 * preparing the panel in that case.
-	 */
 	if (p->no_hpd) {
-		/* T3 VCC to HPD high is max 200 ms */
-		msleep(200);
-	} else if (p->hpd_gpio) {
-		ret = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
-					 hpd_asserted, hpd_asserted,
-					 1000, 200000);
-		if (!hpd_asserted)
+		msleep(HPD_MAX_MS);
+	} else {
+		if (p->hpd_gpio)
+			ret = readx_poll_timeout(gpiod_get_value_cansleep,
+						 p->hpd_gpio, hpd_asserted,
+						 hpd_asserted, 1000, HPD_MAX_US);
+		else if (p->aux->wait_hpd_asserted)
+			ret = p->aux->wait_hpd_asserted(p->aux, HPD_MAX_US);
+
+		/*
+		 * Note that it's possible that no_hpd is false, hpd_gpio is
+		 * NULL, and wait_hpd_asserted is NULL. This is because
+		 * wait_hpd_asserted() is optional even if HPD is hooked up to
+		 * a dedicated pin on the eDP controller. In this case we just
+		 * assume that the controller driver will wait for HPD at the
+		 * right times.
+		 */
+		if (!hpd_asserted && (p->hpd_gpio || p->aux->wait_hpd_asserted))
 			dev_warn(dev, "Timeout waiting for HPD\n");
 	}
 
@@ -263,6 +273,8 @@ static int atana33xc20_probe(struct dp_aux_ep_device *aux_ep)
 		return -ENOMEM;
 	dev_set_drvdata(dev, panel);
 
+	panel->aux = aux_ep->aux;
+
 	panel->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(panel->supply))
 		return dev_err_probe(dev, PTR_ERR(panel->supply),
-- 
2.36.0.rc0.470.gd361397f0d-goog

