Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE64486C97
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbiAFVrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244765AbiAFVql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:46:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BD4C03327A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:46:32 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id m1so3575132pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cp/sB0csPJfGnASpc4rymZ0PPQPzUhdhwUtGaGHpcvc=;
        b=hh951AuDm1lnuTY6Tg2bk0JqAZI+SXik/wKYCanK/9z21XaxR8dcVOq5HuTUHvXX+4
         BA5DB+cYLOeFa4Yj/qhEHktwsW51FrcAvaCxu93fkpHy98KKRByaAlCqq3LMH6f2Yesv
         syDwoIVXJ+hcSDIJ+jirliEw4GXQyzkO5KEuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cp/sB0csPJfGnASpc4rymZ0PPQPzUhdhwUtGaGHpcvc=;
        b=LBmeJfA4p3Bn/znDU6INtw5ZIH9q+2ljtSsY/pyuZl5rEjIGmWE52o8U5iXOqJHGFS
         u9yOT77YIpmn+RkNaQA8D0iqXgdBdKyTK5JxV7JOCOd8IvPjlMMtPLeWMo9FIVDGAwLT
         RhnnTiyGC5VhX4aD9h9zKaauDDG0Ii0Ygq3Fa9rWwHqqpkVH1wo3MxaMTy3R+d19PcQb
         MLAKlI8wK5RXsFIAObYmhaa3mp+Ltgq2E3YuGIWPfpKOMbJCKg1nE9vMC2mjXuCQOIOR
         wG+DpI5JAsuA2Yo5BB5cPK+RFcA/lTgbyTlEC0ZlpFY8HfNXq2RJX5Njzb14s5V1ECs2
         ervw==
X-Gm-Message-State: AOAM533f72wkWDKFVnRvL+RBnx+hQfz1SVU0UcSMQzl9xEv+XBf3TP4G
        Km8e1qmufVGAogNSUxc7SuK2TQ==
X-Google-Smtp-Source: ABdhPJy9dQQssWkM2CNx3zabLk5PMLLArRIIl85gPr/Wn1u8evvprhCEN6jMJEhMiz/HIX7vMXU6aQ==
X-Received: by 2002:a63:a744:: with SMTP id w4mr31926122pgo.142.1641505591920;
        Thu, 06 Jan 2022 13:46:31 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ebe:a8fd:f9b0:7e85])
        by smtp.gmail.com with ESMTPSA id 10sm3539960pfm.56.2022.01.06.13.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:46:31 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 25/32] iommu/mtk: Migrate to aggregate driver
Date:   Thu,  6 Jan 2022 13:45:48 -0800
Message-Id: <20220106214556.2461363-26-swboyd@chromium.org>
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

Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iommu/mtk_iommu.c    | 14 +++++++++-----
 drivers/iommu/mtk_iommu.h    |  6 ++++--
 drivers/iommu/mtk_iommu_v1.c | 14 +++++++++-----
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 25b834104790..8e722898cbe2 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -752,9 +752,13 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	return 0;
 }
 
-static const struct component_master_ops mtk_iommu_com_ops = {
-	.bind		= mtk_iommu_bind,
-	.unbind		= mtk_iommu_unbind,
+static struct aggregate_driver mtk_iommu_aggregate_driver = {
+	.probe		= mtk_iommu_bind,
+	.remove		= mtk_iommu_unbind,
+	.driver		= {
+		.name	= "mtk_iommu_agg",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static int mtk_iommu_probe(struct platform_device *pdev)
@@ -895,7 +899,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			goto out_list_del;
 	}
 
-	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
+	ret = component_aggregate_register(dev, &mtk_iommu_aggregate_driver, match);
 	if (ret)
 		goto out_bus_set_null;
 	return ret;
@@ -928,7 +932,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	device_link_remove(data->smicomm_dev, &pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	devm_free_irq(&pdev->dev, data->irq, data);
-	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
+	component_aggregate_unregister(&pdev->dev, &mtk_iommu_aggregate_driver);
 	return 0;
 }
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index f81fa8862ed0..064fd4f4eade 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -94,15 +94,17 @@ static inline void release_of(struct device *dev, void *data)
 	of_node_put(data);
 }
 
-static inline int mtk_iommu_bind(struct device *dev)
+static inline int mtk_iommu_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 
 	return component_bind_all(dev, &data->larb_imu);
 }
 
-static inline void mtk_iommu_unbind(struct device *dev)
+static inline void mtk_iommu_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 
 	component_unbind_all(dev, &data->larb_imu);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index be22fcf988ce..5fb29058a165 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -534,9 +534,13 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{}
 };
 
-static const struct component_master_ops mtk_iommu_com_ops = {
-	.bind		= mtk_iommu_bind,
-	.unbind		= mtk_iommu_unbind,
+static struct aggregate_driver mtk_iommu_aggregate_driver = {
+	.probe		= mtk_iommu_bind,
+	.remove		= mtk_iommu_unbind,
+	.driver		= {
+		.name	= "mtk_iommu_agg",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static int mtk_iommu_probe(struct platform_device *pdev)
@@ -624,7 +628,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			goto out_dev_unreg;
 	}
 
-	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
+	ret = component_aggregate_register(dev, &mtk_iommu_aggregate_driver, match);
 	if (ret)
 		goto out_bus_set_null;
 	return ret;
@@ -650,7 +654,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
-	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
+	component_aggregate_unregister(&pdev->dev, &mtk_iommu_aggregate_driver);
 	return 0;
 }
 
-- 
https://chromeos.dev

