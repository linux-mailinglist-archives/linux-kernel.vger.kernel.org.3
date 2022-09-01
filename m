Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD65A959A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiIALVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiIALVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:21:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6416125B90
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:21:04 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJJVz6G9fz681Zh;
        Thu,  1 Sep 2022 19:20:27 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 13:21:02 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 12:21:00 +0100
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        <rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <yangyingliang@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/5] bus: hisi_lpc: Don't dereference fwnode handle
Date:   Thu, 1 Sep 2022 19:14:27 +0800
Message-ID: <1662030871-182688-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662030871-182688-1-git-send-email-john.garry@huawei.com>
References: <1662030871-182688-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Use dev_fwnode() and acpi_fwnode_handle() instead of dereferencing
an fwnode handle directly, which is a better coding practice.

While at it, reuse fwnode instead of ACPI_COMPANION().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: John Garry <john.garry@huawei.com>
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
2.35.3

