Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5B055E716
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346835AbiF1NnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346781AbiF1Nm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:42:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE32AC43;
        Tue, 28 Jun 2022 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656423774; x=1687959774;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Y0QXjOizetyX3Soq97gP2p3KCAQsLgAHEtiVVB0k/s0=;
  b=aHBY6B36K2yO8Rn/rM4a8BR8R8FOOVTTatDd5dggoa7T/Fz5ed9dAhHA
   Ban6o7t/sVgbYooQ8eGtcnOMhZUnyubnmEVGw7tuM1swgVI+1Ucj/R/Zw
   Cgl9spsglik8re52TD5bCqa5zm9rrz7bNb3oEP4OSOJ79t6OBa4XCCHwW
   zNlUqfwrQgeCovo4jZy7ztLT26F2OIVAiOlmgWj/mfu6jjVhFWRk8HR10
   FuNjEj3yLN+hF2Gy6MBm+Un5v8zhkDNuUpkPSXBbCzFUNLQqluvG+1Ejs
   xUmkss+MGwgh/fDNcNSAPTx1YnjfEU3jKU/BWHSFNxuxOzhnZpoucGsQ+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281780646"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281780646"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646918031"
Received: from iannetti-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] serial: 8250_dw: Move 16550 compatible & LCR checks to dw8250_verify_write()
Date:   Tue, 28 Jun 2022 16:42:33 +0300
Message-Id: <20220628134234.53771-4-ilpo.jarvinen@linux.intel.com>
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

Rename dw8250_check_lcr() -> dw8250_verify_write() and add comment.
Move LCR and 16550_compatible checks there. As offset is now passed and
dw8250_verify_write() ensures it's UART_LCR, offset can use used
instead of explicit UART_LCR.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 35 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f18975b4d2c7..fc367d44f86d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -87,14 +87,24 @@ static void dw8250_force_idle(struct uart_port *p)
 	(void)p->serial_in(p, UART_RX);
 }
 
-static void dw8250_check_lcr(struct uart_port *p, int value)
+/*
+ * DW UART can be configured to indicate BUSY in USR (with
+ * UART_16550_COMPATIBLE=NO or version prior to introducing that option).
+ * If BUSY is set while writing to LCR register, the write is ignored and
+ * needs to be retries.
+ */
+static void dw8250_verify_write(struct uart_port *p, int offset, int value)
 {
-	void __iomem *reg_offset = p->membase + (UART_LCR << p->regshift);
+	void __iomem *reg_offset = p->membase + (offset << p->regshift);
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
 	int tries = 1000;
 
+	if ((offset != UART_LCR) || !d->uart_16550_compatible)
+		return;
+
 	/* Make sure LCR write wasn't ignored */
 	while (tries--) {
-		unsigned int lcr = p->serial_in(p, UART_LCR);
+		unsigned int lcr = p->serial_in(p, offset);
 
 		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
 			return;
@@ -145,12 +155,9 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
 
 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 {
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
-
 	writeb(value, p->membase + (offset << p->regshift));
 
-	if (offset == UART_LCR && !d->uart_16550_compatible)
-		dw8250_check_lcr(p, value);
+	dw8250_verify_write(p, offset, value);
 }
 
 static void dw8250_serial_out38x(struct uart_port *p, int offset, int value)
@@ -181,26 +188,20 @@ static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
 
 static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 {
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
-
 	value &= 0xff;
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
 	__raw_readq(p->membase + (UART_LCR << p->regshift));
 
-	if (offset == UART_LCR && !d->uart_16550_compatible)
-		dw8250_check_lcr(p, value);
+	dw8250_verify_write(p, offset, value);
 }
 #endif /* CONFIG_64BIT */
 
 static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 {
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
-
 	writel(value, p->membase + (offset << p->regshift));
 
-	if (offset == UART_LCR && !d->uart_16550_compatible)
-		dw8250_check_lcr(p, value);
+	dw8250_verify_write(p, offset, value);
 }
 
 static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
@@ -212,12 +213,10 @@ static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
 
 static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
 {
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
 
 	iowrite32be(value, p->membase + (offset << p->regshift));
 
-	if (offset == UART_LCR && !d->uart_16550_compatible)
-		dw8250_check_lcr(p, value);
+	dw8250_verify_write(p, offset, value);
 }
 
 static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
-- 
2.30.2

