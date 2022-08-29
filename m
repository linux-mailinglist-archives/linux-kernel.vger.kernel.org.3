Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057C35A4EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiH2OLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiH2OLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:11:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBC85FD6;
        Mon, 29 Aug 2022 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661782254; x=1693318254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HhBA62FoyfYtqtJY+7hzMyC+yrK3wjqOhR5xyZFgC8=;
  b=n8tk4WXNLAWElVTN3SW0x1qJEod7Ncd0BzZ9bj8PYnHNvCUuOLIbQMzK
   pWiPleeFOwBhcKbcx5g99Iiu/Ei5b6obJpx6lcpIrtGfQBieDirzsKjIC
   rj3zv1bfVrPsaTSQaJVEEuVqk2l/3ijlD8jd8C6gUksvBTmhLLsqt0t8M
   eD+3eqaY5GYkGr0U/ZzP5NQ5TMuNxdnFeRc4qRf9s1d4iDatEmvVxDoay
   4lClSEDY8sljrXrvduxhYIgRTsyNooIwY32YjXpNofUp/MFxpOduWa1HI
   H95WgfXPIQH2r+9lP8lWFpgfIrRLKp/5CR44K3XRCN4Y3tWz/hYEphB+i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="277915228"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="277915228"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="737340737"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2022 07:10:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B46921C3; Mon, 29 Aug 2022 17:11:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 4/4] ACPI: platform: Keep list of ACPI IDs sorted
Date:   Mon, 29 Aug 2022 17:11:00 +0300
Message-Id: <20220829141100.63934-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829141100.63934-1-andriy.shevchenko@linux.intel.com>
References: <20220829141100.63934-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better maintenance keep list of the ACPI IDs sorted.
While at it, replace terminator with more standard '{ }'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

