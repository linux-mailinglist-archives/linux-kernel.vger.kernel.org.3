Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA8C4D2115
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349936AbiCHTKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349895AbiCHTKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:10:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C07A4B417
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:09:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so194345pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qamn1KXLKkoAp4pJxR8atvIxLoRPmk7xdgGcjv6i0+c=;
        b=KWpUP9V1zWY6hI52DajnsMEkJD26WM9/Ne3QgRKuLujtTMP2693SAgDCFDcDgwEAt1
         61zLFBQ2BCxo90/6a+I4tJNLsduxlllG5zcG6lqTCv5kSeKtgZuSVDFCSH7lWIyVt0gh
         jIix0O3NEpZiThGtbsqHsraHNYAV0oKrhUEm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qamn1KXLKkoAp4pJxR8atvIxLoRPmk7xdgGcjv6i0+c=;
        b=GirR9mu7NjXjz4kg4sStCYhAkxIloBBK65ZPhL6tBcDp+sFQPJVM3nu/dUb3+SpyTx
         cjpRNJEKz8mps2y2tsEgpI36oGmNpXTdN/857olVrtIrpPu+3DH/mHHINxovG00GRf3w
         BQ2kTGnIDS+PpWZOHqAkkHuHHyNpFRCtSUi+ElAjAfzn91LFPLguc8IvTZyxtkhATm+q
         hO0VmOBMEl4qJgEK6iCJ87H1bLt4ziekWlyZ976llqxHqHe/NozlIu20fL7zaIIzPLh1
         nEs+PeK22JB+NXhy6zzsjFVsZ/oHR6nlG/BT0d9uE/dCFaTnLkSXM/09jddiEFMqRH6U
         UZ9A==
X-Gm-Message-State: AOAM5330uLiV0Qm/+tZkXhgL0dxeD+V611l/v9WXo9lbxCFT578MVLnY
        4sQO/IriCfnVIE/C20nDuN94c1WVi2ozfg==
X-Google-Smtp-Source: ABdhPJxMRM3jSlzJKvwYSqv2fc/aj5x5HjMrnLPxxun/3azB6oM37SyO01OzdnD9GIMEeXXx7+NFgg==
X-Received: by 2002:a17:90a:3906:b0:1bf:a0a6:d208 with SMTP id y6-20020a17090a390600b001bfa0a6d208mr1809264pjb.21.1646766568597;
        Tue, 08 Mar 2022 11:09:28 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id f13-20020a056a001acd00b004f0f9a967basm20781448pfv.100.2022.03.08.11.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:28 -0800 (PST)
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
Subject: [PATCH v4 08/15] PM / devfreq: rk3399_dmc: Use bitfield macro definitions for ODT_PD
Date:   Tue,  8 Mar 2022 11:08:54 -0800
Message-Id: <20220308110825.v4.8.I0f36da588afd01d0dc9ce5866240efa34bd91e21@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308190901.3144566-1-briannorris@chromium.org>
References: <20220308190901.3144566-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to add new usages, and it's cleaner to work with macros
instead of comments and magic numbers.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/devfreq/rk3399_dmc.c | 43 ++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 8f447217303f..c4efbc15cbb1 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/devfreq.h>
@@ -23,6 +24,15 @@
 #include <soc/rockchip/rk3399_grf.h>
 #include <soc/rockchip/rockchip_sip.h>
 
+#define RK3399_SET_ODT_PD_0_SR_IDLE			GENMASK(7, 0)
+#define RK3399_SET_ODT_PD_0_SR_MC_GATE_IDLE		GENMASK(15, 8)
+#define RK3399_SET_ODT_PD_0_STANDBY_IDLE		GENMASK(31, 16)
+
+#define RK3399_SET_ODT_PD_1_PD_IDLE			GENMASK(11, 0)
+#define RK3399_SET_ODT_PD_1_SRPD_LITE_IDLE		GENMASK(27, 16)
+
+#define RK3399_SET_ODT_PD_2_ODT_ENABLE			BIT(0)
+
 struct rk3399_dmcfreq {
 	struct device *dev;
 	struct devfreq *devfreq;
@@ -55,7 +65,6 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	unsigned long old_clk_rate = dmcfreq->rate;
 	unsigned long target_volt, target_rate;
 	struct arm_smccc_res res;
-	bool odt_enable = false;
 	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
@@ -72,8 +81,10 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	mutex_lock(&dmcfreq->lock);
 
 	if (dmcfreq->regmap_pmu) {
+		unsigned int odt_pd_arg2 = 0;
+
 		if (target_rate >= dmcfreq->odt_dis_freq)
-			odt_enable = true;
+			odt_pd_arg2 |= RK3399_SET_ODT_PD_2_ODT_ENABLE;
 
 		/*
 		 * This makes a SMC call to the TF-A to set the DDR PD
@@ -83,7 +94,7 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 		arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
 			      dmcfreq->odt_pd_arg1,
 			      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
-			      odt_enable, 0, 0, 0, &res);
+			      odt_pd_arg2, 0, 0, 0, &res);
 	}
 
 	/*
@@ -316,23 +327,17 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	/*
 	 * In TF-A there is a platform SIP call to set the PD (power-down)
 	 * timings and to enable or disable the ODT (on-die termination).
-	 * This call needs three arguments as follows:
-	 *
-	 * arg0:
-	 *     bit[0-7]   : sr_idle
-	 *     bit[8-15]  : sr_mc_gate_idle
-	 *     bit[16-31] : standby idle
-	 * arg1:
-	 *     bit[0-11]  : pd_idle
-	 *     bit[16-27] : srpd_lite_idle
-	 * arg2:
-	 *     bit[0]     : odt enable
 	 */
-	data->odt_pd_arg0 = (data->sr_idle & 0xff) |
-			    ((data->sr_mc_gate_idle & 0xff) << 8) |
-			    ((data->standby_idle & 0xffff) << 16);
-	data->odt_pd_arg1 = (data->pd_idle & 0xfff) |
-			    ((data->srpd_lite_idle & 0xfff) << 16);
+	data->odt_pd_arg0 =
+		FIELD_PREP(RK3399_SET_ODT_PD_0_SR_IDLE, data->sr_idle) |
+		FIELD_PREP(RK3399_SET_ODT_PD_0_SR_MC_GATE_IDLE,
+			   data->sr_mc_gate_idle) |
+		FIELD_PREP(RK3399_SET_ODT_PD_0_STANDBY_IDLE,
+			   data->standby_idle);
+	data->odt_pd_arg1 =
+		FIELD_PREP(RK3399_SET_ODT_PD_1_PD_IDLE, data->pd_idle) |
+		FIELD_PREP(RK3399_SET_ODT_PD_1_SRPD_LITE_IDLE,
+			   data->srpd_lite_idle);
 
 	/*
 	 * We add a devfreq driver to our parent since it has a device tree node
-- 
2.35.1.616.g0bdcbb4464-goog

