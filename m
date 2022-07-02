Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6AB5642E7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiGBVhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiGBVh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:37:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C0B855
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 14:37:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so9995202ejj.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWfZE2YpB25R+rCMwVNZi2s9IwZn0JfO+IgsGnjhYqY=;
        b=wVSILGBGUjVOC+cfuxxbSMyxpvn6GttZQpREPJStje8Jo1kxV0hOiJBQjYgcMjnGO8
         HzrlHKacg6/F0WF0UTTYxmtVqmcttqofFOrJX6K+BP9MvvRdIR7qYrVcD7+DFCx3EKT0
         v7Hte9vIx/BKEL3aPNq1az2t5Nf5ERiriNAhe4KwSJOAyDfa58FaLw+AHHh0SnQeL6jn
         UMtj1LphcAYF+SCg6rTx11cw/9TDH61FUx3QLb2jvIAt9clvxCy6iYOFU5DZ9Kgf8G9u
         J/kArGjS3bdmqxj4yPJLCgNcdbkBX/TWXfqGZSQ3YUT28PeuTlKYSuvKmAr01wazLM4f
         ZKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWfZE2YpB25R+rCMwVNZi2s9IwZn0JfO+IgsGnjhYqY=;
        b=7oaui6cSdA5DKF2Q0F9mOwJBxdAbB7+i0e9jSppl6GN6weIqfbWDCb9intVljHK3W0
         hEg3tufJN5+HfIt5HBxHgi3yb4dzmGi72nkpX7an4xPsszei5P4XlSYa8jT37XiUZi8g
         aFXd7YkA7LoJLMZdbNmzOmsEaAlnL4bvzjqfgXd4BuRe4xNJz1t/SG7fCmbQFXuAg1/A
         L8T6C1hOsiD5sjS6veMLLic8vBghHkPtdSk3K39/DhLZtHr51Id+SDnIO5ikUIW2O+Z1
         pVEDDEnuKuy1YObd0fXc0hhZI6HzlbRcj2QG1A4vScLaK5FmfHrU6unUs+INg89jHfz5
         oOWw==
X-Gm-Message-State: AJIora+pnsVZpd9kVApChOwqJMqn/utH+kzg79/MCKVNYrCsv+gngo9d
        CCHLRSbrZtt2upZ3LjPRB5QDwQ==
X-Google-Smtp-Source: AGRyM1sjE5ZjIaY+GfCnbQmj6BkapC2AnzQE+mzuISXF0GaEPi7w7Vucxh56Irz739GXVnorjZvvIA==
X-Received: by 2002:a17:906:1018:b0:718:dd3f:f28c with SMTP id 24-20020a170906101800b00718dd3ff28cmr21490786ejm.55.1656797846558;
        Sat, 02 Jul 2022 14:37:26 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906671200b00718e4e64b7bsm12214247ejp.79.2022.07.02.14.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:37:26 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/exynos: Set correct dma mask for SysMMU v5+
Date:   Sun,  3 Jul 2022 00:37:21 +0300
Message-Id: <20220702213724.3949-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220702213724.3949-1-semen.protsenko@linaro.org>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
mask to avoid falling back to SWTLBIO usage in dma_map_single() because
of failed dma_capable() check.

The original code for this fix was suggested by Marek.

Originally-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 71f2018e23fe..28f8c8d93aa3 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -647,6 +647,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (MMU_MAJ_VER(data->version) >= 5) {
+		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
+		if (ret) {
+			dev_err(dev, "Unable to set DMA mask: %d\n", ret);
+			return ret;
+		}
+	}
+
 	/*
 	 * use the first registered sysmmu device for performing
 	 * dma mapping operations on iommu page tables (cpu cache flush)
-- 
2.30.2

