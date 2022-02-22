Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E544C01B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiBVSy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiBVSyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:54:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBC1375A3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645556066; x=1677092066;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0eEVoBEoLghU3hLOEP5nLnPp5kV4RYKvZKL/+tFfRYo=;
  b=WrTPSbZ3OO/mteNfRkVhONFABvB5przgO0qUuOltYgsKjdDy4/TxjonH
   DzaP5ZHXrXGZTglpxXEAWaW+gezJ097Kh2EnHnnathApNQZ4pjNJAcJ0W
   CUEpATGa+yxHLhf4L7a3ighnRJU59cFEAsFKMlZJ9MOvAMafpweg+s7Gy
   pQO7/sYGfUeimfGogZrW53CIaxbG4LFxaZQovYSTTu58SNpXfl+5b+aZj
   ZAfhN0Gmc8t7r4g0EZoIvY4Q6LxrE8k3nJwnJ/OqP6cbvfIPL150Jhfm4
   pkOtieoC2nOn4gYQcab3ucagDU7+2GUGnsrhno5+Y6I0nrkIWLYSuEjQO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="315012968"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="315012968"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:54:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="508105495"
Received: from oux.sc.intel.com ([10.3.52.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:54:24 -0800
From:   Yian Chen <yian.chen@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Yian Chen <yian.chen@intel.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=C2=A0=202/2=5D=20iommu/vt-d=3A=20Declare=20dmar=5Fats=5Fsupported=28=29=20as=20static=20function?=
Date:   Tue, 22 Feb 2022 10:54:16 -0800
Message-Id: <20220222185416.1722611-3-yian.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222185416.1722611-1-yian.chen@intel.com>
References: <20220222185416.1722611-1-yian.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmar_ats_supported() is defined in and only used by iommu.c
so that declare it as a static function and move the
code accordingly.

Signed-off-by: Yian Chen <yian.chen@intel.com>
---
 drivers/iommu/intel/iommu.c | 164 ++++++++++++++++++------------------
 include/linux/intel-iommu.h |   1 -
 2 files changed, 82 insertions(+), 83 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index aa0b27b5bf83..eaf9764c476d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2643,6 +2643,88 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
+static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
+{
+	int i;
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
+			if (to_pci_dev(tmp) == dev)
+				goto out;
+	}
+	satcu = NULL;
+out:
+	rcu_read_unlock();
+	return satcu;
+}
+
+static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
+{
+	int i, ret = 1;
+	struct pci_bus *bus;
+	struct pci_dev *bridge = NULL;
+	struct device *tmp;
+	struct acpi_dmar_atsr *atsr;
+	struct dmar_atsr_unit *atsru;
+	struct dmar_satc_unit *satcu;
+
+	dev = pci_physfn(dev);
+	satcu = dmar_find_matched_satc_unit(dev);
+	if (satcu) {
+		/* This dev supports ATS as it is in SATC table!
+		 * When IOMMU is in legacy mode, enabling ATS is done
+		 * automatically by HW for the device that requires
+		 * ATS, hence OS should not enable this device ATS
+		 * to avoid duplicated TLB invalidation
+		 */
+		if (satcu->atc_required && !sm_supported(iommu))
+			ret = 0;
+		return ret;
+	}
+
+	for (bus = dev->bus; bus; bus = bus->parent) {
+		bridge = bus->self;
+		/* If it's an integrated device, allow ATS */
+		if (!bridge)
+			return 1;
+		/* Connected via non-PCIe: no ATS */
+		if (!pci_is_pcie(bridge) ||
+		    pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)
+			return 0;
+		/* If we found the root port, look it up in the ATSR */
+		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
+			break;
+	}
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list) {
+		atsr = container_of(atsru->hdr, struct acpi_dmar_atsr, header);
+		if (atsr->segment != pci_domain_nr(dev->bus))
+			continue;
+
+		for_each_dev_scope(atsru->devices, atsru->devices_cnt, i, tmp)
+			if (tmp == &bridge->dev)
+				goto out;
+
+		if (atsru->include_all)
+			goto out;
+	}
+	ret = 0;
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    int bus, int devfn,
 						    struct device *dev,
@@ -4020,88 +4102,6 @@ static void intel_iommu_free_dmars(void)
 	}
 }
 
-static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
-{
-	int i;
-	struct device *tmp;
-	struct dmar_satc_unit *satcu;
-	struct acpi_dmar_satc *satc;
-
-	dev = pci_physfn(dev);
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
-		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
-		if (satc->segment != pci_domain_nr(dev->bus))
-			continue;
-		for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
-			if (to_pci_dev(tmp) == dev)
-				goto out;
-	}
-	satcu = NULL;
-out:
-	rcu_read_unlock();
-	return satcu;
-}
-
-int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
-{
-	int i, ret = 1;
-	struct pci_bus *bus;
-	struct pci_dev *bridge = NULL;
-	struct device *tmp;
-	struct acpi_dmar_atsr *atsr;
-	struct dmar_atsr_unit *atsru;
-	struct dmar_satc_unit *satcu;
-
-	dev = pci_physfn(dev);
-	satcu = dmar_find_matched_satc_unit(dev);
-	if (satcu) {
-		/* This dev supports ATS as it is in SATC table!
-		 * When IOMMU is in legacy mode, enabling ATS is done
-		 * automatically by HW for the device that requires
-		 * ATS, hence OS should not enable this device ATS
-		 * to avoid duplicated TLB invalidation
-		 */
-		if (satcu->atc_required && !sm_supported(iommu))
-			ret = 0;
-		return ret;
-	}
-
-	for (bus = dev->bus; bus; bus = bus->parent) {
-		bridge = bus->self;
-		/* If it's an integrated device, allow ATS */
-		if (!bridge)
-			return 1;
-		/* Connected via non-PCIe: no ATS */
-		if (!pci_is_pcie(bridge) ||
-		    pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)
-			return 0;
-		/* If we found the root port, look it up in the ATSR */
-		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
-			break;
-	}
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list) {
-		atsr = container_of(atsru->hdr, struct acpi_dmar_atsr, header);
-		if (atsr->segment != pci_domain_nr(dev->bus))
-			continue;
-
-		for_each_dev_scope(atsru->devices, atsru->devices_cnt, i, tmp)
-			if (tmp == &bridge->dev)
-				goto out;
-
-		if (atsru->include_all)
-			goto out;
-	}
-	ret = 0;
-out:
-	rcu_read_unlock();
-
-	return ret;
-}
-
 int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 {
 	int ret;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fe9fd417d611..9262cdf04f05 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -717,7 +717,6 @@ static inline int nr_pte_to_next_page(struct dma_pte *pte)
 }
 
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
-extern int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu);
 
 extern int dmar_enable_qi(struct intel_iommu *iommu);
 extern void dmar_disable_qi(struct intel_iommu *iommu);
-- 
2.25.1

