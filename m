Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1210A466C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377453AbhLBWbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377261AbhLBWbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:31:15 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A0AC0613E1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:27:49 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g19so941819pfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aOJT4e2/QJLKFjWixGXmSkqLgf4Tc1N8aTB3xOsamvQ=;
        b=S2cUyv9Jrj0pIQ5/FWHVT8/lxQnJ2mFqOXQxH4toOlnhWX5u9ggWSz2i+KOxf+Efpz
         zkybdoQu1cuONhDb6wYe/s4UNs11qwUoDeIrg58N1vhbqBrGiRZDi9oPIHwPdVkHu8Ua
         c0q4USKqqFECxpqCgUnx8UQA1xgJy3+2UoWpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOJT4e2/QJLKFjWixGXmSkqLgf4Tc1N8aTB3xOsamvQ=;
        b=UuGjLJtiB10rXv3bmPPm62qt9Ji2B/udFCwjGy2qi3gX5LtCubzVR119415nFEr8WA
         Vg4oxOzp4bwuc2kWMf4CHGHJlMnu1wKn34Sxazp6oeY//6RQ0y2IrD6jduTGCxkFtneq
         O3CH9fONYl3WwYi+1dwWlaelnPtMrvMz33ftAtc6MPc3le+QXHLNZ+RoeH22broe27NB
         RYpp5ZjbPTkTtscKrI1bqXCQqJomdXbiOUdUeMZi47a3Km3fYWLo5FEdU5RM540zp1cD
         PvOq3/yCo1Oq9u169EA5Qv21DhNkHl2TUm/rSAoFJQPNoJ4+cH+cetpzOs3GpZXOrCHx
         pSew==
X-Gm-Message-State: AOAM532ECvxwr1kfPCIFdWJ0L3PJeenw5+j3NIDfYlvMNExlwqNW+9hG
        JTPR8Im794xYe6LQVTDXWWDQ/w==
X-Google-Smtp-Source: ABdhPJxwnbblXolNA9QDloMU8T9W4LnnaErrTpJjrCxF8cdzwncQwTXxTXVaks30xOUz0l/fc1YfLw==
X-Received: by 2002:a05:6a00:2391:b0:4a2:cb64:2c97 with SMTP id f17-20020a056a00239100b004a2cb642c97mr15192965pfc.36.1638484068602;
        Thu, 02 Dec 2021 14:27:48 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:f4f2:1b7e:5aea:bf3c])
        by smtp.gmail.com with ESMTPSA id q9sm836934pfj.9.2021.12.02.14.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:27:48 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v4 15/34] drm/imx: Migrate to aggregate driver
Date:   Thu,  2 Dec 2021 14:27:13 -0800
Message-Id: <20211202222732.2453851-16-swboyd@chromium.org>
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

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/imx/imx-drm-core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index cb685fe2039b..9e28bb16364c 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -196,8 +196,9 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == np;
 }
 
-static int imx_drm_bind(struct device *dev)
+static int imx_drm_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm;
 	int ret;
 
@@ -264,8 +265,9 @@ static int imx_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void imx_drm_unbind(struct device *dev)
+static void imx_drm_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm = dev_get_drvdata(dev);
 
 	drm_dev_unregister(drm);
@@ -279,14 +281,18 @@ static void imx_drm_unbind(struct device *dev)
 	dev_set_drvdata(dev, NULL);
 }
 
-static const struct component_master_ops imx_drm_ops = {
-	.bind = imx_drm_bind,
-	.unbind = imx_drm_unbind,
+static struct aggregate_driver imx_drm_aggregate_driver = {
+	.probe = imx_drm_bind,
+	.remove = imx_drm_unbind,
+	.driver = {
+		.name = "imx_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int imx_drm_platform_probe(struct platform_device *pdev)
 {
-	int ret = drm_of_component_probe(&pdev->dev, compare_of, &imx_drm_ops);
+	int ret = drm_of_aggregate_probe(&pdev->dev, compare_of, &imx_drm_aggregate_driver);
 
 	if (!ret)
 		ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
@@ -296,7 +302,7 @@ static int imx_drm_platform_probe(struct platform_device *pdev)
 
 static int imx_drm_platform_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &imx_drm_ops);
+	component_aggregate_unregister(&pdev->dev, &imx_drm_aggregate_driver);
 	return 0;
 }
 
-- 
https://chromeos.dev

