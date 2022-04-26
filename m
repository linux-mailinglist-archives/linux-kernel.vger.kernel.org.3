Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843B5510BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355729AbiDZWTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355713AbiDZWSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:18:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B9D443E1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e24so7458474wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wH0tuaCVxYZkZwsvsiS/Twq7F92ctIdlTQyOxZZNlXw=;
        b=pflkFKZnYcmXkLfj0oATpR+JBj3hv5X+H+5emrYjR9tVH5KWlAgJnYG3xtlVIgZACR
         2Cy5HCeBC84zhwKk/OMiX/QkJrQATh+pVJgoFeogamogPeRlZ6jkhg2TU0nQ/R/R1MUr
         iKSP/IqVaDNDvJ90tNaxNgQwO3OFeiAg82qElrIYq97ChFhcxvsda+NTdOL1AMRQt29L
         UZdeWAROgEJk/HC0wP10VqhUVqh/yd+QXglwv5PufJrd9Nk/PnMdLDwCWcymDQ0OdCdC
         PQJc8eBKx4SVGr0x72WuyLsIfch/lvEcxeuLi7EJtli8MUmF52qLCwGwiD6j+ch4HR6E
         SGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wH0tuaCVxYZkZwsvsiS/Twq7F92ctIdlTQyOxZZNlXw=;
        b=RBuarRf5vRygKxebCdjvG7Bm9FUI1ciBwN4iFC5g4xVanEnv5/fN2aFTDwl0Xou/WA
         3X6VoRH6cIKDF8VD7iH2rIFmrkdnIi0gMaXsmDsEdDPwJGhitEbKihCWJy7MVnxrIXaU
         IvUv75Agp9yMkcg9gcaFkx6LlG1DFv/L6pB3/2LsXLnbo0b6SZwZBotHPdmYceUxf2tq
         oDDd0EscNiJGSd0UYTLZdeq7rn828E6KkHnxS36bss7e+o09hdC+pKoStmABOvhyZfNy
         e7TWNWc2U3zgQSZxnp0MZSjB/6I2Nae3sQx5OK2DR3p6oMBezHPUeapbn6LrEI9jPM1X
         8a2g==
X-Gm-Message-State: AOAM532oNzoyfhOyzafv/nuRI/lQk/UWuHhWN5hPknTlPWbGmof+FHaK
        ckn/1IahqX6qXeqnD3N3Qz0WU46kw+GdTzu99cw=
X-Google-Smtp-Source: ABdhPJwQX3rj31lXRnPvoC1o5R9T3O58u7/Y+EQPpr6Cuq04nmM8rc0/hXFslDJP86YVr3NJnmksBw==
X-Received: by 2002:adf:f244:0:b0:20a:c3ab:d009 with SMTP id b4-20020adff244000000b0020ac3abd009mr20068107wrp.10.1651011343373;
        Tue, 26 Apr 2022 15:15:43 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] thermal/core: Add thermal_trip in thermal_zone
Date:   Wed, 27 Apr 2022 00:15:19 +0200
Message-Id: <20220426221523.3056696-12-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.h | 10 ++++++++++
 include/linux/thermal.h        |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index ea92a959ad59..04f3d9f80db2 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -113,6 +113,16 @@ int thermal_build_list_of_policies(char *buf);
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone *tz);
 
+static inline struct thermal_trip *thermal_zone_get_trips(struct thermal_zone *tz)
+{
+	return tz->trips;
+}
+
+static inline int thermal_zone_get_ntrips(struct thermal_zone *tz)
+{
+	return tz->ntrips;
+}
+
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone *, int);
 void thermal_zone_destroy_device_groups(struct thermal_zone *);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e58a2f053e1c..9c75afff517a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -184,6 +184,7 @@ struct thermal_zone {
 	struct thermal_sensor sensor;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
+	struct thermal_trip *trips;
 	void *governor_data;
 	struct list_head thermal_instances;
 	struct ida ida;
-- 
2.25.1

