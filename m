Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB053E65D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiFFKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiFFKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6DC719EF;
        Mon,  6 Jun 2022 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509933; x=1686045933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uiu6/OhYYKXexbF3L+XQuHEeDHHGh13iJur0g7QkeDo=;
  b=IwTitZE36Z3pIA+HQV40r84DMV4fHpBCqOhtXSeDrowCdwIXOmcFjGof
   iifQmuekdNbU8bhNoHqXdZuwKBpgkNDd+qdwP73bnOYnOc0Eq09NfCdwA
   1FeLCju+G2Dmp7fJcIFJ8bnkuWHQiGoc1Wqf1dPBlphuBcKAHWXUVen51
   F9n3AV+NGyPGOgQrRdcupIq6ztEWvlLY4WjD1Xv1zgX4ffzNMTWm5nyrr
   fzIQ4GNHy7Gfy3AMc33Jh7/YnBpYwi7k7Zo3X47XJB4whFwOE6MwPpExJ
   /o+tlDCCb76+BctUx9gNT/h21rx6PczFG+DQLju9RgEM3gXTHC/Zlhkmi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987045"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987045"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523608"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:17 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/36] serial: 8250_lpc18cc: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:06 +0300
Message-Id: <20220606100433.13793-10-ilpo.jarvinen@linux.intel.com>
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

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpc18xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 570e25d6f37e..66ce5d05fe9c 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -98,6 +98,12 @@ static void lpc18xx_uart_serial_out(struct uart_port *p, int offset, int value)
 	writel(value, p->membase + offset);
 }
 
+static const struct serial_rs485 lpc18xx_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_after_send = 1,
+	/* Delay RTS before send is not supported */
+};
+
 static int lpc18xx_serial_probe(struct platform_device *pdev)
 {
 	struct lpc18xx_uart_data *data;
@@ -168,6 +174,7 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 	uart.port.uartclk = clk_get_rate(data->clk_uart);
 	uart.port.private_data = data;
 	uart.port.rs485_config = lpc18xx_rs485_config;
+	uart.port.rs485_supported = &lpc18xx_rs485_supported;
 	uart.port.serial_out = lpc18xx_uart_serial_out;
 
 	uart.dma = &data->dma;
-- 
2.30.2

