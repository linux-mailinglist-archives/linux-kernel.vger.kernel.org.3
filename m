Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34B4CE6D5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiCEUPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiCEUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:35 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94B6A22531;
        Sat,  5 Mar 2022 12:14:44 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 5FE167A05A3;
        Sat,  5 Mar 2022 21:14:40 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/16] pata_parport: add comm protocol driver
Date:   Sat,  5 Mar 2022 21:14:00 +0100
Message-Id: <20220305201411.501-6-linux@zary.sk>
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

Add DataStor Commuter protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  10 ++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/comm.c   | 198 ++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/ata/pata_parport/comm.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index e88d9c0bedc6..3cc3d6ae4d45 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -54,3 +54,13 @@ config PATA_PARPORT_BPCK6
 	  answer Y here to build in the protocol driver, otherwise you should
 	  answer M to build it as a loadable module.  The module will be
 	  called bpck6.
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
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index 60522279aa16..fcb77a855ef6 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_PATA_PARPORT)		+= pata_parport.o
 obj-$(CONFIG_PATA_PARPORT_ATEN)		+= aten.o
 obj-$(CONFIG_PATA_PARPORT_BPCK)		+= bpck.o
 obj-$(CONFIG_PATA_PARPORT_BPCK6)	+= bpck6.o
+obj-$(CONFIG_PATA_PARPORT_COMM)		+= comm.o
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
-- 
Ondrej Zary

