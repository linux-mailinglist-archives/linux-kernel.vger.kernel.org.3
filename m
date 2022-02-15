Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFAB4B694A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiBOK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:29:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiBOK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:28:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112702B182;
        Tue, 15 Feb 2022 02:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644920929; x=1676456929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=85wKYWEI0PZAYipWC8gNEf3x2a/vJuUB3PU/diIazfo=;
  b=IwbAHPWrCD2xc+uq0/CrmSn7Co2J1fP5F+kraVI4/8T3t1S95CwutuXO
   NLTwfMcq6DA7y8uI9575b4sAB+lAXNWSoohoC+SnUkpCZM9/zmWK/Uvv5
   h26iSJL9NSut4Oa8EQt/5qMBAZUxIkOd11kzsPx+iXVXOb/w7bcqBsYi+
   56g5UKeLrnrob2d36763iBTjZIFPpdeRwmRVmYdqvi9XWCqnjpR56AWM0
   B7pdjB+85hG0bFzR5C6sXMhsaDKMeG3wxwYwcFC3EBsjx1uMjCKnKTz9b
   U5br87nx0Iu+FtUjUrO3LVJVFNjWtvr+W5sG8pE1w21Na6UUJ2iiBcujh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230285315"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="230285315"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 02:28:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="773468790"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 15 Feb 2022 02:28:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D7FF715B; Tue, 15 Feb 2022 12:29:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>, Qing Wang <wangqing@vivo.com>
Subject: [PATCH v1 1/1] serial: 8250_lpss: Balance reference count for PCI DMA device
Date:   Tue, 15 Feb 2022 12:28:59 +0200
Message-Id: <20220215102859.69123-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/tty/serial/8250/8250_lpss.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index d3bafec7619d..96a4dc709bce 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -152,6 +152,14 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
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
@@ -170,6 +178,10 @@ static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	return 0;
 }
 
+static void ehl_serial_exit(struct lpss8250 *lpss)
+{
+}
+
 #ifdef CONFIG_SERIAL_8250_DMA
 static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
 	.nr_channels = 2,
@@ -344,8 +356,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_exit:
-	if (lpss->board->exit)
-		lpss->board->exit(lpss);
+	lpss->board->exit(lpss);
 	pci_free_irq_vectors(pdev);
 	return ret;
 }
@@ -356,8 +367,7 @@ static void lpss8250_remove(struct pci_dev *pdev)
 
 	serial8250_unregister_port(lpss->data.line);
 
-	if (lpss->board->exit)
-		lpss->board->exit(lpss);
+	lpss->board->exit(lpss);
 	pci_free_irq_vectors(pdev);
 }
 
@@ -365,12 +375,14 @@ static const struct lpss8250_board byt_board = {
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

