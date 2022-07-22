Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D7457E7CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbiGVUAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiGVUAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:00:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461968717
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id id17so3378582wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Cg8NIEv3M0ZsrQ6LuqyJLiJb25T+jZLIiP7PzCJ4Cg=;
        b=jhlOUJ60KT6l/iTJg3SfQ2S82Y4QGgj2fjsOHInVSIB6f18jLAoz0DgvHqCu8yIV2f
         vBnAnhH2MOFB1YT6XQkUUGepn3EQ212i66MiU9BZMPmQFu1jmeO/M57DxnTTuTSnoypJ
         QH4pi+8YZho86tG4lWv3BVhCMQQpUABQaKORkwF+4eKmuTUQX7NR2wwvZRdUWwd80Vj7
         gLuaGK1f/ROKlKmF42kgvsBUUortXqIJtV89M2+gydO7DInbkZiJsRgBP5v5p4XAJyS7
         RVeJqtXW5FiPXs/vyM+SpmcFTuBaPm4kKL1wNV97A9BVXjPujrZfWqcNhx5+A/wOWmGa
         mAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Cg8NIEv3M0ZsrQ6LuqyJLiJb25T+jZLIiP7PzCJ4Cg=;
        b=loDKl/bvUUYP9phBmcZNTmQyxDfHBdFsGppIhIV+92ITBzeQeDOXPQtMT5SGPyoNMw
         u3ASnFfSo1/qjE+1LNoCmZmpqyKfWgsfnOjw42uB5ijzgDrAsKHCZsydivlC7uBDSHbH
         Nj9Y4d3Yf2Sky5xU+JeUDqrutAaZ+gidqSiGi0pSUOWemSgRpmq/9OtUJfRy/HprYYdk
         WpRfoXMYHbK4EV+U7y5a7lQIJFUCKgtep2i2V1MhLakvkYw3cJauvsDlS7EIBRdn7HWv
         1plXtJP6jvm9NoPMk6bfqWv4H30PkWzccCKy8q12tXaJRAEJTw8Ei1lsFkLimPF1l8Fp
         OSUw==
X-Gm-Message-State: AJIora8skUD8T37UrfoGV+qM8ZSKFOY+wH98l9ja574dnpLovUjc8/6u
        s74BuQiw7ZabLUCx2mXnHoZmXw==
X-Google-Smtp-Source: AGRyM1vJz/i3tldpQmZ7vmiE/x09TOC3aQtZK1txvGzhPRhB7qM7vhA6UX8BSmQxDoej55+LydGhNQ==
X-Received: by 2002:a05:600c:1c27:b0:3a3:294b:ad25 with SMTP id j39-20020a05600c1c2700b003a3294bad25mr910438wms.69.1658520033986;
        Fri, 22 Jul 2022 13:00:33 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm6429008wms.0.2022.07.22.13.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:00:33 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 04/10] thermal/of: Move thermal_trip structure to thermal.h
Date:   Fri, 22 Jul 2022 22:00:01 +0200
Message-Id: <20220722200007.1839356-5-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure thermal_trip is now generic and will be usable by the
different sensor drivers in place of their own structure.

Move its definition to thermal.h to make it accessible.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.h | 12 ------------
 include/linux/thermal.h        | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index ff10cdda056c..60844e2d59bb 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -68,18 +68,6 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 void thermal_cdev_update(struct thermal_cooling_device *);
 void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
-/**
- * struct thermal_trip - representation of a point in temperature domain
- * @temperature: temperature value in miliCelsius
- * @hysteresis: relative hysteresis in miliCelsius
- * @type: trip point type
- */
-struct thermal_trip {
-	int temperature;
-	int hysteresis;
-	enum thermal_trip_type type;
-};
-
 int get_tz_trend(struct thermal_zone_device *tz, int trip);
 
 struct thermal_instance *
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 365733b428d8..6289b0bb1c97 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -80,6 +80,18 @@ struct thermal_zone_device_ops {
 	void (*critical)(struct thermal_zone_device *);
 };
 
+/**
+ * struct thermal_trip - representation of a point in temperature domain
+ * @temperature: temperature value in miliCelsius
+ * @hysteresis: relative hysteresis in miliCelsius
+ * @type: trip point type
+ */
+struct thermal_trip {
+	int temperature;
+	int hysteresis;
+	enum thermal_trip_type type;
+};
+
 struct thermal_cooling_device_ops {
 	int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);
-- 
2.25.1

