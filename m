Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE749EC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbiA0UD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343810AbiA0UCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:02:42 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C4C06175E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:37 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z131so3205115pgz.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZPdM2UZRVqO2e0C8ICFRT9vqGkS5bJAyu59fLH+Uvcs=;
        b=Gl4OTjqsqgynBhjQVr0J0vK/Y4lnurULqWtCsHyQOkEHqf7pCYHQI81VfLe0ELPBsG
         0SYrju/lR6J6HE43y4rKJGyo6/G5xD8lVQyH6+Ijf/swy2beLa8NcG5FgN9KTJwKHXGo
         bQsVmN6a58G5hTr/ZwYaIyIU2zcLLGHUCcPIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPdM2UZRVqO2e0C8ICFRT9vqGkS5bJAyu59fLH+Uvcs=;
        b=XZEsIwDCrs3Fw/IQJ1g+stKc1jmwzhoKwdJuLkcBN/gbGRwrUyP2Br343342emj27u
         yjSYWpTok4/K68s3M5Lai9L5Aq/h+oZoRwIN6ySOiTpgIlYyjNxfXHFxdKSDjDuTZImy
         qk6uEolEET1gCOHf3QqfKppVdWgxexl/P120NST5O3PNNDEruGhvL67k163LuYd2WsaD
         TVg8ZSELHR/dyPvb3A9odlNy3CG/SFSUTHqVdOJNDuo+QJoJAkag6Mwxwk/HM6aTwXYE
         pujT4BEaVXpetziNE00kagEbJtY/BdFe5bIiLycv7uQJb8bJdLqUvgS2md95Wb9Y2wQ2
         xqiQ==
X-Gm-Message-State: AOAM531uzp0mxVZBIR6re+2KQV8kUMR4uFcJJyro9Og46GSnDQQJKVDK
        kZRKSQo4H6A1CEEqNfoKVabFHQ==
X-Google-Smtp-Source: ABdhPJwB8j2u/cujHRi6C9hFkNiVFW4PLGhDjL/+Uzw5oKliGwBjASBtEEumzc2+wCCT+0M/ofqccg==
X-Received: by 2002:a05:6a00:14d1:: with SMTP id w17mr4787164pfu.46.1643313756502;
        Thu, 27 Jan 2022 12:02:36 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:9246:1838:3243:3071])
        by smtp.gmail.com with ESMTPSA id k21sm6561190pff.33.2022.01.27.12.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:02:36 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Tang <kevin3.tang@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 31/35] drm/sprd: Migrate to aggregate driver
Date:   Thu, 27 Jan 2022 12:01:37 -0800
Message-Id: <20220127200141.1295328-32-swboyd@chromium.org>
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

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Kevin Tang <kevin3.tang@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/sprd/sprd_drm.c | 48 +++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index a077e2d4d721..ff39b32b20c0 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -65,8 +65,9 @@ static struct drm_driver sprd_drm_drv = {
 	.minor			= DRIVER_MINOR,
 };
 
-static int sprd_drm_bind(struct device *dev)
+static int sprd_drm_aggregate_probe(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm;
 	struct sprd_drm *sprd;
@@ -118,8 +119,9 @@ static int sprd_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void sprd_drm_unbind(struct device *dev)
+static void sprd_drm_aggregate_remove(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
 	struct drm_device *drm = dev_get_drvdata(dev);
 
 	drm_dev_unregister(drm);
@@ -129,9 +131,28 @@ static void sprd_drm_unbind(struct device *dev)
 	component_unbind_all(drm->dev, drm);
 }
 
-static const struct component_master_ops drm_component_ops = {
-	.bind = sprd_drm_bind,
-	.unbind = sprd_drm_unbind,
+static void sprd_drm_aggregate_shutdown(struct aggregate_device *adev)
+{
+	struct device *dev = aggregate_device_parent(adev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = platform_get_drvdata(pdev);
+
+	if (!drm) {
+		drm_warn(drm, "drm device is not available, no shutdown\n");
+		return;
+	}
+
+	drm_atomic_helper_shutdown(drm);
+}
+
+static struct aggregate_driver sprd_drm_aggregate_driver = {
+	.probe = sprd_drm_aggregate_probe,
+	.remove = sprd_drm_aggregate_remove,
+	.shutdown = sprd_drm_aggregate_shutdown,
+	.driver = {
+		.name = "sprd_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int compare_of(struct device *dev, void *data)
@@ -141,27 +162,15 @@ static int compare_of(struct device *dev, void *data)
 
 static int sprd_drm_probe(struct platform_device *pdev)
 {
-	return drm_of_component_probe(&pdev->dev, compare_of, &drm_component_ops);
+	return drm_of_aggregate_probe(&pdev->dev, compare_of, &sprd_drm_aggregate_driver);
 }
 
 static int sprd_drm_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &drm_component_ops);
+	component_aggregate_unregister(&pdev->dev, &sprd_drm_aggregate_driver);
 	return 0;
 }
 
-static void sprd_drm_shutdown(struct platform_device *pdev)
-{
-	struct drm_device *drm = platform_get_drvdata(pdev);
-
-	if (!drm) {
-		drm_warn(drm, "drm device is not available, no shutdown\n");
-		return;
-	}
-
-	drm_atomic_helper_shutdown(drm);
-}
-
 static const struct of_device_id drm_match_table[] = {
 	{ .compatible = "sprd,display-subsystem", },
 	{ /* sentinel */ },
@@ -171,7 +180,6 @@ MODULE_DEVICE_TABLE(of, drm_match_table);
 static struct platform_driver sprd_drm_driver = {
 	.probe = sprd_drm_probe,
 	.remove = sprd_drm_remove,
-	.shutdown = sprd_drm_shutdown,
 	.driver = {
 		.name = "sprd-drm-drv",
 		.of_match_table = drm_match_table,
-- 
https://chromeos.dev

