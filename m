Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C435254BD19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiFNVyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357858AbiFNVyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:54:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48EF2B19F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:54:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x138so9707789pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/m4CI4QQSCApkc/AOcjH4+peoaHbWtmSNURLAr70/iQ=;
        b=TOa5A/MPY0GzRyi8zVHJ708N42r0XfCt1ehWJaLsmgLM8s8zQBpWq9MEFEOPX5zDlK
         axqfAEaJA8UdjLyWX7q2dPlYPbqpCSI5kOGLVp5Jm4N2fowSwRoD2tPrG3A9IaccgeQM
         R8p1SKi1HbpfqULH3PrEBfWZG8rswJbQvzyAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/m4CI4QQSCApkc/AOcjH4+peoaHbWtmSNURLAr70/iQ=;
        b=pJqEze5gz5pbUQ4kOyGmAqaWOvPIsxDRYsvapVG7JEGyD2e/YuwW/2Ge18YpozNRem
         w55aqNdrAXm24b+lvWMZLGoRwjeB5nFMTvY+vFDkvqR9Rss56FvLJtLdXSFuE95DR4tM
         pz6GPPuJvgAjhzDNCN6aiY26rsXI7HEzF5Kxx7h/mQ9CU8Tns/w2A+99YXW/G6ryNlH7
         Swi2Xbrrju34t/fIYwGLJ3lo9ABCJtH1QyjudMw/rZMmcaqfJhQ3oYEkc7mpQ+1v0CSw
         ZG9Tunvw+GywbIlP41bKDibCVwPkriJ/SqfVNsGbQR41crCsnLx03XWh2tngeQrxd2Zl
         pm1Q==
X-Gm-Message-State: AOAM533xmDq7m/a1k5/vsA0gK2gvyzxN1nCmOoMIijM/ja++ADrgZChK
        FY0DEWRskr2AXZPRoswUUh10XQ==
X-Google-Smtp-Source: ABdhPJwa1rc1AecnmEH9sWNMtW8IyHVRsgkxDHCAHJ8r0pyupbJHEokJH2CNZh7GCiuaSsAg7mSDsA==
X-Received: by 2002:a63:2b16:0:b0:3fa:faf9:e6d7 with SMTP id r22-20020a632b16000000b003fafaf9e6d7mr6217810pgr.325.1655243685302;
        Tue, 14 Jun 2022 14:54:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f355:be2d:74b7:3c7c])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b0016641a646cbsm7668968pli.218.2022.06.14.14.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:54:45 -0700 (PDT)
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
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] drm/bridge: parade-ps8640: Provide wait_hpd_asserted() in struct drm_dp_aux
Date:   Tue, 14 Jun 2022 14:54:18 -0700
Message-Id: <20220614145327.v4.4.Ie827321ce263be52fdb8c1276f6f8cc00d78029f@changeid>
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

NOTE: When handling the timeout for HPD we start the timer _after_
we've runtime resumed the device. This is definitely important for the
panel on my homestar which comes up 170 ms after we start timing (the
panel specifies 200 ms max). It's a little unclear how much of this
extra time is due to some internal state machine in the parade
firmware vs. debouncing but it seems to work for the two test cases I
have to do it this way.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

Changes in v4:
- Add comment that caller powered up the panel.
- Mention in commit message debouncing vs. powering on timing.

Changes in v2:
- Change is_hpd_asserted() to wait_hpd_asserted()

 drivers/gpu/drm/bridge/parade-ps8640.c | 39 +++++++++++++++++---------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index ff4227f6d800..e880eee55822 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -168,23 +168,35 @@ static bool ps8640_of_panel_on_aux_bus(struct device *dev)
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
+	/*
+	 * Note that this function is called by code that has already powered
+	 * the panel. We have to power ourselves up but we don't need to worry
+	 * about powering the panel.
+	 */
+	pm_runtime_get_sync(dev);
+	ret = _ps8640_wait_hpd_asserted(ps_bridge, wait_us);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -323,9 +335,7 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
 	int ret;
 
 	pm_runtime_get_sync(dev);
-	ret = ps8640_ensure_hpd(ps_bridge);
-	if (!ret)
-		ret = ps8640_aux_transfer_msg(aux, msg);
+	ret = ps8640_aux_transfer_msg(aux, msg);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
@@ -369,8 +379,8 @@ static int __maybe_unused ps8640_resume(struct device *dev)
 	 * Mystery 200 ms delay for the "MCU to be ready". It's unclear if
 	 * this is truly necessary since the MCU will already signal that
 	 * things are "good to go" by signaling HPD on "gpio 9". See
-	 * ps8640_ensure_hpd(). For now we'll keep this mystery delay just in
-	 * case.
+	 * _ps8640_wait_hpd_asserted(). For now we'll keep this mystery delay
+	 * just in case.
 	 */
 	msleep(200);
 
@@ -406,7 +416,9 @@ static void ps8640_pre_enable(struct drm_bridge *bridge)
 	int ret;
 
 	pm_runtime_get_sync(dev);
-	ps8640_ensure_hpd(ps_bridge);
+	ret = _ps8640_wait_hpd_asserted(ps_bridge, 200 * 1000);
+	if (ret < 0)
+		dev_warn(dev, "HPD didn't go high: %d\n", ret);
 
 	/*
 	 * The Manufacturer Command Set (MCS) is a device dependent interface
@@ -682,6 +694,7 @@ static int ps8640_probe(struct i2c_client *client)
 	ps_bridge->aux.name = "parade-ps8640-aux";
 	ps_bridge->aux.dev = dev;
 	ps_bridge->aux.transfer = ps8640_aux_transfer;
+	ps_bridge->aux.wait_hpd_asserted = ps8640_wait_hpd_asserted;
 	drm_dp_aux_init(&ps_bridge->aux);
 
 	pm_runtime_enable(dev);
-- 
2.36.1.476.g0c4daa206d-goog

