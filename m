Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10E4463C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbhK3Qtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:49:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37096 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbhK3Qte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:49:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 740031FD58;
        Tue, 30 Nov 2021 16:46:13 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 26F54A3B94;
        Tue, 30 Nov 2021 16:46:13 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     geert@linux-m68k.org
Subject: [PATCH 2/3] MIPS: TXX9: Remove rbtx4939 board support
Date:   Tue, 30 Nov 2021 17:45:55 +0100
Message-Id: <20211130164558.85584-2-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211130164558.85584-1-tsbogend@alpha.franken.de>
References: <20211130164558.85584-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No active MIPS user own this board, so let's remove it.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/configs/rbtx49xx_defconfig          |   2 -
 .../include/asm/mach-tx49xx/mangle-port.h     |   8 -
 arch/mips/include/asm/txx9/boards.h           |   3 -
 arch/mips/include/asm/txx9/rbtx4939.h         | 142 -----
 arch/mips/txx9/Kconfig                        |  12 -
 arch/mips/txx9/Makefile                       |   1 -
 arch/mips/txx9/generic/7segled.c              | 123 ----
 arch/mips/txx9/generic/Makefile               |   1 -
 arch/mips/txx9/generic/setup.c                |  20 -
 arch/mips/txx9/rbtx4939/Makefile              |   2 -
 arch/mips/txx9/rbtx4939/irq.c                 |  95 ---
 arch/mips/txx9/rbtx4939/prom.c                |  29 -
 arch/mips/txx9/rbtx4939/setup.c               | 554 ------------------
 drivers/mtd/maps/Kconfig                      |   6 -
 drivers/mtd/maps/Makefile                     |   1 -
 drivers/mtd/maps/rbtx4939-flash.c             | 133 -----
 16 files changed, 1132 deletions(-)
 delete mode 100644 arch/mips/include/asm/txx9/rbtx4939.h
 delete mode 100644 arch/mips/txx9/generic/7segled.c
 delete mode 100644 arch/mips/txx9/rbtx4939/Makefile
 delete mode 100644 arch/mips/txx9/rbtx4939/irq.c
 delete mode 100644 arch/mips/txx9/rbtx4939/prom.c
 delete mode 100644 arch/mips/txx9/rbtx4939/setup.c
 delete mode 100644 drivers/mtd/maps/rbtx4939-flash.c

diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index 5e62923c6774..f8212a813be7 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -10,7 +10,6 @@ CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_MACH_TX49XX=y
 CONFIG_TOSHIBA_RBTX4927=y
-CONFIG_TOSHIBA_RBTX4939=y
 # CONFIG_SECCOMP is not set
 CONFIG_PCI=y
 CONFIG_MODULES=y
@@ -36,7 +35,6 @@ CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_RBTX4939=y
 CONFIG_MTD_RAW_NAND=m
 CONFIG_MTD_NAND_TXX9NDFMC=m
 CONFIG_BLK_DEV_LOOP=y
diff --git a/arch/mips/include/asm/mach-tx49xx/mangle-port.h b/arch/mips/include/asm/mach-tx49xx/mangle-port.h
index 98c7abf4484a..50b1b8f1e186 100644
--- a/arch/mips/include/asm/mach-tx49xx/mangle-port.h
+++ b/arch/mips/include/asm/mach-tx49xx/mangle-port.h
@@ -9,16 +9,8 @@
 
 #define ioswabb(a, x)		(x)
 #define __mem_ioswabb(a, x)	(x)
-#if defined(CONFIG_TOSHIBA_RBTX4939) && \
-	IS_ENABLED(CONFIG_SMC91X) && \
-	defined(__BIG_ENDIAN)
-#define NEEDS_TXX9_IOSWABW
-extern u16 (*ioswabw)(volatile u16 *a, u16 x);
-extern u16 (*__mem_ioswabw)(volatile u16 *a, u16 x);
-#else
 #define ioswabw(a, x)		le16_to_cpu((__force __le16)(x))
 #define __mem_ioswabw(a, x)	(x)
-#endif
 #define ioswabl(a, x)		le32_to_cpu((__force __le32)(x))
 #define __mem_ioswabl(a, x)	(x)
 #define ioswabq(a, x)		le64_to_cpu((__force __le64)(x))
diff --git a/arch/mips/include/asm/txx9/boards.h b/arch/mips/include/asm/txx9/boards.h
index 0f6ae53a3a1b..70284e90dc53 100644
--- a/arch/mips/include/asm/txx9/boards.h
+++ b/arch/mips/include/asm/txx9/boards.h
@@ -6,6 +6,3 @@ BOARD_VEC(jmr3927_vec)
 BOARD_VEC(rbtx4927_vec)
 BOARD_VEC(rbtx4937_vec)
 #endif
-#ifdef CONFIG_TOSHIBA_RBTX4939
-BOARD_VEC(rbtx4939_vec)
-#endif
diff --git a/arch/mips/include/asm/txx9/rbtx4939.h b/arch/mips/include/asm/txx9/rbtx4939.h
deleted file mode 100644
index 6157bfd90848..000000000000
--- a/arch/mips/include/asm/txx9/rbtx4939.h
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- * Definitions for RBTX4939
- *
- * (C) Copyright TOSHIBA CORPORATION 2005-2006
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __ASM_TXX9_RBTX4939_H
-#define __ASM_TXX9_RBTX4939_H
-
-#include <asm/addrspace.h>
-#include <asm/txx9irq.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/tx4939.h>
-
-/* Address map */
-#define RBTX4939_IOC_REG_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000000)
-#define RBTX4939_BOARD_REV_ADDR (IO_BASE + TXX9_CE(1) + 0x00000000)
-#define RBTX4939_IOC_REV_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000002)
-#define RBTX4939_CONFIG1_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000004)
-#define RBTX4939_CONFIG2_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000006)
-#define RBTX4939_CONFIG3_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000008)
-#define RBTX4939_CONFIG4_ADDR	(IO_BASE + TXX9_CE(1) + 0x0000000a)
-#define RBTX4939_USTAT_ADDR	(IO_BASE + TXX9_CE(1) + 0x00001000)
-#define RBTX4939_UDIPSW_ADDR	(IO_BASE + TXX9_CE(1) + 0x00001002)
-#define RBTX4939_BDIPSW_ADDR	(IO_BASE + TXX9_CE(1) + 0x00001004)
-#define RBTX4939_IEN_ADDR	(IO_BASE + TXX9_CE(1) + 0x00002000)
-#define RBTX4939_IPOL_ADDR	(IO_BASE + TXX9_CE(1) + 0x00002002)
-#define RBTX4939_IFAC1_ADDR	(IO_BASE + TXX9_CE(1) + 0x00002004)
-#define RBTX4939_IFAC2_ADDR	(IO_BASE + TXX9_CE(1) + 0x00002006)
-#define RBTX4939_SOFTINT_ADDR	(IO_BASE + TXX9_CE(1) + 0x00003000)
-#define RBTX4939_ISASTAT_ADDR	(IO_BASE + TXX9_CE(1) + 0x00004000)
-#define RBTX4939_PCISTAT_ADDR	(IO_BASE + TXX9_CE(1) + 0x00004002)
-#define RBTX4939_ROME_ADDR	(IO_BASE + TXX9_CE(1) + 0x00004004)
-#define RBTX4939_SPICS_ADDR	(IO_BASE + TXX9_CE(1) + 0x00004006)
-#define RBTX4939_AUDI_ADDR	(IO_BASE + TXX9_CE(1) + 0x00004008)
-#define RBTX4939_ISAGPIO_ADDR	(IO_BASE + TXX9_CE(1) + 0x0000400a)
-#define RBTX4939_PE1_ADDR	(IO_BASE + TXX9_CE(1) + 0x00005000)
-#define RBTX4939_PE2_ADDR	(IO_BASE + TXX9_CE(1) + 0x00005002)
-#define RBTX4939_PE3_ADDR	(IO_BASE + TXX9_CE(1) + 0x00005004)
-#define RBTX4939_VP_ADDR	(IO_BASE + TXX9_CE(1) + 0x00005006)
-#define RBTX4939_VPRESET_ADDR	(IO_BASE + TXX9_CE(1) + 0x00005008)
-#define RBTX4939_VPSOUT_ADDR	(IO_BASE + TXX9_CE(1) + 0x0000500a)
-#define RBTX4939_VPSIN_ADDR	(IO_BASE + TXX9_CE(1) + 0x0000500c)
-#define RBTX4939_7SEG_ADDR(s, ch)	\
-	(IO_BASE + TXX9_CE(1) + 0x00006000 + (s) * 16 + ((ch) & 3) * 2)
-#define RBTX4939_SOFTRESET_ADDR (IO_BASE + TXX9_CE(1) + 0x00007000)
-#define RBTX4939_RESETEN_ADDR	(IO_BASE + TXX9_CE(1) + 0x00007002)
-#define RBTX4939_RESETSTAT_ADDR (IO_BASE + TXX9_CE(1) + 0x00007004)
-#define RBTX4939_ETHER_BASE	(IO_BASE + TXX9_CE(1) + 0x00020000)
-
-/* Ethernet port address */
-#define RBTX4939_ETHER_ADDR	(RBTX4939_ETHER_BASE + 0x300)
-
-/* bits for IEN/IPOL/IFAC */
-#define RBTX4938_INTB_ISA0	0
-#define RBTX4938_INTB_ISA11	1
-#define RBTX4938_INTB_ISA12	2
-#define RBTX4938_INTB_ISA15	3
-#define RBTX4938_INTB_I2S	4
-#define RBTX4938_INTB_SW	5
-#define RBTX4938_INTF_ISA0	(1 << RBTX4938_INTB_ISA0)
-#define RBTX4938_INTF_ISA11	(1 << RBTX4938_INTB_ISA11)
-#define RBTX4938_INTF_ISA12	(1 << RBTX4938_INTB_ISA12)
-#define RBTX4938_INTF_ISA15	(1 << RBTX4938_INTB_ISA15)
-#define RBTX4938_INTF_I2S	(1 << RBTX4938_INTB_I2S)
-#define RBTX4938_INTF_SW	(1 << RBTX4938_INTB_SW)
-
-/* bits for PE1,PE2,PE3 */
-#define RBTX4939_PE1_ATA(ch)	(0x01 << (ch))
-#define RBTX4939_PE1_RMII(ch)	(0x04 << (ch))
-#define RBTX4939_PE2_SIO0	0x01
-#define RBTX4939_PE2_SIO2	0x02
-#define RBTX4939_PE2_SIO3	0x04
-#define RBTX4939_PE2_CIR	0x08
-#define RBTX4939_PE2_SPI	0x10
-#define RBTX4939_PE2_GPIO	0x20
-#define RBTX4939_PE3_VP 0x01
-#define RBTX4939_PE3_VP_P	0x02
-#define RBTX4939_PE3_VP_S	0x04
-
-#define rbtx4939_board_rev_addr ((u8 __iomem *)RBTX4939_BOARD_REV_ADDR)
-#define rbtx4939_ioc_rev_addr	((u8 __iomem *)RBTX4939_IOC_REV_ADDR)
-#define rbtx4939_config1_addr	((u8 __iomem *)RBTX4939_CONFIG1_ADDR)
-#define rbtx4939_config2_addr	((u8 __iomem *)RBTX4939_CONFIG2_ADDR)
-#define rbtx4939_config3_addr	((u8 __iomem *)RBTX4939_CONFIG3_ADDR)
-#define rbtx4939_config4_addr	((u8 __iomem *)RBTX4939_CONFIG4_ADDR)
-#define rbtx4939_ustat_addr	((u8 __iomem *)RBTX4939_USTAT_ADDR)
-#define rbtx4939_udipsw_addr	((u8 __iomem *)RBTX4939_UDIPSW_ADDR)
-#define rbtx4939_bdipsw_addr	((u8 __iomem *)RBTX4939_BDIPSW_ADDR)
-#define rbtx4939_ien_addr	((u8 __iomem *)RBTX4939_IEN_ADDR)
-#define rbtx4939_ipol_addr	((u8 __iomem *)RBTX4939_IPOL_ADDR)
-#define rbtx4939_ifac1_addr	((u8 __iomem *)RBTX4939_IFAC1_ADDR)
-#define rbtx4939_ifac2_addr	((u8 __iomem *)RBTX4939_IFAC2_ADDR)
-#define rbtx4939_softint_addr	((u8 __iomem *)RBTX4939_SOFTINT_ADDR)
-#define rbtx4939_isastat_addr	((u8 __iomem *)RBTX4939_ISASTAT_ADDR)
-#define rbtx4939_pcistat_addr	((u8 __iomem *)RBTX4939_PCISTAT_ADDR)
-#define rbtx4939_rome_addr	((u8 __iomem *)RBTX4939_ROME_ADDR)
-#define rbtx4939_spics_addr	((u8 __iomem *)RBTX4939_SPICS_ADDR)
-#define rbtx4939_audi_addr	((u8 __iomem *)RBTX4939_AUDI_ADDR)
-#define rbtx4939_isagpio_addr	((u8 __iomem *)RBTX4939_ISAGPIO_ADDR)
-#define rbtx4939_pe1_addr	((u8 __iomem *)RBTX4939_PE1_ADDR)
-#define rbtx4939_pe2_addr	((u8 __iomem *)RBTX4939_PE2_ADDR)
-#define rbtx4939_pe3_addr	((u8 __iomem *)RBTX4939_PE3_ADDR)
-#define rbtx4939_vp_addr	((u8 __iomem *)RBTX4939_VP_ADDR)
-#define rbtx4939_vpreset_addr	((u8 __iomem *)RBTX4939_VPRESET_ADDR)
-#define rbtx4939_vpsout_addr	((u8 __iomem *)RBTX4939_VPSOUT_ADDR)
-#define rbtx4939_vpsin_addr	((u8 __iomem *)RBTX4939_VPSIN_ADDR)
-#define rbtx4939_7seg_addr(s, ch) \
-				((u8 __iomem *)RBTX4939_7SEG_ADDR(s, ch))
-#define rbtx4939_softreset_addr ((u8 __iomem *)RBTX4939_SOFTRESET_ADDR)
-#define rbtx4939_reseten_addr	((u8 __iomem *)RBTX4939_RESETEN_ADDR)
-#define rbtx4939_resetstat_addr ((u8 __iomem *)RBTX4939_RESETSTAT_ADDR)
-
-/*
- * IRQ mappings
- */
-#define RBTX4939_NR_IRQ_IOC	8
-
-#define RBTX4939_IRQ_IOC	(TXX9_IRQ_BASE + TX4939_NUM_IR)
-#define RBTX4939_IRQ_END	(RBTX4939_IRQ_IOC + RBTX4939_NR_IRQ_IOC)
-
-/* IOC (ISA, etc) */
-#define RBTX4939_IRQ_IOCINT	(TXX9_IRQ_BASE + TX4939_IR_INT(0))
-/* Onboard 10M Ether */
-#define RBTX4939_IRQ_ETHER	(TXX9_IRQ_BASE + TX4939_IR_INT(1))
-
-void rbtx4939_prom_init(void);
-void rbtx4939_irq_setup(void);
-
-struct mtd_partition;
-struct map_info;
-struct rbtx4939_flash_data {
-	unsigned int width;
-	unsigned int nr_parts;
-	struct mtd_partition *parts;
-	void (*map_init)(struct map_info *map);
-};
-
-#endif /* __ASM_TXX9_RBTX4939_H */
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index a5484c284353..9e5e33a09cf9 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -39,15 +39,6 @@ config TOSHIBA_RBTX4927
 	  This Toshiba board is based on the TX4927 processor. Say Y here to
 	  support this machine type
 
-config TOSHIBA_RBTX4939
-	bool "Toshiba RBTX4939 board"
-	depends on MACH_TX49XX
-	select SOC_TX4939
-	select TXX9_7SEGLED
-	help
-	  This Toshiba board is based on the TX4939 processor. Say Y here to
-	  support this machine type
-
 config SOC_TX3927
 	bool
 	select CEVT_TXX9
@@ -84,9 +75,6 @@ config SOC_TX4939
 	select PCI_TX4927
 	imply HAS_TXX9_ACLC
 
-config TXX9_7SEGLED
-	bool
-
 config TOSHIBA_FPCIB0
 	bool "FPCIB0 Backplane Support"
 	depends on PCI && MACH_TXX9
diff --git a/arch/mips/txx9/Makefile b/arch/mips/txx9/Makefile
index c8eeca8fa3d5..53269910a48b 100644
--- a/arch/mips/txx9/Makefile
+++ b/arch/mips/txx9/Makefile
@@ -14,4 +14,3 @@ obj-$(CONFIG_TOSHIBA_JMR3927)  += jmr3927/
 # Toshiba RBTX49XX boards
 #
 obj-$(CONFIG_TOSHIBA_RBTX4927) += rbtx4927/
-obj-$(CONFIG_TOSHIBA_RBTX4939) += rbtx4939/
diff --git a/arch/mips/txx9/generic/7segled.c b/arch/mips/txx9/generic/7segled.c
deleted file mode 100644
index 2203c2548cb4..000000000000
--- a/arch/mips/txx9/generic/7segled.c
+++ /dev/null
@@ -1,123 +0,0 @@
-/*
- * 7 Segment LED routines
- * Based on RBTX49xx patch from CELF patch archive.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * (C) Copyright TOSHIBA CORPORATION 2005-2007
- * All Rights Reserved.
- */
-#include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/map_to_7segment.h>
-#include <asm/txx9/generic.h>
-
-static unsigned int tx_7segled_num;
-static void (*tx_7segled_putc)(unsigned int pos, unsigned char val);
-
-void __init txx9_7segled_init(unsigned int num,
-			      void (*putc)(unsigned int pos, unsigned char val))
-{
-	tx_7segled_num = num;
-	tx_7segled_putc = putc;
-}
-
-static SEG7_CONVERSION_MAP(txx9_seg7map, MAP_ASCII7SEG_ALPHANUM_LC);
-
-int txx9_7segled_putc(unsigned int pos, char c)
-{
-	if (pos >= tx_7segled_num)
-		return -EINVAL;
-	c = map_to_seg7(&txx9_seg7map, c);
-	if (c < 0)
-		return c;
-	tx_7segled_putc(pos, c);
-	return 0;
-}
-
-static ssize_t ascii_store(struct device *dev,
-			   struct device_attribute *attr,
-			   const char *buf, size_t size)
-{
-	unsigned int ch = dev->id;
-	txx9_7segled_putc(ch, buf[0]);
-	return size;
-}
-
-static ssize_t raw_store(struct device *dev,
-			 struct device_attribute *attr,
-			 const char *buf, size_t size)
-{
-	unsigned int ch = dev->id;
-	tx_7segled_putc(ch, buf[0]);
-	return size;
-}
-
-static DEVICE_ATTR_WO(ascii);
-static DEVICE_ATTR_WO(raw);
-
-static ssize_t map_seg7_show(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	memcpy(buf, &txx9_seg7map, sizeof(txx9_seg7map));
-	return sizeof(txx9_seg7map);
-}
-
-static ssize_t map_seg7_store(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf, size_t size)
-{
-	if (size != sizeof(txx9_seg7map))
-		return -EINVAL;
-	memcpy(&txx9_seg7map, buf, size);
-	return size;
-}
-
-static DEVICE_ATTR(map_seg7, 0600, map_seg7_show, map_seg7_store);
-
-static struct bus_type tx_7segled_subsys = {
-	.name		= "7segled",
-	.dev_name	= "7segled",
-};
-
-static void tx_7segled_release(struct device *dev)
-{
-	kfree(dev);
-}
-
-static int __init tx_7segled_init_sysfs(void)
-{
-	int error, i;
-	if (!tx_7segled_num)
-		return -ENODEV;
-	error = subsys_system_register(&tx_7segled_subsys, NULL);
-	if (error)
-		return error;
-	error = device_create_file(tx_7segled_subsys.dev_root, &dev_attr_map_seg7);
-	if (error)
-		return error;
-	for (i = 0; i < tx_7segled_num; i++) {
-		struct device *dev;
-		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-		if (!dev) {
-			error = -ENODEV;
-			break;
-		}
-		dev->id = i;
-		dev->bus = &tx_7segled_subsys;
-		dev->release = &tx_7segled_release;
-		error = device_register(dev);
-		if (error) {
-			put_device(dev);
-			return error;
-		}
-		device_create_file(dev, &dev_attr_ascii);
-		device_create_file(dev, &dev_attr_raw);
-	}
-	return error;
-}
-
-device_initcall(tx_7segled_init_sysfs);
diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index 76caa756ec2b..62b6dc6915e3 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -10,4 +10,3 @@ obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o setup_tx4927.o irq_tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o setup_tx4938.o irq_tx4938.o
 obj-$(CONFIG_SOC_TX4939)	+= setup_tx4939.o irq_tx4939.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
-obj-$(CONFIG_TXX9_7SEGLED)	+= 7segled.o
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 5c42da622b8b..c2743165e9a7 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -314,11 +314,6 @@ static void __init select_board(void)
 	case 0x4937:
 		txx9_board_vec = &rbtx4937_vec;
 		break;
-#endif
-#ifdef CONFIG_TOSHIBA_RBTX4939
-	case 0x4939:
-		txx9_board_vec = &rbtx4939_vec;
-		break;
 #endif
 	}
 #endif
@@ -585,21 +580,6 @@ unsigned long (*__swizzle_addr_b)(unsigned long port) = __swizzle_addr_none;
 EXPORT_SYMBOL(__swizzle_addr_b);
 #endif
 
-#ifdef NEEDS_TXX9_IOSWABW
-static u16 ioswabw_default(volatile u16 *a, u16 x)
-{
-	return le16_to_cpu(x);
-}
-static u16 __mem_ioswabw_default(volatile u16 *a, u16 x)
-{
-	return x;
-}
-u16 (*ioswabw)(volatile u16 *a, u16 x) = ioswabw_default;
-EXPORT_SYMBOL(ioswabw);
-u16 (*__mem_ioswabw)(volatile u16 *a, u16 x) = __mem_ioswabw_default;
-EXPORT_SYMBOL(__mem_ioswabw);
-#endif
-
 void __init txx9_physmap_flash_init(int no, unsigned long addr,
 				    unsigned long size,
 				    const struct physmap_flash_data *pdata)
diff --git a/arch/mips/txx9/rbtx4939/Makefile b/arch/mips/txx9/rbtx4939/Makefile
deleted file mode 100644
index 840496e7a76e..000000000000
--- a/arch/mips/txx9/rbtx4939/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y	 += irq.o setup.o prom.o
diff --git a/arch/mips/txx9/rbtx4939/irq.c b/arch/mips/txx9/rbtx4939/irq.c
deleted file mode 100644
index 69a80616f0c9..000000000000
--- a/arch/mips/txx9/rbtx4939/irq.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- * Toshiba RBTX4939 interrupt routines
- * Based on linux/arch/mips/txx9/rbtx4938/irq.c,
- *	    and RBTX49xx patch from CELF patch archive.
- *
- * Copyright (C) 2000-2001,2005-2006 Toshiba Corporation
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/txx9/rbtx4939.h>
-
-/*
- * RBTX4939 IOC controller definition
- */
-
-static void rbtx4939_ioc_irq_unmask(struct irq_data *d)
-{
-	int ioc_nr = d->irq - RBTX4939_IRQ_IOC;
-
-	writeb(readb(rbtx4939_ien_addr) | (1 << ioc_nr), rbtx4939_ien_addr);
-}
-
-static void rbtx4939_ioc_irq_mask(struct irq_data *d)
-{
-	int ioc_nr = d->irq - RBTX4939_IRQ_IOC;
-
-	writeb(readb(rbtx4939_ien_addr) & ~(1 << ioc_nr), rbtx4939_ien_addr);
-	mmiowb();
-}
-
-static struct irq_chip rbtx4939_ioc_irq_chip = {
-	.name		= "IOC",
-	.irq_mask	= rbtx4939_ioc_irq_mask,
-	.irq_unmask	= rbtx4939_ioc_irq_unmask,
-};
-
-
-static inline int rbtx4939_ioc_irqroute(void)
-{
-	unsigned char istat = readb(rbtx4939_ifac2_addr);
-
-	if (unlikely(istat == 0))
-		return -1;
-	return RBTX4939_IRQ_IOC + __fls8(istat);
-}
-
-static int rbtx4939_irq_dispatch(int pending)
-{
-	int irq;
-
-	if (pending & CAUSEF_IP7)
-		return MIPS_CPU_IRQ_BASE + 7;
-	irq = tx4939_irq();
-	if (likely(irq >= 0)) {
-		/* redirect IOC interrupts */
-		switch (irq) {
-		case RBTX4939_IRQ_IOCINT:
-			irq = rbtx4939_ioc_irqroute();
-			break;
-		}
-	} else if (pending & CAUSEF_IP0)
-		irq = MIPS_CPU_IRQ_BASE + 0;
-	else if (pending & CAUSEF_IP1)
-		irq = MIPS_CPU_IRQ_BASE + 1;
-	else
-		irq = -1;
-	return irq;
-}
-
-void __init rbtx4939_irq_setup(void)
-{
-	int i;
-
-	/* mask all IOC interrupts */
-	writeb(0, rbtx4939_ien_addr);
-
-	/* clear SoftInt interrupts */
-	writeb(0, rbtx4939_softint_addr);
-
-	txx9_irq_dispatch = rbtx4939_irq_dispatch;
-
-	tx4939_irq_init();
-	for (i = RBTX4939_IRQ_IOC;
-	     i < RBTX4939_IRQ_IOC + RBTX4939_NR_IRQ_IOC; i++)
-		irq_set_chip_and_handler(i, &rbtx4939_ioc_irq_chip,
-					 handle_level_irq);
-
-	irq_set_chained_handler(RBTX4939_IRQ_IOCINT, handle_simple_irq);
-}
diff --git a/arch/mips/txx9/rbtx4939/prom.c b/arch/mips/txx9/rbtx4939/prom.c
deleted file mode 100644
index ba25ba1bd2ec..000000000000
--- a/arch/mips/txx9/rbtx4939/prom.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * rbtx4939 specific prom routines
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/init.h>
-#include <linux/memblock.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/rbtx4939.h>
-
-void __init rbtx4939_prom_init(void)
-{
-	unsigned long start, size;
-	u64 win;
-	int i;
-
-	for (i = 0; i < 4; i++) {
-		if (!((__u32)____raw_readq(&tx4939_ddrcptr->winen) & (1 << i)))
-			continue;
-		win = ____raw_readq(&tx4939_ddrcptr->win[i]);
-		start = (unsigned long)(win >> 48);
-		size = (((unsigned long)(win >> 32) & 0xffff) + 1) - start;
-		memblock_add(start << 20, size << 20);
-	}
-	txx9_sio_putchar_init(TX4939_SIO_REG(0) & 0xfffffffffULL);
-}
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
deleted file mode 100644
index ef29a9c2ffd6..000000000000
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ /dev/null
@@ -1,554 +0,0 @@
-/*
- * Toshiba RBTX4939 setup routines.
- * Based on linux/arch/mips/txx9/rbtx4938/setup.c,
- *	    and RBTX49xx patch from CELF patch archive.
- *
- * Copyright (C) 2000-2001,2005-2007 Toshiba Corporation
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/export.h>
-#include <linux/platform_device.h>
-#include <linux/leds.h>
-#include <linux/interrupt.h>
-#include <linux/smc91x.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/map.h>
-#include <asm/reboot.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/pci.h>
-#include <asm/txx9/rbtx4939.h>
-
-static void rbtx4939_machine_restart(char *command)
-{
-	local_irq_disable();
-	writeb(1, rbtx4939_reseten_addr);
-	writeb(1, rbtx4939_softreset_addr);
-	while (1)
-		;
-}
-
-static void __init rbtx4939_time_init(void)
-{
-	tx4939_time_init(0);
-}
-
-#if defined(__BIG_ENDIAN) && IS_ENABLED(CONFIG_SMC91X)
-#define HAVE_RBTX4939_IOSWAB
-#define IS_CE1_ADDR(addr) \
-	((((unsigned long)(addr) - IO_BASE) & 0xfff00000) == TXX9_CE(1))
-static u16 rbtx4939_ioswabw(volatile u16 *a, u16 x)
-{
-	return IS_CE1_ADDR(a) ? x : le16_to_cpu(x);
-}
-static u16 rbtx4939_mem_ioswabw(volatile u16 *a, u16 x)
-{
-	return !IS_CE1_ADDR(a) ? x : le16_to_cpu(x);
-}
-#endif /* __BIG_ENDIAN && CONFIG_SMC91X */
-
-static void __init rbtx4939_pci_setup(void)
-{
-#ifdef CONFIG_PCI
-	int extarb = !(__raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_PCIARB);
-	struct pci_controller *c = &txx9_primary_pcic;
-
-	register_pci_controller(c);
-
-	tx4939_report_pciclk();
-	tx4927_pcic_setup(tx4939_pcicptr, c, extarb);
-	if (!(__raw_readq(&tx4939_ccfgptr->pcfg) & TX4939_PCFG_ATA1MODE) &&
-	    (__raw_readq(&tx4939_ccfgptr->pcfg) &
-	     (TX4939_PCFG_ET0MODE | TX4939_PCFG_ET1MODE))) {
-		tx4939_report_pci1clk();
-
-		/* mem:64K(max), io:64K(max) (enough for ETH0,ETH1) */
-		c = txx9_alloc_pci_controller(NULL, 0, 0x10000, 0, 0x10000);
-		register_pci_controller(c);
-		tx4927_pcic_setup(tx4939_pcic1ptr, c, 0);
-	}
-
-	tx4939_setup_pcierr_irq();
-#endif /* CONFIG_PCI */
-}
-
-static unsigned long long default_ebccr[] __initdata = {
-	0x01c0000000007608ULL, /* 64M ROM */
-	0x017f000000007049ULL, /* 1M IOC */
-	0x0180000000408608ULL, /* ISA */
-	0,
-};
-
-static void __init rbtx4939_ebusc_setup(void)
-{
-	int i;
-	unsigned int sp;
-
-	/* use user-configured speed */
-	sp = TX4939_EBUSC_CR(0) & 0x30;
-	default_ebccr[0] |= sp;
-	default_ebccr[1] |= sp;
-	default_ebccr[2] |= sp;
-	/* initialise by myself */
-	for (i = 0; i < ARRAY_SIZE(default_ebccr); i++) {
-		if (default_ebccr[i])
-			____raw_writeq(default_ebccr[i],
-				       &tx4939_ebuscptr->cr[i]);
-		else
-			____raw_writeq(____raw_readq(&tx4939_ebuscptr->cr[i])
-				       & ~8,
-				       &tx4939_ebuscptr->cr[i]);
-	}
-}
-
-static void __init rbtx4939_update_ioc_pen(void)
-{
-	__u64 pcfg = ____raw_readq(&tx4939_ccfgptr->pcfg);
-	__u64 ccfg = ____raw_readq(&tx4939_ccfgptr->ccfg);
-	__u8 pe1 = readb(rbtx4939_pe1_addr);
-	__u8 pe2 = readb(rbtx4939_pe2_addr);
-	__u8 pe3 = readb(rbtx4939_pe3_addr);
-	if (pcfg & TX4939_PCFG_ATA0MODE)
-		pe1 |= RBTX4939_PE1_ATA(0);
-	else
-		pe1 &= ~RBTX4939_PE1_ATA(0);
-	if (pcfg & TX4939_PCFG_ATA1MODE) {
-		pe1 |= RBTX4939_PE1_ATA(1);
-		pe1 &= ~(RBTX4939_PE1_RMII(0) | RBTX4939_PE1_RMII(1));
-	} else {
-		pe1 &= ~RBTX4939_PE1_ATA(1);
-		if (pcfg & TX4939_PCFG_ET0MODE)
-			pe1 |= RBTX4939_PE1_RMII(0);
-		else
-			pe1 &= ~RBTX4939_PE1_RMII(0);
-		if (pcfg & TX4939_PCFG_ET1MODE)
-			pe1 |= RBTX4939_PE1_RMII(1);
-		else
-			pe1 &= ~RBTX4939_PE1_RMII(1);
-	}
-	if (ccfg & TX4939_CCFG_PTSEL)
-		pe3 &= ~(RBTX4939_PE3_VP | RBTX4939_PE3_VP_P |
-			 RBTX4939_PE3_VP_S);
-	else {
-		__u64 vmode = pcfg &
-			(TX4939_PCFG_VSSMODE | TX4939_PCFG_VPSMODE);
-		if (vmode == 0)
-			pe3 &= ~(RBTX4939_PE3_VP | RBTX4939_PE3_VP_P |
-				 RBTX4939_PE3_VP_S);
-		else if (vmode == TX4939_PCFG_VPSMODE) {
-			pe3 |= RBTX4939_PE3_VP_P;
-			pe3 &= ~(RBTX4939_PE3_VP | RBTX4939_PE3_VP_S);
-		} else if (vmode == TX4939_PCFG_VSSMODE) {
-			pe3 |= RBTX4939_PE3_VP | RBTX4939_PE3_VP_S;
-			pe3 &= ~RBTX4939_PE3_VP_P;
-		} else {
-			pe3 |= RBTX4939_PE3_VP | RBTX4939_PE3_VP_P;
-			pe3 &= ~RBTX4939_PE3_VP_S;
-		}
-	}
-	if (pcfg & TX4939_PCFG_SPIMODE) {
-		if (pcfg & TX4939_PCFG_SIO2MODE_GPIO)
-			pe2 &= ~(RBTX4939_PE2_SIO2 | RBTX4939_PE2_SIO0);
-		else {
-			if (pcfg & TX4939_PCFG_SIO2MODE_SIO2) {
-				pe2 |= RBTX4939_PE2_SIO2;
-				pe2 &= ~RBTX4939_PE2_SIO0;
-			} else {
-				pe2 |= RBTX4939_PE2_SIO0;
-				pe2 &= ~RBTX4939_PE2_SIO2;
-			}
-		}
-		if (pcfg & TX4939_PCFG_SIO3MODE)
-			pe2 |= RBTX4939_PE2_SIO3;
-		else
-			pe2 &= ~RBTX4939_PE2_SIO3;
-		pe2 &= ~RBTX4939_PE2_SPI;
-	} else {
-		pe2 |= RBTX4939_PE2_SPI;
-		pe2 &= ~(RBTX4939_PE2_SIO3 | RBTX4939_PE2_SIO2 |
-			 RBTX4939_PE2_SIO0);
-	}
-	if ((pcfg & TX4939_PCFG_I2SMODE_MASK) == TX4939_PCFG_I2SMODE_GPIO)
-		pe2 |= RBTX4939_PE2_GPIO;
-	else
-		pe2 &= ~RBTX4939_PE2_GPIO;
-	writeb(pe1, rbtx4939_pe1_addr);
-	writeb(pe2, rbtx4939_pe2_addr);
-	writeb(pe3, rbtx4939_pe3_addr);
-}
-
-#define RBTX4939_MAX_7SEGLEDS	8
-
-#if IS_BUILTIN(CONFIG_LEDS_CLASS)
-static u8 led_val[RBTX4939_MAX_7SEGLEDS];
-struct rbtx4939_led_data {
-	struct led_classdev cdev;
-	char name[32];
-	unsigned int num;
-};
-
-/* Use "dot" in 7seg LEDs */
-static void rbtx4939_led_brightness_set(struct led_classdev *led_cdev,
-					enum led_brightness value)
-{
-	struct rbtx4939_led_data *led_dat =
-		container_of(led_cdev, struct rbtx4939_led_data, cdev);
-	unsigned int num = led_dat->num;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	led_val[num] = (led_val[num] & 0x7f) | (value ? 0x80 : 0);
-	writeb(led_val[num], rbtx4939_7seg_addr(num / 4, num % 4));
-	local_irq_restore(flags);
-}
-
-static int __init rbtx4939_led_probe(struct platform_device *pdev)
-{
-	struct rbtx4939_led_data *leds_data;
-	int i;
-	static char *default_triggers[] __initdata = {
-		"heartbeat",
-		"disk-activity",
-		"nand-disk",
-	};
-
-	leds_data = kcalloc(RBTX4939_MAX_7SEGLEDS, sizeof(*leds_data),
-			    GFP_KERNEL);
-	if (!leds_data)
-		return -ENOMEM;
-	for (i = 0; i < RBTX4939_MAX_7SEGLEDS; i++) {
-		int rc;
-		struct rbtx4939_led_data *led_dat = &leds_data[i];
-
-		led_dat->num = i;
-		led_dat->cdev.brightness_set = rbtx4939_led_brightness_set;
-		sprintf(led_dat->name, "rbtx4939:amber:%u", i);
-		led_dat->cdev.name = led_dat->name;
-		if (i < ARRAY_SIZE(default_triggers))
-			led_dat->cdev.default_trigger = default_triggers[i];
-		rc = led_classdev_register(&pdev->dev, &led_dat->cdev);
-		if (rc < 0)
-			return rc;
-		led_dat->cdev.brightness_set(&led_dat->cdev, 0);
-	}
-	return 0;
-
-}
-
-static struct platform_driver rbtx4939_led_driver = {
-	.driver	 = {
-		.name = "rbtx4939-led",
-	},
-};
-
-static void __init rbtx4939_led_setup(void)
-{
-	platform_device_register_simple("rbtx4939-led", -1, NULL, 0);
-	platform_driver_probe(&rbtx4939_led_driver, rbtx4939_led_probe);
-}
-#else
-static inline void rbtx4939_led_setup(void)
-{
-}
-#endif
-
-static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
-{
-#if IS_BUILTIN(CONFIG_LEDS_CLASS)
-	unsigned long flags;
-	local_irq_save(flags);
-	/* bit7: reserved for LED class */
-	led_val[pos] = (led_val[pos] & 0x80) | (val & 0x7f);
-	val = led_val[pos];
-	local_irq_restore(flags);
-#endif
-	writeb(val, rbtx4939_7seg_addr(pos / 4, pos % 4));
-}
-
-static void rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
-{
-	/* convert from map_to_seg7() notation */
-	val = (val & 0x88) |
-		((val & 0x40) >> 6) |
-		((val & 0x20) >> 4) |
-		((val & 0x10) >> 2) |
-		((val & 0x04) << 2) |
-		((val & 0x02) << 4) |
-		((val & 0x01) << 6);
-	__rbtx4939_7segled_putc(pos, val);
-}
-
-#if IS_ENABLED(CONFIG_MTD_RBTX4939)
-/* special mapping for boot rom */
-static unsigned long rbtx4939_flash_fixup_ofs(unsigned long ofs)
-{
-	u8 bdipsw = readb(rbtx4939_bdipsw_addr) & 0x0f;
-	unsigned char shift;
-
-	if (bdipsw & 8) {
-		/* BOOT Mode: USER ROM1 / USER ROM2 */
-		shift = bdipsw & 3;
-		/* rotate A[23:22] */
-		return (ofs & ~0xc00000) | ((((ofs >> 22) + shift) & 3) << 22);
-	}
-#ifdef __BIG_ENDIAN
-	if (bdipsw == 0)
-		/* BOOT Mode: Monitor ROM */
-		ofs ^= 0x400000;	/* swap A[22] */
-#endif
-	return ofs;
-}
-
-static map_word rbtx4939_flash_read16(struct map_info *map, unsigned long ofs)
-{
-	map_word r;
-
-	ofs = rbtx4939_flash_fixup_ofs(ofs);
-	r.x[0] = __raw_readw(map->virt + ofs);
-	return r;
-}
-
-static void rbtx4939_flash_write16(struct map_info *map, const map_word datum,
-				   unsigned long ofs)
-{
-	ofs = rbtx4939_flash_fixup_ofs(ofs);
-	__raw_writew(datum.x[0], map->virt + ofs);
-	mb();	/* see inline_map_write() in mtd/map.h */
-}
-
-static void rbtx4939_flash_copy_from(struct map_info *map, void *to,
-				     unsigned long from, ssize_t len)
-{
-	u8 bdipsw = readb(rbtx4939_bdipsw_addr) & 0x0f;
-	unsigned char shift;
-	ssize_t curlen;
-
-	from += (unsigned long)map->virt;
-	if (bdipsw & 8) {
-		/* BOOT Mode: USER ROM1 / USER ROM2 */
-		shift = bdipsw & 3;
-		while (len) {
-			curlen = min_t(unsigned long, len,
-				     0x400000 - (from & (0x400000 - 1)));
-			memcpy(to,
-			       (void *)((from & ~0xc00000) |
-					((((from >> 22) + shift) & 3) << 22)),
-			       curlen);
-			len -= curlen;
-			from += curlen;
-			to += curlen;
-		}
-		return;
-	}
-#ifdef __BIG_ENDIAN
-	if (bdipsw == 0) {
-		/* BOOT Mode: Monitor ROM */
-		while (len) {
-			curlen = min_t(unsigned long, len,
-				     0x400000 - (from & (0x400000 - 1)));
-			memcpy(to, (void *)(from ^ 0x400000), curlen);
-			len -= curlen;
-			from += curlen;
-			to += curlen;
-		}
-		return;
-	}
-#endif
-	memcpy(to, (void *)from, len);
-}
-
-static void rbtx4939_flash_map_init(struct map_info *map)
-{
-	map->read = rbtx4939_flash_read16;
-	map->write = rbtx4939_flash_write16;
-	map->copy_from = rbtx4939_flash_copy_from;
-}
-
-static void __init rbtx4939_mtd_init(void)
-{
-	static struct {
-		struct platform_device dev;
-		struct resource res;
-		struct rbtx4939_flash_data data;
-	} pdevs[4];
-	int i;
-	static char names[4][8];
-	static struct mtd_partition parts[4];
-	struct rbtx4939_flash_data *boot_pdata = &pdevs[0].data;
-	u8 bdipsw = readb(rbtx4939_bdipsw_addr) & 0x0f;
-
-	if (bdipsw & 8) {
-		/* BOOT Mode: USER ROM1 / USER ROM2 */
-		boot_pdata->nr_parts = 4;
-		for (i = 0; i < boot_pdata->nr_parts; i++) {
-			sprintf(names[i], "img%d", 4 - i);
-			parts[i].name = names[i];
-			parts[i].size = 0x400000;
-			parts[i].offset = MTDPART_OFS_NXTBLK;
-		}
-	} else if (bdipsw == 0) {
-		/* BOOT Mode: Monitor ROM */
-		boot_pdata->nr_parts = 2;
-		strcpy(names[0], "big");
-		strcpy(names[1], "little");
-		for (i = 0; i < boot_pdata->nr_parts; i++) {
-			parts[i].name = names[i];
-			parts[i].size = 0x400000;
-			parts[i].offset = MTDPART_OFS_NXTBLK;
-		}
-	} else {
-		/* BOOT Mode: ROM Emulator */
-		boot_pdata->nr_parts = 2;
-		parts[0].name = "boot";
-		parts[0].offset = 0xc00000;
-		parts[0].size = 0x400000;
-		parts[1].name = "user";
-		parts[1].offset = 0;
-		parts[1].size = 0xc00000;
-	}
-	boot_pdata->parts = parts;
-	boot_pdata->map_init = rbtx4939_flash_map_init;
-
-	for (i = 0; i < ARRAY_SIZE(pdevs); i++) {
-		struct resource *r = &pdevs[i].res;
-		struct platform_device *dev = &pdevs[i].dev;
-
-		r->start = 0x1f000000 - i * 0x1000000;
-		r->end = r->start + 0x1000000 - 1;
-		r->flags = IORESOURCE_MEM;
-		pdevs[i].data.width = 2;
-		dev->num_resources = 1;
-		dev->resource = r;
-		dev->id = i;
-		dev->name = "rbtx4939-flash";
-		dev->dev.platform_data = &pdevs[i].data;
-		platform_device_register(dev);
-	}
-}
-#else
-static void __init rbtx4939_mtd_init(void)
-{
-}
-#endif
-
-static void __init rbtx4939_arch_init(void)
-{
-	rbtx4939_pci_setup();
-}
-
-static void __init rbtx4939_device_init(void)
-{
-	unsigned long smc_addr = RBTX4939_ETHER_ADDR - IO_BASE;
-	struct resource smc_res[] = {
-		{
-			.start	= smc_addr,
-			.end	= smc_addr + 0x10 - 1,
-			.flags	= IORESOURCE_MEM,
-		}, {
-			.start	= RBTX4939_IRQ_ETHER,
-			/* override default irq flag defined in smc91x.h */
-			.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
-		},
-	};
-	struct smc91x_platdata smc_pdata = {
-		.flags = SMC91X_USE_16BIT,
-	};
-	struct platform_device *pdev;
-#if IS_ENABLED(CONFIG_TC35815)
-	int i, j;
-	unsigned char ethaddr[2][6];
-	u8 bdipsw = readb(rbtx4939_bdipsw_addr) & 0x0f;
-
-	for (i = 0; i < 2; i++) {
-		unsigned long area = CKSEG1 + 0x1fff0000 + (i * 0x10);
-		if (bdipsw == 0)
-			memcpy(ethaddr[i], (void *)area, 6);
-		else {
-			u16 buf[3];
-			if (bdipsw & 8)
-				area -= 0x03000000;
-			else
-				area -= 0x01000000;
-			for (j = 0; j < 3; j++)
-				buf[j] = le16_to_cpup((u16 *)(area + j * 2));
-			memcpy(ethaddr[i], buf, 6);
-		}
-	}
-	tx4939_ethaddr_init(ethaddr[0], ethaddr[1]);
-#endif
-	pdev = platform_device_alloc("smc91x", -1);
-	if (!pdev ||
-	    platform_device_add_resources(pdev, smc_res, ARRAY_SIZE(smc_res)) ||
-	    platform_device_add_data(pdev, &smc_pdata, sizeof(smc_pdata)) ||
-	    platform_device_add(pdev))
-		platform_device_put(pdev);
-	rbtx4939_mtd_init();
-	/* TC58DVM82A1FT: tDH=10ns, tWP=tRP=tREADID=35ns */
-	tx4939_ndfmc_init(10, 35,
-			  (1 << 1) | (1 << 2),
-			  (1 << 2)); /* ch1:8bit, ch2:16bit */
-	rbtx4939_led_setup();
-	tx4939_wdt_init();
-	tx4939_ata_init();
-	tx4939_rtc_init();
-	tx4939_dmac_init(0, 2);
-	tx4939_aclc_init();
-	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
-	tx4939_sramc_init();
-	tx4939_rng_init();
-}
-
-static void __init rbtx4939_setup(void)
-{
-	int i;
-
-	rbtx4939_ebusc_setup();
-	/* always enable ATA0 */
-	txx9_set64(&tx4939_ccfgptr->pcfg, TX4939_PCFG_ATA0MODE);
-	if (txx9_master_clock == 0)
-		txx9_master_clock = 20000000;
-	tx4939_setup();
-	rbtx4939_update_ioc_pen();
-#ifdef HAVE_RBTX4939_IOSWAB
-	ioswabw = rbtx4939_ioswabw;
-	__mem_ioswabw = rbtx4939_mem_ioswabw;
-#endif
-
-	_machine_restart = rbtx4939_machine_restart;
-
-	txx9_7segled_init(RBTX4939_MAX_7SEGLEDS, rbtx4939_7segled_putc);
-	for (i = 0; i < RBTX4939_MAX_7SEGLEDS; i++)
-		txx9_7segled_putc(i, '-');
-	pr_info("RBTX4939 (Rev %02x) --- FPGA(Rev %02x) DIPSW:%02x,%02x\n",
-		readb(rbtx4939_board_rev_addr), readb(rbtx4939_ioc_rev_addr),
-		readb(rbtx4939_udipsw_addr), readb(rbtx4939_bdipsw_addr));
-
-#ifdef CONFIG_PCI
-	txx9_alloc_pci_controller(&txx9_primary_pcic, 0, 0, 0, 0);
-	txx9_board_pcibios_setup = tx4927_pcibios_setup;
-#else
-	set_io_port_base(RBTX4939_ETHER_BASE);
-#endif
-
-	tx4939_sio_init(TX4939_SCLK0(txx9_master_clock), 0);
-}
-
-struct txx9_board_vec rbtx4939_vec __initdata = {
-	.system = "Toshiba RBTX4939",
-	.prom_init = rbtx4939_prom_init,
-	.mem_setup = rbtx4939_setup,
-	.irq_setup = rbtx4939_irq_setup,
-	.time_init = rbtx4939_time_init,
-	.device_init = rbtx4939_device_init,
-	.arch_init = rbtx4939_arch_init,
-#ifdef CONFIG_PCI
-	.pci_map_irq = tx4939_pci_map_irq,
-#endif
-};
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 4945caa88345..6a099bbcd8be 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -357,12 +357,6 @@ config MTD_INTEL_VR_NOR
 	  Map driver for a NOR flash bank located on the Expansion Bus of the
 	  Intel Vermilion Range chipset.
 
-config MTD_RBTX4939
-	tristate "Map driver for RBTX4939 board"
-	depends on TOSHIBA_RBTX4939 && MTD_CFI && MTD_COMPLEX_MAPPINGS
-	help
-	  Map driver for NOR flash chips on RBTX4939 board.
-
 config MTD_PLATRAM
 	tristate "Map driver for platform device RAM (mtd-ram)"
 	select MTD_RAM
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 11fea9c8d561..2240b100f66a 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -42,6 +42,5 @@ obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
 obj-$(CONFIG_MTD_IXP4XX)	+= ixp4xx.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
-obj-$(CONFIG_MTD_RBTX4939)	+= rbtx4939-flash.o
 obj-$(CONFIG_MTD_VMU)		+= vmu-flash.o
 obj-$(CONFIG_MTD_LANTIQ)	+= lantiq-flash.o
diff --git a/drivers/mtd/maps/rbtx4939-flash.c b/drivers/mtd/maps/rbtx4939-flash.c
deleted file mode 100644
index 39c86c0b0ec1..000000000000
--- a/drivers/mtd/maps/rbtx4939-flash.c
+++ /dev/null
@@ -1,133 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * rbtx4939-flash (based on physmap.c)
- *
- * This is a simplified physmap driver with map_init callback function.
- *
- * Copyright (C) 2009 Atsushi Nemoto <anemo@mba.ocn.ne.jp>
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-#include <asm/txx9/rbtx4939.h>
-
-struct rbtx4939_flash_info {
-	struct mtd_info *mtd;
-	struct map_info map;
-};
-
-static int rbtx4939_flash_remove(struct platform_device *dev)
-{
-	struct rbtx4939_flash_info *info;
-
-	info = platform_get_drvdata(dev);
-	if (!info)
-		return 0;
-
-	if (info->mtd) {
-		mtd_device_unregister(info->mtd);
-		map_destroy(info->mtd);
-	}
-	return 0;
-}
-
-static const char * const rom_probe_types[] = {
-	"cfi_probe", "jedec_probe", NULL };
-
-static int rbtx4939_flash_probe(struct platform_device *dev)
-{
-	struct rbtx4939_flash_data *pdata;
-	struct rbtx4939_flash_info *info;
-	struct resource *res;
-	const char * const *probe_type;
-	int err = 0;
-	unsigned long size;
-
-	pdata = dev_get_platdata(&dev->dev);
-	if (!pdata)
-		return -ENODEV;
-
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-	info = devm_kzalloc(&dev->dev, sizeof(struct rbtx4939_flash_info),
-			    GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	platform_set_drvdata(dev, info);
-
-	size = resource_size(res);
-	pr_notice("rbtx4939 platform flash device: %pR\n", res);
-
-	if (!devm_request_mem_region(&dev->dev, res->start, size,
-				     dev_name(&dev->dev)))
-		return -EBUSY;
-
-	info->map.name = dev_name(&dev->dev);
-	info->map.phys = res->start;
-	info->map.size = size;
-	info->map.bankwidth = pdata->width;
-
-	info->map.virt = devm_ioremap(&dev->dev, info->map.phys, size);
-	if (!info->map.virt)
-		return -EBUSY;
-
-	if (pdata->map_init)
-		(*pdata->map_init)(&info->map);
-	else
-		simple_map_init(&info->map);
-
-	probe_type = rom_probe_types;
-	for (; !info->mtd && *probe_type; probe_type++)
-		info->mtd = do_map_probe(*probe_type, &info->map);
-	if (!info->mtd) {
-		dev_err(&dev->dev, "map_probe failed\n");
-		err = -ENXIO;
-		goto err_out;
-	}
-	info->mtd->dev.parent = &dev->dev;
-	err = mtd_device_register(info->mtd, pdata->parts, pdata->nr_parts);
-
-	if (err)
-		goto err_out;
-	return 0;
-
-err_out:
-	rbtx4939_flash_remove(dev);
-	return err;
-}
-
-#ifdef CONFIG_PM
-static void rbtx4939_flash_shutdown(struct platform_device *dev)
-{
-	struct rbtx4939_flash_info *info = platform_get_drvdata(dev);
-
-	if (mtd_suspend(info->mtd) == 0)
-		mtd_resume(info->mtd);
-}
-#else
-#define rbtx4939_flash_shutdown NULL
-#endif
-
-static struct platform_driver rbtx4939_flash_driver = {
-	.probe		= rbtx4939_flash_probe,
-	.remove		= rbtx4939_flash_remove,
-	.shutdown	= rbtx4939_flash_shutdown,
-	.driver		= {
-		.name	= "rbtx4939-flash",
-	},
-};
-
-module_platform_driver(rbtx4939_flash_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("RBTX4939 MTD map driver");
-MODULE_ALIAS("platform:rbtx4939-flash");
-- 
2.29.2

