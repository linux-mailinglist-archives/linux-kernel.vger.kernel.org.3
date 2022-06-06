Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5453E75C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiFFKH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiFFKGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADCB1248D3;
        Mon,  6 Jun 2022 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509946; x=1686045946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7XSfGDSnHBYzZ97A7lWYCvMsBnzI6IPieM3jLFqdRQY=;
  b=SI3yj8OSI8bltOiLecpIrnVZ+IRrTdrbD+XnJCJVPt7bKVwg679PI4oH
   SmqKTNqgyQD64mjjYRCIgkimRR6V/kpBib7APg6mrb+yfVVaeZH2xmETu
   8tji6L1txBZbWMToglDQ1r/gAEGc5C1DI9rJWgz42lN9Ttas5B8WHCjc/
   w1nCp8FY4gX9g99myVJBnHY0pRhi3uuTqDZ/PjzE8qFuT/vg9WvW0DVkw
   gEPVMUIk5xge76/np3CtE0SN5jQ+Np8FtY91/nqsUfypYFYlOXTXei//X
   JiGD7Q0+HROP8oYQ56ppsPxzu61ElGQdtFTPjlqkKckcFwuKDSzHHgu5D
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987063"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987063"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523762"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:44 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 18/36] serial: mcf: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:15 +0300
Message-Id: <20220606100433.13793-19-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/mcf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 2aec62b5d6c4..655255e0c76a 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -453,6 +453,10 @@ static int mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 	return 0;
 }
 
+static const struct serial_rs485 mcf_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
+};
+
 /****************************************************************************/
 
 /*
@@ -502,6 +506,7 @@ int __init early_mcf_setup(struct mcf_platform_uart *platp)
 		port->uartclk = MCF_BUSCLK;
 		port->flags = UPF_BOOT_AUTOCONF;
 		port->rs485_config = mcf_config_rs485;
+		port->rs485_supported = &mcf_rs485_supported;
 		port->ops = &mcf_uart_ops;
 	}
 
@@ -629,6 +634,7 @@ static int mcf_probe(struct platform_device *pdev)
 		port->ops = &mcf_uart_ops;
 		port->flags = UPF_BOOT_AUTOCONF;
 		port->rs485_config = mcf_config_rs485;
+		port->rs485_supported = &mcf_rs485_supported;
 		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
 
 		uart_add_one_port(&mcf_driver, port);
-- 
2.30.2

