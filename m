Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C9358E5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiHJDrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiHJDrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:47:40 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC387FE71
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:47:38 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10edfa2d57dso16479139fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+aJ62R3cE9m9PROwpKbgYuzNBPF5jR0Zo722sl/Di+M=;
        b=FK4uzxeqhLnJWXjxXzoQNmK5T/jMp4VpW0z9/LQQ70Xb8LgGa5PcsTohyYm4wnGwJl
         pa4oGH+89/+KWOKbYA4WTNxPg1z4LyujgpYund5UVwrHOPmMgYWOGOq8FTqto4Rsj5UZ
         Jrnul3F8H+054ckfeKHeiqhq09ZR3Cr5Sfcck8bye7bsy2ASt7IP1ByqigBcl4w3QwPh
         SS5A4FAYMOcm5kpN/3Ja23B7Lg/PFSG0l3tlH/QoNGvRgA2umN4AoP8iKVf6v671mDNB
         yixkPSp4zU/bdEFES+1AjCZjxvJv2/MMMqJSURnf4PxCHf8Y47i1kQSTAQfa/+Hpp4Av
         9w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+aJ62R3cE9m9PROwpKbgYuzNBPF5jR0Zo722sl/Di+M=;
        b=zpxI5IITJRILfYjn59NRWrz8P2KgBzZGNu89oaFICfzomNgkL74sVm10Y2I+/Dh9Sm
         9MxP83886T46lpNbOTnb/eGdZ10vFK0SY0vv7mefNUv1iPBHwj9nt3lNPIxX24XJO6ht
         6mlV+X4xO3rVWWFlZ3o15nuQCFhS99C7xqAvSe7/vAMBwF0bVHrqzXQXq6FLqttL8/Ki
         +a+cjlSJHIEAjDcXkKJdh3f4YdHzj6G+Pczyrj6K2XfCUOryVGBrq9tSqWd9Fjp7kS3u
         sXRwxVf3j+DmHvuwhT/ta1WPT9Z++JCdZhk4LKUQx8jG5J1/9HV4il/nTkt3ssNy9DI2
         0GoA==
X-Gm-Message-State: ACgBeo24Rss+fKqOLw89vCKwOcfx3h7Hs0BuLQivaFxu05bMPG5kdtfS
        k2ZOi3fWQ7ccZ5SgsZcfRQlWKw==
X-Google-Smtp-Source: AA6agR4EVl4kLNakAFFhFfsiR3HAIKrZONiCIpAAGZfpr+IygMxdmApyCi3o1QvfJtKHnXPAT6uyGQ==
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id w1-20020a056870b38100b000fe2004b3b5mr684866oap.63.1660103258149;
        Tue, 09 Aug 2022 20:47:38 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n2-20020a4ae742000000b00444f26822e5sm454337oov.10.2022.08.09.20.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:47:37 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] drm/msm/dp: Stop using DP id as index in desc
Date:   Tue,  9 Aug 2022 20:50:08 -0700
Message-Id: <20220810035013.3582848-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
References: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the SC8280XP platform there are two identical MDSS instances, each
with the same set of DisplayPort instances, at different addresses.

By not relying on the index to define the instance id it's possible to
describe them both in the same table and hence have a single compatible.

While at it, flatten the cfg/desc structure so that the match data is
just an array of descs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 72 ++++++++++-------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bfd0aeff3f0d..2d9bbc335786 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -122,61 +122,41 @@ struct dp_display_private {
 
 struct msm_dp_desc {
 	phys_addr_t io_start;
+	unsigned int id;
 	unsigned int connector_type;
 	bool wide_bus_en;
 };
 
-struct msm_dp_config {
-	const struct msm_dp_desc *descs;
-	size_t num_descs;
-};
-
 static const struct msm_dp_desc sc7180_dp_descs[] = {
-	[MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
-};
-
-static const struct msm_dp_config sc7180_dp_cfg = {
-	.descs = sc7180_dp_descs,
-	.num_descs = ARRAY_SIZE(sc7180_dp_descs),
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+	{}
 };
 
 static const struct msm_dp_desc sc7280_dp_descs[] = {
-	[MSM_DP_CONTROLLER_0] =	{ .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
-	[MSM_DP_CONTROLLER_1] =	{ .io_start = 0x0aea0000, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
-};
-
-static const struct msm_dp_config sc7280_dp_cfg = {
-	.descs = sc7280_dp_descs,
-	.num_descs = ARRAY_SIZE(sc7280_dp_descs),
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
+	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
+	{}
 };
 
 static const struct msm_dp_desc sc8180x_dp_descs[] = {
-	[MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
-	[MSM_DP_CONTROLLER_1] = { .io_start = 0x0ae98000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
-	[MSM_DP_CONTROLLER_2] = { .io_start = 0x0ae9a000, .connector_type = DRM_MODE_CONNECTOR_eDP },
-};
-
-static const struct msm_dp_config sc8180x_dp_cfg = {
-	.descs = sc8180x_dp_descs,
-	.num_descs = ARRAY_SIZE(sc8180x_dp_descs),
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP },
+	{}
 };
 
 static const struct msm_dp_desc sm8350_dp_descs[] = {
-	[MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
-};
-
-static const struct msm_dp_config sm8350_dp_cfg = {
-	.descs = sm8350_dp_descs,
-	.num_descs = ARRAY_SIZE(sm8350_dp_descs),
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+	{}
 };
 
 static const struct of_device_id dp_dt_match[] = {
-	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
-	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_cfg },
-	{ .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_cfg },
-	{ .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_cfg },
-	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_cfg },
-	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_cfg },
+	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
+	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
+	{ .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_descs },
+	{ .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_descs },
+	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_descs },
+	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
 	{}
 };
 
@@ -1262,10 +1242,9 @@ int dp_display_request_irq(struct msm_dp *dp_display)
 	return 0;
 }
 
-static const struct msm_dp_desc *dp_display_get_desc(struct platform_device *pdev,
-						     unsigned int *id)
+static const struct msm_dp_desc *dp_display_get_desc(struct platform_device *pdev)
 {
-	const struct msm_dp_config *cfg = of_device_get_match_data(&pdev->dev);
+	const struct msm_dp_desc *descs = of_device_get_match_data(&pdev->dev);
 	struct resource *res;
 	int i;
 
@@ -1273,11 +1252,9 @@ static const struct msm_dp_desc *dp_display_get_desc(struct platform_device *pde
 	if (!res)
 		return NULL;
 
-	for (i = 0; i < cfg->num_descs; i++) {
-		if (cfg->descs[i].io_start == res->start) {
-			*id = i;
-			return &cfg->descs[i];
-		}
+	for (i = 0; i < descs[i].io_start; i++) {
+		if (descs[i].io_start == res->start)
+			return &descs[i];
 	}
 
 	dev_err(&pdev->dev, "unknown displayport instance\n");
@@ -1299,12 +1276,13 @@ static int dp_display_probe(struct platform_device *pdev)
 	if (!dp)
 		return -ENOMEM;
 
-	desc = dp_display_get_desc(pdev, &dp->id);
+	desc = dp_display_get_desc(pdev);
 	if (!desc)
 		return -EINVAL;
 
 	dp->pdev = pdev;
 	dp->name = "drm_dp";
+	dp->id = desc->id;
 	dp->dp_display.connector_type = desc->connector_type;
 	dp->wide_bus_en = desc->wide_bus_en;
 	dp->dp_display.is_edp =
-- 
2.35.1

