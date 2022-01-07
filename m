Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AEC487FB6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiAGXxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiAGXxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:53:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C2C061763
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:53:42 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso12333818pjm.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fo7MtS17rkUvmbaM/Uvg709jlFSobNAPiAMJh0FigaM=;
        b=fSm7J0uiwb17KOSyzyl61f+8mwrl0o5hL7QEjeyMf7wS5AmQDhfBg9xblIB5W9moOJ
         4DkkZ99h02NPOvtMt8kNaJpyUX7qzNJ4A5sGcVgS+fW5rXzix2v0ztiZfhC91pNL9haA
         pz1zbyFqf20YGMkR8dh0gFcF2EQXmzR0xWlVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fo7MtS17rkUvmbaM/Uvg709jlFSobNAPiAMJh0FigaM=;
        b=u6FoaQQZ5ji8foVKftndfmqJObdAFj4P7jqj1/n5o91r51yx/NU0PWv4bJIA2NPBLt
         ukof30IKyL7Yt4Gg6Nf5WyjZA3IeSAAWG1sOpBK7zMo+OSllivwBlDGbb2V23xS/G3LR
         TK1hITrzk+3Jem+rbzPYaTd8n5WNeb2G/vQ8J+3ZfSjqu/E/oOWD0jSRS37MjBZOeEVn
         +fdW5ZqOdJd8XJdgnUC130u5F42ofhGOH75vx/CMDxebPdCJVhWFqbX8mieMsI6Vz8XY
         LOf3cq2SwaFX/eRuzD2G79WC8skGdK4DPBV/Lme2j0oeUX/DccEdOg6u5RNBr1BpvyYh
         rSMQ==
X-Gm-Message-State: AOAM5312MvWz30B/DghkhAIgjoPah0WT5N7T4d7/XH5TgqVxcGhHkVCl
        6fSxvtz7z6eXwrthjIPpKV6nYA==
X-Google-Smtp-Source: ABdhPJzb90L7hROlDUtE7Sn6Ih+ihkNKTqcbGYvSCEKak9WB1KlTMVy28l/ZxdhjcDndIARS2jNjCw==
X-Received: by 2002:a17:90b:1d07:: with SMTP id on7mr18400843pjb.177.1641599622416;
        Fri, 07 Jan 2022 15:53:42 -0800 (PST)
Received: from localhost ([2620:15c:202:201:db:1c60:693f:c24e])
        by smtp.gmail.com with UTF8SMTPSA id c10sm45878pfl.200.2022.01.07.15.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 15:53:41 -0800 (PST)
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
Subject: [PATCH 06/10] PM / devfreq: rk3399_dmc: Drop excess timing properties
Date:   Fri,  7 Jan 2022 15:53:16 -0800
Message-Id: <20220107155215.6.Ia0f7d6168a71ba4a4fd0519972a8dfd4c681fc25@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107235320.965497-1-briannorris@chromium.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of these properties are initialized by ARM Trusted Firmware, and
have been since the early days of this chip. It's redundant (and
possibly wrong) to do this here now. What's more, there seems to be some
confusion about the units and some of the definitions of this timing
struct: the DT docs say MHz for many of these, but downstream users were
in Hz (and therefore, the ATF interface was Hz). Also, the in-driver
usage for some of these (e.g., for comparing to target frequency) were
in Hz too. So doubly wrong.

We can avoid thinking about who got the right units by dropping the
unnecessary code and properties. They are marked deprecated in the
binding schema.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/devfreq/rk3399_dmc.c | 144 +++++++----------------------------
 1 file changed, 29 insertions(+), 115 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e982862f6ac2..8f447217303f 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -23,38 +23,6 @@
 #include <soc/rockchip/rk3399_grf.h>
 #include <soc/rockchip/rockchip_sip.h>
 
-struct dram_timing {
-	unsigned int ddr3_speed_bin;
-	unsigned int pd_idle;
-	unsigned int sr_idle;
-	unsigned int sr_mc_gate_idle;
-	unsigned int srpd_lite_idle;
-	unsigned int standby_idle;
-	unsigned int auto_pd_dis_freq;
-	unsigned int dram_dll_dis_freq;
-	unsigned int phy_dll_dis_freq;
-	unsigned int ddr3_odt_dis_freq;
-	unsigned int ddr3_drv;
-	unsigned int ddr3_odt;
-	unsigned int phy_ddr3_ca_drv;
-	unsigned int phy_ddr3_dq_drv;
-	unsigned int phy_ddr3_odt;
-	unsigned int lpddr3_odt_dis_freq;
-	unsigned int lpddr3_drv;
-	unsigned int lpddr3_odt;
-	unsigned int phy_lpddr3_ca_drv;
-	unsigned int phy_lpddr3_dq_drv;
-	unsigned int phy_lpddr3_odt;
-	unsigned int lpddr4_odt_dis_freq;
-	unsigned int lpddr4_drv;
-	unsigned int lpddr4_dq_odt;
-	unsigned int lpddr4_ca_odt;
-	unsigned int phy_lpddr4_ca_drv;
-	unsigned int phy_lpddr4_ck_cs_drv;
-	unsigned int phy_lpddr4_dq_drv;
-	unsigned int phy_lpddr4_odt;
-};
-
 struct rk3399_dmcfreq {
 	struct device *dev;
 	struct devfreq *devfreq;
@@ -62,13 +30,21 @@ struct rk3399_dmcfreq {
 	struct clk *dmc_clk;
 	struct devfreq_event_dev *edev;
 	struct mutex lock;
-	struct dram_timing timing;
 	struct regulator *vdd_center;
 	struct regmap *regmap_pmu;
 	unsigned long rate, target_rate;
 	unsigned long volt, target_volt;
 	unsigned int odt_dis_freq;
 	int odt_pd_arg0, odt_pd_arg1;
+
+	unsigned int pd_idle;
+	unsigned int sr_idle;
+	unsigned int sr_mc_gate_idle;
+	unsigned int srpd_lite_idle;
+	unsigned int standby_idle;
+	unsigned int ddr3_odt_dis_freq;
+	unsigned int lpddr3_odt_dis_freq;
+	unsigned int lpddr4_odt_dis_freq;
 };
 
 static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
@@ -238,69 +214,27 @@ static __maybe_unused int rk3399_dmcfreq_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(rk3399_dmcfreq_pm, rk3399_dmcfreq_suspend,
 			 rk3399_dmcfreq_resume);
 
-static int of_get_ddr_timings(struct dram_timing *timing,
-			      struct device_node *np)
+static int rk3399_dmcfreq_of_props(struct rk3399_dmcfreq *data,
+				   struct device_node *np)
 {
 	int ret = 0;
 
-	ret = of_property_read_u32(np, "rockchip,ddr3_speed_bin",
-				   &timing->ddr3_speed_bin);
 	ret |= of_property_read_u32(np, "rockchip,pd_idle",
-				    &timing->pd_idle);
+				    &data->pd_idle);
 	ret |= of_property_read_u32(np, "rockchip,sr_idle",
-				    &timing->sr_idle);
+				    &data->sr_idle);
 	ret |= of_property_read_u32(np, "rockchip,sr_mc_gate_idle",
-				    &timing->sr_mc_gate_idle);
+				    &data->sr_mc_gate_idle);
 	ret |= of_property_read_u32(np, "rockchip,srpd_lite_idle",
-				    &timing->srpd_lite_idle);
+				    &data->srpd_lite_idle);
 	ret |= of_property_read_u32(np, "rockchip,standby_idle",
-				    &timing->standby_idle);
-	ret |= of_property_read_u32(np, "rockchip,auto_pd_dis_freq",
-				    &timing->auto_pd_dis_freq);
-	ret |= of_property_read_u32(np, "rockchip,dram_dll_dis_freq",
-				    &timing->dram_dll_dis_freq);
-	ret |= of_property_read_u32(np, "rockchip,phy_dll_dis_freq",
-				    &timing->phy_dll_dis_freq);
+				    &data->standby_idle);
 	ret |= of_property_read_u32(np, "rockchip,ddr3_odt_dis_freq",
-				    &timing->ddr3_odt_dis_freq);
-	ret |= of_property_read_u32(np, "rockchip,ddr3_drv",
-				    &timing->ddr3_drv);
-	ret |= of_property_read_u32(np, "rockchip,ddr3_odt",
-				    &timing->ddr3_odt);
-	ret |= of_property_read_u32(np, "rockchip,phy_ddr3_ca_drv",
-				    &timing->phy_ddr3_ca_drv);
-	ret |= of_property_read_u32(np, "rockchip,phy_ddr3_dq_drv",
-				    &timing->phy_ddr3_dq_drv);
-	ret |= of_property_read_u32(np, "rockchip,phy_ddr3_odt",
-				    &timing->phy_ddr3_odt);
+				    &data->ddr3_odt_dis_freq);
 	ret |= of_property_read_u32(np, "rockchip,lpddr3_odt_dis_freq",
-				    &timing->lpddr3_odt_dis_freq);
-	ret |= of_property_read_u32(np, "rockchip,lpddr3_drv",
-				    &timing->lpddr3_drv);
-	ret |= of_property_read_u32(np, "rockchip,lpddr3_odt",
-				    &timing->lpddr3_odt);
-	ret |= of_property_read_u32(np, "rockchip,phy_lpddr3_ca_drv",
-				    &timing->phy_lpddr3_ca_drv);
-	ret |= of_property_read_u32(np, "rockchip,phy_lpddr3_dq_drv",
-				    &timing->phy_lpddr3_dq_drv);
-	ret |= of_property_read_u32(np, "rockchip,phy_lpddr3_odt",
-				    &timing->phy_lpddr3_odt);
+				    &data->lpddr3_odt_dis_freq);
 	ret |= of_property_read_u32(np, "rockchip,lpddr4_odt_dis_freq",
-				    &timing->lpddr4_odt_dis_freq);
-	ret |= of_property_read_u32(np, "rockchip,lpddr4_drv",
-				    &timing->lpddr4_drv);
-	ret |= of_property_read_u32(np, "rockchip,lpddr4_dq_odt",
-				    &timing->lpddr4_dq_odt);
-	ret |= of_property_read_u32(np, "rockchip,lpddr4_ca_odt",
-				    &timing->lpddr4_ca_odt);
-	ret |= of_property_read_u32(np, "rockchip,phy_lpddr4_ca_drv",
-				    &timing->phy_lpddr4_ca_drv);
-	ret |= of_property_read_u32(np, "rockchip,phy_lpddr4_ck_cs_drv",
-				    &timing->phy_lpddr4_ck_cs_drv);
-	ret |= of_property_read_u32(np, "rockchip,phy_lpddr4_dq_drv",
-				    &timing->phy_lpddr4_dq_drv);
-	ret |= of_property_read_u32(np, "rockchip,phy_lpddr4_odt",
-				    &timing->phy_lpddr4_odt);
+				    &data->lpddr4_odt_dis_freq);
 
 	return ret;
 }
@@ -311,8 +245,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node, *node;
 	struct rk3399_dmcfreq *data;
-	int ret, index, size;
-	uint32_t *timing;
+	int ret;
 	struct dev_pm_opp *opp;
 	u32 ddr_type;
 	u32 val;
@@ -343,26 +276,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/*
-	 * Get dram timing and pass it to arm trust firmware,
-	 * the dram driver in arm trust firmware will get these
-	 * timing and to do dram initial.
-	 */
-	if (!of_get_ddr_timings(&data->timing, np)) {
-		timing = &data->timing.ddr3_speed_bin;
-		size = sizeof(struct dram_timing) / 4;
-		for (index = 0; index < size; index++) {
-			arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, *timing++, index,
-				      ROCKCHIP_SIP_CONFIG_DRAM_SET_PARAM,
-				      0, 0, 0, 0, &res);
-			if (res.a0) {
-				dev_err(dev, "Failed to set dram param: %ld\n",
-					res.a0);
-				ret = -EINVAL;
-				goto err_edev;
-			}
-		}
-	}
+	rk3399_dmcfreq_of_props(data, np);
 
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
 	if (!node)
@@ -381,13 +295,13 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	switch (ddr_type) {
 	case RK3399_PMUGRF_DDRTYPE_DDR3:
-		data->odt_dis_freq = data->timing.ddr3_odt_dis_freq;
+		data->odt_dis_freq = data->ddr3_odt_dis_freq;
 		break;
 	case RK3399_PMUGRF_DDRTYPE_LPDDR3:
-		data->odt_dis_freq = data->timing.lpddr3_odt_dis_freq;
+		data->odt_dis_freq = data->lpddr3_odt_dis_freq;
 		break;
 	case RK3399_PMUGRF_DDRTYPE_LPDDR4:
-		data->odt_dis_freq = data->timing.lpddr4_odt_dis_freq;
+		data->odt_dis_freq = data->lpddr4_odt_dis_freq;
 		break;
 	default:
 		ret = -EINVAL;
@@ -414,11 +328,11 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	 * arg2:
 	 *     bit[0]     : odt enable
 	 */
-	data->odt_pd_arg0 = (data->timing.sr_idle & 0xff) |
-			    ((data->timing.sr_mc_gate_idle & 0xff) << 8) |
-			    ((data->timing.standby_idle & 0xffff) << 16);
-	data->odt_pd_arg1 = (data->timing.pd_idle & 0xfff) |
-			    ((data->timing.srpd_lite_idle & 0xfff) << 16);
+	data->odt_pd_arg0 = (data->sr_idle & 0xff) |
+			    ((data->sr_mc_gate_idle & 0xff) << 8) |
+			    ((data->standby_idle & 0xffff) << 16);
+	data->odt_pd_arg1 = (data->pd_idle & 0xfff) |
+			    ((data->srpd_lite_idle & 0xfff) << 16);
 
 	/*
 	 * We add a devfreq driver to our parent since it has a device tree node
-- 
2.34.1.575.g55b058a8bb-goog

