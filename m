Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C785AF18B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbiIFRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbiIFRAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:00:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58C480362
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:48:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso10001078wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OHXbaNWdyZ0Wkkc1xL/nI14ReQ0AVnlGlwSXS+lV7dA=;
        b=CzyMlGwNMuWv+cFzFuo6jtNX8TSHXlGC9Xzcc4djbsEt1Nolp+eTdLRV1XA3YiMPt7
         YpBDmcaKi+4RkPydZnvdstdcn374ChRdgiDIAQ1T/Uun5itQ6vWFF7EOPR2JokY+pJ5O
         eRDxxZMjXLM9v66sLZQmGN8XxHxZ7ChMl593W95N3v4zjSe4ESlzQOrnCRFTQC7wSMPK
         hfegFwwGJuwoCbuMq9VqF5ZXFQYGtgtd6KpGq21o4SH/JgZFbOvrhx3Hhp9w/EK7AsiJ
         0SpSm7uBBmZThHuIHs42ZyJCNDtXdCprHlhOiSiqIhe1t1mikgzroY4GLpofvEwA/y7W
         kD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OHXbaNWdyZ0Wkkc1xL/nI14ReQ0AVnlGlwSXS+lV7dA=;
        b=iiEvhonqLadNS1IryEDZjAI14SKN+kOjfohtWNhdWrdSHt49SSninh0yjxkVhUc0ll
         s9jOoqYlUelyKPhlXwFea+d5VRNG+/m8CQTPqA1lI2AEI6dIkIW1xJxaRQDpHt7moo8o
         2lCfDxZJS/LsGio5dSHFA7r1HrACK9XJO1v+cNZoOay5HY1jXHJy2/yf8yK/sglK2Uqk
         e6VHLDNGwiA+HRbOae9ODWpi258tKKIIKpQ7pEIkLPSx4tLkYNZwXjmGU1G2QpI23FUL
         fkjH0Pc/QeetMVA3MEr8PeGJy1HwmFv1g5oPljHnQydLnABI/rpX9VgK4ltx1gGrx5su
         4Pow==
X-Gm-Message-State: ACgBeo0CWkYanwRYqGbUFKSJAR4k02pzBwxNQQid5Qa2nptDrWKj+WV9
        h2mqADwOcbdG3a68QHX7RXmHlw==
X-Google-Smtp-Source: AA6agR59Lc5T6LmLLEGeP2MxLdnTw/CCIK7z4Jk5oL8Yyf+mgy2XuAwlPGWqQyEXR6G0r0LTbmqrGQ==
X-Received: by 2002:a05:600c:2256:b0:3a5:c27d:bfb2 with SMTP id a22-20020a05600c225600b003a5c27dbfb2mr14019410wmm.102.1662482882025;
        Tue, 06 Sep 2022 09:48:02 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:48:01 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 20/30] thermal/of: Remove of_thermal_get_crit_temp()
Date:   Tue,  6 Sep 2022 18:47:10 +0200
Message-Id: <20220906164720.330701-21-daniel.lezcano@linaro.org>
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

The generic version of of_thermal_get_crit_temp() can be used. Let's
remove this ops which is pointless.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 494e9c319541..bd872183e521 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,20 +19,6 @@
 
 #include "thermal_core.h"
 
-static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
-				    int *temp)
-{
-	int i;
-
-	for (i = 0; i < tz->num_trips; i++)
-		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
-			*temp = tz->trips[i].temperature;
-			return 0;
-		}
-
-	return -EINVAL;
-}
-
 /***   functions parsing device tree nodes   ***/
 
 static int of_find_trip_id(struct device_node *np, struct device_node *trip)
@@ -529,7 +515,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
 
-- 
2.34.1

