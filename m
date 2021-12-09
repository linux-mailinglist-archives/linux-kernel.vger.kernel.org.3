Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9183846E584
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhLIJ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:29:41 -0500
Received: from elvis.franken.de ([193.175.24.41]:38012 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233247AbhLIJ3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:29:40 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mvFgg-0001er-01; Thu, 09 Dec 2021 10:26:02 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4CC51C4E1D; Thu,  9 Dec 2021 10:24:47 +0100 (CET)
Date:   Thu, 9 Dec 2021 10:24:47 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Only define pci_remap_iospace() for Ralink
Message-ID: <20211209092447.GB6981@alpha.franken.de>
References: <1638955639-3584-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638955639-3584-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:27:19PM +0800, Tiezhu Yang wrote:
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
> Based on the above analysis, the architecture-specific pci_remap_iospace()
> is not suitable for Loongson64, we should only define pci_remap_iospace()
> for Ralink on MIPS based on the commit background.
> 
> Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/include/asm/mach-ralink/spaces.h | 2 ++
>  arch/mips/include/asm/pci.h                | 4 ----
>  arch/mips/pci/pci-generic.c                | 2 ++
>  3 files changed, 4 insertions(+), 4 deletions(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
