Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E88A4C01AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiBVSyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbiBVSyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:54:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EE913A1DB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645556065; x=1677092065;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=oaMfgQdcTHgSG9PJV6HqTAIJsJi+MkXGCe+Nq5OSzjw=;
  b=Fv3Uw8egvoIhDiu0mxj3n2D3UF+S13abveoV5GDwRmcisUVic8D1pnsp
   FBQJfsktMMVU7uwKekkjdpHfUQLeKBO0jzs6aHaqgQIPrtktjgFChJFg6
   j06hKFmxGniQPHFuO0EF+cSkyLF75ZqdIZQCMmtbwdGE/ZXTjZLhG91NW
   ihIz4Pjqd+00UyzAvBWkyw9zA97PFM4S5XqP3AQ+xXCdsNuXVorAqC7m4
   kSGHDvAc+jYoAc5xyKdUkS/oMJg0LkTApwh3x+hPpaC9cUmWfQz0FQ6eS
   PSTklGPmqm1sKAEg1AT7DBK88nDAGDtopW+nVmias+4Re13onMf6uUryY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="315012967"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="315012967"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:54:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="508105491"
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
Subject: =?UTF-8?q?=5BPATCH=20v2=C2=A0=201/2=5D=20iommu/vt-d=3A=20Enable=20ATS=20for=20the=20devices=20in=20SATC=20table?=
Date:   Tue, 22 Feb 2022 10:54:15 -0800
Message-Id: <20220222185416.1722611-2-yian.chen@intel.com>
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
 drivers/iommu/intel/iommu.c | 42 +++++++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h |  2 +-
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..aa0b27b5bf83 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2684,7 +2684,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
-		    dmar_find_matched_atsr_unit(pdev))
+		    dmar_ats_supported(pdev, iommu))
 			info->ats_supported = 1;
 
 		if (sm_supported(iommu)) {
@@ -4020,7 +4020,31 @@ static void intel_iommu_free_dmars(void)
 	}
 }
 
-int dmar_find_matched_atsr_unit(struct pci_dev *dev)
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
+int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 {
 	int i, ret = 1;
 	struct pci_bus *bus;
@@ -4028,8 +4052,22 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
 	struct device *tmp;
 	struct acpi_dmar_atsr *atsr;
 	struct dmar_atsr_unit *atsru;
+	struct dmar_satc_unit *satcu;
 
 	dev = pci_physfn(dev);
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

