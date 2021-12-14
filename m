Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE54740D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhLNKv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:51:59 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35842 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233288AbhLNKv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:51:57 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEAJNtZ019136;
        Tue, 14 Dec 2021 02:51:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=xDPXA9Dvs1IphzstMbremuaj22AGEVES4+HfoxNs3QY=;
 b=SsSSpFXKI1la35sWQ7iHiMuT1jlaFrheUSq7uCz8puZuj0iws/lhqtlZsQpKfnvCrHwW
 Riy1vYc+oR3i+3y5NuLxPkQSS9LX+lTSbVt+7dy3w6Vu5Jt4Zi7pYLnUgNeTLJ/ykiP7
 wO+nHbytMz1s++GAKbdBfiTuaWnexCPC20HUGnpqs+iPWPdiC0xxxvVlBjkWr/7RYJHZ
 bnOHVT300f9IdEdIjk2ZjA/5zRRl87hZwbJe9GqIpPX3dvCm+aMR14e72Kks5RyX1wxy
 6xri38ps/pq+Klg+C4FZjNlIJNcibnVgl86EKlIzIaS+IRS/1SQ3X0RzAdaL9BsXI4Ys wA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cxsds03n3-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 02:51:52 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 14 Dec
 2021 02:51:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 14 Dec 2021 02:51:13 -0800
Received: from machine421.marvell.com (unknown [10.29.37.2])
        by maili.marvell.com (Postfix) with ESMTP id 65B603F703F;
        Tue, 14 Dec 2021 02:51:11 -0800 (PST)
From:   <sgoutham@marvell.com>
To:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sunil.kovvuri@gmail.com>, Sunil Goutham <sgoutham@marvell.com>,
        "Bharat Bhushan" <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>
Subject: [PATCH v2] hwrng: cn10k: Add random number generator support
Date:   Tue, 14 Dec 2021 16:21:08 +0530
Message-ID: <1639479068-22101-1-git-send-email-sgoutham@marvell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: bhbxnzEal0kYVDlP1RV0SF1EvwDt5Obr
X-Proofpoint-ORIG-GUID: bhbxnzEal0kYVDlP1RV0SF1EvwDt5Obr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_06,2021-12-14_01,2021-12-02_01
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
v1 -> v2:
	Fixed warnings reported by kernel test robot.
	Also modified TRNG read logix to address an issue where TRNG_STATUS
	read from HW could be incorrect.
---
 drivers/char/hw_random/Kconfig     |  11 +++
 drivers/char/hw_random/Makefile    |   1 +
 drivers/char/hw_random/cn10k-rng.c | 181 +++++++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
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
index 0000000..35001c6
--- /dev/null
+++ b/drivers/char/hw_random/cn10k-rng.c
@@ -0,0 +1,181 @@
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
+
+	/* Send SMC service call to reset EBG health state */
+	arm_smccc_smc(PLAT_OCTEONTX_RESET_RNG_EBG_HEALTH_STATE, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != 0UL)
+		return -EIO;
+
+	return 0;
+}
+
+static int check_rng_health(struct cn10k_rng *rng)
+{
+	u64 status;
+	int err;
+
+	/* Skip checking health */
+	if (!rng->reg_base)
+		return 0;
+
+	status = readq(rng->reg_base + RNM_PF_EBG_HEALTH);
+	if (status & BIT_ULL(20)) {
+		err = reset_rng_health_state(rng);
+		if (err) {
+			dev_err(&rng->pdev->dev, "HWRNG: Health test failed (status=%llx)\n",
+					status);
+			dev_err(&rng->pdev->dev, "HWRNG: error during reset\n");
+		}
+	}
+	return 0;
+}
+
+static void cn10k_read_trng(struct cn10k_rng *rng, u64 *value)
+{
+	u64 upper, lower;
+
+	*value = readq(rng->reg_base + RNM_PF_RANDOM);
+
+	/* HW can run out of entropy if large amount random data is read in
+	 * quick succession. Zeros may not be real random data from HW.
+	 */
+	if (!*value) {
+		upper = readq(rng->reg_base + RNM_PF_RANDOM);
+		lower = readq(rng->reg_base + RNM_PF_RANDOM);
+		while (!(upper & 0x00000000FFFFFFFFULL))
+			upper = readq(rng->reg_base + RNM_PF_RANDOM);
+		while (!(lower & 0xFFFFFFFF00000000ULL))
+			lower = readq(rng->reg_base + RNM_PF_RANDOM);
+
+		*value = (upper & 0xFFFFFFFF00000000) | (lower & 0xFFFFFFFF);
+	}
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
+	size = max;
+
+	while (size >= 8) {
+		cn10k_read_trng(rng, &value);
+
+		*((u64 *)data) = (u64)value;
+		size -= 8;
+		data += 8;
+	}
+
+	while (size > 0) {
+		cn10k_read_trng(rng, &value);
+
+		*((u8 *)data) = (u8)value;
+		size--;
+		data++;
+	}
+
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
+	reset_rng_health_state(rng);
+
+	err = devm_hwrng_register(&pdev->dev, &rng->ops);
+	if (err) {
+		dev_err(&pdev->dev, "Could not register hwrng device.\n");
+		return err;
+	}
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

