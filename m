Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB32F5052B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiDRMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbiDRMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:39:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C421A383;
        Mon, 18 Apr 2022 05:30:20 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23ICUEb8072028;
        Mon, 18 Apr 2022 07:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650285014;
        bh=cHGPmtvXxs8biTYESwSuGT8XUHiC/b5q+NY8NwRIHbw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=reH3SfIq7vs9XizVY483mD5LmSugCAWNjUEz9iVWkQVOyQ65n8/pg4rB1GBLimYGQ
         /S1RrriWkVcls2P8YW6HlNW3RjEU0mfO/Qrh4CsnPTbD13EZYh/MLpEKXZ0SRA8g2D
         bEnhLh4TsFS4+WpbMY8ajAwjLK/2qi5ujnhEjzKo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23ICUE0h016576
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Apr 2022 07:30:14 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 18
 Apr 2022 07:30:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 18 Apr 2022 07:30:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23ICUDuo011244;
        Mon, 18 Apr 2022 07:30:13 -0500
From:   Puranjay Mohan <p-mohan@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <p-mohan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <rogerq@kernel.org>, <grygorii.strashko@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>
Subject: [PATCH v2 3/6] soc: ti: pruss: Add pruss_cfg_read()/update() API
Date:   Mon, 18 Apr 2022 18:00:01 +0530
Message-ID: <20220418123004.9332-4-p-mohan@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220418123004.9332-1-p-mohan@ti.com>
References: <20220418123004.9332-1-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
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

From: Suman Anna <s-anna@ti.com>

Add two new generic API pruss_cfg_read() and pruss_cfg_update() to
the PRUSS platform driver to allow other drivers to read and program
respectively a register within the PRUSS CFG sub-module represented
by a syscon driver. This interface provides a simple way for client
drivers without having them to include and parse the CFG syscon node
within their respective device nodes. Various useful registers and
macros for certain register bit-fields and their values have also
been added.

It is the responsibility of the client drivers to reconfigure or
reset a particular register upon any failures.

Signed-off-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
---
 drivers/soc/ti/pruss.c |  41 +++++++++++++++++
 include/linux/pruss.h  | 102 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 95c0cbd7c52f..bf5471c4fa33 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -164,6 +164,47 @@ int pruss_release_mem_region(struct pruss *pruss,
 }
 EXPORT_SYMBOL_GPL(pruss_release_mem_region);
 
+/**
+ * pruss_cfg_read() - read a PRUSS CFG sub-module register
+ * @pruss: the pruss instance handle
+ * @reg: register offset within the CFG sub-module
+ * @val: pointer to return the value in
+ *
+ * Reads a given register within the PRUSS CFG sub-module and
+ * returns it through the passed-in @val pointer
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int pruss_cfg_read(struct pruss *pruss, unsigned int reg, unsigned int *val)
+{
+	if (IS_ERR_OR_NULL(pruss))
+		return -EINVAL;
+
+	return regmap_read(pruss->cfg_regmap, reg, val);
+}
+EXPORT_SYMBOL_GPL(pruss_cfg_read);
+
+/**
+ * pruss_cfg_update() - configure a PRUSS CFG sub-module register
+ * @pruss: the pruss instance handle
+ * @reg: register offset within the CFG sub-module
+ * @mask: bit mask to use for programming the @val
+ * @val: value to write
+ *
+ * Programs a given register within the PRUSS CFG sub-module
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int pruss_cfg_update(struct pruss *pruss, unsigned int reg,
+		     unsigned int mask, unsigned int val)
+{
+	if (IS_ERR_OR_NULL(pruss))
+		return -EINVAL;
+
+	return regmap_update_bits(pruss->cfg_regmap, reg, mask, val);
+}
+EXPORT_SYMBOL_GPL(pruss_cfg_update);
+
 static void pruss_of_free_clk_provider(void *data)
 {
 	struct device_node *clk_mux_np = data;
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index 689ef243bcbc..eb2f974eef9c 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -10,12 +10,99 @@
 #ifndef __LINUX_PRUSS_H
 #define __LINUX_PRUSS_H
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/types.h>
 
 #define PRU_RPROC_DRVNAME "pru-rproc"
 
+/*
+ * PRU_ICSS_CFG registers
+ * SYSCFG, ISRP, ISP, IESP, IECP, SCRP applicable on AMxxxx devices only
+ */
+#define PRUSS_CFG_REVID		0x00
+#define PRUSS_CFG_SYSCFG	0x04
+#define PRUSS_CFG_GPCFG(x)	(0x08 + (x) * 4)
+#define PRUSS_CFG_CGR		0x10
+#define PRUSS_CFG_ISRP		0x14
+#define PRUSS_CFG_ISP		0x18
+#define PRUSS_CFG_IESP		0x1C
+#define PRUSS_CFG_IECP		0x20
+#define PRUSS_CFG_SCRP		0x24
+#define PRUSS_CFG_PMAO		0x28
+#define PRUSS_CFG_MII_RT	0x2C
+#define PRUSS_CFG_IEPCLK	0x30
+#define PRUSS_CFG_SPP		0x34
+#define PRUSS_CFG_PIN_MX	0x40
+
+/* PRUSS_GPCFG register bits */
+#define PRUSS_GPCFG_PRU_GPO_SH_SEL		BIT(25)
+
+#define PRUSS_GPCFG_PRU_DIV1_SHIFT		20
+#define PRUSS_GPCFG_PRU_DIV1_MASK		GENMASK(24, 20)
+
+#define PRUSS_GPCFG_PRU_DIV0_SHIFT		15
+#define PRUSS_GPCFG_PRU_DIV0_MASK		GENMASK(15, 19)
+
+#define PRUSS_GPCFG_PRU_GPO_MODE		BIT(14)
+#define PRUSS_GPCFG_PRU_GPO_MODE_DIRECT		0
+#define PRUSS_GPCFG_PRU_GPO_MODE_SERIAL		BIT(14)
+
+#define PRUSS_GPCFG_PRU_GPI_SB			BIT(13)
+
+#define PRUSS_GPCFG_PRU_GPI_DIV1_SHIFT		8
+#define PRUSS_GPCFG_PRU_GPI_DIV1_MASK		GENMASK(12, 8)
+
+#define PRUSS_GPCFG_PRU_GPI_DIV0_SHIFT		3
+#define PRUSS_GPCFG_PRU_GPI_DIV0_MASK		GENMASK(7, 3)
+
+#define PRUSS_GPCFG_PRU_GPI_CLK_MODE_POSITIVE	0
+#define PRUSS_GPCFG_PRU_GPI_CLK_MODE_NEGATIVE	BIT(2)
+#define PRUSS_GPCFG_PRU_GPI_CLK_MODE		BIT(2)
+
+#define PRUSS_GPCFG_PRU_GPI_MODE_MASK		GENMASK(1, 0)
+#define PRUSS_GPCFG_PRU_GPI_MODE_SHIFT		0
+
+#define PRUSS_GPCFG_PRU_MUX_SEL_SHIFT		26
+#define PRUSS_GPCFG_PRU_MUX_SEL_MASK		GENMASK(29, 26)
+
+/* PRUSS_MII_RT register bits */
+#define PRUSS_MII_RT_EVENT_EN			BIT(0)
+
+/* PRUSS_SPP register bits */
+#define PRUSS_SPP_XFER_SHIFT_EN			BIT(1)
+#define PRUSS_SPP_PRU1_PAD_HP_EN		BIT(0)
+
+/*
+ * enum pruss_gp_mux_sel - PRUSS GPI/O Mux modes for the
+ * PRUSS_GPCFG0/1 registers
+ *
+ * NOTE: The below defines are the most common values, but there
+ * are some exceptions like on 66AK2G, where the RESERVED and MII2
+ * values are interchanged. Also, this bit-field does not exist on
+ * AM335x SoCs
+ */
+enum pruss_gp_mux_sel {
+	PRUSS_GP_MUX_SEL_GP = 0,
+	PRUSS_GP_MUX_SEL_ENDAT,
+	PRUSS_GP_MUX_SEL_RESERVED,
+	PRUSS_GP_MUX_SEL_SD,
+	PRUSS_GP_MUX_SEL_MII2,
+	PRUSS_GP_MUX_SEL_MAX,
+};
+
+/*
+ * enum pruss_gpi_mode - PRUSS GPI configuration modes, used
+ *			 to program the PRUSS_GPCFG0/1 registers
+ */
+enum pruss_gpi_mode {
+	PRUSS_GPI_MODE_DIRECT = 0,
+	PRUSS_GPI_MODE_PARALLEL,
+	PRUSS_GPI_MODE_28BIT_SHIFT,
+	PRUSS_GPI_MODE_MII,
+};
+
 /*
  * enum pruss_pru_id - PRU core identifiers
  */
@@ -73,6 +160,9 @@ int pruss_request_mem_region(struct pruss *pruss, enum pruss_mem mem_id,
 			     struct pruss_mem_region *region);
 int pruss_release_mem_region(struct pruss *pruss,
 			     struct pruss_mem_region *region);
+int pruss_cfg_read(struct pruss *pruss, unsigned int reg, unsigned int *val);
+int pruss_cfg_update(struct pruss *pruss, unsigned int reg,
+		     unsigned int mask, unsigned int val);
 
 #else
 
@@ -96,6 +186,18 @@ static inline int pruss_release_mem_region(struct pruss *pruss,
 	return -EOPNOTSUPP;
 }
 
+static inline int pruss_cfg_read(struct pruss *pruss, unsigned int reg,
+				 unsigned int *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pruss_cfg_update(struct pruss *pruss, unsigned int reg,
+				   unsigned int mask, unsigned int val)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_TI_PRUSS */
 
 #if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
-- 
2.17.1

