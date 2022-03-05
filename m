Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65BE4CE6D8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiCEUQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiCEUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:35 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94DB232988;
        Sat,  5 Mar 2022 12:14:44 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id A91257A062B;
        Sat,  5 Mar 2022 21:14:40 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/16] pata_parport: add fit2 protocol driver
Date:   Sat,  5 Mar 2022 21:14:02 +0100
Message-Id: <20220305201411.501-8-linux@zary.sk>
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

Add FIT TD-2000 protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  11 +++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/fit2.c   | 135 ++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/ata/pata_parport/fit2.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index 67f203dfbdca..db8edb288db4 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -74,3 +74,14 @@ config PATA_PARPORT_DSTR
 	  into your kernel, you may answer Y here to build in the protocol
 	  driver, otherwise you should answer M to build it as a loadable
 	  module. The module will be called dstr.
+
+config PATA_PARPORT_FIT2
+	tristate "FIT TD-2000 protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the TD-2000 parallel port IDE
+	  protocol from Fidelity International Technology. This is a simple
+	  (low speed) adapter that is used in some portable hard drives. If
+	  you chose to build PATA_PARPORT support into your kernel, you may answer Y
+	  here to build in the protocol driver, otherwise you should answer M
+	  to build it as a loadable module. The module will be called ktti.
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index bf81c4ca32ab..27d854f52ad7 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_PATA_PARPORT_BPCK)		+= bpck.o
 obj-$(CONFIG_PATA_PARPORT_BPCK6)	+= bpck6.o
 obj-$(CONFIG_PATA_PARPORT_COMM)		+= comm.o
 obj-$(CONFIG_PATA_PARPORT_DSTR)		+= dstr.o
+obj-$(CONFIG_PATA_PARPORT_FIT2)		+= fit2.o
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
new file mode 100644
index 000000000000..92cee479108c
--- /dev/null
+++ b/drivers/ata/pata_parport/fit2.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	fit2.c	(c) 1998  Grant R. Guenther <grant@torque.net>
+ *			  Under the terms of the GNU General Public License.
+ *
+ *	fit2.c is a low-level protocol driver for the older version
+ *	of the Fidelity International Technology parallel port adapter.
+ *	This adapter is used in their TransDisk 2000 and older TransDisk
+ *	3000 portable hard-drives.  As far as I can tell, this device
+ *	supports 4-bit mode _only_.
+ *
+ *	Newer models of the FIT products use an enhanced protocol.
+ *	The "fit3" protocol module should support current drives.
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
+#define j44(a, b)	(((a >> 4) & 0x0f) | (b & 0xf0))
+
+/* cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ *
+ * NB:  The FIT adapter does not appear to use the control registers.
+ * So, we map ALT_STATUS to STATUS and NO-OP writes to the device
+ * control register - this means that IDE reset will not work on these
+ * devices.
+ */
+
+static void fit2_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	if (cont == 1)
+		return;
+	w2(0xc); w0(regr); w2(4); w0(val); w2(5); w0(0); w2(4);
+}
+
+static int fit2_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int  a, b, r;
+
+	if (cont) {
+		if (regr != 6)
+			return 0xff;
+		r = 7;
+	} else
+		r = regr + 0x10;
+
+	w2(0xc); w0(r); w2(4); w2(5);
+		 w0(0); a = r1();
+		 w0(1); b = r1();
+	w2(4);
+
+	return j44(a, b);
+}
+
+static void fit2_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, a, b, c, d;
+
+	w2(0xc); w0(0x10);
+
+	for (k = 0; k < count / 4; k++) {
+		w2(4); w2(5);
+		w0(0); a = r1(); w0(1); b = r1();
+		w0(3); c = r1(); w0(2); d = r1();
+		buf[4 * k + 0] = j44(a, b);
+		buf[4 * k + 1] = j44(d, c);
+
+		w2(4); w2(5);
+		       a = r1(); w0(3); b = r1();
+		w0(1); c = r1(); w0(0); d = r1();
+		buf[4 * k + 2] = j44(d, c);
+		buf[4 * k + 3] = j44(a, b);
+	}
+
+	w2(4);
+}
+
+static void fit2_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	w2(0xc); w0(0);
+	for (k = 0; k < count / 2; k++) {
+		w2(4); w0(buf[2 * k]);
+		w2(5); w0(buf[2 * k + 1]);
+	}
+	w2(4);
+}
+
+static void fit2_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(0xcc);
+}
+
+static void fit2_disconnect(struct pi_adapter *pi)
+{
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void fit2_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	dev_info(&pi->dev, "fit2, FIT 2000 adapter at 0x%x, delay %d\n",
+		pi->port, pi->delay);
+}
+
+static struct pi_protocol fit2 = {
+	.owner		= THIS_MODULE,
+	.name		= "fit2",
+	.max_mode	= 1,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= fit2_write_regr,
+	.read_regr	= fit2_read_regr,
+	.write_block	= fit2_write_block,
+	.read_block	= fit2_read_block,
+	.connect	= fit2_connect,
+	.disconnect	= fit2_disconnect,
+	.log_adapter	= fit2_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-fit2") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(fit2);
-- 
Ondrej Zary

