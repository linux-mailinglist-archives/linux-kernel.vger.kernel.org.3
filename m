Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD053EA0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiFFKID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiFFKGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343D6127988;
        Mon,  6 Jun 2022 03:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509949; x=1686045949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VW7eoIRDLDLFWBbt2VZnnx9snvB/xQDw6V2b9QVadRI=;
  b=HJEZJ6xYcKSNzGG7/bebQN1YtFj017bw5HLf41nUpxbF3sbj4RNzwBKz
   euPS+/TYnaMTo8RnRqYv/Au7PhbrlIBi6SMt0sVRTv6lSDHcGz42l2DFH
   YaXnAKZWy0lr75JrRE4zTCq+H8UzS7vK9BQt5+/41uIiswZXFhFOQduQ2
   okuhoqxQAMfi+19sixdkLwiB5JDs3hE8WVBaqx0+7iqiD9maG3u6YXRBa
   WpTYi+RiImE/H+9lXHmC23SBticuRlWjHutOxOWZ01b9HFui4OS+v4Grr
   dWJi/QJGgVmP/80iKB7X3DI+bgN3jYYQKrr6SVEARrriNYBPUQnBZ3TOs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987065"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987065"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523773"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:47 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 19/36] serial: omap: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:16 +0300
Message-Id: <20220606100433.13793-20-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/omap-serial.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 46f4d4cacb6e..98622c35d896 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1559,6 +1559,13 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 	return 0;
 }
 
+static const struct serial_rs485 serial_omap_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
+		 SER_RS485_RX_DURING_TX,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,
+};
+
 static int serial_omap_probe(struct platform_device *pdev)
 {
 	struct omap_uart_port_info *omap_up_info = dev_get_platdata(&pdev->dev);
@@ -1636,6 +1643,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.flags = omap_up_info->flags;
 	up->port.uartclk = omap_up_info->uartclk;
 	up->port.rs485_config = serial_omap_config_rs485;
+	up->port.rs485_supported = &serial_omap_rs485_supported;
 	if (!up->port.uartclk) {
 		up->port.uartclk = DEFAULT_CLK_SPEED;
 		dev_warn(&pdev->dev,
-- 
2.30.2

