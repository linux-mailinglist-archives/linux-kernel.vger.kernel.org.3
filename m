Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8155A4EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiH2OLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiH2OLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:11:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BB16D9FC;
        Mon, 29 Aug 2022 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661782290; x=1693318290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UdyAlP6Cu2i6g5ve3boSf0mI1AlQpMT/Vp53YUlwOUM=;
  b=LtO/3IJ9dAlaxoxB2HEqTYs62Pf6ENmYK47EutmFVy2oTlFUEhg1Maef
   KXenQzSZQpQlm3Qn/YB1SbECQkvTv0Rqbqv7vnNGRTwlGujjhRaOsobBj
   sHTK2vfJGgZDUGde1KoqPPPdV6kMzcDoPOZlcFPfvAdC3w/hAG+i7Tzcw
   zaF/UcWmuHaMvblvGdgcVAEPRP5VdLfDs67p5X7P5SD1T1NY6Aj77teqy
   3hC8P5bddpBEwrheylReMciyI5RmC0XkBDYrTWSRwsADQX7H3vxixDPH6
   NkDRlbsIPlm86i1KKJ/J9zu+N+lCJ62CToZT4wkimJKl7yZG6mhHq7i+Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="356618235"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="356618235"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="679635865"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2022 07:11:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7666D19D; Mon, 29 Aug 2022 17:11:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] ACPI: LPSS: Replace loop with first entry retrieval
Date:   Mon, 29 Aug 2022 17:11:28 +0300
Message-Id: <20220829141129.65916-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 6505e452371d ("ACPI: LPSS: Use the helper
acpi_dev_get_memory_resources()") the list is empty or
contains only resource of IORESOURCE_MEM type. Hence, no
need to check for the type, and since we break after the
first found, no need to iterate over full list. That said,
replace loop with first entry retrieval.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 4f6cba8fe8de..c39a0a88f3a3 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -656,16 +656,14 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	if (ret < 0)
 		goto err_out;
 
-	list_for_each_entry(rentry, &resource_list, node)
-		if (resource_type(rentry->res) == IORESOURCE_MEM) {
-			if (dev_desc->prv_size_override)
-				pdata->mmio_size = dev_desc->prv_size_override;
-			else
-				pdata->mmio_size = resource_size(rentry->res);
-			pdata->mmio_base = ioremap(rentry->res->start,
-						   pdata->mmio_size);
-			break;
-		}
+	rentry = list_first_entry_or_null(&resource_list, struct resource_entry, node);
+	if (rentry) {
+		if (dev_desc->prv_size_override)
+			pdata->mmio_size = dev_desc->prv_size_override;
+		else
+			pdata->mmio_size = resource_size(rentry->res);
+		pdata->mmio_base = ioremap(rentry->res->start, pdata->mmio_size);
+	}
 
 	acpi_dev_free_resource_list(&resource_list);
 
-- 
2.35.1

