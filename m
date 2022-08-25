Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4255A16D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiHYQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiHYQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:41:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F941B99D8;
        Thu, 25 Aug 2022 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661445663; x=1692981663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bK5Pr9tx4aF8qD5Hm5yfT5c8GZSZbo0EmA54sQj8Dug=;
  b=O9nFwkyJR28qcCsHGsaFnXXfDxMoHFRZiuEw3h5ykINYQkWMqq+mAipx
   dXIdAwka1OsO0WcArBJ0Z63zmcRzmjzPixb88nHVoVtyVNyeacjzH4N2f
   gR6xWMMMnDcGWqDAeWHvbH25ubCOBerE4Xucpkut3kRA2Sfcn6G5utrxl
   c3k03n+6YymJoBL3QCOKZBZE+gMAWkAn/zIS2HENO/R/0ogoxP4V8Az//
   3JfyxFtjMx0sP0LetNzKf2ccKRSkgeZ183Et10mngXUftnpdpHRLrsNWH
   R0IMLtgqZY5KVDrEnQQ3UD+YOkf2vrrR8v1ki9wQw6X724j6znWVChxpd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="380586964"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="380586964"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="786072443"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 25 Aug 2022 09:41:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 71E621C3; Thu, 25 Aug 2022 19:41:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/5] ACPI: bus: Refactor acpi_driver_match_device() for better readability
Date:   Thu, 25 Aug 2022 19:41:00 +0300
Message-Id: <20220825164103.27694-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com>
References: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With temporary variables for OF and ACPI IDs, it's easier to read
the code. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 8e87996607ec..c4d63c594d68 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -948,14 +948,13 @@ EXPORT_SYMBOL(acpi_match_device_ids);
 bool acpi_driver_match_device(struct device *dev,
 			      const struct device_driver *drv)
 {
-	if (!drv->acpi_match_table)
-		return acpi_of_match_device(ACPI_COMPANION(dev),
-					    drv->of_match_table,
-					    NULL);
-
-	return __acpi_match_device(acpi_companion_match(dev),
-				   drv->acpi_match_table, drv->of_match_table,
-				   NULL, NULL);
+	const struct acpi_device_id *acpi_ids = drv->acpi_match_table;
+	const struct of_device_id *of_ids = drv->of_match_table;
+
+	if (!acpi_ids)
+		return acpi_of_match_device(ACPI_COMPANION(dev), of_ids, NULL);
+
+	return __acpi_match_device(acpi_companion_match(dev), acpi_ids, of_ids, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(acpi_driver_match_device);
 
-- 
2.35.1

