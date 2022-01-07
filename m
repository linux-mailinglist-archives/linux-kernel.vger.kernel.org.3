Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7222048743E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346126AbiAGIrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:47:11 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31146 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiAGIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:47:08 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JVcGQ0Dxszbbjf;
        Fri,  7 Jan 2022 16:44:30 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 7 Jan 2022 16:47:07 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <linux@armlinux.org.uk>, <vkoul@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [RFC PATCH] ACPI / amba: Skip creating amba device when associated cpu is not online
Date:   Fri, 7 Jan 2022 16:41:46 +0800
Message-ID: <1641544906-7069-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

If not up all the cpus with command line "maxcpus=x", system will be
blocked.
We find that some amba devices such as ETM devices, are associated with
special cpus, and if the cpu is not up, the register of associated device
is not allowed to access. BIOS reports all the ETM device nodes and a
amba device is created for every ETM device, so even if one cpu is not up,
the amba device will still be created for the associated device, and also
the register of device (pid and cid) will be accessed when adding amba
device which will cause the issue.
To fix it, skip creating amba device if it is associated with a cpu which
is not online.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/acpi/acpi_amba.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index ab8a4e0191b1..2369198f734b 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -16,6 +16,7 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <acpi/processor.h>
 
 #include "internal.h"
 
@@ -45,6 +46,35 @@ static void amba_register_dummy_clk(void)
 	clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
 }
 
+static int acpi_handle_to_cpuid(acpi_handle handle)
+{
+	int cpu = -1;
+	struct acpi_processor *pr;
+
+	for_each_possible_cpu(cpu) {
+		pr = per_cpu(processors, cpu);
+		if (pr && pr->handle == handle)
+			break;
+	}
+
+	return cpu;
+}
+
+static int acpi_dev_get_cpu(struct acpi_device *adev)
+{
+	acpi_handle cpu_handle;
+	acpi_status status;
+	int cpu;
+
+	status = acpi_get_parent(adev->handle, &cpu_handle);
+	if (ACPI_FAILURE(status))
+		return -1;
+	cpu = acpi_handle_to_cpuid(cpu_handle);
+	if (cpu >= nr_cpu_ids)
+		return -1;
+	return cpu;
+}
+
 static int amba_handler_attach(struct acpi_device *adev,
 				const struct acpi_device_id *id)
 {
@@ -54,11 +84,17 @@ static int amba_handler_attach(struct acpi_device *adev,
 	bool address_found = false;
 	int irq_no = 0;
 	int ret;
+	int cpu;
 
 	/* If the ACPI node already has a physical device attached, skip it. */
 	if (adev->physical_node_count)
 		return 0;
 
+	/* If the cpu associated with the device is not online, skip it. */
+	cpu = acpi_dev_get_cpu(adev);
+	if (cpu >= 0 && !cpu_online(cpu))
+		return 0;
+
 	dev = amba_device_alloc(dev_name(&adev->dev), 0, 0);
 	if (!dev) {
 		dev_err(&adev->dev, "%s(): amba_device_alloc() failed\n",
-- 
2.33.0

