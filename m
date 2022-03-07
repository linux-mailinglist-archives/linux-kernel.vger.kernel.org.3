Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AE64D030B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiCGPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243771AbiCGPiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:38:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771CE91AFC;
        Mon,  7 Mar 2022 07:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646667442; x=1678203442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ybW3M4nzO8GKlJknw4z8ysGU3mE/whXfEi076XbiQk=;
  b=qPr7072Yy9lJyZAckRpOPBSDS6QMsdpAggHdy3/mhL2zkxNvtovojSKA
   4leyqBdZa955u2zyvM0i0adMrTKurGwG/QDNNOmLex6zmFUww7Rpzy+mB
   tRyYQqftPzfead/NyOtywP8N/8qYr1m2SykaWxKExgkF/mRJJ70SdRX/q
   c6gynbka4KFoHmb6KXXGfJS3kXxK/fU2/eDf77qnSa/p3hMXx5+Oe9V25
   2xXxmF8AoUnSTv5tl9p+RddEj8g3y1X66+Wt62j+cOEVyDArNUmlcCnbh
   S0BJWvt7HJ3Mp7mbPv7cvEjgPI/15vBjWUDVHJWHPjjMs0MZ45hZIQHjG
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="88075954"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 08:37:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 08:37:21 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 7 Mar 2022 08:37:20 -0700
From:   <conor.dooley@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>
CC:     <lewis.hanly@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Conor Dooley" <conor.dooley@microchip.com>
Subject: [PATCH 1/2] hwrng: mpfs - add polarfire soc hwrng support
Date:   Mon, 7 Mar 2022 15:40:23 +0000
Message-ID: <20220307154023.813158-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307154023.813158-1-conor.dooley@microchip.com>
References: <20220307154023.813158-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add a driver to access the hardware random number generator on the
Polarfire SoC. The hwrng can only be accessed via the system controller,
so use the mailbox interface the system controller exposes to access the
hwrng.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/char/hw_random/Kconfig    |  13 ++++
 drivers/char/hw_random/Makefile   |   1 +
 drivers/char/hw_random/mpfs-rng.c | 103 ++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 drivers/char/hw_random/mpfs-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 9704963f9d50..69f1fd538589 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -385,6 +385,19 @@ config HW_RANDOM_PIC32
 
 	  If unsure, say Y.
 
+config HW_RANDOM_POLARFIRE_SOC
+	tristate "Microchip PolarFire SoC Random Number Generator support"
+	depends on HW_RANDOM && POLARFIRE_SOC_SYS_CTRL
+	help
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on PolarFire SoC (MPFS).
+
+	  To compile this driver as a module, choose M here. The
+	  module will be called mfps_rng.
+
+	  If unsure, say N.
+
+
 config HW_RANDOM_MESON
 	tristate "Amlogic Meson Random Number Generator support"
 	depends on HW_RANDOM
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 584d47ba32f7..3e948cf04476 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -46,3 +46,4 @@ obj-$(CONFIG_HW_RANDOM_CCTRNG) += cctrng.o
 obj-$(CONFIG_HW_RANDOM_XIPHERA) += xiphera-trng.o
 obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) += arm_smccc_trng.o
 obj-$(CONFIG_HW_RANDOM_CN10K) += cn10k-rng.o
+obj-$(CONFIG_HW_RANDOM_POLARFIRE_SOC) += mpfs-rng.o
diff --git a/drivers/char/hw_random/mpfs-rng.c b/drivers/char/hw_random/mpfs-rng.c
new file mode 100644
index 000000000000..a103c765d021
--- /dev/null
+++ b/drivers/char/hw_random/mpfs-rng.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip PolarFire SoC (MPFS) hardware random driver
+ *
+ * Copyright (c) 2020-2022 Microchip Corporation. All rights reserved.
+ *
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ */
+
+#include <linux/module.h>
+#include <linux/hw_random.h>
+#include <linux/platform_device.h>
+#include <soc/microchip/mpfs.h>
+
+#define CMD_OPCODE	0x21
+#define CMD_DATA_SIZE	0U
+#define CMD_DATA	NULL
+#define MBOX_OFFSET	0U
+#define RESP_OFFSET	0U
+#define RNG_RESP_BYTES	32U
+
+struct mpfs_rng {
+	struct mpfs_sys_controller *sys_controller;
+	struct hwrng rng;
+};
+
+static int mpfs_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	struct mpfs_rng *rng_priv = container_of(rng, struct mpfs_rng, rng);
+	u32 response_msg[RNG_RESP_BYTES / sizeof(u32)];
+	unsigned int count = 0, copy_size_bytes;
+	int ret;
+
+	struct mpfs_mss_response response = {
+		.resp_status = 0U,
+		.resp_msg = (u32 *)response_msg,
+		.resp_size = RNG_RESP_BYTES
+	};
+	struct mpfs_mss_msg msg = {
+		.cmd_opcode = CMD_OPCODE,
+		.cmd_data_size = CMD_DATA_SIZE,
+		.response = &response,
+		.cmd_data = CMD_DATA,
+		.mbox_offset = MBOX_OFFSET,
+		.resp_offset = RESP_OFFSET
+	};
+
+	while (count < max) {
+		ret = mpfs_blocking_transaction(rng_priv->sys_controller, &msg);
+		if (ret)
+			return ret;
+
+		copy_size_bytes = max - count > RNG_RESP_BYTES ? RNG_RESP_BYTES : max - count;
+		memcpy(buf + count, response_msg, copy_size_bytes);
+
+		count += copy_size_bytes;
+		if (!wait)
+			break;
+	}
+
+	return count;
+}
+
+static int mpfs_rng_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mpfs_rng *rng_priv;
+	int ret;
+
+	rng_priv = devm_kzalloc(dev, sizeof(*rng_priv), GFP_KERNEL);
+	if (!rng_priv)
+		return -ENOMEM;
+
+	rng_priv->sys_controller =  mpfs_sys_controller_get(&pdev->dev);
+	if (IS_ERR(rng_priv->sys_controller))
+		return dev_err_probe(dev, PTR_ERR(rng_priv->sys_controller),
+				     "Failed to register system controller hwrng sub device\n");
+
+	rng_priv->rng.read = mpfs_rng_read;
+	rng_priv->rng.name = pdev->name;
+
+	platform_set_drvdata(pdev, rng_priv);
+
+	ret = devm_hwrng_register(&pdev->dev, &rng_priv->rng);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to register MPFS hwrng\n");
+
+	dev_info(&pdev->dev, "Registered MPFS hwrng\n");
+
+	return 0;
+}
+
+static struct platform_driver mpfs_rng_driver = {
+	.driver = {
+		.name = "mpfs-rng",
+	},
+	.probe = mpfs_rng_probe,
+};
+module_platform_driver(mpfs_rng_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("PolarFire SoC (MPFS) hardware random driver");
-- 
2.35.1

