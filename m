Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2A48E01A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiAMWNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:13:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:53718 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233023AbiAMWNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642111995; x=1673647995;
  h=from:to:cc:subject:date:message-id;
  bh=BRcMWiTvAIYEWm6nRi08D8xbfePlAJ2/c+iNxGqgvx0=;
  b=DP1ROMPsD8l/89lJY4tUrSTyfu8F927a3tc0Av4vlClIRhFwTabPMTVg
   Gb6v0uGvHTL5gpsKs77JnE5zV9FdSRTD4J0xoBE1tPGcOtUPXwxAdIWI7
   QgKFvYbnuo8ECwrTm032kwRlntx5ysdTgVXLqgOqBnbfsGfJM7hf++qMI
   QB1O4t9h59p1dsFwpFahO5EkJX0v7A28YdTPrx6MzqktH4DBDJRvsfFib
   lEG9keSPOZuZizrYQdMkPX2N5oNK+fSp8Q4X0RQPATGg4Ns5pf7OPW6SY
   y0atK2+ap+cRriKv9n0/u2AiUYwuMCRKKjlaKXMxn/ca5qHElNpafQizw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244327500"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244327500"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 14:13:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="491283174"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2022 14:13:13 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
Subject: [PATCH] iommu/vt-d: Fix PCI bus rescan device hot add
Date:   Thu, 13 Jan 2022 05:23:18 -0800
Message-Id: <1642080198-10971-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During PCI bus rescan, adding new devices involve two notifiers.
1. dmar_pci_bus_notifier()
2. iommu_bus_notifier()
The current code sets #1 as low priority (INT_MIN) which resulted in #2
being invoked first. The result is that struct device pointer cannot be
found in DRHD search for the new device's DMAR/IOMMU. Subsequently, the
device is put under the "catch-all" IOMMU instead of the correct one.

This could cause system hang when device TLB invalidation is sent to the
wrong IOMMU. Invalidation timeout error or hard lockup can be observed.

This patch fixes the issue by setting a higher priority for
dmar_pci_bus_notifier. DRHD search for a new device will find the
correct IOMMU.

Fixes: 59ce0515cdaf ("iommu/vt-d: Update DRHD/RMRR/ATSR device scope")
Reported-by: Zhang, Bernice <bernice.zhang@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 915bff76fe96..5d07e5b89c2e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -385,7 +385,7 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
 
 static struct notifier_block dmar_pci_bus_nb = {
 	.notifier_call = dmar_pci_bus_notifier,
-	.priority = INT_MIN,
+	.priority = INT_MAX,
 };
 
 static struct dmar_drhd_unit *
-- 
2.25.1

