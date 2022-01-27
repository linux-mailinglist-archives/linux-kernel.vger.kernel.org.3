Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D6549EBB9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343748AbiA0UCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiA0UCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:02:06 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B2DC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:02 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k17so3763423plk.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zwidypq4Go5OKqz8SmfacxJttUeteOhXrn3UaB5BhXk=;
        b=REahsmFv7SO2EJS19EQED429NY5ulcBzeS591w9Qh4Pq6DIrlxU+tNgz/zgHk4ndaQ
         WmxeguS5tRm+SlE5GaCWn5j2DmkfC+5tNTZZ21cjQj5J5I9mkVRp+aiMLbedeIhp/GB+
         UotSKyXeCFEAFddTD58EeLeO4HL6mIql/DJrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zwidypq4Go5OKqz8SmfacxJttUeteOhXrn3UaB5BhXk=;
        b=bQ4xMEZibPlU2NUDHKNCNmWnoFTHGIVdtlBmBOUzxHtwd13JYuA7m4ePbuhXd4svcJ
         Ysf6y/A9NHjNr2x1BjlfagKQpO/+Xb3vDTqGk0Uo4u21+c0nIbU+T3tfY/ochFLpg0jr
         mxYcy1KsdPqKmLDaMB9ohqPfYo/B4A4yIQ9rwoL/vmETjUXmG7vOgLfazTJeo3MGD1PL
         SnJ8AXuFcP55STD4w7IXCQfd+qY81jKkJsPB6QotRdWZiqSGVlRzTAi7BHvL0vkjEARK
         mimXqybRK3QSkgo2mCiM5Wqkpa42LPmERne66UP1YtrxV/5ZO04Mj2YTP5QfW/atAWDY
         p7yw==
X-Gm-Message-State: AOAM531+2YlrTInsmA7E/srILPR3flbVK9+R5yonUQEPIAmPwvUvb+rj
        bX/b614QbGp+1hc7O6/3l/RLZA==
X-Google-Smtp-Source: ABdhPJyWAZjfirfkH7ymqHsj2L9OtTZWs6HiPoJtXWaYoR1/GX3EP0aYSGVsGYHdsaRFZkClJbP2WQ==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4mr2394992plo.78.1643313722210;
        Thu, 27 Jan 2022 12:02:02 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:9246:1838:3243:3071])
        by smtp.gmail.com with ESMTPSA id k21sm6561190pff.33.2022.01.27.12.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:02:01 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 06/35] drm/msm: Migrate to aggregate driver
Date:   Thu, 27 Jan 2022 12:01:12 -0800
Message-Id: <20220127200141.1295328-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127200141.1295328-1-swboyd@chromium.org>
References: <20220127200141.1295328-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device lists are poorly ordered when the component device code is
used. This is because component_master_add_with_match() returns 0
regardless of component devices calling component_add() first. It can
really only fail if an allocation fails, in which case everything is
going bad and we're out of memory. The driver that registers the
aggregate driver, can succeed at probe and put the attached device on
the DPM lists before any of the component devices are probed and put on
the lists.

Within the component device framework this usually isn't that bad
because the real driver work is done at bind time via
component{,master}_ops::bind(). It becomes a problem when the driver
core, or host driver, wants to operate on the component device outside
of the bind/unbind functions, e.g. via 'remove' or 'shutdown'. The
driver core doesn't understand the relationship between the host device
and the component devices and could possibly try to operate on component
devices when they're already removed from the system or shut down.

Normally, device links or probe defer would reorder the lists and put
devices that depend on other devices in the lists at the correct
location, but with component devices this doesn't happen because this
information isn't expressed anywhere. Drivers simply succeed at
registering their component or the aggregate driver with the component
framework and wait for their bind() callback to be called once the other
components are ready. In summary, the drivers that make up the aggregate
driver can probe in any order.

This ordering problem becomes fairly obvious when shutting down the
device with a DSI controller connected to a DSI bridge that is
controlled via i2c. In this case, the msm display driver wants to tear
down the display pipeline on shutdown via msm_pdev_shutdown() by calling
drm_atomic_helper_shutdown(), and it can't do that unless the whole
display chain is still probed and active in the system. When a display
bridge is on i2c, the i2c device for the bridge will be created whenever
the i2c controller probes, which could be before or after the msm
display driver probes. If the i2c controller probes after the display
driver, then the i2c controller will be shutdown before the display
controller during system wide shutdown and thus i2c transactions will
stop working before the display pipeline is shut down. This means we'll
have the display bridge trying to access an i2c bus that's shut down
because drm_atomic_helper_shutdown() is trying to disable the bridge
after the bridge is off.

The solution is to make the aggregate driver into a real struct driver
that is bound to a device when the other component devices have all
probed. Now that the component driver code is a proper bus, we can
simply register an aggregate driver with that bus via
component_aggregate_register() and then attach the shutdown hook to that
driver to be sure that the shutdown for the display pipeline is called
before any of the component device driver shutdown hooks are called.

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 48 ++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ad35a5d94053..32107e5cb547 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1331,19 +1331,37 @@ static int add_gpu_components(struct device *dev,
 	return 0;
 }
 
-static int msm_drm_bind(struct device *dev)
+static int msm_drm_bind(struct aggregate_device *adev)
 {
-	return msm_drm_init(dev, &msm_driver);
+	return msm_drm_init(aggregate_device_parent(adev), &msm_driver);
 }
 
-static void msm_drm_unbind(struct device *dev)
+static void msm_drm_unbind(struct aggregate_device *adev)
 {
-	msm_drm_uninit(dev);
+	msm_drm_uninit(aggregate_device_parent(adev));
+}
+
+static void msm_drm_shutdown(struct aggregate_device *adev)
+{
+	const struct device *parent = aggregate_device_parent(adev);
+	const struct platform_device *pdev = to_platform_device(parent);
+	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct drm_device *drm = priv ? priv->dev : NULL;
+
+	if (!priv || !priv->kms)
+		return;
+
+	drm_atomic_helper_shutdown(drm);
 }
 
-static const struct component_master_ops msm_drm_ops = {
-	.bind = msm_drm_bind,
-	.unbind = msm_drm_unbind,
+static struct aggregate_driver msm_drm_aggregate_driver = {
+	.probe = msm_drm_bind,
+	.remove = msm_drm_unbind,
+	.shutdown = msm_drm_shutdown,
+	.driver = {
+		.name	= "msm_drm",
+		.owner	= THIS_MODULE,
+	},
 };
 
 /*
@@ -1395,7 +1413,7 @@ static int msm_pdev_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
-	ret = component_master_add_with_match(&pdev->dev, &msm_drm_ops, match);
+	ret = component_aggregate_register(&pdev->dev, &msm_drm_aggregate_driver, match);
 	if (ret)
 		goto fail;
 
@@ -1415,7 +1433,7 @@ static int msm_pdev_remove(struct platform_device *pdev)
 	struct msm_drm_private *priv = platform_get_drvdata(pdev);
 	struct msm_mdss *mdss = priv->mdss;
 
-	component_master_del(&pdev->dev, &msm_drm_ops);
+	component_aggregate_unregister(&pdev->dev, &msm_drm_aggregate_driver);
 	of_platform_depopulate(&pdev->dev);
 
 	if (mdss && mdss->funcs)
@@ -1424,17 +1442,6 @@ static int msm_pdev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void msm_pdev_shutdown(struct platform_device *pdev)
-{
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
-	struct drm_device *drm = priv ? priv->dev : NULL;
-
-	if (!priv || !priv->kms)
-		return;
-
-	drm_atomic_helper_shutdown(drm);
-}
-
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "qcom,mdp4", .data = (void *)KMS_MDP4 },
 	{ .compatible = "qcom,mdss", .data = (void *)KMS_MDP5 },
@@ -1450,7 +1457,6 @@ MODULE_DEVICE_TABLE(of, dt_match);
 static struct platform_driver msm_platform_driver = {
 	.probe      = msm_pdev_probe,
 	.remove     = msm_pdev_remove,
-	.shutdown   = msm_pdev_shutdown,
 	.driver     = {
 		.name   = "msm",
 		.of_match_table = dt_match,
-- 
https://chromeos.dev

