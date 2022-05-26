Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F978534E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiEZLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbiEZLoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66D3C6E5A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e66so1121585pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XNML7XiFhEmWhS7Wmn0QQk81yeWXZBxdfXtoqtiuEE=;
        b=F0RZwf+QVtfdPntABkUWCqnKWd9ZvaRtPa4RLbnjoS3Mv9huYArM/2p97ntmluKcx5
         sbuzSjy+OWEN6dzN7C6RYQgoNFlHohr4VKNTUfutPa7zwq1JV6AtX9/fNvPMAlVNPSPb
         KXM9WqnEd/bX9iVNhvKaU4SeqlFiBrGMgDvhqFvZDYJz3W6jnOESDByw3Ffm0L/ubDbR
         Bsb4ZMDq0fueO+vqGE5Nen8Ix6yV//gu8uLXJcIAIAtx1hxrVAeCjxHqFjCo+/yp4cL8
         YAFRMkagm/VLnmb1a+Jz/JKzq00ysjOHsH0DS9QGm64iB/sk/GCEc4J+kb224nRIYVL/
         uK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XNML7XiFhEmWhS7Wmn0QQk81yeWXZBxdfXtoqtiuEE=;
        b=JkaHPcyy0S6T359ABpGUCuE9jtsGrbJ6cKSds6d/b4F0/jqq0HQTmvm0d+77YnT2wB
         HkroeUltMAjS87bsNw2gCD17LaUcza0GklhO/LNo6WvKubW/WO5q/gB5kMDSMoYOocHq
         OFeXFPL8atbdQOF7CCMdMdtGuay38InFz7vaU9EEboEjRAcXvp4cb3j3ulOBACzGOVnr
         1QhTwj+HCzqMHdpOeB4RYHt/JoRsOt4FM18KAbRlummMXD85PRCqdsS6QyP6kWDjijl3
         9Y6A8DiON8aRtR8CBP9uBYANgLMG7OzYtKn3N2mM4eRzleLB17RsK8bfgqOQGNcJO+Ye
         to2g==
X-Gm-Message-State: AOAM532E1fuv4Se4/6IdH4XlqtYJdBZjPgLXsEU93raIiAAn7vSlRpu8
        UCkAbnhl8n2nUXpt7GlAa/J8kA==
X-Google-Smtp-Source: ABdhPJz4oCK0FlHgCt3OpAXEyjzMx8MM0BIoifZPvN2PfUIfJKR2EWbMtcAxZKXzchUrRLOzNjahKA==
X-Received: by 2002:a05:6a00:1487:b0:518:b952:889b with SMTP id v7-20020a056a00148700b00518b952889bmr16382659pfu.43.1653565445537;
        Thu, 26 May 2022 04:44:05 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id o13-20020a170903210d00b0015e8d4eb213sm1283995ple.93.2022.05.26.04.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:05 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/31] drm/lima: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:12 +0530
Message-Id: <22268a714109e8f18ee0612d2e0f746a357af9c3.1653564321.git.viresh.kumar@linaro.org>
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
 drivers/gpu/drm/lima/lima_devfreq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index 8989e215dfc9..e792ab5cd76a 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -111,6 +111,11 @@ int lima_devfreq_init(struct lima_device *ldev)
 	struct dev_pm_opp *opp;
 	unsigned long cur_freq;
 	int ret;
+	struct dev_pm_opp_config config = {
+		.regulator_names = (const char *[]){ "mali" },
+		.regulator_count = 1,
+		.clk_name = "core",
+	};
 
 	if (!device_property_present(dev, "operating-points-v2"))
 		/* Optional, continue without devfreq */
@@ -118,11 +123,7 @@ int lima_devfreq_init(struct lima_device *ldev)
 
 	spin_lock_init(&ldevfreq->lock);
 
-	ret = devm_pm_opp_set_clkname(dev, "core");
-	if (ret)
-		return ret;
-
-	ret = devm_pm_opp_set_regulators(dev, (const char *[]){ "mali" }, 1);
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret) {
 		/* Continue if the optional regulator is missing */
 		if (ret != -ENODEV)
-- 
2.31.1.272.g89b43f80a514

