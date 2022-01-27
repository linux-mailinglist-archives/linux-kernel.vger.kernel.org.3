Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330D249EE96
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbiA0XI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbiA0XIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:08:46 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AC3C061756
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x11so4210498plg.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9UUBFHvbSrtJMfZR9HJLLl/uTdLWsiae0TVMvt6HWo=;
        b=WZ5WVi8R+bmMgknUpN9mtZuAUztF0PXl5q1MvKtTVVlbJV/nokfuBkGkbupYK/bjnL
         MghDXT89x7o7pz8erRgPiNB1tbJj41LzolRQRLknKPj794F0YYWiyV18zLsEjpknXcpC
         S6m4H9JZkY4Vq1lFjVzu3Ona8/l/63mH45q5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9UUBFHvbSrtJMfZR9HJLLl/uTdLWsiae0TVMvt6HWo=;
        b=u3avOX9f34Ype660yoI0FYTfH47KDN/uEWy1PRlrCo3sl5aIMWyLMIocEb3KaQdR+J
         jzhPJXAUDGkjVuFPq3bxGWlqRft5mZk/73uIHg++yAicOYjlcodZFvYmhXz4p3BiWzkA
         DR0iWP02tN2Rd43sSLjK6ag7FnzZrDZX9DaUpOHRwygXs84Pl+2pizL+O5VnMMJo1J7R
         7modjYNQdvB0wWmNSpCnqZbNswQjYqMqNRgeUyk3sXvSu+wvpJBQQfkDeddmBkJM9I6w
         fH/EDlOaWnGKrx+PYiXnE+eI82HJYwCWSDwhNKaQNwLf0/bs7T2vevKE0gImPyad54IF
         KPyg==
X-Gm-Message-State: AOAM531Kn0vD6XtoBvP2cQ7CaTcjENYovmBNBRkYnWhwsIMuiFFpl5Ka
        DX4eWVYlxDB+opkNs5sFuA/c1w==
X-Google-Smtp-Source: ABdhPJwLYXBQbIhC3AWRQacZGe/+yRBB0PUOR8RSC8ozjMA3n/Xb0G8ifymvRon0Yc8CnrtIKg+b9A==
X-Received: by 2002:a17:902:ba98:: with SMTP id k24mr5444084pls.44.1643324923796;
        Thu, 27 Jan 2022 15:08:43 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id k15sm6933107pff.39.2022.01.27.15.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:43 -0800 (PST)
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
Subject: [PATCH v2 10/15] PM / devfreq: rk3399_dmc: Support new *-ns properties
Date:   Thu, 27 Jan 2022 15:07:21 -0800
Message-Id: <20220127150615.v2.10.I4e01e243ea11e9f95295b40b44a9eaa3a883a0dd@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to keep the idle time fixed, so compute based on the current DDR
frequency.

The old properties were deprecated and never used, so we can safely drop
them from the driver.

This is a rewritten version of work by Lin Huang <hl@rock-chips.com>.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - New patch

 drivers/devfreq/rk3399_dmc.c | 85 +++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index fc740c1f6747..f778564cab49 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -24,6 +24,8 @@
 #include <soc/rockchip/rk3399_grf.h>
 #include <soc/rockchip/rockchip_sip.h>
 
+#define NS_TO_CYCLE(NS, MHz)				(((NS) * (MHz)) / NSEC_PER_USEC)
+
 #define RK3399_SET_ODT_PD_0_SR_IDLE			GENMASK(7, 0)
 #define RK3399_SET_ODT_PD_0_SR_MC_GATE_IDLE		GENMASK(15, 8)
 #define RK3399_SET_ODT_PD_0_STANDBY_IDLE		GENMASK(31, 16)
@@ -45,13 +47,12 @@ struct rk3399_dmcfreq {
 	unsigned long rate, target_rate;
 	unsigned long volt, target_volt;
 	unsigned int odt_dis_freq;
-	int odt_pd_arg0, odt_pd_arg1;
 
-	unsigned int pd_idle;
-	unsigned int sr_idle;
-	unsigned int sr_mc_gate_idle;
-	unsigned int srpd_lite_idle;
-	unsigned int standby_idle;
+	unsigned int pd_idle_ns;
+	unsigned int sr_idle_ns;
+	unsigned int sr_mc_gate_idle_ns;
+	unsigned int srpd_lite_idle_ns;
+	unsigned int standby_idle_ns;
 	unsigned int ddr3_odt_dis_freq;
 	unsigned int lpddr3_odt_dis_freq;
 	unsigned int lpddr4_odt_dis_freq;
@@ -70,9 +71,14 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	struct dev_pm_opp *opp;
 	unsigned long old_clk_rate = dmcfreq->rate;
 	unsigned long target_volt, target_rate;
+	unsigned int ddrcon_mhz;
 	struct arm_smccc_res res;
 	int err;
 
+	u32 odt_pd_arg0 = 0;
+	u32 odt_pd_arg1 = 0;
+	u32 odt_pd_arg2 = 0;
+
 	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
@@ -86,11 +92,35 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 
 	mutex_lock(&dmcfreq->lock);
 
-	if (dmcfreq->regmap_pmu) {
-		unsigned int odt_pd_arg0 = dmcfreq->odt_pd_arg0;
-		unsigned int odt_pd_arg1 = dmcfreq->odt_pd_arg1;
-		unsigned int odt_pd_arg2 = 0;
+	/*
+	 * Some idle parameters may be based on the DDR controller clock, which
+	 * is half of the DDR frequency.
+	 * pd_idle and standby_idle are based on the controller clock cycle.
+	 * sr_idle_cycle, sr_mc_gate_idle_cycle, and srpd_lite_idle_cycle
+	 * are based on the 1024 controller clock cycle
+	 */
+	ddrcon_mhz = target_rate / USEC_PER_SEC / 2;
+
+	u32p_replace_bits(&odt_pd_arg1,
+			  NS_TO_CYCLE(dmcfreq->pd_idle_ns, ddrcon_mhz),
+			  RK3399_SET_ODT_PD_1_PD_IDLE);
+	u32p_replace_bits(&odt_pd_arg0,
+			  NS_TO_CYCLE(dmcfreq->standby_idle_ns, ddrcon_mhz),
+			  RK3399_SET_ODT_PD_0_STANDBY_IDLE);
+	u32p_replace_bits(&odt_pd_arg0,
+			  DIV_ROUND_UP(NS_TO_CYCLE(dmcfreq->sr_idle_ns,
+						   ddrcon_mhz), 1024),
+			  RK3399_SET_ODT_PD_0_SR_IDLE);
+	u32p_replace_bits(&odt_pd_arg0,
+			  DIV_ROUND_UP(NS_TO_CYCLE(dmcfreq->sr_mc_gate_idle_ns,
+						   ddrcon_mhz), 1024),
+			  RK3399_SET_ODT_PD_0_SR_MC_GATE_IDLE);
+	u32p_replace_bits(&odt_pd_arg1,
+			  DIV_ROUND_UP(NS_TO_CYCLE(dmcfreq->srpd_lite_idle_ns,
+						   ddrcon_mhz), 1024),
+			  RK3399_SET_ODT_PD_1_SRPD_LITE_IDLE);
 
+	if (dmcfreq->regmap_pmu) {
 		if (target_rate >= dmcfreq->sr_idle_dis_freq)
 			odt_pd_arg0 &= ~RK3399_SET_ODT_PD_0_SR_IDLE;
 
@@ -262,16 +292,16 @@ static int rk3399_dmcfreq_of_props(struct rk3399_dmcfreq *data,
 		data->srpd_lite_idle_dis_freq =
 		data->standby_idle_dis_freq = UINT_MAX;
 
-	ret |= of_property_read_u32(np, "rockchip,pd_idle",
-				    &data->pd_idle);
-	ret |= of_property_read_u32(np, "rockchip,sr_idle",
-				    &data->sr_idle);
-	ret |= of_property_read_u32(np, "rockchip,sr_mc_gate_idle",
-				    &data->sr_mc_gate_idle);
-	ret |= of_property_read_u32(np, "rockchip,srpd_lite_idle",
-				    &data->srpd_lite_idle);
-	ret |= of_property_read_u32(np, "rockchip,standby_idle",
-				    &data->standby_idle);
+	ret |= of_property_read_u32(np, "rockchip,pd-idle-ns",
+				    &data->pd_idle_ns);
+	ret |= of_property_read_u32(np, "rockchip,sr-idle-ns",
+				    &data->sr_idle_ns);
+	ret |= of_property_read_u32(np, "rockchip,sr-mc-gate-idle-ns",
+				    &data->sr_mc_gate_idle_ns);
+	ret |= of_property_read_u32(np, "rockchip,srpd-lite-idle-ns",
+				    &data->srpd_lite_idle_ns);
+	ret |= of_property_read_u32(np, "rockchip,standby-idle-ns",
+				    &data->standby_idle_ns);
 	ret |= of_property_read_u32(np, "rockchip,ddr3_odt_dis_freq",
 				    &data->ddr3_odt_dis_freq);
 	ret |= of_property_read_u32(np, "rockchip,lpddr3_odt_dis_freq",
@@ -367,21 +397,6 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		      ROCKCHIP_SIP_CONFIG_DRAM_INIT,
 		      0, 0, 0, 0, &res);
 
-	/*
-	 * In TF-A there is a platform SIP call to set the PD (power-down)
-	 * timings and to enable or disable the ODT (on-die termination).
-	 */
-	data->odt_pd_arg0 =
-		FIELD_PREP(RK3399_SET_ODT_PD_0_SR_IDLE, data->sr_idle) |
-		FIELD_PREP(RK3399_SET_ODT_PD_0_SR_MC_GATE_IDLE,
-			   data->sr_mc_gate_idle) |
-		FIELD_PREP(RK3399_SET_ODT_PD_0_STANDBY_IDLE,
-			   data->standby_idle);
-	data->odt_pd_arg1 =
-		FIELD_PREP(RK3399_SET_ODT_PD_1_PD_IDLE, data->pd_idle) |
-		FIELD_PREP(RK3399_SET_ODT_PD_1_SRPD_LITE_IDLE,
-			   data->srpd_lite_idle);
-
 	/*
 	 * We add a devfreq driver to our parent since it has a device tree node
 	 * with operating points.
-- 
2.35.0.rc0.227.g00780c9af4-goog

