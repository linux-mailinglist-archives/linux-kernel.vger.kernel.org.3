Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB80E4B6DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiBONoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:44:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbiBONn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:43:58 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B2EEF79A;
        Tue, 15 Feb 2022 05:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644932629; x=1676468629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cmKw35IY9cbJ6YmhebqoqUoFN6ud0S+L3yRqYhkV0ac=;
  b=dU4sbr7im8I/ims4Hlbq1L5ZPVG8TiP8Gr1G6Di1mNAU5lb40tm4WeLN
   tfOe7lWOvrzShMpm9MYezQgbNU2eytXco7iSRz3zXCZUDrILe73pEYw7t
   kYt2Ufe9xnvZUCHqHNCz+t/07J3/VfXg5XHp7w0u82ASYF1QVGeTYVPgv
   j8wIjGwowOwXadq72SHRoF1m2uHQhioy1Xf3gsZXsfauVhjSNV6bB6DA2
   yfgNm4IrfIOH3mJp72r2TtvE/iuD/O0GsFcNdPFRoWdYpgYIP0tWbFm1K
   n/POC/tI9U0qB/PWAjeL6OQv3MdQKo6J6a13PvfHijwCcXaS0fqNF8OIW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="233894108"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="233894108"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 05:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="635885098"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 05:43:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 551ED15B; Tue, 15 Feb 2022 15:44:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Qing Wang <wangqing@vivo.com>
Subject: [PATCH v2 1/2] serial: 8250_lpss: Balance reference count for PCI DMA device
Date:   Tue, 15 Feb 2022 15:43:58 +0200
Message-Id: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pci_get_slot() increases its reference count, the caller
must decrement the reference count by calling pci_dev_put().

Fixes: 9a1870ce812e ("serial: 8250: don't use slave_id of dma_slave_config")
Depends-on: a13e19cf3dc1 ("serial: 8250_lpss: split LPSS driver to separate module")
Reported-by: Qing Wang <wangqing@vivo.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: made sure we bump reference count only on success (Jiri)
 drivers/tty/serial/8250/8250_lpss.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index d3bafec7619d..0f5af061e0b4 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -117,8 +117,7 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 {
 	struct dw_dma_slave *param = &lpss->dma_param;
 	struct pci_dev *pdev = to_pci_dev(port->dev);
-	unsigned int dma_devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
-	struct pci_dev *dma_dev = pci_get_slot(pdev->bus, dma_devfn);
+	struct pci_dev *dma_dev;
 
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_INTEL_BYT_UART1:
@@ -137,6 +136,8 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 		return -EINVAL;
 	}
 
+	dma_dev = pci_get_slot(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
+
 	param->dma_dev = &dma_dev->dev;
 	param->m_master = 0;
 	param->p_master = 1;
@@ -152,6 +153,14 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	return 0;
 }
 
+static void byt_serial_exit(struct lpss8250 *lpss)
+{
+	struct dw_dma_slave *param = &lpss->dma_param;
+
+	/* Paired with pci_get_slot() in the byt_serial_setup() above */
+	put_device(param->dma_dev);
+}
+
 static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 {
 	struct uart_8250_dma *dma = &lpss->data.dma;
@@ -170,6 +179,13 @@ static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	return 0;
 }
 
+static void ehl_serial_exit(struct lpss8250 *lpss)
+{
+	struct uart_8250_port *up = serial8250_get_port(lpss->data.line);
+
+	up->dma = NULL;
+}
+
 #ifdef CONFIG_SERIAL_8250_DMA
 static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
 	.nr_channels = 2,
@@ -344,8 +360,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_exit:
-	if (lpss->board->exit)
-		lpss->board->exit(lpss);
+	lpss->board->exit(lpss);
 	pci_free_irq_vectors(pdev);
 	return ret;
 }
@@ -356,8 +371,7 @@ static void lpss8250_remove(struct pci_dev *pdev)
 
 	serial8250_unregister_port(lpss->data.line);
 
-	if (lpss->board->exit)
-		lpss->board->exit(lpss);
+	lpss->board->exit(lpss);
 	pci_free_irq_vectors(pdev);
 }
 
@@ -365,12 +379,14 @@ static const struct lpss8250_board byt_board = {
 	.freq = 100000000,
 	.base_baud = 2764800,
 	.setup = byt_serial_setup,
+	.exit = byt_serial_exit,
 };
 
 static const struct lpss8250_board ehl_board = {
 	.freq = 200000000,
 	.base_baud = 12500000,
 	.setup = ehl_serial_setup,
+	.exit = ehl_serial_exit,
 };
 
 static const struct lpss8250_board qrk_board = {
-- 
2.34.1

