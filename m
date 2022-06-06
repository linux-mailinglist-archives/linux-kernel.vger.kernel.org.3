Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A3753EC1B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiFFKHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiFFKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270BE64D0B;
        Mon,  6 Jun 2022 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509935; x=1686045935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aI/KgY4+B8Ci+VydAqA1rpLQE3wNHPRRmKH/bbm45dk=;
  b=azvu6Vpl08iHAE6WYq8mP4ZHUw6I5cvE4//luw8ibmxH9n6zu0CEPliC
   Xe59QqS1xWeZ49jjiH3ZG6DK4MlrGLK9rhNRyAWVQJqF8Hsph3r2HQz95
   bce/kdIOsauV2PgCSjfMmfzMuJnkmMmI5XrgpP1tRQ5+XCDyAgTPTomXE
   6CHM6RlW3gxQjfeo40f0ie4rSsRo+Au+xoHLqxKs3BG0QHbCk6aU/L3cT
   nz7nXFuq5ln2eN1GNJhA6D1zSivWYlNtiYPm7nbLWpxxXoF82mcrw7oBx
   y1Mvc+nSTj1zhsFaUVfkuxTgkkm2PZL01lX5+JbC0ib8dHErNALc1QLEn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987053"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987053"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523691"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:28 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 13/36] serial: ar933x: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:10 +0300
Message-Id: <20220606100433.13793-14-ilpo.jarvinen@linux.intel.com>
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

Add information on supported serial_rs485 features.

In the case where RTS is lacking, RS485 cannot be enabled so provide
zero rs485_supported for that case. Perhaps it would make sense to not
provide rs485_config() at all in that case but such a change would have
userspace visible impact/change in behavior so this patch does not
attempt it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/ar933x_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 6269dbf93546..ab2c5b2a1ce8 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -702,6 +702,11 @@ static struct uart_driver ar933x_uart_driver = {
 	.cons		= NULL, /* filled in runtime */
 };
 
+static const struct serial_rs485 ar933x_no_rs485 = {};
+static const struct serial_rs485 ar933x_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
+};
+
 static int ar933x_uart_probe(struct platform_device *pdev)
 {
 	struct ar933x_uart_port *up;
@@ -773,6 +778,7 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	port->fifosize = AR933X_UART_FIFO_SIZE;
 	port->ops = &ar933x_uart_ops;
 	port->rs485_config = ar933x_config_rs485;
+	port->rs485_supported = &ar933x_rs485_supported;
 
 	baud = ar933x_uart_get_baud(port->uartclk, AR933X_UART_MAX_SCALE, 1);
 	up->min_baud = max_t(unsigned int, baud, AR933X_UART_MIN_BAUD);
@@ -796,6 +802,7 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	    !up->rts_gpiod) {
 		dev_err(&pdev->dev, "lacking rts-gpio, disabling RS485\n");
 		port->rs485.flags &= ~SER_RS485_ENABLED;
+		port->rs485_supported = &ar933x_no_rs485;
 	}
 
 #ifdef CONFIG_SERIAL_AR933X_CONSOLE
-- 
2.30.2

