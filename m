Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE0F55A2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiFXUm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiFXUmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:42:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11784880;
        Fri, 24 Jun 2022 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656103369; x=1687639369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bwi2Vvc2+30PyuZPEbysx8z3V6ygkFBP38WvAgtFQPk=;
  b=hqLgbC7JLEPuU0m0UdOWB28xauT/4ekHc1yD6zG0ggOZgkDv2kQxbQYC
   oKEhMnKXc+ibxugBWLagnXRelV+0SkChqn/5+WapVTw1Y5lMo7C9EduM3
   QhsadPPS1OkzpNnCHCDOzAuhSzA9hegS8yOyDONVPAZ7uhJkjC8nY/yk0
   B52GNQyw2jUCRmQMk7Ng5mWAKa7pid1EkGhcH3DK/JG5O+99Ox8J2JFuc
   b6YDY1aUtREkQGPpkfm5BK9Q4k7A3bX4fR+sHxo/yfV9/UWDkFFiyKvwo
   B3BncMLWs+mMoQODNt7b6GltQ/roG4l12qnzosGlI/bwCW5rnVTN1uLO7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="260899857"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="260899857"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:42:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="593381082"
Received: from vhavel-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.91])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:42:45 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 3/6] serial: 8250_lpss: Use 32-bit reads
Date:   Fri, 24 Jun 2022 23:42:07 +0300
Message-Id: <20220624204210.11112-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624204210.11112-1-ilpo.jarvinen@linux.intel.com>
References: <20220624204210.11112-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 32-bit reads in order to not lose higher bits of DW UART regs. This
change does not fix any known issue as the high bits are not used for
anything related to 8250 driver (dw8250_readl_ext and dw8250_writel_ext
used within the dwlib are already doing
readl/writel/ioread32be/iowrite32be anyway).

This change is necessary to enables 9th bit address mode. DW UART
reports address frames with BIT(8) of LSR.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 0f5af061e0b4..4ba43bef9933 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -330,7 +330,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	uart.port.irq = pci_irq_vector(pdev, 0);
 	uart.port.private_data = &lpss->data;
 	uart.port.type = PORT_16550A;
-	uart.port.iotype = UPIO_MEM;
+	uart.port.iotype = UPIO_MEM32;
 	uart.port.regshift = 2;
 	uart.port.uartclk = lpss->board->base_baud * 16;
 	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
-- 
2.30.2

