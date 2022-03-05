Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182884CE6CF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiCEUPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiCEUPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:34 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF3C12DCB;
        Sat,  5 Mar 2022 12:14:41 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 381C87A0543;
        Sat,  5 Mar 2022 21:14:40 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] pata_parport: add bpck6 protocol driver
Date:   Sat,  5 Mar 2022 21:13:59 +0100
Message-Id: <20220305201411.501-5-linux@zary.sk>
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

Add MicroSolutions backpack (Series 6) protocol driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/Kconfig   |  18 ++
 drivers/ata/pata_parport/Makefile  |   1 +
 drivers/ata/pata_parport/bpck6.c   | 164 ++++++++++
 drivers/ata/pata_parport/ppc6lnx.c | 486 +++++++++++++++++++++++++++++
 4 files changed, 669 insertions(+)
 create mode 100644 drivers/ata/pata_parport/bpck6.c
 create mode 100644 drivers/ata/pata_parport/ppc6lnx.c

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
index ed33a6a5c6fe..e88d9c0bedc6 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -36,3 +36,21 @@ config PATA_PARPORT_BPCK
 	  answer Y here to build in the protocol driver, otherwise you should
 	  answer M to build it as a loadable module.  The module will be
 	  called bpck.
+
+config PATA_PARPORT_BPCK6
+	tristate "MicroSolutions backpack (Series 6) protocol"
+	depends on PATA_PARPORT && !64BIT
+	help
+	  This option enables support for the Micro Solutions BACKPACK
+	  parallel port Series 6 IDE protocol.  (Most BACKPACK drives made
+	  after 1999 were Series 6) Series 6 drives will have the Series noted
+	  on the bottom of the drive.  Series 5 drivers don't always have it
+	  noted.
+
+	  In other words, if your BACKPACK drive says "Series 6" on the
+	  bottom, enable this option.
+
+	  If you chose to build PATA_PARPORT support into your kernel, you may
+	  answer Y here to build in the protocol driver, otherwise you should
+	  answer M to build it as a loadable module.  The module will be
+	  called bpck6.
diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
index 1d03e49aa29f..60522279aa16 100644
--- a/drivers/ata/pata_parport/Makefile
+++ b/drivers/ata/pata_parport/Makefile
@@ -9,3 +9,4 @@
 obj-$(CONFIG_PATA_PARPORT)		+= pata_parport.o
 obj-$(CONFIG_PATA_PARPORT_ATEN)		+= aten.o
 obj-$(CONFIG_PATA_PARPORT_BPCK)		+= bpck.o
+obj-$(CONFIG_PATA_PARPORT_BPCK6)	+= bpck6.o
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
new file mode 100644
index 000000000000..cd517c822ee2
--- /dev/null
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	backpack.c (c) 2001 Micro Solutions Inc.
+ *		Released under the terms of the GNU General Public license
+ *
+ *	backpack.c is a low-level protocol driver for the Micro Solutions
+ *		"BACKPACK" parallel port IDE adapter
+ *		(Works on Series 6 drives)
+ *
+ *	Written by: Ken Hahn     (linux-dev@micro-solutions.com)
+ *		    Clive Turvey (linux-dev@micro-solutions.com)
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/io.h>
+#include <linux/parport.h>
+
+#include "ppc6lnx.c"
+#include "pata_parport.h"
+
+#define PPCSTRUCT(pi) ((struct ppc_storage *)(pi->private))
+
+#define ATAPI_DATA       0      /* data port */
+
+static int bpck6_read_regr(struct pi_adapter *pi, int cont, int reg)
+{
+	unsigned int out;
+
+	/* check for bad settings */
+	if (reg < 0 || reg > 7 || cont < 0 || cont > 2)
+		return -1;
+	out = ppc6_rd_port(PPCSTRUCT(pi), cont ? reg | 8 : reg);
+	return out;
+}
+
+static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
+{
+	/* check for bad settings */
+	if (reg >= 0 && reg <= 7 && cont >= 0 && cont <= 1)
+		ppc6_wr_port(PPCSTRUCT(pi), cont ? reg | 8 : reg, (u8)val);
+}
+
+static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
+{
+	ppc6_wr_port16_blk(PPCSTRUCT(pi), ATAPI_DATA, buf, (u32)len >> 1);
+}
+
+static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
+{
+	ppc6_rd_port16_blk(PPCSTRUCT(pi), ATAPI_DATA, buf, (u32) len >> 1);
+}
+
+static void bpck6_connect(struct pi_adapter *pi)
+{
+	if (pi->mode >= 2)
+		PPCSTRUCT(pi)->mode = 4 + pi->mode - 2;
+	else if (pi->mode == 1)
+		PPCSTRUCT(pi)->mode = 3;
+	else
+		PPCSTRUCT(pi)->mode = 1;
+
+	ppc6_open(PPCSTRUCT(pi));
+	ppc6_wr_extout(PPCSTRUCT(pi), 0x3);
+}
+
+static void bpck6_disconnect(struct pi_adapter *pi)
+{
+	ppc6_wr_extout(PPCSTRUCT(pi), 0x0);
+	ppc6_close(PPCSTRUCT(pi));
+}
+
+static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
+{
+	/* copy over duplicate stuff.. initialize state info */
+	PPCSTRUCT(pi)->ppc_id = pi->unit;
+	PPCSTRUCT(pi)->lpt_addr = pi->port;
+
+	/* look at the parport device to see if what modes we can use */
+	if (((struct pardevice *)(pi->pardev))->port->modes &
+	    (PARPORT_MODE_EPP))
+		return 5; /* Can do EPP*/
+	else if (((struct pardevice *)(pi->pardev))->port->modes &
+		 (PARPORT_MODE_TRISTATE))
+		return 2;
+	else /* Just flat SPP */
+		return 1;
+}
+
+static int bpck6_probe_unit(struct pi_adapter *pi)
+{
+	int out;
+
+	/* SET PPC UNIT NUMBER */
+	PPCSTRUCT(pi)->ppc_id = pi->unit;
+
+	/* LOWER DOWN TO UNIDIRECTIONAL */
+	PPCSTRUCT(pi)->mode = 1;
+
+	out = ppc6_open(PPCSTRUCT(pi));
+
+	if (out) {
+		ppc6_close(PPCSTRUCT(pi));
+		return 1;
+	}
+
+	return 0;
+}
+
+static void bpck6_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+{
+	static char * const mode_string[] = {
+		"4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
+
+	dev_info(&pi->dev, "bpck6, Micro Solutions BACKPACK Drive at 0x%x\n",
+		pi->port);
+	dev_info(&pi->dev, "Unit: %d Mode:%d (%s) Delay %d\n",
+		pi->unit, pi->mode, mode_string[pi->mode], pi->delay);
+}
+
+static int bpck6_init_proto(struct pi_adapter *pi)
+{
+	struct ppc_storage *p = kzalloc(sizeof(struct ppc_storage), GFP_KERNEL);
+
+	if (p) {
+		pi->private = (unsigned long)p;
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+static void bpck6_release_proto(struct pi_adapter *pi)
+{
+	kfree((void *)(pi->private));
+}
+
+static struct pi_protocol bpck6 = {
+	.owner		= THIS_MODULE,
+	.name		= "bpck6",
+	.max_mode	= 5,
+	.epp_first	= 2, /* 2-5 use epp (need 8 ports) */
+	.max_units	= 255,
+	.write_regr	= bpck6_write_regr,
+	.read_regr	= bpck6_read_regr,
+	.write_block	= bpck6_write_block,
+	.read_block	= bpck6_read_block,
+	.connect	= bpck6_connect,
+	.disconnect	= bpck6_disconnect,
+	.test_port	= bpck6_test_port,
+	.probe_unit	= bpck6_probe_unit,
+	.log_adapter	= bpck6_log_adapter,
+	.init_proto	= bpck6_init_proto,
+	.release_proto	= bpck6_release_proto,
+	.sht		= { PATA_PARPORT_SHT("pata_parport-bpck6") },
+};
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Micro Solutions Inc.");
+MODULE_DESCRIPTION("BACKPACK Protocol module, compatible with PARIDE");
+module_pata_parport_driver(bpck6);
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
new file mode 100644
index 000000000000..52e0f08548c9
--- /dev/null
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -0,0 +1,486 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	ppc6lnx.c (c) 2001 Micro Solutions Inc.
+ *		Released under the terms of the GNU General Public license
+ *
+ *	ppc6lnx.c  is a part of the protocol driver for the Micro Solutions
+ *		"BACKPACK" parallel port IDE adapter
+ *		(Works on Series 6 drives)
+ */
+
+/* PPC 6 Code in C sanitized for LINUX */
+/* Original x86 ASM by Ron, Converted to C by Clive */
+
+#define port_stb	1
+#define port_afd	2
+#define cmd_stb		port_afd
+#define port_init	4
+#define data_stb	port_init
+#define port_sel	8
+#define port_int	16
+#define port_dir	0x20
+
+#define ECR_EPP		0x80
+#define ECR_BI		0x20
+
+/* 60772 Commands */
+#define ACCESS_REG	0x00
+#define ACCESS_PORT	0x40
+
+#define ACCESS_READ	0x00
+#define ACCESS_WRITE	0x20
+
+/* 60772 Command Prefix */
+
+#define CMD_PREFIX_SET		0xe0	/* Special cmd that modifies the next command's operation */
+#define CMD_PREFIX_RESET	0xc0	/* Resets current cmd modifier reg bits */
+ #define PREFIX_IO16		0x01	/* perform 16-bit wide I/O */
+ #define PREFIX_FASTWR		0x04	/* enable PPC mode fast-write */
+ #define PREFIX_BLK		0x08	/* enable block transfer mode */
+
+/* 60772 Registers */
+
+#define REG_STATUS		0x00	/* status register */
+ #define STATUS_IRQA		0x01	/* Peripheral IRQA line */
+ #define STATUS_EEPROM_DO	0x40	/* Serial EEPROM data bit */
+#define REG_VERSION		0x01	/* PPC version register (read) */
+#define REG_HWCFG		0x02	/* Hardware Config register */
+#define REG_RAMSIZE		0x03	/* Size of RAM Buffer */
+ #define RAMSIZE_128K		0x02
+#define REG_EEPROM		0x06	/* EEPROM control register */
+ #define EEPROM_SK		0x01	/* eeprom SK bit */
+ #define EEPROM_DI		0x02	/* eeprom DI bit */
+ #define EEPROM_CS		0x04	/* eeprom CS bit */
+ #define EEPROM_EN		0x08	/* eeprom output enable */
+#define REG_BLKSIZE		0x08	/* Block transfer len (24 bit) */
+
+struct ppc_storage {
+	u16	lpt_addr;		/* LPT base address */
+	u8	ppc_id;
+	u8	mode;			/* operating mode */
+					/* 0 = PPC Uni SW */
+					/* 1 = PPC Uni FW */
+					/* 2 = PPC Bi SW */
+					/* 3 = PPC Bi FW */
+					/* 4 = EPP Byte */
+					/* 5 = EPP Word */
+					/* 6 = EPP Dword */
+	u8	ppc_flags;
+	u8	org_data;		/* original LPT data port contents */
+	u8	org_ctrl;		/* original LPT control port contents */
+	u8	cur_ctrl;		/* current control port contents */
+};
+
+/* ppc_flags */
+#define fifo_wait		0x10
+
+/* DONT CHANGE THESE LEST YOU BREAK EVERYTHING - BIT FIELD DEPENDENCIES */
+#define PPCMODE_UNI_SW		0
+#define PPCMODE_UNI_FW		1
+#define PPCMODE_BI_SW		2
+#define PPCMODE_BI_FW		3
+#define PPCMODE_EPP_BYTE	4
+#define PPCMODE_EPP_WORD	5
+#define PPCMODE_EPP_DWORD	6
+
+static int ppc6_select(struct ppc_storage *ppc);
+static void ppc6_deselect(struct ppc_storage *ppc);
+static void ppc6_send_cmd(struct ppc_storage *ppc, u8 cmd);
+static void ppc6_wr_data_byte(struct ppc_storage *ppc, u8 data);
+static u8 ppc6_rd_data_byte(struct ppc_storage *ppc);
+static u8 ppc6_rd_port(struct ppc_storage *ppc, u8 port);
+static void ppc6_wr_port(struct ppc_storage *ppc, u8 port, u8 data);
+static void ppc6_rd_data_blk(struct ppc_storage *ppc, u8 *data, long count);
+static void ppc6_wait_for_fifo(struct ppc_storage *ppc);
+static void ppc6_wr_data_blk(struct ppc_storage *ppc, u8 *data, long count);
+static void ppc6_rd_port16_blk(struct ppc_storage *ppc, u8 port, u8 *data, long length);
+static void ppc6_wr_port16_blk(struct ppc_storage *ppc, u8 port, u8 *data, long length);
+static void ppc6_wr_extout(struct ppc_storage *ppc, u8 regdata);
+static int ppc6_open(struct ppc_storage *ppc);
+static void ppc6_close(struct ppc_storage *ppc);
+
+static int ppc6_select(struct ppc_storage *ppc)
+{
+	u8 i, j, k;
+
+	i = inb(ppc->lpt_addr + 1);
+	if (i & 1)
+		outb(i, ppc->lpt_addr + 1);
+
+	ppc->org_data = inb(ppc->lpt_addr);
+	ppc->org_ctrl = inb(ppc->lpt_addr + 2) & 0x5F; /* readback ctrl */
+	ppc->cur_ctrl = ppc->org_ctrl;
+	ppc->cur_ctrl |= port_sel;
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	if (ppc->org_data == 'b')
+		outb('x', ppc->lpt_addr);
+	outb('b', ppc->lpt_addr);
+	outb('p', ppc->lpt_addr);
+	outb(ppc->ppc_id, ppc->lpt_addr);
+	outb(~ppc->ppc_id, ppc->lpt_addr);
+	ppc->cur_ctrl &= ~port_sel;
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	ppc->cur_ctrl = (ppc->cur_ctrl & port_int) | port_init;
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	i = ppc->mode & 0x0C;
+	if (i == 0)
+		i = (ppc->mode & 2) | 1;
+	outb(i, ppc->lpt_addr);
+	ppc->cur_ctrl |= port_sel;
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	/* DELAY */
+	ppc->cur_ctrl |= port_afd;
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	j = ((i & 0x08) << 4) | ((i & 0x07) << 3);
+	k = inb(ppc->lpt_addr + 1) & 0xB8;
+	if (j == k) {
+		ppc->cur_ctrl &= ~port_afd;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		k = (inb(ppc->lpt_addr + 1) & 0xB8) ^ 0xB8;
+		if (j == k) {
+			if (i & 4)	/* EPP */
+				ppc->cur_ctrl &= ~(port_sel | port_init);
+			else		/* PPC/ECP */
+				ppc->cur_ctrl &= ~port_sel;
+
+			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+
+			return 1;
+		}
+	}
+	outb(ppc->org_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->org_data, ppc->lpt_addr);
+
+	return 0; /* FAIL */
+}
+
+static void ppc6_deselect(struct ppc_storage *ppc)
+{
+	if (ppc->mode & 4)	/* EPP */
+		ppc->cur_ctrl |= port_init;
+	else			/* PPC/ECP */
+		ppc->cur_ctrl |= port_sel;
+
+	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->org_data, ppc->lpt_addr);
+	outb((ppc->org_ctrl | port_sel), ppc->lpt_addr + 2);
+	outb(ppc->org_ctrl, ppc->lpt_addr + 2);
+}
+
+static void ppc6_send_cmd(struct ppc_storage *ppc, u8 cmd)
+{
+	switch (ppc->mode) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		outb(cmd, ppc->lpt_addr);
+		ppc->cur_ctrl ^= cmd_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_BYTE:
+	case PPCMODE_EPP_WORD:
+	case PPCMODE_EPP_DWORD:
+		outb(cmd, ppc->lpt_addr + 3);
+		break;
+	}
+}
+
+static void ppc6_wr_data_byte(struct ppc_storage *ppc, u8 data)
+{
+	switch (ppc->mode) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		outb(data, ppc->lpt_addr);
+		ppc->cur_ctrl ^= data_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_BYTE:
+	case PPCMODE_EPP_WORD:
+	case PPCMODE_EPP_DWORD:
+		outb(data, ppc->lpt_addr + 4);
+		break;
+	}
+}
+
+static u8 ppc6_rd_data_byte(struct ppc_storage *ppc)
+{
+	u8 data = 0;
+
+	switch (ppc->mode) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+		ppc->cur_ctrl = (ppc->cur_ctrl & ~port_stb) ^ data_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		/* DELAY */
+		data = inb(ppc->lpt_addr + 1);
+		data = ((data & 0x80) >> 1) | ((data & 0x38) >> 3);
+		ppc->cur_ctrl |= port_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		/* DELAY */
+		data |= inb(ppc->lpt_addr + 1) & 0xB8;
+		break;
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		ppc->cur_ctrl |= port_dir;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		ppc->cur_ctrl = (ppc->cur_ctrl | port_stb) ^ data_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		data = inb(ppc->lpt_addr);
+		ppc->cur_ctrl &= ~port_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		ppc->cur_ctrl &= ~port_dir;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_BYTE:
+	case PPCMODE_EPP_WORD:
+	case PPCMODE_EPP_DWORD:
+		outb((ppc->cur_ctrl | port_dir), ppc->lpt_addr + 2);
+		data = inb(ppc->lpt_addr + 4);
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	}
+
+	return data;
+}
+
+static u8 ppc6_rd_port(struct ppc_storage *ppc, u8 port)
+{
+	ppc6_send_cmd(ppc, port | ACCESS_PORT | ACCESS_READ);
+
+	return ppc6_rd_data_byte(ppc);
+}
+
+static void ppc6_wr_port(struct ppc_storage *ppc, u8 port, u8 data)
+{
+	ppc6_send_cmd(ppc, port | ACCESS_PORT | ACCESS_WRITE);
+
+	ppc6_wr_data_byte(ppc, data);
+}
+
+static void ppc6_rd_data_blk(struct ppc_storage *ppc, u8 *data, long count)
+{
+	switch (ppc->mode) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+		while (count) {
+			u8 d;
+
+			ppc->cur_ctrl = (ppc->cur_ctrl & ~port_stb) ^ data_stb;
+			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			/* DELAY */
+			d = inb(ppc->lpt_addr + 1);
+			d = ((d & 0x80) >> 1) | ((d & 0x38) >> 3);
+			ppc->cur_ctrl |= port_stb;
+			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			/* DELAY */
+			d |= inb(ppc->lpt_addr + 1) & 0xB8;
+			*data++ = d;
+			count--;
+		}
+		break;
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		ppc->cur_ctrl |= port_dir;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		ppc->cur_ctrl |= port_stb;
+		while (count) {
+			ppc->cur_ctrl ^= data_stb;
+			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			*data++ = inb(ppc->lpt_addr);
+			count--;
+		}
+		ppc->cur_ctrl &= ~port_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		ppc->cur_ctrl &= ~port_dir;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_BYTE:
+		outb((ppc->cur_ctrl | port_dir), ppc->lpt_addr + 2);
+		/* DELAY */
+		while (count) {
+			*data++ = inb(ppc->lpt_addr + 4);
+			count--;
+		}
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_WORD:
+		outb((ppc->cur_ctrl | port_dir), ppc->lpt_addr + 2);
+		/* DELAY */
+		while (count > 1) {
+			*((u16 *)data) = inw(ppc->lpt_addr + 4);
+			data  += 2;
+			count -= 2;
+		}
+		while (count) {
+			*data++ = inb(ppc->lpt_addr + 4);
+			count--;
+		}
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	case PPCMODE_EPP_DWORD:
+		outb((ppc->cur_ctrl | port_dir), ppc->lpt_addr + 2);
+		/* DELAY */
+		while (count > 3) {
+			*((u32 *)data) = inl(ppc->lpt_addr + 4);
+			data  += 4;
+			count -= 4;
+		}
+		while (count) {
+			*data++ = inb(ppc->lpt_addr + 4);
+			count--;
+		}
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		break;
+	}
+}
+
+static void ppc6_wait_for_fifo(struct ppc_storage *ppc)
+{
+	int i;
+
+	if (ppc->ppc_flags & fifo_wait)
+		for (i = 0; i < 20; i++)
+			inb(ppc->lpt_addr + 1);
+}
+
+static void ppc6_wr_data_blk(struct ppc_storage *ppc, u8 *data, long count)
+{
+	u8 this, last;
+
+	switch (ppc->mode) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_BI_SW:
+		while (count--)	{
+			outb(*data++, ppc->lpt_addr);
+			ppc->cur_ctrl ^= data_stb;
+			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		}
+		break;
+	case PPCMODE_UNI_FW:
+	case PPCMODE_BI_FW:
+		ppc6_send_cmd(ppc, CMD_PREFIX_SET | PREFIX_FASTWR);
+		ppc->cur_ctrl |= port_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		last = *data;
+		outb(last, ppc->lpt_addr);
+		while (count) {
+			this = *data++;
+			count--;
+
+			if (this == last) {
+				ppc->cur_ctrl ^= data_stb;
+				outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			} else {
+				outb(this, ppc->lpt_addr);
+				last = this;
+			}
+		}
+		ppc->cur_ctrl &= ~port_stb;
+		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		ppc6_send_cmd(ppc, CMD_PREFIX_RESET | PREFIX_FASTWR);
+		break;
+	case PPCMODE_EPP_BYTE:
+		while (count) {
+			outb(*data++, ppc->lpt_addr + 4);
+			count--;
+		}
+		ppc6_wait_for_fifo(ppc);
+		break;
+	case PPCMODE_EPP_WORD:
+		while (count > 1) {
+			outw(*((u16 *)data), ppc->lpt_addr + 4);
+			data  += 2;
+			count -= 2;
+		}
+		while (count) {
+			outb(*data++, ppc->lpt_addr + 4);
+			count--;
+		}
+		ppc6_wait_for_fifo(ppc);
+		break;
+	case PPCMODE_EPP_DWORD:
+		while (count > 3) {
+			outl(*((u32 *)data), ppc->lpt_addr + 4);
+			data  += 4;
+			count -= 4;
+		}
+		while (count) {
+			outb(*data++, ppc->lpt_addr + 4);
+			count--;
+		}
+		ppc6_wait_for_fifo(ppc);
+		break;
+	}
+}
+
+static void ppc6_rd_port16_blk(struct ppc_storage *ppc, u8 port, u8 *data, long length)
+{
+	length = length << 1;
+
+	ppc6_send_cmd(ppc, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
+	ppc6_wr_data_byte(ppc, (u8)length);
+	ppc6_wr_data_byte(ppc, (u8)(length >> 8));
+	ppc6_wr_data_byte(ppc, 0);
+
+	ppc6_send_cmd(ppc, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
+
+	ppc6_send_cmd(ppc, port | ACCESS_PORT | ACCESS_READ);
+
+	ppc6_rd_data_blk(ppc, data, length);
+
+	ppc6_send_cmd(ppc, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
+}
+
+static void ppc6_wr_port16_blk(struct ppc_storage *ppc, u8 port, u8 *data, long length)
+{
+	length = length << 1;
+
+	ppc6_send_cmd(ppc, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
+	ppc6_wr_data_byte(ppc, (u8)length);
+	ppc6_wr_data_byte(ppc, (u8)(length >> 8));
+	ppc6_wr_data_byte(ppc, 0);
+
+	ppc6_send_cmd(ppc, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
+
+	ppc6_send_cmd(ppc, port | ACCESS_PORT | ACCESS_WRITE);
+
+	ppc6_wr_data_blk(ppc, data, length);
+
+	ppc6_send_cmd(ppc, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
+}
+
+static void ppc6_wr_extout(struct ppc_storage *ppc, u8 regdata)
+{
+	ppc6_send_cmd(ppc, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
+
+	ppc6_wr_data_byte(ppc, (regdata & 0x03) << 6);
+}
+
+static int ppc6_open(struct ppc_storage *ppc)
+{
+	int ret;
+
+	ret = ppc6_select(ppc);
+	if (ret == 0)
+		return ret;
+
+	ppc->ppc_flags &= ~fifo_wait;
+
+	ppc6_send_cmd(ppc, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
+	ppc6_wr_data_byte(ppc, RAMSIZE_128K);
+
+	ppc6_send_cmd(ppc, ACCESS_REG | ACCESS_READ | REG_VERSION);
+
+	if ((ppc6_rd_data_byte(ppc) & 0x3F) == 0x0C)
+		ppc->ppc_flags |= fifo_wait;
+
+	return ret;
+}
+
+static void ppc6_close(struct ppc_storage *ppc)
+{
+	ppc6_deselect(ppc);
+}
-- 
Ondrej Zary

