Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59592566A10
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiGELnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiGELnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:43:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B53017061
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657021398; x=1688557398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+eKy3mDGSq9qCESn2yLkn1Xvvpqxf5Qt9r+qaD7RR9k=;
  b=Yp3RxIdhDU4bpUThava/tEjvL8dalPIAyzBxnElWOifqFWiskhBVyKVw
   IUAYplfj3lUPcEBjhuAyFAHaRQmizk0YKglKdP2WkeWACHkmt0ByjFaK3
   /uLvg13fBbHUzyYlRvcuQSCbfzoZzbVMtquaF7Bz9eXAjPB4Tz91KIZdL
   4WO7jI1lqZ06gkAO94WNcmcC6mycNxZBY67M+hmm4g1RfM2/oB8hS/WXr
   7OyadjSTUqoUO62oJn2tSiO5sh3u8X+k7s38YRE/CePyAKlfvdkPLn7jV
   /0J3RKzRnYGUm/VxycNX/lwZTB1b534Javg1l4a8DpQ8IlvITZKprtrke
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="369653605"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="369653605"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 04:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="619795867"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2022 04:43:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 86EB21A0; Tue,  5 Jul 2022 14:43:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] bus: hisi_lpc: Don't dereference fwnode handle
Date:   Tue,  5 Jul 2022 14:43:09 +0300
Message-Id: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_fwnode() and acpi_fwnode_handle() instead of dereferencing
an fwnode handle directly.

While at it, reuse fwnode instead of ACPI_COMPANION().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bus/hisi_lpc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 2e564803e786..6d432a07cbba 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -347,7 +347,7 @@ static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
 	unsigned long sys_port;
 	resource_size_t len = resource_size(res);
 
-	sys_port = logic_pio_trans_hwaddr(&host->fwnode, res->start, len);
+	sys_port = logic_pio_trans_hwaddr(acpi_fwnode_handle(host), res->start, len);
 	if (sys_port == ~0UL)
 		return -EFAULT;
 
@@ -615,7 +615,6 @@ static void hisi_lpc_acpi_remove(struct device *hostdev)
 static int hisi_lpc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct acpi_device *acpi_device = ACPI_COMPANION(dev);
 	struct logic_pio_hwaddr *range;
 	struct hisi_lpc_dev *lpcdev;
 	resource_size_t io_end;
@@ -637,7 +636,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	if (!range)
 		return -ENOMEM;
 
-	range->fwnode = dev->fwnode;
+	range->fwnode = dev_fwnode(dev);
 	range->flags = LOGIC_PIO_INDIRECT;
 	range->size = PIO_INDIRECT_SIZE;
 	range->hostdata = lpcdev;
@@ -651,7 +650,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	}
 
 	/* register the LPC host PIO resources */
-	if (acpi_device)
+	if (is_acpi_device_node(range->fwnode))
 		ret = hisi_lpc_acpi_probe(dev);
 	else
 		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
@@ -672,11 +671,10 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 static int hisi_lpc_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct acpi_device *acpi_device = ACPI_COMPANION(dev);
 	struct hisi_lpc_dev *lpcdev = dev_get_drvdata(dev);
 	struct logic_pio_hwaddr *range = lpcdev->io_host;
 
-	if (acpi_device)
+	if (is_acpi_device_node(range->fwnode))
 		hisi_lpc_acpi_remove(dev);
 	else
 		of_platform_depopulate(dev);
-- 
2.35.1

