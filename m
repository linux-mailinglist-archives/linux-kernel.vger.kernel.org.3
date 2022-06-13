Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64524548361
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbiFMJeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiFMJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:34:02 -0400
X-Greylist: delayed 370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Jun 2022 02:34:00 PDT
Received: from mail-m121144.qiye.163.com (mail-m121144.qiye.163.com [115.236.121.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB866356;
        Mon, 13 Jun 2022 02:34:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 0A824AC04CF;
        Mon, 13 Jun 2022 17:27:48 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH] spi: rockchip: Disable local irq when pio write out of interrupt service
Date:   Mon, 13 Jun 2022 17:27:44 +0800
Message-Id: <20220613092744.9726-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlKS0tKN1dZLVlBSVdZDwkaFQgSH1lBWUNLSBlWGEtJSktLHU
        saGh1DVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCo6CRw4KT09IQ0QPUkXDygS
        HUoKFANVSlVKTU5OSkpJT01DTUlLVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFJTENLNwY+
X-HM-Tid: 0a815c640702b039kuuu0a824ac04cf
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid interrupt come and interrupt the pio_writer.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
Signed-off-by: Jon <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a08215eb9e14..2184de146928 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -199,6 +199,7 @@ struct rockchip_spi {
 	bool cs_high_supported; /* native CS supports active-high polarity */
 
 	struct spi_transfer *xfer; /* Store xfer temporarily */
+	spinlock_t lock; /* prevent I/O concurrent access */
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
@@ -293,9 +294,13 @@ static void rockchip_spi_handle_err(struct spi_controller *ctlr,
 
 static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
 {
-	u32 tx_free = rs->fifo_len - readl_relaxed(rs->regs + ROCKCHIP_SPI_TXFLR);
-	u32 words = min(rs->tx_left, tx_free);
+	u32 tx_free;
+	u32 words;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rs->lock, flags);
+	tx_free = rs->fifo_len - readl_relaxed(rs->regs + ROCKCHIP_SPI_TXFLR);
+	words = min(rs->tx_left, tx_free);
 	rs->tx_left -= words;
 	for (; words; words--) {
 		u32 txw;
@@ -308,6 +313,7 @@ static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
 		writel_relaxed(txw, rs->regs + ROCKCHIP_SPI_TXDR);
 		rs->tx += rs->n_bytes;
 	}
+	spin_unlock_irqrestore(&rs->lock, flags);
 }
 
 static void rockchip_spi_pio_reader(struct rockchip_spi *rs)
@@ -779,6 +785,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_put_ctlr;
 	}
 
+	spin_lock_init(&rs->lock);
+
 	rs->apb_pclk = devm_clk_get(&pdev->dev, "apb_pclk");
 	if (IS_ERR(rs->apb_pclk)) {
 		dev_err(&pdev->dev, "Failed to get apb_pclk\n");
-- 
2.17.1

