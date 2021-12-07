Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6594046C154
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbhLGRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:09:57 -0500
Received: from elvis.franken.de ([193.175.24.41]:35282 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234465AbhLGRJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:09:56 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mudv5-0003op-00; Tue, 07 Dec 2021 18:06:23 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 6EC63C4DFD; Tue,  7 Dec 2021 18:06:03 +0100 (CET)
Date:   Tue, 7 Dec 2021 18:06:03 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Do not define pci_remap_iospace() under
 MACH_LOONGSON64
Message-ID: <20211207170603.GA20028@alpha.franken.de>
References: <1637139795-3032-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637139795-3032-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 05:03:15PM +0800, Tiezhu Yang wrote:
> After commit 9f76779f2418 ("MIPS: implement architecture-specific
> 'pci_remap_iospace()'"), there exists the following warning on the
> Loongson64 platform:
> 
>     loongson-pci 1a000000.pci:       IO 0x0018020000..0x001803ffff -> 0x0000020000
>     loongson-pci 1a000000.pci:      MEM 0x0040000000..0x007fffffff -> 0x0040000000
>     ------------[ cut here ]------------
>     WARNING: CPU: 2 PID: 1 at arch/mips/pci/pci-generic.c:55 pci_remap_iospace+0x84/0x90
>     resource start address is not zero
>     ...
>     Call Trace:
>     [<ffffffff8020dc78>] show_stack+0x40/0x120
>     [<ffffffff80cf4a0c>] dump_stack_lvl+0x58/0x74
>     [<ffffffff8023a0b0>] __warn+0xe0/0x110
>     [<ffffffff80cee02c>] warn_slowpath_fmt+0xa4/0xd0
>     [<ffffffff80cecf24>] pci_remap_iospace+0x84/0x90
>     [<ffffffff807f9864>] devm_pci_remap_iospace+0x5c/0xb8
>     [<ffffffff808121b0>] devm_of_pci_bridge_init+0x178/0x1f8
>     [<ffffffff807f4000>] devm_pci_alloc_host_bridge+0x78/0x98
>     [<ffffffff80819454>] loongson_pci_probe+0x34/0x160
>     [<ffffffff809203cc>] platform_probe+0x6c/0xe0
>     [<ffffffff8091d5d4>] really_probe+0xbc/0x340
>     [<ffffffff8091d8f0>] __driver_probe_device+0x98/0x110
>     [<ffffffff8091d9b8>] driver_probe_device+0x50/0x118
>     [<ffffffff8091dea0>] __driver_attach+0x80/0x118
>     [<ffffffff8091b280>] bus_for_each_dev+0x80/0xc8
>     [<ffffffff8091c6d8>] bus_add_driver+0x130/0x210
>     [<ffffffff8091ead4>] driver_register+0x8c/0x150
>     [<ffffffff80200a8c>] do_one_initcall+0x54/0x288
>     [<ffffffff811a5320>] kernel_init_freeable+0x27c/0x2e4
>     [<ffffffff80cfc380>] kernel_init+0x2c/0x134
>     [<ffffffff80205a2c>] ret_from_kernel_thread+0x14/0x1c
>     ---[ end trace e4a0efe10aa5cce6 ]---
>     loongson-pci 1a000000.pci: error -19: failed to map resource [io  0x20000-0x3ffff]
> 
> We can see that the resource start address is 0x0000020000, because
> the ISA Bridge used the zero address which is defined in the dts file
> arch/mips/boot/dts/loongson/ls7a-pch.dtsi:
> 
>     ISA Bridge: /bus@10000000/isa@18000000
>     IO 0x0000000018000000..0x000000001801ffff  ->  0x0000000000000000
> 
> The architecture-independent function pci_remap_iospace() works well
> for Loongson64, so just do not define architecture-specific function
> pci_remap_iospace() under MACH_LOONGSON64.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/include/asm/pci.h | 2 ++
>  arch/mips/pci/pci-generic.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 421231f..5d647cb 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -21,8 +21,10 @@
>  #include <linux/of.h>
>  
>  #ifdef CONFIG_PCI_DRIVERS_GENERIC
> +#ifndef CONFIG_MACH_LOONGSON64
>  #define pci_remap_iospace pci_remap_iospace
>  #endif
> +#endif

I prefer a version without new CONFIG_MACH_LOONGSON64 ifdefery. Something
like:


diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
index 05d14c21c417..f7af11ea2d61 100644
--- a/arch/mips/include/asm/mach-ralink/spaces.h
+++ b/arch/mips/include/asm/mach-ralink/spaces.h
@@ -6,5 +6,7 @@
 #define PCI_IOSIZE	SZ_64K
 #define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
 
+#define pci_remap_iospace pci_remap_iospace
+
 #include <asm/mach-generic/spaces.h>
 #endif
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 421231f55935..9ffc8192adae 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -20,10 +20,6 @@
 #include <linux/list.h>
 #include <linux/of.h>
 
-#ifdef CONFIG_PCI_DRIVERS_GENERIC
-#define pci_remap_iospace pci_remap_iospace
-#endif
-
 #ifdef CONFIG_PCI_DRIVERS_LEGACY
 
 /*
diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
index 18eb8a453a86..d2d68bac3d25 100644
--- a/arch/mips/pci/pci-generic.c
+++ b/arch/mips/pci/pci-generic.c
@@ -47,6 +47,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	pci_read_bridge_bases(bus);
 }
 
+#ifdef pci_remap_iospace
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
 	unsigned long vaddr;
@@ -60,3 +61,4 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 	set_io_port_base(vaddr);
 	return 0;
 }
+#endif

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
