Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE04CE6E1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiCEUQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiCEUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:39 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EED413F53;
        Sat,  5 Mar 2022 12:14:45 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 006BA7A0650;
        Sat,  5 Mar 2022 21:14:40 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] pata_parport: add epia protocol driver
Date:   Sat,  5 Mar 2022 21:14:05 +0100
Message-Id: <20220305201411.501-11-linux@zary.sk>
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

Add Shuttle EPIA protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  11 ++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/epia.c   | 308 ++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 drivers/ata/pata_parport/epia.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index 6c218486c3b8..832ab8b00511 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -109,3 +109,14 @@ config PATA_PARPORT_EPAT
 	  PATA_PARPORT support into your kernel, you may answer Y here to build in
 	  the protocol driver, otherwise you should answer M to build it as a
 	  loadable module. The module will be called epat.
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
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index 459307f4a096..6e72778f45cb 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_PATA_PARPORT_DSTR)		+= dstr.o
 obj-$(CONFIG_PATA_PARPORT_FIT2)		+= fit2.o
 obj-$(CONFIG_PATA_PARPORT_FIT3)		+= fit3.o
 obj-$(CONFIG_PATA_PARPORT_EPAT)		+= epat.o
+obj-$(CONFIG_PATA_PARPORT_EPIA)		+= epia.o
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
-- 
Ondrej Zary

