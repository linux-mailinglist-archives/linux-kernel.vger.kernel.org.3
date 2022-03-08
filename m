Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49C14D210F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349949AbiCHTKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349911AbiCHTKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:10:25 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BBD4A3CE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:09:26 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d17so197593pfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MGvJc+Ve3oy0Yq0K3bpgSkrQ5JxGu0c98z8DVJNiX8g=;
        b=NOrGr4vMwXpdp5J0k2X41Gy+WSY8DEp7MQcwRe2e3Dx3IMs3z4xNrxyR+7wx2wGxNB
         d7VtVskm1B4sNzZoz2CBQ+GPTaIPpU2iG2EQ78RYY43K659GFbd3uwIbhK/LB7FH6Y2h
         e8CKd2TsZ6BW9wRAAqH+xrnTt+g5dK3qDls/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MGvJc+Ve3oy0Yq0K3bpgSkrQ5JxGu0c98z8DVJNiX8g=;
        b=wY6rpat3VuXr9XFAAKhTwYZ21Zf5JpbhvDR8H74SkCKUVHrG8Cj0fwaKv0/U+sg2Zu
         M3mKFxCoJtQbiLhytgMrxBypmgNqqUj6X8yRhBonuR45wc02TeMBb8Y1g2kc9Nr2k4pC
         p2P43U9nrUgMjknuFKbYp+3EJYOB71HMNQeYB+3GMTxTK2/tjXwzCzmo6aFKoypD8ctx
         JJ+qPzg0h+GgRyuMTKDZKDewhpA88ix9uxftccHiivKyiL6PF0IIgGSfdAI8pA2AaJQs
         0ePB8DU3K3ofF5kIzJSFSq882K0uk2SYXCJCmga3wio1qTPWjXyJEZxiEEUwu633jnGJ
         ttog==
X-Gm-Message-State: AOAM531laa27iQ3z8KQS5pVKTyfObgWnCtqZi3sy7S1V/ZKxSAE4Xme6
        Jp4q/c+kb1BRxHiSk5dQAn+vNA==
X-Google-Smtp-Source: ABdhPJxxzJ/Hw8tQQls00LevA33RIKViziiy3kGxSNaj5N/yoBMPP2JAvI9Q6tzRCqvYRxHuZcX4hQ==
X-Received: by 2002:a63:f04f:0:b0:373:bd70:af2 with SMTP id s15-20020a63f04f000000b00373bd700af2mr15219130pgj.497.1646766566341;
        Tue, 08 Mar 2022 11:09:26 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id k1-20020a056a00168100b004e0e45a39c6sm21486873pfc.181.2022.03.08.11.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:25 -0800 (PST)
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
Subject: [PATCH v4 07/15] PM / devfreq: rk3399_dmc: Drop excess timing properties
Date:   Tue,  8 Mar 2022 11:08:53 -0800
Message-Id: <20220308110825.v4.7.Ia0f7d6168a71ba4a4fd0519972a8dfd4c681fc25@changeid>
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

