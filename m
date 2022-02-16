Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051BE4B9147
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiBPTgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:36:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiBPTga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:36:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3810291FAE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645040177; x=1676576177;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5szMQlEDye63aiiwYqhef/hAzPhF9F7nlQ69TY5qzo0=;
  b=Q8dIEuRKVJZr3/c/x3t2QaCssnt1VelOVfsCUBc3qxjwkGB5jmJHonBF
   vRxmlx2MsvMXgtbpenP+N6zhFZ34h2iU1lsWiv9t5ABe5GNX9klgfviV7
   aQtFYWpsR+c17itwvlEEPHYBCwccHTOl+ptYhIbjNMKGS+Q5MX3Siooq2
   BcqvALbQHwoguBlneUG2QEck4QlHgxo7uI4zDdYyKsD5CiIH+UPyS0xrP
   9h+r8B7nattM5pS1qSVFqKoB9WMdAFczojZ0MB0gRDunQdyvcsRDvqMxT
   IJ3giVJDPE6ORQyNf8IKSqonccysMortzw89n35p51dbMYEbpNT/5DV+e
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="275290469"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="275290469"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:36:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="529669418"
Received: from oux.sc.intel.com ([10.3.52.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:36:17 -0800
From:   Yian Chen <yian.chen@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Yian Chen <yian.chen@intel.com>
Subject: [PATCH] iommu/vt-d: Enable ATS for the devices in SATC table
Date:   Wed, 16 Feb 2022 11:36:09 -0800
Message-Id: <20220216193609.686107-1-yian.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from Intel VT-d v3.2, Intel platform BIOS can provide
additional SATC table structure. SATC table includes a list of
SoC integrated devices that support ATC (Address translation
cache).

Enabling ATC (via ATS capability) can be a functional requirement
for SATC device operation or an optional to enhance device
performance/functionality. This is determined by the bit of
ATC_REQUIRED in SATC table. When IOMMU is working in scalable
mode, software chooses to always enable ATS for every device in
SATC table because Intel SoC devices in SATC table are trusted
to use ATS.

On the other hand, if IOMMU is in legacy mode, ATS of SATC
capable devices can work transparently to software and be
automatically enabled by IOMMU hardware. As the result,
there is no need for software to enable ATS on these devices.

Signed-off-by: Yian Chen <yian.chen@intel.com>
---
 drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++++++++++---
 include/linux/intel-iommu.h |  2 +-
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..58a80cec50bb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -872,7 +872,6 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
 
 	return false;
 }
-
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 {
 	struct dmar_drhd_unit *drhd = NULL;
@@ -2684,7 +2683,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
-		    dmar_find_matched_atsr_unit(pdev))
+		    dmar_ats_supported(pdev, iommu))
 			info->ats_supported = 1;
 
 		if (sm_supported(iommu)) {
@@ -4020,7 +4019,42 @@ static void intel_iommu_free_dmars(void)
 	}
 }
 
-int dmar_find_matched_atsr_unit(struct pci_dev *dev)
+/* dev_satc_state - Find if dev is in a DMAR SATC table
+ *
+ * return value:
+ *    1: dev is in STAC table and ATS is required
+ *    0: dev is in SATC table and ATS is optional
+ *    -1: dev isn't in SATC table
+ */
+static int dev_satc_state(struct pci_dev *dev)
+{
+	int i, ret = -1;
+	struct device *tmp;
+	struct dmar_satc_unit *satcu;
+	struct acpi_dmar_satc *satc;
+
+	dev = pci_physfn(dev);
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
+		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
+		if (satc->segment != pci_domain_nr(dev->bus))
+			continue;
+		for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
+			if (to_pci_dev(tmp) == dev) {
+				if (satc->flags)
+					ret = 1;
+				else
+					ret = 0;
+				goto out;
+			}
+	}
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 {
 	int i, ret = 1;
 	struct pci_bus *bus;
@@ -4030,6 +4064,19 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
 	struct dmar_atsr_unit *atsru;
 
 	dev = pci_physfn(dev);
+	i = dev_satc_state(dev);
+	if (i >= 0) {
+		/* This dev supports ATS as it is in SATC table!
+		 * When IOMMU is in legacy mode, enabling ATS is done
+		 * automatically by HW for the device that requires
+		 * ATS, hence OS should not enable this device ATS
+		 * to avoid duplicated TLB invalidation
+		 */
+		if (i && !sm_supported(iommu))
+			ret = 0;
+		return ret;
+	}
+
 	for (bus = dev->bus; bus; bus = bus->parent) {
 		bridge = bus->self;
 		/* If it's an integrated device, allow ATS */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 69230fd695ea..fe9fd417d611 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -717,7 +717,7 @@ static inline int nr_pte_to_next_page(struct dma_pte *pte)
 }
 
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
-extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
+extern int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu);
 
 extern int dmar_enable_qi(struct intel_iommu *iommu);
 extern void dmar_disable_qi(struct intel_iommu *iommu);
-- 
2.25.1

