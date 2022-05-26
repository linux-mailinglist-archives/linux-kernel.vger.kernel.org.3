Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB4534E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347132AbiEZLph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347190AbiEZLof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0A8D0289
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1514751pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HsZm01W7lVAYoixKo6Nk800vk4WIHy3MlJNuyYghC/E=;
        b=Wu/JMipJ6JOhMstgYzE3dXXw6nfzo+Z40qL43mmLs92tnCkqEchuC0GkobCAide8pC
         9dAMVYodIG1r8gvpVHuxSNdfQpIoHGrVGx/GFK/zzgLOiU8yag8npVq/xiFZQdlQy5lv
         3UT1eW4xeo6Igg8MmXPt8iJQw/p6UIFhczgqv67ux8KvehwfVHIQyiCvfBxxDP9IJiie
         GosfMVhgFvoDmzkA7yln56NRSwmneRV6Ur4rGXDVVnE2RZCPFS57Ls2pgOpgItOmuSvh
         XFrxNBsETuUFY8EFBPK1TdYiZRtorTjeHslF1AqfpYTuCWS3mmz7/hEbQ3f+cD8+o+A6
         2P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HsZm01W7lVAYoixKo6Nk800vk4WIHy3MlJNuyYghC/E=;
        b=ABxObW+6P20nOmHcxmvxkId/1Fx06wtJTzJuk9WId689yZzerUWSEWwUw468BPzpyL
         75PxhiNmj+oSZPPnCr3Hvv359ZdOCPW8r1ZpAbgIEjZBnikk5sVDwQvjhSW4Q/m5V0z7
         lPXGfovJvuFWyypF7Ejvc8UVAJti50j/IK9UFSkMuhmz4Vz0p6UWU+uhOSQeF2uZApt0
         L1RsK+QtLutGOQ3BYums+ljh8QpWPsZe9qIxlraY8RLBVZzzWH+zRXiF1as43A1Ovm1i
         ArgdVet4zMpwQ6N5UJgXDa6QquayScSBgr+RHPmdsGfmELuVt6/mrotLPv1uWMZ6rBo1
         E+vQ==
X-Gm-Message-State: AOAM532Ec70pzSnC+X7bqCq1WpMPZU1avSDEV7MdtvLzERuINYmgwxFE
        o1+x2RI8OSOrIUTrzgsIm9YH9Q==
X-Google-Smtp-Source: ABdhPJyfcjHj9Ly12wH9ItwVX3s2KDOb31DEq1TzBbFi6yJUwSS4pqWWAqG68J0QgVbGcfhWH2g6lQ==
X-Received: by 2002:a17:902:f70a:b0:153:88c7:774 with SMTP id h10-20020a170902f70a00b0015388c70774mr37348147plo.166.1653565452780;
        Thu, 26 May 2022 04:44:12 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902eb8c00b0015e8d4eb1d7sm1270604plg.33.2022.05.26.04.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:12 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/31] drm/panfrost: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:14 +0530
Message-Id: <2a0970a5cf1fc92e16eb2b782798a6b609594cdc.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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

