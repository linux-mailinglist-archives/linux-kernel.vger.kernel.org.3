Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84F74D211F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245600AbiCHTK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349904AbiCHTKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:10:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608494BFDD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:09:31 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p17so17935753plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+3SrDNrw/tlXyCfJ6sF6gqf9JcGrmJbnTr1rnT8D4k=;
        b=aTcw+M9ZEjgQzvHb2+BdfgWDVyy/gqv5aSCeebSGzwwxeCMUmlW1xmSgRWAvNU1At1
         /pdzpY6AdbwjCKjYykANs3xpmYG+vh6AvryxdeP1GLycmS8VbFw0jy+ocCXyEpDTNtc4
         CFSpiy5Srfv0UNyFRlGBbftnhntJ6HkkG6RE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+3SrDNrw/tlXyCfJ6sF6gqf9JcGrmJbnTr1rnT8D4k=;
        b=nxOm0cAEQsAfQmvdEi0pbUZMEmmRDaji7dO8pp5gIu4CTK0sOaRMRPBae974b2FFXb
         Y3TIMzEDdZm1YcQHnMNBnHhYBQ5QatViLB4F8SBbrsMmdLCjVbNP7UrCDIIB1kR7WaAf
         A6Aik97g2JG7t5HJS4nV+outA9Jok6zNzHFB052nVGJ7p+n1w4K3GW69WuOnNG4J5NoX
         4yUYxdgxQyCXijau0S6i5ihqKB/6ZiU9FGhLn+n4xkUJ1kXwPtCXjPVWG6odIvLRmvId
         Bwh9ukIaOBAFaQBHxu7MW+8LvNduj5dn4rgev1Ph5bVfy8vdEpcJLH3iPmnhJsq1JM+J
         hdcg==
X-Gm-Message-State: AOAM530KTYmvxGDMsyyNkiFr6vb58h7euN/nPbIYc3Ks5tGJb7JzpS8Y
        ldqx6t69Z5GRX9brpqL7b653Pg==
X-Google-Smtp-Source: ABdhPJzWjgyBSd1wfd+6BvA5Q07fS6h4JlkXLbFWvC6IHIPEFkE8HBBZUbuG254hRo64x4r88itRYw==
X-Received: by 2002:a17:902:cf05:b0:14d:5249:3b1f with SMTP id i5-20020a170902cf0500b0014d52493b1fmr18666116plg.135.1646766570855;
        Tue, 08 Mar 2022 11:09:30 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id mt15-20020a17090b230f00b001bf191e6f08sm3622423pjb.9.2022.03.08.11.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:30 -0800 (PST)
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
Subject: [PATCH v4 09/15] PM / devfreq: rk3399_dmc: Support new disable-freq properties
Date:   Tue,  8 Mar 2022 11:08:55 -0800
Message-Id: <20220308110825.v4.9.I08d654522b8a1ae92ecb8d2e2a74511f778f61e5@changeid>
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

