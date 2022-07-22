Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04157E7C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiGVUAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbiGVUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:00:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A852E55
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so5818032wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKRi+GmwXFnPZbvdKLtGDHFP5gB36/7lKJQI47b4ftU=;
        b=SuIi2BPEaOCamo8F4dt60V4K3a/ZMV9tpP7ZInqWFBBMAOTEBHFXqmB/SmL0ePbY9W
         m68Zz61vWLMLlZfBLeneW3F1SVXVzRYOn5NvwOMA2KIYzyijsqsqsS2rM620dp6FiQwD
         Nbna8zakZ2wtHbrM0M8SinIW0oc/F0QWephdw0DQyPgpzbw/NljkNWhKCNPTajD4srXN
         XQdY+ztqKAjh4jwbmV6jxI+7BofV2ObkKEBBhmp4aBKay8Cf1ykZMJHDxWh+Oe8zaqPq
         T1y512leznpoIdFCr/C4eBGQL3BAKPo1JF5Sve9P850Ed9yuZxbhC2Aj4i/fTF3ofvu9
         TW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKRi+GmwXFnPZbvdKLtGDHFP5gB36/7lKJQI47b4ftU=;
        b=DfUdSIi6E2UMG2hnPJ3REEMtQTKKH/QSSr/dI/+IpgfVJwTJNR/XLJD4ZyHRxJdlxC
         4Rey6mKEFrXCDVFGpIhu0Ciy5pUSVIXVj5LwJc+jNKbObPlfxN1zKPKe0vTdyl21MU3W
         3tBCb4rBNc+Jxbazhp01k/9o66Uv6nFPtuDbyqX1a/6F7f7W6f//RK4Olb4GleK6cfcR
         KyNqsbJFzOMAi7wxlRDrlguG13lQasXaVSGFl1l0jwEl/XkZZhv26QWXBsFW8B406P1N
         pEUKIaVLLmMahJPY16eEltT3iVIsEyIrVO23sZqghUIpPhUOV/VWkWkZg3gshF8G33/E
         /SAQ==
X-Gm-Message-State: AJIora+hMS7zM2FmImzWqvjsJG//+QZXVmFSAOTwfiGsancFTZ96uXfV
        VlDxsMnL9z592t2RO8CnFWsgPw==
X-Google-Smtp-Source: AGRyM1ti22mtKLYbr5cawcbMgI7Jnwh855ikTVJk6SmicfawczFM3OeTFtDdx88EHkKMRfqJToRVLg==
X-Received: by 2002:a7b:ce8e:0:b0:3a3:1b01:8e7 with SMTP id q14-20020a7bce8e000000b003a31b0108e7mr13575204wmj.31.1658520032914;
        Fri, 22 Jul 2022 13:00:32 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm6429008wms.0.2022.07.22.13.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:00:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 03/10] thermal/of: Remove the device node pointer for thermal_trip
Date:   Fri, 22 Jul 2022 22:00:00 +0200
Message-Id: <20220722200007.1839356-4-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node pointer is no longer needed in the thermal trip
structure, remove it.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.h | 2 --
 drivers/thermal/thermal_of.c   | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 726e327b4205..ff10cdda056c 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -70,13 +70,11 @@ void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
 /**
  * struct thermal_trip - representation of a point in temperature domain
- * @np: pointer to struct device_node that this trip point was created from
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
  * @type: trip point type
  */
 struct thermal_trip {
-	struct device_node *np;
 	int temperature;
 	int hysteresis;
 	enum thermal_trip_type type;
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 7d96494ef94d..19243c57b3f4 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -867,10 +867,6 @@ static int thermal_of_populate_trip(struct device_node *np,
 		return ret;
 	}
 
-	/* Required for cooling map matching */
-	trip->np = np;
-	of_node_get(np);
-
 	return 0;
 }
 
@@ -1001,8 +997,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	kfree(tz->tbps);
 free_trips:
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	of_node_put(trips);
 	of_node_put(gchild);
@@ -1028,8 +1022,6 @@ static __init void of_thermal_free_zone(struct __thermal_zone *tz)
 	}
 
 	kfree(tz->tbps);
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	kfree(tz);
 }
-- 
2.25.1

