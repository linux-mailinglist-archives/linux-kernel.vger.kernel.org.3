Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21E056CF16
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGJMfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGJMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A77F1114C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n10so3848272wrc.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Cg8NIEv3M0ZsrQ6LuqyJLiJb25T+jZLIiP7PzCJ4Cg=;
        b=2tR83h0EGCkoEv7T2lFxnCY/aeBlHG41RKBSE4YTvKcawRtlPIjRh5M7W4XlVGevic
         iXa7QvAM0csp2vl+ruQGWPSoKDWIeRMJI6u8X73oMHTUcPdRWaEPD2kfx+oYciOqdtmZ
         kHFWzqvkIM4qtJF4MzrSjVMdjfxFl30HrRsNf8h3ibsGrYgmBDV3FYukDki+DlllaJlF
         450miA1mwl/uJNuyHDMK8UUUIwf/laLUzGtFHTnbhc/IBtPaKdPQgqBkqNX4JIr62q3P
         xbQfMJ/b21qH7qL6UFCRnlwPi7jRVUOBIm9cMMDFuo1NDd0lD+7oRoOV5E3uOhoLrtCG
         +C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Cg8NIEv3M0ZsrQ6LuqyJLiJb25T+jZLIiP7PzCJ4Cg=;
        b=gkLsiMGMljESC6mhXPbl1m0/WDGKWZroJN1o5cHjgLgma1c1yXasKOne9du4a6jxMJ
         A1E+ra4ywtqe+czKinBZaL1y2C36TmZsuoWhp3tPJWeKPNDBbQAExTz+FIAVYdXDx9q+
         7oq1XmPxNEB95s4dlvjl2Qs4xu6JDj5RppnC5iDRXmz0k3jCvRRJklr67xjrlen/lViv
         NhNmbpzlI1hHpCVAr6a08WAUbS8cvVneKPFloWz37scAQWytm/4v4E9XmglZxFtPBuWn
         SM028FPhtHxGfVpe7wXyKiIq33zQ8toEYQ8bUYjzFT1PcwKPr0Cn5FDnutssn1/XD1pp
         Z43A==
X-Gm-Message-State: AJIora/Qcf+AXrOJSbC/sn4wrOabMN0+4E7Fz3MhuyWlO7OPJh0P3BGV
        onBu4IBS2mleY+II+ny3zita0w==
X-Google-Smtp-Source: AGRyM1sobN42PnLDSkquBXU5EqHk/Cwh2Bjpol+3ULi79i2Hv1oY7VLhc40TjaJsegxcH16grgMeGg==
X-Received: by 2002:adf:fb03:0:b0:21d:70cb:d6b5 with SMTP id c3-20020adffb03000000b0021d70cbd6b5mr11900872wrr.548.1657456520668;
        Sun, 10 Jul 2022 05:35:20 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:20 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 04/12] thermal/of: Move thermal_trip structure to thermal.h
Date:   Sun, 10 Jul 2022 14:35:03 +0200
Message-Id: <20220710123512.1714714-5-daniel.lezcano@linexp.org>
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

