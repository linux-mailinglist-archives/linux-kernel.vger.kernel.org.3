Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915F149EEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344567AbiA0XJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbiA0XIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:08:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E401EC061768
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so9266940pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Go5UOmrJA+s7smi2h52lD2tDLTL92TO4mF/3kSWc9Mw=;
        b=BD2hpR7jg+O2kVPF1qJXnuIpWgp1ScyjuAwtsYLAXOQDA3zbUFoCnVJJqrfqpylj9I
         WkldlnM7rS/nrlYZPEzyeNmMen8h5zRRumXIFqTs1NeKmEQvzAbFd1RxgdxH6oG+WCK3
         A4qUAHhNqs6bC9yAGwD49KrJgLsgRsUQsKBig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Go5UOmrJA+s7smi2h52lD2tDLTL92TO4mF/3kSWc9Mw=;
        b=kIUQ0HY5IplySaG4pOaTDrwJCv7F4ni01486NTXydxphIvhXxNRsw1bjaad1tEja7N
         9LGR10+hX+G1f9MemDIers2WFqezTYi4QGQpDKpdpeJ2zeDHf/UC1bPDD00tSj5Hhuu9
         snWud0YedUebQ8ogerxLazjNtnHFCHZPyE7On1yiFVnfnH9A61q/vbsXX0EmLc9eoEhl
         EKa7NGf1lb+T8PYF0/vr9bDqMF4HrPLhRiZslFWevE5JdP769fWSjM3RkqqjnDTq3/vT
         jk1uUq+W49ntJWcqdNwUZgkgtbz0fIMwKYHrTZz6FNQq0UPF4u827uJMcMqLuIsZo0o4
         61Xg==
X-Gm-Message-State: AOAM533OJoiEr0Why3nW9yCHBZTtnY0WqceBWYCE+x2OvoOijAqtxZJe
        Zw6vmIfCQZ6EES1oIa2GsPGTaQ==
X-Google-Smtp-Source: ABdhPJzC64/S0pZWwwbAFZsH3pw2HjjqvrdmyZAjA0v0ob2Yy/chyC08JNhUoQmIoBfblbLksdOALg==
X-Received: by 2002:a17:902:d4c5:: with SMTP id o5mr5877723plg.116.1643324934496;
        Thu, 27 Jan 2022 15:08:54 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id 17sm7074374pfl.175.2022.01.27.15.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:53 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 15/15] PM / devfreq: rk3399_dmc: Avoid static (reused) profile
Date:   Thu, 27 Jan 2022 15:07:26 -0800
Message-Id: <20220127150615.v2.15.I8d71e9555aca1fa7e532d22dd1ef27976f21799d@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This static struct can get reused if the device gets removed/reprobed,
and that causes use-after-free in its ->freq_table.

Let's just move the struct to our dynamic allocation.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - New patch

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
2.35.0.rc0.227.g00780c9af4-goog

