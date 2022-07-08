Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BAF56C3D8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbiGHVI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbiGHVI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:08:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2807B367
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657314535; x=1688850535;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gFLK1shtx1D6SxBo2Bo4N8I275mKD06V5N6e5VArP+Q=;
  b=HNBz9i/a9pHDUsyGr90Od5bV5bvksbxFCnhIcJZQ5Lc2kSsvMGzBEJUV
   DVzWay9GSncxXunKnJMm+pLEbSkt7WP0q9UJQXgUnZgjqqgwqoS/S4aip
   O+jz+s8bpJFrV9qaPtbRblL3YuZIjZnGDK+SgrUveuHvts3L8YtuywjI3
   yWr7JcSbRQKTpDE6P5KJ1IbpHB4C0Mx8pclBbVuxy6vvrDBfmKoFXuNb7
   FecGIWl8O7vdbLaFZVvwnqDnWME9eV2JLSx1jSGaTJVb2YxDgpcqE6h9e
   /kMnj4IZtGi2Io+dr++TmZc/dwf1kjb3ncs7CQiD9Dts/noK7OZDYdyrT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="370678950"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="370678950"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 14:08:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="626831689"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2022 14:08:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 90784CE; Sat,  9 Jul 2022 00:09:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com
Subject: [PATCH v2 1/4] bus: hisi_lpc: Don't dereference fwnode handle
Date:   Sat,  9 Jul 2022 00:08:56 +0300
Message-Id: <20220708210859.6774-1-andriy.shevchenko@linux.intel.com>
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
an fwnode handle directly, which is a better coding practice.

While at it, reuse fwnode instead of ACPI_COMPANION().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: John Garry <john.garry@huawei.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v2: added tags (John, Rafael), tweaked commit message (John)
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

