Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D58560C21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiF2WNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2WNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:13:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2ADB7E9;
        Wed, 29 Jun 2022 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656540790; x=1688076790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+MnWaU8YkjOfexvbyxnqg21OgQpirbLQcDuM0OclIg=;
  b=UDHkvSiPCckDdjkoNUgjq3+o2D5IltOTGEJ1KRc6J3rRoCKn1I5GXV3S
   vVPq/0Pc6TxC/FC6Ax1TLia+9mMkMsmWd9znltpSLybdI1iaISJzRXp74
   pdEcCbcZkLTa9sRiw7UIVgdZSTJJ1aak+837rhXUt6vo5RNbmw1uZVJl0
   8Cd/cN2Ig8gPeKp3zHHFLBOL6t2kRKX3z11pR4JIKbENOxuw2LN2ASWOm
   BBNe6LPzi0G5Rf61bAHsyHyM2NCkV+uArt6b3jiVRL4fOPsXgs2DglOEc
   F5dCJEZ2VsWKzgn0Ys51Lufvvtwk1Y3OM2g6+rW0A+um93jUohsc5w2vS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="346165640"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="346165640"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="541027909"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2022 15:13:09 -0700
Received: from MeteorLakePO1.jf.intel.com (MeteorLakePO1.jf.intel.com [10.234.180.58])
        by linux.intel.com (Postfix) with ESMTP id CF622580B55;
        Wed, 29 Jun 2022 15:13:09 -0700 (PDT)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, david.e.box@linux.intel.com,
        srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>
Subject: [PATCH v1 1/4] platform/x86/intel/vsec: Rework early hardware code
Date:   Wed, 29 Jun 2022 15:13:31 -0700
Message-Id: <20220629221334.434307-2-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220629221334.434307-1-gayatri.kammela@linux.intel.com>
References: <20220629221334.434307-1-gayatri.kammela@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

In the Intel VSEC PCI driver, use a new VSEC_QUIRK_EARLY_HW flag in
driver_data to indicate the need for early hardware quirks in
auxiliary devices. Remove the separate PCI ID list maintained by the
Intel PMT auxiliary driver.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c | 23 ++++---------
 drivers/platform/x86/intel/vsec.c      | 46 ++++++++++++--------------
 drivers/platform/x86/intel/vsec.h      | 11 +++++-
 3 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 1c9e3f3ea41c..53d7fd2943b4 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -20,25 +20,16 @@
 #define PMT_XA_MAX		INT_MAX
 #define PMT_XA_LIMIT		XA_LIMIT(PMT_XA_START, PMT_XA_MAX)
 
-/*
- * Early implementations of PMT on client platforms have some
- * differences from the server platforms (which use the Out Of Band
- * Management Services Module OOBMSM). This list tracks those
- * platforms as needed to handle those differences. Newer client
- * platforms are expected to be fully compatible with server.
- */
-static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x467d) }, /* ADL */
-	{ PCI_VDEVICE(INTEL, 0x490e) }, /* DG1 */
-	{ PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
-	{ }
-};
-
 bool intel_pmt_is_early_client_hw(struct device *dev)
 {
-	struct pci_dev *parent = to_pci_dev(dev->parent);
+	struct intel_vsec_device *ivdev = dev_to_ivdev(dev);
 
-	return !!pci_match_id(pmt_telem_early_client_pci_ids, parent);
+	/*
+	 * Early implementations of PMT on client platforms have some
+	 * differences from the server platforms (which use the Out Of Band
+	 * Management Services Module OOBMSM).
+	 */
+	return !!(ivdev->info->quirks & VSEC_QUIRK_EARLY_HW);
 }
 EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
 
diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index bed436bf181f..d48df46e2e27 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -54,12 +54,6 @@ struct intel_vsec_header {
 	u32	offset;
 };
 
-/* Platform specific data */
-struct intel_vsec_platform_info {
-	struct intel_vsec_header **capabilities;
-	unsigned long quirks;
-};
-
 enum intel_vsec_id {
 	VSEC_ID_TELEMETRY	= 2,
 	VSEC_ID_WATCHER		= 3,
@@ -169,10 +163,11 @@ static int intel_vsec_add_aux(struct pci_dev *pdev, struct intel_vsec_device *in
 }
 
 static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
-			   unsigned long quirks)
+			      struct intel_vsec_platform_info *info)
 {
 	struct intel_vsec_device *intel_vsec_dev;
 	struct resource *res, *tmp;
+	unsigned long quirks = info->quirks;
 	int i;
 
 	if (!intel_vsec_allowed(header->id) || intel_vsec_disabled(header->id, quirks))
@@ -216,7 +211,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	intel_vsec_dev->pcidev = pdev;
 	intel_vsec_dev->resource = res;
 	intel_vsec_dev->num_resources = header->num_entries;
-	intel_vsec_dev->quirks = quirks;
+	intel_vsec_dev->info = info;
 
 	if (header->id == VSEC_ID_SDSI)
 		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
@@ -226,14 +221,15 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	return intel_vsec_add_aux(pdev, intel_vsec_dev, intel_vsec_name(header->id));
 }
 
-static bool intel_vsec_walk_header(struct pci_dev *pdev, unsigned long quirks,
-				struct intel_vsec_header **header)
+static bool intel_vsec_walk_header(struct pci_dev *pdev,
+				   struct intel_vsec_platform_info *info)
 {
+	struct intel_vsec_header **header = info->capabilities;
 	bool have_devices = false;
 	int ret;
 
 	for ( ; *header; header++) {
-		ret = intel_vsec_add_dev(pdev, *header, quirks);
+		ret = intel_vsec_add_dev(pdev, *header, info);
 		if (ret)
 			dev_info(&pdev->dev, "Could not add device for DVSEC id %d\n",
 				 (*header)->id);
@@ -244,7 +240,8 @@ static bool intel_vsec_walk_header(struct pci_dev *pdev, unsigned long quirks,
 	return have_devices;
 }
 
-static bool intel_vsec_walk_dvsec(struct pci_dev *pdev, unsigned long quirks)
+static bool intel_vsec_walk_dvsec(struct pci_dev *pdev,
+				  struct intel_vsec_platform_info *info)
 {
 	bool have_devices = false;
 	int pos = 0;
@@ -283,7 +280,7 @@ static bool intel_vsec_walk_dvsec(struct pci_dev *pdev, unsigned long quirks)
 		pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER2, &hdr);
 		header.id = PCI_DVSEC_HEADER2_ID(hdr);
 
-		ret = intel_vsec_add_dev(pdev, &header, quirks);
+		ret = intel_vsec_add_dev(pdev, &header, info);
 		if (ret)
 			continue;
 
@@ -293,7 +290,8 @@ static bool intel_vsec_walk_dvsec(struct pci_dev *pdev, unsigned long quirks)
 	return have_devices;
 }
 
-static bool intel_vsec_walk_vsec(struct pci_dev *pdev, unsigned long quirks)
+static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
+				 struct intel_vsec_platform_info *info)
 {
 	bool have_devices = false;
 	int pos = 0;
@@ -327,7 +325,7 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev, unsigned long quirks)
 		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
 		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
 
-		ret = intel_vsec_add_dev(pdev, &header, quirks);
+		ret = intel_vsec_add_dev(pdev, &header, info);
 		if (ret)
 			continue;
 
@@ -341,7 +339,6 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 {
 	struct intel_vsec_platform_info *info;
 	bool have_devices = false;
-	unsigned long quirks = 0;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -349,17 +346,17 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 		return ret;
 
 	info = (struct intel_vsec_platform_info *)id->driver_data;
-	if (info)
-		quirks = info->quirks;
+	if (!info)
+		return -EINVAL;
 
-	if (intel_vsec_walk_dvsec(pdev, quirks))
+	if (intel_vsec_walk_dvsec(pdev, info))
 		have_devices = true;
 
-	if (intel_vsec_walk_vsec(pdev, quirks))
+	if (intel_vsec_walk_vsec(pdev, info))
 		have_devices = true;
 
 	if (info && (info->quirks & VSEC_QUIRK_NO_DVSEC) &&
-	    intel_vsec_walk_header(pdev, quirks, info->capabilities))
+	    intel_vsec_walk_header(pdev, info))
 		have_devices = true;
 
 	if (!have_devices)
@@ -370,7 +367,8 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 
 /* TGL info */
 static const struct intel_vsec_platform_info tgl_info = {
-	.quirks = VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG | VSEC_QUIRK_TABLE_SHIFT,
+	.quirks = VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG |
+		  VSEC_QUIRK_TABLE_SHIFT | VSEC_QUIRK_EARLY_HW,
 };
 
 /* DG1 info */
@@ -390,7 +388,7 @@ static struct intel_vsec_header *dg1_capabilities[] = {
 
 static const struct intel_vsec_platform_info dg1_info = {
 	.capabilities = dg1_capabilities,
-	.quirks = VSEC_QUIRK_NO_DVSEC,
+	.quirks = VSEC_QUIRK_NO_DVSEC | VSEC_QUIRK_EARLY_HW,
 };
 
 #define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
@@ -400,7 +398,7 @@ static const struct intel_vsec_platform_info dg1_info = {
 static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
-	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, NULL) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &(struct intel_vsec_platform_info) {}) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
 	{ }
 };
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index 4cc36678e8c5..3deeb05cf394 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -20,6 +20,15 @@ enum intel_vsec_quirks {
 
 	/* DVSEC not present (provided in driver data) */
 	VSEC_QUIRK_NO_DVSEC	= BIT(3),
+
+	/* Platforms requiring quirk in the auxiliary driver */
+	VSEC_QUIRK_EARLY_HW     = BIT(4),
+};
+
+/* Platform specific data */
+struct intel_vsec_platform_info {
+	struct intel_vsec_header **capabilities;
+	unsigned long quirks;
 };
 
 struct intel_vsec_device {
@@ -27,7 +36,7 @@ struct intel_vsec_device {
 	struct pci_dev *pcidev;
 	struct resource *resource;
 	struct ida *ida;
-	unsigned long quirks;
+	struct intel_vsec_platform_info *info;
 	int num_resources;
 };
 
-- 
2.32.0

