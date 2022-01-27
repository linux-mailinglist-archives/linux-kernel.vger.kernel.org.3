Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8515549EBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbiA0UCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbiA0UCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:02:17 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B934C061756
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:17 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d5so4130660pjk.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5nHsB00jtundOhkCVDWS5TBuSGtd2+UB36XQklCAGT4=;
        b=EAPzMHqfta1nmc6u+9Lz9Pg6102ho3xcaQ0U7gHOVeh/7b1Y70gnQahXl4F8vZwb31
         vmNDp4HH13iMO7nVsGIQmuOMCJmPL2XQTGmVOBYhIDww/Ty5WgBFNioiYZQymIEd9BcH
         hEsTcdMeWg/p03KnJHevUNINE8XesrzNa0HBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5nHsB00jtundOhkCVDWS5TBuSGtd2+UB36XQklCAGT4=;
        b=oO4T0uuj3sCn0F/5lFGkZlbT1eqF3pS/B43i9saQ8fL+ssLzMdbBMfhXYtTjD7KrUO
         +voTDKE0TZ2guoV+LrtXwRq2fvsGxp6CXnyuFkp0FgyL78ELnjoCyLLSGOMWFWbEEoPz
         zUe+h7VKR5x/hIvznU5kqB2N7WyiRmHILh8WBuBMSxTecYFvu/KYkQE76vm0RozR25XW
         nN1Wip4aNRO/qLVF/jluWqezKSZ1Jql6aAD4XlFig8/PKJzrPdUPPFlytzPmYXLlylpL
         iHyjVlc+7ga3+kczMPtgRi36nBYaGMWG1NLPyn0/WffLbe1KhvsQmxYp3qM9RpfEk29h
         C5eQ==
X-Gm-Message-State: AOAM530y4bntE7J/HAoA0QmTLVfuehmDFKQR/RjyHbF5zMpubTLcwdW2
        L07V5ZE4Xdqo2Z6lRj/X21vnLw==
X-Google-Smtp-Source: ABdhPJzAgFOIdFDf3XTRUBFIzS7iQ6d3J1G2j6LVj19GOwcMvSsXue1RzG2Hk4lmi4hswUqUzBKqNQ==
X-Received: by 2002:a17:902:c40b:: with SMTP id k11mr4550482plk.48.1643313736945;
        Thu, 27 Jan 2022 12:02:16 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:9246:1838:3243:3071])
        by smtp.gmail.com with ESMTPSA id k21sm6561190pff.33.2022.01.27.12.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:02:16 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 17/35] drm/mediatek: Migrate to aggregate driver
Date:   Thu, 27 Jan 2022 12:01:23 -0800
Message-Id: <20220127200141.1295328-18-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127200141.1295328-1-swboyd@chromium.org>
References: <20220127200141.1295328-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 56ff8c57ef8f..b486e98bf8d9 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -374,8 +374,9 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
-static int mtk_drm_bind(struct device *dev)
+static int mtk_drm_bind(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 	struct drm_device *drm;
 	int ret;
@@ -406,8 +407,9 @@ static int mtk_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void mtk_drm_unbind(struct device *dev)
+static void mtk_drm_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 
 	drm_dev_unregister(private->drm);
@@ -417,9 +419,13 @@ static void mtk_drm_unbind(struct device *dev)
 	private->drm = NULL;
 }
 
-static const struct component_master_ops mtk_drm_ops = {
-	.bind		= mtk_drm_bind,
-	.unbind		= mtk_drm_unbind,
+static struct aggregate_driver mtk_drm_aggregate_driver = {
+	.probe		= mtk_drm_bind,
+	.remove		= mtk_drm_unbind,
+	.driver		= {
+		.name	= "mtk_drm",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
@@ -635,7 +641,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, private);
 
-	ret = component_master_add_with_match(dev, &mtk_drm_ops, match);
+	ret = component_aggregate_register(dev, &mtk_drm_aggregate_driver, match);
 	if (ret)
 		goto err_pm;
 
@@ -658,7 +664,7 @@ static int mtk_drm_remove(struct platform_device *pdev)
 	struct mtk_drm_private *private = platform_get_drvdata(pdev);
 	int i;
 
-	component_master_del(&pdev->dev, &mtk_drm_ops);
+	component_aggregate_unregister(&pdev->dev, &mtk_drm_aggregate_driver);
 	pm_runtime_disable(&pdev->dev);
 	of_node_put(private->mutex_node);
 	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
-- 
https://chromeos.dev

