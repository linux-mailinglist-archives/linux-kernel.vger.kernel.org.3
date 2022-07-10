Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6456D1E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 01:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGJXGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 19:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGJXGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 19:06:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB031261B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so2100436wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eG4cDXpCwPd5e9f6H24dRQy0mExW1bAeq7MJJ7YjfTc=;
        b=vKgGjeledgKSvbyvudX5W+WP80Jb5rPkTbE5n4lbDLPTYE1R3td4O1Fh2SIRlWsChs
         zNTctxShh7Q0kUWdIvbCbYZY/ghIjcQDxK5qWLSBgHWPm4Rq7lhHUI8Qn/0LmLfmZtvf
         PLWzfMbYIvCzuqIyGECbXxu9A7kzHlJTlhGr3okDBUAdxWjXo0WaZ9Ga94A/cNp837TS
         GRkfALXaNHLXDqdxKO9Ky+8WwKvxCSBjLlJuixhEZ8lqjNdhiBSoBY5thpYIwv9vhKCT
         mNXwinWjmp7CAMs7NcESNaD3xu8w/PJ/YkhF3BY7wmXcz9FHZhKivcjVnQQS7lHbSDT6
         pFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eG4cDXpCwPd5e9f6H24dRQy0mExW1bAeq7MJJ7YjfTc=;
        b=yTyPbWl0vpfYwz7VhkHPVXbbhN7/9N2T+tEGRILiiOup/2fHyf1jqeIL2O1xHSXCad
         F6+xRTrlAp9JVa+X58yWNFIb+7AfSdM+nPm/WC/kd9VAVFFQgNjGmgBvPtDxekgIqviS
         69TVaXbuHf0TQvjM70aS20n9AUeBiCXimBu79Mzs/DQrbCKmr1sgQuVHYeB2I02AXd3R
         qNd6wuOFQcvq0hx0PeO8ku5HRxSjhVGnEl3SLyhOeBPfRZRLhSCP1XDJIIVg7H3IkFqj
         9tpKoehAYFt2e7L0AvZMOG2PAmJ7eGpB1DujL5bP3a/ce/h7HbUWfjzzXLspU0z37Y64
         Visg==
X-Gm-Message-State: AJIora++CWy/svtD1/lEiAyXuV8wr3jHgTxsEyWx+HBfsO4u53HnDH3k
        nJ+4lzG61+joPPWEIwVCkOS8CA==
X-Google-Smtp-Source: AGRyM1tn3eeoTDSPR6nUcb7hLnN1jy33xtCICi4w0wZfKNEp3alCe02khff0VldwrNkL1Z8Yh+gQOQ==
X-Received: by 2002:a7b:cb03:0:b0:39e:e826:ce6d with SMTP id u3-20020a7bcb03000000b0039ee826ce6dmr12559153wmj.102.1657494367129;
        Sun, 10 Jul 2022 16:06:07 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003a2cf5eb900sm2687143wmi.40.2022.07.10.16.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:06 -0700 (PDT)
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
Subject: [PATCH v2 2/7] iommu/exynos: Handle failed IOMMU device registration properly
Date:   Mon, 11 Jul 2022 02:05:58 +0300
Message-Id: <20220710230603.13526-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220710230603.13526-1-semen.protsenko@linaro.org>
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
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

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

