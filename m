Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB0486C82
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbiAFVq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244545AbiAFVqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:46:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25DCC034003
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:46:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m13so3557443pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqazxdkkitgTin4SJ5P9dnD2fQGX/sBsDUPb6a/Agwo=;
        b=UF0V8/d2dqEfdB7HCgBN7DdYJT4+e8BJM+MYJD8k8/fO68+IUWBGZ6JkAsJJkh+FnD
         vaXLGgHFYVWFjjXVyQxkteffvW9U/hth0QeOEhOrAMeeMNR5ObgSOlPQix0JS2mt5/gW
         apV2grR0P52r0odyd0kdBpYKYJYhO3qZDpkHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqazxdkkitgTin4SJ5P9dnD2fQGX/sBsDUPb6a/Agwo=;
        b=XcZmBnpleBW/bJjaPcTEJAXWHfgSC+p/sjT4w9XglZqux1c7Q/avkuzV61mwrtMdue
         YpwWM6q4W9z5BNWXECkCTzNQ0qX2A1oVXEY/NX9IN6ihFrP4w86bvmaH/vHuJTKPxx7c
         g+8sUTUPMc/KTnvdflg2iFDRKJYAIhRqXwxvEGET5+flRf3R+AheESMumqJPxvbG4I2r
         6slTgEvMIsOeUMEc7Xxmk99tST9hE5JFSFHLr9sPdq1RBgeWDaWfpj1NXmQl2PVSd+6+
         35onylgeKME1Z5Cu11FAw/EzBailRJLOtAl2enIbHW3eP3GJwQWpuwM9+BtbTRz0WFBl
         32vw==
X-Gm-Message-State: AOAM5311rfsy9BggVYiLI4XtWKqLrULs0LjNdySnJqpeTVAa/x0e87cM
        1v3li7UKbTTmTuy4G+TJp/b1ts19e5C89Q==
X-Google-Smtp-Source: ABdhPJx3X6P0Se4Tp7Ye4XYdLYrIonMHZGBXV1H/Uf8y5UHsJsIHUkaZumNdcF/jAe2cmmNLHsWLzA==
X-Received: by 2002:a17:90b:33cd:: with SMTP id lk13mr12189005pjb.35.1641505580410;
        Thu, 06 Jan 2022 13:46:20 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ebe:a8fd:f9b0:7e85])
        by smtp.gmail.com with ESMTPSA id 10sm3539960pfm.56.2022.01.06.13.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:46:20 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 16/32] drm/mcde: Migrate to aggregate driver
Date:   Thu,  6 Jan 2022 13:45:39 -0800
Message-Id: <20220106214556.2461363-17-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220106214556.2461363-1-swboyd@chromium.org>
References: <20220106214556.2461363-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/mcde/mcde_drv.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 5b5afc6aaf8e..1652f9e0601d 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -215,8 +215,9 @@ static const struct drm_driver mcde_drm_driver = {
 	DRM_GEM_CMA_DRIVER_OPS,
 };
 
-static int mcde_drm_bind(struct device *dev)
+static int mcde_drm_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm = dev_get_drvdata(dev);
 	int ret;
 
@@ -247,8 +248,9 @@ static int mcde_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void mcde_drm_unbind(struct device *dev)
+static void mcde_drm_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm = dev_get_drvdata(dev);
 
 	drm_dev_unregister(drm);
@@ -256,9 +258,13 @@ static void mcde_drm_unbind(struct device *dev)
 	component_unbind_all(drm->dev, drm);
 }
 
-static const struct component_master_ops mcde_drm_comp_ops = {
-	.bind = mcde_drm_bind,
-	.unbind = mcde_drm_unbind,
+static struct aggregate_driver mcde_drm_comp_driver = {
+	.probe = mcde_drm_bind,
+	.remove = mcde_drm_unbind,
+	.driver = {
+		.name = "mcde_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static struct platform_driver *const mcde_component_drivers[] = {
@@ -419,7 +425,7 @@ static int mcde_probe(struct platform_device *pdev)
 	 * Perform an invasive reset of the MCDE and all blocks by
 	 * cutting the power to the subsystem, then bring it back up
 	 * later when we enable the display as a result of
-	 * component_master_add_with_match().
+	 * component_aggregate_register().
 	 */
 	ret = regulator_disable(mcde->epod);
 	if (ret) {
@@ -429,8 +435,7 @@ static int mcde_probe(struct platform_device *pdev)
 	/* Wait 50 ms so we are sure we cut the power */
 	usleep_range(50000, 70000);
 
-	ret = component_master_add_with_match(&pdev->dev, &mcde_drm_comp_ops,
-					      match);
+	ret = component_aggregate_register(&pdev->dev, &mcde_drm_comp_driver, match);
 	if (ret) {
 		dev_err(dev, "failed to add component master\n");
 		/*
@@ -459,7 +464,7 @@ static int mcde_remove(struct platform_device *pdev)
 	struct drm_device *drm = platform_get_drvdata(pdev);
 	struct mcde *mcde = to_mcde(drm);
 
-	component_master_del(&pdev->dev, &mcde_drm_comp_ops);
+	component_aggregate_unregister(&pdev->dev, &mcde_drm_comp_driver);
 	clk_disable_unprepare(mcde->mcde_clk);
 	regulator_disable(mcde->vana);
 	regulator_disable(mcde->epod);
-- 
https://chromeos.dev

