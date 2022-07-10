Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9956CF1F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiGJMf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGJMfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B8511149
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q9so3829952wrd.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWXSn875oBDJq4Q/0NyDjwM2E/hA/gxhBWxbmBReloU=;
        b=wrpaz+erB/SUAvWKJfI4hiKHYzgifm9j24LzmoyTVnQ+aeaN10CpMA/HqHSI4TayaE
         giVHjnJRDvxYgsTKfEERbvJNaNhtJBOP9pYaqKqdt9pLLliYPYawwtf8EFSZxScd470I
         BurTlZO8cj/FsXkm56qa8nVYlR0JEtuIOoWyBE3I6QbN3olYAAMXwppRitHyHf6eXDr7
         +hbbwiNLcTH1rdG2nMLxGLD8Qkr+A5EY9KuDnQLq4qIhqDvOMFg1RU4lqkQQ7LvUZwB1
         bs7clzfvdo7RrO88MWVgPOnts2aeHVVzKYWVlOuUEWKZkyaTymc4s9t07QZWpRI+7Hur
         GknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWXSn875oBDJq4Q/0NyDjwM2E/hA/gxhBWxbmBReloU=;
        b=fjJ+DSQCZbyupJi1//fVXkpGv+RWAY8d5z9DEJ2qhEse3k8QyyhkVyzcZJD/DLmqwH
         i7hRGFdTevKfcWnsH6+w+TNUmTC4B0j/idNEa7q1Jfywv56w5Ow8kSnOlfkQ4Z/ruJsK
         pdZmP2spymCwDgpulBq8edw+AsAyoSWN+NbE+SOXtcPZ3Y3kIf616YPO+pv9LdA2Osng
         uNIAlZhdcrcapleIxXwAFGlGvh85E2rsuzJmaXg4rpLiJVDrebCISQBAMtrKknRdG8fd
         HvsZc7WORAdRjJi/zWuqUk319AvV2WcdCsryDvzdLxg3EFLVf4+1iopDwD0a3z/MF97w
         6svQ==
X-Gm-Message-State: AJIora/ofOaobw7zLuKp36BE5EhnQhsbLXnrH94Y0FcZ1muW9Ggd4BND
        WfuJfS5CDxlwFaPtGkewNB59WA==
X-Google-Smtp-Source: AGRyM1tPY+iS5RNpkA8nAJfTHqN1aiU4tOpl3nsbv+m0ThfN9FW2NaL8g7K8RL0Q5IixxkhtMl1puA==
X-Received: by 2002:adf:d1e9:0:b0:21b:c8f8:3c16 with SMTP id g9-20020adfd1e9000000b0021bc8f83c16mr12265818wrd.659.1657456533117;
        Sun, 10 Jul 2022 05:35:33 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 08/12] thermal/core: Add thermal_trip in thermal_zone
Date:   Sun, 10 Jul 2022 14:35:08 +0200
Message-Id: <20220710123512.1714714-10-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
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

The thermal trip points are properties of a thermal zone and the
different sub systems should be able to save them in the thermal zone
structure instead of having their own definition.

Give the opportunity to the drivers to create a thermal zone with
thermal trips which will be accessible directly from the thermal core
framework.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.h | 10 ++++++++++
 include/linux/thermal.h        |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c991bb290512..a4e730391cab 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -113,6 +113,16 @@ int thermal_build_list_of_policies(char *buf);
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
 
+static inline struct thermal_trip *thermal_zone_get_trips(struct thermal_zone_device *tz)
+{
+	return tz->trips;
+}
+
+static inline int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
+{
+	return tz->num_trips;
+}
+
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
 void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 03e968d61471..c7fcb9e2a4fc 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -125,6 +125,7 @@ struct thermal_cooling_device {
  * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
  * @mode:		current mode of this thermal zone
  * @devdata:	private pointer for device private data
+ * @trips:	an array of struct thermal_trip
  * @num_trips:	number of trip points the thermal zone supports
  * @trips_disabled;	bitmap for disabled trips
  * @passive_delay_jiffies: number of jiffies to wait between polls when
@@ -165,6 +166,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_hyst_attrs;
 	enum thermal_device_mode mode;
 	void *devdata;
+	struct thermal_trip *trips;
 	int num_trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	unsigned long passive_delay_jiffies;
-- 
2.25.1

