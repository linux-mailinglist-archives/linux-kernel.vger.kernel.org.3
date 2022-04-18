Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29682505BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbiDRPuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345857AbiDRPtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:49:41 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C45E65F40;
        Mon, 18 Apr 2022 08:27:22 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2ECB692009E; Mon, 18 Apr 2022 17:27:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 27F8A92009C;
        Mon, 18 Apr 2022 16:27:22 +0100 (BST)
Date:   Mon, 18 Apr 2022 16:27:22 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] serial: 8250: Fold EndRun device support into OxSemi
 Tornado code
In-Reply-To: <alpine.DEB.2.21.2204181506000.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204181516220.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204181506000.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EndRun PTP/1588 dual serial port device is based on the Oxford
Semiconductor OXPCIe952 UART device with the PCI vendor:device ID set
for EndRun Technologies and uses the same sequence to determine the
number of ports available.  Despite that we have duplicate code
specific to the EndRun device.

Remove redundant code then and factor out OxSemi Tornado device
detection.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes from v4:

- Reorder as 3/5 (from 2/5).

Changes from v3:

- Factor out baud base correction along with the `Fixes' tag to 1/5.

- Discard the change to move the EndRun vendor:device ID macros to 
  <linux/pci_ids.h>.

New change in v3.
---
 drivers/tty/serial/8250/8250_pci.c |   76 ++++++++++++-------------------------
 1 file changed, 25 insertions(+), 51 deletions(-)

linux-serial-8250-oxsemi-endrun.diff
Index: linux-macro/drivers/tty/serial/8250/8250_pci.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/8250/8250_pci.c
+++ linux-macro/drivers/tty/serial/8250/8250_pci.c
@@ -994,41 +994,29 @@ static void pci_ite887x_exit(struct pci_
 }
 
 /*
- * EndRun Technologies.
- * Determine the number of ports available on the device.
+ * Oxford Semiconductor Inc.
+ * Check if an OxSemi device is part of the Tornado range of devices.
  */
 #define PCI_VENDOR_ID_ENDRUN			0x7401
 #define PCI_DEVICE_ID_ENDRUN_1588	0xe100
 
-static int pci_endrun_init(struct pci_dev *dev)
+static bool pci_oxsemi_tornado_p(struct pci_dev *dev)
 {
-	u8 __iomem *p;
-	unsigned long deviceID;
-	unsigned int  number_uarts = 0;
+	/* OxSemi Tornado devices are all 0xCxxx */
+	if (dev->vendor == PCI_VENDOR_ID_OXSEMI &&
+	    (dev->device & 0xf000) != 0xc000)
+		return false;
 
-	/* EndRun device is all 0xexxx */
+	/* EndRun devices are all 0xExxx */
 	if (dev->vendor == PCI_VENDOR_ID_ENDRUN &&
-		(dev->device & 0xf000) != 0xe000)
-		return 0;
-
-	p = pci_iomap(dev, 0, 5);
-	if (p == NULL)
-		return -ENOMEM;
+	    (dev->device & 0xf000) != 0xe000)
+		return false;
 
-	deviceID = ioread32(p);
-	/* EndRun device */
-	if (deviceID == 0x07000200) {
-		number_uarts = ioread8(p + 4);
-		pci_dbg(dev, "%d ports detected on EndRun PCI Express device\n", number_uarts);
-	}
-	pci_iounmap(dev, p);
-	return number_uarts;
+	return true;
 }
 
 /*
- * Oxford Semiconductor Inc.
- * Check that device is part of the Tornado range of devices, then determine
- * the number of ports available on the device.
+ * Determine the number of ports available on a Tornado device.
  */
 static int pci_oxsemi_tornado_init(struct pci_dev *dev)
 {
@@ -1036,9 +1024,7 @@ static int pci_oxsemi_tornado_init(struc
 	unsigned long deviceID;
 	unsigned int  number_uarts = 0;
 
-	/* OxSemi Tornado devices are all 0xCxxx */
-	if (dev->vendor == PCI_VENDOR_ID_OXSEMI &&
-	    (dev->device & 0xF000) != 0xC000)
+	if (!pci_oxsemi_tornado_p(dev))
 		return 0;
 
 	p = pci_iomap(dev, 0, 5);
@@ -1049,7 +1035,10 @@ static int pci_oxsemi_tornado_init(struc
 	/* Tornado device */
 	if (deviceID == 0x07000200) {
 		number_uarts = ioread8(p + 4);
-		pci_dbg(dev, "%d ports detected on Oxford PCI Express device\n", number_uarts);
+		pci_dbg(dev, "%d ports detected on %s PCI Express device\n",
+			number_uarts,
+			dev->vendor == PCI_VENDOR_ID_ENDRUN ?
+			"EndRun" : "Oxford");
 	}
 	pci_iounmap(dev, p);
 	return number_uarts;
@@ -2244,7 +2233,7 @@ static struct pci_serial_quirk pci_seria
 		.device		= PCI_ANY_ID,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.init		= pci_endrun_init,
+		.init		= pci_oxsemi_tornado_init,
 		.setup		= pci_default_setup,
 	},
 	/*
@@ -2667,7 +2656,6 @@ enum pci_board_num_t {
 	pbn_panacom2,
 	pbn_panacom4,
 	pbn_plx_romulus,
-	pbn_endrun_2_3906250,
 	pbn_oxsemi,
 	pbn_oxsemi_1_3906250,
 	pbn_oxsemi_2_3906250,
@@ -3190,20 +3178,6 @@ static struct pciserial_board pci_boards
 	},
 
 	/*
-	 * EndRun Technologies
-	* Uses the size of PCI Base region 0 to
-	* signal now many ports are available
-	* 2 port 952 Uart support
-	*/
-	[pbn_endrun_2_3906250] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 2,
-		.base_baud	= 3906250,
-		.uart_offset	= 0x200,
-		.first_offset	= 0x1000,
-	},
-
-	/*
 	 * This board uses the size of PCI Base region 0 to
 	 * signal now many ports are available
 	 */
@@ -4123,13 +4097,6 @@ static const struct pci_device_id serial
 		0x10b5, 0x106a, 0, 0,
 		pbn_plx_romulus },
 	/*
-	* EndRun Technologies. PCI express device range.
-	*    EndRun PTP/1588 has 2 Native UARTs.
-	*/
-	{	PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_endrun_2_3906250 },
-	/*
 	 * Quatech cards. These actually have configurable clocks but for
 	 * now we just use the default.
 	 *
@@ -4390,6 +4357,13 @@ static const struct pci_device_id serial
 	{	PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_2_OX_IBM,
 		PCI_SUBVENDOR_ID_IBM, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_2_3906250 },
+	/*
+	 * EndRun Technologies. PCI express device range.
+	 * EndRun PTP/1588 has 2 Native UARTs utilizing OxSemi 952.
+	 */
+	{	PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_3906250 },
 
 	/*
 	 * SBS Technologies, Inc. P-Octal and PMC-OCTPRO cards,
