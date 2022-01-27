Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE17149EBE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbiA0UCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343756AbiA0UCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:02:22 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEE7C06175C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id i1so3669381pla.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGCYteteinr61zPnRrp4oGl0a47ZYXq3HmBJU43ZKkM=;
        b=k1sf94SonpGpLzpc1eZgA1C/aa+5bazFQmE3BqTBpHJIhPTVql2l5ddtWUYF0w2amf
         xglsb43JXD9he1Z6Lxg3FS8Mv9yHCSn7eNZo/7dJohdzh70qL8bvwWxSUMBvwRaJQvrW
         T/LIMTGmPZC8er6bC0A63ZUFrWWtFwytLjG8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGCYteteinr61zPnRrp4oGl0a47ZYXq3HmBJU43ZKkM=;
        b=0f1GoxTGNJWgUDFhNFjGYfKsh0Iy8dWYHnuBQ71B/7tU/HR+nSmdbxQlTOd7BYSQeC
         RziQInF05HwELpqZmxDLSZ5+c+GgH3Adgd8RPb6KegutuQF2cymWnRoqC4sfunHK9Xoh
         eIlBZMpBhoX1Rn3Ss0U5SFIKJ+qLMJPNJTPLZNEsXbU22ESyVWBUC1p6lRrTT6Ft5bu8
         5R4l7lSWBXhfTiBPnSRW0aJ4gX6mu72iJdNPR3jyIHah3w/XmiEual39GN7JIJuYtWKU
         eWbzupR9QE47d/PXwh6nEVi5qrj5jsvztbK/7G3Wmbu9ShxuF+aJFhRTNMjjoW0R8owG
         3jsQ==
X-Gm-Message-State: AOAM53052b8jO+hd/kZmkKTqbE32jty5eqvm683K2Vrcpvgj1JPyoD1K
        1po00aV8FOYCw+zkOlpdxM/Gvg==
X-Google-Smtp-Source: ABdhPJw9/AERVJn/DWVhf7xxY/0tKAxYCNg3kYQRZkczeiE7EyDOGTbC8tRqk37+MKPkwel0JA2hBA==
X-Received: by 2002:a17:903:2352:: with SMTP id c18mr5295494plh.104.1643313739361;
        Thu, 27 Jan 2022 12:02:19 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:9246:1838:3243:3071])
        by smtp.gmail.com with ESMTPSA id k21sm6561190pff.33.2022.01.27.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:02:19 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Tomi Valkeinen <tomba@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 19/35] drm/omap: Migrate to aggregate driver
Date:   Thu, 27 Jan 2022 12:01:25 -0800
Message-Id: <20220127200141.1295328-20-swboyd@chromium.org>
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

Cc: Tomi Valkeinen <tomba@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/omapdrm/dss/dss.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index 69b3e15b9356..96a290a7bd68 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -1304,8 +1304,9 @@ static const struct soc_device_attribute dss_soc_devices[] = {
 	{ /* sentinel */ }
 };
 
-static int dss_bind(struct device *dev)
+static int dss_bind(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
 	struct dss_device *dss = dev_get_drvdata(dev);
 	struct platform_device *drm_pdev;
 	struct dss_pdata pdata;
@@ -1330,8 +1331,9 @@ static int dss_bind(struct device *dev)
 	return 0;
 }
 
-static void dss_unbind(struct device *dev)
+static void dss_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
 	struct dss_device *dss = dev_get_drvdata(dev);
 
 	platform_device_unregister(dss->drm_pdev);
@@ -1339,9 +1341,13 @@ static void dss_unbind(struct device *dev)
 	component_unbind_all(dev, NULL);
 }
 
-static const struct component_master_ops dss_component_ops = {
-	.bind = dss_bind,
-	.unbind = dss_unbind,
+static struct aggregate_driver dss_aggregate_driver = {
+	.probe = dss_bind,
+	.remove = dss_unbind,
+	.driver = {
+		.name = "dss_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int dss_component_compare(struct device *dev, void *data)
@@ -1502,7 +1508,7 @@ static int dss_probe(struct platform_device *pdev)
 	cmatch.match = &match;
 	device_for_each_child(&pdev->dev, &cmatch, dss_add_child_component);
 
-	r = component_master_add_with_match(&pdev->dev, &dss_component_ops, match);
+	r = component_aggregate_register(&pdev->dev, &dss_aggregate_driver, match);
 	if (r)
 		goto err_of_depopulate;
 
@@ -1541,7 +1547,7 @@ static int dss_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(&pdev->dev);
 
-	component_master_del(&pdev->dev, &dss_component_ops);
+	component_aggregate_unregister(&pdev->dev, &dss_aggregate_driver);
 
 	dss_debugfs_remove_file(dss->debugfs.clk);
 	dss_debugfs_remove_file(dss->debugfs.dss);
-- 
https://chromeos.dev

