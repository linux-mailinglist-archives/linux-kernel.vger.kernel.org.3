Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D534CE6EC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiCEUQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiCEUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:39 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EE2412ABC;
        Sat,  5 Mar 2022 12:14:45 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id DB3D77A064B;
        Sat,  5 Mar 2022 21:14:40 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/16] pata_parport: add epat protocol driver
Date:   Sat,  5 Mar 2022 21:14:04 +0100
Message-Id: <20220305201411.501-10-linux@zary.sk>
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

Add Shuttle EPAT/EPEZ protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  12 ++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/epat.c   | 320 ++++++++++++++++++++++++++++++
 3 files changed, 333 insertions(+)
 create mode 100644 drivers/ata/pata_parport/epat.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index a03c626e4e6c..6c218486c3b8 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -97,3 +97,15 @@ config PATA_PARPORT_FIT3
 	  may answer Y here to build in the protocol driver, otherwise you
 	  should answer M to build it as a loadable module. The module will be
 	  called fit3.
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
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index 140f6f142eaa..459307f4a096 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_PATA_PARPORT_COMM)		+= comm.o
 obj-$(CONFIG_PATA_PARPORT_DSTR)		+= dstr.o
 obj-$(CONFIG_PATA_PARPORT_FIT2)		+= fit2.o
 obj-$(CONFIG_PATA_PARPORT_FIT3)		+= fit3.o
+obj-$(CONFIG_PATA_PARPORT_EPAT)		+= epat.o
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
-- 
Ondrej Zary

