Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBB556CBC0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiGIWdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGIWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:32:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C13A286EF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:32:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r14so2620718wrg.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3yHMzkH3fXgNxlTdZV4uJD5eQrxfqVqNnQSzgsUY+c=;
        b=24xBtJgtSBDKylRS46FvI0oI+VUMvnqGnrZVjJQfK/v2gF5KgV1/LJyH6zzhtwmARp
         5Q3f39IONBzdBFv9wMgg2zD30vN5Vk4CwZViZ/K68toixnsEeCbnTrhUb9u6mac3vL59
         4aYo825VYEj66rt3KRza4OGuNbMLKt5Pf0ekztEKCqIjFbIl/tNKbPCQNJzPej3M42Nr
         5nhpTV74T/Odj6ns9hgRrEyRFu3mr/zyipqkzLiNSSUM9t8HVdAaQxRhbU0bHn8z5+vq
         UVpcMEvE3Mkw2BgokQJBj7dG/oyMHD9DDqopGlP1q75TCNjt2Qua15KoCLR/9Y6pxbDh
         I9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3yHMzkH3fXgNxlTdZV4uJD5eQrxfqVqNnQSzgsUY+c=;
        b=cAhYQVGfWSxQEz+QotwhCTgv4OLjszwFL0hMjxoVv8HETWHcUPW4UPeas0xiWInOfh
         X1OMZFRLq+lawH+WOhFNXAsXcJsp17JtsopmOUQziP0Qm6QQKw4iZpV3JbFlIgwDXUIY
         t6+c/XbknTX6W+GYNPgiU9NcLNk3YGQp3XuouUEEuFi6wnO/M2baIlBUaM11Gg8ltEnU
         tT8MHsP9kauTi1+IFtH4/pViUBy5acXsC1LypuAFN9hnM8quZWUITGyY3G71i8QMJPIf
         ZWiB4SJzYNiQZ2pDwPYqmo3UjfvOO7dlD342Avd028+oTRd/xqRJz637jfB9wAgYfC5x
         zklw==
X-Gm-Message-State: AJIora+k9VivoCubf/uTyTQEUx/xMlrHPmSRTSZmS2Em4kZygwNA5OpA
        oPpMjncFoRGOBpB4O++v/P+2wA==
X-Google-Smtp-Source: AGRyM1sIFcInXH4TeuOaGsIA0l3LNcz85kdgn0+Bvonwwm0YBYGrp1zS91z9BF30Oa7s+kVT75OwZA==
X-Received: by 2002:a5d:48cf:0:b0:210:1229:2e7 with SMTP id p15-20020a5d48cf000000b00210122902e7mr9796471wrs.567.1657405968103;
        Sat, 09 Jul 2022 15:32:48 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 06/12] thermal/core: Move thermal_set_delay_jiffies to static
Date:   Sun, 10 Jul 2022 00:32:23 +0200
Message-Id: <20220709223229.1619339-7-daniel.lezcano@linexp.org>
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

The function 'thermal_set_delay_jiffies' is only used in
thermal_core.c but it is defined and implemented in a separate
file. Move the function to thermal_core.c and make it static.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c    | 7 +++++++
 drivers/thermal/thermal_core.h    | 1 -
 drivers/thermal/thermal_helpers.c | 7 -------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e22e7d939c54..a8b1628937c6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1159,6 +1159,13 @@ static void bind_tz(struct thermal_zone_device *tz)
 	mutex_unlock(&thermal_list_lock);
 }
 
+static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
+{
+	*delay_jiffies = msecs_to_jiffies(delay_ms);
+	if (delay_ms > 1000)
+		*delay_jiffies = round_jiffies(*delay_jiffies);
+}
+
 /**
  * thermal_zone_device_register() - register a new thermal zone device
  * @type:	the thermal zone device type
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 60844e2d59bb..c991bb290512 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -112,7 +112,6 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
-void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index f4c1e87ef040..60bfda1a1db7 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -174,13 +174,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
-void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
-{
-	*delay_jiffies = msecs_to_jiffies(delay_ms);
-	if (delay_ms > 1000)
-		*delay_jiffies = round_jiffies(*delay_jiffies);
-}
-
 static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 				       int target)
 {
-- 
2.25.1

