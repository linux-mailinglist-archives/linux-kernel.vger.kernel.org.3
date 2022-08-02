Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEFE58846B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiHBWiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiHBWiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:38:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CE45464E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:38:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so13566314pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=a6ycZe6N1cjRSfzIPPZ+jiMuWfW1VD/vu0x1N4mzpQs=;
        b=QTUc47HjP2Whuz9yztQ8puZxx66qK+Dl2U1N0WY37bb7WqiSgSVxOVqnSZwpMXSUCG
         HRduadX5w0Qa4bIOW3mUQPk5n41dOhNIpPxYCuoGCcD9FyLJzz2KKx05NDkv5ungMehi
         S/Cgyl5i1IjtU6qy4S4g3s7L5Bfsp0t/dQHVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a6ycZe6N1cjRSfzIPPZ+jiMuWfW1VD/vu0x1N4mzpQs=;
        b=uyXZKQ0BV6l2ukIjMA8mPY8ewQbIFYxlqnAOs6E5WtKTt54H26cL8JtJ/BvHl+C56A
         5RhaLfcbNZv0M/Uxz5Mvm71t2IKg0QURm7vk5yiqaYzWVqVVqp+yTToE0VxM+s3s3Mlh
         I2fiEYQ5298DGZ1PfsyfZAN4WMfzr5bYHMwqP8HAFrLgyo6yhUdUlmm3e4/MSKBHSpLa
         NnnfaIcwjs8+gu2G85Ps11Yax+H0XKVgp/rG2Km1DuER9Nxltdes8Ut6+c4hOEKMBcZ3
         QsnFtvsomdUq0nOggWNllL3w/ViDfwGfL/0zsTTqBWZjvOKZi9l5JWfAypyLQXJzXxhB
         SS9g==
X-Gm-Message-State: AJIora9Y5fulMj0CAcIRCjeKcsUEeyYhGNO8cAguYbtpZKh6caWPFevd
        aaFrMk516GCzJmPCrX1BC19H0Q==
X-Google-Smtp-Source: AGRyM1sJvaN2OOkWmEu5SE0NEJoK3KM098xo2cg8jkO3KBeH3Bi+1zb9rGJaciJWQzHxBVbjQ4y3wg==
X-Received: by 2002:a63:5c42:0:b0:412:b2e9:97e4 with SMTP id n2-20020a635c42000000b00412b2e997e4mr19377140pgm.36.1659479879805;
        Tue, 02 Aug 2022 15:37:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:31c9:9937:c6bb:62f5])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00528c066678csm11353030pfb.72.2022.08.02.15.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 15:37:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] drm/msm/dsi: Improve dsi_phy_driver_probe() probe error handling
Date:   Tue,  2 Aug 2022 15:37:38 -0700
Message-Id: <20220802153434.v3.6.I969118a35934a0e5007fe4f80e3e28e9c0b7602a@changeid>
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

The dsi_phy_driver_probe() function has a "goto fail" for no
reason. Change it to just always return directly when it sees an
error. Make this simpler by leveraging dev_err_probe() which is
designed to make code like this shorter / simpler.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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

