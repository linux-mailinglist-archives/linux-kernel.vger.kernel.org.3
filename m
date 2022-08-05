Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C942758ACAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbiHEO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240984AbiHEO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:57:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD794D807
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:57:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p10so3523614wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IVRxvoFqwRQnZhAcHxHZbeumlslt03wT2RECT4OCZkw=;
        b=KG8t4thEXO1EAMM4g9SuMmBUNntB3ar5OMy7/FF6n6ke1vU1zR06HBoXeP/K50oyc9
         uh+WhmRzqb/0lt+afKXlT7f++5+1IyrZV+GXCBaz677/7NEbtbgRgeTOzR5lZZGq+/Jl
         hjOOTNNyTLUpWuA0AEf9X6gqYbWcOgdNljsTcL8n7/vNNfS6TYe7GbNhXFbPpGo9BxU9
         l/8B2TIYONsaGa9hM4O4of0hdWgmtf87dc3yF44cPywFRl/EXKNgdv/SP1d9/8wqSRoo
         /v6JCHKAkEG+O+TfkVl72kEu+WomU4JWt1Lpwfp4U6ERj1LOKxvj7xCVovl2sn7nbsYA
         DrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IVRxvoFqwRQnZhAcHxHZbeumlslt03wT2RECT4OCZkw=;
        b=QvPpZIhayZ2UPCfFXsQp21Mv+QJBekhpd5bRkd5a/OWg76dNfszOLaoJdVlLcTsU1c
         00jEDIe+Jki1mNs9gu5mjrJeYr5wmuAb5OUhaT11ePOIgq1zeQMv5kF8BBSq+PvUWOgW
         hRMyPp8XJqSnqtSAyWbODDi70E/celTiaI+arepCtSXvbQsgqQS5TlKlggtFbBw/x1gX
         LMCyDqtdvYm5gsfQfHU5MH4mZpwZxTKsjqUksYOfBuk7oGIW67Q3U5WEvo3NseJYEviQ
         EnBUee9WpJFftROXfGzb+p6YwM2tS5MQgi7dpzVefTajKk2EGZPgEOtvCuvoCrRXNdCw
         9XBw==
X-Gm-Message-State: ACgBeo3bA2nlc5jzYOx6kKi/TH1EY9u10kfo0ASiNXYcOnJYfKOc0rdO
        Mg0lsvnWPAgCR4qBeRYUcVrOpw==
X-Google-Smtp-Source: AA6agR6hFCyfpTZi71oTguTbP9QzIkTPi3a8OyWcF0iGylWEyCSab7M7hW8AKmmjYCMECjxsUIVtTQ==
X-Received: by 2002:a05:6000:235:b0:220:3a22:fe38 with SMTP id l21-20020a056000023500b002203a22fe38mr4647889wrz.419.1659711465256;
        Fri, 05 Aug 2022 07:57:45 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:57:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 02/26] thermal/sysfs: Do not make get_trip_hyst optional
Date:   Fri,  5 Aug 2022 16:57:05 +0200
Message-Id: <20220805145729.2491611-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
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

The get_trip_hyst() ops is optional. It results all around the thermal
framework code a check against the ops pointer and different action
adding more complexity and making the code less readable and
understandable.

A zero hysteresis value is perfectly valid, so instead of adding more
circumvolutions in the code, create unconditionnaly the hysteresis and
use the thermal_zone_get_trip() function which returns a zero
hysteresis if the get_trip_hyst() is not defined.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2b53927f3263..bc3337826ae2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -420,23 +420,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		return -ENOMEM;
 	}
 
-	if (tz->ops->get_trip_hyst) {
-		tz->trip_hyst_attrs = kcalloc(tz->num_trips,
-					      sizeof(*tz->trip_hyst_attrs),
-					      GFP_KERNEL);
-		if (!tz->trip_hyst_attrs) {
-			kfree(tz->trip_type_attrs);
-			kfree(tz->trip_temp_attrs);
-			return -ENOMEM;
-		}
+	tz->trip_hyst_attrs = kcalloc(tz->num_trips,
+				      sizeof(*tz->trip_hyst_attrs),
+				      GFP_KERNEL);
+	if (!tz->trip_hyst_attrs) {
+		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_temp_attrs);
+		return -ENOMEM;
 	}
 
 	attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
-		if (tz->ops->get_trip_hyst)
-			kfree(tz->trip_hyst_attrs);
+		kfree(tz->trip_hyst_attrs);
 		return -ENOMEM;
 	}
 
@@ -469,9 +466,6 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
-		/* create Optional trip hyst attribute */
-		if (!tz->ops->get_trip_hyst)
-			continue;
 		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_hyst", indx);
 
@@ -508,8 +502,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
-	if (tz->ops->get_trip_hyst)
-		kfree(tz->trip_hyst_attrs);
+	kfree(tz->trip_hyst_attrs);
 	kfree(tz->trips_attribute_group.attrs);
 }
 
-- 
2.25.1

