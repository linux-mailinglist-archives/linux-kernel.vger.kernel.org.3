Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151654CE6DC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiCEUQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiCEUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:42 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D4835FF22;
        Sat,  5 Mar 2022 12:14:46 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 81C197A069D;
        Sat,  5 Mar 2022 21:14:41 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] pata_parport: add on20 protocol driver
Date:   Sat,  5 Mar 2022 21:14:10 +0100
Message-Id: <20220305201411.501-16-linux@zary.sk>
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

Add OnSpec 90c20 protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  11 +++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/on20.c   | 136 ++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/ata/pata_parport/on20.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index 4505a037591a..c18757464b1d 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -165,3 +165,14 @@ config PATA_PARPORT_KTTI
 	  support into your kernel, you may answer Y here to build in the
 	  protocol driver, otherwise you should answer M to build it as a
 	  loadable module. The module will be called ktti.
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
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index 0c31cf55c96b..4358d1d946cb 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_PATA_PARPORT_FRIQ)		+= friq.o
 obj-$(CONFIG_PATA_PARPORT_FRPW)		+= frpw.o
 obj-$(CONFIG_PATA_PARPORT_KBIC)		+= kbic.o
 obj-$(CONFIG_PATA_PARPORT_KTTI)		+= ktti.o
+obj-$(CONFIG_PATA_PARPORT_ON20)		+= on20.o
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
-- 
Ondrej Zary

