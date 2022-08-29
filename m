Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23935A4EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiH2OLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiH2OLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:11:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4ED83F32;
        Mon, 29 Aug 2022 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661782252; x=1693318252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5mdqMNR2eL5FmZvRmeIyMK1iB5FOZvG+sogI99gXKfM=;
  b=TNKK4Ry2hkCAks+Sl4B/UP3RilBgx9jyY90pwM97I7gFSRwLhetnMz1r
   aTIVhgKe1unINThYjxU/5+Ff/lbdys6OZMkNdwsxH7Tj0xkPcdVDiP4cB
   9XPzToRddtNkYuSO5lVmM2arDOw6ZnnvU9EQw98tLLOF+tqJ3q6iB8puB
   FBSNQizEiCLvHN0ODUgDsHRNrPKVbBju9NQCj3lRbXHxmWgnPTtqXggVp
   Hq+40FKYlvJIpHY9O7YAoh1VoEs2ySDG+NlMdnCXSWCHsy9B0F75i2Esg
   JXCYK4nWM+zj/QpRNWxe/b1ydHtV2beJSWyu6bU1CQYF2YgngTD7ddIcJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="358865159"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="358865159"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="614227836"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2022 07:10:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A949BAD; Mon, 29 Aug 2022 17:11:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/4] ACPI: platform: Remove redundant print on ENOMEM
Date:   Mon, 29 Aug 2022 17:10:58 +0300
Message-Id: <20220829141100.63934-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829141100.63934-1-andriy.shevchenko@linux.intel.com>
References: <20220829141100.63934-1-andriy.shevchenko@linux.intel.com>
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

We rely on somebody else to print enough information on failures.
So remove the log in acpi_create_platform_device() when return
-ENOMEM.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 75e26528056d..042f80588c18 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -120,7 +120,6 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 		resources = kcalloc(count, sizeof(struct resource),
 				    GFP_KERNEL);
 		if (!resources) {
-			dev_err(&adev->dev, "No memory for resources\n");
 			acpi_dev_free_resource_list(&resource_list);
 			return ERR_PTR(-ENOMEM);
 		}
-- 
2.35.1

