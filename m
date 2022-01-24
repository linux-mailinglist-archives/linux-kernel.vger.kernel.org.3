Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED163497940
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbiAXHOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:14:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41102 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbiAXHOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 73EBE21901;
        Mon, 24 Jan 2022 07:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5vn8IFil54kOIDOQHFgmEi8qAOxK9uV6kljLIOsoWtc=;
        b=J0IFt69csqkT1kd8ZxxlwMdo/JX/C//pAFWqEvYuxAi315j6Gmvatsk1gqLdFbz0IbR2Y0
        fVMjfa9Dgk17JnEGc5rn5M10Qvuyimsd0Us70n0LYAEqcMsMTD4p8YFvchDXSzLLHjCANG
        ZUM0cIbyNHAPTxArlN9F9e3e02ke1oA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5vn8IFil54kOIDOQHFgmEi8qAOxK9uV6kljLIOsoWtc=;
        b=c0OO/LuhsXkJvJovtqOtjjFgSOrqApYIeKeQC2SGu/sT2OlGRqY/LQe1zFT5BKfL9FLyRs
        6huaDl0VnWLr3lAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 34A8AA3B84;
        Mon, 24 Jan 2022 07:14:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH 08/11] serial: fsl_linflexuart: deduplicate character sending
Date:   Mon, 24 Jan 2022 08:14:27 +0100
Message-Id: <20220124071430.14907-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124071430.14907-1-jslaby@suse.cz>
References: <20220124071430.14907-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new linflex_put_char() helper to send a character. And use
it on both places this code was duplicated.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 42 +++++++++++-----------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 283757264608..81a04039b6c1 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -157,27 +157,29 @@ static void linflex_stop_rx(struct uart_port *port)
 	writel(ier & ~LINFLEXD_LINIER_DRIE, port->membase + LINIER);
 }
 
-static inline void linflex_transmit_buffer(struct uart_port *sport)
+static void linflex_put_char(struct uart_port *sport, unsigned char c)
 {
-	struct circ_buf *xmit = &sport->state->xmit;
-	unsigned char c;
 	unsigned long status;
 
-	while (!uart_circ_empty(xmit)) {
-		c = xmit->buf[xmit->tail];
-		writeb(c, sport->membase + BDRL);
+	writeb(c, sport->membase + BDRL);
 
-		/* Waiting for data transmission completed. */
-		while (((status = readl(sport->membase + UARTSR)) &
-					LINFLEXD_UARTSR_DTFTFF) !=
-					LINFLEXD_UARTSR_DTFTFF)
-			;
+	/* Waiting for data transmission completed. */
+	while (((status = readl(sport->membase + UARTSR)) &
+				LINFLEXD_UARTSR_DTFTFF) !=
+				LINFLEXD_UARTSR_DTFTFF)
+		;
+
+	writel(status | LINFLEXD_UARTSR_DTFTFF, sport->membase + UARTSR);
+}
 
+static inline void linflex_transmit_buffer(struct uart_port *sport)
+{
+	struct circ_buf *xmit = &sport->state->xmit;
+
+	while (!uart_circ_empty(xmit)) {
+		linflex_put_char(sport, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		sport->icount.tx++;
-
-		writel(status | LINFLEXD_UARTSR_DTFTFF,
-		       sport->membase + UARTSR);
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -201,21 +203,11 @@ static irqreturn_t linflex_txint(int irq, void *dev_id)
 	struct uart_port *sport = dev_id;
 	struct circ_buf *xmit = &sport->state->xmit;
 	unsigned long flags;
-	unsigned long status;
 
 	spin_lock_irqsave(&sport->lock, flags);
 
 	if (sport->x_char) {
-		writeb(sport->x_char, sport->membase + BDRL);
-
-		/* waiting for data transmission completed */
-		while (((status = readl(sport->membase + UARTSR)) &
-			LINFLEXD_UARTSR_DTFTFF) != LINFLEXD_UARTSR_DTFTFF)
-			;
-
-		writel(status | LINFLEXD_UARTSR_DTFTFF,
-		       sport->membase + UARTSR);
-
+		linflex_put_char(sport, sport->x_char);
 		goto out;
 	}
 
-- 
2.34.1

