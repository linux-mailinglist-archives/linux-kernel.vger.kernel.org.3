Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608A6542CB1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiFHKKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbiFHKJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:09:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B839B1D5AA1;
        Wed,  8 Jun 2022 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654682097; x=1686218097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GeRNMr3HZUhOZVt9G+fJ5knQmLzUpmCXYoXf8y44tOw=;
  b=kIEEuK7Pan80vXJZcuJOPUKJx1i5WI59IuQ3/7cmDI20kxqwIfIpq4lu
   6bK8/KS0RI52eg30KvTIsvsQd7Dbj3O1z+xQaB9b9AyrfGP+Ngn8tjDTf
   HEg5Xiiy30NlON2Z7JmpQ59AJ+QOv+se5TbqMblLA+Ciun3TwkXigQYFz
   9/0/wK/6PLHNd8JF4EUczmwGcE8TVVAGBLBeprvS3DqenDQRYOPxhDZOQ
   qyzPKEUWeG8NKoSkfyC+34F2DNu+/9dKXl++Rz2GL4+TwieOgsSdlLUFG
   2LrmmjiECoF2Ndx6Br2nd77BFppx7tmFaf3FbbU+EMsI3J1JgppSFbbYF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="278019533"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="278019533"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:54:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="584783446"
Received: from bmichals-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.131])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:54:47 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 2/6] serial: 8250: Create serial_lsr_in()
Date:   Wed,  8 Jun 2022 12:54:27 +0300
Message-Id: <20220608095431.18376-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608095431.18376-1-ilpo.jarvinen@linux.intel.com>
References: <20220608095431.18376-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSR register readers need to be careful in order to not lose bits that
are not preserved across reads. Create a helper that takes care of
storing the non-preserved bits into lsr_save_flags.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h      | 20 ++++++++++++++++++++
 drivers/tty/serial/8250/8250_core.c |  3 +--
 drivers/tty/serial/8250/8250_port.c | 15 ++++-----------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 3d9a7e539dea..b120da57c61f 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -123,6 +123,26 @@ static inline void serial_out(struct uart_8250_port *up, int offset, int value)
 	up->port.serial_out(&up->port, offset, value);
 }
 
+/**
+ *	serial_lsr_in - Read LSR register and preserve flags across reads
+ *	@up:	uart 8250 port
+ *
+ *	Read LSR register and handle saving non-preserved flags across reads.
+ *	The flags that are not preserved across reads are stored into
+ *	up->lsr_saved_flags.
+ *
+ *	Returns LSR value or'ed with the preserved flags (if any).
+ */
+static inline unsigned int serial_lsr_in(struct uart_8250_port *up)
+{
+	unsigned int lsr = up->lsr_saved_flags;
+
+	lsr |= serial_in(up, UART_LSR);
+	up->lsr_saved_flags = lsr & LSR_SAVE_FLAGS;
+
+	return lsr;
+}
+
 /*
  * For the 16C950
  */
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 12c5e5d0ce6d..90ddc8924811 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -276,8 +276,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	 * the "Diva" UART used on the management processor on many HP
 	 * ia64 and parisc boxes.
 	 */
-	lsr = serial_in(up, UART_LSR);
-	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	lsr = serial_lsr_in(up);
 	if ((iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
 	    (!uart_circ_empty(&up->port.state->xmit) || up->port.x_char) &&
 	    (lsr & UART_LSR_THRE)) {
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c5e0f925f4b6..ec5abeb638eb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1508,11 +1508,9 @@ static inline void __stop_tx(struct uart_8250_port *p)
 	struct uart_8250_em485 *em485 = p->em485;
 
 	if (em485) {
-		unsigned char lsr = serial_in(p, UART_LSR);
+		unsigned char lsr = serial_lsr_in(p);
 		u64 stop_delay = 0;
 
-		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-
 		if (!(lsr & UART_LSR_THRE))
 			return;
 		/*
@@ -1567,10 +1565,8 @@ static inline void __start_tx(struct uart_port *port)
 
 	if (serial8250_set_THRI(up)) {
 		if (up->bugs & UART_BUG_TXEN) {
-			unsigned char lsr;
+			unsigned char lsr = serial_lsr_in(up);
 
-			lsr = serial_in(up, UART_LSR);
-			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
 			if (lsr & UART_LSR_THRE)
 				serial8250_tx_chars(up);
 		}
@@ -2001,8 +1997,7 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 	serial8250_rpm_get(up);
 
 	spin_lock_irqsave(&port->lock, flags);
-	lsr = serial_port_in(port, UART_LSR);
-	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	lsr = serial_lsr_in(up);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	serial8250_rpm_put(up);
@@ -2078,9 +2073,7 @@ static void wait_for_lsr(struct uart_8250_port *up, int bits)
 
 	/* Wait up to 10ms for the character(s) to be sent. */
 	for (;;) {
-		status = serial_in(up, UART_LSR);
-
-		up->lsr_saved_flags |= status & LSR_SAVE_FLAGS;
+		status = serial_lsr_in(up);
 
 		if ((status & bits) == bits)
 			break;
-- 
2.30.2

