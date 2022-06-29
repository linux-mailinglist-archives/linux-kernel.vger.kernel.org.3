Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3C56042A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiF2PMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiF2PMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:12:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F48A3EF06
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:10:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so22927080wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3ZYq3bcsj/UjtaD25DcyTAm2D/1RmGVwIAKcRPY+eg=;
        b=CmfYYcfr9K4XbkT5SOVFmJr3HuPO8kzgs7aT8gxU2yyEUPp6GOVCS8JG+2P3gzMlbj
         yKeowkAkIbJykRtw72dw9FERYSt6OhnDV90lVoenDJ6YiMW27N0D3oCzJdSLLG33V9C1
         wL6nDNlwM4meKfHLoGHjvaKpuzsQ88v+Qu7lYNugA3HQl5BIxNkR/fzCJDge2CCkLdJg
         oRd6Ld+/46jhOoHppRz+S5f0j7K+V2Zq9ZeJsgKBNEKDiDYxRXSVqEyrxjjvQovJqeFm
         GXVEdxkh3WDLpVa5h/tX89cGWi2oD86jhuiQIq7Ft6t/jCFpOSHR6nRELoiSIxGwQe8V
         EeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3ZYq3bcsj/UjtaD25DcyTAm2D/1RmGVwIAKcRPY+eg=;
        b=C1TlKOlqi1s5/+s9E8Q36Oydyfxy1yWF0TkYzerwiCWTllGtHxxLy6rClpzBHp66dD
         JP7msb35ugUoMeodkEiWQTcOdNMAbSyRjROjOUM+hzongPblK6nes7sSXRCF9eD0/gUg
         Qk88VOuA4boKOEdoVJebc4tiTGx0eRxpBAbCi2KlSazG932gjxhqHdnH6WhfbGPsU81Y
         Qxb6Ag4tGERoF2O7e3cy7xoSBqRCpVejw4Tx3oTte7Z38AbVZdJ5IW0krYbOOMw5TCz6
         U0aXhPyCdXCevYQmah33cqI1KUmtf1lZ9DkzMcpHzHg9wv0tM0YKrQHrORGUVzeq5LXU
         PF9g==
X-Gm-Message-State: AJIora+RVE/Um4xHr0cNfWHHypuQz5xT4LPEMVmQSh3o8vXZEAMJ8mYp
        9Cg18O7BFP2tTH3HXB3vOkOu9g==
X-Google-Smtp-Source: AGRyM1vWMbd1NwnfZaHax5oHnxcFN5zGrIUsdhYd0b6WXkGuttwDKXF/INDjHiqVGqyNHSzC+DHU/g==
X-Received: by 2002:a5d:604d:0:b0:21b:9b2c:be31 with SMTP id j13-20020a5d604d000000b0021b9b2cbe31mr3710411wrt.91.1656515427060;
        Wed, 29 Jun 2022 08:10:27 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b0039c4d022a44sm3509029wmq.1.2022.06.29.08.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:10:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] thermal/core: Use clamp() helper in the stepwise governor
Date:   Wed, 29 Jun 2022 17:10:11 +0200
Message-Id: <20220629151012.3115773-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is actually clampling the next cooling device state using the
lowest and highest states of the thermal instance.

That code can be replaced by the clamp() macro which does exactly the
same. It results in a simpler routine to read.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_step_wise.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 12acb12aac50..6efbfaf014da 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/thermal.h>
+#include <linux/minmax.h>
 #include <trace/events/thermal.h>
 
 #include "thermal_core.h"
@@ -52,10 +53,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 
 	if (!instance->initialized) {
 		if (throttle) {
-			next_target = (cur_state + 1) >= instance->upper ?
-					instance->upper :
-					((cur_state + 1) < instance->lower ?
-					instance->lower : (cur_state + 1));
+			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
 		} else {
 			next_target = THERMAL_NO_TARGET;
 		}
@@ -66,10 +64,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 	switch (trend) {
 	case THERMAL_TREND_RAISING:
 		if (throttle) {
-			next_target = cur_state < instance->upper ?
-				    (cur_state + 1) : instance->upper;
-			if (next_target < instance->lower)
-				next_target = instance->lower;
+			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
 		}
 		break;
 	case THERMAL_TREND_RAISE_FULL:
@@ -82,9 +77,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 				next_target = THERMAL_NO_TARGET;
 		} else {
 			if (!throttle) {
-				next_target = cur_state - 1;
-				if (next_target > instance->upper)
-					next_target = instance->upper;
+				next_target = clamp((cur_state - 1), instance->lower, instance->upper);
 			}
 		}
 		break;
-- 
2.25.1

