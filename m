Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91E4CE6C2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiCEUPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiCEUPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:34 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05355E09B;
        Sat,  5 Mar 2022 12:14:41 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 24A177A053C;
        Sat,  5 Mar 2022 21:14:40 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/16] pata_parport: add bpck protocol driver
Date:   Sat,  5 Mar 2022 21:13:58 +0100
Message-Id: <20220305201411.501-4-linux@zary.sk>
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

Add MicroSolutions backpack (Series 5) protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  17 ++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/bpck.c   | 481 ++++++++++++++++++++++++++++++
 3 files changed, 499 insertions(+)
 create mode 100644 drivers/ata/pata_parport/bpck.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index 93b0ad65b523..ed33a6a5c6fe 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -19,3 +19,20 @@ config PATA_PARPORT_ATEN
 	  support into your kernel, you may answer Y here to build in the
 	  protocol driver, otherwise you should answer M to build it as a
 	  loadable module. The module will be called aten.
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
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index 7e821b629c58..1d03e49aa29f 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -8,3 +8,4 @@
 
 obj-$(CONFIG_PATA_PARPORT)		+= pata_parport.o
 obj-$(CONFIG_PATA_PARPORT_ATEN)		+= aten.o
+obj-$(CONFIG_PATA_PARPORT_BPCK)		+= bpck.o
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
new file mode 100644
index 000000000000..07ee353eae84
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
+	//// FIXME: devtype was removed and we're called before device detection
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
-- 
Ondrej Zary

