Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5546153EAB0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiFFKJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiFFKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A205113F422;
        Mon,  6 Jun 2022 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509979; x=1686045979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/YabGktWvQG02Q/xoYLG4tb6J7+vtQn25dgAbOHlnbo=;
  b=HnO20zhfRM6HHbZDqXHftIHTrh4iIO/B6H+ebnleEsdEZXHWaAyh0NUt
   KC12iQHrjhm4Iytl+NPfq9uDWNu5FMzUgh6+HWBftprn4LHJg4ElmJMdE
   iLIAzdidQDt2/hUu96SI39584iiO9vH48rNhT6/2c6zr8tq+2gkHmTu3e
   r/1lbU6P+GKY7Y/t63ZMlh/529biIo0wiL+PDsICAGUPzMsPJ4XHK4ifb
   oN508xgNVBfwFmHQWW9/wmVvxDxUh+ENuR8JPFzI08i7QX3FMt9hh4Qr5
   9reW3L4JEJizpT9206ux0RBw06pIGC8m1B5x6t28kGFnXX/cVE1gB2Pbx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987085"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987085"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523868"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:17 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 30/36] serial: fsl_lpuart: Call core's sanitization and remove custom one
Date:   Mon,  6 Jun 2022 13:04:27 +0300
Message-Id: <20220606100433.13793-31-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
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

Serial core handles serial_rs485 sanitization. Remove custom
sanitization from lpuart_config_rs485.

This change loses dev_err when SER_RS485_RX_DURING_TX is set due to
incorrect configuration. Other drivers do not do similar prinout for
full-duplex case and it should be done in serial core if it is
desirable to notify on this condition. Personally, I doesn't see it
important because the kernel gracefully downgrades to half-duplex.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/fsl_lpuart.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 88692dc9eefa..d35414cb3e4e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1365,11 +1365,6 @@ static int lpuart_config_rs485(struct uart_port *port,
 		~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
 	writeb(modem, sport->port.membase + UARTMODEM);
 
-	/* clear unsupported configurations */
-	rs485->delay_rts_before_send = 0;
-	rs485->delay_rts_after_send = 0;
-	rs485->flags &= ~SER_RS485_RX_DURING_TX;
-
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
 		modem |= UARTMODEM_TXRTSE;
@@ -1400,11 +1395,6 @@ static int lpuart32_config_rs485(struct uart_port *port,
 				& ~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 
-	/* clear unsupported configurations */
-	rs485->delay_rts_before_send = 0;
-	rs485->delay_rts_after_send = 0;
-	rs485->flags &= ~SER_RS485_RX_DURING_TX;
-
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
 		modem |= UARTMODEM_TXRTSE;
@@ -2723,13 +2713,6 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_get_rs485;
 
-	if (sport->port.rs485.flags & SER_RS485_RX_DURING_TX)
-		dev_err(&pdev->dev, "driver doesn't support RX during TX\n");
-
-	if (sport->port.rs485.delay_rts_before_send ||
-	    sport->port.rs485.delay_rts_after_send)
-		dev_err(&pdev->dev, "driver doesn't support RTS delays\n");
-
 	uart_rs485_config(&sport->port);
 
 	ret = devm_request_irq(&pdev->dev, sport->port.irq, handler, 0,
-- 
2.30.2

