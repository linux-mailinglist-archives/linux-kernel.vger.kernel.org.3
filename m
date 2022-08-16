Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074B2595AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiHPLzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiHPLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:54:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19876265B;
        Tue, 16 Aug 2022 04:33:46 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6TS55Hhkz67wrC;
        Tue, 16 Aug 2022 19:28:53 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 13:33:44 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 12:33:41 +0100
From:   John Garry <john.garry@huawei.com>
To:     <lenb@kernel.org>, <rafael@kernel.org>, <andy.shevchenko@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH PoC 3/3] bus: hisi_lpc: Use acpi_create_platform_device_ops()
Date:   Tue, 16 Aug 2022 19:27:24 +0800
Message-ID: <1660649244-146842-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
References: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Function acpi_create_platform_device_ops() was added to factor out the
duplicated code to create platform device between ACPI platform device
code and this driver.

Most of the complication added here comes from LPC UART support. To
support the LPC UART, we create a serial platform device. For this we
need to create a structure of plat_serial8250_port data. The specific
complication comes from the fact that the UART iobase in
plat_serial8250_port needs to be fixed up after the resource translation.
As such, we need to provide a pointer to this plat_serial8250_port data
to do the fix up in the xlat callback.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 165 +++++++++++++++++------------------------
 1 file changed, 69 insertions(+), 96 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 2e564803e786..ada1cea1affc 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -390,70 +390,49 @@ static void hisi_lpc_acpi_fixup_child_resource(struct device *hostdev,
  * host-relative address resource.  This function will return the translated
  * logical PIO addresses for each child devices resources.
  */
-static int hisi_lpc_acpi_set_io_res(struct acpi_device *adev,
-				    struct device *hostdev,
-				    const struct resource **res, int *num_res)
+struct hisi_lpc_acpi_cell_data;
+
+struct hisi_lpc_acpi_cell {
+	const char *hid;
+	const char *name;
+	struct hisi_lpc_acpi_cell_data *data;
+	size_t data_size;
+};
+
+struct hisi_lpc_acpi_cell_data {
+	const struct hisi_lpc_acpi_cell *owner;
+	union {
+		struct plat_serial8250_port serial[2];
+	};
+};
+
+int hisi_lpc_acpi_xlat_res(struct acpi_device *adev, struct resource *res,
+			   void *data, size_t data_len)
 {
 	struct acpi_device *host = to_acpi_device(adev->dev.parent);
-	struct resource_entry *rentry;
-	LIST_HEAD(resource_list);
-	struct resource *resources;
-	int count;
-	int i;
-
-	if (!adev->status.present) {
-		dev_dbg(&adev->dev, "device is not present\n");
-		return -EIO;
-	}
+	struct device *dev = &adev->dev;
+	struct device *hostdev = dev->parent;
+	int ret;
 
-	if (acpi_device_enumerated(adev)) {
-		dev_dbg(&adev->dev, "has been enumerated\n");
-		return -EIO;
-	}
+	hisi_lpc_acpi_fixup_child_resource(hostdev, res);
 
-	/*
-	 * The following code segment to retrieve the resources is common to
-	 * acpi_create_platform_device(), so consider a common helper function
-	 * in future.
-	 */
-	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
-	if (count <= 0) {
-		dev_dbg(&adev->dev, "failed to get resources\n");
-		return count ? count : -EIO;
-	}
+	if (!(res->flags & IORESOURCE_IO))
+		return 0;
 
-	resources = devm_kcalloc(hostdev, count, sizeof(*resources),
-				 GFP_KERNEL);
-	if (!resources) {
-		dev_warn(hostdev, "could not allocate memory for %d resources\n",
-			 count);
-		acpi_dev_free_resource_list(&resource_list);
-		return -ENOMEM;
-	}
-	count = 0;
-	list_for_each_entry(rentry, &resource_list, node) {
-		resources[count] = *rentry->res;
-		hisi_lpc_acpi_fixup_child_resource(hostdev, &resources[count]);
-		count++;
-	}
+	ret = hisi_lpc_acpi_xlat_io_res(adev, host, res);
+	if (data_len) {
+		struct hisi_lpc_acpi_cell_data *cell_data = container_of(data,
+				struct hisi_lpc_acpi_cell_data,  serial);
+		const struct hisi_lpc_acpi_cell *cell;
 
-	acpi_dev_free_resource_list(&resource_list);
+		cell = cell_data->owner;
 
-	/* translate the I/O resources */
-	for (i = 0; i < count; i++) {
-		int ret;
+		if (!strcmp(cell->hid, "HISI1031")) {
+			struct plat_serial8250_port *serial = data;
 
-		if (!(resources[i].flags & IORESOURCE_IO))
-			continue;
-		ret = hisi_lpc_acpi_xlat_io_res(adev, host, &resources[i]);
-		if (ret) {
-			dev_err(&adev->dev, "translate IO range %pR failed (%d)\n",
-				&resources[i], ret);
-			return ret;
+			serial->iobase = res->start;
 		}
 	}
-	*res = resources;
-	*num_res = count;
 
 	return 0;
 }
@@ -470,13 +449,6 @@ static int hisi_lpc_acpi_clear_enumerated(struct acpi_device *adev, void *not_us
 	return 0;
 }
 
-struct hisi_lpc_acpi_cell {
-	const char *hid;
-	const char *name;
-	void *pdata;
-	size_t pdata_size;
-};
-
 static void hisi_lpc_acpi_remove(struct device *hostdev)
 {
 	device_for_each_child(hostdev, NULL, hisi_lpc_acpi_remove_subdev);
@@ -490,15 +462,16 @@ static int hisi_lpc_acpi_add_child(struct acpi_device *child, void *data)
 	struct device *hostdev = data;
 	const struct hisi_lpc_acpi_cell *cell;
 	struct platform_device *pdev;
-	const struct resource *res;
 	bool found = false;
-	int num_res;
-	int ret;
 
-	ret = hisi_lpc_acpi_set_io_res(child, hostdev, &res, &num_res);
-	if (ret) {
-		dev_warn(hostdev, "set resource fail (%d)\n", ret);
-		return ret;
+	if (!child->status.present) {
+		dev_err(&child->dev, "device is not present\n");
+		return -EIO;
+	}
+
+	if (acpi_device_enumerated(child)) {
+		dev_err(&child->dev, "has been enumerated\n");
+		return -EIO;
 	}
 
 	cell = (struct hisi_lpc_acpi_cell []){
@@ -511,16 +484,21 @@ static int hisi_lpc_acpi_add_child(struct acpi_device *child, void *data)
 		{
 			.hid = "HISI1031",
 			.name = "serial8250",
-			.pdata = (struct plat_serial8250_port []) {
+			.data = (struct hisi_lpc_acpi_cell_data []) {
 				{
-					.iobase = res->start,
-					.uartclk = 1843200,
-					.iotype = UPIO_PORT,
-					.flags = UPF_BOOT_AUTOCONF,
+					.serial = {
+						{
+						//	.iobase to be set after xlat'ing resources
+							.uartclk = 1843200,
+							.iotype = UPIO_PORT,
+							.flags = UPF_BOOT_AUTOCONF,
+						},
+						{}
+					},
 				},
 				{}
 			},
-			.pdata_size = 2 *
+			.data_size = 2 *
 				sizeof(struct plat_serial8250_port),
 		},
 		{}
@@ -540,31 +518,26 @@ static int hisi_lpc_acpi_add_child(struct acpi_device *child, void *data)
 		return 0;
 	}
 
-	pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);
-	if (!pdev)
-		return -ENOMEM;
-
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
+	if (cell->data) {
+		struct hisi_lpc_acpi_cell_data *cell_data = cell->data;
+		struct plat_serial8250_port *data = cell_data->serial;
+
+		cell_data->owner = cell;
+		pdev = acpi_create_platform_device_ops(child, cell->name, NULL,
+						       data, cell->data_size,
+						       hisi_lpc_acpi_xlat_res,
+						       PLATFORM_DEVID_AUTO);
+	} else {
+		pdev = acpi_create_platform_device_ops(child, cell->name, NULL,
+						       NULL, 0,
+						       hisi_lpc_acpi_xlat_res,
+						       PLATFORM_DEVID_AUTO);
+	}
 
-	ret = platform_device_add(pdev);
-	if (ret)
-		goto fail;
+	if (IS_ERR_OR_NULL(pdev))
+		return -ENOMEM;
 
-	acpi_device_set_enumerated(child);
 	return 0;
-
-fail:
-	platform_device_put(pdev);
-	return ret;
 }
 
 /*
-- 
2.35.3

