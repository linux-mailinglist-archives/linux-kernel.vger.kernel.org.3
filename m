Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8573951E718
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446372AbiEGM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384944AbiEGM7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:59:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3E83EBAD
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:55:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j15so13460403wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0U/s6dQTEfoFEbpTJihWWY85W4BK/cbywxL1SeG1t9U=;
        b=2Qm8bNiXNCwkPjVehTglY1L/ALQ+SkYt0zoY5cJug/jsrR5na46y1dILW/DppzMKHl
         p6nVoj9OkynpqOHbnrXvRG3WgaCFEO0J64gUwqVx9TthjQczi0mUjTNpIy9rp2ndS7vE
         Q0FGaJYb1HQakrCV/uyRVS0aOPowdH0skbXuS3x1n6C3FxZ6UpcnRwPkzPW84Z+8xoIi
         MLNU1XU6Apth5WMB8WGEtKZ8RTYAinGu6tJ7UvQTlh2voT8DlDEHvDKrLyEfrtxb6QMl
         ctRKH11rc3KV7mNsXY6AmhQlhPNXPn0H0aM5WSAR4/INMt2cCjjVHcvRcHmz++QX0qgt
         Hg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0U/s6dQTEfoFEbpTJihWWY85W4BK/cbywxL1SeG1t9U=;
        b=kKCRqQhVbTQ0Jy0xgkZSXqGecYg3qiRH5lV9iIuPoDlUMebbONTfYre4eTXomupr5Q
         tuisYm02DBhS5z652yj0wg0mC5Bl4JWhYo5cVrVDz4GtG/2rtOuz7FNN/rrIaQzIGfTA
         204k2GIZ3DbqfSVWWMuv8PUv8Oys6/CTogEbnoF/fFJ1EcTCPAomNIZ+qXI4z0K3Izt6
         E0FVTFKUKPsXKJf08UutSeQFOOfUqOJ6ITa1UKRQ0+PHyTmj5pCRv04fmL0fcck1XHkf
         k3uwa5HMGUQGKeqXOkyxtOWvtMVV5YDAE+b2TV1B7eCUULVBbzKUBx3k7OAO2X+oRFX+
         wz3g==
X-Gm-Message-State: AOAM531NpwIWJ04qRxBV1socli+VMo1aopcF/dReW1mD4ronTUKTUSoo
        RExRdDSNog6sWY1yTJCzdKmM1Q==
X-Google-Smtp-Source: ABdhPJxk7AFrtzXjdxWAguuWuKWkzF2JF2G/mbGYTHXrWpUwSmLHl88tunPErUcVgLWNZY08bG/UnQ==
X-Received: by 2002:a5d:47ce:0:b0:20c:6305:d8cb with SMTP id o14-20020a5d47ce000000b0020c6305d8cbmr6733219wrc.106.1651928113765;
        Sat, 07 May 2022 05:55:13 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 08/14] thermal/core: Move thermal_set_delay_jiffies to static
Date:   Sat,  7 May 2022 14:54:36 +0200
Message-Id: <20220507125443.2766939-9-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function 'thermal_set_delay_jiffies' is only used in
thermal_core.c but it is defined and implemented in a separate
file. Move the function to thermal_core.c and make it static.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.c    | 7 +++++++
 drivers/thermal/thermal_core.h    | 1 -
 drivers/thermal/thermal_helpers.c | 7 -------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index dc5a03d51f5c..386453d46e94 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1158,6 +1158,13 @@ static void bind_tz(struct thermal_zone_device *tz)
 	mutex_unlock(&thermal_list_lock);
 }
 
+static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
+{
+	*delay_jiffies = msecs_to_jiffies(delay_ms);
+	if (delay_ms > 1000)
+		*delay_jiffies = round_jiffies(*delay_jiffies);
+}
+
 /**
  * thermal_zone_device_register() - register a new thermal zone device
  * @type:	the thermal zone device type
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 60844e2d59bb..c991bb290512 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -112,7 +112,6 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
-void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index beb97cd6b799..3c7aa31686ad 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -174,13 +174,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
-void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
-{
-	*delay_jiffies = msecs_to_jiffies(delay_ms);
-	if (delay_ms > 1000)
-		*delay_jiffies = round_jiffies(*delay_jiffies);
-}
-
 static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 				       int target)
 {
-- 
2.25.1

