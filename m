Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AEB49A26C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 02:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2362380AbiAXXmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:42:18 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41238 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843329AbiAXXDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:03:50 -0500
Received: from [192.168.4.54] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6612120B6C61;
        Mon, 24 Jan 2022 15:03:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6612120B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1643065429;
        bh=erMbjM3XkmJLfKK8q0n5yEgsEAAwonKLOKfoVw5HxBQ=;
        h=Date:From:Subject:To:Cc:From;
        b=rCaPyArv7JzRk2A/NuDnfWI2VZX4LncAbOSOc1SI6p05uHnxI6WXtV0O4Hyh38cp7
         dEQ+9Gr3ZdVlZcsQLrMmFpAQrON9wMRuQ2jG+GiCmANhIrRa9c0x8hhksAQbqMScvl
         vb9wZ8vuVEXMM+uhpwf778/GWvFxxV2L4ch135zU=
Message-ID: <9a34ee9b-0ede-30a6-0898-d32fe81d5b0c@linux.microsoft.com>
Date:   Mon, 24 Jan 2022 15:03:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Subject: [arm64] kernel boot slowdown in v5.10.19 -> v5.10.42 update
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We noticed 150ms kernel boot slowdown back in June, 2021, when moving 
from v5.10.19 to v5.10.42.  This on a 8GB SoC.  Only recently we 
investigated this issue and found the regression is introduced by a 
change in map_mem() (paging_init() -> map_mem() -> __map_memblock(), in 
particular "map all the memory banks" for loop) by patch

2687275a5843d1089687f08fc64eb3f3b026a169
arm64: Force NO_BLOCK_MAPPINGS if crashkernel reservation is required

above is a follow up to

0a30c53573b07d5561457e41fb0ab046cd857da5
arm64: mm: Move reserve_crashkernel() into mem_init())

which deferred crashkernel reservation into mem_init().

The ~150ms slowdown disappears on booting without "crashkernel=.." on 
kernel command-line.

Please let us know if it known/understood or addressed already or being 
looked into.  Any insight is appreciated.

Thanks,
Vijay

console output collected with debug prints --

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 
5.10.42.6-xxx-standard-2008.3.0-local-snapshot-01210432 
(oe-user@oe-host) (clang version 10.[    0.000001] sched_clock: 64 bits 
at 125MHz, resolution 8ns, wraps every 4398046511100ns
[    0.000003]          2.560781952 MSFT: kernel boot start
[    0.000484] Machine model: xxx
[    0.009379] earlycon: uart8250 at MMIO32 0x0000000068a10000 (options '')
[    0.009383] printk: bootconsole [uart8250] enabled
[    0.009828] before paging_init()
[    0.009977] before map_mem()
[    0.009978] after memblock_mark_nomap()
[    0.152388] after __map_memblock() for loop
[    0.152391] after __map_memblock() kernel_start, kernel_end
[    0.152393] after memblock_clear_nomap
[    0.152394] after map_mem()
[    0.152401] after paging_init()
[    0.153273] NUMA: No NUMA configuration found
[    0.153278] NUMA: Faking a node at [mem 
0x0000000080000000-0x000000097fffffff]
[    0.153282] NUMA: NODE_DATA [mem 0x97efec5c0-0x97efedfff]
[    0.153316] Zone ranges:
[    0.153319]   Normal   [mem 0x0000000080000000-0x000000097fffffff]
[    0.153323]   Device   empty
[    0.153325] Movable zone start for each node
[    0.153326] Early memory node ranges
[    0.153328]   node   0: [mem 0x0000000080000000-0x000000008adfffff]
[    0.153330]   node   0: [mem 0x000000008ae00000-0x000000008f223fff]
[    0.153331]   node   0: [mem 0x000000008f224000-0x00000000ffffffff]
[    0.153333]   node   0: [mem 0x0000000880000000-0x00000008800fffff]
[    0.153334]   node   0: [mem 0x0000000880100000-0x000000097fffffff]
[    0.153337] Initmem setup node 0 [mem 
0x0000000080000000-0x000000097fffffff]
[    0.153340] On node 0 totalpages: 1572864
[    0.153342]   Normal zone: 24576 pages used for memmap
[    0.153343]   Normal zone: 0 pages reserved
[    0.153345]   Normal zone: 1572864 pages, LIFO batch:63
[    0.154507] crashkernel reserved: 0x0000000968e00000 - 
0x0000000978e00000 (256 MB)

Console output from PXE boot without "crashkernel=256M" boot parameter --
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 
5.10.42.6-xxx-standard-2008.3.0-local-snapshot-01210432 
(oe-user@oe-host) (clang version 10.[    0.000001] sched_clock: 64 bits 
at 125MHz, resolution 8ns, wraps every 4398046511100ns
[    0.000003]         14.765446920 MSFT: kernel boot start
[    0.000484] Machine model: xxx
[    0.009400] earlycon: uart8250 at MMIO32 0x0000000068a10000 (options '')
[    0.009404] printk: bootconsole [uart8250] enabled
[    0.009835] before paging_init()
[    0.009986] before map_mem()
[    0.009987] after memblock_mark_nomap()
[    0.010154] after __map_memblock() for loop
[    0.010156] after __map_memblock() kernel_start, kernel_end
[    0.010158] after memblock_clear_nomap
[    0.010159] after map_mem()
[    0.010163] after paging_init()
[    0.011002] NUMA: No NUMA configuration found
[    0.011005] NUMA: Faking a node at [mem 
0x0000000080000000-0x000000097fffffff]
[    0.011009] NUMA: NODE_DATA [mem 0x97fbc65c0-0x97fbc7fff]
[    0.011037] Zone ranges:
[    0.011038]   Normal   [mem 0x0000000080000000-0x000000097fffffff]
[    0.011041]   Device   empty
[    0.011043] Movable zone start for each node
[    0.011044] Early memory node ranges
[    0.011046]   node   0: [mem 0x0000000080000000-0x000000008adfffff]
[    0.011048]   node   0: [mem 0x000000008ae00000-0x000000008f223fff]
[    0.011049]   node   0: [mem 0x000000008f224000-0x00000000ffffffff]
[    0.011050]   node   0: [mem 0x0000000880000000-0x00000008800fffff]
[    0.011052]   node   0: [mem 0x0000000880100000-0x000000097fffffff]
[    0.011054] Initmem setup node 0 [mem 
0x0000000080000000-0x000000097fffffff]
[    0.011056] On node 0 totalpages: 1572864
[    0.011058]   Normal zone: 24576 pages used for memmap
[    0.011060]   Normal zone: 0 pages reserved
[    0.011061]   Normal zone: 1572864 pages, LIFO batch:63
