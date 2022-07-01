Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8A562DF1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiGAIXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiGAIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:21:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4310A71BDC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:21:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id jb13so1699235plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MggsQ4TY4XeBgvA7QVMGXMCN2KhkYB30faLk4meCgmY=;
        b=rs/NQg8B3YMz/mXdzfqsGOdveJ25PwZxde1vf73UXhbF5yk92CA9Jlpgam3cHheIz+
         fzhXNzj9WbYhPukIx/QifaABEy4k6mAmPVzssxaxdU8XH4Zwvf32Mt4ujAyhrUwi7Dvu
         Rdmd4ZLrrjbPNPC7R24anUQBoxNTFyvJOFLoRH6i9+IpoFw9Rr88F3imH7ZcFACORMkl
         1MMREqAd8Jkc10wZs5+Hz5+TCzm80Uha7wjOobc+ExAg1fUWK52q28mkJGkLKt0zQWLH
         2cGq5zSLUbqY92VpoHLmzxJ5yfFDEl5UGRYgWVPfUIBFU0k7op4RU/DWdWathnO5TlA3
         +tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MggsQ4TY4XeBgvA7QVMGXMCN2KhkYB30faLk4meCgmY=;
        b=B8PiHIOyfDimjP+3+RSSaqGfVQ3YriSjxl+ljzI84fUhClDFE6bqk4u1qEq49Ifr5d
         o3CJcKo/4kjsj5wGomN6KKTVDcB/EjLEOZ89m0Ay3SCQ/+XhUq9RnqeBSgrnoJHhRF0F
         owNE5yMEJ8qP+G8Tt823aZePWPPfm1pbCs4ln/+xzrcIr2D/GZOtcod+CYRaTpF4N7AM
         lLrSSxgmAxa9OFLzf+DhV4E3GT+sgvUcgwWMJSV0jhliIy6VEwta37wCbJdYFC7PDING
         b4C0Ry+APxJ9nhcCn7EjbDyvNDuY8eAjcd+Kd7pQZ01Pm9nDMaXKkcCeYx3etE99gKNY
         xbPA==
X-Gm-Message-State: AJIora81nGYUDy8H2sRb8uH/uewjPbBWDlqYNcUZrOiBBh1SUFmnETg8
        6LHCk4D+dq/yK185LGrwIReQOw==
X-Google-Smtp-Source: AGRyM1sOKtre5vBYoEvJpv35QmWxmGVHmbIKmanb1KOI/w0yrthBM5qY5HTR/cBv6eUk4S4fhX5bCw==
X-Received: by 2002:a17:902:ea47:b0:16b:a612:208d with SMTP id r7-20020a170902ea4700b0016ba612208dmr10862224plg.96.1656663686760;
        Fri, 01 Jul 2022 01:21:26 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090aee8400b001eb162ffaa3sm5884839pjz.25.2022.07.01.01.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:26 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 15/30] drm/panfrost: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:10 +0530
Message-Id: <1179832f813aafc02c408b65765f299e7f668ad3.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
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

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Acked-by: Steven Price <steven.price@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 194af7f607a6..7826d9366d35 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -91,6 +91,10 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
+	struct dev_pm_opp_config config = {
+		.regulator_names = pfdev->comp->supply_names,
+		.regulator_count = pfdev->comp->num_supplies,
+	};
 
 	if (pfdev->comp->num_supplies > 1) {
 		/*
@@ -101,13 +105,12 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		return 0;
 	}
 
-	ret = devm_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
-					 pfdev->comp->num_supplies);
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret) {
 		/* Continue if the optional regulator is missing */
 		if (ret != -ENODEV) {
 			if (ret != -EPROBE_DEFER)
-				DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
+				DRM_DEV_ERROR(dev, "Couldn't set OPP config\n");
 			return ret;
 		}
 	}
-- 
2.31.1.272.g89b43f80a514

