Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177C9466C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349443AbhLBWcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377373AbhLBWbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:31:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B06DC0613FC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:27:53 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 8so964570pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IAciPlNRPfkJgo3LSljGMR1t9yoWVxJAu5cqfoLKs8=;
        b=ZrzSCh/rFXkmx5Dr8yB+yeAaW9c6VEvfWvglxVBg2FFKJ7efhLwtmeT6vKYdWUr8Yw
         QqxZbXE04o4P2qvypJIKuDvCMKiknt4LJ6XNiz71Fa8gTKRC1cIH4is5SvtDk3Ngr68s
         MNI0HNgCtQ3pqos7n1/yzeN1LmON/a29L9lRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IAciPlNRPfkJgo3LSljGMR1t9yoWVxJAu5cqfoLKs8=;
        b=Csly/c+c+6j4H+Kr8SqKpUEeeMyi3YiYJ6NJmRqVxmrWFLr4iLz9cdGABRon/YA6bh
         cLTQ9cCceT5TH0jtwi356rRnQhPfidKAsqseBpSsZ1/QCnWNFwDxGHCpnEQndPVG7GbJ
         2SPBrvSR/AOoYNPz3xQl95AHD2+QZdwGICYM3qXMldf5r1pt6X0MLIIn4T/ZHVpSRFHb
         o4vJg8dWcFcCt3IKIZOVRJNq5OWGSA97edxliDlwmIcaOmwOYVs7sv9snJkPDARgITXY
         znkNV5Pj0jVXkUa+Vdkw5W1Ty8gLFGOTihcY9/ohqrcTeceSnC0JmPOBJHTfaLwpgqIB
         l3hQ==
X-Gm-Message-State: AOAM532IgOrVwaZvFrpy8kKNNR210HB0wOIaYIAYPEEGZ4RP6X419H68
        Ao0scr/sNECaPLG+f0PD2/C03AsX6VIshQ==
X-Google-Smtp-Source: ABdhPJy13mZ48jfTvFMjifi+H+M3BRVPQTEod/OK8/r5QfcrwMxFPAuEeOqfLBI/CQ3w3gfEW2A7GQ==
X-Received: by 2002:a63:8848:: with SMTP id l69mr1617155pgd.41.1638484073050;
        Thu, 02 Dec 2021 14:27:53 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:f4f2:1b7e:5aea:bf3c])
        by smtp.gmail.com with ESMTPSA id q9sm836934pfj.9.2021.12.02.14.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:27:52 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Tomi Valkeinen <tomba@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v4 20/34] drm/omap: Migrate to aggregate driver
Date:   Thu,  2 Dec 2021 14:27:18 -0800
Message-Id: <20211202222732.2453851-21-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
In-Reply-To: <20211202222732.2453851-1-swboyd@chromium.org>
References: <20211202222732.2453851-1-swboyd@chromium.org>
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
index d6a5862b4dbf..9328d97f19ab 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -1304,8 +1304,9 @@ static const struct soc_device_attribute dss_soc_devices[] = {
 	{ /* sentinel */ }
 };
 
-static int dss_bind(struct device *dev)
+static int dss_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct dss_device *dss = dev_get_drvdata(dev);
 	struct platform_device *drm_pdev;
 	struct dss_pdata pdata;
@@ -1330,8 +1331,9 @@ static int dss_bind(struct device *dev)
 	return 0;
 }
 
-static void dss_unbind(struct device *dev)
+static void dss_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
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
@@ -1504,7 +1510,7 @@ static int dss_probe(struct platform_device *pdev)
 	cmatch.match = &match;
 	device_for_each_child(&pdev->dev, &cmatch, dss_add_child_component);
 
-	r = component_master_add_with_match(&pdev->dev, &dss_component_ops, match);
+	r = component_aggregate_register(&pdev->dev, &dss_aggregate_driver, match);
 	if (r)
 		goto err_of_depopulate;
 
@@ -1543,7 +1549,7 @@ static int dss_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(&pdev->dev);
 
-	component_master_del(&pdev->dev, &dss_component_ops);
+	component_aggregate_unregister(&pdev->dev, &dss_aggregate_driver);
 
 	dss_debugfs_remove_file(dss->debugfs.clk);
 	dss_debugfs_remove_file(dss->debugfs.dss);
-- 
https://chromeos.dev

