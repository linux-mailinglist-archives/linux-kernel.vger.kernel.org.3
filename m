Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EC0466C72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377398AbhLBWb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377351AbhLBWba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:31:30 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94669C061759
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:27:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z6so945405pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SfmZAoSN1UYJWac68o+RmufoyphUhdu5prdrSebp+yc=;
        b=GqHzD9FvNj8SYcgXbE573ClF6vnNZ4lCuFS/aJ3QG383hX8usV6EKBrhu9+NkEIamY
         OclBhOZt8HVNupj84GNDvtbiUwu5t4su0VRrL2FA1fAMeh5t9z0qEOjPG/EG9iTybM0H
         x7TdKSHNDr1wa8LbUzwsWMQ0urOKXq9btv+9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfmZAoSN1UYJWac68o+RmufoyphUhdu5prdrSebp+yc=;
        b=tYg/XhUr+nJgTxnzOmlwmsRcTLcdxUAguepiYrLrejOkysG1N09yxHhMy4vm80jWh7
         RMv9jLUC5bk/0OOPXTt0ZcIVAEGhpodpooD5QwXgDQMdp0PlEN22EpBaofKqAA2XnLQi
         w+8AwYonnp0LWXEx/T6QTzUVfNktj2F+dT2aw1UO0FFd+eZb6E4EMO+qFWxfquRf0mRe
         5frFtlHLWucT9QEysA1KcxwQdeTyFEIvITIduRFbLqYCPXofy/gupORpjTAllZCMKCE7
         70u75W+ahJWiTKf1qnhKjFAT5teUZYs8kQzW9w6+oyCUdM99Mbb/8Z1Oi6Y4ZCAQ/iNU
         7zQw==
X-Gm-Message-State: AOAM533B7ctdbDmjX73w++hKhOFztzV5QZm1jcBfE4oCewaRT5GLZU22
        PiTF7kqM7+3MSa10oERP786zrw==
X-Google-Smtp-Source: ABdhPJw2Fepit9l43kyK4gY1m1LC4bO41CiNzjUZksZppK/ZCWFoSYygyjGs0OZuYHfrjsdL9pHJog==
X-Received: by 2002:a63:4c58:: with SMTP id m24mr1515448pgl.597.1638484071208;
        Thu, 02 Dec 2021 14:27:51 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:f4f2:1b7e:5aea:bf3c])
        by smtp.gmail.com with ESMTPSA id q9sm836934pfj.9.2021.12.02.14.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:27:50 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v4 18/34] drm/mediatek: Migrate to aggregate driver
Date:   Thu,  2 Dec 2021 14:27:16 -0800
Message-Id: <20211202222732.2453851-19-swboyd@chromium.org>
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

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index aec39724ebeb..a3f27b8c9769 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -348,8 +348,9 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
-static int mtk_drm_bind(struct device *dev)
+static int mtk_drm_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 	struct drm_device *drm;
 	int ret;
@@ -380,8 +381,9 @@ static int mtk_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void mtk_drm_unbind(struct device *dev)
+static void mtk_drm_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 
 	drm_dev_unregister(private->drm);
@@ -391,9 +393,13 @@ static void mtk_drm_unbind(struct device *dev)
 	private->drm = NULL;
 }
 
-static const struct component_master_ops mtk_drm_ops = {
-	.bind		= mtk_drm_bind,
-	.unbind		= mtk_drm_unbind,
+static struct aggregate_driver mtk_drm_aggregate_driver = {
+	.probe		= mtk_drm_bind,
+	.remove		= mtk_drm_unbind,
+	.driver		= {
+		.name	= "mtk_drm",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
@@ -593,7 +599,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, private);
 
-	ret = component_master_add_with_match(dev, &mtk_drm_ops, match);
+	ret = component_aggregate_register(dev, &mtk_drm_aggregate_driver, match);
 	if (ret)
 		goto err_pm;
 
@@ -616,7 +622,7 @@ static int mtk_drm_remove(struct platform_device *pdev)
 	struct mtk_drm_private *private = platform_get_drvdata(pdev);
 	int i;
 
-	component_master_del(&pdev->dev, &mtk_drm_ops);
+	component_aggregate_unregister(&pdev->dev, &mtk_drm_aggregate_driver);
 	pm_runtime_disable(&pdev->dev);
 	of_node_put(private->mutex_node);
 	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
-- 
https://chromeos.dev

