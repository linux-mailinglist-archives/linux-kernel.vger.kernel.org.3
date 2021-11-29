Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBFF461D27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbhK2R7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:59:16 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:3170 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243169AbhK2R5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:57:14 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ATF6IC3003861;
        Mon, 29 Nov 2021 09:53:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=RgLAwPklu6l2JeigRzfr7WxK61toYWM1hTDXtcRyUMQ=;
 b=AIfdMz2PxCmAVfMFRINBhGIRth9/m1eXPHyM+Ay3B3BT3xTsmTFwqOIrtRQ2mN4P5Yt5
 Nt7ctEF2alLoUCEC+elaxcOpZ4ppxTm1m9N0x5dHH5x2xKgKoBNaAQXTbMp5dNUhwurr
 t5KHf4zK//p+FiP7QlxVNP6PsUDwtKWLitIyvePB7Y7sCBRqap5TMC9yshquT7QaMV/2
 QtNmBppjG8YmLrfVl7EMhyjdIZb9O/9Cpq7RVuvkqQBrC5Vj1jtk5VrjsqV69MHrPkly
 KvT68gVAoiTT7+KjSI6rakOEVHkjSa0SeRd2wcQiB485wojkOu3AOKtYEtrcNbOBf1m7 Iw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cmtkpjah8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 09:53:51 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 29 Nov
 2021 09:53:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Nov 2021 09:53:48 -0800
Received: from machine421.marvell.com (unknown [10.29.37.2])
        by maili.marvell.com (Postfix) with ESMTP id CEA753F7077;
        Mon, 29 Nov 2021 09:53:46 -0800 (PST)
From:   <sgoutham@marvell.com>
To:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sunil.kovvuri@gmail.com>, Sunil Goutham <sgoutham@marvell.com>,
        "Bharat Bhushan" <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>
Subject: [PATCH] hwrng: cn10k: Add random number generator support
Date:   Mon, 29 Nov 2021 23:23:43 +0530
Message-ID: <1638208423-21494-1-git-send-email-sgoutham@marvell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: iNe_ahid90cO233xbJNezZtbYXTUT1iW
X-Proofpoint-ORIG-GUID: iNe_ahid90cO233xbJNezZtbYXTUT1iW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_10,2021-11-28_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

CN10K series of silicons support true random number
generators. This patch adds support for the same. Also
supports entropy health status checking.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Joseph Longever <jlongever@marvell.com>
---
 drivers/char/hw_random/Kconfig     |  11 ++
 drivers/char/hw_random/Makefile    |   1 +
 drivers/char/hw_random/cn10k-rng.c | 205 +++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/char/hw_random/cn10k-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 1da6477..001b819 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -538,6 +538,17 @@ config HW_RANDOM_ARM_SMCCC_TRNG
 	  To compile this driver as a module, choose M here: the
 	  module will be called arm_smccc_trng.
 
+config HW_RANDOM_CN10K
+       tristate "Marvell CN10K Random Number Generator support"
+       depends on HW_RANDOM && PCI && ARM64
+       default HW_RANDOM
+       help
+	 This driver provides support for the True Random Number
+	 generator available in Marvell CN10K SoCs.
+
+	 To compile this driver as a module, choose M here.
+	 The module will be called cn10k_rng. If unsure, say Y.
+
 endif # HW_RANDOM
 
 config UML_RANDOM
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index a5a1c76..a2f1ce0 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -46,3 +46,4 @@ obj-$(CONFIG_HW_RANDOM_NPCM) += npcm-rng.o
 obj-$(CONFIG_HW_RANDOM_CCTRNG) += cctrng.o
 obj-$(CONFIG_HW_RANDOM_XIPHERA) += xiphera-trng.o
 obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) += arm_smccc_trng.o
+obj-$(CONFIG_HW_RANDOM_CN10K) += cn10k-rng.o
diff --git a/drivers/char/hw_random/cn10k-rng.c b/drivers/char/hw_random/cn10k-rng.c
new file mode 100644
index 0000000..e348732
--- /dev/null
+++ b/drivers/char/hw_random/cn10k-rng.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell CN10K RVU Hardware Random Number Generator.
+ *
+ * Copyright (C) 2021 Marvell.
+ *
+ */
+
+#include <linux/hw_random.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/delay.h>
+
+#include <linux/arm-smccc.h>
+
+/* CSRs */
+#define RNM_CTL_STATUS		0x000
+#define RNM_ENTROPY_STATUS	0x008
+#define RNM_CONST		0x030
+#define RNM_EBG_ENT		0x048
+#define RNM_PF_EBG_HEALTH	0x050
+#define RNM_PF_RANDOM		0x400
+#define RNM_TRNG_RESULT		0x408
+
+struct cn10k_rng {
+	void __iomem *reg_base;
+	struct hwrng ops;
+	struct pci_dev *pdev;
+};
+
+#define PLAT_OCTEONTX_RESET_RNG_EBG_HEALTH_STATE     0xc2000b0f
+
+static int reset_rng_health_state(struct cn10k_rng *rng)
+{
+	struct arm_smccc_res res;
+	int ret = 0;
+
+	/* Send SMC service call to reset EBG health state */
+	arm_smccc_smc(PLAT_OCTEONTX_RESET_RNG_EBG_HEALTH_STATE, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 == 0UL) {
+		dev_info(&rng->pdev->dev, "HWRNG: reset completed\n");
+	} else {
+		dev_err(&rng->pdev->dev, "HWRNG: error during reset\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int check_rng_health(struct cn10k_rng *rng)
+{
+	u64 status;
+
+	/* Skip checking health */
+	if (!rng->reg_base)
+		return 0;
+
+	status = readq(rng->reg_base + RNM_PF_EBG_HEALTH);
+	if (status & BIT_ULL(20)) {
+		dev_err(&rng->pdev->dev,
+			"HWRNG: Health test failed (status=%llx)\n", status);
+		return reset_rng_health_state(rng);
+	}
+	return 0;
+}
+
+static int cn10k_check_entropy(struct cn10k_rng *rng)
+{
+	int retries = 5;
+	u64 ent_status;
+
+	while (retries) {
+		ent_status = readq(rng->reg_base + RNM_ENTROPY_STATUS);
+		if (ent_status & 0x7FULL)
+			break;
+		udelay(20);
+		retries--;
+	}
+	return ent_status & 0x7FULL;
+}
+
+static int cn10k_read_trng(struct cn10k_rng *rng, u64 *value)
+{
+	u64 addr, result = 0;
+	int retry_count = 5;
+
+	addr = (u64)rng->reg_base + RNM_PF_RANDOM;
+	/* TRNG and status need to be read at a time */
+	while (!result && retry_count) {
+		__asm__ volatile("ldp  %0,%1,[%2]" :\
+				 "=r" (*value), "=r" (result) : "r" (addr) : );
+
+		retry_count--;
+	}
+
+	return retry_count ? 0 : -EIO;
+}
+
+static int cn10k_rng_read(struct hwrng *hwrng, void *data,
+			  size_t max, bool wait)
+{
+	struct cn10k_rng *rng = (struct cn10k_rng *)hwrng->priv;
+	unsigned int size;
+	int err = 0;
+	u64 value;
+
+	err = check_rng_health(rng);
+	if (err)
+		return err;
+
+	/* HW can run out of entropy if large amount random data is read in
+	 * quick succession. So check if it's available to be read.
+	 */
+	size = cn10k_check_entropy(rng);
+	if (size > max)
+		size = max;
+	else
+		max = size;
+
+	while (size >= 8) {
+		err = cn10k_read_trng(rng, &value);
+		if (err)
+			goto exit;
+
+		*((u64 *)data) = (u64)value;
+		size -= 8;
+		data += 8;
+	}
+
+	while (size > 0) {
+		err = cn10k_read_trng(rng, &value);
+		if (err)
+			goto exit;
+
+		*((u8 *)data) = (u8)value;
+		size--;
+		data++;
+	}
+
+exit:
+	return max - size;
+}
+
+static int cn10k_rng_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct	cn10k_rng *rng;
+	int	err;
+
+	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
+	if (!rng)
+		return -ENOMEM;
+
+	rng->pdev = pdev;
+	pci_set_drvdata(pdev, rng);
+
+	rng->reg_base = pcim_iomap(pdev, 0, 0);
+	if (!rng->reg_base) {
+		dev_err(&pdev->dev, "Error while mapping CSRs, exiting\n");
+		return -ENOMEM;
+	}
+
+	rng->ops.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+				       "cn10k-rng-%s", dev_name(&pdev->dev));
+	if (!rng->ops.name)
+		return -ENOMEM;
+
+	rng->ops.read    = cn10k_rng_read;
+	rng->ops.quality = 1000;
+	rng->ops.priv = (unsigned long)rng;
+
+	err = devm_hwrng_register(&pdev->dev, &rng->ops);
+	if (err) {
+		dev_err(&pdev->dev, "Could not register hwrng device.\n");
+		return err;
+	}
+
+	reset_rng_health_state(rng);
+
+	return 0;
+}
+
+static void cn10k_rng_remove(struct pci_dev *pdev)
+{
+	/* Nothing to do */
+}
+
+static const struct pci_device_id cn10k_rng_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xA098) }, /* RNG PF */
+	{0,},
+};
+
+MODULE_DEVICE_TABLE(pci, cn10k_rng_id_table);
+
+static struct pci_driver cn10k_rng_driver = {
+	.name		= "cn10k_rng",
+	.id_table	= cn10k_rng_id_table,
+	.probe		= cn10k_rng_probe,
+	.remove		= cn10k_rng_remove,
+};
+
+module_pci_driver(cn10k_rng_driver);
+MODULE_AUTHOR("Sunil Goutham <sgoutham@marvell.com>");
+MODULE_DESCRIPTION("Marvell CN10K HW RNG Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

