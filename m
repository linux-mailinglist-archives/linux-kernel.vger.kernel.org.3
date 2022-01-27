Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB2049E9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiA0SGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:06:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:25424 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236657AbiA0SGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306777; x=1674842777;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aAQSLnsFhUPTordpbiaInHqdpfNTKKO9IrT60Vc8DBU=;
  b=JQovtNFVDfrOUfallVALl3O92zyMho82lWPtEE0WCLydvDgp/DrDH2IU
   XrJISnyMTTplpyLcVscH1uF+zFiQVqctWazka+33eJQoKfQzqdxpCOxr4
   4HJvffV1LfLIrFy5geC02U9mYs9sDoD7gS92ch3SxXrternlghTURBcJE
   J7Thu02jHVjdoQsTUhYeaxSJkMnkyR2IZX6E/B4w1qggQIALnM3RPzAGg
   XtXrqFKrayFZH16cPR1pZK8kEt3Ph9DKpLINPUhKZGQjAzu9ACM5/G3Xv
   48Z3KZNjdhuOFIPXfrKjnZKnNzIOUPY6/N+cAHg9W4Bl3T6a1jm5ArVEN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333281985"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="333281985"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 10:05:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="533196457"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2022 10:05:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3C665167; Thu, 27 Jan 2022 20:06:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 1/1] serial: 8250_exar: derive nr_ports from PCI ID for Acces I/O cards
Date:   Thu, 27 Jan 2022 20:06:08 +0200
Message-Id: <20220127180608.71509-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the similar way how it's done in 8250_pericom, derive the number of
the UART ports from PCI ID for Acces I/O cards.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed variable name (Ilpo)
 drivers/tty/serial/8250/8250_exar.c | 37 ++++++++++-------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index a4508ac0cac9..a243f36c41fa 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -611,7 +611,12 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 
 	maxnr = pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);
 
-	nr_ports = board->num_ports ? board->num_ports : pcidev->device & 0x0f;
+	if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO)
+		nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
+	else if (board->num_ports)
+		nr_ports = board->num_ports;
+	else
+		nr_ports = pcidev->device & 0x0f;
 
 	priv = devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
 	if (!priv)
@@ -710,22 +715,6 @@ static int __maybe_unused exar_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
 
-static const struct exar8250_board acces_com_2x = {
-	.num_ports	= 2,
-	.setup		= pci_xr17c154_setup,
-};
-
-static const struct exar8250_board acces_com_4x = {
-	.num_ports	= 4,
-	.setup		= pci_xr17c154_setup,
-};
-
-static const struct exar8250_board acces_com_8x = {
-	.num_ports	= 8,
-	.setup		= pci_xr17c154_setup,
-};
-
-
 static const struct exar8250_board pbn_fastcom335_2 = {
 	.num_ports	= 2,
 	.setup		= pci_fastcom335_setup,
@@ -810,13 +799,13 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	}
 
 static const struct pci_device_id exar_pci_tbl[] = {
-	EXAR_DEVICE(ACCESSIO, COM_2S, acces_com_2x),
-	EXAR_DEVICE(ACCESSIO, COM_4S, acces_com_4x),
-	EXAR_DEVICE(ACCESSIO, COM_8S, acces_com_8x),
-	EXAR_DEVICE(ACCESSIO, COM232_8, acces_com_8x),
-	EXAR_DEVICE(ACCESSIO, COM_2SM, acces_com_2x),
-	EXAR_DEVICE(ACCESSIO, COM_4SM, acces_com_4x),
-	EXAR_DEVICE(ACCESSIO, COM_8SM, acces_com_8x),
+	EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
+	EXAR_DEVICE(ACCESSIO, COM_4S, pbn_exar_XR17C15x),
+	EXAR_DEVICE(ACCESSIO, COM_8S, pbn_exar_XR17C15x),
+	EXAR_DEVICE(ACCESSIO, COM232_8, pbn_exar_XR17C15x),
+	EXAR_DEVICE(ACCESSIO, COM_2SM, pbn_exar_XR17C15x),
+	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
+	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),
 
 	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
 	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
-- 
2.34.1

