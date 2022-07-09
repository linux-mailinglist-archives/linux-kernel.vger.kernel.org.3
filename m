Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3826856CBBC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiGIWcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGIWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:32:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F8175A4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:32:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o19-20020a05600c511300b003a2de48b4bbso1659737wms.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UKKS5f7QbJpxlk+iXwxbcq70b7aqG7EJc4B5ZEy8YU=;
        b=K3WpTj9IS4oPO/xbKdn90VqUsZ5OqorLd/R+V9gn4eVgJYfr7JCn1opHg3Yu3q2JKk
         CsZYAuRX31p6y6hWTAGpAWkTMDXLg3vVMgpMULT6TRcgbDuBDpxvoYfCKTaQzSVurlQH
         ZpwEZCaRrprG9k+X4XTjVVCya4BtHd8QSQtY79IL63j52rf9oiCd46ZK8kItgvOvfSjw
         hUlUSM8p04IA08iOp2WRa0+hxCSXm3VmDnIDeqkC/qCJjQqUeZd8M57ic8M+rQXjmq9z
         QFpqpnj6xuIRi4qejPwJL2MYkHMW2gKzZMEGMOZIzT9+3aFCAMw2Fxc3cOJVGZ6OQk5c
         V8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UKKS5f7QbJpxlk+iXwxbcq70b7aqG7EJc4B5ZEy8YU=;
        b=pfLW1Yw8+y14aB7lWph5+cmMndCdEY/ZQMMCZTl6Ghp79TIlEzVn9zpZuATR77vDst
         gPYXQPb9hKRwK4N8EdWXUjpboQ9qAs2Iu/ZjKj0SbHIlFrj4aTmUS0EMFlgmwUWFedGZ
         kjdnomw1dqPRAOJmnhVM+kKmcD7tjFDG559za4mSxmLpyvayTl/SQ1F1VjjThB7epEBY
         hj6lLqAxjd0Hy8LS8ttUgf9Qf14ksR+FzUvWFzyf4hFJV6Ox5m8rLRv+0BLEwhaa2V9V
         tGAHk6ptHi4nnnBwcJKITZ6QevoeEZWVSAVWnBIw/5e9bNcnE6cRQe30iKL6syzACOov
         snQw==
X-Gm-Message-State: AJIora8da/EmYMPTc5DdC9hONnE4mxSgQvdo/HPewRsf2g9e0YnMrdzd
        sS73zaaqkGGjuJRdT5WqmWQr3A==
X-Google-Smtp-Source: AGRyM1syNknWUeDtrb2zQ0mSXavdYoNhvvHnt/MZKAWdXrFo8uNvNeBGeUFitcifm5x9u5JPmkFmfg==
X-Received: by 2002:a05:600c:4e8b:b0:3a0:5826:3321 with SMTP id f11-20020a05600c4e8b00b003a058263321mr7572674wmq.108.1657405962755;
        Sat, 09 Jul 2022 15:32:42 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 01/12] thermal/core: Remove duplicate information when an error occurs
Date:   Sun, 10 Jul 2022 00:32:18 +0200
Message-Id: <20220709223229.1619339-2-daniel.lezcano@linexp.org>
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

The pr_err already tells it is an error, it is pointless to add the
'Error:' string in the messages. Remove them.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cdc0552e8c42..e22e7d939c54 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1198,23 +1198,23 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	struct thermal_governor *governor;
 
 	if (!type || strlen(type) == 0) {
-		pr_err("Error: No thermal zone type defined\n");
+		pr_err("No thermal zone type defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
-		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
+		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
 		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
-		pr_err("Error: Incorrect number of thermal trips\n");
+		pr_err("Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (!ops) {
-		pr_err("Error: Thermal zone device ops not defined\n");
+		pr_err("Thermal zone device ops not defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.25.1

