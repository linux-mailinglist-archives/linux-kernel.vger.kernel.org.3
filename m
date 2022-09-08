Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC345B169B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiIHINw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiIHINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:13:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C335261738
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:13:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q3so16993088pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=O1vPzp++Y+rg877+GNK8AXhim+X8pwwIT0iX2ZyyZGc=;
        b=aU+cB1J4gIcX9czY5UabCbYzMhsgnCE6P3ZxLkl4oSTxzOqBFcrV2pRr1ffiSzzg3l
         IHX9G44qeKLQ/5IltNvL0aay91DB+3ApLtFPI4BmiGuGODuMQEXCZ3lZsS9p3yf9WnRz
         f+81tttNHHZ+kIoOjkUd0vEXPpMkSPGalXvbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O1vPzp++Y+rg877+GNK8AXhim+X8pwwIT0iX2ZyyZGc=;
        b=af83ZGG9yr1AzWRJWWqYwbctdGBv8d4posvs+r8NjJQfoAgD0kc5uaxWtTcTXKeCXW
         YmkKU+1UaChDBGU077dJK4EpBe5Tc4rvWp9JlljqTtIXwmG80n7CtNzORNQ7EkWX0vWJ
         tsX+JnRIC/Ycg0qWlFUkfOo0LifGgTwzdWdypSTHAq5QEgDkyQWrNwKol3ZV+aLrBIFg
         gmy/33SmTtjnP/Z0jXL0B4/VxsYLaANdiPSYgnlhZ6cgeYPSVKiEQ4jze763CndBjmhS
         zcLM3YwVqowErWrPF7h8+9mrkcmL9AuRp2CTYsC6ynSEwBisWNH8tfx6E4e+a/4BadKW
         yHtQ==
X-Gm-Message-State: ACgBeo3E1CmlXWRxH1P0h/euYNKqmEPqckHCpWCwoxrf1aEXIubueEHx
        Ud02ESGlK8kETD9ZW8aF8v9s1w==
X-Google-Smtp-Source: AA6agR7NC8MzGBXfOam39plBc4fj/sNv5PauFaLxGrH8rC2K1EiGjJ6oljoacaKFQeeyTHBzyd58Jw==
X-Received: by 2002:a17:902:ec88:b0:175:d8f:44b with SMTP id x8-20020a170902ec8800b001750d8f044bmr7849588plg.84.1662624791085;
        Thu, 08 Sep 2022 01:13:11 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:5237:c185:9b01:8955])
        by smtp.gmail.com with ESMTPSA id z22-20020aa79496000000b0052d4cb47339sm14159702pfk.151.2022.09.08.01.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:13:10 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH 1/2] drm/bridge: it6505: Adapt runtime power management framework
Date:   Thu,  8 Sep 2022 16:12:57 +0800
Message-Id: <20220908081259.503236-2-treapking@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220908081259.503236-1-treapking@chromium.org>
References: <20220908081259.503236-1-treapking@chromium.org>
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

Use pm_runtime_(get|put)_sync to control the bridge power, and add
SET_SYSTEM_SLEEP_PM_OPS with pm_runtime_force_(suspend|resume) to it6505
driver. Without SET_SYSTEM_SLEEP_PM_OPS, the bridge will be powered on
unnecessarily when no external display is connected.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/bridge/ite-it6505.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 2bb957cffd94..9d37660545fb 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -421,6 +421,7 @@ struct it6505 {
 	struct notifier_block event_nb;
 	struct extcon_dev *extcon;
 	struct work_struct extcon_wq;
+	int extcon_state;
 	enum drm_connector_status connector_status;
 	enum link_train_status link_state;
 	struct work_struct link_works;
@@ -2685,31 +2686,34 @@ static void it6505_extcon_work(struct work_struct *work)
 {
 	struct it6505 *it6505 = container_of(work, struct it6505, extcon_wq);
 	struct device *dev = &it6505->client->dev;
-	int state = extcon_get_state(it6505->extcon, EXTCON_DISP_DP);
-	unsigned int pwroffretry = 0;
+	int state;
 
 	if (it6505->enable_drv_hold)
 		return;
 
 	mutex_lock(&it6505->extcon_lock);
 
+	state = extcon_get_state(it6505->extcon, EXTCON_DISP_DP);
 	DRM_DEV_DEBUG_DRIVER(dev, "EXTCON_DISP_DP = 0x%02x", state);
+
+	if (state == it6505->extcon_state)
+		goto unlock;
+
 	if (state > 0) {
 		DRM_DEV_DEBUG_DRIVER(dev, "start to power on");
 		msleep(100);
-		it6505_poweron(it6505);
+		pm_runtime_get_sync(dev);
 	} else {
 		DRM_DEV_DEBUG_DRIVER(dev, "start to power off");
-		while (it6505_poweroff(it6505) && pwroffretry++ < 5) {
-			DRM_DEV_DEBUG_DRIVER(dev, "power off fail %d times",
-					     pwroffretry);
-		}
+		pm_runtime_put_sync(dev);
 
 		drm_helper_hpd_irq_event(it6505->bridge.dev);
 		memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
 		DRM_DEV_DEBUG_DRIVER(dev, "power off it6505 success!");
 	}
+	it6505->extcon_state = state;
 
+unlock:
 	mutex_unlock(&it6505->extcon_lock);
 }
 
@@ -3032,8 +3036,10 @@ static __maybe_unused int it6505_bridge_suspend(struct device *dev)
 	return it6505_poweroff(it6505);
 }
 
-static SIMPLE_DEV_PM_OPS(it6505_bridge_pm_ops, it6505_bridge_suspend,
-			 it6505_bridge_resume);
+static const struct dev_pm_ops it6505_bridge_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(it6505_bridge_suspend, it6505_bridge_resume, NULL)
+};
 
 static int it6505_init_pdata(struct it6505 *it6505)
 {
@@ -3315,6 +3321,7 @@ static int it6505_i2c_probe(struct i2c_client *client,
 
 	DRM_DEV_DEBUG_DRIVER(dev, "it6505 device name: %s", dev_name(dev));
 	debugfs_init(it6505);
+	pm_runtime_enable(dev);
 
 	it6505->bridge.funcs = &it6505_bridge_funcs;
 	it6505->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
-- 
2.37.2.789.g6183377224-goog

