Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCEE487FB8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiAGXxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiAGXxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:53:47 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C476C06175C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:53:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so13838738pjd.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Xh2WAcRayquz/Kdsf8CPJU6vn+1pkaPERRV3q8+MOc=;
        b=YaZZufWqRGJ5Z3Lk4+FjRkBmyUgUwYG1YMsrEXuTJ6lo4dsTRis5izX/in5bs5SqEx
         S0FenPEqwK6lPtmwzuvWbh/+C1A5YqJISRYUk2+ioYdk29aKUFO9lH/a/lRPHoEEXdW2
         LbkTOQgA4lnX5zQidjLaImjWqBfT6MfKFXtwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Xh2WAcRayquz/Kdsf8CPJU6vn+1pkaPERRV3q8+MOc=;
        b=qAiC7/ePAQIHx8/+R2253G3903ss4SsILc9PhkbSxeC8MQg8W+OAb7xhwX2F2o0Rkr
         Jymw3i3UmHyPlv8Qs2a+9CNeraW79vimLztVebTeYKsYiW0ZbqhLyKHurPuClWy5LE/4
         venwR+yxUr3RZT1eXXPJdyRp8+pKyI8U0Ywv04+uYMMgEkbXA+/rqWovzOPfnoi1/J8K
         gNRNl151o1v2QUtKxukOO+PhBSyKAVYeqZewyRyuZ+Tglh5hueyuBJKU+JbfiwLdPv8G
         mu5QLCEqa8OHbUiHgzmZEaUwYZEqCdvLsX8LvtVMrFVMrBdIJnUzCOaxNPEEg20OrhSo
         Pw6Q==
X-Gm-Message-State: AOAM532JcOa2dpZStcOnnKU6aT4kWRJ9t4C4XO+Tv1jXaxWJ6NCMB+LX
        78mF1EjUeosvGca5SogoQkT7Qg==
X-Google-Smtp-Source: ABdhPJzLeYyNBTb3Y2nHcruEQoGGGyC4SOeMaL3pTo+pMcWUBs9W/dgNZ2RbjFIPKEP1nG7WAeePfw==
X-Received: by 2002:a17:902:8346:b0:149:d1c7:fdc0 with SMTP id z6-20020a170902834600b00149d1c7fdc0mr14458886pln.166.1641599626571;
        Fri, 07 Jan 2022 15:53:46 -0800 (PST)
Received: from localhost ([2620:15c:202:201:db:1c60:693f:c24e])
        by smtp.gmail.com with UTF8SMTPSA id e21sm58740pff.24.2022.01.07.15.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 15:53:46 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 08/10] PM / devfreq: rk3399_dmc: Support new disable-freq properties
Date:   Fri,  7 Jan 2022 15:53:18 -0800
Message-Id: <20220107155215.8.I08d654522b8a1ae92ecb8d2e2a74511f778f61e5@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107235320.965497-1-briannorris@chromium.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the newly-defined properties to allow disabling certain
power-saving-at-idle features at higher frequencies.

This is a rewritten version of work by Lin Huang <hl@rock-chips.com>.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/devfreq/rk3399_dmc.c | 51 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index c4efbc15cbb1..58a4970918be 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -55,6 +55,12 @@ struct rk3399_dmcfreq {
 	unsigned int ddr3_odt_dis_freq;
 	unsigned int lpddr3_odt_dis_freq;
 	unsigned int lpddr4_odt_dis_freq;
+
+	unsigned int pd_idle_dis_freq;
+	unsigned int sr_idle_dis_freq;
+	unsigned int sr_mc_gate_idle_dis_freq;
+	unsigned int srpd_lite_idle_dis_freq;
+	unsigned int standby_idle_dis_freq;
 };
 
 static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
@@ -81,8 +87,25 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	mutex_lock(&dmcfreq->lock);
 
 	if (dmcfreq->regmap_pmu) {
+		unsigned int odt_pd_arg0 = dmcfreq->odt_pd_arg0;
+		unsigned int odt_pd_arg1 = dmcfreq->odt_pd_arg1;
 		unsigned int odt_pd_arg2 = 0;
 
+		if (target_rate >= dmcfreq->sr_idle_dis_freq)
+			odt_pd_arg0 &= ~RK3399_SET_ODT_PD_0_SR_IDLE;
+
+		if (target_rate >= dmcfreq->sr_mc_gate_idle_dis_freq)
+			odt_pd_arg0 &= ~RK3399_SET_ODT_PD_0_SR_MC_GATE_IDLE;
+
+		if (target_rate >= dmcfreq->standby_idle_dis_freq)
+			odt_pd_arg0 &= ~RK3399_SET_ODT_PD_0_STANDBY_IDLE;
+
+		if (target_rate >= dmcfreq->pd_idle_dis_freq)
+			odt_pd_arg1 &= ~RK3399_SET_ODT_PD_1_PD_IDLE;
+
+		if (target_rate >= dmcfreq->srpd_lite_idle_dis_freq)
+			odt_pd_arg1 &= ~RK3399_SET_ODT_PD_1_SRPD_LITE_IDLE;
+
 		if (target_rate >= dmcfreq->odt_dis_freq)
 			odt_pd_arg2 |= RK3399_SET_ODT_PD_2_ODT_ENABLE;
 
@@ -91,10 +114,9 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 		 * (power-down) timings and to enable or disable the
 		 * ODT (on-die termination) resistors.
 		 */
-		arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
-			      dmcfreq->odt_pd_arg1,
-			      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
-			      odt_pd_arg2, 0, 0, 0, &res);
+		arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, odt_pd_arg0, odt_pd_arg1,
+			      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD, odt_pd_arg2,
+			      0, 0, 0, &res);
 	}
 
 	/*
@@ -230,6 +252,16 @@ static int rk3399_dmcfreq_of_props(struct rk3399_dmcfreq *data,
 {
 	int ret = 0;
 
+	/*
+	 * These are all optional, and serve as minimum bounds. Give them large
+	 * (i.e., never "disabled") values if the DT doesn't specify one.
+	 */
+	data->pd_idle_dis_freq =
+		data->sr_idle_dis_freq =
+		data->sr_mc_gate_idle_dis_freq =
+		data->srpd_lite_idle_dis_freq =
+		data->standby_idle_dis_freq = UINT_MAX;
+
 	ret |= of_property_read_u32(np, "rockchip,pd_idle",
 				    &data->pd_idle);
 	ret |= of_property_read_u32(np, "rockchip,sr_idle",
@@ -247,6 +279,17 @@ static int rk3399_dmcfreq_of_props(struct rk3399_dmcfreq *data,
 	ret |= of_property_read_u32(np, "rockchip,lpddr4_odt_dis_freq",
 				    &data->lpddr4_odt_dis_freq);
 
+	ret |= of_property_read_u32(np, "rockchip,pd_idle_dis_freq",
+				    &data->pd_idle_dis_freq);
+	ret |= of_property_read_u32(np, "rockchip,sr_idle_dis_freq",
+				    &data->sr_idle_dis_freq);
+	ret |= of_property_read_u32(np, "rockchip,sr_mc_gate_idle_dis_freq",
+				    &data->sr_mc_gate_idle_dis_freq);
+	ret |= of_property_read_u32(np, "rockchip,srpd_lite_idle_dis_freq",
+				    &data->srpd_lite_idle_dis_freq);
+	ret |= of_property_read_u32(np, "rockchip,standby_idle_dis_freq",
+				    &data->standby_idle_dis_freq);
+
 	return ret;
 }
 
-- 
2.34.1.575.g55b058a8bb-goog

