Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B526E56CF19
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiGJMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGJMfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3123B1115F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so1612662wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+KDnyI1rYWiKYKY6BfUNrB+RXhqQv2REJcaYGxminc=;
        b=cIeFBig7IbdxtGrb61XbNxVA+j6A2T94DM8apK+8AkboXuzK4lBJQ30jOJQDQVZhYA
         dFvBkspS+X1eTk37AGMH65QuEITTbvoKPpRlousVXsQ1AB8i+0jM1h4ZEnYCeO6A4KVy
         SN5UvB4ciPgJpL3ITaGMH7J+iiSFHZYhIjOwFRO2zCYO/K3SLVHPiOVC4glsoXPKo4Aa
         N8o8ozXpt14eaWWuNd6l6MM5pmDxrQg3YuPbD+gSYpe1FKSr+y0yams6lQJVhoey6wIX
         3F3ULBfZ+4ARYiIq9IL7sCkwpqcBu1fGFAvZZTVMBEkFtomO24r/I4WdQmrZC+VrHshU
         TG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+KDnyI1rYWiKYKY6BfUNrB+RXhqQv2REJcaYGxminc=;
        b=hex65rwer6VKAkP+sAohfwYJyhKAKEdnuBPCewa7Y3+7mPCIhLUKlOotOwXNdFPflY
         r9PRHaoP3rIKqm+1cK5gZ+7J0z5ZiCneqRewz2z3QuZeslwZvZc9owL/36A3yS+t28yA
         zNW7pRwLWb/yzHpkjc0F16UN4utGpGwq6HDLI4qHAiZKp+J5aYM4q4vowxI7UmKUF3o/
         9W1Tr1IcAAEmpMYHTQDVwSUX2ysgh8fQW0HSNtXLdK1DZ0Y+4umgSH0nrT8FdCqxc7bw
         j9HYPa23vHh9/Z8OIgs1iK3XiNXJHmFHXk++ED94AFzEBEpuIEvhNXrpYwytzCXLPdFl
         fCqQ==
X-Gm-Message-State: AJIora9T84ClXqxEL3NvCoRO4uWXxnBUwgoJsurhB7pwqb1pqpFDdS8s
        q1oQpacmtzAzd74qPnJFo1q3+g==
X-Google-Smtp-Source: AGRyM1sSHBD5IryGyIIB5s/pP/i+ITi3z5Ljl+3aEfpZ15MxZROK6TaAMG73DQcVAnTrTEz286IOdQ==
X-Received: by 2002:a05:600c:48a:b0:3a2:ce31:a150 with SMTP id d10-20020a05600c048a00b003a2ce31a150mr10100680wme.48.1657456521656;
        Sun, 10 Jul 2022 05:35:21 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:21 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 05/12] thermal/core: Remove unneeded EXPORT_SYMBOLS
Date:   Sun, 10 Jul 2022 14:35:04 +0200
Message-Id: <20220710123512.1714714-6-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
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

Different functions are exporting the symbols but are actually only
used by the thermal framework internals. Remove these EXPORT_SYMBOLS.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 3edd047e144f..f4c1e87ef040 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -39,7 +39,6 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
 
 	return trend;
 }
-EXPORT_SYMBOL(get_tz_trend);
 
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
@@ -228,7 +227,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	}
 	mutex_unlock(&cdev->lock);
 }
-EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
  * thermal_zone_get_slope - return the slope attribute of the thermal zone
-- 
2.25.1

