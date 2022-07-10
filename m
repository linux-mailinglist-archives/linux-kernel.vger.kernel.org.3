Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EBE56CF13
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiGJMf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGJMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85BB11149
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d13-20020a05600c34cd00b003a2dc1cf0b4so1602367wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UKKS5f7QbJpxlk+iXwxbcq70b7aqG7EJc4B5ZEy8YU=;
        b=By6v5r10L/lAATCEtUvIN9UyTUj23D9ixh8xCslWB5BV4bBLKCf97tNmLKl4p2J5Vj
         6kpafYxSKNlwzHLzVTbGj5p9xVzVDeygR3U5xP3mfFDtVP2BEGhbElywcAu5HrgbS7xC
         8D4h3P6DiI3v6claR6LLrOpL7js65S+5276sT/9nCckLsoyVigewZxD0QfmOW349joJs
         OYb58loCAq1/W6MR/TJ3OpVCRjWQZRGIq28GyyF/F3Hy1UvOBDayNJEZyHWPFLKyEsTL
         CgcAL6HZ62dwAUHAAFMYwVRBxae6s5xfkJb6kJSadQev7yRRo2UtztdnTNaQ49k/LW6+
         tmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UKKS5f7QbJpxlk+iXwxbcq70b7aqG7EJc4B5ZEy8YU=;
        b=ZLZKII17Qkc9Vxj7vMhAgiF1vCuECMi5X64j9fwWjAFSXIbFo8CG6nLasLYJVxZIeV
         +tf7JZrk539i6pcdMt8vxxMuTOwOFkeNepNHMnK36cJe46IQCgWutc16ILFP0L3o/NLw
         cufjeRzZKl1sAgggsxhpGwBEib9CgF1YwXL46KIbmeGAEwVh50YGv6iKmkG9A940N9yl
         SsBxSFAoDavoLXTy9paX7ia4aG8yNW48prEqDoDyBpbZfolZ4NCLN2dNy+z9PA6OlAxK
         DddC/ebm9Rtc4lb/mFMih/p7Pf2UWUB9UgmMTXUxFJxzIhVCBWuBY06rZnz9gssuDlBB
         K7gA==
X-Gm-Message-State: AJIora90ylGyT2I7LGUtZ0JoqWLm0lfnYasTZ5uhb3BZfWRWhSTydkOc
        sWFxUVbe24RlAzj3aOJBSJtBi6FWj73XBA==
X-Google-Smtp-Source: AGRyM1tHDEsVQduYimH8r3NljPB+Kato4ADWXh8GoJ/14eVbkAq2Q7IoN4V9CC1Ml0PyvstWVl8nCw==
X-Received: by 2002:a05:600c:34c2:b0:3a0:5439:1f with SMTP id d2-20020a05600c34c200b003a05439001fmr9960836wmq.179.1657456517482;
        Sun, 10 Jul 2022 05:35:17 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:17 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 01/12] thermal/core: Remove duplicate information when an error occurs
Date:   Sun, 10 Jul 2022 14:35:00 +0200
Message-Id: <20220710123512.1714714-2-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

