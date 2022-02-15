Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CD44B6DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiBONoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:44:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiBONn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:43:58 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2974D109F;
        Tue, 15 Feb 2022 05:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644932628; x=1676468628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8+Ef9YN8LSSPy+BvHaYR3DJrg5mpRPczEb96wm5Ge38=;
  b=H/qfXOGtj4cOzckR5WHsm4NXgYxtqQkp94vUwG3m/qKxS4a64QN2qNzn
   1TxIZuoZt4Ys6GbFcJRxaXWI5vBKHauYgenr1r4h6UPVUDnKY4baA/0zk
   lQSdIT/1/+NC8FhnYADU3SYm/WSoikGdqKsNDb3S4i4Ej92xV6pYq6vY0
   So7HZ936t7jyY4bYgIjfjMhaXQq43hvHL9EnrK7jHBvws8bNBZ+SeLkjJ
   csnOQDqFXmSxgoHTpSCgBIdMe0UAvv4SX1/lIODQh8PkEkxtcZf0bZWi6
   iF+0FNv0DNijBc+xGHAAIrCgPN/9d1oGn6DCWltulXH+PmBzNlgUuuSG+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313626821"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="313626821"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 05:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="497136041"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 05:43:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5FDBE143; Tue, 15 Feb 2022 15:44:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 2/2] serial: 8250_lpss: Switch to pcim_iomap() instead of pci_ioremap_bar()
Date:   Tue, 15 Feb 2022 15:43:59 +0200
Message-Id: <20220215134359.78169-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
References: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pci_iounmap() doesn't cover all the cases where resource should
be unmapped. Instead of spreading it more, replace the pci_ioremap_bar()
with pcim_iomap() which uses managed resource approach.

Fixes: fecdef932b00 ("serial: 8250_lpss: enable DMA on Intel Quark UART")
Depends-on: ea5ab2e422de ("8250_lpss: check null return when calling pci_ioremap_bar")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new fix (by code inspection due to previous patch)
 drivers/tty/serial/8250/8250_lpss.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 0f5af061e0b4..a9fc1d7d9c37 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -209,7 +209,7 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	chip->dev = &pdev->dev;
 	chip->id = pdev->devfn;
 	chip->irq = pci_irq_vector(pdev, 0);
-	chip->regs = pci_ioremap_bar(pdev, 1);
+	chip->regs = pcim_iomap(pdev, 1, 0);
 	if (!chip->regs)
 		return;
 
@@ -241,8 +241,6 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 		return;
 
 	dw_dma_remove(chip);
-
-	pci_iounmap(to_pci_dev(chip->dev), chip->regs);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
 static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
-- 
2.34.1

