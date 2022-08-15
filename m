Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402A9593308
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiHOQWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiHOQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31AFB1CB32
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEE501D34;
        Mon, 15 Aug 2022 09:20:46 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A61A73F70D;
        Mon, 15 Aug 2022 09:20:44 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/16] iommu/tegra-smmu: Clean up bus_set_iommu()
Date:   Mon, 15 Aug 2022 17:20:15 +0100
Message-Id: <13bb6baa6c4d74e95a12529e4eb1ddfb3885c3b5.1660572783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1660572783.git.robin.murphy@arm.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop calling bus_set_iommu() since it's now unnecessary, and simplify
the probe failure path accordingly.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 drivers/iommu/tegra-smmu.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2a8de975fe63..5b1af40221ec 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1083,8 +1083,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 
 	/*
 	 * This is a bit of a hack. Ideally we'd want to simply return this
-	 * value. However the IOMMU registration process will attempt to add
-	 * all devices to the IOMMU when bus_set_iommu() is called. In order
+	 * value. However iommu_device_register() will attempt to add
+	 * all devices to the IOMMU before we get that far. In order
 	 * not to rely on global variables to track the IOMMU instance, we
 	 * set it here so that it can be looked up from the .probe_device()
 	 * callback via the IOMMU device's .drvdata field.
@@ -1138,32 +1138,15 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 		return ERR_PTR(err);
 
 	err = iommu_device_register(&smmu->iommu, &tegra_smmu_ops, dev);
-	if (err)
-		goto remove_sysfs;
-
-	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
-	if (err < 0)
-		goto unregister;
-
-#ifdef CONFIG_PCI
-	err = bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
-	if (err < 0)
-		goto unset_platform_bus;
-#endif
+	if (err) {
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return ERR_PTR(err);
+	}
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_init(smmu);
 
 	return smmu;
-
-unset_platform_bus: __maybe_unused;
-	bus_set_iommu(&platform_bus_type, NULL);
-unregister:
-	iommu_device_unregister(&smmu->iommu);
-remove_sysfs:
-	iommu_device_sysfs_remove(&smmu->iommu);
-
-	return ERR_PTR(err);
 }
 
 void tegra_smmu_remove(struct tegra_smmu *smmu)
-- 
2.36.1.dirty

