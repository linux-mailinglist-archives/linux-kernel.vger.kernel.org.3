Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F67564921
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiGCSbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiGCSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:31:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E623886
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:31:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c131-20020a1c3589000000b003a19b2bce36so1123499wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lYiarM6ryCuSTp2tU29BbcCVirvvghP4xAIxJ7FKWQI=;
        b=X1DjKI+m1eU/WtbCOKdkKYpTrI92MOgpcrTaKGWVrqwoRuT7SV+0OAyxJE79WtEmq7
         BUoYGsWeRJ3J95S53ewFuYGYF1N48wTly80F6st20feP7pDAIMXNkT/iOrTKu48IZbwH
         SG5Aa9RHuPG2PssE7gZgj7h0KScuYUMSyzSmAcBTXXIlF7jNXhLwr0WsrcK0EWKP2sTC
         28fxD2dnvOv04h8MUzSUmzyCAUznzbpyNiL6zi3nsQ9l9zLRLoP6w1jx0wncKSHCFpy2
         GG/MhL1sFRiz612ygQTmW52cmS2/VeCMbO/oo10qEJGRpRSwxlF0vWQbYmVqgHM7vN3Z
         PAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYiarM6ryCuSTp2tU29BbcCVirvvghP4xAIxJ7FKWQI=;
        b=3YFVqUbBPEPtHbh761LCqzFN4Ffa/jiKfrh9Km/3gl+UqKSyOIyoD+mgb7JV/Inxh8
         xLsXfdXFZ4k68EonZ09XI5tEJcelJNkt1NWMplkge23h0rE1/DTuULM4P/YM0Q20Zifg
         8Re2H8Da0JtEnc1o/44nAV+UuEW7fBKDgyxjDEz6ZxDLkagH1rsJErqS2OVN2WMbXCjE
         zT5vG3OTfId3BuJKqjsF5nmI5IiHff9BgKEqeHtAHRFMK9BIIUVtgytx5GjfgV8+2Q/X
         NdpWaiVED4ycXfi2sV2pJG+ucPdWE03B6NItPSom6Nz5ojif5CGuMpcHFBOfk/XUjk1e
         hl9g==
X-Gm-Message-State: AJIora/qs22kAerSw+q7in/UkQZvMHtLIMVYM8yVFEU6I2cOlag1JkaV
        JFXqg9m7lxQ8CHANjmGchdOsHA==
X-Google-Smtp-Source: AGRyM1tS3mlJ0wfgPTJPXoEoze0T1T/T81PmNi9tH11k/td1lmaFNTG1MFHvsG87l/i3VEht0vhrPg==
X-Received: by 2002:a05:600c:2207:b0:3a0:4659:a0b0 with SMTP id z7-20020a05600c220700b003a04659a0b0mr29806674wml.48.1656873087286;
        Sun, 03 Jul 2022 11:31:27 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 01/12] thermal/core: Remove duplicate information when an error occurs
Date:   Sun,  3 Jul 2022 20:30:48 +0200
Message-Id: <20220703183059.4133659-2-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
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
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
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

