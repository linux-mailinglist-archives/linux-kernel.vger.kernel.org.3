Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8268E5AF165
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiIFRBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiIFQ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:59:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0080360
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:47:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j26so7220850wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=re6cY3b7LhtgjVns3TGnT3S1+gVlK6XqwvcFa/mv1ME=;
        b=KjpL9gPce9GfquWmLZi31YA4capzkankRSmSWEHvHGCJqpZp2eH3IRWL9Acf5kIS6Q
         3aUZxPD/Y1UXUopYYuU0VdHxx55s4aEMydWcmDkScpww6MJiHOeOwThcDXZ3vDMRRg2q
         fWblLaZ46l7AieQ9aOlvGMcBmR9M0LfhahCz4ifCVJvfhOsCT6nWaFP+dAv2g9LcVxaR
         mCEYrYyZrF3F78hQ/un6Q4+MC8kfyPxOZRXjM0NUBkwM4TWnIfsiC0ie/vnkk5RQP12I
         oxhC6/mvxO+w11rEQF+SjSy0uZupQmyUSKGa99vDaRkAViSg2u6eLndUoBfFHXH1ydJT
         5+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=re6cY3b7LhtgjVns3TGnT3S1+gVlK6XqwvcFa/mv1ME=;
        b=DQWe3pNC7xcgelpUQP/u9fs2nfx3HsQ6W8Kw4L3iBwvoHHDGfwMtybEw8V2xDhhqGe
         NQQacxUhnGBdXravagwkNil1r2Ote/C1NFUK9461gC0VaURJ1z4O9L5E601rOPQUW/Tt
         Xg5WFZWLqDU1H0Q7tU0UZznKPG4Q7hQz3nu4p8dozlqVwHi7+mskldpzOaToM37Dlsty
         mKZu6RS6mCgV8gbeKX2fnxtDiZKW5pW9RtyU3omgU78d4ttF9Jp423/IvGwLRy/C6fqh
         vb6c0ID05o7WL5TVeD36/kXoEQ3KcA+ozdBpT23SSytOUyxluycinJaq0glcGfLAg80Y
         Kf/A==
X-Gm-Message-State: ACgBeo0AFunr5wkQzjRTNE0QM9J0SFEXgEtK0WyfafJtSqxPimEXGmRL
        nWPiD8+KngGNhdRx+KKVYiHiSQ==
X-Google-Smtp-Source: AA6agR5zfI3EV/KSyUhZtILFIlXY+U646eq+jbERhN32np9LTr3WVIhNttonSI7tKZfIDEN518zprA==
X-Received: by 2002:a05:600c:358f:b0:3a6:145:3500 with SMTP id p15-20020a05600c358f00b003a601453500mr14878386wmq.64.1662482860172;
        Tue, 06 Sep 2022 09:47:40 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 02/30] thermal/sysfs: Do not make get_trip_hyst optional
Date:   Tue,  6 Sep 2022 18:46:52 +0200
Message-Id: <20220906164720.330701-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
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
index 75f6b151a58b..18cdd7cd0008 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -424,23 +424,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
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
 
@@ -473,9 +470,6 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
-		/* create Optional trip hyst attribute */
-		if (!tz->ops->get_trip_hyst)
-			continue;
 		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_hyst", indx);
 
@@ -512,8 +506,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
-	if (tz->ops->get_trip_hyst)
-		kfree(tz->trip_hyst_attrs);
+	kfree(tz->trip_hyst_attrs);
 	kfree(tz->trips_attribute_group.attrs);
 }
 
-- 
2.34.1

