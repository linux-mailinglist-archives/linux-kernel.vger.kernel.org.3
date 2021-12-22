Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB9D47D7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbhLVToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:44:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:55515 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbhLVToJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640202249; x=1671738249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7eZDGz/iiLgWgKXq6dgjtOY9xoQndBNl5y9xF61/U0I=;
  b=YBI6h/kK3jj+iN/+xjLbBMS4NhV1+49WRVGaUnkcZV1/pfZpnyGgoH8I
   EI57xssMvQd8Ppk9doykOjqOSFtR6OTBMnzjmpBUD5ht3l1UETxOUOzuN
   QJCNogCEbrU6g0899LCTFd2j/dKNEz/DRGrkz9XzCc4umnb+QuyrRf05j
   P7/b+5N0/kb7a6aKknIoU7hkUXeQ+Q6LA7D5xs6jLGxymoPQWIM+0aYMo
   AGDX9vJT1BG46QjUgcLeKUg6vdEualRX/R5BcXj6AmVlxGJUNQx/Q0dxa
   ZhNC4GLiSheq0kOv24cl0dlrSleqoWm2L+cD1Umhu9/EDqX9NdDz+eNLO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="327004123"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="327004123"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 11:44:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="570674162"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Dec 2021 11:44:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2F4C5FE; Wed, 22 Dec 2021 21:44:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_exar: derive nr_ports from ID for Acces I/O cards
Date:   Wed, 22 Dec 2021 21:44:13 +0200
Message-Id: <20211222194413.75069-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the similar way how it's done in 8250_pericom, derive number of
UART ports from PCI ID for Acces I/O cards.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 37 ++++++++++-------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index a4508ac0cac9..cf16bd889abd 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -611,7 +611,12 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 
 	maxnr = pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);
 
-	nr_ports = board->num_ports ? board->num_ports : pcidev->device & 0x0f;
+	if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO)
+		nr = BIT(((pcidev->device & 0x38) >> 3) - 1);
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

