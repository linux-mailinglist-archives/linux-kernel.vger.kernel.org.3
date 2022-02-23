Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6A4C162F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbiBWPLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiBWPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:11:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A584AB65E9;
        Wed, 23 Feb 2022 07:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645629073; x=1677165073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AoSFRgrUFUDO1B0aof0XuA6F59treUMH8g8YYtllkbo=;
  b=kCKmp6b8bfahkTOCBMwaxIy3dFNvs/2l/2fE2H0f7+kwyd7QuEZv3NNx
   5lq66EwcIe/Yly1KoZQxH/CdVOvoB2+HrVUFRmlRe6t8RhbHAaOoM2Lhq
   biK4jzvzHZLVebKmyYQEa4M3YP07HQJH0aZibs7jDPaDXMMxNWz9orqbI
   aH5pD7IupVKaJ85HY1JWyiZrThgD8JZ8LO03g7B7DLwdEjJ8uLMrL33tv
   oCF8fKSWWYoqzZ9I11SB0K0seAK24DEjQObA4z/WNnzj17UWS6NEYPVaN
   PEwAR8I+M7BaVKTv99dg8e4sOibrUMHog+AExIR0F1kVCf/XTSwa77p9X
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="239374967"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="239374967"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:11:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="607080661"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2022 07:11:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B31394; Wed, 23 Feb 2022 17:11:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Qing Wang <wangqing@vivo.com>
Subject: [PATCH v2 1/1] serial: 8250_mid: Balance reference count for PCI DMA device
Date:   Wed, 23 Feb 2022 17:11:24 +0200
Message-Id: <20220223151124.70026-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pci_get_slot() increases its reference count, the caller
must decrement the reference count by calling pci_dev_put().

Fixes: 90b9aacf912a ("serial: 8250_pci: add Intel Tangier support")
Fixes: f549e94effa1 ("serial: 8250_pci: add Intel Penwell ports")
Depends-on: d9eda9bab237 ("serial: 8250_pci: Intel MID UART support to its own driver")
Reported-by: Qing Wang <wangqing@vivo.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of the latest tty-linus
 drivers/tty/serial/8250/8250_mid.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 83592b51a996..a2a03acb04ad 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -73,6 +73,11 @@ static int pnw_setup(struct mid8250 *mid, struct uart_port *p)
 	return 0;
 }
 
+static void pnw_exit(struct mid8250 *mid)
+{
+	pci_dev_put(mid->dma_dev);
+}
+
 static int tng_handle_irq(struct uart_port *p)
 {
 	struct mid8250 *mid = p->private_data;
@@ -124,6 +129,11 @@ static int tng_setup(struct mid8250 *mid, struct uart_port *p)
 	return 0;
 }
 
+static void tng_exit(struct mid8250 *mid)
+{
+	pci_dev_put(mid->dma_dev);
+}
+
 static int dnv_handle_irq(struct uart_port *p)
 {
 	struct mid8250 *mid = p->private_data;
@@ -328,9 +338,9 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_drvdata(pdev, mid);
 	return 0;
+
 err:
-	if (mid->board->exit)
-		mid->board->exit(mid);
+	mid->board->exit(mid);
 	return ret;
 }
 
@@ -340,8 +350,7 @@ static void mid8250_remove(struct pci_dev *pdev)
 
 	serial8250_unregister_port(mid->line);
 
-	if (mid->board->exit)
-		mid->board->exit(mid);
+	mid->board->exit(mid);
 }
 
 static const struct mid8250_board pnw_board = {
@@ -349,6 +358,7 @@ static const struct mid8250_board pnw_board = {
 	.freq = 50000000,
 	.base_baud = 115200,
 	.setup = pnw_setup,
+	.exit = pnw_exit,
 };
 
 static const struct mid8250_board tng_board = {
@@ -356,6 +366,7 @@ static const struct mid8250_board tng_board = {
 	.freq = 38400000,
 	.base_baud = 1843200,
 	.setup = tng_setup,
+	.exit = tng_exit,
 };
 
 static const struct mid8250_board dnv_board = {
-- 
2.34.1

