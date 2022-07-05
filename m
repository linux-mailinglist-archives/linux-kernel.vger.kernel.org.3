Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E47356638B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiGEHB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiGEHBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:01:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4AEE0FD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:01:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m2so10249755plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgzYVIoUF/W7ZZqlkRPUIeh8Y0nkpYJWUmbATvkU2GI=;
        b=yGoD2hyeQwWrzlSQ45BdlmoPYQvy4nmu81ti6NYReaSEmCgC/ywl/t1yTm1OjXRVsN
         L73KTn8aJPM84deNLu74ZtZeeAxa+vMWp0j9RjZ6LH1KV/ZUBNkmQVNm0vTzwTn9FhkW
         SP7U3nwHJa0z7CR5YdhizAtoCDlh2ZIpAJPdm0mxzsLCFPU3kpVzNI9oQIIEdKs6zCT3
         Lrp30aShQy23RRH5poC3xbokeBJc3pEn4m5L0BO3LW/jzoBcXQyVPbwq6mtug2DUFqXf
         cYBp07jOrzq7lxX+/KyC4Lo3gQfBSyvb7kN5c9At9ZcuirNlTlEcCLiv5IPyo89QDnS4
         aWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgzYVIoUF/W7ZZqlkRPUIeh8Y0nkpYJWUmbATvkU2GI=;
        b=3xqjlmtbqsafGPb1BVde4Jcbj1QzotA2CkClxvYNVRnI0EFK9kBnkoNmP6dG2vq6oF
         1LdpJg1CwJD3thPAIAFPnWK3aTueqBnAJPfq5j4CSB+EPto7dfpzChOUp5g28dFDchjp
         5/UpUeGovlbQ1ULfpzeQ5T55dBsrNDpcFwOx7I3KOREDJgzkMgpPsAk3gQhdmIgl3mw6
         faLUmnOm7OCndBqkJ2E6UTbp9YlM85ceDhN5njchKPzE+eayi7QF0PetOExJNcuqBEKG
         geqouTRc2a8kmvlOT/8LhA57UYV+xfjTHS9KpgzdN36gEA4ddeii0MltSAZHQUHp+hpo
         kFaw==
X-Gm-Message-State: AJIora+2sM4BIua22trK8HGdQL/BmU89CAHyPi1/EgtOvvzp2mwyMV4w
        SFQjuz7wooUx82Z2UQZzsibcZw==
X-Google-Smtp-Source: AGRyM1v1J2kF4CQzLQeSp9H28kOL+JQ3ADsbF48SrQi09UZfZq0BKDfJ+V//5K7St0Zqv85y/uGZgg==
X-Received: by 2002:a17:90b:3648:b0:1ef:7c45:62cb with SMTP id nh8-20020a17090b364800b001ef7c4562cbmr17443339pjb.132.1657004463621;
        Tue, 05 Jul 2022 00:01:03 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id q11-20020a63504b000000b004126f1e48f4sm769229pgl.20.2022.07.05.00.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:01:03 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/13] OPP: Allow config_clks helper for single clk case
Date:   Tue,  5 Jul 2022 12:30:14 +0530
Message-Id: <a6233c9fe4d85b0ecef9db43c430eee9410db1c3.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
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

There is a corner case with Tegra30, where we want to skip clk
configuration via dev_pm_opp_set_opp(), but still want the OPP core to
read the "opp-hz" property so we can find the right OPP via freq finding
helpers.

This is the easiest of the ways to make it work, without any special
hacks in the OPP core. Allow config_clks to be passed for single clk
case.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 597f7df3e375..666e1ebf91d1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2177,7 +2177,7 @@ static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
 		count = 1;
 
 	/* Fail early for invalid configurations */
-	if (!count || (config_clks && count == 1) || (!config_clks && count > 1))
+	if (!count || (!config_clks && count > 1))
 		return -EINVAL;
 
 	/* Another CPU that shares the OPP table has set the clkname ? */
@@ -2203,10 +2203,12 @@ static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
 	}
 
 	opp_table->clk_count = count;
+	opp_table->config_clks = config_clks;
 
 	/* Set generic single clk set here */
 	if (count == 1) {
-		opp_table->config_clks = _opp_config_clk_single;
+		if (!opp_table->config_clks)
+			opp_table->config_clks = _opp_config_clk_single;
 
 		/*
 		 * We could have just dropped the "clk" field and used "clks"
@@ -2221,8 +2223,6 @@ static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
 		 * too.
 		 */
 		opp_table->clk = opp_table->clks[0];
-	} else {
-		opp_table->config_clks = config_clks;
 	}
 
 	return 0;
-- 
2.31.1.272.g89b43f80a514

