Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53638486C84
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244991AbiAFVrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244424AbiAFVqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:46:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49337C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:46:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so4590921pjp.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0P0B2t7jpcQb6RReBEhUJcwiQBX6wggU1M1usRBo/kI=;
        b=OMmriz8g6SqvUhC+jJKguXZPzeNbrMkAffwjErEk+CltWZ6StTRLM1QhiC5eJkz90c
         Z0YD413vMw0bVDIg90Vurus2guUNuLOOw7WxT2Ux27KNw3xAswtMH624dH2SEC/F2Yhx
         VcAd0TKcwWLB7s5I7sk8rCos61gT5buuj5b2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0P0B2t7jpcQb6RReBEhUJcwiQBX6wggU1M1usRBo/kI=;
        b=sweeSJwfavW5OLd7XVEZX8JvRWIq/ip0myZ4wtq/RLADqPNg3JkjptOALs5M2JUESx
         BelILuvzDE+0fSK8YHqr41gD85HQgvqL8TuD9xnrL0aK4ombvILtH0uEeUhrrBz5FXf7
         F5QSs9Njc0iHaKwHPLWFcUqR3c8BO4Lu5uGC5zq5vvqOgORWvUmer8KDEnHhp1lmrw17
         RkuDnPMC+mU0CppLXg38i2Smh23UcRvcaiOoxuZgvX7Z87IkTKOoX3r9IczMB7EgpgB2
         q3SZ/p/b7/gpR2Mb2L/IrsZ2O9g5fp+7bs4VJUJCwwQVK8HCMGgst/DZblx8rLY3epiA
         HEAw==
X-Gm-Message-State: AOAM533hQBUy0SbtIWH8j+CWXExS2Tw32zPNjsL3kvGrKMXwd709C6yh
        kO4faOoTiJkX7rPhvguMH+vbaA==
X-Google-Smtp-Source: ABdhPJwevDLAx3RQTtIwgYxJoTRsVhvDf16aEqPPEqco33SsVOKqwUE3w+uhW5OAbjFhWL2saEpvwQ==
X-Received: by 2002:a17:902:d645:b0:149:b7bf:9932 with SMTP id y5-20020a170902d64500b00149b7bf9932mr22561186plh.48.1641505582894;
        Thu, 06 Jan 2022 13:46:22 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ebe:a8fd:f9b0:7e85])
        by smtp.gmail.com with ESMTPSA id 10sm3539960pfm.56.2022.01.06.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:46:22 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 18/32] drm/meson: Migrate to aggregate driver
Date:   Thu,  6 Jan 2022 13:45:41 -0800
Message-Id: <20220106214556.2461363-19-swboyd@chromium.org>
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

Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/meson/meson_drv.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 7f41a33592c8..3028f2a45f66 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -356,13 +356,16 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	return ret;
 }
 
-static int meson_drv_bind(struct device *dev)
+static int meson_drv_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
+
 	return meson_drv_bind_master(dev, true);
 }
 
-static void meson_drv_unbind(struct device *dev)
+static void meson_drv_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct meson_drm *priv = dev_get_drvdata(dev);
 	struct drm_device *drm = priv->drm;
 
@@ -386,9 +389,13 @@ static void meson_drv_unbind(struct device *dev)
 	}
 }
 
-static const struct component_master_ops meson_drv_master_ops = {
-	.bind	= meson_drv_bind,
-	.unbind	= meson_drv_unbind,
+static struct aggregate_driver meson_aggregate_drv = {
+	.probe	= meson_drv_bind,
+	.remove	= meson_drv_unbind,
+	.driver = {
+		.name = "meson_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int __maybe_unused meson_drv_pm_suspend(struct device *dev)
@@ -502,9 +509,7 @@ static int meson_drv_probe(struct platform_device *pdev)
 	if (count) {
 		dev_info(&pdev->dev, "Queued %d outputs on vpu\n", count);
 
-		return component_master_add_with_match(&pdev->dev,
-						       &meson_drv_master_ops,
-						       match);
+		return component_aggregate_register(&pdev->dev, &meson_aggregate_drv, match);
 	}
 
 	/* If no output endpoints were available, simply bail out */
-- 
https://chromeos.dev

