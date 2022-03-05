Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93224CE6EB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiCEUQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiCEUPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:40 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33A464090A;
        Sat,  5 Mar 2022 12:14:46 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 377587A0666;
        Sat,  5 Mar 2022 21:14:41 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/16] pata_parport: add frpw protocol driver
Date:   Sat,  5 Mar 2022 21:14:07 +0100
Message-Id: <20220305201411.501-13-linux@zary.sk>
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

Add FreeCom power protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  10 +
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/frpw.c   | 292 ++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 drivers/ata/pata_parport/frpw.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index 8a569ee0bf6a..d8e5feaaae7a 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -132,3 +132,13 @@ config PATA_PARPORT_FRIQ
 	  should answer M to build it as a loadable module. The module will be
 	  called friq. You must also have a high-level driver for the type
 	  of device that you want to support.
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
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index 20d05e525c95..136374be9613 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_PATA_PARPORT_FIT3)		+= fit3.o
 obj-$(CONFIG_PATA_PARPORT_EPAT)		+= epat.o
 obj-$(CONFIG_PATA_PARPORT_EPIA)		+= epia.o
 obj-$(CONFIG_PATA_PARPORT_FRIQ)		+= friq.o
+obj-$(CONFIG_PATA_PARPORT_FRPW)		+= frpw.o
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
-- 
Ondrej Zary

