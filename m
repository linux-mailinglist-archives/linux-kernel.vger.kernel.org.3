Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF5553283
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350898AbiFUMun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350754AbiFUMuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:50:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640432A43F;
        Tue, 21 Jun 2022 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655815824; x=1687351824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ixMQi5m0yAWtx781C2psFoRemTcSPTJq60wZ+v7XFco=;
  b=JZwwJmYnk9ohQVDVNeql+Oh/OPLHTMl+HiHKL9lm9JaVpfzqI8l7OddP
   Y98SuzNNvqtxuAWssWIwfeDLeXuBZdnfM4fVO4b9JVRtZKatRldXtBHMa
   a867k0fKYpFOjHK62bHUpjRQWxEUwIYiYYTiP1knAlPAG/NFxhae+3+4C
   KHKFQHh72YF0HyIqSpS9oZdJbK//npVoXIysQBvoEnsZ3QBqW+fiiWWAB
   6ShdEn+a/tJd/yDMYQ/uSjtvHxf6wTqenWPnm2fjKMcSMNpyZKkRZRPdM
   WNDzQm+xM65kN6qJPIO2WRBY3RJ2mTdXnGjcm90Z5PyVHLwzb5198iYeR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341793002"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341793002"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:50:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="833561582"
Received: from zjeffery-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.211])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:50:22 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 4/6] serial: 8250: Use C99 array initializer & define UART_REG_UNMAPPED
Date:   Tue, 21 Jun 2022 15:49:56 +0300
Message-Id: <20220621124958.3342-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use C99 array initializer insteads of comments and make unmapped checks
more obvious.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 38 +++++++++++++++--------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 953b0fadfd4c..432742a567b6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -336,27 +336,29 @@ static void default_serial_dl_write(struct uart_8250_port *up, int value)
 
 #ifdef CONFIG_SERIAL_8250_RT288X
 
+#define UART_REG_UNMAPPED	-1
+
 /* Au1x00/RT288x UART hardware has a weird register layout */
 static const s8 au_io_in_map[8] = {
-	 0,	/* UART_RX  */
-	 2,	/* UART_IER */
-	 3,	/* UART_IIR */
-	 5,	/* UART_LCR */
-	 6,	/* UART_MCR */
-	 7,	/* UART_LSR */
-	 8,	/* UART_MSR */
-	-1,	/* UART_SCR (unmapped) */
+	[UART_RX]	= 0,
+	[UART_IER]	= 2,
+	[UART_IIR]	= 3,
+	[UART_LCR]	= 5,
+	[UART_MCR]	= 6,
+	[UART_LSR]	= 7,
+	[UART_MSR]	= 8,
+	[UART_SCR]	= UART_REG_UNMAPPED,
 };
 
 static const s8 au_io_out_map[8] = {
-	 1,	/* UART_TX  */
-	 2,	/* UART_IER */
-	 4,	/* UART_FCR */
-	 5,	/* UART_LCR */
-	 6,	/* UART_MCR */
-	-1,	/* UART_LSR (unmapped) */
-	-1,	/* UART_MSR (unmapped) */
-	-1,	/* UART_SCR (unmapped) */
+	[UART_TX]	= 1,
+	[UART_IER]	= 2,
+	[UART_FCR]	= 4,
+	[UART_LCR]	= 5,
+	[UART_MCR]	= 6,
+	[UART_LSR]	= UART_REG_UNMAPPED,
+	[UART_MSR]	= UART_REG_UNMAPPED,
+	[UART_SCR]	= UART_REG_UNMAPPED,
 };
 
 unsigned int au_serial_in(struct uart_port *p, int offset)
@@ -364,7 +366,7 @@ unsigned int au_serial_in(struct uart_port *p, int offset)
 	if (offset >= ARRAY_SIZE(au_io_in_map))
 		return UINT_MAX;
 	offset = au_io_in_map[offset];
-	if (offset < 0)
+	if (offset == UART_REG_UNMAPPED)
 		return UINT_MAX;
 	return __raw_readl(p->membase + (offset << p->regshift));
 }
@@ -374,7 +376,7 @@ void au_serial_out(struct uart_port *p, int offset, int value)
 	if (offset >= ARRAY_SIZE(au_io_out_map))
 		return;
 	offset = au_io_out_map[offset];
-	if (offset < 0)
+	if (offset == UART_REG_UNMAPPED)
 		return;
 	__raw_writel(value, p->membase + (offset << p->regshift));
 }
-- 
2.30.2

