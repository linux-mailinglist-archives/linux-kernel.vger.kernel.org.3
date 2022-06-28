Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4555E68A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbiF1NnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346827AbiF1Nm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:42:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF0927CD0;
        Tue, 28 Jun 2022 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656423777; x=1687959777;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SPLW4MUTelcNhLfIwrYgBfgM4WHiKHjiuBV0hIitAOk=;
  b=VC1qva8aZRF8FnzQ6UWM0/XnvXHUVmBd/h1uoIBtonQpNVMetKBy5wam
   93biRH9Z4UrO1E1T4h5kkR580a51K6eN+nhHSJ3N0IitCypc2TNwcDU6h
   8L+94qPV5c9yIN5SWvob/sXRDgbVdItgUXqGdEj1kUNr2X2zjVOQmIWqb
   St1F7/Ws0bj9vuk9/Bggc6wVAfYrrJCMchsg4VO/eOTZy71mdoWSOk7I7
   eATlcfCyPOS8XMk8PEwGuAjzPj2C3hgdiHoASbj62lknhxDd1C2eoh+rb
   TEpTgkyuJdiYEkyNRHKa5G4PlQHV95DqOBVOTh2Wwi8TaHyU9kfuMuGKq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281780657"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281780657"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646918036"
Received: from iannetti-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:55 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] serial: 8250_dw: Rework ->serial_out() LCR write retry logic
Date:   Tue, 28 Jun 2022 16:42:34 +0300
Message-Id: <20220628134234.53771-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently dw8250_verify_write() (was dw8250_check_lcr()) nullifies the
benefit from differentiated ->serial_out() by having big if tree to
select correct write type.

Rework the logic such that the LCR write can be retried within the
relevant ->serial_out() handler:
  1. Move retries counter on the caller level and pass as pointer to
     dw8250_verify_write()
  2. Make dw8250_verify_write() return bool
  3. Retry the write on caller level (if needed)

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 59 ++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index fc367d44f86d..f6846363341b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -92,41 +92,36 @@ static void dw8250_force_idle(struct uart_port *p)
  * UART_16550_COMPATIBLE=NO or version prior to introducing that option).
  * If BUSY is set while writing to LCR register, the write is ignored and
  * needs to be retries.
+ *
+ * Returns: false if the caller should retry the write.
  */
-static void dw8250_verify_write(struct uart_port *p, int offset, int value)
+static bool dw8250_verify_write(struct uart_port *p, int offset, int value,
+				    unsigned int *retries)
 {
-	void __iomem *reg_offset = p->membase + (offset << p->regshift);
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-	int tries = 1000;
+	unsigned int lcr;
 
 	if ((offset != UART_LCR) || !d->uart_16550_compatible)
-		return;
+		return true;
 
 	/* Make sure LCR write wasn't ignored */
-	while (tries--) {
-		unsigned int lcr = p->serial_in(p, offset);
+	lcr = p->serial_in(p, offset);
 
-		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-			return;
+	if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
+		return true;
 
-		dw8250_force_idle(p);
+	dw8250_force_idle(p);
 
-#ifdef CONFIG_64BIT
-		if (p->type == PORT_OCTEON)
-			__raw_writeq(value & 0xff, reg_offset);
-		else
-#endif
-		if (p->iotype == UPIO_MEM32)
-			writel(value, reg_offset);
-		else if (p->iotype == UPIO_MEM32BE)
-			iowrite32be(value, reg_offset);
-		else
-			writeb(value, reg_offset);
+	if (*retries) {
+		*retries -= 1;
+		return false;
 	}
+
 	/*
 	 * FIXME: this deadlocks if port->lock is already held
 	 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
 	 */
+	return true;
 }
 
 /* Returns once the transmitter is empty or we run out of retries */
@@ -155,9 +150,13 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
 
 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 {
+	unsigned int retries = 1000;
+
+retry:
 	writeb(value, p->membase + (offset << p->regshift));
 
-	dw8250_verify_write(p, offset, value);
+	if (!dw8250_verify_write(p, offset, value, &retries))
+		goto retry;
 }
 
 static void dw8250_serial_out38x(struct uart_port *p, int offset, int value)
@@ -188,20 +187,29 @@ static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
 
 static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 {
+	unsigned int retries = 1000;
+
 	value &= 0xff;
+
+retry:
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
 	__raw_readq(p->membase + (UART_LCR << p->regshift));
 
-	dw8250_verify_write(p, offset, value);
+	if (!dw8250_verify_write(p, offset, value, &retries))
+		goto retry;
 }
 #endif /* CONFIG_64BIT */
 
 static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 {
+	unsigned int retries = 1000;
+
+retry:
 	writel(value, p->membase + (offset << p->regshift));
 
-	dw8250_verify_write(p, offset, value);
+	if (!dw8250_verify_write(p, offset, value, &retries))
+		goto retry;
 }
 
 static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
@@ -213,10 +221,13 @@ static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
 
 static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
 {
+	unsigned int retries = 1000;
 
+retry:
 	iowrite32be(value, p->membase + (offset << p->regshift));
 
-	dw8250_verify_write(p, offset, value);
+	if (!dw8250_verify_write(p, offset, value, &retries))
+		goto retry;
 }
 
 static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
-- 
2.30.2

