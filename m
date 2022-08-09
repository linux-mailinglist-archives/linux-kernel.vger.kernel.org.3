Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351DD58E26A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiHIWG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiHIWFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99DCBC22
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l4so15720022wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FDZNsuY2Fz02k6+2isiLLrmXfm/GSYt18ZvQTGmfKxk=;
        b=D/wpuEd826M7uLn1nuZvCb69MBy+JlPzPpuLzqpKQlS7eVVJ1LqcnVW4GVSw37atQU
         uIpglDfeo9dsn06GSK6ONB7epSxQmZVM5xjNMoESmj4wvknyvMVBJ0jaenuPpeQrkDl2
         NWrEoOikJWWIIcgnqBIRwZ5ojuO/C+D3PSaBJtRb3r3DAC1Q1r23vauZNIGPrJmUep8X
         4hHhOQCASr+4hVVRYvNUAM2BfKYqe5uGtR6efdrRB2mb6a0BBBKd5iZcVWpkwguHAiPh
         0UZMsKbSMrQ9qYYE++1n8XLl/24ABxrVHXzZ9akN+Te1m4QwYWoXl74tj8lgSGy71n5+
         zbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FDZNsuY2Fz02k6+2isiLLrmXfm/GSYt18ZvQTGmfKxk=;
        b=d6Kqk2+EiRhbKzS2CaZBnKQlFe0jihVdWuXfNfUlxpHzvrcyKbxo46/NLuSqBq5TdA
         5xNNZT0mEEyqWNaqRrtkVqPQKR76FBldY30ZP9elkIFUU5Ti3RYqg18At+j9ZCriFufb
         hKicskOwHD+4H6mkrHgM+K23l9un2Q/GKYWxkcZ/TauohaKr//eNt+d8oq2XO2nL5OaS
         YQr9dU8kusWR4rvlaRG8sePI3kXxrY5J59nfBFD12Tuh55tj/EFucZM4CrXDUCWvwehG
         Ovb/L8mWo+XD1jer0aPPAJhEyT+Mtv9qk+Fqx8FJ1Vjh4rbm7Xnygx1BIwn1HaZVcmP+
         J+eQ==
X-Gm-Message-State: ACgBeo3kIZnoV5WBzzsI5qkv1AewvIxG5TISL039pdeZvPQsRtuoEobp
        ZU8UxoTaCm95pQRmvuZNMSEAA/gMZgCOHw==
X-Google-Smtp-Source: AA6agR6y2W3+rO3v7v71n3PyD6PyZL03SK/5X/O4VqZHdh4YluhRPu0ukUOO9xhV1Ehjzj5bcq4qEg==
X-Received: by 2002:a05:6000:549:b0:220:5a5d:e2e2 with SMTP id b9-20020a056000054900b002205a5de2e2mr15931000wrf.695.1660082712447;
        Tue, 09 Aug 2022 15:05:12 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 12/26] thermal/drivers/OF: Use generic thermal_zone_get_trip() function
Date:   Wed, 10 Aug 2022 00:04:22 +0200
Message-Id: <20220809220436.711020-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

The thermal OF code uses the thermal_zone_device_register_with_trips()
function. It builds the trips array and pass it to the register
function. That means the get_trip_* ops are duplicated with what does
already the core code.

Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index fd2fb84bf246..70171fb4283f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -71,39 +71,6 @@ of_thermal_get_trip_points(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
 
-static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
-				    enum thermal_trip_type *type)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*type = tz->trips[trip].type;
-
-	return 0;
-}
-
-static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
-				    int *temp)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*temp = tz->trips[trip].temperature;
-
-	return 0;
-}
-
-static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
-				    int *hyst)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*hyst = tz->trips[trip].hysteresis;
-
-	return 0;
-}
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
@@ -670,9 +637,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->get_trip_type = of_ops->get_trip_type ? : of_thermal_get_trip_type;
-	of_ops->get_trip_temp = of_ops->get_trip_temp ? : of_thermal_get_trip_temp;
-	of_ops->get_trip_hyst = of_ops->get_trip_hyst ? : of_thermal_get_trip_hyst;
 	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
 	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
-- 
2.34.1

