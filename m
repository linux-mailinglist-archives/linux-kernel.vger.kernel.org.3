Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623114B33EA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 09:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiBLImH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 03:42:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiBLImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:42:00 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21B292656A;
        Sat, 12 Feb 2022 00:41:54 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4212B92009D; Sat, 12 Feb 2022 09:41:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3EBCB92009B;
        Sat, 12 Feb 2022 08:41:53 +0000 (GMT)
Date:   Sat, 12 Feb 2022 08:41:53 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mike Skoog <mskoog@endruntechnologies.com>,
        Mike Korreng <mkorreng@endruntechnologies.com>,
        info@endruntechnologies.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] serial: 8250: Fold EndRun device support into OxSemi
 Tornado code
In-Reply-To: <alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2202111124110.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk>
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
detection.  Also correct the baud base like with commit 6cbe45d8ac93
("serial: 8250: Correct the clock for OxSemi PCIe devices") for the
value of 3906250 rather than 4000000, obtained by dividing the 62.5MHz
clock input by the default oversampling rate of 16.  Finally move the
EndRun vendor:device ID to <linux/pci_ids.h>.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 1bc8cde46a159 ("8250_pci: Added driver for Endrun Technologies PTP PCIe card.")
---
 drivers/tty/serial/8250/8250_pci.c |   79 +++++++++++--------------------------
 include/linux/pci_ids.h            |    3 +
 2 files changed, 28 insertions(+), 54 deletions(-)

Index: linux-macro/drivers/tty/serial/8250/8250_pci.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/8250/8250_pci.c
+++ linux-macro/drivers/tty/serial/8250/8250_pci.c
@@ -994,41 +994,26 @@ static void pci_ite887x_exit(struct pci_
 }
 
 /*
- * EndRun Technologies.
- * Determine the number of ports available on the device.
+ * Oxford Semiconductor Inc.
+ * Check if an OxSemi device is part of the Tornado range of devices.
  */
-#define PCI_VENDOR_ID_ENDRUN			0x7401
-#define PCI_DEVICE_ID_ENDRUN_1588	0xe100
-
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
@@ -1036,9 +1021,7 @@ static int pci_oxsemi_tornado_init(struc
 	unsigned long deviceID;
 	unsigned int  number_uarts = 0;
 
-	/* OxSemi Tornado devices are all 0xCxxx */
-	if (dev->vendor == PCI_VENDOR_ID_OXSEMI &&
-	    (dev->device & 0xF000) != 0xC000)
+	if (!pci_oxsemi_tornado_p(dev))
 		return 0;
 
 	p = pci_iomap(dev, 0, 5);
@@ -1049,7 +1032,10 @@ static int pci_oxsemi_tornado_init(struc
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
@@ -2244,7 +2230,7 @@ static struct pci_serial_quirk pci_seria
 		.device		= PCI_ANY_ID,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.init		= pci_endrun_init,
+		.init		= pci_oxsemi_tornado_init,
 		.setup		= pci_default_setup,
 	},
 	/*
@@ -2667,7 +2653,6 @@ enum pci_board_num_t {
 	pbn_panacom2,
 	pbn_panacom4,
 	pbn_plx_romulus,
-	pbn_endrun_2_4000000,
 	pbn_oxsemi,
 	pbn_oxsemi_1_3906250,
 	pbn_oxsemi_2_3906250,
@@ -3190,20 +3175,6 @@ static struct pciserial_board pci_boards
 	},
 
 	/*
-	 * EndRun Technologies
-	* Uses the size of PCI Base region 0 to
-	* signal now many ports are available
-	* 2 port 952 Uart support
-	*/
-	[pbn_endrun_2_4000000] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 2,
-		.base_baud	= 4000000,
-		.uart_offset	= 0x200,
-		.first_offset	= 0x1000,
-	},
-
-	/*
 	 * This board uses the size of PCI Base region 0 to
 	 * signal now many ports are available
 	 */
@@ -4123,13 +4094,6 @@ static const struct pci_device_id serial
 		0x10b5, 0x106a, 0, 0,
 		pbn_plx_romulus },
 	/*
-	* EndRun Technologies. PCI express device range.
-	*    EndRun PTP/1588 has 2 Native UARTs.
-	*/
-	{	PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_endrun_2_4000000 },
-	/*
 	 * Quatech cards. These actually have configurable clocks but for
 	 * now we just use the default.
 	 *
@@ -4390,6 +4354,13 @@ static const struct pci_device_id serial
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
Index: linux-macro/include/linux/pci_ids.h
===================================================================
--- linux-macro.orig/include/linux/pci_ids.h
+++ linux-macro/include/linux/pci_ids.h
@@ -2614,6 +2614,9 @@
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
+#define PCI_VENDOR_ID_ENDRUN		0x7401
+#define PCI_DEVICE_ID_ENDRUN_1588	0xe100
+
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
