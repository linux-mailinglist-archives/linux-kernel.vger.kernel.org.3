Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FE14C1FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244942AbiBWXin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244885AbiBWXi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:38:28 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814B45A597;
        Wed, 23 Feb 2022 15:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645659477; x=1677195477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+MRbB5DRgFvuMH3fvObVcrNFhjluEvf0jPhElKZgs1w=;
  b=gi+qzBsaFfqENBDMIaAUscS6RffAlP1N+78FKmTntti2oP9hI04z0kZm
   nC0BJuyWrdq2AnKwfw6F1ogyVgCk3oWqolT8i302cHYrBUff4IcWfd8bH
   DzYFOU8MqQRerlSboYYwjogmD4f64pamb+LvC1DgNwU5PIUXI8z1GcA8f
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Feb 2022 15:37:57 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:37:57 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 15:37:56 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 05/11] virt: gunyah: Add sysfs nodes
Date:   Wed, 23 Feb 2022 15:37:23 -0800
Message-ID: <20220223233729.1571114-6-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223233729.1571114-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /sys/hypervisor support when detecting that Linux is running in a
Gunyah environment. Export the version of Gunyah which is reported via
the hyp_identify hypercall.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../ABI/testing/sysfs-hypervisor-gunyah       |  37 ++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/include/asm/gunyah/hypercall.h     |   2 +
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/gunyah/Kconfig                   |  13 ++
 drivers/virt/gunyah/Makefile                  |   4 +
 drivers/virt/gunyah/sysfs.c                   | 116 ++++++++++++++++++
 8 files changed, 177 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-hypervisor-gunyah
 create mode 100644 drivers/virt/gunyah/Kconfig
 create mode 100644 drivers/virt/gunyah/Makefile
 create mode 100644 drivers/virt/gunyah/sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-hypervisor-gunyah b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
new file mode 100644
index 000000000000..ebbdd0aead7b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
@@ -0,0 +1,37 @@
+What:		/sys/hypervisor/type
+Date:		January 2022
+KernelVersion:	5.17
+Contact:	linux-arm-msm@vger.kernel.org
+Description:	If running under Gunyah:
+		Type of hypervisor:
+		"gunyah": Gunyah hypervisor
+
+What:		/sys/hypervisor/features
+Date:		January 2022
+KernelVersion:	5.17
+Contact:	linux-arm-msm@vger.kernel.org
+Description:	If running under Gunyah:
+		Space separated list of features supported by Linux and Gunyah:
+		"cspace": Gunyah devices
+		"doorbell": Sending/receiving virtual interrupts via Gunyah doorbells
+		"message-queue": Sending/receiving messages via Gunyah message queues
+		"vic": Interrupt lending
+		"vpm": Virtual platform management
+		"vcpu": Virtual CPU management
+		"memextent": Memory lending/management
+		"trace": Gunyah hypervisor tracing
+
+
+What:		/sys/hypervisor/version/api
+Date:		April 2020
+KernelVersion:	5.17
+Contact:	linux-arm-msm@vger.kernel.org
+Description:	If running under Gunyah:
+		The Gunyah API version.
+
+What:		/sys/hypervisor/version/variant
+Date:		April 2020
+KernelVersion:	5.17
+Contact:	linux-arm-msm@vger.kernel.org
+Description:	If running under Gunyah:
+		The Gunyah variant (build) version.
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index 59e7070f726a..10c59c8767ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8400,9 +8400,11 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
 M:	Murali Nalajala <quic_mnalajal@quicinc.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-hypervisor-gunyah
 F:	Documentation/devicetree/bindings/gunyah/
 F:	Documentation/virt/gunyah/
 F:	arch/arm64/include/asm/gunyah/
+F:	drivers/virt/gunyah/
 F:	include/linux/gunyah.h
 
 H8/300 ARCHITECTURE
diff --git a/arch/arm64/include/asm/gunyah/hypercall.h b/arch/arm64/include/asm/gunyah/hypercall.h
index 626163500e32..a8e68ece074e 100644
--- a/arch/arm64/include/asm/gunyah/hypercall.h
+++ b/arch/arm64/include/asm/gunyah/hypercall.h
@@ -7,6 +7,8 @@
 
 #include <linux/types.h>
 
+#define GH_HYPERCALL_HYP_IDENTIFY		0x6000
+
 #define ___gh_count_args(_0, _1, _2, _3, _4, _5, _6, _7, _8, x, ...) x
 
 #define __gh_count_args(...)						\
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 8061e8ef449f..823663d67a95 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -36,4 +36,6 @@ source "drivers/virt/vboxguest/Kconfig"
 source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
+
+source "drivers/virt/gunyah/Kconfig"
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 3e272ea60cd9..ca2141b6837e 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
 obj-y				+= vboxguest/
+obj-$(CONFIG_GUNYAH)		+= gunyah/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
new file mode 100644
index 000000000000..e88289963518
--- /dev/null
+++ b/drivers/virt/gunyah/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config GUNYAH
+	tristate "Gunyah Virtualization drivers"
+	depends on ARM64
+	select SYS_HYPERVISOR
+	help
+	  The Gunyah drivers are the helper interfaces that runs in a guest VM
+	  such as basic inter-VM IPC and signaling mechanism,s and higher level
+	  services such as memory/device sharing, IRQ sharing, and so on.
+
+	  Say Y here to enable the drivers needed to interact in a Gunyah
+	  virtual environment.
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
new file mode 100644
index 000000000000..0aa086f9149f
--- /dev/null
+++ b/drivers/virt/gunyah/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+gunyah-y += sysfs.o
+obj-$(CONFIG_GUNYAH) += gunyah.o
\ No newline at end of file
diff --git a/drivers/virt/gunyah/sysfs.c b/drivers/virt/gunyah/sysfs.c
new file mode 100644
index 000000000000..3d22f08360db
--- /dev/null
+++ b/drivers/virt/gunyah/sysfs.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gunyah: " fmt
+
+#include <linux/kobject.h>
+#include <linux/gunyah.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/of.h>
+
+#include "gunyah_private.h"
+
+#define GH_API_INFO_API_VERSION(x)	(((x) >> 0) & 0x3fff)
+#define GH_API_INFO_BIG_ENDIAN(x)	(((x) >> 14) & 1)
+#define GH_API_INFO_IS_64BIT(x)		(((x) >> 15) & 1)
+#define GH_API_INFO_VARIANT(x)		(((x) >> 56) & 0xff)
+
+#define GH_IDENTIFY_PARTITION_CSPACE(flags)	(((flags)[0] >> 0) & 1)
+#define GH_IDENTIFY_DOORBELL(flags)		(((flags)[0] >> 1) & 1)
+#define GH_IDENTIFY_MSGQUEUE(flags)		(((flags)[0] >> 2) & 1)
+#define GH_IDENTIFY_VIC(flags)			(((flags)[0] >> 3) & 1)
+#define GH_IDENTIFY_VPM(flags)			(((flags)[0] >> 4) & 1)
+#define GH_IDENTIFY_VCPU(flags)			(((flags)[0] >> 5) & 1)
+#define GH_IDENTIFY_MEMEXTENT(flags)		(((flags)[0] >> 6) & 1)
+#define GH_IDENTIFY_TRACE_CTRL(flags)		(((flags)[0] >> 7) & 1)
+
+struct gh_hypercall_hyp_identify_resp {
+	u64 api_info;
+	u64 flags[3];
+};
+
+static struct gh_hypercall_hyp_identify_resp gunyah_api;
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
+{
+	return sysfs_emit(buffer, "gunyah\n");
+}
+static struct kobj_attribute type_attr = __ATTR_RO(type);
+
+static ssize_t api_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
+{
+	return sysfs_emit(buffer, "%d\n", (int)GH_API_INFO_API_VERSION(gunyah_api.api_info));
+}
+static struct kobj_attribute api_attr = __ATTR_RO(api);
+
+static ssize_t variant_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
+{
+	return sysfs_emit(buffer, "%d\n", (int)GH_API_INFO_VARIANT(gunyah_api.api_info));
+}
+static struct kobj_attribute variant_attr = __ATTR_RO(variant);
+
+static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
+{
+	return sysfs_emit(buffer, "\n");
+}
+static struct kobj_attribute features_attr = __ATTR_RO(features);
+
+static struct attribute *version_attrs[] = {
+	&api_attr.attr,
+	&variant_attr.attr,
+	NULL
+};
+
+static const struct attribute_group version_group = {
+	.name = "version",
+	.attrs = version_attrs,
+};
+
+static int __init gh_sysfs_register(void)
+{
+	int ret;
+
+	ret = sysfs_create_file(hypervisor_kobj, &type_attr.attr);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_group(hypervisor_kobj, &version_group);
+	if (ret)
+		return ret;
+
+	return sysfs_create_file(hypervisor_kobj, &features_attr.attr);
+}
+
+static void gh_sysfs_unregister(void)
+{
+	sysfs_remove_file(hypervisor_kobj, &type_attr.attr);
+	sysfs_remove_group(hypervisor_kobj, &version_group);
+}
+
+static int __init gunyah_init(void)
+{
+	arch_gh_hypercall(GH_HYPERCALL_HYP_IDENTIFY, 0, gunyah_api.api_info,
+		gunyah_api.flags[0], gunyah_api.flags[1], gunyah_api.flags[2]);
+
+	if (GH_API_INFO_API_VERSION(gunyah_api.api_info) != 1) {
+		pr_warn("Unrecognized gunyah version: %llu. Currently supported: 1\n",
+			GH_API_INFO_API_VERSION(gunyah_api.api_info));
+		return 0;
+	}
+
+	return gh_sysfs_register();
+}
+module_init(gunyah_init);
+
+static void __exit gunyah_exit(void)
+{
+	gh_sysfs_unregister();
+}
+module_exit(gunyah_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Gunyah Hypervisor Driver");
-- 
2.25.1

