Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A97505D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346949AbiDRRVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346911AbiDRRU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:20:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC526556
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:18:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s14so12854028plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbyBbjg8gyQUteF6HieSyj7KxxSHSKGjYqQSaFd6TEU=;
        b=Zwq7VaOgsewiCmFbE/n3kyjx9CnT9hrV1iH13ddciUfogTYoP3vKbKr2r6xIr489kr
         OKKvgazeoIC641p9t8uY7He78fymv9yeCfFKojsIC6FDtcegdms0UggwymRnd6JZkrGq
         5T8EUG8NWtHKJD8gs0BWpOtwKWiV2/vvYbvIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbyBbjg8gyQUteF6HieSyj7KxxSHSKGjYqQSaFd6TEU=;
        b=lPV47yZm5Kva1tcXq7HhpKKHnM1tFB+fhAORJbXMluofcRudLHQ8cDEF8mX0kpdvY0
         zbno+fIJBVlJXStHbdeK5aL2gkCV9JLqkfnuLuMEB1t4Nzq4B72EmsSbM1yr5uK6qkNO
         KHeZxm6VbDsArlHbvULjv6jWbMdBZxSFl14yWfN2zwSWLiTw12jc+daqliXOht5ftO+V
         gSdNDOjQFxFpRGAuYVHP1e+32FxhbI2m61bWpA4+tE4LZnPdBDB/4lp/F3x8whCd80Ff
         6i0bBSO3ED47Mjk9Lz4n9cKqFQNYQVDjifVP+92mYGu8DQ27w0cXfnWYHXJYsPjKNhul
         ZvYQ==
X-Gm-Message-State: AOAM533eCtJayHS9vRKNYYznBhFaRJHPNs3KhMcJaYNHMIuZxXtjBQxm
        AqvsNiLWUNYK0x4aQEMBofKFUQ==
X-Google-Smtp-Source: ABdhPJyaED3SN66kMNUE2uFkmpidmKhbhonRfUkIPOEYVFjhxla397ZKSGrYrID4nNtyd6w2iBhLOw==
X-Received: by 2002:a17:902:e98a:b0:159:5f7:49cf with SMTP id f10-20020a170902e98a00b0015905f749cfmr3763147plb.41.1650302298343;
        Mon, 18 Apr 2022 10:18:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:94f4:f90:c59f:129b])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0050a3bbd36d6sm12152126pfn.204.2022.04.18.10.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:18:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] drm/panel: atna33xc20: Take advantage of wait_hpd_asserted() in struct drm_dp_aux
Date:   Mon, 18 Apr 2022 10:17:56 -0700
Message-Id: <20220418101725.v3.3.I9ee239f6b95b944c8fa030f300ad222a7af9899d@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418171757.2282651-1-dianders@chromium.org>
References: <20220418171757.2282651-1-dianders@chromium.org>
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

Changes in v3:
- Don't check "hpd_asserted" boolean when unset.
- Handle errors from gpiod_get_value_cansleep() properly.

Changes in v2:
- Change is_hpd_asserted() to wait_hpd_asserted()

 .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 41 +++++++++++++------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 20666b6217e7..5ef1b4032c56 100644
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
 
@@ -79,7 +84,7 @@ static int atana33xc20_suspend(struct device *dev)
 static int atana33xc20_resume(struct device *dev)
 {
 	struct atana33xc20_panel *p = dev_get_drvdata(dev);
-	bool hpd_asserted = false;
+	int hpd_asserted;
 	int ret;
 
 	/* T12 (Power off time) is min 500 ms */
@@ -91,20 +96,28 @@ static int atana33xc20_resume(struct device *dev)
 	p->powered_on_time = ktime_get();
 
 	/*
-	 * Handle HPD. Note: if HPD is hooked up to a dedicated pin on the
-	 * eDP controller then "no_hpd" will be false _and_ "hpd_gpio" will be
-	 * NULL. It's up to the controller driver to wait for HPD after
-	 * preparing the panel in that case.
+	 * Note that it's possible that no_hpd is false, hpd_gpio is
+	 * NULL, and wait_hpd_asserted is NULL. This is because
+	 * wait_hpd_asserted() is optional even if HPD is hooked up to
+	 * a dedicated pin on the eDP controller. In this case we just
+	 * assume that the controller driver will wait for HPD at the
+	 * right times.
 	 */
 	if (p->no_hpd) {
-		/* T3 VCC to HPD high is max 200 ms */
-		msleep(200);
-	} else if (p->hpd_gpio) {
-		ret = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
-					 hpd_asserted, hpd_asserted,
-					 1000, 200000);
-		if (!hpd_asserted)
-			dev_warn(dev, "Timeout waiting for HPD\n");
+		msleep(HPD_MAX_MS);
+	} else {
+		if (p->hpd_gpio) {
+			ret = readx_poll_timeout(gpiod_get_value_cansleep,
+						 p->hpd_gpio, hpd_asserted,
+						 hpd_asserted, 1000, HPD_MAX_US);
+			if (hpd_asserted < 0)
+				ret = hpd_asserted;
+		} else if (p->aux->wait_hpd_asserted) {
+			ret = p->aux->wait_hpd_asserted(p->aux, HPD_MAX_US);
+		}
+
+		if (ret)
+			dev_warn(dev, "Error waiting for HPD: %d\n", ret);
 	}
 
 	return 0;
@@ -263,6 +276,8 @@ static int atana33xc20_probe(struct dp_aux_ep_device *aux_ep)
 		return -ENOMEM;
 	dev_set_drvdata(dev, panel);
 
+	panel->aux = aux_ep->aux;
+
 	panel->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(panel->supply))
 		return dev_err_probe(dev, PTR_ERR(panel->supply),
-- 
2.36.0.rc0.470.gd361397f0d-goog

