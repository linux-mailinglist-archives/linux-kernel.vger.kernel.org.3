Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2447DBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345490AbhLWAWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345439AbhLWAWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:22:34 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5D2C061574;
        Wed, 22 Dec 2021 16:22:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so4053967pjb.5;
        Wed, 22 Dec 2021 16:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmETOXOkNKQa2rKCeFKfspOjqOV7hD2bdN3ZZG5FHUI=;
        b=UC3LITshLiCeZPJfbMnFWKVzk+NdxgHQXUs2cuh5g0zkp5TWUKAhtNpar0sVngrS64
         IORiZyiJDJTK9/p6Xe/jHOAIWxXxok7ftwOY8v0n3D7cSHnWmi1Xm5cJ7S6TVY0wTo1K
         sQaN8CZ+WFyz6qC33tdUpAbi9QJy9PZ8ajCfveE0wC96V5UKhGFWICSEPZ35BCC0/vJS
         KhSi6hPabCtBKGD3YoZU7kQ/QkrKeT+Bpv/eP3HikmynvOThLJt8L8zRxv7o1plvy6eY
         cIvaeZywe3GqhIfdQmkRtIOhMCEqHDikDCpaVfslgxv3Q2eOTmSUr0sj2G4huJOEagm1
         c3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmETOXOkNKQa2rKCeFKfspOjqOV7hD2bdN3ZZG5FHUI=;
        b=q1rPdpvL+rgshbPczNuVSLhCLiY7obPPyOZ2slr6jhqiixWSO3KHfL8pKWcbPLfW4v
         9+kb/H2QyaURVnZtV0FhUx+Pil2LdOGGlDk9vQ3bsRIz2T/KgyLbrohlZ6yOXlrg5Dst
         Fv4bt4bNqKZpACuCkahWuZdWylRa7hQyajvUbq7n9J8GbzXY/e/mhwxTdQ7b6r2waFcP
         NntbnOQVMWZsIpPKiwHD9a/ptANnrioM83IfSQ1Qar2XGGFTbpTRI6lVw/rohY5f07eA
         Z8dvKlb3hBA/ghi8Rr6QQxR0zhJxyLQyatq9KRSPySQYPi6YZLXZNkF6DEzpumKI923k
         1Zaw==
X-Gm-Message-State: AOAM530s44T+4A24fJZ+bJ7XCo8ULSxetWFIwH+ey4nrFIDv/Z2ng/YS
        /dNXzjix2ZLeF7XmNpmh5fM=
X-Google-Smtp-Source: ABdhPJwhz8YZlay9PUCTslrKMaxwhliG6OEIIBNm11WCw9aJY46qwiWx1rz70bxyRDenBBotVqJCVw==
X-Received: by 2002:a17:90a:cb0d:: with SMTP id z13mr42268pjt.89.1640218953323;
        Wed, 22 Dec 2021 16:22:33 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm6720703pjt.45.2021.12.22.16.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:22:32 -0800 (PST)
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
Subject: [PATCH 1/9] mtd: rawnand: brcmnand: Allow SoC to provide I/O operations
Date:   Wed, 22 Dec 2021 16:22:17 -0800
Message-Id: <20211223002225.3738385-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223002225.3738385-1-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a brcmnand_soc instance to provide a custom set of I/O operations
which we will require when using this driver on a BCMA bus which is not
directly memory mapped I/O. Update the nand_{read,write}_reg accordingly
to use the SoC operations if provided.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++++--
 drivers/mtd/nand/raw/brcmnand/brcmnand.h | 23 +++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index f75929783b94..7a1673b1b1af 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -594,13 +594,18 @@ enum {
 
 static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)
 {
+	if (brcmnand_soc_has_ops(ctrl->soc))
+		return brcmnand_soc_read(ctrl->soc, offs);
 	return brcmnand_readl(ctrl->nand_base + offs);
 }
 
 static inline void nand_writereg(struct brcmnand_controller *ctrl, u32 offs,
 				 u32 val)
 {
-	brcmnand_writel(val, ctrl->nand_base + offs);
+	if (brcmnand_soc_has_ops(ctrl->soc))
+		brcmnand_soc_write(ctrl->soc, val, offs);
+	else
+		brcmnand_writel(val, ctrl->nand_base + offs);
 }
 
 static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
@@ -766,13 +771,18 @@ static inline void brcmnand_rmw_reg(struct brcmnand_controller *ctrl,
 
 static inline u32 brcmnand_read_fc(struct brcmnand_controller *ctrl, int word)
 {
+	if (brcmnand_soc_has_ops(ctrl->soc))
+		return brcmnand_soc_read(ctrl->soc, ~0);
 	return __raw_readl(ctrl->nand_fc + word * 4);
 }
 
 static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
 				     int word, u32 val)
 {
-	__raw_writel(val, ctrl->nand_fc + word * 4);
+	if (brcmnand_soc_has_ops(ctrl->soc))
+		brcmnand_soc_write(ctrl->soc, val, ~0);
+	else
+		__raw_writel(val, ctrl->nand_fc + word * 4);
 }
 
 static inline void edu_writel(struct brcmnand_controller *ctrl,
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
index eb498fbe505e..a3f2ad5f6572 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
@@ -11,12 +11,19 @@
 
 struct platform_device;
 struct dev_pm_ops;
+struct brcmnand_io_ops;
 
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
@@ -58,6 +65,22 @@ static inline void brcmnand_writel(u32 val, void __iomem *addr)
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

