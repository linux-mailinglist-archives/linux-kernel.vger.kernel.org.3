Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC14D210B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350016AbiCHTLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349965AbiCHTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:10:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB794EA0E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:09:34 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q19so4662950pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XdkuXzvsU8Qmmgk1oFXQM7A/zqUKyIIaZpyPEVdNOeA=;
        b=JwRh6BtiqbuT4qCPUSLvGr9eHRAxIPrezqeJENfy+kjTR4kU0Rlm0pGwZFmWl/Uj9A
         uyaUeaO7hoZaj/lAbwawuRyCY0iYJyGPpRY2KeE+/OSfDXsAWuPf2OWVh9NxtRqdCzF2
         rIdrqmDQqhqHwHcdn1cmAtDZb7SYig3gAhZJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XdkuXzvsU8Qmmgk1oFXQM7A/zqUKyIIaZpyPEVdNOeA=;
        b=L4jWTOeu17hTAfotaYoeurDiaq30wpy8Lxpa+DvWIta9Ff3EosZLZX0bVwHZVEETLs
         4PvT7BzXhdRWkIiaIebT41OYI3TtfkiFFLRXkeopXr7aUzr1lUEJp9v+0ScNUXJ5BHnZ
         vS3UY+YBxN/+lOPK2V3Rkkdu2D0En/SCPQjZg/TeBVYfmm09dt/x2tlC3QpCNi5+9B46
         cdjNsuaTAx7qNON6eiXjo/HSDgseHi2ywCe18iqgC01YOqHv1cb5dlfhRFMwj66RZORf
         uFbitMoIEyTaV58lOrIk+xCeBD8mmcmNa4o/eZSDImRGcUr+0VT/35YE7Od13GhHtZQO
         zgkA==
X-Gm-Message-State: AOAM530XR4IFOpYzTsEhdy2wQHMPH/ve496hsxUzGas1Wk22+V/cTz4h
        3NyvBw5mGw4fUfRimNlJb690Tw==
X-Google-Smtp-Source: ABdhPJxRtrM2/49Je72bpHM2q09u+9Kclg+1x8oKck8ftlFcUfomI5ADI2wTOiWXIUoJ/CAsnmmgsA==
X-Received: by 2002:a63:7e43:0:b0:374:75ce:4d80 with SMTP id o3-20020a637e43000000b0037475ce4d80mr15356157pgn.589.1646766573686;
        Tue, 08 Mar 2022 11:09:33 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id q11-20020a63f94b000000b00373c5319642sm15865829pgk.93.2022.03.08.11.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:32 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 10/15] PM / devfreq: rk3399_dmc: Support new *-ns properties
Date:   Tue,  8 Mar 2022 11:08:56 -0800
Message-Id: <20220308110825.v4.10.I4e01e243ea11e9f95295b40b44a9eaa3a883a0dd@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308190901.3144566-1-briannorris@chromium.org>
References: <20220308190901.3144566-1-briannorris@chromium.org>
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

We want to keep the idle time fixed, so compute based on the current DDR
frequency.

The old properties were deprecated and never used, so we can safely drop
them from the driver.

This is a rewritten version of work by Lin Huang <hl@rock-chips.com>.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v2)

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
2.35.1.616.g0bdcbb4464-goog

