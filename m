Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EED4CE6E3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiCEUQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiCEUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:35 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94D0B2558F;
        Sat,  5 Mar 2022 12:14:44 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id C1D067A0645;
        Sat,  5 Mar 2022 21:14:40 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] pata_parport: add fit3 protocol driver
Date:   Sat,  5 Mar 2022 21:14:03 +0100
Message-Id: <20220305201411.501-9-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220305201411.501-1-linux@zary.sk>
References: <20220305201411.501-1-linux@zary.sk>
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

Add FIT TD-3000 protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  12 ++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/fit3.c   | 195 ++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 drivers/ata/pata_parport/fit3.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index db8edb288db4..a03c626e4e6c 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -85,3 +85,15 @@ config PATA_PARPORT_FIT2
 	  you chose to build PATA_PARPORT support into your kernel, you may answer Y
 	  here to build in the protocol driver, otherwise you should answer M
 	  to build it as a loadable module. The module will be called ktti.
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
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index 27d854f52ad7..140f6f142eaa 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PATA_PARPORT_BPCK6)	+= bpck6.o
 obj-$(CONFIG_PATA_PARPORT_COMM)		+= comm.o
 obj-$(CONFIG_PATA_PARPORT_DSTR)		+= dstr.o
 obj-$(CONFIG_PATA_PARPORT_FIT2)		+= fit2.o
+obj-$(CONFIG_PATA_PARPORT_FIT3)		+= fit3.o
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
-- 
Ondrej Zary

