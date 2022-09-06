Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD665AF174
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiIFRA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiIFRAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:00:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C91180C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:47:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso7816681wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yxHcU1hX4elGm4XFMd+giLQwBSqd0y+6MVuYVIhVRhA=;
        b=wC0u5ZDKxe8XektZYNhAzGgvvSfEj7QchsVhEdjnPiI4VTbCufKAwpamuaVENu/3cj
         Ggl91i5CGv+W/OtgeYuGftKjatlwKhcNy7tBrxLnY5a9+/xJry8qDtOEPR0A0mMPAxWR
         5HPfLTdxjxV/OSLWCIQFFnVapWizHqJf2OZAWNCz0ziMTh+WQrNJrzuqeqQdj+692WMW
         RQkG2wze3vtJTx2MsXa8qOBl2v28YoGZA+2FnVXH+Mv2A/BRoUc1v+baCjjvyf7/gnTr
         Tzd01xWRK4oVdiWQbCoRjSZ5OUmDWqhqAB1ffi4A4wI1m5orpAaiXM2Dxmp5J77hz0bd
         9F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yxHcU1hX4elGm4XFMd+giLQwBSqd0y+6MVuYVIhVRhA=;
        b=iQKWBi3eq1/q+TKsU1vLwWy+UJFmCkjaKoxW+jAafrhkBYw7lhQP5p/sPL30RvtLXW
         /xhZ9beSP9IoARU6ATgkuPUn6dp+VIIP89hMhRUZNKPFhlzq/xJen0+z09Ebom5mex5J
         zqEeas2hQERwEz19TaWA3iVEdbF3B7PBJrmgCZM8W7ueDjJqVvxjoxuy80A5NV6sSwvZ
         XxqnHg7HZFASPr7PABMgvVl7AYtg6fw1uagnN2ANj8CnBQkbGyejownZFs3FA55zKZpD
         7CBYtE85yKa6noMHFBLsHAz0e+Ua8kWjL4EepDSqydfXeDusjXqXQQnY7Iu2PkyMLMjq
         eyAg==
X-Gm-Message-State: ACgBeo2kZT6AWGDpxgf9Losr+kAxPoTAeeVDLnUvXfy0aF57wk3RiHE1
        wP+U27FSRoENEwkrZ1+KwUXC2A==
X-Google-Smtp-Source: AA6agR7zpWKGpwuAeGWCXAABPKqNUO2h1nGOBfQ+nCTtY820MxbzTgfZPxJXHaBZLmpJMmCpfXVnnA==
X-Received: by 2002:a05:600c:a0a:b0:3a6:71e5:fb70 with SMTP id z10-20020a05600c0a0a00b003a671e5fb70mr14114058wmp.141.1662482862434;
        Tue, 06 Sep 2022 09:47:42 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 04/30] thermal/core: Add a generic thermal_zone_get_crit_temp() function
Date:   Tue,  6 Sep 2022 18:46:54 +0200
Message-Id: <20220906164720.330701-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone ops defines a callback to retrieve the critical
temperature. As the trip handling is being reworked, all the trip
points will be the same whatever the driver and consequently finding
the critical trip temperature will be just a loop to search for a
critical trip point type.

Provide such a generic function, so we encapsulate the ops
get_crit_temp() which can be removed when all the backend drivers are
using the generic trip points handling.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 27 +++++++++++++++++++++++++++
 include/linux/thermal.h        |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fa0f89a24b68..2495c174a226 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1144,6 +1144,33 @@ int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
 
+int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
+{
+	int i, ret = 0;
+
+	if (tz->ops->get_crit_temp)
+		return tz->ops->get_crit_temp(tz, temp);
+	
+	if (!tz->trips)
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+
+	for (i = 0; i < tz->num_trips; i++) {
+		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
+			*temp = tz->trips[i].temperature;
+			goto out;
+		}
+	}
+
+	ret = -EINVAL;
+out:
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
+
 static int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 				   struct thermal_trip *trip)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5350a437f245..66373f872237 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -343,6 +343,8 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
 
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
+int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
+
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
-- 
2.34.1

