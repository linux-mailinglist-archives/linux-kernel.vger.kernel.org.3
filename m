Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F217F54EB17
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378657AbiFPU0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378652AbiFPU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:26:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772FD5D659
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:26:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i64so2427558pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5oDf6mmYoYGsoU0I4zvpHX1oZdig110uWrdCKfJ96DM=;
        b=K99w/XO1zGTWG5p0b5wFgtUWUOrT4YwqNbDgdD+6s2ht7eTgzVqqrKb+qDfipid6VQ
         RCHPEPQvKgRu89Ze62rJQ1UbzvDUahENV93wf2/zIl3EZr2EwYebUMbDfhcHHtwMxn54
         yWG+RztQTZWP18/pZOwTKwIEVyvQqqDWHeN2wepOyjFGminVWFS4lis144PUC/G0HrfY
         McR9vxFmPBSSjCskeK0AkbUeMrwmNcpNHFMPu2lOxNEvqnG6c8zaytTME3PRyMm6rntk
         TnpKsz/uWs22nRtsTU6s7dfe91x9y+pzUQ4MYKaBAn/gbZPrEYvWRwK2qvTpAHxEDeDb
         TZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5oDf6mmYoYGsoU0I4zvpHX1oZdig110uWrdCKfJ96DM=;
        b=Zs8wtCGYa2znvmOPsJPvxDLVhz/uQvCM7FbhMLAWrtZEbl4qT9H7n4qDN6z0WveHp9
         mSYyCiRgRRpaNJgpHArRBHtNwV/2TefGGqy7B/0Jha1Zcl+/vvhOIPDkBXJQ5D3+n1cn
         CAiH/+sf0cqhxseELHQ29yBgaYN3U26zJrY3z7v6obCC5+Pf+CVL568n64DCv3qskTfM
         nBPR0F0EgHXCE2FmM/ysl3alCTDWdjZEDfe1g5uUAZ6FALuDCjGEE3W7NGS1VA9t1Pxc
         7+RpJ8mqW9RRnBRKieoAEhff3hS29L+KthPAJle29G/7axPgnPHo2IjRp3tcTopa9g88
         6I7w==
X-Gm-Message-State: AJIora8jQRr1gxDhjUCUSiw+5A3MlHSx7hJfiehytEFn8ZUPg2DF7zkT
        vE3nEiXbIuFIaPXvZzA3LG265A==
X-Google-Smtp-Source: AGRyM1tE/z5ezitmRGVAU4CPIEUY4+4fj61Od8atEUWs8WCGxhFKyRxGSMdn9fimcrLyhx0GDvpS9g==
X-Received: by 2002:a63:5b04:0:b0:3fc:61a1:da0d with SMTP id p4-20020a635b04000000b003fc61a1da0dmr5910643pgb.177.1655411160331;
        Thu, 16 Jun 2022 13:26:00 -0700 (PDT)
Received: from mai.imgcgcw.net ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id a5-20020aa79705000000b0051bb0be7109sm2182960pfg.78.2022.06.16.13.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:25:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 2/3] thermal/drivers/tegra: Remove get_trend function
Date:   Thu, 16 Jun 2022 22:25:36 +0200
Message-Id: <20220616202537.303655-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616202537.303655-1-daniel.lezcano@linaro.org>
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
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

The get_trend function does already what the generic framework does.

Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/soctherm.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 210325f92559..825eab526619 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -633,37 +633,6 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 	return 0;
 }
 
-static int tegra_thermctl_get_trend(void *data, int trip,
-				    enum thermal_trend *trend)
-{
-	struct tegra_thermctl_zone *zone = data;
-	struct thermal_zone_device *tz = zone->tz;
-	int trip_temp, temp, last_temp, ret;
-
-	if (!tz)
-		return -EINVAL;
-
-	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
-	if (ret)
-		return ret;
-
-	temp = READ_ONCE(tz->temperature);
-	last_temp = READ_ONCE(tz->last_temperature);
-
-	if (temp > trip_temp) {
-		if (temp >= last_temp)
-			*trend = THERMAL_TREND_RAISING;
-		else
-			*trend = THERMAL_TREND_STABLE;
-	} else if (temp < trip_temp) {
-		*trend = THERMAL_TREND_DROPPING;
-	} else {
-		*trend = THERMAL_TREND_STABLE;
-	}
-
-	return 0;
-}
-
 static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
 {
 	u32 r;
@@ -716,7 +685,6 @@ static int tegra_thermctl_set_trips(void *data, int lo, int hi)
 static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
 	.get_temp = tegra_thermctl_get_temp,
 	.set_trip_temp = tegra_thermctl_set_trip_temp,
-	.get_trend = tegra_thermctl_get_trend,
 	.set_trips = tegra_thermctl_set_trips,
 };
 
-- 
2.25.1

