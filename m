Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36B572CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiGMEzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiGMEzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:55:20 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E97B30F74
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:55:19 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220713045518epoutp016c35c0887d5d261b51481fa3b2422501~BSo_EbEj11478414784epoutp01F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:55:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220713045518epoutp016c35c0887d5d261b51481fa3b2422501~BSo_EbEj11478414784epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657688118;
        bh=e6KcPjiX/fgjZDAK7r7t1afM/SZiXxWdwJOwmvqIWiw=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Yhc0QItsdqYb4TV6Kzxtwh4YtHKW5xcmgP9X9iLFS/yxlFShmGqcSS/fvFWi/rIy0
         uJtACfTKPFCGZT+mRvpilmTFFFZPHKc/EQId1z1GbbqKJKSO1efOQVYjhKV2ruTbwp
         54ACYViO3i1xCvYiHO5UwsCuDLsmDyTyRSPKPFmY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220713045517epcas1p1381270ef36be2e290921db8bba7bdd40~BSo9XYOe31982019820epcas1p1U;
        Wed, 13 Jul 2022 04:55:17 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LjQKc5BFJz4x9QD; Wed, 13 Jul
        2022 04:55:16 +0000 (GMT)
X-AuditID: b6c32a38-597ff700000027db-e7-62ce50344fa8
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.75.10203.4305EC26; Wed, 13 Jul 2022 13:55:16 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 2/4] firmware: Samsung: Add secure monitor driver
Reply-To: dj76.yang@samsung.com
Sender: Dongjin Yang <dj76.yang@samsung.com>
From:   Dongjin Yang <dj76.yang@samsung.com>
To:     "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
Date:   Wed, 13 Jul 2022 13:55:16 +0900
X-CMS-MailID: 20220713045516epcms1p86b3f6a8795d767faac65eb947405f911
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmnq5JwLkkg5nPVSxO73/HYvHykKbF
        /CPnWC12z1jOZDFz6hlmi4XTljNaPD80i9ni5ax7bBZH3nxktrj/9Sijxf7jK5ksLu+aw2Zx
        bnGmReveI+wWdw6fZXHg97i+LsBj06pONo871/awebzfd5XNo2/LKkaPz5vkAtiism0yUhNT
        UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5WUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn9E0+xFyw
        17Fi4o3DTA2Mz027GDk5JARMJOZOncXSxcjFISSwg1Gi+dBl9i5GDg5eAUGJvzuEQWqEBRwl
        dq+cDBYWEpCX+DyxEiKsI9Hx9ikLSJhNQEtidn8iyBQRgc+MEo+3PWYHcZgFjjBLNByZywax
        i1diRjtIA4gtLbF9+VZGCFtD4seyXmYIW1Ti5uq37DD2+2PzoWpEJFrvnYWqEZR48HM3VFxK
        4lHzASi7WuJcey/YYgmBBkaJg583soFcJyGgL7HjujFIDa+Ar8SXZe+YQGwWAVWJWZf+MEKU
        uEhMO+AHEmYGenH72znMIGFmAU2J9bv0ISqUJY7cYoF5pGHjb3Z0NrMAn8S7rz2sMPEd854w
        QdjKEp+bX0P1SkosnjyTeQKj0ixEMM9CsncWwt4FjMyrGMVSC4pz01OLDQtM4DGbnJ+7iRGc
        cLUsdjDOfftB7xAjEwfjIUYJDmYlEd4/Z08lCfGmJFZWpRblxxeV5qQWH2I0BXp4IrOUaHI+
        MOXnlcQbmlgamJgZmZoaGliYKInz9k49nSgkkJ5YkpqdmlqQWgTTx8TBKdXANM+BL8CXXzLw
        8uxsN2EhbSYHVYn9BiJ9H/h2LeWp07rXG5PDK/z0SPyfv4nrZz78sEj/aWbJ1leLBV9bzj2Y
        JvF253nLO513RZof8n0P/p70sOWtRpCyxTQr/oL91ra5hxiadomF3I6SeXP9Y1rB2adpW0vU
        bI6qCqasjz199v0Vb2H23wkfAo5sd+VScU+u8rbsZDn07ev9v/zT9a+EnTPRak1ev1rAxqOg
        V1x8ltuJM/PezF58U/iqaGadUF9O84mHebrbdTafeuizWP7etOrNehHLHsRdeXXI9d0kpyv3
        xcrWfG85wrjaVC/QWujW1gOT9Cqclnkr9332ncf2/lfIaje5NTe/Me991Oi/QImlOCPRUIu5
        qDgRAGulMWdBBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713045516epcms1p86b3f6a8795d767faac65eb947405f911
References: <CGME20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver to provide calls into secure monitor mode.
This driver is used for SoCs produced by Samsung Foundry to provide
SMC call. This patch supports register read/write request to secure
monitor. Also, SMC call request which uses shared memory to exchange
the data between kernel and secure monitor.

Signed-off-by: Dongjin Yang <dj76.yang@samsung.com>
---
 MAINTAINERS                              |   2 +
 drivers/firmware/Kconfig                 |  11 +++
 drivers/firmware/Makefile                |   1 +
 drivers/firmware/samsung-smc-svc.c       | 154 +++++++++++++++++++++++++++++++
 include/linux/firmware/samsung-smc-svc.h |  59 ++++++++++++
 5 files changed, 227 insertions(+)
 create mode 100644 drivers/firmware/samsung-smc-svc.c
 create mode 100644 include/linux/firmware/samsung-smc-svc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6763746c349f..d173043ffb46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1868,8 +1868,10 @@ F:	arch/arm/boot/dts/artpec6*
 F:	arch/arm/mach-artpec
 F:	drivers/clk/axis
 F:	drivers/crypto/axis
+F:	drivers/firmware/samsung-smc-svc.c
 F:	drivers/mmc/host/usdhi6rol0.c
 F:	drivers/pinctrl/pinctrl-artpec*
+F:	include/linux/firmware/samsung-smc-svc.h
 
 ARM/ASPEED I2C DRIVER
 M:	Brendan Higgins <brendanhiggins@google.com>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index e5cfb01353d8..4b0f2d033f58 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -217,6 +217,17 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 
 	  Say Y here to enable "download mode" by default.
 
+config SAMSUNG_SECURE_SERVICE
+	bool "Samsung Foundry Secure Service Layer"
+	depends on HAVE_ARM_SMCCC
+	default n
+	help
+	  Support secure service layer for SoCs which is manufactured by
+	  Samsung Foundry.
+
+	  This option provide support of secure monitor service call using
+	  Trusted Foundations.
+
 config SYSFB
 	bool
 	default y
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4e58cb474a68..985e30a9665f 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
 qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_SAMSUNG_SECURE_SERVICE) += samsung-smc-svc.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
diff --git a/drivers/firmware/samsung-smc-svc.c b/drivers/firmware/samsung-smc-svc.c
new file mode 100644
index 000000000000..eb3a5285cf2b
--- /dev/null
+++ b/drivers/firmware/samsung-smc-svc.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Samsung Electronics Co., Ltd.
+ * Author: Kihyun Yoon<kihyun.yoon@samsung.com>
+ * Author: Dongjin Yang<dj76.yang@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/samsung-smc-svc.h>
+
+struct samsung_smc_version {
+	u32 major;
+	u32 minor;
+};
+
+struct samsung_smc_data {
+	struct samsung_smc_version version;
+	u32 svc_cmd_list[SAMSUNG_SIP_NR_SIP];
+};
+
+struct samsung_smc_data *svc_data;
+
+static int samsung_smc_svc_init(void);
+
+static int __samsung_get_svc_cmd(u32 cmd_idx)
+{
+	if (cmd_idx >= SAMSUNG_SIP_NR_SIP)
+		return SAMSUNG_SIP_NOT_SUPPORTED;
+
+	/* Initialize this driver if it is not ready */
+	if (!svc_data && samsung_smc_svc_init()) {
+		pr_err("samsung,smccc_service initialization is failed\n");
+		return SAMSUNG_SIP_NOT_SUPPORTED;
+	}
+
+	return svc_data->svc_cmd_list[cmd_idx];
+}
+
+int samsung_smc_call(u32 cmd_idx,
+		     unsigned long a0, unsigned long a1,
+		     unsigned long a2, unsigned long a3,
+		     u32 *val)
+
+{
+	struct arm_smccc_res res;
+	u32 cmd = __samsung_get_svc_cmd(cmd_idx);
+
+	if (cmd == SAMSUNG_SIP_NOT_SUPPORTED)
+		return -EOPNOTSUPP;
+
+	arm_smccc_smc(cmd, a0, a1, a2, a3, 0, 0, 0, &res);
+	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
+		return -EINVAL;
+
+	if (val)
+		*val = (u32)res.a1;
+
+	return 0;
+}
+EXPORT_SYMBOL(samsung_smc_call);
+
+int samsung_smc_reg_read(void *base, u32 reg, u32 *val)
+{
+	return samsung_smc_call(SAMSUNG_SIP_READ_REG,
+				(unsigned long)base, reg, 0, 0, val);
+}
+EXPORT_SYMBOL(samsung_smc_reg_read);
+
+int samsung_smc_reg_write(void *base, u32 reg, u32 val)
+{
+	return samsung_smc_call(SAMSUNG_SIP_WRITE_REG,
+				  (unsigned long)base, reg, val, 0, NULL);
+}
+EXPORT_SYMBOL(samsung_smc_reg_write);
+
+static int samsung_smc_check_version(struct samsung_smc_version *ver)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SAMSUNG_SIP_SVC_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	if ((u32)res.a0 != ver->major || (u32)res.a1 != ver->minor)
+		return -EINVAL;
+
+	pr_info("Samsung SVC version [%d.%d] is detected\n",
+		ver->major, ver->minor);
+
+	return 0;
+}
+
+static const struct samsung_smc_data svc_0_1 = {
+	.version = {
+		.major = 0,
+		.minor = 1
+	},
+	.svc_cmd_list = {
+		[SAMSUNG_SIP_READ_REG] = 0x82000020,
+		[SAMSUNG_SIP_WRITE_REG] = 0x82000021,
+		/* TODO: SMC call for clock driver should be added */
+	}
+};
+
+static const struct of_device_id samsung_smc_of_match[] = {
+	{ .compatible = "samsung,smccc-svc", .data = &svc_0_1 },
+	{ /* sentinel */ }
+};
+
+static int samsung_smc_svc_init(void)
+{
+	struct device_node *fw_np;
+	struct device_node *np;
+	const struct of_device_id *match;
+	int ret;
+
+	if (svc_data) {
+		pr_info("samsung,smccc_service is already initialized\n");
+		return 0;
+	}
+
+	fw_np = of_find_node_by_name(NULL, "firmware");
+	if (!fw_np)
+		return -ENODEV;
+
+	np = of_find_matching_node_and_match(fw_np, samsung_smc_of_match,
+					     &match);
+	if (!np)
+		return -ENODEV;
+
+	svc_data = (struct samsung_smc_data *)match->data;
+	if (!svc_data)
+		return -ENODEV;
+
+	ret = samsung_smc_check_version(&svc_data->version);
+	if (ret) {
+		pr_err("samsung svc version is not matched\n");
+		return ret;
+	}
+
+	pr_info("samsung smc svc is initialized\n");
+	return 0;
+}
+
+early_initcall(samsung_smc_svc_init);
diff --git a/include/linux/firmware/samsung-smc-svc.h b/include/linux/firmware/samsung-smc-svc.h
new file mode 100644
index 000000000000..9c94fd3e10a2
--- /dev/null
+++ b/include/linux/firmware/samsung-smc-svc.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SAMSUNG_SMC_H
+#define __SAMSUNG_SMC_H
+
+#include <linux/arm-smccc.h>
+
+#ifdef CONFIG_SAMSUNG_SECURE_SERVICE
+
+#define SAMSUNG_SIP_CALL_VAL(x) \
+		ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+		ARM_SMCCC_SMC_32, ARM_SMCCC_OWNER_SIP, x)
+
+/* Common SIP SVC number */
+#define SAMSUING_SIP_SVC_CALL_COUNT	SAMSUNG_SIP_CALL_VAL(0xff00)
+#define SAMSUING_SIP_SVC_UID		SAMSUNG_SIP_CALL_VAL(0xff01)
+#define SAMSUNG_SIP_SVC_VERSION		SAMSUNG_SIP_CALL_VAL(0xff03)
+#define SAMSUNG_SIP_NOT_SUPPORTED	0x0
+
+enum {
+	/* SIP enumeration for V0.1 */
+	SAMSUNG_SIP_READ_REG,
+	SAMSUNG_SIP_WRITE_REG,
+	/* Add here for later version */
+	SAMSUNG_SIP_NR_SIP
+};
+
+int samsung_smc_call(u32 cmd_idx,
+		     unsigned long a0, unsigned long a1,
+		     unsigned long a2, unsigned long a3,
+		     u32 *val);
+int samsung_smc_reg_read(void *addr, unsigned int reg, u32 *val);
+int samsung_smc_reg_write(void *addr, unsigned int reg, u32 val);
+
+#else
+
+static inline int samsung_smc_call(u32 cmd_idx,
+				   unsigned long a0, unsigned long a1,
+				   unsigned long a2, unsigned long a3,
+				   u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int samsung_smc_reg_read(void *base,
+				       unsigned int reg, u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int samsung_smc_reg_write(void *base,
+					unsigned int reg, u32 val)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
+
+#endif /* __SAMSUNG_SMC_H */
-- 
2.9.5
