Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7B52CDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiESH5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiESH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:56:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D015935852;
        Thu, 19 May 2022 00:56:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EF179210EA;
        Thu, 19 May 2022 07:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652947013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RDxo6wzU5uioDacPmhT1bEtFr01wPXxQz320zi+IVxU=;
        b=BISQseBJZCtvQEmOFCLqaO3nVcgvmxEkqpIa2zQcX87U1SaOb3Ma3j53NgkSaIDW4OYoYt
        SQHTrhvvgwEyymWYHq4/B797Tmo0Df54e8LNygN6fllbJJSyNgEoV7FAi3ho+wxOJFYW2i
        +BvxF/N0M0EKkXUzDMxe1HuE/yQhp9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652947013;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RDxo6wzU5uioDacPmhT1bEtFr01wPXxQz320zi+IVxU=;
        b=y7UCf21lY6Q8W1XTugPD/U9psis1SjoI7NxWubQa7nZkTwpR5+JW6qPDoCLkpDE2Ii+ejV
        /4ZjqFM2qLyKxQCw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B334E2C141;
        Thu, 19 May 2022 07:56:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/4] serial: pmac_zilog: remove unfinished DBDMA support
Date:   Thu, 19 May 2022 09:56:50 +0200
Message-Id: <20220519075653.31356-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support for DBDMA was never completed. Remove the the code that only
maps spaces without real work.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pmac_zilog.c | 38 +--------------------------------
 drivers/tty/serial/pmac_zilog.h |  9 --------
 2 files changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index c903085acb8d..2953ff64a892 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -65,9 +65,6 @@
 
 #include "pmac_zilog.h"
 
-/* Not yet implemented */
-#undef HAS_DBDMA
-
 static char version[] __initdata = "pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("Driver for the Mac and PowerMac serial ports.");
@@ -1399,7 +1396,7 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 		char	name[1];
 	} *slots;
 	int len;
-	struct resource r_ports, r_rxdma, r_txdma;
+	struct resource r_ports;
 
 	/*
 	 * Request & map chip registers
@@ -1411,35 +1408,6 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 
 	uap->control_reg = uap->port.membase;
 	uap->data_reg = uap->control_reg + 0x10;
-	
-	/*
-	 * Request & map DBDMA registers
-	 */
-#ifdef HAS_DBDMA
-	if (of_address_to_resource(np, 1, &r_txdma) == 0 &&
-	    of_address_to_resource(np, 2, &r_rxdma) == 0)
-		uap->flags |= PMACZILOG_FLAG_HAS_DMA;
-#else
-	memset(&r_txdma, 0, sizeof(struct resource));
-	memset(&r_rxdma, 0, sizeof(struct resource));
-#endif	
-	if (ZS_HAS_DMA(uap)) {
-		uap->tx_dma_regs = ioremap(r_txdma.start, 0x100);
-		if (uap->tx_dma_regs == NULL) {	
-			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
-			goto no_dma;
-		}
-		uap->rx_dma_regs = ioremap(r_rxdma.start, 0x100);
-		if (uap->rx_dma_regs == NULL) {	
-			iounmap(uap->tx_dma_regs);
-			uap->tx_dma_regs = NULL;
-			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
-			goto no_dma;
-		}
-		uap->tx_dma_irq = irq_of_parse_and_map(np, 1);
-		uap->rx_dma_irq = irq_of_parse_and_map(np, 2);
-	}
-no_dma:
 
 	/*
 	 * Detect port type
@@ -1505,8 +1473,6 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 	    of_device_is_compatible(np->parent->parent, "gatwick")) {
 		/* IRQs on gatwick are offset by 64 */
 		uap->port.irq = irq_create_mapping(NULL, 64 + 15);
-		uap->tx_dma_irq = irq_create_mapping(NULL, 64 + 4);
-		uap->rx_dma_irq = irq_create_mapping(NULL, 64 + 5);
 	}
 
 	/* Setup some valid baud rate information in the register
@@ -1526,8 +1492,6 @@ static void pmz_dispose_port(struct uart_pmac_port *uap)
 	struct device_node *np;
 
 	np = uap->node;
-	iounmap(uap->rx_dma_regs);
-	iounmap(uap->tx_dma_regs);
 	iounmap(uap->control_reg);
 	uap->node = NULL;
 	of_node_put(np);
diff --git a/drivers/tty/serial/pmac_zilog.h b/drivers/tty/serial/pmac_zilog.h
index fa85b0de5c2f..87337b748d6d 100644
--- a/drivers/tty/serial/pmac_zilog.h
+++ b/drivers/tty/serial/pmac_zilog.h
@@ -43,7 +43,6 @@ struct uart_pmac_port {
 #define PMACZILOG_FLAG_TX_ACTIVE	0x00000040
 #define PMACZILOG_FLAG_IS_IRDA		0x00000100
 #define PMACZILOG_FLAG_IS_INTMODEM	0x00000200
-#define PMACZILOG_FLAG_HAS_DMA		0x00000400
 #define PMACZILOG_FLAG_RSRC_REQUESTED	0x00000800
 #define PMACZILOG_FLAG_IS_OPEN		0x00002000
 #define PMACZILOG_FLAG_IS_EXTCLK	0x00008000
@@ -55,13 +54,6 @@ struct uart_pmac_port {
 	volatile u8			__iomem *control_reg;
 	volatile u8			__iomem *data_reg;
 
-#ifdef CONFIG_PPC_PMAC
-	unsigned int			tx_dma_irq;
-	unsigned int			rx_dma_irq;
-	volatile struct dbdma_regs	__iomem *tx_dma_regs;
-	volatile struct dbdma_regs	__iomem *rx_dma_regs;
-#endif
-
 	unsigned char			irq_name[8];
 
 	struct ktermios			termios_cache;
@@ -377,7 +369,6 @@ static inline void zssync(struct uart_pmac_port *port)
 #define ZS_WANTS_MODEM_STATUS(UP)	((UP)->flags & PMACZILOG_FLAG_MODEM_STATUS)
 #define ZS_IS_IRDA(UP)			((UP)->flags & PMACZILOG_FLAG_IS_IRDA)
 #define ZS_IS_INTMODEM(UP)		((UP)->flags & PMACZILOG_FLAG_IS_INTMODEM)
-#define ZS_HAS_DMA(UP)			((UP)->flags & PMACZILOG_FLAG_HAS_DMA)
 #define ZS_IS_OPEN(UP)			((UP)->flags & PMACZILOG_FLAG_IS_OPEN)
 #define ZS_IS_EXTCLK(UP)		((UP)->flags & PMACZILOG_FLAG_IS_EXTCLK)
 
-- 
2.36.1

