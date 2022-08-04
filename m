Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322A1589DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbiHDOj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiHDOjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:39:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71D94D81A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:39:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f192so10072325pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eqpuB/jZzr6RZg9MRH4VQT6RcEmZ2WxwGiLdN4NtIg4=;
        b=evryTDQOO0HgjyAOUk7ubNrfNSGdkhoTL9o+GwIA/OY2hY+51Vj6trYOWxPbPml4FT
         rw9PKgSLcUoxCoT9TO13RHS09VL6LyK+mQWk3vhspjXMvgg7lc90ilqNvrtMSLhZl4Nj
         X1qeLbUpaXlwz6DeNwYCPuZGQ5yXzp18XZzuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eqpuB/jZzr6RZg9MRH4VQT6RcEmZ2WxwGiLdN4NtIg4=;
        b=ouCtKYb7F0tJmbLur42Flt6B1Tw1ZR1j0L/zt2xvBPTdYrlJbz5RGxcOrGsVDAgDTA
         FXgXk54hhH9+U0wjsuNCD3pDPK9+0AbsUmFVFSbVxKqEGsL6kvei/HYI2gGcq6mK98cN
         CRwCSFSZG7zHSqDzwgx1Wb9qYR/UFqLpRovQ/vS+RfvfGBROlW/x2nNVAl3sVAo8Y8rM
         E/xNrsCrwS8riojSrZU0w8GpJ7sK9mV+WuY/qPlIYPlkPf3x7lUuHdMVNCfJL+7fpU/N
         cdECl+tYfTiAlCp+mQQpAYWKE96tzO2jkoNAQ6gAKYosG3m0khHFGzjRS1fzAaxKPVYl
         DTUQ==
X-Gm-Message-State: ACgBeo1ibHNt8T2jbn+Vfm7/sHryJH+doXYJuzE2Vy2NoP7hJthsKE0m
        p15XJp+bNjVGPwnfHIrr9uhl7A==
X-Google-Smtp-Source: AA6agR7Vaijl6KTd0e85hYD7XDfBZESwSM8wGKiYzx4xW6HUQmtTu+dDVpncWOtNc9BzWoeu3QXNSg==
X-Received: by 2002:a63:87:0:b0:419:f2d0:1e3b with SMTP id 129-20020a630087000000b00419f2d01e3bmr1963782pga.234.1659623970813;
        Thu, 04 Aug 2022 07:39:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:aa71:2553:6f54:5cb1])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016a111c83cdsm1075071plk.119.2022.08.04.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 07:39:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] drm/msm/dsi: Improve dsi_phy_driver_probe() probe error handling
Date:   Thu,  4 Aug 2022 07:38:53 -0700
Message-Id: <20220804073608.v4.6.I969118a35934a0e5007fe4f80e3e28e9c0b7602a@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220804143854.1544395-1-dianders@chromium.org>
References: <20220804143854.1544395-1-dianders@chromium.org>
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

The dsi_phy_driver_probe() function has a "goto fail" for no
reason. Change it to just always return directly when it sees an
error. Make this simpler by leveraging dev_err_probe() which is
designed to make code like this shorter / simpler.

NOTE: as part of this, we now pass through error codes directly from
msm_ioremap_size() rather than translating to -ENOMEM. This changed
mostly because it's much more convenient when using dev_err_probe()
and also it's usually encouraged not to hide error codes like the old
code was doing unless there is a good reason. I can't see any reason
why we'd need to return -ENOMEM instead of -EINVAL from the probe
function.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---

Changes in v4:
- Mention error code change in commit message.

Changes in v3:
- ("Improve dsi_phy_driver_probe() probe error handling") new for v3.

 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 74 ++++++++++-----------------
 1 file changed, 27 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 0a00f9b73fc5..57cd525de7a1 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -621,12 +621,9 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 	phy->pdev = pdev;
 
 	phy->id = dsi_phy_get_id(phy);
-	if (phy->id < 0) {
-		ret = phy->id;
-		DRM_DEV_ERROR(dev, "%s: couldn't identify PHY index, %d\n",
-			__func__, ret);
-		goto fail;
-	}
+	if (phy->id < 0)
+		return dev_err_probe(dev, phy->id,
+				     "Couldn't identify PHY index\n");
 
 	phy->regulator_ldo_mode = of_property_read_bool(dev->of_node,
 				"qcom,dsi-phy-regulator-ldo-mode");
@@ -634,88 +631,71 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 		phy->cphy_mode = (phy_type == PHY_TYPE_CPHY);
 
 	phy->base = msm_ioremap_size(pdev, "dsi_phy", &phy->base_size);
-	if (IS_ERR(phy->base)) {
-		DRM_DEV_ERROR(dev, "%s: failed to map phy base\n", __func__);
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (IS_ERR(phy->base))
+		return dev_err_probe(dev, PTR_ERR(phy->base),
+				     "Failed to map phy base\n");
 
 	phy->pll_base = msm_ioremap_size(pdev, "dsi_pll", &phy->pll_size);
-	if (IS_ERR(phy->pll_base)) {
-		DRM_DEV_ERROR(&pdev->dev, "%s: failed to map pll base\n", __func__);
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (IS_ERR(phy->pll_base))
+		return dev_err_probe(dev, PTR_ERR(phy->pll_base),
+				     "Failed to map pll base\n");
 
 	if (phy->cfg->has_phy_lane) {
 		phy->lane_base = msm_ioremap_size(pdev, "dsi_phy_lane", &phy->lane_size);
-		if (IS_ERR(phy->lane_base)) {
-			DRM_DEV_ERROR(&pdev->dev, "%s: failed to map phy lane base\n", __func__);
-			ret = -ENOMEM;
-			goto fail;
-		}
+		if (IS_ERR(phy->lane_base))
+			return dev_err_probe(dev, PTR_ERR(phy->lane_base),
+					     "Failed to map phy lane base\n");
 	}
 
 	if (phy->cfg->has_phy_regulator) {
 		phy->reg_base = msm_ioremap_size(pdev, "dsi_phy_regulator", &phy->reg_size);
-		if (IS_ERR(phy->reg_base)) {
-			DRM_DEV_ERROR(&pdev->dev, "%s: failed to map phy regulator base\n", __func__);
-			ret = -ENOMEM;
-			goto fail;
-		}
+		if (IS_ERR(phy->reg_base))
+			return dev_err_probe(dev, PTR_ERR(phy->reg_base),
+					     "Failed to map phy regulator base\n");
 	}
 
 	if (phy->cfg->ops.parse_dt_properties) {
 		ret = phy->cfg->ops.parse_dt_properties(phy);
 		if (ret)
-			goto fail;
+			return ret;
 	}
 
 	ret = devm_regulator_bulk_get_const(dev, phy->cfg->num_regulators,
 					    phy->cfg->regulator_data,
 					    &phy->supplies);
 	if (ret)
-		goto fail;
+		return ret;
 
 	phy->ahb_clk = msm_clk_get(pdev, "iface");
-	if (IS_ERR(phy->ahb_clk)) {
-		DRM_DEV_ERROR(dev, "%s: Unable to get ahb clk\n", __func__);
-		ret = PTR_ERR(phy->ahb_clk);
-		goto fail;
-	}
+	if (IS_ERR(phy->ahb_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->ahb_clk),
+				     "Unable to get ahb clk\n");
 
 	/* PLL init will call into clk_register which requires
 	 * register access, so we need to enable power and ahb clock.
 	 */
 	ret = dsi_phy_enable_resource(phy);
 	if (ret)
-		goto fail;
+		return ret;
 
 	if (phy->cfg->ops.pll_init) {
 		ret = phy->cfg->ops.pll_init(phy);
-		if (ret) {
-			DRM_DEV_INFO(dev,
-				"%s: pll init failed: %d, need separate pll clk driver\n",
-				__func__, ret);
-			goto fail;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "PLL init failed; need separate clk driver\n");
 	}
 
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 				     phy->provided_clocks);
-	if (ret) {
-		DRM_DEV_ERROR(dev, "%s: failed to register clk provider: %d\n", __func__, ret);
-		goto fail;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register clk provider\n");
 
 	dsi_phy_disable_resource(phy);
 
 	platform_set_drvdata(pdev, phy);
 
 	return 0;
-
-fail:
-	return ret;
 }
 
 static struct platform_driver dsi_phy_platform_driver = {
-- 
2.37.1.455.g008518b4e5-goog

