Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D049E4D0C97
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbiCHALi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344058AbiCHAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:11:28 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190E437A09
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:10:21 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o26so14913900pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MGvJc+Ve3oy0Yq0K3bpgSkrQ5JxGu0c98z8DVJNiX8g=;
        b=UB7j9G1HDj04FKQq7m2izcjNzAJC52qy1efJ/GUa/pZUqutvSGGJByhja3yVXdXyDg
         C2cXCAhR5ANOcvQB2Q9i8RSwlE1W6Dt3vvOBdaY38GV2n7wkM+qlp0XGqkJDsLr+EmUA
         R5+jzG5umnOk7AktqvwDO5M1kfCtVJE9PX1kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MGvJc+Ve3oy0Yq0K3bpgSkrQ5JxGu0c98z8DVJNiX8g=;
        b=H7E9NE9+Ih1NKWAK5TMAUBDXl+3gkcyer9H0KoikAxS//+FOpNaXHDYPkAh5I5VrdM
         Q5/L4UnSRLwgIdt/cVW+pL+MEXXU1IQvH93t4f1R+BlXyw8ce+40A+IxP+lavYzL5+J8
         txR1FbW6Xr0JiCFhSrEyBYute6fYLSWAObXpRnemxdMXFtJ/tyN8aCYfXm+zrWDuTDj5
         i7CBSxbWfeWAAJrER5U28z927HwQG+jb7qEx15JWqZw6n7wsyfdnBLY1hh+dGUiFLne3
         TZTGEBDPx0v3/bN4RgkztKek1y/iPKu+JQnn8qFk0XQn1dMWr6wrmQMo12C/+fgsg5ls
         OjrA==
X-Gm-Message-State: AOAM531YPGRW+031oOvizq8ZP4g5yw3VMYF+tqLzGl7a3IoD/HN0WXbZ
        DKVEaHfC372nThdVUK3BiyBmnA==
X-Google-Smtp-Source: ABdhPJzyjRDgpUUUw66qx9ApKgD161Rwe+h47hLyiildmJsL1cTCNh3MlFkbanKJEadiAqA6N2lCag==
X-Received: by 2002:a63:8bca:0:b0:37f:ed6e:e49e with SMTP id j193-20020a638bca000000b0037fed6ee49emr12004065pge.347.1646698220460;
        Mon, 07 Mar 2022 16:10:20 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id u18-20020a056a00159200b004f708ecd48esm4756481pfk.149.2022.03.07.16.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:19 -0800 (PST)
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
Subject: [PATCH v3 07/15] PM / devfreq: rk3399_dmc: Drop excess timing properties
Date:   Mon,  7 Mar 2022 16:09:37 -0800
Message-Id: <20220307160918.v3.7.Ia0f7d6168a71ba4a4fd0519972a8dfd4c681fc25@changeid>
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

(no changes since v1)

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
2.35.1.616.g0bdcbb4464-goog

