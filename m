Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45074C9ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbiCBIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiCBIEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:04:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34AB6D15;
        Wed,  2 Mar 2022 00:03:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD18B60BAA;
        Wed,  2 Mar 2022 08:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A68C004E1;
        Wed,  2 Mar 2022 08:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646208212;
        bh=XVSDm4zGluVMXX2dmFKSlq6Iqi3qFcUpPX6v9nTXTB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKq2q/mNICKglLoxy2+1EvSnfFoMr7r5D3UNcc5UUjr30Jgubk8QzMAZUGD3dav06
         GycPzFaNQLBf4gFczb2zGuR6UVu+zX1vHJIQHqLrW5gGAlrL2GpFrGsGGz7xusnPBJ
         SZK9zDArWCZV5Er2aR2uEZEKYYaODfvcTHMCRgLtJefDpnVxyrBPPmacHjNsqXAQgw
         OiM2pTAI5GYwNfRNKlq2bijp69D09NV0lUrfRPJ8XZkCtLyGLKAxJYQ32dsS4gy05Y
         52eELXqieoQtiJ5sZxZl1wSQ8u8rYeqMDVrSeaVMGgMBlM7WMsiGauttmVjif9Dccr
         lDexJrVqf0Zjw==
Date:   Wed, 2 Mar 2022 10:03:24 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
Message-ID: <Yh8kzK7TM7EhaKEQ@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <Yh3tgr+g/6IElq0P@kernel.org>
 <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn>
 <Yh4uUoYT+YS5Jxsv@kernel.org>
 <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 09:50:49AM +0800, Tiezhu Yang wrote:
> 
> 
> On 03/01/2022 10:31 PM, Mike Rapoport wrote:
> > On Tue, Mar 01, 2022 at 07:51:23PM +0800, Tiezhu Yang wrote:
> > > 
> > > 
> > > On 03/01/2022 05:55 PM, Mike Rapoport wrote:
> > > > Hi,
> > > > 
> > > > On Tue, Mar 01, 2022 at 12:28:57PM +0800, Tiezhu Yang wrote:
> > > > > In the current code, the kernel command-line parameter mem= and memmap=
> > > > > can not work well on MIPS, this patchset refactors the related code to
> > > > > fix them.
> > > > > 
> > > > > For kdump on MIPS, if the users want to limit the memory region for the
> > > > > capture kernel to avoid corrupting the memory image of the panic kernel,
> > > > > use the parameter memmap=limit@base is the proper way, I will submit a
> > > > > patch to use memmap=limit@base for kexec-tools after this patchset is
> > > > > applied.
> > > > 
> > > > Sorry, apparently I misread the prevoius version.
> > > > What's wrong with the current implementation of mem=limit@base for the
> > > > kdump case?
> > > 
> > > In the current code, without this patchset, kernel boot hangs when add
> > > mem=3G, mem=3G@64M or memmap=3G@64M to the command-line, it means that
> > > the parameter mem= and memmap= have bug on mips.
> > 
> > I can see how mem=3G may be wrong when the memory does not start at 0, but
> > it seems to do the right thing of mem=3G@64M.
> > 
> > Do you see system hangs with mem=3G@64M?
> 
> Yes.
> 
> > 
> > Do you have the logs before the hang?
> 
> Here are the logs:
> 
> [    0.000000] Linux version 5.17.0-rc3+ (loongson@linux) (gcc (GCC) 7.3.1
> 20180303 (Red Hat 7.3.1-6), GNU ld version 2.28-13.fc21.loongson.6) #1 SMP
> PREEMPT Wed Mar 2 09:07:39 CST 2022
> [    0.000000] CpuClock = 1800000000
> [    0.000000] The bridge chip is LS7A
> [    0.000000] CP0_Config3: CP0 16.3 (0xdc8030a0)
> [    0.000000] CP0_PageGrain: CP0 5.1 (0x28000000)
> [    0.000000] NUMA: Discovered 4 cpus on 1 nodes
> [    0.000000] Node0: mem_type:1, mem_start:0x200000, mem_size:0xee MB
> [    0.000000]        start_pfn:0x80, end_pfn:0x3c00, num_physpages:0x3b80
> [    0.000000] Node0: mem_type:2, mem_start:0x90200000, mem_size:0x6fe MB
> [    0.000000]        start_pfn:0x24080, end_pfn:0x40000,
> num_physpages:0x1fb00
> [    0.000000] Node0: mem_type:2, mem_start:0x120000000, mem_size:0x1600 MB
> [    0.000000]        start_pfn:0x48000, end_pfn:0xa0000,
> num_physpages:0x77b00
> [    0.000000] Node0's addrspace_offset is 0x0
> [    0.000000] Node0: start_pfn=0x80, end_pfn=0xa0000
> [    0.000000] NUMA: set cpumask cpu 0 on node 0
> [    0.000000] NUMA: set cpumask cpu 1 on node 0
> [    0.000000] NUMA: set cpumask cpu 2 on node 0
> [    0.000000] NUMA: set cpumask cpu 3 on node 0
> [    0.000000] printk: bootconsole [early0] enabled
> [    0.000000] CPU0 revision is: 0014c001 (ICT Loongson-3)
> [    0.000000] FPU revision is: 00f70501
> [    0.000000] MSA revision is: 00060140
> [    0.000000] OF: fdt: No chosen node found, continuing without
> [    0.000000] MIPS: machine is loongson,loongson64g-4core-ls7a
> [    0.000000] User-defined physical RAM map overwrite
> [    0.000000] Kernel sections are not in the memory maps
> [    0.000000] Initrd not found or empty - disabling initrd
 
Can you please also send the log with "memblock=debug" added to the kernel
command line?
 
> > As for memmap= option, it does not specify the memory map but rather alters
> > the memory map passed by the firmware. Particularity in MIPS implementation
> > it allows to add a single range of available or reserved memory.
> > 
> > AFAIU, for the kdump use-case mem=X@Y should suffice.
> 
> We can modify some code to make mem=X@Y work well,
> but according to Documentation/admin-guide/kernel-parameters.txt,
> the common way is mem=X and memmap=X@Y, so mem=X@Y for mips seems
> odd, the intention of this patchset is to make mem= and memmap=
> work well and consistent with the other archs.

These options are anyway not consistent on different architectures.
arm, mips and x86 implement mem= one way and arm64, powerpc and riscv in
another so there is no common way to use mem=.

Your changes will break the existing systems that use mem= and memmap=
options because they change the semantics of their MIPS implementation.

For kexec/kdump use-cases modern architectures usually do not pass mem= but
rather prepare the memory map for the kexeced kernel to use. I believe this
would be the right solution.

> Thanks,
> Tiezhu
> 
> > 
> > > Thanks,
> > > Tiezhu
> > > 
> > > > 
> > > > > v4: Fix some build warnings reported by kernel test robot
> > > > > 
> > > > > v3: Modify patch #3 to maintain compatibility for memmap=limit{$,#,!}base,
> > > > >     commented by Mike Rapoport, thank you
> > > > > 
> > > > > v2: Add some new patches to support memmap=limit@base
> > > > > 
> > > > > Tiezhu Yang (4):
> > > > >   MIPS: Refactor early_parse_mem() to fix mem= parameter
> > > > >   memblock: Introduce memblock_mem_range_remove_map()
> > > > >   MIPS: Refactor early_parse_memmap() to fix memmap= parameter
> > > > >   MIPS: Remove not used variable usermem
> > > > > 
> > > > >  arch/mips/kernel/setup.c | 69 ++++++++++++++++++++++--------------------------
> > > > >  include/linux/memblock.h |  1 +
> > > > >  mm/memblock.c            |  9 +++++--
> > > > >  3 files changed, 40 insertions(+), 39 deletions(-)
> > > > > 
> > > > > --
> > > > > 2.1.0
> > > > > 
> > > > 
> > > 
> > 
> 

-- 
Sincerely yours,
Mike.
