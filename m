Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6B15A4EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiH2OLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiH2OLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:11:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF638A1F6;
        Mon, 29 Aug 2022 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661782290; x=1693318290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p6tujt5OzoBQdRTagDTLViVcqSUKC0TjOcq+d85Ngfw=;
  b=UpRRJ2mjnjxjD+34aTXbrvG8SWaoYcwpKxbEtmc85GvU8yeoCPahY3Bt
   T4Rou5VejTXIpwUf8nQt7+W5HFf4OVRaIj/CPi/CtiXADgMwvSCL3p+vP
   ZcKouk1LOzgBUE3Hh5YYn/qOqz96eKhUcc7ZklJI4E5i8N2/SNU7EpfTx
   TLx4FzAvfrQdwoqYhs+Xhck0hsgmMtzY01cvArF9tEm9pB8NQ2jXI/Jqp
   Rkf05CBWutkpSDfcbgbYi/PA1CetxdUHn/XtFZk/Nzh/fmjI5+vcpbRyU
   k/sJMAs7lyks9dVJPllve/GKEyKTyu1m9NtrzacnCicbRfL1SuX5yvSSf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295678392"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295678392"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="939590184"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2022 07:11:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F6A7AD; Mon, 29 Aug 2022 17:11:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] ACPI: LPSS: Deduplicate skipping device in acpi_lpss_create_device()
Date:   Mon, 29 Aug 2022 17:11:29 +0300
Message-Id: <20220829141129.65916-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829141129.65916-1-andriy.shevchenko@linux.intel.com>
References: <20220829141129.65916-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new label to deduplicate skipping device code in the
acpi_lpss_create_device(). No functional change intended.

While at it, convert the last conditional to use the classical
pattern, i.e.

	if (err)
		...handle err...

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index c39a0a88f3a3..7a73528aa9c2 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -670,9 +670,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	if (!pdata->mmio_base) {
 		/* Avoid acpi_bus_attach() instantiating a pdev for this dev. */
 		adev->pnp.type.platform_id = 0;
-		/* Skip the device, but continue the namespace scan. */
-		ret = 0;
-		goto err_out;
+		goto out_free;
 	}
 
 	pdata->adev = adev;
@@ -683,11 +681,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 
 	if (dev_desc->flags & LPSS_CLK) {
 		ret = register_device_clock(adev, pdata);
-		if (ret) {
-			/* Skip the device, but continue the namespace scan. */
-			ret = 0;
-			goto err_out;
-		}
+		if (ret)
+			goto out_free;
 	}
 
 	/*
@@ -699,15 +694,19 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 
 	adev->driver_data = pdata;
 	pdev = acpi_create_platform_device(adev, dev_desc->properties);
-	if (!IS_ERR_OR_NULL(pdev)) {
-		acpi_lpss_create_device_links(adev, pdev);
-		return 1;
+	if (IS_ERR_OR_NULL(pdev)) {
+		adev->driver_data = NULL;
+		ret = PTR_ERR(pdev);
+		goto err_out;
 	}
 
-	ret = PTR_ERR(pdev);
-	adev->driver_data = NULL;
+	acpi_lpss_create_device_links(adev, pdev);
+	return 1;
 
- err_out:
+out_free:
+	/* Skip the device, but continue the namespace scan */
+	ret = 0;
+err_out:
 	kfree(pdata);
 	return ret;
 }
-- 
2.35.1

