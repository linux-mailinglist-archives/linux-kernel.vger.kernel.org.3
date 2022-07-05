Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C51567553
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiGERJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiGERJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:09:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C18271F60F;
        Tue,  5 Jul 2022 10:09:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9F1C1595;
        Tue,  5 Jul 2022 10:09:06 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DABC03F66F;
        Tue,  5 Jul 2022 10:09:04 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/15] iommu/tegra-smmu: Clean up bus_set_iommu()
Date:   Tue,  5 Jul 2022 18:08:36 +0100
Message-Id: <226d48b93ae94947630ecc237d399f6e2efed0ee.1657034828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
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

v3: No change

 drivers/iommu/tegra-smmu.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1fea68e551f1..2e4d2e4c65bb 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1086,8 +1086,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 
 	/*
 	 * This is a bit of a hack. Ideally we'd want to simply return this
-	 * value. However the IOMMU registration process will attempt to add
-	 * all devices to the IOMMU when bus_set_iommu() is called. In order
+	 * value. However iommu_device_register() will attempt to add
+	 * all devices to the IOMMU before we get that far. In order
 	 * not to rely on global variables to track the IOMMU instance, we
 	 * set it here so that it can be looked up from the .probe_device()
 	 * callback via the IOMMU device's .drvdata field.
@@ -1141,32 +1141,15 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
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

