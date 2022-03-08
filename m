Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68004D0CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbiCHAL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344047AbiCHALl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:11:41 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA21037A2B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:10:39 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b8so15565859pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExeMvBUYf18gUbw3oNoBhQIqfKznu+dtCvkD2ZUwMDI=;
        b=dUSKXKD2oLryc1nruR3FNcnsYYhThzA308IDtnm37tWHi+DdqgeCtz4xqfUo6Nt7UW
         fI4qPKxksSC65tT0l7YkCINT05BtyR+OAL8TSWjGo/RlhyavUD+bacUAkumZNAfYZZ52
         goJj0JVvFwvvujDp0z90ZPeHro8+w88DMROGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExeMvBUYf18gUbw3oNoBhQIqfKznu+dtCvkD2ZUwMDI=;
        b=pQKNPhU4hjSMR/hILLs4FqqDkv19Raz6R/L1N+MxIhLfAZjxfz9QuT+1bdRtkZh309
         ae/v46Oi4WKh2qgEo64kf6isgSEuVL1ArJpp6Mo8ro9m2HtRpvj+A+jYT7ov7N1RG5VK
         NzWN6h3bQOCUI/et+MBT+ozUoXyjj6rrJSTcytc5o7X+JRlNsfQG/LrceVeKxZT+xrKj
         8mIrzJ6W+4uG2u8U2Fcz7hz1+i4hJj41fJ+TzkwGVWhE/oBBymPxz8TI5sjboNKd6qA+
         LJ9Q9dmY2z2Q45tZx8DdXEpcKWO4WZqXpTjGeXdUVmQ35YmV4xBw9uu+QyFP/ItQD2LJ
         feIQ==
X-Gm-Message-State: AOAM530Jqr5AOVaI8n3BQXdy4apiMAaMOFGF2MJ46Zu4jVuJSt4r5LUK
        c3JR7wdKgAoBQqth81fYjhKmhw==
X-Google-Smtp-Source: ABdhPJyrcw+XhrxMuU5ct7+AqtGPHqcx+ajYHdkXRnnV0rz1xXVGUvlzhLNfmp1oAPTEeWB/2Df2Ag==
X-Received: by 2002:a17:902:ed82:b0:151:d081:3832 with SMTP id e2-20020a170902ed8200b00151d0813832mr14035788plj.165.1646698239237;
        Mon, 07 Mar 2022 16:10:39 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id p25-20020a637419000000b0037fa57520adsm8884252pgc.27.2022.03.07.16.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:38 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 15/15] PM / devfreq: rk3399_dmc: Avoid static (reused) profile
Date:   Mon,  7 Mar 2022 16:09:45 -0800
Message-Id: <20220307160918.v3.15.I8d71e9555aca1fa7e532d22dd1ef27976f21799d@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308000945.706701-1-briannorris@chromium.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This static struct can get reused if the device gets removed/reprobed,
and that causes use-after-free in its ->freq_table.

Let's just move the struct to our dynamic allocation.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v2)

Changes in v2:
 * New patch

 drivers/devfreq/rk3399_dmc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 9615658d04ae..e494d1497d60 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -38,6 +38,7 @@
 struct rk3399_dmcfreq {
 	struct device *dev;
 	struct devfreq *devfreq;
+	struct devfreq_dev_profile profile;
 	struct devfreq_simple_ondemand_data ondemand_data;
 	struct clk *dmc_clk;
 	struct devfreq_event_dev *edev;
@@ -228,13 +229,6 @@ static int rk3399_dmcfreq_get_cur_freq(struct device *dev, unsigned long *freq)
 	return 0;
 }
 
-static struct devfreq_dev_profile rk3399_devfreq_dmc_profile = {
-	.polling_ms	= 200,
-	.target		= rk3399_dmcfreq_target,
-	.get_dev_status	= rk3399_dmcfreq_get_dev_status,
-	.get_cur_freq	= rk3399_dmcfreq_get_cur_freq,
-};
-
 static __maybe_unused int rk3399_dmcfreq_suspend(struct device *dev)
 {
 	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(dev);
@@ -422,10 +416,16 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	data->volt = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
-	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
+	data->profile = (struct devfreq_dev_profile) {
+		.polling_ms	= 200,
+		.target		= rk3399_dmcfreq_target,
+		.get_dev_status	= rk3399_dmcfreq_get_dev_status,
+		.get_cur_freq	= rk3399_dmcfreq_get_cur_freq,
+		.initial_freq	= data->rate,
+	};
 
 	data->devfreq = devm_devfreq_add_device(dev,
-					   &rk3399_devfreq_dmc_profile,
+					   &data->profile,
 					   DEVFREQ_GOV_SIMPLE_ONDEMAND,
 					   &data->ondemand_data);
 	if (IS_ERR(data->devfreq)) {
-- 
2.35.1.616.g0bdcbb4464-goog

