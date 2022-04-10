Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873444FAD3B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiDJK3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiDJK32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:29:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FA963BF8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649586437; x=1681122437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LHaBLkL3Fo7QvrYk2jmT/lCRBzU7VriX7ll+JAWuTbk=;
  b=lkkR4JP6I7Io9AEdIPBQG7UjupGyuu/2qp+Ek6C7z1XyFeZ69wHzOuWd
   i2NZPVVKYvxQVp+aaF8LTZZWL/sxmR8+rpci9NeUMRwVFFOmqmJCN/Muc
   N8fSxsSE+db3KGi+vheN/0QKZn+qXtMJ++9XHrWjhXuTVsh3bRQ18xjoK
   RsAcOv7l5KUAHr2ps+FnH+W7ZXJzwrxmV23HojNc6OMZOz6uvff1cVjCh
   MSx/hJuX8RDy9j2AoFpyovycMHAGFdajeYGHbjjgIe1czaP5ll57MZ7qQ
   JaOGp6l1yWoalHh1PN8wxwZbbwbKJYCXxinoC0gMuOSKQV1OcWDInF/bK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="286962888"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="286962888"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 03:27:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="699019590"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 03:27:12 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable singleton group
Date:   Sun, 10 Apr 2022 18:24:33 +0800
Message-Id: <20220410102443.294128-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410102443.294128-1-baolu.lu@linux.intel.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some features require that a single device must be immutably isolated,
even when hot plug is supported. For example, the SVA bind()/unbind()
interfaces require that the device exists in a singleton group. If we
have a singleton group that doesn't have ACS (or similar technologies)
and someone hotplugs in another device on a bridge, then our SVA is
completely broken and we get data corruption.

This adds a flag in the iommu_group struct to indicate an immutable
singleton group, and uses standard PCI bus topology, isolation features,
and DMA alias quirks to set the flag. If the device came from DT, assume
it is static and then the singleton attribute can know from the device
count in the group.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 67 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c42ece25854..56ffbf5fdc18 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -48,6 +48,7 @@ struct iommu_group {
 	struct list_head entry;
 	unsigned int owner_cnt;
 	void *owner;
+	bool immutable_singleton;
 };
 
 struct group_device {
@@ -74,6 +75,16 @@ static const char * const iommu_group_resv_type_string[] = {
 #define IOMMU_CMD_LINE_DMA_API		BIT(0)
 #define IOMMU_CMD_LINE_STRICT		BIT(1)
 
+/*
+ * To consider a PCI device isolated, we require ACS to support Source
+ * Validation, Request Redirection, Completer Redirection, and Upstream
+ * Forwarding.  This effectively means that devices cannot spoof their
+ * requester ID, requests and completions cannot be redirected, and all
+ * transactions are forwarded upstream, even as it passes through a
+ * bridge where the target device is downstream.
+ */
+#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
+
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
@@ -89,6 +100,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
+static int iommu_group_device_count(struct iommu_group *group);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -844,6 +856,37 @@ static bool iommu_is_attach_deferred(struct device *dev)
 	return false;
 }
 
+static int has_pci_alias(struct pci_dev *pdev, u16 alias, void *opaque)
+{
+	return -EEXIST;
+}
+
+static bool pci_immutably_isolated(struct pci_dev *pdev)
+{
+	/* Skip the bridges. */
+	if (pci_is_bridge(pdev))
+		return false;
+
+	/*
+	 * The device could be considered to be fully isolated if
+	 * all devices on the path from the parent to the host-PCI
+	 * bridge are protected from peer-to-peer DMA by ACS.
+	 */
+	if (!pci_is_root_bus(pdev->bus) &&
+	    !pci_acs_path_enabled(pdev->bus->self, NULL, REQ_ACS_FLAGS))
+		return false;
+
+	/* Multi-function devices should have ACS enabled. */
+	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
+		return false;
+
+	/* Filter out devices which has any alias device. */
+	if (pci_for_each_dma_alias(pdev, has_pci_alias, NULL))
+		return false;
+
+	return true;
+}
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
@@ -898,6 +941,20 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain  && !iommu_is_attach_deferred(dev))
 		ret = __iommu_attach_device(group->domain, dev);
+
+	/*
+	 * Use standard PCI bus topology, isolation features, and DMA
+	 * alias quirks to set the immutable singleton attribute. If
+	 * the device came from DT, assume it is static and then
+	 * singleton can know from the device count in the group.
+	 */
+	if (dev_is_pci(dev))
+		group->immutable_singleton =
+				pci_immutably_isolated(to_pci_dev(dev));
+	else if (is_of_node(dev_fwnode(dev)))
+		group->immutable_singleton =
+				(iommu_group_device_count(group) == 1);
+
 	mutex_unlock(&group->mutex);
 	if (ret)
 		goto err_put_group;
@@ -1290,16 +1347,6 @@ EXPORT_SYMBOL_GPL(iommu_group_id);
 static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 					       unsigned long *devfns);
 
-/*
- * To consider a PCI device isolated, we require ACS to support Source
- * Validation, Request Redirection, Completer Redirection, and Upstream
- * Forwarding.  This effectively means that devices cannot spoof their
- * requester ID, requests and completions cannot be redirected, and all
- * transactions are forwarded upstream, even as it passes through a
- * bridge where the target device is downstream.
- */
-#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
-
 /*
  * For multifunction devices which are not isolated from each other, find
  * all the other non-isolated functions and look for existing groups.  For
-- 
2.25.1

