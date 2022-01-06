Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7878486C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbiAFVqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbiAFVqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:46:13 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FEDC034001
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:46:12 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i30so3769070pgl.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g366T6z/wDv+u0z2UhkHLqZZ67YI06zaB4um2FhnwRI=;
        b=hMzRCsm85BzTseZgCckSwAtxGaQ6AwGKmpMBLS/VovB3h2UykhAOfX8IJg4bI+Przl
         +hVQ4fMopnz0l091lu3Xx9mRGBiLNG23xThYMrNM8Ofdiw6LWwc/hI+hwty7lC7UtgNN
         OqQ0vT+Q4Q1vqf95QgPtaETz8S+UHWY6u4ZlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g366T6z/wDv+u0z2UhkHLqZZ67YI06zaB4um2FhnwRI=;
        b=BfNF8X7G2nuBa2veNfttmvngKkvwPdIB4hXgTYfmCfZopmY8HNTrdSSGWQavzsLBQX
         23HmXYq52Q2noKPbbE46Te01DLdiwZ0zjvjqmQrz5v6ftOgIBRkqxJNPJem+BVOoeQAH
         Y+3FCAV80rPuaGSPnhkiluwAVQjH+rkWLnZu4sZex1vJz+quVN6qvm2ilx1YxtlJZ5/N
         lPbocJqZvuKNdwOGSWjkRZza0hZH2P7EAVoNP60fvfvl7E4niWeXb3ZCXb5C1XgK8s2v
         vkL+kjxSLDZTwjVzmo3mE5SOB+n7FwHLAYIL6AVcjp4dGJiH3VoNrUixMj6qln67x2dg
         ONwQ==
X-Gm-Message-State: AOAM530ElNuPaXL/udWvCP64qaLbVq3Pi/23RCz5esGdj4uMCyyr9P27
        ZjR94mZ0kngiHJ6S+fxGI7q8pA==
X-Google-Smtp-Source: ABdhPJyLrhaeJQJp2viy5oBwJ2SLs74cYyQ+2SgkPuLbpAA6wOupAp3ggrLPzlQxYpAOTb8xeL3g8w==
X-Received: by 2002:a63:7110:: with SMTP id m16mr38503368pgc.621.1641505572311;
        Thu, 06 Jan 2022 13:46:12 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ebe:a8fd:f9b0:7e85])
        by smtp.gmail.com with ESMTPSA id 10sm3539960pfm.56.2022.01.06.13.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:46:12 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 10/32] drm/armada: Migrate to aggregate driver
Date:   Thu,  6 Jan 2022 13:45:33 -0800
Message-Id: <20220106214556.2461363-11-swboyd@chromium.org>
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

Cc: Russell King <linux@armlinux.org.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/armada/armada_drv.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 8e3e98f13db4..b3559363ea43 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -60,8 +60,9 @@ static const struct drm_mode_config_funcs armada_drm_mode_config_funcs = {
 	.atomic_commit		= drm_atomic_helper_commit,
 };
 
-static int armada_drm_bind(struct device *dev)
+static int armada_drm_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct armada_private *priv;
 	struct resource *mem = NULL;
 	int ret, n;
@@ -159,8 +160,9 @@ static int armada_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void armada_drm_unbind(struct device *dev)
+static void armada_drm_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct armada_private *priv = drm_to_armada_dev(drm);
 
@@ -202,9 +204,13 @@ static void armada_add_endpoints(struct device *dev,
 	}
 }
 
-static const struct component_master_ops armada_master_ops = {
-	.bind = armada_drm_bind,
-	.unbind = armada_drm_unbind,
+static struct aggregate_driver armada_aggregate_driver = {
+	.probe = armada_drm_bind,
+	.remove = armada_drm_unbind,
+	.driver = {
+		.name = "armada_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int armada_drm_probe(struct platform_device *pdev)
@@ -213,7 +219,7 @@ static int armada_drm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	ret = drm_of_component_probe(dev, compare_dev_name, &armada_master_ops);
+	ret = drm_of_aggregate_probe(dev, compare_dev_name, &armada_aggregate_driver);
 	if (ret != -EINVAL)
 		return ret;
 
@@ -240,13 +246,12 @@ static int armada_drm_probe(struct platform_device *pdev)
 		}
 	}
 
-	return component_master_add_with_match(&pdev->dev, &armada_master_ops,
-					       match);
+	return component_aggregate_register(&pdev->dev, &armada_aggregate_driver, match);
 }
 
 static int armada_drm_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &armada_master_ops);
+	component_aggregate_unregister(&pdev->dev, &armada_aggregate_driver);
 	return 0;
 }
 
-- 
https://chromeos.dev

