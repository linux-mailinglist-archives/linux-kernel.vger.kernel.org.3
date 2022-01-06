Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C038C486C95
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbiAFVrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244738AbiAFVqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:46:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F0C03401F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:46:27 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso8543018pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3a3i/nDaB8ZUdNqJ4VU8hWXyXTL7/wWiLoMS1h5NiSM=;
        b=fdvHO09XyrK1fRBMv6ZCuxZJEOBZEnRNlYv157RP6xvIBDI1KvxVfeWRIWISqNDWJy
         Mje3eRi4npSQNpDWJ9O/5uGZmlZQUlN1UZC4PK3FDQL/MgLM1GrU1WmJLfcElmnrOL1s
         6sKDsY1CzavLw8ggHfgi4o17oPUIa2PeA1B94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3a3i/nDaB8ZUdNqJ4VU8hWXyXTL7/wWiLoMS1h5NiSM=;
        b=YbIlFtH3DD/ev1q/ZIJkW5b78vgVmSyt4euvWXo7EeJFleBh1kSbfvO+A+NVkix4hu
         vOW+DsEAn/UZ8Njg8JTTH37Q0cuLkbvIz2pjv0EKPf7bzLhehI93vSLa2G/+rBA0Fepy
         DS6Q1ZpjqRs5dMR8mCNk4wn0u7U71LgU2fDqCbRe80fb4tHuq/bAGG2dbgRS6gkSSlaE
         zRomXKMp0N4jxTQo4EdocPqcSZtfgk6DlUTuofRUic7ENQm5poIaBJjZaV5pUtQNuLpW
         V1qi4OvME40v1nPqmVRJCCsqag4W9arNneob9X6tiplmpyhC1enS3oYGFWfs9XCTkM+S
         jwsQ==
X-Gm-Message-State: AOAM532uMzkf7ArJUidIW8zJrNvEn5WxqXBR6/8zZgeh20k6YGJD432O
        rxckFhOAfi6wAi+R1nl+qx80rw==
X-Google-Smtp-Source: ABdhPJwr1viR7RiIgdiNaWACG2FQzv9WC65+KPeGyqeBih/ukDD1zE8+KmCzZ5Vl/9CAHYBtTaRbIw==
X-Received: by 2002:a17:902:ec85:b0:148:a8d2:91c0 with SMTP id x5-20020a170902ec8500b00148a8d291c0mr60254706plg.94.1641505586819;
        Thu, 06 Jan 2022 13:46:26 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ebe:a8fd:f9b0:7e85])
        by smtp.gmail.com with ESMTPSA id 10sm3539960pfm.56.2022.01.06.13.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:46:26 -0800 (PST)
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
Subject: [PATCH v5 21/32] drm/sti: Migrate to aggregate driver
Date:   Thu,  6 Jan 2022 13:45:44 -0800
Message-Id: <20220106214556.2461363-22-swboyd@chromium.org>
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
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/sti/sti_drv.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index c7efb43b83ee..b277cc679154 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -182,8 +182,9 @@ static void sti_cleanup(struct drm_device *ddev)
 	ddev->dev_private = NULL;
 }
 
-static int sti_bind(struct device *dev)
+static int sti_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *ddev;
 	int ret;
 
@@ -216,8 +217,9 @@ static int sti_bind(struct device *dev)
 	return ret;
 }
 
-static void sti_unbind(struct device *dev)
+static void sti_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *ddev = dev_get_drvdata(dev);
 
 	drm_dev_unregister(ddev);
@@ -225,9 +227,13 @@ static void sti_unbind(struct device *dev)
 	drm_dev_put(ddev);
 }
 
-static const struct component_master_ops sti_ops = {
-	.bind = sti_bind,
-	.unbind = sti_unbind,
+static struct aggregate_driver sti_aggregate_driver = {
+	.probe = sti_bind,
+	.remove = sti_unbind,
+	.driver = {
+		.name = "sti_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int sti_platform_probe(struct platform_device *pdev)
@@ -249,12 +255,12 @@ static int sti_platform_probe(struct platform_device *pdev)
 		child_np = of_get_next_available_child(node, child_np);
 	}
 
-	return component_master_add_with_match(dev, &sti_ops, match);
+	return component_aggregate_register(dev, &sti_aggregate_driver, match);
 }
 
 static int sti_platform_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &sti_ops);
+	component_aggregate_unregister(&pdev->dev, &sti_aggregate_driver);
 
 	return 0;
 }
-- 
https://chromeos.dev

