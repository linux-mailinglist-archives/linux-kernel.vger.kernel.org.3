Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DAE5AF1A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiIFRCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239152AbiIFRAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:00:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B0F6F573
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:48:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so9979880wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KY22MjtoUlIwWIKxWwfuHh0wn9QBG3Vjtz/Dduvf6bU=;
        b=aN9PiFxFulWh9P/V4Crz48Fw6Up0k2wSiTJGHPwyPLdmF6RuT7ut5Bz2PC0utfF+Jh
         akGbJVYbzYi5H0EvB2HE9R2mqfLaxaUJLoQS69VxQao6Y1OeE9BjKNLi71TaLhtNyaAR
         RCDcT4W9JkLAr4cFlwHWCEXvrZgWZCutA4ECBl0yWbHsV92jGL2GRs8lFTJfnK4CVAth
         XdmpxvrQ9UVgnjJ+hPaaF3MefxcDVv5Cn63ON374fTl53sH9rcyZoK282N6k5VeX9jxv
         yYE5WJ25AH7LkTtat7FkbSUtlYeDsucK6ZS+Bp806ln6twOJZ2Dh2eZ7uNnHu8/8ROJE
         10EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KY22MjtoUlIwWIKxWwfuHh0wn9QBG3Vjtz/Dduvf6bU=;
        b=VkGUuXT0KeV2ZOVt5Om8S2d3cGhqYvMwJWPcvFRuAw6EtvqktcG7xLVwEowd7vUbrP
         N8/3iT/6qqpSx8PIzaLN14Tc6J/FfrlY1nRVRemk9KN0D3ubmqDLI5KuelYHm5y7o6/f
         Cfntbha8Fg38p9iezHr4pSR1J6HJL7Ucr3bFaVci+0x91ez7x3SG7Jb7qWEH8CdtXyxw
         K/66Xot1gAU2/8kkRAqeboTHnOIWQz0W9Ymk3Zk3LjsR6Om0WywpE+jIWCmoMp+j6TsQ
         If4gnAZiY0ZQ3E99FhuCR8o6kNxgavoit8ziccsnTxUmHkjvZi4ja65AQmWxMpjtgCTy
         eQCQ==
X-Gm-Message-State: ACgBeo0omKLN8jajBuyNPpbZkBIxY1v3RtI/VZQSC7rSl9mc3IwZ4OgI
        wsaBCQ4UCEc1JuewXmZxIhM9lbHpzUncIg==
X-Google-Smtp-Source: AA6agR5r5Ak8QiMHIGoePFRUr0EK5M9YEiNFMot3mkX+bjnBZ/bGRqe2PY/dlL7LW20MtsV1yDNLPw==
X-Received: by 2002:a05:600c:3556:b0:3a6:220e:6242 with SMTP id i22-20020a05600c355600b003a6220e6242mr13850056wmq.145.1662482881017;
        Tue, 06 Sep 2022 09:48:01 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:48:00 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 19/30] thermal/of: Remove of_thermal_set_trip_hyst()
Date:   Tue,  6 Sep 2022 18:47:09 +0200
Message-Id: <20220906164720.330701-20-daniel.lezcano@linaro.org>
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

The thermal core is providing the generic thermal_zone_set_trip()
function which does exactly what the OF ops function is doing.

It is pointless to define our own version, just remove the ops and the
thermal_zone_set_trip() will take care of it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 4e54d62720dc..494e9c319541 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,18 +19,6 @@
 
 #include "thermal_core.h"
 
-static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
-				    int hyst)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	/* thermal framework should take care of data->mask & (1 << trip) */
-	tz->trips[trip].hysteresis = hyst;
-
-	return 0;
-}
-
 static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 				    int *temp)
 {
@@ -541,7 +529,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
 	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
-- 
2.34.1

