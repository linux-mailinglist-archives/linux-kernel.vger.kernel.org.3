Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761EC512525
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiD0WTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbiD0WTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:19:02 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECFAC13F21
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:15:48 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4E5C192009C; Thu, 28 Apr 2022 00:15:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 480CF92009B;
        Wed, 27 Apr 2022 23:15:47 +0100 (BST)
Date:   Wed, 27 Apr 2022 23:15:47 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: PCI: Avoid handing out address 0 to devices
Message-ID: <alpine.DEB.2.21.2204271207590.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RISC-V platforms we permit assigning addresses from 0 to PCI devices,
both in the memory and the I/O bus space, and we happily do so if there 
is no conflict, e.g.:

pci 0000:07:00.0: BAR 0: assigned [io  0x0000-0x0007]
pci 0000:07:00.1: BAR 0: assigned [io  0x0008-0x000f]
pci 0000:06:01.0: PCI bridge to [bus 07]
pci 0000:06:01.0:   bridge window [io  0x0000-0x0fff]

(with the SiFive HiFive Unmatched RISC-V board and a dual serial port 
option card based on the OxSemi OXPCIe952 device wired for the legacy 
UART mode).

Address 0 is treated specially however in many places, for example in 
`pci_iomap_range' and `pci_iomap_wc_range' we require that the start 
address is non-zero, and even if we let such an address through, then 
individual device drivers could reject a request to handle a device at 
such an address, such as in `uart_configure_port'.  Consequently given
devices configured as shown above only one is actually usable:

Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial 0000:07:00.0: enabling device (0000 -> 0001)
serial: probe of 0000:07:00.0 failed with error -12
serial 0000:07:00.1: enabling device (0000 -> 0001)
serial 0000:07:00.1: detected caps 00000700 should be 00000500
0000:07:00.1: ttyS0 at I/O 0x8 (irq = 39, base_baud = 15625000) is a 16C950/954

Therefore avoid handing out address 0, by bumping the lowest address 
available to PCI via PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM up by 4 and 16 
respectively, which is the minimum allocation size for I/O and memory 
BARs.

With this in place the system in question we have:

pci 0000:07:00.0: BAR 0: assigned [io  0x1000-0x1007]
pci 0000:07:00.1: BAR 0: assigned [io  0x1008-0x100f]
pci 0000:06:01.0: PCI bridge to [bus 07]
pci 0000:06:01.0:   bridge window [io  0x1000-0x1fff]

and then devices work correctly:

Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial 0000:07:00.0: enabling device (0000 -> 0001)
serial 0000:07:00.0: detected caps 00000700 should be 00000500
0000:07:00.0: ttyS0 at I/O 0x1000 (irq = 38, base_baud = 15625000) is a 16C950/954
serial 0000:07:00.1: enabling device (0000 -> 0001)
serial 0000:07:00.1: detected caps 00000700 should be 00000500
0000:07:00.1: ttyS1 at I/O 0x1008 (irq = 39, base_baud = 15625000) is a 16C950/954

Especially I/O space ranges are particularly valuable, because bridges 
only decode bits from 12 up and consequently where 16-bit addressing is 
in effect, as few as 16 separate ranges can be assigned to individual 
buses only, however a generic change to avoid handing out address 0 only 
has turned out controversial as per the discussion referred via the link 
below.

Conversely sorting this out in platform code has been standard practice 
since forever to avoid a clash with legacy devices subtractively decoded 
by the southbridge where present.  This can be revised should a generic 
solution be adopted sometime.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk
---
Hi,

 NB I have an OxSemi OXPCIe952 based card that can be wired to either the 
native or the legacy mode via a jumper block and I am so glad that I have 
checked whether it works in the legacy mode as well.  I guess there are so 
few legacy-free platforms still for nobody else to notice this issue yet.

  Maciej
---
 arch/riscv/include/asm/pci.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

linux-riscv-pcibios-min.diff
Index: linux-macro/arch/riscv/include/asm/pci.h
===================================================================
--- linux-macro.orig/arch/riscv/include/asm/pci.h
+++ linux-macro/arch/riscv/include/asm/pci.h
@@ -12,8 +12,8 @@
 
 #include <asm/io.h>
 
-#define PCIBIOS_MIN_IO		0
-#define PCIBIOS_MIN_MEM		0
+#define PCIBIOS_MIN_IO		4
+#define PCIBIOS_MIN_MEM		16
 
 /* RISC-V shim does not initialize PCI bus */
 #define pcibios_assign_all_busses() 1
