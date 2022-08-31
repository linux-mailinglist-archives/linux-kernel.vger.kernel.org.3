Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC99B5A7F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiHaOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiHaODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:03:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94050D6B99;
        Wed, 31 Aug 2022 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661954602; x=1693490602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sTmoYg+/fhXLwgBbkoLEM4CwBWesyXOqZ6VTvfe0paA=;
  b=bZK1Xh9xbmBerAeFKucg1bRCVXE8pfHC2P1acQ5gaUAOZjJm5BtjmSpE
   8YH5gRV02/+3E2xUAgXDdqb/hmKsRrHoFxzSL/wzAu5Ucva3DpHmUoopd
   gpBbWSwU+xbGek5l0b8+tUgjJViE6KnL3MpaWoRZ9zjNCLeZ8tRBbsz6c
   gDEsJP9Hlkrk4v23fATykYCKZLvRyPOtIAZScHEQ1QLgk8IJBB8/5EygD
   Puml7ml8FtcVSyHd37UYOZjpHGzpI5ymz8qkanplP49+eCwPSAcYLlsnZ
   hCVZc0akg5F4KF2+TQjVi7RXehWW4E/sXE2wxzsHkxeUg9heXSYNWZpuC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357171061"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="357171061"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="563041420"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2022 07:03:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF90BAD; Wed, 31 Aug 2022 17:03:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 2/4] ACPI: platform: Remove redundant print on -ENOMEM
Date:   Wed, 31 Aug 2022 17:03:25 +0300
Message-Id: <20220831140327.79149-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831140327.79149-1-andriy.shevchenko@linux.intel.com>
References: <20220831140327.79149-1-andriy.shevchenko@linux.intel.com>
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

We rely on somebody else to print enough information on memory
allocation failures. So remove the log in
the acpi_create_platform_device() when return -ENOMEM.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: slightly modified commit message to be prettier
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

