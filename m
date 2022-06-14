Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7B54AB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355287AbiFNH5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352727AbiFNH46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:56:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4243EF09;
        Tue, 14 Jun 2022 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655193418; x=1686729418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zIQrQlUmKwb8YHvLHxjwbgT1lAItadg+f+xEfpBQyQ8=;
  b=CUT2BPuVn/SFo1xi+iCOzpJ8Arm916yQHG23AXXxRthdGJAjlq7ui08K
   agqX8Qm5RfJUOhDEvx5L0cofIZdWAB/16LKNkSzOM8sWq/XQb3t+fu4ha
   gYAOn4ur+2qGDhS0VeBRzb5tTQqkpP+QTF/3zQwy05q5PkTmoN9mdYhdC
   lNStcHNXdVBTVtcAsyoCTX+dez10/2tYrKmqe9XSgZ/V48GSq/ItMy8fP
   szdJT0NJT904PFRPmNseIXSSGkF6cQn4bfsw9vllg+71NJ+508ckyeovM
   Ug5oSHTJZ6r/IwWIim6v4nwjgwFCcE0AV+hoo6wfvOVsTC9eitEkUtkVt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267230704"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="267230704"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:56:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="588307701"
Received: from jlaghzal-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.32.175])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:56:49 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?UTF-8?q?Nuno=20Gon=C3=A7alves?= <nunojpg@gmail.com>
Subject: [PATCH v4] serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle
Date:   Tue, 14 Jun 2022 10:56:37 +0300
Message-Id: <20220614075637.8558-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver must provide throttle and unthrottle in uart_ops when it
sets UPSTAT_AUTORTS. Add them using existing stop_rx &
enable_interrupts functions.

Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
Tested-by: Nuno Gonçalves <nunojpg@gmail.com>
Fixes: 2a76fa283098 (serial: pl011: Adopt generic flag to store auto RTS status)
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
v4:
- Added Nuno's Tested-by

v3:
- Add hooks to correct ops

 drivers/tty/serial/amba-pl011.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 97ef41cb2721..16a21422ddce 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1367,6 +1367,15 @@ static void pl011_stop_rx(struct uart_port *port)
 	pl011_dma_rx_stop(uap);
 }
 
+static void pl011_throttle_rx(struct uart_port *port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	pl011_stop_rx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static void pl011_enable_ms(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -1788,9 +1797,10 @@ static int pl011_allocate_irq(struct uart_amba_port *uap)
  */
 static void pl011_enable_interrupts(struct uart_amba_port *uap)
 {
+	unsigned long flags;
 	unsigned int i;
 
-	spin_lock_irq(&uap->port.lock);
+	spin_lock_irqsave(&uap->port.lock, flags);
 
 	/* Clear out any spuriously appearing RX interrupts */
 	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
@@ -1812,7 +1822,14 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
 	pl011_write(uap->im, uap, REG_IMSC);
-	spin_unlock_irq(&uap->port.lock);
+	spin_unlock_irqrestore(&uap->port.lock, flags);
+}
+
+static void pl011_unthrottle_rx(struct uart_port *port)
+{
+	struct uart_amba_port *uap = container_of(port, struct uart_amba_port, port);
+
+	pl011_enable_interrupts(uap);
 }
 
 static int pl011_startup(struct uart_port *port)
@@ -2225,6 +2242,8 @@ static const struct uart_ops amba_pl011_pops = {
 	.stop_tx	= pl011_stop_tx,
 	.start_tx	= pl011_start_tx,
 	.stop_rx	= pl011_stop_rx,
+	.throttle	= pl011_throttle_rx,
+	.unthrottle	= pl011_unthrottle_rx,
 	.enable_ms	= pl011_enable_ms,
 	.break_ctl	= pl011_break_ctl,
 	.startup	= pl011_startup,

-- 
tg: (f2906aa86338..) pl011/add-throttle (depends on: tty-next)
