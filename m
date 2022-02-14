Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C98C4B5CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiBNVfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:35:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiBNVfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:35:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B346E15C1BB;
        Mon, 14 Feb 2022 13:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644874400; x=1676410400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3VNpCeDMulLlJrE98YYeKShG9gqaFAeFwMgC+ghMVKU=;
  b=Q5pWDkGNAZFgRKCV94yD4vTqR9GBHpWWyStZEkQEOEGIsAPcBjq83xjI
   HF6dzY863VyWP0/0YMCn9TDsNqDCjOq5H15GAV/61X5AOeKWUCDDAw7tx
   ++JKxxrq/tDsBfaRb8A23sgXcH9RhUQWnJE1QzjnU+yV7+xyLKsj6s15b
   8s9APZ9/cDANiM887iqQWQnKSOPeUUFBp0U+OZfb/q1Em1z7+P8wA8L83
   yy55PnG05qPJXi9tl2coJhBm6W/AXyX3+Taxp1Wwu0eHoZGJi0pqZOXdr
   RFx2WnIOTdY6OINA+s/MX5CgWtOMTxnJFZtdEA+bWAv0Jdv9ynAnWJ4eb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="237599346"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="237599346"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 13:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="603469909"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 14 Feb 2022 13:33:06 -0800
Received: from debox1-desk4.intel.com (unknown [10.255.228.161])
        by linux.intel.com (Postfix) with ESMTP id B6AC6580D37;
        Mon, 14 Feb 2022 13:33:06 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        mgross@linux.intel.com, rjw@rjwysocki.net,
        srinivas.pandruvada@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/3] platform/x86/intel: vsec: Enable runtime D3
Date:   Mon, 14 Feb 2022 13:32:57 -0800
Message-Id: <20220214213258.1929462-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214213258.1929462-1-david.e.box@linux.intel.com>
References: <20220214213258.1929462-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm_runtime helpers to allow the PCI device to go to D3 when
not in use.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c |  5 +++++
 drivers/platform/x86/intel/pmt/class.h |  3 +++
 drivers/platform/x86/intel/vsec.c      | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 85fc159961c1..a3ec09fe2f38 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 
 #include "../vsec.h"
 #include "class.h"
@@ -63,7 +64,10 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
 	if (count > entry->size - off)
 		count = entry->size - off;
 
+	pm_runtime_get_sync(&entry->pdev->dev);
 	memcpy_fromio(buf, entry->base + off, count);
+	pm_runtime_mark_last_busy(&entry->pdev->dev);
+	pm_runtime_put_autosuspend(&entry->pdev->dev);
 
 	return count;
 }
@@ -209,6 +213,7 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
 	}
 
 	entry->kobj = &dev->kobj;
+	entry->pdev = to_pci_dev(parent->parent);
 
 	if (ns->attr_grp) {
 		ret = sysfs_create_group(entry->kobj, ns->attr_grp);
diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
index db11d58867ce..b4df7ee91c51 100644
--- a/drivers/platform/x86/intel/pmt/class.h
+++ b/drivers/platform/x86/intel/pmt/class.h
@@ -18,9 +18,12 @@
 #define GET_BIR(v)		((v) & GENMASK(2, 0))
 #define GET_ADDRESS(v)		((v) & GENMASK(31, 3))
 
+struct pci_dev;
+
 struct intel_pmt_entry {
 	struct bin_attribute	pmt_bin_attr;
 	struct kobject		*kobj;
+	struct pci_dev		*pdev;
 	void __iomem		*disc_table;
 	void __iomem		*base;
 	unsigned long		base_addr;
diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index c3bdd75ed690..d182122c261d 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -19,6 +19,7 @@
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/types.h>
 
 #include "vsec.h"
@@ -355,9 +356,21 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (!have_devices)
 		return -ENODEV;
 
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
+	pm_runtime_allow(&pdev->dev);
+
 	return 0;
 }
 
+static void intel_vsec_pci_remove(struct pci_dev *pdev)
+{
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_get(&pdev->dev);
+}
+
 /* TGL info */
 static const struct intel_vsec_platform_info tgl_info = {
 	.quirks = VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG | VSEC_QUIRK_TABLE_SHIFT,
@@ -383,6 +396,10 @@ static const struct intel_vsec_platform_info dg1_info = {
 	.quirks = VSEC_QUIRK_NO_DVSEC,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static const struct dev_pm_ops intel_vsec_pm_ops = {};
+#endif
+
 #define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
 #define PCI_DEVICE_ID_INTEL_VSEC_DG1		0x490e
 #define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
@@ -400,6 +417,12 @@ static struct pci_driver intel_vsec_pci_driver = {
 	.name = "intel_vsec",
 	.id_table = intel_vsec_pci_ids,
 	.probe = intel_vsec_pci_probe,
+	.remove = intel_vsec_pci_remove,
+	.driver = {
+#ifdef CONFIG_PM_SLEEP
+		.pm = &intel_vsec_pm_ops,
+#endif
+	},
 };
 module_pci_driver(intel_vsec_pci_driver);
 
-- 
2.25.1

