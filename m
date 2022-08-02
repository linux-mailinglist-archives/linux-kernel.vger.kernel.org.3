Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B1588289
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiHBTfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiHBTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:34:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B33ED4D;
        Tue,  2 Aug 2022 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659468898; x=1691004898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nh6oqzOP4zkEC2BfS8mKs5YxKTaE500IwLAFVtKjfWc=;
  b=bMrffLiBKeYeXRXzSkrDTNuiBrz9Rek9SPR4AZ/p8XA5/YxgqVlCpehv
   yIN5uniehoYY5H30qhGql9R9C2iE3u/NFqQUSz/++MQPUp1se1H3ldOJK
   bm6TVSNvQ7G4Dc8pLtLCIPDePjlrj2q95GOvPCXGcT4slxsTA9PV1Qa7P
   RYGXxwKAZEkaBehS/d8Bd/DxAd/t5LhqRpAcwAJy0xjxRYc+40x3DwU4g
   P+qe59qC77rZ9En834pPv9iouXeYdG7cI6vsuLmzv4m6mI3kIKYf1+8qB
   FnHo3/rwaJJFl6YXC8PFK/OEW4vvYOkOcjxqCbXDOe6CYoMBCPEtQ0Xpl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290278326"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="290278326"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 12:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="848320304"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2022 12:34:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0ABD7F7; Tue,  2 Aug 2022 22:35:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Eric Auger <eric.auger@redhat.com>, linux-acpi@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: VIOT: Do not dereference fwnode in struct device
Date:   Tue,  2 Aug 2022 22:35:03 +0300
Message-Id: <20220802193503.3092-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make the underneath API easier to change in the future,
prevent users from dereferencing fwnode from struct device.
Instead, use the specific dev_fwnode() and device_match_fwnode()
APIs for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/viot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index 647f11cf165d..6132092dab2a 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -88,7 +88,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
 		return -ENODEV;
 	}
 
-	fwnode = pdev->dev.fwnode;
+	fwnode = dev_fwnode(&pdev->dev);
 	if (!fwnode) {
 		/*
 		 * PCI devices aren't necessarily described by ACPI. Create a
@@ -101,7 +101,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
 		}
 		set_primary_fwnode(&pdev->dev, fwnode);
 	}
-	viommu->fwnode = pdev->dev.fwnode;
+	viommu->fwnode = dev_fwnode(&pdev->dev);
 	pci_dev_put(pdev);
 	return 0;
 }
@@ -314,7 +314,7 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
 		return -ENODEV;
 
 	/* We're not translating ourself */
-	if (viommu->fwnode == dev->fwnode)
+	if (device_match_fwnode(dev, viommu->fwnode))
 		return -EINVAL;
 
 	ops = iommu_ops_from_fwnode(viommu->fwnode);
-- 
2.35.1

