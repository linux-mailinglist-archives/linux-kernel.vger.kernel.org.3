Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5454EC563
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345820AbiC3NVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbiC3NVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:21:46 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FED3A5E3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:19:57 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1nZYEr-0004MQ-Ok; Wed, 30 Mar 2022 23:19:54 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eWSzGw32XdvpZHiZ7VoXWcNdZJtehlkAEcSX5xFx1Dk=; b=SuLY5mTTvehY9UHhpqiqNd92eM
        p8ILhr2PJHp/z3HJKBGM06x0NIiaXkoav7QL0COf4jI57rFvcvvJ9dz/c8Ue4DpzTHHgha7fD+d49
        WCl1FhPpQPSZQBrn5Oz5dR0PBFZWIHfgFGlzzE2JLa6C9phIEw0lN++cF0gX3ghsCge0=;
Message-ID: <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
Date:   Wed, 30 Mar 2022 21:19:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <acbb3a86-ea15-47ec-90fa-72fbd94921b1@fnarfbargle.com>
 <YkLt+/kJ54fwCYgy@lahna>
 <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
 <YkMC4XnfIZix6kBn@lahna>
 <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
 <YkQuk7E8AbSEiw59@lahna>
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YkQuk7E8AbSEiw59@lahna>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mika,

On 30/3/22 18:18, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Mar 29, 2022 at 10:06:35PM +0800, Brad Campbell wrote:
>>> Indeed, I did not add this to the "discovery" path yet.
>>>
>>> I wonder what happens if you change this:
>>>
>>> +       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
>>> +                                   first ? 0 : 1);
>>>
>>> to this in your tree:
>>>
>>> +       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
>>> +                                   first ? 1 : 0);
>>>
>>
>> Here's where it gets all "Apple..y". On the iMac this does the job no matter which
>> port the chain is plugged into. Boots and displays correctly first time, every time.
>>
>> It turns out on the laptop, one port works and the other doesn't. Changing the order
>> simply changes which port works. So I assume the EFI sets up the first display using
>> the first lane if it's in the first port, and the second if it's in the second.
>>
>> That means had I managed to perform the first test in the "other port" consistently,
>> it would have worked there also.
> 
> Can you try the below patch too? I hard-code the lane based on the
> DP adapter number in TBT gen1.
> 
> Let's first figure out proper solution to this issue and then look at
> the other one.
> 
> diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> index a473cc7d9a8d..97d36a7bb527 100644
> --- a/drivers/thunderbolt/tunnel.c
> +++ b/drivers/thunderbolt/tunnel.c
> @@ -865,6 +865,7 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,

This one works from cold boot on both machines regardless of the port the chain is plugged into.
It fails on both machines on any hotplug with the symptoms of allocating them both the same link.
I added an extra debug into tunnel.c and verified that.


        path = tb_path_alloc(tb, in, TB_DP_VIDEO_HOPID, out, TB_DP_VIDEO_HOPID,
-                            1, "Video");
+                            link_nr, "Video");
        if (!path)
                goto err_free;
+       tb_dbg(tb, "Tunnel link %i\n", link_nr);
        tb_dp_init_video_path(path);
        paths[TB_DP_VIDEO_PATH_OUT] = path;
 
        path = tb_path_alloc(tb, in, TB_DP_AUX_TX_HOPID, out,
-                            TB_DP_AUX_TX_HOPID, 1, "AUX TX");
+                            TB_DP_AUX_TX_HOPID, link_nr, "AUX TX");


This dmesg was the laptop booted with the chain plugged in, then unplugged and re-plugged. You can see both get allocated Link 0.

[    0.000000] Linux version 5.17.0+ (brad@bklaptop) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #39 SMP PREEMPT_DYNAMIC Wed Mar 30 21:09:15 AWST 2022
[    0.000000] Command line: ro root=UUID=c500d66c-50ec-42a2-a333-eb48d6c9d97b thunderbolt.dyndbg initrd=boot\initrd.img-5.17.0+
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008ad0ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ad10000-0x000000008ad52fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000008ad53000-0x000000008ad61fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ad62000-0x000000008ad8efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000008ad8f000-0x000000008ae38fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ae39000-0x000000008ae8efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008ae8f000-0x000000008aed1fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008aed2000-0x000000008aefefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008aeff000-0x000000008af83fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008af84000-0x000000008afeffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008aff0000-0x000000008affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000008b000000-0x000000008f9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffe10000-0x00000000ffe3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000046f5fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x73d4b190-0x73d5b1cf] usable ==> usable
[    0.000000] e820: update [mem 0x73d4b190-0x73d5b1cf] usable ==> usable
[    0.000000] e820: update [mem 0x73d6e190-0x73d6ed98] usable ==> usable
[    0.000000] e820: update [mem 0x73d6e190-0x73d6ed98] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000008efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000073d4b18f] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d4b190-0x0000000073d5b1cf] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d5b1d0-0x0000000073d6e18f] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d6e190-0x0000000073d6ed98] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d6ed99-0x000000008ad0ffff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ad10000-0x000000008ad52fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000008ad53000-0x000000008ad61fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ad62000-0x000000008ad8efff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000008ad8f000-0x000000008ae38fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ae39000-0x000000008ae8efff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008ae8f000-0x000000008aed1fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008aed2000-0x000000008aefefff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008aeff000-0x000000008af83fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008af84000-0x000000008afeffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008aff0000-0x000000008affffff] usable
[    0.000000] reserve setup_data: [mem 0x000000008b000000-0x000000008f9fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ffe10000-0x00000000ffe3ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000046f5fffff] usable
[    0.000000] efi: EFI v1.10 by Apple
[    0.000000] efi: ACPI=0x8ad8e000 ACPI 2.0=0x8ad8e014 SMBIOS=0x8ad11000 
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Apple Inc. MacBookPro11,1/Mac-189A3D4F975D5FFC, BIOS 432.60.3.0.0 10/27/2021
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2600.046 MHz processor
[    0.000117] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000120] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000128] last_pfn = 0x46f600 max_arch_pfn = 0x400000000
[    0.000215] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001098] last_pfn = 0x8b000 max_arch_pfn = 0x400000000
[    0.001144] Using GB pages for direct mapping
[    0.002175] Secure boot disabled
[    0.002176] RAMDISK: [mem 0x7076d000-0x70e8ffff]
[    0.002179] ACPI: Early table checksum verification disabled
[    0.002181] ACPI: RSDP 0x000000008AD8E014 000024 (v02 APPLE )
[    0.002186] ACPI: XSDT 0x000000008AD8E1C0 0000A4 (v01 APPLE  Apple00  00000000      01000013)
[    0.002190] ACPI: FACP 0x000000008AD8C000 0000F4 (v05 APPLE  Apple00  00000000 Loki 0000005F)
[    0.002196] ACPI: DSDT 0x000000008AD7F000 007681 (v03 APPLE  MacBookP 00110001 INTL 20100915)
[    0.002199] ACPI: FACS 0x000000008AD18000 000040
[    0.002202] ACPI: FACS 0x000000008AD18000 000040
[    0.002204] ACPI: HPET 0x000000008AD8B000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002207] ACPI: APIC 0x000000008AD8A000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002210] ACPI: SBST 0x000000008AD88000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002213] ACPI: ECDT 0x000000008AD87000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002216] ACPI: SSDT 0x000000008AD7E000 00010B (v01 APPLE  SataAhci 00001000 INTL 20100915)
[    0.002219] ACPI: SSDT 0x000000008AD7D000 000024 (v01 APPLE  SmcDppt  00001000 INTL 20100915)
[    0.002222] ACPI: SSDT 0x000000008AD7A000 000FE9 (v01 APPLE  SDUsbLpt 00001000 INTL 20100915)
[    0.002225] ACPI: SSDT 0x000000008AD76000 000032 (v01 APPLE  SsdtS3   00001000 INTL 20100915)
[    0.002228] ACPI: SSDT 0x000000008AD73000 0028B2 (v01 APPLE  PcieTbt  00001000 INTL 20100915)
[    0.002231] ACPI: SSDT 0x000000008AD66000 0000B8 (v01 APPLE  Sdxc     00001000 INTL 20100915)
[    0.002234] ACPI: SSDT 0x000000008AD65000 0003E0 (v01 APPLE  SaHdaCdc 00001000 INTL 20100915)
[    0.002237] ACPI: SSDT 0x000000008AD64000 000594 (v01 PmRef  Cpu0Ist  00003000 INTL 20100915)
[    0.002240] ACPI: SSDT 0x000000008AD63000 000B83 (v01 PmRef  CpuPm    00003000 INTL 20100915)
[    0.002243] ACPI: DMAR 0x000000008AD62000 000088 (v01 APPLE  HSW      00000001 AAPL 00000001)
[    0.002246] ACPI: MCFG 0x000000008AD89000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002249] ACPI: Reserving FACP table memory at [mem 0x8ad8c000-0x8ad8c0f3]
[    0.002251] ACPI: Reserving DSDT table memory at [mem 0x8ad7f000-0x8ad86680]
[    0.002252] ACPI: Reserving FACS table memory at [mem 0x8ad18000-0x8ad1803f]
[    0.002253] ACPI: Reserving FACS table memory at [mem 0x8ad18000-0x8ad1803f]
[    0.002254] ACPI: Reserving HPET table memory at [mem 0x8ad8b000-0x8ad8b037]
[    0.002256] ACPI: Reserving APIC table memory at [mem 0x8ad8a000-0x8ad8a0bb]
[    0.002257] ACPI: Reserving SBST table memory at [mem 0x8ad88000-0x8ad8802f]
[    0.002258] ACPI: Reserving ECDT table memory at [mem 0x8ad87000-0x8ad87052]
[    0.002259] ACPI: Reserving SSDT table memory at [mem 0x8ad7e000-0x8ad7e10a]
[    0.002260] ACPI: Reserving SSDT table memory at [mem 0x8ad7d000-0x8ad7d023]
[    0.002262] ACPI: Reserving SSDT table memory at [mem 0x8ad7a000-0x8ad7afe8]
[    0.002263] ACPI: Reserving SSDT table memory at [mem 0x8ad76000-0x8ad76031]
[    0.002264] ACPI: Reserving SSDT table memory at [mem 0x8ad73000-0x8ad758b1]
[    0.002265] ACPI: Reserving SSDT table memory at [mem 0x8ad66000-0x8ad660b7]
[    0.002266] ACPI: Reserving SSDT table memory at [mem 0x8ad65000-0x8ad653df]
[    0.002267] ACPI: Reserving SSDT table memory at [mem 0x8ad64000-0x8ad64593]
[    0.002268] ACPI: Reserving SSDT table memory at [mem 0x8ad63000-0x8ad63b82]
[    0.002270] ACPI: Reserving DMAR table memory at [mem 0x8ad62000-0x8ad62087]
[    0.002271] ACPI: Reserving MCFG table memory at [mem 0x8ad89000-0x8ad8903b]
[    0.002277] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.002298] Zone ranges:
[    0.002299]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002301]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002303]   Normal   [mem 0x0000000100000000-0x000000046f5fffff]
[    0.002305] Movable zone start for each node
[    0.002306] Early memory node ranges
[    0.002307]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.002309]   node   0: [mem 0x0000000000059000-0x000000000008efff]
[    0.002310]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.002311]   node   0: [mem 0x0000000000100000-0x000000008ad0ffff]
[    0.002313]   node   0: [mem 0x000000008ad53000-0x000000008ad61fff]
[    0.002314]   node   0: [mem 0x000000008ad8f000-0x000000008ae38fff]
[    0.002315]   node   0: [mem 0x000000008ae8f000-0x000000008aed1fff]
[    0.002316]   node   0: [mem 0x000000008aeff000-0x000000008af83fff]
[    0.002317]   node   0: [mem 0x000000008aff0000-0x000000008affffff]
[    0.002318]   node   0: [mem 0x0000000100000000-0x000000046f5fffff]
[    0.002321] Initmem setup node 0 [mem 0x0000000000001000-0x000000046f5fffff]
[    0.002325] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002327] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002328] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002353] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.006105] On node 0, zone DMA32: 67 pages in unavailable ranges
[    0.006111] On node 0, zone DMA32: 45 pages in unavailable ranges
[    0.006113] On node 0, zone DMA32: 86 pages in unavailable ranges
[    0.006116] On node 0, zone DMA32: 45 pages in unavailable ranges
[    0.006118] On node 0, zone DMA32: 108 pages in unavailable ranges
[    0.030194] On node 0, zone Normal: 20480 pages in unavailable ranges
[    0.030224] On node 0, zone Normal: 2560 pages in unavailable ranges
[    0.030232] Reserving Intel graphics memory at [mem 0x8ba00000-0x8f9fffff]
[    0.030351] ACPI: PM-Timer IO Port: 0x1808
[    0.030358] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.030360] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.030361] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.030362] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.030363] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.030364] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.030365] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.030366] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.030376] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-39
[    0.030379] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.030381] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.030385] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.030386] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.030390] TSC deadline timer available
[    0.030391] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.030412] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.030415] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.030417] PM: hibernation: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.030419] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
[    0.030420] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.030422] PM: hibernation: Registered nosave memory: [mem 0x73d4b000-0x73d4bfff]
[    0.030424] PM: hibernation: Registered nosave memory: [mem 0x73d5b000-0x73d5bfff]
[    0.030426] PM: hibernation: Registered nosave memory: [mem 0x73d6e000-0x73d6efff]
[    0.030428] PM: hibernation: Registered nosave memory: [mem 0x73d6e000-0x73d6efff]
[    0.030431] PM: hibernation: Registered nosave memory: [mem 0x8ad10000-0x8ad52fff]
[    0.030433] PM: hibernation: Registered nosave memory: [mem 0x8ad62000-0x8ad8efff]
[    0.030435] PM: hibernation: Registered nosave memory: [mem 0x8ae39000-0x8ae8efff]
[    0.030437] PM: hibernation: Registered nosave memory: [mem 0x8aed2000-0x8aefefff]
[    0.030439] PM: hibernation: Registered nosave memory: [mem 0x8af84000-0x8afeffff]
[    0.030441] PM: hibernation: Registered nosave memory: [mem 0x8b000000-0x8f9fffff]
[    0.030442] PM: hibernation: Registered nosave memory: [mem 0x8fa00000-0xe00f7fff]
[    0.030443] PM: hibernation: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.030444] PM: hibernation: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff]
[    0.030445] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.030446] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xffe0ffff]
[    0.030447] PM: hibernation: Registered nosave memory: [mem 0xffe10000-0xffe3ffff]
[    0.030448] PM: hibernation: Registered nosave memory: [mem 0xffe40000-0xffffffff]
[    0.030450] [mem 0x8fa00000-0xe00f7fff] available for PCI devices
[    0.030455] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.030461] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.030642] percpu: Embedded 52 pages/cpu s173096 r8192 d31704 u524288
[    0.030650] pcpu-alloc: s173096 r8192 d31704 u524288 alloc=1*2097152
[    0.030653] pcpu-alloc: [0] 0 1 2 3 
[    0.030675] Built 1 zonelists, mobility grouping on.  Total pages: 4105486
[    0.030677] Kernel command line: ro root=UUID=c500d66c-50ec-42a2-a333-eb48d6c9d97b thunderbolt.dyndbg initrd=boot\initrd.img-5.17.0+
[    0.031542] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.031960] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.032000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.080020] Memory: 15923596K/16683256K available (10248K kernel code, 2251K rwdata, 2740K rodata, 996K init, 740K bss, 759400K reserved, 0K cma-reserved)
[    0.080052] random: get_random_u64 called from cache_random_seq_create+0x63/0x150 with crng_init=0
[    0.080120] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.080755] Dynamic Preempt: voluntary
[    0.080781] rcu: Preemptible hierarchical RCU implementation.
[    0.080783] 	Trampoline variant of Tasks RCU enabled.
[    0.080784] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.081752] NR_IRQS: 4352, nr_irqs: 728, preallocated irqs: 16
[    0.081975] Console: colour dummy device 80x25
[    0.082304] printk: console [tty0] enabled
[    0.082312] ACPI: Core revision 20211217
[    0.082411] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.082414] APIC: Switch to symmetric I/O mode setup
[    0.082417] DMAR: Host address width 39
[    0.082419] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.082425] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020660462 ecap f0101a
[    0.082430] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.082435] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008020660462 ecap f010da
[    0.082439] DMAR: RMRR base: 0x0000008b800000 end: 0x0000008f9fffff
[    0.082443] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.082446] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.083038] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.083525] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x257a67bf1a9, max_idle_ns: 440795300317 ns
[    0.083534] Calibrating delay loop (skipped), value calculated using timer frequency.. 5200.09 BogoMIPS (lpj=26000460)
[    0.083540] pid_max: default: 32768 minimum: 301
[    0.093531] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.093531] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.093531] CPU0: Thermal monitoring enabled (TM1)
[    0.093531] process: using mwait in idle threads
[    0.093531] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.093531] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.093531] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.093531] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.093531] Spectre V2 : Vulnerable
[    0.093531] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.093531] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.093531] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.093531] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.093531] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.093531] SRBDS: Mitigation: Microcode
[    0.093531] MDS: Mitigation: Clear CPU buffers
[    0.093531] Freeing SMP alternatives memory: 28K
[    0.093531] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1220
[    0.093531] smpboot: CPU0: Intel(R) Core(TM) i5-4278U CPU @ 2.60GHz (family: 0x6, model: 0x45, stepping: 0x1)
[    0.093531] cblist_init_generic: Setting adjustable number of callback queues.
[    0.093531] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.093531] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.093531] ... version:                3
[    0.093531] ... bit width:              48
[    0.093531] ... generic registers:      4
[    0.093531] ... value mask:             0000ffffffffffff
[    0.093531] ... max period:             00007fffffffffff
[    0.093531] ... fixed-purpose events:   3
[    0.093531] ... event mask:             000000070000000f
[    0.093531] rcu: Hierarchical SRCU implementation.
[    0.093531] smp: Bringing up secondary CPUs ...
[    0.093531] x86: Booting SMP configuration:
[    0.093531] .... node  #0, CPUs:      #1 #2
[    0.093531] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.093531]  #3
[    0.093531] smp: Brought up 1 node, 4 CPUs
[    0.093531] smpboot: Max logical packages: 1
[    0.093531] smpboot: Total of 4 processors activated (20800.36 BogoMIPS)
[    0.093531] devtmpfs: initialized
[    0.093531] ACPI: PM: Registering ACPI NVS region [mem 0x8ad10000-0x8ad52fff] (274432 bytes)
[    0.093531] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.093531] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.093531] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.093531] thermal_sys: Registered thermal governor 'step_wise'
[    0.093531] thermal_sys: Registered thermal governor 'user_space'
[    0.093531] cpuidle: using governor ladder
[    0.093531] cpuidle: using governor menu
[    0.093531] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.093531] PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem 0xe0000000-0xe9bfffff] (base 0xe0000000)
[    0.093531] PCI: not using MMCONFIG
[    0.093531] PCI: Using configuration type 1 for base access
[    0.093531] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.093531] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.093531] cryptd: max_cpu_qlen set to 1000
[    0.093531] ACPI: Disabled all _OSI OS vendors
[    0.093531] ACPI: Added _OSI(Module Device)
[    0.093531] ACPI: Added _OSI(Processor Device)
[    0.093531] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.093531] ACPI: Added _OSI(Processor Aggregator Device)
[    0.093531] ACPI: Added _OSI(Linux-Dell-Video)
[    0.093531] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.093531] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.093531] ACPI: Added _OSI(Darwin)
[    0.095337] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.095705] ACPI: EC: EC started
[    0.095707] ACPI: EC: interrupt blocked
[    0.096787] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.096790] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.096973] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.097288] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.097324] ACPI Error: Needed type [Reference], found [Integer] 0000000011c38b8b (20211217/exresop-69)
[    0.097324] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20211217/dswexec-434)
[    0.097324] ACPI Error: Aborting method \_PR.CPU0._PDC due to previous error (AE_AML_OPERAND_TYPE) (20211217/psparse-531)
[    0.097324] ACPI: Dynamic OEM Table Load:
[    0.097324] ACPI: SSDT 0xFFFF9F8AC0AF7800 00067C (v01 PmRef  ApIst    00003000 INTL 20100915)
[    0.097324] ACPI: Dynamic OEM Table Load:
[    0.097324] ACPI: SSDT 0xFFFF9F8AC0C8DC00 000119 (v01 PmRef  ApCst    00003000 INTL 20100915)
[    0.097324] ACPI: Interpreter enabled
[    0.097324] ACPI: PM: (supports S0 S3 S4 S5)
[    0.097324] ACPI: Using IOAPIC for interrupt routing
[    0.097324] PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem 0xe0000000-0xe9bfffff] (base 0xe0000000)
[    0.097324] PCI: MMCONFIG at [mem 0xe0000000-0xe9bfffff] reserved in ACPI motherboard resources
[    0.097324] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.097324] ACPI: Enabled 4 GPEs in block 00 to 7F
[    0.107003] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.107011] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.107016] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-9b] only partially covers this bridge
[    0.107173] PCI host bridge to bus 0000:00
[    0.107176] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.107179] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.107182] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.107185] pci_bus 0000:00: root bus resource [mem 0x8fa00000-0xfeafffff window]
[    0.107188] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.107191] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.107203] pci 0000:00:00.0: [8086:0a04] type 00 class 0x060000
[    0.107280] pci 0000:00:02.0: [8086:0a2e] type 00 class 0x030000
[    0.107289] pci 0000:00:02.0: reg 0x10: [mem 0xb0000000-0xb03fffff 64bit]
[    0.107296] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xafffffff 64bit pref]
[    0.107302] pci 0000:00:02.0: reg 0x20: [io  0x2000-0x203f]
[    0.107313] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.107318] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.107406] pci 0000:00:03.0: [8086:0a0c] type 00 class 0x040300
[    0.107415] pci 0000:00:03.0: reg 0x10: [mem 0xb0c10000-0xb0c13fff 64bit]
[    0.107530] pci 0000:00:14.0: [8086:9c31] type 00 class 0x0c0330
[    0.107546] pci 0000:00:14.0: reg 0x10: [mem 0xb0c00000-0xb0c0ffff 64bit]
[    0.107596] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.107779] pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
[    0.107797] pci 0000:00:16.0: reg 0x10: [mem 0xb0c2a100-0xb0c2a11f 64bit]
[    0.107858] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.107909] pci 0000:00:1b.0: [8086:9c20] type 00 class 0x040300
[    0.107924] pci 0000:00:1b.0: reg 0x10: [mem 0xb0c14000-0xb0c17fff 64bit]
[    0.107985] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.108045] pci 0000:00:1c.0: [8086:9c10] type 01 class 0x060400
[    0.108104] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.108121] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    0.108124] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    0.108214] pci 0000:00:1c.1: [8086:9c12] type 01 class 0x060400
[    0.108281] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.108297] pci 0000:00:1c.1: Enabling MPC IRBNCE
[    0.108300] pci 0000:00:1c.1: Intel PCH root port ACS workaround enabled
[    0.108389] pci 0000:00:1c.2: [8086:9c14] type 01 class 0x060400
[    0.108455] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.108471] pci 0000:00:1c.2: Enabling MPC IRBNCE
[    0.108474] pci 0000:00:1c.2: Intel PCH root port ACS workaround enabled
[    0.108561] pci 0000:00:1c.4: [8086:9c18] type 01 class 0x060400
[    0.108627] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.108643] pci 0000:00:1c.4: Enabling MPC IRBNCE
[    0.108646] pci 0000:00:1c.4: Intel PCH root port ACS workaround enabled
[    0.108740] pci 0000:00:1c.5: [8086:9c1a] type 01 class 0x060400
[    0.108806] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.108822] pci 0000:00:1c.5: Enabling MPC IRBNCE
[    0.108825] pci 0000:00:1c.5: Intel PCH root port ACS workaround enabled
[    0.108918] pci 0000:00:1f.0: [8086:9c43] type 00 class 0x060100
[    0.109067] pci 0000:00:1f.3: [8086:9c22] type 00 class 0x0c0500
[    0.109083] pci 0000:00:1f.3: reg 0x10: [mem 0xb0c2a000-0xb0c2a0ff 64bit]
[    0.109101] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.109184] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.109243] pci 0000:02:00.0: [14e4:1570] type 00 class 0x048000
[    0.109266] pci 0000:02:00.0: reg 0x10: [mem 0xb0b00000-0xb0b0ffff 64bit]
[    0.109282] pci 0000:02:00.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.109298] pci 0000:02:00.0: reg 0x20: [mem 0xb0a00000-0xb0afffff 64bit]
[    0.109392] pci 0000:02:00.0: supports D1
[    0.109394] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.109498] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.109504] pci 0000:00:1c.1:   bridge window [mem 0xb0a00000-0xb0bfffff]
[    0.109509] pci 0000:00:1c.1:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.109568] pci 0000:03:00.0: [14e4:43ba] type 00 class 0x028000
[    0.109591] pci 0000:03:00.0: reg 0x10: [mem 0xb0800000-0xb0807fff 64bit]
[    0.109606] pci 0000:03:00.0: reg 0x18: [mem 0xb0400000-0xb07fffff 64bit]
[    0.109727] pci 0000:03:00.0: supports D1 D2
[    0.109729] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.109872] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.109877] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb08fffff]
[    0.109941] pci 0000:05:00.0: [8086:156d] type 01 class 0x060400
[    0.109995] pci 0000:05:00.0: enabling Extended Tags
[    0.110077] pci 0000:05:00.0: supports D1 D2
[    0.110079] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.133560] pci 0000:00:1c.4: PCI bridge to [bus 05-6b]
[    0.133566] pci 0000:00:1c.4:   bridge window [io  0x3000-0x5fff]
[    0.133570] pci 0000:00:1c.4:   bridge window [mem 0xb0d00000-0xbd1fffff]
[    0.133575] pci 0000:00:1c.4:   bridge window [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.133680] pci 0000:06:00.0: [8086:156d] type 01 class 0x060400
[    0.133738] pci 0000:06:00.0: enabling Extended Tags
[    0.133822] pci 0000:06:00.0: supports D1 D2
[    0.133824] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.133935] pci 0000:06:03.0: [8086:156d] type 01 class 0x060400
[    0.133992] pci 0000:06:03.0: enabling Extended Tags
[    0.134075] pci 0000:06:03.0: supports D1 D2
[    0.134077] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134186] pci 0000:06:04.0: [8086:156d] type 01 class 0x060400
[    0.134236] pci 0000:06:04.0: enabling Extended Tags
[    0.134323] pci 0000:06:04.0: supports D1 D2
[    0.134325] pci 0000:06:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134429] pci 0000:06:05.0: [8086:156d] type 01 class 0x060400
[    0.134478] pci 0000:06:05.0: enabling Extended Tags
[    0.134565] pci 0000:06:05.0: supports D1 D2
[    0.134567] pci 0000:06:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134671] pci 0000:06:06.0: [8086:156d] type 01 class 0x060400
[    0.134720] pci 0000:06:06.0: enabling Extended Tags
[    0.134806] pci 0000:06:06.0: supports D1 D2
[    0.134808] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134918] pci 0000:05:00.0: PCI bridge to [bus 06-6b]
[    0.134925] pci 0000:05:00.0:   bridge window [io  0x3000-0x4fff]
[    0.134930] pci 0000:05:00.0:   bridge window [mem 0xb0d00000-0xb91fffff]
[    0.134938] pci 0000:05:00.0:   bridge window [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.135013] pci 0000:07:00.0: [8086:156c] type 00 class 0x088000
[    0.135037] pci 0000:07:00.0: reg 0x10: [mem 0xb0d00000-0xb0d3ffff]
[    0.135050] pci 0000:07:00.0: reg 0x14: [mem 0xb0d40000-0xb0d40fff]
[    0.135117] pci 0000:07:00.0: enabling Extended Tags
[    0.135227] pci 0000:07:00.0: supports D1 D2
[    0.135230] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.163567] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.163579] pci 0000:06:00.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[    0.163698] pci 0000:08:00.0: [8086:1513] type 01 class 0x060400
[    0.163802] pci 0000:08:00.0: enabling Extended Tags
[    0.163957] pci 0000:08:00.0: supports D1 D2
[    0.163959] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.193568] pci 0000:06:03.0: PCI bridge to [bus 08-38]
[    0.193576] pci 0000:06:03.0:   bridge window [io  0x3000-0x3fff]
[    0.193581] pci 0000:06:03.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[    0.193588] pci 0000:06:03.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.193679] acpiphp: Slot [1] registered
[    0.193703] acpiphp: Slot [2] registered
[    0.193726] acpiphp: Slot [3] registered
[    0.193750] acpiphp: Slot [4] registered
[    0.193773] acpiphp: Slot [5] registered
[    0.193828] pci 0000:09:00.0: [8086:1513] type 01 class 0x060400
[    0.193938] pci 0000:09:00.0: enabling Extended Tags
[    0.194096] pci 0000:09:00.0: supports D1 D2
[    0.194099] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.194271] pci 0000:09:01.0: [8086:1513] type 01 class 0x060400
[    0.194381] pci 0000:09:01.0: enabling Extended Tags
[    0.194539] pci 0000:09:01.0: supports D1 D2
[    0.194541] pci 0000:09:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.194696] pci 0000:09:02.0: [8086:1513] type 01 class 0x060400
[    0.194805] pci 0000:09:02.0: enabling Extended Tags
[    0.194963] pci 0000:09:02.0: supports D1 D2
[    0.194965] pci 0000:09:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.195125] pci 0000:09:04.0: [8086:1513] type 01 class 0x060400
[    0.195235] pci 0000:09:04.0: enabling Extended Tags
[    0.195395] pci 0000:09:04.0: supports D1 D2
[    0.195397] pci 0000:09:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.195571] pci 0000:09:05.0: [8086:1513] type 01 class 0x060400
[    0.195665] pci 0000:09:05.0: enabling Extended Tags
[    0.195826] pci 0000:09:05.0: supports D1 D2
[    0.195828] pci 0000:09:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.196017] pci 0000:08:00.0: PCI bridge to [bus 09-18]
[    0.196034] pci 0000:08:00.0:   bridge window [mem 0xb0e00000-0xb11fffff]
[    0.196046] pci 0000:08:00.0:   bridge window [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.196138] acpiphp: Slot [1-1] registered
[    0.196196] pci 0000:0a:00.0: [12d8:400c] type 01 class 0x060400
[    0.196551] pci 0000:0a:00.0: supports D1 D2
[    0.196553] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.223574] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[    0.223592] pci 0000:09:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.223765] pci 0000:0b:03.0: [12d8:400c] type 01 class 0x060400
[    0.224074] pci 0000:0b:03.0: supports D1 D2
[    0.224076] pci 0000:0b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.224270] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[    0.224293] pci 0000:0a:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.224450] pci 0000:0c:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.224498] pci 0000:0c:00.0: reg 0x10: [mem 0xb1101000-0xb1101fff]
[    0.224786] pci 0000:0c:00.0: supports D1 D2
[    0.224788] pci 0000:0c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.224937] pci 0000:0c:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.224984] pci 0000:0c:00.1: reg 0x10: [mem 0xb1100000-0xb1100fff]
[    0.225272] pci 0000:0c:00.1: supports D1 D2
[    0.225274] pci 0000:0c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.225399] pci 0000:0c:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.225446] pci 0000:0c:00.2: reg 0x10: [mem 0xb1102000-0xb11020ff]
[    0.225733] pci 0000:0c:00.2: supports D1 D2
[    0.225735] pci 0000:0c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.225975] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[    0.225998] pci 0000:0b:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.226161] pci 0000:0d:00.0: [14e4:16b0] type 00 class 0x020000
[    0.226225] pci 0000:0d:00.0: reg 0x10: [mem 0xbd300000-0xbd30ffff 64bit pref]
[    0.226267] pci 0000:0d:00.0: reg 0x18: [mem 0xbd310000-0xbd31ffff 64bit pref]
[    0.226580] pci 0000:0d:00.0: PME# supported from D0 D3hot D3cold
[    0.253589] pci 0000:09:01.0: PCI bridge to [bus 0d]
[    0.253617] pci 0000:09:01.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.253729] pci 0000:0e:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.253793] pci 0000:0e:00.0: reg 0x10: [mem 0xb1000000-0xb1000fff 64bit]
[    0.254117] pci 0000:0e:00.0: supports D1 D2
[    0.254120] pci 0000:0e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.283589] pci 0000:09:02.0: PCI bridge to [bus 0e]
[    0.283607] pci 0000:09:02.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.283781] pci 0000:0f:00.0: [8086:1513] type 01 class 0x060400
[    0.283939] pci 0000:0f:00.0: enabling Extended Tags
[    0.284175] pci 0000:0f:00.0: supports D1 D2
[    0.284177] pci 0000:0f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.313579] pci 0000:09:04.0: PCI bridge to [bus 0f-17]
[    0.313597] pci 0000:09:04.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.313610] pci 0000:09:04.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.313732] acpiphp: Slot [1-2] registered
[    0.313758] acpiphp: Slot [2-1] registered
[    0.313784] acpiphp: Slot [3-1] registered
[    0.313809] acpiphp: Slot [4-1] registered
[    0.313891] pci 0000:10:00.0: [8086:1513] type 01 class 0x060400
[    0.314055] pci 0000:10:00.0: enabling Extended Tags
[    0.314296] pci 0000:10:00.0: supports D1 D2
[    0.314298] pci 0000:10:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.314540] pci 0000:10:01.0: [8086:1513] type 01 class 0x060400
[    0.314705] pci 0000:10:01.0: enabling Extended Tags
[    0.314945] pci 0000:10:01.0: supports D1 D2
[    0.314947] pci 0000:10:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.315170] pci 0000:10:02.0: [8086:1513] type 01 class 0x060400
[    0.315334] pci 0000:10:02.0: enabling Extended Tags
[    0.315574] pci 0000:10:02.0: supports D1 D2
[    0.315576] pci 0000:10:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.315805] pci 0000:10:04.0: [8086:1513] type 01 class 0x060400
[    0.315947] pci 0000:10:04.0: enabling Extended Tags
[    0.316190] pci 0000:10:04.0: supports D1 D2
[    0.316192] pci 0000:10:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.316437] pci 0000:10:05.0: [8086:1513] type 01 class 0x060400
[    0.316578] pci 0000:10:05.0: enabling Extended Tags
[    0.316822] pci 0000:10:05.0: supports D1 D2
[    0.316824] pci 0000:10:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.317094] pci 0000:0f:00.0: PCI bridge to [bus 10-17]
[    0.317120] pci 0000:0f:00.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.317137] pci 0000:0f:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.317255] acpiphp: Slot [1-3] registered
[    0.317333] pci 0000:11:00.0: [12d8:400c] type 01 class 0x060400
[    0.317821] pci 0000:11:00.0: supports D1 D2
[    0.317823] pci 0000:11:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.318105] pci 0000:10:00.0: PCI bridge to [bus 11-13]
[    0.318130] pci 0000:10:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.318364] pci 0000:12:03.0: [12d8:400c] type 01 class 0x060400
[    0.318786] pci 0000:12:03.0: supports D1 D2
[    0.318789] pci 0000:12:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.319045] pci 0000:11:00.0: PCI bridge to [bus 12-13]
[    0.319075] pci 0000:11:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.319287] pci 0000:13:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.319351] pci 0000:13:00.0: reg 0x10: [mem 0xb0f01000-0xb0f01fff]
[    0.319745] pci 0000:13:00.0: supports D1 D2
[    0.319747] pci 0000:13:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.319949] pci 0000:13:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.320013] pci 0000:13:00.1: reg 0x10: [mem 0xb0f00000-0xb0f00fff]
[    0.320406] pci 0000:13:00.1: supports D1 D2
[    0.320408] pci 0000:13:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.320569] pci 0000:13:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.320632] pci 0000:13:00.2: reg 0x10: [mem 0xb0f02000-0xb0f020ff]
[    0.321025] pci 0000:13:00.2: supports D1 D2
[    0.321027] pci 0000:13:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.321362] pci 0000:12:03.0: PCI bridge to [bus 13]
[    0.321393] pci 0000:12:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.321617] pci 0000:14:00.0: [14e4:16b0] type 00 class 0x020000
[    0.321702] pci 0000:14:00.0: reg 0x10: [mem 0xbd200000-0xbd20ffff 64bit pref]
[    0.321759] pci 0000:14:00.0: reg 0x18: [mem 0xbd210000-0xbd21ffff 64bit pref]
[    0.322184] pci 0000:14:00.0: PME# supported from D0 D3hot D3cold
[    0.322500] pci 0000:10:01.0: PCI bridge to [bus 14]
[    0.322540] pci 0000:10:01.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.322696] pci 0000:15:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.322781] pci 0000:15:00.0: reg 0x10: [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.323220] pci 0000:15:00.0: supports D1 D2
[    0.323222] pci 0000:15:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.323515] pci 0000:10:02.0: PCI bridge to [bus 15]
[    0.323541] pci 0000:10:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.323680] pci 0000:10:04.0: PCI bridge to [bus 16]
[    0.323813] pci 0000:10:05.0: PCI bridge to [bus 17]
[    0.324014] pci 0000:09:05.0: PCI bridge to [bus 18]
[    0.324164] pci 0000:06:04.0: PCI bridge to [bus 39]
[    0.324235] pci 0000:06:05.0: PCI bridge to [bus 3a-6a]
[    0.324242] pci 0000:06:05.0:   bridge window [io  0x4000-0x4fff]
[    0.324247] pci 0000:06:05.0:   bridge window [mem 0xb5200000-0xb91fffff]
[    0.324255] pci 0000:06:05.0:   bridge window [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.324298] pci 0000:06:06.0: PCI bridge to [bus 6b]
[    0.324396] pci 0000:04:00.0: [1c5c:174a] type 00 class 0x010802
[    0.324421] pci 0000:04:00.0: reg 0x10: [mem 0xb0900000-0xb0903fff 64bit]
[    0.324433] pci 0000:04:00.0: reg 0x18: [mem 0xb0905000-0xb0905fff]
[    0.324444] pci 0000:04:00.0: reg 0x1c: [mem 0xb0904000-0xb0904fff]
[    0.324594] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:1c.5 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.324800] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.324806] pci 0000:00:1c.5:   bridge window [mem 0xb0900000-0xb09fffff]
[    0.324830] pci_bus 0000:00: on NUMA node 0
[    0.325570] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.325574] ACPI: PCI: Interrupt link LNKA disabled
[    0.325607] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.325610] ACPI: PCI: Interrupt link LNKB disabled
[    0.325641] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.325643] ACPI: PCI: Interrupt link LNKC disabled
[    0.325674] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.325676] ACPI: PCI: Interrupt link LNKD disabled
[    0.325707] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.325710] ACPI: PCI: Interrupt link LNKE disabled
[    0.325740] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.325743] ACPI: PCI: Interrupt link LNKF disabled
[    0.325775] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.325777] ACPI: PCI: Interrupt link LNKG disabled
[    0.325808] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.325810] ACPI: PCI: Interrupt link LNKH disabled
[    0.325958] ACPI: EC: interrupt unblocked
[    0.325961] ACPI: EC: event unblocked
[    0.325969] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.325973] ACPI: EC: GPE=0x4e
[    0.325976] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.325981] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.326037] iommu: Default domain type: Translated 
[    0.326040] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.326083] SCSI subsystem initialized
[    0.326090] libata version 3.00 loaded.
[    0.326148] Registered efivars operations
[    0.326251] PCI: Using ACPI for IRQ routing
[    0.331442] PCI: pci_cache_line_size set to 64 bytes
[    0.331689] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.331691] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.331692] e820: reserve RAM buffer [mem 0x73d4b190-0x73ffffff]
[    0.331694] e820: reserve RAM buffer [mem 0x73d6e190-0x73ffffff]
[    0.331695] e820: reserve RAM buffer [mem 0x8ad10000-0x8bffffff]
[    0.331697] e820: reserve RAM buffer [mem 0x8ad62000-0x8bffffff]
[    0.331698] e820: reserve RAM buffer [mem 0x8ae39000-0x8bffffff]
[    0.331700] e820: reserve RAM buffer [mem 0x8aed2000-0x8bffffff]
[    0.331701] e820: reserve RAM buffer [mem 0x8af84000-0x8bffffff]
[    0.331702] e820: reserve RAM buffer [mem 0x8b000000-0x8bffffff]
[    0.331703] e820: reserve RAM buffer [mem 0x46f600000-0x46fffffff]
[    0.331717] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.331717] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.331717] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.331717] vgaarb: loaded
[    0.331717] clocksource: Switched to clocksource tsc-early
[    0.331717] pnp: PnP ACPI init
[    0.331717] system 00:00: [mem 0xfed00000-0xfed03fff] has been reserved
[    0.331717] system 00:01: [io  0xffff] has been reserved
[    0.331717] system 00:01: [io  0x1800-0x187f] has been reserved
[    0.331717] system 00:01: [io  0x0800-0x087f] has been reserved
[    0.331717] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.331717] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.331717] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.331717] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.331717] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.331717] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.331717] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.331717] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.331717] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[    0.331717] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.331717] system 00:04: [mem 0x20000000-0x201fffff] could not be reserved
[    0.331717] system 00:04: [mem 0x40000000-0x401fffff] could not be reserved
[    0.331717] pnp: PnP ACPI: found 5 devices
[    0.331717] pci 0000:00:02.0: assigning 3 device properties
[    0.331717] pci 0000:07:00.0: assigning 9 device properties
[    0.331717] pci 0000:08:00.0: assigning 3 device properties
[    0.331717] pci 0000:0f:00.0: assigning 3 device properties
[    0.331717] pci 0000:0e:00.0: assigning 2 device properties
[    0.331717] pci 0000:15:00.0: assigning 2 device properties
[    0.331717] pci 0000:00:1b.0: assigning 4 device properties
[    0.335597] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.335639] NET: Registered PF_INET protocol family
[    0.335802] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.338478] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.338515] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.338738] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.338881] TCP: Hash tables configured (established 131072 bind 65536)
[    0.338910] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.338952] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.339022] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.339098] RPC: Registered named UNIX socket transport module.
[    0.339102] RPC: Registered udp transport module.
[    0.339106] RPC: Registered tcp transport module.
[    0.339109] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.339122] pci 0000:06:00.0: bridge window [io  0x1000-0x0fff] to [bus 07] add_size 1000
[    0.339130] pci 0000:06:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 07] add_size 200000 add_align 100000
[    0.339144] pci 0000:10:04.0: bridge window [io  0x1000-0x0fff] to [bus 16] add_size 1000
[    0.339151] pci 0000:10:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 16] add_size 200000 add_align 100000
[    0.339159] pci 0000:10:04.0: bridge window [mem 0x00100000-0x000fffff] to [bus 16] add_size 200000 add_align 100000
[    0.339166] pci 0000:10:05.0: bridge window [io  0x1000-0x0fff] to [bus 17] add_size 1000
[    0.339173] pci 0000:10:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 17] add_size 200000 add_align 100000
[    0.339180] pci 0000:10:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 17] add_size 200000 add_align 100000
[    0.339188] pci 0000:0f:00.0: bridge window [io  0x1000-0x0fff] to [bus 10-17] add_size 2000
[    0.339195] pci 0000:09:04.0: bridge window [io  0x1000-0x0fff] to [bus 0f-17] add_size 3000
[    0.339202] pci 0000:09:05.0: bridge window [io  0x1000-0x0fff] to [bus 18] add_size 1000
[    0.339208] pci 0000:09:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 18] add_size 200000 add_align 100000
[    0.339215] pci 0000:09:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 18] add_size 200000 add_align 100000
[    0.339225] pci 0000:08:00.0: bridge window [io  0x1000-0x0fff] to [bus 09-18] add_size 4000
[    0.339232] pci 0000:06:04.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
[    0.339238] pci 0000:06:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
[    0.339246] pci 0000:06:04.0: bridge window [mem 0x00100000-0x000fffff] to [bus 39] add_size 200000 add_align 100000
[    0.339253] pci 0000:06:06.0: bridge window [io  0x1000-0x0fff] to [bus 6b] add_size 1000
[    0.339259] pci 0000:06:06.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6b] add_size 200000 add_align 100000
[    0.339267] pci 0000:06:06.0: bridge window [mem 0x00100000-0x000fffff] to [bus 6b] add_size 200000 add_align 100000
[    0.339280] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.339293] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.339300] pci 0000:00:1c.1:   bridge window [mem 0xb0a00000-0xb0bfffff]
[    0.339306] pci 0000:00:1c.1:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.339315] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.339322] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb08fffff]
[    0.339338] pci 0000:06:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339344] pci 0000:06:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339350] pci 0000:06:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339355] pci 0000:06:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339362] pci 0000:06:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339367] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339373] pci 0000:06:06.0: BAR 8: no space for [mem size 0x00200000]
[    0.339378] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339384] pci 0000:06:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339390] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339396] pci 0000:06:00.0: BAR 7: no space for [io  size 0x1000]
[    0.339401] pci 0000:06:00.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339406] pci 0000:06:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339410] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339415] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.339420] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339426] pci 0000:06:06.0: BAR 8: no space for [mem size 0x00200000]
[    0.339431] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339437] pci 0000:06:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339443] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339448] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.339453] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339458] pci 0000:06:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339463] pci 0000:06:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339469] pci 0000:06:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339474] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339480] pci 0000:06:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339485] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339491] pci 0000:06:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339497] pci 0000:06:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339503] pci 0000:06:00.0: BAR 7: no space for [io  size 0x1000]
[    0.339508] pci 0000:06:00.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339513] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.339521] pci 0000:06:00.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[    0.339535] pci 0000:08:00.0: BAR 7: no space for [io  size 0x4000]
[    0.339540] pci 0000:08:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.339545] pci 0000:08:00.0: BAR 7: no space for [io  size 0x4000]
[    0.339549] pci 0000:08:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.339556] pci 0000:09:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339561] pci 0000:09:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339567] pci 0000:09:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339573] pci 0000:09:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339579] pci 0000:09:04.0: BAR 7: no space for [io  size 0x3000]
[    0.339583] pci 0000:09:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.339588] pci 0000:09:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339593] pci 0000:09:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339598] pci 0000:09:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339603] pci 0000:09:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339609] pci 0000:09:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339614] pci 0000:09:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339620] pci 0000:09:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339625] pci 0000:09:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339630] pci 0000:09:04.0: BAR 7: no space for [io  size 0x3000]
[    0.339634] pci 0000:09:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.339641] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[    0.339655] pci 0000:0b:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339681] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[    0.339696] pci 0000:0a:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339722] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[    0.339734] pci 0000:09:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339755] pci 0000:09:01.0: PCI bridge to [bus 0d]
[    0.339772] pci 0000:09:01.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.339788] pci 0000:09:02.0: PCI bridge to [bus 0e]
[    0.339800] pci 0000:09:02.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.339820] pci 0000:0f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.339825] pci 0000:0f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.339830] pci 0000:0f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.339834] pci 0000:0f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.339841] pci 0000:10:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339846] pci 0000:10:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339852] pci 0000:10:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339858] pci 0000:10:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339864] pci 0000:10:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339869] pci 0000:10:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339875] pci 0000:10:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339880] pci 0000:10:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339886] pci 0000:10:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339890] pci 0000:10:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339895] pci 0000:10:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339899] pci 0000:10:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339905] pci 0000:10:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339910] pci 0000:10:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339916] pci 0000:10:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339922] pci 0000:10:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339927] pci 0000:10:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339932] pci 0000:10:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339937] pci 0000:10:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339942] pci 0000:10:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339948] pci 0000:10:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339953] pci 0000:10:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339959] pci 0000:10:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339963] pci 0000:10:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339969] pci 0000:12:03.0: PCI bridge to [bus 13]
[    0.339988] pci 0000:12:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.340021] pci 0000:11:00.0: PCI bridge to [bus 12-13]
[    0.340040] pci 0000:11:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.340074] pci 0000:10:00.0: PCI bridge to [bus 11-13]
[    0.340090] pci 0000:10:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.340118] pci 0000:10:01.0: PCI bridge to [bus 14]
[    0.340142] pci 0000:10:01.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340163] pci 0000:10:02.0: PCI bridge to [bus 15]
[    0.340179] pci 0000:10:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.340207] pci 0000:10:04.0: PCI bridge to [bus 16]
[    0.340246] pci 0000:10:05.0: PCI bridge to [bus 17]
[    0.340285] pci 0000:0f:00.0: PCI bridge to [bus 10-17]
[    0.340300] pci 0000:0f:00.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.340313] pci 0000:0f:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340334] pci 0000:09:04.0: PCI bridge to [bus 0f-17]
[    0.340346] pci 0000:09:04.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.340356] pci 0000:09:04.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340372] pci 0000:09:05.0: PCI bridge to [bus 18]
[    0.340399] pci 0000:08:00.0: PCI bridge to [bus 09-18]
[    0.340411] pci 0000:08:00.0:   bridge window [mem 0xb0e00000-0xb11fffff]
[    0.340421] pci 0000:08:00.0:   bridge window [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.340437] pci 0000:06:03.0: PCI bridge to [bus 08-38]
[    0.340443] pci 0000:06:03.0:   bridge window [io  0x3000-0x3fff]
[    0.340451] pci 0000:06:03.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[    0.340459] pci 0000:06:03.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.340470] pci 0000:06:04.0: PCI bridge to [bus 39]
[    0.340486] pci 0000:06:05.0: PCI bridge to [bus 3a-6a]
[    0.340491] pci 0000:06:05.0:   bridge window [io  0x4000-0x4fff]
[    0.340500] pci 0000:06:05.0:   bridge window [mem 0xb5200000-0xb91fffff]
[    0.340507] pci 0000:06:05.0:   bridge window [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.340518] pci 0000:06:06.0: PCI bridge to [bus 6b]
[    0.340534] pci 0000:05:00.0: PCI bridge to [bus 06-6b]
[    0.340540] pci 0000:05:00.0:   bridge window [io  0x3000-0x4fff]
[    0.340548] pci 0000:05:00.0:   bridge window [mem 0xb0d00000-0xb91fffff]
[    0.340556] pci 0000:05:00.0:   bridge window [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.340567] pci 0000:00:1c.4: PCI bridge to [bus 05-6b]
[    0.340572] pci 0000:00:1c.4:   bridge window [io  0x3000-0x5fff]
[    0.340579] pci 0000:00:1c.4:   bridge window [mem 0xb0d00000-0xbd1fffff]
[    0.340585] pci 0000:00:1c.4:   bridge window [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.340594] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.340601] pci 0000:00:1c.5:   bridge window [mem 0xb0900000-0xb09fffff]
[    0.340611] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.340616] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.340621] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.340627] pci_bus 0000:00: resource 7 [mem 0x8fa00000-0xfeafffff window]
[    0.340632] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff window]
[    0.340637] pci_bus 0000:02: resource 1 [mem 0xb0a00000-0xb0bfffff]
[    0.340642] pci_bus 0000:02: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.340648] pci_bus 0000:03: resource 1 [mem 0xb0400000-0xb08fffff]
[    0.340653] pci_bus 0000:05: resource 0 [io  0x3000-0x5fff]
[    0.340657] pci_bus 0000:05: resource 1 [mem 0xb0d00000-0xbd1fffff]
[    0.340662] pci_bus 0000:05: resource 2 [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.340668] pci_bus 0000:06: resource 0 [io  0x3000-0x4fff]
[    0.340672] pci_bus 0000:06: resource 1 [mem 0xb0d00000-0xb91fffff]
[    0.340677] pci_bus 0000:06: resource 2 [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.340683] pci_bus 0000:07: resource 1 [mem 0xb0d00000-0xb0dfffff]
[    0.340688] pci_bus 0000:08: resource 0 [io  0x3000-0x3fff]
[    0.340692] pci_bus 0000:08: resource 1 [mem 0xb0e00000-0xb51fffff]
[    0.340697] pci_bus 0000:08: resource 2 [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.340703] pci_bus 0000:09: resource 1 [mem 0xb0e00000-0xb11fffff]
[    0.340707] pci_bus 0000:09: resource 2 [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.340713] pci_bus 0000:0a: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340718] pci_bus 0000:0b: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340723] pci_bus 0000:0c: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340728] pci_bus 0000:0d: resource 2 [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.340734] pci_bus 0000:0e: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.340739] pci_bus 0000:0f: resource 1 [mem 0xb0e00000-0xb0ffffff]
[    0.340743] pci_bus 0000:0f: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340749] pci_bus 0000:10: resource 1 [mem 0xb0e00000-0xb0ffffff]
[    0.340754] pci_bus 0000:10: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340759] pci_bus 0000:11: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340764] pci_bus 0000:12: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340769] pci_bus 0000:13: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340774] pci_bus 0000:14: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340780] pci_bus 0000:15: resource 1 [mem 0xb0e00000-0xb0efffff]
[    0.340785] pci_bus 0000:3a: resource 0 [io  0x4000-0x4fff]
[    0.340790] pci_bus 0000:3a: resource 1 [mem 0xb5200000-0xb91fffff]
[    0.340795] pci_bus 0000:3a: resource 2 [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.340801] pci_bus 0000:04: resource 1 [mem 0xb0900000-0xb09fffff]
[    0.341191] pci 0000:05:00.0: CLS mismatch (256 != 128), using 64 bytes
[    0.341219] pci 0000:0c:00.0: MSI is not implemented on this device, disabling it
[    0.341224] pci 0000:0c:00.0: PME# is unreliable, disabling it
[    0.341610] pci 0000:0c:00.1: MSI is not implemented on this device, disabling it
[    0.341616] pci 0000:0c:00.1: PME# is unreliable, disabling it
[    0.341723] pci 0000:0c:00.2: MSI is not implemented on this device, disabling it
[    0.341728] pci 0000:0c:00.2: PME# is unreliable, disabling it
[    0.341793] pci 0000:0c:00.2: EHCI: unrecognized capability 00
[    0.341851] pci 0000:13:00.0: MSI is not implemented on this device, disabling it
[    0.341857] pci 0000:13:00.0: PME# is unreliable, disabling it
[    0.342178] pci 0000:13:00.1: MSI is not implemented on this device, disabling it
[    0.342183] pci 0000:13:00.1: PME# is unreliable, disabling it
[    0.342306] pci 0000:13:00.2: MSI is not implemented on this device, disabling it
[    0.342312] pci 0000:13:00.2: PME# is unreliable, disabling it
[    0.342389] pci 0000:13:00.2: EHCI: unrecognized capability 00
[    0.342471] DMAR: No ATSR found
[    0.342474] DMAR: No SATC found
[    0.342478] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.342480] DMAR: IOMMU feature sc_support inconsistent
[    0.342484] DMAR: IOMMU feature pass_through inconsistent
[    0.342485] Unpacking initramfs...
[    0.342487] DMAR: dmar0: Using Queued invalidation
[    0.342501] DMAR: dmar1: Using Queued invalidation
[    0.438669] pci 0000:00:00.0: Adding to iommu group 0
[    0.438701] pci 0000:00:02.0: Adding to iommu group 1
[    0.438722] pci 0000:00:03.0: Adding to iommu group 2
[    0.438743] pci 0000:00:14.0: Adding to iommu group 3
[    0.438774] pci 0000:00:16.0: Adding to iommu group 4
[    0.438793] pci 0000:00:1b.0: Adding to iommu group 5
[    0.438814] pci 0000:00:1c.0: Adding to iommu group 6
[    0.438834] pci 0000:00:1c.1: Adding to iommu group 7
[    0.438855] pci 0000:00:1c.2: Adding to iommu group 8
[    0.438875] pci 0000:00:1c.4: Adding to iommu group 9
[    0.438895] pci 0000:00:1c.5: Adding to iommu group 10
[    0.438931] pci 0000:00:1f.0: Adding to iommu group 11
[    0.438951] pci 0000:00:1f.3: Adding to iommu group 11
[    0.438970] pci 0000:02:00.0: Adding to iommu group 12
[    0.438989] pci 0000:03:00.0: Adding to iommu group 13
[    0.439008] pci 0000:05:00.0: Adding to iommu group 14
[    0.439029] pci 0000:06:00.0: Adding to iommu group 15
[    0.439049] pci 0000:06:03.0: Adding to iommu group 16
[    0.439069] pci 0000:06:04.0: Adding to iommu group 17
[    0.439089] pci 0000:06:05.0: Adding to iommu group 18
[    0.439109] pci 0000:06:06.0: Adding to iommu group 19
[    0.439118] pci 0000:07:00.0: Adding to iommu group 15
[    0.439126] pci 0000:08:00.0: Adding to iommu group 16
[    0.439135] pci 0000:09:00.0: Adding to iommu group 16
[    0.439144] pci 0000:09:01.0: Adding to iommu group 16
[    0.439154] pci 0000:09:02.0: Adding to iommu group 16
[    0.439162] pci 0000:09:04.0: Adding to iommu group 16
[    0.439171] pci 0000:09:05.0: Adding to iommu group 16
[    0.439180] pci 0000:0a:00.0: Adding to iommu group 16
[    0.439189] pci 0000:0b:03.0: Adding to iommu group 16
[    0.439197] pci 0000:0c:00.0: Adding to iommu group 16
[    0.439205] pci 0000:0c:00.1: Adding to iommu group 16
[    0.439212] pci 0000:0c:00.2: Adding to iommu group 16
[    0.439221] pci 0000:0d:00.0: Adding to iommu group 16
[    0.439230] pci 0000:0e:00.0: Adding to iommu group 16
[    0.439238] pci 0000:0f:00.0: Adding to iommu group 16
[    0.439248] pci 0000:10:00.0: Adding to iommu group 16
[    0.439256] pci 0000:10:01.0: Adding to iommu group 16
[    0.439264] pci 0000:10:02.0: Adding to iommu group 16
[    0.439273] pci 0000:10:04.0: Adding to iommu group 16
[    0.439281] pci 0000:10:05.0: Adding to iommu group 16
[    0.439289] pci 0000:11:00.0: Adding to iommu group 16
[    0.439298] pci 0000:12:03.0: Adding to iommu group 16
[    0.439307] pci 0000:13:00.0: Adding to iommu group 16
[    0.439316] pci 0000:13:00.1: Adding to iommu group 16
[    0.439324] pci 0000:13:00.2: Adding to iommu group 16
[    0.439334] pci 0000:14:00.0: Adding to iommu group 16
[    0.439343] pci 0000:15:00.0: Adding to iommu group 16
[    0.439362] pci 0000:04:00.0: Adding to iommu group 20
[    0.441466] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.441472] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.441476] software IO TLB: mapped [mem 0x000000006c76d000-0x000000007076d000] (64MB)
[    0.441487] ACPI: bus type thunderbolt registered
[    0.441661] thunderbolt 0000:07:00.0: total paths: 12
[    0.441924] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.441961] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.441984] thunderbolt 0000:07:00.0: control channel created
[    0.441988] thunderbolt 0000:07:00.0: ICM not supported on this controller
[    0.442000] thunderbolt 0000:07:00.0: freeing RX ring 0
[    0.442010] thunderbolt 0000:07:00.0: freeing TX ring 0
[    0.442024] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.442034] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.442046] thunderbolt 0000:07:00.0: control channel created
[    0.442048] thunderbolt 0000:07:00.0: using software connection manager
[    0.442051] thunderbolt 0000:07:00.0: device link creation from 0000:06:00.0 failed
[    0.442100] thunderbolt 0000:07:00.0: created link from 0000:06:03.0
[    0.442116] thunderbolt 0000:07:00.0: created link from 0000:06:04.0
[    0.442133] thunderbolt 0000:07:00.0: created link from 0000:06:05.0
[    0.442149] thunderbolt 0000:07:00.0: created link from 0000:06:06.0
[    0.442287] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[    0.442289] thunderbolt 0000:07:00.0: control channel starting...
[    0.442291] thunderbolt 0000:07:00.0: starting TX ring 0
[    0.442300] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.442303] thunderbolt 0000:07:00.0: starting RX ring 0
[    0.442311] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[    0.442316] thunderbolt 0000:07:00.0: security level set to user
[    0.442829] thunderbolt 0000:07:00.0: current switch config:
[    0.442832] thunderbolt 0000:07:00.0:  Thunderbolt 2 Switch: 8086:156d (Revision: 0, TB Version: 2)
[    0.442835] thunderbolt 0000:07:00.0:   Max Port Number: 12
[    0.442838] thunderbolt 0000:07:00.0:   Config:
[    0.442839] thunderbolt 0000:07:00.0:    Upstream Port Number: 5 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.442843] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.444280] Freeing initrd memory: 7308K
[    0.555264] thunderbolt 0000:07:00.0: initializing Switch at 0x0 (depth: 0, up port: 5)
[    0.555902] thunderbolt 0000:07:00.0: 0: DROM version: 1
[    0.557306] thunderbolt 0000:07:00.0: 0: uid: 0x1000f0811ee60
[    0.559226] thunderbolt 0000:07:00.0:  Port 1: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.559229] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.559231] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.559232] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.559233] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.561145] thunderbolt 0000:07:00.0:  Port 2: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.561147] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.561149] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.561150] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.561151] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.563065] thunderbolt 0000:07:00.0:  Port 3: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.563067] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.563068] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.563069] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.563070] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.564985] thunderbolt 0000:07:00.0:  Port 4: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.564987] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.564988] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.564989] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.564990] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.565753] thunderbolt 0000:07:00.0:  Port 5: 8086:156d (Revision: 0, TB Version: 1, Type: NHI (0x2))
[    0.565755] thunderbolt 0000:07:00.0:   Max hop id (in/out): 11/11
[    0.565756] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.565757] thunderbolt 0000:07:00.0:   NFC Credits: 0xf00000
[    0.565758] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.566009] thunderbolt 0000:07:00.0:  Port 6: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566011] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566012] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566013] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566014] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566266] random: fast init done
[    0.566268] thunderbolt 0000:07:00.0:  Port 7: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566274] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566276] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566277] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566278] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566521] thunderbolt 0000:07:00.0:  Port 8: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566524] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566525] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566526] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566527] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566777] thunderbolt 0000:07:00.0:  Port 9: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566779] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566780] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566781] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566782] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566783] thunderbolt 0000:07:00.0: 0:a: disabled by eeprom
[    0.567033] thunderbolt 0000:07:00.0:  Port 11: 8086:156d (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.567035] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.567036] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.567037] thunderbolt 0000:07:00.0:   NFC Credits: 0xf0000b
[    0.567038] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.567289] thunderbolt 0000:07:00.0:  Port 12: 8086:156d (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.567291] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.567292] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.567293] thunderbolt 0000:07:00.0:   NFC Credits: 0xf00000
[    0.567294] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.572281] thunderbolt 0000:07:00.0: 0: TMU: current mode: HiFi
[    0.572411] thunderbolt 0000:07:00.0: 0:1: is connected, link is up (state: 2)
[    0.572664] thunderbolt 0000:07:00.0: current switch config:
[    0.572665] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.572667] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.572668] thunderbolt 0000:07:00.0:   Config:
[    0.572669] thunderbolt 0000:07:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x1 Enabled: 1, PlugEventsDelay: 255ms
[    0.572671] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.577272] thunderbolt 0000:07:00.0: initializing Switch at 0x1 (depth: 1, up port: 1)
[    0.594678] thunderbolt 0000:07:00.0: 1: reading drom (length: 0x97)
[    1.088326] thunderbolt 0000:07:00.0: 1: DROM version: 1
[    1.089350] thunderbolt 0000:07:00.0: 1: uid: 0x1000100189170
[    1.092293] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.092295] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.092297] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.092298] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.092299] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.095236] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.095238] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.095239] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.095240] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c0000e
[    1.095241] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.098180] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.098181] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.098182] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.098183] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.098184] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.101123] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.101125] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.101126] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.101127] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.101128] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.101129] thunderbolt 0000:07:00.0: 1:5: disabled by eeprom
[    1.101130] thunderbolt 0000:07:00.0: 1:6: disabled by eeprom
[    1.102019] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.102021] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.102022] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.102023] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.102024] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.102915] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.102917] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.102918] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.102919] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.102920] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.102921] thunderbolt 0000:07:00.0: 1:9: disabled by eeprom
[    1.103812] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.103814] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.103815] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.103816] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.103817] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.104964] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.104966] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.104967] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.104968] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.104969] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.104970] thunderbolt 0000:07:00.0: 1:c: disabled by eeprom
[    1.104971] thunderbolt 0000:07:00.0: 1:d: disabled by eeprom
[    1.123324] thunderbolt 0000:07:00.0: 1: TMU: current mode: bi-directional, HiFi
[    1.123340] thunderbolt 0-1: new device found, vendor=0x1 device=0x8002
[    1.123344] thunderbolt 0-1: Apple, Inc. Thunderbolt Display
[    1.123836] thunderbolt 0000:07:00.0: 1:3: is connected, link is up (state: 2)
[    1.124092] thunderbolt 0000:07:00.0: current switch config:
[    1.124093] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    1.124094] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    1.124096] thunderbolt 0000:07:00.0:   Config:
[    1.124096] thunderbolt 0000:07:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x301 Enabled: 1, PlugEventsDelay: 255ms
[    1.124098] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.128700] thunderbolt 0000:07:00.0: initializing Switch at 0x301 (depth: 2, up port: 3)
[    1.146106] thunderbolt 0000:07:00.0: 301: reading drom (length: 0x97)
[    1.621709] random: crng init done
[    1.639753] thunderbolt 0000:07:00.0: 301: DROM version: 1
[    1.640777] thunderbolt 0000:07:00.0: 301: uid: 0x100010102a740
[    1.643720] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.643722] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.643724] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.643725] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.643726] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.646664] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.646666] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.646667] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.646668] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.646669] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.649608] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.649609] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.649611] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.649612] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.649613] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.652551] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.652553] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.652554] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.652555] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.652556] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.652557] thunderbolt 0000:07:00.0: 301:5: disabled by eeprom
[    1.652559] thunderbolt 0000:07:00.0: 301:6: disabled by eeprom
[    1.653447] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.653449] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.653450] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.653451] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.653452] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.654343] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.654345] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.654346] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.654347] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.654348] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.654349] thunderbolt 0000:07:00.0: 301:9: disabled by eeprom
[    1.655239] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.655241] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.655242] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.655243] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.655244] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.656391] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.656393] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.656394] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.656395] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.656396] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.656397] thunderbolt 0000:07:00.0: 301:c: disabled by eeprom
[    1.656398] thunderbolt 0000:07:00.0: 301:d: disabled by eeprom
[    1.675048] thunderbolt 0000:07:00.0: 301: TMU: current mode: bi-directional, HiFi
[    1.675065] thunderbolt 0-301: new device found, vendor=0x1 device=0x8002
[    1.675069] thunderbolt 0-301: Apple, Inc. Thunderbolt Display
[    1.675178] thunderbolt 0000:07:00.0: 301:1: is unplugged (state: 7)
[    1.675433] thunderbolt 0000:07:00.0: 301:b: DP adapter HPD set, queuing hotplug
[    1.675816] thunderbolt 0000:07:00.0: 0:3: is unplugged (state: 7)
[    1.677352] thunderbolt 0000:07:00.0: 0:6 <-> 1:a (PCI): discovered
[    1.679912] thunderbolt 0000:07:00.0: 0:b <-> 1:b (DP): discovered
[    1.681576] thunderbolt 0000:07:00.0: 1:7 <-> 301:a (PCI): discovered
[    1.681961] thunderbolt 0000:07:00.0: 0:b: DP IN resource available
[    1.681963] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.682103] thunderbolt 0000:07:00.0: 301:b: DP OUT resource available
[    1.682107] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[    1.682119] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    1.682125] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    1.682127] RAPL PMU: hw unit of domain package 2^-14 Joules
[    1.682129] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    1.682131] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    1.682220] thunderbolt 0000:07:00.0: 0:b: in use
[    1.682347] thunderbolt 0000:07:00.0: 0:c: DP IN available
[    1.682473] thunderbolt 0000:07:00.0: 301:b: DP OUT available
[    1.682477] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 12
[    1.682479] thunderbolt 0000:07:00.0: 301:b: calculating available bandwidth
[    1.682603] thunderbolt 0000:07:00.0: 0:1: link total bandwidth 9000 Mb/s
[    1.682607] thunderbolt 0000:07:00.0: 1:1: link total bandwidth 9000 Mb/s
[    1.682730] thunderbolt 0000:07:00.0: 1:3: link total bandwidth 9000 Mb/s
[    1.682734] thunderbolt 0000:07:00.0: 301:3: link total bandwidth 9000 Mb/s
[    1.682737] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    1.682742] thunderbolt 0000:07:00.0: Tunnel link 0
[    1.682747] thunderbolt 0000:07:00.0: 0:c <-> 301:b (DP): activating
[    1.682750] thunderbolt 0000:07:00.0: activating Video path from 0:12 to 301:11
[    1.682753] thunderbolt 0000:07:00.0: 301:3: adding 12 NFC credits to 0
[    1.682858] thunderbolt 0000:07:00.0: 1:1: adding 12 NFC credits to 0
[    1.682955] Initialise system trusted keyrings
[    1.682985] thunderbolt 0000:07:00.0: 0:c: adding 12 NFC credits to 0
[    1.682986] workingset: timestamp_bits=62 max_order=22 bucket_order=0
[    1.683239] thunderbolt 0000:07:00.0: 301:3: Writing hop 2
[    1.683240] thunderbolt 0000:07:00.0: 301:3:  In HopID: 9 => Out port: 11 Out HopID: 9
[    1.683242] thunderbolt 0000:07:00.0: 301:3:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.683244] thunderbolt 0000:07:00.0: 301:3:    Counter enabled: 0 Counter index: 2047
[    1.683246] thunderbolt 0000:07:00.0: 301:3:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.683247] thunderbolt 0000:07:00.0: 301:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683495] thunderbolt 0000:07:00.0: 1:1: Writing hop 1
[    1.683496] thunderbolt 0000:07:00.0: 1:1:  In HopID: 9 => Out port: 3 Out HopID: 9
[    1.683498] thunderbolt 0000:07:00.0: 1:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.683499] thunderbolt 0000:07:00.0: 1:1:    Counter enabled: 0 Counter index: 2047
[    1.683501] thunderbolt 0000:07:00.0: 1:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.683502] thunderbolt 0000:07:00.0: 1:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683751] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[    1.683753] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 1 Out HopID: 9
[    1.683754] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.683755] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[    1.683757] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.683758] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683879] thunderbolt 0000:07:00.0: path activation complete
[    1.683881] thunderbolt 0000:07:00.0: activating AUX TX path from 0:12 to 301:11
[    1.684007] thunderbolt 0000:07:00.0: 301:3: Writing hop 2
[    1.684009] thunderbolt 0000:07:00.0: 301:3:  In HopID: 10 => Out port: 11 Out HopID: 8
[    1.684010] thunderbolt 0000:07:00.0: 301:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.684012] thunderbolt 0000:07:00.0: 301:3:    Counter enabled: 0 Counter index: 2047
[    1.684013] thunderbolt 0000:07:00.0: 301:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.684015] thunderbolt 0000:07:00.0: 301:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.684153] NFS: Registering the id_resolver key type
[    1.684159] Key type id_resolver registered
[    1.684161] Key type id_legacy registered
[    1.684176] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.684215] Key type asymmetric registered
[    1.684217] Asymmetric key parser 'x509' registered
[    1.684655] thunderbolt 0000:07:00.0: 1:1: Writing hop 1
[    1.684658] thunderbolt 0000:07:00.0: 1:1:  In HopID: 10 => Out port: 3 Out HopID: 10
[    1.684661] thunderbolt 0000:07:00.0: 1:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.684664] thunderbolt 0000:07:00.0: 1:1:    Counter enabled: 0 Counter index: 2047
[    1.684667] thunderbolt 0000:07:00.0: 1:1:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.684670] thunderbolt 0000:07:00.0: 1:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.685457] pcieport 0000:06:00.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.685509] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[    1.685512] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 1 Out HopID: 10
[    1.685515] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.685518] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[    1.685521] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.685524] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.685636] thunderbolt 0000:07:00.0: path activation complete
[    1.685638] thunderbolt 0000:07:00.0: activating AUX RX path from 301:11 to 0:12
[    1.685701] pcieport 0000:06:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.685765] thunderbolt 0000:07:00.0: 0:1: Writing hop 2
[    1.685768] thunderbolt 0000:07:00.0: 0:1:  In HopID: 9 => Out port: 12 Out HopID: 8
[    1.685770] thunderbolt 0000:07:00.0: 0:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.685772] thunderbolt 0000:07:00.0: 0:1:    Counter enabled: 0 Counter index: 2047
[    1.685774] thunderbolt 0000:07:00.0: 0:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.685776] thunderbolt 0000:07:00.0: 0:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.685948] pcieport 0000:06:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.686022] thunderbolt 0000:07:00.0: 1:3: Writing hop 1
[    1.686025] thunderbolt 0000:07:00.0: 1:3:  In HopID: 9 => Out port: 1 Out HopID: 9
[    1.686027] thunderbolt 0000:07:00.0: 1:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.686029] thunderbolt 0000:07:00.0: 1:3:    Counter enabled: 0 Counter index: 2047
[    1.686031] thunderbolt 0000:07:00.0: 1:3:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.686033] thunderbolt 0000:07:00.0: 1:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.686106] pcieport 0000:06:05.0: enabling device (0000 -> 0003)
[    1.686216] pcieport 0000:06:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.686276] thunderbolt 0000:07:00.0: 301:b: Writing hop 0
[    1.686278] thunderbolt 0000:07:00.0: 301:b:  In HopID: 8 => Out port: 3 Out HopID: 9
[    1.686281] thunderbolt 0000:07:00.0: 301:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.686284] thunderbolt 0000:07:00.0: 301:b:    Counter enabled: 0 Counter index: 2047
[    1.686286] thunderbolt 0000:07:00.0: 301:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.686289] thunderbolt 0000:07:00.0: 301:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.686404] thunderbolt 0000:07:00.0: path activation complete
[    1.686516] pcieport 0000:06:06.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.689074] pcieport 0000:09:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.689402] pcieport 0000:09:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.692762] pcieport 0000:10:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.693185] pcieport 0000:10:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.694148] ACPI: AC: AC Adapter [ADP1] (off-line)
[    1.694216] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    1.694253] ACPI: button: Lid Switch [LID0]
[    1.694293] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.694315] ACPI: button: Power Button [PWRB]
[    1.694350] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    1.694369] ACPI: button: Sleep Button [SLPB]
[    1.694404] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.694432] ACPI: button: Power Button [PWRF]
[    1.694725] smbus_hc ACPI0001:00: SBS HC: offset = 0x20, query_bit = 0x10
[    2.114414] ACPI: Smart Battery System [SBS0]: Battery Slot [BAT0] (battery present)
[    2.123919] hpet_acpi_add: no address or irqs in _CRS
[    2.125029] loop: module loaded
[    2.125246] nvme nvme0: pci function 0000:04:00.0
[    2.125509] tun: Universal TUN/TAP device driver, 1.6
[    2.125583] mousedev: PS/2 mouse device common for all mice
[    2.125601] rtc_cmos 00:02: RTC can wake from S4
[    2.125861] rtc_cmos 00:02: registered as rtc0
[    2.125898] rtc_cmos 00:02: setting system clock to 2022-03-30T13:10:08 UTC (1648645808)
[    2.125904] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram
[    2.126081] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[    2.126095] intel_pstate: Intel P-state driver initializing
[    2.126200] efifb: probing for efifb
[    2.126211] efifb: framebuffer at 0xa0000000, using 16000k, total 16000k
[    2.126213] efifb: mode is 2560x1600x32, linelength=10240, pages=1
[    2.126216] efifb: scrolling: redraw
[    2.126217] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    2.129403] Console: switching to colour frame buffer device 320x100
[    2.132418] fb0: EFI VGA frame buffer device
[    2.132485] NET: Registered PF_PACKET protocol family
[    2.132504] Key type dns_resolver registered
[    2.132662] microcode: sig=0x40651, pf=0x40, revision=0x26
[    2.132700] microcode: Microcode Update Driver: v2.2.
[    2.132704] IPI shorthand broadcast: enabled
[    2.132723] AVX2 version of gcm_enc/dec engaged.
[    2.132762] AES CTR mode by8 optimization enabled
[    2.132890] sched_clock: Marking stable (2131290411, 1593985)->(2158526439, -25642043)
[    2.132958] registered taskstats version 1
[    2.132965] Loading compiled-in X.509 certificates
[    2.181076] nvme0: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) 
[    2.199235] nvme nvme0: 4/0/0 default/read/poll queues
[    2.204201]  nvme0n1: p1 p2 p3 p4 p5 p6 p7
[    2.370962] Freeing unused kernel image (initmem) memory: 996K
[    2.403594] Write protecting the kernel read-only data: 16384k
[    2.403952] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    2.404147] Freeing unused kernel image (rodata/data gap) memory: 1356K
[    2.404164] Run /init as init process
[    2.404172]   with arguments:
[    2.404173]     /init
[    2.404174]   with environment:
[    2.404175]     HOME=/
[    2.404175]     TERM=linux
[    2.456184] udevd[938]: starting version 3.2.9
[    2.456917] udevd[939]: starting eudev-3.2.9
[    2.477515] ACPI: bus type USB registered
[    2.477619] usbcore: registered new interface driver usbfs
[    2.477645] usbcore: registered new interface driver hub
[    2.477725] usbcore: registered new device driver usb
[    2.480867] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.480896] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.481997] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x000000000004b810
[    2.482178] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    2.482206] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.482225] usb usb1: Product: xHCI Host Controller
[    2.482239] usb usb1: Manufacturer: Linux 5.17.0+ xhci-hcd
[    2.482253] usb usb1: SerialNumber: 0000:00:14.0
[    2.483147] hub 1-0:1.0: USB hub found
[    2.483378] hub 1-0:1.0: 9 ports detected
[    2.485349] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.485395] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.485499] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.485549] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.17
[    2.485574] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.485593] usb usb2: Product: xHCI Host Controller
[    2.485608] usb usb2: Manufacturer: Linux 5.17.0+ xhci-hcd
[    2.485622] usb usb2: SerialNumber: 0000:00:14.0
[    2.485901] hub 2-0:1.0: USB hub found
[    2.485921] hub 2-0:1.0: 4 ports detected
[    2.486168] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    2.486383] i2c i2c-0: 2/2 memory slots populated (from DMI)
[    2.543395] applesmc: key=571 fan=1 temp=32 index=31 acc=0 lux=2 kbd=1
[    2.543563] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    2.553204] tg3 0000:0d:00.0 eth0: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[    2.553226] tg3 0000:0d:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.553243] tg3 0000:0d:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.553257] tg3 0000:0d:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.634108] tg3 0000:14:00.0 eth1: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[    2.634130] tg3 0000:14:00.0 eth1: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.634147] tg3 0000:14:00.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.634161] tg3 0000:14:00.0 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.723591] tsc: Refined TSC clocksource calibration: 2599.999 MHz
[    2.723603] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x257a3b2ad7e, max_idle_ns: 440795282337 ns
[    2.723627] clocksource: Switched to clocksource tsc
[    2.773593] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    2.955891] usb 1-3: New USB device found, idVendor=05ac, idProduct=8290, bcdDevice= 1.69
[    2.955896] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.955898] usb 1-3: Product: Bluetooth USB Host Controller
[    2.955899] usb 1-3: Manufacturer: Broadcom Corp.
[    2.963051] hid: raw HID events driver (C) Jiri Kosina
[    2.967395] usbcore: registered new interface driver usbhid
[    2.967397] usbhid: USB HID core driver
[    2.968041] input: Broadcom Corp. Bluetooth USB Host Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:05AC:8290.0001/input/input4
[    3.033757] hid-generic 0003:05AC:8290.0001: input,hidraw0: USB HID v1.11 Keyboard [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.0-3/input0
[    3.033899] input: Broadcom Corp. Bluetooth USB Host Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.1/0003:05AC:8290.0002/input/input5
[    3.034406] hid-generic 0003:05AC:8290.0002: input,hidraw1: USB HID v1.11 Mouse [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.0-3/input1
[    3.103756] usb 2-3: new SuperSpeed USB device number 2 using xhci_hcd
[    3.136024] usb 2-3: New USB device found, idVendor=05ac, idProduct=8406, bcdDevice= 8.20
[    3.136029] usb 2-3: New USB device strings: Mfr=3, Product=4, SerialNumber=5
[    3.136031] usb 2-3: Product: Card Reader
[    3.136032] usb 2-3: Manufacturer: Apple
[    3.136033] usb 2-3: SerialNumber: 000000000820
[    3.139040] usb-storage 2-3:1.0: USB Mass Storage device detected
[    3.139159] scsi host0: usb-storage 2-3:1.0
[    3.139263] usbcore: registered new interface driver usb-storage
[    3.139485] usbcore: registered new interface driver uas
[    3.283594] usb 1-5: new full-speed USB device number 3 using xhci_hcd
[    3.469240] usb 1-5: New USB device found, idVendor=05ac, idProduct=0259, bcdDevice= 2.24
[    3.469246] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.469248] usb 1-5: Product: Apple Internal Keyboard / Trackpad
[    3.469249] usb 1-5: Manufacturer: Apple Inc.
[    3.478427] input: Apple Inc. Apple Internal Keyboard / Trackpad as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/0003:05AC:0259.0003/input/input6
[    3.543739] apple 0003:05AC:0259.0003: input,hidraw2: USB HID v1.11 Keyboard [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-5/input0
[    3.543934] apple 0003:05AC:0259.0004: hidraw3: USB HID v1.11 Device [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-5/input1
[    4.165567] scsi 0:0:0:0: Direct-Access     APPLE    SD Card Reader   3.00 PQ: 0 ANSI: 6
[    4.166161] sd 0:0:0:0: [sda] Media removed, stopped polling
[    4.166251] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.166825] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    9.719127] process '/usr/bin/fstype' started with executable stack
[    9.778350] PM: Image not found (code -22)
[    9.780426] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[    9.780430] PM: hibernation: Marking nosave pages: [mem 0x00058000-0x00058fff]
[    9.780432] PM: hibernation: Marking nosave pages: [mem 0x0008f000-0x0008ffff]
[    9.780433] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
[    9.780435] PM: hibernation: Marking nosave pages: [mem 0x73d4b000-0x73d4bfff]
[    9.780436] PM: hibernation: Marking nosave pages: [mem 0x73d5b000-0x73d5bfff]
[    9.780437] PM: hibernation: Marking nosave pages: [mem 0x73d6e000-0x73d6efff]
[    9.780438] PM: hibernation: Marking nosave pages: [mem 0x73d6e000-0x73d6efff]
[    9.780440] PM: hibernation: Marking nosave pages: [mem 0x8ad10000-0x8ad52fff]
[    9.780441] PM: hibernation: Marking nosave pages: [mem 0x8ad62000-0x8ad8efff]
[    9.780443] PM: hibernation: Marking nosave pages: [mem 0x8ae39000-0x8ae8efff]
[    9.780445] PM: hibernation: Marking nosave pages: [mem 0x8aed2000-0x8aefefff]
[    9.780447] PM: hibernation: Marking nosave pages: [mem 0x8af84000-0x8afeffff]
[    9.780449] PM: hibernation: Marking nosave pages: [mem 0x8b000000-0xffffffff]
[    9.781538] PM: hibernation: Basic memory bitmaps created
[    9.782276] PM: hibernation: Basic memory bitmaps freed
[    9.982276] EXT4-fs (nvme0n1p4): mounted filesystem with ordered data mode. Quota mode: disabled.
[   10.117276] udevd[1214]: starting version 3.2.9
[   10.141858] udevd[1215]: starting eudev-3.2.9
[   10.206408] Linux agpgart interface v0.103
[   10.210834] ACPI: bus type drm_connector registered
[   10.222993] tg3 0000:0d:00.0 eth2: renamed from eth0
[   10.225927] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   10.237877] input: bcm5974 as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.2/input/input7
[   10.239124] usbcore: registered new interface driver bcm5974
[   10.250345] i915 0000:00:02.0: [drm] VT-d active for gfx access
[   10.252010] checking generic (a0000000 fa0000) vs hw (b0000000 400000)
[   10.252013] checking generic (a0000000 fa0000) vs hw (a0000000 10000000)
[   10.252015] fb0: switching to i915 from EFI VGA
[   10.254460] Console: switching to colour dummy device 80x25
[   10.255166] i915 0000:00:02.0: vgaarb: deactivate vga console
[   10.255222] i915 0000:00:02.0: [drm] Transparent Hugepage support is recommended for optimal performance when IOMMU is enabled!
[   10.256064] i915 0000:00:02.0: [drm] DMAR active, disabling use of stolen memory
[   10.258950] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   10.295601] snd_hda_codec_cirrus hdaudioC1D0: autoconfig for CS4208: line_outs=2 (0x12/0x13/0x0/0x0/0x0) type:speaker
[   10.295614] snd_hda_codec_cirrus hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   10.295620] snd_hda_codec_cirrus hdaudioC1D0:    hp_outs=1 (0x10/0x0/0x0/0x0/0x0)
[   10.295625] snd_hda_codec_cirrus hdaudioC1D0:    mono: mono_out=0x0
[   10.295628] snd_hda_codec_cirrus hdaudioC1D0:    dig-out=0x21/0x0
[   10.295632] snd_hda_codec_cirrus hdaudioC1D0:    inputs:
[   10.295636] snd_hda_codec_cirrus hdaudioC1D0:      Internal Mic=0x1c
[   10.295640] snd_hda_codec_cirrus hdaudioC1D0:      Mic=0x18
[   10.304472] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   10.304652] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   10.304664] cfg80211: failed to load regulatory.db
[   10.304785] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input8
[   10.304859] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[   10.304923] input: HDA Intel PCH SPDIF as /devices/pci0000:00/0000:00:1b.0/sound/card1/input10
[   10.306966] brcmfmac 0000:03:00.0: enabling device (0000 -> 0002)
[   10.340886] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[   10.341690] ACPI: video: Video Device [IGPU] (multi-head: yes  rom: no  post: no)
[   10.342220] acpi device:02: registered as cooling_device4
[   10.342438] Bluetooth: Core ver 2.22
[   10.342461] NET: Registered PF_BLUETOOTH protocol family
[   10.342466] Bluetooth: HCI device and connection manager initialized
[   10.342474] Bluetooth: HCI socket layer initialized
[   10.342478] Bluetooth: L2CAP socket layer initialized
[   10.342486] Bluetooth: SCO socket layer initialized
[   10.343386] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input11
[   10.343880] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   10.345018] usbcore: registered new interface driver btusb
[   10.377827] udevd[1245]: Unable to EVIOCGABS device "/dev/input/event6"
[   10.377839] udevd[1245]: Unable to EVIOCGABS device "/dev/input/event6"
[   10.377845] udevd[1245]: Unable to EVIOCGABS device "/dev/input/event6"
[   10.377850] udevd[1245]: Unable to EVIOCGABS device "/dev/input/event6"
[   10.423798] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43602-pcie for chip BCM43602/1
[   10.424112] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.Apple Inc.-MacBookPro11,1.bin failed with error -2
[   10.424854] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.Apple Inc.-MacBookPro11,1.txt failed with error -2
[   10.424868] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.txt failed with error -2
[   10.500623] fbcon: i915drmfb (fb0) is primary device
[   10.525742] Bluetooth: hci0: BCM: chip id 102 build 0729
[   10.526741] Bluetooth: hci0: BCM: product 05ac:8290
[   10.527744] Bluetooth: hci0: BCM: features 0x2f
[   10.545743] Bluetooth: hci0: BlueZ 5.50
[   10.936035] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43602-pcie for chip BCM43602/1
[   10.936058] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
[   10.936619] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43602/1 wl0: Nov 10 2015 06:38:10 version 7.35.177.61 (r598657) FWID 01-ea662a8c
[   12.004655] Console: switching to colour frame buffer device 320x90
[   12.023978] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[   12.072184] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input12
[   12.072297] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input13
[   12.073782] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input14
[   12.074547] input: HDA Intel HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/sound/card0/input15
[   12.074796] input: HDA Intel HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.0/sound/card0/input16
[   12.253395] Adding 19528700k swap on /dev/mapper/swap.  Priority:-2 extents:1 across:19528700k SS
[   12.266376] EXT4-fs (nvme0n1p4): re-mounted. Quota mode: disabled.
[   18.107340] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Quota mode: disabled.
[   18.316724] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   21.379285] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   21.379288] Bluetooth: BNEP filters: protocol multicast
[   21.379293] Bluetooth: BNEP socket layer initialized
[   21.734334] broken atomic modeset userspace detected, disabling atomic
[   28.394732] irq 9: nobody cared (try booting with the "irqpoll" option)
[   28.394754] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.17.0+ #39
[   28.394770] Hardware name: Apple Inc. MacBookPro11,1/Mac-189A3D4F975D5FFC, BIOS 432.60.3.0.0 10/27/2021
[   28.394788] Call Trace:
[   28.394798]  <IRQ>
[   28.394807]  dump_stack_lvl+0x38/0x49
[   28.394823]  dump_stack+0x10/0x12
[   28.394834]  __report_bad_irq+0x37/0xb1
[   28.394847]  note_interrupt.cold.11+0xb/0x5c
[   28.394859]  handle_irq_event_percpu+0x33/0x40
[   28.394873]  handle_irq_event+0x34/0x60
[   28.394885]  handle_fasteoi_irq+0x8b/0x130
[   28.394897]  __common_interrupt+0x39/0x90
[   28.394912]  common_interrupt+0x85/0xa0
[   28.394925]  </IRQ>
[   28.394933]  <TASK>
[   28.394941]  asm_common_interrupt+0x1e/0x40
[   28.394954] RIP: 0010:cpuidle_enter_state+0xc9/0x360
[   28.394969] Code: 89 c4 0f 1f 44 00 00 31 ff e8 23 dc b5 ff 80 7d d7 00 74 12 9c 58 f6 c4 02 0f 85 54 02 00 00 31 ff e8 1b 55 ba ff fb 45 85 ff <0f> 88 0e 01 00 00 49 63 cf 4c 2b 65 c8 48 89 c8 48 6b d1 68 48 c1
[   28.394999] RSP: 0018:ffff9f8ac01cfe60 EFLAGS: 00000202
[   28.395013] RAX: ffff9f8e1f2a9140 RBX: 0000000000000008 RCX: 000000000000001f
[   28.395028] RDX: 000000069c74c193 RSI: 00000000313b14ef RDI: 0000000000000000
[   28.395043] RBP: ffff9f8ac01cfe98 R08: 0000000000000002 R09: 0000000000028a00
[   28.395058] R10: 00000017dc2e76b6 R11: ffff9f8e1f2a82a4 R12: 000000069c74c193
[   28.395073] R13: ffffd4b57fcb2d10 R14: ffffffffb91aa760 R15: 0000000000000008
[   28.395089]  cpuidle_enter+0x29/0x40
[   28.395101]  call_cpuidle+0x1e/0x30
[   28.395114]  do_idle+0x1ed/0x210
[   28.395126]  cpu_startup_entry+0x18/0x20
[   28.395139]  start_secondary+0xed/0x110
[   28.395153]  secondary_startup_64_no_verify+0xc3/0xcb
[   28.395167]  </TASK>
[   28.395176] handlers:
[   28.395184] [<00000000a6729c5b>] acpi_irq
[   28.395199] Disabling IRQ #9
[   35.564614] ieee80211 phy0: brcmf_cfg80211_scan: Connecting: status (3)
[   36.564875] ieee80211 phy0: brcmf_cfg80211_scan: Connecting: status (3)
[   37.362654] pcieport 0000:06:03.0: pciehp: Slot(3-2): Link Down
[   37.362654] thunderbolt 0000:07:00.0: acking hot unplug event on 0:1
[   37.362673] thunderbolt 0000:07:00.0: 0:1: switch unplugged
[   37.362727] thunderbolt 0000:07:00.0: acking hot unplug event on 0:2
[   37.363760] thunderbolt 0000:07:00.0: 0:6 <-> 1:a (PCI): deactivating
[   37.363761] pcieport 0000:06:03.0: pciehp: Slot(3-2): Card not present
[   37.363774] pcieport 0000:09:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.363783] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 1:10 to 0:6
[   37.366313] pcieport 0000:10:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.366531] pcieport 0000:10:04.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.366672] pcieport 0000:10:02.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.370158] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 0:6 to 1:10
[   37.372598] thunderbolt 0000:07:00.0: 0:b <-> 1:b (DP): deactivating
[   37.373363] thunderbolt 0000:07:00.0: deactivating Video path from 0:11 to 1:11
[   37.373749] thunderbolt 0000:07:00.0: 0:b: adding -11 NFC credits to 11
[   37.373875] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:11 to 1:11
[   37.374258] thunderbolt 0000:07:00.0: deactivating AUX RX path from 1:11 to 0:11
[   37.374640] thunderbolt 0000:07:00.0: 0: released DP resource for port 11
[   37.374649] thunderbolt 0000:07:00.0: 1:7 <-> 301:a (PCI): deactivating
[   37.374652] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 301:10 to 1:7
[   37.374656] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 1:7 to 301:10
[   37.374660] thunderbolt 0000:07:00.0: 0:c <-> 301:b (DP): deactivating
[   37.375409] thunderbolt 0000:07:00.0: deactivating Video path from 0:12 to 301:11
[   37.375792] thunderbolt 0000:07:00.0: 0:c: adding -12 NFC credits to 12
[   37.375918] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:12 to 301:11
[   37.376303] thunderbolt 0000:07:00.0: deactivating AUX RX path from 301:11 to 0:12
[   37.376692] thunderbolt 0000:07:00.0: 0: released DP resource for port 12
[   37.376698] thunderbolt 0000:07:00.0: 301:b: DP OUT resource unavailable
[   37.376796] thunderbolt 0-301: device disconnected
[   37.376876] thunderbolt 0-1: device disconnected
[   37.377010] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   37.377075] thunderbolt 0000:07:00.0: 0:b: DP IN available
[   37.377155] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   37.377158] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
[   37.377164] thunderbolt 0000:07:00.0: 0:2: got unplug event for disconnected port, ignoring
[   37.383564] pcieport 0000:0b:03.0: can't change power state from D0 to D3hot (config space inaccessible)
[   37.383583] pcieport 0000:12:03.0: can't change power state from D0 to D3hot (config space inaccessible)
[   37.383608] pcieport 0000:09:00.0: can't change power state from D0 to D3hot (config space inaccessible)
[   37.383620] pcieport 0000:10:00.0: can't change power state from D0 to D3hot (config space inaccessible)
[   37.433658] pcieport 0000:10:01.0: can't change power state from D0 to D3hot (config space inaccessible)
[   37.433665] pcieport 0000:10:01.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.433875] pcieport 0000:10:00.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.433881] pci 0000:11:00.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.433883] pcieport 0000:12:03.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.436900] pcieport 0000:09:02.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.543673] pcieport 0000:09:01.0: can't change power state from D0 to D3hot (config space inaccessible)
[   37.544863] pcieport 0000:09:01.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.546143] pcieport 0000:09:00.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.547332] pci 0000:0a:00.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.548537] pcieport 0000:0b:03.0: can't change power state from D3cold to D0 (config space inaccessible)
[   37.550063] pci 0000:0c:00.0: Removing from iommu group 16
[   37.551386] pci 0000:0c:00.1: Removing from iommu group 16
[   37.552649] pci 0000:0c:00.2: Removing from iommu group 16
[   37.553865] pci_bus 0000:0c: busn_res: [bus 0c] is released
[   37.553920] pci 0000:0b:03.0: Removing from iommu group 16
[   37.553930] pci_bus 0000:0b: busn_res: [bus 0b-0c] is released
[   37.554354] pci 0000:0a:00.0: Removing from iommu group 16
[   37.557803] pci_bus 0000:0a: busn_res: [bus 0a-0c] is released
[   37.557805] acpiphp: Slot [1-1] unregistered
[   37.557866] pci 0000:09:00.0: Removing from iommu group 16
[   37.558402] pci 0000:0d:00.0: Removing from iommu group 16
[   37.558475] pci_bus 0000:0d: busn_res: [bus 0d] is released
[   37.559483] pci 0000:09:01.0: Removing from iommu group 16
[   37.559826] pci 0000:0e:00.0: Removing from iommu group 16
[   37.566150] pci_bus 0000:0e: busn_res: [bus 0e] is released
[   37.566153] ieee80211 phy0: brcmf_cfg80211_scan: Connecting: status (3)
[   37.567107] pci 0000:09:02.0: Removing from iommu group 16
[   37.569266] pci 0000:13:00.0: Removing from iommu group 16
[   37.570220] pci 0000:13:00.1: Removing from iommu group 16
[   37.570325] pci 0000:13:00.2: Removing from iommu group 16
[   37.570344] pci_bus 0000:13: busn_res: [bus 13] is released
[   37.570381] pci 0000:12:03.0: Removing from iommu group 16
[   37.570387] pci_bus 0000:12: busn_res: [bus 12-13] is released
[   37.572514] pci 0000:11:00.0: Removing from iommu group 16
[   37.577940] pci_bus 0000:11: busn_res: [bus 11-13] is released
[   37.578838] acpiphp: Slot [1-3] unregistered
[   37.578984] pci 0000:10:00.0: Removing from iommu group 16
[   37.580889] pci 0000:14:00.0: Removing from iommu group 16
[   37.580906] pci_bus 0000:14: busn_res: [bus 14] is released
[   37.580939] pci 0000:10:01.0: Removing from iommu group 16
[   37.581667] pci 0000:15:00.0: Removing from iommu group 16
[   37.581761] pci_bus 0000:15: busn_res: [bus 15] is released
[   37.583135] pci 0000:10:02.0: Removing from iommu group 16
[   37.588567] pci_bus 0000:16: busn_res: [bus 16] is released
[   37.589531] pci 0000:10:04.0: Removing from iommu group 16
[   37.589537] pci_bus 0000:17: busn_res: [bus 17] is released
[   37.590970] pci 0000:10:05.0: Removing from iommu group 16
[   37.591021] pci_bus 0000:10: busn_res: [bus 10-17] is released
[   37.591022] acpiphp: Slot [1-2] unregistered
[   37.591215] acpiphp: Slot [2-1] unregistered
[   37.591406] acpiphp: Slot [3-1] unregistered
[   37.591585] acpiphp: Slot [4-1] unregistered
[   37.594026] pci 0000:0f:00.0: Removing from iommu group 16
[   37.600584] pci_bus 0000:0f: busn_res: [bus 0f-17] is released
[   37.600640] pci 0000:09:04.0: Removing from iommu group 16
[   37.600670] pci_bus 0000:18: busn_res: [bus 18] is released
[   37.600726] pci 0000:09:05.0: Removing from iommu group 16
[   37.600732] pci_bus 0000:09: busn_res: [bus 09-18] is released
[   37.600734] acpiphp: Slot [1] unregistered
[   37.600741] acpiphp: Slot [2] unregistered
[   37.600745] acpiphp: Slot [3] unregistered
[   37.600749] acpiphp: Slot [4] unregistered
[   37.600753] acpiphp: Slot [5] unregistered
[   37.600806] pci 0000:08:00.0: Removing from iommu group 16
[   42.665314] thunderbolt 0000:07:00.0: acking hot plug event on 0:2
[   42.665369] thunderbolt 0000:07:00.0: 0:2: hotplug: scanning
[   42.665374] thunderbolt 0000:07:00.0: 0:2: hotplug: no switch found
[   42.696717] thunderbolt 0000:07:00.0: acking hot plug event on 0:1
[   42.696774] thunderbolt 0000:07:00.0: 0:1: hotplug: scanning
[   42.696869] thunderbolt 0000:07:00.0: 0:1: is connected, link is up (state: 2)
[   42.697116] thunderbolt 0000:07:00.0: current switch config:
[   42.697120] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   42.697135] thunderbolt 0000:07:00.0:   Max Port Number: 13
[   42.697137] thunderbolt 0000:07:00.0:   Config:
[   42.697139] thunderbolt 0000:07:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[   42.697141] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[   42.701658] thunderbolt 0000:07:00.0: initializing Switch at 0x1 (depth: 1, up port: 1)
[   42.719064] thunderbolt 0000:07:00.0: 1: reading drom (length: 0x97)
[   43.212720] thunderbolt 0000:07:00.0: 1: DROM version: 1
[   43.214640] thunderbolt 0000:07:00.0: 1: uid: 0x1000100189170
[   43.217590] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   43.217596] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   43.217598] thunderbolt 0000:07:00.0:   Max counters: 32
[   43.217599] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   43.217600] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   43.220495] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   43.220498] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   43.220499] thunderbolt 0000:07:00.0:   Max counters: 32
[   43.220500] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   43.220501] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   43.223429] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   43.223431] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   43.223432] thunderbolt 0000:07:00.0:   Max counters: 32
[   43.223433] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   43.223434] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   43.239948] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   43.239956] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   43.239957] thunderbolt 0000:07:00.0:   Max counters: 32
[   43.239959] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   43.239960] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   43.239962] thunderbolt 0000:07:00.0: 1:5: disabled by eeprom
[   43.239963] thunderbolt 0000:07:00.0: 1:6: disabled by eeprom
[   43.240811] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   43.240814] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   43.240815] thunderbolt 0000:07:00.0:   Max counters: 1
[   43.240816] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   43.240817] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   43.241717] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   43.241718] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   43.241720] thunderbolt 0000:07:00.0:   Max counters: 1
[   43.241720] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   43.241721] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   43.241722] thunderbolt 0000:07:00.0: 1:9: disabled by eeprom
[   43.242612] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   43.242614] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   43.242615] thunderbolt 0000:07:00.0:   Max counters: 1
[   43.242616] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   43.242617] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   43.243756] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   43.243759] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[   43.243760] thunderbolt 0000:07:00.0:   Max counters: 2
[   43.243761] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   43.243762] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   43.243763] thunderbolt 0000:07:00.0: 1:c: disabled by eeprom
[   43.243764] thunderbolt 0000:07:00.0: 1:d: disabled by eeprom
[   43.262060] thunderbolt 0000:07:00.0: 1: TMU: current mode: bi-directional, HiFi
[   43.262091] thunderbolt 0-1: new device found, vendor=0x1 device=0x8002
[   43.262093] thunderbolt 0-1: Apple, Inc. Thunderbolt Display
[   43.263988] thunderbolt 0000:07:00.0: 1:3: is connected, link is up (state: 2)
[   43.264245] thunderbolt 0000:07:00.0: current switch config:
[   43.264251] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   43.264254] thunderbolt 0000:07:00.0:   Max Port Number: 13
[   43.264255] thunderbolt 0000:07:00.0:   Config:
[   43.264257] thunderbolt 0000:07:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[   43.264261] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[   43.268853] thunderbolt 0000:07:00.0: initializing Switch at 0x301 (depth: 2, up port: 3)
[   43.286258] thunderbolt 0000:07:00.0: 301: reading drom (length: 0x97)
[   43.299438] thunderbolt 0000:07:00.0: acking hot plug event on 1:b
[   43.299442] thunderbolt 0000:07:00.0: acking hot plug event on 1:b
[   43.500935] thunderbolt 0000:07:00.0: acking hot plug event on 301:b
[   43.500939] thunderbolt 0000:07:00.0: acking hot plug event on 301:b
[   43.708879] ieee80211 phy0: brcmf_inetaddr_changed: fail to get arp ip table err:-52
[   43.796859] thunderbolt 0000:07:00.0: 301: DROM version: 1
[   43.797871] thunderbolt 0000:07:00.0: 301: uid: 0x100010102a740
[   43.800816] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   43.800819] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   43.800820] thunderbolt 0000:07:00.0:   Max counters: 32
[   43.800821] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   43.800822] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   43.803761] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   43.803766] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   43.803768] thunderbolt 0000:07:00.0:   Max counters: 32
[   43.803769] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   43.803770] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   43.806703] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   43.806709] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   43.806710] thunderbolt 0000:07:00.0:   Max counters: 32
[   43.806712] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   43.806714] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   43.809649] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   43.809652] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   43.809653] thunderbolt 0000:07:00.0:   Max counters: 32
[   43.809655] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   43.809656] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   43.809657] thunderbolt 0000:07:00.0: 301:5: disabled by eeprom
[   43.809659] thunderbolt 0000:07:00.0: 301:6: disabled by eeprom
[   43.810546] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   43.810550] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   43.810554] thunderbolt 0000:07:00.0:   Max counters: 1
[   43.810556] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   43.810557] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   43.811440] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   43.811442] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   43.811444] thunderbolt 0000:07:00.0:   Max counters: 1
[   43.811446] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   43.811449] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   43.811450] thunderbolt 0000:07:00.0: 301:9: disabled by eeprom
[   43.812335] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   43.812338] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   43.812339] thunderbolt 0000:07:00.0:   Max counters: 1
[   43.812341] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   43.812342] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   43.813487] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   43.813490] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[   43.813491] thunderbolt 0000:07:00.0:   Max counters: 2
[   43.813492] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   43.813497] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   43.813498] thunderbolt 0000:07:00.0: 301:c: disabled by eeprom
[   43.813500] thunderbolt 0000:07:00.0: 301:d: disabled by eeprom
[   43.831667] thunderbolt 0000:07:00.0: 301: TMU: current mode: bi-directional, HiFi
[   43.831714] thunderbolt 0-301: new device found, vendor=0x1 device=0x8002
[   43.831716] thunderbolt 0-301: Apple, Inc. Thunderbolt Display
[   43.831813] thunderbolt 0000:07:00.0: 301:1: is unplugged (state: 7)
[   43.832065] thunderbolt 0000:07:00.0: 301:b: DP adapter HPD set, queuing hotplug
[   43.832321] thunderbolt 0000:07:00.0: 1:b: DP adapter HPD set, queuing hotplug
[   43.832452] thunderbolt 0000:07:00.0: 0:6 <-> 1:a (PCI): activating
[   43.832455] thunderbolt 0000:07:00.0: activating PCIe Down path from 0:6 to 1:10
[   43.832577] thunderbolt 0000:07:00.0: 1:1: Writing hop 1
[   43.832578] thunderbolt 0000:07:00.0: 1:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[   43.832579] thunderbolt 0000:07:00.0: 1:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   43.832581] thunderbolt 0000:07:00.0: 1:1:    Counter enabled: 0 Counter index: 2047
[   43.832582] thunderbolt 0000:07:00.0: 1:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   43.832583] thunderbolt 0000:07:00.0: 1:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.833649] thunderbolt 0000:07:00.0: 0:6: Writing hop 0
[   43.834490] thunderbolt 0000:07:00.0: 0:6:  In HopID: 8 => Out port: 1 Out HopID: 8
[   43.834491] thunderbolt 0000:07:00.0: 0:6:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   43.834492] thunderbolt 0000:07:00.0: 0:6:    Counter enabled: 0 Counter index: 2047
[   43.834493] thunderbolt 0000:07:00.0: 0:6:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   43.834495] thunderbolt 0000:07:00.0: 0:6:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.834508] thunderbolt 0000:07:00.0: path activation complete
[   43.834509] thunderbolt 0000:07:00.0: activating PCIe Up path from 1:10 to 0:6
[   43.834647] thunderbolt 0000:07:00.0: 0:1: Writing hop 1
[   43.834650] thunderbolt 0000:07:00.0: 0:1:  In HopID: 8 => Out port: 6 Out HopID: 8
[   43.834652] thunderbolt 0000:07:00.0: 0:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   43.834654] thunderbolt 0000:07:00.0: 0:1:    Counter enabled: 0 Counter index: 2047
[   43.834655] thunderbolt 0000:07:00.0: 0:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   43.834657] thunderbolt 0000:07:00.0: 0:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.834897] thunderbolt 0000:07:00.0: 1:a: Writing hop 0
[   43.834899] thunderbolt 0000:07:00.0: 1:a:  In HopID: 8 => Out port: 1 Out HopID: 8
[   43.834900] thunderbolt 0000:07:00.0: 1:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   43.834901] thunderbolt 0000:07:00.0: 1:a:    Counter enabled: 0 Counter index: 2047
[   43.834903] thunderbolt 0000:07:00.0: 1:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   43.834904] thunderbolt 0000:07:00.0: 1:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.835024] thunderbolt 0000:07:00.0: path activation complete
[   43.835050] pcieport 0000:06:03.0: pciehp: Slot(3-2): Card present
[   43.835407] thunderbolt 0000:07:00.0: 1:b: DP OUT resource available
[   43.835410] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   43.835532] thunderbolt 0000:07:00.0: 0:b: DP IN available
[   43.835661] thunderbolt 0000:07:00.0: 1:b: DP OUT available
[   43.835663] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 11
[   43.835666] thunderbolt 0000:07:00.0: 1:b: calculating available bandwidth
[   43.835791] thunderbolt 0000:07:00.0: 0:1: link total bandwidth 9000 Mb/s
[   43.835793] thunderbolt 0000:07:00.0: 1:1: link total bandwidth 9000 Mb/s
[   43.835795] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[   43.835799] thunderbolt 0000:07:00.0: Tunnel link 0
[   43.835803] thunderbolt 0000:07:00.0: 0:b <-> 1:b (DP): activating
[   43.835806] thunderbolt 0000:07:00.0: activating Video path from 0:11 to 1:11
[   43.835808] thunderbolt 0000:07:00.0: 1:1: adding 12 NFC credits to 0
[   43.837224] thunderbolt 0000:07:00.0: 0:b: adding 12 NFC credits to 0
[   43.837368] thunderbolt 0000:07:00.0: 1:1: Writing hop 1
[   43.837371] thunderbolt 0000:07:00.0: 1:1:  In HopID: 9 => Out port: 11 Out HopID: 9
[   43.837374] thunderbolt 0000:07:00.0: 1:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   43.837377] thunderbolt 0000:07:00.0: 1:1:    Counter enabled: 0 Counter index: 2047
[   43.837379] thunderbolt 0000:07:00.0: 1:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   43.837382] thunderbolt 0000:07:00.0: 1:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.837622] thunderbolt 0000:07:00.0: 0:b: Writing hop 0
[   43.837624] thunderbolt 0000:07:00.0: 0:b:  In HopID: 9 => Out port: 1 Out HopID: 9
[   43.837627] thunderbolt 0000:07:00.0: 0:b:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   43.837629] thunderbolt 0000:07:00.0: 0:b:    Counter enabled: 0 Counter index: 2047
[   43.837632] thunderbolt 0000:07:00.0: 0:b:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   43.837634] thunderbolt 0000:07:00.0: 0:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.837751] thunderbolt 0000:07:00.0: path activation complete
[   43.837753] thunderbolt 0000:07:00.0: activating AUX TX path from 0:11 to 1:11
[   43.837879] thunderbolt 0000:07:00.0: 1:1: Writing hop 1
[   43.837881] thunderbolt 0000:07:00.0: 1:1:  In HopID: 10 => Out port: 11 Out HopID: 8
[   43.837883] thunderbolt 0000:07:00.0: 1:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   43.837886] thunderbolt 0000:07:00.0: 1:1:    Counter enabled: 0 Counter index: 2047
[   43.837888] thunderbolt 0000:07:00.0: 1:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   43.837890] thunderbolt 0000:07:00.0: 1:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.838137] thunderbolt 0000:07:00.0: 0:b: Writing hop 0
[   43.838139] thunderbolt 0000:07:00.0: 0:b:  In HopID: 8 => Out port: 1 Out HopID: 10
[   43.838141] thunderbolt 0000:07:00.0: 0:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   43.838144] thunderbolt 0000:07:00.0: 0:b:    Counter enabled: 0 Counter index: 2047
[   43.838146] thunderbolt 0000:07:00.0: 0:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   43.838148] thunderbolt 0000:07:00.0: 0:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.838265] thunderbolt 0000:07:00.0: path activation complete
[   43.838266] thunderbolt 0000:07:00.0: activating AUX RX path from 1:11 to 0:11
[   43.838394] thunderbolt 0000:07:00.0: 0:1: Writing hop 1
[   43.838396] thunderbolt 0000:07:00.0: 0:1:  In HopID: 9 => Out port: 11 Out HopID: 8
[   43.838398] thunderbolt 0000:07:00.0: 0:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   43.838401] thunderbolt 0000:07:00.0: 0:1:    Counter enabled: 0 Counter index: 2047
[   43.838403] thunderbolt 0000:07:00.0: 0:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   43.838406] thunderbolt 0000:07:00.0: 0:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.840963] thunderbolt 0000:07:00.0: 1:b: Writing hop 0
[   43.840965] thunderbolt 0000:07:00.0: 1:b:  In HopID: 8 => Out port: 1 Out HopID: 9
[   43.840967] thunderbolt 0000:07:00.0: 1:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   43.840970] thunderbolt 0000:07:00.0: 1:b:    Counter enabled: 0 Counter index: 2047
[   43.840972] thunderbolt 0000:07:00.0: 1:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   43.840974] thunderbolt 0000:07:00.0: 1:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.841091] thunderbolt 0000:07:00.0: path activation complete
[   43.842252] thunderbolt 0000:07:00.0: 1:7 <-> 301:a (PCI): activating
[   43.842255] thunderbolt 0000:07:00.0: activating PCIe Down path from 1:7 to 301:10
[   43.842370] thunderbolt 0000:07:00.0: 301:3: Writing hop 1
[   43.842372] thunderbolt 0000:07:00.0: 301:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[   43.842374] thunderbolt 0000:07:00.0: 301:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   43.842376] thunderbolt 0000:07:00.0: 301:3:    Counter enabled: 0 Counter index: 2047
[   43.842378] thunderbolt 0000:07:00.0: 301:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   43.842380] thunderbolt 0000:07:00.0: 301:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.842629] thunderbolt 0000:07:00.0: 1:7: Writing hop 0
[   43.842631] thunderbolt 0000:07:00.0: 1:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[   43.842632] thunderbolt 0000:07:00.0: 1:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   43.842634] thunderbolt 0000:07:00.0: 1:7:    Counter enabled: 0 Counter index: 2047
[   43.842636] thunderbolt 0000:07:00.0: 1:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   43.842638] thunderbolt 0000:07:00.0: 1:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.842756] thunderbolt 0000:07:00.0: path activation complete
[   43.842757] thunderbolt 0000:07:00.0: activating PCIe Up path from 301:10 to 1:7
[   43.842885] thunderbolt 0000:07:00.0: 1:3: Writing hop 1
[   43.842887] thunderbolt 0000:07:00.0: 1:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[   43.842889] thunderbolt 0000:07:00.0: 1:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   43.842891] thunderbolt 0000:07:00.0: 1:3:    Counter enabled: 0 Counter index: 2047
[   43.842893] thunderbolt 0000:07:00.0: 1:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   43.842895] thunderbolt 0000:07:00.0: 1:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.843140] thunderbolt 0000:07:00.0: 301:a: Writing hop 0
[   43.843142] thunderbolt 0000:07:00.0: 301:a:  In HopID: 8 => Out port: 3 Out HopID: 8
[   43.843144] thunderbolt 0000:07:00.0: 301:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   43.843146] thunderbolt 0000:07:00.0: 301:a:    Counter enabled: 0 Counter index: 2047
[   43.843148] thunderbolt 0000:07:00.0: 301:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   43.843150] thunderbolt 0000:07:00.0: 301:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.843267] thunderbolt 0000:07:00.0: path activation complete
[   43.843783] thunderbolt 0000:07:00.0: 301:b: DP OUT resource available
[   43.843787] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   43.843906] thunderbolt 0000:07:00.0: 0:b: in use
[   43.844038] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   43.844163] thunderbolt 0000:07:00.0: 1:b: in use
[   43.844291] thunderbolt 0000:07:00.0: 301:b: DP OUT available
[   43.844293] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 12
[   43.844296] thunderbolt 0000:07:00.0: 301:b: calculating available bandwidth
[   43.844423] thunderbolt 0000:07:00.0: 0:1: link total bandwidth 9000 Mb/s
[   43.844548] thunderbolt 0000:07:00.0: 0:b <-> 1:b (DP): consumed bandwidth 0/1296 Mb/s
[   43.844552] thunderbolt 0000:07:00.0: 1:1: link total bandwidth 9000 Mb/s
[   43.844676] thunderbolt 0000:07:00.0: 0:b <-> 1:b (DP): consumed bandwidth 0/1296 Mb/s
[   43.844803] thunderbolt 0000:07:00.0: 1:3: link total bandwidth 9000 Mb/s
[   43.844806] thunderbolt 0000:07:00.0: 301:3: link total bandwidth 9000 Mb/s
[   43.844808] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/7704 Mb/s
[   43.844812] thunderbolt 0000:07:00.0: Tunnel link 0
[   43.844817] thunderbolt 0000:07:00.0: 0:c <-> 301:b (DP): activating
[   43.844819] thunderbolt 0000:07:00.0: activating Video path from 0:12 to 301:11
[   43.844822] thunderbolt 0000:07:00.0: 301:3: adding 12 NFC credits to 0
[   43.844930] thunderbolt 0000:07:00.0: 1:1: adding 12 NFC credits to 12
[   43.845057] thunderbolt 0000:07:00.0: 0:c: adding 12 NFC credits to 0
[   43.845314] thunderbolt 0000:07:00.0: 301:3: Writing hop 2
[   43.845316] thunderbolt 0000:07:00.0: 301:3:  In HopID: 9 => Out port: 11 Out HopID: 9
[   43.845318] thunderbolt 0000:07:00.0: 301:3:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   43.845321] thunderbolt 0000:07:00.0: 301:3:    Counter enabled: 0 Counter index: 2047
[   43.845325] thunderbolt 0000:07:00.0: 301:3:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   43.845327] thunderbolt 0000:07:00.0: 301:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.845571] thunderbolt 0000:07:00.0: 1:1: Writing hop 1
[   43.845573] thunderbolt 0000:07:00.0: 1:1:  In HopID: 11 => Out port: 3 Out HopID: 9
[   43.845575] thunderbolt 0000:07:00.0: 1:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   43.845577] thunderbolt 0000:07:00.0: 1:1:    Counter enabled: 0 Counter index: 2047
[   43.845581] thunderbolt 0000:07:00.0: 1:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   43.845583] thunderbolt 0000:07:00.0: 1:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.845824] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[   43.845826] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 1 Out HopID: 11
[   43.845831] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   43.845832] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[   43.845834] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   43.845836] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.845952] thunderbolt 0000:07:00.0: path activation complete
[   43.845953] thunderbolt 0000:07:00.0: activating AUX TX path from 0:12 to 301:11
[   43.848900] thunderbolt 0000:07:00.0: 301:3: Writing hop 2
[   43.848902] thunderbolt 0000:07:00.0: 301:3:  In HopID: 10 => Out port: 11 Out HopID: 8
[   43.848905] thunderbolt 0000:07:00.0: 301:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   43.848907] thunderbolt 0000:07:00.0: 301:3:    Counter enabled: 0 Counter index: 2047
[   43.848908] thunderbolt 0000:07:00.0: 301:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   43.848910] thunderbolt 0000:07:00.0: 301:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.849157] thunderbolt 0000:07:00.0: 1:1: Writing hop 1
[   43.849159] thunderbolt 0000:07:00.0: 1:1:  In HopID: 12 => Out port: 3 Out HopID: 10
[   43.849161] thunderbolt 0000:07:00.0: 1:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   43.849164] thunderbolt 0000:07:00.0: 1:1:    Counter enabled: 0 Counter index: 2047
[   43.849166] thunderbolt 0000:07:00.0: 1:1:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   43.849168] thunderbolt 0000:07:00.0: 1:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.849413] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[   43.849414] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 1 Out HopID: 12
[   43.849416] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   43.849418] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[   43.849419] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   43.849421] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.849542] thunderbolt 0000:07:00.0: path activation complete
[   43.849544] thunderbolt 0000:07:00.0: activating AUX RX path from 301:11 to 0:12
[   43.849671] thunderbolt 0000:07:00.0: 0:1: Writing hop 2
[   43.849673] thunderbolt 0000:07:00.0: 0:1:  In HopID: 10 => Out port: 12 Out HopID: 8
[   43.849675] thunderbolt 0000:07:00.0: 0:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   43.849677] thunderbolt 0000:07:00.0: 0:1:    Counter enabled: 0 Counter index: 2047
[   43.849679] thunderbolt 0000:07:00.0: 0:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   43.849681] thunderbolt 0000:07:00.0: 0:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.849924] thunderbolt 0000:07:00.0: 1:3: Writing hop 1
[   43.849926] thunderbolt 0000:07:00.0: 1:3:  In HopID: 9 => Out port: 1 Out HopID: 10
[   43.849928] thunderbolt 0000:07:00.0: 1:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   43.849930] thunderbolt 0000:07:00.0: 1:3:    Counter enabled: 0 Counter index: 2047
[   43.849931] thunderbolt 0000:07:00.0: 1:3:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   43.849936] thunderbolt 0000:07:00.0: 1:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.850183] thunderbolt 0000:07:00.0: 301:b: Writing hop 0
[   43.850186] thunderbolt 0000:07:00.0: 301:b:  In HopID: 8 => Out port: 3 Out HopID: 9
[   43.850188] thunderbolt 0000:07:00.0: 301:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   43.850190] thunderbolt 0000:07:00.0: 301:b:    Counter enabled: 0 Counter index: 2047
[   43.850195] thunderbolt 0000:07:00.0: 301:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   43.850197] thunderbolt 0000:07:00.0: 301:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   43.850309] thunderbolt 0000:07:00.0: path activation complete
[   44.023607] pci 0000:08:00.0: [8086:1513] type 01 class 0x060400
[   44.023699] pci 0000:08:00.0: enabling Extended Tags
[   44.023870] pci 0000:08:00.0: supports D1 D2
[   44.023871] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.024059] pci 0000:08:00.0: Adding to iommu group 16
[   44.029144] pcieport 0000:06:03.0: ASPM: current common clock configuration is inconsistent, reconfiguring
[   44.053577] pci 0000:08:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.053755] acpiphp: Slot [1] registered
[   44.053785] acpiphp: Slot [2] registered
[   44.053813] acpiphp: Slot [3] registered
[   44.053846] acpiphp: Slot [4] registered
[   44.053880] acpiphp: Slot [5] registered
[   44.053946] pci 0000:09:00.0: [8086:1513] type 01 class 0x060400
[   44.054045] pci 0000:09:00.0: enabling Extended Tags
[   44.054223] pci 0000:09:00.0: supports D1 D2
[   44.054225] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.054928] pci 0000:09:00.0: Adding to iommu group 16
[   44.068759] pci 0000:09:01.0: [8086:1513] type 01 class 0x060400
[   44.068864] pci 0000:09:01.0: enabling Extended Tags
[   44.069047] pci 0000:09:01.0: supports D1 D2
[   44.069049] pci 0000:09:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.069325] pci 0000:09:01.0: Adding to iommu group 16
[   44.069412] pci 0000:09:02.0: [8086:1513] type 01 class 0x060400
[   44.069508] pci 0000:09:02.0: enabling Extended Tags
[   44.069671] pci 0000:09:02.0: supports D1 D2
[   44.069672] pci 0000:09:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.069814] pci 0000:09:02.0: Adding to iommu group 16
[   44.069890] pci 0000:09:04.0: [8086:1513] type 01 class 0x060400
[   44.069988] pci 0000:09:04.0: enabling Extended Tags
[   44.070166] pci 0000:09:04.0: supports D1 D2
[   44.070168] pci 0000:09:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.070424] pci 0000:09:04.0: Adding to iommu group 16
[   44.087582] pci 0000:09:05.0: [8086:1513] type 01 class 0x060400
[   44.087682] pci 0000:09:05.0: enabling Extended Tags
[   44.087869] pci 0000:09:05.0: supports D1 D2
[   44.087870] pci 0000:09:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.088201] pci 0000:09:05.0: Adding to iommu group 16
[   44.088295] pci 0000:08:00.0: PCI bridge to [bus 09-38]
[   44.088307] pci 0000:08:00.0:   bridge window [io  0x0000-0x0fff]
[   44.088313] pci 0000:08:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.088324] pci 0000:08:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.088328] pci 0000:09:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.088342] pci 0000:09:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.088355] pci 0000:09:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.088368] pci 0000:09:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.088382] pci 0000:09:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.088838] acpiphp: Slot [1-1] registered
[   44.088902] pci 0000:0a:00.0: [12d8:400c] type 01 class 0x060400
[   44.089264] pci 0000:0a:00.0: supports D1 D2
[   44.089267] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.089496] pci 0000:0a:00.0: Adding to iommu group 16
[   44.113568] pci 0000:09:00.0: PCI bridge to [bus 0a-38]
[   44.113582] pci 0000:09:00.0:   bridge window [io  0x0000-0x0fff]
[   44.113588] pci 0000:09:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.113599] pci 0000:09:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.113604] pci 0000:0a:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.113832] pci 0000:0b:03.0: [12d8:400c] type 01 class 0x060400
[   44.114152] pci 0000:0b:03.0: supports D1 D2
[   44.120418] pci 0000:0b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.121531] pci 0000:0b:03.0: Adding to iommu group 16
[   44.121658] pci 0000:0a:00.0: PCI bridge to [bus 0b-38]
[   44.121674] pci 0000:0a:00.0:   bridge window [io  0x0000-0x0fff]
[   44.121683] pci 0000:0a:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.121699] pci 0000:0a:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.121705] pci 0000:0b:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.122022] pci 0000:0c:00.0: [12d8:400e] type 00 class 0x0c0310
[   44.122065] pci 0000:0c:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   44.122335] pci 0000:0c:00.0: supports D1 D2
[   44.122341] pci 0000:0c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.122647] pci 0000:0c:00.0: Adding to iommu group 16
[   44.122728] pci 0000:0c:00.1: [12d8:400e] type 00 class 0x0c0310
[   44.122771] pci 0000:0c:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   44.135261] pci 0000:0c:00.1: supports D1 D2
[   44.135263] pci 0000:0c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   44.135351] pci 0000:0c:00.1: Adding to iommu group 16
[   44.135415] pci 0000:0c:00.2: [12d8:400f] type 00 class 0x0c0320
[   44.135458] pci 0000:0c:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   44.135729] pci 0000:0c:00.2: supports D1 D2
[   44.135731] pci 0000:0c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   44.136060] pci 0000:0c:00.2: Adding to iommu group 16
[   44.136255] pci 0000:0b:03.0: PCI bridge to [bus 0c-38]
[   44.145389] pci 0000:0b:03.0:   bridge window [io  0x0000-0x0fff]
[   44.146562] pci 0000:0b:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.146578] pci 0000:0b:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.148624] pci_bus 0000:0c: busn_res: [bus 0c-38] end is updated to 0c
[   44.148637] pci_bus 0000:0b: busn_res: [bus 0b-38] end is updated to 0c
[   44.148647] pci_bus 0000:0a: busn_res: [bus 0a-38] end is updated to 0c
[   44.148819] pci 0000:0d:00.0: [14e4:16b0] type 00 class 0x020000
[   44.148879] pci 0000:0d:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   44.148915] pci 0000:0d:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   44.149236] pci 0000:0d:00.0: PME# supported from D0 D3hot D3cold
[   44.149427] pci 0000:0d:00.0: Adding to iommu group 16
[   44.173589] pci 0000:09:01.0: PCI bridge to [bus 0d-38]
[   44.173605] pci 0000:09:01.0:   bridge window [io  0x0000-0x0fff]
[   44.173612] pci 0000:09:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.173624] pci 0000:09:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.173627] pci_bus 0000:0d: busn_res: [bus 0d-38] end is updated to 0d
[   44.173796] pci 0000:0e:00.0: [11c1:5901] type 00 class 0x0c0010
[   44.173856] pci 0000:0e:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   44.174176] pci 0000:0e:00.0: supports D1 D2
[   44.181267] pci 0000:0e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.181428] pci 0000:0e:00.0: Adding to iommu group 16
[   44.213584] pci 0000:09:02.0: PCI bridge to [bus 0e-38]
[   44.213598] pci 0000:09:02.0:   bridge window [io  0x0000-0x0fff]
[   44.213604] pci 0000:09:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.213616] pci 0000:09:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.213617] pci_bus 0000:0e: busn_res: [bus 0e-38] end is updated to 0e
[   44.213848] pci 0000:0f:00.0: [8086:1513] type 01 class 0x060400
[   44.213997] pci 0000:0f:00.0: enabling Extended Tags
[   44.214257] pci 0000:0f:00.0: supports D1 D2
[   44.221278] pci 0000:0f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.223528] pci 0000:0f:00.0: Adding to iommu group 16
[   44.253577] pci 0000:09:04.0: PCI bridge to [bus 0f-38]
[   44.253591] pci 0000:09:04.0:   bridge window [io  0x0000-0x0fff]
[   44.253597] pci 0000:09:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.253609] pci 0000:09:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.253614] pci 0000:0f:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.256808] acpiphp: Slot [1-2] registered
[   44.256842] acpiphp: Slot [2-1] registered
[   44.256872] acpiphp: Slot [3-1] registered
[   44.256903] acpiphp: Slot [4-1] registered
[   44.256993] pci 0000:10:00.0: [8086:1513] type 01 class 0x060400
[   44.269966] pci 0000:10:00.0: enabling Extended Tags
[   44.270245] pci 0000:10:00.0: supports D1 D2
[   44.270246] pci 0000:10:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.287039] pci 0000:10:00.0: Adding to iommu group 16
[   44.303322] pci 0000:10:01.0: [8086:1513] type 01 class 0x060400
[   44.303485] pci 0000:10:01.0: enabling Extended Tags
[   44.306916] pci 0000:10:01.0: supports D1 D2
[   44.306918] pci 0000:10:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.307097] pci 0000:10:01.0: Adding to iommu group 16
[   44.319997] pci 0000:10:02.0: [8086:1513] type 01 class 0x060400
[   44.320159] pci 0000:10:02.0: enabling Extended Tags
[   44.323428] pci 0000:10:02.0: supports D1 D2
[   44.326632] pci 0000:10:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.336766] pci 0000:10:02.0: Adding to iommu group 16
[   44.340107] pci 0000:10:04.0: [8086:1513] type 01 class 0x060400
[   44.340261] pci 0000:10:04.0: enabling Extended Tags
[   44.353368] pci 0000:10:04.0: supports D1 D2
[   44.353370] pci 0000:10:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.353708] pci 0000:10:04.0: Adding to iommu group 16
[   44.356786] pci 0000:10:05.0: [8086:1513] type 01 class 0x060400
[   44.370098] pci 0000:10:05.0: enabling Extended Tags
[   44.370373] pci 0000:10:05.0: supports D1 D2
[   44.370374] pci 0000:10:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.373645] pci 0000:10:05.0: Adding to iommu group 16
[   44.386756] pci 0000:0f:00.0: PCI bridge to [bus 10-38]
[   44.386777] pci 0000:0f:00.0:   bridge window [io  0x0000-0x0fff]
[   44.386788] pci 0000:0f:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.386806] pci 0000:0f:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.386814] pci 0000:10:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.386839] pci 0000:10:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.386862] pci 0000:10:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.386885] pci 0000:10:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.386909] pci 0000:10:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.390075] acpiphp: Slot [1-3] registered
[   44.390165] pci 0000:11:00.0: [12d8:400c] type 01 class 0x060400
[   44.420049] pci 0000:11:00.0: supports D1 D2
[   44.420051] pci 0000:11:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.420903] pci 0000:11:00.0: Adding to iommu group 16
[   44.423837] pci 0000:10:00.0: PCI bridge to [bus 11-38]
[   44.440093] pci 0000:10:00.0:   bridge window [io  0x0000-0x0fff]
[   44.440104] pci 0000:10:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.440122] pci 0000:10:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.440129] pci 0000:11:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.440448] pci 0000:12:03.0: [12d8:400c] type 01 class 0x060400
[   44.453723] pci 0000:12:03.0: supports D1 D2
[   44.453725] pci 0000:12:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.456867] pci 0000:12:03.0: Adding to iommu group 16
[   44.457032] pci 0000:11:00.0: PCI bridge to [bus 12-38]
[   44.457055] pci 0000:11:00.0:   bridge window [io  0x0000-0x0fff]
[   44.457067] pci 0000:11:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.457089] pci 0000:11:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.457096] pci 0000:12:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   44.470204] pci 0000:13:00.0: [12d8:400e] type 00 class 0x0c0310
[   44.470262] pci 0000:13:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   44.473615] pci 0000:13:00.0: supports D1 D2
[   44.477141] pci 0000:13:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.486898] pci 0000:13:00.0: Adding to iommu group 16
[   44.486993] pci 0000:13:00.1: [12d8:400e] type 00 class 0x0c0310
[   44.487052] pci 0000:13:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   44.490418] pci 0000:13:00.1: supports D1 D2
[   44.492629] pci 0000:13:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   44.503507] pci 0000:13:00.1: Adding to iommu group 16
[   44.506880] pci 0000:13:00.2: [12d8:400f] type 00 class 0x0c0320
[   44.506937] pci 0000:13:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   44.523539] pci 0000:13:00.2: supports D1 D2
[   44.523541] pci 0000:13:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   44.523663] pci 0000:13:00.2: Adding to iommu group 16
[   44.523931] pci 0000:12:03.0: PCI bridge to [bus 13-38]
[   44.536763] pci 0000:12:03.0:   bridge window [io  0x0000-0x0fff]
[   44.553436] pci 0000:12:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.553461] pci 0000:12:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.553463] pci_bus 0000:13: busn_res: [bus 13-38] end is updated to 13
[   44.553478] pci_bus 0000:12: busn_res: [bus 12-38] end is updated to 13
[   44.553491] pci_bus 0000:11: busn_res: [bus 11-38] end is updated to 13
[   44.553719] pci 0000:14:00.0: [14e4:16b0] type 00 class 0x020000
[   44.553802] pci 0000:14:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   44.553854] pci 0000:14:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   44.557259] pci 0000:14:00.0: PME# supported from D0 D3hot D3cold
[   44.570342] pci 0000:14:00.0: Adding to iommu group 16
[   44.570489] pci 0000:10:01.0: PCI bridge to [bus 14-38]
[   44.570508] pci 0000:10:01.0:   bridge window [io  0x0000-0x0fff]
[   44.570518] pci 0000:10:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.570536] pci 0000:10:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.570538] pci_bus 0000:14: busn_res: [bus 14-38] end is updated to 14
[   44.586987] pci 0000:15:00.0: [11c1:5901] type 00 class 0x0c0010
[   44.603553] pci 0000:15:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   44.606991] pci 0000:15:00.0: supports D1 D2
[   44.606993] pci 0000:15:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   44.607219] pci 0000:15:00.0: Adding to iommu group 16
[   44.620189] pci 0000:10:02.0: PCI bridge to [bus 15-38]
[   44.620209] pci 0000:10:02.0:   bridge window [io  0x0000-0x0fff]
[   44.620220] pci 0000:10:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.620238] pci 0000:10:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.620242] pci_bus 0000:15: busn_res: [bus 15-38] end is updated to 15
[   44.620462] pci 0000:10:04.0: PCI bridge to [bus 16-38]
[   44.620481] pci 0000:10:04.0:   bridge window [io  0x0000-0x0fff]
[   44.620490] pci 0000:10:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.636845] pci 0000:10:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.636848] pci_bus 0000:16: busn_res: [bus 16-38] end is updated to 1f
[   44.637004] pci 0000:10:05.0: PCI bridge to [bus 20-38]
[   44.637023] pci 0000:10:05.0:   bridge window [io  0x0000-0x0fff]
[   44.637032] pci 0000:10:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.637050] pci 0000:10:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.637051] pci_bus 0000:20: busn_res: [bus 20-38] end is updated to 25
[   44.637062] pci_bus 0000:10: busn_res: [bus 10-38] end is updated to 25
[   44.637072] pci_bus 0000:0f: busn_res: [bus 0f-38] end is updated to 25
[   44.640262] pci 0000:09:05.0: PCI bridge to [bus 26-38]
[   44.640276] pci 0000:09:05.0:   bridge window [io  0x0000-0x0fff]
[   44.640283] pci 0000:09:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   44.640296] pci 0000:09:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   44.640298] pci_bus 0000:26: busn_res: [bus 26-38] end is updated to 38
[   44.640307] pci_bus 0000:09: busn_res: [bus 09-38] end is updated to 38
[   44.640325] pci 0000:10:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 16-1f] add_size 100000 add_align 100000
[   44.655959] pci 0000:10:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 16-1f] add_size 100000 add_align 100000
[   44.656951] pci 0000:10:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 20-25] add_size 100000 add_align 100000
[   44.658014] pci 0000:10:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 20-25] add_size 100000 add_align 100000
[   44.658017] pci 0000:0f:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 10-25] add_size 200000 add_align 100000
[   44.658019] pci 0000:0f:00.0: bridge window [mem 0x00100000-0x005fffff] to [bus 10-25] add_size 200000 add_align 100000
[   44.658020] pci 0000:09:04.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 0f-25] add_size 200000 add_align 100000
[   44.658022] pci 0000:09:04.0: bridge window [mem 0x00100000-0x005fffff] to [bus 0f-25] add_size 200000 add_align 100000
[   44.658023] pci 0000:09:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 26-38] add_size 100000 add_align 100000
[   44.658024] pci 0000:09:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 26-38] add_size 100000 add_align 100000
[   44.658027] pci 0000:08:00.0: bridge window [mem 0x00100000-0x009fffff 64bit pref] to [bus 09-38] add_size 300000 add_align 100000
[   44.666146] pci 0000:08:00.0: bridge window [mem 0x00100000-0x009fffff] to [bus 09-38] add_size 300000 add_align 100000
[   44.666155] pci 0000:08:00.0: BAR 8: assigned [mem 0xb0e00000-0xb51fffff]
[   44.666158] pci 0000:08:00.0: BAR 9: assigned [mem 0xbd200000-0xc13fffff 64bit pref]
[   44.666160] pci 0000:08:00.0: BAR 7: assigned [io  0x3000-0x3fff]
[   44.666163] pci 0000:09:00.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[   44.666166] pci 0000:09:00.0: BAR 9: assigned [mem 0xbd200000-0xbd2fffff 64bit pref]
[   44.666168] pci 0000:09:01.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[   44.666170] pci 0000:09:01.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   44.666172] pci 0000:09:02.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[   44.666173] pci 0000:09:02.0: BAR 9: assigned [mem 0xbd400000-0xbd4fffff 64bit pref]
[   44.666175] pci 0000:09:04.0: BAR 8: assigned [mem 0xb1100000-0xb317ffff]
[   44.666177] pci 0000:09:04.0: BAR 9: assigned [mem 0xbd500000-0xbf47ffff 64bit pref]
[   44.666178] pci 0000:09:05.0: BAR 8: assigned [mem 0xb3200000-0xb51fffff]
[   44.666181] pci 0000:09:05.0: BAR 9: assigned [mem 0xbf500000-0xc13fffff 64bit pref]
[   44.666183] pci 0000:09:00.0: BAR 7: assigned [io  0x3000-0x3fff]
[   44.666185] pci 0000:09:01.0: BAR 7: no space for [io  size 0x1000]
[   44.666186] pci 0000:09:01.0: BAR 7: failed to assign [io  size 0x1000]
[   44.666188] pci 0000:09:02.0: BAR 7: no space for [io  size 0x1000]
[   44.666189] pci 0000:09:02.0: BAR 7: failed to assign [io  size 0x1000]
[   44.666191] pci 0000:09:04.0: BAR 7: no space for [io  size 0x5000]
[   44.666192] pci 0000:09:04.0: BAR 7: failed to assign [io  size 0x5000]
[   44.666194] pci 0000:09:05.0: BAR 7: no space for [io  size 0x1000]
[   44.666195] pci 0000:09:05.0: BAR 7: failed to assign [io  size 0x1000]
[   44.666198] pci 0000:0a:00.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[   44.666200] pci 0000:0a:00.0: BAR 9: assigned [mem 0xbd200000-0xbd2fffff 64bit pref]
[   44.666202] pci 0000:0a:00.0: BAR 7: assigned [io  0x3000-0x3fff]
[   44.666204] pci 0000:0b:03.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[   44.666206] pci 0000:0b:03.0: BAR 9: assigned [mem 0xbd200000-0xbd2fffff 64bit pref]
[   44.666208] pci 0000:0b:03.0: BAR 7: assigned [io  0x3000-0x3fff]
[   44.666211] pci 0000:0c:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff]
[   44.670192] pci 0000:0c:00.1: BAR 0: assigned [mem 0xb0e01000-0xb0e01fff]
[   44.703558] pci 0000:0c:00.2: BAR 0: assigned [mem 0xb0e02000-0xb0e020ff]
[   44.703568] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[   44.703574] pci 0000:0b:03.0:   bridge window [io  0x3000-0x3fff]
[   44.703586] pci 0000:0b:03.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[   44.703594] pci 0000:0b:03.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[   44.703610] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[   44.720232] pci 0000:0a:00.0:   bridge window [io  0x3000-0x3fff]
[   44.720246] pci 0000:0a:00.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[   44.720255] pci 0000:0a:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[   44.720271] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[   44.720275] pci 0000:09:00.0:   bridge window [io  0x3000-0x3fff]
[   44.720285] pci 0000:09:00.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[   44.720291] pci 0000:09:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[   44.720305] pci 0000:0d:00.0: BAR 0: assigned [mem 0xbd300000-0xbd30ffff 64bit pref]
[   44.720333] pci 0000:0d:00.0: BAR 2: assigned [mem 0xbd310000-0xbd31ffff 64bit pref]
[   44.720360] pci 0000:09:01.0: PCI bridge to [bus 0d]
[   44.720369] pci 0000:09:01.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[   44.720375] pci 0000:09:01.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   44.720387] pci 0000:0e:00.0: BAR 0: assigned [mem 0xb1000000-0xb1000fff 64bit]
[   44.720414] pci 0000:09:02.0: PCI bridge to [bus 0e]
[   44.720423] pci 0000:09:02.0:   bridge window [mem 0xb1000000-0xb10fffff]
[   44.720429] pci 0000:09:02.0:   bridge window [mem 0xbd400000-0xbd4fffff 64bit pref]
[   44.720441] pci 0000:0f:00.0: BAR 8: assigned [mem 0xb1100000-0xb317ffff]
[   44.720442] pci 0000:0f:00.0: BAR 9: assigned [mem 0xbd500000-0xbf47ffff 64bit pref]
[   44.720444] pci 0000:0f:00.0: BAR 7: no space for [io  size 0x5000]
[   44.720445] pci 0000:0f:00.0: BAR 7: failed to assign [io  size 0x5000]
[   44.720447] pci 0000:10:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   44.720449] pci 0000:10:00.0: BAR 9: assigned [mem 0xbd500000-0xbd5fffff 64bit pref]
[   44.720450] pci 0000:10:01.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[   44.720451] pci 0000:10:01.0: BAR 9: assigned [mem 0xbd600000-0xbd6fffff 64bit pref]
[   44.720452] pci 0000:10:02.0: BAR 8: assigned [mem 0xb1300000-0xb13fffff]
[   44.720453] pci 0000:10:02.0: BAR 9: assigned [mem 0xbd700000-0xbd7fffff 64bit pref]
[   44.720455] pci 0000:10:04.0: BAR 8: assigned [mem 0xb1400000-0xb22bffff]
[   44.720456] pci 0000:10:04.0: BAR 9: assigned [mem 0xbd800000-0xbe63ffff 64bit pref]
[   44.720457] pci 0000:10:05.0: BAR 8: assigned [mem 0xb2300000-0xb317ffff]
[   44.720458] pci 0000:10:05.0: BAR 9: assigned [mem 0xbe700000-0xbf47ffff 64bit pref]
[   44.720459] pci 0000:10:00.0: BAR 7: no space for [io  size 0x1000]
[   44.720460] pci 0000:10:00.0: BAR 7: failed to assign [io  size 0x1000]
[   44.720461] pci 0000:10:01.0: BAR 7: no space for [io  size 0x1000]
[   44.720462] pci 0000:10:01.0: BAR 7: failed to assign [io  size 0x1000]
[   44.720463] pci 0000:10:02.0: BAR 7: no space for [io  size 0x1000]
[   44.720464] pci 0000:10:02.0: BAR 7: failed to assign [io  size 0x1000]
[   44.720464] pci 0000:10:04.0: BAR 7: no space for [io  size 0x1000]
[   44.720465] pci 0000:10:04.0: BAR 7: failed to assign [io  size 0x1000]
[   44.720466] pci 0000:10:05.0: BAR 7: no space for [io  size 0x1000]
[   44.720467] pci 0000:10:05.0: BAR 7: failed to assign [io  size 0x1000]
[   44.720468] pci 0000:11:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   44.720470] pci 0000:11:00.0: BAR 9: assigned [mem 0xbd500000-0xbd5fffff 64bit pref]
[   44.720471] pci 0000:11:00.0: BAR 7: no space for [io  size 0x1000]
[   44.720471] pci 0000:11:00.0: BAR 7: failed to assign [io  size 0x1000]
[   44.720473] pci 0000:12:03.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   44.720474] pci 0000:12:03.0: BAR 9: assigned [mem 0xbd500000-0xbd5fffff 64bit pref]
[   44.720475] pci 0000:12:03.0: BAR 7: no space for [io  size 0x1000]
[   44.720476] pci 0000:12:03.0: BAR 7: failed to assign [io  size 0x1000]
[   44.720477] pci 0000:13:00.0: BAR 0: assigned [mem 0xb1100000-0xb1100fff]
[   44.720489] pci 0000:13:00.1: BAR 0: assigned [mem 0xb1101000-0xb1101fff]
[   44.720500] pci 0000:13:00.2: BAR 0: assigned [mem 0xb1102000-0xb11020ff]
[   44.720511] pci 0000:12:03.0: PCI bridge to [bus 13]
[   44.720527] pci 0000:12:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   44.720538] pci 0000:12:03.0:   bridge window [mem 0xbd500000-0xbd5fffff 64bit pref]
[   44.720559] pci 0000:11:00.0: PCI bridge to [bus 12-13]
[   44.720575] pci 0000:11:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   44.720586] pci 0000:11:00.0:   bridge window [mem 0xbd500000-0xbd5fffff 64bit pref]
[   44.720608] pci 0000:10:00.0: PCI bridge to [bus 11-13]
[   44.720621] pci 0000:10:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   44.720630] pci 0000:10:00.0:   bridge window [mem 0xbd500000-0xbd5fffff 64bit pref]
[   44.720648] pci 0000:14:00.0: BAR 0: assigned [mem 0xbd600000-0xbd60ffff 64bit pref]
[   44.736926] pci 0000:14:00.0: BAR 2: assigned [mem 0xbd610000-0xbd61ffff 64bit pref]
[   44.803668] pci 0000:10:01.0: PCI bridge to [bus 14]
[   44.803682] pci 0000:10:01.0:   bridge window [mem 0xb1200000-0xb12fffff]
[   44.803692] pci 0000:10:01.0:   bridge window [mem 0xbd600000-0xbd6fffff 64bit pref]
[   44.803710] pci 0000:15:00.0: BAR 0: assigned [mem 0xb1300000-0xb1300fff 64bit]
[   44.803748] pci 0000:10:02.0: PCI bridge to [bus 15]
[   44.803761] pci 0000:10:02.0:   bridge window [mem 0xb1300000-0xb13fffff]
[   44.803770] pci 0000:10:02.0:   bridge window [mem 0xbd700000-0xbd7fffff 64bit pref]
[   44.803788] pci 0000:10:04.0: PCI bridge to [bus 16-1f]
[   44.803801] pci 0000:10:04.0:   bridge window [mem 0xb1400000-0xb22bffff]
[   44.803810] pci 0000:10:04.0:   bridge window [mem 0xbd800000-0xbe63ffff 64bit pref]
[   44.803827] pci 0000:10:05.0: PCI bridge to [bus 20-25]
[   44.803840] pci 0000:10:05.0:   bridge window [mem 0xb2300000-0xb317ffff]
[   44.803849] pci 0000:10:05.0:   bridge window [mem 0xbe700000-0xbf47ffff 64bit pref]
[   44.803867] pci 0000:0f:00.0: PCI bridge to [bus 10-25]
[   44.803880] pci 0000:0f:00.0:   bridge window [mem 0xb1100000-0xb317ffff]
[   44.803889] pci 0000:0f:00.0:   bridge window [mem 0xbd500000-0xbf47ffff 64bit pref]
[   44.803907] pci 0000:09:04.0: PCI bridge to [bus 0f-25]
[   44.803916] pci 0000:09:04.0:   bridge window [mem 0xb1100000-0xb317ffff]
[   44.820314] pci 0000:09:04.0:   bridge window [mem 0xbd500000-0xbf47ffff 64bit pref]
[   44.820325] pci 0000:09:05.0: PCI bridge to [bus 26-38]
[   44.820334] pci 0000:09:05.0:   bridge window [mem 0xb3200000-0xb51fffff]
[   44.820340] pci 0000:09:05.0:   bridge window [mem 0xbf500000-0xc13fffff 64bit pref]
[   44.820352] pci 0000:08:00.0: PCI bridge to [bus 09-38]
[   44.820356] pci 0000:08:00.0:   bridge window [io  0x3000-0x3fff]
[   44.820365] pci 0000:08:00.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[   44.820371] pci 0000:08:00.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[   44.820382] pcieport 0000:06:03.0: PCI bridge to [bus 08-38]
[   44.820385] pcieport 0000:06:03.0:   bridge window [io  0x3000-0x3fff]
[   44.820389] pcieport 0000:06:03.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[   44.820392] pcieport 0000:06:03.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[   44.820398] PCI: No. 2 try to assign unassigned res
[   44.820401] pci 0000:0b:03.0: resource 7 [io  0x3000-0x3fff] released
[   44.820402] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[   44.820417] pci 0000:0a:00.0: resource 7 [io  0x3000-0x3fff] released
[   44.820418] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[   44.820433] pci 0000:09:00.0: resource 7 [io  0x3000-0x3fff] released
[   44.820434] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[   44.820447] pci 0000:08:00.0: resource 7 [io  0x3000-0x3fff] released
[   44.820448] pci 0000:08:00.0: PCI bridge to [bus 09-38]
[   44.820465] pci 0000:08:00.0: BAR 7: assigned [io  0x3000-0x3fff]
[   44.820467] pci 0000:09:00.0: BAR 7: assigned [io  0x3000-0x3fff]
[   44.820468] pci 0000:09:01.0: BAR 7: no space for [io  size 0x1000]
[   44.820469] pci 0000:09:01.0: BAR 7: failed to assign [io  size 0x1000]
[   44.820470] pci 0000:09:02.0: BAR 7: no space for [io  size 0x1000]
[   44.820471] pci 0000:09:02.0: BAR 7: failed to assign [io  size 0x1000]
[   44.820472] pci 0000:09:04.0: BAR 7: no space for [io  size 0x5000]
[   44.820473] pci 0000:09:04.0: BAR 7: failed to assign [io  size 0x5000]
[   44.820474] pci 0000:09:05.0: BAR 7: no space for [io  size 0x1000]
[   44.820475] pci 0000:09:05.0: BAR 7: failed to assign [io  size 0x1000]
[   44.820476] pci 0000:0a:00.0: BAR 7: assigned [io  0x3000-0x3fff]
[   44.820477] pci 0000:0b:03.0: BAR 7: assigned [io  0x3000-0x3fff]
[   44.820478] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[   44.820482] pci 0000:0b:03.0:   bridge window [io  0x3000-0x3fff]
[   44.820495] pci 0000:0b:03.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[   44.820503] pci 0000:0b:03.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[   44.820518] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[   44.820522] pci 0000:0a:00.0:   bridge window [io  0x3000-0x3fff]
[   44.820534] pci 0000:0a:00.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[   44.820542] pci 0000:0a:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[   44.820558] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[   44.820561] pci 0000:09:00.0:   bridge window [io  0x3000-0x3fff]
[   44.820569] pci 0000:09:00.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[   44.820576] pci 0000:09:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[   44.820587] pci 0000:09:01.0: PCI bridge to [bus 0d]
[   44.820596] pci 0000:09:01.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[   44.820602] pci 0000:09:01.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   44.820614] pci 0000:09:02.0: PCI bridge to [bus 0e]
[   44.820622] pci 0000:09:02.0:   bridge window [mem 0xb1000000-0xb10fffff]
[   44.820629] pci 0000:09:02.0:   bridge window [mem 0xbd400000-0xbd4fffff 64bit pref]
[   44.820640] pci 0000:0f:00.0: BAR 7: no space for [io  size 0x5000]
[   44.820641] pci 0000:0f:00.0: BAR 7: failed to assign [io  size 0x5000]
[   44.820643] pci 0000:10:00.0: BAR 7: no space for [io  size 0x1000]
[   44.820644] pci 0000:10:00.0: BAR 7: failed to assign [io  size 0x1000]
[   44.820644] pci 0000:10:01.0: BAR 7: no space for [io  size 0x1000]
[   44.820645] pci 0000:10:01.0: BAR 7: failed to assign [io  size 0x1000]
[   44.820646] pci 0000:10:02.0: BAR 7: no space for [io  size 0x1000]
[   44.820647] pci 0000:10:02.0: BAR 7: failed to assign [io  size 0x1000]
[   44.820648] pci 0000:10:04.0: BAR 7: no space for [io  size 0x1000]
[   44.820649] pci 0000:10:04.0: BAR 7: failed to assign [io  size 0x1000]
[   44.820649] pci 0000:10:05.0: BAR 7: no space for [io  size 0x1000]
[   44.820650] pci 0000:10:05.0: BAR 7: failed to assign [io  size 0x1000]
[   44.820651] pci 0000:11:00.0: BAR 7: no space for [io  size 0x1000]
[   44.820652] pci 0000:11:00.0: BAR 7: failed to assign [io  size 0x1000]
[   44.820653] pci 0000:12:03.0: BAR 7: no space for [io  size 0x1000]
[   44.820654] pci 0000:12:03.0: BAR 7: failed to assign [io  size 0x1000]
[   44.820655] pci 0000:12:03.0: PCI bridge to [bus 13]
[   44.820671] pci 0000:12:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   44.820682] pci 0000:12:03.0:   bridge window [mem 0xbd500000-0xbd5fffff 64bit pref]
[   44.820704] pci 0000:11:00.0: PCI bridge to [bus 12-13]
[   44.820720] pci 0000:11:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   44.883520] pci 0000:11:00.0:   bridge window [mem 0xbd500000-0xbd5fffff 64bit pref]
[   44.884524] pci 0000:10:00.0: PCI bridge to [bus 11-13]
[   44.884537] pci 0000:10:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   44.886459] pci 0000:10:00.0:   bridge window [mem 0xbd500000-0xbd5fffff 64bit pref]
[   44.886478] pci 0000:10:01.0: PCI bridge to [bus 14]
[   44.886492] pci 0000:10:01.0:   bridge window [mem 0xb1200000-0xb12fffff]
[   44.886501] pci 0000:10:01.0:   bridge window [mem 0xbd600000-0xbd6fffff 64bit pref]
[   44.886520] pci 0000:10:02.0: PCI bridge to [bus 15]
[   44.886534] pci 0000:10:02.0:   bridge window [mem 0xb1300000-0xb13fffff]
[   44.886543] pci 0000:10:02.0:   bridge window [mem 0xbd700000-0xbd7fffff 64bit pref]
[   44.886562] pci 0000:10:04.0: PCI bridge to [bus 16-1f]
[   44.886575] pci 0000:10:04.0:   bridge window [mem 0xb1400000-0xb22bffff]
[   44.886585] pci 0000:10:04.0:   bridge window [mem 0xbd800000-0xbe63ffff 64bit pref]
[   44.886603] pci 0000:10:05.0: PCI bridge to [bus 20-25]
[   44.886617] pci 0000:10:05.0:   bridge window [mem 0xb2300000-0xb317ffff]
[   44.886626] pci 0000:10:05.0:   bridge window [mem 0xbe700000-0xbf47ffff 64bit pref]
[   44.886644] pci 0000:0f:00.0: PCI bridge to [bus 10-25]
[   44.886658] pci 0000:0f:00.0:   bridge window [mem 0xb1100000-0xb317ffff]
[   44.886668] pci 0000:0f:00.0:   bridge window [mem 0xbd500000-0xbf47ffff 64bit pref]
[   44.886685] pci 0000:09:04.0: PCI bridge to [bus 0f-25]
[   44.886694] pci 0000:09:04.0:   bridge window [mem 0xb1100000-0xb317ffff]
[   44.886701] pci 0000:09:04.0:   bridge window [mem 0xbd500000-0xbf47ffff 64bit pref]
[   44.886713] pci 0000:09:05.0: PCI bridge to [bus 26-38]
[   44.886722] pci 0000:09:05.0:   bridge window [mem 0xb3200000-0xb51fffff]
[   44.886730] pci 0000:09:05.0:   bridge window [mem 0xbf500000-0xc13fffff 64bit pref]
[   44.886743] pci 0000:08:00.0: PCI bridge to [bus 09-38]
[   44.886748] pci 0000:08:00.0:   bridge window [io  0x3000-0x3fff]
[   44.886756] pci 0000:08:00.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[   44.886762] pci 0000:08:00.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[   44.886774] pcieport 0000:06:03.0: PCI bridge to [bus 08-38]
[   44.886776] pcieport 0000:06:03.0:   bridge window [io  0x3000-0x3fff]
[   44.886780] pcieport 0000:06:03.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[   44.886784] pcieport 0000:06:03.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[   44.886818] pcieport 0000:08:00.0: enabling device (0000 -> 0003)
[   44.887686] pcieport 0000:09:00.0: enabling device (0000 -> 0003)
[   44.917813] pcieport 0000:09:01.0: enabling device (0000 -> 0002)
[   44.919006] pcieport 0000:09:02.0: enabling device (0000 -> 0002)
[   44.921263] pcieport 0000:09:04.0: enabling device (0000 -> 0002)
[   44.921770] pcieport 0000:09:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   44.922369] pcieport 0000:09:05.0: enabling device (0000 -> 0002)
[   44.925049] pcieport 0000:09:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   44.925856] pcieport 0000:0a:00.0: enabling device (0000 -> 0003)
[   44.925998] pcieport 0000:0b:03.0: enabling device (0000 -> 0003)
[   44.926151] pci 0000:0c:00.0: MSI is not implemented on this device, disabling it
[   44.926153] pci 0000:0c:00.0: PME# is unreliable, disabling it
[   44.926174] pci 0000:0c:00.0: enabling device (0000 -> 0002)
[   44.926357] pci 0000:0c:00.1: MSI is not implemented on this device, disabling it
[   44.926359] pci 0000:0c:00.1: PME# is unreliable, disabling it
[   44.926373] pci 0000:0c:00.1: enabling device (0000 -> 0002)
[   44.926492] pci 0000:0c:00.2: MSI is not implemented on this device, disabling it
[   44.926494] pci 0000:0c:00.2: PME# is unreliable, disabling it
[   44.926960] pci 0000:0c:00.2: enabling device (0000 -> 0002)
[   44.938062] pci 0000:0c:00.2: EHCI: unrecognized capability 00
[   44.938088] pci 0000:0c:00.2: quirk_usb_early_handoff+0x0/0x600 took 11321 usecs
[   44.938127] tg3 0000:0d:00.0: enabling device (0000 -> 0002)
[   44.985376] tg3 0000:0d:00.0 eth0: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[   44.985383] tg3 0000:0d:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   44.985386] tg3 0000:0d:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   44.985389] tg3 0000:0d:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[   44.985659] pcieport 0000:0f:00.0: enabling device (0000 -> 0002)
[   44.990838] tg3 0000:0d:00.0 eth2: renamed from eth0
[   44.991165] pcieport 0000:10:00.0: enabling device (0000 -> 0002)
[   44.996309] pcieport 0000:10:01.0: enabling device (0000 -> 0002)
[   44.997805] pcieport 0000:10:02.0: enabling device (0000 -> 0002)
[   45.000742] pcieport 0000:10:04.0: enabling device (0000 -> 0002)
[   45.000961] pcieport 0000:10:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   45.001890] pcieport 0000:10:05.0: enabling device (0000 -> 0002)
[   45.002557] pcieport 0000:10:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   45.003949] pcieport 0000:11:00.0: enabling device (0000 -> 0002)
[   45.004184] pcieport 0000:12:03.0: enabling device (0000 -> 0002)
[   45.004434] pci 0000:13:00.0: MSI is not implemented on this device, disabling it
[   45.004436] pci 0000:13:00.0: PME# is unreliable, disabling it
[   45.004464] pci 0000:13:00.0: enabling device (0000 -> 0002)
[   45.004672] pci 0000:13:00.1: MSI is not implemented on this device, disabling it
[   45.004674] pci 0000:13:00.1: PME# is unreliable, disabling it
[   45.004691] pci 0000:13:00.1: enabling device (0000 -> 0002)
[   45.004842] pci 0000:13:00.2: MSI is not implemented on this device, disabling it
[   45.004844] pci 0000:13:00.2: PME# is unreliable, disabling it
[   45.004861] pci 0000:13:00.2: enabling device (0000 -> 0002)
[   45.004937] pci 0000:13:00.2: EHCI: unrecognized capability 00
[   45.005091] tg3 0000:14:00.0: enabling device (0000 -> 0002)
[   45.084519] tg3 0000:14:00.0 eth0: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[   45.084525] tg3 0000:14:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   45.084529] tg3 0000:14:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   45.084531] tg3 0000:14:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[   45.085489] tg3 0000:14:00.0 eth1: renamed from eth0
[   48.751118] pcieport 0000:06:03.0: pciehp: Slot(3-2): Link Down
[   48.751118] thunderbolt 0000:07:00.0: acking hot unplug event on 0:1
[   48.751128] thunderbolt 0000:07:00.0: 0:1: switch unplugged
[   48.752212] pcieport 0000:06:03.0: pciehp: Slot(3-2): Card not present
[   48.752223] pcieport 0000:09:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   48.753180] thunderbolt 0000:07:00.0: 0:6 <-> 1:a (PCI): deactivating
[   48.754148] thunderbolt 0000:07:00.0: acking hot unplug event on 0:2
[   48.754167] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 0:6 to 1:10
[   48.754387] pcieport 0000:10:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   48.754551] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 1:10 to 0:6
[   48.754929] pcieport 0000:10:04.0: can't change power state from D3cold to D0 (config space inaccessible)
[   48.754939] thunderbolt 0000:07:00.0: 0:b <-> 1:b (DP): deactivating
[   48.755701] thunderbolt 0000:07:00.0: deactivating Video path from 0:11 to 1:11
[   48.758398] thunderbolt 0000:07:00.0: 0:b: adding -12 NFC credits to 12
[   48.758524] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:11 to 1:11
[   48.758910] thunderbolt 0000:07:00.0: deactivating AUX RX path from 1:11 to 0:11
[   48.759351] thunderbolt 0000:07:00.0: 0: released DP resource for port 11
[   48.759363] thunderbolt 0000:07:00.0: 1:7 <-> 301:a (PCI): deactivating
[   48.759365] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 1:7 to 301:10
[   48.759368] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 301:10 to 1:7
[   48.759375] thunderbolt 0000:07:00.0: 0:c <-> 301:b (DP): deactivating
[   48.760080] thunderbolt 0000:07:00.0: deactivating Video path from 0:12 to 301:11
[   48.760447] thunderbolt 0000:07:00.0: 0:c: adding -12 NFC credits to 12
[   48.760579] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:12 to 301:11
[   48.760959] thunderbolt 0000:07:00.0: deactivating AUX RX path from 301:11 to 0:12
[   48.762085] thunderbolt 0000:07:00.0: 0: released DP resource for port 12
[   48.762093] thunderbolt 0000:07:00.0: 301:b: DP OUT resource unavailable
[   48.762095] thunderbolt 0000:07:00.0: 1:b: DP OUT resource unavailable
[   48.762217] thunderbolt 0-301: device disconnected
[   48.764544] thunderbolt 0-1: device disconnected
[   48.764664] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   48.764686] thunderbolt 0000:07:00.0: 0:b: DP IN available
[   48.764810] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   48.764812] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
[   48.764816] thunderbolt 0000:07:00.0: 0:2: got unplug event for disconnected port, ignoring
[   48.833191] i915 0000:00:02.0: [drm] *ERROR* [ENCODER:83:DDI B/PHY B][DPRX] Failed to get link status
[   48.893920] pci 0000:0c:00.0: Removing from iommu group 16
[   48.895366] pci 0000:0c:00.1: Removing from iommu group 16
[   48.896721] pci 0000:0c:00.2: Removing from iommu group 16
[   48.898074] pci_bus 0000:0c: busn_res: [bus 0c] is released
[   48.899414] pci 0000:0b:03.0: Removing from iommu group 16
[   48.900714] pci_bus 0000:0b: busn_res: [bus 0b-0c] is released
[   48.902406] pci 0000:0a:00.0: Removing from iommu group 16
[   48.903829] pci_bus 0000:0a: busn_res: [bus 0a-0c] is released
[   48.903833] acpiphp: Slot [1-1] unregistered
[   48.904294] pci 0000:09:00.0: Removing from iommu group 16
[   48.905179] pci 0000:0d:00.0: Removing from iommu group 16
[   48.905274] pci_bus 0000:0d: busn_res: [bus 0d] is released
[   48.906446] pci 0000:09:01.0: Removing from iommu group 16
[   48.913934] pci 0000:0e:00.0: Removing from iommu group 16
[   48.913972] pci_bus 0000:0e: busn_res: [bus 0e] is released
[   48.914887] pci 0000:09:02.0: Removing from iommu group 16
[   48.915572] pci 0000:13:00.0: Removing from iommu group 16
[   48.915821] pci 0000:13:00.1: Removing from iommu group 16
[   48.916662] pci 0000:13:00.2: Removing from iommu group 16
[   48.921977] pci_bus 0000:13: busn_res: [bus 13] is released
[   48.922096] pci 0000:12:03.0: Removing from iommu group 16
[   48.924268] pci_bus 0000:12: busn_res: [bus 12-13] is released
[   48.924419] pci 0000:11:00.0: Removing from iommu group 16
[   48.924444] pci_bus 0000:11: busn_res: [bus 11-13] is released
[   48.924447] acpiphp: Slot [1-3] unregistered
[   48.926306] pci 0000:10:00.0: Removing from iommu group 16
[   48.932550] pci 0000:14:00.0: Removing from iommu group 16
[   48.932570] pci_bus 0000:14: busn_res: [bus 14] is released
[   48.933113] pci 0000:10:01.0: Removing from iommu group 16
[   48.933752] pci 0000:15:00.0: Removing from iommu group 16
[   48.933799] pci_bus 0000:15: busn_res: [bus 15] is released
[   48.934896] pci 0000:10:02.0: Removing from iommu group 16
[   48.941653] pci_bus 0000:16: busn_res: [bus 16-1f] is released
[   48.943021] pci 0000:10:04.0: Removing from iommu group 16
[   48.943038] pci_bus 0000:20: busn_res: [bus 20-25] is released
[   48.943932] pci 0000:10:05.0: Removing from iommu group 16
[   48.944062] pci_bus 0000:10: busn_res: [bus 10-25] is released
[   48.944065] acpiphp: Slot [1-2] unregistered
[   48.944196] acpiphp: Slot [2-1] unregistered
[   48.944384] acpiphp: Slot [3-1] unregistered
[   48.944598] acpiphp: Slot [4-1] unregistered
[   48.946562] pci 0000:0f:00.0: Removing from iommu group 16
[   48.955555] pci_bus 0000:0f: busn_res: [bus 0f-25] is released
[   48.956876] pci 0000:09:04.0: Removing from iommu group 16
[   48.956896] pci_bus 0000:26: busn_res: [bus 26-38] is released
[   48.957724] pci 0000:09:05.0: Removing from iommu group 16
[   48.957856] pci_bus 0000:09: busn_res: [bus 09-38] is released
[   48.957859] acpiphp: Slot [1] unregistered
[   48.957997] acpiphp: Slot [2] unregistered
[   48.958153] acpiphp: Slot [3] unregistered
[   48.958327] acpiphp: Slot [4] unregistered
[   48.958496] acpiphp: Slot [5] unregistered
[   48.960393] pci 0000:08:00.0: Removing from iommu group 16
[   49.030500] i915 0000:00:02.0: [drm] *ERROR* Failed to read DPCD register 0x92
