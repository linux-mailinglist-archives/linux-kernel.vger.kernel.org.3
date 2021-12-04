Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E95946881D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhLDWgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLDWgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:36:35 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17BBC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 14:33:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 13so13272395ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 14:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JcR/1TkvkZEzS/XW2AKnFEClRR66tq7M2hycKAeV9lk=;
        b=qyVf/zAn7iCw2B5P/SI7zem1gA4GDvMO8nsQdDYe0OhvMrS0sp3V8eVaWv2JvJFUKD
         9DTRSHVWIP8AycZZMu/lzhppacy6YDwbCKOVEuc1PdndsoOctwvb5UABLpwf3OA7PvkI
         RjTFhUUNTdEh4UuxJ0zEzwYHWT0k6wBS1ry1IDG6xSLpgif16vqVuhvCImbm6hRoZwsr
         dQaQ1tsoDNHwtVk2VaFV2FS+Sko4ti3psW+lHOwwXWGg0SWSyaD6o0QPwG1/fYjbES3Z
         HZWmpQMDqJcwlv65Z0t2iIwlxmGGkx5ePlzvj4IO2bI1VSRjJr0lX2qPlH+uPdjwncMj
         uKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JcR/1TkvkZEzS/XW2AKnFEClRR66tq7M2hycKAeV9lk=;
        b=GmpRdUoxUOE6a5kEkD8hAehY45ov9qSFYDRx7Aj1tal84FphVgxMj4cXqTjL8n8632
         argQtI4emORXsNS9nxQKQATTqSwzPfR2Rtp124ge7EIqgHZ27Eq9kdUtjwJIW4AzLVk9
         /C5dAaS9wwTTBgjxDcq/EaLSFfA+EdYCrMwfTkuPjgLQ0SqFGjprC6ZpFz3m6Igq5I5I
         im9gn4wIZhSAitnOzpCf8hwnUAkfY2okdlXxmeQr5/qnEIMixTHM2yDY17RoHvugBnzx
         BXnG7x4M+q0JrZ/4Tpq1/sexbinFxCUHl6B/EvD5zNCzBzdRu4dL5hlOYbPopk3afI6N
         LkJA==
X-Gm-Message-State: AOAM530ogP88mXaTMdRkmfIBtUPLzEoIqZObyJml52Bc/RsIZGx5p/zk
        rUFuR6Q8dvZC8ZZvNgpm/ds=
X-Google-Smtp-Source: ABdhPJxDC9IzaaRdBdaUhhcLV9tTL5ss7E0UuFEqJAXk8UPPOqTIYFZ5WD9J93rz8GwUd8Ek6nJgng==
X-Received: by 2002:a2e:b711:: with SMTP id j17mr27964564ljo.39.1638657186996;
        Sat, 04 Dec 2021 14:33:06 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id h1sm886834lfp.249.2021.12.04.14.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 14:33:06 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops
Date:   Sat,  4 Dec 2021 23:33:01 +0100
Message-Id: <20211204223301.100649-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of arm_smmu_mmu_notifier_ops is to assign its address to
the ops field in the mmu_notifier struct, which is a pointer to const
struct mmu_notifier_ops. Make it const to allow the compiler to put it
in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index ee66d1f4cb81..a737ba5f727e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -220,7 +220,7 @@ static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 	kfree(mn_to_smmu(mn));
 }
 
-static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
+static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
 	.invalidate_range	= arm_smmu_mm_invalidate_range,
 	.release		= arm_smmu_mm_release,
 	.free_notifier		= arm_smmu_mmu_notifier_free,
-- 
2.34.1

