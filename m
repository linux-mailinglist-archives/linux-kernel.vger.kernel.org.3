Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE74CE6E5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiCEUQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiCEUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:42 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D4C35FF2C;
        Sat,  5 Mar 2022 12:14:46 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 9949D7A06A0;
        Sat,  5 Mar 2022 21:14:41 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] pata_parport: add on26 protocol driver
Date:   Sat,  5 Mar 2022 21:14:11 +0100
Message-Id: <20220305201411.501-17-linux@zary.sk>
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

Add OnSpec 90c26 protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  11 ++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/on26.c   | 302 ++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)
 create mode 100644 drivers/ata/pata_parport/on26.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index c18757464b1d..5d3440f372fc 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -176,3 +176,14 @@ config PATA_PARPORT_ON20
 	  may answer Y here to build in the protocol driver, otherwise you
 	  should answer M to build it as a loadable module.The module will
 	  be called on20.
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
index 4358d1d946cb..2b03a5a9131a 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_PATA_PARPORT_FRPW)		+= frpw.o
 obj-$(CONFIG_PATA_PARPORT_KBIC)		+= kbic.o
 obj-$(CONFIG_PATA_PARPORT_KTTI)		+= ktti.o
 obj-$(CONFIG_PATA_PARPORT_ON20)		+= on20.o
+obj-$(CONFIG_PATA_PARPORT_ON26)		+= on26.o
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
-- 
Ondrej Zary

