Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBCF56CBBB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiGIWdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGIWc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:32:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC23C2A250
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:32:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o4so2614404wrh.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWXSn875oBDJq4Q/0NyDjwM2E/hA/gxhBWxbmBReloU=;
        b=o7JVRHYVfcul4OsqSwYRYPwnc7kaBwGWcy0Q7KTjK+F8T0BtG9AIrCOBziM2A6RLQu
         bU9dxRD06ujY+ZbwApfCBEeINGn2iJ25fvbwULFbE8z/lZi2vHPft6kLtSk995Lk+lLq
         oX1eMYF1dFvo8XFot8n+C4v3wnQDz6YCvG8ccrCyuOc7gVmOi6yUr4UmkR9AoEKhMUmd
         2zDr5xtDRSl8oQ4AFguUadc6MO7F+Tmy5A8nJQa0Uar8tQWK/Am6286ye52NFEBJwI6l
         iMvRkWtjsUKMGNugwBid8NQ0FqEfh11VZD0PghJMWnUyrW0TxbikVDfRJRMqEzsh/hN4
         Kt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWXSn875oBDJq4Q/0NyDjwM2E/hA/gxhBWxbmBReloU=;
        b=8RUVRiyn3rPc0LgJ6WTfD/2VeYV1/eA82V2eUAz4uH/uQ/yTC/Q2FQjJSvYQG48Eb5
         LklTuPuIc1WVLpyeP6eAjV+jKW7s/PTpj4DvCgt7qrRPtBSurk8rv0BLtCZLGMX4llgh
         L9+Oyu+yeYT9iWqoH4vMWzRGaAnuhYMlU+m0XfdG+AuDHEq6A91gZWyNvTZ/O85/Y45c
         6wWYndWYX+OeKGDcdvND1guLYCFpbRNIUmTmZyoF+jN+oGiGgiYyQIX6fJsDs1o1znZU
         9seGicO0uu5zlxWKxBkNXkCmQc8guwspTA9k20/rDK5n44onLMcgEKrByY3Qm1Ylb33D
         ntPw==
X-Gm-Message-State: AJIora8lPG7RnPzT76HcGOIX8vWVRxOHK7LIKH/OyUuiOIxPh98qZ+lu
        cB+de9G5C9nbLC8cp76W8TYZKQ==
X-Google-Smtp-Source: AGRyM1umdJo9ZTc3GyMtiWJlfdUbbBFE1MKOITaUsVXBsD4/Bx9P+7vqwAv/HTFdeUO0cRAagW05HQ==
X-Received: by 2002:a5d:4388:0:b0:21d:691d:7d0e with SMTP id i8-20020a5d4388000000b0021d691d7d0emr9434177wrq.684.1657405975254;
        Sat, 09 Jul 2022 15:32:55 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 08/12] thermal/core: Add thermal_trip in thermal_zone
Date:   Sun, 10 Jul 2022 00:32:25 +0200
Message-Id: <20220709223229.1619339-9-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
References: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

