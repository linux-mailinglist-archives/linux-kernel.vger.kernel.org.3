Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B312E53EA25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiFFKGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiFFKFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C856D1BF;
        Mon,  6 Jun 2022 03:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509932; x=1686045932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WqrcVFYGblqHCkvnnCBwU3N04CPl2ZyImCOIMc3L9wQ=;
  b=gRfhsJfDJaPPnxEkXA3YbSqweQ3KD6srTe/ng1Vm659xkcHyVHf6Kk56
   /dvapv4f3YO5II+fNvbq2WrNP+ftmDBNEpmcDyoj+J4VSRMwerCA2v9Cm
   HGBWYOx29smrdWSbgMZy9j3ZFFGHI1MUS/x+IVhBfdJ95B4da6aUV1Yan
   iPikNNPks3MMwhBG4yPMR6VkVE+lrJyNcWqmUJtCAHZeW8a3W6FK0NmZQ
   m0sG9kDxT+QNIFVktXH3k6Cap1Ey9VKDj5olLRt7lOoAI2PoxskgReW4I
   jwCly0LLMi+c1jE9JeuCfknkJVir2D6yw88lTV3AgH39f74oNCPHJQdQI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987042"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987042"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523580"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:11 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 07/36] serial: 8250_exar: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:04 +0300
Message-Id: <20220606100433.13793-8-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/8250/8250_exar.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 7292917ac878..11916f603a3d 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -113,6 +113,7 @@ struct exar8250;
 
 struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
+	const struct serial_rs485 *rs485_supported;
 	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
 	void (*unregister_gpio)(struct uart_8250_port *);
 };
@@ -431,10 +432,15 @@ static int generic_rs485_config(struct uart_port *port,
 	return 0;
 }
 
+static const struct serial_rs485 generic_rs485_supported = {
+	.flags = SER_RS485_ENABLED,
+};
+
 static const struct exar8250_platform exar8250_default_platform = {
 	.register_gpio = xr17v35x_register_gpio,
 	.unregister_gpio = xr17v35x_unregister_gpio,
 	.rs485_config = generic_rs485_config,
+	.rs485_supported = &generic_rs485_supported,
 };
 
 static int iot2040_rs485_config(struct uart_port *port,
@@ -470,6 +476,10 @@ static int iot2040_rs485_config(struct uart_port *port,
 	return generic_rs485_config(port, rs485);
 }
 
+static const struct serial_rs485 iot2040_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
+};
+
 static const struct property_entry iot2040_gpio_properties[] = {
 	PROPERTY_ENTRY_U32("exar,first-pin", 10),
 	PROPERTY_ENTRY_U32("ngpios", 1),
@@ -498,6 +508,7 @@ static int iot2040_register_gpio(struct pci_dev *pcidev,
 
 static const struct exar8250_platform iot2040_platform = {
 	.rs485_config = iot2040_rs485_config,
+	.rs485_supported = &iot2040_rs485_supported,
 	.register_gpio = iot2040_register_gpio,
 	.unregister_gpio = xr17v35x_unregister_gpio,
 };
@@ -540,6 +551,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 
 	port->port.uartclk = baud * 16;
 	port->port.rs485_config = platform->rs485_config;
+	port->port.rs485_supported = platform->rs485_supported;
 
 	/*
 	 * Setup the UART clock for the devices on expansion slot to
-- 
2.30.2

