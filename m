Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF60560C26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiF2WNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiF2WNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:13:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197341AD8D;
        Wed, 29 Jun 2022 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656540796; x=1688076796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hM5yXBlOkkU9tdnWE+P4k5x9ZayD+DfNzsincX9Nu0w=;
  b=drd5NDyRHSHo5ftdsGWskL04jyJv8G9mYp564kJn8VbmHExRjR7QXwoO
   qaT68OxScZKXpjN74WQfVtaxWOra6PIWLEU//oH3hYSqooCY6V54MKTIr
   HE6repRIbu9P2txHN6ooSgkbD+fWN+xpH+/TcKW3ycHcImRGRjkLRr3DA
   UQcrExX453IvfxEJiOrRlPSJGBN9wTGtKlEX108Vg2A078WGnFZycROHY
   M0TEqmlvkj1hM01acoYUPdfmW5Ovm2OTnb3VAYCOsJQ8a1Laabs0xilLt
   DPGXuUWHAVVjHdqaMd2AabJ0rfgrjFOsmzA/BtVWzmWfvCmWKX2KNu1ow
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="346165664"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="346165664"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="917782995"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2022 15:13:15 -0700
Received: from MeteorLakePO1.jf.intel.com (MeteorLakePO1.jf.intel.com [10.234.180.58])
        by linux.intel.com (Postfix) with ESMTP id 313B9580AB4;
        Wed, 29 Jun 2022 15:13:15 -0700 (PDT)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, david.e.box@linux.intel.com,
        srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        David E Box <david.e.box@intel.com>
Subject: [PATCH v1 4/4] platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT
Date:   Wed, 29 Jun 2022 15:13:34 -0700
Message-Id: <20220629221334.434307-5-gayatri.kammela@linux.intel.com>
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

Add PCI error recovery support for Intel PMT driver to recover
from PCI fatal errors

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: David E Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 82 ++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 9368a3d587ab..544493ae85b7 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -15,6 +15,7 @@
 
 #include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/idr.h>
 #include <linux/module.h>
@@ -30,9 +31,13 @@
 #define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
 #define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
 #define TABLE_OFFSET_SHIFT		3
+#define PMT_XA_START			0
+#define PMT_XA_MAX			INT_MAX
+#define PMT_XA_LIMIT			XA_LIMIT(PMT_XA_START, PMT_XA_MAX)
 
 static DEFINE_IDA(intel_vsec_ida);
 static DEFINE_IDA(intel_vsec_sdsi_ida);
+static DEFINE_XARRAY_ALLOC(auxdev_array);
 
 /**
  * struct intel_vsec_header - Common fields of Intel VSEC and DVSEC registers.
@@ -132,7 +137,7 @@ static int intel_vsec_add_aux(struct pci_dev *pdev, struct intel_vsec_device *in
 			      const char *name)
 {
 	struct auxiliary_device *auxdev = &intel_vsec_dev->auxdev;
-	int ret;
+	int ret, id;
 
 	ret = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
 	if (ret < 0) {
@@ -159,7 +164,18 @@ static int intel_vsec_add_aux(struct pci_dev *pdev, struct intel_vsec_device *in
 		return ret;
 	}
 
-	return devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux, auxdev);
+	ret = devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux,
+				       auxdev);
+	if (ret < 0)
+		return ret;
+
+	/* Add auxdev to list */
+	ret = xa_alloc(&auxdev_array, &id, intel_vsec_dev, PMT_XA_LIMIT,
+		       GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
@@ -345,6 +361,7 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (ret)
 		return ret;
 
+	pci_save_state(pdev);
 	info = (struct intel_vsec_platform_info *)id->driver_data;
 	if (!info)
 		return -EINVAL;
@@ -406,10 +423,71 @@ static const struct pci_device_id intel_vsec_pci_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, intel_vsec_pci_ids);
 
+static pci_ers_result_t intel_vsec_pci_error_detected(struct pci_dev *pdev,
+						      pci_channel_state_t state)
+{
+	pci_channel_state_t status = PCI_ERS_RESULT_NEED_RESET;
+
+	dev_info(&pdev->dev, "PCI error detected, state %d", state);
+
+	if (state == pci_channel_io_perm_failure)
+		status = PCI_ERS_RESULT_DISCONNECT;
+	else
+		pci_disable_device(pdev);
+
+	return status;
+}
+
+static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
+{
+	struct intel_vsec_device *intel_vsec_dev;
+	pci_channel_state_t status = PCI_ERS_RESULT_DISCONNECT;
+	const struct pci_device_id *pci_dev_id;
+	unsigned long index;
+
+	dev_info(&pdev->dev, "Resetting PCI slot\n");
+
+	msleep(2000);
+	if (pci_enable_device(pdev)) {
+		dev_info(&pdev->dev,
+			 "Failed to re-enable PCI device after reset.\n");
+		goto out;
+	}
+
+	status =  PCI_ERS_RESULT_RECOVERED;
+
+	xa_for_each(&auxdev_array, index, intel_vsec_dev) {
+		/* check if pdev doesn't match */
+		if (pdev != intel_vsec_dev->pcidev)
+			continue;
+		devm_release_action(&pdev->dev, intel_vsec_remove_aux,
+				    &intel_vsec_dev->auxdev);
+	}
+	pci_disable_device(pdev);
+	pci_restore_state(pdev);
+	pci_dev_id = pci_match_id(intel_vsec_pci_ids, pdev);
+	intel_vsec_pci_probe(pdev, pci_dev_id);
+
+out:
+	return status;
+}
+
+void intel_vsec_pci_resume(struct pci_dev *pdev)
+{
+	dev_info(&pdev->dev, "Done resuming PCI device\n");
+}
+
+const struct pci_error_handlers intel_vsec_pci_err_handlers = {
+	.error_detected = intel_vsec_pci_error_detected,
+	.slot_reset = intel_vsec_pci_slot_reset,
+	.resume = intel_vsec_pci_resume,
+};
+
 static struct pci_driver intel_vsec_pci_driver = {
 	.name = "intel_vsec",
 	.id_table = intel_vsec_pci_ids,
 	.probe = intel_vsec_pci_probe,
+	.err_handler = &intel_vsec_pci_err_handlers,
 };
 module_pci_driver(intel_vsec_pci_driver);
 
-- 
2.32.0

