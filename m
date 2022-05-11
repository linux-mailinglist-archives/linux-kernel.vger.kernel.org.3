Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72065236D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245610AbiEKPND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245548AbiEKPMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:12:39 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E175F8D0;
        Wed, 11 May 2022 08:12:38 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-ed8a3962f8so3174698fac.4;
        Wed, 11 May 2022 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWVV90oYpi4dWYDQ2mZpGM9vUZygMcQs9ZQl2WC1Reo=;
        b=YMSModPq/NltiVm3CaGLRZJ5MvAnSy6N4eoa4dSUqfmOSzFgoOKcm3D3NcjIxBM+jP
         WD6+i7dU4d5OIi48RAhaspZ2VRTheb6NdyVbmwYEk64kIb32KgqJQ2LMKaWPu904Sh/q
         vO8K7Z0pF0OyKhfBZBNETu03BttIXSUaaeKAgD0uZV3UZdjoK8Y5UrdxhW270e8hU4jj
         vIlte5TKL3UukZvAb5pfHIlzZ5hlU5nKurwMvldxNGaHMPx4taux94vLtsJUmO8Ore0o
         mZjsnNILOZF06oS7QRyk1NfO2wM6wO1UVfk3SsHGMs6LWNDklWAL75Nh6VUSP22jTYnx
         fESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lWVV90oYpi4dWYDQ2mZpGM9vUZygMcQs9ZQl2WC1Reo=;
        b=hIv9MUkxbrxkUKVGYxFRGJzBNVyXSl7PJNshegKLfH15mFPxZ6LC+KQ3FN05RopHKE
         i6FNR685Ego229EQuamaeQRhiK3F6zt7gxWo55iQO4v8hAP84bQFTDgPJd7fKadk5hKg
         6pqqUgjcohMFwgfD4PjNe9hkY9YryYPgLp0tr8kcfIxo8xDsJAoK+pmfWoT6WHlDemiq
         pcSNCV216lvdnBE4xF692rBBU34/3uPuVXx0mmXiin3FiOPWD1yUxk6WG/yS4JfcT1WP
         jesneedC7Z47qVXB8+BBIEtyic/h08pOv0DuLVecUCSrrgwzDDItFrkehHk/BTVyI5Mo
         JOpw==
X-Gm-Message-State: AOAM533JVcGtcVdlSK0WFmb+PTjkyM6QmMcoUbvaN5oNTPX+t29pARCk
        nkzriTG16NdQuU3qhUhkh9o=
X-Google-Smtp-Source: ABdhPJyZtfT41OEAJN7SYN5skLyaan98nvwQQQ/N3h5pVIAPPFAsizBEODUCEvyMM005MmhHpQoHRg==
X-Received: by 2002:a05:6870:2301:b0:e2:d57e:1c22 with SMTP id w1-20020a056870230100b000e2d57e1c22mr3067987oao.244.1652281957985;
        Wed, 11 May 2022 08:12:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t13-20020a4adbcd000000b0035eb4e5a6b8sm1006421oou.14.2022.05.11.08.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:12:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/3] thermal/drivers/thermal_hwmon: Use hwmon_device_register_for_thermal()
Date:   Wed, 11 May 2022 08:12:29 -0700
Message-Id: <20220511151230.2983227-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511151230.2983227-1-linux@roeck-us.net>
References: <20220511151230.2983227-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal subsystem registers a hwmon device without providing chip
information or sysfs attribute groups. While undesirable, it would be
difficult to change. On the other side, it abuses the
hwmon_device_register_with_info API by not providing that information.
Use new API specifically created for the thermal subsystem instead to
let us enforce the 'chip' parameter for other callers of
hwmon_device_register_with_info().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_hwmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index ad03262cca56..09e49ec8b6f4 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -149,8 +149,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	INIT_LIST_HEAD(&hwmon->tz_list);
 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
 	strreplace(hwmon->type, '-', '_');
-	hwmon->device = hwmon_device_register_with_info(&tz->device, hwmon->type,
-							hwmon, NULL, NULL);
+	hwmon->device = hwmon_device_register_for_thermal(&tz->device,
+							  hwmon->type, hwmon);
 	if (IS_ERR(hwmon->device)) {
 		result = PTR_ERR(hwmon->device);
 		goto free_mem;
@@ -277,3 +277,5 @@ int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(devm_thermal_add_hwmon_sysfs);
+
+MODULE_IMPORT_NS(HWMON_THERMAL);
-- 
2.35.1

