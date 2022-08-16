Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890A595AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiHPLzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiHPLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:54:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA394F6F;
        Tue, 16 Aug 2022 04:33:43 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6TS335HDz67wK2;
        Tue, 16 Aug 2022 19:28:51 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 13:33:41 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 12:33:39 +0100
From:   John Garry <john.garry@huawei.com>
To:     <lenb@kernel.org>, <rafael@kernel.org>, <andy.shevchenko@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH PoC 2/3] ACPI: platform: Refactor acpi_create_platform_device()
Date:   Tue, 16 Aug 2022 19:27:23 +0800
Message-ID: <1660649244-146842-3-git-send-email-john.garry@huawei.com>
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

There is commonality between acpi_create_platform_device() and
hisi_lpc_acpi_add_child(), in that it covers 2x main steps:
- Read resources for the acpi_device
- Create platform device

Refactor acpi_create_platform_device() so that it may be reused by
hisi_lpc_acpi_add_child() to reduce duplication.

The following extended support is added:
- Allow custom platform device name be set
- Support platform data
- Support custom platform device id
- Support translating resources for Indirect PIO

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/acpi/acpi_platform.c | 37 ++++++++++++++++++++++++++++--------
 include/linux/acpi.h         | 17 +++++++++++++++--
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index de3cbf152dee..f153372a0b11 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -84,9 +84,14 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
 }
 
 /**
- * acpi_create_platform_device - Create platform device for ACPI device node
+ * acpi_create_platform_device_ops - Create platform device for ACPI device node
  * @adev: ACPI device node to create a platform device for.
+ * @name: Name for platform device, may be unset
  * @properties: Optional collection of build-in properties.
+ * @data: platform data pointer
+ * @size_data: platform data size
+ * @xlat: callback translate function for resources
+ * @id: platform device id
  *
  * Check if the given @adev can be represented as a platform device and, if
  * that's the case, create and register a platform device, populate its common
@@ -94,8 +99,15 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
  *
  * Name of the platform device will be the same as @adev's.
  */
-struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
-						    const struct property_entry *properties)
+struct platform_device *acpi_create_platform_device_ops(
+					struct acpi_device *adev,
+					const char *name,
+					const struct property_entry *properties,
+					void *data, size_t size_data,
+					int (*xlat)(struct acpi_device *adev,
+						    struct resource *res,
+						    void *data, size_t size_data),
+					int id)
 {
 	struct platform_device *pdev = NULL;
 	struct platform_device_info pdevinfo;
@@ -124,9 +136,13 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 			return ERR_PTR(-ENOMEM);
 		}
 		count = 0;
-		list_for_each_entry(rentry, &resource_list, node)
+		list_for_each_entry(rentry, &resource_list, node) {
 			acpi_platform_fill_resource(adev, rentry->res,
-						    &resources[count++]);
+						    &resources[count]);
+			if (xlat)
+				xlat(adev, &resources[count], data, size_data);
+			count++;
+		}
 
 		acpi_dev_free_resource_list(&resource_list);
 	}
@@ -139,12 +155,17 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	 */
 	pdevinfo.parent = adev->parent ?
 		acpi_get_first_physical_node(adev->parent) : NULL;
-	pdevinfo.name = dev_name(&adev->dev);
-	pdevinfo.id = -1;
+	if (name)
+		pdevinfo.name = name;
+	else
+		pdevinfo.name = dev_name(&adev->dev);
+	pdevinfo.id = id;
 	pdevinfo.res = resources;
 	pdevinfo.num_res = count;
 	pdevinfo.fwnode = acpi_fwnode_handle(adev);
 	pdevinfo.properties = properties;
+	pdevinfo.data = data;
+	pdevinfo.size_data = size_data;
 
 	if (acpi_dma_supported(adev))
 		pdevinfo.dma_mask = DMA_BIT_MASK(32);
@@ -165,7 +186,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 
 	return pdev;
 }
-EXPORT_SYMBOL_GPL(acpi_create_platform_device);
+EXPORT_SYMBOL_GPL(acpi_create_platform_device_ops);
 
 void __init acpi_platform_init(void)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f64b2f3dc54..d657731086fd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -28,6 +28,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -721,8 +722,20 @@ extern bool acpi_driver_match_device(struct device *dev,
 int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
 int acpi_device_modalias(struct device *, char *, int);
 
-struct platform_device *acpi_create_platform_device(struct acpi_device *,
-						    const struct property_entry *);
+struct platform_device *acpi_create_platform_device_ops(
+				struct acpi_device *adev,
+				const char *name,
+				const struct property_entry *properties,
+				void *data, size_t size_data,
+				int (*xlat)(struct acpi_device *adev,
+					    struct resource *res,
+					    void *data, size_t size_data),
+				int id);
+
+#define acpi_create_platform_device(adev, properties) \
+	acpi_create_platform_device_ops(adev, NULL, properties, NULL, 0, \
+					NULL, PLATFORM_DEVID_NONE)
+
 #define ACPI_PTR(_ptr)	(_ptr)
 
 static inline void acpi_device_set_enumerated(struct acpi_device *adev)
-- 
2.35.3

