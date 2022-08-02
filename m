Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B6588463
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiHBWiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbiHBWh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:37:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0435183BC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:37:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v18so14721879plo.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=70tgsTToQyngoKvQL1zGXWfJI+4T6mTRNc2DsRt8wBg=;
        b=OUuQ8ZX2m7oiDjZiZZz7emZKpfC5o6AfaNCX9b08AJae6wJ0pYgpSi+H0eVgvrkCDZ
         UkVkEDtwm9ZwgfKFvkb1tNe1nzEWv8+uzO5snMApAVRYpRxc+c60nzvrXJpBJglKBtcY
         4a8Sc8EdfhpWcKr7A/dJAZj/3G6L2u/DfzGNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=70tgsTToQyngoKvQL1zGXWfJI+4T6mTRNc2DsRt8wBg=;
        b=PBjx8a0hVpyLuZujVGs+DJaXaDA5WhN4h00JwPintOrjFWseJBkfemLEOWs69ARTQI
         luW0oDB5a+M39eUMZnuaeaDAvDrB2chsuEfkOUWV/SL9vyoL6yjBsE4Qqrm4Tyn0kkIT
         XZl6l40ZmeWGFFaqEDm3aK5GgnHkipdP6BHkAz+0IFQQFmvp0nmt7D8ACZDRQfZonaBj
         B1zHMdEPi2Yh14Hny+o1rT/8j0ZfirZn0EQ04jSoeKEnFtrxMnoFXlTv7TY6V0NlIn+E
         //YsnrrLDSfKgpdQWe3Yn3YN0mYzR+Wp0OqQtGkhavAT8kopZcezWWIBCrvx5WrdWsAg
         pEvg==
X-Gm-Message-State: ACgBeo3xzK7d/QGuZTG9Yfc3J/lYsN1qdLumhEoDvqFP1ZBA+Ggmyz54
        3olQzKU/0ptusQySG2txDbWAbg==
X-Google-Smtp-Source: AA6agR4V2IqUluzEe8H06Cw96GmrlrqYcBZsin9VMDPLhSNbCaG0W+ISLlPsUGyvOxFKYsqiZRUPdA==
X-Received: by 2002:a17:902:ef4f:b0:16c:d1a7:19f3 with SMTP id e15-20020a170902ef4f00b0016cd1a719f3mr23659328plx.65.1659479874044;
        Tue, 02 Aug 2022 15:37:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:31c9:9937:c6bb:62f5])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00528c066678csm11353030pfb.72.2022.08.02.15.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 15:37:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] drm/msm/dsi: Don't set a load before disabling a regulator
Date:   Tue,  2 Aug 2022 15:37:35 -0700
Message-Id: <20220802153434.v3.3.If1f94fbbdb7c1d0fb3961de61483a851ad1971a7@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220802223738.898592-1-dianders@chromium.org>
References: <20220802223738.898592-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 5451781dadf8 ("regulator: core: Only count load for
enabled consumers"), a load isn't counted for a disabled
regulator. That means all the code in the DSI driver to specify and
set loads before disabling a regulator is not actually doing anything
useful. Let's remove it.

It should be noted that all of the loads set that were being specified
were pointless noise anyway. The only use for this number is to pick
between low power and high power modes of regulators. Regulators
appear to do this changeover at loads on the order of 10000 uA. You
would need a lot of clients of the same rail for that 100 uA number to
count for anything.

Note that now that we get rid of the setting of the load at disable
time, we can just set the load once when we first get the regulator
and then forget it.

It should also be noted that the regulator functions
regulator_bulk_enable() and regulator_set_load() already print error
messages when they encounter problems so while moving things around we
get rid of some extra error prints.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Fix typo in commit message.
- Just directly call the bulk commands; get rid of the wrapper.

 drivers/gpu/drm/msm/dsi/dsi.h                 |  1 -
 drivers/gpu/drm/msm/dsi/dsi_cfg.c             | 52 +++++++-------
 drivers/gpu/drm/msm/dsi/dsi_host.c            | 71 ++++---------------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         | 52 ++------------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c    |  4 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c    |  6 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c    |  4 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c    |  6 +-
 .../gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c   |  2 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     |  6 +-
 10 files changed, 60 insertions(+), 144 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 580a1e6358bf..bb6a5bd05cb1 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -37,7 +37,6 @@ enum msm_dsi_phy_usecase {
 struct dsi_reg_entry {
 	char name[32];
 	int enable_load;
-	int disable_load;
 };
 
 struct dsi_reg_config {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 72c018e26f47..901d6fd53800 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -14,9 +14,9 @@ static const struct msm_dsi_config apq8064_dsi_cfg = {
 	.reg_cfg = {
 		.num = 3,
 		.regs = {
-			{"vdda", 100000, 100},	/* 1.2 V */
-			{"avdd", 10000, 100},	/* 3.0 V */
-			{"vddio", 100000, 100},	/* 1.8 V */
+			{"vdda", 100000},	/* 1.2 V */
+			{"avdd", 10000},	/* 3.0 V */
+			{"vddio", 100000},	/* 1.8 V */
 		},
 	},
 	.bus_clk_names = dsi_v2_bus_clk_names,
@@ -34,9 +34,9 @@ static const struct msm_dsi_config msm8974_apq8084_dsi_cfg = {
 	.reg_cfg = {
 		.num = 3,
 		.regs = {
-			{"vdd", 150000, 100},	/* 3.0 V */
-			{"vdda", 100000, 100},	/* 1.2 V */
-			{"vddio", 100000, 100},	/* 1.8 V */
+			{"vdd", 150000},	/* 3.0 V */
+			{"vdda", 100000},	/* 1.2 V */
+			{"vddio", 100000},	/* 1.8 V */
 		},
 	},
 	.bus_clk_names = dsi_6g_bus_clk_names,
@@ -54,8 +54,8 @@ static const struct msm_dsi_config msm8916_dsi_cfg = {
 	.reg_cfg = {
 		.num = 2,
 		.regs = {
-			{"vdda", 100000, 100},	/* 1.2 V */
-			{"vddio", 100000, 100},	/* 1.8 V */
+			{"vdda", 100000},	/* 1.2 V */
+			{"vddio", 100000},	/* 1.8 V */
 		},
 	},
 	.bus_clk_names = dsi_8916_bus_clk_names,
@@ -73,8 +73,8 @@ static const struct msm_dsi_config msm8976_dsi_cfg = {
 	.reg_cfg = {
 		.num = 2,
 		.regs = {
-			{"vdda", 100000, 100},	/* 1.2 V */
-			{"vddio", 100000, 100},	/* 1.8 V */
+			{"vdda", 100000},	/* 1.2 V */
+			{"vddio", 100000},	/* 1.8 V */
 		},
 	},
 	.bus_clk_names = dsi_8976_bus_clk_names,
@@ -88,12 +88,12 @@ static const struct msm_dsi_config msm8994_dsi_cfg = {
 	.reg_cfg = {
 		.num = 6,
 		.regs = {
-			{"vdda", 100000, 100},	/* 1.25 V */
-			{"vddio", 100000, 100},	/* 1.8 V */
-			{"vcca", 10000, 100},	/* 1.0 V */
-			{"vdd", 100000, 100},	/* 1.8 V */
-			{"lab_reg", -1, -1},
-			{"ibb_reg", -1, -1},
+			{"vdda", 100000},	/* 1.25 V */
+			{"vddio", 100000},	/* 1.8 V */
+			{"vcca", 10000},	/* 1.0 V */
+			{"vdd", 100000},	/* 1.8 V */
+			{"lab_reg", -1},
+			{"ibb_reg", -1},
 		},
 	},
 	.bus_clk_names = dsi_6g_bus_clk_names,
@@ -111,9 +111,9 @@ static const struct msm_dsi_config msm8996_dsi_cfg = {
 	.reg_cfg = {
 		.num = 3,
 		.regs = {
-			{"vdda", 18160, 1 },	/* 1.25 V */
-			{"vcca", 17000, 32 },	/* 0.925 V */
-			{"vddio", 100000, 100 },/* 1.8 V */
+			{"vdda", 18160},	/* 1.25 V */
+			{"vcca", 17000},	/* 0.925 V */
+			{"vddio", 100000},/* 1.8 V */
 		},
 	},
 	.bus_clk_names = dsi_8996_bus_clk_names,
@@ -131,8 +131,8 @@ static const struct msm_dsi_config msm8998_dsi_cfg = {
 	.reg_cfg = {
 		.num = 2,
 		.regs = {
-			{"vdd", 367000, 16 },	/* 0.9 V */
-			{"vdda", 62800, 2 },	/* 1.2 V */
+			{"vdd", 367000},	/* 0.9 V */
+			{"vdda", 62800},	/* 1.2 V */
 		},
 	},
 	.bus_clk_names = dsi_msm8998_bus_clk_names,
@@ -150,7 +150,7 @@ static const struct msm_dsi_config sdm660_dsi_cfg = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vdda", 12560, 4 },	/* 1.2 V */
+			{"vdda", 12560},	/* 1.2 V */
 		},
 	},
 	.bus_clk_names = dsi_sdm660_bus_clk_names,
@@ -172,7 +172,7 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vdda", 21800, 4 },	/* 1.2 V */
+			{"vdda", 21800},	/* 1.2 V */
 		},
 	},
 	.bus_clk_names = dsi_sdm845_bus_clk_names,
@@ -186,7 +186,7 @@ static const struct msm_dsi_config sc7180_dsi_cfg = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vdda", 21800, 4 },	/* 1.2 V */
+			{"vdda", 21800},	/* 1.2 V */
 		},
 	},
 	.bus_clk_names = dsi_sc7180_bus_clk_names,
@@ -204,7 +204,7 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vdda", 8350, 0 },	/* 1.2 V */
+			{"vdda", 8350},	/* 1.2 V */
 		},
 	},
 	.bus_clk_names = dsi_sc7280_bus_clk_names,
@@ -222,7 +222,7 @@ static const struct msm_dsi_config qcm2290_dsi_cfg = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vdda", 21800, 4 },	/* 1.2 V */
+			{"vdda", 21800},	/* 1.2 V */
 		},
 	},
 	.bus_clk_names = dsi_qcm2290_bus_clk_names,
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index a95d5df52653..9df278d39559 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -203,9 +203,6 @@ static inline void dsi_write(struct msm_dsi_host *msm_host, u32 reg, u32 data)
 	msm_writel(data, msm_host->ctrl_base + reg);
 }
 
-static int dsi_host_regulator_enable(struct msm_dsi_host *msm_host);
-static void dsi_host_regulator_disable(struct msm_dsi_host *msm_host);
-
 static const struct msm_dsi_cfg_handler *dsi_get_config(
 						struct msm_dsi_host *msm_host)
 {
@@ -256,56 +253,6 @@ static inline struct msm_dsi_host *to_msm_dsi_host(struct mipi_dsi_host *host)
 	return container_of(host, struct msm_dsi_host, base);
 }
 
-static void dsi_host_regulator_disable(struct msm_dsi_host *msm_host)
-{
-	struct regulator_bulk_data *s = msm_host->supplies;
-	const struct dsi_reg_entry *regs = msm_host->cfg_hnd->cfg->reg_cfg.regs;
-	int num = msm_host->cfg_hnd->cfg->reg_cfg.num;
-	int i;
-
-	DBG("");
-	for (i = num - 1; i >= 0; i--)
-		if (regs[i].disable_load >= 0)
-			regulator_set_load(s[i].consumer,
-					   regs[i].disable_load);
-
-	regulator_bulk_disable(num, s);
-}
-
-static int dsi_host_regulator_enable(struct msm_dsi_host *msm_host)
-{
-	struct regulator_bulk_data *s = msm_host->supplies;
-	const struct dsi_reg_entry *regs = msm_host->cfg_hnd->cfg->reg_cfg.regs;
-	int num = msm_host->cfg_hnd->cfg->reg_cfg.num;
-	int ret, i;
-
-	DBG("");
-	for (i = 0; i < num; i++) {
-		if (regs[i].enable_load >= 0) {
-			ret = regulator_set_load(s[i].consumer,
-						 regs[i].enable_load);
-			if (ret < 0) {
-				pr_err("regulator %d set op mode failed, %d\n",
-					i, ret);
-				goto fail;
-			}
-		}
-	}
-
-	ret = regulator_bulk_enable(num, s);
-	if (ret < 0) {
-		pr_err("regulator enable failed, %d\n", ret);
-		goto fail;
-	}
-
-	return 0;
-
-fail:
-	for (i--; i >= 0; i--)
-		regulator_set_load(s[i].consumer, regs[i].disable_load);
-	return ret;
-}
-
 static int dsi_regulator_init(struct msm_dsi_host *msm_host)
 {
 	struct regulator_bulk_data *s = msm_host->supplies;
@@ -323,6 +270,15 @@ static int dsi_regulator_init(struct msm_dsi_host *msm_host)
 		return ret;
 	}
 
+	for (i = 0; i < num; i++) {
+		if (regs[i].enable_load >= 0) {
+			ret = regulator_set_load(s[i].consumer,
+						 regs[i].enable_load);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -2561,7 +2517,8 @@ int msm_dsi_host_power_on(struct mipi_dsi_host *host,
 
 	msm_dsi_sfpb_config(msm_host, true);
 
-	ret = dsi_host_regulator_enable(msm_host);
+	ret = regulator_bulk_enable(msm_host->cfg_hnd->cfg->reg_cfg.num,
+				    msm_host->supplies);
 	if (ret) {
 		pr_err("%s:Failed to enable vregs.ret=%d\n",
 			__func__, ret);
@@ -2601,7 +2558,8 @@ int msm_dsi_host_power_on(struct mipi_dsi_host *host,
 	cfg_hnd->ops->link_clk_disable(msm_host);
 	pm_runtime_put(&msm_host->pdev->dev);
 fail_disable_reg:
-	dsi_host_regulator_disable(msm_host);
+	regulator_bulk_disable(msm_host->cfg_hnd->cfg->reg_cfg.num,
+			       msm_host->supplies);
 unlock_ret:
 	mutex_unlock(&msm_host->dev_mutex);
 	return ret;
@@ -2628,7 +2586,8 @@ int msm_dsi_host_power_off(struct mipi_dsi_host *host)
 	cfg_hnd->ops->link_clk_disable(msm_host);
 	pm_runtime_put(&msm_host->pdev->dev);
 
-	dsi_host_regulator_disable(msm_host);
+	regulator_bulk_disable(msm_host->cfg_hnd->cfg->reg_cfg.num,
+			       msm_host->supplies);
 
 	msm_dsi_sfpb_config(msm_host, false);
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index a39de3bdc7fa..7c105120d73e 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -529,58 +529,16 @@ static int dsi_phy_regulator_init(struct msm_dsi_phy *phy)
 		return ret;
 	}
 
-	return 0;
-}
-
-static void dsi_phy_regulator_disable(struct msm_dsi_phy *phy)
-{
-	struct regulator_bulk_data *s = phy->supplies;
-	const struct dsi_reg_entry *regs = phy->cfg->reg_cfg.regs;
-	int num = phy->cfg->reg_cfg.num;
-	int i;
-
-	DBG("");
-	for (i = num - 1; i >= 0; i--)
-		if (regs[i].disable_load >= 0)
-			regulator_set_load(s[i].consumer, regs[i].disable_load);
-
-	regulator_bulk_disable(num, s);
-}
-
-static int dsi_phy_regulator_enable(struct msm_dsi_phy *phy)
-{
-	struct regulator_bulk_data *s = phy->supplies;
-	const struct dsi_reg_entry *regs = phy->cfg->reg_cfg.regs;
-	struct device *dev = &phy->pdev->dev;
-	int num = phy->cfg->reg_cfg.num;
-	int ret, i;
-
-	DBG("");
 	for (i = 0; i < num; i++) {
 		if (regs[i].enable_load >= 0) {
 			ret = regulator_set_load(s[i].consumer,
 							regs[i].enable_load);
-			if (ret < 0) {
-				DRM_DEV_ERROR(dev,
-					"regulator %d set op mode failed, %d\n",
-					i, ret);
-				goto fail;
-			}
+			if (ret < 0)
+				return ret;
 		}
 	}
 
-	ret = regulator_bulk_enable(num, s);
-	if (ret < 0) {
-		DRM_DEV_ERROR(dev, "regulator enable failed, %d\n", ret);
-		goto fail;
-	}
-
 	return 0;
-
-fail:
-	for (i--; i >= 0; i--)
-		regulator_set_load(s[i].consumer, regs[i].disable_load);
-	return ret;
 }
 
 static int dsi_phy_enable_resource(struct msm_dsi_phy *phy)
@@ -829,7 +787,7 @@ int msm_dsi_phy_enable(struct msm_dsi_phy *phy,
 		goto res_en_fail;
 	}
 
-	ret = dsi_phy_regulator_enable(phy);
+	ret = regulator_bulk_enable(phy->cfg->reg_cfg.num, phy->supplies);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "%s: regulator enable failed, %d\n",
 			__func__, ret);
@@ -866,7 +824,7 @@ int msm_dsi_phy_enable(struct msm_dsi_phy *phy,
 	if (phy->cfg->ops.disable)
 		phy->cfg->ops.disable(phy);
 phy_en_fail:
-	dsi_phy_regulator_disable(phy);
+	regulator_bulk_disable(phy->cfg->reg_cfg.num, phy->supplies);
 reg_en_fail:
 	dsi_phy_disable_resource(phy);
 res_en_fail:
@@ -880,7 +838,7 @@ void msm_dsi_phy_disable(struct msm_dsi_phy *phy)
 
 	phy->cfg->ops.disable(phy);
 
-	dsi_phy_regulator_disable(phy);
+	regulator_bulk_disable(phy->cfg->reg_cfg.num, phy->supplies);
 	dsi_phy_disable_resource(phy);
 }
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
index 08b015ea1b1e..6a10a1448051 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
@@ -1033,7 +1033,7 @@ const struct msm_dsi_phy_cfg dsi_phy_10nm_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vdds", 36000, 32},
+			{"vdds", 36000},
 		},
 	},
 	.ops = {
@@ -1055,7 +1055,7 @@ const struct msm_dsi_phy_cfg dsi_phy_10nm_8998_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vdds", 36000, 32},
+			{"vdds", 36000},
 		},
 	},
 	.ops = {
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
index 8199c53567f4..0f3d4c56c333 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
@@ -1029,7 +1029,7 @@ const struct msm_dsi_phy_cfg dsi_phy_14nm_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vcca", 17000, 32},
+			{"vcca", 17000},
 		},
 	},
 	.ops = {
@@ -1050,7 +1050,7 @@ const struct msm_dsi_phy_cfg dsi_phy_14nm_660_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vcca", 73400, 32},
+			{"vcca", 73400},
 		},
 	},
 	.ops = {
@@ -1071,7 +1071,7 @@ const struct msm_dsi_phy_cfg dsi_phy_14nm_8953_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vcca", 17000, 32},
+			{"vcca", 17000},
 		},
 	},
 	.ops = {
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c
index ee7c418a1c29..b7c621d94981 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c
@@ -134,8 +134,8 @@ const struct msm_dsi_phy_cfg dsi_phy_20nm_cfgs = {
 	.reg_cfg = {
 		.num = 2,
 		.regs = {
-			{"vddio", 100000, 100},	/* 1.8 V */
-			{"vcca", 10000, 100},	/* 1.0 V */
+			{"vddio", 100000},	/* 1.8 V */
+			{"vcca", 10000},	/* 1.0 V */
 		},
 	},
 	.ops = {
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
index 48eab80b548e..6beba387640d 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
@@ -774,7 +774,7 @@ const struct msm_dsi_phy_cfg dsi_phy_28nm_hpm_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vddio", 100000, 100},
+			{"vddio", 100000},
 		},
 	},
 	.ops = {
@@ -795,7 +795,7 @@ const struct msm_dsi_phy_cfg dsi_phy_28nm_hpm_famb_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vddio", 100000, 100},
+			{"vddio", 100000},
 		},
 	},
 	.ops = {
@@ -816,7 +816,7 @@ const struct msm_dsi_phy_cfg dsi_phy_28nm_lp_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vddio", 100000, 100},	/* 1.8 V */
+			{"vddio", 100000},	/* 1.8 V */
 		},
 	},
 	.ops = {
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
index fc56cdcc9ad6..2e942b10fffa 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
@@ -653,7 +653,7 @@ const struct msm_dsi_phy_cfg dsi_phy_28nm_8960_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vddio", 100000, 100},	/* 1.8 V */
+			{"vddio", 100000},	/* 1.8 V */
 		},
 	},
 	.ops = {
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 66ed1919a1db..9c7c49ce1200 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -1041,7 +1041,7 @@ const struct msm_dsi_phy_cfg dsi_phy_7nm_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vdds", 36000, 32},
+			{"vdds", 36000},
 		},
 	},
 	.ops = {
@@ -1068,7 +1068,7 @@ const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vdds", 36000, 32},
+			{"vdds", 36000},
 		},
 	},
 	.ops = {
@@ -1090,7 +1090,7 @@ const struct msm_dsi_phy_cfg dsi_phy_7nm_7280_cfgs = {
 	.reg_cfg = {
 		.num = 1,
 		.regs = {
-			{"vdds", 37550, 0},
+			{"vdds", 37550},
 		},
 	},
 	.ops = {
-- 
2.37.1.455.g008518b4e5-goog

