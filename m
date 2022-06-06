Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F253E636
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbiFFKJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiFFKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4413A2C4;
        Mon,  6 Jun 2022 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509974; x=1686045974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8oQ3ewHg3zpBccSONWwns1Fm40ESV4+zLrlmNBxoXUc=;
  b=OUDOoAppi34XWjZnkdXuaSAFbTRh6XT0Fgh1oa1Q2l2mLDeGCp+xQG37
   0XINOY97DGyb5d1y2njwyP+ayWaEPXPxEgnqWyTL3K3AcHjZ2iU4UvmCZ
   Slma6N0EXLhrUr9RHqfPOHs00CdE1MlzcTLQIXd9KMYdxg4qZhoIY1mYg
   W9pQBRfjgZ5jMm7LWnWtnNrSTv7Xo3oloHmkZsW73lSTFUJxqjckQfzQ0
   ZBq8xsL8OxoMGCYf1+SRbUVYSQoWQFbgRXx11lCj0cQ065544TWq+2+l4
   C4iHQoEUI2LR0OEbXKQWGFxhlNFEdNO2IVELLqcl8FOYUKaCGu+vNJpNv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987083"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987083"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523854"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:12 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 28/36] serial: 8250_pci: Remove serial_rs485 sanitization
Date:   Mon,  6 Jun 2022 13:04:25 +0300
Message-Id: <20220606100433.13793-29-ilpo.jarvinen@linux.intel.com>
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

Serial core handles serial_rs485 sanitization and copying rs485 struct.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index a76254031bc2..b6d71268aa7d 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1562,14 +1562,6 @@ static int pci_fintek_rs485_config(struct uart_port *port,
 
 	pci_read_config_byte(pci_dev, 0x40 + 8 * *index + 7, &setting);
 
-	if (rs485->flags & SER_RS485_ENABLED)
-		memset(rs485->padding, 0, sizeof(rs485->padding));
-	else
-		memset(rs485, 0, sizeof(*rs485));
-
-	/* F81504/508/512 not support RTS delay before or after send */
-	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
-
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable RTS H/W control mode */
 		setting |= FINTEK_RTS_CONTROL_BY_HW;
@@ -1581,9 +1573,6 @@ static int pci_fintek_rs485_config(struct uart_port *port,
 			/* RTS driving low on TX */
 			setting |= FINTEK_RTS_INVERT;
 		}
-
-		rs485->delay_rts_after_send = 0;
-		rs485->delay_rts_before_send = 0;
 	} else {
 		/* Disable RTS H/W control mode */
 		setting &= ~(FINTEK_RTS_CONTROL_BY_HW | FINTEK_RTS_INVERT);
@@ -1591,9 +1580,6 @@ static int pci_fintek_rs485_config(struct uart_port *port,
 
 	pci_write_config_byte(pci_dev, 0x40 + 8 * *index + 7, setting);
 
-	if (rs485 != &port->rs485)
-		port->rs485 = *rs485;
-
 	return 0;
 }
 
-- 
2.30.2

