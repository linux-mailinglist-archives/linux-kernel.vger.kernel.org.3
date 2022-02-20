Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79BF4BD286
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 00:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiBTW7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 17:59:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiBTW7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 17:59:37 -0500
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Feb 2022 14:59:10 PST
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE1E844777;
        Sun, 20 Feb 2022 14:59:10 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 08C8F7A037A;
        Sun, 20 Feb 2022 23:49:36 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pata_parport: second preview
Date:   Sun, 20 Feb 2022 23:49:09 +0100
Message-Id: <20220220224909.8032-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
here's a second version of pata_parport. Now a complete patch with protocol
drivers (cleaned up coding style).

The device model is complete now (pata_parport bus, protocol drivers and
manually created devices). Devices can also be deleted:
# echo pata_parport.0 > /sys/bus/pata_parport/delete_device 

Protocol registration could be improved - I don't like protocols[] and
protocol numbers, devices should probably be created by protocol name.
Also the LPT port base addresses should probably be replaced by port names
(like parport0).

The bpck driver seems to need to know if a CD drive is attached (weird) but
I doubt that I can get such info from libata.

I haven't tested other devices yet, only the Imation SuperDisk drive:

[ 4297.947270] paride: epat registered as protocol 0
[ 4302.019782] pata_parport pata_parport.0: 0x378 is parport0
[ 4302.030573] pata_parport pata_parport.0: epat: port 0x378, mode 0, ccr 0, test=(0,256,0)
[ 4302.030587] pata_parport pata_parport.0: Sharing parport0 at 0x378
[ 4302.030719] pata_parport pata_parport.0: epat, Shuttle EPAT chip c6 at 0x378, mode 0 (4-bit), delay 0
[ 4302.062891] scsi host4: pata_parport-epat
[ 4302.063036] ata6: PATA max PIO0 port parport0 protocol epat
[ 4302.277720] ata6.00: ATAPI: LS-120 COSM   04              UHD Floppy, 0270M09T, max PIO2
[ 4302.358986] scsi 4:0:0:0: Direct-Access     MATSHITA LS-120 COSM   04 0270 PQ: 0 ANSI: 5
[ 4302.394406] sd 4:0:0:0: Attached scsi generic sg1 type 0
[ 4302.429152] sd 4:0:0:0: [sdb] Media removed, stopped polling
[ 4302.461007] sd 4:0:0:0: [sdb] Attached SCSI removable disk


---
 drivers/ata/Kconfig                     |  25 +
 drivers/ata/Makefile                    |   2 +
 drivers/ata/pata_parport/Kconfig        | 189 ++++++
 drivers/ata/pata_parport/Makefile       |  24 +
 drivers/ata/pata_parport/aten.c         | 139 +++++
 drivers/ata/pata_parport/bpck.c         | 481 +++++++++++++++
 drivers/ata/pata_parport/bpck6.c        | 164 +++++
 drivers/ata/pata_parport/comm.c         | 198 ++++++
 drivers/ata/pata_parport/dstr.c         | 226 +++++++
 drivers/ata/pata_parport/epat.c         | 320 ++++++++++
 drivers/ata/pata_parport/epia.c         | 308 ++++++++++
 drivers/ata/pata_parport/fit2.c         | 135 +++++
 drivers/ata/pata_parport/fit3.c         | 195 ++++++
 drivers/ata/pata_parport/friq.c         | 263 ++++++++
 drivers/ata/pata_parport/frpw.c         | 292 +++++++++
 drivers/ata/pata_parport/kbic.c         | 292 +++++++++
 drivers/ata/pata_parport/ktti.c         | 112 ++++
 drivers/ata/pata_parport/on20.c         | 136 +++++
 drivers/ata/pata_parport/on26.c         | 302 +++++++++
 drivers/ata/pata_parport/pata_parport.c | 773 ++++++++++++++++++++++++
 drivers/ata/pata_parport/pata_parport.h | 114 ++++
 drivers/ata/pata_parport/ppc6lnx.c      | 486 +++++++++++++++
 22 files changed, 5176 insertions(+)
 create mode 100644 drivers/ata/pata_parport/Kconfig
 create mode 100644 drivers/ata/pata_parport/Makefile
 create mode 100644 drivers/ata/pata_parport/aten.c
 create mode 100644 drivers/ata/pata_parport/bpck.c
 create mode 100644 drivers/ata/pata_parport/bpck6.c
 create mode 100644 drivers/ata/pata_parport/comm.c
 create mode 100644 drivers/ata/pata_parport/dstr.c
 create mode 100644 drivers/ata/pata_parport/epat.c
 create mode 100644 drivers/ata/pata_parport/epia.c
 create mode 100644 drivers/ata/pata_parport/fit2.c
 create mode 100644 drivers/ata/pata_parport/fit3.c
 create mode 100644 drivers/ata/pata_parport/friq.c
 create mode 100644 drivers/ata/pata_parport/frpw.c
 create mode 100644 drivers/ata/pata_parport/kbic.c
 create mode 100644 drivers/ata/pata_parport/ktti.c
 create mode 100644 drivers/ata/pata_parport/on20.c
 create mode 100644 drivers/ata/pata_parport/on26.c
 create mode 100644 drivers/ata/pata_parport/pata_parport.c
 create mode 100644 drivers/ata/pata_parport/pata_parport.h
 create mode 100644 drivers/ata/pata_parport/ppc6lnx.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cb54631fd950..de4548471398 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1161,6 +1161,31 @@ config PATA_WINBOND_VLB
 	  Support for the Winbond W83759A controller on Vesa Local Bus
 	  systems.
 
+config PATA_PARPORT
+	tristate "Parallel port IDE device support (PARIDE replacement)"
+	depends on PARPORT_PC
+	help
+	  There are many external CD-ROM and disk devices that connect through
+	  your computer's parallel port. Most of them are actually IDE devices
+	  using a parallel port IDE adapter. This option enables the PATA_PARPORT
+	  subsystem which contains drivers for many of these external drives.
+	  Read <file:Documentation/admin-guide/blockdev/paride.rst> for more information.
+
+	  If you have said Y to the "Parallel-port support" configuration
+	  option, you may share a single port between your printer and other
+	  parallel port devices. Answer Y to build PATA_PARPORT support into your
+	  kernel, or M if you would like to build it as a loadable module. If
+	  your parallel port support is in a loadable module, you must build
+	  PATA_PARPORT as a module. If you built PATA_PARPORT support into your kernel,
+	  you may still build the individual protocol modules as loadable
+	  modules. If you build this support as a module, it will be called pata_parport.
+
+	  Unlike the old PARIDE, there are no high-level drivers needed.
+	  The IDE devices behind parallel port adapters are handled by the
+	  ATA layer.
+
+source "drivers/ata/pata_parport/Kconfig"
+
 comment "Generic fallback / legacy drivers"
 
 config PATA_ACPI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b8aebfb14e82..bd6b5fdc004e 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -114,6 +114,8 @@ obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
 
 obj-$(CONFIG_PATA_PXA)		+= pata_pxa.o
 
+obj-$(CONFIG_PATA_PARPORT)	+= pata_parport/
+
 # Should be last but two libata driver
 obj-$(CONFIG_PATA_ACPI)		+= pata_acpi.o
 # Should be last but one libata driver
diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
new file mode 100644
index 000000000000..5d3440f372fc
--- /dev/null
+++ b/drivers/ata/pata_parport/Kconfig
@@ -0,0 +1,189 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# PATA_PARPORT configuration
+#
+# PATA_PARPORT doesn't need PARPORT, but if PARPORT is configured as a module,
+# PATA_PARPORT must also be a module.
+# PATA_PARPORT only supports PC style parports. Tough for USB or other parports...
+
+comment "Parallel IDE protocol modules"
+	depends on PATA_PARPORT
+
+config PATA_PARPORT_ATEN
+	tristate "ATEN EH-100 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the ATEN EH-100 parallel port IDE
+	  protocol. This protocol is used in some inexpensive low performance
+	  parallel port kits made in Hong Kong. If you chose to build PATA_PARPORT
+	  support into your kernel, you may answer Y here to build in the
+	  protocol driver, otherwise you should answer M to build it as a
+	  loadable module. The module will be called aten.
+
+config PATA_PARPORT_BPCK
+	tristate "MicroSolutions backpack (Series 5) protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the Micro Solutions BACKPACK
+	  parallel port Series 5 IDE protocol.  (Most BACKPACK drives made
+	  before 1999 were Series 5) Series 5 drives will NOT always have the
+	  Series noted on the bottom of the drive. Series 6 drivers will.
+
+	  In other words, if your BACKPACK drive doesn't say "Series 6" on the
+	  bottom, enable this option.
+
+	  If you chose to build PATA_PARPORT support into your kernel, you may
+	  answer Y here to build in the protocol driver, otherwise you should
+	  answer M to build it as a loadable module.  The module will be
+	  called bpck.
+
+config PATA_PARPORT_BPCK6
+	tristate "MicroSolutions backpack (Series 6) protocol"
+	depends on PATA_PARPORT && !64BIT
+	help
+	  This option enables support for the Micro Solutions BACKPACK
+	  parallel port Series 6 IDE protocol.  (Most BACKPACK drives made
+	  after 1999 were Series 6) Series 6 drives will have the Series noted
+	  on the bottom of the drive.  Series 5 drivers don't always have it
+	  noted.
+
+	  In other words, if your BACKPACK drive says "Series 6" on the
+	  bottom, enable this option.
+
+	  If you chose to build PATA_PARPORT support into your kernel, you may
+	  answer Y here to build in the protocol driver, otherwise you should
+	  answer M to build it as a loadable module.  The module will be
+	  called bpck6.
+
+config PATA_PARPORT_COMM
+	tristate "DataStor Commuter protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the Commuter parallel port IDE
+	  protocol from DataStor. If you chose to build PATA_PARPORT support
+	  into your kernel, you may answer Y here to build in the protocol
+	  driver, otherwise you should answer M to build it as a loadable
+	  module. The module will be called comm.
+
+config PATA_PARPORT_DSTR
+	tristate "DataStor EP-2000 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the EP-2000 parallel port IDE
+	  protocol from DataStor. If you chose to build PATA_PARPORT support
+	  into your kernel, you may answer Y here to build in the protocol
+	  driver, otherwise you should answer M to build it as a loadable
+	  module. The module will be called dstr.
+
+config PATA_PARPORT_FIT2
+	tristate "FIT TD-2000 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the TD-2000 parallel port IDE
+	  protocol from Fidelity International Technology. This is a simple
+	  (low speed) adapter that is used in some portable hard drives. If
+	  you chose to build PATA_PARPORT support into your kernel, you may answer Y
+	  here to build in the protocol driver, otherwise you should answer M
+	  to build it as a loadable module. The module will be called ktti.
+
+config PATA_PARPORT_FIT3
+	tristate "FIT TD-3000 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the TD-3000 parallel port IDE
+	  protocol from Fidelity International Technology. This protocol is
+	  used in newer models of their portable disk, CD-ROM and PD/CD
+	  devices. If you chose to build PATA_PARPORT support into your kernel, you
+	  may answer Y here to build in the protocol driver, otherwise you
+	  should answer M to build it as a loadable module. The module will be
+	  called fit3.
+
+config PATA_PARPORT_EPAT
+	tristate "Shuttle EPAT/EPEZ protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the EPAT parallel port IDE protocol.
+	  EPAT is a parallel port IDE adapter manufactured by Shuttle
+	  Technology and widely used in devices from major vendors such as
+	  Hewlett-Packard, SyQuest, Imation and Avatar. If you chose to build
+	  PATA_PARPORT support into your kernel, you may answer Y here to build in
+	  the protocol driver, otherwise you should answer M to build it as a
+	  loadable module. The module will be called epat.
+
+config PATA_PARPORT_EPIA
+	tristate "Shuttle EPIA protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the (obsolete) EPIA parallel port
+	  IDE protocol from Shuttle Technology. This adapter can still be
+	  found in some no-name kits. If you chose to build PATA_PARPORT support
+	  into your kernel, you may answer Y here to build in the protocol
+	  driver, otherwise you should answer M to build it as a loadable
+	  module. The module will be called epia.
+
+config PATA_PARPORT_FRIQ
+	tristate "Freecom IQ ASIC-2 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for version 2 of the Freecom IQ parallel
+	  port IDE adapter.  This adapter is used by the Maxell Superdisk
+	  drive.  If you chose to build PATA_PARPORT support into your kernel, you
+	  may answer Y here to build in the protocol driver, otherwise you
+	  should answer M to build it as a loadable module. The module will be
+	  called friq. You must also have a high-level driver for the type
+	  of device that you want to support.
+
+config PATA_PARPORT_FRPW
+	tristate "FreeCom power protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the Freecom power parallel port IDE
+	  protocol. If you chose to build PATA_PARPORT support into your kernel, you
+	  may answer Y here to build in the protocol driver, otherwise you
+	  should answer M to build it as a loadable module. The module will be
+	  called frpw.
+
+config PATA_PARPORT_KBIC
+	tristate "KingByte KBIC-951A/971A protocols"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the KBIC-951A and KBIC-971A parallel
+	  port IDE protocols from KingByte Information Corp. KingByte's
+	  adapters appear in many no-name portable disk and CD-ROM products,
+	  especially in Europe. If you chose to build PATA_PARPORT support into your
+	  kernel, you may answer Y here to build in the protocol driver,
+	  otherwise you should answer M to build it as a loadable module. The
+	  module will be called kbic.
+
+config PATA_PARPORT_KTTI
+	tristate "KT PHd protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the "PHd" parallel port IDE protocol
+	  from KT Technology. This is a simple (low speed) adapter that is
+	  used in some 2.5" portable hard drives. If you chose to build PATA_PARPORT
+	  support into your kernel, you may answer Y here to build in the
+	  protocol driver, otherwise you should answer M to build it as a
+	  loadable module. The module will be called ktti.
+
+config PATA_PARPORT_ON20
+	tristate "OnSpec 90c20 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the (obsolete) 90c20 parallel port
+	  IDE protocol from OnSpec (often marketed under the ValuStore brand
+	  name). If you chose to build PATA_PARPORT support into your kernel, you
+	  may answer Y here to build in the protocol driver, otherwise you
+	  should answer M to build it as a loadable module.The module will
+	  be called on20.
+
+config PATA_PARPORT_ON26
+	tristate "OnSpec 90c26 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the 90c26 parallel port IDE protocol
+	  from OnSpec Electronics (often marketed under the ValuStore brand
+	  name). If you chose to build PATA_PARPORT support into your kernel, you
+	  may answer Y here to build in the protocol driver, otherwise you
+	  should answer M to build it as a loadable module. The module will be
+	  called on26.
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
new file mode 100644
index 000000000000..fc6d3b60b63e
--- /dev/null
+++ b/drivers/ata/pata_parport/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Parallel port IDE device drivers.
+#
+# 7 October 2000, Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
+# Rewritten to use lists instead of if-statements.
+#
+
+obj-$(CONFIG_PATA_PARPORT)		+= pata_parport.o
+obj-$(CONFIG_PATA_PARPORT_ATEN)		+= aten.o
+obj-$(CONFIG_PATA_PARPORT_BPCK)		+= bpck.o
+obj-$(CONFIG_PATA_PARPORT_COMM)		+= comm.o
+obj-$(CONFIG_PATA_PARPORT_DSTR)		+= dstr.o
+obj-$(CONFIG_PATA_PARPORT_KBIC)		+= kbic.o
+obj-$(CONFIG_PATA_PARPORT_EPAT)		+= epat.o
+obj-$(CONFIG_PATA_PARPORT_EPIA)		+= epia.o
+obj-$(CONFIG_PATA_PARPORT_FRPW)		+= frpw.o
+obj-$(CONFIG_PATA_PARPORT_FRIQ)		+= friq.o
+obj-$(CONFIG_PATA_PARPORT_FIT2)		+= fit2.o
+obj-$(CONFIG_PATA_PARPORT_FIT3)		+= fit3.o
+obj-$(CONFIG_PATA_PARPORT_ON20)		+= on20.o
+obj-$(CONFIG_PATA_PARPORT_ON26)		+= on26.o
+obj-$(CONFIG_PATA_PARPORT_KTTI)		+= ktti.o
+obj-$(CONFIG_PATA_PARPORT_BPCK6)	+= bpck6.o
diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
new file mode 100644
index 000000000000..a811a471e942
--- /dev/null
+++ b/drivers/ata/pata_parport/aten.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	aten.c  (c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *			    Under the terms of the GNU General Public License.
+ *
+ *	aten.c is a low-level protocol driver for the ATEN EH-100
+ *	parallel port adapter.  The EH-100 supports 4-bit and 8-bit
+ *	modes only.  There is also an EH-132 which supports EPP mode
+ *	transfers.  The EH-132 is not yet supported.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/wait.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#define j44(a, b)		((((a >> 4) & 0x0f) | (b & 0xf0)) ^ 0x88)
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static int cont_map[2] = { 0x08, 0x20 };
+
+static void aten_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont] + 0x80;
+
+	w0(r); w2(0xe); w2(6); w0(val); w2(7); w2(6); w2(0xc);
+}
+
+static int aten_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b, r;
+
+	r = regr + cont_map[cont] + 0x40;
+
+	switch (pi->mode) {
+	case 0:
+		w0(r); w2(0xe); w2(6);
+		w2(7); w2(6); w2(0);
+		a = r1(); w0(0x10); b = r1(); w2(0xc);
+		return j44(a, b);
+	case 1:
+		r |= 0x10;
+		w0(r); w2(0xe); w2(6); w0(0xff);
+		w2(0x27); w2(0x26); w2(0x20);
+		a = r0();
+		w2(0x26); w2(0xc);
+		return a;
+	}
+	return -1;
+}
+
+static void aten_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int  k, a, b, c, d;
+
+	switch (pi->mode) {
+	case 0:
+		w0(0x48); w2(0xe); w2(6);
+		for (k = 0; k < count / 2; k++) {
+			w2(7); w2(6); w2(2);
+			a = r1(); w0(0x58); b = r1();
+			w2(0); d = r1(); w0(0x48); c = r1();
+			buf[2 * k] = j44(c, d);
+			buf[2 * k + 1] = j44(a, b);
+		}
+		w2(0xc);
+		break;
+	case 1:
+		w0(0x58); w2(0xe); w2(6);
+		for (k = 0; k < count / 2; k++) {
+			w2(0x27); w2(0x26); w2(0x22);
+			a = r0(); w2(0x20); b = r0();
+			buf[2 * k] = b; buf[2 * k + 1] = a;
+		}
+		w2(0x26); w2(0xc);
+		break;
+	}
+}
+
+static void aten_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	w0(0x88); w2(0xe); w2(6);
+	for (k = 0; k < count / 2; k++) {
+		w0(buf[2 * k + 1]); w2(0xe); w2(6);
+		w0(buf[2 * k]); w2(7); w2(6);
+	}
+	w2(0xc);
+}
+
+static void aten_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(0xc);
+}
+
+static void aten_disconnect(struct pi_adapter *pi)
+{
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void aten_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	char *mode_string[2] = { "4-bit", "8-bit" };
+
+	dev_info(&pi->dev, "aten, ATEN EH-100 at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol aten = {
+	.owner		= THIS_MODULE,
+	.name		= "aten",
+	.max_mode	= 2,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= aten_write_regr,
+	.read_regr	= aten_read_regr,
+	.write_block	= aten_write_block,
+	.read_block	= aten_read_block,
+	.connect	= aten_connect,
+	.disconnect	= aten_disconnect,
+	.log_adapter	= aten_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-aten") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(aten);
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
new file mode 100644
index 000000000000..f0cbe07ddce3
--- /dev/null
+++ b/drivers/ata/pata_parport/bpck.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	bpck.c	(c) 1996-8  Grant R. Guenther <grant@torque.net>
+ *			    Under the terms of the GNU General Public License.
+ *
+ *	bpck.c is a low-level protocol driver for the MicroSolutions
+ *	"backpack" parallel port IDE adapter.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#undef r2
+#undef w2
+#undef PC
+
+#define PC		pi->private
+#define r2()		(PC = (in_p(2) & 0xff))
+#define w2(byte)	{ out_p(2, byte); PC = byte; }
+#define t2(pat)		{ PC ^= pat; out_p(2, PC); }
+#define e2()		{ PC &= 0xfe; out_p(2, PC); }
+#define o2()		{ PC |= 1; out_p(2, PC); }
+
+#define j44(l, h)     (((l >> 3) & 0x7) | ((l >> 4) & 0x8) | ((h << 1) & 0x70) | (h & 0x80))
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ * cont = 2 - use internal bpck register addressing
+ */
+
+static int cont_map[3] = { 0x40, 0x48, 0 };
+
+static int bpck_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int r, l, h;
+
+	r = regr + cont_map[cont];
+
+	switch (pi->mode) {
+	case 0:
+		w0(r & 0xf); w0(r); t2(2); t2(4);
+		l = r1();
+		t2(4);
+		h = r1();
+		return j44(l, h);
+	case 1:
+		w0(r & 0xf); w0(r); t2(2);
+		e2(); t2(0x20);
+		t2(4); h = r0();
+		t2(1); t2(0x20);
+		return h;
+	case 2:
+	case 3:
+	case 4:
+		w0(r); w2(9); w2(0); w2(0x20);
+		h = r4();
+		w2(0);
+		return h;
+	}
+	return -1;
+}
+
+static void bpck_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont];
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		w0(r);
+		t2(2);
+		w0(val);
+		o2(); t2(4); t2(1);
+		break;
+	case 2:
+	case 3:
+	case 4:
+		w0(r); w2(9); w2(0);
+		w0(val); w2(1); w2(3); w2(0);
+		break;
+	}
+}
+
+/* These macros access the bpck registers in native addressing */
+#define WR(r, v)	bpck_write_regr(pi, 2, r, v)
+#define RR(r)		(bpck_read_regr(pi, 2, r))
+
+static void bpck_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int i;
+
+	switch (pi->mode) {
+	case 0:
+		WR(4, 0x40);
+		w0(0x40); t2(2); t2(1);
+		for (i = 0; i < count; i++) {
+			w0(buf[i]); t2(4);
+		}
+		WR(4, 0);
+		break;
+	case 1:
+		WR(4, 0x50);
+		w0(0x40); t2(2); t2(1);
+		for (i = 0; i < count; i++) {
+			w0(buf[i]); t2(4);
+		}
+		WR(4, 0x10);
+		break;
+	case 2:
+		WR(4, 0x48);
+		w0(0x40); w2(9); w2(0); w2(1);
+		for (i = 0; i < count; i++)
+			w4(buf[i]);
+		w2(0);
+		WR(4, 8);
+		break;
+	case 3:
+		WR(4, 0x48);
+		w0(0x40); w2(9); w2(0); w2(1);
+		for (i = 0; i < count / 2; i++)
+			w4w(((u16 *)buf)[i]);
+		w2(0);
+		WR(4, 8);
+		break;
+	case 4:
+		WR(4, 0x48);
+		w0(0x40); w2(9); w2(0); w2(1);
+		for (i = 0; i < count / 4; i++)
+			w4l(((u32 *)buf)[i]);
+		w2(0);
+		WR(4, 8);
+		break;
+	}
+}
+
+static void bpck_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int i, l, h;
+
+	switch (pi->mode) {
+	case 0:
+		WR(4, 0x40);
+		w0(0x40); t2(2);
+		for (i = 0; i < count; i++) {
+			t2(4); l = r1();
+			t2(4); h = r1();
+			buf[i] = j44(l, h);
+		}
+		WR(4, 0);
+		break;
+	case 1:
+		WR(4, 0x50);
+		w0(0x40); t2(2); t2(0x20);
+		for (i = 0; i < count; i++) {
+			t2(4); buf[i] = r0();
+		}
+		t2(1); t2(0x20);
+		WR(4, 0x10);
+		break;
+	case 2:
+		WR(4, 0x48);
+		w0(0x40); w2(9); w2(0); w2(0x20);
+		for (i = 0; i < count; i++)
+			buf[i] = r4();
+		w2(0);
+		WR(4, 8);
+		break;
+	case 3:
+		WR(4, 0x48);
+		w0(0x40); w2(9); w2(0); w2(0x20);
+		for (i = 0; i < count / 2; i++)
+			((u16 *)buf)[i] = r4w();
+		w2(0);
+		WR(4, 8);
+		break;
+	case 4:
+		WR(4, 0x48);
+		w0(0x40); w2(9); w2(0); w2(0x20);
+		for (i = 0; i < count / 4; i++)
+			((u32 *)buf)[i] = r4l();
+		w2(0);
+		WR(4, 8);
+		break;
+	}
+}
+
+static int bpck_probe_unit(struct pi_adapter *pi)
+{
+	int o1, o0, f7, id;
+	int t, s;
+
+	id = pi->unit;
+	s = 0;
+	w2(4); w2(0xe); r2(); t2(2);
+	o1 = r1() & 0xf8;
+	o0 = r0();
+	w0(255-id); w2(4); w0(id);
+	t2(8); t2(8); t2(8);
+	t2(2); t = r1() & 0xf8;
+	f7 = ((id % 8) == 7);
+	if ((f7) || (t != o1)) {
+		t2(2); s = r1() & 0xf8;
+	}
+	if ((t == o1) && ((!f7) || (s == o1)))  {
+		w2(0x4c); w0(o0);
+		return 0;
+	}
+	t2(8); w0(0); t2(2); w2(0x4c); w0(o0);
+	return 1;
+}
+
+static void bpck_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	w0(0xff-pi->unit); w2(4); w0(pi->unit);
+	t2(8); t2(8); t2(8);
+	t2(2); t2(2);
+
+	switch (pi->mode) {
+	case 0:
+		t2(8); WR(4, 0);
+		break;
+	case 1:
+		t2(8); WR(4, 0x10);
+		break;
+	case 2:
+	case 3:
+	case 4:
+		w2(0); WR(4, 8);
+		break;
+	}
+
+	WR(5, 8);
+
+	//// FIXE: devtype no longer exists
+//	if (pi->devtype == PI_PCD) {
+//		WR(0x46, 0x10);		/* fiddle with ESS logic ??? */
+//		WR(0x4c, 0x38);
+//		WR(0x4d, 0x88);
+//		WR(0x46, 0xa0);
+//		WR(0x41, 0);
+//		WR(0x4e, 8);
+//	}
+}
+
+static void bpck_disconnect(struct pi_adapter *pi)
+{
+	w0(0);
+	if (pi->mode >= 2) {
+		w2(9); w2(0);
+	} else
+		t2(2);
+	w2(0x4c); w0(pi->saved_r0);
+}
+
+/* This fakes the EPP protocol to turn off EPP ... */
+static void bpck_force_spp(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	w0(0xff-pi->unit); w2(4); w0(pi->unit);
+	t2(8); t2(8); t2(8);
+	t2(2); t2(2);
+
+	w2(0);
+	w0(4); w2(9); w2(0);
+	w0(0); w2(1); w2(3); w2(0);
+	w0(0); w2(9); w2(0);
+	w2(0x4c); w0(pi->saved_r0);
+}
+
+#define TEST_LEN  16
+
+static int bpck_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	int i, e, l, h, om;
+	char buf[TEST_LEN];
+
+	bpck_force_spp(pi);
+
+	switch (pi->mode) {
+	case 0:
+		bpck_connect(pi);
+		WR(0x13, 0x7f);
+		w0(0x13); t2(2);
+		for (i = 0; i < TEST_LEN; i++) {
+			t2(4); l = r1();
+			t2(4); h = r1();
+			buf[i] = j44(l, h);
+		}
+		bpck_disconnect(pi);
+		break;
+	case 1:
+		bpck_connect(pi);
+		WR(0x13, 0x7f);
+		w0(0x13); t2(2); t2(0x20);
+		for (i = 0; i < TEST_LEN; i++) {
+			t2(4); buf[i] = r0();
+		}
+		t2(1); t2(0x20);
+		bpck_disconnect(pi);
+		break;
+	case 2:
+	case 3:
+	case 4:
+		om = pi->mode;
+		pi->mode = 0;
+		bpck_connect(pi);
+		WR(7, 3);
+		WR(4, 8);
+		bpck_disconnect(pi);
+
+		pi->mode = om;
+		bpck_connect(pi);
+		w0(0x13); w2(9); w2(1); w0(0); w2(3); w2(0); w2(0xe0);
+
+		switch (pi->mode) {
+		case 2:
+			for (i = 0; i < TEST_LEN; i++)
+				buf[i] = r4();
+			break;
+		case 3:
+			for (i = 0; i < TEST_LEN / 2; i++)
+				((u16 *)buf)[i] = r4w();
+			break;
+		case 4:
+			for (i = 0; i < TEST_LEN / 4; i++)
+				((u32 *)buf)[i] = r4l();
+			break;
+		}
+
+		w2(0);
+		WR(7, 0);
+		bpck_disconnect(pi);
+
+		break;
+	}
+
+	if (verbose)
+		dev_info(&pi->dev, "bpck: 0x%x unit %d mode %d",
+		       pi->port, pi->unit, pi->mode);
+
+	e = 0;
+	for (i = 0; i < TEST_LEN; i++)
+		if (buf[i] != (i+1))
+			e++;
+	return e;
+}
+
+static void bpck_read_eeprom(struct pi_adapter *pi, char *buf)
+{
+	int i, j, k, p, v, f, om, od;
+
+	bpck_force_spp(pi);
+
+	om = pi->mode;  od = pi->delay;
+	pi->mode = 0; pi->delay = 6;
+
+	bpck_connect(pi);
+
+	WR(4, 0);
+	for (i = 0; i < 64; i++) {
+		WR(6, 8);
+		WR(6, 0xc);
+		p = 0x100;
+		for (k = 0; k < 9; k++) {
+			f = (((i + 0x180) & p) != 0) * 2;
+			WR(6, f + 0xc);
+			WR(6, f + 0xd);
+			WR(6, f + 0xc);
+			p = (p >> 1);
+		}
+		for (j = 0; j < 2; j++) {
+			v = 0;
+			for (k = 0; k < 8; k++) {
+				WR(6, 0xc);
+				WR(6, 0xd);
+				WR(6, 0xc);
+				f = RR(0);
+				v = 2 * v + (f == 0x84);
+			}
+			buf[2 * i + 1 - j] = v;
+		}
+	}
+	WR(6, 8);
+	WR(6, 0);
+	WR(5, 8);
+
+	bpck_disconnect(pi);
+
+	if (om >= 2) {
+		bpck_connect(pi);
+		WR(7, 3);
+		WR(4, 8);
+		bpck_disconnect(pi);
+	}
+
+	pi->mode = om; pi->delay = od;
+}
+
+static int bpck_test_port(struct pi_adapter *pi)	/* check for 8-bit port */
+{
+	int i, r, m;
+
+	w2(0x2c); i = r0(); w0(255-i); r = r0(); w0(i);
+	m = -1;
+	if (r == i)
+		m = 2;
+	if (r == (255-i))
+		m = 0;
+
+	w2(0xc); i = r0(); w0(255-i); r = r0(); w0(i);
+	if (r != (255-i))
+		m = -1;
+
+	if (m == 0) {
+		w2(6); w2(0xc); r = r0(); w0(0xaa); w0(r); w0(0xaa);
+	}
+	if (m == 2) {
+		w2(0x26); w2(0xc);
+	}
+
+	if (m == -1)
+		return 0;
+	return 5;
+}
+
+static void bpck_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = {
+		"4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
+
+#ifdef DUMP_EEPROM
+	int i;
+#endif
+
+	bpck_read_eeprom(pi, scratch);
+
+#ifdef DUMP_EEPROM
+	if (verbose) {
+		for (i = 0; i < 128; i++)
+			if ((scratch[i] < ' ') || (scratch[i] > '~'))
+				scratch[i] = '.';
+		dev_info(&pi->dev, "bpck EEPROM: %64.64s\n", scratch);
+		dev_info(&pi->dev, "	      %64.64s\n", &scratch[64]);
+	}
+#endif
+
+	dev_info(&pi->dev, "bpck, backpack %8.8s unit %d at 0x%x, mode %d (%s), delay %d\n",
+		&scratch[110], pi->unit, pi->port, pi->mode,
+		mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol bpck = {
+	.owner		= THIS_MODULE,
+	.name		= "bpck",
+	.max_mode	= 5,
+	.epp_first	= 2,
+	.default_delay	= 4,
+	.max_units	= 255,
+	.write_regr	= bpck_write_regr,
+	.read_regr	= bpck_read_regr,
+	.write_block	= bpck_write_block,
+	.read_block	= bpck_read_block,
+	.connect	= bpck_connect,
+	.disconnect	= bpck_disconnect,
+	.test_port	= bpck_test_port,
+	.probe_unit	= bpck_probe_unit,
+	.test_proto	= bpck_test_proto,
+	.log_adapter	= bpck_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-bpck") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(bpck);
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
new file mode 100644
index 000000000000..cd517c822ee2
--- /dev/null
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	backpack.c (c) 2001 Micro Solutions Inc.
+ *		Released under the terms of the GNU General Public license
+ *
+ *	backpack.c is a low-level protocol driver for the Micro Solutions
+ *		"BACKPACK" parallel port IDE adapter
+ *		(Works on Series 6 drives)
+ *
+ *	Written by: Ken Hahn     (linux-dev@micro-solutions.com)
+ *		    Clive Turvey (linux-dev@micro-solutions.com)
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/io.h>
+#include <linux/parport.h>
+
+#include "ppc6lnx.c"
+#include "pata_parport.h"
+
+#define PPCSTRUCT(pi) ((struct ppc_storage *)(pi->private))
+
+#define ATAPI_DATA       0      /* data port */
+
+static int bpck6_read_regr(struct pi_adapter *pi, int cont, int reg)
+{
+	unsigned int out;
+
+	/* check for bad settings */
+	if (reg < 0 || reg > 7 || cont < 0 || cont > 2)
+		return -1;
+	out = ppc6_rd_port(PPCSTRUCT(pi), cont ? reg | 8 : reg);
+	return out;
+}
+
+static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
+{
+	/* check for bad settings */
+	if (reg >= 0 && reg <= 7 && cont >= 0 && cont <= 1)
+		ppc6_wr_port(PPCSTRUCT(pi), cont ? reg | 8 : reg, (u8)val);
+}
+
+static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
+{
+	ppc6_wr_port16_blk(PPCSTRUCT(pi), ATAPI_DATA, buf, (u32)len >> 1);
+}
+
+static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
+{
+	ppc6_rd_port16_blk(PPCSTRUCT(pi), ATAPI_DATA, buf, (u32) len >> 1);
+}
+
+static void bpck6_connect(struct pi_adapter *pi)
+{
+	if (pi->mode >= 2)
+		PPCSTRUCT(pi)->mode = 4 + pi->mode - 2;
+	else if (pi->mode == 1)
+		PPCSTRUCT(pi)->mode = 3;
+	else
+		PPCSTRUCT(pi)->mode = 1;
+
+	ppc6_open(PPCSTRUCT(pi));
+	ppc6_wr_extout(PPCSTRUCT(pi), 0x3);
+}
+
+static void bpck6_disconnect(struct pi_adapter *pi)
+{
+	ppc6_wr_extout(PPCSTRUCT(pi), 0x0);
+	ppc6_close(PPCSTRUCT(pi));
+}
+
+static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
+{
+	/* copy over duplicate stuff.. initialize state info */
+	PPCSTRUCT(pi)->ppc_id = pi->unit;
+	PPCSTRUCT(pi)->lpt_addr = pi->port;
+
+	/* look at the parport device to see if what modes we can use */
+	if (((struct pardevice *)(pi->pardev))->port->modes &
+	    (PARPORT_MODE_EPP))
+		return 5; /* Can do EPP*/
+	else if (((struct pardevice *)(pi->pardev))->port->modes &
+		 (PARPORT_MODE_TRISTATE))
+		return 2;
+	else /* Just flat SPP */
+		return 1;
+}
+
+static int bpck6_probe_unit(struct pi_adapter *pi)
+{
+	int out;
+
+	/* SET PPC UNIT NUMBER */
+	PPCSTRUCT(pi)->ppc_id = pi->unit;
+
+	/* LOWER DOWN TO UNIDIRECTIONAL */
+	PPCSTRUCT(pi)->mode = 1;
+
+	out = ppc6_open(PPCSTRUCT(pi));
+
+	if (out) {
+		ppc6_close(PPCSTRUCT(pi));
+		return 1;
+	}
+
+	return 0;
+}
+
+static void bpck6_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = {
+		"4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
+
+	dev_info(&pi->dev, "bpck6, Micro Solutions BACKPACK Drive at 0x%x\n",
+		pi->port);
+	dev_info(&pi->dev, "Unit: %d Mode:%d (%s) Delay %d\n",
+		pi->unit, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static int bpck6_init_proto(struct pi_adapter *pi)
+{
+	struct ppc_storage *p = kzalloc(sizeof(struct ppc_storage), GFP_KERNEL);
+
+	if (p) {
+		pi->private = (unsigned long)p;
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+static void bpck6_release_proto(struct pi_adapter *pi)
+{
+	kfree((void *)(pi->private));
+}
+
+static struct pi_protocol bpck6 = {
+	.owner		= THIS_MODULE,
+	.name		= "bpck6",
+	.max_mode	= 5,
+	.epp_first	= 2, /* 2-5 use epp (need 8 ports) */
+	.max_units	= 255,
+	.write_regr	= bpck6_write_regr,
+	.read_regr	= bpck6_read_regr,
+	.write_block	= bpck6_write_block,
+	.read_block	= bpck6_read_block,
+	.connect	= bpck6_connect,
+	.disconnect	= bpck6_disconnect,
+	.test_port	= bpck6_test_port,
+	.probe_unit	= bpck6_probe_unit,
+	.log_adapter	= bpck6_log_adapter,
+	.init_proto	= bpck6_init_proto,
+	.release_proto	= bpck6_release_proto,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-bpck6") },
+};
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Micro Solutions Inc.");
+MODULE_DESCRIPTION("BACKPACK Protocol module, compatible with PARIDE");
+module_pata_parport_driver(bpck6);
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
new file mode 100644
index 000000000000..cca67e15b498
--- /dev/null
+++ b/drivers/ata/pata_parport/comm.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	comm.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *			      Under the terms of the GNU General Public License.
+ *
+ *	comm.c is a low-level protocol driver for some older models
+ *	of the DataStor "Commuter" parallel to IDE adapter.  Some of
+ *	the parallel port devices marketed by Arista currently
+ *	use this adapter.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+/* mode codes:  0  nybble reads, 8-bit writes
+ *		1  8-bit reads and writes
+ *		2  8-bit EPP mode
+ */
+
+#define j44(a, b)	(((a >> 3) & 0x0f) | ((b << 1) & 0xf0))
+
+#define P1	do { w2(5); w2(0xd); w2(0xd); w2(5); w2(4); } while (0)
+#define P2	do { w2(5); w2(7); w2(7); w2(5); w2(4); } while (0)
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static int cont_map[2] = { 0x08, 0x10 };
+
+static int comm_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int l, h, r;
+
+	r = regr + cont_map[cont];
+
+	switch (pi->mode)  {
+	case 0:
+		w0(r); P1; w0(0);
+		w2(6); l = r1(); w0(0x80); h = r1(); w2(4);
+		return j44(l, h);
+	case 1:
+		w0(r+0x20); P1;
+		w0(0); w2(0x26); h = r0(); w2(4);
+		return h;
+	case 2:
+	case 3:
+	case 4:
+		w3(r+0x20); (void)r1();
+		w2(0x24); h = r4(); w2(4);
+		return h;
+	}
+	return -1;
+}
+
+static void comm_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont];
+
+	switch (pi->mode)  {
+	case 0:
+	case 1:
+		w0(r); P1; w0(val); P2;
+		break;
+	case 2:
+	case 3:
+	case 4:
+		w3(r); (void)r1(); w4(val);
+		break;
+	}
+}
+
+static void comm_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(4); w0(0xff); w2(6);
+	w2(4); w0(0xaa); w2(6);
+	w2(4); w0(0x00); w2(6);
+	w2(4); w0(0x87); w2(6);
+	w2(4); w0(0xe0); w2(0xc); w2(0xc); w2(4);
+}
+
+static void comm_disconnect(struct pi_adapter *pi)
+{
+	w2(0); w2(0); w2(0); w2(4);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void comm_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int i, l, h;
+
+	switch (pi->mode) {
+	case 0:
+		w0(0x48); P1;
+		for (i = 0; i < count; i++) {
+			w0(0); w2(6); l = r1();
+			w0(0x80); h = r1(); w2(4);
+			buf[i] = j44(l, h);
+		}
+		break;
+	case 1:
+		w0(0x68); P1; w0(0);
+		for (i = 0; i < count; i++) {
+			w2(0x26); buf[i] = r0(); w2(0x24);
+		}
+		w2(4);
+		break;
+	case 2:
+		w3(0x68); (void)r1(); w2(0x24);
+		for (i = 0; i < count; i++)
+			buf[i] = r4();
+		w2(4);
+		break;
+	case 3:
+		w3(0x68); (void)r1(); w2(0x24);
+		for (i = 0; i < count / 2; i++)
+			((u16 *)buf)[i] = r4w();
+		w2(4);
+		break;
+	case 4:
+		w3(0x68); (void)r1(); w2(0x24);
+		for (i = 0; i < count / 4; i++)
+			((u32 *)buf)[i] = r4l();
+		w2(4);
+		break;
+	}
+}
+
+/* NB: Watch out for the byte swapped writes ! */
+static void comm_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		w0(0x68); P1;
+		for (k = 0; k < count; k++) {
+			w2(5); w0(buf[k^1]); w2(7);
+		}
+		w2(5); w2(4);
+		break;
+	case 2:
+		w3(0x48); (void)r1();
+		for (k = 0; k < count; k++)
+			w4(buf[k^1]);
+		break;
+	case 3:
+		w3(0x48); (void)r1();
+		for (k = 0; k < count / 2; k++)
+			w4w(pi_swab16(buf, k));
+		break;
+	case 4:
+		w3(0x48); (void)r1();
+		for (k = 0; k < count / 4; k++)
+			w4l(pi_swab32(buf, k));
+		break;
+	}
+}
+
+static void comm_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = {
+		"4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
+
+	dev_info(&pi->dev, "comm, DataStor Commuter at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol comm = {
+	.owner		= THIS_MODULE,
+	.name		= "comm",
+	.max_mode	= 5,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= comm_write_regr,
+	.read_regr	= comm_read_regr,
+	.write_block	= comm_write_block,
+	.read_block	= comm_read_block,
+	.connect	= comm_connect,
+	.disconnect	= comm_disconnect,
+	.log_adapter	= comm_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-comm") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(comm);
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
new file mode 100644
index 000000000000..2e1e078fa467
--- /dev/null
+++ b/drivers/ata/pata_parport/dstr.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	dstr.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *			      Under the terms of the GNU General Public License.
+ *
+ *	dstr.c is a low-level protocol driver for the
+ *	DataStor EP2000 parallel to IDE adapter chip.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+/* mode codes:  0  nybble reads, 8-bit writes
+ *		1  8-bit reads and writes
+ *		2  8-bit EPP mode
+ *		3  EPP-16
+ *		4  EPP-32
+ */
+
+#define j44(a, b)  (((a >> 3) & 0x07) | ((~a >> 4) & 0x08) | ((b << 1) & 0x70) | ((~b) & 0x80))
+
+#define P1	do { w2(5); w2(0xd); w2(5); w2(4); } while (0)
+#define P2	do { w2(5); w2(7); w2(5); w2(4); } while (0)
+#define P3      do { w2(6); w2(4); w2(6); w2(4); } while (0)
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static int cont_map[2] = { 0x20, 0x40 };
+
+static int dstr_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b, r;
+
+	r = regr + cont_map[cont];
+
+	w0(0x81); P1;
+	if (pi->mode)
+		w0(0x11);
+	else
+		w0(1);
+	P2; w0(r); P1;
+
+	switch (pi->mode) {
+	case 0:
+		w2(6); a = r1(); w2(4); w2(6); b = r1(); w2(4);
+		return j44(a, b);
+	case 1:
+		w0(0); w2(0x26); a = r0(); w2(4);
+		return a;
+	case 2:
+	case 3:
+	case 4:
+		w2(0x24); a = r4(); w2(4);
+		return a;
+	}
+	return -1;
+}
+
+static void dstr_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont];
+
+	w0(0x81); P1;
+	if (pi->mode >= 2)
+		w0(0x11);
+	else
+		w0(1);
+	P2; w0(r); P1;
+
+	switch (pi->mode)  {
+	case 0:
+	case 1:
+		w0(val); w2(5); w2(7); w2(5); w2(4);
+		break;
+	case 2:
+	case 3:
+	case 4:
+		w4(val);
+		break;
+	}
+}
+
+#define CCP(x)	do { w0(0xff); w2(0xc); w2(4);\
+		     w0(0xaa); w0(0x55); w0(0); w0(0xff); w0(0x87); w0(0x78);\
+		     w0(x); w2(5); w2(4);\
+		} while (0)
+
+static void dstr_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(4); CCP(0xe0); w0(0xff);
+}
+
+static void dstr_disconnect(struct pi_adapter *pi)
+{
+	CCP(0x30);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void dstr_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, a, b;
+
+	w0(0x81); P1;
+	if (pi->mode)
+		w0(0x19);
+	else
+		w0(9);
+	P2; w0(0x82); P1; P3; w0(0x20); P1;
+
+	switch (pi->mode) {
+	case 0:
+		for (k = 0; k < count; k++) {
+			w2(6); a = r1(); w2(4);
+			w2(6); b = r1(); w2(4);
+			buf[k] = j44(a, b);
+		}
+		break;
+	case 1:
+		w0(0);
+		for (k = 0; k < count; k++) {
+			w2(0x26); buf[k] = r0(); w2(0x24);
+		}
+		w2(4);
+		break;
+	case 2:
+		w2(0x24);
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(4);
+		break;
+	case 3:
+		w2(0x24);
+		for (k = 0; k < count / 2; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(4);
+		break;
+	case 4:
+		w2(0x24);
+		for (k = 0; k < count / 4; k++)
+			((u32 *)buf)[k] = r4l();
+		w2(4);
+		break;
+	}
+}
+
+static void dstr_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	w0(0x81); P1;
+	if (pi->mode)
+		w0(0x19);
+	else
+		w0(9);
+	P2; w0(0x82); P1; P3; w0(0x20); P1;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		for (k = 0; k < count; k++) {
+			w2(5); w0(buf[k]); w2(7);
+		}
+		w2(5); w2(4);
+		break;
+	case 2:
+		w2(0xc5);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
+		w2(0xc4);
+		break;
+	case 3:
+		w2(0xc5);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
+		w2(0xc4);
+		break;
+	case 4:
+		w2(0xc5);
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
+		w2(0xc4);
+		break;
+	}
+}
+
+
+static void dstr_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = {
+		"4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
+
+	dev_info(&pi->dev, "dstr, DataStor EP2000 at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol dstr = {
+	.owner		= THIS_MODULE,
+	.name		= "dstr",
+	.max_mode	= 5,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= dstr_write_regr,
+	.read_regr	= dstr_read_regr,
+	.write_block	= dstr_write_block,
+	.read_block	= dstr_read_block,
+	.connect	= dstr_connect,
+	.disconnect	= dstr_disconnect,
+	.log_adapter	= dstr_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-dstr") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(dstr);
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
new file mode 100644
index 000000000000..2103e272c82a
--- /dev/null
+++ b/drivers/ata/pata_parport/epat.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	epat.c  (c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *			    Under the terms of the GNU General Public License.
+ *
+ *	This is the low level protocol driver for the EPAT parallel
+ *	to IDE adapter from Shuttle Technologies.  This adapter is
+ *	used in many popular parallel port disk products such as the
+ *	SyQuest EZ drives, the Avatar Shark and the Imation SuperDisk.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#define j44(a, b)	(((a >> 4) & 0x0f) + (b & 0xf0))
+#define j53(a, b)	(((a >> 3) & 0x1f) + ((b << 4) & 0xe0))
+
+static int epatc8 = 1;
+module_param(epatc8, int, 0);
+MODULE_PARM_DESC(epatc8, "Support for the Shuttle EP1284 chip, used in any recent Imation SuperDisk (LS-120) drive (0=off, 1=on [default])");
+
+/* cont =  0   IDE register file
+ * cont =  1   IDE control registers
+ * cont =  2   internal EPAT registers
+ */
+
+static int cont_map[3] = { 0x18, 0x10, 0 };
+
+static void epat_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont];
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+	case 2:
+		w0(0x60+r); w2(1); w0(val); w2(4);
+		break;
+	case 3:
+	case 4:
+	case 5:
+		w3(0x40+r); w4(val);
+		break;
+	}
+}
+
+static int epat_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b, r;
+
+	r = regr + cont_map[cont];
+
+	switch (pi->mode) {
+	case 0:
+		w0(r); w2(1); w2(3);
+		a = r1(); w2(4); b = r1();
+		return j44(a, b);
+	case 1:
+		w0(0x40+r); w2(1); w2(4);
+		a = r1(); b = r2(); w0(0xff);
+		return j53(a, b);
+	case 2:
+		w0(0x20+r); w2(1); w2(0x25);
+		a = r0(); w2(4);
+		return a;
+	case 3:
+	case 4:
+	case 5:
+		w3(r); w2(0x24); a = r4(); w2(4);
+		return a;
+	}
+	return -1;	/* never gets here */
+}
+
+static void epat_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int  k, ph, a, b;
+
+	switch (pi->mode) {
+	case 0:
+		w0(7); w2(1); w2(3); w0(0xff);
+		ph = 0;
+		for (k = 0; k < count; k++) {
+			if (k == count-1)
+				w0(0xfd);
+			w2(6 + ph); a = r1();
+			if (a & 8)
+				b = a;
+			else {
+				w2(4+ph); b = r1();
+			}
+			buf[k] = j44(a, b);
+			ph =  1 - ph;
+		}
+		w0(0); w2(4);
+		break;
+	case 1:
+		w0(0x47); w2(1); w2(5); w0(0xff);
+		ph = 0;
+		for (k = 0; k < count; k++) {
+			if (k == count - 1)
+				w0(0xfd);
+			w2(4 + ph);
+			a = r1(); b = r2();
+			buf[k] = j53(a, b);
+			ph = 1 - ph;
+		}
+		w0(0); w2(4);
+		break;
+	case 2:
+		w0(0x27); w2(1); w2(0x25); w0(0);
+		ph = 0;
+		for (k = 0; k < count-1; k++) {
+			w2(0x24 + ph);
+			buf[k] = r0();
+			ph = 1 - ph;
+		}
+		w2(0x26); w2(0x27); buf[count - 1] = r0();
+		w2(0x25); w2(4);
+		break;
+	case 3:
+		w3(0x80); w2(0x24);
+		for (k = 0; k < count - 1; k++)
+			buf[k] = r4();
+		w2(4); w3(0xa0); w2(0x24); buf[count - 1] = r4();
+		w2(4);
+		break;
+	case 4:
+		w3(0x80); w2(0x24);
+		for (k = 0; k < (count / 2) - 1; k++)
+			((u16 *)buf)[k] = r4w();
+		buf[count - 2] = r4();
+		w2(4); w3(0xa0); w2(0x24); buf[count - 1] = r4();
+		w2(4);
+		break;
+	case 5:
+		w3(0x80); w2(0x24);
+		for (k = 0; k < (count / 4) - 1; k++)
+			((u32 *)buf)[k] = r4l();
+		for (k = count - 4; k < count - 1; k++)
+			buf[k] = r4();
+		w2(4); w3(0xa0); w2(0x24); buf[count - 1] = r4();
+		w2(4);
+		break;
+	}
+}
+
+static void epat_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int ph, k;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+	case 2:
+		w0(0x67); w2(1); w2(5);
+		ph = 0;
+		for (k = 0; k < count; k++) {
+			w0(buf[k]);
+			w2(4+ph);
+			ph = 1 - ph;
+		}
+		w2(7); w2(4);
+		break;
+	case 3:
+		w3(0xc0);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
+		w2(4);
+		break;
+	case 4:
+		w3(0xc0);
+		for (k = 0; k < (count/2); k++)
+			w4w(((u16 *)buf)[k]);
+		w2(4);
+		break;
+	case 5:
+		w3(0xc0);
+		for (k = 0; k < (count/4); k++)
+			w4l(((u32 *)buf)[k]);
+		w2(4);
+		break;
+	}
+}
+
+/* these macros access the EPAT registers in native addressing */
+#define	WR(r, v)	epat_write_regr(pi, 2, r, v)
+#define	RR(r)		(epat_read_regr(pi, 2, r))
+
+/* and these access the IDE task file */
+#define WRi(r, v)	epat_write_regr(pi, 0, r, v)
+#define RRi(r)		(epat_read_regr(pi, 0, r))
+
+/* FIXME:  the CPP stuff should be fixed to handle multiple EPATs on a chain */
+#define CPP(x)	do { w2(4); w0(0x22); w0(0xaa); w0(0x55); w0(0); w0(0xff);\
+		     w0(0x87); w0(0x78); w0(x); w2(4); w2(5); w2(4); w0(0xff);\
+		} while (0)
+
+static void epat_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+
+	/* Initialize the chip */
+	CPP(0);
+
+	if (epatc8) {
+		CPP(0x40); CPP(0xe0);
+		w0(0); w2(1); w2(4);
+		WR(0x8, 0x12); WR(0xc, 0x14); WR(0x12, 0x10);
+		WR(0xe, 0xf); WR(0xf, 4);
+		/* WR(0xe, 0xa); WR(0xf, 4); */
+		WR(0xe, 0xd); WR(0xf, 0);
+		/* CPP(0x30); */
+	}
+
+	/* Connect to the chip */
+	CPP(0xe0);
+	w0(0); w2(1); w2(4); /* Idle into SPP */
+	if (pi->mode >= 3) {
+		w0(0); w2(1); w2(4); w2(0xc);
+		/* Request EPP */
+		w0(0x40); w2(6); w2(7); w2(4); w2(0xc); w2(4);
+	}
+
+	if (!epatc8) {
+		WR(8, 0x10); WR(0xc, 0x14); WR(0xa, 0x38); WR(0x12, 0x10);
+	}
+}
+
+static void epat_disconnect(struct pi_adapter *pi)
+{
+	CPP(0x30);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static int epat_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	int k, j, f, cc;
+	int e[2] = { 0, 0 };
+
+	epat_connect(pi);
+	cc = RR(0xd);
+	epat_disconnect(pi);
+
+	epat_connect(pi);
+	for (j = 0; j < 2; j++) {
+		WRi(6, 0xa0 + j * 0x10);
+		for (k = 0; k < 256; k++) {
+			WRi(2, k ^ 0xaa);
+			WRi(3, k ^ 0x55);
+			if (RRi(2) != (k ^ 0xaa))
+				e[j]++;
+		}
+	}
+	epat_disconnect(pi);
+
+	f = 0;
+	epat_connect(pi);
+	WR(0x13, 1); WR(0x13, 0); WR(0xa, 0x11);
+	epat_read_block(pi, scratch, 512);
+
+	for (k = 0; k < 256; k++) {
+		if ((scratch[2 * k] & 0xff) != k)
+			f++;
+		if ((scratch[2 * k + 1] & 0xff) != (0xff - k))
+			f++;
+	}
+	epat_disconnect(pi);
+
+	if (verbose)
+		dev_info(&pi->dev, "epat: port 0x%x, mode %d, ccr %x, test=(%d,%d,%d)\n",
+			pi->port, pi->mode, cc, e[0], e[1], f);
+
+	return (e[0] && e[1]) || f;
+}
+
+static void epat_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	int ver;
+	static char * const mode_string[] = {
+		"4-bit", "5/3", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
+
+	epat_connect(pi);
+	WR(0xa, 0x38);		/* read the version code */
+	ver = RR(0xb);
+	epat_disconnect(pi);
+
+	dev_info(&pi->dev, "epat, Shuttle EPAT chip %x at 0x%x, mode %d (%s), delay %d\n",
+		ver, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol epat = {
+	.owner		= THIS_MODULE,
+	.name		= "epat",
+	.max_mode	= 6,
+	.epp_first	= 3,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= epat_write_regr,
+	.read_regr	= epat_read_regr,
+	.write_block	= epat_write_block,
+	.read_block	= epat_read_block,
+	.connect	= epat_connect,
+	.disconnect	= epat_disconnect,
+	.test_proto	= epat_test_proto,
+	.log_adapter	= epat_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-epat") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(epat);
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
new file mode 100644
index 000000000000..7f3db02fd243
--- /dev/null
+++ b/drivers/ata/pata_parport/epia.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	epia.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *			      Under the terms of the GNU General Public License.
+ *
+ *	epia.c is a low-level protocol driver for Shuttle Technologies
+ *	EPIA parallel to IDE adapter chip.  This device is now obsolete
+ *	and has been replaced with the EPAT chip, which is supported
+ *	by epat.c, however, some devices based on EPIA are still
+ *	available.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+/* mode codes:  0  nybble reads on port 1, 8-bit writes
+ *		1  5/3 reads on ports 1 & 2, 8-bit writes
+ *		2  8-bit reads and writes
+ *		3  8-bit EPP mode
+ *		4  16-bit EPP
+ *		5  32-bit EPP
+ */
+
+#define j44(a, b)	(((a >> 4) & 0x0f) + (b & 0xf0))
+#define j53(a, b)	(((a >> 3) & 0x1f) + ((b << 4) & 0xe0))
+
+/* cont =  0   IDE register file
+ * cont =  1   IDE control registers
+ */
+
+static int cont_map[2] = { 0, 0x80 };
+
+static int epia_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b, r;
+
+	regr += cont_map[cont];
+
+	switch (pi->mode)  {
+	case 0:
+		r = regr ^ 0x39;
+		w0(r); w2(1); w2(3); w0(r);
+		a = r1(); w2(1); b = r1(); w2(4);
+		return j44(a, b);
+	case 1:
+		r = regr ^ 0x31;
+		w0(r); w2(1); w0(r&0x37);
+		w2(3); w2(5); w0(r|0xf0);
+		a = r1(); b = r2(); w2(4);
+		return j53(a, b);
+	case 2:
+		r = regr ^ 0x29;
+		w0(r); w2(1); w2(0X21); w2(0x23);
+		a = r0(); w2(4);
+		return a;
+	case 3:
+	case 4:
+	case 5:
+		w3(regr); w2(0x24); a = r4(); w2(4);
+		return a;
+	}
+	return -1;
+}
+
+static void epia_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int  r;
+
+	regr += cont_map[cont];
+
+	switch (pi->mode)  {
+	case 0:
+	case 1:
+	case 2:
+		r = regr ^ 0x19;
+		w0(r); w2(1); w0(val); w2(3); w2(4);
+		break;
+	case 3:
+	case 4:
+	case 5:
+		r = regr ^ 0x40;
+		w3(r); w4(val); w2(4);
+		break;
+	}
+}
+
+#define WR(r, v)	epia_write_regr(pi, 0, r, v)
+#define RR(r)		(epia_read_regr(pi, 0, r))
+
+/* The use of register 0x84 is entirely unclear - it seems to control
+ * some EPP counters ...  currently we know about 3 different block
+ * sizes:  the standard 512 byte reads and writes, 12 byte writes and
+ * 2048 byte reads (the last two being used in the CDrom drivers.
+ */
+
+static void epia_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+
+	w2(4); w0(0xa0); w0(0x50); w0(0xc0); w0(0x30); w0(0xa0); w0(0);
+	w2(1); w2(4);
+	if (pi->mode >= 3) {
+		w0(0xa); w2(1); w2(4); w0(0x82); w2(4); w2(0xc); w2(4);
+		w2(0x24); w2(0x26); w2(4);
+	}
+	WR(0x86, 8);
+}
+
+static void epia_disconnect(struct pi_adapter *pi)
+{
+	/* WR(0x84, 0x10); */
+	w0(pi->saved_r0);
+	w2(1); w2(4);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void epia_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, ph, a, b;
+
+	switch (pi->mode) {
+	case 0:
+		w0(0x81); w2(1); w2(3); w0(0xc1);
+		ph = 1;
+		for (k = 0; k < count; k++) {
+			w2(2 + ph); a = r1();
+			w2(4 + ph); b = r1();
+			buf[k] = j44(a, b);
+			ph = 1 - ph;
+		}
+		w0(0); w2(4);
+		break;
+	case 1:
+		w0(0x91); w2(1); w0(0x10); w2(3);
+		w0(0x51); w2(5); w0(0xd1);
+		ph = 1;
+		for (k = 0; k < count; k++) {
+			w2(4 + ph);
+			a = r1(); b = r2();
+			buf[k] = j53(a, b);
+			ph = 1 - ph;
+		}
+		w0(0); w2(4);
+		break;
+	case 2:
+		w0(0x89); w2(1); w2(0x23); w2(0x21);
+		ph = 1;
+		for (k = 0; k < count; k++) {
+			w2(0x24 + ph);
+			buf[k] = r0();
+			ph = 1 - ph;
+		}
+		w2(6); w2(4);
+		break;
+	case 3:
+		if (count > 512)
+			WR(0x84, 3);
+		w3(0); w2(0x24);
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(4); WR(0x84, 0);
+		break;
+	case 4:
+		if (count > 512)
+			WR(0x84, 3);
+		w3(0); w2(0x24);
+		for (k = 0; k < count / 2; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(4); WR(0x84, 0);
+		break;
+	case 5:
+		if (count > 512)
+			WR(0x84, 3);
+		w3(0); w2(0x24);
+		for (k = 0; k < count / 4; k++)
+			((u32 *)buf)[k] = r4l();
+		w2(4); WR(0x84, 0);
+		break;
+	}
+}
+
+static void epia_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int ph, k, last, d;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+	case 2:
+		w0(0xa1); w2(1); w2(3); w2(1); w2(5);
+		ph = 0; last = 0x8000;
+		for (k = 0; k < count; k++) {
+			d = buf[k];
+			if (d != last) {
+				last = d; w0(d);
+			}
+			w2(4 + ph);
+			ph = 1 - ph;
+		}
+		w2(7); w2(4);
+		break;
+	case 3:
+		if (count < 512)
+			WR(0x84, 1);
+		w3(0x40);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
+		if (count < 512)
+			WR(0x84, 0);
+		break;
+	case 4:
+		if (count < 512)
+			WR(0x84, 1);
+		w3(0x40);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
+		if (count < 512)
+			WR(0x84, 0);
+		break;
+	case 5:
+		if (count < 512)
+			WR(0x84, 1);
+		w3(0x40);
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
+		if (count < 512)
+			WR(0x84, 0);
+		break;
+	}
+}
+
+static int epia_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	int j, k, f;
+	int e[2] = { 0, 0 };
+
+	epia_connect(pi);
+	for (j = 0; j < 2; j++) {
+		WR(6, 0xa0 + j * 0x10);
+		for (k = 0; k < 256; k++) {
+			WR(2, k ^ 0xaa);
+			WR(3, k ^ 0x55);
+			if (RR(2) != (k ^ 0xaa))
+				e[j]++;
+		}
+		WR(2, 1); WR(3, 1);
+	}
+	epia_disconnect(pi);
+
+	f = 0;
+	epia_connect(pi);
+	WR(0x84, 8);
+	epia_read_block(pi, scratch, 512);
+	for (k = 0; k < 256; k++) {
+		if ((scratch[2 * k] & 0xff) != ((k + 1) & 0xff))
+			f++;
+		if ((scratch[2 * k + 1] & 0xff) != ((-2 - k) & 0xff))
+			f++;
+	}
+	WR(0x84, 0);
+	epia_disconnect(pi);
+
+	if (verbose)
+		dev_info(&pi->dev, "epia: port 0x%x, mode %d, test=(%d,%d,%d)\n",
+			pi->port, pi->mode, e[0], e[1], f);
+
+	return (e[0] && e[1]) || f;
+}
+
+
+static void epia_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = {
+		"4-bit", "5/3", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
+
+	dev_info(&pi->dev, "epia, Shuttle EPIA at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol epia = {
+	.owner		= THIS_MODULE,
+	.name		= "epia",
+	.max_mode	= 6,
+	.epp_first	= 3,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= epia_write_regr,
+	.read_regr	= epia_read_regr,
+	.write_block	= epia_write_block,
+	.read_block	= epia_read_block,
+	.connect	= epia_connect,
+	.disconnect	= epia_disconnect,
+	.test_proto	= epia_test_proto,
+	.log_adapter	= epia_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-epia") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(epia);
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
new file mode 100644
index 000000000000..92cee479108c
--- /dev/null
+++ b/drivers/ata/pata_parport/fit2.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	fit2.c	(c) 1998  Grant R. Guenther <grant@torque.net>
+ *			  Under the terms of the GNU General Public License.
+ *
+ *	fit2.c is a low-level protocol driver for the older version
+ *	of the Fidelity International Technology parallel port adapter.
+ *	This adapter is used in their TransDisk 2000 and older TransDisk
+ *	3000 portable hard-drives.  As far as I can tell, this device
+ *	supports 4-bit mode _only_.
+ *
+ *	Newer models of the FIT products use an enhanced protocol.
+ *	The "fit3" protocol module should support current drives.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#define j44(a, b)	(((a >> 4) & 0x0f) | (b & 0xf0))
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ *
+ * NB:  The FIT adapter does not appear to use the control registers.
+ * So, we map ALT_STATUS to STATUS and NO-OP writes to the device
+ * control register - this means that IDE reset will not work on these
+ * devices.
+ */
+
+static void fit2_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	if (cont == 1)
+		return;
+	w2(0xc); w0(regr); w2(4); w0(val); w2(5); w0(0); w2(4);
+}
+
+static int fit2_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int  a, b, r;
+
+	if (cont) {
+		if (regr != 6)
+			return 0xff;
+		r = 7;
+	} else
+		r = regr + 0x10;
+
+	w2(0xc); w0(r); w2(4); w2(5);
+		 w0(0); a = r1();
+		 w0(1); b = r1();
+	w2(4);
+
+	return j44(a, b);
+}
+
+static void fit2_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, a, b, c, d;
+
+	w2(0xc); w0(0x10);
+
+	for (k = 0; k < count / 4; k++) {
+		w2(4); w2(5);
+		w0(0); a = r1(); w0(1); b = r1();
+		w0(3); c = r1(); w0(2); d = r1();
+		buf[4 * k + 0] = j44(a, b);
+		buf[4 * k + 1] = j44(d, c);
+
+		w2(4); w2(5);
+		       a = r1(); w0(3); b = r1();
+		w0(1); c = r1(); w0(0); d = r1();
+		buf[4 * k + 2] = j44(d, c);
+		buf[4 * k + 3] = j44(a, b);
+	}
+
+	w2(4);
+}
+
+static void fit2_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	w2(0xc); w0(0);
+	for (k = 0; k < count / 2; k++) {
+		w2(4); w0(buf[2 * k]);
+		w2(5); w0(buf[2 * k + 1]);
+	}
+	w2(4);
+}
+
+static void fit2_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(0xcc);
+}
+
+static void fit2_disconnect(struct pi_adapter *pi)
+{
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void fit2_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	dev_info(&pi->dev, "fit2, FIT 2000 adapter at 0x%x, delay %d\n",
+		pi->port, pi->delay);
+}
+
+static struct pi_protocol fit2 = {
+	.owner		= THIS_MODULE,
+	.name		= "fit2",
+	.max_mode	= 1,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= fit2_write_regr,
+	.read_regr	= fit2_read_regr,
+	.write_block	= fit2_write_block,
+	.read_block	= fit2_read_block,
+	.connect	= fit2_connect,
+	.disconnect	= fit2_disconnect,
+	.log_adapter	= fit2_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-fit2") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(fit2);
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
new file mode 100644
index 000000000000..7c874dc8b41b
--- /dev/null
+++ b/drivers/ata/pata_parport/fit3.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	fit3.c	(c) 1998  Grant R. Guenther <grant@torque.net>
+ *			  Under the terms of the GNU General Public License.
+ *
+ *	fit3.c is a low-level protocol driver for newer models
+ *	of the Fidelity International Technology parallel port adapter.
+ *	This adapter is used in their TransDisk 3000 portable
+ *	hard-drives, as well as CD-ROM, PD-CD and other devices.
+ *
+ *	The TD-2000 and certain older devices use a different protocol.
+ *	Try the fit2 protocol module with them.
+ *
+ *	NB:  The FIT adapters do not appear to support the control
+ *	registers.  So, we map ALT_STATUS to STATUS and NO-OP writes
+ *	to the device control register - this means that IDE reset
+ *	will not work on these devices.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#define j44(a, b)	(((a >> 3) & 0x0f) | ((b << 1) & 0xf0))
+
+#define w7(byte)	out_p(7, byte)
+#define r7()		(in_p(7) & 0xff)
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static void fit3_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	if (cont == 1)
+		return;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		w2(0xc); w0(regr); w2(0x8); w2(0xc);
+		w0(val); w2(0xd);
+		w0(0);   w2(0xc);
+		break;
+	case 2:
+		w2(0xc); w0(regr); w2(0x8); w2(0xc);
+		w4(val); w4(0);
+		w2(0xc);
+		break;
+	}
+}
+
+static int fit3_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b;
+
+	if (cont) {
+		if (regr != 6)
+			return 0xff;
+		regr = 7;
+	}
+
+	switch (pi->mode) {
+	case 0:
+		w2(0xc); w0(regr + 0x10); w2(0x8); w2(0xc);
+		w2(0xd); a = r1();
+		w2(0xf); b = r1();
+		w2(0xc);
+		return j44(a, b);
+	case 1:
+		w2(0xc); w0(regr + 0x90); w2(0x8); w2(0xc);
+		w2(0xec); w2(0xee); w2(0xef); a = r0();
+		w2(0xc);
+		return a;
+	case 2:
+		w2(0xc); w0(regr + 0x90); w2(0x8); w2(0xc);
+		w2(0xec);
+		a = r4(); b = r4();
+		w2(0xc);
+		return a;
+	}
+	return -1;
+}
+
+static void fit3_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, a, b, c, d;
+
+	switch (pi->mode) {
+	case 0:
+		w2(0xc); w0(0x10); w2(0x8); w2(0xc);
+		for (k = 0; k < count / 2; k++) {
+			w2(0xd); a = r1();
+			w2(0xf); b = r1();
+			w2(0xc); c = r1();
+			w2(0xe); d = r1();
+			buf[2 * k] = j44(a, b);
+			buf[2 * k + 1] = j44(c, d);
+		}
+		w2(0xc);
+		break;
+	case 1:
+		w2(0xc); w0(0x90); w2(0x8); w2(0xc);
+		w2(0xec); w2(0xee);
+		for (k = 0; k < count / 2; k++) {
+			w2(0xef); a = r0();
+			w2(0xee); b = r0();
+			buf[2 * k] = a;
+			buf[2 * k + 1] = b;
+		}
+		w2(0xec);
+		w2(0xc);
+		break;
+	case 2:
+		w2(0xc); w0(0x90); w2(0x8); w2(0xc);
+		w2(0xec);
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(0xc);
+		break;
+	}
+}
+
+static void fit3_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		w2(0xc); w0(0); w2(0x8); w2(0xc);
+		for (k = 0; k < count/2; k++) {
+			w0(buf[2 * k]); w2(0xd);
+			w0(buf[2 * k + 1]); w2(0xc);
+		}
+		break;
+	case 2:
+		w2(0xc); w0(0); w2(0x8); w2(0xc);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
+		w2(0xc);
+		break;
+	}
+}
+
+static void fit3_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(0xc); w0(0); w2(0xa);
+	if (pi->mode == 2) {
+		w2(0xc); w0(0x9); w2(0x8); w2(0xc);
+	}
+}
+
+static void fit3_disconnect(struct pi_adapter *pi)
+{
+	w2(0xc); w0(0xa); w2(0x8); w2(0xc);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void fit3_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = { "4-bit", "8-bit", "EPP" };
+
+	dev_info(&pi->dev, "fit3, FIT 3000 adapter at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol fit3 = {
+	.owner		= THIS_MODULE,
+	.name		= "fit3",
+	.max_mode	= 3,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= fit3_write_regr,
+	.read_regr	= fit3_read_regr,
+	.write_block	= fit3_write_block,
+	.read_block	= fit3_read_block,
+	.connect	= fit3_connect,
+	.disconnect	= fit3_disconnect,
+	.log_adapter	= fit3_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-fit3") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(fit3);
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
new file mode 100644
index 000000000000..73dabeb7c3d3
--- /dev/null
+++ b/drivers/ata/pata_parport/friq.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	friq.c	(c) 1998    Grant R. Guenther <grant@torque.net>
+ *			    Under the terms of the GNU General Public License
+ *
+ *	friq.c is a low-level protocol driver for the Freecom "IQ"
+ *	parallel port IDE adapter.   Early versions of this adapter
+ *	use the 'frpw' protocol.
+ *
+ *	Freecom uses this adapter in a battery powered external
+ *	CD-ROM drive.  It is also used in LS-120 drives by
+ *	Maxell and Panasonic, and other devices.
+ *
+ *	The battery powered drive requires software support to
+ *	control the power to the drive.  This module enables the
+ *	drive power when the high level driver (pcd) is loaded
+ *	and disables it when the module is unloaded.  Note, if
+ *	the friq module is built in to the kernel, the power
+ *	will never be switched off, so other means should be
+ *	used to conserve battery power.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#define CMD(x)	do { w2(4); w0(0xff); w0(0xff); w0(0x73); w0(0x73);\
+		     w0(0xc9); w0(0xc9); w0(0x26); w0(0x26); w0(x); w0(x);\
+		} while (0)
+
+#define j44(l, h)	(((l >> 4) & 0x0f) | (h & 0xf0))
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static int cont_map[2] = { 0x08, 0x10 };
+
+static int friq_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int h, l, r;
+
+	r = regr + cont_map[cont];
+
+	CMD(r);
+	w2(6); l = r1();
+	w2(4); h = r1();
+	w2(4);
+
+	return j44(l, h);
+
+}
+
+static void friq_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont];
+
+	CMD(r);
+	w0(val);
+	w2(5); w2(7); w2(5); w2(4);
+}
+
+static void friq_read_block_int(struct pi_adapter *pi, char *buf, int count, int regr)
+{
+	int h, l, k, ph;
+
+	switch (pi->mode) {
+
+	case 0:
+		CMD(regr);
+		for (k = 0; k < count; k++) {
+			w2(6); l = r1();
+			w2(4); h = r1();
+			buf[k] = j44(l, h);
+		}
+		w2(4);
+		break;
+	case 1:
+		ph = 2;
+		CMD(regr + 0xc0);
+		w0(0xff);
+		for (k = 0; k < count; k++) {
+			w2(0xa4 + ph);
+			buf[k] = r0();
+			ph = 2 - ph;
+		}
+		w2(0xac); w2(0xa4); w2(4);
+		break;
+	case 2:
+		CMD(regr + 0x80);
+		for (k = 0; k < count - 2; k++)
+			buf[k] = r4();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
+	case 3:
+		CMD(regr + 0x80);
+		for (k = 0; k < (count / 2) - 1; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
+	case 4:
+		CMD(regr + 0x80);
+		for (k = 0; k < (count / 4) - 1; k++)
+			((u32 *)buf)[k] = r4l();
+		buf[count - 4] = r4();
+		buf[count - 3] = r4();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
+	}
+}
+
+static void friq_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	friq_read_block_int(pi, buf, count, 0x08);
+}
+
+static void friq_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		CMD(8); w2(5);
+		for (k = 0; k < count; k++) {
+			w0(buf[k]);
+			w2(7); w2(5);
+		}
+		w2(4);
+		break;
+	case 2:
+		CMD(0xc8); w2(5);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
+		w2(4);
+		break;
+	case 3:
+		CMD(0xc8); w2(5);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
+		w2(4);
+		break;
+	case 4:
+		CMD(0xc8); w2(5);
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
+		w2(4);
+		break;
+	}
+}
+
+static void friq_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(4);
+}
+
+static void friq_disconnect(struct pi_adapter *pi)
+{
+	CMD(0x20);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static int friq_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	int j, k, r;
+	int e[2] = { 0, 0 };
+
+	pi->saved_r0 = r0();
+	w0(0xff); udelay(20); CMD(0x3d); /* turn the power on */
+	udelay(500);
+	w0(pi->saved_r0);
+
+	friq_connect(pi);
+	for (j = 0; j < 2; j++) {
+		friq_write_regr(pi, 0, 6, 0xa0 + j * 0x10);
+		for (k = 0; k < 256; k++) {
+			friq_write_regr(pi, 0, 2, k ^ 0xaa);
+			friq_write_regr(pi, 0, 3, k ^ 0x55);
+			if (friq_read_regr(pi, 0, 2) != (k ^ 0xaa))
+				e[j]++;
+		}
+	}
+	friq_disconnect(pi);
+
+	friq_connect(pi);
+	friq_read_block_int(pi, scratch, 512, 0x10);
+	r = 0;
+	for (k = 0; k < 128; k++)
+		if (scratch[k] != k)
+			r++;
+	friq_disconnect(pi);
+
+	if (verbose)
+		dev_info(&pi->dev, "friq: port 0x%x, mode %d, test=(%d,%d,%d)\n",
+			pi->port, pi->mode, e[0], e[1], r);
+
+	return (r || (e[0] && e[1]));
+}
+
+
+static void friq_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = {
+		"4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
+
+	dev_info(&pi->dev, "friq, Freecom IQ ASIC-2 adapter at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+
+	pi->private = 1;
+	friq_connect(pi);
+	CMD(0x9e);		/* disable sleep timer */
+	friq_disconnect(pi);
+}
+
+static void friq_release_proto(struct pi_adapter *pi)
+{
+	if (pi->private) {		/* turn off the power */
+		friq_connect(pi);
+		CMD(0x1d); CMD(0x1e);
+		friq_disconnect(pi);
+		pi->private = 0;
+	}
+}
+
+static struct pi_protocol friq = {
+	.owner		= THIS_MODULE,
+	.name		= "friq",
+	.max_mode	= 5,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= friq_write_regr,
+	.read_regr	= friq_read_regr,
+	.write_block	= friq_write_block,
+	.read_block	= friq_read_block,
+	.connect	= friq_connect,
+	.disconnect	= friq_disconnect,
+	.test_proto	= friq_test_proto,
+	.log_adapter	= friq_log_adapter,
+	.release_proto	= friq_release_proto,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-friq") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(friq);
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
new file mode 100644
index 000000000000..5151d3c26361
--- /dev/null
+++ b/drivers/ata/pata_parport/frpw.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	frpw.c	(c) 1996-8  Grant R. Guenther <grant@torque.net>
+ *			    Under the terms of the GNU General Public License
+ *
+ *	frpw.c is a low-level protocol driver for the Freecom "Power"
+ *	parallel port IDE adapter.
+ *
+ *	Some applications of this adapter may require a "printer" reset
+ *	prior to loading the driver.  This can be done by loading and
+ *	unloading the "lp" driver, or it can be done by this driver
+ *	if you define FRPW_HARD_RESET.  The latter is not recommended
+ *	as it may upset devices on other ports.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#define cec4		do { w2(0xc); w2(0xe); w2(0xe); w2(0xc); w2(4); w2(4); w2(4); } while (0)
+#define j44(l, h)	(((l >> 4) & 0x0f) | (h & 0xf0))
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static int cont_map[2] = { 0x08, 0x10 };
+
+static int frpw_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int h, l, r;
+
+	r = regr + cont_map[cont];
+
+	w2(4);
+	w0(r); cec4;
+	w2(6); l = r1();
+	w2(4); h = r1();
+	w2(4);
+
+	return j44(l, h);
+}
+
+static void frpw_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont];
+
+	w2(4); w0(r); cec4;
+	w0(val);
+	w2(5); w2(7); w2(5); w2(4);
+}
+
+static void frpw_read_block_int(struct pi_adapter *pi, char *buf, int count, int regr)
+{
+	int h, l, k, ph;
+
+	switch (pi->mode) {
+	case 0:
+		w2(4); w0(regr); cec4;
+		for (k = 0; k < count; k++) {
+			w2(6); l = r1();
+			w2(4); h = r1();
+			buf[k] = j44(l, h);
+		}
+		w2(4);
+		break;
+	case 1:
+		ph = 2;
+		w2(4); w0(regr + 0xc0); cec4;
+		w0(0xff);
+		for (k = 0; k < count; k++) {
+			w2(0xa4 + ph);
+			buf[k] = r0();
+			ph = 2 - ph;
+		}
+		w2(0xac); w2(0xa4); w2(4);
+		break;
+	case 2:
+		w2(4); w0(regr + 0x80); cec4;
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(0xac); w2(0xa4);
+		w2(4);
+		break;
+	case 3:
+		w2(4); w0(regr + 0x80); cec4;
+		for (k = 0; k < count - 2; k++)
+			buf[k] = r4();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
+	case 4:
+		w2(4); w0(regr + 0x80); cec4;
+		for (k = 0; k < (count / 2) - 1; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
+	case 5:
+		w2(4); w0(regr + 0x80); cec4;
+		for (k = 0; k < (count / 4) - 1; k++)
+			((u32 *)buf)[k] = r4l();
+		buf[count - 4] = r4();
+		buf[count - 3] = r4();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
+	}
+}
+
+static void frpw_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	frpw_read_block_int(pi, buf, count, 0x08);
+}
+
+static void frpw_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+	case 2:
+		w2(4); w0(8); cec4; w2(5);
+		for (k = 0; k < count; k++) {
+			w0(buf[k]);
+			w2(7); w2(5);
+		}
+		w2(4);
+		break;
+	case 3:
+		w2(4); w0(0xc8); cec4; w2(5);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
+		w2(4);
+		break;
+	case 4:
+		w2(4); w0(0xc8); cec4; w2(5);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
+		w2(4);
+		break;
+	case 5:
+		w2(4); w0(0xc8); cec4; w2(5);
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
+		w2(4);
+		break;
+	}
+}
+
+static void frpw_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(4);
+}
+
+static void frpw_disconnect(struct pi_adapter *pi)
+{
+	w2(4); w0(0x20); cec4;
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+/* Stub logic to see if PNP string is available - used to distinguish
+ * between the Xilinx and ASIC implementations of the Freecom adapter.
+ *
+ * returns chip_type:   0 = Xilinx, 1 = ASIC
+ */
+
+static int frpw_test_pnp(struct pi_adapter *pi)
+{
+	int olddelay, a, b;
+
+#ifdef FRPW_HARD_RESET
+	w0(0); w2(8); udelay(50); w2(0xc);   /* parallel bus reset */
+	mdelay(1500);
+#endif
+
+	olddelay = pi->delay;
+	pi->delay = 10;
+
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+
+	w2(4); w0(4); w2(6); w2(7);
+	a = r1() & 0xff; w2(4); b = r1() & 0xff;
+	w2(0xc); w2(0xe); w2(4);
+
+	pi->delay = olddelay;
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+
+	return ((~a & 0x40) && (b & 0x40));
+}
+
+/* We use the pi->private to remember the result of the PNP test.
+ * To make this work, private = port*2 + chip.  Yes, I know it's a hack :-(
+ */
+
+static int frpw_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	int j, k, r;
+	int e[2] = { 0, 0 };
+
+	if ((pi->private>>1) != pi->port)
+		pi->private = frpw_test_pnp(pi) + 2 * pi->port;
+
+	if (((pi->private % 2) == 0) && (pi->mode > 2)) {
+		if (verbose)
+			dev_info(&pi->dev, "frpw: Xilinx does not support mode %d\n",
+				pi->mode);
+		return 1;
+	}
+
+	if (((pi->private % 2) == 1) && (pi->mode == 2)) {
+		if (verbose)
+			dev_info(&pi->dev, "frpw: ASIC does not support mode 2\n");
+		return 1;
+	}
+
+	frpw_connect(pi);
+	for (j = 0; j < 2; j++) {
+		frpw_write_regr(pi, 0, 6, 0xa0 + j * 0x10);
+		for (k = 0; k < 256; k++) {
+			frpw_write_regr(pi, 0, 2, k ^ 0xaa);
+			frpw_write_regr(pi, 0, 3, k ^ 0x55);
+			if (frpw_read_regr(pi, 0, 2) != (k ^ 0xaa))
+				e[j]++;
+		}
+	}
+	frpw_disconnect(pi);
+
+	frpw_connect(pi);
+	frpw_read_block_int(pi, scratch, 512, 0x10);
+	r = 0;
+	for (k = 0; k < 128; k++)
+		if (scratch[k] != k)
+			r++;
+	frpw_disconnect(pi);
+
+	if (verbose)
+		dev_info(&pi->dev, "frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
+			pi->port, (pi->private % 2), pi->mode, e[0], e[1], r);
+
+	return (r || (e[0] && e[1]));
+}
+
+
+static void frpw_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = {
+		"4-bit", "8-bit", "EPP", "EPP-8", "EPP-16", "EPP-32" };
+
+	dev_info(&pi->dev, "frpw, Freecom (%s) adapter at 0x%x, mode %d (%s), delay %d\n",
+		((pi->private % 2) == 0) ? "Xilinx" : "ASIC", pi->port,
+		pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol frpw = {
+	.owner		= THIS_MODULE,
+	.name		= "frpw",
+	.max_mode	= 6,
+	.epp_first	= 2,
+	.default_delay	= 2,
+	.max_units	= 1,
+	.write_regr	= frpw_write_regr,
+	.read_regr	= frpw_read_regr,
+	.write_block	= frpw_write_block,
+	.read_block	= frpw_read_block,
+	.connect	= frpw_connect,
+	.disconnect	= frpw_disconnect,
+	.test_proto	= frpw_test_proto,
+	.log_adapter	= frpw_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-frpw") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(frpw);
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
new file mode 100644
index 000000000000..49f8a88db2a2
--- /dev/null
+++ b/drivers/ata/pata_parport/kbic.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	kbic.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *			      Under the terms of the GNU General Public License.
+ *
+ *	This is a low-level driver for the KBIC-951A and KBIC-971A
+ *	parallel to IDE adapter chips from KingByte Information Systems.
+ *
+ *	The chips are almost identical, however, the wakeup code
+ *	required for the 971A interferes with the correct operation of
+ *	the 951A, so this driver registers itself twice, once for
+ *	each chip.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#define r12w()		(delay_p, inw(pi->port + 1) & 0xffff)
+
+#define j44(a, b)	((((a >> 4) & 0x0f) | (b & 0xf0)) ^ 0x88)
+#define j53(w)		(((w >> 3) & 0x1f) | ((w >> 4) & 0xe0))
+
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static int cont_map[2] = { 0x80, 0x40 };
+
+static int kbic_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b, s;
+
+	s = cont_map[cont];
+
+	switch (pi->mode) {
+	case 0:
+		w0(regr | 0x18 | s); w2(4); w2(6); w2(4); w2(1); w0(8);
+		a = r1(); w0(0x28); b = r1(); w2(4);
+		return j44(a, b);
+	case 1:
+		w0(regr | 0x38 | s); w2(4); w2(6); w2(4); w2(5); w0(8);
+		a = r12w(); w2(4);
+		return j53(a);
+	case 2:
+		w0(regr | 0x08 | s); w2(4); w2(6); w2(4); w2(0xa5); w2(0xa1);
+		a = r0(); w2(4);
+		return a;
+	case 3:
+	case 4:
+	case 5:
+		w0(0x20 | s); w2(4); w2(6); w2(4); w3(regr);
+		a = r4(); b = r4(); w2(4); w2(0); w2(4);
+		return a;
+	}
+	return -1;
+}
+
+static void kbic_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int s = cont_map[cont];
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+	case 2:
+		w0(regr | 0x10 | s); w2(4); w2(6); w2(4);
+		w0(val); w2(5); w2(4);
+		break;
+	case 3:
+	case 4:
+	case 5:
+		w0(0x20 | s); w2(4); w2(6); w2(4); w3(regr);
+		w4(val); w4(val);
+		w2(4); w2(0); w2(4);
+		break;
+	}
+}
+
+static void k951_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(4);
+}
+
+static void k951_disconnect(struct pi_adapter *pi)
+{
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+#define	CCP(x)	do { w2(0xc4); w0(0xaa); w0(0x55); w0(0); w0(0xff); w0(0x87);\
+		     w0(0x78); w0(x); w2(0xc5); w2(0xc4); w0(0xff);\
+		} while (0)
+
+static void k971_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	CCP(0x20);
+	w2(4);
+}
+
+static void k971_disconnect(struct pi_adapter *pi)
+{
+	CCP(0x30);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+/* counts must be congruent to 0 MOD 4, but all known applications
+ * have this property.
+ */
+
+static void kbic_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, a, b;
+
+	switch (pi->mode) {
+	case 0:
+		w0(0x98); w2(4); w2(6); w2(4);
+		for (k = 0; k < count/2; k++) {
+			w2(1); w0(8);    a = r1();
+			       w0(0x28); b = r1();
+			buf[2 * k]   = j44(a, b);
+			w2(5);	   b = r1();
+			       w0(8);    a = r1();
+			buf[2 * k + 1] = j44(a, b);
+			w2(4);
+		}
+		break;
+	case 1:
+		w0(0xb8); w2(4); w2(6); w2(4);
+		for (k = 0; k < count / 4; k++) {
+			w0(0xb8);
+			w2(4); w2(5);
+			w0(8);    buf[4 * k]   = j53(r12w());
+			w0(0xb8); buf[4 * k + 1] = j53(r12w());
+			w2(4); w2(5);
+				  buf[4 * k + 3] = j53(r12w());
+			w0(8);    buf[4 * k + 2] = j53(r12w());
+		}
+		w2(4);
+		break;
+	case 2:
+		w0(0x88); w2(4); w2(6); w2(4);
+		for (k = 0; k < count / 2; k++) {
+			w2(0xa0); w2(0xa1); buf[2 * k] = r0();
+			w2(0xa5); buf[2 * k + 1] = r0();
+		}
+		w2(4);
+		break;
+	case 3:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(4); w2(0); w2(4);
+		break;
+	case 4:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		for (k = 0; k < count / 2; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(4); w2(0); w2(4);
+		break;
+	case 5:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		for (k = 0; k < count / 4; k++)
+			((u32 *)buf)[k] = r4l();
+		w2(4); w2(0); w2(4);
+		break;
+	}
+}
+
+static void kbic_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+	case 2:
+		w0(0x90); w2(4); w2(6); w2(4);
+		for (k = 0; k < count / 2; k++) {
+			w0(buf[2 * k + 1]); w2(0); w2(4);
+			w0(buf[2 * k]);   w2(5); w2(4);
+		}
+		break;
+	case 3:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		for (k = 0; k < count / 2; k++) {
+			w4(buf[2 * k + 1]);
+			w4(buf[2 * k]);
+		}
+		w2(4); w2(0); w2(4);
+		break;
+	case 4:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		for (k = 0; k < count / 2; k++)
+			w4w(pi_swab16(buf, k));
+		w2(4); w2(0); w2(4);
+		break;
+	case 5:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		for (k = 0; k < count / 4; k++)
+			w4l(pi_swab32(buf, k));
+		w2(4); w2(0); w2(4);
+		break;
+	}
+}
+
+static void kbic_log_adapter(struct pi_adapter *pi, char *scratch, int verbose, char *chip)
+{
+	static char * const mode_string[] = {
+		"4-bit", "5/3", "8-bit", "EPP-8", "EPP_16", "EPP-32"};
+
+	dev_info(&pi->dev, "kbic, KingByte %s at 0x%x, mode %d (%s), delay %d\n",
+		chip, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static void k951_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	kbic_log_adapter(pi, scratch, verbose, "KBIC-951A");
+}
+
+static void k971_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	kbic_log_adapter(pi, scratch, verbose, "KBIC-971A");
+}
+
+static struct pi_protocol k951 = {
+	.owner		= THIS_MODULE,
+	.name		= "k951",
+	.max_mode	= 6,
+	.epp_first	= 3,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= kbic_write_regr,
+	.read_regr	= kbic_read_regr,
+	.write_block	= kbic_write_block,
+	.read_block	= kbic_read_block,
+	.connect	= k951_connect,
+	.disconnect	= k951_disconnect,
+	.log_adapter	= k951_log_adapter,
+};
+
+static struct pi_protocol k971 = {
+	.owner		= THIS_MODULE,
+	.name		= "k971",
+	.max_mode	= 6,
+	.epp_first	= 3,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= kbic_write_regr,
+	.read_regr	= kbic_read_regr,
+	.write_block	= kbic_write_block,
+	.read_block	= kbic_read_block,
+	.connect	= k971_connect,
+	.disconnect	= k971_disconnect,
+	.log_adapter	= k971_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-kbic") },
+};
+
+static int __init kbic_init(void)
+{
+	int rv;
+
+	rv = pata_parport_register_driver(&k951);
+	if (rv < 0)
+		return rv;
+	rv = pata_parport_register_driver(&k971);
+	if (rv < 0)
+		pata_parport_unregister_driver(&k951);
+	return rv;
+}
+
+static void __exit kbic_exit(void)
+{
+	pata_parport_unregister_driver(&k951);
+	pata_parport_unregister_driver(&k971);
+}
+
+MODULE_LICENSE("GPL");
+module_init(kbic_init)
+module_exit(kbic_exit)
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
new file mode 100644
index 000000000000..4604bbd41b18
--- /dev/null
+++ b/drivers/ata/pata_parport/ktti.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	ktti.c	(c) 1998  Grant R. Guenther <grant@torque.net>
+ *			  Under the terms of the GNU General Public License.
+ *
+ *	ktti.c is a low-level protocol driver for the KT Technology
+ *	parallel port adapter.  This adapter is used in the "PHd"
+ *	portable hard-drives.  As far as I can tell, this device
+ *	supports 4-bit mode _only_.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#define j44(a, b)	(((a >> 4) & 0x0f) | (b & 0xf0))
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static int cont_map[2] = { 0x10, 0x08 };
+
+static void ktti_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont];
+
+	w0(r); w2(0xb); w2(0xa); w2(3); w2(6);
+	w0(val); w2(3); w0(0); w2(6); w2(0xb);
+}
+
+static int ktti_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int  a, b, r;
+
+	r = regr + cont_map[cont];
+
+	w0(r); w2(0xb); w2(0xa); w2(9); w2(0xc); w2(9);
+	a = r1(); w2(0xc);  b = r1(); w2(9); w2(0xc); w2(9);
+	return j44(a, b);
+}
+
+static void ktti_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int  k, a, b;
+
+	for (k = 0; k < count / 2; k++) {
+		w0(0x10); w2(0xb); w2(0xa); w2(9); w2(0xc); w2(9);
+		a = r1(); w2(0xc); b = r1(); w2(9);
+		buf[2 * k] = j44(a, b);
+		a = r1(); w2(0xc); b = r1(); w2(9);
+		buf[2 * k + 1] = j44(a, b);
+	}
+}
+
+static void ktti_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	for (k = 0; k < count / 2; k++) {
+		w0(0x10); w2(0xb); w2(0xa); w2(3); w2(6);
+		w0(buf[2 * k]); w2(3);
+		w0(buf[2 * k + 1]); w2(6);
+		w2(0xb);
+	}
+}
+
+static void ktti_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(0xb); w2(0xa); w0(0); w2(3); w2(6);
+}
+
+static void ktti_disconnect(struct pi_adapter *pi)
+{
+	w2(0xb); w2(0xa); w0(0xa0); w2(3); w2(4);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void ktti_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	dev_info(&pi->dev, "ktti, KT adapter at 0x%x, delay %d\n",
+		pi->port, pi->delay);
+}
+
+static struct pi_protocol ktti = {
+	.owner		= THIS_MODULE,
+	.name		= "ktti",
+	.max_mode	= 1,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= ktti_write_regr,
+	.read_regr	= ktti_read_regr,
+	.write_block	= ktti_write_block,
+	.read_block	= ktti_read_block,
+	.connect	= ktti_connect,
+	.disconnect	= ktti_disconnect,
+	.log_adapter	= ktti_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-ktti") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(ktti);
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
new file mode 100644
index 000000000000..2c0c6f9841dd
--- /dev/null
+++ b/drivers/ata/pata_parport/on20.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	on20.c	(c) 1996-8  Grant R. Guenther <grant@torque.net>
+ *			    Under the terms of the GNU General Public License.
+ *
+ *	on20.c is a low-level protocol driver for the
+ *	Onspec 90c20 parallel to IDE adapter.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#define op(f)	do { w2(4); w0(f); w2(5); w2(0xd); w2(5); w2(0xd); w2(5); w2(4); } while (0)
+#define vl(v)	do { w2(4); w0(v); w2(5); w2(7); w2(5); w2(4); } while (0)
+
+#define j44(a, b)	(((a >> 4) & 0x0f) | (b & 0xf0))
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static int on20_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int h, l, r;
+
+	r = (regr << 2) + 1 + cont;
+
+	op(1); vl(r); op(0);
+
+	switch (pi->mode)  {
+	case 0:
+		w2(4); w2(6); l = r1();
+		w2(4); w2(6); h = r1();
+		w2(4); w2(6); w2(4); w2(6); w2(4);
+		return j44(l, h);
+	case 1:
+		w2(4); w2(0x26); r = r0();
+		w2(4); w2(0x26); w2(4);
+		return r;
+
+	}
+	return -1;
+}
+
+static void on20_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = (regr << 2) + 1 + cont;
+
+	op(1); vl(r);
+	op(0); vl(val);
+	op(0); vl(val);
+}
+
+static void on20_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+
+	w2(4); w0(0); w2(0xc); w2(4); w2(6); w2(4); w2(6); w2(4);
+	if (pi->mode) {
+		op(2); vl(8); op(2); vl(9);
+	} else {
+		op(2); vl(0); op(2); vl(8);
+	}
+}
+
+static void on20_disconnect(struct pi_adapter *pi)
+{
+	w2(4); w0(7); w2(4); w2(0xc); w2(4);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void on20_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, l, h;
+
+	op(1); vl(1); op(0);
+
+	for (k = 0; k < count; k++)
+		if (pi->mode) {
+			w2(4); w2(0x26); buf[k] = r0();
+		} else {
+			w2(6); l = r1(); w2(4);
+			w2(6); h = r1(); w2(4);
+			buf[k] = j44(l, h);
+		}
+	w2(4);
+}
+
+static void on20_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	op(1); vl(1); op(0);
+
+	for (k = 0; k < count; k++) {
+		w2(5); w0(buf[k]); w2(7);
+	}
+	w2(4);
+}
+
+static void on20_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = { "4-bit", "8-bit" };
+
+	dev_info(&pi->dev, "on20, OnSpec 90c20 at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol on20 = {
+	.owner		= THIS_MODULE,
+	.name		= "on20",
+	.max_mode	= 2,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= on20_write_regr,
+	.read_regr	= on20_read_regr,
+	.write_block	= on20_write_block,
+	.read_block	= on20_read_block,
+	.connect	= on20_connect,
+	.disconnect	= on20_disconnect,
+	.log_adapter	= on20_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-on20") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(on20);
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
new file mode 100644
index 000000000000..1f224bb38b4a
--- /dev/null
+++ b/drivers/ata/pata_parport/on26.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	on26.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *			      Under the terms of the GNU General Public License.
+ *
+ *	on26.c is a low-level protocol driver for the
+ *	OnSpec 90c26 parallel to IDE adapter chip.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+/* mode codes:  0  nybble reads, 8-bit writes
+ *		1  8-bit reads and writes
+ *		2  8-bit EPP mode
+ *		3  EPP-16
+ *		4  EPP-32
+ */
+
+#define j44(a, b)  (((a >> 4) & 0x0f) | (b & 0xf0))
+
+#define P1	do { w2(5); w2(0xd); w2(5); w2(0xd); w2(5); w2(4); } while (0)
+#define P2	do { w2(5); w2(7); w2(5); w2(4); } while (0)
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static int on26_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b, r;
+
+	r = (regr << 2) + 1 + cont;
+
+	switch (pi->mode)  {
+	case 0:
+		w0(1); P1; w0(r); P2; w0(0); P1;
+		w2(6); a = r1(); w2(4);
+		w2(6); b = r1(); w2(4);
+		w2(6); w2(4); w2(6); w2(4);
+		return j44(a, b);
+	case 1:
+		w0(1); P1; w0(r); P2; w0(0); P1;
+		w2(0x26); a = r0(); w2(4); w2(0x26); w2(4);
+		return a;
+	case 2:
+	case 3:
+	case 4:
+		w3(1); w3(1); w2(5); w4(r); w2(4);
+		w3(0); w3(0); w2(0x24); a = r4(); w2(4);
+		w2(0x24); (void)r4(); w2(4);
+		return a;
+	}
+	return -1;
+}
+
+static void on26_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = (regr<<2) + 1 + cont;
+
+	switch (pi->mode)  {
+	case 0:
+	case 1:
+		w0(1); P1; w0(r); P2; w0(0); P1;
+		w0(val); P2; w0(val); P2;
+		break;
+	case 2:
+	case 3:
+	case 4:
+		w3(1); w3(1); w2(5); w4(r); w2(4);
+		w3(0); w3(0);
+		w2(5); w4(val); w2(4);
+		w2(5); w4(val); w2(4);
+		break;
+	}
+}
+
+#define CCP(x)	do { w0(0xfe); w0(0xaa); w0(0x55); w0(0); w0(0xff);\
+		     w0(0x87); w0(0x78); w0(x); w2(4); w2(5); w2(4); w0(0xff);\
+		} while (0)
+
+static void on26_connect(struct pi_adapter *pi)
+{
+	int x;
+
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+
+	CCP(0x20);
+	x = 8;
+	if (pi->mode)
+		x = 9;
+
+	w0(2); P1; w0(8); P2;
+	w0(2); P1; w0(x); P2;
+}
+
+static void on26_disconnect(struct pi_adapter *pi)
+{
+	if (pi->mode >= 2) {
+		w3(4); w3(4); w3(4); w3(4);
+	} else {
+		w0(4); P1; w0(4); P1;
+	}
+	CCP(0x30);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+#define	RESET_WAIT  200
+
+static int on26_test_port(struct pi_adapter *pi)  /* hard reset */
+{
+	int i, m, d, x = 0, y = 0;
+
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+
+	d = pi->delay;
+	m = pi->mode;
+	pi->delay = 5;
+	pi->mode = 0;
+
+	w2(0xc);
+
+	CCP(0x30); CCP(0);
+
+	w0(0xfe); w0(0xaa); w0(0x55); w0(0); w0(0xff);
+	i = ((r1() & 0xf0) << 4); w0(0x87);
+	i |= (r1() & 0xf0); w0(0x78);
+	w0(0x20); w2(4); w2(5);
+	i |= ((r1() & 0xf0) >> 4);
+	w2(4); w0(0xff);
+
+	if (i == 0xb5f) {
+		w0(2); P1; w0(0);   P2;
+		w0(3); P1; w0(0);   P2;
+		w0(2); P1; w0(8);   P2; udelay(100);
+		w0(2); P1; w0(0xa); P2; udelay(100);
+		w0(2); P1; w0(8);   P2; udelay(1000);
+
+		on26_write_regr(pi, 0, 6, 0xa0);
+
+		for (i = 0; i < RESET_WAIT; i++) {
+			on26_write_regr(pi, 0, 6, 0xa0);
+			x = on26_read_regr(pi, 0, 7);
+			on26_write_regr(pi, 0, 6, 0xb0);
+			y = on26_read_regr(pi, 0, 7);
+			if (!((x & 0x80) || (y & 0x80)))
+				break;
+			mdelay(100);
+		}
+
+		if (i == RESET_WAIT)
+			dev_err(&pi->dev, "on26: Device reset failed (%x,%x)\n", x, y);
+
+		w0(4); P1; w0(4); P1;
+	}
+
+	CCP(0x30);
+
+	pi->delay = d;
+	pi->mode = m;
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+
+	return 5;
+}
+
+
+static void on26_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, a, b;
+
+	switch (pi->mode) {
+	case 0:
+		w0(1); P1; w0(1); P2; w0(2); P1; w0(0x18); P2; w0(0); P1;
+		udelay(10);
+		for (k = 0; k < count; k++) {
+			w2(6); a = r1();
+			w2(4); b = r1();
+			buf[k] = j44(a, b);
+		}
+		w0(2); P1; w0(8); P2;
+		break;
+	case 1:
+		w0(1); P1; w0(1); P2; w0(2); P1; w0(0x19); P2; w0(0); P1;
+		udelay(10);
+		for (k = 0; k < count / 2; k++) {
+			w2(0x26); buf[2 * k] = r0();
+			w2(0x24); buf[2 * k + 1] = r0();
+		}
+		w0(2); P1; w0(9); P2;
+		break;
+	case 2:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
+		w3(0); w3(0); w2(0x24);
+		udelay(10);
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(4);
+		break;
+	case 3:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
+		w3(0); w3(0); w2(0x24);
+		udelay(10);
+		for (k = 0; k < count / 2; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(4);
+		break;
+	case 4:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
+		w3(0); w3(0); w2(0x24);
+		udelay(10);
+		for (k = 0; k < count / 4; k++)
+			((u32 *)buf)[k] = r4l();
+		w2(4);
+		break;
+	}
+}
+
+static void on26_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		w0(1); P1; w0(1); P2;
+		w0(2); P1; w0(0x18 + pi->mode); P2; w0(0); P1;
+		udelay(10);
+		for (k = 0; k < count / 2; k++) {
+			w2(5); w0(buf[2 * k]);
+			w2(7); w0(buf[2 * k + 1]);
+		}
+		w2(5); w2(4);
+		w0(2); P1; w0(8 + pi->mode); P2;
+		break;
+	case 2:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
+		w3(0); w3(0); w2(0xc5);
+		udelay(10);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
+		w2(0xc4);
+		break;
+	case 3:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
+		w3(0); w3(0); w2(0xc5);
+		udelay(10);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
+		w2(0xc4);
+		break;
+	case 4:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
+		w3(0); w3(0); w2(0xc5);
+		udelay(10);
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
+		w2(0xc4);
+		break;
+	}
+}
+
+static void on26_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = {
+		"4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
+
+	dev_info(&pi->dev, "on26, OnSpec 90c26 at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol on26 = {
+	.owner		= THIS_MODULE,
+	.name		= "on26",
+	.max_mode	= 5,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= on26_write_regr,
+	.read_regr	= on26_read_regr,
+	.write_block	= on26_write_block,
+	.read_block	= on26_read_block,
+	.connect	= on26_connect,
+	.disconnect	= on26_disconnect,
+	.test_port	= on26_test_port,
+	.log_adapter	= on26_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-on26") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(on26);
diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
new file mode 100644
index 000000000000..85e4b6124d3d
--- /dev/null
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -0,0 +1,773 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/parport.h>
+#include "pata_parport.h"
+
+#define DRV_NAME "pata_parport"
+
+#define MAX_PROTOS	32
+static struct pi_protocol *protocols[MAX_PROTOS];
+
+static struct bus_type pata_parport_bus_type = {
+	.name = DRV_NAME,
+};
+
+static struct device pata_parport_bus = {
+	.init_name = DRV_NAME,
+};
+
+static DEFINE_IDA(pata_parport_bus_dev_ids);
+
+/* functions taken from libata-sff.c and converted from direct port I/O */
+static unsigned int pata_parport_devchk(struct ata_port *ap, unsigned int device)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+	u8 nsect, lbal;
+
+	ap->ops->sff_dev_select(ap, device);
+
+	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
+	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
+
+	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
+	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
+
+	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
+	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
+
+	nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
+	lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
+
+	if ((nsect == 0x55) && (lbal == 0xaa))
+		return 1;	/* we found a device */
+
+	return 0;		/* nothing found */
+}
+
+static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
+				      unsigned long deadline)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+	/* software reset.  causes dev0 to be selected */
+	pi->proto->write_regr(pi, 1, 6, ap->ctl);
+	udelay(20);	/* FIXME: flush */
+	pi->proto->write_regr(pi, 1, 6, ap->ctl | ATA_SRST);
+	udelay(20);	/* FIXME: flush */
+	pi->proto->write_regr(pi, 1, 6, ap->ctl);
+	ap->last_ctl = ap->ctl;
+
+	/* wait the port to become ready */
+	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
+}
+
+static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
+				  unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
+	unsigned int devmask = 0;
+	int rc;
+	u8 err;
+
+	/* determine if device 0/1 are present */
+	if (pata_parport_devchk(ap, 0))
+		devmask |= (1 << 0);
+	if (slave_possible && pata_parport_devchk(ap, 1))
+		devmask |= (1 << 1);
+
+	/* select device 0 again */
+	ap->ops->sff_dev_select(ap, 0);
+
+	/* issue bus reset */
+	rc = pata_parport_bus_softreset(ap, devmask, deadline);
+	/* if link is occupied, -ENODEV too is an error */
+	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
+		ata_link_err(link, "SRST failed (errno=%d)\n", rc);
+		return rc;
+	}
+
+	/* determine by signature whether we have ATA or ATAPI devices */
+	classes[0] = ata_sff_dev_classify(&link->device[0],
+					  devmask & (1 << 0), &err);
+	if (slave_possible && err != 0x81)
+		classes[1] = ata_sff_dev_classify(&link->device[1],
+						  devmask & (1 << 1), &err);
+
+	return 0;
+}
+
+static u8 pata_parport_check_status(struct ata_port *ap)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	return pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
+}
+
+static u8 pata_parport_check_altstatus(struct ata_port *ap)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	return pi->proto->read_regr(pi, 1, 6);
+}
+
+static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+	u8 tmp;
+
+	if (device == 0)
+		tmp = ATA_DEVICE_OBS;
+	else
+		tmp = ATA_DEVICE_OBS | ATA_DEV1;
+
+	pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tmp);
+	ata_sff_pause(ap);	/* needed; also flushes, for mmio */
+}
+
+static void pata_parport_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+
+	if (tf->ctl != ap->last_ctl) {
+		pi->proto->write_regr(pi, 1, 6, tf->ctl);
+		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
+	}
+
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		pi->proto->write_regr(pi, 0, ATA_REG_FEATURE, tf->hob_feature);
+		pi->proto->write_regr(pi, 0, ATA_REG_NSECT, tf->hob_nsect);
+		pi->proto->write_regr(pi, 0, ATA_REG_LBAL, tf->hob_lbal);
+		pi->proto->write_regr(pi, 0, ATA_REG_LBAM, tf->hob_lbam);
+		pi->proto->write_regr(pi, 0, ATA_REG_LBAH, tf->hob_lbah);
+	}
+
+	if (is_addr) {
+		pi->proto->write_regr(pi, 0, ATA_REG_FEATURE, tf->feature);
+		pi->proto->write_regr(pi, 0, ATA_REG_NSECT, tf->nsect);
+		pi->proto->write_regr(pi, 0, ATA_REG_LBAL, tf->lbal);
+		pi->proto->write_regr(pi, 0, ATA_REG_LBAM, tf->lbam);
+		pi->proto->write_regr(pi, 0, ATA_REG_LBAH, tf->lbah);
+	}
+
+	if (tf->flags & ATA_TFLAG_DEVICE)
+		pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tf->device);
+
+	ata_wait_idle(ap);
+}
+
+static void pata_parport_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	tf->command = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
+	tf->feature = pi->proto->read_regr(pi, 0, ATA_REG_ERR);
+	tf->nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
+	tf->lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
+	tf->lbam = pi->proto->read_regr(pi, 0, ATA_REG_LBAM);
+	tf->lbah = pi->proto->read_regr(pi, 0, ATA_REG_LBAH);
+	tf->device = pi->proto->read_regr(pi, 0, ATA_REG_DEVICE);
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		pi->proto->write_regr(pi, 1, 6, tf->ctl | ATA_HOB);
+		tf->hob_feature = pi->proto->read_regr(pi, 0, ATA_REG_ERR);
+		tf->hob_nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
+		tf->hob_lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
+		tf->hob_lbam = pi->proto->read_regr(pi, 0, ATA_REG_LBAM);
+		tf->hob_lbah = pi->proto->read_regr(pi, 0, ATA_REG_LBAH);
+		pi->proto->write_regr(pi, 1, 6, tf->ctl);
+		ap->last_ctl = tf->ctl;
+	}
+}
+
+static void pata_parport_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	pi->proto->write_regr(pi, 0, ATA_REG_CMD, tf->command);
+	ata_sff_pause(ap);
+}
+
+static unsigned int pata_parport_data_xfer(struct ata_queued_cmd *qc, unsigned char *buf,
+					   unsigned int buflen, int rw)
+{
+	struct ata_port *ap = qc->dev->link->ap;
+	struct pi_adapter *pi = ap->host->private_data;
+
+	if (rw == READ)
+		pi->proto->read_block(pi, buf, buflen);
+	else
+		pi->proto->write_block(pi, buf, buflen);
+
+	return buflen;
+}
+
+static void pata_parport_drain_fifo(struct ata_queued_cmd *qc)
+{
+	int count;
+	struct ata_port *ap;
+	struct pi_adapter *pi;
+	char junk[2];
+
+	/* We only need to flush incoming data when a command was running */
+	if (qc == NULL || qc->dma_dir == DMA_TO_DEVICE)
+		return;
+
+	ap = qc->ap;
+	pi = ap->host->private_data;
+	/* Drain up to 64K of data before we give up this recovery method */
+	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
+						&& count < 65536; count += 2)
+		pi->proto->read_block(pi, junk, 2);
+
+	if (count)
+		ata_port_dbg(ap, "drained %d bytes to clear DRQ\n", count);
+
+}
+
+static void pata_parport_lost_interrupt(struct ata_port *ap)
+{
+	u8 status;
+	struct ata_queued_cmd *qc;
+
+	/* Only one outstanding command per SFF channel */
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
+	/* We cannot lose an interrupt on a non-existent or polled command */
+	if (!qc || qc->tf.flags & ATA_TFLAG_POLLING)
+		return;
+	/* See if the controller thinks it is still busy - if so the command
+	   isn't a lost IRQ but is still in progress */
+	status = pata_parport_check_altstatus(ap);
+	if (status & ATA_BUSY)
+		return;
+
+	/* There was a command running, we are no longer busy and we have
+	   no interrupt. */
+	ata_port_warn(ap, "lost interrupt (Status 0x%x)\n", status);
+	/* Run the host interrupt logic as if the interrupt had not been lost */
+	ata_sff_port_intr(ap, qc);
+}
+
+static struct ata_port_operations pata_parport_port_ops = {
+	.qc_prep		= ata_noop_qc_prep,
+	.qc_issue		= ata_sff_qc_issue,
+	.qc_fill_rtf		= ata_sff_qc_fill_rtf,
+
+	.freeze			= ata_sff_freeze,
+	.thaw			= ata_sff_thaw,
+	.prereset		= ata_sff_prereset,
+	.softreset		= pata_parport_softreset,
+	.postreset		= ata_sff_postreset,
+	.error_handler		= ata_sff_error_handler,
+	.sched_eh		= ata_std_sched_eh,
+	.end_eh			= ata_std_end_eh,
+
+	.sff_dev_select		= pata_parport_dev_select,
+	.sff_check_status	= pata_parport_check_status,
+	.sff_check_altstatus	= pata_parport_check_altstatus,
+	.sff_tf_load		= pata_parport_tf_load,
+	.sff_tf_read		= pata_parport_tf_read,
+	.sff_exec_command	= pata_parport_exec_command,
+	.sff_data_xfer		= pata_parport_data_xfer,
+	.sff_drain_fifo		= pata_parport_drain_fifo,
+
+	.lost_interrupt		= pata_parport_lost_interrupt,
+};
+
+static const struct ata_port_info pata_parport_port_info = {
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_POLLING,
+	.pio_mask	= ATA_PIO0,
+	/* No DMA */
+	.port_ops	= &pata_parport_port_ops,
+};
+
+int pata_parport_register_driver(struct pi_protocol *pr)
+{
+	int k;
+	int error;
+
+	for (k = 0; k < MAX_PROTOS; k++)
+		if (protocols[k] && !strcmp(pr->name, protocols[k]->name)) {
+			printk("paride: %s protocol already registered\n",
+			       pr->name);
+			return -1;
+		}
+	k = 0;
+	while ((k < MAX_PROTOS) && (protocols[k]))
+		k++;
+	if (k == MAX_PROTOS) {
+		printk("paride: protocol table full\n");
+		return -1;
+	}
+	protocols[k] = pr;
+	pr->index = k;
+	printk("paride: %s registered as protocol %d\n", pr->name, k);
+
+	pr->driver.bus = &pata_parport_bus_type;
+	pr->driver.name = pr->name;
+	error = driver_register(&pr->driver);
+	if (error)
+		return error;
+
+	return 0;
+}
+EXPORT_SYMBOL(pata_parport_register_driver);
+
+void pata_parport_unregister_driver(struct pi_protocol *pr)
+{
+	if (!pr)
+		return;
+	if (protocols[pr->index] != pr) {
+		printk("paride: %s not registered\n", pr->name);
+		return;
+	}
+	protocols[pr->index] = NULL;
+	driver_unregister(&pr->driver);
+}
+EXPORT_SYMBOL(pata_parport_unregister_driver);
+
+static DEFINE_SPINLOCK(pi_spinlock);
+
+static void pi_wake_up(void *p)
+{
+	struct pi_adapter *pi = p;
+	unsigned long flags;
+	void (*cont)(void) = NULL;
+
+	spin_lock_irqsave(&pi_spinlock, flags);
+
+	if (pi->claim_cont && !parport_claim(pi->pardev)) {
+		cont = pi->claim_cont;
+		pi->claim_cont = NULL;
+		pi->claimed = 1;
+	}
+
+	spin_unlock_irqrestore(&pi_spinlock, flags);
+
+	wake_up(&(pi->parq));
+
+	if (cont)
+		cont();
+}
+
+static void pi_claim(struct pi_adapter *pi)
+{
+	if (pi->claimed)
+		return;
+	pi->claimed = 1;
+	if (pi->pardev)
+		wait_event(pi->parq,
+			   !parport_claim((struct pardevice *) pi->pardev));
+}
+
+static void pi_unclaim(struct pi_adapter *pi)
+{
+	pi->claimed = 0;
+	if (pi->pardev)
+		parport_release((struct pardevice *) (pi->pardev));
+}
+
+static void pi_unregister_parport(struct pi_adapter *pi)
+{
+	if (pi->pardev) {
+		parport_unregister_device((struct pardevice *) (pi->pardev));
+		pi->pardev = NULL;
+	}
+}
+
+void pi_release(struct pi_adapter *pi)
+{
+	pi_unregister_parport(pi);
+	if (pi->proto->release_proto)
+		pi->proto->release_proto(pi);
+	module_put(pi->proto->owner);
+}
+
+static int default_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	int j, k;
+	int e[2] = { 0, 0 };
+
+	pi->proto->connect(pi);
+
+	for (j = 0; j < 2; j++) {
+		pi->proto->write_regr(pi, 0, 6, 0xa0 + j * 0x10);
+		for (k = 0; k < 256; k++) {
+			pi->proto->write_regr(pi, 0, 2, k ^ 0xaa);
+			pi->proto->write_regr(pi, 0, 3, k ^ 0x55);
+			if (pi->proto->read_regr(pi, 0, 2) != (k ^ 0xaa))
+				e[j]++;
+		}
+	}
+	pi->proto->disconnect(pi);
+
+	if (verbose)
+		dev_info(&pi->dev, "%s: port 0x%x, mode  %d, test=(%d,%d)\n",
+		       pi->proto->name, pi->port,
+		       pi->mode, e[0], e[1]);
+
+	return (e[0] && e[1]);	/* not here if both > 0 */
+}
+
+static int pi_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	int res;
+
+	pi_claim(pi);
+	if (pi->proto->test_proto)
+		res = pi->proto->test_proto(pi, scratch, verbose);
+	else
+		res = default_test_proto(pi, scratch, verbose);
+	pi_unclaim(pi);
+
+	return res;
+}
+
+static int pi_register_parport(struct pi_adapter *pi, int verbose, int unit)
+{
+	struct parport *port;
+	struct pardev_cb par_cb;
+
+	port = parport_find_base(pi->port);
+	if (!port)
+		return 0;
+	memset(&par_cb, 0, sizeof(par_cb));
+	par_cb.wakeup = pi_wake_up;
+	par_cb.private = (void *)pi;
+	pi->pardev = parport_register_dev_model(port, dev_name(&pi->dev), &par_cb,
+						unit);
+	parport_put_port(port);
+	if (!pi->pardev)
+		return 0;
+
+	init_waitqueue_head(&pi->parq);
+
+	if (verbose)
+		dev_info(&pi->dev, "0x%x is %s\n", pi->port, port->name);
+
+	pi->parname = (char *) port->name;
+
+	return 1;
+}
+
+static int pi_probe_mode(struct pi_adapter *pi, int max, char *scratch, int verbose)
+{
+	int best, range;
+
+	if (pi->mode != -1) {
+		if (pi->mode >= max)
+			return 0;
+		range = 3;
+		if (pi->mode >= pi->proto->epp_first)
+			range = 8;
+		if ((range == 8) && (pi->port % 8))
+			return 0;
+		return (!pi_test_proto(pi, scratch, verbose));
+	}
+	best = -1;
+	for (pi->mode = 0; pi->mode < max; pi->mode++) {
+		range = 3;
+		if (pi->mode >= pi->proto->epp_first)
+			range = 8;
+		if ((range == 8) && (pi->port % 8))
+			break;
+		if (!pi_test_proto(pi, scratch, verbose))
+			best = pi->mode;
+	}
+	pi->mode = best;
+	return (best > -1);
+}
+
+
+static int pi_probe_unit(struct pi_adapter *pi, int unit, char *scratch, int verbose)
+{
+	int max, s, e;
+
+	s = unit;
+	e = s + 1;
+
+	if (s == -1) {
+		s = 0;
+		e = pi->proto->max_units;
+	}
+
+	if (!pi_register_parport(pi, verbose, s))
+		return 0;
+
+	if (pi->proto->test_port) {
+		pi_claim(pi);
+		max = pi->proto->test_port(pi);
+		pi_unclaim(pi);
+	} else
+		max = pi->proto->max_mode;
+
+	if (pi->proto->probe_unit) {
+		pi_claim(pi);
+		for (pi->unit = s; pi->unit < e; pi->unit++)
+			if (pi->proto->probe_unit(pi)) {
+				pi_unclaim(pi);
+				if (pi_probe_mode(pi, max, scratch, verbose))
+					return 1;
+				pi_unregister_parport(pi);
+				return 0;
+			}
+		pi_unclaim(pi);
+		pi_unregister_parport(pi);
+		return 0;
+	}
+
+	if (!pi_probe_mode(pi, max, scratch, verbose)) {
+		pi_unregister_parport(pi);
+		return 0;
+	}
+	return 1;
+
+}
+
+int pi_init(struct pi_adapter *pi, int autoprobe, int port, int mode,
+	int unit, int protocol, int delay, char *scratch,
+	int verbose)
+{
+	int p, k, s, e;
+	int lpts[7] = { 0x3bc, 0x378, 0x278, 0x268, 0x27c, 0x26c, 0 };
+
+	s = protocol;
+	e = s + 1;
+
+	if (!protocols[0])
+		request_module("paride_protocol");
+
+	if (autoprobe) {
+		s = 0;
+		e = MAX_PROTOS;
+	} else if ((s < 0) || (s >= MAX_PROTOS) || (port <= 0) ||
+		   (!protocols[s]) || (unit < 0) ||
+		   (unit >= protocols[s]->max_units)) {
+		dev_err(&pi->dev, "Invalid parameters\n");
+		return 0;
+	}
+
+	for (p = s; p < e; p++) {
+		struct pi_protocol *proto = protocols[p];
+
+		if (!proto)
+			continue;
+		/* still racy */
+		if (!try_module_get(proto->owner))
+			continue;
+		pi->proto = proto;
+		pi->private = 0;
+		if (proto->init_proto && proto->init_proto(pi) < 0) {
+			pi->proto = NULL;
+			module_put(proto->owner);
+			continue;
+		}
+		if (delay == -1)
+			pi->delay = pi->proto->default_delay;
+		else
+			pi->delay = delay;
+
+		pi->parname = NULL;
+		pi->pardev = NULL;
+		init_waitqueue_head(&pi->parq);
+		pi->claimed = 0;
+		pi->claim_cont = NULL;
+
+		pi->mode = mode;
+		if (port != -1) {
+			pi->port = port;
+			if (pi_probe_unit(pi, unit, scratch, verbose))
+				break;
+			pi->port = 0;
+		} else {
+			k = 0;
+			while ((pi->port = lpts[k++]))
+				if (pi_probe_unit
+				    (pi, unit, scratch, verbose))
+					break;
+			if (pi->port)
+				break;
+		}
+		if (pi->proto->release_proto)
+			pi->proto->release_proto(pi);
+		module_put(proto->owner);
+	}
+
+	if (!pi->port) {
+		if (autoprobe)
+			dev_info(&pi->dev, "Autoprobe failed\n");
+		else
+			dev_info(&pi->dev, "Adapter not found\n");
+		return 0;
+	}
+
+	if (pi->parname)
+		dev_info(&pi->dev, "Sharing %s at 0x%x\n",
+			pi->parname, pi->port);
+
+	pi->proto->log_adapter(pi, scratch, verbose);
+
+	return 1;
+}
+
+static ssize_t new_device_store(struct bus_type *bus, const char *buf, size_t count)
+{
+	struct pi_adapter *pi;
+	int retval;
+	int autoprobe, port, mode, unit, protocol, delay;
+	int fields;
+	const struct ata_port_info *ppi[] = { &pata_parport_port_info };
+	struct ata_host *host;
+	char scratch[512];
+
+	fields = sscanf(buf, "%x %d %d %d %d",
+			&port, &mode, &unit, &protocol, &delay);
+	if (fields < 5)
+		return -EINVAL;
+
+	pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
+	if (!pi)
+		return -ENOMEM;
+	/* set up pi->dev before pi_init() so it can use dev_printk() */
+	pi->dev.parent = &pata_parport_bus;
+	pi->dev.bus = &pata_parport_bus_type;
+	pi->dev.id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
+	if (pi->dev.id < 0) {
+		retval = -ENOSPC;
+		goto out_free;
+	}
+	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
+
+	if (!pi_init(pi, autoprobe, port, mode, unit, protocol, delay, scratch, 2)) {
+		retval = -ENODEV;
+		goto out_ida_free;
+	}
+
+	/* now we know the driver so we can register the device */
+	pi->dev.driver = &pi->proto->driver;
+	retval = device_register(&pi->dev);
+	if (retval) {
+		put_device(&pi->dev);
+		goto out_ida_free;
+	}
+
+	pi_claim(pi);
+	pi->proto->connect(pi);
+
+	host = ata_host_alloc_pinfo(&pi->dev, ppi, 1);
+	if (!host) {
+		retval = -ENOMEM;
+		goto out_pi;
+	}
+	dev_set_drvdata(&pi->dev, host);
+	host->private_data = pi;
+
+	ata_port_desc(host->ports[0], "port %s", pi->parname);
+	ata_port_desc(host->ports[0], "protocol %s", pi->proto->name);
+
+	retval = ata_host_activate(host, 0, NULL, 0, &pi->proto->sht);
+	if (retval)
+		goto out_pi;
+
+	return count;
+
+out_pi:
+	pi->proto->disconnect(pi);
+	pi_unclaim(pi);
+	pi_release(pi);
+	device_unregister(&pi->dev);
+out_ida_free:
+	ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
+out_free:
+	kfree(pi);
+	return retval;
+}
+static BUS_ATTR_WO(new_device);
+
+static ssize_t delete_device_store(struct bus_type *bus, const char *buf, size_t count)
+{
+	struct device *dev;
+	struct ata_host *host;
+	struct pi_adapter *pi;
+	char device_name[32];
+	int fields;
+
+	fields = sscanf(buf, "%30s", device_name);
+	if (fields < 1)
+		return -EINVAL;
+
+	dev = bus_find_device_by_name(bus, NULL, device_name);
+	if (!dev)
+		return -ENODEV;
+	host = dev_get_drvdata(dev);
+	pi = host->private_data;
+
+	ata_host_detach(host);
+	pi->proto->disconnect(pi);
+	pi_unclaim(pi);
+	pi_release(pi);
+	device_unregister(dev);
+	ida_free(&pata_parport_bus_dev_ids, dev->id);
+	kfree(pi);
+
+	return count;
+}
+static BUS_ATTR_WO(delete_device);
+
+static __init int pata_parport_init(void)
+{
+	int error;
+
+	error = bus_register(&pata_parport_bus_type);
+	if (error) {
+		pr_err("failed to register pata_parport bus, error: %d\n", error);
+		return error;
+	}
+
+	error = device_register(&pata_parport_bus);
+	if (error) {
+		pr_err("failed to register pata_parport bus, error: %d\n", error);
+		return error;
+		goto out_unregister_bus;
+	}
+
+	error = bus_create_file(&pata_parport_bus_type, &bus_attr_new_device);
+	if (error) {
+		pr_err("unable to create sysfs file, error: %d\n", error);
+		goto out_unregister_dev;
+	}
+
+	error = bus_create_file(&pata_parport_bus_type, &bus_attr_delete_device);
+	if (error) {
+		pr_err("unable to create sysfs file, error: %d\n", error);
+		goto out_remove_new;
+	}
+
+
+	return 0;
+out_remove_new:
+	bus_remove_file(&pata_parport_bus_type, &bus_attr_new_device);
+out_unregister_dev:
+	device_unregister(&pata_parport_bus);
+out_unregister_bus:
+	bus_unregister(&pata_parport_bus_type);
+	return error;
+}
+
+static __exit void pata_parport_exit(void)
+{
+	bus_remove_file(&pata_parport_bus_type, &bus_attr_new_device);
+	bus_remove_file(&pata_parport_bus_type, &bus_attr_delete_device);
+	device_unregister(&pata_parport_bus);
+	bus_unregister(&pata_parport_bus_type);
+}
+
+MODULE_AUTHOR("Ondrej Zary");
+MODULE_DESCRIPTION("driver for parallel port ATA adapters");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("paride");
+
+module_init(pata_parport_init);
+module_exit(pata_parport_exit);
diff --git a/drivers/ata/pata_parport/pata_parport.h b/drivers/ata/pata_parport/pata_parport.h
new file mode 100644
index 000000000000..de80e115098f
--- /dev/null
+++ b/drivers/ata/pata_parport/pata_parport.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *	paride.h	(c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *				    Under the terms of the GPL.
+ *
+ * This file defines the interface for adapter chip drivers.
+ */
+
+#include <linux/libata.h>
+
+struct pi_adapter  {
+	struct device dev;
+	struct pi_protocol *proto;	/* adapter protocol */
+	int port;			/* base address of parallel port */
+	int mode;			/* transfer mode in use */
+	int delay;			/* adapter delay setting */
+	int unit;			/* unit number for chained adapters */
+	int saved_r0;			/* saved port state */
+	int saved_r2;			/* saved port state */
+	unsigned long private;		/* for protocol module */
+
+	wait_queue_head_t parq;		/* semaphore for parport sharing */
+	void *pardev;			/* pointer to pardevice */
+	char *parname;			/* parport name */
+	int claimed;			/* parport has already been claimed */
+	void (*claim_cont)(void);	/* continuation for parport wait */
+};
+
+/* registers are addressed as (cont,regr)
+ *	cont: 0 for command register file, 1 for control register(s)
+ *	regr: 0-7 for register number.
+ */
+
+/* macros and functions exported to the protocol modules */
+#define delay_p			(pi->delay ? udelay(pi->delay) : (void)0)
+#define out_p(offs, byte)	do { outb(byte, pi->port + offs); delay_p; } while (0)
+#define in_p(offs)		(delay_p, inb(pi->port + offs))
+
+#define w0(byte)		out_p(0, byte)
+#define r0()			(in_p(0) & 0xff)
+#define w1(byte)		out_p(1, byte)
+#define r1()			(in_p(1) & 0xff)
+#define w2(byte)		out_p(2, byte)
+#define r2()			(in_p(2) & 0xff)
+#define w3(byte)		out_p(3, byte)
+#define w4(byte)		out_p(4, byte)
+#define r4()			(in_p(4) & 0xff)
+#define w4w(data)		do { outw(data, pi->port + 4); delay_p; } while (0)
+#define w4l(data)		do { outl(data, pi->port + 4); delay_p; } while (0)
+#define r4w()			(delay_p, inw(pi->port + 4) & 0xffff)
+#define r4l()			(delay_p, inl(pi->port + 4) & 0xffffffff)
+
+static inline u16 pi_swab16(char *b, int k)
+{
+	union { u16 u; char t[2]; } r;
+
+	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
+	return r.u;
+}
+
+static inline u32 pi_swab32(char *b, int k)
+{
+	union { u32 u; char f[4]; } r;
+
+	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
+	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
+	return r.u;
+}
+
+struct pi_protocol {
+	char name[8];		/* name for this protocol */
+	int index;		/* index into protocol table */
+
+	int max_mode;		/* max mode number */
+	int epp_first;		/* modes >= this use 8 ports */
+
+	int default_delay;	/* delay parameter if not specified */
+	int max_units;		/* max chained units probed for */
+
+	void (*write_regr)(struct pi_adapter *pi, int cont, int regr, int val);
+	int (*read_regr)(struct pi_adapter *pi, int cont, int regr);
+	void (*write_block)(struct pi_adapter *pi, char *buf, int count);
+	void (*read_block)(struct pi_adapter *pi, char *buf, int count);
+
+	void (*connect)(struct pi_adapter *pi);
+	void (*disconnect)(struct pi_adapter *pi);
+
+	int (*test_port)(struct pi_adapter *pi);
+	int (*probe_unit)(struct pi_adapter *pi);
+	int (*test_proto)(struct pi_adapter *pi, char *scratch, int verbose);
+	void (*log_adapter)(struct pi_adapter *pi, char *scratch, int verbose);
+
+	int (*init_proto)(struct pi_adapter *pi);
+	void (*release_proto)(struct pi_adapter *pi);
+	struct module *owner;
+	struct device_driver driver;
+	struct scsi_host_template sht;
+};
+
+#define PATA_PARPORT_SHT ATA_PIO_SHT
+
+extern int pata_parport_register_driver(struct pi_protocol *pr);
+extern void pata_parport_unregister_driver(struct pi_protocol *pr);
+
+/**
+ * module_pata_parport_driver() - Helper macro for registering a pata_parport driver
+ * @__pi_protocol: pi_protocol struct
+ *
+ * Helper macro for pata_parport drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_pata_parport_driver(__pi_protocol) \
+	module_driver(__pi_protocol, pata_parport_register_driver, pata_parport_unregister_driver)
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
new file mode 100644
index 000000000000..52e0f08548c9
--- /dev/null
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -0,0 +1,486 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	ppc6lnx.c (c) 2001 Micro Solutions Inc.
+ *		Released under the terms of the GNU General Public license
+ *
+ *	ppc6lnx.c  is a part of the protocol driver for the Micro Solutions
+ *		"BACKPACK" parallel port IDE adapter
+ *		(Works on Series 6 drives)
+ */
+
+/* PPC 6 Code in C sanitized for LINUX */
+/* Original x86 ASM by Ron, Converted to C by Clive */
+
+#define port_stb	1
+#define port_afd	2
+#define cmd_stb		port_afd
+#define port_init	4
+#define data_stb	port_init
+#define port_sel	8
+#define port_int	16
+#define port_dir	0x20
+
+#define ECR_EPP		0x80
+#define ECR_BI		0x20
+
+/* 60772 Commands */
+#define ACCESS_REG	0x00
+#define ACCESS_PORT	0x40
+
+#define ACCESS_READ	0x00
+#define ACCESS_WRITE	0x20
+
+/* 60772 Command Prefix */
+
+#define CMD_PREFIX_SET		0xe0	/* Special cmd that modifies the next command's operation */
+#define CMD_PREFIX_RESET	0xc0	/* Resets current cmd modifier reg bits */
+ #define PREFIX_IO16		0x01	/* perform 16-bit wide I/O */
+ #define PREFIX_FASTWR		0x04	/* enable PPC mode fast-write */
+ #define PREFIX_BLK		0x08	/* enable block transfer mode */
+
+/* 60772 Registers */
+
+#define REG_STATUS		0x00	/* status register */
+ #define STATUS_IRQA		0x01	/* Peripheral IRQA line */
+ #define STATUS_EEPROM_DO	0x40	/* Serial EEPROM data bit */
+#define REG_VERSION		0x01	/* PPC version register (read) */
+#define REG_HWCFG		0x02	/* Hardware Config register */
+#define REG_RAMSIZE		0x03	/* Size of RAM Buffer */
+ #define RAMSIZE_128K		0x02
+#define REG_EEPROM		0x06	/* EEPROM control register */
+ #define EEPROM_SK		0x01	/* eeprom SK bit */
+ #define EEPROM_DI		0x02	/* eeprom DI bit */
+ #define EEPROM_CS		0x04	/* eeprom CS bit */
+ #define EEPROM_EN		0x08	/* eeprom output enable */
+#define REG_BLKSIZE		0x08	/* Block transfer len (24 bit) */
+
+struct ppc_storage {
+	u16	lpt_addr;		/* LPT base address */
+	u8	ppc_id;
+	u8	mode;			/* operating mode */
+					/* 0 = PPC Uni SW */
+					/* 1 = PPC Uni FW */
+					/* 2 = PPC Bi SW */
+					/* 3 = PPC Bi FW */
+					/* 4 = EPP Byte */
+					/* 5 = EPP Word */
+					/* 6 = EPP Dword */
+	u8	ppc_flags;
+	u8	org_data;		/* original LPT data port contents */
+	u8	org_ctrl;		/* original LPT control port contents */
+	u8	cur_ctrl;		/* current control port contents */
+};
+
+/* ppc_flags */
+#define fifo_wait		0x10
+
+/* DONT CHANGE THESE LEST YOU BREAK EVERYTHING - BIT FIELD DEPENDENCIES */
+#define PPCMODE_UNI_SW		0
+#define PPCMODE_UNI_FW		1
+#define PPCMODE_BI_SW		2
+#define PPCMODE_BI_FW		3
+#define PPCMODE_EPP_BYTE	4
+#define PPCMODE_EPP_WORD	5
+#define PPCMODE_EPP_DWORD	6
+
+static int ppc6_select(struct ppc_storage *ppc);
+static void ppc6_deselect(struct ppc_storage *ppc);
+static void ppc6_send_cmd(struct ppc_storage *ppc, u8 cmd);
+static void ppc6_wr_data_byte(struct ppc_storage *ppc, u8 data);
+static u8 ppc6_rd_data_byte(struct ppc_storage *ppc);
+static u8 ppc6_rd_port(struct ppc_storage *ppc, u8 port);
+static void ppc6_wr_port(struct ppc_storage *ppc, u8 port, u8 data);
+static void ppc6_rd_data_blk(struct ppc_storage *ppc, u8 *data, long count);
+static void ppc6_wait_for_fifo(struct ppc_storage *ppc);
+static void ppc6_wr_data_blk(struct ppc_storage *ppc, u8 *data, long count);
+static void ppc6_rd_port16_blk(struct ppc_storage *ppc, u8 port, u8 *data, long length);
+static void ppc6_wr_port16_blk(struct ppc_storage *ppc, u8 port, u8 *data, long length);
+static void ppc6_wr_extout(struct ppc_storage *ppc, u8 regdata);
+static int ppc6_open(struct ppc_storage *ppc);
+static void ppc6_close(struct ppc_storage *ppc);
+
+static int ppc6_select(struct ppc_storage *ppc)
+{
+	u8 i, j, k;
+
+	i = inb(ppc->lpt_addr + 1);
+	if (i & 1)
+		outb(i, ppc->lpt_addr + 1);
+
+	ppc->org_data = inb(ppc->lpt_addr);
+	ppc->org_ctrl = inb(ppc->lpt_addr + 2) & 0x5F; /* readback ctrl */
+	ppc->cur_ctrl = ppc->org_ctrl;
+	ppc->cur_ctrl |= port_sel;
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	if (ppc->org_data == 'b')
+		outb('x', ppc->lpt_addr);
+	outb('b', ppc->lpt_addr);
+	outb('p', ppc->lpt_addr);
+	outb(ppc->ppc_id, ppc->lpt_addr);
+	outb(~ppc->ppc_id, ppc->lpt_addr);
+	ppc->cur_ctrl &= ~port_sel;
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	ppc->cur_ctrl = (ppc->cur_ctrl & port_int) | port_init;
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	i = ppc->mode & 0x0C;
+	if (i == 0)
+		i = (ppc->mode & 2) | 1;
+	outb(i, ppc->lpt_addr);
+	ppc->cur_ctrl |= port_sel;
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	/* DELAY */
+	ppc->cur_ctrl |= port_afd;
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	j = ((i & 0x08) << 4) | ((i & 0x07) << 3);
+	k = inb(ppc->lpt_addr + 1) & 0xB8;
+	if (j == k) {
+		ppc->cur_ctrl &= ~port_afd;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		k = (inb(ppc->lpt_addr + 1) & 0xB8) ^ 0xB8;
+		if (j == k) {
+			if (i & 4)	/* EPP */
+				ppc->cur_ctrl &= ~(port_sel | port_init);
+			else		/* PPC/ECP */
+				ppc->cur_ctrl &= ~port_sel;
+
+			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+
+			return 1;
+		}
+	}
+	outb(ppc->org_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->org_data, ppc->lpt_addr);
+
+	return 0; /* FAIL */
+}
+
+static void ppc6_deselect(struct ppc_storage *ppc)
+{
+	if (ppc->mode & 4)	/* EPP */
+		ppc->cur_ctrl |= port_init;
+	else			/* PPC/ECP */
+		ppc->cur_ctrl |= port_sel;
+
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->org_data, ppc->lpt_addr);
+	outb((ppc->org_ctrl | port_sel), ppc->lpt_addr + 2);
+	outb(ppc->org_ctrl, ppc->lpt_addr + 2);
+}
+
+static void ppc6_send_cmd(struct ppc_storage *ppc, u8 cmd)
+{
+	switch (ppc->mode) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		outb(cmd, ppc->lpt_addr);
+		ppc->cur_ctrl ^= cmd_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_BYTE:
+	case PPCMODE_EPP_WORD:
+	case PPCMODE_EPP_DWORD:
+		outb(cmd, ppc->lpt_addr + 3);
+		break;
+	}
+}
+
+static void ppc6_wr_data_byte(struct ppc_storage *ppc, u8 data)
+{
+	switch (ppc->mode) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		outb(data, ppc->lpt_addr);
+		ppc->cur_ctrl ^= data_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_BYTE:
+	case PPCMODE_EPP_WORD:
+	case PPCMODE_EPP_DWORD:
+		outb(data, ppc->lpt_addr + 4);
+		break;
+	}
+}
+
+static u8 ppc6_rd_data_byte(struct ppc_storage *ppc)
+{
+	u8 data = 0;
+
+	switch (ppc->mode) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+		ppc->cur_ctrl = (ppc->cur_ctrl & ~port_stb) ^ data_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		/* DELAY */
+		data = inb(ppc->lpt_addr + 1);
+		data = ((data & 0x80) >> 1) | ((data & 0x38) >> 3);
+		ppc->cur_ctrl |= port_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		/* DELAY */
+		data |= inb(ppc->lpt_addr + 1) & 0xB8;
+		break;
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		ppc->cur_ctrl |= port_dir;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		ppc->cur_ctrl = (ppc->cur_ctrl | port_stb) ^ data_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		data = inb(ppc->lpt_addr);
+		ppc->cur_ctrl &= ~port_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		ppc->cur_ctrl &= ~port_dir;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_BYTE:
+	case PPCMODE_EPP_WORD:
+	case PPCMODE_EPP_DWORD:
+		outb((ppc->cur_ctrl | port_dir), ppc->lpt_addr + 2);
+		data = inb(ppc->lpt_addr + 4);
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	}
+
+	return data;
+}
+
+static u8 ppc6_rd_port(struct ppc_storage *ppc, u8 port)
+{
+	ppc6_send_cmd(ppc, port | ACCESS_PORT | ACCESS_READ);
+
+	return ppc6_rd_data_byte(ppc);
+}
+
+static void ppc6_wr_port(struct ppc_storage *ppc, u8 port, u8 data)
+{
+	ppc6_send_cmd(ppc, port | ACCESS_PORT | ACCESS_WRITE);
+
+	ppc6_wr_data_byte(ppc, data);
+}
+
+static void ppc6_rd_data_blk(struct ppc_storage *ppc, u8 *data, long count)
+{
+	switch (ppc->mode) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+		while (count) {
+			u8 d;
+
+			ppc->cur_ctrl = (ppc->cur_ctrl & ~port_stb) ^ data_stb;
+			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			/* DELAY */
+			d = inb(ppc->lpt_addr + 1);
+			d = ((d & 0x80) >> 1) | ((d & 0x38) >> 3);
+			ppc->cur_ctrl |= port_stb;
+			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			/* DELAY */
+			d |= inb(ppc->lpt_addr + 1) & 0xB8;
+			*data++ = d;
+			count--;
+		}
+		break;
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		ppc->cur_ctrl |= port_dir;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		ppc->cur_ctrl |= port_stb;
+		while (count) {
+			ppc->cur_ctrl ^= data_stb;
+			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			*data++ = inb(ppc->lpt_addr);
+			count--;
+		}
+		ppc->cur_ctrl &= ~port_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		ppc->cur_ctrl &= ~port_dir;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_BYTE:
+		outb((ppc->cur_ctrl | port_dir), ppc->lpt_addr + 2);
+		/* DELAY */
+		while (count) {
+			*data++ = inb(ppc->lpt_addr + 4);
+			count--;
+		}
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_WORD:
+		outb((ppc->cur_ctrl | port_dir), ppc->lpt_addr + 2);
+		/* DELAY */
+		while (count > 1) {
+			*((u16 *)data) = inw(ppc->lpt_addr + 4);
+			data  += 2;
+			count -= 2;
+		}
+		while (count) {
+			*data++ = inb(ppc->lpt_addr + 4);
+			count--;
+		}
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_DWORD:
+		outb((ppc->cur_ctrl | port_dir), ppc->lpt_addr + 2);
+		/* DELAY */
+		while (count > 3) {
+			*((u32 *)data) = inl(ppc->lpt_addr + 4);
+			data  += 4;
+			count -= 4;
+		}
+		while (count) {
+			*data++ = inb(ppc->lpt_addr + 4);
+			count--;
+		}
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	}
+}
+
+static void ppc6_wait_for_fifo(struct ppc_storage *ppc)
+{
+	int i;
+
+	if (ppc->ppc_flags & fifo_wait)
+		for (i = 0; i < 20; i++)
+			inb(ppc->lpt_addr + 1);
+}
+
+static void ppc6_wr_data_blk(struct ppc_storage *ppc, u8 *data, long count)
+{
+	u8 this, last;
+
+	switch (ppc->mode) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_BI_SW:
+		while (count--)	{
+			outb(*data++, ppc->lpt_addr);
+			ppc->cur_ctrl ^= data_stb;
+			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		}
+		break;
+	case PPCMODE_UNI_FW:
+	case PPCMODE_BI_FW:
+		ppc6_send_cmd(ppc, CMD_PREFIX_SET | PREFIX_FASTWR);
+		ppc->cur_ctrl |= port_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		last = *data;
+		outb(last, ppc->lpt_addr);
+		while (count) {
+			this = *data++;
+			count--;
+
+			if (this == last) {
+				ppc->cur_ctrl ^= data_stb;
+				outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			} else {
+				outb(this, ppc->lpt_addr);
+				last = this;
+			}
+		}
+		ppc->cur_ctrl &= ~port_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		ppc6_send_cmd(ppc, CMD_PREFIX_RESET | PREFIX_FASTWR);
+		break;
+	case PPCMODE_EPP_BYTE:
+		while (count) {
+			outb(*data++, ppc->lpt_addr + 4);
+			count--;
+		}
+		ppc6_wait_for_fifo(ppc);
+		break;
+	case PPCMODE_EPP_WORD:
+		while (count > 1) {
+			outw(*((u16 *)data), ppc->lpt_addr + 4);
+			data  += 2;
+			count -= 2;
+		}
+		while (count) {
+			outb(*data++, ppc->lpt_addr + 4);
+			count--;
+		}
+		ppc6_wait_for_fifo(ppc);
+		break;
+	case PPCMODE_EPP_DWORD:
+		while (count > 3) {
+			outl(*((u32 *)data), ppc->lpt_addr + 4);
+			data  += 4;
+			count -= 4;
+		}
+		while (count) {
+			outb(*data++, ppc->lpt_addr + 4);
+			count--;
+		}
+		ppc6_wait_for_fifo(ppc);
+		break;
+	}
+}
+
+static void ppc6_rd_port16_blk(struct ppc_storage *ppc, u8 port, u8 *data, long length)
+{
+	length = length << 1;
+
+	ppc6_send_cmd(ppc, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
+	ppc6_wr_data_byte(ppc, (u8)length);
+	ppc6_wr_data_byte(ppc, (u8)(length >> 8));
+	ppc6_wr_data_byte(ppc, 0);
+
+	ppc6_send_cmd(ppc, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
+
+	ppc6_send_cmd(ppc, port | ACCESS_PORT | ACCESS_READ);
+
+	ppc6_rd_data_blk(ppc, data, length);
+
+	ppc6_send_cmd(ppc, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
+}
+
+static void ppc6_wr_port16_blk(struct ppc_storage *ppc, u8 port, u8 *data, long length)
+{
+	length = length << 1;
+
+	ppc6_send_cmd(ppc, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
+	ppc6_wr_data_byte(ppc, (u8)length);
+	ppc6_wr_data_byte(ppc, (u8)(length >> 8));
+	ppc6_wr_data_byte(ppc, 0);
+
+	ppc6_send_cmd(ppc, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
+
+	ppc6_send_cmd(ppc, port | ACCESS_PORT | ACCESS_WRITE);
+
+	ppc6_wr_data_blk(ppc, data, length);
+
+	ppc6_send_cmd(ppc, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
+}
+
+static void ppc6_wr_extout(struct ppc_storage *ppc, u8 regdata)
+{
+	ppc6_send_cmd(ppc, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
+
+	ppc6_wr_data_byte(ppc, (regdata & 0x03) << 6);
+}
+
+static int ppc6_open(struct ppc_storage *ppc)
+{
+	int ret;
+
+	ret = ppc6_select(ppc);
+	if (ret == 0)
+		return ret;
+
+	ppc->ppc_flags &= ~fifo_wait;
+
+	ppc6_send_cmd(ppc, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
+	ppc6_wr_data_byte(ppc, RAMSIZE_128K);
+
+	ppc6_send_cmd(ppc, ACCESS_REG | ACCESS_READ | REG_VERSION);
+
+	if ((ppc6_rd_data_byte(ppc) & 0x3F) == 0x0C)
+		ppc->ppc_flags |= fifo_wait;
+
+	return ret;
+}
+
+static void ppc6_close(struct ppc_storage *ppc)
+{
+	ppc6_deselect(ppc);
+}
-- 
Ondrej Zary

