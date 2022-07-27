Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F2C582222
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiG0I3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiG0I3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:29:18 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F35F459A2;
        Wed, 27 Jul 2022 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658910557; x=1690446557;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=iTamDCOH/9WmaX6NdcA+gYUfOkf4snb7Ud8mOkqbfFk=;
  b=AxR2nJRfG9LnfZr1d6aLNA/Yb6LCnpT8r+670zpA+f+aPRWtpf5F58NS
   HCREXg0xP2pTEgReG96Fk4Xp/9/NE5hlyrXz9OtDj0Z52wrxPiQXzOoBT
   UbSdbOo5ni4uS2FEMNO5JwvXdFHgCkHi929TQd9e5tofpG3l+wJyIVGNE
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jul 2022 01:29:16 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 01:29:16 -0700
Received: from hu-cchinnad-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 01:29:14 -0700
From:   Chetan C R <quic_cchinnad@quicinc.com>
To:     <jejb@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Chetan C R <quic_cchinnad@quicinc.com>
Subject: [PATCH V1] scsi: ufs: Get boot device storage type from command line
Date:   Wed, 27 Jul 2022 13:58:55 +0530
Message-ID: <1658910535-31802-1-git-send-email-quic_cchinnad@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the boot device storage type by reading it from
kernel command line arguments and export the same
information to ufs modules.

Signed-off-by: Chetan C R <quic_cchinnad@quicinc.com>
---
 drivers/ufs/Kconfig            |  1 +
 drivers/ufs/host/Kconfig       |  9 +++++++
 drivers/ufs/host/Makefile      |  1 +
 drivers/ufs/host/ufs-cmdline.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)
 create mode 100644 drivers/ufs/host/ufs-cmdline.c

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 90226f7..9d2f84e 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -9,6 +9,7 @@ menuconfig SCSI_UFSHCD
 	select PM_DEVFREQ
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select NLS
+	select UFS_QCOM_CMDLINE if ARCH_QCOM
 	help
 	  Enables support for UFS (Universal Flash Storage) host controllers.
 	  A UFS host controller is an electronic component that is able to
diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
index 8259022..6197070 100644
--- a/drivers/ufs/host/Kconfig
+++ b/drivers/ufs/host/Kconfig
@@ -68,6 +68,15 @@ config SCSI_UFS_QCOM
 	  Select this if you have UFS controller on QCOM chipset.
 	  If unsure, say N.
 
+config UFS_QCOM_CMDLINE
+	bool "Get the boot device type from kernel command line for Qcom devices"
+	help
+	  This selects the support of getting the boot device storage type
+	  from kernel command line arguments and export this information
+	  to the Qcom UFS controller platform driver.
+
+	  If unsure, say N.
+
 config SCSI_UFS_MEDIATEK
 	tristate "Mediatek specific hooks to UFS controller platform driver"
 	depends on SCSI_UFSHCD_PLATFORM && ARCH_MEDIATEK
diff --git a/drivers/ufs/host/Makefile b/drivers/ufs/host/Makefile
index e4be542..a9463f1 100644
--- a/drivers/ufs/host/Makefile
+++ b/drivers/ufs/host/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) += cdns-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_QCOM) += ufs_qcom.o
 ufs_qcom-y += ufs-qcom.o
 ufs_qcom-$(CONFIG_SCSI_UFS_CRYPTO) += ufs-qcom-ice.o
+obj-$(CONFIG_UFS_QCOM_CMDLINE)          += ufs-cmdline.o
 obj-$(CONFIG_SCSI_UFS_EXYNOS) += ufs-exynos.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
diff --git a/drivers/ufs/host/ufs-cmdline.c b/drivers/ufs/host/ufs-cmdline.c
new file mode 100644
index 0000000..408755c
--- /dev/null
+++ b/drivers/ufs/host/ufs-cmdline.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <linux/string.h>
+
+#ifdef CONFIG_BOOT_CONFIG
+#include <linux/bootconfig.h>
+#endif
+
+#define ANDROID_BOOT_DEV_MAX_V3    30
+
+static char android_boot_dev_v3[ANDROID_BOOT_DEV_MAX_V3];
+static const char *android_boot_dev_v4;
+
+const char *get_storage_boot_device(void)
+{
+	if (android_boot_dev_v4 && strlen(android_boot_dev_v4))
+		return android_boot_dev_v4;
+
+	else if (strlen(android_boot_dev_v3))
+		return android_boot_dev_v3;
+
+	pr_err("Not able to get Bootconfig or Kernel command line param\n");
+	return NULL;
+};
+EXPORT_SYMBOL_GPL(get_storage_boot_device);
+
+/* boot image header version 3 android boot device type */
+static int __init get_android_boot_dev_v3(char *str)
+{
+	strscpy(android_boot_dev_v3, str, ANDROID_BOOT_DEV_MAX_V3);
+	return 1;
+}
+__setup("androidboot.bootdevice=", get_android_boot_dev_v3);
+
+#ifdef CONFIG_BOOT_CONFIG
+/* boot image header version 4 android boot device type */
+static int __init get_android_boot_dev_v4(void)
+{
+	struct xbc_node *vnode = NULL;
+
+	android_boot_dev_v4 = xbc_find_value("androidboot.bootdevice", &vnode);
+
+	if (vnode && xbc_node_is_array(vnode))
+		xbc_array_for_each_value(vnode, android_boot_dev_v4);
+
+	return 0;
+}
+fs_initcall(get_android_boot_dev_v4);
+#endif
-- 
2.7.4

