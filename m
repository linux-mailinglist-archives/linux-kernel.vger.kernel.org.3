Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AFA4CE6E2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiCEUQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiCEUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:39 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94BB8240B1;
        Sat,  5 Mar 2022 12:14:44 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 868B97A05A6;
        Sat,  5 Mar 2022 21:14:40 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/16] pata_parport: add dstr protocol driver
Date:   Sat,  5 Mar 2022 21:14:01 +0100
Message-Id: <20220305201411.501-7-linux@zary.sk>
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

Add DataStor EP-2000 protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  10 ++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/dstr.c   | 226 ++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/ata/pata_parport/dstr.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index 3cc3d6ae4d45..67f203dfbdca 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -64,3 +64,13 @@ config PATA_PARPORT_COMM
 	  into your kernel, you may answer Y here to build in the protocol
 	  driver, otherwise you should answer M to build it as a loadable
 	  module. The module will be called comm.
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
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index fcb77a855ef6..bf81c4ca32ab 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_PATA_PARPORT_ATEN)		+= aten.o
 obj-$(CONFIG_PATA_PARPORT_BPCK)		+= bpck.o
 obj-$(CONFIG_PATA_PARPORT_BPCK6)	+= bpck6.o
 obj-$(CONFIG_PATA_PARPORT_COMM)		+= comm.o
+obj-$(CONFIG_PATA_PARPORT_DSTR)		+= dstr.o
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
-- 
Ondrej Zary

