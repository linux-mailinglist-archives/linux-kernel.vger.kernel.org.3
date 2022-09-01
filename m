Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4C5A959C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiIALVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiIALVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:21:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FCE125B90
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:21:13 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJJW81QP1z682sP;
        Thu,  1 Sep 2022 19:20:36 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 13:21:11 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 12:21:09 +0100
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        <rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <yangyingliang@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5/5] bus: hisi_lpc: Use platform_device_register_full()
Date:   Thu, 1 Sep 2022 19:14:31 +0800
Message-ID: <1662030871-182688-6-git-send-email-john.garry@huawei.com>
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

The code to create the child platform device is essentially the same as
what platform_device_register_full() does, so change over to use
that same function to reduce duplication.

Signed-off-by: John Garry <john.garry@huawei.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bus/hisi_lpc.c | 70 ++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 74f4448bff9d..2203ee57eaaf 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -472,9 +472,7 @@ static int hisi_lpc_acpi_clear_enumerated(struct acpi_device *adev, void *not_us
 
 struct hisi_lpc_acpi_cell {
 	const char *hid;
-	const char *name;
-	void *pdata;
-	size_t pdata_size;
+	const struct platform_device_info *pdevinfo;
 };
 
 static void hisi_lpc_acpi_remove(struct device *hostdev)
@@ -505,28 +503,51 @@ static int hisi_lpc_acpi_add_child(struct acpi_device *child, void *data)
 		/* ipmi */
 		{
 			.hid = "IPI0001",
-			.name = "hisi-lpc-ipmi",
+			.pdevinfo = (struct platform_device_info []) {
+				{
+					.parent = hostdev,
+					.fwnode = acpi_fwnode_handle(child),
+
+					.name = "hisi-lpc-ipmi",
+					.id = PLATFORM_DEVID_AUTO,
+
+					.res = res,
+					.num_res = num_res,
+				},
+			},
 		},
 		/* 8250-compatible uart */
 		{
 			.hid = "HISI1031",
-			.name = "serial8250",
-			.pdata = (struct plat_serial8250_port []) {
+			.pdevinfo = (struct platform_device_info []) {
 				{
-					.iobase = res->start,
-					.uartclk = 1843200,
-					.iotype = UPIO_PORT,
-					.flags = UPF_BOOT_AUTOCONF,
+					.parent = hostdev,
+					.fwnode = acpi_fwnode_handle(child),
+
+					.name = "serial8250",
+					.id = PLATFORM_DEVID_AUTO,
+
+					.res = res,
+					.num_res = num_res,
+
+					.data = (struct plat_serial8250_port []) {
+						{
+							.iobase = res->start,
+							.uartclk = 1843200,
+							.iotype = UPIO_PORT,
+							.flags = UPF_BOOT_AUTOCONF,
+						},
+						{}
+					},
+					.size_data =  2 *
+						sizeof(struct plat_serial8250_port),
 				},
-				{}
 			},
-			.pdata_size = 2 *
-				sizeof(struct plat_serial8250_port),
 		},
 		{}
 	};
 
-	for (; cell && cell->name; cell++) {
+	for (; cell && cell->hid; cell++) {
 		if (!strcmp(cell->hid, hid)) {
 			found = true;
 			break;
@@ -540,31 +561,12 @@ static int hisi_lpc_acpi_add_child(struct acpi_device *child, void *data)
 		return 0;
 	}
 
-	pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);
+	pdev = platform_device_register_full(cell->pdevinfo);
 	if (!pdev)
 		return -ENOMEM;
 
-	pdev->dev.parent = hostdev;
-	ACPI_COMPANION_SET(&pdev->dev, child);
-
-	ret = platform_device_add_resources(pdev, res, num_res);
-	if (ret)
-		goto fail;
-
-	ret = platform_device_add_data(pdev, cell->pdata, cell->pdata_size);
-	if (ret)
-		goto fail;
-
-	ret = platform_device_add(pdev);
-	if (ret)
-		goto fail;
-
 	acpi_device_set_enumerated(child);
 	return 0;
-
-fail:
-	platform_device_put(pdev);
-	return ret;
 }
 
 /*
-- 
2.35.3

