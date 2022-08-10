Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B530758E5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiHJDsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiHJDrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:47:55 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C6D80501
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:47:44 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10ea9ef5838so16422360fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uebmoneVYa9z0k/kynCu9/yCmrGe0dGNvEMVLmT1Zfk=;
        b=G3KpBWShMzBghOxqZeYhWej84Du0/RWKqUTbuNdk04/toga1JbTPeCJGeyMxIIceeZ
         ZOclunNeeFP94y86JAAe2/ordFnT4pXKQSepNjubsf2qrYyv+brT324b9n9fE1xSvIhL
         ODjNGVGX9n+i6nuphZ55kG8tUC0yv27uG+x/3hyPI2O7L51gUr8Fur6CclsrMQ8dhFjl
         QFzmFsNxAO9ONgc5EJsyLtaugjY4ALiCCqTEE+harD4BtjMh9y9YHZ4qwa6Lacvxt6mb
         cdeLq9UXayp4spdSc9wnRumr54zVxWWxxh8Nw8YbR4RZfGtuBCxL1RlPW4dzNIdJ9LsB
         dMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uebmoneVYa9z0k/kynCu9/yCmrGe0dGNvEMVLmT1Zfk=;
        b=3SM/noiETxDyG/v0defmTh8pYDfYPmb0lYIqgEoZMQ0xWoKkoGRavUzMePisMm2PQp
         z1HSVkk3I1iANGkQS5yueOxJiIguWnZm2R4mliOfIte4Z5smTGzYWU7vQKtQ0o41D9Mz
         xe1KYLzky4jR5BdUYay8F6itsMsydU0PtPmlD1lLLlMu0z9reE3v/p0jXINy5CGWL48X
         DegS+Y0qMgpaeINuc3RHX45UlztVsAPLRodifc4ZH1ahWA5R5m+vjAX0WzuY0XHjU4qT
         Rcp4XC8Y7Q6gFixRPm9mypL/Tbuc1xmQzbgu6lG7wTLZJUxckC/FMj5ta8Dpk5lLa8kr
         4ztw==
X-Gm-Message-State: ACgBeo2GyfHc1waGInigLhDiBA5nL0HwODbcIaceJZOu+uhFz1ax9gzZ
        NUCSZ+DdHhixAFJzDrwFXqbt+A==
X-Google-Smtp-Source: AA6agR7SI0AvmwIlMO2J6EANOOTDmTDJ52FbWWKdY/n6F04P8Zi6DLT1LKtfBQIHjML93P3JUBeHKA==
X-Received: by 2002:a05:6871:b10:b0:10e:d8aa:53fd with SMTP id fq16-20020a0568710b1000b0010ed8aa53fdmr695371oab.122.1660103263971;
        Tue, 09 Aug 2022 20:47:43 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n2-20020a4ae742000000b00444f26822e5sm454337oov.10.2022.08.09.20.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:47:43 -0700 (PDT)
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
Subject: [PATCH 7/7] drm/msm/dp: HPD handling relates to next_bridge
Date:   Tue,  9 Aug 2022 20:50:13 -0700
Message-Id: <20220810035013.3582848-8-bjorn.andersson@linaro.org>
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

The DisplayPort controller's internal HPD interrupt handling is used for
cases where the HPD signal is connected to a GPIO which is pinmuxed into
the DisplayPort controller.

Most of the logic for enabling and disabling the HPD-related interrupts
is conditioned on the presence of an EDP panel, but more generically
designs that has a downstream drm_bridge (next_bridge) could use this to
handle the HPD interrupts, instead of the internal mechanism.

So replace the current is_edp-based guards with a check for the presence
of next_bridge.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bb4db9acaa4f..3e93918aa276 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -610,7 +610,7 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 	}
 
 	/* enable HDP irq_hpd/replug interrupt */
-	if (!dp->dp_display.is_edp)
+	if (!dp->dp_display.next_bridge)
 		dp_catalog_hpd_config_intr(dp->catalog,
 					   DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK,
 					   true);
@@ -653,7 +653,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 			dp->dp_display.connector_type, state);
 
 	/* disable irq_hpd/replug interrupts */
-	if (!dp->dp_display.is_edp)
+	if (!dp->dp_display.next_bridge)
 		dp_catalog_hpd_config_intr(dp->catalog,
 					   DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK,
 					   false);
@@ -682,7 +682,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 	}
 
 	/* disable HPD plug interrupts */
-	if (!dp->dp_display.is_edp)
+	if (!dp->dp_display.next_bridge)
 		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, false);
 
 	/*
@@ -701,7 +701,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 	dp_display_handle_plugged_change(&dp->dp_display, false);
 
 	/* enable HDP plug interrupt to prepare for next plugin */
-	if (!dp->dp_display.is_edp)
+	if (!dp->dp_display.next_bridge)
 		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, true);
 
 	drm_dbg_dp(dp->drm_dev, "After, type=%d hpd_state=%d\n",
@@ -1086,8 +1086,8 @@ static void dp_display_config_hpd(struct dp_display_private *dp)
 	dp_display_host_init(dp);
 	dp_catalog_ctrl_hpd_config(dp->catalog);
 
-	/* Enable plug and unplug interrupts only for external DisplayPort */
-	if (!dp->dp_display.is_edp)
+	/* Enable plug and unplug interrupts only if not handled by next_bridge */
+	if (!dp->dp_display.next_bridge)
 		dp_catalog_hpd_config_intr(dp->catalog,
 				DP_DP_HPD_PLUG_INT_MASK |
 				DP_DP_HPD_UNPLUG_INT_MASK,
@@ -1380,8 +1380,7 @@ static int dp_pm_resume(struct device *dev)
 
 	dp_catalog_ctrl_hpd_config(dp->catalog);
 
-
-	if (!dp->dp_display.is_edp)
+	if (!dp->dp_display.next_bridge)
 		dp_catalog_hpd_config_intr(dp->catalog,
 				DP_DP_HPD_PLUG_INT_MASK |
 				DP_DP_HPD_UNPLUG_INT_MASK,
-- 
2.35.1

