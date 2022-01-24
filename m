Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442AF498523
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243875AbiAXQqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbiAXQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:46:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C004C06173B;
        Mon, 24 Jan 2022 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1z4sQ0kHBktu0WFZZnOJ/LrrjXxfbB9BJmEPoulyRdA=; b=CpLrAxZKOqS7CfirRRJa/WfmNg
        txS4UyCh9btgZpRRGI4Jh6v8yyRWe39K6qiYbZQwyU1y3eQ0cKNarCKIzTs/i2gmE7pau9RGgSkI/
        n1XqgwfuRotyjfjGY3L5jmHEfRM9C+ohvAvKiptj0rsmMtnr/FRo4nqdw5FkvmZaXGTutQ50FNGcO
        EoOvLf1pumIvBw0sXZrc2rhSBsz0mZ+jjOvNuUMr+mjjIrH61RxkrkMrNGR/hLLzmCI8rdISOckLL
        fckIWjbI92s01vzgoezTMIO5hPGSJD1v/L+M/dij3FNiHb6vKjzvubmDkbu2IIGKU0NWX+sgNGKc+
        Au6vGvBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nC2U8-000vih-St; Mon, 24 Jan 2022 16:46:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F4C6300B80;
        Mon, 24 Jan 2022 17:46:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7821F2B54C709; Mon, 24 Jan 2022 17:46:28 +0100 (CET)
Date:   Mon, 24 Jan 2022 17:46:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <Ye7X5I4lm8gtRaBv@hirez.programming.kicks-ass.net>
References: <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
 <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
 <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
 <Ye7WLM+NyVQlEMXN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye7WLM+NyVQlEMXN@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 05:39:08PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 24, 2022 at 04:55:22PM +0200, Mathias Nyman wrote:
> >  
> > > [    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
> > > [    4.984106] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
> > > [    9.946159] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
> > > [    9.946163] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
> > >
> > > [   12.818364] xhci_hcd 0000:00:0d.0: xHCI Host Controller
> > > [   12.818373] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
> > > [   12.820360] xhci_hcd 0000:00:0d.0: xHCI Host Controller
> > > [   12.820363] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
> > > [   12.821036] xhci_hcd 0000:00:14.0: xHCI Host Controller
> > > [   12.821040] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
> > > [   12.823451] xhci_hcd 0000:00:14.0: xHCI Host Controller
> > > [   12.823453] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
> > > [   17.115089] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
> > > [   17.115163] usb usb4-port4: config error
> > 
> > Ok, I see it now.
> > Your setup has two xhci controllers, earlypringk=dbc enables dbc on the first xhci
> > it finds, which would be at 0000:00:0d.0.
> > Your cable is connected to the second xhci host at 0000:00:14.0
> > 
> > does using "earlyprintk=xdbc1" work?
> 
> Very quick testing says it don't work.. but I'll try again later, need
> to go cook dinner now.

FYI, I'm thinking early_xdbc_parse_parameter should've now given
dpgp_num: 1 ?

---

[    0.000000] Linux version 5.16.0+ (root@tigerlake) (gcc (Debian 11.2.0-12) 11.2.0, GNU ld (GNU Binutils for Debian) 2.37) #18 SMP PREEMPT Mon Jan 24 17:42:21 CET 2022
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc1,keep force_early_printk sched_verbose ftrace=nop mitigations=off nokaslr
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3632
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000038180fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000038181000-0x0000000040b91fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040b92000-0x0000000040c5dfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000040c5e000-0x0000000040d1cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000040d1d000-0x000000004173afff] reserved
[    0.000000] BIOS-e820: [mem 0x000000004173b000-0x00000000417fefff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000417ff000-0x00000000417fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000041800000-0x0000000047ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000048e00000-0x000000004f7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004b07fffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi: ACPI=0x40cce000 ACPI 2.0=0x40cce014 SMBIOS=0x41568000 SMBIOS 3.0=0x41567000 MEMATTR=0x31355018 ESRT=0x35190298 MOKvar=0x3134c000 
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: Intel(R) Client Systems NUC11PAHi7/NUC11PABi7, BIOS PATGL357.0041.2021.0811.1505 08/11/2021
[    0.000000] tsc: Detected 2800.000 MHz processor
[    0.000000] tsc: Detected 2803.200 MHz TSC
[    0.000002] delay_tsc
[    0.000948] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000949] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000953] last_pfn = 0x4b0800 max_arch_pfn = 0x400000000
[    0.001063] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002183] last_pfn = 0x41800 max_arch_pfn = 0x400000000
[    0.021154] esrt: Reserving ESRT space from 0x0000000035190298 to 0x0000000035190370.
[    0.021157] e820: update [mem 0x35190000-0x35190fff] usable ==> reserved
[    0.021165] e820: update [mem 0x3134c000-0x3134efff] usable ==> reserved
[    0.021174] Using GB pages for direct mapping
[    0.021395] Secure boot could not be determined
[    0.021396] RAMDISK: [mem 0x2f8e0000-0x30b4afff]
[    0.021398] ACPI: Early table checksum verification disabled
[    0.021400] ACPI: RSDP 0x0000000040CCE014 000024 (v02 INTEL )
[    0.021403] ACPI: XSDT 0x0000000040CCD728 0000EC (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021406] ACPI: FACP 0x0000000040C57000 000114 (v06 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021410] ACPI: DSDT 0x0000000040BFC000 05AB35 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021412] ACPI: FACS 0x0000000040D19000 000040
[    0.021413] ACPI: MCFG 0x0000000040C5B000 00003C (v01 INTEL  NUC11PAB 00000029 MSFT 00000097)
[    0.021415] ACPI: SSDT 0x0000000040C58000 00255D (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021417] ACPI: FIDT 0x0000000040BFB000 00009C (v01 INTEL  NUC11PAB 00000029 AMI  00010013)
[    0.021419] ACPI: SSDT 0x0000000040BF8000 002C3E (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021421] ACPI: SSDT 0x0000000040BF4000 003435 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021423] ACPI: SSDT 0x0000000040BE8000 00B27A (v02 INTEL  NUC11PAB 00001000 INTL 20191018)
[    0.021424] ACPI: HPET 0x0000000040C5D000 000038 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021426] ACPI: APIC 0x0000000040C5C000 00012C (v04 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021428] ACPI: SSDT 0x0000000040BE2000 00590A (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021430] ACPI: SSDT 0x0000000040BE1000 000B5E (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021432] ACPI: NHLT 0x0000000040BE0000 00002D (v00 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021433] ACPI: UEFI 0x0000000040CBB000 000048 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021435] ACPI: LPIT 0x0000000040BDF000 0000CC (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021437] ACPI: SSDT 0x0000000040BDB000 002720 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021439] ACPI: SSDT 0x0000000040BDA000 00012A (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021441] ACPI: DBGP 0x0000000040BD9000 000034 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021442] ACPI: DBG2 0x0000000040BD8000 000054 (v00 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021444] ACPI: SSDT 0x0000000040BD6000 0015FC (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021446] ACPI: DMAR 0x0000000040BD5000 0000B8 (v02 INTEL  NUC11PAB 00000029      01000013)
[    0.021448] ACPI: SSDT 0x0000000040BD4000 000823 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021450] ACPI: SSDT 0x0000000040BD3000 000144 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021451] ACPI: PTDT 0x0000000040BD2000 000D44 (v00 INTEL  NUC11PAB 00000029 MSFT 0100000D)
[    0.021453] ACPI: WSMT 0x0000000040BDE000 000028 (v01 INTEL  NUC11PAB 00000029 AMI  00010013)
[    0.021455] ACPI: FPDT 0x0000000040BD1000 000044 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021456] ACPI: Reserving FACP table memory at [mem 0x40c57000-0x40c57113]
[    0.021457] ACPI: Reserving DSDT table memory at [mem 0x40bfc000-0x40c56b34]
[    0.021458] ACPI: Reserving FACS table memory at [mem 0x40d19000-0x40d1903f]
[    0.021459] ACPI: Reserving MCFG table memory at [mem 0x40c5b000-0x40c5b03b]
[    0.021459] ACPI: Reserving SSDT table memory at [mem 0x40c58000-0x40c5a55c]
[    0.021460] ACPI: Reserving FIDT table memory at [mem 0x40bfb000-0x40bfb09b]
[    0.021460] ACPI: Reserving SSDT table memory at [mem 0x40bf8000-0x40bfac3d]
[    0.021461] ACPI: Reserving SSDT table memory at [mem 0x40bf4000-0x40bf7434]
[    0.021462] ACPI: Reserving SSDT table memory at [mem 0x40be8000-0x40bf3279]
[    0.021462] ACPI: Reserving HPET table memory at [mem 0x40c5d000-0x40c5d037]
[    0.021463] ACPI: Reserving APIC table memory at [mem 0x40c5c000-0x40c5c12b]
[    0.021463] ACPI: Reserving SSDT table memory at [mem 0x40be2000-0x40be7909]
[    0.021464] ACPI: Reserving SSDT table memory at [mem 0x40be1000-0x40be1b5d]
[    0.021465] ACPI: Reserving NHLT table memory at [mem 0x40be0000-0x40be002c]
[    0.021465] ACPI: Reserving UEFI table memory at [mem 0x40cbb000-0x40cbb047]
[    0.021466] ACPI: Reserving LPIT table memory at [mem 0x40bdf000-0x40bdf0cb]
[    0.021466] ACPI: Reserving SSDT table memory at [mem 0x40bdb000-0x40bdd71f]
[    0.021467] ACPI: Reserving SSDT table memory at [mem 0x40bda000-0x40bda129]
[    0.021467] ACPI: Reserving DBGP table memory at [mem 0x40bd9000-0x40bd9033]
[    0.021468] ACPI: Reserving DBG2 table memory at [mem 0x40bd8000-0x40bd8053]
[    0.021469] ACPI: Reserving SSDT table memory at [mem 0x40bd6000-0x40bd75fb]
[    0.021469] ACPI: Reserving DMAR table memory at [mem 0x40bd5000-0x40bd50b7]
[    0.021470] ACPI: Reserving SSDT table memory at [mem 0x40bd4000-0x40bd4822]
[    0.021470] ACPI: Reserving SSDT table memory at [mem 0x40bd3000-0x40bd3143]
[    0.021471] ACPI: Reserving PTDT table memory at [mem 0x40bd2000-0x40bd2d43]
[    0.021472] ACPI: Reserving WSMT table memory at [mem 0x40bde000-0x40bde027]
[    0.021472] ACPI: Reserving FPDT table memory at [mem 0x40bd1000-0x40bd1043]
[    0.021848] No NUMA configuration found
[    0.021848] Faking a node at [mem 0x0000000000000000-0x00000004b07fffff]
[    0.021854] NODE_DATA(0) allocated [mem 0x4b07d5000-0x4b07fefff]
[    0.022027] xhci_dbc:xdbc_early_setup: XXX A
[    0.022030] xhci_dbc:xdbc_early_setup: XXX B
[    0.022030] xhci_dbc:xdbc_early_setup: XXX C
[    0.022031] xhci_dbc:xdbc_early_setup: XXX D
[    0.022032] xhci_dbc:xdbc_early_setup: XXX E
[    0.022033] xhci_dbc:xdbc_early_setup: XXX F
[    0.022034] xhci_dbc:xdbc_early_setup: XXX G
[    0.022035] xhci_dbc:xdbc_early_setup: XXX H
[    4.984169] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
[    9.946289] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
[    9.946293] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
[    9.946304] Zone ranges:
[    9.946305]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    9.946306]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    9.946307]   Normal   [mem 0x0000000100000000-0x00000004b07fffff]
[    9.946308]   Device   empty
[    9.946309] Movable zone start for each node
[    9.946310] Early memory node ranges
[    9.946310]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    9.946311]   node   0: [mem 0x0000000000100000-0x0000000038180fff]
[    9.946312]   node   0: [mem 0x00000000417ff000-0x00000000417fffff]
[    9.946313]   node   0: [mem 0x0000000100000000-0x00000004b07fffff]
[    9.946314] Initmem setup node 0 [mem 0x0000000000001000-0x00000004b07fffff]
[    9.946317] On node 0, zone DMA: 1 pages in unavailable ranges
[    9.946339] On node 0, zone DMA: 97 pages in unavailable ranges
[    9.947737] On node 0, zone DMA32: 38526 pages in unavailable ranges
[    9.948069] On node 0, zone Normal: 26624 pages in unavailable ranges
[    9.948243] On node 0, zone Normal: 30720 pages in unavailable ranges
[    9.948285] Reserving Intel graphics memory at [mem 0x4b800000-0x4f7fffff]
[    9.949328] ACPI: PM-Timer IO Port: 0x1808
[    9.949332] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    9.949334] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    9.949334] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    9.949335] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    9.949335] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    9.949336] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    9.949336] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    9.949337] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    9.949337] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    9.949338] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    9.949338] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    9.949338] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    9.949339] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    9.949339] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    9.949340] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    9.949340] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    9.949409] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    9.949427] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    9.949428] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    9.949430] ACPI: Using ACPI (MADT) for SMP configuration information
[    9.949431] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    9.949433] TSC deadline timer available
[    9.949434] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    9.949444] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    9.949446] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    9.949447] PM: hibernation: Registered nosave memory: [mem 0x3134c000-0x3134efff]
[    9.949448] PM: hibernation: Registered nosave memory: [mem 0x35190000-0x35190fff]
[    9.949449] PM: hibernation: Registered nosave memory: [mem 0x38181000-0x40b91fff]
[    9.949450] PM: hibernation: Registered nosave memory: [mem 0x40b92000-0x40c5dfff]
[    9.949450] PM: hibernation: Registered nosave memory: [mem 0x40c5e000-0x40d1cfff]
[    9.949451] PM: hibernation: Registered nosave memory: [mem 0x40d1d000-0x4173afff]
[    9.949451] PM: hibernation: Registered nosave memory: [mem 0x4173b000-0x417fefff]
[    9.949452] PM: hibernation: Registered nosave memory: [mem 0x41800000-0x47ffffff]
[    9.949453] PM: hibernation: Registered nosave memory: [mem 0x48000000-0x48dfffff]
[    9.949453] PM: hibernation: Registered nosave memory: [mem 0x48e00000-0x4f7fffff]
[    9.949454] PM: hibernation: Registered nosave memory: [mem 0x4f800000-0xbfffffff]
[    9.949454] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xcfffffff]
[    9.949455] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xfdffffff]
[    9.949455] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    9.949456] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    9.949456] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    9.949457] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    9.949457] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    9.949458] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed1ffff]
[    9.949458] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    9.949459] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfedfffff]
[    9.949459] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    9.949460] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    9.949460] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    9.949461] [mem 0x4f800000-0xbfffffff] available for PCI devices
[    9.949462] Booting paravirtualized kernel on bare hardware
[    9.949464] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    9.954363] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    9.954474] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
[    9.954479] pcpu-alloc: s212992 r8192 d28672 u262144 alloc=1*2097152
[    9.954480] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    9.954496] Fallback order for Node 0: 0 
[    9.954498] Built 1 zonelists, mobility grouping on.  Total pages: 4034139
[    9.954499] Policy zone: Normal
[    9.954500] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc1,keep force_early_printk sched_verbose ftrace=nop mitigations=off nokaslr
[    9.954549] sysrq: sysrq always enabled.
[    9.954593] Unknown kernel command line parameters "force_early_printk nokaslr BOOT_IMAGE=/boot/vmlinuz-5.16.0+", will be passed to user space.
[    9.954988] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    9.955190] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    9.955243] mem auto-init: stack:off, heap alloc:on, heap free:off
[    9.965576] Memory: 797624K/16393344K available (20499K kernel code, 4046K rwdata, 14224K rodata, 2800K init, 4764K bss, 541540K reserved, 0K cma-reserved)
[    9.965580] random: get_random_u64 called from __kmem_cache_create+0x2a/0x530 with crng_init=0
[    9.965655] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    9.965663] ftrace: allocating 63046 entries in 247 pages
[    9.977700] ftrace: allocated 247 pages with 7 groups
[    9.977848] Starting tracer 'nop'
[    9.978630] Dynamic Preempt: voluntary
[    9.978649] rcu: Preemptible hierarchical RCU implementation.
[    9.978649] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    9.978650] 	Trampoline variant of Tasks RCU enabled.
[    9.978651] 	Rude variant of Tasks RCU enabled.
[    9.978651] 	Tracing variant of Tasks RCU enabled.
[    9.978652] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    9.978652] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    9.981033] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    9.981730] random: crng done (trusting CPU's manufacturer)
[    9.981746] Console: colour dummy device 80x25
[    9.981943] printk: console [tty0] enabled
[    9.981952] ACPI: Core revision 20210930
[    9.982139] hpet: HPET dysfunctional in PC10. Force disabled.
[    9.982140] APIC: Switch to symmetric I/O mode setup
[    9.982142] DMAR: Host address width 39
[    9.982143] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    9.982147] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 69e2ff0505e
[    9.982150] DMAR: DRHD base: 0x000000fed84000 flags: 0x0
[    9.982151] DMAR: dmar1: reg_base_addr fed84000 ver 1:0 cap d2008c40660462 ecap f050da
[    9.982155] DMAR: DRHD base: 0x000000fed87000 flags: 0x0
[    9.982157] DMAR: dmar2: reg_base_addr fed87000 ver 1:0 cap d2008c40660462 ecap f050da
[    9.982161] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    9.982163] DMAR: dmar3: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    9.982168] DMAR: RMRR base: 0x0000004b000000 end: 0x0000004f7fffff
[    9.982171] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 3
[    9.982172] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    9.982174] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    9.986552] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    9.986554] x2apic enabled
[    9.986608] Switched APIC routing to cluster x2apic.
[    9.998278] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[    9.998284] Calibrating delay loop (skipped), value calculated using timer frequency.. 5606.40 BogoMIPS (lpj=11212800)
[    9.998287] pid_max: default: 32768 minimum: 301
[   10.000830] LSM: Security Framework initializing
[   10.000838] Yama: becoming mindful.
[   10.000852] AppArmor: AppArmor initialized
[   10.000854] TOMOYO Linux initialized
[   10.000879] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[   10.000897] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[   10.001051] CPU0: Thermal monitoring enabled (TM1)
[   10.001053] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[   10.001140] process: using mwait in idle threads
[   10.001142] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[   10.001143] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[   10.001146] Speculative Store Bypass: Vulnerable
[   10.002281] Freeing SMP alternatives memory: 60K
[   10.002281] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1499
[   10.002281] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz (family: 0x6, model: 0x8c, stepping: 0x1)
[   10.002281] Performance Events: PEBS fmt4+-baseline,  AnyThread deprecated, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
[   10.002281] ... version:                5
[   10.002281] ... bit width:              48
[   10.002281] ... generic registers:      8
[   10.002281] ... value mask:             0000ffffffffffff
[   10.002281] ... max period:             00007fffffffffff
[   10.002281] ... fixed-purpose events:   4
[   10.002281] ... event mask:             0001000f000000ff
[   10.002281] rcu: Hierarchical SRCU implementation.
[   10.002281] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[   10.002281] smp: Bringing up secondary CPUs ...
[   10.002281] x86: Booting SMP configuration:
[   10.002281] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[   10.003202] smp: Brought up 1 node, 8 CPUs
[   10.003202] smpboot: Max logical packages: 1
[   10.003202] smpboot: Total of 8 processors activated (44851.20 BogoMIPS)
[   10.006313] CPU0 attaching sched-domain(s):
[   10.006314]  domain-0: span=0,4 level=SMT
[   10.006316]   groups: 0:{ span=0 }, 4:{ span=4 }
[   10.006319]   domain-1: span=0-7 level=MC
[   10.006321]    groups: 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }
[   10.006329] CPU1 attaching sched-domain(s):
[   10.006330]  domain-0: span=1,5 level=SMT
[   10.006331]   groups: 1:{ span=1 }, 5:{ span=5 }
[   10.006333]   domain-1: span=0-7 level=MC
[   10.006334]    groups: 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }
[   10.006340] CPU2 attaching sched-domain(s):
[   10.006341]  domain-0: span=2,6 level=SMT
[   10.006342]   groups: 2:{ span=2 }, 6:{ span=6 }
[   10.006344]   domain-1: span=0-7 level=MC
[   10.006345]    groups: 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }
[   10.006351] CPU3 attaching sched-domain(s):
[   10.006351]  domain-0: span=3,7 level=SMT
[   10.006353]   groups: 3:{ span=3 }, 7:{ span=7 }
[   10.006355]   domain-1: span=0-7 level=MC
[   10.006356]    groups: 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }
[   10.006362] CPU4 attaching sched-domain(s):
[   10.006362]  domain-0: span=0,4 level=SMT
[   10.006364]   groups: 4:{ span=4 }, 0:{ span=0 }
[   10.006366]   domain-1: span=0-7 level=MC
[   10.006367]    groups: 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }
[   10.006372] CPU5 attaching sched-domain(s):
[   10.006373]  domain-0: span=1,5 level=SMT
[   10.006374]   groups: 5:{ span=5 }, 1:{ span=1 }
[   10.006377]   domain-1: span=0-7 level=MC
[   10.006378]    groups: 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }
[   10.006383] CPU6 attaching sched-domain(s):
[   10.006384]  domain-0: span=2,6 level=SMT
[   10.006385]   groups: 6:{ span=6 }, 2:{ span=2 }
[   10.006387]   domain-1: span=0-7 level=MC
[   10.006388]    groups: 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }
[   10.006394] CPU7 attaching sched-domain(s):
[   10.006395]  domain-0: span=3,7 level=SMT
[   10.006396]   groups: 7:{ span=7 }, 3:{ span=3 }
[   10.006398]   domain-1: span=0-7 level=MC
[   10.006399]    groups: 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }
[   10.006404] root domain span: 0-7 (max cpu_capacity = 1024)
[   10.022327] node 0 deferred pages initialised in 16ms
[   10.022779] devtmpfs: initialized
[   10.022779] x86/mm: Memory block size: 128MB
[   10.022897] ACPI: PM: Registering ACPI NVS region [mem 0x40c5e000-0x40d1cfff] (782336 bytes)
[   10.022897] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[   10.022897] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[   10.022897] pinctrl core: initialized pinctrl subsystem
[   10.022897] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[   10.022897] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[   10.022897] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[   10.022960] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[   10.022969] audit: initializing netlink subsys (disabled)
[   10.022977] audit: type=2000 audit(1643042632.024:1): state=initialized audit_enabled=0 res=1
[   10.022977] thermal_sys: Registered thermal governor 'fair_share'
[   10.022977] thermal_sys: Registered thermal governor 'bang_bang'
[   10.022977] thermal_sys: Registered thermal governor 'step_wise'
[   10.022977] thermal_sys: Registered thermal governor 'user_space'
[   10.022977] thermal_sys: Registered thermal governor 'power_allocator'
[   10.022977] cpuidle: using governor ladder
[   10.022977] cpuidle: using governor menu
[   10.022977] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[   10.022977] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[   10.022977] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[   10.022977] PCI: Using configuration type 1 for base access
[   10.022977] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[   10.026647] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[   10.026653] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[   10.026653] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[   10.026653] cryptd: max_cpu_qlen set to 1000
[   10.094283] raid6: avx512x4 gen() 64316 MB/s
[   10.162282] raid6: avx512x4 xor() 17948 MB/s
[   10.230282] raid6: avx512x2 gen() 73845 MB/s
[   10.298282] raid6: avx512x2 xor() 42700 MB/s
[   10.366282] raid6: avx512x1 gen() 67001 MB/s
[   10.434282] raid6: avx512x1 xor() 38395 MB/s
[   10.502282] raid6: avx2x4   gen() 55757 MB/s
[   10.570282] raid6: avx2x4   xor() 20386 MB/s
[   10.638282] raid6: avx2x2   gen() 55331 MB/s
[   10.706282] raid6: avx2x2   xor() 32276 MB/s
[   10.774282] raid6: avx2x1   gen() 42244 MB/s
[   10.842282] raid6: avx2x1   xor() 24911 MB/s
[   10.910282] raid6: sse2x4   gen() 14349 MB/s
[   10.978283] raid6: sse2x4   xor()  7199 MB/s
[   11.046282] raid6: sse2x2   gen() 14716 MB/s
[   11.114283] raid6: sse2x2   xor()  9440 MB/s
[   11.182282] raid6: sse2x1   gen() 13472 MB/s
[   11.250282] raid6: sse2x1   xor()  7579 MB/s
[   11.250283] raid6: using algorithm avx512x2 gen() 73845 MB/s
[   11.250284] raid6: .... xor() 42700 MB/s, rmw enabled
[   11.250286] raid6: using avx512x2 recovery algorithm
[   11.250369] ACPI: Added _OSI(Module Device)
[   11.250377] ACPI: Added _OSI(Processor Device)
[   11.250377] ACPI: Added _OSI(3.0 _SCP Extensions)
[   11.250377] ACPI: Added _OSI(Processor Aggregator Device)
[   11.250377] ACPI: Added _OSI(Linux-Dell-Video)
[   11.250377] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[   11.250377] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[   11.295269] ACPI: 12 ACPI AML tables successfully acquired and loaded
[   11.295869] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^SPI1.SPFD.CVFD (20210930/dspkginit-438)
[   11.295874] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^SPI1.SPFD.CVFD (20210930/dspkginit-438)
[   11.295877] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^XHCI.RHUB.HS04.VI2C (20210930/dspkginit-438)
[   11.295886] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^XHCI.RHUB.HS04.VI2C (20210930/dspkginit-438)
[   11.306284] ACPI: Dynamic OEM Table Load:
[   11.306284] ACPI: SSDT 0xFFFF88810257D600 0001CB (v02 PmRef  Cpu0Psd  00003000 INTL 20191018)
[   11.306284] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[   11.306284] ACPI: Dynamic OEM Table Load:
[   11.306284] ACPI: SSDT 0xFFFF8881025BCC00 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20191018)
[   11.306284] ACPI: Dynamic OEM Table Load:
[   11.306284] ACPI: SSDT 0xFFFF8881025C5000 000647 (v02 PmRef  Cpu0Ist  00003000 INTL 20191018)
[   11.306459] ACPI: Dynamic OEM Table Load:
[   11.306463] ACPI: SSDT 0xFFFF8881025BF000 000266 (v02 PmRef  Cpu0Hwp  00003000 INTL 20191018)
[   11.307238] ACPI: Dynamic OEM Table Load:
[   11.307243] ACPI: SSDT 0xFFFF888101E42000 0008E7 (v02 PmRef  ApIst    00003000 INTL 20191018)
[   11.308002] ACPI: Dynamic OEM Table Load:
[   11.308005] ACPI: SSDT 0xFFFF8881025C1800 00048A (v02 PmRef  ApHwp    00003000 INTL 20191018)
[   11.308715] ACPI: Dynamic OEM Table Load:
[   11.308719] ACPI: SSDT 0xFFFF8881025C4800 0004D4 (v02 PmRef  ApPsd    00003000 INTL 20191018)
[   11.309421] ACPI: Dynamic OEM Table Load:
[   11.309425] ACPI: SSDT 0xFFFF8881025C3800 00048A (v02 PmRef  ApCst    00003000 INTL 20191018)
[   11.742344] ACPI: EC: EC started
[   11.742346] ACPI: EC: interrupt blocked
[   11.742373] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[   11.742376] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC used to handle transactions
[   11.742378] ACPI: Interpreter enabled
[   11.742431] ACPI: PM: (supports S0 S3 S4 S5)
[   11.742433] ACPI: Using IOAPIC for interrupt routing
[   11.742478] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[   11.744167] ACPI: Enabled 7 GPEs in block 00 to 7F
[   11.749134] ACPI: PM: Power Resource [PXP]
[   11.749993] ACPI: PM: Power Resource [PXP]
[   11.756133] ACPI: PM: Power Resource [BTPR]
[   11.756661] ACPI: PM: Power Resource [PAUD]
[   11.758479] ACPI: PM: Power Resource [V0PR]
[   11.758552] ACPI: PM: Power Resource [V1PR]
[   11.758620] ACPI: PM: Power Resource [V2PR]
[   11.760437] ACPI: PM: Power Resource [PXTC]
[   11.760639] ACPI: PM: Power Resource [PTPL]
[   11.761025] ACPI: PM: Power Resource [PXTC]
[   11.761460] ACPI: PM: Power Resource [PXTC]
[   11.766760] ACPI: PM: Power Resource [WRST]
[   11.768746] ACPI: PM: Power Resource [TBT0]
[   11.768941] ACPI: PM: Power Resource [TBT1]
[   11.769131] ACPI: PM: Power Resource [D3C]
[   12.038232] ACPI: PM: Power Resource [FN00]
[   12.038288] ACPI: PM: Power Resource [FN01]
[   12.038346] ACPI: PM: Power Resource [FN02]
[   12.038950] ACPI: PM: Power Resource [PIN]
[   12.039255] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[   12.039270] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[   12.041823] acpi PNP0A08:00: _OSC: platform does not support [AER]
[   12.046619] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
[   12.048266] PCI host bridge to bus 0000:00
[   12.048268] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[   12.048270] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[   12.048272] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[   12.048273] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[   12.048275] pci_bus 0000:00: root bus resource [mem 0x4f800000-0xbfffffff window]
[   12.048276] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[   12.048278] pci_bus 0000:00: root bus resource [bus 00-fe]
[   12.048391] pci 0000:00:00.0: [8086:9a14] type 00 class 0x060000
[   12.048666] pci 0000:00:02.0: [8086:9a49] type 00 class 0x030000
[   12.048675] pci 0000:00:02.0: reg 0x10: [mem 0x603c000000-0x603cffffff 64bit]
[   12.048680] pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x400fffffff 64bit pref]
[   12.048684] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[   12.048697] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[   12.048720] pci 0000:00:02.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bit]
[   12.048722] pci 0000:00:02.0: VF(n) BAR0 space: [mem 0x00000000-0x06ffffff 64bit] (contains BAR0 for 7 VFs)
[   12.048727] pci 0000:00:02.0: reg 0x34c: [mem 0x00000000-0x1fffffff 64bit pref]
[   12.048728] pci 0000:00:02.0: VF(n) BAR2 space: [mem 0x00000000-0xdfffffff 64bit pref] (contains BAR2 for 7 VFs)
[   12.048866] pci 0000:00:06.0: [8086:9a09] type 01 class 0x060400
[   12.048956] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[   12.048992] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[   12.049369] pci 0000:00:07.0: [8086:9a23] type 01 class 0x060400
[   12.049439] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[   12.049462] pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
[   12.050573] pci 0000:00:07.3: [8086:9a29] type 01 class 0x060400
[   12.050644] pci 0000:00:07.3: PME# supported from D0 D3hot D3cold
[   12.050666] pci 0000:00:07.3: DPC: RP PIO log size 0 is invalid
[   12.051777] pci 0000:00:08.0: [8086:9a11] type 00 class 0x088000
[   12.051785] pci 0000:00:08.0: reg 0x10: [mem 0x603d1b2000-0x603d1b2fff 64bit]
[   12.051915] pci 0000:00:0d.0: [8086:9a13] type 00 class 0x0c0330
[   12.051927] pci 0000:00:0d.0: reg 0x10: [mem 0x603d190000-0x603d19ffff 64bit]
[   12.051979] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[   12.053011] pci 0000:00:0d.2: [8086:9a1b] type 00 class 0x0c0340
[   12.053021] pci 0000:00:0d.2: reg 0x10: [mem 0x603d140000-0x603d17ffff 64bit]
[   12.053028] pci 0000:00:0d.2: reg 0x18: [mem 0x603d1b1000-0x603d1b1fff 64bit]
[   12.053058] pci 0000:00:0d.2: supports D1 D2
[   12.053060] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
[   12.053129] pci 0000:00:0d.3: [8086:9a1d] type 00 class 0x0c0340
[   12.053139] pci 0000:00:0d.3: reg 0x10: [mem 0x603d100000-0x603d13ffff 64bit]
[   12.053146] pci 0000:00:0d.3: reg 0x18: [mem 0x603d1b0000-0x603d1b0fff 64bit]
[   12.053176] pci 0000:00:0d.3: supports D1 D2
[   12.053177] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold
[   12.053387] pci 0000:00:14.0: [8086:a0ed] type 00 class 0x0c0330
[   12.053410] pci 0000:00:14.0: reg 0x10: [mem 0x603d180000-0x603d18ffff 64bit]
[   12.053512] pci 0000:00:14.0: PME# supported from D3hot D3cold
[   12.054557] pci 0000:00:14.2: [8086:a0ef] type 00 class 0x050000
[   12.054579] pci 0000:00:14.2: reg 0x10: [mem 0x603d1a8000-0x603d1abfff 64bit]
[   12.054596] pci 0000:00:14.2: reg 0x18: [mem 0x603d1af000-0x603d1affff 64bit]
[   12.054741] pci 0000:00:14.3: [8086:a0f0] type 00 class 0x028000
[   12.054785] pci 0000:00:14.3: reg 0x10: [mem 0x603d1a4000-0x603d1a7fff 64bit]
[   12.054942] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[   12.055637] pci 0000:00:15.0: [8086:a0e8] type 00 class 0x0c8000
[   12.056369] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   12.059525] pci 0000:00:16.0: [8086:a0e0] type 00 class 0x078000
[   12.059551] pci 0000:00:16.0: reg 0x10: [mem 0x603d1ad000-0x603d1adfff 64bit]
[   12.059645] pci 0000:00:16.0: PME# supported from D3hot
[   12.059989] pci 0000:00:17.0: [8086:a0d3] type 00 class 0x010601
[   12.060009] pci 0000:00:17.0: reg 0x10: [mem 0x6a600000-0x6a601fff]
[   12.060022] pci 0000:00:17.0: reg 0x14: [mem 0x6a603000-0x6a6030ff]
[   12.060033] pci 0000:00:17.0: reg 0x18: [io  0x3090-0x3097]
[   12.060043] pci 0000:00:17.0: reg 0x1c: [io  0x3080-0x3083]
[   12.060054] pci 0000:00:17.0: reg 0x20: [io  0x3060-0x307f]
[   12.060064] pci 0000:00:17.0: reg 0x24: [mem 0x6a602000-0x6a6027ff]
[   12.060120] pci 0000:00:17.0: PME# supported from D3hot
[   12.060534] pci 0000:00:1c.0: [8086:a0bc] type 01 class 0x060400
[   12.060657] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[   12.060698] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[   12.061124] pci 0000:00:1c.6: [8086:a0be] type 01 class 0x060400
[   12.061246] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[   12.061287] pci 0000:00:1c.6: PTM enabled (root), 4ns granularity
[   12.061672] pci 0000:00:1f.0: [8086:a082] type 00 class 0x060100
[   12.061977] pci 0000:00:1f.3: [8086:a0c8] type 00 class 0x040380
[   12.062039] pci 0000:00:1f.3: reg 0x10: [mem 0x603d1a0000-0x603d1a3fff 64bit]
[   12.062115] pci 0000:00:1f.3: reg 0x20: [mem 0x603d000000-0x603d0fffff 64bit]
[   12.062274] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[   12.062587] pci 0000:00:1f.4: [8086:a0a3] type 00 class 0x0c0500
[   12.062619] pci 0000:00:1f.4: reg 0x10: [mem 0x603d1ac000-0x603d1ac0ff 64bit]
[   12.062655] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[   12.062843] pci 0000:00:1f.5: [8086:a0a4] type 00 class 0x0c8000
[   12.062865] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[   12.063345] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
[   12.063361] pci 0000:01:00.0: reg 0x10: [mem 0x6a500000-0x6a503fff 64bit]
[   12.063537] pci 0000:00:06.0: PCI bridge to [bus 01]
[   12.063540] pci 0000:00:06.0:   bridge window [mem 0x6a500000-0x6a5fffff]
[   12.063571] pci 0000:00:07.0: PCI bridge to [bus 02-2c]
[   12.063575] pci 0000:00:07.0:   bridge window [mem 0x5e000000-0x6a1fffff]
[   12.063580] pci 0000:00:07.0:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[   12.063608] pci 0000:00:07.3: PCI bridge to [bus 2d-57]
[   12.063612] pci 0000:00:07.3:   bridge window [mem 0x50000000-0x5c1fffff]
[   12.063616] pci 0000:00:07.3:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[   12.063776] pci 0000:58:00.0: [17a0:9755] type 00 class 0x080501
[   12.063823] pci 0000:58:00.0: reg 0x10: [mem 0x6a400000-0x6a400fff]
[   12.064161] pci 0000:58:00.0: supports D1 D2
[   12.064162] pci 0000:58:00.0: PME# supported from D1 D2 D3hot D3cold
[   12.064568] pci 0000:00:1c.0: PCI bridge to [bus 58]
[   12.064573] pci 0000:00:1c.0:   bridge window [mem 0x6a400000-0x6a4fffff]
[   12.064754] pci 0000:59:00.0: [8086:15f3] type 00 class 0x020000
[   12.064773] pci 0000:59:00.0: reg 0x10: [mem 0x6a200000-0x6a2fffff]
[   12.064798] pci 0000:59:00.0: reg 0x1c: [mem 0x6a300000-0x6a303fff]
[   12.064924] pci 0000:59:00.0: PME# supported from D0 D3hot D3cold
[   12.065053] pci 0000:00:1c.6: PCI bridge to [bus 59]
[   12.065058] pci 0000:00:1c.6:   bridge window [mem 0x6a200000-0x6a3fffff]
[   12.069113] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[   12.069181] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[   12.069247] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[   12.069312] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[   12.069378] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[   12.069443] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[   12.069508] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[   12.069574] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[   12.090165] ACPI: EC: interrupt unblocked
[   12.090167] ACPI: EC: event unblocked
[   12.090211] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[   12.090213] ACPI: EC: GPE=0x6e
[   12.090214] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC initialization complete
[   12.090216] ACPI: \_SB_.PC00.LPCB.H_EC: EC: Used to handle transactions and events
[   12.090294] iommu: Default domain type: Translated 
[   12.090294] iommu: DMA domain TLB invalidation policy: lazy mode 
[   12.090300] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[   12.090300] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[   12.090300] pci 0000:00:02.0: vgaarb: bridge control possible
[   12.090300] vgaarb: loaded
[   12.090335] SCSI subsystem initialized
[   12.094290] libata version 3.00 loaded.
[   12.094294] ACPI: bus type USB registered
[   12.094302] usbcore: registered new interface driver usbfs
[   12.094306] usbcore: registered new interface driver hub
[   12.094310] usbcore: registered new device driver usb
[   12.094330] pps_core: LinuxPPS API ver. 1 registered
[   12.094331] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   12.094333] PTP clock support registered
[   12.094340] EDAC MC: Ver: 3.0.0
[   12.094948] Registered efivars operations
[   12.094948] Advanced Linux Sound Architecture Driver Initialized.
[   12.094948] Bluetooth: Core ver 2.22
[   12.094948] NET: Registered PF_BLUETOOTH protocol family
[   12.094948] Bluetooth: HCI device and connection manager initialized
[   12.094948] Bluetooth: HCI socket layer initialized
[   12.094948] Bluetooth: L2CAP socket layer initialized
[   12.094948] Bluetooth: SCO socket layer initialized
[   12.094948] NetLabel: Initializing
[   12.094948] NetLabel:  domain hash size = 128
[   12.094948] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[   12.094948] NetLabel:  unlabeled traffic allowed by default
[   12.094948] PCI: Using ACPI for IRQ routing
[   12.167584] PCI: pci_cache_line_size set to 64 bytes
[   12.168135] pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010fff]: no compatible bridge window
[   12.168680] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[   12.168682] e820: reserve RAM buffer [mem 0x3134c000-0x33ffffff]
[   12.168684] e820: reserve RAM buffer [mem 0x35190000-0x37ffffff]
[   12.168685] e820: reserve RAM buffer [mem 0x38181000-0x3bffffff]
[   12.168686] e820: reserve RAM buffer [mem 0x41800000-0x43ffffff]
[   12.168687] e820: reserve RAM buffer [mem 0x4b0800000-0x4b3ffffff]
[   12.170340] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[   12.170363] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[   12.170450] clocksource: Switched to clocksource tsc-early
[   12.176874] VFS: Disk quotas dquot_6.6.0
[   12.176885] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   12.176951] AppArmor: AppArmor Filesystem Enabled
[   12.176962] pnp: PnP ACPI init
[   12.177227] system 00:00: [io  0x0a00-0x0a0f] has been reserved
[   12.177230] system 00:00: [io  0x0a10-0x0a2f] has been reserved
[   12.177231] system 00:00: [io  0x0a30-0x0a4f] has been reserved
[   12.177232] system 00:00: [io  0x0a50-0x0a6f] has been reserved
[   12.177234] system 00:00: [io  0x0a70-0x0a7f] has been reserved
[   12.177235] system 00:00: [io  0x0a80-0x0a8f] has been reserved
[   12.177463] system 00:01: [io  0x0680-0x069f] has been reserved
[   12.177464] system 00:01: [io  0x164e-0x164f] has been reserved
[   12.177541] system 00:02: [io  0x1854-0x1857] has been reserved
[   12.177955] pnp 00:03: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[   12.177971] system 00:03: [mem 0xfedc0000-0xfedc7fff] has been reserved
[   12.177973] system 00:03: [mem 0xfeda0000-0xfeda0fff] has been reserved
[   12.177974] system 00:03: [mem 0xfeda1000-0xfeda1fff] has been reserved
[   12.177976] system 00:03: [mem 0xfed20000-0xfed7ffff] has been reserved
[   12.177977] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[   12.177979] system 00:03: [mem 0xfed45000-0xfed8ffff] could not be reserved
[   12.177980] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
[   12.179961] system 00:04: [io  0x1800-0x18fe] could not be reserved
[   12.179963] system 00:04: [mem 0xfe000000-0xfe01ffff] could not be reserved
[   12.179965] system 00:04: [mem 0xfe04c000-0xfe04ffff] has been reserved
[   12.179967] system 00:04: [mem 0xfe050000-0xfe0affff] has been reserved
[   12.179968] system 00:04: [mem 0xfe0d0000-0xfe0fffff] has been reserved
[   12.179970] system 00:04: [mem 0xfe200000-0xfe7fffff] has been reserved
[   12.179971] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[   12.179973] system 00:04: [mem 0xfd000000-0xfd68ffff] has been reserved
[   12.179974] system 00:04: [mem 0xfd6b0000-0xfd6cffff] has been reserved
[   12.179976] system 00:04: [mem 0xfd6f0000-0xfdffffff] has been reserved
[   12.180192] system 00:05: [io  0x2000-0x20fe] has been reserved
[   12.180438] system 00:07: [mem 0xfe410400-0xfe4104fe] has been reserved
[   12.180499] pnp: PnP ACPI: found 8 devices
[   12.185625] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[   12.185665] NET: Registered PF_INET protocol family
[   12.185789] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[   12.186753] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[   12.186818] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[   12.186944] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[   12.186985] TCP: Hash tables configured (established 131072 bind 65536)
[   12.187043] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
[   12.187086] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[   12.187114] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[   12.187152] NET: Registered PF_UNIX/PF_LOCAL protocol family
[   12.187268] RPC: Registered named UNIX socket transport module.
[   12.187271] RPC: Registered udp transport module.
[   12.187272] RPC: Registered tcp transport module.
[   12.187272] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   12.187382] NET: Registered PF_XDP protocol family
[   12.187386] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
[   12.187393] pci 0000:00:02.0: BAR 9: assigned [mem 0x4020000000-0x40ffffffff 64bit pref]
[   12.187397] pci 0000:00:02.0: BAR 7: assigned [mem 0x4010000000-0x4016ffffff 64bit]
[   12.187400] pci 0000:00:07.0: BAR 13: assigned [io  0x4000-0x4fff]
[   12.187402] pci 0000:00:07.3: BAR 13: assigned [io  0x5000-0x5fff]
[   12.187404] pci 0000:00:15.0: BAR 0: assigned [mem 0x4017000000-0x4017000fff 64bit]
[   12.187751] pci 0000:00:1f.5: BAR 0: assigned [mem 0x4f800000-0x4f800fff]
[   12.187767] pci 0000:00:06.0: PCI bridge to [bus 01]
[   12.187776] pci 0000:00:06.0:   bridge window [mem 0x6a500000-0x6a5fffff]
[   12.187792] pci 0000:00:07.0: PCI bridge to [bus 02-2c]
[   12.187794] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]
[   12.187797] pci 0000:00:07.0:   bridge window [mem 0x5e000000-0x6a1fffff]
[   12.187800] pci 0000:00:07.0:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[   12.187804] pci 0000:00:07.3: PCI bridge to [bus 2d-57]
[   12.187806] pci 0000:00:07.3:   bridge window [io  0x5000-0x5fff]
[   12.187809] pci 0000:00:07.3:   bridge window [mem 0x50000000-0x5c1fffff]
[   12.187812] pci 0000:00:07.3:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[   12.187817] pci 0000:00:1c.0: PCI bridge to [bus 58]
[   12.187834] pci 0000:00:1c.0:   bridge window [mem 0x6a400000-0x6a4fffff]
[   12.187842] pci 0000:00:1c.6: PCI bridge to [bus 59]
[   12.187846] pci 0000:00:1c.6:   bridge window [mem 0x6a200000-0x6a3fffff]
[   12.187854] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[   12.187855] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[   12.187856] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[   12.187858] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000fffff window]
[   12.187859] pci_bus 0000:00: resource 8 [mem 0x4f800000-0xbfffffff window]
[   12.187860] pci_bus 0000:00: resource 9 [mem 0x4000000000-0x7fffffffff window]
[   12.187862] pci_bus 0000:01: resource 1 [mem 0x6a500000-0x6a5fffff]
[   12.187863] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[   12.187864] pci_bus 0000:02: resource 1 [mem 0x5e000000-0x6a1fffff]
[   12.187866] pci_bus 0000:02: resource 2 [mem 0x6020000000-0x603bffffff 64bit pref]
[   12.187867] pci_bus 0000:2d: resource 0 [io  0x5000-0x5fff]
[   12.187868] pci_bus 0000:2d: resource 1 [mem 0x50000000-0x5c1fffff]
[   12.187870] pci_bus 0000:2d: resource 2 [mem 0x6000000000-0x601bffffff 64bit pref]
[   12.187871] pci_bus 0000:58: resource 1 [mem 0x6a400000-0x6a4fffff]
[   12.187873] pci_bus 0000:59: resource 1 [mem 0x6a200000-0x6a3fffff]
[   12.187961] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[   12.188772] PCI: CLS 64 bytes, default 64
[   12.188778] DMAR: Intel-IOMMU force enabled due to platform opt in
[   12.188790] DMAR: No ATSR found
[   12.188791] DMAR: No SATC found
[   12.188792] DMAR: IOMMU feature fl1gp_support inconsistent
[   12.188793] DMAR: IOMMU feature pgsel_inv inconsistent
[   12.188794] DMAR: IOMMU feature nwfs inconsistent
[   12.188795] DMAR: IOMMU feature pds inconsistent
[   12.188796] DMAR: IOMMU feature dit inconsistent
[   12.188797] DMAR: IOMMU feature eafs inconsistent
[   12.188797] DMAR: IOMMU feature prs inconsistent
[   12.188798] DMAR: IOMMU feature nest inconsistent
[   12.188799] DMAR: IOMMU feature mts inconsistent
[   12.188800] DMAR: IOMMU feature sc_support inconsistent
[   12.188800] DMAR: IOMMU feature dev_iotlb_support inconsistent
[   12.188802] DMAR: dmar2: Using Queued invalidation
[   12.188805] DMAR: dmar1: Using Queued invalidation
[   12.188808] DMAR: dmar0: Using Queued invalidation
[   12.188809] DMAR: dmar3: Using Queued invalidation
[   12.188821] Unpacking initramfs...
[   12.188936] pci 0000:00:00.0: Adding to iommu group 0
[   12.188942] pci 0000:00:02.0: Adding to iommu group 1
[   12.188956] pci 0000:00:06.0: Adding to iommu group 2
[   12.188962] pci 0000:00:07.0: Adding to iommu group 3
[   12.188969] pci 0000:00:07.3: Adding to iommu group 4
[   12.188974] pci 0000:00:08.0: Adding to iommu group 5
[   12.188984] pci 0000:00:0d.0: Adding to iommu group 6
[   12.188988] pci 0000:00:0d.2: Adding to iommu group 6
[   12.188993] pci 0000:00:0d.3: Adding to iommu group 6
[   12.189002] pci 0000:00:14.0: Adding to iommu group 7
[   12.189007] pci 0000:00:14.2: Adding to iommu group 7
[   12.189012] pci 0000:00:14.3: Adding to iommu group 8
[   12.189019] pci 0000:00:15.0: Adding to iommu group 9
[   12.189026] pci 0000:00:16.0: Adding to iommu group 10
[   12.189031] pci 0000:00:17.0: Adding to iommu group 11
[   12.189051] pci 0000:00:1c.0: Adding to iommu group 12
[   12.189066] pci 0000:00:1c.6: Adding to iommu group 13
[   12.189078] pci 0000:00:1f.0: Adding to iommu group 14
[   12.189083] pci 0000:00:1f.3: Adding to iommu group 14
[   12.189089] pci 0000:00:1f.4: Adding to iommu group 14
[   12.189094] pci 0000:00:1f.5: Adding to iommu group 14
[   12.189106] pci 0000:01:00.0: Adding to iommu group 15
[   12.189127] pci 0000:58:00.0: Adding to iommu group 16
[   12.189140] pci 0000:59:00.0: Adding to iommu group 17
[   12.189233] DMAR: Intel(R) Virtualization Technology for Directed I/O
[   12.189234] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   12.189236] software IO TLB: mapped [mem 0x000000002b8e0000-0x000000002f8e0000] (64MB)
[   12.198401] resource sanity check: requesting [mem 0xfedc0000-0xfedcdfff], which spans more than pnp 00:03 [mem 0xfedc0000-0xfedc7fff]
[   12.198407] caller tgl_uncore_imc_freerunning_init_box+0xb7/0xf0 mapping multiple BARs
[   12.267405] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[   12.267425] clocksource: Switched to clocksource tsc
[   12.267435] platform rtc_cmos: registered platform RTC device (no PNP device found)
[   12.267681] Initialise system trusted keyrings
[   12.267688] Key type blacklist registered
[   12.267726] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[   12.268317] zbud: loaded
[   12.268522] NFS: Registering the id_resolver key type
[   12.268529] Key type id_resolver registered
[   12.268531] Key type id_legacy registered
[   12.268546] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[   12.268548] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[   12.268550] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   12.268729] fuse: init (API version 7.35)
[   12.268823] integrity: Platform Keyring initialized
[   12.275179] NET: Registered PF_ALG protocol family
[   12.275180] xor: automatically using best checksumming function   avx       
[   12.275183] async_tx: api initialized (async)
[   12.275184] Key type asymmetric registered
[   12.275186] Asymmetric key parser 'x509' registered
[   12.275198] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[   12.275229] io scheduler mq-deadline registered
[   12.282606] pcieport 0000:00:06.0: PME: Signaling with IRQ 124
[   12.282777] pcieport 0000:00:07.0: PME: Signaling with IRQ 125
[   12.282790] pcieport 0000:00:07.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[   12.282979] pcieport 0000:00:07.3: PME: Signaling with IRQ 126
[   12.282991] pcieport 0000:00:07.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[   12.353913] Freeing initrd memory: 18860K
[   12.411108] pcieport 0000:00:1c.0: PME: Signaling with IRQ 127
[   12.531057] pcieport 0000:00:1c.6: PME: Signaling with IRQ 128
[   12.531197] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.531370] Monitor-Mwait will be used to enter C-1 state
[   12.531375] Monitor-Mwait will be used to enter C-2 state
[   12.531378] Monitor-Mwait will be used to enter C-3 state
[   12.531380] ACPI: \_SB_.PR00: Found 3 idle states
[   12.531724] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[   12.531744] ACPI: button: Sleep Button [SLPB]
[   12.531772] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[   12.531787] ACPI: button: Power Button [PWRB]
[   12.531814] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   12.531838] ACPI: button: Power Button [PWRF]
[   12.532083] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1499
[   12.532970] thermal LNXTHERM:00: registered as thermal_zone0
[   12.532973] ACPI: thermal: Thermal Zone [TZ0] (-263 C)
[   12.533326] thermal LNXTHERM:01: registered as thermal_zone1
[   12.533328] ACPI: thermal: Thermal Zone [TZ00] (40 C)
[   12.533430] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   12.534256] hpet_acpi_add: no address or irqs in _CRS
[   12.534278] Linux agpgart interface v0.103
[   12.534332] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[   12.534539] ACPI: bus type drm_connector registered
[   12.535199] i915 0000:00:02.0: [drm] VT-d active for gfx access
[   12.535203] i915 0000:00:02.0: vgaarb: deactivate vga console
[   12.535241] i915 0000:00:02.0: [drm] Transparent Hugepage mode 'huge=within_size'
[   12.536996] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   12.537779] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/tgl_dmc_ver2_12.bin (v2.12)
[   12.651883] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[   12.652877] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   12.653221] acpi device:48: registered as cooling_device11
[   12.653372] acpi device:49: registered as cooling_device12
[   12.653415] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[   12.654352] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   12.654372] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   12.654597] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   12.654832] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   12.661835] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops)
[   12.674469] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[   12.674788] idma64 idma64.0: Found Intel integrated DMA 64-bit
[   12.680624] nvme 0000:01:00.0: platform quirk: setting simple suspend
[   12.680695] nvme nvme0: pci function 0000:01:00.0
[   12.680711] ahci 0000:00:17.0: version 3.0
[   12.681522] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[   12.681525] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part deso sadm sds 
[   12.681862] scsi host0: ahci
[   12.681962] scsi host1: ahci
[   12.681993] ata1: SATA max UDMA/133 abar m2048@0x6a602000 port 0x6a602100 irq 131
[   12.681995] ata2: SATA max UDMA/133 abar m2048@0x6a602000 port 0x6a602180 irq 131
[   12.682037] Intel(R) 2.5G Ethernet Linux Driver
[   12.682038] Copyright(c) 2018 Intel Corporation.
[   12.682134] igc 0000:59:00.0: enabling device (0000 -> 0002)
[   12.682277] igc 0000:59:00.0: PTM enabled, 4ns granularity
[   12.686819] nvme nvme0: missing or invalid SUBNQN field.
[   12.686831] nvme nvme0: Shutdown timeout set to 8 seconds
[   12.697770] nvme nvme0: 8/0/0 default/read/poll queues
[   12.699782]  nvme0n1: p1 p2 p3
[   12.732831] pps pps0: new PPS source ptp0
[   12.732928] igc 0000:59:00.0 (unnamed net_device) (uninitialized): PHC added
[   12.797980] igc 0000:59:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[   12.797987] igc 0000:59:00.0 eth0: MAC: 1c:69:7a:ac:a4:aa
[   12.798020] Intel(R) Wireless WiFi driver for Linux
[   12.798076] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[   12.800734] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-67.ucode failed with error -2
[   12.800747] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-66.ucode failed with error -2
[   12.800755] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-65.ucode failed with error -2
[   12.800763] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-64.ucode failed with error -2
[   12.800770] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-63.ucode failed with error -2
[   12.800778] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-62.ucode failed with error -2
[   12.800786] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-61.ucode failed with error -2
[   12.800793] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-60.ucode failed with error -2
[   12.800802] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-59.ucode failed with error -2
[   12.800809] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-58.ucode failed with error -2
[   12.800817] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-57.ucode failed with error -2
[   12.800824] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-56.ucode failed with error -2
[   12.800831] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-55.ucode failed with error -2
[   12.800839] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-54.ucode failed with error -2
[   12.800847] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-53.ucode failed with error -2
[   12.800858] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-52.ucode failed with error -2
[   12.800867] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-51.ucode failed with error -2
[   12.800874] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-50.ucode failed with error -2
[   12.800882] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-49.ucode failed with error -2
[   12.800889] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-48.ucode failed with error -2
[   12.800896] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-47.ucode failed with error -2
[   12.800904] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-46.ucode failed with error -2
[   12.800912] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-45.ucode failed with error -2
[   12.800920] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-44.ucode failed with error -2
[   12.800929] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-43.ucode failed with error -2
[   12.800936] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-42.ucode failed with error -2
[   12.800944] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-41.ucode failed with error -2
[   12.800951] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-40.ucode failed with error -2
[   12.800959] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-39.ucode failed with error -2
[   12.800961] iwlwifi 0000:00:14.3: no suitable firmware found!
[   12.800963] iwlwifi 0000:00:14.3: minimum version required: iwlwifi-QuZ-a0-hr-b0-39
[   12.800965] iwlwifi 0000:00:14.3: maximum version supported: iwlwifi-QuZ-a0-hr-b0-67
[   12.800968] iwlwifi 0000:00:14.3: check git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
[   12.801075] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[   12.801080] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
[   12.802176] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[   12.802512] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
[   12.802516] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.802518] usb usb1: Product: xHCI Host Controller
[   12.802521] usb usb1: Manufacturer: Linux 5.16.0+ xhci-hcd
[   12.802522] usb usb1: SerialNumber: 0000:00:0d.0
[   12.802692] hub 1-0:1.0: USB hub found
[   12.802705] hub 1-0:1.0: 1 port detected
[   12.803140] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[   12.803146] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
[   12.803150] xhci_hcd 0000:00:0d.0: Host supports USB 3.1 Enhanced SuperSpeed
[   12.803181] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
[   12.803185] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.803187] usb usb2: Product: xHCI Host Controller
[   12.803189] usb usb2: Manufacturer: Linux 5.16.0+ xhci-hcd
[   12.803190] usb usb2: SerialNumber: 0000:00:0d.0
[   12.803318] hub 2-0:1.0: USB hub found
[   12.803331] hub 2-0:1.0: 4 ports detected
[   12.803931] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   12.803936] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[   12.805055] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000000009810
[   12.805298] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
[   12.805301] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.805304] usb usb3: Product: xHCI Host Controller
[   12.805305] usb usb3: Manufacturer: Linux 5.16.0+ xhci-hcd
[   12.805307] usb usb3: SerialNumber: 0000:00:14.0
[   12.805454] hub 3-0:1.0: USB hub found
[   12.805483] hub 3-0:1.0: 12 ports detected
[   12.806521] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   12.806524] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[   12.806527] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[   12.806582] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
[   12.806585] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.806587] usb usb4: Product: xHCI Host Controller
[   12.806589] usb usb4: Manufacturer: Linux 5.16.0+ xhci-hcd
[   12.806591] usb usb4: SerialNumber: 0000:00:14.0
[   12.806724] hub 4-0:1.0: USB hub found
[   12.806748] hub 4-0:1.0: 4 ports detected
[   12.843798] i8042: PNP: No PS/2 controller found.
[   12.844038] mousedev: PS/2 mouse device common for all mice
[   12.844421] usbcore: registered new interface driver synaptics_usb
[   12.844459] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   12.844510] rtc_cmos rtc_cmos: RTC can wake from S4
[   12.846219] rtc_cmos rtc_cmos: registered as rtc0
[   12.846642] rtc_cmos rtc_cmos: setting system clock to 2022-01-24T16:43:55 UTC (1643042635)
[   12.846655] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
[   12.846887] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   12.846983] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   12.849066] i2c i2c-14: 2/2 memory slots populated (from DMI)
[   12.850256] ee1004 14-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[   12.850261] i2c i2c-14: Successfully instantiated SPD at 0x50
[   12.852060] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
[   12.852182] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   12.852192] iTCO_vendor_support: vendor-support=0
[   12.852285] usbcore: registered new interface driver btusb
[   12.852289] intel_pstate: Intel P-state driver initializing
[   12.852870] intel_pstate: HWP enabled
[   12.852875] sdhci: Secure Digital Host Controller Interface driver
[   12.852877] sdhci: Copyright(c) Pierre Ossman
[   12.852891] sdhci-pci 0000:58:00.0: SDHCI controller found [17a0:9755] (rev 0)
[   12.852961] sdhci-pci 0000:58:00.0: enabling device (0000 -> 0002)
[   12.853569] mmc0: SDHCI controller on PCI [0000:58:00.0] using ADMA 64-bit
[   12.853801] ledtrig-cpu: registered to indicate activity on CPUs
[   12.866353] pstore: Registered efi as persistent store backend
[   12.866369] hid: raw HID events driver (C) Jiri Kosina
[   12.866379] usbcore: registered new interface driver usbhid
[   12.866380] usbhid: USB HID core driver
[   12.866467] intel_pmc_core INT33A1:00:  initialized
[   12.866516] intel_rapl_msr: PL4 support detected.
[   12.866525] intel_rapl_common: Found RAPL domain package
[   12.866528] intel_rapl_common: Found RAPL domain core
[   12.866530] intel_rapl_common: Found RAPL domain uncore
[   12.866532] intel_rapl_common: Found RAPL domain psys
[   12.866929] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
[   12.866952] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   12.867056] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops)
[   12.867502] NET: Registered PF_INET6 protocol family
[   12.871675] Segment Routing with IPv6
[   12.871681] In-situ OAM (IOAM) with IPv6
[   12.871694] mip6: Mobile IPv6
[   12.871695] NET: Registered PF_PACKET protocol family
[   12.871697] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.871699] Bluetooth: BNEP filters: protocol multicast
[   12.871700] Bluetooth: BNEP socket layer initialized
[   12.871746] Key type dns_resolver registered
[   12.871748] mpls_gso: MPLS GSO support
[   12.872187] microcode: sig=0x806c1, pf=0x80, revision=0x72
[   12.872207] microcode: Microcode Update Driver: v2.2.
[   12.872244] resctrl: L2 allocation detected
[   12.872248] IPI shorthand broadcast: enabled
[   12.872251] AVX2 version of gcm_enc/dec engaged.
[   12.872286] AES CTR mode by8 optimization enabled
[   12.872412] sched_clock: Marking stable (12855778528, 16629372)->(12886790324, -14382424)
[   12.872550] registered taskstats version 1
[   12.872553] Loading compiled-in X.509 certificates
[   12.888192] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC256: line_outs=1 (0x21/0x0/0x0/0x0/0x0) type:hp
[   12.888195] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   12.888197] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   12.888198] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   12.888200] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   12.888201] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x13
[   12.888202] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[   12.909221] Loaded X.509 cert 'Build time autogenerated kernel key: 03137a584dfb08dfb89c47acef0b1d7589f4ca2a'
[   12.909652] zswap: loaded using pool lzo/zbud
[   12.909790] ------------[ cut here ]------------
[   12.909792] Debug warning: early ioremap leak of 1 areas detected.
               please boot with early_ioremap_debug and report the dmesg.
[   12.909797] WARNING: CPU: 0 PID: 1 at mm/early_ioremap.c:91 check_early_ioremap_leak+0x31/0x39
[   12.909802] Modules linked in:
[   12.909803] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0+ #18
[   12.909805] Hardware name: Intel(R) Client Systems NUC11PAHi7/NUC11PABi7, BIOS PATGL357.0041.2021.0811.1505 08/11/2021
[   12.909807] RIP: 0010:check_early_ioremap_leak+0x31/0x39
[   12.909809] Code: 31 c0 48 83 3c d5 00 dc 04 84 00 74 02 ff c0 48 ff c2 48 83 fa 08 75 ea 85 c0 74 15 89 c6 48 c7 c7 10 fe b7 82 e8 eb 6e 1d fe <0f> 0b b8 01 00 00 00 c3 0f 1f 44 00 00 41 57 31 c0 48 89 f1 41 56
[   12.909812] RSP: 0000:ffffc90000067e30 EFLAGS: 00010286
[   12.909814] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   12.909815] RDX: 0000000000000001 RSI: 00000000ffffefff RDI: 00000000ffffffff
[   12.909816] RBP: ffffffff83efbf84 R08: 0000000000000000 R09: ffffc90000067c60
[   12.909818] R10: ffffc90000067c58 R11: ffffffff834f8b68 R12: ffff888101f55800
[   12.909819] R13: ffffffff84118c58 R14: 0000000000000000 R15: 0000000000000000
[   12.909820] FS:  0000000000000000(0000) GS:ffff8884a0400000(0000) knlGS:0000000000000000
[   12.909822] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.909823] CR2: 0000000000000000 CR3: 0000000006810001 CR4: 0000000000770ef0
[   12.909824] PKRU: 55555554
[   12.909825] Call Trace:
[   12.909828]  <TASK>
[   12.909829]  do_one_initcall+0x41/0x200
[   12.909833]  kernel_init_freeable+0x21b/0x282
[   12.909836]  ? rest_init+0xd0/0xd0
[   12.909839]  kernel_init+0x16/0x120
[   12.909841]  ret_from_fork+0x1f/0x30
[   12.909843]  </TASK>
[   12.909844] ---[ end trace 921c693ae08cc13a ]---
[   12.909860] Key type ._fscrypt registered
[   12.909861] Key type .fscrypt registered
[   12.909862] Key type fscrypt-provisioning registered
[   12.909961] pstore: Using crash dump compression: deflate
[   12.912161] Key type encrypted registered
[   12.912165] AppArmor: AppArmor sha1 policy hashing enabled
[   12.912514] integrity: Loading X.509 certificate: UEFI:db
[   12.912532] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[   12.912534] integrity: Loading X.509 certificate: UEFI:db
[   12.912546] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[   12.913456] integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
[   12.913580] integrity: Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[   12.913583] ima: No TPM chip found, activating TPM-bypass!
[   12.913586] ima: Allocated hash algorithm: sha256
[   12.913591] ima: No architecture policies found
[   12.913597] evm: Initialising EVM extended attributes:
[   12.913598] evm: security.selinux
[   12.913599] evm: security.SMACK64 (disabled)
[   12.913600] evm: security.SMACK64EXEC (disabled)
[   12.913601] evm: security.SMACK64TRANSMUTE (disabled)
[   12.913602] evm: security.SMACK64MMAP (disabled)
[   12.913603] evm: security.apparmor
[   12.913603] evm: security.ima
[   12.913604] evm: security.capability
[   12.913605] evm: HMAC attrs: 0x1
[   12.939825] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[   12.951709] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input5
[   12.951730] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input6
[   12.951747] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input7
[   12.951763] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
[   12.951778] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[   12.951794] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[   12.951811] input: HDA Intel PCH HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[   12.951827] input: HDA Intel PCH HDMI/DP,pcm=12 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[   12.951842] input: HDA Intel PCH HDMI/DP,pcm=13 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[   12.951859] input: HDA Intel PCH HDMI/DP,pcm=14 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[   12.951874] input: HDA Intel PCH HDMI/DP,pcm=15 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[   12.951889] input: HDA Intel PCH HDMI/DP,pcm=16 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   12.951905] input: HDA Intel PCH HDMI/DP,pcm=17 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[   12.996118] ata1: SATA link down (SStatus 4 SControl 300)
[   12.996938] ata2: SATA link down (SStatus 4 SControl 300)
[   13.000528] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   13.000641] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.000649] ALSA device list:
[   13.000650]   #0: HDA Intel PCH at 0x603d1a0000 irq 148
[   13.003121] Freeing unused decrypted memory: 2036K
[   13.003474] Freeing unused kernel image (initmem) memory: 2800K
[   13.003495] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   13.003498] cfg80211: failed to load regulatory.db
[   13.022481] usb usb4-port1: config error
[   13.022489] Write protecting the kernel read-only data: 36864k
[   13.023082] Freeing unused kernel image (text/rodata gap) memory: 2028K
[   13.023272] Freeing unused kernel image (rodata/data gap) memory: 112K
[   13.036535] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   13.036549] Run /init as init process
[   13.036551]   with arguments:
[   13.036554]     /init
[   13.036555]     force_early_printk
[   13.036557]     nokaslr
[   13.036558]   with environment:
[   13.036560]     HOME=/
[   13.036561]     TERM=linux
[   13.036563]     BOOT_IMAGE=/boot/vmlinuz-5.16.0+
[   13.070293] usb 3-5: new full-speed USB device number 2 using xhci_hcd
[   13.106512] igc 0000:59:00.0 enp89s0: renamed from eth0
[   13.198503] usb 3-5: device descriptor read/64, error -71
[   13.434459] usb 3-5: device descriptor read/64, error -71
[   13.670428] usb 3-5: new full-speed USB device number 3 using xhci_hcd
[   13.798509] usb 3-5: device descriptor read/64, error -71
[   14.034767] usb 3-5: device descriptor read/64, error -71
[   14.142598] usb usb3-port5: attempt power cycle
[   14.554403] usb 3-5: new full-speed USB device number 4 using xhci_hcd
[   14.554759] usb 3-5: Device not responding to setup address.
[   14.762801] usb 3-5: Device not responding to setup address.
[   14.970426] usb 3-5: device not accepting address 4, error -71
[   15.098437] usb 3-5: new full-speed USB device number 5 using xhci_hcd
[   15.098810] usb 3-5: Device not responding to setup address.
[   15.306699] usb 3-5: Device not responding to setup address.
[   15.514422] usb 3-5: device not accepting address 5, error -71
[   15.514657] usb usb3-port5: unable to enumerate USB device
[   15.642405] usb 3-10: new full-speed USB device number 6 using xhci_hcd
[   15.792621] usb 3-10: New USB device found, idVendor=8087, idProduct=0026, bcdDevice= 0.02
[   15.792636] usb 3-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   15.795596] Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
[   15.796574] Bluetooth: hci0: Device revision is 2
[   15.796583] Bluetooth: hci0: Secure boot is enabled
[   15.796587] Bluetooth: hci0: OTP lock is enabled
[   15.796590] Bluetooth: hci0: API lock is enabled
[   15.796593] Bluetooth: hci0: Debug lock is disabled
[   15.796596] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   15.796624] Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-19-0-4.sfi (-2)
[   17.102556] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   17.102628] usb usb4-port1: config error
[   21.174523] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   21.174735] usb usb4-port1: config error
[   25.246517] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   25.246589] usb usb4-port1: config error
[   29.318503] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   29.318717] usb usb4-port1: config error
[   33.390515] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   33.390585] usb usb4-port1: config error
[   37.462518] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   37.462732] usb usb4-port1: config error
[   41.534516] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   41.534586] usb usb4-port1: config error
[   45.606510] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   45.606726] usb usb4-port1: config error
[   45.685537] PM: Image not found (code -22)
[   45.725568] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[   45.750785] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[   45.815001] systemd[1]: systemd 249.7-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS -OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP -LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[   45.815029] systemd[1]: No virtualization found in DMI vendor table.
[   45.815053] systemd[1]: DMI BIOS Extension table does not indicate virtualization.
[   45.834517] systemd[1]: UML virtualization not found in /proc/cpuinfo.
[   45.834537] systemd[1]: No virtualization found in CPUID
[   45.834555] systemd[1]: Virtualization XEN not found, /proc/xen does not exist
[   45.834575] systemd[1]: This platform does not support /proc/device-tree
[   45.834580] systemd[1]: This platform does not support /proc/sysinfo
[   45.834585] systemd[1]: Found VM virtualization none
[   45.834592] systemd[1]: Detected architecture x86-64.
[   45.834737] systemd[1]: Detected initialized system, this is not the first boot.
[   45.835147] systemd[1]: Hostname set to <tigerlake>.
[   45.835749] systemd[1]: Successfully added address 127.0.0.1 to loopback interface
[   45.835761] systemd[1]: Successfully added address ::1 to loopback interface
[   45.835769] systemd[1]: Successfully brought loopback interface up
[   45.835998] systemd[1]: Setting 'fs/file-max' to '9223372036854775807'.
[   45.836629] systemd[1]: Found cgroup2 on /sys/fs/cgroup/, full unified hierarchy
[   45.836637] systemd[1]: Unified cgroup hierarchy is located at /sys/fs/cgroup.
[   45.860009] systemd[1]: Got EBADF when using BPF_F_ALLOW_MULTI, which indicates it is supported. Yay!
[   45.860114] systemd[1]: Controller 'cpu' supported: yes
[   45.860143] systemd[1]: Controller 'cpuacct' supported: no
[   45.860145] systemd[1]: Controller 'cpuset' supported: yes
[   45.860146] systemd[1]: Controller 'io' supported: yes
[   45.860147] systemd[1]: Controller 'blkio' supported: no
[   45.860149] systemd[1]: Controller 'memory' supported: yes
[   45.860150] systemd[1]: Controller 'devices' supported: no
[   45.860152] systemd[1]: Controller 'pids' supported: yes
[   45.860153] systemd[1]: Controller 'bpf-firewall' supported: yes
[   45.860154] systemd[1]: Controller 'bpf-devices' supported: yes
[   45.860155] systemd[1]: Controller 'bpf-foreign' supported: yes
[   45.860157] systemd[1]: Controller 'bpf-socket-bind' supported: no
[   45.860164] systemd[1]: Set up TFD_TIMER_CANCEL_ON_SET timerfd.
[   45.860367] systemd[1]: Enabling (yes) showing of status (commandline).
[   45.860494] systemd[1]: Successfully forked off '(sd-executor)' as PID 372.
[   45.861033] systemd[372]: Successfully forked off '(direxec)' as PID 373.
[   45.861114] systemd[372]: Successfully forked off '(direxec)' as PID 374.
[   45.861180] systemd[372]: Successfully forked off '(direxec)' as PID 375.
[   45.861246] systemd[372]: Successfully forked off '(direxec)' as PID 376.
[   45.861315] systemd[372]: Successfully forked off '(direxec)' as PID 377.
[   45.861382] systemd[372]: Successfully forked off '(direxec)' as PID 378.
[   45.861454] systemd[372]: Successfully forked off '(direxec)' as PID 379.
[   45.861531] systemd[372]: Successfully forked off '(direxec)' as PID 380.
[   45.861630] systemd[372]: Successfully forked off '(direxec)' as PID 381.
[   45.861722] systemd[372]: Successfully forked off '(direxec)' as PID 382.
[   45.861828] systemd[372]: Successfully forked off '(direxec)' as PID 383.
[   45.861945] systemd[372]: Successfully forked off '(direxec)' as PID 384.
[   45.862050] systemd[372]: Successfully forked off '(direxec)' as PID 385.
[   45.864103] systemd-fstab-generator[377]: Parsing /etc/fstab...
[   45.864154] systemd-fstab-generator[377]: Found entry what=/dev/disk/by-uuid/a652986c-fbc6-4341-85c3-b4ad4402f130 where=/ type=ext4 makefs=no growfs=no noauto=no nofail=no
[   45.864269] systemd-bless-boot-generator[374]: Skipping generator, not booted with boot counting in effect.
[   45.864276] systemd-hibernate-resume-generator[380]: Not running in an initrd, quitting.
[   45.864281] systemd-rc-local-generator[381]: /etc/rc.local does not exist, skipping.
[   45.864929] systemd-fstab-generator[377]: SELinux enabled state cached to: disabled
[   45.865631] systemd-fstab-generator[377]: Found entry what=/dev/disk/by-uuid/7F40-7E64 where=/boot/efi type=vfat makefs=no growfs=no noauto=no nofail=no
[   45.865745] systemd-fstab-generator[377]: Checking was requested for /dev/disk/by-uuid/7F40-7E64, but fsck.vfat does not exist.
[   45.865766] systemd-fstab-generator[377]: Found entry what=/dev/disk/by-uuid/63cfb962-43f6-416b-8f7d-dcb57f471473 where=none type=swap makefs=no growfs=no noauto=no nofail=no
[   45.866763] systemd-gpt-auto-generator[379]: Disabling root partition auto-detection, root= is defined.
[   45.866782] systemd-sysv-generator[384]: Native unit for procps.service already exists, skipping.
[   45.866788] systemd-gpt-auto-generator[379]: Failed to chase block device '/', ignoring: No such file or directory
[   45.866813] systemd[372]: /usr/lib/systemd/system-generators/systemd-veritysetup-generator succeeded.
[   45.866822] systemd[372]: /usr/lib/systemd/system-generators/systemd-debug-generator succeeded.
[   45.866827] systemd[372]: /usr/lib/systemd/system-generators/systemd-bless-boot-generator succeeded.
[   45.866832] systemd[372]: /usr/lib/systemd/system-generators/systemd-run-generator succeeded.
[   45.866837] systemd[372]: /usr/lib/systemd/system-generators/systemd-getty-generator succeeded.
[   45.866996] systemd-gpt-auto-generator[379]: nvme0n1p2: Root device /dev/nvme0n1.
[   45.867014] systemd-sysv-generator[384]: Native unit for smartmontools.service already exists, skipping.
[   45.867167] systemd-sysv-generator[384]: Native unit for lvm2-lvmpolld.service already exists, skipping.
[   45.867310] systemd-sysv-generator[384]: Native unit for dbus.service already exists, skipping.
[   45.867389] systemd-sysv-generator[384]: Native unit for cron.service already exists, skipping.
[   45.867416] systemd-sysv-generator[384]: Native unit for hwclock.service already exists, skipping.
[   45.867482] systemd-sysv-generator[384]: Native unit for console-setup.service already exists, skipping.
[   45.867505] systemd-sysv-generator[384]: Native unit for sudo.service already exists, skipping.
[   45.867687] systemd-sysv-generator[384]: Native unit for udev.service already exists, skipping.
[   45.867755] systemd-sysv-generator[384]: Native unit for rsync.service already exists, skipping.
[   45.868085] systemd-sysv-generator[384]: Native unit for nfs-common.service already exists, skipping.
[   45.868116] systemd-sysv-generator[384]: Native unit for x11-common.service already exists, skipping.
[   45.868192] systemd-sysv-generator[384]: Native unit for acpid.service already exists, skipping.
[   45.868262] systemd-sysv-generator[384]: Native unit for uuidd.service already exists, skipping.
[   45.868740] systemd-sysv-generator[384]: Native unit for apparmor.service already exists, skipping.
[   45.868760] systemd-sysv-generator[384]: Native unit for live-tools.service already exists, skipping.
[   45.868787] systemd-sysv-generator[384]: Native unit for alsa-utils.service already exists, skipping.
[   45.868853] systemd-sysv-generator[384]: Native unit for bluetooth.service already exists, skipping.
[   45.868958] systemd-sysv-generator[384]: Native unit for ssh.service already exists, skipping.
[   45.869050] systemd-sysv-generator[384]: Native unit for anacron.service already exists, skipping.
[   45.869125] systemd-sysv-generator[384]: Native unit for keyboard-setup.service already exists, skipping.
[   45.869194] systemd-sysv-generator[384]: Native unit for networking.service already exists, skipping.
[   45.869207] systemd-sysv-generator[384]: Cannot find unit exim4.service.
[   45.869210] systemd-sysv-generator[384]: SysV service '/etc/init.d/exim4' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
[   45.869253] systemd-sysv-generator[384]: Native unit for lvm2.service already exists, skipping.
[   45.869291] systemd-sysv-generator[384]: Native unit for mdadm-waitidle.service already exists, skipping.
[   45.869393] systemd-sysv-generator[384]: Native unit for rpcbind.service already exists, skipping.
[   45.869433] systemd-sysv-generator[384]: Native unit for mdadm.service already exists, skipping.
[   45.869636] systemd-sysv-generator[384]: Native unit for kmod.service already exists, skipping.
[   45.869703] systemd-sysv-generator[384]: Native unit for sysstat.service already exists, skipping.
[   45.869784] systemd-sysv-generator[384]: Native unit for lm-sensors.service already exists, skipping.
[   45.870029] systemd-sysv-generator[384]: Ignoring S01cron symlink in rc2.d, not generating cron.service.
[   45.870032] systemd-sysv-generator[384]: Ignoring S01mdadm symlink in rc2.d, not generating mdadm.service.
[   45.870035] systemd-sysv-generator[384]: Ignoring S01lvm2-lvmpolld symlink in rc2.d, not generating lvm2-lvmpolld.service.
[   45.870040] systemd-sysv-generator[384]: Ignoring S01bluetooth symlink in rc2.d, not generating bluetooth.service.
[   45.870042] systemd-sysv-generator[384]: Ignoring S01rsync symlink in rc2.d, not generating rsync.service.
[   45.870044] systemd-sysv-generator[384]: Ignoring S01sudo symlink in rc2.d, not generating sudo.service.
[   45.870046] systemd-sysv-generator[384]: Ignoring S01dbus symlink in rc2.d, not generating dbus.service.
[   45.870049] systemd-sysv-generator[384]: Ignoring S01sysstat symlink in rc2.d, not generating sysstat.service.
[   45.870052] systemd-sysv-generator[384]: Ignoring S01uuidd symlink in rc2.d, not generating uuidd.service.
[   45.870054] systemd-sysv-generator[384]: Ignoring S01anacron symlink in rc2.d, not generating anacron.service.
[   45.870056] systemd-sysv-generator[384]: Ignoring S01acpid symlink in rc2.d, not generating acpid.service.
[   45.870059] systemd-sysv-generator[384]: Ignoring S01ssh symlink in rc2.d, not generating ssh.service.
[   45.870061] systemd-sysv-generator[384]: Ignoring S01console-setup.sh symlink in rc2.d, not generating console-setup.service.
[   45.870064] systemd-sysv-generator[384]: Ignoring S01smartmontools symlink in rc2.d, not generating smartmontools.service.
[   45.870149] systemd-sysv-generator[384]: Ignoring S01cron symlink in rc3.d, not generating cron.service.
[   45.870154] systemd-sysv-generator[384]: Ignoring S01mdadm symlink in rc3.d, not generating mdadm.service.
[   45.870158] systemd-sysv-generator[384]: Ignoring S01lvm2-lvmpolld symlink in rc3.d, not generating lvm2-lvmpolld.service.
[   45.870162] systemd-sysv-generator[384]: Ignoring S01bluetooth symlink in rc3.d, not generating bluetooth.service.
[   45.870166] systemd-sysv-generator[384]: Ignoring S01rsync symlink in rc3.d, not generating rsync.service.
[   45.870170] systemd-sysv-generator[384]: Ignoring S01sudo symlink in rc3.d, not generating sudo.service.
[   45.870174] systemd-sysv-generator[384]: Ignoring S01dbus symlink in rc3.d, not generating dbus.service.
[   45.870178] systemd-sysv-generator[384]: Ignoring S01sysstat symlink in rc3.d, not generating sysstat.service.
[   45.870183] systemd-sysv-generator[384]: Ignoring S01uuidd symlink in rc3.d, not generating uuidd.service.
[   45.870186] systemd-sysv-generator[384]: Ignoring S01anacron symlink in rc3.d, not generating anacron.service.
[   45.870190] systemd-sysv-generator[384]: Ignoring S01acpid symlink in rc3.d, not generating acpid.service.
[   45.870194] systemd-sysv-generator[384]: Ignoring S01ssh symlink in rc3.d, not generating ssh.service.
[   45.870198] systemd-sysv-generator[384]: Ignoring S01console-setup.sh symlink in rc3.d, not generating console-setup.service.
[   45.870202] systemd-sysv-generator[384]: Ignoring S01smartmontools symlink in rc3.d, not generating smartmontools.service.
[   45.870361] systemd-sysv-generator[384]: Ignoring S01cron symlink in rc4.d, not generating cron.service.
[   45.870365] systemd-sysv-generator[384]: Ignoring S01mdadm symlink in rc4.d, not generating mdadm.service.
[   45.870367] systemd-sysv-generator[384]: Ignoring S01lvm2-lvmpolld symlink in rc4.d, not generating lvm2-lvmpolld.service.
[   45.870369] systemd-sysv-generator[384]: Ignoring S01bluetooth symlink in rc4.d, not generating bluetooth.service.
[   45.870372] systemd-sysv-generator[384]: Ignoring S01rsync symlink in rc4.d, not generating rsync.service.
[   45.870374] systemd-sysv-generator[384]: Ignoring S01sudo symlink in rc4.d, not generating sudo.service.
[   45.870376] systemd-sysv-generator[384]: Ignoring S01dbus symlink in rc4.d, not generating dbus.service.
[   45.870378] systemd-sysv-generator[384]: Ignoring S01sysstat symlink in rc4.d, not generating sysstat.service.
[   45.870381] systemd-sysv-generator[384]: Ignoring S01uuidd symlink in rc4.d, not generating uuidd.service.
[   45.870383] systemd-sysv-generator[384]: Ignoring S01anacron symlink in rc4.d, not generating anacron.service.
[   45.870386] systemd-sysv-generator[384]: Ignoring S01acpid symlink in rc4.d, not generating acpid.service.
[   45.870388] systemd-sysv-generator[384]: Ignoring S01ssh symlink in rc4.d, not generating ssh.service.
[   45.870390] systemd-sysv-generator[384]: Ignoring S01console-setup.sh symlink in rc4.d, not generating console-setup.service.
[   45.870392] systemd-sysv-generator[384]: Ignoring S01smartmontools symlink in rc4.d, not generating smartmontools.service.
[   45.870478] systemd-sysv-generator[384]: Ignoring S01cron symlink in rc5.d, not generating cron.service.
[   45.870480] systemd-sysv-generator[384]: Ignoring S01mdadm symlink in rc5.d, not generating mdadm.service.
[   45.870482] systemd-sysv-generator[384]: Ignoring S01lvm2-lvmpolld symlink in rc5.d, not generating lvm2-lvmpolld.service.
[   45.870484] systemd-sysv-generator[384]: Ignoring S01bluetooth symlink in rc5.d, not generating bluetooth.service.
[   45.870486] systemd-sysv-generator[384]: Ignoring S01rsync symlink in rc5.d, not generating rsync.service.
[   45.870488] systemd-sysv-generator[384]: Ignoring S01sudo symlink in rc5.d, not generating sudo.service.
[   45.870490] systemd-sysv-generator[384]: Ignoring S01dbus symlink in rc5.d, not generating dbus.service.
[   45.870493] systemd-sysv-generator[384]: Ignoring S01sysstat symlink in rc5.d, not generating sysstat.service.
[   45.870496] systemd-sysv-generator[384]: Ignoring S01uuidd symlink in rc5.d, not generating uuidd.service.
[   45.870497] systemd-sysv-generator[384]: Ignoring S01anacron symlink in rc5.d, not generating anacron.service.
[   45.870499] systemd-sysv-generator[384]: Ignoring S01acpid symlink in rc5.d, not generating acpid.service.
[   45.870501] systemd-sysv-generator[384]: Ignoring S01ssh symlink in rc5.d, not generating ssh.service.
[   45.870503] systemd-sysv-generator[384]: Ignoring S01console-setup.sh symlink in rc5.d, not generating console-setup.service.
[   45.870505] systemd-sysv-generator[384]: Ignoring S01smartmontools symlink in rc5.d, not generating smartmontools.service.
[   45.870511] systemd-sysv-generator[384]: Loading SysV script /etc/init.d/exim4
[   45.870814] systemd-sysv-generator[384]: SELinux enabled state cached to: disabled
[   45.870974] systemd-gpt-auto-generator[379]: swap specified in fstab, ignoring.
[   45.871001] systemd-gpt-auto-generator[379]: "/boot" already populated, ignoring.
[   45.878662] systemd[372]: /usr/lib/systemd/system-generators/lvm2-activation-generator succeeded.
[   45.878672] systemd[372]: /usr/lib/systemd/system-generators/systemd-rc-local-generator succeeded.
[   45.878678] systemd[372]: /usr/lib/systemd/system-generators/systemd-hibernate-resume-generator succeeded.
[   45.878684] systemd[372]: /usr/lib/systemd/system-generators/systemd-fstab-generator succeeded.
[   45.878689] systemd[372]: /usr/lib/systemd/system-generators/systemd-sysv-generator succeeded.
[   45.878694] systemd[372]: /usr/lib/systemd/system-generators/systemd-cryptsetup-generator succeeded.
[   45.878698] systemd[372]: /usr/lib/systemd/system-generators/systemd-gpt-auto-generator succeeded.
[   45.878703] systemd[372]: /usr/lib/systemd/system-generators/systemd-system-update-generator succeeded.
[   45.878863] systemd[1]: (sd-executor) succeeded.
[   45.878878] systemd[1]: Looking for unit files in (higher priority first):
[   45.878880] systemd[1]: 	/etc/systemd/system.control
[   45.878881] systemd[1]: 	/run/systemd/system.control
[   45.878882] systemd[1]: 	/run/systemd/transient
[   45.878883] systemd[1]: 	/run/systemd/generator.early
[   45.878885] systemd[1]: 	/etc/systemd/system
[   45.878886] systemd[1]: 	/etc/systemd/system.attached
[   45.878887] systemd[1]: 	/run/systemd/system
[   45.878888] systemd[1]: 	/run/systemd/system.attached
[   45.878889] systemd[1]: 	/run/systemd/generator
[   45.878890] systemd[1]: 	/usr/local/lib/systemd/system
[   45.878891] systemd[1]: 	/lib/systemd/system
[   45.878892] systemd[1]: 	/usr/lib/systemd/system
[   45.878893] systemd[1]: 	/run/systemd/generator.late
[   45.879765] systemd[1]: Modification times have changed, need to update cache.
[   45.879807] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/dbus-org.bluez.service \xe2\x86\x92 bluetooth.service
[   45.879825] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/dbus-org.freedesktop.timesync1.service \xe2\x86\x92 systemd-timesyncd.service
[   45.879839] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/dbus-fi.w1.wpa_supplicant1.service \xe2\x86\x92 wpa_supplicant.service
[   45.879857] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/smartd.service \xe2\x86\x92 smartmontools.service
[   45.879872] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/sshd.service \xe2\x86\x92 ssh.service
[   45.879893] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/syslog.service \xe2\x86\x92 rsyslog.service
[   45.879902] systemd[1]: unit_file_build_name_map: linked unit file: /etc/systemd/system/live-tools.service \xe2\x86\x92 /dev/null
[   45.879916] systemd[1]: unit_file_build_name_map: normal unit file: /run/systemd/generator/dev-disk-by\x2duuid-63cfb962\x2d43f6\x2d416b\x2d8f7d\x2ddcb57f471473.swap
[   45.879919] systemd[1]: unit_file_build_name_map: normal unit file: /run/systemd/generator/boot-efi.mount
[   45.879929] systemd[1]: unit_file_build_name_map: normal unit file: /run/systemd/generator/-.mount
[   45.879993] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpcbind.socket
[   45.880000] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/hwclock.service \xe2\x86\x92 /dev/null
[   45.880003] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysstat-collect.timer
[   45.880008] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/machine.slice
[   45.880010] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-sysext.service
[   45.880013] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-networkd-wait-online.service
[   45.880015] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-cleanup.service
[   45.880018] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-modules-load.service
[   45.880020] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/hibernate.target
[   45.880023] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald-dev-log.socket
[   45.880026] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-pstore.service
[   45.880028] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-udevd-control.socket
[   45.880031] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/powertop.service
[   45.880034] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-ask-password-console.path
[   45.880036] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald-audit.socket
[   45.880043] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-cryptsetup.target
[   45.880046] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-networkd.service
[   45.880048] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/anacron.timer
[   45.880051] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald.socket
[   45.880053] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/uuidd.socket
[   45.880065] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/printer.target
[   45.880068] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-volatile-root.service
[   45.880070] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/nss-lookup.target
[   45.880073] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/alsa-restore.service
[   45.880091] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/default.target \xe2\x86\x92 graphical.target
[   45.880094] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/kexec.target
[   45.880096] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/nss-user-lookup.target
[   45.880099] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/exim4-base.timer
[   45.880107] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/rcS.service \xe2\x86\x92 /dev/null
[   45.880110] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald@.service
[   45.880112] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-fs.target
[   45.880120] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/cryptdisks.service \xe2\x86\x92 /dev/null
[   45.880123] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-suspend-then-hibernate.service
[   45.880126] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/suspend.target
[   45.880128] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-reboot.service
[   45.880131] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-parse-etc.service
[   45.880134] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpcbind.service
[   45.880137] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-resolved.service
[   45.880139] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/apt-daily.service
[   45.880146] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rsync.service
[   45.880149] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sys-fs-fuse-connections.mount
[   45.880152] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/time-sync.target
[   45.880155] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-timedated.service
[   45.880158] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/apt-daily-upgrade.timer
[   45.880160] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-boot-system-token.service
[   45.880162] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sleep.target
[   45.880165] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/local-fs-pre.target
[   45.880167] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-setup.service
[   45.880170] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysinit.target
[   45.880172] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/modprobe@.service
[   45.880174] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub@.service
[   45.880177] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-networkd.socket
[   45.880180] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/mdcheck_start.timer
[   45.880182] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/bluetooth.target
[   45.880189] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/x11-common.service \xe2\x86\x92 /dev/null
[   45.880191] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/mdadm-grow-continue@.service
[   45.880194] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-sysusers.service
[   45.880197] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/acpid.socket
[   45.880199] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysstat.service
[   45.880216] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/autovt@.service \xe2\x86\x92 getty@.service
[   45.880231] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/dbus-org.freedesktop.hostname1.service \xe2\x86\x92 systemd-hostnamed.service
[   45.880234] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/timers.target
[   45.880236] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/anacron.service
[   45.880256] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sound.target
[   45.880258] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-time-wait-sync.service
[   45.880261] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-root-device.target
[   45.880277] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/dbus-org.freedesktop.locale1.service \xe2\x86\x92 systemd-localed.service
[   45.880279] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub_all.service
[   45.880282] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rescue-ssh.target
[   45.880284] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd.target
[   45.880287] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-exit.service
[   45.880290] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub_all.timer
[   45.880292] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-fs.target
[   45.880294] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/cron.service
[   45.880296] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/nfs-idmapd.service
[   45.880299] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-ask-password-wall.path
[   45.880301] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-setup-dev.service
[   45.880304] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-clean.service
[   45.880306] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-hibernate.service
[   45.880309] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/console-setup.service
[   45.880312] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/system-update.target
[   45.880314] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/emergency.service
[   45.880317] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/halt.target
[   45.880319] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/lvm2-lvmpolld.socket
[   45.880326] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/lvm2.service \xe2\x86\x92 /dev/null
[   45.880340] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/runlevel5.target \xe2\x86\x92 graphical.target
[   45.880343] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/getty-pre.target
[   45.880357] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/alsa-utils.service \xe2\x86\x92 /dev/null
[   45.880360] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-update-utmp-runlevel.service
[   45.880362] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/user-runtime-dir@.service
[   45.880364] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/run-qemu.mount
[   45.880367] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/boot-complete.target
[   45.880369] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/ssh@.service
[   45.880371] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-clean.timer
[   45.880374] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/shutdown.target
[   45.880376] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-binfmt.service
[   45.880379] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-switch-root.service
[   45.880393] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/ctrl-alt-del.target \xe2\x86\x92 reboot.target
[   45.880396] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sys-kernel-tracing.mount
[   45.880398] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/basic.target
[   45.880401] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-machine-id-commit.service
[   45.880403] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/auth-rpcgss-module.service
[   45.880406] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-timesyncd.service
[   45.880409] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/dbus.socket
[   45.880411] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysstat-summary.timer
[   45.880426] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/dbus-org.freedesktop.timedate1.service \xe2\x86\x92 systemd-timedated.service
[   45.880429] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpc-statd-notify.service
[   45.880431] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/getty.target
[   45.880434] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-suspend.service
[   45.880446] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/kmod.service \xe2\x86\x92 systemd-modules-load.service
[   45.880448] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journal-flush.service
[   45.880451] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-initctl.service
[   45.880454] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-veritysetup.target
[   45.880457] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-fs-pre.target
[   45.880459] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/ssh.socket
[   45.880462] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/veritysetup.target
[   45.880464] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/lvm2-lvmpolld.service
[   45.880467] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-remount-fs.service
[   45.880470] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/swap.target
[   45.880473] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpc-statd.service
[   45.880476] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-rfkill.socket
[   45.880478] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-user-sessions.service
[   45.880482] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-switch-root.target
[   45.880485] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-rfkill.service
[   45.880487] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rc-local.service
[   45.880491] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/man-db.service
[   45.880494] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/ifupdown-pre.service
[   45.880496] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/logrotate.service
[   45.880499] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-fsckd.socket
[   45.880515] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/runlevel3.target \xe2\x86\x92 multi-user.target
[   45.880517] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub_reap.service
[   45.880520] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-root-fs.target
[   45.880523] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/run-rpc_pipefs.mount
[   45.880525] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/veritysetup-pre.target
[   45.880528] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/uuidd.service
[   45.880531] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/network-online.target
[   45.880534] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/blockdev@.target
[   45.880536] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/bluetooth.service
[   45.880538] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/lm-sensors.service
[   45.880541] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/local-fs.target
[   45.928899] EXT4-fs (nvme0n1p2): re-mounted. Opts: errors=remount-ro. Quota mode: none.
[   45.930217] systemd-journald[403]: SELinux enabled state cached to: disabled
[   45.930233] systemd-journald[403]: Auditing in kernel turned off.
[   45.931188] systemd-journald[403]: Journal effective settings seal=no keyed_hash=yes compress=yes compress_threshold_bytes=512B
[   45.931217] systemd-journald[403]: Fixed min_use=16.0M max_use=156.1M max_size=19.5M min_size=512.0K keep_free=78.0M n_max_files=100
[   45.931235] systemd-journald[403]: Reserving 333 entries in field hash table.
[   45.932887] systemd-journald[403]: Reserving 35534 entries in data hash table.
[   45.933072] systemd-journald[403]: Vacuuming...
[   45.933083] systemd-journald[403]: Vacuuming done, freed 0B of archived journals from /run/log/journal/3aa984411adf418abc91217f7a356b70.
[   45.933091] systemd-journald[403]: Flushing /dev/kmsg...
[   45.954995] systemd-journald[403]: systemd-journald running as PID 403 for the system.
[   45.955066] systemd-journald[403]: Sent READY=1 notification.
[   45.955069] systemd-journald[403]: Sent WATCHDOG=1 notification.
[   45.955214] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955298] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955361] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955421] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955483] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955543] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955665] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955727] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955788] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955846] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955908] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.955969] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.956048] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.956096] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.956142] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.956203] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.956249] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.956500] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.956717] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.956788] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.956854] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.956898] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   45.958171] systemd-journald[403]: varlink: New incoming connection.
[   45.958178] systemd-journald[403]: varlink-22: Setting state idle-server
[   45.958208] systemd-journald[403]: varlink-22: New incoming message: {"method":"io.systemd.Journal.FlushToVar","parameters":{}}
[   45.958221] systemd-journald[403]: varlink-22: Changing state idle-server \xe2\x86\x92 processing-method
[   45.958224] systemd-journald[403]: Received client request to flush runtime journal.
[   45.958638] systemd-journald[403]: Journal effective settings seal=yes keyed_hash=yes compress=yes compress_threshold_bytes=512B
[   45.959187] systemd-journald[403]: Fixed min_use=16.0M max_use=4.0G max_size=128.0M min_size=512.0K keep_free=4.0G n_max_files=100
[   45.963104] systemd-journald[403]: Flushing to /var/log/journal/3aa984411adf418abc91217f7a356b70...
[   45.963109] systemd-journald[403]: Considering root directory '/run/log/journal'.
[   45.963116] systemd-journald[403]: Root directory /run/log/journal added.
[   45.963120] systemd-journald[403]: Considering directory '/run/log/journal/3aa984411adf418abc91217f7a356b70'.
[   45.963128] systemd-journald[403]: Directory /run/log/journal/3aa984411adf418abc91217f7a356b70 added.
[   45.963135] systemd-journald[403]: Journal effective settings seal=no keyed_hash=yes compress=no compress_threshold_bytes=8B
[   45.963144] systemd-journald[403]: File /run/log/journal/3aa984411adf418abc91217f7a356b70/system.journal added.
[   45.963148] systemd-journald[403]: Considering root directory '/var/log/journal'.
[   45.963150] systemd-journald[403]: Considering root directory '/var/log/journal/remote'.
[   46.136162] systemd-journald[403]: Root directory /run/log/journal removed.
[   46.136174] systemd-journald[403]: Directory /run/log/journal/3aa984411adf418abc91217f7a356b70 removed.
[   46.136180] systemd-journald[403]: mmap cache statistics: 87987 context cache hit, 3 window list hit, 1 miss
[   46.136198] systemd-journald[403]: Journal effective settings seal=no keyed_hash=yes compress=yes compress_threshold_bytes=512B
[   46.136511] systemd-journald[403]: Vacuuming...
[   46.146050] systemd-journald[403]: Vacuuming done, freed 0B of archived journals from /var/log/journal/3aa984411adf418abc91217f7a356b70.
[   46.148256] systemd-journald[403]: varlink-22: Sending message: {"parameters":{}}
[   46.148269] systemd-journald[403]: varlink-22: Changing state processing-method \xe2\x86\x92 processed-method
[   46.148275] systemd-journald[403]: varlink-22: Changing state processed-method \xe2\x86\x92 idle-server
[   46.148964] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.150607] systemd-journald[403]: varlink-22: Got POLLHUP from socket.
[   46.150620] systemd-journald[403]: varlink-22: Changing state idle-server \xe2\x86\x92 pending-disconnect
[   46.150627] systemd-journald[403]: varlink-22: Changing state pending-disconnect \xe2\x86\x92 processing-disconnect
[   46.150632] systemd-journald[403]: varlink-22: Changing state processing-disconnect \xe2\x86\x92 disconnected
[   46.305512] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.306340] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.322830] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.323907] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.324312] Adding 999420k swap on /dev/nvme0n1p3.  Priority:-2 extents:1 across:999420k SSFS
[   46.340075] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.341560] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.343833] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.349104] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.353628] audit: type=1400 audit(1643042669.000:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=471 comm="apparmor_parser"
[   46.354220] audit: type=1400 audit(1643042669.000:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=472 comm="apparmor_parser"
[   46.354224] audit: type=1400 audit(1643042669.000:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=472 comm="apparmor_parser"
[   46.354595] audit: type=1400 audit(1643042669.004:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=473 comm="apparmor_parser"
[   46.354599] audit: type=1400 audit(1643042669.004:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=473 comm="apparmor_parser"
[   46.354601] audit: type=1400 audit(1643042669.004:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=473 comm="apparmor_parser"
[   46.379156] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.409590] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.412628] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.415024] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.461722] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.502232] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.502854] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.504041] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.504116] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.505777] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.506445] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.507719] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.508373] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.509694] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.510358] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.512183] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.517194] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   46.536327] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   49.682545] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   49.682620] usb usb4-port1: config error
[   49.833253] igc 0000:59:00.0 enp89s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   49.834527] IPv6: ADDRCONF(NETDEV_CHANGE): enp89s0: link becomes ready
[   53.754530] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   53.754751] usb usb4-port1: config error
[   57.826545] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   57.826619] usb usb4-port1: config error
[   61.898501] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   61.898696] usb usb4-port1: config error
[   65.970512] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   65.970584] usb usb4-port1: config error
[   66.260862] igc 0000:59:00.0 enp89s0: NIC Link is Down
[   69.509619] igc 0000:59:00.0 enp89s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   70.042519] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   70.042751] usb usb4-port1: config error
[   74.114529] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   74.114602] usb usb4-port1: config error
[   78.215911] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   78.215999] usb usb4-port1: config error
[   82.393045] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   82.393119] usb usb4-port1: config error
[   86.525385] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   86.525646] usb usb4-port1: config error
[   86.545779] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   86.693428] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   86.695518] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   86.697193] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   86.711307] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   86.762315] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   86.784409] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   87.433255] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   87.437268] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   87.485514] systemd-journald[403]: Successfully sent stream file descriptor to service manager.
[   90.632181] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   90.632245] usb usb4-port1: config error
[   94.724412] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
[   94.724477] usb usb4-port1: config error
