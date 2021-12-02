Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63453466C4D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377263AbhLBWbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377217AbhLBWbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:31:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24112C061759
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:27:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so3952905pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyFhWuo5Hgtey/EJ0ER9SojRROyEQ1lmEqqEKYabFj8=;
        b=odwqzjRkBmxA1qXzAb8CtaV8Ax17PvJAsF8AWA5KlGHBc9xiJ20mEnFtBc9/S0n2DS
         m5c2HgazJs1iEEriuNiaJGQstV3se73Rp9LsgIm8iHfGJY8nQorkhMitamkq8qynQfK6
         EUNGQbhmWVuUpWpQ7GeD3K90KEgEaF78pPYEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyFhWuo5Hgtey/EJ0ER9SojRROyEQ1lmEqqEKYabFj8=;
        b=jvwF+/dg91px1exOXdojYlmgkQAVZWTkv1LeD8zSxKPxGg2ouQqg6j3Bnfi7fLCJHe
         GZMCE3Z+hET+hauGahZHcJMlV5eV4CMxsHi34aj49Zs7keeBhclT3r765gQR1FPsfsNW
         G1p4IlXH9rfpyXT1xh64jzz92Vwc8dbnVwqprrhCsF3pjtP2oFfU5pywGTIJWEbas80I
         0y1AAxD1ZqZmVvompOsIm784ImL8mYJED5rtx/tevCgkh//cS6U4QsUWl9ZaANeBseQf
         ITA4Uq7yGXgMaYIJG0XJJ0N+kPro0vQW+7FF8M3LJIy6f1SOSPAAK8Uh4ddOBJN8/3vZ
         Aojg==
X-Gm-Message-State: AOAM532wX/2/u/MN6y6nUyXzu3Xy+memJVQIVSzS682/NNUZwJ1CYcQ3
        1KuHbCT6xwWtZbXp8KLQwYrmQZUQVIWYbg==
X-Google-Smtp-Source: ABdhPJzTjzlJn/+0dlB7m+bDOcOE8sPA8L78n/0o1kEtXiZ8GrYP+EFvD6RSgzQOktKB+UYrIdbj7A==
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id i11-20020a1709026acb00b0014276c3d35fmr18280297plt.89.1638484064692;
        Thu, 02 Dec 2021 14:27:44 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:f4f2:1b7e:5aea:bf3c])
        by smtp.gmail.com with ESMTPSA id q9sm836934pfj.9.2021.12.02.14.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:27:44 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v4 10/34] drm/malidp: Migrate to aggregate driver
Date:   Thu,  2 Dec 2021 14:27:08 -0800
Message-Id: <20211202222732.2453851-11-swboyd@chromium.org>
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

TODO: This can be updated to move the drm helper logic into the
aggregate driver shutdown op.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/arm/malidp_drv.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 78d15b04b105..e6ee4d1e3bb8 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -702,8 +702,9 @@ static int malidp_runtime_pm_resume(struct device *dev)
 	return 0;
 }
 
-static int malidp_bind(struct device *dev)
+static int malidp_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct resource *res;
 	struct drm_device *drm;
 	struct malidp_drm *malidp;
@@ -894,8 +895,9 @@ static int malidp_bind(struct device *dev)
 	return ret;
 }
 
-static void malidp_unbind(struct device *dev)
+static void malidp_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct malidp_drm *malidp = drm->dev_private;
 	struct malidp_hw_device *hwdev = malidp->dev;
@@ -921,9 +923,13 @@ static void malidp_unbind(struct device *dev)
 	of_reserved_mem_device_release(dev);
 }
 
-static const struct component_master_ops malidp_master_ops = {
-	.bind = malidp_bind,
-	.unbind = malidp_unbind,
+static struct aggregate_driver malidp_aggregate_driver = {
+	.probe = malidp_bind,
+	.remove = malidp_unbind,
+	.driver = {
+		.name = "malidp_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int malidp_compare_dev(struct device *dev, void *data)
@@ -949,13 +955,12 @@ static int malidp_platform_probe(struct platform_device *pdev)
 	drm_of_component_match_add(&pdev->dev, &match, malidp_compare_dev,
 				   port);
 	of_node_put(port);
-	return component_master_add_with_match(&pdev->dev, &malidp_master_ops,
-					       match);
+	return component_aggregate_register(&pdev->dev, &malidp_aggregate_driver, match);
 }
 
 static int malidp_platform_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &malidp_master_ops);
+	component_aggregate_unregister(&pdev->dev, &malidp_aggregate_driver);
 	return 0;
 }
 
-- 
https://chromeos.dev

