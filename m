Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC356040A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiF2PMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiF2PMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:12:05 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D45C3EF10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:10:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso888513wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/xWzWXDjwfHlllM6Hvtaj2XKm2chFd2jJ2ssW13thU=;
        b=qsokU08JAvgideuDlR9em8hS0EkmPliIb05x2bqVwzfMJUXEcMybvE8u+D9fjuvrel
         3QP+Zfdry1XM7qWyYh1zl7MuHNSyz91nmJf4hqVKCRw+dJ031mY8hDrkA82oAuuy8il7
         fih/AQexicIQKz9WipwwHNAaBGpZrOHEaMVPVJUjEpz85Wk/4YYFHBBENSu662mFOkrN
         BrYhMS/zOn+luxiZSNjz4us5OdpFp23sLI+h4I9mtioJ+WYgB/aoGxHUjHuuvZAhOqqW
         ba9htJQvX6bRUfjigXVSQP3ftiXSqWGJT6OlyTAAayxCEGFUb6ZWnVss1/8dSkOIVNv/
         aXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/xWzWXDjwfHlllM6Hvtaj2XKm2chFd2jJ2ssW13thU=;
        b=TwSILV/tu7iZ+iNlx+kE6PEYdoqpD0ZTyKVT2TrmS5UdKdtKlS+frFrFmvUTL8A6yp
         qZl9obXyK76ikOLCqCpBXmp/9g3PPXuizDsO9yBwN4UzDXnQjsTud/sMQzUz0lH2Gr/k
         gj3dYIpvL5dYbUU48x+Ywf8YUi9YoGZafdwYpvsQ445jWtaox+yDQPbAnLolBVFxVw/N
         XiLbxCuwbgytOx9kSj4p/HMBD8LG8KLiguIRcJ6V0VVWrQNwWv08/DlkKEDRn39l/B7z
         84tZewgDC0k/bFmOdLqBiX53gnYqgQmz8yzKN/xz4Py4xVk7gDxjeJOuv7m21mzQd0Yy
         zDlQ==
X-Gm-Message-State: AJIora9nGIhYv+5FDCeqFPu77i1DPPpfhUhq24xRWwlllaaRG0Z5qoC/
        k5KYHRbTXivn7l6+gPlM0PN3dA==
X-Google-Smtp-Source: AGRyM1sC3dsIpYTDwO198OxJpK+5oBNuhHGguIKYVnPwaVxiGRjAVt7t7Cx8Bi4DEbZwA8B0MrKFlQ==
X-Received: by 2002:a05:600c:509:b0:3a0:45d9:43e7 with SMTP id i9-20020a05600c050900b003a045d943e7mr4209360wmc.176.1656515428563;
        Wed, 29 Jun 2022 08:10:28 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b0039c4d022a44sm3509029wmq.1.2022.06.29.08.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:10:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] thermal/core: Remove DROP_FULL and RAISE_FULL
Date:   Wed, 29 Jun 2022 17:10:12 +0200
Message-Id: <20220629151012.3115773-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629151012.3115773-1-daniel.lezcano@linaro.org>
References: <20220629151012.3115773-1-daniel.lezcano@linaro.org>
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

The trends DROP_FULL and RAISE_FULL are not used and were never used
in the past AFAICT. Remove these conditions as they seems to not be
handled anywhere.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_step_wise.c | 11 -----------
 include/linux/thermal.h         |  2 --
 2 files changed, 13 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 6efbfaf014da..9729b46d0258 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -67,10 +67,6 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
 		}
 		break;
-	case THERMAL_TREND_RAISE_FULL:
-		if (throttle)
-			next_target = instance->upper;
-		break;
 	case THERMAL_TREND_DROPPING:
 		if (cur_state <= instance->lower) {
 			if (!throttle)
@@ -81,13 +77,6 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 			}
 		}
 		break;
-	case THERMAL_TREND_DROP_FULL:
-		if (cur_state == instance->lower) {
-			if (!throttle)
-				next_target = THERMAL_NO_TARGET;
-		} else
-			next_target = instance->lower;
-		break;
 	default:
 		break;
 	}
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 522c9180a08d..c8528bb6c01c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -41,8 +41,6 @@ enum thermal_trend {
 	THERMAL_TREND_STABLE, /* temperature is stable */
 	THERMAL_TREND_RAISING, /* temperature is raising */
 	THERMAL_TREND_DROPPING, /* temperature is dropping */
-	THERMAL_TREND_RAISE_FULL, /* apply highest cooling action */
-	THERMAL_TREND_DROP_FULL, /* apply lowest cooling action */
 };
 
 /* Thermal notification reason */
-- 
2.25.1

