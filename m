Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3211F505D35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346740AbiDRRBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346696AbiDRRBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:01:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3F32AD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:58:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j8so12782060pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dgl5eKn4iSzXB9l06M4fwVd6TIsHNtzaSHHFv1Wa9zw=;
        b=BZQFA9pcqNGWWm/TFoYFFVZdh6KTVdcVLfXm/LYOkpxORHlZJkWyJzamzdep7WPyws
         ZJPpjlwYhKtM38pYvGQB8OV5r2gkjnNdFrinAOXarjmIh5CKSeQ/Vs4R8ZuF+eIU37zE
         vXeyRDrb56V0yWMcCRSp96qh6Aytunonn02UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dgl5eKn4iSzXB9l06M4fwVd6TIsHNtzaSHHFv1Wa9zw=;
        b=4GBEQJn/jKPrvpkV2ltiZcdTRFCPiQrLWMxLI4bZ3NnMltBl62TafLIScrXM7AVpNN
         /CaJLOy8lUEWlNRNp6fM+lLJUV3k1qo/fR3OFdrrSE6cL+2ZFqgntMU35LP/7y2iCsHF
         A/kPbmAHeEK51EjIBFCcT9XGEWp98RFR9Te/4s7kgJodTPiWyzSkHSwyxcyBbzAuILYO
         lqUFLUY/bKktArVPbO262uoFgGDNFeXXAuADfUzcqcfXDbTcVDnEL8KVkvUafCa9CVVv
         JeosrbEvQr2E/IuXDBJ6cGJQibrKUts6Q4ssXMzsjQcy8n5wrlp+R7DC7zDyX0dLtRZp
         XFWA==
X-Gm-Message-State: AOAM533KZoAs69M6CuXJJ67/v/CFqpqREte4cwX9rE0muTVXnjz0RDmx
        l19/o4vvrASINVEwFQbZZRxK7Q==
X-Google-Smtp-Source: ABdhPJxQVsYC/f7eoCzdIS38t+LLRJmAkBiI96AdewmBzcUliQs0YJQ/uNxYdYHYGIw1Keing25HWQ==
X-Received: by 2002:a17:90a:c781:b0:1d0:c23e:5842 with SMTP id gn1-20020a17090ac78100b001d0c23e5842mr18487206pjb.182.1650301119843;
        Mon, 18 Apr 2022 09:58:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:94f4:f90:c59f:129b])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a150800b001cbaf536a3esm17700980pja.18.2022.04.18.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:58:39 -0700 (PDT)
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
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/bridge: parade-ps8640: Provide wait_hpd_asserted() in struct drm_dp_aux
Date:   Mon, 18 Apr 2022 09:56:42 -0700
Message-Id: <20220418095557.v2.4.Ie827321ce263be52fdb8c1276f6f8cc00d78029f@changeid>
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

This implements the callback added by the patch ("drm/dp: Add
wait_hpd_asserted() callback to struct drm_dp_aux").

With this change and all the two "DP AUX Endpoint" drivers changed to
use wait_hpd_asserted(), we no longer need to have an long delay in
the AUX transfer function. It's up to the panel code to make sure that
the panel is powered now. If someone tried to call the aux transfer
function without making sure the panel is powered we'll just get a
normal transfer failure.

We'll still keep the wait for HPD in the pre_enable() function. Though
it's probably not actually needed there, this driver is used in the
old mode (pre-DP AUX Endpoints) and it may be important for those
cases. If nothing else, it shouldn't cause any big problems.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Change is_hpd_asserted() to wait_hpd_asserted()

 drivers/gpu/drm/bridge/parade-ps8640.c | 34 ++++++++++++++++----------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 9766cbbd62ad..2f19a8c89880 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -168,23 +168,30 @@ static bool ps8640_of_panel_on_aux_bus(struct device *dev)
 	return true;
 }
 
-static int ps8640_ensure_hpd(struct ps8640 *ps_bridge)
+static int _ps8640_wait_hpd_asserted(struct ps8640 *ps_bridge, unsigned long wait_us)
 {
 	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
-	struct device *dev = &ps_bridge->page[PAGE2_TOP_CNTL]->dev;
 	int status;
-	int ret;
 
 	/*
 	 * Apparently something about the firmware in the chip signals that
 	 * HPD goes high by reporting GPIO9 as high (even though HPD isn't
 	 * actually connected to GPIO9).
 	 */
-	ret = regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
-				       status & PS_GPIO9, 20 * 1000, 200 * 1000);
+	return regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
+					status & PS_GPIO9, wait_us / 10, wait_us);
+}
 
-	if (ret < 0)
-		dev_warn(dev, "HPD didn't go high: %d\n", ret);
+static int ps8640_wait_hpd_asserted(struct drm_dp_aux *aux, unsigned long wait_us)
+{
+	struct ps8640 *ps_bridge = aux_to_ps8640(aux);
+	struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	ret = _ps8640_wait_hpd_asserted(ps_bridge, wait_us);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -323,9 +330,7 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
 	int ret;
 
 	pm_runtime_get_sync(dev);
-	ret = ps8640_ensure_hpd(ps_bridge);
-	if (!ret)
-		ret = ps8640_aux_transfer_msg(aux, msg);
+	ret = ps8640_aux_transfer_msg(aux, msg);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
@@ -369,8 +374,8 @@ static int __maybe_unused ps8640_resume(struct device *dev)
 	 * Mystery 200 ms delay for the "MCU to be ready". It's unclear if
 	 * this is truly necessary since the MCU will already signal that
 	 * things are "good to go" by signaling HPD on "gpio 9". See
-	 * ps8640_ensure_hpd(). For now we'll keep this mystery delay just in
-	 * case.
+	 * _ps8640_wait_hpd_asserted(). For now we'll keep this mystery delay
+	 * just in case.
 	 */
 	msleep(200);
 
@@ -406,7 +411,9 @@ static void ps8640_pre_enable(struct drm_bridge *bridge)
 	int ret;
 
 	pm_runtime_get_sync(dev);
-	ps8640_ensure_hpd(ps_bridge);
+	ret = _ps8640_wait_hpd_asserted(ps_bridge, 200 * 1000);
+	if (ret < 0)
+		dev_warn(dev, "HPD didn't go high: %d\n", ret);
 
 	/*
 	 * The Manufacturer Command Set (MCS) is a device dependent interface
@@ -652,6 +659,7 @@ static int ps8640_probe(struct i2c_client *client)
 	ps_bridge->aux.name = "parade-ps8640-aux";
 	ps_bridge->aux.dev = dev;
 	ps_bridge->aux.transfer = ps8640_aux_transfer;
+	ps_bridge->aux.wait_hpd_asserted = ps8640_wait_hpd_asserted;
 	drm_dp_aux_init(&ps_bridge->aux);
 
 	pm_runtime_enable(dev);
-- 
2.36.0.rc0.470.gd361397f0d-goog

