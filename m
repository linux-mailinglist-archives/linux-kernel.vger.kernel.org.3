Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343FC4DAEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355310AbiCPL1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345749AbiCPL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:27:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F2AB652DD;
        Wed, 16 Mar 2022 04:25:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEE0B1515;
        Wed, 16 Mar 2022 04:25:55 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CC4C3F85F;
        Wed, 16 Mar 2022 04:25:54 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
        hch@lst.de
Subject: [PATCH] thunderbolt: Stop using iommu_present()
Date:   Wed, 16 Mar 2022 11:25:51 +0000
Message-Id: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if an IOMMU might be present for some PCI segment in the system,
that doesn't necessarily mean it provides translation for the device
we care about. Furthermore, the presence or not of one firmware flag
doesn't imply anything about the IOMMU driver's behaviour, which may
still depend on other firmware properties and kernel options too. What
actually matters is whether an IOMMU is enforcing protection for our
device - regardless of whether that stemmed from firmware policy, kernel
config, or user control - at the point we need to decide whether to
authorise it. We can ascertain that generically by simply looking at
whether we're currently attached to a translation domain or not.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

I don't have the means to test this, but I'm at least 80% confident
in my unpicking of the structures to retrieve the correct device...

 drivers/thunderbolt/domain.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 7018d959f775..5f5fc5f6a09b 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -257,13 +257,14 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
+	struct tb *tb = container_of(dev, struct tb, dev);
+	struct iommu_domain *iod = iommu_get_domain_for_dev(&tb->nhi->pdev->dev);
 	/*
 	 * Kernel DMA protection is a feature where Thunderbolt security is
 	 * handled natively using IOMMU. It is enabled when IOMMU is
-	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
+	 * enabled and actively enforcing translation.
 	 */
-	return sprintf(buf, "%d\n",
-		       iommu_present(&pci_bus_type) && dmar_platform_optin());
+	return sprintf(buf, "%d\n", iod && iod->type != IOMMU_DOMAIN_IDENTITY);
 }
 static DEVICE_ATTR_RO(iommu_dma_protection);
 
-- 
2.28.0.dirty

