Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243FE564926
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiGCSbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiGCSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:31:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EE52DE4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:31:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l68so4194709wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A2z3qfhbQ3zSDbb76Qqm6EAs5xwOzGA7CqbEOdCxb6g=;
        b=XhQSb87XVVI3luZ32GWskOiupZ5bhwPz1YAQE1fY5hOjVny3ZZB1mQzM8xqwA0WF1y
         xMTEgCUd9wKgfrskPUemcvxiDbjBMl20XafSGYnRkaGdW0RHnqngtJcmKp+PKjb8Wj6n
         523eScii7Q0p3lIUlL7j+fS5Hn6e7lVa+9+d1tDWfs6sYDpvnrhJxO2I3Uh7uFygTSxt
         cOSHNOJmdYwgyI7X+uhvUVlLc5Ti5bznfVzKFMu9sec8a8OEzwA3ra4rfsJMA7A0CcMk
         reD/hlq2YxY8pGJKTh5n9MY/6/JiK6N+B8LO1CqfBx8mlfOJ3bR0iDZ8FMSQBMK5Abn3
         scCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2z3qfhbQ3zSDbb76Qqm6EAs5xwOzGA7CqbEOdCxb6g=;
        b=sBv7jaXpdg0MSSZDsJnxjSTeX3K58LFsGw0ihCnhIq35L8P5f4SP87Hn5uEIqenaId
         KVJlw1XmCW0bBL9ZOjbG8J1cz8XeaOSloA4dk90nzI/l3znuDQbcmyeCPeUIQweXa+sg
         CRoV5VePlX6J4Fe0w2EcnQXkteLMOzkfiVhidStLjWlS0rQecP0KW64yIZniWrBcba+C
         pGHG2JVN6VEZudosQ48kyU+j2c6KKIg8BNCx01vlKm0pFjE29BqarjoOZwkUDaLNsZNu
         QiICPxWy4yAtlPg3sNcS+dpneXv0R3XXMuab8Whk3zG1/LoH+x3B/y9eWOVtz9z6umyh
         iOGw==
X-Gm-Message-State: AJIora9xGe7epx1lggJUYOb/F/489C/lAKS5bCeb84b4m5NY/a2gSjDJ
        G/g049qUPkpmFbELz+KSmq+i4w==
X-Google-Smtp-Source: AGRyM1tuvMijgjcSMj9tFddYyj2ScVNEALBCowAqot6wGPssoHDtk7EBqcmWdK5tMba5E15kDXmXJQ==
X-Received: by 2002:a05:600c:1c93:b0:3a0:579e:9f44 with SMTP id k19-20020a05600c1c9300b003a0579e9f44mr27474122wms.82.1656873090393;
        Sun, 03 Jul 2022 11:31:30 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 04/12] thermal/of: Move thermal_trip structure to thermal.h
Date:   Sun,  3 Jul 2022 20:30:51 +0200
Message-Id: <20220703183059.4133659-5-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
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

The structure thermal_trip is now generic and will be usable by the
different sensor drivers in place of their own structure.

Move its definition to thermal.h to make it accessible.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
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

