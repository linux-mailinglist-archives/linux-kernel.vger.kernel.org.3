Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F434F492F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391472AbiDEWFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357361AbiDELQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:16:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2CE22DAA9;
        Tue,  5 Apr 2022 03:41:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FB7FD6E;
        Tue,  5 Apr 2022 03:41:16 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 180CA3F5A1;
        Tue,  5 Apr 2022 03:41:14 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com, hch@lst.de
Subject: [PATCH v3 3/4] thunderbolt: Make iommu_dma_protection more accurate
Date:   Tue,  5 Apr 2022 11:41:03 +0100
Message-Id: <b1f89ea2ad38221e0b75783357b9afb53087061d.1649089693.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1649089693.git.robin.murphy@arm.com>
References: <cover.1649089693.git.robin.murphy@arm.com>
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

Between me trying to get rid of iommu_present() and Mario wanting to
support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has shown
that the iommu_dma_protection attribute is being far too optimistic.
Even if an IOMMU might be present for some PCI segment in the system,
that doesn't necessarily mean it provides translation for the device(s)
we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
is tell us that memory was protected before the kernel was loaded, and
prevent the user from disabling the intel-iommu driver entirely. While
that lets us assume kernel integrity, what matters for actual runtime
DMA protection is whether we trust individual devices, based on the
"external facing" property that we expect firmware to describe for
Thunderbolt ports.

It's proven challenging to determine the appropriate ports accurately
given the variety of possible topologies, so while still not getting a
perfect answer, by putting enough faith in firmware we can at least get
a good bit closer. If we can see that any device near a Thunderbolt NHI
has all the requisites for Kernel DMA Protection, chances are that it
*is* a relevant port, but moreover that implies that firmware is playing
the game overall, so we'll use that to assume that all Thunderbolt ports
should be correctly marked and thus will end up fully protected.

CC: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Check for correct external_facing property, add debug message.

 drivers/thunderbolt/domain.c | 12 +++-------
 drivers/thunderbolt/nhi.c    | 44 ++++++++++++++++++++++++++++++++++++
 include/linux/thunderbolt.h  |  2 ++
 3 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 7018d959f775..2889a214dadc 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -7,9 +7,7 @@
  */
 
 #include <linux/device.h>
-#include <linux/dmar.h>
 #include <linux/idr.h>
-#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -257,13 +255,9 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	/*
-	 * Kernel DMA protection is a feature where Thunderbolt security is
-	 * handled natively using IOMMU. It is enabled when IOMMU is
-	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
-	 */
-	return sprintf(buf, "%d\n",
-		       iommu_present(&pci_bus_type) && dmar_platform_optin());
+	struct tb *tb = container_of(dev, struct tb, dev);
+
+	return sysfs_emit(buf, "%d\n", tb->nhi->iommu_dma_protection);
 }
 static DEVICE_ATTR_RO(iommu_dma_protection);
 
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 4a582183f675..4bc87b0f003a 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -15,9 +15,11 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/property.h>
+#include <linux/string_helpers.h>
 
 #include "nhi.h"
 #include "nhi_regs.h"
@@ -1103,6 +1105,47 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
 		nhi->quirks |= QUIRK_AUTO_CLEAR_INT;
 }
 
+static int nhi_check_iommu_pdev(struct pci_dev *pdev, void *data)
+{
+	if (!pdev->external_facing ||
+	    !device_iommu_capable(&pdev->dev, IOMMU_CAP_PRE_BOOT_PROTECTION))
+		return 0;
+	*(bool *)data = true;
+	return 1; /* Stop walking */
+}
+
+static void nhi_check_iommu(struct tb_nhi *nhi)
+{
+	struct pci_bus *bus = nhi->pdev->bus;
+	bool port_ok = false;
+
+	/*
+	 * Ideally what we'd do here is grab every PCI device that
+	 * represents a tunnelling adapter for this NHI and check their
+	 * status directly, but unfortunately USB4 seems to make it
+	 * obnoxiously difficult to reliably make any correlation.
+	 *
+	 * So for now we'll have to bodge it... Hoping that the system
+	 * is at least sane enough that an adapter is in the same PCI
+	 * segment as its NHI, if we can find *something* on that segment
+	 * which meets the requirements for Kernel DMA Protection, we'll
+	 * take that to imply that firmware is aware and has (hopefully)
+	 * done the right thing in general. We need to know that the PCI
+	 * layer has seen the ExternalFacingPort property which will then
+	 * inform the IOMMU layer to enforce the complete "untrusted DMA"
+	 * flow, but also that the IOMMU driver itself can be trusted not
+	 * to have been subverted by a pre-boot DMA attack.
+	 */
+	while (bus->parent)
+		bus = bus->parent;
+
+	pci_walk_bus(bus, nhi_check_iommu_pdev, &port_ok);
+
+	nhi->iommu_dma_protection = port_ok;
+	dev_dbg(&nhi->pdev->dev, "IOMMU DMA protection is %s\n",
+		str_enabled_disabled(port_ok));
+}
+
 static int nhi_init_msi(struct tb_nhi *nhi)
 {
 	struct pci_dev *pdev = nhi->pdev;
@@ -1220,6 +1263,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	nhi_check_quirks(nhi);
+	nhi_check_iommu(nhi);
 
 	res = nhi_init_msi(nhi);
 	if (res) {
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 124e13cb1469..7a8ad984e651 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -465,6 +465,7 @@ static inline struct tb_xdomain *tb_service_parent(struct tb_service *svc)
  * @msix_ida: Used to allocate MSI-X vectors for rings
  * @going_away: The host controller device is about to disappear so when
  *		this flag is set, avoid touching the hardware anymore.
+ * @iommu_dma_protection: An IOMMU will isolate external-facing ports.
  * @interrupt_work: Work scheduled to handle ring interrupt when no
  *		    MSI-X is used.
  * @hop_count: Number of rings (end point hops) supported by NHI.
@@ -479,6 +480,7 @@ struct tb_nhi {
 	struct tb_ring **rx_rings;
 	struct ida msix_ida;
 	bool going_away;
+	bool iommu_dma_protection;
 	struct work_struct interrupt_work;
 	u32 hop_count;
 	unsigned long quirks;
-- 
2.28.0.dirty

