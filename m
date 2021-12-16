Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63202477432
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhLPOP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:15:29 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:49698 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229612AbhLPOP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:15:28 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAAnvqbgSbthnnSfAw--.52579S2;
        Thu, 16 Dec 2021 22:14:56 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v3] serial: pch_uart: potential dereference of null pointer
Date:   Thu, 16 Dec 2021 22:14:54 +0800
Message-Id: <20211216141454.423333-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAnvqbgSbthnnSfAw--.52579S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4UuF4fXF4fWF48Jw1DZFb_yoW5GF4xpa
        1jyrZ8A3yYq3Z3KF18Ar47Xr4avwn3CFy7KrW7KwnIyr9rtr1UCF15t3s0vrn5JrWxKryF
        vw4qyF45uF48taDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xryl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6WlgUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of dma_alloc_coherent() needs to be checked.
To avoid dereference of null pointer in case of the failure of alloc.
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v2 -> v3

*Change 1. Remove dev_err.
*Change 2. Change the return type of pch_request_dma to int.
*Change 3. Return -ENOMEM when dma_alloc_coherent() failed and 0 the
others.
*Change 4. Check return value of dma_alloc_coherent().
---
 drivers/tty/serial/pch_uart.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index f0351e6f0ef6..cfad5592010c 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -698,7 +698,7 @@ static bool filter(struct dma_chan *chan, void *slave)
 	}
 }
 
-static void pch_request_dma(struct uart_port *port)
+static int pch_request_dma(struct uart_port *port)
 {
 	dma_cap_mask_t mask;
 	struct dma_chan *chan;
@@ -723,7 +723,7 @@ static void pch_request_dma(struct uart_port *port)
 	if (!chan) {
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Tx)\n",
 			__func__);
-		return;
+		return 0;
 	}
 	priv->chan_tx = chan;
 
@@ -739,13 +739,20 @@ static void pch_request_dma(struct uart_port *port)
 			__func__);
 		dma_release_channel(priv->chan_tx);
 		priv->chan_tx = NULL;
-		return;
+		return 0;
 	}
 
 	/* Get Consistent memory for DMA */
 	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
 				    &priv->rx_buf_dma, GFP_KERNEL);
+	if (!priv->rx_buf_virt) {
+		dma_release_channel(priv->chan_tx);
+		priv->chan_tx = NULL;
+		return -ENOMEM;
+	}
+
 	priv->chan_rx = chan;
+	return 0;
 }
 
 static void pch_dma_rx_complete(void *arg)
@@ -1321,8 +1328,11 @@ static int pch_uart_startup(struct uart_port *port)
 	if (ret < 0)
 		return ret;
 
-	if (priv->use_dma)
-		pch_request_dma(port);
+	if (priv->use_dma) {
+		ret = pch_request_dma(port);
+		if (ret)
+			return ret;
+	}
 
 	priv->start_rx = 1;
 	pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_RX_INT |
@@ -1469,6 +1479,7 @@ static int pch_uart_verify_port(struct uart_port *port,
 				struct serial_struct *serinfo)
 {
 	struct eg20t_port *priv;
+	int ret;
 
 	priv = container_of(port, struct eg20t_port, port);
 	if (serinfo->flags & UPF_LOW_LATENCY) {
@@ -1483,7 +1494,9 @@ static int pch_uart_verify_port(struct uart_port *port,
 		return -EOPNOTSUPP;
 #endif
 		if (!priv->use_dma) {
-			pch_request_dma(port);
+			ret = pch_request_dma(port);
+			if (ret)
+				return ret;
 			if (priv->chan_rx)
 				priv->use_dma = 1;
 		}
-- 
2.25.1

