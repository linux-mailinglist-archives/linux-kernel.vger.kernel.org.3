Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535784CE6E9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiCEUPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiCEUPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:40 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33D8455483;
        Sat,  5 Mar 2022 12:14:46 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 1D50D7A065F;
        Sat,  5 Mar 2022 21:14:41 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/16] pata_parport: add friq protocol driver
Date:   Sat,  5 Mar 2022 21:14:06 +0100
Message-Id: <20220305201411.501-12-linux@zary.sk>
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

Add Freecom IQ ASIC-2 protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  12 ++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/friq.c   | 263 ++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 drivers/ata/pata_parport/friq.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index 832ab8b00511..8a569ee0bf6a 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -120,3 +120,15 @@ config PATA_PARPORT_EPIA
 	  into your kernel, you may answer Y here to build in the protocol
 	  driver, otherwise you should answer M to build it as a loadable
 	  module. The module will be called epia.
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
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index 6e72778f45cb..20d05e525c95 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_PATA_PARPORT_FIT2)		+= fit2.o
 obj-$(CONFIG_PATA_PARPORT_FIT3)		+= fit3.o
 obj-$(CONFIG_PATA_PARPORT_EPAT)		+= epat.o
 obj-$(CONFIG_PATA_PARPORT_EPIA)		+= epia.o
+obj-$(CONFIG_PATA_PARPORT_FRIQ)		+= friq.o
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
-- 
Ondrej Zary

