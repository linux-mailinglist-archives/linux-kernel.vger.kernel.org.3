Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69CA4CE6C6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiCEUPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiCEUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:33 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF49FDE83;
        Sat,  5 Mar 2022 12:14:41 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 06F317A04E8;
        Sat,  5 Mar 2022 21:14:40 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] pata_parport: add aten protocol driver
Date:   Sat,  5 Mar 2022 21:13:57 +0100
Message-Id: <20220305201411.501-3-linux@zary.sk>
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

Add ATEN EH-100 protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  11 +++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/aten.c   | 139 ++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 drivers/ata/pata_parport/aten.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index 56dc6b25d5fa..93b0ad65b523 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -8,3 +8,14 @@
 
 comment "Parallel IDE protocol modules"
 	depends on PATA_PARPORT
+
+config PATA_PARPORT_ATEN
+	tristate "ATEN EH-100 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the ATEN EH-100 parallel port IDE
+	  protocol. This protocol is used in some inexpensive low performance
+	  parallel port kits made in Hong Kong. If you chose to build PATA_PARPORT
+	  support into your kernel, you may answer Y here to build in the
+	  protocol driver, otherwise you should answer M to build it as a
+	  loadable module. The module will be called aten.
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index b105e1cb8dc6..7e821b629c58 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -7,3 +7,4 @@
 #
 
 obj-$(CONFIG_PATA_PARPORT)		+= pata_parport.o
+obj-$(CONFIG_PATA_PARPORT_ATEN)		+= aten.o
diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
new file mode 100644
index 000000000000..a811a471e942
--- /dev/null
+++ b/drivers/ata/pata_parport/aten.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	aten.c  (c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *			    Under the terms of the GNU General Public License.
+ *
+ *	aten.c is a low-level protocol driver for the ATEN EH-100
+ *	parallel port adapter.  The EH-100 supports 4-bit and 8-bit
+ *	modes only.  There is also an EH-132 which supports EPP mode
+ *	transfers.  The EH-132 is not yet supported.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/wait.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#include "pata_parport.h"
+
+#define j44(a, b)		((((a >> 4) & 0x0f) | (b & 0xf0)) ^ 0x88)
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+
+static int cont_map[2] = { 0x08, 0x20 };
+
+static void aten_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont] + 0x80;
+
+	w0(r); w2(0xe); w2(6); w0(val); w2(7); w2(6); w2(0xc);
+}
+
+static int aten_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b, r;
+
+	r = regr + cont_map[cont] + 0x40;
+
+	switch (pi->mode) {
+	case 0:
+		w0(r); w2(0xe); w2(6);
+		w2(7); w2(6); w2(0);
+		a = r1(); w0(0x10); b = r1(); w2(0xc);
+		return j44(a, b);
+	case 1:
+		r |= 0x10;
+		w0(r); w2(0xe); w2(6); w0(0xff);
+		w2(0x27); w2(0x26); w2(0x20);
+		a = r0();
+		w2(0x26); w2(0xc);
+		return a;
+	}
+	return -1;
+}
+
+static void aten_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int  k, a, b, c, d;
+
+	switch (pi->mode) {
+	case 0:
+		w0(0x48); w2(0xe); w2(6);
+		for (k = 0; k < count / 2; k++) {
+			w2(7); w2(6); w2(2);
+			a = r1(); w0(0x58); b = r1();
+			w2(0); d = r1(); w0(0x48); c = r1();
+			buf[2 * k] = j44(c, d);
+			buf[2 * k + 1] = j44(a, b);
+		}
+		w2(0xc);
+		break;
+	case 1:
+		w0(0x58); w2(0xe); w2(6);
+		for (k = 0; k < count / 2; k++) {
+			w2(0x27); w2(0x26); w2(0x22);
+			a = r0(); w2(0x20); b = r0();
+			buf[2 * k] = b; buf[2 * k + 1] = a;
+		}
+		w2(0x26); w2(0xc);
+		break;
+	}
+}
+
+static void aten_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	w0(0x88); w2(0xe); w2(6);
+	for (k = 0; k < count / 2; k++) {
+		w0(buf[2 * k + 1]); w2(0xe); w2(6);
+		w0(buf[2 * k]); w2(7); w2(6);
+	}
+	w2(0xc);
+}
+
+static void aten_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(0xc);
+}
+
+static void aten_disconnect(struct pi_adapter *pi)
+{
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void aten_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	char *mode_string[2] = { "4-bit", "8-bit" };
+
+	dev_info(&pi->dev, "aten, ATEN EH-100 at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static struct pi_protocol aten = {
+	.owner		= THIS_MODULE,
+	.name		= "aten",
+	.max_mode	= 2,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= aten_write_regr,
+	.read_regr	= aten_read_regr,
+	.write_block	= aten_write_block,
+	.read_block	= aten_read_block,
+	.connect	= aten_connect,
+	.disconnect	= aten_disconnect,
+	.log_adapter	= aten_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-aten") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(aten);
-- 
Ondrej Zary

