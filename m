Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6715748F7B9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiAOQHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiAOQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:07:05 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F05C061574;
        Sat, 15 Jan 2022 08:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KSqYpovTL9I+88kws+rgGb4in7mlUubwzpip0c/LIRc=; b=eSjCC+5We8J7BC3KmpQRXk3nRs
        0cPp6k/Fnr0d0GUfFffXdNcHqC/QfTH2QdzPGG+0/NctMRLQoj53f1hgh0esOjYhG8osUup73U/QN
        pVnPgVRW0S7EUIWtq5Vw8MEf/icR1VxV0eNkQhlnzbs+5C9YzbsX4OiJXWiXrSL2Ho84t1Hh/hjep
        /uk+4O3eQ5YDsfERQ2VqOcDPwXGKMZu0V7mHUqvHfZtsyEpL/CJv1gPQRcLQdBD3x86I3x9P9ysvx
        +ak3XKlPogG8DlAvSuodcxprzuuQv2EbAyzj8CBD67bW8OnTuwPKtbsuTe9VcTBizP824gg0B7XpJ
        L+H/OlxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8lZl-001KVa-SC; Sat, 15 Jan 2022 16:06:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9376E3001FD;
        Sat, 15 Jan 2022 17:06:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 354912999C033; Sat, 15 Jan 2022 17:06:43 +0100 (CET)
Date:   Sat, 15 Jan 2022 17:06:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 09:31:17PM +0200, Mathias Nyman wrote:
> On 14.1.2022 10.47, Peter Zijlstra wrote:

> > Any thoughts on this? I'd really like to be able to use this machine but
> > can't due to lack of console.
> > 
> 
> Tried to reproduce this with another cable that should have all pins connected,
> but it still workes for me.

:-(

> It looks like the connection is not even detected in your case.
> 
> What does the host say? If the cable is connected before CTRL_DBC_ENABLED bit is
> written on the target side, then the link should go to a inactive "error" state.
> Host should try to recover the inactive link with a warm reset.
> 

> xHCI documentation also states that Debug capability enable bit (CTRL_DBC_ENABLE)
> could be toggled to retry failed enumeration. 
> 
> The non-early dbc that works for you does clear the control register before enabling
> the debug capability, and it also skips port reset.
> Something like the below could be worth trying out:

So the host has a stream of:

[1532578.477838] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[1532578.477904] usb usb2-port3: config error

The target has (notable excerpt, full thing below):

[    4.984106] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
[    9.946159] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
[    9.946163] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host

and in full:

[    0.000000] Linux version 5.16.0-rc3+ (root@tigerlake) (gcc (Debian 11.2.0-12) 11.2.0, GNU ld (GNU Binutils for Debian) 2.37) #14 SMP PREEMPT Sat Jan 15 16:50:29 CET 2022
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc,keep force_early_printk sched_verbose ftrace=nop mitigations=off nokaslr
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
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
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
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi: ACPI=0x40cce000 ACPI 2.0=0x40cce014 SMBIOS=0x41568000 SMBIOS 3.0=0x41567000 MEMATTR=0x31355018 ESRT=0x35190298 MOKvar=0x3134c000 
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: Intel(R) Client Systems NUC11PAHi7/NUC11PABi7, BIOS PATGL357.0041.2021.0811.1505 08/11/2021
[    0.000000] tsc: Detected 2800.000 MHz processor
[    0.000000] tsc: Detected 2803.200 MHz TSC
[    0.000002] delay_tsc
[    0.000941] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000943] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000947] last_pfn = 0x4b0800 max_arch_pfn = 0x400000000
[    0.001050] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002163] last_pfn = 0x41800 max_arch_pfn = 0x400000000
[    0.021106] esrt: Reserving ESRT space from 0x0000000035190298 to 0x0000000035190370.
[    0.021109] e820: update [mem 0x35190000-0x35190fff] usable ==> reserved
[    0.021118] e820: update [mem 0x3134c000-0x3134efff] usable ==> reserved
[    0.021127] Using GB pages for direct mapping
[    0.021399] Secure boot could not be determined
[    0.021399] RAMDISK: [mem 0x2f8e0000-0x30b4afff]
[    0.021401] ACPI: Early table checksum verification disabled
[    0.021403] ACPI: RSDP 0x0000000040CCE014 000024 (v02 INTEL )
[    0.021406] ACPI: XSDT 0x0000000040CCD728 0000EC (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021410] ACPI: FACP 0x0000000040C57000 000114 (v06 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021413] ACPI: DSDT 0x0000000040BFC000 05AB35 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021415] ACPI: FACS 0x0000000040D19000 000040
[    0.021416] ACPI: MCFG 0x0000000040C5B000 00003C (v01 INTEL  NUC11PAB 00000029 MSFT 00000097)
[    0.021418] ACPI: SSDT 0x0000000040C58000 00255D (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021420] ACPI: FIDT 0x0000000040BFB000 00009C (v01 INTEL  NUC11PAB 00000029 AMI  00010013)
[    0.021422] ACPI: SSDT 0x0000000040BF8000 002C3E (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021424] ACPI: SSDT 0x0000000040BF4000 003435 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021425] ACPI: SSDT 0x0000000040BE8000 00B27A (v02 INTEL  NUC11PAB 00001000 INTL 20191018)
[    0.021427] ACPI: HPET 0x0000000040C5D000 000038 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021429] ACPI: APIC 0x0000000040C5C000 00012C (v04 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021431] ACPI: SSDT 0x0000000040BE2000 00590A (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021432] ACPI: SSDT 0x0000000040BE1000 000B5E (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021434] ACPI: NHLT 0x0000000040BE0000 00002D (v00 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021436] ACPI: UEFI 0x0000000040CBB000 000048 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021438] ACPI: LPIT 0x0000000040BDF000 0000CC (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021439] ACPI: SSDT 0x0000000040BDB000 002720 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021441] ACPI: SSDT 0x0000000040BDA000 00012A (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021443] ACPI: DBGP 0x0000000040BD9000 000034 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021445] ACPI: DBG2 0x0000000040BD8000 000054 (v00 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021447] ACPI: SSDT 0x0000000040BD6000 0015FC (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021448] ACPI: DMAR 0x0000000040BD5000 0000B8 (v02 INTEL  NUC11PAB 00000029      01000013)
[    0.021450] ACPI: SSDT 0x0000000040BD4000 000823 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021452] ACPI: SSDT 0x0000000040BD3000 000144 (v02 INTEL  NUC11PAB 00000029 INTL 20191018)
[    0.021454] ACPI: PTDT 0x0000000040BD2000 000D44 (v00 INTEL  NUC11PAB 00000029 MSFT 0100000D)
[    0.021455] ACPI: WSMT 0x0000000040BDE000 000028 (v01 INTEL  NUC11PAB 00000029 AMI  00010013)
[    0.021457] ACPI: FPDT 0x0000000040BD1000 000044 (v01 INTEL  NUC11PAB 00000029 AMI  01000013)
[    0.021459] ACPI: Reserving FACP table memory at [mem 0x40c57000-0x40c57113]
[    0.021460] ACPI: Reserving DSDT table memory at [mem 0x40bfc000-0x40c56b34]
[    0.021460] ACPI: Reserving FACS table memory at [mem 0x40d19000-0x40d1903f]
[    0.021461] ACPI: Reserving MCFG table memory at [mem 0x40c5b000-0x40c5b03b]
[    0.021462] ACPI: Reserving SSDT table memory at [mem 0x40c58000-0x40c5a55c]
[    0.021462] ACPI: Reserving FIDT table memory at [mem 0x40bfb000-0x40bfb09b]
[    0.021463] ACPI: Reserving SSDT table memory at [mem 0x40bf8000-0x40bfac3d]
[    0.021463] ACPI: Reserving SSDT table memory at [mem 0x40bf4000-0x40bf7434]
[    0.021464] ACPI: Reserving SSDT table memory at [mem 0x40be8000-0x40bf3279]
[    0.021464] ACPI: Reserving HPET table memory at [mem 0x40c5d000-0x40c5d037]
[    0.021465] ACPI: Reserving APIC table memory at [mem 0x40c5c000-0x40c5c12b]
[    0.021466] ACPI: Reserving SSDT table memory at [mem 0x40be2000-0x40be7909]
[    0.021466] ACPI: Reserving SSDT table memory at [mem 0x40be1000-0x40be1b5d]
[    0.021467] ACPI: Reserving NHLT table memory at [mem 0x40be0000-0x40be002c]
[    0.021467] ACPI: Reserving UEFI table memory at [mem 0x40cbb000-0x40cbb047]
[    0.021468] ACPI: Reserving LPIT table memory at [mem 0x40bdf000-0x40bdf0cb]
[    0.021469] ACPI: Reserving SSDT table memory at [mem 0x40bdb000-0x40bdd71f]
[    0.021469] ACPI: Reserving SSDT table memory at [mem 0x40bda000-0x40bda129]
[    0.021470] ACPI: Reserving DBGP table memory at [mem 0x40bd9000-0x40bd9033]
[    0.021470] ACPI: Reserving DBG2 table memory at [mem 0x40bd8000-0x40bd8053]
[    0.021471] ACPI: Reserving SSDT table memory at [mem 0x40bd6000-0x40bd75fb]
[    0.021472] ACPI: Reserving DMAR table memory at [mem 0x40bd5000-0x40bd50b7]
[    0.021472] ACPI: Reserving SSDT table memory at [mem 0x40bd4000-0x40bd4822]
[    0.021473] ACPI: Reserving SSDT table memory at [mem 0x40bd3000-0x40bd3143]
[    0.021473] ACPI: Reserving PTDT table memory at [mem 0x40bd2000-0x40bd2d43]
[    0.021474] ACPI: Reserving WSMT table memory at [mem 0x40bde000-0x40bde027]
[    0.021474] ACPI: Reserving FPDT table memory at [mem 0x40bd1000-0x40bd1043]
[    0.021850] No NUMA configuration found
[    0.021851] Faking a node at [mem 0x0000000000000000-0x00000004b07fffff]
[    0.021856] NODE_DATA(0) allocated [mem 0x4b07d5000-0x4b07fefff]
[    0.022032] xhci_dbc:xdbc_early_setup: XXX A
[    0.022034] xhci_dbc:xdbc_early_setup: XXX B
[    0.022035] xhci_dbc:xdbc_early_setup: XXX C
[    0.022036] xhci_dbc:xdbc_early_setup: XXX D
[    0.022036] xhci_dbc:xdbc_early_setup: XXX E
[    0.022037] xhci_dbc:xdbc_early_setup: XXX F
[    0.022038] xhci_dbc:xdbc_early_setup: XXX G
[    0.022040] xhci_dbc:xdbc_early_setup: XXX H
[    4.984106] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
[    9.946159] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
[    9.946163] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
[    9.946174] Zone ranges:
[    9.946174]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    9.946175]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    9.946177]   Normal   [mem 0x0000000100000000-0x00000004b07fffff]
[    9.946178]   Device   empty
[    9.946178] Movable zone start for each node
[    9.946179] Early memory node ranges
[    9.946180]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    9.946181]   node   0: [mem 0x0000000000100000-0x0000000038180fff]
[    9.946181]   node   0: [mem 0x00000000417ff000-0x00000000417fffff]
[    9.946182]   node   0: [mem 0x0000000100000000-0x00000004b07fffff]
[    9.946183] Initmem setup node 0 [mem 0x0000000000001000-0x00000004b07fffff]
[    9.946186] On node 0, zone DMA: 1 pages in unavailable ranges
[    9.946208] On node 0, zone DMA: 97 pages in unavailable ranges
[    9.947660] On node 0, zone DMA32: 38526 pages in unavailable ranges
[    9.947997] On node 0, zone Normal: 26624 pages in unavailable ranges
[    9.948171] On node 0, zone Normal: 30720 pages in unavailable ranges
[    9.948212] Reserving Intel graphics memory at [mem 0x4b800000-0x4f7fffff]
[    9.949241] ACPI: PM-Timer IO Port: 0x1808
[    9.949246] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    9.949247] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    9.949248] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    9.949248] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    9.949249] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    9.949249] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    9.949250] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    9.949250] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    9.949251] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    9.949251] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    9.949252] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    9.949252] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    9.949253] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    9.949253] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    9.949254] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    9.949254] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    9.949339] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    9.949341] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    9.949342] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    9.949344] ACPI: Using ACPI (MADT) for SMP configuration information
[    9.949345] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    9.949347] TSC deadline timer available
[    9.949348] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    9.949358] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    9.949359] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    9.949361] PM: hibernation: Registered nosave memory: [mem 0x3134c000-0x3134efff]
[    9.949362] PM: hibernation: Registered nosave memory: [mem 0x35190000-0x35190fff]
[    9.949363] PM: hibernation: Registered nosave memory: [mem 0x38181000-0x40b91fff]
[    9.949363] PM: hibernation: Registered nosave memory: [mem 0x40b92000-0x40c5dfff]
[    9.949364] PM: hibernation: Registered nosave memory: [mem 0x40c5e000-0x40d1cfff]
[    9.949364] PM: hibernation: Registered nosave memory: [mem 0x40d1d000-0x4173afff]
[    9.949365] PM: hibernation: Registered nosave memory: [mem 0x4173b000-0x417fefff]
[    9.949366] PM: hibernation: Registered nosave memory: [mem 0x41800000-0x47ffffff]
[    9.949366] PM: hibernation: Registered nosave memory: [mem 0x48000000-0x48dfffff]
[    9.949367] PM: hibernation: Registered nosave memory: [mem 0x48e00000-0x4f7fffff]
[    9.949367] PM: hibernation: Registered nosave memory: [mem 0x4f800000-0xbfffffff]
[    9.949368] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xcfffffff]
[    9.949369] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xfdffffff]
[    9.949369] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    9.949370] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    9.949370] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    9.949371] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    9.949371] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    9.949372] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed1ffff]
[    9.949372] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    9.949373] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfedfffff]
[    9.949373] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    9.949374] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    9.949374] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    9.949375] [mem 0x4f800000-0xbfffffff] available for PCI devices
[    9.949377] Booting paravirtualized kernel on bare hardware
[    9.949379] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    9.954232] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    9.954344] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
[    9.954348] pcpu-alloc: s212992 r8192 d28672 u262144 alloc=1*2097152
[    9.954350] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    9.954366] Fallback order for Node 0: 0 
[    9.954368] Built 1 zonelists, mobility grouping on.  Total pages: 4034139
[    9.954369] Policy zone: Normal
[    9.954370] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc,keep force_early_printk sched_verbose ftrace=nop mitigations=off nokaslr
[    9.954417] sysrq: sysrq always enabled.
[    9.954461] Unknown kernel command line parameters "force_early_printk nokaslr BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+", will be passed to user space.
[    9.954855] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    9.955058] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    9.955110] mem auto-init: stack:off, heap alloc:on, heap free:off
[    9.965393] Memory: 797624K/16393344K available (20499K kernel code, 4046K rwdata, 14220K rodata, 2800K init, 4768K bss, 541540K reserved, 0K cma-reserved)
[    9.965396] random: get_random_u64 called from __kmem_cache_create+0x2a/0x530 with crng_init=0
[    9.965492] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    9.965499] ftrace: allocating 63035 entries in 247 pages
[    9.978266] ftrace: allocated 247 pages with 7 groups
[    9.978418] Starting tracer 'nop'
[    9.979199] Dynamic Preempt: voluntary
[    9.979219] rcu: Preemptible hierarchical RCU implementation.
[    9.979220] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    9.979221] 	Trampoline variant of Tasks RCU enabled.
[    9.979221] 	Rude variant of Tasks RCU enabled.
[    9.979221] 	Tracing variant of Tasks RCU enabled.
[    9.979222] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    9.979223] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    9.981574] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    9.982270] random: crng done (trusting CPU's manufacturer)
[    9.982287] Console: colour dummy device 80x25
[    9.982486] printk: console [tty0] enabled
[    9.982496] ACPI: Core revision 20210930
[    9.982683] hpet: HPET dysfunctional in PC10. Force disabled.
[    9.982684] APIC: Switch to symmetric I/O mode setup
[    9.982687] DMAR: Host address width 39
[    9.982688] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    9.982691] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 69e2ff0505e
[    9.982694] DMAR: DRHD base: 0x000000fed84000 flags: 0x0
[    9.982696] DMAR: dmar1: reg_base_addr fed84000 ver 1:0 cap d2008c40660462 ecap f050da
[    9.982700] DMAR: DRHD base: 0x000000fed87000 flags: 0x0
[    9.982702] DMAR: dmar2: reg_base_addr fed87000 ver 1:0 cap d2008c40660462 ecap f050da
[    9.982705] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    9.982708] DMAR: dmar3: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    9.982713] DMAR: RMRR base: 0x0000004b000000 end: 0x0000004f7fffff
[    9.982715] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 3
[    9.982717] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    9.982718] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    9.987092] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    9.987094] x2apic enabled
[    9.987147] Switched APIC routing to cluster x2apic.
[    9.998814] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[    9.998821] Calibrating delay loop (skipped), value calculated using timer frequency.. 5606.40 BogoMIPS (lpj=11212800)
[    9.998824] pid_max: default: 32768 minimum: 301
[   10.001358] LSM: Security Framework initializing
[   10.001366] Yama: becoming mindful.
[   10.001379] AppArmor: AppArmor initialized
[   10.001381] TOMOYO Linux initialized
[   10.001406] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[   10.001424] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[   10.001575] CPU0: Thermal monitoring enabled (TM1)
[   10.001577] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[   10.001662] process: using mwait in idle threads
[   10.001664] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[   10.001665] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[   10.001669] Speculative Store Bypass: Vulnerable
[   10.002819] Freeing SMP alternatives memory: 60K
[   10.002819] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1499
[   10.002819] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz (family: 0x6, model: 0x8c, stepping: 0x1)
[   10.002819] Performance Events: PEBS fmt4+-baseline,  AnyThread deprecated, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
[   10.002819] ... version:                5
[   10.002819] ... bit width:              48
[   10.002819] ... generic registers:      8
[   10.002819] ... value mask:             0000ffffffffffff
[   10.002819] ... max period:             00007fffffffffff
[   10.002819] ... fixed-purpose events:   4
[   10.002819] ... event mask:             0001000f000000ff
[   10.002819] rcu: Hierarchical SRCU implementation.
[   10.002819] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[   10.002819] smp: Bringing up secondary CPUs ...
[   10.002819] x86: Booting SMP configuration:
[   10.002819] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[   10.003735] smp: Brought up 1 node, 8 CPUs
[   10.003735] smpboot: Max logical packages: 1
[   10.003735] smpboot: Total of 8 processors activated (44851.20 BogoMIPS)
[   10.006851] CPU0 attaching sched-domain(s):
[   10.006852]  domain-0: span=0,4 level=SMT
[   10.006855]   groups: 0:{ span=0 }, 4:{ span=4 }
[   10.006858]   domain-1: span=0-7 level=MC
[   10.006860]    groups: 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }
[   10.006867] CPU1 attaching sched-domain(s):
[   10.006868]  domain-0: span=1,5 level=SMT
[   10.006869]   groups: 1:{ span=1 }, 5:{ span=5 }
[   10.006871]   domain-1: span=0-7 level=MC
[   10.006873]    groups: 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }
[   10.006878] CPU2 attaching sched-domain(s):
[   10.006879]  domain-0: span=2,6 level=SMT
[   10.006880]   groups: 2:{ span=2 }, 6:{ span=6 }
[   10.006882]   domain-1: span=0-7 level=MC
[   10.006883]    groups: 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }
[   10.006889] CPU3 attaching sched-domain(s):
[   10.006890]  domain-0: span=3,7 level=SMT
[   10.006891]   groups: 3:{ span=3 }, 7:{ span=7 }
[   10.006893]   domain-1: span=0-7 level=MC
[   10.006894]    groups: 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }
[   10.006900] CPU4 attaching sched-domain(s):
[   10.006900]  domain-0: span=0,4 level=SMT
[   10.006902]   groups: 4:{ span=4 }, 0:{ span=0 }
[   10.006904]   domain-1: span=0-7 level=MC
[   10.006905]    groups: 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }
[   10.006910] CPU5 attaching sched-domain(s):
[   10.006911]  domain-0: span=1,5 level=SMT
[   10.006912]   groups: 5:{ span=5 }, 1:{ span=1 }
[   10.006914]   domain-1: span=0-7 level=MC
[   10.006916]    groups: 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }
[   10.006921] CPU6 attaching sched-domain(s):
[   10.006922]  domain-0: span=2,6 level=SMT
[   10.006923]   groups: 6:{ span=6 }, 2:{ span=2 }
[   10.006925]   domain-1: span=0-7 level=MC
[   10.006926]    groups: 2:{ span=2,6 cap=2048 }, 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }
[   10.006931] CPU7 attaching sched-domain(s):
[   10.006932]  domain-0: span=3,7 level=SMT
[   10.006933]   groups: 7:{ span=7 }, 3:{ span=3 }
[   10.006936]   domain-1: span=0-7 level=MC
[   10.006937]    groups: 3:{ span=3,7 cap=2048 }, 0:{ span=0,4 cap=2048 }, 1:{ span=1,5 cap=2048 }, 2:{ span=2,6 cap=2048 }
[   10.006942] root domain span: 0-7 (max cpu_capacity = 1024)
[   10.022862] node 0 deferred pages initialised in 16ms
[   10.023548] devtmpfs: initialized
[   10.023548] x86/mm: Memory block size: 128MB
[   10.023548] ACPI: PM: Registering ACPI NVS region [mem 0x40c5e000-0x40d1cfff] (782336 bytes)
[   10.023548] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[   10.023548] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[   10.023548] pinctrl core: initialized pinctrl subsystem
[   10.023548] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[   10.023548] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[   10.023548] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[   10.023548] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[   10.023548] audit: initializing netlink subsys (disabled)
[   10.023548] audit: type=2000 audit(1642261920.024:1): state=initialized audit_enabled=0 res=1
[   10.023548] thermal_sys: Registered thermal governor 'fair_share'
[   10.023548] thermal_sys: Registered thermal governor 'bang_bang'
[   10.023548] thermal_sys: Registered thermal governor 'step_wise'
[   10.023548] thermal_sys: Registered thermal governor 'user_space'
[   10.023548] thermal_sys: Registered thermal governor 'power_allocator'
[   10.023548] cpuidle: using governor ladder
[   10.023548] cpuidle: using governor menu
[   10.023548] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[   10.023548] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[   10.023548] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[   10.023548] PCI: Using configuration type 1 for base access
[   10.023548] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[   10.027546] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[   10.027553] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[   10.027553] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[   10.027553] cryptd: max_cpu_qlen set to 1000
[   10.090912] raid6: avx512x4 gen() 65861 MB/s
[   10.159006] raid6: avx512x4 xor() 18925 MB/s
[   10.227100] raid6: avx512x2 gen() 71990 MB/s
[   10.295195] raid6: avx512x2 xor() 41544 MB/s
[   10.363294] raid6: avx512x1 gen() 65523 MB/s
[   10.431390] raid6: avx512x1 xor() 38406 MB/s
[   10.499484] raid6: avx2x4   gen() 52871 MB/s
[   10.567579] raid6: avx2x4   xor() 20514 MB/s
[   10.635673] raid6: avx2x2   gen() 56784 MB/s
[   10.703770] raid6: avx2x2   xor() 30331 MB/s
[   10.771865] raid6: avx2x1   gen() 44908 MB/s
[   10.839961] raid6: avx2x1   xor() 25012 MB/s
[   10.908049] raid6: sse2x4   gen() 14540 MB/s
[   10.976131] raid6: sse2x4   xor()  7682 MB/s
[   11.044218] raid6: sse2x2   gen() 14983 MB/s
[   11.112300] raid6: sse2x2   xor()  8704 MB/s
[   11.180385] raid6: sse2x1   gen() 14288 MB/s
[   11.248469] raid6: sse2x1   xor()  7743 MB/s
[   11.248471] raid6: using algorithm avx512x2 gen() 71990 MB/s
[   11.248472] raid6: .... xor() 41544 MB/s, rmw enabled
[   11.248473] raid6: using avx512x2 recovery algorithm
[   11.250893] ACPI: Added _OSI(Module Device)
[   11.250896] ACPI: Added _OSI(Processor Device)
[   11.250897] ACPI: Added _OSI(3.0 _SCP Extensions)
[   11.250898] ACPI: Added _OSI(Processor Aggregator Device)
[   11.250899] ACPI: Added _OSI(Linux-Dell-Video)
[   11.250900] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[   11.250901] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[   11.301079] ACPI: 12 ACPI AML tables successfully acquired and loaded
[   11.301667] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^SPI1.SPFD.CVFD (20210930/dspkginit-438)
[   11.301671] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^SPI1.SPFD.CVFD (20210930/dspkginit-438)
[   11.301674] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^XHCI.RHUB.HS04.VI2C (20210930/dspkginit-438)
[   11.301683] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - ^XHCI.RHUB.HS04.VI2C (20210930/dspkginit-438)
[   11.308747] ACPI: Dynamic OEM Table Load:
[   11.308747] ACPI: SSDT 0xFFFF8881025F5A00 0001CB (v02 PmRef  Cpu0Psd  00003000 INTL 20191018)
[   11.308747] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[   11.311078] ACPI: Dynamic OEM Table Load:
[   11.311082] ACPI: SSDT 0xFFFF888102600400 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20191018)
[   11.311791] ACPI: Dynamic OEM Table Load:
[   11.311795] ACPI: SSDT 0xFFFF888102608800 000647 (v02 PmRef  Cpu0Ist  00003000 INTL 20191018)
[   11.312522] ACPI: Dynamic OEM Table Load:
[   11.312526] ACPI: SSDT 0xFFFF888102605000 000266 (v02 PmRef  Cpu0Hwp  00003000 INTL 20191018)
[   11.313297] ACPI: Dynamic OEM Table Load:
[   11.313302] ACPI: SSDT 0xFFFF8881025FC000 0008E7 (v02 PmRef  ApIst    00003000 INTL 20191018)
[   11.314051] ACPI: Dynamic OEM Table Load:
[   11.314054] ACPI: SSDT 0xFFFF88810260A000 00048A (v02 PmRef  ApHwp    00003000 INTL 20191018)
[   11.314760] ACPI: Dynamic OEM Table Load:
[   11.314764] ACPI: SSDT 0xFFFF888102609800 0004D4 (v02 PmRef  ApPsd    00003000 INTL 20191018)
[   11.315476] ACPI: Dynamic OEM Table Load:
[   11.315479] ACPI: SSDT 0xFFFF88810260B800 00048A (v02 PmRef  ApCst    00003000 INTL 20191018)
[   11.742874] ACPI: EC: EC started
[   11.742876] ACPI: EC: interrupt blocked
[   11.742904] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[   11.742906] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC used to handle transactions
[   11.742908] ACPI: Interpreter enabled
[   11.742965] ACPI: PM: (supports S0 S3 S4 S5)
[   11.742967] ACPI: Using IOAPIC for interrupt routing
[   11.743012] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[   11.744758] ACPI: Enabled 7 GPEs in block 00 to 7F
[   11.749944] ACPI: PM: Power Resource [PXP]
[   11.750829] ACPI: PM: Power Resource [PXP]
[   11.757183] ACPI: PM: Power Resource [BTPR]
[   11.757721] ACPI: PM: Power Resource [PAUD]
[   11.759557] ACPI: PM: Power Resource [V0PR]
[   11.759631] ACPI: PM: Power Resource [V1PR]
[   11.759698] ACPI: PM: Power Resource [V2PR]
[   11.761554] ACPI: PM: Power Resource [PXTC]
[   11.761762] ACPI: PM: Power Resource [PTPL]
[   11.762162] ACPI: PM: Power Resource [PXTC]
[   11.762604] ACPI: PM: Power Resource [PXTC]
[   11.763941] ACPI: PM: Power Resource [WRST]
[   11.766000] ACPI: PM: Power Resource [TBT0]
[   11.766204] ACPI: PM: Power Resource [TBT1]
[   11.766404] ACPI: PM: Power Resource [D3C]
[   12.042161] ACPI: PM: Power Resource [FN00]
[   12.042198] ACPI: PM: Power Resource [FN01]
[   12.042231] ACPI: PM: Power Resource [FN02]
[   12.042643] ACPI: PM: Power Resource [PIN]
[   12.042858] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[   12.042863] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[   12.045418] acpi PNP0A08:00: _OSC: platform does not support [AER]
[   12.050190] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
[   12.051821] PCI host bridge to bus 0000:00
[   12.051823] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[   12.051825] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[   12.051826] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[   12.051828] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[   12.051829] pci_bus 0000:00: root bus resource [mem 0x4f800000-0xbfffffff window]
[   12.051831] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[   12.051832] pci_bus 0000:00: root bus resource [bus 00-fe]
[   12.051948] pci 0000:00:00.0: [8086:9a14] type 00 class 0x060000
[   12.052223] pci 0000:00:02.0: [8086:9a49] type 00 class 0x030000
[   12.052231] pci 0000:00:02.0: reg 0x10: [mem 0x603c000000-0x603cffffff 64bit]
[   12.052236] pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x400fffffff 64bit pref]
[   12.052240] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[   12.052253] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[   12.052277] pci 0000:00:02.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bit]
[   12.052279] pci 0000:00:02.0: VF(n) BAR0 space: [mem 0x00000000-0x06ffffff 64bit] (contains BAR0 for 7 VFs)
[   12.052283] pci 0000:00:02.0: reg 0x34c: [mem 0x00000000-0x1fffffff 64bit pref]
[   12.052285] pci 0000:00:02.0: VF(n) BAR2 space: [mem 0x00000000-0xdfffffff 64bit pref] (contains BAR2 for 7 VFs)
[   12.052428] pci 0000:00:06.0: [8086:9a09] type 01 class 0x060400
[   12.052518] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[   12.052554] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[   12.052940] pci 0000:00:07.0: [8086:9a23] type 01 class 0x060400
[   12.053011] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[   12.053033] pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
[   12.054180] pci 0000:00:07.3: [8086:9a29] type 01 class 0x060400
[   12.054250] pci 0000:00:07.3: PME# supported from D0 D3hot D3cold
[   12.054273] pci 0000:00:07.3: DPC: RP PIO log size 0 is invalid
[   12.055441] pci 0000:00:08.0: [8086:9a11] type 00 class 0x088000
[   12.055449] pci 0000:00:08.0: reg 0x10: [mem 0x603d1b2000-0x603d1b2fff 64bit]
[   12.055579] pci 0000:00:0d.0: [8086:9a13] type 00 class 0x0c0330
[   12.055592] pci 0000:00:0d.0: reg 0x10: [mem 0x603d190000-0x603d19ffff 64bit]
[   12.055644] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[   12.056720] pci 0000:00:0d.2: [8086:9a1b] type 00 class 0x0c0340
[   12.056730] pci 0000:00:0d.2: reg 0x10: [mem 0x603d140000-0x603d17ffff 64bit]
[   12.056737] pci 0000:00:0d.2: reg 0x18: [mem 0x603d1b1000-0x603d1b1fff 64bit]
[   12.056768] pci 0000:00:0d.2: supports D1 D2
[   12.056769] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
[   12.056838] pci 0000:00:0d.3: [8086:9a1d] type 00 class 0x0c0340
[   12.056847] pci 0000:00:0d.3: reg 0x10: [mem 0x603d100000-0x603d13ffff 64bit]
[   12.056854] pci 0000:00:0d.3: reg 0x18: [mem 0x603d1b0000-0x603d1b0fff 64bit]
[   12.056885] pci 0000:00:0d.3: supports D1 D2
[   12.056886] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold
[   12.057097] pci 0000:00:14.0: [8086:a0ed] type 00 class 0x0c0330
[   12.057120] pci 0000:00:14.0: reg 0x10: [mem 0x603d180000-0x603d18ffff 64bit]
[   12.057223] pci 0000:00:14.0: PME# supported from D3hot D3cold
[   12.058313] pci 0000:00:14.2: [8086:a0ef] type 00 class 0x050000
[   12.058336] pci 0000:00:14.2: reg 0x10: [mem 0x603d1a8000-0x603d1abfff 64bit]
[   12.058352] pci 0000:00:14.2: reg 0x18: [mem 0x603d1af000-0x603d1affff 64bit]
[   12.058499] pci 0000:00:14.3: [8086:a0f0] type 00 class 0x028000
[   12.058543] pci 0000:00:14.3: reg 0x10: [mem 0x603d1a4000-0x603d1a7fff 64bit]
[   12.058694] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[   12.059383] pci 0000:00:15.0: [8086:a0e8] type 00 class 0x0c8000
[   12.060124] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   12.063286] pci 0000:00:16.0: [8086:a0e0] type 00 class 0x078000
[   12.063312] pci 0000:00:16.0: reg 0x10: [mem 0x603d1ad000-0x603d1adfff 64bit]
[   12.063409] pci 0000:00:16.0: PME# supported from D3hot
[   12.063761] pci 0000:00:17.0: [8086:a0d3] type 00 class 0x010601
[   12.063781] pci 0000:00:17.0: reg 0x10: [mem 0x6a600000-0x6a601fff]
[   12.063794] pci 0000:00:17.0: reg 0x14: [mem 0x6a603000-0x6a6030ff]
[   12.063804] pci 0000:00:17.0: reg 0x18: [io  0x3090-0x3097]
[   12.063815] pci 0000:00:17.0: reg 0x1c: [io  0x3080-0x3083]
[   12.063825] pci 0000:00:17.0: reg 0x20: [io  0x3060-0x307f]
[   12.063836] pci 0000:00:17.0: reg 0x24: [mem 0x6a602000-0x6a6027ff]
[   12.063892] pci 0000:00:17.0: PME# supported from D3hot
[   12.064321] pci 0000:00:1c.0: [8086:a0bc] type 01 class 0x060400
[   12.064443] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[   12.064485] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[   12.064921] pci 0000:00:1c.6: [8086:a0be] type 01 class 0x060400
[   12.065043] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[   12.065082] pci 0000:00:1c.6: PTM enabled (root), 4ns granularity
[   12.065480] pci 0000:00:1f.0: [8086:a082] type 00 class 0x060100
[   12.065790] pci 0000:00:1f.3: [8086:a0c8] type 00 class 0x040380
[   12.065845] pci 0000:00:1f.3: reg 0x10: [mem 0x603d1a0000-0x603d1a3fff 64bit]
[   12.065924] pci 0000:00:1f.3: reg 0x20: [mem 0x603d000000-0x603d0fffff 64bit]
[   12.066082] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[   12.066398] pci 0000:00:1f.4: [8086:a0a3] type 00 class 0x0c0500
[   12.066429] pci 0000:00:1f.4: reg 0x10: [mem 0x603d1ac000-0x603d1ac0ff 64bit]
[   12.066466] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[   12.066658] pci 0000:00:1f.5: [8086:a0a4] type 00 class 0x0c8000
[   12.066680] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[   12.067173] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
[   12.067189] pci 0000:01:00.0: reg 0x10: [mem 0x6a500000-0x6a503fff 64bit]
[   12.067365] pci 0000:00:06.0: PCI bridge to [bus 01]
[   12.067368] pci 0000:00:06.0:   bridge window [mem 0x6a500000-0x6a5fffff]
[   12.067400] pci 0000:00:07.0: PCI bridge to [bus 02-2c]
[   12.067404] pci 0000:00:07.0:   bridge window [mem 0x5e000000-0x6a1fffff]
[   12.067408] pci 0000:00:07.0:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[   12.067438] pci 0000:00:07.3: PCI bridge to [bus 2d-57]
[   12.067442] pci 0000:00:07.3:   bridge window [mem 0x50000000-0x5c1fffff]
[   12.067446] pci 0000:00:07.3:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[   12.067606] pci 0000:58:00.0: [17a0:9755] type 00 class 0x080501
[   12.067652] pci 0000:58:00.0: reg 0x10: [mem 0x6a400000-0x6a400fff]
[   12.068014] pci 0000:58:00.0: supports D1 D2
[   12.068015] pci 0000:58:00.0: PME# supported from D1 D2 D3hot D3cold
[   12.068386] pci 0000:00:1c.0: PCI bridge to [bus 58]
[   12.068391] pci 0000:00:1c.0:   bridge window [mem 0x6a400000-0x6a4fffff]
[   12.068554] pci 0000:59:00.0: [8086:15f3] type 00 class 0x020000
[   12.068573] pci 0000:59:00.0: reg 0x10: [mem 0x6a200000-0x6a2fffff]
[   12.068598] pci 0000:59:00.0: reg 0x1c: [mem 0x6a300000-0x6a303fff]
[   12.068724] pci 0000:59:00.0: PME# supported from D0 D3hot D3cold
[   12.068854] pci 0000:00:1c.6: PCI bridge to [bus 59]
[   12.068859] pci 0000:00:1c.6:   bridge window [mem 0x6a200000-0x6a3fffff]
[   12.073049] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[   12.073120] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[   12.073188] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[   12.073257] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[   12.073325] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[   12.073394] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[   12.073463] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[   12.073531] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[   12.094524] ACPI: EC: interrupt unblocked
[   12.094526] ACPI: EC: event unblocked
[   12.094570] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[   12.094572] ACPI: EC: GPE=0x6e
[   12.094573] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC initialization complete
[   12.094575] ACPI: \_SB_.PC00.LPCB.H_EC: EC: Used to handle transactions and events
[   12.094846] iommu: Default domain type: Translated 
[   12.094846] iommu: DMA domain TLB invalidation policy: lazy mode 
[   12.094846] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[   12.094846] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[   12.094846] pci 0000:00:02.0: vgaarb: bridge control possible
[   12.094846] vgaarb: loaded
[   12.094875] SCSI subsystem initialized
[   12.094878] libata version 3.00 loaded.
[   12.094878] ACPI: bus type USB registered
[   12.094878] usbcore: registered new interface driver usbfs
[   12.094878] usbcore: registered new interface driver hub
[   12.094878] usbcore: registered new device driver usb
[   12.094878] pps_core: LinuxPPS API ver. 1 registered
[   12.094878] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   12.094878] PTP clock support registered
[   12.094878] EDAC MC: Ver: 3.0.0
[   12.098840] Registered efivars operations
[   12.098863] Advanced Linux Sound Architecture Driver Initialized.
[   12.098892] Bluetooth: Core ver 2.22
[   12.098896] NET: Registered PF_BLUETOOTH protocol family
[   12.098898] Bluetooth: HCI device and connection manager initialized
[   12.098899] Bluetooth: HCI socket layer initialized
[   12.098900] Bluetooth: L2CAP socket layer initialized
[   12.098902] Bluetooth: SCO socket layer initialized
[   12.098907] NetLabel: Initializing
[   12.098908] NetLabel:  domain hash size = 128
[   12.098909] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[   12.098919] NetLabel:  unlabeled traffic allowed by default
[   12.098926] PCI: Using ACPI for IRQ routing
[   12.175895] PCI: pci_cache_line_size set to 64 bytes
[   12.176455] pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010fff]: no compatible bridge window
[   12.177001] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[   12.177003] e820: reserve RAM buffer [mem 0x3134c000-0x33ffffff]
[   12.177004] e820: reserve RAM buffer [mem 0x35190000-0x37ffffff]
[   12.177006] e820: reserve RAM buffer [mem 0x38181000-0x3bffffff]
[   12.177007] e820: reserve RAM buffer [mem 0x41800000-0x43ffffff]
[   12.177008] e820: reserve RAM buffer [mem 0x4b0800000-0x4b3ffffff]
[   12.177012] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[   12.177012] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[   12.177012] clocksource: Switched to clocksource tsc-early
[   12.180412] VFS: Disk quotas dquot_6.6.0
[   12.180412] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   12.180412] AppArmor: AppArmor Filesystem Enabled
[   12.180412] pnp: PnP ACPI init
[   12.180412] system 00:00: [io  0x0a00-0x0a0f] has been reserved
[   12.180412] system 00:00: [io  0x0a10-0x0a2f] has been reserved
[   12.180412] system 00:00: [io  0x0a30-0x0a4f] has been reserved
[   12.180412] system 00:00: [io  0x0a50-0x0a6f] has been reserved
[   12.180412] system 00:00: [io  0x0a70-0x0a7f] has been reserved
[   12.180412] system 00:00: [io  0x0a80-0x0a8f] has been reserved
[   12.180412] system 00:01: [io  0x0680-0x069f] has been reserved
[   12.180412] system 00:01: [io  0x164e-0x164f] has been reserved
[   12.180412] system 00:02: [io  0x1854-0x1857] has been reserved
[   12.180412] pnp 00:03: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[   12.180412] system 00:03: [mem 0xfedc0000-0xfedc7fff] has been reserved
[   12.180412] system 00:03: [mem 0xfeda0000-0xfeda0fff] has been reserved
[   12.180412] system 00:03: [mem 0xfeda1000-0xfeda1fff] has been reserved
[   12.180412] system 00:03: [mem 0xfed20000-0xfed7ffff] has been reserved
[   12.180412] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[   12.180412] system 00:03: [mem 0xfed45000-0xfed8ffff] could not be reserved
[   12.180412] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
[   12.184704] system 00:04: [io  0x1800-0x18fe] could not be reserved
[   12.184706] system 00:04: [mem 0xfe000000-0xfe01ffff] could not be reserved
[   12.184707] system 00:04: [mem 0xfe04c000-0xfe04ffff] has been reserved
[   12.184709] system 00:04: [mem 0xfe050000-0xfe0affff] has been reserved
[   12.184711] system 00:04: [mem 0xfe0d0000-0xfe0fffff] has been reserved
[   12.184713] system 00:04: [mem 0xfe200000-0xfe7fffff] has been reserved
[   12.184714] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[   12.184716] system 00:04: [mem 0xfd000000-0xfd68ffff] has been reserved
[   12.184717] system 00:04: [mem 0xfd6b0000-0xfd6cffff] has been reserved
[   12.184719] system 00:04: [mem 0xfd6f0000-0xfdffffff] has been reserved
[   12.184946] system 00:05: [io  0x2000-0x20fe] has been reserved
[   12.185200] system 00:07: [mem 0xfe410400-0xfe4104fe] has been reserved
[   12.185266] pnp: PnP ACPI: found 8 devices
[   12.190367] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[   12.190407] NET: Registered PF_INET protocol family
[   12.190531] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[   12.191451] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[   12.191516] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[   12.191641] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[   12.191681] TCP: Hash tables configured (established 131072 bind 65536)
[   12.191738] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
[   12.191782] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[   12.191810] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[   12.191890] NET: Registered PF_UNIX/PF_LOCAL protocol family
[   12.191976] RPC: Registered named UNIX socket transport module.
[   12.191977] RPC: Registered udp transport module.
[   12.191978] RPC: Registered tcp transport module.
[   12.191979] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   12.192080] NET: Registered PF_XDP protocol family
[   12.192084] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
[   12.192093] pci 0000:00:02.0: BAR 9: assigned [mem 0x4020000000-0x40ffffffff 64bit pref]
[   12.192097] pci 0000:00:02.0: BAR 7: assigned [mem 0x4010000000-0x4016ffffff 64bit]
[   12.192100] pci 0000:00:07.0: BAR 13: assigned [io  0x4000-0x4fff]
[   12.192102] pci 0000:00:07.3: BAR 13: assigned [io  0x5000-0x5fff]
[   12.192104] pci 0000:00:15.0: BAR 0: assigned [mem 0x4017000000-0x4017000fff 64bit]
[   12.192452] pci 0000:00:1f.5: BAR 0: assigned [mem 0x4f800000-0x4f800fff]
[   12.192468] pci 0000:00:06.0: PCI bridge to [bus 01]
[   12.192477] pci 0000:00:06.0:   bridge window [mem 0x6a500000-0x6a5fffff]
[   12.192493] pci 0000:00:07.0: PCI bridge to [bus 02-2c]
[   12.192495] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]
[   12.192498] pci 0000:00:07.0:   bridge window [mem 0x5e000000-0x6a1fffff]
[   12.192501] pci 0000:00:07.0:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[   12.192505] pci 0000:00:07.3: PCI bridge to [bus 2d-57]
[   12.192507] pci 0000:00:07.3:   bridge window [io  0x5000-0x5fff]
[   12.192510] pci 0000:00:07.3:   bridge window [mem 0x50000000-0x5c1fffff]
[   12.192513] pci 0000:00:07.3:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[   12.192517] pci 0000:00:1c.0: PCI bridge to [bus 58]
[   12.192535] pci 0000:00:1c.0:   bridge window [mem 0x6a400000-0x6a4fffff]
[   12.192543] pci 0000:00:1c.6: PCI bridge to [bus 59]
[   12.192547] pci 0000:00:1c.6:   bridge window [mem 0x6a200000-0x6a3fffff]
[   12.192554] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[   12.192556] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[   12.192557] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[   12.192558] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000fffff window]
[   12.192560] pci_bus 0000:00: resource 8 [mem 0x4f800000-0xbfffffff window]
[   12.192561] pci_bus 0000:00: resource 9 [mem 0x4000000000-0x7fffffffff window]
[   12.192563] pci_bus 0000:01: resource 1 [mem 0x6a500000-0x6a5fffff]
[   12.192564] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[   12.192565] pci_bus 0000:02: resource 1 [mem 0x5e000000-0x6a1fffff]
[   12.192566] pci_bus 0000:02: resource 2 [mem 0x6020000000-0x603bffffff 64bit pref]
[   12.192568] pci_bus 0000:2d: resource 0 [io  0x5000-0x5fff]
[   12.192569] pci_bus 0000:2d: resource 1 [mem 0x50000000-0x5c1fffff]
[   12.192570] pci_bus 0000:2d: resource 2 [mem 0x6000000000-0x601bffffff 64bit pref]
[   12.192572] pci_bus 0000:58: resource 1 [mem 0x6a400000-0x6a4fffff]
[   12.192573] pci_bus 0000:59: resource 1 [mem 0x6a200000-0x6a3fffff]
[   12.192666] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[   12.193483] PCI: CLS 64 bytes, default 64
[   12.193488] DMAR: Intel-IOMMU force enabled due to platform opt in
[   12.193497] DMAR: No ATSR found
[   12.193497] DMAR: No SATC found
[   12.193501] DMAR: IOMMU feature fl1gp_support inconsistent
[   12.193502] DMAR: IOMMU feature pgsel_inv inconsistent
[   12.193503] DMAR: IOMMU feature nwfs inconsistent
[   12.193504] DMAR: IOMMU feature pds inconsistent
[   12.193504] DMAR: IOMMU feature dit inconsistent
[   12.193505] DMAR: IOMMU feature eafs inconsistent
[   12.193506] DMAR: IOMMU feature prs inconsistent
[   12.193507] DMAR: IOMMU feature nest inconsistent
[   12.193507] DMAR: IOMMU feature mts inconsistent
[   12.193508] DMAR: IOMMU feature sc_support inconsistent
[   12.193509] DMAR: IOMMU feature dev_iotlb_support inconsistent
[   12.193510] DMAR: dmar2: Using Queued invalidation
[   12.193514] DMAR: dmar1: Using Queued invalidation
[   12.193516] DMAR: dmar0: Using Queued invalidation
[   12.193518] DMAR: dmar3: Using Queued invalidation
[   12.193527] Unpacking initramfs...
[   12.193660] pci 0000:00:00.0: Adding to iommu group 0
[   12.193666] pci 0000:00:02.0: Adding to iommu group 1
[   12.193680] pci 0000:00:06.0: Adding to iommu group 2
[   12.193686] pci 0000:00:07.0: Adding to iommu group 3
[   12.193692] pci 0000:00:07.3: Adding to iommu group 4
[   12.193697] pci 0000:00:08.0: Adding to iommu group 5
[   12.193707] pci 0000:00:0d.0: Adding to iommu group 6
[   12.193712] pci 0000:00:0d.2: Adding to iommu group 6
[   12.193717] pci 0000:00:0d.3: Adding to iommu group 6
[   12.193725] pci 0000:00:14.0: Adding to iommu group 7
[   12.193730] pci 0000:00:14.2: Adding to iommu group 7
[   12.193735] pci 0000:00:14.3: Adding to iommu group 8
[   12.193742] pci 0000:00:15.0: Adding to iommu group 9
[   12.193749] pci 0000:00:16.0: Adding to iommu group 10
[   12.193754] pci 0000:00:17.0: Adding to iommu group 11
[   12.193775] pci 0000:00:1c.0: Adding to iommu group 12
[   12.193789] pci 0000:00:1c.6: Adding to iommu group 13
[   12.193800] pci 0000:00:1f.0: Adding to iommu group 14
[   12.193806] pci 0000:00:1f.3: Adding to iommu group 14
[   12.193813] pci 0000:00:1f.4: Adding to iommu group 14
[   12.193818] pci 0000:00:1f.5: Adding to iommu group 14
[   12.193830] pci 0000:01:00.0: Adding to iommu group 15
[   12.193851] pci 0000:58:00.0: Adding to iommu group 16
[   12.193865] pci 0000:59:00.0: Adding to iommu group 17
[   12.193964] DMAR: Intel(R) Virtualization Technology for Directed I/O
[   12.193965] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   12.193966] software IO TLB: mapped [mem 0x000000002b8e0000-0x000000002f8e0000] (64MB)
[   12.194043] resource sanity check: requesting [mem 0xfedc0000-0xfedcdfff], which spans more than pnp 00:03 [mem 0xfedc0000-0xfedc7fff]
[   12.194045] caller tgl_uncore_imc_freerunning_init_box+0xb7/0xf0 mapping multiple BARs
[   12.290363] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[   12.290420] clocksource: Switched to clocksource tsc
[   12.290429] platform rtc_cmos: registered platform RTC device (no PNP device found)
[   12.290677] Initialise system trusted keyrings
[   12.290685] Key type blacklist registered
[   12.290730] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[   12.291340] zbud: loaded
[   12.291564] NFS: Registering the id_resolver key type
[   12.291568] Key type id_resolver registered
[   12.291569] Key type id_legacy registered
[   12.291578] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[   12.291579] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[   12.291580] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   12.291682] fuse: init (API version 7.35)
[   12.291761] integrity: Platform Keyring initialized
[   12.298484] NET: Registered PF_ALG protocol family
[   12.298486] xor: automatically using best checksumming function   avx       
[   12.298489] async_tx: api initialized (async)
[   12.298491] Key type asymmetric registered
[   12.298492] Asymmetric key parser 'x509' registered
[   12.298508] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[   12.298578] io scheduler mq-deadline registered
[   12.305911] pcieport 0000:00:06.0: PME: Signaling with IRQ 124
[   12.306080] pcieport 0000:00:07.0: PME: Signaling with IRQ 125
[   12.306093] pcieport 0000:00:07.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[   12.306305] pcieport 0000:00:07.3: PME: Signaling with IRQ 126
[   12.306318] pcieport 0000:00:07.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[   12.365122] Freeing initrd memory: 18860K
[   12.431649] pcieport 0000:00:1c.0: PME: Signaling with IRQ 127
[   12.551599] pcieport 0000:00:1c.6: PME: Signaling with IRQ 128
[   12.551746] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.551918] Monitor-Mwait will be used to enter C-1 state
[   12.551922] Monitor-Mwait will be used to enter C-2 state
[   12.551925] Monitor-Mwait will be used to enter C-3 state
[   12.551927] ACPI: \_SB_.PR00: Found 3 idle states
[   12.552278] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[   12.552298] ACPI: button: Sleep Button [SLPB]
[   12.552325] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[   12.552340] ACPI: button: Power Button [PWRB]
[   12.552365] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   12.552390] ACPI: button: Power Button [PWRF]
[   12.552639] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1499
[   12.553633] thermal LNXTHERM:00: registered as thermal_zone0
[   12.553637] ACPI: thermal: Thermal Zone [TZ0] (-263 C)
[   12.553989] thermal LNXTHERM:01: registered as thermal_zone1
[   12.553991] ACPI: thermal: Thermal Zone [TZ00] (38 C)
[   12.554136] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   12.554811] hpet_acpi_add: no address or irqs in _CRS
[   12.554839] Linux agpgart interface v0.103
[   12.554892] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[   12.555107] ACPI: bus type drm_connector registered
[   12.555775] i915 0000:00:02.0: [drm] VT-d active for gfx access
[   12.555779] i915 0000:00:02.0: vgaarb: deactivate vga console
[   12.555816] i915 0000:00:02.0: [drm] Transparent Hugepage mode 'huge=within_size'
[   12.557838] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   12.558485] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/tgl_dmc_ver2_12.bin (v2.12)
[   12.672827] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[   12.673720] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   12.674071] acpi device:48: registered as cooling_device11
[   12.674224] acpi device:49: registered as cooling_device12
[   12.674267] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[   12.675192] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   12.675521] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   12.675852] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   12.682525] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops)
[   12.695023] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[   12.695363] idma64 idma64.0: Found Intel integrated DMA 64-bit
[   12.701985] nvme 0000:01:00.0: platform quirk: setting simple suspend
[   12.702013] nvme nvme0: pci function 0000:01:00.0
[   12.702030] ahci 0000:00:17.0: version 3.0
[   12.702893] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[   12.702896] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part deso sadm sds 
[   12.703257] scsi host0: ahci
[   12.703591] scsi host1: ahci
[   12.703627] ata1: SATA max UDMA/133 abar m2048@0x6a602000 port 0x6a602100 irq 131
[   12.703630] ata2: SATA max UDMA/133 abar m2048@0x6a602000 port 0x6a602180 irq 131
[   12.703676] Intel(R) 2.5G Ethernet Linux Driver
[   12.703677] Copyright(c) 2018 Intel Corporation.
[   12.703775] igc 0000:59:00.0: enabling device (0000 -> 0002)
[   12.703920] igc 0000:59:00.0: PTM enabled, 4ns granularity
[   12.708438] nvme nvme0: missing or invalid SUBNQN field.
[   12.708451] nvme nvme0: Shutdown timeout set to 8 seconds
[   12.719852] nvme nvme0: 8/0/0 default/read/poll queues
[   12.721842]  nvme0n1: p1 p2 p3
[   12.751461] pps pps0: new PPS source ptp0
[   12.751570] igc 0000:59:00.0 (unnamed net_device) (uninitialized): PHC added
[   12.815301] igc 0000:59:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[   12.815309] igc 0000:59:00.0 eth0: MAC: 1c:69:7a:ac:a4:aa
[   12.815340] Intel(R) Wireless WiFi driver for Linux
[   12.815398] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[   12.817987] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-67.ucode failed with error -2
[   12.818000] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-66.ucode failed with error -2
[   12.818008] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-65.ucode failed with error -2
[   12.818016] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-64.ucode failed with error -2
[   12.818024] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-63.ucode failed with error -2
[   12.818032] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-62.ucode failed with error -2
[   12.818039] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-61.ucode failed with error -2
[   12.818047] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-60.ucode failed with error -2
[   12.818055] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-59.ucode failed with error -2
[   12.818063] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-58.ucode failed with error -2
[   12.818071] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-57.ucode failed with error -2
[   12.818078] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-56.ucode failed with error -2
[   12.818086] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-55.ucode failed with error -2
[   12.818094] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-54.ucode failed with error -2
[   12.818102] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-53.ucode failed with error -2
[   12.818110] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-52.ucode failed with error -2
[   12.818118] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-51.ucode failed with error -2
[   12.818125] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-50.ucode failed with error -2
[   12.818133] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-49.ucode failed with error -2
[   12.818142] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-48.ucode failed with error -2
[   12.818149] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-47.ucode failed with error -2
[   12.818156] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-46.ucode failed with error -2
[   12.818164] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-45.ucode failed with error -2
[   12.818172] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-44.ucode failed with error -2
[   12.818180] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-43.ucode failed with error -2
[   12.818187] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-42.ucode failed with error -2
[   12.818195] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-41.ucode failed with error -2
[   12.818202] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-40.ucode failed with error -2
[   12.818210] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-39.ucode failed with error -2
[   12.818212] iwlwifi 0000:00:14.3: no suitable firmware found!
[   12.818214] iwlwifi 0000:00:14.3: minimum version required: iwlwifi-QuZ-a0-hr-b0-39
[   12.818216] iwlwifi 0000:00:14.3: maximum version supported: iwlwifi-QuZ-a0-hr-b0-67
[   12.818218] iwlwifi 0000:00:14.3: check git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
[   12.818364] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[   12.818373] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
[   12.819528] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[   12.819815] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
[   12.819821] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.819825] usb usb1: Product: xHCI Host Controller
[   12.819828] usb usb1: Manufacturer: Linux 5.16.0-rc3+ xhci-hcd
[   12.819831] usb usb1: SerialNumber: 0000:00:0d.0
[   12.820240] hub 1-0:1.0: USB hub found
[   12.820246] hub 1-0:1.0: 1 port detected
[   12.820360] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[   12.820363] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
[   12.820366] xhci_hcd 0000:00:0d.0: Host supports USB 3.1 Enhanced SuperSpeed
[   12.820393] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
[   12.820395] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.820398] usb usb2: Product: xHCI Host Controller
[   12.820399] usb usb2: Manufacturer: Linux 5.16.0-rc3+ xhci-hcd
[   12.820401] usb usb2: SerialNumber: 0000:00:0d.0
[   12.820467] hub 2-0:1.0: USB hub found
[   12.820476] hub 2-0:1.0: 4 ports detected
[   12.821036] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   12.821040] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[   12.822147] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000000009810
[   12.822355] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
[   12.822357] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.822359] usb usb3: Product: xHCI Host Controller
[   12.822360] usb usb3: Manufacturer: Linux 5.16.0-rc3+ xhci-hcd
[   12.822362] usb usb3: SerialNumber: 0000:00:14.0
[   12.822490] hub 3-0:1.0: USB hub found
[   12.822517] hub 3-0:1.0: 12 ports detected
[   12.823451] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   12.823453] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[   12.823455] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[   12.823491] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
[   12.823493] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.823494] usb usb4: Product: xHCI Host Controller
[   12.823495] usb usb4: Manufacturer: Linux 5.16.0-rc3+ xhci-hcd
[   12.823496] usb usb4: SerialNumber: 0000:00:14.0
[   12.823613] hub 4-0:1.0: USB hub found
[   12.823632] hub 4-0:1.0: 4 ports detected
[   12.872363] i8042: PNP: No PS/2 controller found.
[   12.872630] mousedev: PS/2 mouse device common for all mice
[   12.872984] usbcore: registered new interface driver synaptics_usb
[   12.873020] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   12.873070] rtc_cmos rtc_cmos: RTC can wake from S4
[   12.874768] rtc_cmos rtc_cmos: registered as rtc0
[   12.875189] rtc_cmos rtc_cmos: setting system clock to 2022-01-15T15:52:03 UTC (1642261923)
[   12.875201] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
[   12.875435] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   12.875531] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   12.877700] i2c i2c-14: 2/2 memory slots populated (from DMI)
[   12.878776] ee1004 14-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[   12.878781] i2c i2c-14: Successfully instantiated SPD at 0x50
[   12.880381] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
[   12.880495] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   12.880505] iTCO_vendor_support: vendor-support=0
[   12.880619] usbcore: registered new interface driver btusb
[   12.880623] intel_pstate: Intel P-state driver initializing
[   12.881165] intel_pstate: HWP enabled
[   12.881174] sdhci: Secure Digital Host Controller Interface driver
[   12.881176] sdhci: Copyright(c) Pierre Ossman
[   12.881194] sdhci-pci 0000:58:00.0: SDHCI controller found [17a0:9755] (rev 0)
[   12.881269] sdhci-pci 0000:58:00.0: enabling device (0000 -> 0002)
[   12.881968] mmc0: SDHCI controller on PCI [0000:58:00.0] using ADMA 64-bit
[   12.882210] ledtrig-cpu: registered to indicate activity on CPUs
[   12.894561] pstore: Registered efi as persistent store backend
[   12.894573] hid: raw HID events driver (C) Jiri Kosina
[   12.894582] usbcore: registered new interface driver usbhid
[   12.894584] usbhid: USB HID core driver
[   12.894667] intel_pmc_core INT33A1:00:  initialized
[   12.894729] intel_rapl_msr: PL4 support detected.
[   12.894843] intel_rapl_common: Found RAPL domain package
[   12.894847] intel_rapl_common: Found RAPL domain core
[   12.894850] intel_rapl_common: Found RAPL domain uncore
[   12.894852] intel_rapl_common: Found RAPL domain psys
[   12.895150] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
[   12.895172] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   12.895281] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops)
[   12.895730] NET: Registered PF_INET6 protocol family
[   12.899750] Segment Routing with IPv6
[   12.899755] In-situ OAM (IOAM) with IPv6
[   12.899765] mip6: Mobile IPv6
[   12.899767] NET: Registered PF_PACKET protocol family
[   12.899770] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.899771] Bluetooth: BNEP filters: protocol multicast
[   12.899773] Bluetooth: BNEP socket layer initialized
[   12.899866] Key type dns_resolver registered
[   12.899868] mpls_gso: MPLS GSO support
[   12.900587] microcode: sig=0x806c1, pf=0x80, revision=0x72
[   12.900727] microcode: Microcode Update Driver: v2.2.
[   12.900899] resctrl: L2 allocation detected
[   12.900902] IPI shorthand broadcast: enabled
[   12.900906] AVX2 version of gcm_enc/dec engaged.
[   12.900985] AES CTR mode by8 optimization enabled
[   12.901118] sched_clock: Marking stable (12884487252, 16625512)->(12917083437, -15970673)
[   12.901257] registered taskstats version 1
[   12.901260] Loading compiled-in X.509 certificates
[   12.916890] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC256: line_outs=1 (0x21/0x0/0x0/0x0/0x0) type:hp
[   12.916895] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   12.916897] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   12.916898] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   12.916900] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   12.916901] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x13
[   12.916902] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[   12.942323] Loaded X.509 cert 'Build time autogenerated kernel key: 03137a584dfb08dfb89c47acef0b1d7589f4ca2a'
[   12.942790] zswap: loaded using pool lzo/zbud
[   12.943410] ------------[ cut here ]------------
[   12.943411] Debug warning: early ioremap leak of 1 areas detected.
               please boot with early_ioremap_debug and report the dmesg.
[   12.943417] WARNING: CPU: 4 PID: 1 at mm/early_ioremap.c:91 check_early_ioremap_leak+0x31/0x39
[   12.943421] Modules linked in:
[   12.943422] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc3+ #14
[   12.943424] Hardware name: Intel(R) Client Systems NUC11PAHi7/NUC11PABi7, BIOS PATGL357.0041.2021.0811.1505 08/11/2021
[   12.943425] RIP: 0010:check_early_ioremap_leak+0x31/0x39
[   12.943427] Code: 31 c0 48 83 3c d5 00 dc 04 84 00 74 02 ff c0 48 ff c2 48 83 fa 08 75 ea 85 c0 74 15 89 c6 48 c7 c7 78 f8 b7 82 e8 b0 7f 1d fe <0f> 0b b8 01 00 00 00 c3 0f 1f 44 00 00 41 57 48 89 f1 41 56 49 89
[   12.943429] RSP: 0018:ffffc90000067e30 EFLAGS: 00010286
[   12.943431] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   12.943432] RDX: 0000000000000001 RSI: 00000000ffffefff RDI: 00000000ffffffff
[   12.943434] RBP: ffffffff83efaee0 R08: 0000000000000000 R09: ffffc90000067c60
[   12.943435] R10: ffffc90000067c58 R11: ffffffff834f8ae8 R12: ffff888101f54e00
[   12.943436] R13: ffffffff8411881c R14: 0000000000000000 R15: 0000000000000000
[   12.943437] FS:  0000000000000000(0000) GS:ffff8884a0500000(0000) knlGS:0000000000000000
[   12.943438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.943439] CR2: 00007fe669e556f4 CR3: 0000000006810001 CR4: 0000000000770ee0
[   12.943441] PKRU: 55555554
[   12.943442] Call Trace:
[   12.943444]  <TASK>
[   12.943445]  do_one_initcall+0x41/0x200
[   12.943449]  kernel_init_freeable+0x21b/0x282
[   12.943451]  ? rest_init+0xd0/0xd0
[   12.943454]  kernel_init+0x16/0x120
[   12.943456]  ret_from_fork+0x1f/0x30
[   12.943458]  </TASK>
[   12.943458] ---[ end trace d2d8f6544cc03c44 ]---
[   12.943476] Key type ._fscrypt registered
[   12.943477] Key type .fscrypt registered
[   12.943477] Key type fscrypt-provisioning registered
[   12.943657] pstore: Using crash dump compression: deflate
[   12.945516] Key type encrypted registered
[   12.945520] AppArmor: AppArmor sha1 policy hashing enabled
[   12.945872] integrity: Loading X.509 certificate: UEFI:db
[   12.945891] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[   12.945893] integrity: Loading X.509 certificate: UEFI:db
[   12.945904] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[   12.946810] integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
[   12.946932] integrity: Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[   12.946935] ima: No TPM chip found, activating TPM-bypass!
[   12.946938] ima: Allocated hash algorithm: sha256
[   12.946944] ima: No architecture policies found
[   12.946951] evm: Initialising EVM extended attributes:
[   12.946951] evm: security.selinux
[   12.946952] evm: security.SMACK64 (disabled)
[   12.946953] evm: security.SMACK64EXEC (disabled)
[   12.946954] evm: security.SMACK64TRANSMUTE (disabled)
[   12.946955] evm: security.SMACK64MMAP (disabled)
[   12.946955] evm: security.apparmor
[   12.946956] evm: security.ima
[   12.946957] evm: security.capability
[   12.946957] evm: HMAC attrs: 0x1
[   12.972346] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[   12.983953] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input5
[   12.983974] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input6
[   12.983992] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input7
[   12.984009] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
[   12.984024] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[   12.984041] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[   12.984058] input: HDA Intel PCH HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[   12.984074] input: HDA Intel PCH HDMI/DP,pcm=12 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[   12.984091] input: HDA Intel PCH HDMI/DP,pcm=13 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[   12.984108] input: HDA Intel PCH HDMI/DP,pcm=14 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[   12.984125] input: HDA Intel PCH HDMI/DP,pcm=15 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[   12.984141] input: HDA Intel PCH HDMI/DP,pcm=16 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   12.984157] input: HDA Intel PCH HDMI/DP,pcm=17 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[   13.017604] ata2: SATA link down (SStatus 4 SControl 300)
[   13.018007] ata1: SATA link down (SStatus 4 SControl 300)
[   13.032464] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   13.032571] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.032579] ALSA device list:
[   13.032580]   #0: HDA Intel PCH at 0x603d1a0000 irq 148
[   13.034880] usb usb4-port4: config error
[   13.034882] Freeing unused decrypted memory: 2036K
[   13.035239] Freeing unused kernel image (initmem) memory: 2800K
[   13.035259] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   13.035262] cfg80211: failed to load regulatory.db
[   13.050990] Write protecting the kernel read-only data: 36864k
[   13.051585] Freeing unused kernel image (text/rodata gap) memory: 2028K
[   13.051733] Freeing unused kernel image (rodata/data gap) memory: 116K
[   13.061979] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   13.061986] Run /init as init process
[   13.061988]   with arguments:
[   13.061990]     /init
[   13.061992]     force_early_printk
[   13.061993]     nokaslr
[   13.061994]   with environment:
[   13.061996]     HOME=/
[   13.061997]     TERM=linux
[   13.061998]     BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+
[   13.082841] usb 3-5: new full-speed USB device number 2 using xhci_hcd
[   13.133052] igc 0000:59:00.0 enp89s0: renamed from eth0
[   13.215018] usb 3-5: device descriptor read/64, error -71
[   13.450933] usb 3-5: device descriptor read/64, error -71
[   13.686960] usb 3-5: new full-speed USB device number 3 using xhci_hcd
[   13.814916] usb 3-5: device descriptor read/64, error -71
[   14.051022] usb 3-5: device descriptor read/64, error -71
[   14.158938] usb usb3-port5: attempt power cycle
[   14.570847] usb 3-5: new full-speed USB device number 4 using xhci_hcd
[   14.571123] usb 3-5: Device not responding to setup address.
[   14.779256] usb 3-5: Device not responding to setup address.
[   14.986963] usb 3-5: device not accepting address 4, error -71
[   15.114944] usb 3-5: new full-speed USB device number 5 using xhci_hcd
[   15.115273] usb 3-5: Device not responding to setup address.
[   15.323240] usb 3-5: Device not responding to setup address.
[   15.530928] usb 3-5: device not accepting address 5, error -71
[   15.531037] usb usb3-port5: unable to enumerate USB device
[   15.658945] usb 3-10: new full-speed USB device number 6 using xhci_hcd
[   15.809529] usb 3-10: New USB device found, idVendor=8087, idProduct=0026, bcdDevice= 0.02
[   15.809544] usb 3-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   15.812718] Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
[   15.813784] Bluetooth: hci0: Device revision is 2
[   15.813798] Bluetooth: hci0: Secure boot is enabled
[   15.813804] Bluetooth: hci0: OTP lock is enabled
[   15.813809] Bluetooth: hci0: API lock is enabled
[   15.813813] Bluetooth: hci0: Debug lock is disabled
[   15.813819] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   15.813853] Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-19-0-4.sfi (-2)
[   17.115089] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   17.115163] usb usb4-port4: config error
[   21.187078] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   21.187319] usb usb4-port4: config error
[   25.259100] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   25.259173] usb usb4-port4: config error
[   29.331034] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   29.331257] usb usb4-port4: config error
[   33.403090] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   33.403155] usb usb4-port4: config error
[   37.475081] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   37.475289] usb usb4-port4: config error
[   41.547044] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   41.547115] usb usb4-port4: config error
[   45.619101] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   45.619313] usb usb4-port4: config error
[   45.689966] PM: Image not found (code -22)
[   45.731803] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[   45.760071] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[   45.824282] systemd[1]: systemd 249.7-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS -OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP -LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[   45.824308] systemd[1]: No virtualization found in DMI vendor table.
[   45.824332] systemd[1]: DMI BIOS Extension table does not indicate virtualization.
[   45.843050] systemd[1]: UML virtualization not found in /proc/cpuinfo.
[   45.843071] systemd[1]: No virtualization found in CPUID
[   45.843087] systemd[1]: Virtualization XEN not found, /proc/xen does not exist
[   45.843106] systemd[1]: This platform does not support /proc/device-tree
[   45.843110] systemd[1]: This platform does not support /proc/sysinfo
[   45.843115] systemd[1]: Found VM virtualization none
[   45.843123] systemd[1]: Detected architecture x86-64.
[   45.843251] systemd[1]: Detected initialized system, this is not the first boot.
[   45.843626] systemd[1]: Hostname set to <tigerlake>.
[   45.844236] systemd[1]: Successfully added address 127.0.0.1 to loopback interface
[   45.844249] systemd[1]: Successfully added address ::1 to loopback interface
[   45.844258] systemd[1]: Successfully brought loopback interface up
[   45.844499] systemd[1]: Setting 'fs/file-max' to '9223372036854775807'.
[   45.845178] systemd[1]: Found cgroup2 on /sys/fs/cgroup/, full unified hierarchy
[   45.845186] systemd[1]: Unified cgroup hierarchy is located at /sys/fs/cgroup.
[   45.859386] systemd[1]: Got EBADF when using BPF_F_ALLOW_MULTI, which indicates it is supported. Yay!
[   45.859495] systemd[1]: Controller 'cpu' supported: yes
[   45.859519] systemd[1]: Controller 'cpuacct' supported: no
[   45.859521] systemd[1]: Controller 'cpuset' supported: yes
[   45.859522] systemd[1]: Controller 'io' supported: yes
[   45.859524] systemd[1]: Controller 'blkio' supported: no
[   45.859525] systemd[1]: Controller 'memory' supported: yes
[   45.859527] systemd[1]: Controller 'devices' supported: no
[   45.859528] systemd[1]: Controller 'pids' supported: yes
[   45.859529] systemd[1]: Controller 'bpf-firewall' supported: yes
[   45.859531] systemd[1]: Controller 'bpf-devices' supported: yes
[   45.859532] systemd[1]: Controller 'bpf-foreign' supported: yes
[   45.859534] systemd[1]: Controller 'bpf-socket-bind' supported: no
[   45.859541] systemd[1]: Set up TFD_TIMER_CANCEL_ON_SET timerfd.
[   45.859647] systemd[1]: Enabling (yes) showing of status (commandline).
[   45.859774] systemd[1]: Successfully forked off '(sd-executor)' as PID 373.
[   45.860148] systemd[373]: Successfully forked off '(direxec)' as PID 374.
[   45.860216] systemd[373]: Successfully forked off '(direxec)' as PID 375.
[   45.860281] systemd[373]: Successfully forked off '(direxec)' as PID 376.
[   45.860361] systemd[373]: Successfully forked off '(direxec)' as PID 377.
[   45.860429] systemd[373]: Successfully forked off '(direxec)' as PID 378.
[   45.860525] systemd[373]: Successfully forked off '(direxec)' as PID 379.
[   45.860606] systemd[373]: Successfully forked off '(direxec)' as PID 380.
[   45.860753] systemd[373]: Successfully forked off '(direxec)' as PID 381.
[   45.860859] systemd[373]: Successfully forked off '(direxec)' as PID 382.
[   45.860972] systemd[373]: Successfully forked off '(direxec)' as PID 383.
[   45.861071] systemd[373]: Successfully forked off '(direxec)' as PID 384.
[   45.861189] systemd[373]: Successfully forked off '(direxec)' as PID 385.
[   45.861290] systemd[373]: Successfully forked off '(direxec)' as PID 386.
[   45.863310] systemd-bless-boot-generator[375]: Skipping generator, not booted with boot counting in effect.
[   45.863318] systemd-fstab-generator[378]: Parsing /etc/fstab...
[   45.863370] systemd-fstab-generator[378]: Found entry what=/dev/disk/by-uuid/a652986c-fbc6-4341-85c3-b4ad4402f130 where=/ type=ext4 makefs=no growfs=no noauto=no nofail=no
[   45.863424] systemd-hibernate-resume-generator[381]: Not running in an initrd, quitting.
[   45.864056] systemd-fstab-generator[378]: SELinux enabled state cached to: disabled
[   45.864475] systemd-fstab-generator[378]: Found entry what=/dev/disk/by-uuid/7F40-7E64 where=/boot/efi type=vfat makefs=no growfs=no noauto=no nofail=no
[   45.864525] systemd-gpt-auto-generator[380]: Disabling root partition auto-detection, root= is defined.
[   45.864551] systemd-gpt-auto-generator[380]: Failed to chase block device '/', ignoring: No such file or directory
[   45.864665] systemd-fstab-generator[378]: Checking was requested for /dev/disk/by-uuid/7F40-7E64, but fsck.vfat does not exist.
[   45.864685] systemd-fstab-generator[378]: Found entry what=/dev/disk/by-uuid/63cfb962-43f6-416b-8f7d-dcb57f471473 where=none type=swap makefs=no growfs=no noauto=no nofail=no
[   45.864893] systemd-gpt-auto-generator[380]: nvme0n1p2: Root device /dev/nvme0n1.
[   45.865452] systemd-rc-local-generator[382]: /etc/rc.local does not exist, skipping.
[   45.866449] systemd-sysv-generator[385]: Native unit for procps.service already exists, skipping.
[   45.866690] systemd-sysv-generator[385]: Native unit for smartmontools.service already exists, skipping.
[   45.866881] systemd-sysv-generator[385]: Native unit for lvm2-lvmpolld.service already exists, skipping.
[   45.867015] systemd-sysv-generator[385]: Native unit for dbus.service already exists, skipping.
[   45.867081] systemd-sysv-generator[385]: Native unit for cron.service already exists, skipping.
[   45.867106] systemd-sysv-generator[385]: Native unit for hwclock.service already exists, skipping.
[   45.867176] systemd-sysv-generator[385]: Native unit for console-setup.service already exists, skipping.
[   45.867200] systemd-sysv-generator[385]: Native unit for sudo.service already exists, skipping.
[   45.867335] systemd-sysv-generator[385]: Native unit for udev.service already exists, skipping.
[   45.867399] systemd-sysv-generator[385]: Native unit for rsync.service already exists, skipping.
[   45.867688] systemd-sysv-generator[385]: Native unit for nfs-common.service already exists, skipping.
[   45.867714] systemd-sysv-generator[385]: Native unit for x11-common.service already exists, skipping.
[   45.867781] systemd-sysv-generator[385]: Native unit for acpid.service already exists, skipping.
[   45.867845] systemd-sysv-generator[385]: Native unit for uuidd.service already exists, skipping.
[   45.868338] systemd-sysv-generator[385]: Native unit for apparmor.service already exists, skipping.
[   45.868356] systemd-sysv-generator[385]: Native unit for live-tools.service already exists, skipping.
[   45.868380] systemd-sysv-generator[385]: Native unit for alsa-utils.service already exists, skipping.
[   45.868445] systemd-sysv-generator[385]: Native unit for bluetooth.service already exists, skipping.
[   45.868511] systemd-sysv-generator[385]: Native unit for ssh.service already exists, skipping.
[   45.868579] systemd-sysv-generator[385]: Native unit for anacron.service already exists, skipping.
[   45.868644] systemd-sysv-generator[385]: Native unit for keyboard-setup.service already exists, skipping.
[   45.868708] systemd-sysv-generator[385]: Native unit for networking.service already exists, skipping.
[   45.868721] systemd-sysv-generator[385]: Cannot find unit exim4.service.
[   45.868724] systemd-sysv-generator[385]: SysV service '/etc/init.d/exim4' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
[   45.868749] systemd-sysv-generator[385]: Native unit for lvm2.service already exists, skipping.
[   45.868773] systemd-sysv-generator[385]: Native unit for mdadm-waitidle.service already exists, skipping.
[   45.868837] systemd-sysv-generator[385]: Native unit for rpcbind.service already exists, skipping.
[   45.868860] systemd-sysv-generator[385]: Native unit for mdadm.service already exists, skipping.
[   45.868994] systemd-sysv-generator[385]: Native unit for kmod.service already exists, skipping.
[   45.869056] systemd-sysv-generator[385]: Native unit for sysstat.service already exists, skipping.
[   45.869075] systemd-gpt-auto-generator[380]: swap specified in fstab, ignoring.
[   45.869104] systemd-gpt-auto-generator[380]: "/boot" already populated, ignoring.
[   45.869120] systemd-sysv-generator[385]: Native unit for lm-sensors.service already exists, skipping.
[   45.869342] systemd-sysv-generator[385]: Ignoring S01cron symlink in rc2.d, not generating cron.service.
[   45.869345] systemd-sysv-generator[385]: Ignoring S01mdadm symlink in rc2.d, not generating mdadm.service.
[   45.869348] systemd-sysv-generator[385]: Ignoring S01lvm2-lvmpolld symlink in rc2.d, not generating lvm2-lvmpolld.service.
[   45.869350] systemd-sysv-generator[385]: Ignoring S01bluetooth symlink in rc2.d, not generating bluetooth.service.
[   45.869353] systemd-sysv-generator[385]: Ignoring S01rsync symlink in rc2.d, not generating rsync.service.
[   45.869355] systemd-sysv-generator[385]: Ignoring S01sudo symlink in rc2.d, not generating sudo.service.
[   45.869357] systemd-sysv-generator[385]: Ignoring S01dbus symlink in rc2.d, not generating dbus.service.
[   45.869359] systemd-sysv-generator[385]: Ignoring S01sysstat symlink in rc2.d, not generating sysstat.service.
[   45.869362] systemd-sysv-generator[385]: Ignoring S01uuidd symlink in rc2.d, not generating uuidd.service.
[   45.869365] systemd-sysv-generator[385]: Ignoring S01anacron symlink in rc2.d, not generating anacron.service.
[   45.869367] systemd-sysv-generator[385]: Ignoring S01acpid symlink in rc2.d, not generating acpid.service.
[   45.869369] systemd-sysv-generator[385]: Ignoring S01ssh symlink in rc2.d, not generating ssh.service.
[   45.869372] systemd-sysv-generator[385]: Ignoring S01console-setup.sh symlink in rc2.d, not generating console-setup.service.
[   45.869374] systemd-sysv-generator[385]: Ignoring S01smartmontools symlink in rc2.d, not generating smartmontools.service.
[   45.869477] systemd-sysv-generator[385]: Ignoring S01cron symlink in rc3.d, not generating cron.service.
[   45.869479] systemd-sysv-generator[385]: Ignoring S01mdadm symlink in rc3.d, not generating mdadm.service.
[   45.869482] systemd-sysv-generator[385]: Ignoring S01lvm2-lvmpolld symlink in rc3.d, not generating lvm2-lvmpolld.service.
[   45.869484] systemd-sysv-generator[385]: Ignoring S01bluetooth symlink in rc3.d, not generating bluetooth.service.
[   45.869486] systemd-sysv-generator[385]: Ignoring S01rsync symlink in rc3.d, not generating rsync.service.
[   45.869489] systemd-sysv-generator[385]: Ignoring S01sudo symlink in rc3.d, not generating sudo.service.
[   45.869491] systemd-sysv-generator[385]: Ignoring S01dbus symlink in rc3.d, not generating dbus.service.
[   45.869493] systemd-sysv-generator[385]: Ignoring S01sysstat symlink in rc3.d, not generating sysstat.service.
[   45.869496] systemd-sysv-generator[385]: Ignoring S01uuidd symlink in rc3.d, not generating uuidd.service.
[   45.869498] systemd-sysv-generator[385]: Ignoring S01anacron symlink in rc3.d, not generating anacron.service.
[   45.869500] systemd-sysv-generator[385]: Ignoring S01acpid symlink in rc3.d, not generating acpid.service.
[   45.869502] systemd-sysv-generator[385]: Ignoring S01ssh symlink in rc3.d, not generating ssh.service.
[   45.869505] systemd-sysv-generator[385]: Ignoring S01console-setup.sh symlink in rc3.d, not generating console-setup.service.
[   45.869507] systemd-sysv-generator[385]: Ignoring S01smartmontools symlink in rc3.d, not generating smartmontools.service.
[   45.869655] systemd-sysv-generator[385]: Ignoring S01cron symlink in rc4.d, not generating cron.service.
[   45.869657] systemd-sysv-generator[385]: Ignoring S01mdadm symlink in rc4.d, not generating mdadm.service.
[   45.869660] systemd-sysv-generator[385]: Ignoring S01lvm2-lvmpolld symlink in rc4.d, not generating lvm2-lvmpolld.service.
[   45.869662] systemd-sysv-generator[385]: Ignoring S01bluetooth symlink in rc4.d, not generating bluetooth.service.
[   45.869664] systemd-sysv-generator[385]: Ignoring S01rsync symlink in rc4.d, not generating rsync.service.
[   45.869666] systemd-sysv-generator[385]: Ignoring S01sudo symlink in rc4.d, not generating sudo.service.
[   45.869669] systemd-sysv-generator[385]: Ignoring S01dbus symlink in rc4.d, not generating dbus.service.
[   45.869671] systemd-sysv-generator[385]: Ignoring S01sysstat symlink in rc4.d, not generating sysstat.service.
[   45.869674] systemd-sysv-generator[385]: Ignoring S01uuidd symlink in rc4.d, not generating uuidd.service.
[   45.869676] systemd-sysv-generator[385]: Ignoring S01anacron symlink in rc4.d, not generating anacron.service.
[   45.869678] systemd-sysv-generator[385]: Ignoring S01acpid symlink in rc4.d, not generating acpid.service.
[   45.869680] systemd-sysv-generator[385]: Ignoring S01ssh symlink in rc4.d, not generating ssh.service.
[   45.869683] systemd-sysv-generator[385]: Ignoring S01console-setup.sh symlink in rc4.d, not generating console-setup.service.
[   45.869685] systemd-sysv-generator[385]: Ignoring S01smartmontools symlink in rc4.d, not generating smartmontools.service.
[   45.869826] systemd-sysv-generator[385]: Ignoring S01cron symlink in rc5.d, not generating cron.service.
[   45.869829] systemd-sysv-generator[385]: Ignoring S01mdadm symlink in rc5.d, not generating mdadm.service.
[   45.869831] systemd-sysv-generator[385]: Ignoring S01lvm2-lvmpolld symlink in rc5.d, not generating lvm2-lvmpolld.service.
[   45.869834] systemd-sysv-generator[385]: Ignoring S01bluetooth symlink in rc5.d, not generating bluetooth.service.
[   45.869836] systemd-sysv-generator[385]: Ignoring S01rsync symlink in rc5.d, not generating rsync.service.
[   45.869838] systemd-sysv-generator[385]: Ignoring S01sudo symlink in rc5.d, not generating sudo.service.
[   45.869840] systemd-sysv-generator[385]: Ignoring S01dbus symlink in rc5.d, not generating dbus.service.
[   45.869842] systemd-sysv-generator[385]: Ignoring S01sysstat symlink in rc5.d, not generating sysstat.service.
[   45.869845] systemd-sysv-generator[385]: Ignoring S01uuidd symlink in rc5.d, not generating uuidd.service.
[   45.869847] systemd-sysv-generator[385]: Ignoring S01anacron symlink in rc5.d, not generating anacron.service.
[   45.869849] systemd-sysv-generator[385]: Ignoring S01acpid symlink in rc5.d, not generating acpid.service.
[   45.869851] systemd-sysv-generator[385]: Ignoring S01ssh symlink in rc5.d, not generating ssh.service.
[   45.869853] systemd-sysv-generator[385]: Ignoring S01console-setup.sh symlink in rc5.d, not generating console-setup.service.
[   45.869856] systemd-sysv-generator[385]: Ignoring S01smartmontools symlink in rc5.d, not generating smartmontools.service.
[   45.869862] systemd-sysv-generator[385]: Loading SysV script /etc/init.d/exim4
[   45.870173] systemd-sysv-generator[385]: SELinux enabled state cached to: disabled
[   45.870444] systemd[373]: /usr/lib/systemd/system-generators/systemd-sysv-generator succeeded.
[   45.870452] systemd[373]: /usr/lib/systemd/system-generators/systemd-gpt-auto-generator succeeded.
[   45.870458] systemd[373]: /usr/lib/systemd/system-generators/systemd-hibernate-resume-generator succeeded.
[   45.870466] systemd[373]: /usr/lib/systemd/system-generators/systemd-bless-boot-generator succeeded.
[   45.870472] systemd[373]: /usr/lib/systemd/system-generators/systemd-getty-generator succeeded.
[   45.870477] systemd[373]: /usr/lib/systemd/system-generators/systemd-cryptsetup-generator succeeded.
[   45.870483] systemd[373]: /usr/lib/systemd/system-generators/systemd-fstab-generator succeeded.
[   45.870488] systemd[373]: /usr/lib/systemd/system-generators/systemd-rc-local-generator succeeded.
[   45.870493] systemd[373]: /usr/lib/systemd/system-generators/systemd-system-update-generator succeeded.
[   45.870498] systemd[373]: /usr/lib/systemd/system-generators/systemd-debug-generator succeeded.
[   45.870503] systemd[373]: /usr/lib/systemd/system-generators/systemd-run-generator succeeded.
[   45.876390] systemd[373]: /usr/lib/systemd/system-generators/lvm2-activation-generator succeeded.
[   45.876399] systemd[373]: /usr/lib/systemd/system-generators/systemd-veritysetup-generator succeeded.
[   45.876552] systemd[1]: (sd-executor) succeeded.
[   45.876569] systemd[1]: Looking for unit files in (higher priority first):
[   45.876571] systemd[1]: 	/etc/systemd/system.control
[   45.876573] systemd[1]: 	/run/systemd/system.control
[   45.876574] systemd[1]: 	/run/systemd/transient
[   45.876575] systemd[1]: 	/run/systemd/generator.early
[   45.876577] systemd[1]: 	/etc/systemd/system
[   45.876578] systemd[1]: 	/etc/systemd/system.attached
[   45.876579] systemd[1]: 	/run/systemd/system
[   45.876581] systemd[1]: 	/run/systemd/system.attached
[   45.876582] systemd[1]: 	/run/systemd/generator
[   45.876583] systemd[1]: 	/usr/local/lib/systemd/system
[   45.876585] systemd[1]: 	/lib/systemd/system
[   45.876586] systemd[1]: 	/usr/lib/systemd/system
[   45.876587] systemd[1]: 	/run/systemd/generator.late
[   45.877454] systemd[1]: Modification times have changed, need to update cache.
[   45.877493] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/dbus-org.bluez.service \xe2\x86\x92 bluetooth.service
[   45.877513] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/dbus-org.freedesktop.timesync1.service \xe2\x86\x92 systemd-timesyncd.service
[   45.877529] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/dbus-fi.w1.wpa_supplicant1.service \xe2\x86\x92 wpa_supplicant.service
[   45.877546] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/smartd.service \xe2\x86\x92 smartmontools.service
[   45.877563] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/sshd.service \xe2\x86\x92 ssh.service
[   45.877586] systemd[1]: unit_file_build_name_map: alias: /etc/systemd/system/syslog.service \xe2\x86\x92 rsyslog.service
[   45.877595] systemd[1]: unit_file_build_name_map: linked unit file: /etc/systemd/system/live-tools.service \xe2\x86\x92 /dev/null
[   45.877611] systemd[1]: unit_file_build_name_map: normal unit file: /run/systemd/generator/dev-disk-by\x2duuid-63cfb962\x2d43f6\x2d416b\x2d8f7d\x2ddcb57f471473.swap
[   45.877615] systemd[1]: unit_file_build_name_map: normal unit file: /run/systemd/generator/boot-efi.mount
[   45.877625] systemd[1]: unit_file_build_name_map: normal unit file: /run/systemd/generator/-.mount
[   45.877698] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpcbind.socket
[   45.877705] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/hwclock.service \xe2\x86\x92 /dev/null
[   45.877709] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysstat-collect.timer
[   45.877714] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/machine.slice
[   45.877716] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-sysext.service
[   45.877719] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-networkd-wait-online.service
[   45.877722] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-cleanup.service
[   45.877725] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-modules-load.service
[   45.877728] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/hibernate.target
[   45.877731] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald-dev-log.socket
[   45.877734] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-pstore.service
[   45.877737] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-udevd-control.socket
[   45.877740] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/powertop.service
[   45.877743] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-ask-password-console.path
[   45.877746] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald-audit.socket
[   45.877753] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-cryptsetup.target
[   45.877755] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-networkd.service
[   45.877758] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/anacron.timer
[   45.877761] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald.socket
[   45.877763] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/uuidd.socket
[   45.877777] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/printer.target
[   45.877780] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-volatile-root.service
[   45.877782] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/nss-lookup.target
[   45.877785] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/alsa-restore.service
[   45.877803] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/default.target \xe2\x86\x92 graphical.target
[   45.877806] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/kexec.target
[   45.877809] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/nss-user-lookup.target
[   45.877811] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/exim4-base.timer
[   45.877820] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/rcS.service \xe2\x86\x92 /dev/null
[   45.877823] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journald@.service
[   45.877825] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-fs.target
[   45.877834] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/cryptdisks.service \xe2\x86\x92 /dev/null
[   45.877837] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-suspend-then-hibernate.service
[   45.877840] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/suspend.target
[   45.877843] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-reboot.service
[   45.877846] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-parse-etc.service
[   45.877848] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpcbind.service
[   45.877851] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-resolved.service
[   45.877854] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/apt-daily.service
[   45.877861] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rsync.service
[   45.877864] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sys-fs-fuse-connections.mount
[   45.877867] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/time-sync.target
[   45.877869] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-timedated.service
[   45.877872] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/apt-daily-upgrade.timer
[   45.877875] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-boot-system-token.service
[   45.877878] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sleep.target
[   45.877880] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/local-fs-pre.target
[   45.877884] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-setup.service
[   45.877887] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysinit.target
[   45.877890] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/modprobe@.service
[   45.877892] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub@.service
[   45.877895] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-networkd.socket
[   45.877897] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/mdcheck_start.timer
[   45.877900] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/bluetooth.target
[   45.877908] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/x11-common.service \xe2\x86\x92 /dev/null
[   45.877911] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/mdadm-grow-continue@.service
[   45.877914] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-sysusers.service
[   45.877917] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/acpid.socket
[   45.877919] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysstat.service
[   45.877938] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/autovt@.service \xe2\x86\x92 getty@.service
[   45.877955] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/dbus-org.freedesktop.hostname1.service \xe2\x86\x92 systemd-hostnamed.service
[   45.877959] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/timers.target
[   45.877961] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/anacron.service
[   45.877984] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sound.target
[   45.877987] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-time-wait-sync.service
[   45.877990] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-root-device.target
[   45.878007] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/dbus-org.freedesktop.locale1.service \xe2\x86\x92 systemd-localed.service
[   45.878010] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub_all.service
[   45.878013] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rescue-ssh.target
[   45.878016] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd.target
[   45.878018] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-exit.service
[   45.878021] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub_all.timer
[   45.878024] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-fs.target
[   45.878026] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/cron.service
[   45.878029] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/nfs-idmapd.service
[   45.878032] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-ask-password-wall.path
[   45.878035] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-setup-dev.service
[   45.878037] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-clean.service
[   45.878040] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-hibernate.service
[   45.878043] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/console-setup.service
[   45.878046] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/system-update.target
[   45.878048] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/emergency.service
[   45.878051] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/halt.target
[   45.878054] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/lvm2-lvmpolld.socket
[   45.878062] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/lvm2.service \xe2\x86\x92 /dev/null
[   45.878078] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/runlevel5.target \xe2\x86\x92 graphical.target
[   45.878081] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/getty-pre.target
[   45.878097] systemd[1]: unit_file_build_name_map: linked unit file: /lib/systemd/system/alsa-utils.service \xe2\x86\x92 /dev/null
[   45.878100] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-update-utmp-runlevel.service
[   45.878102] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/user-runtime-dir@.service
[   45.878105] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/run-qemu.mount
[   45.878107] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/boot-complete.target
[   45.878111] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/ssh@.service
[   45.878113] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-tmpfiles-clean.timer
[   45.878116] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/shutdown.target
[   45.878119] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-binfmt.service
[   45.878121] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-switch-root.service
[   45.878137] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/ctrl-alt-del.target \xe2\x86\x92 reboot.target
[   45.878140] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sys-kernel-tracing.mount
[   45.878143] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/basic.target
[   45.878146] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-machine-id-commit.service
[   45.878149] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/auth-rpcgss-module.service
[   45.878152] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-timesyncd.service
[   45.878155] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/dbus.socket
[   45.878158] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/sysstat-summary.timer
[   45.878173] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/dbus-org.freedesktop.timedate1.service \xe2\x86\x92 systemd-timedated.service
[   45.878176] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpc-statd-notify.service
[   45.878180] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/getty.target
[   45.878182] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-suspend.service
[   45.878195] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/kmod.service \xe2\x86\x92 systemd-modules-load.service
[   45.878198] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-journal-flush.service
[   45.878201] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-initctl.service
[   45.878203] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-veritysetup.target
[   45.878206] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/remote-fs-pre.target
[   45.878210] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/ssh.socket
[   45.878212] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/veritysetup.target
[   45.878215] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/lvm2-lvmpolld.service
[   45.878218] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-remount-fs.service
[   45.878221] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/swap.target
[   45.878223] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rpc-statd.service
[   45.878226] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-rfkill.socket
[   45.878229] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-user-sessions.service
[   45.878233] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-switch-root.target
[   45.878236] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-rfkill.service
[   45.878239] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/rc-local.service
[   45.878242] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/man-db.service
[   45.878244] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/ifupdown-pre.service
[   45.878247] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/logrotate.service
[   45.878249] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/systemd-fsckd.socket
[   45.878267] systemd[1]: unit_file_build_name_map: alias: /lib/systemd/system/runlevel3.target \xe2\x86\x92 multi-user.target
[   45.878270] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/e2scrub_reap.service
[   45.878272] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/initrd-root-fs.target
[   45.878276] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/run-rpc_pipefs.mount
[   45.878279] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/veritysetup-pre.target
[   45.878282] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/uuidd.service
[   45.878285] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/network-online.target
[   45.878287] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/blockdev@.target
[   45.878290] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/bluetooth.service
[   45.878293] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/lm-sensors.service
[   45.878296] systemd[1]: unit_file_build_name_map: normal unit file: /lib/systemd/system/local-fs.target
[   45.928982] EXT4-fs (nvme0n1p2): re-mounted. Opts: errors=remount-ro. Quota mode: none.
[   45.930221] systemd-journald[404]: SELinux enabled state cached to: disabled
[   45.930237] systemd-journald[404]: Auditing in kernel turned off.
[   45.931183] systemd-journald[404]: Journal effective settings seal=no keyed_hash=yes compress=yes compress_threshold_bytes=512B
[   45.931205] systemd-journald[404]: Fixed min_use=16.0M max_use=156.1M max_size=19.5M min_size=512.0K keep_free=78.0M n_max_files=100
[   45.931218] systemd-journald[404]: Reserving 333 entries in field hash table.
[   45.932396] systemd-journald[404]: Reserving 35534 entries in data hash table.
[   45.932539] systemd-journald[404]: Vacuuming...
[   45.932545] systemd-journald[404]: Vacuuming done, freed 0B of archived journals from /run/log/journal/3aa984411adf418abc91217f7a356b70.
[   45.932551] systemd-journald[404]: Flushing /dev/kmsg...
[   45.953740] systemd-journald[404]: systemd-journald running as PID 404 for the system.
[   45.953809] systemd-journald[404]: Sent READY=1 notification.
[   45.953814] systemd-journald[404]: Sent WATCHDOG=1 notification.
[   45.954010] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.954121] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.954224] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.954321] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.954415] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.954512] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.954693] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.954785] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.954950] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.955040] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.955128] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.955210] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.955310] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.955374] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.955436] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.955500] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.955579] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.955847] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.956098] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.956180] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.956261] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.956317] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   45.956897] systemd-journald[404]: varlink: New incoming connection.
[   45.956906] systemd-journald[404]: varlink-22: Setting state idle-server
[   45.956923] systemd-journald[404]: varlink-22: New incoming message: {"method":"io.systemd.Journal.FlushToVar","parameters":{}}
[   45.956934] systemd-journald[404]: varlink-22: Changing state idle-server \xe2\x86\x92 processing-method
[   45.956937] systemd-journald[404]: Received client request to flush runtime journal.
[   45.957338] systemd-journald[404]: Journal effective settings seal=yes keyed_hash=yes compress=yes compress_threshold_bytes=512B
[   45.957852] systemd-journald[404]: Fixed min_use=16.0M max_use=4.0G max_size=128.0M min_size=512.0K keep_free=4.0G n_max_files=100
[   45.961582] systemd-journald[404]: Flushing to /var/log/journal/3aa984411adf418abc91217f7a356b70...
[   45.961588] systemd-journald[404]: Considering root directory '/run/log/journal'.
[   45.961595] systemd-journald[404]: Root directory /run/log/journal added.
[   45.961599] systemd-journald[404]: Considering directory '/run/log/journal/3aa984411adf418abc91217f7a356b70'.
[   45.961606] systemd-journald[404]: Directory /run/log/journal/3aa984411adf418abc91217f7a356b70 added.
[   45.961613] systemd-journald[404]: Journal effective settings seal=no keyed_hash=yes compress=no compress_threshold_bytes=8B
[   45.961623] systemd-journald[404]: File /run/log/journal/3aa984411adf418abc91217f7a356b70/system.journal added.
[   45.961627] systemd-journald[404]: Considering root directory '/var/log/journal'.
[   45.961629] systemd-journald[404]: Considering root directory '/var/log/journal/remote'.
[   46.091899] systemd-journald[404]: Root directory /run/log/journal removed.
[   46.091915] systemd-journald[404]: Directory /run/log/journal/3aa984411adf418abc91217f7a356b70 removed.
[   46.091922] systemd-journald[404]: mmap cache statistics: 82931 context cache hit, 3 window list hit, 1 miss
[   46.091942] systemd-journald[404]: Journal effective settings seal=no keyed_hash=yes compress=yes compress_threshold_bytes=512B
[   46.092109] systemd-journald[404]: Vacuuming...
[   46.101803] systemd-journald[404]: Vacuuming done, freed 0B of archived journals from /var/log/journal/3aa984411adf418abc91217f7a356b70.
[   46.107208] systemd-journald[404]: varlink-22: Sending message: {"parameters":{}}
[   46.107222] systemd-journald[404]: varlink-22: Changing state processing-method \xe2\x86\x92 processed-method
[   46.107228] systemd-journald[404]: varlink-22: Changing state processed-method \xe2\x86\x92 idle-server
[   46.108321] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.110591] systemd-journald[404]: varlink-22: Got POLLHUP from socket.
[   46.110607] systemd-journald[404]: varlink-22: Changing state idle-server \xe2\x86\x92 pending-disconnect
[   46.110615] systemd-journald[404]: varlink-22: Changing state pending-disconnect \xe2\x86\x92 processing-disconnect
[   46.110621] systemd-journald[404]: varlink-22: Changing state processing-disconnect \xe2\x86\x92 disconnected
[   46.231099] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.231819] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.254343] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.255175] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.255954] Adding 999420k swap on /dev/nvme0n1p3.  Priority:-2 extents:1 across:999420k SSFS
[   46.272747] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.274009] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.276384] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.282223] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.287142] audit: type=1400 audit(1642261956.908:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=475 comm="apparmor_parser"
[   46.287576] audit: type=1400 audit(1642261956.908:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=476 comm="apparmor_parser"
[   46.287581] audit: type=1400 audit(1642261956.908:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=476 comm="apparmor_parser"
[   46.287796] audit: type=1400 audit(1642261956.908:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=477 comm="apparmor_parser"
[   46.287801] audit: type=1400 audit(1642261956.908:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=477 comm="apparmor_parser"
[   46.287806] audit: type=1400 audit(1642261956.908:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=477 comm="apparmor_parser"
[   46.308395] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.333371] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.336953] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.339263] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.347727] systemd-journald[404]: Compressed data object 923 -> 343 using ZSTD
[   46.348006] systemd-journald[404]: Compressed data object 923 -> 341 using ZSTD
[   46.348160] systemd-journald[404]: Compressed data object 941 -> 357 using ZSTD
[   46.348266] systemd-journald[404]: Compressed data object 912 -> 332 using ZSTD
[   46.348299] systemd-journald[404]: Compressed data object 923 -> 341 using ZSTD
[   46.348476] systemd-journald[404]: Compressed data object 941 -> 357 using ZSTD
[   46.348512] systemd-journald[404]: Compressed data object 920 -> 336 using ZSTD
[   46.349000] systemd-journald[404]: Compressed data object 923 -> 341 using ZSTD
[   46.349247] systemd-journald[404]: Compressed data object 941 -> 357 using ZSTD
[   46.349537] systemd-journald[404]: Compressed data object 923 -> 341 using ZSTD
[   46.350391] systemd-journald[404]: Compressed data object 923 -> 341 using ZSTD
[   46.350476] systemd-journald[404]: Compressed data object 941 -> 357 using ZSTD
[   46.350664] systemd-journald[404]: Compressed data object 941 -> 357 using ZSTD
[   46.351422] systemd-journald[404]: Compressed data object 923 -> 341 using ZSTD
[   46.351612] systemd-journald[404]: Compressed data object 941 -> 357 using ZSTD
[   46.352289] systemd-journald[404]: Compressed data object 923 -> 341 using ZSTD
[   46.352401] systemd-journald[404]: Compressed data object 941 -> 357 using ZSTD
[   46.352915] systemd-journald[404]: Compressed data object 941 -> 357 using ZSTD
[   46.388914] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.428272] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.429010] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.429962] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.430232] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.432467] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.433119] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.434426] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.435058] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.436454] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.437075] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.441421] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.445759] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   46.461538] systemd-journald[404]: Successfully sent stream file descriptor to service manager.
[   49.699069] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   49.699144] usb usb4-port4: config error
[   49.829802] igc 0000:59:00.0 enp89s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   49.831067] IPv6: ADDRCONF(NETDEV_CHANGE): enp89s0: link becomes ready
[   53.771065] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[   53.771285] usb usb4-port4: config error

And then also continues with those last two lines.

However, when I then do:

$ echo enable > /sys/bus/pci/devices/0000:00:14.0/dbc

The target says:

[  346.969915] xhci_hcd 0000:00:14.0: DbC connected
[  347.050045] usb usb4-port4: config error
[  347.441899] xhci_hcd 0000:00:14.0: DbC configured

And the host then says:

[1532683.766689] usb 2-3: new SuperSpeed USB device number 4 using xhci_hcd
[1532683.790996] usb 2-3: LPM exit latency is zeroed, disabling LPM.
[1532683.791377] usb 2-3: New USB device found, idVendor=1d6b, idProduct=0010, bcdDevice= 0.10
[1532683.791393] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[1532683.791400] usb 2-3: Product: Linux USB Debug Target
[1532683.791406] usb 2-3: Manufacturer: Linux Foundation
[1532683.791411] usb 2-3: SerialNumber: 0001
[1532683.853841] usbcore: registered new interface driver usbserial_generic
[1532683.853857] usbserial: USB Serial support registered for generic
[1532683.854961] usbcore: registered new interface driver usb_debug
[1532683.854973] usbserial: USB Serial support registered for debug
[1532683.854984] usbserial: USB Serial support registered for xhci_dbc
[1532683.855002] usb_debug 2-3:1.0: xhci_dbc converter detected
[1532683.855085] usb 2-3: xhci_dbc converter now attached to ttyUSB0

And then I can write into /dev/ttyDBC0 on the target and read from
/dev/ttyUSB0 on the host just fine...


So the whole thing *can* work, but for some reason, earlyprintk=xdbc
refuses service.. and I really need me a console :/
