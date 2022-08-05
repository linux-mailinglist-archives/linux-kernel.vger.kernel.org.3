Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8924E58AD18
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiHEPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiHEPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:38:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC55123BCF
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:38:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l4so3625861wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mGocdfdbRBVtbkhwoUtGYTP1ry+mhM2CsW1ZOWw9fd8=;
        b=rq0571EFJcbGGDYlW9TQ8EZZDyhlajpGv3mOEkzqe+kQWWSVw3I17MWMwXrOIyu+O9
         V52QbEOodPAUpbZVsO/UsiJF2EnWa57pr8o791l3aC0NypY+xcXzSVdSCVn9XSH6K4C8
         KC6Bzofgdc1QdqhqwZDKhQIeHYpXIJPIhuHrlgmXNUglaqNoh/XpANtOlRmqmFpuI0O8
         Lic2WGznFUQoUGm75w7IsoMZj7u9illNFZJebK4Gp7H6IWV7EP9hlvF3fCxigk9dtgRu
         JPcp6SlmPkOQl5ePHR+xonSK8jjZVJuopqi6MG4YGJpkukV6P/6Ds9/h4mnDcnZ1xoy7
         UnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mGocdfdbRBVtbkhwoUtGYTP1ry+mhM2CsW1ZOWw9fd8=;
        b=XfH4JHldT5XxR7n0pFORMYDLsrnK4yDB6VXKpIQsn2u+XObVD499xGDqGC6HIITT1E
         81TG7t9oP83fzHZsgNNhXrlYiq98LEvVGtLbMZ0ynxKLmDw+iYEvXmAJkCkSwl6mt9wy
         em2KSexIJKDJEcAXev6tzgl6gJRHnVaRYD1Wc2Gd6RjCoVTSuFXMlGxIu23MpInqPAwF
         vk2M40M9b0SifiYU5YkOfB/EsGOFgMT97HUMX42GPTKtZsX7Jnn9xvIiAgEjOKdL2TY2
         0Xd11210PJ8go2TTROdWG7/D/fHjiulVuay/qXJWnVgLYR9SxiG1Lj5OGe2URJyy9cv9
         i1OA==
X-Gm-Message-State: ACgBeo1XvkAc4y/srvrvJ3pFs3I7R+dKHnZeqdi287+illm9zDnWYBAO
        jipNO4XhtSsK93S5cPTBzcViZA==
X-Google-Smtp-Source: AA6agR45MGXfqxXZUDoPUFyl35baFe+mTwJWDsZftCp0Te3+wJEVblJAaY6htWWgRfHYKdfStDaCMg==
X-Received: by 2002:a05:6000:2a9:b0:21e:8f9b:74b9 with SMTP id l9-20020a05600002a900b0021e8f9b74b9mr4603653wry.232.1659713926310;
        Fri, 05 Aug 2022 08:38:46 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b002217540b222sm1721025wrq.58.2022.08.05.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:38:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 2/5] thermal/core: Rework the monitoring a bit
Date:   Fri,  5 Aug 2022 17:38:31 +0200
Message-Id: <20220805153834.2510142-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
References: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The should_stop_polling() function wraps the function
thermal_zone_device_is_enabled().

The monitor_thermal_zone() function checks if the thermal zone is
enabled via the should_stop_polling() function.

However, the instant after checking the thermal zone is enabled, this
one can be disabled, so even if that reduces the race window, it does
not prevent that and the monitoring can be set again with the thermal
zone disabled.

For this reason, the function should_stop_polling() is replaced by a
direct check of the thermal zone mode with the mutex locks held, that
prevents the situation described above.

As the semantic is clear with the thermal_zone_is_enabled() function,
we can remove the should_stop_polling() function and replace the check
with the former function.

While at it, reorder the checks to improve the readability of the
monitor_thermal_zone() function.

In the future, the thermal_zone_device_disable() and the
thermal_zone_device_enable() functions should unset / set the polling
timer directly instead of relying on the next
thermal_zone_device_update() call to do that. That will make a
synchronous thermal zone mode change but the locking scheme should be
double checked for that which out of the scope of this change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4e1a83987b99..d7029fd1c112 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -295,25 +295,16 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 		cancel_delayed_work(&tz->poll_queue);
 }
 
-static inline bool should_stop_polling(struct thermal_zone_device *tz)
-{
-	return !thermal_zone_device_is_enabled(tz);
-}
-
 static void monitor_thermal_zone(struct thermal_zone_device *tz)
 {
-	bool stop;
-
-	stop = should_stop_polling(tz);
-
 	mutex_lock(&tz->lock);
 
-	if (!stop && tz->passive)
+	if (tz->mode != THERMAL_DEVICE_ENABLED)
+		thermal_zone_device_set_polling(tz, 0);
+	else if (tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
-	else if (!stop && tz->polling_delay_jiffies)
+	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
-	else
-		thermal_zone_device_set_polling(tz, 0);
 
 	mutex_unlock(&tz->lock);
 }
@@ -480,7 +471,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 {
 	int count;
 
-	if (should_stop_polling(tz))
+	if (!thermal_zone_device_is_enabled(tz))
 		return;
 
 	if (atomic_read(&in_suspend))
-- 
2.25.1

