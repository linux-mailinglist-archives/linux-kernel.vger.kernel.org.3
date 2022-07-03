Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F395156492E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiGCSbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiGCSbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:31:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE7D5580
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:31:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso6716930wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raVjxKqEErh+B2L67+xqA5bMSQyms2haK6UW0czdPBo=;
        b=x3xuFSbyzWpkII3FF3+X2kRzXrRCTeSq/nism1nI8JQx0uo+wtA3nTCC91UoBd33Cz
         oESvVBEalCTWXvJsvUsy8YIcNeO8V2QRoqHwN058K5JIfNRH8Ozk5+iXqDVb93KRcdB5
         ONmG/PNKOTOwuolb6R1CDOy5A2f1jSXGWMdI2w+UmZGA6fl0BOaIHiDGkyxzWIZmWc5r
         a9m/nPJfRphMYoQNn/Olo8Agt0KsNpHux/PtiBNV1EC+BC7Qv0LCavgELgZhnf3ZRQyQ
         UY9v4vns82XB/SIizXJ4NJIB9KBv3E5yIgU3vCGAejprMKThk1aeQL+/qQlCzPH9FhpA
         ozWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raVjxKqEErh+B2L67+xqA5bMSQyms2haK6UW0czdPBo=;
        b=HofhU2Ef2U+8Vn6Jr+aZ5xsggiorjJfxm/E+0nQgnUfT9O4Oab4VNKOwZ3gDCQMAuF
         owA4Lmr9MNhSX4Nszkwykp6wAyezevGK2fbxZf18fcrmNNhdhhGkwG5PiZsOHTOaFgc3
         ln9tA2kx0u/+NpakC2up1T0FrKpVnAMk80Ud0Q0BQZg1VlUx4ERuZRjzRv3Id014w61G
         H5HDdpMBX27oU70HZLnvamXhtki5Kzqxd87gp4aWtkU1PEV44aBTluithGehWjHsUM2y
         Xmz4yCPXpvXp9QxMVSkgV5XgkpJr1elYKvSoR7J94X58G1hkqArH1uFcNAcwfMML61Sn
         ye5w==
X-Gm-Message-State: AJIora9n+gbOzV9fVqrNrbG3racUznd7s3jAf5PjjettAmhX5CDbewUO
        LkJGwTfdhPNZUW5h/bGZjYi8HL4b4IkqUA==
X-Google-Smtp-Source: AGRyM1tUz5gLMmIs7wbe3dm4z8qkP4CmQflxr31boSetvZ6qf5tAb2zcGYWDFJ2Gd1PNCfkyjdJItA==
X-Received: by 2002:a05:600c:3847:b0:3a1:db24:b7c9 with SMTP id s7-20020a05600c384700b003a1db24b7c9mr1786489wmr.24.1656873092493;
        Sun, 03 Jul 2022 11:31:32 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 06/12] thermal/core: Move thermal_set_delay_jiffies to static
Date:   Sun,  3 Jul 2022 20:30:53 +0200
Message-Id: <20220703183059.4133659-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
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
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
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

