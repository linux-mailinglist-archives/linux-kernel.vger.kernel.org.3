Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80334A4D20
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380950AbiAaRZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:25:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45674 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380917AbiAaRZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:25:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F14060F8A;
        Mon, 31 Jan 2022 17:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85785C340F0;
        Mon, 31 Jan 2022 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643649910;
        bh=nPEjBRXdNzJXnjxJpmZvEAHmB5XNHQExUL9DWceCG/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYEf6MTUz5T1TYyB7XLVEkniNo8tV3ymo6lP16pjyRRHJgOzFGYW6M9XfLvlPaACq
         Ma/IuTu/LhnENpXWd11jNdwbfdRsFdI8yf/3cbzgThsJUBNRlX1VQPr74sDbR3x4t7
         ZOmlSPhWwpk6+vDjgRUAQnmB06QXnsTRvWwtEcgB8nSMj+vbc1SGl9XBewKVhCWJDo
         3AI+0dHlW1ziV/bZQOZz8CCkK8o/vR/gor/4v5k+Jf85yhQx4Eje1ztyZEYcUQKySh
         cq8QQNh3BqIzQ9TrGmZa9kruChaQDNZJ5HKI3r980OX5hHXTS5lT3GEzDKz1LYiXOU
         eN0TRBG35p6fg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3/3] spmi: pmic-arb: Add support for PMIC v7
Date:   Mon, 31 Jan 2022 22:54:50 +0530
Message-Id: <20220131172450.2528065-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220131172450.2528065-1-vkoul@kernel.org>
References: <20220131172450.2528065-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

PMIC v7 has different offset values and seqeunces, so add support for
this new version of PMIC

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 233 ++++++++++++++++++++++++++++++++---
 1 file changed, 214 insertions(+), 19 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 2113be40b5a9..f4d54e7785a8 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -22,8 +22,14 @@
 #define PMIC_ARB_VERSION_V2_MIN		0x20010000
 #define PMIC_ARB_VERSION_V3_MIN		0x30000000
 #define PMIC_ARB_VERSION_V5_MIN		0x50000000
+#define PMIC_ARB_VERSION_V7_MIN		0x70000000
 #define PMIC_ARB_INT_EN			0x0004
 
+#define PMIC_ARB_FEATURES		0x0004
+#define PMIC_ARB_FEATURES_PERIPH_MASK	GENMASK(10, 0)
+
+#define PMIC_ARB_FEATURES1		0x0008
+
 /* PMIC Arbiter channel registers offsets */
 #define PMIC_ARB_CMD			0x00
 #define PMIC_ARB_CONFIG			0x04
@@ -48,7 +54,6 @@
 #define INVALID_EE				0xFF
 
 /* Ownership Table */
-#define SPMI_OWNERSHIP_TABLE_REG(N)	(0x0700 + (4 * (N)))
 #define SPMI_OWNERSHIP_PERIPH2OWNER(X)	((X) & 0x7)
 
 /* Channel Status fields */
@@ -91,6 +96,7 @@ enum pmic_arb_channel {
 
 /* Maximum number of support PMIC peripherals */
 #define PMIC_ARB_MAX_PERIPHS		512
+#define PMIC_ARB_MAX_PERIPHS_V7		1024
 #define PMIC_ARB_TIMEOUT_US		100
 #define PMIC_ARB_MAX_TRANS_BYTES	(8)
 
@@ -104,12 +110,12 @@ enum pmic_arb_channel {
 	((((slave_id) & 0xF)   << 28) | \
 	(((periph_id) & 0xFF)  << 20) | \
 	(((irq_id)    & 0x7)   << 16) | \
-	(((apid)      & 0x1FF) << 0))
+	(((apid)      & 0x3FF) << 0))
 
 #define hwirq_to_sid(hwirq)  (((hwirq) >> 28) & 0xF)
 #define hwirq_to_per(hwirq)  (((hwirq) >> 20) & 0xFF)
 #define hwirq_to_irq(hwirq)  (((hwirq) >> 16) & 0x7)
-#define hwirq_to_apid(hwirq) (((hwirq) >> 0)  & 0x1FF)
+#define hwirq_to_apid(hwirq) (((hwirq) >> 0)  & 0x3FF)
 
 struct pmic_arb_ver_ops;
 
@@ -137,6 +143,8 @@ struct apid_data {
  * @spmic:		SPMI controller object
  * @ver_ops:		version dependent operations.
  * @ppid_to_apid	in-memory copy of PPID -> APID mapping table.
+ * @apid_data:		Table of data for all APIDs
+ * @max_periphs:	Number of elements in apid_data[]
  */
 struct spmi_pmic_arb {
 	void __iomem		*rd_base;
@@ -149,8 +157,11 @@ struct spmi_pmic_arb {
 	u8			channel;
 	int			irq;
 	u8			ee;
+	u32			bus_instance;
 	u16			min_apid;
 	u16			max_apid;
+	u16			base_apid;
+	int			apid_count;
 	u32			*mapping_table;
 	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
 	struct irq_domain	*domain;
@@ -158,7 +169,8 @@ struct spmi_pmic_arb {
 	const struct pmic_arb_ver_ops *ver_ops;
 	u16			*ppid_to_apid;
 	u16			last_apid;
-	struct apid_data	apid_data[PMIC_ARB_MAX_PERIPHS];
+	struct apid_data	*apid_data;
+	int			max_periphs;
 };
 
 /**
@@ -180,6 +192,7 @@ struct spmi_pmic_arb {
  * @irq_clear:		on v1 address of PMIC_ARB_SPMI_PIC_IRQ_CLEARn
  *			on v2 address of SPMI_PIC_IRQ_CLEARn.
  * @apid_map_offset:	offset of PMIC_ARB_REG_CHNLn
+ * @apid_owner:		on v2 and later address of SPMI_PERIPHn_2OWNER_TABLE_REG
  */
 struct pmic_arb_ver_ops {
 	const char *ver_str;
@@ -196,6 +209,7 @@ struct pmic_arb_ver_ops {
 	void __iomem *(*irq_status)(struct spmi_pmic_arb *pmic_arb, u16 n);
 	void __iomem *(*irq_clear)(struct spmi_pmic_arb *pmic_arb, u16 n);
 	u32 (*apid_map_offset)(u16 n);
+	void __iomem *(*apid_owner)(struct spmi_pmic_arb *pmic_arb, u16 n);
 };
 
 static inline void pmic_arb_base_write(struct spmi_pmic_arb *pmic_arb,
@@ -631,6 +645,11 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int first = pmic_arb->min_apid >> 5;
 	int last = pmic_arb->max_apid >> 5;
+	/*
+	 * acc_offset will be non-zero for the secondary SPMI bus instance on
+	 * v7 controllers.
+	 */
+	int acc_offset = pmic_arb->base_apid >> 5;
 	u8 ee = pmic_arb->ee;
 	u32 status, enable;
 	int i, id, apid;
@@ -638,8 +657,7 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	for (i = first; i <= last; ++i) {
-		status = readl_relaxed(
-				ver_ops->owner_acc_status(pmic_arb, ee, i));
+		status = readl_relaxed(ver_ops->owner_acc_status(pmic_arb, ee, i - acc_offset));
 		while (status) {
 			id = ffs(status) - 1;
 			status &= ~BIT(id);
@@ -944,8 +962,8 @@ static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 		if (offset >= pmic_arb->core_size)
 			break;
 
-		regval = readl_relaxed(pmic_arb->cnfg +
-				      SPMI_OWNERSHIP_TABLE_REG(apid));
+		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb,
+								     apid));
 		apidd->irq_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
 		apidd->write_ee = apidd->irq_ee;
 
@@ -981,20 +999,29 @@ static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 
 static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 {
-	struct apid_data *apidd = pmic_arb->apid_data;
+	struct apid_data *apidd;
 	struct apid_data *prev_apidd;
-	u16 i, apid, ppid;
+	u16 i, apid, ppid, apid_max;
 	bool valid, is_irq_ee;
 	u32 regval, offset;
 
 	/*
 	 * In order to allow multiple EEs to write to a single PPID in arbiter
-	 * version 5, there is more than one APID mapped to each PPID.
+	 * version 5 and 7, there is more than one APID mapped to each PPID.
 	 * The owner field for each of these mappings specifies the EE which is
 	 * allowed to write to the APID.  The owner of the last (highest) APID
 	 * for a given PPID will receive interrupts from the PPID.
+	 *
+	 * In arbiter version 7, the APID numbering space is divided between
+	 * the primary bus (0) and secondary bus (1) such that:
+	 * APID = 0 to N-1 are assigned to the primary bus
+	 * APID = N to N+M-1 are assigned to the secondary bus
+	 * where N = number of APIDs supported by the primary bus and
+	 *       M = number of APIDs supported by the secondary bus
 	 */
-	for (i = 0; ; i++, apidd++) {
+	apidd = &pmic_arb->apid_data[pmic_arb->base_apid];
+	apid_max = pmic_arb->base_apid + pmic_arb->apid_count;
+	for (i = pmic_arb->base_apid; i < apid_max; i++, apidd++) {
 		offset = pmic_arb->ver_ops->apid_map_offset(i);
 		if (offset >= pmic_arb->core_size)
 			break;
@@ -1005,8 +1032,8 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 		ppid = (regval >> 8) & PMIC_ARB_PPID_MASK;
 		is_irq_ee = PMIC_ARB_CHAN_IS_IRQ_OWNER(regval);
 
-		regval = readl_relaxed(pmic_arb->cnfg +
-				      SPMI_OWNERSHIP_TABLE_REG(i));
+		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb,
+								     i));
 		apidd->write_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
 
 		apidd->irq_ee = is_irq_ee ? apidd->write_ee : INVALID_EE;
@@ -1100,6 +1127,40 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return offset;
 }
 
+/*
+ * v7 offset per ee and per apid for observer channels and per apid for
+ * read/write channels.
+ */
+static int pmic_arb_offset_v7(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
+			   enum pmic_arb_channel ch_type)
+{
+	u16 apid;
+	int rc;
+	u32 offset = 0;
+	u16 ppid = (sid << 8) | (addr >> 8);
+
+	rc = pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
+	if (rc < 0)
+		return rc;
+
+	apid = rc;
+	switch (ch_type) {
+	case PMIC_ARB_CHANNEL_OBS:
+		offset = 0x8000 * pmic_arb->ee + 0x20 * apid;
+		break;
+	case PMIC_ARB_CHANNEL_RW:
+		if (pmic_arb->apid_data[apid].write_ee != pmic_arb->ee) {
+			dev_err(&pmic_arb->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
+				sid, addr);
+			return -EPERM;
+		}
+		offset = 0x1000 * apid;
+		break;
+	}
+
+	return offset;
+}
+
 static u32 pmic_arb_fmt_cmd_v1(u8 opc, u8 sid, u16 addr, u8 bc)
 {
 	return (opc << 27) | ((sid & 0xf) << 20) | (addr << 4) | (bc & 0x7);
@@ -1134,6 +1195,12 @@ pmic_arb_owner_acc_status_v5(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
 	return pmic_arb->intr + 0x10000 * m + 0x4 * n;
 }
 
+static void __iomem *
+pmic_arb_owner_acc_status_v7(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+{
+	return pmic_arb->intr + 0x1000 * m + 0x4 * n;
+}
+
 static void __iomem *
 pmic_arb_acc_enable_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
 {
@@ -1152,6 +1219,12 @@ pmic_arb_acc_enable_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
 	return pmic_arb->wr_base + 0x100 + 0x10000 * n;
 }
 
+static void __iomem *
+pmic_arb_acc_enable_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+{
+	return pmic_arb->wr_base + 0x100 + 0x1000 * n;
+}
+
 static void __iomem *
 pmic_arb_irq_status_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
 {
@@ -1170,6 +1243,12 @@ pmic_arb_irq_status_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
 	return pmic_arb->wr_base + 0x104 + 0x10000 * n;
 }
 
+static void __iomem *
+pmic_arb_irq_status_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+{
+	return pmic_arb->wr_base + 0x104 + 0x1000 * n;
+}
+
 static void __iomem *
 pmic_arb_irq_clear_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
 {
@@ -1188,6 +1267,12 @@ pmic_arb_irq_clear_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
 	return pmic_arb->wr_base + 0x108 + 0x10000 * n;
 }
 
+static void __iomem *
+pmic_arb_irq_clear_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+{
+	return pmic_arb->wr_base + 0x108 + 0x1000 * n;
+}
+
 static u32 pmic_arb_apid_map_offset_v2(u16 n)
 {
 	return 0x800 + 0x4 * n;
@@ -1198,6 +1283,28 @@ static u32 pmic_arb_apid_map_offset_v5(u16 n)
 	return 0x900 + 0x4 * n;
 }
 
+static u32 pmic_arb_apid_map_offset_v7(u16 n)
+{
+	return 0x2000 + 0x4 * n;
+}
+
+static void __iomem *
+pmic_arb_apid_owner_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
+{
+	return pmic_arb->cnfg + 0x700 + 0x4 * n;
+}
+
+/*
+ * For arbiter version 7, APID ownership table registers have independent
+ * numbering space for each SPMI bus instance, so each is indexed starting from
+ * 0.
+ */
+static void __iomem *
+pmic_arb_apid_owner_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+{
+	return pmic_arb->cnfg + 0x4 * (n - pmic_arb->base_apid);
+}
+
 static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 	.ver_str		= "v1",
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v1,
@@ -1209,6 +1316,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 	.irq_status		= pmic_arb_irq_status_v1,
 	.irq_clear		= pmic_arb_irq_clear_v1,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
+	.apid_owner		= pmic_arb_apid_owner_v2,
 };
 
 static const struct pmic_arb_ver_ops pmic_arb_v2 = {
@@ -1222,6 +1330,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v2 = {
 	.irq_status		= pmic_arb_irq_status_v2,
 	.irq_clear		= pmic_arb_irq_clear_v2,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
+	.apid_owner		= pmic_arb_apid_owner_v2,
 };
 
 static const struct pmic_arb_ver_ops pmic_arb_v3 = {
@@ -1235,6 +1344,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v3 = {
 	.irq_status		= pmic_arb_irq_status_v2,
 	.irq_clear		= pmic_arb_irq_clear_v2,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v2,
+	.apid_owner		= pmic_arb_apid_owner_v2,
 };
 
 static const struct pmic_arb_ver_ops pmic_arb_v5 = {
@@ -1248,6 +1358,21 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 	.irq_status		= pmic_arb_irq_status_v5,
 	.irq_clear		= pmic_arb_irq_clear_v5,
 	.apid_map_offset	= pmic_arb_apid_map_offset_v5,
+	.apid_owner		= pmic_arb_apid_owner_v2,
+};
+
+static const struct pmic_arb_ver_ops pmic_arb_v7 = {
+	.ver_str		= "v7",
+	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
+	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
+	.offset			= pmic_arb_offset_v7,
+	.fmt_cmd		= pmic_arb_fmt_cmd_v2,
+	.owner_acc_status	= pmic_arb_owner_acc_status_v7,
+	.acc_enable		= pmic_arb_acc_enable_v7,
+	.irq_status		= pmic_arb_irq_status_v7,
+	.irq_clear		= pmic_arb_irq_clear_v7,
+	.apid_map_offset	= pmic_arb_apid_map_offset_v7,
+	.apid_owner		= pmic_arb_apid_owner_v7,
 };
 
 static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
@@ -1274,8 +1399,18 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	pmic_arb = spmi_controller_get_drvdata(ctrl);
 	pmic_arb->spmic = ctrl;
 
+	/*
+	 * Please don't replace this with devm_platform_ioremap_resource() or
+	 * devm_ioremap_resource().  These both result in a call to
+	 * devm_request_mem_region() which prevents multiple mappings of this
+	 * register address range.  SoCs with PMIC arbiter v7 may define two
+	 * arbiter devices, for the two physical SPMI interfaces, which  share
+	 * some register address ranges (i.e. "core", "obsrvr", and "chnls").
+	 * Ensure that both devices probe successfully by calling devm_ioremap()
+	 * which does not result in a devm_request_mem_region() call.
+	 */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
-	core = devm_ioremap_resource(&ctrl->dev, res);
+	core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
 	if (IS_ERR(core)) {
 		err = PTR_ERR(core);
 		goto err_put_ctrl;
@@ -1304,12 +1439,15 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 			pmic_arb->ver_ops = &pmic_arb_v2;
 		else if (hw_ver < PMIC_ARB_VERSION_V5_MIN)
 			pmic_arb->ver_ops = &pmic_arb_v3;
-		else
+		else if (hw_ver < PMIC_ARB_VERSION_V7_MIN)
 			pmic_arb->ver_ops = &pmic_arb_v5;
+		else
+			pmic_arb->ver_ops = &pmic_arb_v7;
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "obsrvr");
-		pmic_arb->rd_base = devm_ioremap_resource(&ctrl->dev, res);
+		pmic_arb->rd_base = devm_ioremap(&ctrl->dev, res->start,
+						 resource_size(res));
 		if (IS_ERR(pmic_arb->rd_base)) {
 			err = PTR_ERR(pmic_arb->rd_base);
 			goto err_put_ctrl;
@@ -1317,13 +1455,70 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "chnls");
-		pmic_arb->wr_base = devm_ioremap_resource(&ctrl->dev, res);
+		pmic_arb->wr_base = devm_ioremap(&ctrl->dev, res->start,
+						 resource_size(res));
 		if (IS_ERR(pmic_arb->wr_base)) {
 			err = PTR_ERR(pmic_arb->wr_base);
 			goto err_put_ctrl;
 		}
 	}
 
+	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
+
+	if (hw_ver >= PMIC_ARB_VERSION_V7_MIN) {
+		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V7;
+		/* Optional property for v7: */
+		of_property_read_u32(pdev->dev.of_node, "qcom,bus-id",
+					&pmic_arb->bus_instance);
+		if (pmic_arb->bus_instance > 1) {
+			err = -EINVAL;
+			dev_err(&pdev->dev, "invalid bus instance (%u) specified\n",
+				pmic_arb->bus_instance);
+			goto err_put_ctrl;
+		}
+
+		if (pmic_arb->bus_instance == 0) {
+			pmic_arb->base_apid = 0;
+			pmic_arb->apid_count =
+				readl_relaxed(core + PMIC_ARB_FEATURES) &
+				PMIC_ARB_FEATURES_PERIPH_MASK;
+		} else {
+			pmic_arb->base_apid =
+				readl_relaxed(core + PMIC_ARB_FEATURES) &
+				PMIC_ARB_FEATURES_PERIPH_MASK;
+			pmic_arb->apid_count =
+				readl_relaxed(core + PMIC_ARB_FEATURES1) &
+				PMIC_ARB_FEATURES_PERIPH_MASK;
+		}
+
+		if (pmic_arb->base_apid + pmic_arb->apid_count >
+		    pmic_arb->max_periphs) {
+			err = -EINVAL;
+			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
+				pmic_arb->base_apid + pmic_arb->apid_count);
+			goto err_put_ctrl;
+		}
+	} else if (hw_ver >= PMIC_ARB_VERSION_V5_MIN) {
+		pmic_arb->base_apid = 0;
+		pmic_arb->apid_count = readl_relaxed(core + PMIC_ARB_FEATURES) &
+					PMIC_ARB_FEATURES_PERIPH_MASK;
+
+		if (pmic_arb->apid_count > pmic_arb->max_periphs) {
+			err = -EINVAL;
+			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
+				pmic_arb->apid_count);
+			goto err_put_ctrl;
+		}
+	}
+
+	pmic_arb->apid_data = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
+					   sizeof(*pmic_arb->apid_data),
+					   GFP_KERNEL);
+	if (!pmic_arb->apid_data) {
+		err = -ENOMEM;
+		goto err_put_ctrl;
+	}
+
 	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
 		 pmic_arb->ver_ops->ver_str, hw_ver);
 
@@ -1386,7 +1581,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	/* Initialize max_apid/min_apid to the opposite bounds, during
 	 * the irq domain translation, we are sure to update these */
 	pmic_arb->max_apid = 0;
-	pmic_arb->min_apid = PMIC_ARB_MAX_PERIPHS - 1;
+	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
 
 	platform_set_drvdata(pdev, ctrl);
 	raw_spin_lock_init(&pmic_arb->lock);
-- 
2.31.1

