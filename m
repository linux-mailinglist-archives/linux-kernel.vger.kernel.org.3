Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6633A58CE72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244394AbiHHTOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbiHHTOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:14:07 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386519C38;
        Mon,  8 Aug 2022 12:13:56 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 278JDb5j099712;
        Mon, 8 Aug 2022 14:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659986017;
        bh=KOptCLLgIgmGY8HkqIFdKBHj6kMP9Ouk3FTgMuo9ngE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=phezLYBkqHJh2KYGzJWeFvfvnX48hiSFf93fYOzh0wo6FB8kBka7Bqn6u7/Gt2hP3
         0buteqi/f3TmKlEKgDzIiPqP9aA+q2mHqtkcnnY9it6rqSguOEbGiZ3iLgF5JwtqiD
         awam57Hl8P8VfYPFGi21M0Wzp2ACfj6pjw71ScfA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 278JDbtN040397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Aug 2022 14:13:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 8
 Aug 2022 14:13:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 8 Aug 2022 14:13:37 -0500
Received: from uda0500628.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 278JDaYT054740;
        Mon, 8 Aug 2022 14:13:37 -0500
From:   Daniel Parks <danielrparks@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 6/6] crypto: sa2ul_pka: Add SA2UL PKA driver
Date:   Mon, 8 Aug 2022 14:12:55 -0500
Message-ID: <b16fdaee8bcaaaa25d01c2e981ddf782ccf726b4.1659985696.git.danielrparks@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <cover.1659985696.git.danielrparks@ti.com>
References: <cover.1659985696.git.danielrparks@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device exposes asymmetric crypto primitives rather than complete
operations, and it only supports memory-mapped I/O, and its memory is
only addressable one 32-bit word at a time. As a result, some of the
code might look a little different from other crypto accelerator
drivers.

Signed-off-by: Daniel Parks <danielrparks@ti.com>
---
 drivers/crypto/Kconfig                    |   2 +
 drivers/crypto/Makefile                   |   1 +
 drivers/crypto/sa2ul_pka/Kconfig          |  26 +
 drivers/crypto/sa2ul_pka/Makefile         |   3 +
 drivers/crypto/sa2ul_pka/sa2ul_pka.h      | 135 ++++++
 drivers/crypto/sa2ul_pka/sa2ul_pka_base.c | 564 ++++++++++++++++++++++
 drivers/crypto/sa2ul_pka/sa2ul_pka_dh.c   | 150 ++++++
 drivers/crypto/sa2ul_pka/sa2ul_pka_op.c   | 205 ++++++++
 drivers/crypto/sa2ul_pka/sa2ul_pka_op.h   |  28 ++
 drivers/crypto/sa2ul_pka/sa2ul_pka_rsa.c  | 193 ++++++++
 drivers/crypto/sa2ul_pka/sa2ul_pka_sg.c   | 316 ++++++++++++
 11 files changed, 1623 insertions(+)
 create mode 100644 drivers/crypto/sa2ul_pka/Kconfig
 create mode 100644 drivers/crypto/sa2ul_pka/Makefile
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka.h
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_base.c
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_dh.c
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_op.c
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_op.h
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_rsa.c
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_sg.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 3e6aa319920b..5238e3028ffd 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -816,7 +816,9 @@ config CRYPTO_DEV_SA2UL
 	  K3 devices include a security accelerator engine that may be
 	  used for crypto offload.  Select this if you want to use hardware
 	  acceleration for cryptographic algorithms on these devices.
 
+source "drivers/crypto/sa2ul_pka/Kconfig"
+
 source "drivers/crypto/keembay/Kconfig"
 
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index f81703a86b98..3c66515ded16 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -37,8 +37,9 @@ obj-$(CONFIG_CRYPTO_DEV_QCE) += qce/
 obj-$(CONFIG_CRYPTO_DEV_QCOM_RNG) += qcom-rng.o
 obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rockchip/
 obj-$(CONFIG_CRYPTO_DEV_S5P) += s5p-sss.o
 obj-$(CONFIG_CRYPTO_DEV_SA2UL) += sa2ul.o
+obj-$(CONFIG_CRYPTO_DEV_SA2UL_PKA) += sa2ul_pka/
 obj-$(CONFIG_CRYPTO_DEV_SAHARA) += sahara.o
 obj-$(CONFIG_CRYPTO_DEV_SL3516) += gemini/
 obj-$(CONFIG_ARCH_STM32) += stm32/
 obj-$(CONFIG_CRYPTO_DEV_TALITOS) += talitos.o
diff --git a/drivers/crypto/sa2ul_pka/Kconfig b/drivers/crypto/sa2ul_pka/Kconfig
new file mode 100644
index 000000000000..c4f87b14878e
--- /dev/null
+++ b/drivers/crypto/sa2ul_pka/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_DEV_SA2UL_PKA
+	tristate "Support for TI security accelerator public-key module"
+	depends on CRYPTO_DEV_SA2UL || COMPILE_TEST
+	select ARM64_CRYPTO
+	select CRYPTO_AKCIPHER
+	select CRYPTO_RSA
+	select PACKING
+	select CRYPTO_DH
+	help
+		The K3 security accelerator engine contains a public-key
+		cryptography module. Select this if you want to use hardware
+		acceleration for asymmetric cryptography on these devices. This
+		engine is not available to the Linux cores on most devices; check
+		your device tree if unsure.
+
+config CRYPTO_DEV_SA2UL_PKA_DEBUG
+	bool "Debugging options for TI security accelerator public-key module"
+	depends on CRYPTO_DEV_SA2UL_PKA
+	default n
+	help
+		Enables the module options 'snapshot' and 'poison_mem' to assist
+		in debugging the PKA driver. Choosing "y" will allow the root user
+		to extract cryptographic keys from the driver, so do not enable in
+		a production build.
diff --git a/drivers/crypto/sa2ul_pka/Makefile b/drivers/crypto/sa2ul_pka/Makefile
new file mode 100644
index 000000000000..b5af4597f186
--- /dev/null
+++ b/drivers/crypto/sa2ul_pka/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CRYPTO_DEV_SA2UL_PKA) += sa2ul_pka.o
+sa2ul_pka-objs := sa2ul_pka_base.o sa2ul_pka_sg.o sa2ul_pka_op.o sa2ul_pka_rsa.o sa2ul_pka_dh.o
diff --git a/drivers/crypto/sa2ul_pka/sa2ul_pka.h b/drivers/crypto/sa2ul_pka/sa2ul_pka.h
new file mode 100644
index 000000000000..09e8929b2fa3
--- /dev/null
+++ b/drivers/crypto/sa2ul_pka/sa2ul_pka.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * K3 SA2UL Public Key Accelerator driver
+ *
+ * Copyright (c) 2022 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * Author: Daniel Parks <danielrparks@ti.com>
+ */
+
+#ifndef _K3_SA2UL_PKA_
+#define _K3_SA2UL_PKA_
+
+#include <crypto/akcipher.h>
+#include <crypto/kpp.h>
+#include <linux/scatterlist.h>
+
+/* registers */
+#define PKA_APTR      0x0000
+#define PKA_BPTR      0x0004
+#define PKA_CPTR      0x0008
+#define PKA_DPTR      0x000c
+#define PKA_ALENGTH   0x0010
+#define PKA_BLENGTH   0x0014
+#define PKA_SHIFT     0x0018
+#define PKA_FUNCTION  0x001c
+#define PKA_COMPARE   0x0020
+#define PKA_MSW       0x0024
+#define PKA_DIVMSW    0x0028
+#define PKA_STATUS    0x00c0
+#define PKA_SEQ_CTRL  0x00c8
+#define PKA_OPTIONS   0x00f4
+#define PKA_SW_REV    0x00f8
+#define PKA_REVISION  0x00fc
+
+#define PKA_REV       0x1fe0
+#define PKA_CLK_CTRL  0x1fe8
+#define PKA_SYSCONFIG 0x1ff0
+#define PKA_SYSSTATUS 0x1ff4
+#define PKA_IRQSTATUS 0x1ff8
+#define PKA_IRQENABLE 0x1ffc
+
+#define PKA_REGS_SIZE (PKA_REVISION + 4 - PKA_APTR \
+		     + PKA_IRQENABLE + 4 - PKA_REV)
+
+/* firmware info */
+#define PKA_FW_FMT "eip29t2_%u.%u.%u.bin"
+#define PKA_FW_RETRIES 5
+/* memory map info */
+#define PKA_PROG_RAM_SIZE 0x4000
+#define PKA_RAM_SIZE 0x1000
+
+/* register bits */
+#define PKA_FUNCTION_RUN BIT(15)
+#define PKA_FUNCTION_OP_TOP_MASK 0x38
+#define PKA_FUNCTION_OP_BOTTOM_MASK 0x3
+
+#define PKA_SEQ_CTRL_RST BIT(31)
+#define PKA_SEQ_CTRL_START BIT(8)
+#define PKA_SEQ_CTRL_STATUS_MASK 0x0000ff00
+#define PKA_SEQ_CTRL_STATUS_OFFSET 8
+
+#define PKA_SYSCONFIG_SRST BIT(1)
+#define PKA_SYSCONFIG_IDLE BIT(5)
+#define PKA_SYSCONFIG_NOIDLE BIT(4)
+
+#define PKA_SYSSTATUS_RST_COMP BIT(0)
+
+#define PKA_RST_TIMEOUT_J 2
+
+#define PKA_SW_REV_MASK 0x0fff0fff
+
+#define PKA_IRQ_MAIN BIT(0)
+
+#define PKA_MAX_VEC 520
+
+/* device configuration */
+struct pka_config {
+	bool ecc : 1;
+	bool montgomery : 1;
+	bool prog_ram : 1;
+};
+
+struct pka_version {
+	u8 major;
+	u8 minor;
+	u8 patch;
+};
+
+struct pka_snapshot {
+	u32 *regs;
+	u32 *mem;
+};
+
+struct pka_data {
+	void __iomem *base;
+	void __iomem *mem;
+	struct device *dev;
+	struct pka_config config;
+	struct mutex mutex; /* locked while the PKA is executing an operation */
+	bool running;
+	struct completion done;
+	int fw_tries;
+	char fw_name[64];
+#ifdef CONFIG_CRYPTO_DEV_SA2UL_PKA_DEBUG
+	struct pka_snapshot snapshot;
+#endif
+};
+
+struct pka_alg_template {
+	struct pka_data *data;
+	union {
+		struct akcipher_alg akcipher;
+		struct kpp_alg kpp;
+	} alg;
+};
+
+#define PKA_TFM_DATA(tfm, type) \
+	container_of((tfm)->base.__crt_alg, \
+		     struct pka_alg_template, \
+		     alg.type.base)->data
+
+int pka_op_wait(struct pka_data *data);
+void pka_intr_enable(struct pka_data *dev_data);
+void pka_intr_disable(struct pka_data *dev_data);
+
+#ifdef CONFIG_CRYPTO_DEV_SA2UL_PKA_DEBUG
+void pka_take_snapshot(struct pka_data *data);
+#else
+static inline void pka_take_snapshot(struct pka_data *data) {}
+#endif
+
+/* ciphers */
+extern struct pka_alg_template pka_rsa, pka_dh;
+
+#endif /* _K3_SA2UL_PKA_ */
diff --git a/drivers/crypto/sa2ul_pka/sa2ul_pka_base.c b/drivers/crypto/sa2ul_pka/sa2ul_pka_base.c
new file mode 100644
index 000000000000..46a0e6b6ea37
--- /dev/null
+++ b/drivers/crypto/sa2ul_pka/sa2ul_pka_base.c
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * K3 SA2UL Public Key Accelerator driver
+ *
+ * Copyright (c) 2022 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * Author: Daniel Parks <danielrparks@ti.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/err.h>
+#include <linux/packing.h>
+#include <linux/pm_runtime.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/sysfs.h>
+#include <linux/fips.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/delay.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/kpp.h>
+#include <asm/unaligned.h>
+
+#include "sa2ul_pka.h"
+
+bool poison_mem;
+bool snapshot;
+#ifdef CONFIG_CRYPTO_DEV_SA2UL_PKA_DEBUG
+module_param(poison_mem, bool, 0);
+module_param(snapshot, bool, 0);
+#endif
+
+static const struct pka_version pka_fws[] = {
+	{2, 1, 0},
+	{}
+};
+
+static inline int pka_packing(void *pbuf, u64 *uval, int startbit, int endbit,
+			      size_t pbuflen, enum packing_op op)
+{
+	return packing(pbuf, uval, startbit, endbit, pbuflen, op,
+		       QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN);
+}
+
+static void pka_parse_version(struct pka_version *out, u32 packed_version,
+			      int startbit)
+{
+	u64 res;
+
+	WARN_ON(startbit < 11);
+	pka_packing(&packed_version, &res,
+		    startbit, startbit - 3, 4, UNPACK);
+	out->major = res;
+	pka_packing(&packed_version, &res,
+		    startbit - 4, startbit - 7, 4, UNPACK);
+	out->minor = res;
+	pka_packing(&packed_version, &res,
+		    startbit - 8, startbit - 11, 4, UNPACK);
+	out->patch = res;
+}
+
+static void pka_set_idle(void __iomem *base, bool idle)
+{
+	writel_relaxed(idle ? PKA_SYSCONFIG_IDLE : PKA_SYSCONFIG_NOIDLE,
+		       base + PKA_SYSCONFIG);
+}
+
+static int pka_request_fw(struct pka_data *dev_data);
+
+/* enable/disable interrupts device-side */
+void pka_intr_enable(struct pka_data *dev_data)
+{
+	writel_relaxed(PKA_IRQ_MAIN, dev_data->base + PKA_IRQSTATUS);
+	writel_relaxed(PKA_IRQ_MAIN, dev_data->base + PKA_IRQENABLE);
+}
+
+void pka_intr_disable(struct pka_data *dev_data)
+{
+	writel_relaxed(0, dev_data->base + PKA_IRQENABLE);
+}
+
+#ifdef CONFIG_CRYPTO_DEV_SA2UL_PKA_DEBUG
+/* debugging - allows taking snapshots of memory and register file just before
+ * dispatching an operation
+ */
+void pka_take_snapshot(struct pka_data *data)
+{
+	if (snapshot) {
+		u32 i, j = 0;
+
+		for (i = PKA_APTR; i <= PKA_REVISION; i += 4, j++)
+			data->snapshot.regs[j] = readl_relaxed(data->base + i);
+		for (i = PKA_REV; i <= PKA_IRQENABLE; i += 4, j++)
+			data->snapshot.regs[j] = readl_relaxed(data->base + i);
+		for (i = 0, j = 0; i < PKA_RAM_SIZE; i += 4, j++)
+			data->snapshot.mem[j] = readl_relaxed(data->mem + i);
+	}
+}
+
+static ssize_t read_snap_reg(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *attr, char *buf,
+			     loff_t offset, size_t count)
+{
+	struct pka_data *data = attr->private;
+
+	memcpy(buf, (u8 *)data->snapshot.regs + offset, count);
+	return count;
+}
+
+static ssize_t read_snap_mem(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *attr, char *buf,
+			     loff_t offset, size_t count)
+{
+	struct pka_data *data = attr->private;
+
+	memcpy(buf, (u8 *)data->snapshot.mem + offset, count);
+	return count;
+}
+
+BIN_ATTR(regs, 0600, read_snap_reg, NULL, PKA_REGS_SIZE);
+BIN_ATTR(mem, 0600, read_snap_mem, NULL, PKA_RAM_SIZE);
+
+static inline int setup_debug(struct pka_data *dev_data)
+{
+	int ret;
+	struct device *dev = dev_data->dev;
+	size_t i;
+
+	if (snapshot) {
+		dev_data->snapshot.regs = devm_kzalloc(dev, PKA_REGS_SIZE,
+						       GFP_KERNEL);
+		dev_data->snapshot.mem = devm_kzalloc(dev, PKA_RAM_SIZE,
+						      GFP_KERNEL);
+		if (!dev_data->snapshot.mem || !dev_data->snapshot.regs)
+			return -ENOMEM;
+		sysfs_bin_attr_init(bin_attr_regs);
+		sysfs_bin_attr_init(bin_attr_mem);
+		bin_attr_regs.private = dev_data;
+		bin_attr_mem.private = dev_data;
+		ret = sysfs_create_bin_file(&dev->kobj, &bin_attr_regs);
+		if (ret) {
+			dev_err(dev, "failed to create regs snapshot file\n");
+			return ret;
+		}
+		ret = sysfs_create_bin_file(&dev->kobj, &bin_attr_mem);
+		if (ret) {
+			dev_err(dev, "failed to create mem snapshot file\n");
+			return ret;
+		}
+	}
+	if (poison_mem) {
+		for (i = 0; i < PKA_RAM_SIZE; i += 4)
+			writel_relaxed(0xccccccccU, dev_data->mem + i);
+	}
+	return 0;
+}
+
+static inline void cleanup_debug(struct platform_device *pdev)
+{
+	if (snapshot) {
+		sysfs_remove_bin_file(&pdev->dev.kobj, &bin_attr_regs);
+		sysfs_remove_bin_file(&pdev->dev.kobj, &bin_attr_mem);
+	}
+}
+
+#else
+static inline int setup_debug(struct pka_data *dev_data)
+{
+	return 0;
+}
+
+static inline void cleanup_debug(struct platform_device *pdev) {}
+#endif
+
+/* actually load the firmware */
+static inline int copy_fw(const struct firmware *fw, struct pka_data *dev_data)
+{
+	size_t i;
+	void __iomem *base = dev_data->base;
+	void __iomem *ram = dev_data->mem;
+	u32 reg;
+	int ret;
+
+	writel_relaxed(PKA_SEQ_CTRL_RST, base + PKA_SEQ_CTRL);
+	for (i = 0; i < fw->size; i += 4)
+		writel_relaxed(le32_to_cpu(get_unaligned(
+			       (u32 *)(fw->data + i))), ram + i);
+	writel_relaxed(0, base + PKA_SEQ_CTRL);
+	ret = readl_relaxed_poll_timeout(base + PKA_SEQ_CTRL, reg, (reg &
+			PKA_SEQ_CTRL_START) == PKA_SEQ_CTRL_START, 0,
+			PKA_RST_TIMEOUT_J);
+	if (ret) {
+		dev_warn(dev_data->dev,
+			 "timed out waiting for sequencer to start 0x%08x",
+			 reg);
+		dev_warn(dev_data->dev, "function: 0x%08x",
+			 readl_relaxed(base + PKA_FUNCTION));
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static inline int verify_fw(const struct firmware *fw,
+			    struct pka_data *dev_data)
+{
+	size_t i;
+	void __iomem *base = dev_data->base;
+	void __iomem *ram = dev_data->mem;
+	u32 reg;
+	int ret;
+
+	writel_relaxed(PKA_SEQ_CTRL_RST, base + PKA_SEQ_CTRL);
+	for (i = 0; i < fw->size; i += 4) {
+		if (readl_relaxed(ram + i)
+		    != le32_to_cpu(get_unaligned((u32 *)(fw->data + i)))) {
+			dev_warn(dev_data->dev,
+				 "firmware download corrupted at 0x%llx\n",
+				 (unsigned long long)i);
+			return -EINVAL;
+		}
+	}
+	writel_relaxed(0, base + PKA_SEQ_CTRL);
+	ret = readl_relaxed_poll_timeout(base + PKA_SEQ_CTRL, reg, (reg &
+			PKA_SEQ_CTRL_START) == PKA_SEQ_CTRL_START, 0,
+			PKA_RST_TIMEOUT_J);
+	return ret;
+}
+
+static inline void print_fw_rev(struct pka_data *dev_data)
+{
+	struct pka_version internal, custom;
+	u32 reg;
+
+	reg = readl_relaxed(dev_data->base + PKA_SW_REV) & PKA_SW_REV_MASK;
+	pka_parse_version(&internal, reg, 27);
+	pka_parse_version(&custom, reg, 11);
+	dev_info(dev_data->dev, "loaded firmware internal version %u.%u.%u, custom version %u.%u.%u\n",
+		 internal.major, internal.minor, internal.patch,
+		 custom.major, custom.minor, custom.patch);
+}
+
+/* load a firmware (requested from pka_request_next_fw) onto the device */
+static int pka_load_fw(const struct firmware *fw, struct pka_data *dev_data)
+{
+	void __iomem *base = dev_data->base;
+	u32 reg;
+	int ret = -ENOENT;
+
+	if (!fw) {
+		goto fw_bad;
+	} else if (fw->size > PKA_PROG_RAM_SIZE) {
+		dev_warn(dev_data->dev, "firmware is larger than max firmware size 0x%x, skipping\n",
+			 PKA_PROG_RAM_SIZE);
+		goto fw_bad;
+	}
+	ret = -EAGAIN;
+	if (copy_fw(fw, dev_data))
+		goto rst_fail;
+	if (verify_fw(fw, dev_data))
+		goto rst_fail;
+	print_fw_rev(dev_data);
+	release_firmware(fw);
+	reg = readl_relaxed(base + PKA_FUNCTION);
+	if (reg & PKA_FUNCTION_RUN)
+		dev_warn(dev_data->dev,
+			 "run bit set after loading firmware! 0x%08x\n", reg);
+
+	pka_intr_enable(dev_data);
+	return 0;
+
+rst_fail:
+	dev_warn(dev_data->dev,
+		 "firmware download corrupt (check silicon?), retrying\n");
+	dev_data->fw_tries++;
+fw_bad:
+	release_firmware(fw);
+	return ret;
+}
+
+/* Do some basic checks to make sure this device is similar enough to the
+ * development device to work with this driver. Also determine some information
+ * about the device configuration so we know which algorithms to enable.
+ */
+static int pka_parse_options(struct pka_data *data, u32 options)
+{
+	int ret = 0;
+	u64 tmp;
+
+	dev_info(data->dev, "options 0x%x\n", options);
+	// PKCP configuration
+	pka_packing(&options, &tmp, 1, 0, 4, UNPACK);
+	if (tmp != 2) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	pka_packing(&options, &tmp, 4, 2, 4, UNPACK);
+	if (tmp <= 2) {
+		data->config.montgomery = !!tmp;
+	} else {
+		ret = -EINVAL;
+		goto out;
+	}
+	// sequencer configuration
+	pka_packing(&options, &tmp, 6, 5, 4, UNPACK);
+	if (tmp != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pka_packing(&options, &tmp, 7, 7, 4, UNPACK);
+	data->config.prog_ram = tmp;
+	// GF(2^m) configuration
+	pka_packing(&options, &tmp, 23, 22, 4, UNPACK);
+	if (tmp <= 1) {
+		data->config.ecc = tmp;
+	} else {
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+static void pka_print_hw_rev(struct pka_data *dev_data)
+{
+	struct pka_version ver;
+	u32 reg;
+
+	reg = readl_relaxed(dev_data->base + PKA_REVISION);
+	pka_parse_version(&ver, reg, 27);
+	dev_info(dev_data->dev, "HW rev %u.%u.%u\n",
+		 ver.major, ver.minor, ver.patch);
+}
+
+/* try to load any available firmware into the device */
+static int pka_request_fw(struct pka_data *dev_data)
+{
+	int fw_next_idx = 0;
+	struct pka_version next_ver;
+	const struct firmware *fw;
+	int ret;
+
+	next_ver = pka_fws[fw_next_idx++];
+	while ((next_ver.major || next_ver.minor || next_ver.patch) &&
+	       dev_data->fw_tries < PKA_FW_RETRIES) {
+		snprintf(dev_data->fw_name, 64, PKA_FW_FMT,
+			 next_ver.major, next_ver.minor, next_ver.patch);
+
+		if (!request_firmware_direct(&fw, dev_data->fw_name,
+					     dev_data->dev)) {
+			ret = pka_load_fw(fw, dev_data);
+			if (ret == 0)
+				return ret;
+			else if (ret == -EAGAIN)
+				fw_next_idx--;
+		}
+		next_ver = pka_fws[fw_next_idx++];
+	}
+
+	dev_warn(dev_data->dev, "unable to load firmware\n");
+	return -ENOENT;
+}
+
+/* interrupts support */
+irqreturn_t pka_intr(int irqnum, void *_data)
+{
+	struct pka_data *data = _data;
+	u32 reg;
+
+	reg = readl_relaxed(data->base + PKA_IRQSTATUS);
+	if (reg & PKA_IRQ_MAIN) {
+		writel_relaxed(PKA_IRQ_MAIN, data->base + PKA_IRQSTATUS);
+		return IRQ_WAKE_THREAD;
+	} else {
+		return IRQ_NONE;
+	}
+}
+
+/* data->running is not synchronized; this is just a best-effort check to aid
+ * in debugging. It is not intended to reliably filter bad interrupts from a
+ * malfunctioning device.
+ */
+irqreturn_t pka_intr_threaded(int irqnum, void *_data)
+{
+	struct pka_data *data = _data;
+
+	if (unlikely(!data->running)) {
+		pr_warn("%s: spurious interrupt!\n", THIS_MODULE->name);
+	} else {
+		data->running = false;
+		complete(&data->done);
+	}
+	return IRQ_HANDLED;
+}
+
+/**
+ * pka_op_wait - wait for operation to finish
+ * @data: the pka to wait for
+ *
+ * Description:
+ *   Block waiting for the sequencer interrupt which indicates that the
+ *   operation has finished.
+ *
+ * Return:
+ * * 0          - Success
+ * * -EINVAL    - PKA returned unknown error code
+ * * -ETIMEDOUT - PKA died
+ */
+int pka_op_wait(struct pka_data *data)
+{
+	int ret;
+	u32 reg;
+
+	ret = wait_for_completion_timeout(&data->done, HZ * 2);
+	reg = readl_relaxed(data->base + PKA_SEQ_CTRL);
+	if (!ret) {
+		/* if we get here, the pka is in a non-recoverable state and
+		 * future operations will have undefined behavior, so taint the
+		 * kernel
+		 */
+		WARN(true, "%s: pka stalled! function 0x%08x, seq 0x%08x\n",
+		     THIS_MODULE->name,
+		     readl_relaxed(data->base + PKA_FUNCTION), reg);
+		return -ETIMEDOUT;
+	}
+	reg = (reg & PKA_SEQ_CTRL_STATUS_MASK) >> PKA_SEQ_CTRL_STATUS_OFFSET;
+	if (reg == 1)
+		return 0;
+	dev_warn(data->dev, "pka op err 0x%02x\n", reg);
+	return -EINVAL;
+}
+
+static int pka_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	static void __iomem *pka_base;
+	static void __iomem *pka_mem;
+	struct pka_data *dev_data;
+	int ret;
+
+	if (fips_enabled) {
+		dev_err(dev, "FIPS mode is not supported\n");
+		return -EACCES;
+	}
+
+	dev_data = devm_kzalloc(dev, sizeof(*dev_data), GFP_KERNEL);
+	if (!dev_data)
+		return -ENOMEM;
+	pka_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pka_base))
+		return PTR_ERR(pka_base);
+	pka_mem = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(pka_mem))
+		return PTR_ERR(pka_mem);
+	dev_data->dev = dev;
+	dev_data->base = pka_base;
+	dev_data->mem = pka_mem;
+	dev_data->running = false;
+	init_completion(&dev_data->done);
+	mutex_init(&dev_data->mutex);
+	platform_set_drvdata(pdev, dev_data);
+	dev_set_drvdata(dev, dev_data);
+
+	pka_print_hw_rev(dev_data);
+	// disable smart idle mode because it isn't smart
+	pka_set_idle(pka_base, false);
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		goto pm_disable;
+
+	ret = pka_parse_options(dev_data,
+				readl_relaxed(pka_base + PKA_OPTIONS));
+	if (ret) {
+		dev_err(dev, "failed to parse pka opts: %d\n", ret);
+		goto pm_disable;
+	}
+	if (dev_data->config.prog_ram) {
+		dev_data->fw_tries = 0;
+		ret = pka_request_fw(dev_data);
+		if (ret)
+			goto pm_disable;
+	}
+	ret = setup_debug(dev_data);
+	if (ret)
+		goto pm_disable;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto pm_disable;
+	ret = devm_request_threaded_irq(dev, ret, pka_intr, pka_intr_threaded,
+					IRQF_TRIGGER_NONE, pdev->name,
+					dev_data);
+	if (ret)
+		goto pm_disable;
+
+	if (dev_data->config.montgomery) {
+		pka_rsa.data = dev_data;
+		ret = crypto_register_akcipher(&pka_rsa.alg.akcipher);
+		if (ret)
+			dev_err(dev,
+				"failed to register crypto op pka_rsa: %d\n",
+				ret);
+		pka_dh.data = dev_data;
+		ret = crypto_register_kpp(&pka_dh.alg.kpp);
+		if (ret)
+			dev_err(dev,
+				"failed to register crypto op pka_dh: %d\n",
+				ret);
+	}
+
+	return 0;
+pm_disable:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	pka_set_idle(pka_base, true);
+	return ret;
+}
+
+static int pka_remove(struct platform_device *pdev)
+{
+	struct pka_data *dev_data = platform_get_drvdata(pdev);
+
+	pka_intr_disable(dev_data);
+
+	if (dev_data->config.montgomery) {
+		crypto_unregister_akcipher(&pka_rsa.alg.akcipher);
+		crypto_unregister_kpp(&pka_dh.alg.kpp);
+	}
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pka_set_idle(dev_data->base, true);
+
+	cleanup_debug(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id of_match[] = {
+	{ .compatible = "inside-secure,safexcel-eip29t2" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_match);
+
+static struct platform_driver pka_driver = {
+	.probe = pka_probe,
+	.remove = pka_remove,
+	.driver = {
+		.name = "saul-pka-crypto",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = of_match,
+	},
+};
+
+module_platform_driver(pka_driver);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Daniel Parks <danielrparks@ti.com>");
+MODULE_DESCRIPTION("SA2UL Public Key Accelerator Driver");
diff --git a/drivers/crypto/sa2ul_pka/sa2ul_pka_dh.c b/drivers/crypto/sa2ul_pka/sa2ul_pka_dh.c
new file mode 100644
index 000000000000..9edd0383b9b1
--- /dev/null
+++ b/drivers/crypto/sa2ul_pka/sa2ul_pka_dh.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * K3 SA2UL Public Key Accelerator driver
+ *
+ * Copyright (c) 2022 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * Author: Daniel Parks <danielrparks@ti.com>
+ */
+
+#include <linux/module.h>
+#include <crypto/internal/kpp.h>
+#include <crypto/kpp.h>
+#include <crypto/dh.h>
+
+#include "sa2ul_pka.h"
+#include "sa2ul_pka_op.h"
+
+/* these are needed per algorithm type because they tend to use different typing
+ * in their data structure
+ */
+static int pka_dh_copy_key_component(const void **dst, const void *src,
+				     uint *newsz, uint sz, bool little)
+{
+	if (!src)
+		return 0;
+	// delete leading zeroes
+	while (!*(u8 *)src && sz > 0) {
+		src++;
+		sz--;
+	}
+
+	*newsz = ALIGN(sz, 4);
+
+	if (*newsz > PKA_MAX_VEC) {
+		pr_err("key is longer than maximum supported by PKA\n");
+		return -EINVAL;
+	}
+
+	kfree(*dst);
+	*dst = kmalloc(*newsz, GFP_KERNEL);
+	if (!*dst)
+		return -ENOMEM;
+
+	if (little) {
+		reverse_memcpy((u8 *)*dst, src, sz);
+		memset((u8 *)*dst + sz, 0, *newsz - sz);
+	} else {
+		memset((u8 *)*dst, 0, *newsz - sz);
+		memcpy((u8 *)*dst + *newsz - sz, src, sz);
+	}
+
+	return 0;
+}
+
+static int pka_dh_copy_params(struct dh *dst, struct dh *src)
+{
+	int ret;
+
+	ret = pka_dh_copy_key_component(&dst->key, src->key, &dst->key_size,
+					src->key_size, true);
+	if (ret)
+		goto die;
+	ret = pka_dh_copy_key_component(&dst->p, src->p, &dst->p_size,
+					src->p_size, true);
+	if (ret)
+		goto die;
+	ret = pka_dh_copy_key_component(&dst->g, src->g, &dst->g_size,
+					src->g_size, false);
+	if (ret)
+		goto die;
+	return 0;
+die:
+	kfree(dst->key);
+	kfree(dst->p);
+	kfree(dst->g);
+	return ret;
+}
+
+static int pka_dh_set_secret(struct crypto_kpp *tfm, const void *buffer,
+			     uint len)
+{
+	struct dh *ctx = kpp_tfm_ctx(tfm);
+	struct dh new_params;
+	int ret;
+
+	ret = crypto_dh_decode_key(buffer, len, &new_params);
+	if (ret < 0)
+		return ret;
+	ret = pka_dh_copy_params(ctx, &new_params);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+/* uses the same code-sharing trick as dh_compute_value() from crypto/dh.c */
+static int pka_dh_modexp(struct kpp_request *req)
+{
+	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
+	struct pka_data *data = PKA_TFM_DATA(tfm, kpp);
+	struct dh *ctx = kpp_tfm_ctx(tfm);
+	struct scatterlist sg;
+	struct scatterlist *base;
+	uint baselen;
+	bool check_base = false;
+
+	if (req->src) {
+		base = req->src;
+		baselen = req->src_len;
+	} else {
+		sg_init_one(&sg, ctx->g, ctx->g_size);
+		base = &sg;
+		baselen = ctx->g_size;
+		check_base = true;
+	}
+	return pka_modexp(data, base, baselen, ctx->key, ctx->key_size, ctx->p,
+			  ctx->p_size, req->dst, &req->dst_len, 1, check_base);
+}
+
+static uint pka_dh_max_size(struct crypto_kpp *tfm)
+{
+	struct dh *ctx = kpp_tfm_ctx(tfm);
+
+	return ctx->p_size;
+}
+
+static void pka_dh_exit(struct crypto_kpp *tfm)
+{
+	struct dh *ctx = kpp_tfm_ctx(tfm);
+
+	kfree(ctx->key);
+	kfree(ctx->p);
+	kfree(ctx->g);
+}
+
+struct pka_alg_template pka_dh = {
+	.alg.kpp = {
+		.set_secret = pka_dh_set_secret,
+		.generate_public_key = pka_dh_modexp,
+		.compute_shared_secret = pka_dh_modexp,
+		.max_size = pka_dh_max_size,
+		.exit = pka_dh_exit,
+		.base = {
+			.cra_name = "dh",
+			.cra_driver_name = "dh-sa2ul-pka",
+			.cra_priority = 400,
+			.cra_module = THIS_MODULE,
+			.cra_ctxsize = sizeof(struct dh)
+		}
+	}
+};
diff --git a/drivers/crypto/sa2ul_pka/sa2ul_pka_op.c b/drivers/crypto/sa2ul_pka/sa2ul_pka_op.c
new file mode 100644
index 000000000000..0b7eb6342b0d
--- /dev/null
+++ b/drivers/crypto/sa2ul_pka/sa2ul_pka_op.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * K3 SA2UL Public Key Accelerator driver
+ *
+ * Copyright (c) 2022 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * Author: Daniel Parks <danielrparks@ti.com>
+ */
+
+#include <linux/iopoll.h>
+
+#include "sa2ul_pka.h"
+#include "sa2ul_pka_op.h"
+
+/* opcodes */
+#define PKA_SEQ_OP_START_BIT PKA_FUNCTION_RUN
+#define PKA_SEQ_OP(seqopcode) \
+	(PKA_SEQ_OP_START_BIT | (((seqopcode) & 0x38) << 16) \
+	 | (((seqopcode) & 0x7) << 12))
+#define PKA_SEQ_OP_MODEXP PKA_SEQ_OP(0x06)
+#define PKA_OP_COMPARE (BIT(10) | PKA_FUNCTION_RUN)
+
+#define PKA_CMP_A_LT_B BIT(1)
+
+/*
+ * The following macros (PKA_ARG_*, PKA_*_OP) can be used to describe a dynamic
+ * memory layout for a PKA operation. For example, the modexp operation
+ * requires the following layout:
+ * +--------+--------------------------+
+ * | Vector | Contents                 |
+ * +--------+--------------------------+
+ * |      A | *Exponent                |
+ * |      B | *Modulus <pad>           |
+ * |      C | *Base <pad>              |
+ * |      D | *Result <pad> *workspace |
+ * +--------+--------------------------+
+ *            *64-bit aligned
+ *
+ * This layout can be created using the macros like this:
+ * PKA_SETUP_OP(data->base, data->mem, elen, mlen,
+ *         PKA_ARG_START(PKA_APTR); PKA_ARG_IN_WORDS(exponent, elen);
+ *         PKA_ARG_START(PKA_BPTR); PKA_ARG_IN_WORDS(modulus, mlen);
+ *                                  PKA_ARG_PAD_WORDS(1);
+ *         PKA_ARG_START(PKA_CPTR); PKA_ARG_IN_SCATTER_BE(base, mlen);
+ *                                  PKA_ARG_PAD_WORDS(1);
+ *         PKA_ARG_START(PKA_DPTR); PKA_ARG_GETLOC(outptr);
+ *                                  PKA_ARG_PAD_WORDS(mlen);
+ *                                  PKA_ARG_PAD_WORDS(1);
+ *                                  PKA_ARG_WKSPC(...);
+ * );
+ *
+ * The PKA_ARG_* macros must only be used as arguments to the
+ * PKA_SETUP_OP macro.
+ */
+#define PKA_ARG_LOC(loc) (_i = (loc))
+#define PKA_ARG_GETLOC(out) ((out) = _i)
+#define PKA_ARG_ALIGN64() (_i = round_up((_i), 8))
+#define PKA_ARG_IN_WORDS(buf, len) do {\
+	PKA_ARG_ALIGN64(); \
+	for (_j = 0; _j < (len); _j++) { \
+		writel_relaxed(le32_to_cpu((buf)[_j]), _mem + _i); \
+		_i += 4; \
+	} \
+} while (0)
+#define _PKA_ARG_IN_SCATTER(sgl, len, be) do { \
+	PKA_ARG_ALIGN64(); \
+	_j = pka_sg_copy_in(_mem + _i, (sgl), (len), be); \
+	_i += _j; \
+} while (0)
+#define PKA_ARG_IN_SCATTER(sgl, len) _PKA_ARG_IN_SCATTER(sgl, len, false)
+#define PKA_ARG_IN_SCATTER_BE(sgl, len) _PKA_ARG_IN_SCATTER(sgl, len, true)
+#define PKA_ARG_PAD_WORDS(len) do { \
+	for (_j = 0; _j < (len); _j++) { \
+		writel_relaxed(0, _mem + _i); \
+		_i += 4; \
+	} \
+} while (0)
+#define PKA_ARG_WKSPC(len) do { \
+	PKA_ARG_ALIGN64(); \
+	_i += 4 * (len); \
+} while (0)
+#define PKA_ARG_START(reg) do { \
+	PKA_ARG_ALIGN64(); \
+	_reg = (reg); \
+	writel_relaxed(_i / 4, _base + _reg); \
+} while (0)
+
+#define PKA_SETUP_OP(b, m, alen, blen, vecs) do {\
+	u32 _reg, _j, _i = 0; \
+	void __iomem *_base = b; \
+	void __iomem *_mem = m; \
+	writel_relaxed(alen, _base + PKA_ALENGTH); \
+	writel_relaxed(blen, _base + PKA_BLENGTH); \
+	vecs \
+} while (0)
+#define PKA_SUBMIT_OP(_pka_data, opcode) do { \
+	struct pka_data *pka_data = _pka_data; \
+	(pka_data)->running = true; \
+	pka_take_snapshot(pka_data); \
+	writel_relaxed(opcode, (pka_data)->base + PKA_FUNCTION); \
+} while (0)
+
+void *reverse_memcpy(void *dest, const void *src, size_t count)
+{
+	char *tmp = dest + count - 1;
+	const char *s = src;
+
+	while (count--)
+		*tmp-- = *s++;
+	return dest;
+}
+
+/**
+ * pka_modexp - perform a modular exponentiation
+ * @src: base, as a scatterlist
+ * @slen: length in bytes of base
+ * @exp: exponent
+ * @elen: length in bytes of @exponent
+ * @mod: modulus
+ * @mlen: length in bytes of @modulus
+ * @dst: result pointer, as a scatterlist
+ * @dlen: length available in @dst
+ * @shift: number of odd primes to precompute (always 1 for public RSA, max 5
+ *         for 4096-bit private RSA)
+ * @check_base: true if (@base < @modulus) should be checked first
+ *
+ * Description:
+ *   Perform a modular exponentiation using the PKA.
+ *   Blocks waiting for operation to finish.
+ *   If @check_base is set, it will take advantage of the fact that it can
+ *   reuse memory after a comparison operation to perform the check
+ *   (@base < @modulus) with almost no overhead (~10us).
+ *
+ * Return:
+ * * 0          - Success
+ * * -EINVAL    - Problem with sizes of input buffers
+ * * -EINVAL    - PKA returned error
+ * * -ETIMEDOUT - PKA died
+ */
+int pka_modexp(struct pka_data *data, struct scatterlist *src, uint slen,
+	       const u8 *exp, size_t elen, const u8 *mod, size_t mlen,
+	       struct scatterlist *dst, uint *dlen, u32 shift,
+	       bool check_base)
+{
+	u32 alen, blen, m, diff, tmp = 0;
+	void __iomem *base = data->base;
+	void __iomem *mem = data->mem;
+	int ret;
+
+	if (slen > mlen) {
+		return -EINVAL;
+	} else if (*dlen < mlen) {
+		*dlen = mlen;
+		return -EINVAL;
+	}
+	alen = elen / 4;
+	blen = mlen / 4;
+	mutex_lock(&data->mutex);
+
+	PKA_SETUP_OP(base, mem, blen, 0,
+		PKA_ARG_ALIGN64();       PKA_ARG_IN_WORDS((u32 *)exp, alen);
+		PKA_ARG_START(PKA_BPTR); PKA_ARG_IN_WORDS((u32 *)mod, blen);
+					 PKA_ARG_PAD_WORDS(1);
+		PKA_ARG_START(PKA_DPTR);
+		PKA_ARG_START(PKA_APTR); PKA_ARG_GETLOC(m);
+					 PKA_ARG_IN_SCATTER_BE(src, slen);
+					 PKA_ARG_PAD_WORDS((mlen - slen) / 4);
+					 PKA_ARG_PAD_WORDS(1);
+	);
+	if (check_base) {
+		pka_intr_disable(data);
+		PKA_SUBMIT_OP(data, PKA_OP_COMPARE);
+		ret = readl_relaxed_poll_timeout(base + PKA_FUNCTION, tmp,
+						 (tmp & PKA_FUNCTION_RUN) == 0,
+						 0, 100);
+		pka_intr_enable(data);
+		if (ret & PKA_FUNCTION_RUN) {
+			ret = -ETIMEDOUT;
+			goto err;
+		}
+		tmp = readl_relaxed(base + PKA_COMPARE);
+		if (!(tmp & PKA_CMP_A_LT_B)) {
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+	writel_relaxed(0, base + PKA_APTR);
+	writel_relaxed(m / 4, base + PKA_CPTR);
+	writel_relaxed(shift, base + PKA_SHIFT);
+	writel_relaxed(alen, base + PKA_ALENGTH);
+	writel_relaxed(blen, base + PKA_BLENGTH);
+
+	PKA_SUBMIT_OP(data, PKA_SEQ_OP_MODEXP);
+	diff = *dlen - blen * 4;
+	ret = pka_op_wait(data);
+	if (ret)
+		goto err;
+	ret = pka_sg_copy_out(mem + m, dst, diff, *dlen, true);
+
+	mutex_unlock(&data->mutex);
+	return ret > 0 ? 0 : ret;
+err:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
diff --git a/drivers/crypto/sa2ul_pka/sa2ul_pka_op.h b/drivers/crypto/sa2ul_pka/sa2ul_pka_op.h
new file mode 100644
index 000000000000..6f7c6f07e8bb
--- /dev/null
+++ b/drivers/crypto/sa2ul_pka/sa2ul_pka_op.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * K3 SA2UL Public Key Accelerator driver
+ *
+ * Copyright (c) 2022 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * Author: Daniel Parks <danielrparks@ti.com>
+ */
+
+#ifndef PKA_OP_H
+#define PKA_OP_H
+
+#include <linux/scatterlist.h>
+
+#include "sa2ul_pka.h"
+
+int pka_modexp(struct pka_data *data, struct scatterlist *src, uint slen,
+	       const u8 *exponent, size_t elen, const u8 *modulus, size_t mlen,
+	       struct scatterlist *dst, uint *dlen, u32 shift,
+	       bool check_base);
+
+size_t pka_sg_copy_in(void __iomem *dst, struct scatterlist *src, size_t len,
+		      bool big);
+size_t pka_sg_copy_out(void __iomem *src, struct scatterlist *dst, size_t skip,
+		       size_t len, bool big);
+void *reverse_memcpy(void *dest, const void *src, size_t count);
+
+#endif /* PKA_OP_H */
diff --git a/drivers/crypto/sa2ul_pka/sa2ul_pka_rsa.c b/drivers/crypto/sa2ul_pka/sa2ul_pka_rsa.c
new file mode 100644
index 000000000000..48d88372236d
--- /dev/null
+++ b/drivers/crypto/sa2ul_pka/sa2ul_pka_rsa.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * K3 SA2UL Public Key Accelerator driver
+ *
+ * Copyright (c) 2022 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * Author: Daniel Parks <danielrparks@ti.com>
+ */
+
+#include <linux/module.h>
+#include <crypto/internal/rsa.h>
+#include <crypto/akcipher.h>
+#include <crypto/internal/akcipher.h>
+
+#include "sa2ul_pka.h"
+#include "sa2ul_pka_op.h"
+
+static int pka_rsa_copy_key_component(const u8 **dst, const u8 *src,
+				      size_t *newsz, size_t sz)
+{
+	if (!src)
+		return 0;
+	// delete leading zeroes
+	while (!*src && sz > 0) {
+		src++;
+		sz--;
+	}
+
+	*newsz = ALIGN(sz, 4);
+
+	if (*newsz > PKA_MAX_VEC) {
+		pr_err("key is longer than maximum supported by PKA\n");
+		return -EINVAL;
+	}
+
+	kfree(*dst);
+	*dst = kmalloc(*newsz, GFP_KERNEL);
+	if (!*dst)
+		return -ENOMEM;
+
+	reverse_memcpy((u8 *)*dst, src, sz);
+	memset((u8 *)*dst + sz, 0, *newsz - sz);
+
+	return 0;
+}
+
+static int pka_rsa_copy_key(struct rsa_key *dst, struct rsa_key *src)
+{
+	int ret;
+
+	ret = pka_rsa_copy_key_component(&dst->n, src->n, &dst->n_sz,
+					 src->n_sz);
+	if (ret)
+		goto die;
+	ret = pka_rsa_copy_key_component(&dst->e, src->e, &dst->e_sz,
+					 src->e_sz);
+	if (ret)
+		goto die;
+	ret = pka_rsa_copy_key_component(&dst->d, src->d, &dst->d_sz,
+					 src->d_sz);
+	if (ret)
+		goto die;
+	ret = pka_rsa_copy_key_component(&dst->p, src->p, &dst->p_sz,
+					 src->p_sz);
+	if (ret)
+		goto die;
+	ret = pka_rsa_copy_key_component(&dst->q, src->q, &dst->q_sz,
+					 src->q_sz);
+	if (ret)
+		goto die;
+	ret = pka_rsa_copy_key_component(&dst->dp, src->dp, &dst->dp_sz,
+					 src->dp_sz);
+	if (ret)
+		goto die;
+	ret = pka_rsa_copy_key_component(&dst->dq, src->dq, &dst->dq_sz,
+					 src->dq_sz);
+	if (ret)
+		goto die;
+	ret = pka_rsa_copy_key_component(&dst->qinv, src->qinv, &dst->qinv_sz,
+					 src->qinv_sz);
+	if (ret)
+		goto die;
+	return 0;
+die:
+	kfree(dst->n);
+	kfree(dst->e);
+	kfree(dst->d);
+	kfree(dst->p);
+	kfree(dst->q);
+	kfree(dst->dp);
+	kfree(dst->dq);
+	kfree(dst->qinv);
+	return ret;
+}
+
+static int pka_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
+				unsigned int keylen)
+{
+	struct rsa_key *dst = akcipher_tfm_ctx(tfm);
+	struct rsa_key src = {0};
+	int ret;
+
+	ret = rsa_parse_priv_key(&src, key, keylen);
+	if (ret)
+		return ret;
+	ret = pka_rsa_copy_key(dst, &src);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static int pka_rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
+			       unsigned int keylen)
+{
+	struct rsa_key *dst = akcipher_tfm_ctx(tfm);
+	struct rsa_key src = {0};
+	int ret;
+
+	ret = rsa_parse_pub_key(&src, key, keylen);
+	if (ret)
+		return ret;
+	ret = pka_rsa_copy_key(dst, &src);
+	return ret;
+}
+
+static int pka_rsa_encrypt(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct pka_data *data = PKA_TFM_DATA(tfm, akcipher);
+	struct rsa_key *key = akcipher_tfm_ctx(tfm);
+
+	// c ≡ m^e (mod n)
+	return pka_modexp(data, req->src, req->src_len, key->e, key->e_sz,
+			  key->n, key->n_sz, req->dst, &req->dst_len, 1, true);
+}
+
+static int pka_rsa_decrypt_standard(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct pka_data *data = PKA_TFM_DATA(tfm, akcipher);
+	struct rsa_key *key = akcipher_tfm_ctx(tfm);
+
+	// m ≡ c^d (mod n)
+	return pka_modexp(data, req->src, req->src_len, key->d, key->d_sz,
+			  key->n, key->n_sz, req->dst, &req->dst_len, 4, true);
+}
+
+/* in the future, we might use modexp_crt instead of modexp here */
+static int pka_rsa_decrypt(struct akcipher_request *req)
+{
+	return pka_rsa_decrypt_standard(req);
+}
+
+static unsigned int pka_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct rsa_key *key = akcipher_tfm_ctx(tfm);
+
+	return key->n_sz;
+}
+
+static void pka_rsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct rsa_key *key = akcipher_tfm_ctx(tfm);
+
+	kfree(key->n);
+	kfree(key->e);
+	kfree(key->d);
+	kfree(key->p);
+	kfree(key->q);
+	kfree(key->dp);
+	kfree(key->dq);
+	kfree(key->qinv);
+}
+
+struct pka_alg_template pka_rsa = {
+	.alg.akcipher = {
+		.encrypt = pka_rsa_encrypt,
+		.decrypt = pka_rsa_decrypt,
+		.sign = NULL,
+		.verify = NULL,
+		.set_priv_key = pka_rsa_set_priv_key,
+		.set_pub_key = pka_rsa_set_pub_key,
+		.max_size = pka_rsa_max_size,
+		.exit = pka_rsa_exit_tfm,
+		.base = {
+			.cra_name = "rsa",
+			.cra_driver_name = "rsa-sa2ul-pka",
+			.cra_priority = 400,
+			.cra_module = THIS_MODULE,
+			.cra_ctxsize = sizeof(struct rsa_key),
+		},
+	}
+};
diff --git a/drivers/crypto/sa2ul_pka/sa2ul_pka_sg.c b/drivers/crypto/sa2ul_pka/sa2ul_pka_sg.c
new file mode 100644
index 000000000000..0b8996a1ca8d
--- /dev/null
+++ b/drivers/crypto/sa2ul_pka/sa2ul_pka_sg.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * K3 SA2UL Public Key Accelerator driver
+ *
+ * Copyright (c) 2022 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * Author: Daniel Parks <danielrparks@ti.com>
+ */
+
+#include <asm/unaligned.h>
+
+#include "sa2ul_pka_op.h"
+
+/* align @a and advance @b by the same amount as @a
+ * mod must be a power of two
+ */
+#define ALIGN_ADVANCE(a, b, mod) do { \
+	b += ALIGN(a, mod) - a; \
+	a = ALIGN(a, mod); \
+} while (0)
+/* down-align @a and advance @b by the amount @a would be aligned *upwards*
+ * mod must be a power of two
+ */
+#define ALIGN_DOWN_ADVANCE(a, b, mod) do { \
+	b += ALIGN(a, mod) - a; \
+	a = ALIGN_DOWN(a, mod); \
+} while (0)
+/* reverse a word index @idx with respect to length @len */
+#define REV_IDX(idx, len) ((len) - (idx) - 4)
+
+struct temp_buffer {
+	u32 buf;
+	bool dirty;
+};
+
+/* if we are in the middle of a word in the destination, copy the remainder of
+ * the word from the source and write it out
+ */
+static inline void in_fragment_begin(size_t *dsti, size_t *miteri,
+				     struct sg_mapping_iter *miter,
+				     void __iomem *dst, size_t len,
+				     struct temp_buffer *buf, bool big)
+{
+	if (*dsti % 4 && *miteri + 4 - *dsti % 4 <= miter->length &&
+	    *dsti < len) {
+		memcpy(((u8 *)&buf->buf) + *dsti % 4, miter->addr + *miteri,
+		       4 - *dsti % 4);
+		ALIGN_DOWN_ADVANCE(*dsti, *miteri, 4);
+		if (big)
+			writel_relaxed(be32_to_cpu(buf->buf),
+				       dst + REV_IDX(*dsti, len));
+		else
+			writel_relaxed(le32_to_cpu(buf->buf), dst + *dsti);
+		buf->dirty = false;
+		buf->buf = 0;
+		*dsti += 4;
+	}
+}
+
+/* if the source sg entry ends in the middle of a word, save the partial word */
+static inline void in_fragment_end(size_t *dsti, size_t *miteri,
+				   struct sg_mapping_iter *miter, size_t len,
+				   struct temp_buffer *buf)
+{
+	u32 tmp;
+
+	if (*miteri < miter->length && *dsti < len) {
+		tmp = miter->length - *miteri;
+		memcpy((u8 *)&buf->buf + *dsti % 4, miter->addr + *miteri, tmp);
+		buf->dirty = true;
+		*dsti += tmp;
+	}
+}
+
+/* if we have a partial word at the end of the source, zero pad and write it out
+ */
+static inline void in_fragment_last(size_t *dsti, void __iomem *dst, size_t len,
+				    struct temp_buffer *buf, bool big)
+{
+	if (buf->dirty) {
+		*dsti = ALIGN_DOWN(*dsti, 4);
+		if (big)
+			writel_relaxed(be32_to_cpu(buf->buf),
+				       dst + REV_IDX(*dsti, len));
+		else
+			writel_relaxed(le32_to_cpu(buf->buf), dst + *dsti);
+		buf->dirty = false;
+		buf->buf = 0;
+	}
+}
+
+/* copy words into the destination */
+static inline void in_loop(size_t *dsti, size_t *miteri,
+			   struct sg_mapping_iter *miter, void __iomem *dst,
+			   size_t len, bool big)
+{
+	u32 tmp;
+
+	while (*miteri + 4 <= miter->length && *dsti + 4 <= len) {
+		if (big) {
+			tmp = be32_to_cpu(*((u32 *)(miter->addr + *miteri)));
+			writel_relaxed(tmp, dst + REV_IDX(*dsti, len));
+		} else {
+			tmp = le32_to_cpu(*((u32 *)(miter->addr + *miteri)));
+			writel_relaxed(tmp, dst + *dsti);
+		}
+		*dsti += 4;
+		*miteri += 4;
+	}
+}
+
+/* copy words into the destination from an unaligned source */
+static inline void in_loop_ua(size_t *dsti, size_t *miteri,
+			      struct sg_mapping_iter *miter, void __iomem *dst,
+			      size_t len, bool big)
+{
+	u32 tmp;
+
+	while (*miteri + 4 <= miter->length && *dsti + 4 <= len) {
+		if (big) {
+			tmp = be32_to_cpu(get_unaligned(
+					  (u32 *)(miter->addr + *miteri)));
+			writel_relaxed(tmp, dst + REV_IDX(*dsti, len));
+		} else {
+			tmp = le32_to_cpu(get_unaligned(
+					  (u32 *)(miter->addr + *miteri)));
+			writel_relaxed(tmp, dst + *dsti);
+		}
+		*dsti += 4;
+		*miteri += 4;
+	}
+}
+
+/**
+ * pka_sg_copy_in - copy data from a scatterlist into PKA memory
+ * @dst: destination (in PKA device memory)
+ * @src: source scatterlist
+ * @len: length of the data to copy
+ * @big: true if source data is big-endian
+ *
+ * Description:
+ *   Intended for copying big integers used in crypto algorithms. In this case,
+ *   the endianness of the memory will be defined by the storage format (e.g.
+ *   ASN.1) rather than the host system. This function performs the copy without
+ *   using costly bounce buffers.
+ *   The PKA memory is always little-endian; if necessary, the endianness will
+ *   be swapped on-the-fly during the copy to the PKA.
+ *   If the scatterlist ends before @len bytes have been copied, this function
+ *   will stop early.
+ *
+ * Return:
+ * The number of bytes copied.
+ */
+size_t pka_sg_copy_in(void __iomem *dst, struct scatterlist *src, size_t len,
+		      bool big)
+{
+	size_t dsti = 0, miteri;
+	struct sg_mapping_iter miter;
+	struct temp_buffer buf = {0, false};
+
+	if (big && len % 4)
+		ALIGN_ADVANCE(len, dsti, 4);
+
+	sg_miter_start(&miter, src, sg_nents(src), SG_MITER_FROM_SG);
+	while (sg_miter_next(&miter) && dsti < len) {
+		miteri = 0;
+		in_fragment_begin(&dsti, &miteri, &miter, dst, len, &buf, big);
+		if (IS_ALIGNED((unsigned long)miter.addr + miteri, 4))
+			in_loop(&dsti, &miteri, &miter, dst, len, big);
+		else
+			in_loop_ua(&dsti, &miteri, &miter, dst, len, big);
+		in_fragment_end(&dsti, &miteri, &miter, len, &buf);
+	}
+	in_fragment_last(&dsti, dst, len, &buf, big);
+	sg_miter_stop(&miter);
+	return dsti;
+}
+
+/* if we are in the middle of a word in the source, write the remainder of the
+ * word to the destination
+ */
+static inline void out_fragment_begin(size_t *srci, size_t *miteri,
+				      struct sg_mapping_iter *miter,
+				      void __iomem *src, size_t len, u32 *buf,
+				      bool big)
+{
+	void __iomem *addr;
+
+	if (*srci % 4 && *miteri + 4 - *srci % 4 <= miter->length &&
+	    *srci < len) {
+		if (big) {
+			addr = src + REV_IDX(ALIGN_DOWN(*srci, 4), len);
+			*buf = cpu_to_be32(readl_relaxed(addr));
+		}
+		memcpy(miter->addr + *miteri, ((u8 *)buf) + *srci % 4,
+		       4 - *srci % 4);
+		ALIGN_ADVANCE(*srci, *miteri, 4);
+	}
+}
+
+/* if the destination sg entry ends in the middle of a word, write what we can
+ * and save the rest
+ */
+static inline void out_fragment_end(size_t *srci, size_t *miteri,
+				    struct sg_mapping_iter *miter,
+				    void __iomem *src, size_t len, u32 *buf,
+				    bool big)
+{
+	u32 tmp;
+	void __iomem *addr;
+
+	if (*miteri < miter->length && *srci < len) {
+		tmp = min(miter->length - *miteri, len - *srci);
+		if (big) {
+			addr = src + REV_IDX(*srci, len);
+			*buf = cpu_to_be32(readl_relaxed(addr));
+		} else {
+			*buf = cpu_to_le32(readl_relaxed(src + *srci));
+		}
+		memcpy(miter->addr + *miteri, (u8 *)buf + *srci % 4, tmp);
+		*srci += tmp;
+	}
+}
+
+/* copy words from the source to the destination */
+static inline void out_loop(size_t *srci, size_t *miteri,
+			    struct sg_mapping_iter *miter, void __iomem *src,
+			    size_t len, bool big)
+{
+	u32 tmp;
+	void __iomem *addr;
+
+	while (*miteri + 4 <= miter->length && *srci + 4 <= len) {
+		if (big) {
+			addr = src + REV_IDX(*srci, len);
+			tmp = cpu_to_be32(readl_relaxed(addr));
+			*((u32 *)(miter->addr + *miteri)) = tmp;
+		} else {
+			tmp = cpu_to_le32(readl_relaxed(src + *srci));
+			*((u32 *)(miter->addr + *miteri)) = tmp;
+		}
+		*srci += 4;
+		*miteri += 4;
+	}
+}
+
+/* copy words from the source to an unaligned destination */
+static inline void out_loop_ua(size_t *srci, size_t *miteri,
+			       struct sg_mapping_iter *miter, void __iomem *src,
+			       size_t len, bool big)
+{
+	u32 tmp;
+	void __iomem *addr;
+
+	while (*miteri + 4 <= miter->length && *srci + 4 <= len) {
+		if (big) {
+			addr = src + REV_IDX(*srci, len);
+			tmp = cpu_to_be32(readl_relaxed(addr));
+			put_unaligned(tmp, (u32 *)(miter->addr + *miteri));
+		} else {
+			tmp = cpu_to_le32(readl_relaxed(src + *srci));
+			put_unaligned(tmp, (u32 *)(miter->addr + *miteri));
+		}
+		*srci += 4;
+		*miteri += 4;
+	}
+}
+
+/**
+ * pka_sg_copy_out - copy data from PKA memory into a scatterlist
+ * @src: source (in PKA device memory)
+ * @dst: destination scatterlist
+ * @skip: number of bytes to skip in the destination before copying
+ * @len: length of the data to copy
+ * @big: true if destination data is big endian
+ *
+ * Description:
+ *   Intended for copying big integers used in crypto algorithms. In this case,
+ *   the endianness of the memory will be defined by the storage format (e.g.
+ *   ASN.1) rather than the host system. This function performs the copy without
+ *   using costly bounce buffers.
+ *   The PKA memory is always little-endian; if necessary, the endianness will
+ *   be swapped on-the-fly during the copy from the PKA.
+ *   If the scatterlist ends before @len bytes have been copied, this function
+ *   will stop early.
+ *
+ * Return:
+ * The number of bytes copied.
+ */
+size_t pka_sg_copy_out(void __iomem *src, struct scatterlist *dst, size_t skip,
+		       size_t len, bool big)
+{
+	size_t srci = 0, miteri;
+	struct sg_mapping_iter miter;
+	u32 buf = 0;
+
+	len -= skip;
+	sg_miter_start(&miter, dst, sg_nents(dst), SG_MITER_TO_SG);
+	sg_zero_buffer(dst, sg_nents(dst), skip, 0);
+	if (!sg_miter_skip(&miter, skip))
+		return 0;
+	if (big && len % 4)
+		ALIGN_ADVANCE(len, srci, 4);
+
+	while (sg_miter_next(&miter) && srci < len) {
+		miteri = 0;
+		out_fragment_begin(&srci, &miteri, &miter, src, len, &buf, big);
+		if (IS_ALIGNED((unsigned long)miter.addr + miteri, 4))
+			out_loop(&srci, &miteri, &miter, src, len, big);
+		else
+			out_loop_ua(&srci, &miteri, &miter, src, len, big);
+		out_fragment_end(&srci, &miteri, &miter, src, len, &buf, big);
+	}
+	sg_miter_stop(&miter);
+	return srci;
+}
-- 
2.17.1

