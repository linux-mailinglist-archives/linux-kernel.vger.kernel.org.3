Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856664CE6E0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiCEUQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiCEUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:42 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 834155E170;
        Sat,  5 Mar 2022 12:14:46 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 6A7E37A0696;
        Sat,  5 Mar 2022 21:14:41 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] pata_parport: add ktti protocol driver
Date:   Sat,  5 Mar 2022 21:14:09 +0100
Message-Id: <20220305201411.501-15-linux@zary.sk>
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

Add KT PHd protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig  |  11 +++
 drivers/ata/pata_parport/Makefile |   1 +
 drivers/ata/pata_parport/ktti.c   | 112 ++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/ata/pata_parport/ktti.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index 004e5cf708f1..4505a037591a 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -154,3 +154,14 @@ config PATA_PARPORT_KBIC
 	  kernel, you may answer Y here to build in the protocol driver,
 	  otherwise you should answer M to build it as a loadable module. The
 	  module will be called kbic.
+
+config PATA_PARPORT_KTTI
+	tristate "KT PHd protocol"
+	depends on PATA_PARPORT
+	help
+	  This option enables support for the "PHd" parallel port IDE protocol
+	  from KT Technology. This is a simple (low speed) adapter that is
+	  used in some 2.5" portable hard drives. If you chose to build PATA_PARPORT
+	  support into your kernel, you may answer Y here to build in the
+	  protocol driver, otherwise you should answer M to build it as a
+	  loadable module. The module will be called ktti.
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index e82fded22da3..0c31cf55c96b 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_PATA_PARPORT_EPIA)		+= epia.o
 obj-$(CONFIG_PATA_PARPORT_FRIQ)		+= friq.o
 obj-$(CONFIG_PATA_PARPORT_FRPW)		+= frpw.o
 obj-$(CONFIG_PATA_PARPORT_KBIC)		+= kbic.o
+obj-$(CONFIG_PATA_PARPORT_KTTI)		+= ktti.o
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
new file mode 100644
index 000000000000..4604bbd41b18
--- /dev/null
+++ b/drivers/ata/pata_parport/ktti.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	ktti.c	(c) 1998  Grant R. Guenther <grant@torque.net>
+ *			  Under the terms of the GNU General Public License.
+ *
+ *	ktti.c is a low-level protocol driver for the KT Technology
+ *	parallel port adapter.  This adapter is used in the "PHd"
+ *	portable hard-drives.  As far as I can tell, this device
+ *	supports 4-bit mode _only_.
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
+ */
+
+static int cont_map[2] = { 0x10, 0x08 };
+
+static void ktti_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont];
+
+	w0(r); w2(0xb); w2(0xa); w2(3); w2(6);
+	w0(val); w2(3); w0(0); w2(6); w2(0xb);
+}
+
+static int ktti_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int  a, b, r;
+
+	r = regr + cont_map[cont];
+
+	w0(r); w2(0xb); w2(0xa); w2(9); w2(0xc); w2(9);
+	a = r1(); w2(0xc);  b = r1(); w2(9); w2(0xc); w2(9);
+	return j44(a, b);
+}
+
+static void ktti_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int  k, a, b;
+
+	for (k = 0; k < count / 2; k++) {
+		w0(0x10); w2(0xb); w2(0xa); w2(9); w2(0xc); w2(9);
+		a = r1(); w2(0xc); b = r1(); w2(9);
+		buf[2 * k] = j44(a, b);
+		a = r1(); w2(0xc); b = r1(); w2(9);
+		buf[2 * k + 1] = j44(a, b);
+	}
+}
+
+static void ktti_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
+
+	for (k = 0; k < count / 2; k++) {
+		w0(0x10); w2(0xb); w2(0xa); w2(3); w2(6);
+		w0(buf[2 * k]); w2(3);
+		w0(buf[2 * k + 1]); w2(6);
+		w2(0xb);
+	}
+}
+
+static void ktti_connect(struct pi_adapter *pi)
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(0xb); w2(0xa); w0(0); w2(3); w2(6);
+}
+
+static void ktti_disconnect(struct pi_adapter *pi)
+{
+	w2(0xb); w2(0xa); w0(0xa0); w2(3); w2(4);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
+
+static void ktti_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	dev_info(&pi->dev, "ktti, KT adapter at 0x%x, delay %d\n",
+		pi->port, pi->delay);
+}
+
+static struct pi_protocol ktti = {
+	.owner		= THIS_MODULE,
+	.name		= "ktti",
+	.max_mode	= 1,
+	.epp_first	= 2,
+	.default_delay	= 1,
+	.max_units	= 1,
+	.write_regr	= ktti_write_regr,
+	.read_regr	= ktti_read_regr,
+	.write_block	= ktti_write_block,
+	.read_block	= ktti_read_block,
+	.connect	= ktti_connect,
+	.disconnect	= ktti_disconnect,
+	.log_adapter	= ktti_log_adapter,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-ktti") },
+};
+
+MODULE_LICENSE("GPL");
+module_pata_parport_driver(ktti);
-- 
Ondrej Zary

