Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D959F3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiHXHI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbiHXHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:08:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ACB93238;
        Wed, 24 Aug 2022 00:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661324924; x=1692860924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Da38opBG4z00BHfm6TpkELk32vGWak8dTjFHtQbetBk=;
  b=RDkIK6KctLKXJtb+F+u+h98KdhmLDlbT9cCeotkiI9ekBl1ZpLl6j4qK
   K9E72E/7VaCghRnFIuLInEeBAegZTEbUDxcC3cKhPYjAx3Ha2kLgw1di5
   kpJ4cyOJ9vkSCbmIyhxVEW2mOEsnNZ+6Un2ZfZhhXDrW32YnMZ8iK78/y
   Nw/0ULLW1p/oIzDkSkWF/9pUoU9VjZChLMq2ezbW37OztHHwcqgqB5gdh
   /Ss+0Cc9RwcjYolfgEd1oS2DQpXrQOQIXHw3xQktWImbLL0QwIQMwWD27
   79+SyutIDl/iuPbbEZQrwxQfoYvx+DW5oJRbEpwKtEme5roimosKShgWa
   w==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="170677310"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 00:08:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 00:08:43 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 00:08:41 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v2 2/3] mailbox: mpfs: fix handling of the reg property
Date:   Wed, 24 Aug 2022 08:08:11 +0100
Message-ID: <20220824070810.52219-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824070810.52219-1-conor.dooley@microchip.com>
References: <20220824070810.52219-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "data" region of the PolarFire SoC's system controller mailbox is
not one continuous register space - the system controller's QSPI sits
between the control and data registers. Split the "data" reg into two
parts: "data" & "control". Optionally get the "data" register address
from the 3rd reg property in the devicetree & fall back to using the
old base + MAILBOX_REG_OFFSET that the current code uses.

Fixes: 83d7b1560810 ("mbox: add polarfire soc system controller mailbox")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mailbox/mailbox-mpfs.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index 4e34854d1238..e432a8f0d148 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -62,6 +62,7 @@ struct mpfs_mbox {
 	struct mbox_controller controller;
 	struct device *dev;
 	int irq;
+	void __iomem *ctrl_base;
 	void __iomem *mbox_base;
 	void __iomem *int_reg;
 	struct mbox_chan chans[1];
@@ -73,7 +74,7 @@ static bool mpfs_mbox_busy(struct mpfs_mbox *mbox)
 {
 	u32 status;
 
-	status = readl_relaxed(mbox->mbox_base + SERVICES_SR_OFFSET);
+	status = readl_relaxed(mbox->ctrl_base + SERVICES_SR_OFFSET);
 
 	return status & SCB_STATUS_BUSY_MASK;
 }
@@ -99,14 +100,13 @@ static int mpfs_mbox_send_data(struct mbox_chan *chan, void *data)
 
 		for (index = 0; index < (msg->cmd_data_size / 4); index++)
 			writel_relaxed(word_buf[index],
-				       mbox->mbox_base + MAILBOX_REG_OFFSET + index * 0x4);
+				       mbox->mbox_base + index * 0x4);
 		if (extra_bits) {
 			u8 i;
 			u8 byte_off = ALIGN_DOWN(msg->cmd_data_size, 4);
 			u8 *byte_buf = msg->cmd_data + byte_off;
 
-			val = readl_relaxed(mbox->mbox_base +
-					    MAILBOX_REG_OFFSET + index * 0x4);
+			val = readl_relaxed(mbox->mbox_base + index * 0x4);
 
 			for (i = 0u; i < extra_bits; i++) {
 				val &= ~(0xffu << (i * 8u));
@@ -114,14 +114,14 @@ static int mpfs_mbox_send_data(struct mbox_chan *chan, void *data)
 			}
 
 			writel_relaxed(val,
-				       mbox->mbox_base + MAILBOX_REG_OFFSET + index * 0x4);
+				       mbox->mbox_base + index * 0x4);
 		}
 	}
 
 	opt_sel = ((msg->mbox_offset << 7u) | (msg->cmd_opcode & 0x7fu));
 	tx_trigger = (opt_sel << SCB_CTRL_POS) & SCB_CTRL_MASK;
 	tx_trigger |= SCB_CTRL_REQ_MASK | SCB_STATUS_NOTIFY_MASK;
-	writel_relaxed(tx_trigger, mbox->mbox_base + SERVICES_CR_OFFSET);
+	writel_relaxed(tx_trigger, mbox->ctrl_base + SERVICES_CR_OFFSET);
 
 	return 0;
 }
@@ -141,7 +141,7 @@ static void mpfs_mbox_rx_data(struct mbox_chan *chan)
 	if (!mpfs_mbox_busy(mbox)) {
 		for (i = 0; i < num_words; i++) {
 			response->resp_msg[i] =
-				readl_relaxed(mbox->mbox_base + MAILBOX_REG_OFFSET
+				readl_relaxed(mbox->mbox_base
 					      + mbox->resp_offset + i * 0x4);
 		}
 	}
@@ -200,14 +200,18 @@ static int mpfs_mbox_probe(struct platform_device *pdev)
 	if (!mbox)
 		return -ENOMEM;
 
-	mbox->mbox_base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
-	if (IS_ERR(mbox->mbox_base))
-		return PTR_ERR(mbox->mbox_base);
+	mbox->ctrl_base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
+	if (IS_ERR(mbox->ctrl_base))
+		return PTR_ERR(mbox->ctrl_base);
 
 	mbox->int_reg = devm_platform_get_and_ioremap_resource(pdev, 1, &regs);
 	if (IS_ERR(mbox->int_reg))
 		return PTR_ERR(mbox->int_reg);
 
+	mbox->mbox_base = devm_platform_get_and_ioremap_resource(pdev, 2, &regs);
+	if (IS_ERR(mbox->mbox_base)) // account for the old dt-binding w/ 2 regs
+		mbox->mbox_base = mbox->ctrl_base + MAILBOX_REG_OFFSET;
+
 	mbox->irq = platform_get_irq(pdev, 0);
 	if (mbox->irq < 0)
 		return mbox->irq;
-- 
2.36.1

