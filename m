Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE2487C59
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiAGSqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiAGSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:46:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BAFC06173F;
        Fri,  7 Jan 2022 10:46:29 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id j16so5500434pll.10;
        Fri, 07 Jan 2022 10:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JjIAIonewoZ/0PMLC1pEg2k6n3SOlIGBtsswSA31us=;
        b=L6AJlNVGCTrVP2UCzU5x1LV1QjP3HtfDodCRv+zh5wFLqPbyvuWktzEMYCzhf1OxiL
         zHYIK72iNIfLxqgfjP1mozDkhguuANLFWGxtMMnWTayccQwaFONg+WUKr2na37jY5Knz
         cmvNbAsftcJxyD/aqP6gMQmBDvB5+DXwJO/OpkPljmsa3MXk8W6FTxT63O8Kd3++2jee
         23gbVSkQV5YdOSLdxvtGF6FnGu+ZHvF9JIkMwrYL7addK+VLI+ofsT3310nA2vWv/BLD
         Tev4H5UZuKOdh6kEg93VdsLes/hSa1gD0XjspeQlKtOTEGC6g6dvTx5tbIMgVZo7SEqD
         Vbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JjIAIonewoZ/0PMLC1pEg2k6n3SOlIGBtsswSA31us=;
        b=OYH+mUY7j/3Xa7bFSQbKVp9V9c9GJw3Bf1FjJowyKqlLKmN//4dvFQCcwObPuk0EDz
         edVF1ZvTE6Bhuyu1dSIXipEWaFfxdgKx4H08lmnW6YQYhsbFbLDj7L8uKh68LT8MWqFX
         IrR33A/AonBFJXThPWvK+5XHmLn5jH19mdDIHP4SVj0loTfAL1K/R8x65Ls5kTG60B4r
         Z+OEIRVFX9kvYWuTGTqo8Ql565jCNDar3z49VGWEnp0r3MF2eY7rrOU9syr4Gze9e+F1
         cqI5Iq1zzBkuRxQGs2YN1GYF3QvgERgkk+dimxOx2wlfZTtcrMGlzCOVBAnkERBj38Zl
         hl7A==
X-Gm-Message-State: AOAM532bJIFFQ/heTQcQIAxTojGHVTdsNYAtfHdO8//dbHdB2qyKVRjg
        LTtGgJmzhLbKPpaEzVtaR8o=
X-Google-Smtp-Source: ABdhPJwUSDioNw9znty0X3Izp/sI1O0Z3z0PNuc7wLvG/vGI+YoKJjxJDDg1ZaWaRQkFmFnoHAF8lg==
X-Received: by 2002:a17:90b:17c2:: with SMTP id me2mr17097635pjb.162.1641581189428;
        Fri, 07 Jan 2022 10:46:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x33sm7219417pfh.212.2022.01.07.10.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:46:29 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:BROADCOM SPECIFIC AMBA DRIVER
        (BCMA)),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER)
Subject: [PATCH v3 2/9] mtd: rawnand: brcmnand: Allow SoC to provide I/O operations
Date:   Fri,  7 Jan 2022 10:46:07 -0800
Message-Id: <20220107184614.2670254-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107184614.2670254-1-f.fainelli@gmail.com>
References: <20220107184614.2670254-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a brcmnand_soc instance to provide a custom set of I/O operations
which we will require when using this driver on a BCMA bus which is not
directly memory mapped I/O. Update the nand_{read,write}_reg accordingly
to use the SoC operations if provided.

To minimize the penalty on other SoCs which do support standard MMIO
accesses, we use a static key which is disabled by default and gets
enabled if a soc implementation does provide I/O operations.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 28 +++++++++++++++++++++--
 drivers/mtd/nand/raw/brcmnand/brcmnand.h | 29 ++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 63080ae3aef1..48d57b19c293 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include <linux/static_key.h>
 #include <linux/list.h>
 #include <linux/log2.h>
 
@@ -207,6 +208,8 @@ enum {
 
 struct brcmnand_host;
 
+static DEFINE_STATIC_KEY_FALSE(brcmnand_soc_has_ops_key);
+
 struct brcmnand_controller {
 	struct device		*dev;
 	struct nand_controller	controller;
@@ -592,15 +595,25 @@ enum {
 	INTFC_CTLR_READY		= BIT(31),
 };
 
+static inline bool brcmnand_non_mmio_ops(struct brcmnand_controller *ctrl)
+{
+	return static_branch_unlikely(&brcmnand_soc_has_ops_key);
+}
+
 static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)
 {
+	if (brcmnand_non_mmio_ops(ctrl))
+		return brcmnand_soc_read(ctrl->soc, offs);
 	return brcmnand_readl(ctrl->nand_base + offs);
 }
 
 static inline void nand_writereg(struct brcmnand_controller *ctrl, u32 offs,
 				 u32 val)
 {
-	brcmnand_writel(val, ctrl->nand_base + offs);
+	if (brcmnand_non_mmio_ops(ctrl))
+		brcmnand_soc_write(ctrl->soc, val, offs);
+	else
+		brcmnand_writel(val, ctrl->nand_base + offs);
 }
 
 static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
@@ -766,13 +779,18 @@ static inline void brcmnand_rmw_reg(struct brcmnand_controller *ctrl,
 
 static inline u32 brcmnand_read_fc(struct brcmnand_controller *ctrl, int word)
 {
+	if (brcmnand_non_mmio_ops(ctrl))
+		return brcmnand_soc_read(ctrl->soc, BRCMNAND_NON_MMIO_FC_ADDR);
 	return __raw_readl(ctrl->nand_fc + word * 4);
 }
 
 static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
 				     int word, u32 val)
 {
-	__raw_writel(val, ctrl->nand_fc + word * 4);
+	if (brcmnand_non_mmio_ops(ctrl))
+		brcmnand_soc_write(ctrl->soc, val, BRCMNAND_NON_MMIO_FC_ADDR);
+	else
+		__raw_writel(val, ctrl->nand_fc + word * 4);
 }
 
 static inline void edu_writel(struct brcmnand_controller *ctrl,
@@ -3000,6 +3018,12 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	ctrl->dev = dev;
 	ctrl->soc = soc;
 
+	/* Enable the static key if the soc provides I/O operations indicating
+	 * that a non-memory mapped IO access path must be used
+	 */
+	if (brcmnand_soc_has_ops(ctrl->soc))
+		static_branch_enable(&brcmnand_soc_has_ops_key);
+
 	init_completion(&ctrl->done);
 	init_completion(&ctrl->dma_done);
 	init_completion(&ctrl->edu_done);
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
index eb498fbe505e..f1f93d85f50d 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
@@ -11,12 +11,25 @@
 
 struct platform_device;
 struct dev_pm_ops;
+struct brcmnand_io_ops;
+
+/* Special register offset constant to intercept a non-MMIO access
+ * to the flash cache register space. This is intentionally large
+ * not to overlap with an existing offset.
+ */
+#define BRCMNAND_NON_MMIO_FC_ADDR	0xffffffff
 
 struct brcmnand_soc {
 	bool (*ctlrdy_ack)(struct brcmnand_soc *soc);
 	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
 	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
 				 bool is_param);
+	const struct brcmnand_io_ops *ops;
+};
+
+struct brcmnand_io_ops {
+	u32 (*read_reg)(struct brcmnand_soc *soc, u32 offset);
+	void (*write_reg)(struct brcmnand_soc *soc, u32 val, u32 offset);
 };
 
 static inline void brcmnand_soc_data_bus_prepare(struct brcmnand_soc *soc,
@@ -58,6 +71,22 @@ static inline void brcmnand_writel(u32 val, void __iomem *addr)
 		writel_relaxed(val, addr);
 }
 
+static inline bool brcmnand_soc_has_ops(struct brcmnand_soc *soc)
+{
+	return soc && soc->ops && soc->ops->read_reg && soc->ops->write_reg;
+}
+
+static inline u32 brcmnand_soc_read(struct brcmnand_soc *soc, u32 offset)
+{
+	return soc->ops->read_reg(soc, offset);
+}
+
+static inline void brcmnand_soc_write(struct brcmnand_soc *soc, u32 val,
+				      u32 offset)
+{
+	soc->ops->write_reg(soc, val, offset);
+}
+
 int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc);
 int brcmnand_remove(struct platform_device *pdev);
 
-- 
2.25.1

