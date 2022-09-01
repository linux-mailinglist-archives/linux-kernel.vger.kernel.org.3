Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CB45A95C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiIALd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiIALdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:33:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DABB115189;
        Thu,  1 Sep 2022 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662032035; x=1693568035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E+0XHZ48Mbb5Asg5RDA8s1aKri51xsKNicl5KUhjpiI=;
  b=DiVw3ZkUpCufsg7se79Krwf10pdY7qeYLcDAb4KeFp8+i1BldmEq5K58
   07B+76/cWh27nFi994CSXG4YK+H689/VC//tP59+BAJHRUX1cTpDZMPz+
   qBv9JujKS1ZfciW76DYfy7XRoL2CnDLcsNroFzUKHQQyukvZ5oas5QwWG
   VKYIfbN9IGqEnSe2CWDYvXRpTTbqgti/1NOtC2v3Pt3aH7meiKTGzpNTI
   XK6N5B5iY+/AJOezAplAm4mir7djfD3XGqOrcoMBzRpsTHNqcYoqCKERl
   OrOWdgutfcOQplclDcycpF9MlG4qY+Bbj6EOmVS8XiZO6OCZs2AOFIUmw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="295697443"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="295697443"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673809731"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2022 04:33:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 11AEE1C3; Thu,  1 Sep 2022 14:34:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: p2sb: Fix UAF when caller uses resource name
Date:   Thu,  1 Sep 2022 14:34:06 +0300
Message-Id: <20220901113406.65876-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have to copy only selected fields from the original resource.
Because a PCI device will be removed immediately after getting
its resources, we may not use any allocated data, hence we may
not copy any pointers.

Consider the following scenario:

  1/ a caller of p2sb_bar() gets the resource;

  2/ the resource has been copied by platform_device_add_data()
     in order to create a platform device;

  3/ the platform device creation will call for the device driver's
     ->probe() as soon as a match found;

  4/ the ->probe() takes given resources (see 2/) and tries to
     access one of its field, i.e. 'name', in the
     __devm_ioremap_resource() to create a pretty looking output;

  5/ but the 'name' is a dangling pointer because p2sb_bar()
     removed a PCI device, which 'name' had been copied to
     the caller's memory.

  6/ UAF (Use-After-Free) as a result.

Kudos to Mika for the initial analisys of the issue.

Fixes: 9745fb07474f ("platform/x86/intel: Add Primary to Sideband (P2SB) bridge support")
Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://lore.kernel.org/linux-i2c/YvPCbnKqDiL2XEKp@xsang-OptiPlex-9020/
Link: https://lore.kernel.org/linux-i2c/YtjAswDKfiuDfWYs@xsang-OptiPlex-9020/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/p2sb.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index fb2e141f3eb8..384d0962ae93 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -42,10 +42,24 @@ static int p2sb_get_devfn(unsigned int *devfn)
 	return 0;
 }
 
+/* Copy resource from the first BAR of the device in question */
 static int p2sb_read_bar0(struct pci_dev *pdev, struct resource *mem)
 {
-	/* Copy resource from the first BAR of the device in question */
-	*mem = pdev->resource[0];
+	struct resource *bar0 = &pdev->resource[0];
+
+	/* Make sure we have no dangling pointers in the output */
+	memset(mem, 0, sizeof(*mem));
+
+	/*
+	 * We copy only selected fields from the original resource.
+	 * Because a PCI device will be removed soon, we may not use
+	 * any allocated data, hence we may not copy any pointers.
+	 */
+	mem->start = bar0->start;
+	mem->end = bar0->end;
+	mem->flags = bar0->flags;
+	mem->desc = bar0->desc;
+
 	return 0;
 }
 
-- 
2.35.1

