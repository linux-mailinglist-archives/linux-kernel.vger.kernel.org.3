Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3045A7F80
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiHaODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiHaODZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:03:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CBFD6BA9;
        Wed, 31 Aug 2022 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661954603; x=1693490603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5kccYvtkHvzcQzQhgfR8z09RnV+ThYRtA105LHeNCwk=;
  b=gk58dDMXmZWQlW33IwlI7KHAAea1ZhEtUtxFHRGqilbwjArapauGQ2tZ
   7AKIE2zGkJkIiq6wlR7vNj72zPY6kwcxzfiaJHItkzoNmL6e3MKnjns+9
   1SSv9714H/1UWBg9/re6u2shJ8Srrro61CjfS1df+geDQyo1+y3KRijnF
   9XaLBaV3X+QI7MQyOG1qz5ZQLbLiNCbhGTHe7pAMrM81lh5tzGUWHe8b7
   urJSIWs1rOCbC6Dwp5Gw3jZZ2HQgdyBSErCqmo2Z6rKKpCK76d2EoYZMb
   rfc1eM7oSrk9GIhyJm5RKD9T1WLH73Oc0nzmEWBd5FJkkCLydEbSMFzlr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275200995"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="275200995"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="680427489"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2022 07:03:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB8DD238; Wed, 31 Aug 2022 17:03:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 4/4] ACPI: platform: Sort forbidden_id_list[] in ascending order
Date:   Wed, 31 Aug 2022 17:03:27 +0300
Message-Id: <20220831140327.79149-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831140327.79149-1-andriy.shevchenko@linux.intel.com>
References: <20220831140327.79149-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For easier maintenance, sort the forbidden_id_list[] table rows in
ascending order with respect to the device ID field.

While at it, use an empty row as the list terminator, which is more
usual in the kernel.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2 modified commit messages to be prettier (Rafael)
 drivers/acpi/acpi_platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 0d812fe248d4..f13409583cd9 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -20,13 +20,13 @@
 #include "internal.h"
 
 static const struct acpi_device_id forbidden_id_list[] = {
+	{"ACPI0009", 0},	/* IOxAPIC */
+	{"ACPI000A", 0},	/* IOAPIC */
 	{"PNP0000",  0},	/* PIC */
 	{"PNP0100",  0},	/* Timer */
 	{"PNP0200",  0},	/* AT DMA Controller */
-	{"ACPI0009", 0},	/* IOxAPIC */
-	{"ACPI000A", 0},	/* IOAPIC */
 	{"SMB0001",  0},	/* ACPI SMBUS virtual device */
-	{"", 0},
+	{ }
 };
 
 static struct platform_device *acpi_platform_device_find_by_companion(struct acpi_device *adev)
-- 
2.35.1

