Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7758ACC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbiHEO7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbiHEO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:58:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CCE65802
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:58:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z16so3494728wrh.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8+E7Vl3OuQJYkPZfeMwMw1IQSn5jvS+Nro+I/6Lgevk=;
        b=h0ud1B5+DGsF/FRvY0TpG0en75NeBVlkgAnh89X68EZlKqBEIaK7fzBYia53lJUyE7
         pR0yvm3U6Vs5r8TlpqN0gs02ld8+kZt3UasFfShQaQf+KCK9VQu0AZoH6wmaDO3bq0S+
         lxHBzs667mEdOIuEi38Ofa6V0zqXLTIafvVaj7vAQOr171oN4tilK8uszjHRoJ+CkK5t
         esOgx7ZiQsdFS4IUM85bZ95AbbEURHzxw+4bqWtt1WU4jwg5iSQ1e0qAHRj9lpjgC635
         LN6OOT/V0ii7xYGQts3J2dkkzcDuN4BDWBy0ZzNyIvQNWLkTLSeHN4h2cg9VXK9gzk5h
         WGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8+E7Vl3OuQJYkPZfeMwMw1IQSn5jvS+Nro+I/6Lgevk=;
        b=tng2Htrdg6hGF+faOkg3S7No2OfXl73utDTK0LAjTz7zfmDrMmZy1+KtLMck1XHYTC
         DgMJcbB2xMdOLjH5oTBkpX4dNmf5++mrEzFHjJzbvCbCP0N8TtND7AKWRsx/O+q5+QRK
         02ER1hopeZtKNr/4Nc4bfC87aPA6vrrdj2A350C5EDrdftOfsVd0DexQDVub5BBXpalL
         mXQ7RzKzQkgvG92MnHSkl3Q97+2EmhpxtYolGTroBwXoDXrqunJ7l53jMRAdEksOYuzI
         GQIs3ugf+OOVp53/IsvHdnEYf2L8ecOceN2z67gFkQhe87hg+25MmSUVJaCvx1t8AxyW
         yH/w==
X-Gm-Message-State: ACgBeo0Tpnx9jsxTTnNWOMZi8ydfjNbLPVOLeDdZxsHHlxAeWfDlm/vs
        q3UtU3oCqexHuzWnlws3GYVR3w==
X-Google-Smtp-Source: AA6agR7V5JIIGK0zTvb4pObU/QSmyBBStTOpqXs5lzqmWi3NjQ2bXd3HTC/moUqy7BCra7tg4n3xug==
X-Received: by 2002:a5d:5a8d:0:b0:21d:6d69:ca03 with SMTP id bp13-20020a5d5a8d000000b0021d6d69ca03mr4542643wrb.135.1659711486604;
        Fri, 05 Aug 2022 07:58:06 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES)
Subject: [PATCH v1 16/26] thermal/drivers/exynos: of_thermal_get_ntrips()
Date:   Fri,  5 Aug 2022 16:57:19 +0200
Message-Id: <20220805145729.2491611-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
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

The thermal core framework allows to get the number of thermal trips,
use it instead of visiting the thermal core structure internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5204e343d5b0..ac47c716c1f0 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -260,6 +260,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tzd = data->tzd;
+	int num_trips = thermal_zone_get_num_trips(tzd);
 	unsigned int status;
 	int ret = 0, temp;
 
@@ -271,12 +272,12 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		goto out;
 	}
 
-	if (of_thermal_get_ntrips(tzd) > data->ntrip) {
+	if (num_trips > data->ntrip) {
 		dev_info(&pdev->dev,
 			 "More trip points than supported by this TMU.\n");
 		dev_info(&pdev->dev,
 			 "%d trip points should be configured in polling mode.\n",
-			 (of_thermal_get_ntrips(tzd) - data->ntrip));
+			 num_trips - data->ntrip);
 	}
 
 	mutex_lock(&data->lock);
@@ -289,7 +290,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		ret = -EBUSY;
 	} else {
 		int i, ntrips =
-			min_t(int, of_thermal_get_ntrips(tzd), data->ntrip);
+			min_t(int, num_trips, data->ntrip);
 
 		data->tmu_initialize(pdev);
 
-- 
2.25.1

