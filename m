Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD051349E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346857AbiD1NOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiD1NOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:14:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677681CFEF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E304D62057
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554E3C385AA;
        Thu, 28 Apr 2022 13:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651151489;
        bh=3cUbLRj0AS6ThTYaeUINo9N9tQusNC2k+C55ygza17A=;
        h=From:To:Cc:Subject:Date:From;
        b=dLPGFXXC3Yg3hkBK39uWfjKON3Qop7xypGm1ULKIbLDZ9A1Chiv/w4uk0ZSAu70mD
         gQa/AV08INc3p/iKF0mmw85FqX+hXUHiT/pRszFetIVfz5ROyNJb4VnpJIVWZec7oF
         rOpaPSRLNfGlq4R7Inbo1MzcfTxMjA10OmLNucSTccs+FVERcoDBssqiuDP8JmKhpg
         y9A+eSBDVeKZjzyEBM9Schpdx6ltyhMf+qGf0hSZh8bKHInw9oUgJtXwtTKCgtqPwn
         8LdgFA4T2t6dF8tESudf7XadBNKjbRdv7bz/DRzGxxlpzQIGrzkMhotzZ3Jx2tDBJ0
         Hp9FzZBDHTynw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa/sa1100: move I/O space to PCI_IOBASE
Date:   Thu, 28 Apr 2022 15:10:34 +0200
Message-Id: <20220428131115.986812-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

PXA and StrongARM1100 traditionally map their I/O space 1:1 into virtual
memory, using a per-bus io_offset that matches the base address of the
ioremap mapping.

In order for PXA to work in a multiplatform config, this needs to
change so I/O space starts at PCI_IOBASE (0xfee00000). Since the pcmcia
soc_common support is shared with StrongARM1100, both have to change at
the same time. The affected machines are:

 - Anything with a PCMCIA slot now uses pci_remap_iospace, which
   is made available to PCMCIA configurations as well, rather than
   just PCI

 - The Zeus and Viper platforms have PC/104-style ISA buses,
   which have a static mapping for both I/O and memory space at
   0xf1000000, which can no longer work. It does not appear to have
   any in-tree users, so moving it to port number 0x2000 is unlikely to
   break something.

 - SA1100 does support ISA slots in theory, but all machines that
   originally enabled this appear to have been removed from the tree
   ages ago, and the I/O space is never mapped anywhere.

 - The Nanoengine machine has support for PCI slots, but looks
   like this never included I/O space, the resources only define the
   location for memory and config space.

With this, the definitions of __io() and IO_SPACE_LIMIT can be simplified,
as the only remaining cases are the generic PCI_IOBASE and the custom
inb()/outb() macros on RiscPC.  S3C24xx still has a custom inb()/outb()
in this here, but this is already removed in another branch.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/io.h   | 25 +++----------------------
 arch/arm/mach-pxa/viper.c   | 12 ++++++++++++
 arch/arm/mach-pxa/zeus.c    | 12 ++++++++++++
 arch/arm/mm/ioremap.c       |  2 +-
 drivers/pcmcia/soc_common.c | 16 ++++++++--------
 include/pcmcia/soc_common.h |  2 +-
 6 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 0c70eb688a00..3bdc54702baa 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -200,32 +200,13 @@ void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size);
  */
 #ifdef CONFIG_NEED_MACH_IO_H
 #include <mach/io.h>
-#elif defined(CONFIG_PCI)
-#define IO_SPACE_LIMIT	((resource_size_t)0xfffff)
-#define __io(a)		__typesafe_io(PCI_IO_VIRT_BASE + ((a) & IO_SPACE_LIMIT))
 #else
-#define __io(a)		__typesafe_io((a) & IO_SPACE_LIMIT)
-#endif
-
-/*
- * This is the limit of PC card/PCI/ISA IO space, which is by default
- * 64K if we have PC card, PCI or ISA support.  Otherwise, default to
- * zero to prevent ISA/PCI drivers claiming IO space (and potentially
- * oopsing.)
- *
- * Only set this larger if you really need inb() et.al. to operate over
- * a larger address space.  Note that SOC_COMMON ioremaps each sockets
- * IO space area, and so inb() et.al. must be defined to operate as per
- * readb() et.al. on such platforms.
- */
-#ifndef IO_SPACE_LIMIT
-#if defined(CONFIG_PCMCIA_SOC_COMMON) || defined(CONFIG_PCMCIA_SOC_COMMON_MODULE)
-#define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
-#elif defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
-#define IO_SPACE_LIMIT ((resource_size_t)0xffff)
+#if defined(CONFIG_PCMCIA) || defined(CONFIG_PCI)
+#define IO_SPACE_LIMIT	((resource_size_t)0xfffff)
 #else
 #define IO_SPACE_LIMIT ((resource_size_t)0)
 #endif
+#define __io(a)		__typesafe_io(PCI_IO_VIRT_BASE + ((a) & IO_SPACE_LIMIT))
 #endif
 
 /*
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 0782f0ed5a6e..71e4d7ea77b8 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -998,6 +998,18 @@ static struct map_desc viper_io_desc[] __initdata = {
 		.length  = 0x00800000,
 		.type    = MT_DEVICE,
 	},
+	{
+		/*
+		 * ISA I/O space mapping:
+		 * -  ports 0x0000-0x0fff are PCMCIA slot 0
+		 * -  ports 0x1000-0x1fff are PCMCIA slot 1
+		 * -  ports 0x2000-0x2fff are PC/104
+		 */
+		.virtual = PCI_IOBASE + 0x2000,
+		.pfn     = __phys_to_pfn(0x30000000),
+		.length  = 0x1000,
+		.type    = MT_DEVICE,
+	},
 };
 
 static void __init viper_map_io(void)
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 1fdef9426784..5ddb4223d1dc 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -929,6 +929,18 @@ static struct map_desc zeus_io_desc[] __initdata = {
 		.length  = 0x00800000,
 		.type    = MT_DEVICE,
 	},
+	{
+		/*
+		 * ISA I/O space mapping:
+		 * -  ports 0x0000-0x0fff are PCMCIA slot 0
+		 * -  ports 0x1000-0x1fff are PCMCIA slot 1
+		 * -  ports 0x2000-0x2fff are PC/104
+		 */
+		.virtual = PCI_IOBASE + 0x2000,
+		.pfn     = __phys_to_pfn(ZEUS_PC104IO_PHYS),
+		.length  = 0x1000,
+		.type    = MT_DEVICE,
+	},
 };
 
 static void __init zeus_map_io(void)
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index aa08bcb72db9..e6f5354ed1d7 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -455,7 +455,7 @@ void iounmap(volatile void __iomem *cookie)
 }
 EXPORT_SYMBOL(iounmap);
 
-#ifdef CONFIG_PCI
+#if defined(CONFIG_PCI) || defined(CONFIG_PCMCIA)
 static int pci_ioremap_mem_type = MT_DEVICE;
 
 void pci_ioremap_set_mem_type(int mem_type)
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 9276a628473d..fdeaefffd34a 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -46,6 +46,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
+#include <linux/pci.h>
 
 #include "soc_common.h"
 
@@ -782,8 +783,7 @@ void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt)
 	/* should not be required; violates some lowlevel drivers */
 	soc_common_pcmcia_config_skt(skt, &dead_socket);
 
-	iounmap(skt->virt_io);
-	skt->virt_io = NULL;
+	pci_unmap_iospace(&skt->res_io_io);
 	release_resource(&skt->res_attr);
 	release_resource(&skt->res_mem);
 	release_resource(&skt->res_io);
@@ -816,11 +816,11 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 	if (ret)
 		goto out_err_4;
 
-	skt->virt_io = ioremap(skt->res_io.start, 0x10000);
-	if (skt->virt_io == NULL) {
-		ret = -ENOMEM;
+	skt->res_io_io = (struct resource)
+		 DEFINE_RES_IO_NAMED(skt->nr * 0x1000, 0x1000, "PCMCIA I/O");
+	ret = pci_remap_iospace(&skt->res_io_io, skt->res_io.start);
+	if (ret)
 		goto out_err_5;
-	}
 
 	/*
 	 * We initialize default socket timing here, because
@@ -838,7 +838,7 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 	skt->socket.resource_ops = &pccard_static_ops;
 	skt->socket.irq_mask = 0;
 	skt->socket.map_size = PAGE_SIZE;
-	skt->socket.io_offset = (unsigned long)skt->virt_io;
+	skt->socket.io_offset = (unsigned long)skt->res_io_io.start;
 
 	skt->status = soc_common_pcmcia_skt_state(skt);
 
@@ -872,7 +872,7 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
  out_err_7:
 	soc_pcmcia_hw_shutdown(skt);
  out_err_6:
-	iounmap(skt->virt_io);
+	pci_unmap_iospace(&skt->res_io_io);
  out_err_5:
 	release_resource(&skt->res_attr);
  out_err_4:
diff --git a/include/pcmcia/soc_common.h b/include/pcmcia/soc_common.h
index 26f1473a06c5..d4f18f4679df 100644
--- a/include/pcmcia/soc_common.h
+++ b/include/pcmcia/soc_common.h
@@ -46,9 +46,9 @@ struct soc_pcmcia_socket {
 
 	struct resource		res_skt;
 	struct resource		res_io;
+	struct resource		res_io_io;
 	struct resource		res_mem;
 	struct resource		res_attr;
-	void __iomem		*virt_io;
 
 	struct {
 		int		gpio;
-- 
2.29.2

