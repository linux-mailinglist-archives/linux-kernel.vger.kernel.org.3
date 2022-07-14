Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5877F57469D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiGNIUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiGNIUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:20:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1A4D2BB37;
        Thu, 14 Jul 2022 01:20:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E877139F;
        Thu, 14 Jul 2022 01:20:10 -0700 (PDT)
Received: from [10.162.42.10] (unknown [10.162.42.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6EB73F70D;
        Thu, 14 Jul 2022 01:20:05 -0700 (PDT)
Message-ID: <ca41951e-e662-c4ba-eb78-68ddc77cba2b@arm.com>
Date:   Thu, 14 Jul 2022 13:50:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [next] Kernel panic - not syncing: swiotlb_init_remap: nslabs = 0
 too small
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        linux-mm <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, conor@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <CA+G9fYuxp2Ge1JGwuXase633r8_7zPZkxrD6doCKi6aYY3mfPw@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CA+G9fYuxp2Ge1JGwuXase633r8_7zPZkxrD6doCKi6aYY3mfPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/22 13:17, Naresh Kamboju wrote:
> [Please ignore this email if it is already reported]
> 
> Linux next-20220713 boot failed on arm, arm64, x86_64 and i386 [1].
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

There are couple of recent commits in swiotlb area, could you please check
reverting them, if that solves the problem. 

26ffb91fa5e0fb282e8 ("swiotlb: split up the global swiotlb lock")
c51ba246cb172c9e947 ("swiotlb: fail map correctly with failed io_tlb_default_mem")

> 
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 4662b7adea50bb62e993a67f611f3be625d3df0d
>   git_describe: next-20220713
>   kernel_version: 5.19.0-rc6
>   kernel-config: https://builds.tuxbuild.com/2BtFIR2DegCrbRCCTSZF93YVeiO/config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/586982028
>   artifact-location: https://builds.tuxbuild.com/2BtFIR2DegCrbRCCTSZF93YVeiO
>   vmlinux.xz: https://builds.tuxbuild.com/2BtFIR2DegCrbRCCTSZF93YVeiO/vmlinux.xz
>   System.map: https://builds.tuxbuild.com/2BtFIR2DegCrbRCCTSZF93YVeiO/System.map
>   toolchain: gcc-11
> 
> Here is the boot log output from arm64 juno-r2 device.
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
> [    0.000000] Linux version 5.19.0-rc6-next-20220713
> (tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU
> ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT @1657717522
> [    0.000000] Machine model: ARM Juno development board (r2)
> [    0.000000] earlycon: pl11 at MMIO 0x000000007ff80000 (options '')
> [    0.000000] printk: bootconsole [pl11] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem
> 0x0000000080000000-0x00000009ffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x9fefd1b40-0x9fefd3fff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000009ffffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080000000-0x00000000feffffff]
> [    0.000000]   node   0: [mem 0x0000000880000000-0x00000009ffffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000009ffffffff]
> [    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
> [    0.000000] cma: Reserved 32 MiB at 0x00000000fd000000
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
> [    0.000000] psci: SMC Calling Convention v1.0
> [    0.000000] percpu: Embedded 30 pages/cpu s82856 r8192 d31832 u122880
> [    0.000000] Detected VIPT I-cache on CPU0
> [    0.000000] CPU features: detected: ARM erratum 843419
> [    0.000000] CPU features: detected: ARM erratum 845719
> [    0.000000] Fallback order for Node 0: 0
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2060288
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: console=ttyAMA0,115200n8
> root=/dev/nfs rw
> nfsroot=10.66.16.120:/var/lib/lava/dispatcher/tmp/5283518/extract-nfsrootfs-ulkeoqdy,tcp,hard,vers=3,wsize=65536
> earlycon=pl011,0x7ff80000 console_msg_format=syslog earlycon
> default_hugepagesz=2M hugepages=256
> sky2.mac_address=0x00,0x02,0xF7,0x00,0x68,0x51 ip=dhcp
> <6>[    0.000000] Dentry cache hash table entries: 1048576 (order: 11,
> 8388608 bytes, linear)
> <6>[    0.000000] Inode-cache hash table entries: 524288 (order: 10,
> 4194304 bytes, linear)
> <6>[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> <0>[    0.000000] Kernel panic - not syncing: swiotlb_init_remap:
> nslabs = 0 too small
> <4>[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 5.19.0-rc6-next-20220713 #1
> <4>[    0.000000] Hardware name: ARM Juno development board (r2) (DT)
> <4>[    0.000000] Call trace:
> <4>[    0.000000]  dump_backtrace+0xe8/0x130
> <4>[    0.000000]  show_stack+0x24/0x60
> <4>[    0.000000]  dump_stack_lvl+0x8c/0xb8
> <4>[    0.000000]  dump_stack+0x18/0x34
> <4>[    0.000000]  panic+0x188/0x38c
> <4>[    0.000000]  swiotlb_init_remap+0x50/0x54
> <4>[    0.000000]  swiotlb_init+0x20/0x2c
> <4>[    0.000000]  mem_init+0x38/0x48
> <4>[    0.000000]  start_kernel+0x448/0x738
> <4>[    0.000000]  __primary_switched+0xb8/0xc0
> <0>[    0.000000] ---[ end Kernel panic - not syncing:
> swiotlb_init_remap: nslabs = 0 too small ]---
> 
> Full test log link,
> [1] https://lkft.validation.linaro.org/scheduler/job/5283518#L582
> 
> Best regards
> Naresh Kamboju
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
