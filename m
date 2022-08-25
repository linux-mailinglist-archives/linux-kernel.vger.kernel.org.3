Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13495A16DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbiHYQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiHYQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:41:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D9FBA9C0;
        Thu, 25 Aug 2022 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661445662; x=1692981662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6L5YW6wVIrpaazRx3sSRrkRPhSy6FbkOX5mt46QUY8A=;
  b=QozEPdJvqeNiEkKxxbQ9SSQp4wiggD/7NpJ0MjUzopx77nJffSPvvbwD
   5I7NFljkNBaRWNg/pkcCZ2QDNaYl0PBoZCvdTTeXS6zPE3+89DmokodEc
   neoQSxn2MTyC4s8vsKql0eQv+brRTUFUGjeM/4QR7xOpXnL1b7hmfUytT
   n6v5QXDTBRZ3R1KTu0CEx5KBKovcjh4wSkbZpd+fqZsSh5wbBOPeWuXa1
   ldEgX6hmO7zddVrDY1121NlxRPjm1YqcweHDbdPzizOn49NcpFJXgFGeR
   k6eHBkw2qaPfTPfozZ7azdIqnByz3atxdlFhSnGdc9oZkgFAL+nSNZ5NV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274689067"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="274689067"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="855701164"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 25 Aug 2022 09:41:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D2A5F238; Thu, 25 Aug 2022 19:41:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 3/5] ACPI: bus: Refactor acpi_bus_register_driver() to get rid of 'ret'
Date:   Thu, 25 Aug 2022 19:41:01 +0300
Message-Id: <20220825164103.27694-3-andriy.shevchenko@linux.intel.com>
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

There is no need to have 'ret' variable in acpi_bus_register_driver().
Refactor it accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c4d63c594d68..607e664b7976 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -972,16 +972,14 @@ EXPORT_SYMBOL_GPL(acpi_driver_match_device);
  */
 int acpi_bus_register_driver(struct acpi_driver *driver)
 {
-	int ret;
-
 	if (acpi_disabled)
 		return -ENODEV;
+
 	driver->drv.name = driver->name;
 	driver->drv.bus = &acpi_bus_type;
 	driver->drv.owner = driver->owner;
 
-	ret = driver_register(&driver->drv);
-	return ret;
+	return driver_register(&driver->drv);
 }
 
 EXPORT_SYMBOL(acpi_bus_register_driver);
-- 
2.35.1

