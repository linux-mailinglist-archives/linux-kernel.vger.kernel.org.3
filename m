Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7322D58E5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiHJDru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiHJDrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:47:41 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19157FE72
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:47:39 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s199so10480516oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YFwrR3MMUAqfzQikQP3XEeQMTFs7soeKt3WpRi+SfIg=;
        b=WmldLYpvZ+KC3FxiJhV1pJ0FaGe1oyA7Uo9MV1NFHmpATqjeF7yJpXHp1fqJhZMRO8
         0HrRmDEEtuQUCq4pICzWi/8B+i7V5UE5h/QPblmoo4OCV6+r/NoRgUCeimMbCHB1A4fo
         oaNxyiuAcim6ysscbmmZgoWgETkkvJ5TBpsRW7VfB/pdMM5DlTIuG/EmsxhWloX02Gr4
         KvMFGzjc4bFDieQ3Yv4CGec871EouRhoA+tek4MNiQxGVO8YUhhsiNJy74MFxDcxLJQV
         rOh4qzyW2IIRKMIBZ1WJ+vpA51hyox9UTWU6hTSO14Q5wY1QNOxqf3hmVdYi1yGXdS7U
         qlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YFwrR3MMUAqfzQikQP3XEeQMTFs7soeKt3WpRi+SfIg=;
        b=zpAJAEpvwxDLzSWu1di0gLZE58BpVAvLzCYw8cP2n0SojD4VVcwx0Y7UtyWeUparFQ
         5q3MgD9AzuBxV/E7FeQvExoLvgqApcCBEVRY+uoBQqC5dXzN9xXnz4h55DOQE3gtVCYK
         KCQ0amoVJtLJYXaF4RM2zbsaXH4oxTAp0NESOAtKacAzEZNHRv3WSOUpTE5bv8Fs8KZp
         jdqQmQqKlZLpnYU3Y/2MuqR+sLCDmNCUA9/N8JGNk9IULSkKi4qxlJpe8/GnlzcpbJUW
         2BFMN+jKnaiDB62mU6Osek3uaqdmq6ghBmPl1CcqHHn5e/SEsdRG2+ypq+NFFa14krAz
         KfdA==
X-Gm-Message-State: ACgBeo26CVZloZIVL0etDtJXBZFsrO3+eP2YW9wAtsisTXl26YYZ/X9n
        SMQWR6/C0LQPPuso9d5Znb92lw==
X-Google-Smtp-Source: AA6agR65C9l72emAawI4jltXzXisVixzgqgpZwuhHwyvg8N9cV+oMnVY90M78bAL5MttFpFWh4zuFg==
X-Received: by 2002:a05:6808:148f:b0:33a:d2ea:ace9 with SMTP id e15-20020a056808148f00b0033ad2eaace9mr661457oiw.186.1660103259426;
        Tue, 09 Aug 2022 20:47:39 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n2-20020a4ae742000000b00444f26822e5sm454337oov.10.2022.08.09.20.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:47:38 -0700 (PDT)
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
Subject: [PATCH 3/7] drm/msm/dp: Add DP and EDP compatibles for SC8280XP
Date:   Tue,  9 Aug 2022 20:50:09 -0700
Message-Id: <20220810035013.3582848-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
References: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC8280XP platform has four DisplayPort controllers, per MDSS
instance, all with widebus support.

The first two are defined to be DisplayPort only, while the latter pair
(of each instance) can be either DisplayPort or Embedded DisplayPort.
The two sets are tied to the possible compatibels.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h       |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 2d9bbc335786..e4a83c2cd972 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -145,6 +145,26 @@ static const struct msm_dp_desc sc8180x_dp_descs[] = {
 	{}
 };
 
+static const struct msm_dp_desc sc8280xp_dp_descs[] = {
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
+	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
+	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
+	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
+	{ .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
+	{ .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
+	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
+	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
+	{}
+};
+
+static const struct msm_dp_desc sc8280xp_edp_descs[] = {
+	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
+	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
+	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
+	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
+	{}
+};
+
 static const struct msm_dp_desc sm8350_dp_descs[] = {
 	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
 	{}
@@ -156,6 +176,8 @@ static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_descs },
 	{ .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_descs },
 	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_descs },
+	{ .compatible = "qcom,sc8280xp-dp", .data = &sc8280xp_dp_descs },
+	{ .compatible = "qcom,sc8280xp-edp", .data = &sc8280xp_edp_descs },
 	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
 	{}
 };
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index b3689a2d27d7..5978c6e26a1e 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -55,6 +55,7 @@ enum msm_dp_controller {
 	MSM_DP_CONTROLLER_0,
 	MSM_DP_CONTROLLER_1,
 	MSM_DP_CONTROLLER_2,
+	MSM_DP_CONTROLLER_3,
 	MSM_DP_CONTROLLER_COUNT,
 };
 
-- 
2.35.1

