Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBD486C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244646AbiAFVqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbiAFVqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:46:14 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB7C06118A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:46:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so10051410pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsjwfsQuiDMEQ+TXne3j17pwDv7xto97Rnhld6OcLgM=;
        b=UfX8IpxE7Xm8m0THPaEOlj7kVL2i9xBXvepNNTPjRZ4zlKvYKJEDRvcbsFMFQ/irYV
         5Bf5aVv5JZ7qUuUqHXTUO8t1mGACN+ojn2ZDY0bM3Mg0eKxbkx7xhxdycW9FfTTWdHZo
         3UM63Knx5hZTA/deRQPpqN0cu4ZGbjK9i0N+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsjwfsQuiDMEQ+TXne3j17pwDv7xto97Rnhld6OcLgM=;
        b=FLc9k0xM3Ks+o3dqEudO22kEKIeenBKXTHKOL0UKvvqCTsZlp/UedAQkM9iibaWzBv
         g/0m9CRpNvmcO1XwKGQBzB0KPay1qvemPqK1itTmACuHqR7aIP7M4VXZzaqcrJ+a8bAG
         FcebJwvvucPIuwZi0CS01uF5AOmzGkG6wZHczH3H83JR/IkiOG6AcNqGogrU+yqdals5
         6d/aR/wKdrqyVuMYIsb2C0yz6L1HPdCRlqzYnzscHg1Yc+Q5KSlkG6utZzmLL1UZebMS
         m1GbeWtxv4eHtF7zPdIsBEgK24aQrQ6DWbryBPK/CivhcYMcfLFaNp9PnLiA4fPqwIlD
         ObEA==
X-Gm-Message-State: AOAM531arzCxPoISFnKofJJ/ABqaIuBCcTHbaw6NOjre57zHWpLRMWvI
        n5EP8GTHWVH5f5rXcFN7etxZvw==
X-Google-Smtp-Source: ABdhPJyk/M15t+lyhtoh1b/2CEQ3pV+TQZFLl1SvsJLFKiODwyiIibw9MBABprRy3lEFWknjr9AaqA==
X-Received: by 2002:a17:90b:1d8b:: with SMTP id pf11mr6100787pjb.119.1641505573602;
        Thu, 06 Jan 2022 13:46:13 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ebe:a8fd:f9b0:7e85])
        by smtp.gmail.com with ESMTPSA id 10sm3539960pfm.56.2022.01.06.13.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:46:13 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 11/32] drm/etnaviv: Migrate to aggregate driver
Date:   Thu,  6 Jan 2022 13:45:34 -0800
Message-Id: <20220106214556.2461363-12-swboyd@chromium.org>
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

Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 7dcc6392792d..95d1e518ff13 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -494,8 +494,9 @@ static const struct drm_driver etnaviv_drm_driver = {
 /*
  * Platform driver:
  */
-static int etnaviv_bind(struct device *dev)
+static int etnaviv_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct etnaviv_drm_private *priv;
 	struct drm_device *drm;
 	int ret;
@@ -552,8 +553,9 @@ static int etnaviv_bind(struct device *dev)
 	return ret;
 }
 
-static void etnaviv_unbind(struct device *dev)
+static void etnaviv_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct etnaviv_drm_private *priv = drm->dev_private;
 
@@ -569,9 +571,13 @@ static void etnaviv_unbind(struct device *dev)
 	drm_dev_put(drm);
 }
 
-static const struct component_master_ops etnaviv_master_ops = {
-	.bind = etnaviv_bind,
-	.unbind = etnaviv_unbind,
+static struct aggregate_driver etnaviv_aggregate_driver = {
+	.probe = etnaviv_bind,
+	.remove = etnaviv_unbind,
+	.driver = {
+		.name = "etnaviv_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int compare_of(struct device *dev, void *data)
@@ -609,12 +615,12 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			component_match_add(dev, &match, compare_str, names[i]);
 	}
 
-	return component_master_add_with_match(dev, &etnaviv_master_ops, match);
+	return component_aggregate_register(dev, &etnaviv_aggregate_driver, match);
 }
 
 static int etnaviv_pdev_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &etnaviv_master_ops);
+	component_aggregate_unregister(&pdev->dev, &etnaviv_aggregate_driver);
 
 	return 0;
 }
-- 
https://chromeos.dev

