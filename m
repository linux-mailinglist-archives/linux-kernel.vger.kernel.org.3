Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF4E575381
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbiGNQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbiGNQz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:55:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9084F6B8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:55:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a5so3334272wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2fOwRS7PBfoQ/JKwgWoKuZEaYFo7PU9A3pBuSjiPrw=;
        b=FJYTZoClCTlgrArGKeLYT8JUYfT6a60vzX4X3MgwAp51q4tyoTeo+z3gFLcTsZ2bEo
         j5hT5ULynZb3pQJxareXMpi7f4RSaQGIqIRmviSi/4Xus+TNZzAs7hp452FuzBLFcg7w
         ywRqEzWxw2c5kKbfm7iRwREbZpU/D9Jbff+gcPJmQI20iQSSqv+5mKOSIMME1uH6Csqf
         4IHfl34HFOIAJvzJabWhKe77UZiHWzC+CtPvYvqQXckMhS4zPEQZF4UX1Zw1vDU0/CAt
         dPiIkVHGtob3+NZ66Xeonz4SYNmBVvCx8iC2hnD+CoOV7FIha5uMQbJ52A7oHmZvbs3I
         60LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2fOwRS7PBfoQ/JKwgWoKuZEaYFo7PU9A3pBuSjiPrw=;
        b=xedD29cWNs8NAd4978CAbO+8Blpjn32Guf4F3vfAhqten/Rhob/5oumjQQaI9Vn3vm
         tKXQqx3SL3iwaISWUZsNu89vPAnajLsoD2EwNHEuySzlY7ZHcwko5uApdukatozkK9Ql
         qadA9Y62xOp0pBkCO0tsD0426HqG3s5lh/I0aKFGBxln8oMEzxidAVp/ntorFoXzqcxz
         fddM4dinf4mN2hNx72v1j+DR7Xa3bi0hT8BGNnMShkKe7Pq6ULFzvk8ubTxi8Y3AXPCx
         f6JaKN4+vULr0yJgC/kRLKIPfP3IfgczPDIQhy77CVVVuVM+Oi0hgVC5L/puTZH5K1qv
         8r3A==
X-Gm-Message-State: AJIora+7yDnfSH4rsrb+xwKMYBrgNV8Ss1+/A5ldl8fgdwdJbR5TTXzv
        4yscl2EkUc1gq4wSc2ACME3OWQ==
X-Google-Smtp-Source: AGRyM1uOCE0ebi2E5Ao34myU6FQDDLS+28S7amW2//dWGnRsQjZ0isNECaLLQ5j97W3z0Vyo//ZQ7g==
X-Received: by 2002:a5d:6489:0:b0:21d:a9a1:3511 with SMTP id o9-20020a5d6489000000b0021da9a13511mr8725414wri.626.1657817754857;
        Thu, 14 Jul 2022 09:55:54 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id z8-20020a1c4c08000000b003942a244f40sm5706762wmf.25.2022.07.14.09.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:55:54 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] iommu/exynos: Handle failed IOMMU device registration properly
Date:   Thu, 14 Jul 2022 19:55:46 +0300
Message-Id: <20220714165550.8884-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714165550.8884-1-semen.protsenko@linaro.org>
References: <20220714165550.8884-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If iommu_device_register() fails in exynos_sysmmu_probe(), the previous
calls have to be cleaned up. In this case, the iommu_device_sysfs_add()
should be cleaned up, by calling its remove counterpart call.

Fixes: d2c302b6e8b1 ("iommu/exynos: Make use of iommu_device_register interface")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Changes in v3:
  - Added Marek's Acked-by tag
  - Added Krzysztof's R-b tag
  - Added "Fixes" tag, as suggested by Krzysztof

Changes in v2:
  - (none) This patch is new and added in v2

 drivers/iommu/exynos-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8f80aaa35092..c85db9dab851 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -629,7 +629,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
 	if (ret)
-		return ret;
+		goto err_iommu_register;
 
 	platform_set_drvdata(pdev, data);
 
@@ -656,6 +656,10 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	return 0;
+
+err_iommu_register:
+	iommu_device_sysfs_remove(&data->iommu);
+	return ret;
 }
 
 static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
-- 
2.30.2

