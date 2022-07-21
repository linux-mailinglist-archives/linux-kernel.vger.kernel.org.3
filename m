Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB4F57C8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiGUKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiGUKPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:15:44 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE6B42A40A;
        Thu, 21 Jul 2022 03:15:41 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 978021C803BA;
        Thu, 21 Jul 2022 18:15:40 +0800 (CST)
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.7; Thu, 21 Jul
 2022 18:15:40 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 21 Jul 2022 18:15:39 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 46A0363A4C; Thu, 21 Jul 2022 13:15:39 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/2] spi: npcm-pspi: add full duplex support
Date:   Thu, 21 Jul 2022 13:15:27 +0300
Message-ID: <20220721101528.118499-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220721101528.118499-1-tmaimon77@gmail.com>
References: <20220721101528.118499-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NPCM PSPI handler, on TX-buffer not null, would perform a dummy read
but did not save the rx-data, this was valid only for half duplex.

This patch adds full duplex support for NPCM PSPI driver by storing all
rx-data when the Rx-buffer is defined also for TX-buffer handling.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-npcm-pspi.c | 75 +++++++++++++++----------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 1668a347e003..02f0fcceaf19 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -195,22 +195,22 @@ static void npcm_pspi_setup_transfer(struct spi_device *spi,
 static void npcm_pspi_send(struct npcm_pspi *priv)
 {
 	int wsize;
-	u16 val;
+	u16 val = 0;
 
 	wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
 	priv->tx_bytes -= wsize;
 
-	if (!priv->tx_buf)
-		return;
-
 	switch (wsize) {
 	case 1:
-		val = *priv->tx_buf++;
+		if (priv->tx_buf)
+			val = *priv->tx_buf++;
 		iowrite8(val, NPCM_PSPI_DATA + priv->base);
 		break;
 	case 2:
-		val = *priv->tx_buf++;
-		val = *priv->tx_buf++ | (val << 8);
+		if (priv->tx_buf) {
+			val = *priv->tx_buf++;
+			val = *priv->tx_buf++ | (val << 8);
+		}
 		iowrite16(val, NPCM_PSPI_DATA + priv->base);
 		break;
 	default:
@@ -222,22 +222,24 @@ static void npcm_pspi_send(struct npcm_pspi *priv)
 static void npcm_pspi_recv(struct npcm_pspi *priv)
 {
 	int rsize;
-	u16 val;
+	u16 val_16;
+	u8  val_8;
 
 	rsize = min(bytes_per_word(priv->bits_per_word), priv->rx_bytes);
 	priv->rx_bytes -= rsize;
 
-	if (!priv->rx_buf)
-		return;
-
 	switch (rsize) {
 	case 1:
-		*priv->rx_buf++ = ioread8(priv->base + NPCM_PSPI_DATA);
+		val_8 = ioread8(priv->base + NPCM_PSPI_DATA);
+		if (priv->rx_buf)
+			*priv->rx_buf++ = val_8;
 		break;
 	case 2:
-		val = ioread16(priv->base + NPCM_PSPI_DATA);
-		*priv->rx_buf++ = (val >> 8);
-		*priv->rx_buf++ = val & 0xff;
+		val_16 = ioread16(priv->base + NPCM_PSPI_DATA);
+		if (priv->rx_buf) {
+			*priv->rx_buf++ = (val_16 >> 8);
+			*priv->rx_buf++ = val_16 & 0xff;
+		}
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -296,43 +298,26 @@ static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
 	struct npcm_pspi *priv = dev_id;
 	u8 stat;
 
-	stat = ioread8(priv->base + NPCM_PSPI_STAT);
-
 	if (!priv->tx_buf && !priv->rx_buf)
 		return IRQ_NONE;
 
-	if (priv->tx_buf) {
-		if (stat & NPCM_PSPI_STAT_RBF) {
-			ioread8(NPCM_PSPI_DATA + priv->base);
-			if (priv->tx_bytes == 0) {
-				npcm_pspi_disable(priv);
-				complete(&priv->xfer_done);
-				return IRQ_HANDLED;
-			}
-		}
-
-		if ((stat & NPCM_PSPI_STAT_BSY) == 0)
-			if (priv->tx_bytes)
-				npcm_pspi_send(priv);
+	if (priv->tx_bytes == 0 && priv->rx_bytes == 0) {
+		npcm_pspi_disable(priv);
+		complete(&priv->xfer_done);
+		return IRQ_HANDLED;
 	}
 
-	if (priv->rx_buf) {
-		if (stat & NPCM_PSPI_STAT_RBF) {
-			if (!priv->rx_bytes)
-				return IRQ_NONE;
-
-			npcm_pspi_recv(priv);
+	stat = ioread8(priv->base + NPCM_PSPI_STAT);
 
-			if (!priv->rx_bytes) {
-				npcm_pspi_disable(priv);
-				complete(&priv->xfer_done);
-				return IRQ_HANDLED;
-			}
-		}
+	/*
+	 * first we do the read since if we do the write we previous read might
+	 * be lost (indeed low chances)
+	 */
+	if ((stat & NPCM_PSPI_STAT_RBF) && priv->rx_bytes)
+		npcm_pspi_recv(priv);
 
-		if (((stat & NPCM_PSPI_STAT_BSY) == 0) && !priv->tx_buf)
-			iowrite8(0x0, NPCM_PSPI_DATA + priv->base);
-	}
+	if (((stat & NPCM_PSPI_STAT_BSY) == 0) && priv->tx_bytes)
+		npcm_pspi_send(priv);
 
 	return IRQ_HANDLED;
 }
-- 
2.33.0

