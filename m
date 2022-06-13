Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD755480FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbiFMHw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbiFMHw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:52:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F89DF2A;
        Mon, 13 Jun 2022 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655106772; x=1686642772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bwi2Vvc2+30PyuZPEbysx8z3V6ygkFBP38WvAgtFQPk=;
  b=SwLgYf7Se5srxQKwUwC0A4/s1qznaqWLyC3uTAwG0D1OPy6FJxWUS4gl
   Cdp1W04bqXsbFtZJlRBUmbv+hj0Uljku//e5A+qNQhA/JkXx+4OE9x0qK
   Jh5SMMKXjCBRB3zuLhMUBZkMR0ohEaKwpsvORhACbUj0sLXcVPFmt/yzl
   kLAZAlQwAsh+gEStQoZFRprxbieqjXfK7VrZyAOQDV7+5ytjOTC/o9H5T
   x5Vycu/cb+nNbnDDL/lSgs/L4oJRvQqtxybz4r8axpBhm66hP83RDPMGm
   dTUZfgd+A2Jwlj6KUGN+s77D2w97DWygjx+l6rHCxSbOh0wi0FparZVPa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="261239105"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="261239105"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:52:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="639593224"
Received: from fnechitx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.40.115])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:52:47 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lukas Wunner <lukas.wunner@intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 3/6] serial: 8250_lpss: Use 32-bit reads
Date:   Mon, 13 Jun 2022 10:52:24 +0300
Message-Id: <20220613075227.10394-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613075227.10394-1-ilpo.jarvinen@linux.intel.com>
References: <20220613075227.10394-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

