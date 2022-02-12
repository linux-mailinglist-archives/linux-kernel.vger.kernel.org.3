Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4694B33ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 09:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiBLIlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 03:41:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiBLIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:41:47 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F112826544;
        Sat, 12 Feb 2022 00:41:44 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E53F892009D; Sat, 12 Feb 2022 09:41:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E281F92009C;
        Sat, 12 Feb 2022 08:41:42 +0000 (GMT)
Date:   Sat, 12 Feb 2022 08:41:42 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] serial: 8250: Report which option to enable for blacklisted
 PCI devices
In-Reply-To: <alpine.DEB.2.21.2202052214360.34636@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2202062133570.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202052214360.34636@angie.orcam.me.uk>
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

Provide information in the kernel log as to what configuration option to 
enable for PCI UART devices that have been blacklisted in the generic 
PCI 8250 UART driver and which have a dedicated driver available to 
handle that has been disabled.  The rationale is there is no easy way 
for the user to map a specific PCI vendor:device pair to an individual 
dedicated driver while the generic driver has this information readily 
available and it will likely be confusing that the generic driver does 
not register such a port.

A message is then printed like:

serial 0000:04:00.3: ignoring port, enable SERIAL_8250_PERICOM to handle

when an affected device is encountered and the generic driver rejects it.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Hi,

 Verified in a simulated environment as obviously I don't have a Pericom 
device.

  Maciej
---
 drivers/tty/serial/8250/8250_pci.c |   67 ++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 27 deletions(-)

linux-serial-8250-pci-blacklist-config.diff
Index: linux-macro/drivers/tty/serial/8250/8250_pci.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/8250/8250_pci.c
+++ linux-macro/drivers/tty/serial/8250/8250_pci.c
@@ -3518,6 +3518,12 @@ static struct pciserial_board pci_boards
 	},
 };
 
+#define REPORT_CONFIG(option) \
+	(IS_ENABLED(CONFIG_##option) ? 0 : (kernel_ulong_t)&#option)
+#define REPORT_8250_CONFIG(option) \
+	(IS_ENABLED(CONFIG_SERIAL_8250_##option) ? \
+	 0 : (kernel_ulong_t)&"SERIAL_8250_"#option)
+
 static const struct pci_device_id blacklist[] = {
 	/* softmodems */
 	{ PCI_VDEVICE(AL, 0x5457), }, /* ALi Corporation M5457 AC'97 Modem */
@@ -3525,40 +3531,43 @@ static const struct pci_device_id blackl
 	{ PCI_DEVICE(0x1543, 0x3052), }, /* Si3052-based modem, default IDs */
 
 	/* multi-io cards handled by parport_serial */
-	{ PCI_DEVICE(0x4348, 0x7053), }, /* WCH CH353 2S1P */
-	{ PCI_DEVICE(0x4348, 0x5053), }, /* WCH CH353 1S1P */
-	{ PCI_DEVICE(0x1c00, 0x3250), }, /* WCH CH382 2S1P */
+	/* WCH CH353 2S1P */
+	{ PCI_DEVICE(0x4348, 0x7053), REPORT_CONFIG(PARPORT_SERIAL), },
+	/* WCH CH353 1S1P */
+	{ PCI_DEVICE(0x4348, 0x5053), REPORT_CONFIG(PARPORT_SERIAL), },
+	/* WCH CH382 2S1P */
+	{ PCI_DEVICE(0x1c00, 0x3250), REPORT_CONFIG(PARPORT_SERIAL), },
 
 	/* Intel platforms with MID UART */
-	{ PCI_VDEVICE(INTEL, 0x081b), },
-	{ PCI_VDEVICE(INTEL, 0x081c), },
-	{ PCI_VDEVICE(INTEL, 0x081d), },
-	{ PCI_VDEVICE(INTEL, 0x1191), },
-	{ PCI_VDEVICE(INTEL, 0x18d8), },
-	{ PCI_VDEVICE(INTEL, 0x19d8), },
+	{ PCI_VDEVICE(INTEL, 0x081b), REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x081c), REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x081d), REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x1191), REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x18d8), REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x19d8), REPORT_8250_CONFIG(MID), },
 
 	/* Intel platforms with DesignWare UART */
-	{ PCI_VDEVICE(INTEL, 0x0936), },
-	{ PCI_VDEVICE(INTEL, 0x0f0a), },
-	{ PCI_VDEVICE(INTEL, 0x0f0c), },
-	{ PCI_VDEVICE(INTEL, 0x228a), },
-	{ PCI_VDEVICE(INTEL, 0x228c), },
-	{ PCI_VDEVICE(INTEL, 0x4b96), },
-	{ PCI_VDEVICE(INTEL, 0x4b97), },
-	{ PCI_VDEVICE(INTEL, 0x4b98), },
-	{ PCI_VDEVICE(INTEL, 0x4b99), },
-	{ PCI_VDEVICE(INTEL, 0x4b9a), },
-	{ PCI_VDEVICE(INTEL, 0x4b9b), },
-	{ PCI_VDEVICE(INTEL, 0x9ce3), },
-	{ PCI_VDEVICE(INTEL, 0x9ce4), },
+	{ PCI_VDEVICE(INTEL, 0x0936), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x0f0a), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x0f0c), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x228a), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x228c), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b96), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b97), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b98), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b99), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b9a), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b9b), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x9ce3), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x9ce4), REPORT_8250_CONFIG(LPSS), },
 
 	/* Exar devices */
-	{ PCI_VDEVICE(EXAR, PCI_ANY_ID), },
-	{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), },
+	{ PCI_VDEVICE(EXAR, PCI_ANY_ID), REPORT_8250_CONFIG(EXAR), },
+	{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), REPORT_8250_CONFIG(EXAR), },
 
 	/* Pericom devices */
-	{ PCI_VDEVICE(PERICOM, PCI_ANY_ID), },
-	{ PCI_VDEVICE(ACCESSIO, PCI_ANY_ID), },
+	{ PCI_VDEVICE(PERICOM, PCI_ANY_ID), REPORT_8250_CONFIG(PERICOM), },
+	{ PCI_VDEVICE(ACCESSIO, PCI_ANY_ID), REPORT_8250_CONFIG(PERICOM), },
 
 	/* End of the black list */
 	{ }
@@ -3840,8 +3849,12 @@ pciserial_init_one(struct pci_dev *dev,
 	board = &pci_boards[ent->driver_data];
 
 	exclude = pci_match_id(blacklist, dev);
-	if (exclude)
+	if (exclude) {
+		if (exclude->driver_data)
+			pci_warn(dev, "ignoring port, enable %s to handle\n",
+				 (const char *)exclude->driver_data);
 		return -ENODEV;
+	}
 
 	rc = pcim_enable_device(dev);
 	pci_save_state(dev);
