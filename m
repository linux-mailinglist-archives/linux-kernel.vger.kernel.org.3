Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2DF4850E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiAEKQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiAEKQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:16:24 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E81C061761;
        Wed,  5 Jan 2022 02:16:24 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q3so30477435pfs.7;
        Wed, 05 Jan 2022 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=aJdy4Vc+2i7MVFq5AwmxIGlmluiA2uKFXYF4yxPWA3k=;
        b=m8i3JZa8/Qzk7foNf2srvzSS/UYiYgHXFUuMTKIsMO9diJn7tjVHXk9CQN6DtxIfhe
         r8ylwe+u/9YXo7T3upExqyAJ5R6iTQLOmy92bioX7VS27m69dO6DO8EnCFE0jH9oWHQi
         W5VNjqdKRChzbmteTOAJkAjOp42ZHMWMstfYdN0V8uDPnqpl9kEChpo2wQU9tVyzp/NY
         OWYGq2o4xc7czvdiWtDcqLgoXivT4AChq4M0YqOMi5RXOQ5sZ6CyhsZaVmJ8x1TWYS5S
         Irt6dVQbOOEFBP1he4J8TmYG55vpikU0pppjcLhzJUPVINMlvTvYA0L0cZd4cRqhqGD7
         WF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aJdy4Vc+2i7MVFq5AwmxIGlmluiA2uKFXYF4yxPWA3k=;
        b=y4fQWgLLs68saMej040huk5Erj0i++r7v6mncFUO13lq22l3Z/sM6e+3YcxnporyL0
         6vkVyyOWcr0zEVJCL7dIjNAvSZEGXm7Gn3RWUXvQdcTaYaCtm1Q3iG0hOQnXTb5ewsrF
         OM5fQpsh/bnqs6z2AfRXdH2UbJE2+yx9IHtJX6PqapKh1MVV5BfMSb5toVzQv5UIN8IG
         NS7xw8DxtC6MiUNLBQLmi+FArM6gIMt43DnrMuDTB/jhtgDCdLArXHBrakmdOZq/DGm/
         Z/kH73gjnnDFokk57Kwj1DHkJGXITNraW+bSS2G87tqAiUbA5hzFPQ1y8SPoDZdIFhE4
         3Mdg==
X-Gm-Message-State: AOAM5335khWB6xLZv6hwzjtX9nKtanKZhFujl4u6T9yiLjkuq4kyELLO
        yypbMkZFZMPZZAmOkxkoQSX43VfirBy8F8dlfp4=
X-Google-Smtp-Source: ABdhPJxOXDyMm2E9v4ooUA8PevdQusz3K/Gvvk6H/GBdRD2sHCc8QDJKva4YpelLW/O5Fr+liNm0Zg==
X-Received: by 2002:a63:3c5e:: with SMTP id i30mr1564473pgn.397.1641377784410;
        Wed, 05 Jan 2022 02:16:24 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id y27sm47044320pfa.12.2022.01.05.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 02:16:24 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Rob Clark <robdclark@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu: Add missing pm_runtime_disable() in qcom_iommu_device_probe
Date:   Wed,  5 Jan 2022 10:16:19 +0000
Message-Id: <20220105101619.29108-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().
Add missing pm_runtime_disable() for error handling.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index b91874cb6cf3..2f227bc88bd9 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -827,20 +827,20 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	ret = devm_of_platform_populate(dev);
 	if (ret) {
 		dev_err(dev, "Failed to populate iommu contexts\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = iommu_device_sysfs_add(&qcom_iommu->iommu, dev, NULL,
 				     dev_name(dev));
 	if (ret) {
 		dev_err(dev, "Failed to register iommu in sysfs\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
@@ -852,6 +852,10 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+	return ret;
 }
 
 static int qcom_iommu_device_remove(struct platform_device *pdev)
-- 
2.17.1

