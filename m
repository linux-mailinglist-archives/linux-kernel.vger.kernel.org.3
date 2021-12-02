Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603D9466C90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbhLBWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377381AbhLBWbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:31:33 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3782CC061784
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:27:54 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so3657907pja.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44Qv1WEc4fBQtGQZgnR/7aRXBM5nSt7tXrgm1eHf/P0=;
        b=cX1iY1ENOZ+a2V3hojNUuDbXyZap3b4mWnbZbtZ5qQdf3XFsal5YWMXVeycKdERVaT
         8vdjnHo/vYB8jcaSorlm0ZMSnnQsueK2ba+1E13Qe8+ax7cnsvWNeieNVp8iPjhlgHXi
         RaEKwXwxy6REnAYw3vl35pPxNV51Ll5ar7l1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44Qv1WEc4fBQtGQZgnR/7aRXBM5nSt7tXrgm1eHf/P0=;
        b=XpA2uyXRHOjtOW2gFHR39yIRaps4w553FoXw7OSnKjrlCc7Nvoq4WygOHMMsrO2beA
         YRO9EvKmBC46FDh2ErjXaNemxnSJ9b33HjrUI8Ka8NpvA0rk4J8CPOz02pvcnX02d96J
         sWboUJ1/rQvTUKrMvbmGQarSnz0b6tgCqJvJL12MWk/1fy8jfGSDSgIi8d3FhCExYY2V
         oToSE58XES/nyqA+ovmec0dSeNOdUX+g2ueQsSm7DYR549NW02qLKFDuxFDtZIkI4K4b
         GjERtMqoUAc0JG3TcAWizqNuU+ByofaZJ8RfMKaHlcZ5QpoX0YJ6JjCtnAVv3QyIM5wF
         WSuA==
X-Gm-Message-State: AOAM533MYeS7t8sBPn2iNQIJ/T7ACao0oZlz0fcrDmcST93GLsT3DApe
        kEF7f64SLvL65E5sl17jrl4zsg==
X-Google-Smtp-Source: ABdhPJyXKoYigNKyoGI61w9SibHpgcyXT6AsTEaLXML82XI6yjC6fGI3u/P/lH+Cj9/0aOxz4y0CHA==
X-Received: by 2002:a17:902:d88b:b0:142:8acf:615b with SMTP id b11-20020a170902d88b00b001428acf615bmr18336884plz.62.1638484073793;
        Thu, 02 Dec 2021 14:27:53 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:f4f2:1b7e:5aea:bf3c])
        by smtp.gmail.com with ESMTPSA id q9sm836934pfj.9.2021.12.02.14.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:27:53 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v4 21/34] drm/rockchip: Migrate to aggregate driver
Date:   Thu,  2 Dec 2021 14:27:19 -0800
Message-Id: <20211202222732.2453851-22-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
In-Reply-To: <20211202222732.2453851-1-swboyd@chromium.org>
References: <20211202222732.2453851-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index e4ebe60b3cc1..6c755361d376 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -109,8 +109,9 @@ static void rockchip_iommu_cleanup(struct drm_device *drm_dev)
 	iommu_domain_free(private->domain);
 }
 
-static int rockchip_drm_bind(struct device *dev)
+static int rockchip_drm_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm_dev;
 	struct rockchip_drm_private *private;
 	int ret;
@@ -183,8 +184,9 @@ static int rockchip_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void rockchip_drm_unbind(struct device *dev)
+static void rockchip_drm_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	drm_dev_unregister(drm_dev);
@@ -346,9 +348,13 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
 	return match ?: ERR_PTR(-ENODEV);
 }
 
-static const struct component_master_ops rockchip_drm_ops = {
-	.bind = rockchip_drm_bind,
-	.unbind = rockchip_drm_unbind,
+static struct aggregate_driver rockchip_aggregate_driver = {
+	.probe = rockchip_drm_bind,
+	.remove = rockchip_drm_unbind,
+	.driver = {
+		.name = "rockchip_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int rockchip_drm_platform_of_probe(struct device *dev)
@@ -419,7 +425,7 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
 	if (IS_ERR(match))
 		return PTR_ERR(match);
 
-	ret = component_master_add_with_match(dev, &rockchip_drm_ops, match);
+	ret = component_aggregate_register(dev, &rockchip_aggregate_driver, match);
 	if (ret < 0) {
 		rockchip_drm_match_remove(dev);
 		return ret;
@@ -430,7 +436,7 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
 
 static int rockchip_drm_platform_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &rockchip_drm_ops);
+	component_aggregate_unregister(&pdev->dev, &rockchip_aggregate_driver);
 
 	rockchip_drm_match_remove(&pdev->dev);
 
-- 
https://chromeos.dev

