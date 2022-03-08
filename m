Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F324D0C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbiCHALo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344098AbiCHAL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:11:29 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A672137AB4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:10:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso701247pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+3SrDNrw/tlXyCfJ6sF6gqf9JcGrmJbnTr1rnT8D4k=;
        b=kes5rEKlUiDwu4xIwi7h/eVnPHdmYkXmiqCB/KbXLeXtt20LcwQZ3cMEeUEPQk4WNl
         YSUPeUv55tPVK1HWOo460cP56vBx8LlWZBFLM+eRKEu3HPYXxnf4NZMnpuN7gLxgb3L/
         NNiZoLQHNnecCeOOZOaQQqejRta7Wlhv54aaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+3SrDNrw/tlXyCfJ6sF6gqf9JcGrmJbnTr1rnT8D4k=;
        b=nVLoqWTdiLYJb0Nwqsc3sxGScAWklUKM6n5utTXR378JMeLr0eTvt/qWo+21f8XPAX
         EPktmBteRKanJGlyOql/zOx2oZ81lAuqrKoJDBluZMrJYXfNJ0yFAXPQ3jQJxmtSa5+h
         WBLtTYtyBx0/TsMjt5hrnstgFPHjLaQwVHnL1Vv0RaMzZ4HZ2lJiqcPwzh4RioJ2iwJa
         j2mJtWMr8qQ/IAc5pq8gRP0Uejv07XMBg4IQYcDL8Y3irxkVMK3kesnpUYcGR9U1O4Oq
         iN96JJXjRaP45KJk+Rh50pgT1xx9xWLEgC/ZMgK3Ng+pkA3RICz0ZzgLnKfOA9eTa1ep
         wXZg==
X-Gm-Message-State: AOAM532Y1yUUwCGEwruooPE82Uo1DeZpq8rVA9W5qDxoPSBTO0b2RPFf
        AbCz2xlAcWB4d4nqYyaWQJxwSw==
X-Google-Smtp-Source: ABdhPJxrjIg4zE5+KWt3LU+HcZ0lUvwuOMu/+VLBS5mYdRjIaE2N6sRh1NSOGgpGd5rHYHS3YTVxNA==
X-Received: by 2002:a17:90b:3807:b0:1bf:6c59:c6ff with SMTP id mq7-20020a17090b380700b001bf6c59c6ffmr1627584pjb.211.1646698224905;
        Mon, 07 Mar 2022 16:10:24 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id d7-20020a056a00244700b004e1300a2f7csm17255136pfj.212.2022.03.07.16.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:24 -0800 (PST)
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
Subject: [PATCH v3 09/15] PM / devfreq: rk3399_dmc: Support new disable-freq properties
Date:   Mon,  7 Mar 2022 16:09:39 -0800
Message-Id: <20220307160918.v3.9.I08d654522b8a1ae92ecb8d2e2a74511f778f61e5@changeid>
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

Implement the newly-defined properties to allow disabling certain
power-saving-at-idle features at higher frequencies.

This is a rewritten version of work by Lin Huang <hl@rock-chips.com>.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/devfreq/rk3399_dmc.c | 51 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index c4efbc15cbb1..fc740c1f6747 100644
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
 
+	ret |= of_property_read_u32(np, "rockchip,pd-idle-dis-freq-hz",
+				    &data->pd_idle_dis_freq);
+	ret |= of_property_read_u32(np, "rockchip,sr-idle-dis-freq-hz",
+				    &data->sr_idle_dis_freq);
+	ret |= of_property_read_u32(np, "rockchip,sr-mc-gate-idle-dis-freq-hz",
+				    &data->sr_mc_gate_idle_dis_freq);
+	ret |= of_property_read_u32(np, "rockchip,srpd-lite-idle-dis-freq-hz",
+				    &data->srpd_lite_idle_dis_freq);
+	ret |= of_property_read_u32(np, "rockchip,standby-idle-dis-freq-hz",
+				    &data->standby_idle_dis_freq);
+
 	return ret;
 }
 
-- 
2.35.1.616.g0bdcbb4464-goog

