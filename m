Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA74F60CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiDFN7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiDFN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:59:19 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF32219022
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:52:01 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1nbvm0-0007VF-EZ; Wed, 06 Apr 2022 12:51:57 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lvxFT8F0sLbZVykdjPWuE41KwZwYtczphjhRJnkFbGU=; b=DKiwYgEF9io/AVhI/STbS/0EQM
        B4FTysR+to13pNlE48EU5jEyqYkBQo9wrRK4be6HPnNCGcHojjMEOlD6YHZBCMH2qEYM8BuWNui0I
        TdB2J4GIGNRr+64LPvRfvZBKs7ym1nTjpuTnqQRffjh7yPJTXo0AEAZx/r7IXR/9iN7M=;
Message-ID: <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
Date:   Wed, 6 Apr 2022 10:51:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-AU
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <YkRebADER3J9ooPM@lahna>
 <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
 <YkRtf2HiXBOWGjna@lahna>
 <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
 <YkXYdcUZ1E18ENle@lahna>
 <5dcee6f7-cc8c-e3ce-920c-4ad3f5d77e14@fnarfbargle.com>
 <YkcMofXKr/ZmOSwH@lahna>
 <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
 <YkrEE0uh9EVCchfl@lahna>
 <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
 <YkrqL/wnACNVOpSi@lahna>
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YkrqL/wnACNVOpSi@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 20:53, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Apr 04, 2022 at 07:38:06PM +0800, Brad Campbell wrote:
>>> Hm, you mean you don't see the timeout errors and stuff with the first
>>> patch applied?
>>
>> I see the config timeout errors and the controller locking up after a
>> couple of unplugs, but when it does configure the DP channels, they
>> both come up every time.
>>
>> So, with the original patch when thunderbolt discovery works, displays
>> both work. With the latest patch, whether or not the hotplug works,
>> the radeon driver fails to bring up the parent head.
>>
>> Both suffer from the controller config timeout reads on unplug causing
>> it to become unresponsive after a couple of re-plug cycles (3 if I'm
>> lucky).
> 
> I suspect the same issue is even with the first patch but it just
> manifests differently. I think the timeouts are the key here and we need
> to figure out why they happen.
> 
>>> I think I will make this current one a proper patch and submit upstream
>>> later this week (will CC you too). For the iMac issue we may need to
>>> debug it further. Not sure if you answered this one already but on iMac
>>> on macOS does it work always when you plug in the whole chain?
>>>
>> Yes, MacOS works fine in any order on any port.
>>
>> There is a difference in the way something is set up between what the
>> EFI does and what Linux does.
> 
> Agree.
> 
>> If I wait for the Chime, then a bit longer and plug the chain in
>> (before the bootloader starts), Linux sets up both heads and hotplug /
>> replug works.
>>
>> If I cold boot with the chain plugged in, the EFI sets up one head and
>> Linux configures the other. Replug fails with the clock-recovery error
>> in that case.
>>
>> The difference seems to be when EFI sets up, on re-plug it sets up the
>> child display first (303 vs 3) and that causes the issue. Repeated
>> tests can get difficult as often on the second or third plug (or
>> unplug) the controller locks up and no longer responds to events.
>>
>> I'll try and get a couple of clear dmesg with your last debug patch
>> because it appear the chain is being discovered in a different order
>> depending on whether or not the EFI set it up.
> 
> That would be helpful.

Both included in-line.

This is cold boot with the chain plugged in. I've re-added the dbg to print the link number, and I've included your path discovery debugs.
Boot with chain plugged in, wait for it to settle, unplug and replug. First head in the chain fails with :

[   65.778129] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
[   65.778158] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed

[    0.000000] Linux version 5.17.1bkc1+ (brad@bkmac) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #28 SMP PREEMPT Wed Apr 6 10:31:18 AWST 2022
[    0.000000] Command line: ro root=UUID=de35d1a6-e0e1-40b0-b46a-3974a04adf4b libata.allow_tpm=1 netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da oops=panic panic=10 thunderbolt.dyndbg pci=assign-busses,realloc,hpbussize=0x10,hpmmiosize=128M,hpmmioprefsize=1G initrd=boot\initrd.img-5.17.1bkc1+
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] reserving inaccessible SNB gfx pages
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008e000-0x000000000008ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040200000-0x000000008ed32fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ed33000-0x000000008ed5efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000008ed5f000-0x000000008ed70fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ed71000-0x000000008ed8efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000008ed8f000-0x000000008ee59fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ee5a000-0x000000008ee8efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008ee8f000-0x000000008eed6fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008eed7000-0x000000008eefefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008eeff000-0x000000008efa2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008efa3000-0x000000008f8fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffed8000-0x00000000ffefffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000086fefffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x89102018-0x8911dc57] usable ==> usable
[    0.000000] e820: update [mem 0x89102018-0x8911dc57] usable ==> usable
[    0.000000] e820: update [mem 0x891a0018-0x891b1c3d] usable ==> usable
[    0.000000] e820: update [mem 0x891a0018-0x891b1c3d] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000008dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008e000-0x000000000008ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000040000000-0x00000000401fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000040200000-0x0000000089102017] usable
[    0.000000] reserve setup_data: [mem 0x0000000089102018-0x000000008911dc57] usable
[    0.000000] reserve setup_data: [mem 0x000000008911dc58-0x00000000891a0017] usable
[    0.000000] reserve setup_data: [mem 0x00000000891a0018-0x00000000891b1c3d] usable
[    0.000000] reserve setup_data: [mem 0x00000000891b1c3e-0x000000008ed32fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ed33000-0x000000008ed5efff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000008ed5f000-0x000000008ed70fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ed71000-0x000000008ed8efff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000008ed8f000-0x000000008ee59fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ee5a000-0x000000008ee8efff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008ee8f000-0x000000008eed6fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008eed7000-0x000000008eefefff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008eeff000-0x000000008efa2fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008efa3000-0x000000008f8fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ffed8000-0x00000000ffefffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000086fefffff] usable
[    0.000000] efi: EFI v1.10 by Apple
[    0.000000] efi: ACPI=0x8ed8e000 ACPI 2.0=0x8ed8e014 SMBIOS=0x8ed3b000
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Apple Inc. iMac12,2/Mac-942B59F58194171B, BIOS 87.0.0.0.0 06/14/2019
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3400.192 MHz processor
[    0.000094] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000096] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000103] last_pfn = 0x86ff00 max_arch_pfn = 0x400000000
[    0.000752] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001367] last_pfn = 0x8efa3 max_arch_pfn = 0x400000000
[    0.002457] Secure boot disabled
[    0.002459] RAMDISK: [mem 0x7e4c0000-0x7fffffff]
[    0.002463] ACPI: Early table checksum verification disabled
[    0.002466] ACPI: RSDP 0x000000008ED8E014 000024 (v02 APPLE )
[    0.002470] ACPI: XSDT 0x000000008ED8E1C0 0000A4 (v01 APPLE  Apple00  0000F000      01000013)
[    0.002475] ACPI: FACP 0x000000008ED8C000 0000F4 (v04 APPLE  Apple00  0000F000 Loki 0000005F)
[    0.002479] ACPI: DSDT 0x000000008ED81000 0053FB (v01 APPLE  iMac     00210001 INTL 20061109)
[    0.002482] ACPI: FACS 0x000000008ED3E000 000040
[    0.002484] ACPI: FACS 0x000000008ED3E000 000040
[    0.002486] ACPI: HPET 0x000000008ED8B000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002489] ACPI: APIC 0x000000008ED8A000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002492] ACPI: SBST 0x000000008ED88000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002494] ACPI: ECDT 0x000000008ED87000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002497] ACPI: SSDT 0x000000008ED7E000 00020D (v01 APPLE  SataAhci 00001000 INTL 20061109)
[    0.002499] ACPI: SSDT 0x000000008ED7C000 0000B1 (v01 APPLE  SmcDppt  00001000 INTL 20061109)
[    0.002502] ACPI: SSDT 0x000000008ED7A000 000646 (v01 APPLE  UsbNoRmh 00001000 INTL 20061109)
[    0.002504] ACPI: SSDT 0x000000008ED78000 00013D (v01 APPLE  SataPrt1 00001000 INTL 20061109)
[    0.002507] ACPI: SSDT 0x000000008ED77000 0000A0 (v02 APPLE  IGHda    00001000 INTL 20061109)
[    0.002510] ACPI: SSDT 0x000000008ED75000 000032 (v01 APPLE  SsdtS3   00001000 INTL 20061109)
[    0.002512] ACPI: SSDT 0x000000008ED74000 000548 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.002515] ACPI: SSDT 0x000000008ED73000 0009B1 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.002517] ACPI: SSDT 0x000000008ED72000 000315 (v01 PmRef  Cpu0Tst  00003000 INTL 20061109)
[    0.002520] ACPI: SSDT 0x000000008ED71000 00037A (v01 PmRef  ApTst    00003000 INTL 20061109)
[    0.002522] ACPI: MCFG 0x000000008ED89000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002525] ACPI: Reserving FACP table memory at [mem 0x8ed8c000-0x8ed8c0f3]
[    0.002526] ACPI: Reserving DSDT table memory at [mem 0x8ed81000-0x8ed863fa]
[    0.002527] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002528] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002529] ACPI: Reserving HPET table memory at [mem 0x8ed8b000-0x8ed8b037]
[    0.002531] ACPI: Reserving APIC table memory at [mem 0x8ed8a000-0x8ed8a0bb]
[    0.002532] ACPI: Reserving SBST table memory at [mem 0x8ed88000-0x8ed8802f]
[    0.002533] ACPI: Reserving ECDT table memory at [mem 0x8ed87000-0x8ed87052]
[    0.002534] ACPI: Reserving SSDT table memory at [mem 0x8ed7e000-0x8ed7e20c]
[    0.002535] ACPI: Reserving SSDT table memory at [mem 0x8ed7c000-0x8ed7c0b0]
[    0.002536] ACPI: Reserving SSDT table memory at [mem 0x8ed7a000-0x8ed7a645]
[    0.002537] ACPI: Reserving SSDT table memory at [mem 0x8ed78000-0x8ed7813c]
[    0.002538] ACPI: Reserving SSDT table memory at [mem 0x8ed77000-0x8ed7709f]
[    0.002539] ACPI: Reserving SSDT table memory at [mem 0x8ed75000-0x8ed75031]
[    0.002540] ACPI: Reserving SSDT table memory at [mem 0x8ed74000-0x8ed74547]
[    0.002541] ACPI: Reserving SSDT table memory at [mem 0x8ed73000-0x8ed739b0]
[    0.002542] ACPI: Reserving SSDT table memory at [mem 0x8ed72000-0x8ed72314]
[    0.002544] ACPI: Reserving SSDT table memory at [mem 0x8ed71000-0x8ed71379]
[    0.002545] ACPI: Reserving MCFG table memory at [mem 0x8ed89000-0x8ed8903b]
[    0.002551] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.002578] Zone ranges:
[    0.002579]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002580]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002582]   Normal   [mem 0x0000000100000000-0x000000086fefffff]
[    0.002583] Movable zone start for each node
[    0.002584] Early memory node ranges
[    0.002584]   node   0: [mem 0x0000000000001000-0x000000000008dfff]
[    0.002586]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.002587]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.002588]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.002589]   node   0: [mem 0x0000000040200000-0x000000008ed32fff]
[    0.002590]   node   0: [mem 0x000000008ed5f000-0x000000008ed70fff]
[    0.002591]   node   0: [mem 0x000000008ed8f000-0x000000008ee59fff]
[    0.002592]   node   0: [mem 0x000000008ee8f000-0x000000008eed6fff]
[    0.002592]   node   0: [mem 0x000000008eeff000-0x000000008efa2fff]
[    0.002593]   node   0: [mem 0x0000000100000000-0x000000086fefffff]
[    0.002596] Initmem setup node 0 [mem 0x0000000000001000-0x000000086fefffff]
[    0.002600] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002601] On node 0, zone DMA: 2 pages in unavailable ranges
[    0.002619] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.004119] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006364] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006369] On node 0, zone DMA32: 44 pages in unavailable ranges
[    0.006372] On node 0, zone DMA32: 30 pages in unavailable ranges
[    0.006374] On node 0, zone DMA32: 53 pages in unavailable ranges
[    0.006376] On node 0, zone DMA32: 40 pages in unavailable ranges
[    0.060498] On node 0, zone Normal: 4189 pages in unavailable ranges
[    0.060505] On node 0, zone Normal: 256 pages in unavailable ranges
[    0.060667] ACPI: PM-Timer IO Port: 0x408
[    0.060673] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.060675] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.060676] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.060677] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.060678] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.060679] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.060680] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.060681] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.060689] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.060692] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.060694] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.060697] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.060698] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.060702] TSC deadline timer available
[    0.060703] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.060724] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.060726] PM: hibernation: Registered nosave memory: [mem 0x0008e000-0x0008ffff]
[    0.060728] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
[    0.060729] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.060730] PM: hibernation: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.060732] PM: hibernation: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.060734] PM: hibernation: Registered nosave memory: [mem 0x89102000-0x89102fff]
[    0.060736] PM: hibernation: Registered nosave memory: [mem 0x8911d000-0x8911dfff]
[    0.060738] PM: hibernation: Registered nosave memory: [mem 0x891a0000-0x891a0fff]
[    0.060740] PM: hibernation: Registered nosave memory: [mem 0x891b1000-0x891b1fff]
[    0.060741] PM: hibernation: Registered nosave memory: [mem 0x8ed33000-0x8ed5efff]
[    0.060743] PM: hibernation: Registered nosave memory: [mem 0x8ed71000-0x8ed8efff]
[    0.060745] PM: hibernation: Registered nosave memory: [mem 0x8ee5a000-0x8ee8efff]
[    0.060747] PM: hibernation: Registered nosave memory: [mem 0x8eed7000-0x8eefefff]
[    0.060749] PM: hibernation: Registered nosave memory: [mem 0x8efa3000-0x8f8fffff]
[    0.060749] PM: hibernation: Registered nosave memory: [mem 0x8f900000-0xe00f7fff]
[    0.060750] PM: hibernation: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.060751] PM: hibernation: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff]
[    0.060752] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.060753] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xffed7fff]
[    0.060754] PM: hibernation: Registered nosave memory: [mem 0xffed8000-0xffefffff]
[    0.060755] PM: hibernation: Registered nosave memory: [mem 0xfff00000-0xffffffff]
[    0.060756] [mem 0x8f900000-0xe00f7fff] available for PCI devices
[    0.060760] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.063046] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.063212] percpu: Embedded 44 pages/cpu s139416 r8192 d32616 u262144
[    0.063219] pcpu-alloc: s139416 r8192 d32616 u262144 alloc=1*2097152
[    0.063221] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.063242] Built 1 zonelists, mobility grouping on.  Total pages: 8251732
[    0.063244] Kernel command line: ro root=UUID=de35d1a6-e0e1-40b0-b46a-3974a04adf4b libata.allow_tpm=1 netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da oops=panic panic=10 thunderbolt.dyndbg pci=assign-busses,realloc,hpbussize=0x10,hpmmiosize=128M,hpmmioprefsize=1G initrd=boot\initrd.img-5.17.1bkc1+
[    0.063308] Unknown kernel command line parameters "netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da", will be passed to user space.
[    0.064927] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.065750] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.065814] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.152413] Memory: 32768320K/33531492K available (8192K kernel code, 2299K rwdata, 1844K rodata, 956K init, 2632K bss, 762916K reserved, 0K cma-reserved)
[    0.152448] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.152662] Dynamic Preempt: voluntary
[    0.152686] rcu: Preemptible hierarchical RCU implementation.
[    0.152687] 	Trampoline variant of Tasks RCU enabled.
[    0.152688] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.152697] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
[    0.152898] random: get_random_bytes called from start_kernel+0x443/0x5f6 with crng_init=0
[    0.152922] Console: colour dummy device 80x25
[    0.153201] printk: console [tty0] enabled
[    0.153210] ACPI: Core revision 20211217
[    0.153294] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.153308] APIC: Switch to symmetric I/O mode setup
[    0.153687] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.203305] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x310303f59eb, max_idle_ns: 440795323301 ns
[    0.203311] Calibrating delay loop (skipped), value calculated using timer frequency.. 6800.38 BogoMIPS (lpj=34001920)
[    0.203315] pid_max: default: 32768 minimum: 301
[    0.207055] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.207118] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.207239] CPU0: Thermal monitoring enabled (TM1)
[    0.207243] process: using mwait in idle threads
[    0.207246] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.207248] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.207251] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.207254] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.207255] Spectre V2 : Vulnerable
[    0.207258] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.207260] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.207262] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.207265] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.207267] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.207270] MDS: Mitigation: Clear CPU buffers
[    0.207425] Freeing SMP alternatives memory: 24K
[    0.207696] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1054
[    0.207703] smpboot: CPU0: Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz (family: 0x6, model: 0x2a, stepping: 0x7)
[    0.207759] cblist_init_generic: Setting adjustable number of callback queues.
[    0.207763] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.207773] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.207787] ... version:                3
[    0.207789] ... bit width:              48
[    0.207790] ... generic registers:      4
[    0.207792] ... value mask:             0000ffffffffffff
[    0.207794] ... max period:             00007fffffffffff
[    0.207795] ... fixed-purpose events:   3
[    0.207797] ... event mask:             000000070000000f
[    0.207874] rcu: Hierarchical SRCU implementation.
[    0.207971] smp: Bringing up secondary CPUs ...
[    0.208014] x86: Booting SMP configuration:
[    0.208017] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.216862] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.216862]  #5 #6 #7
[    0.226640] smp: Brought up 1 node, 8 CPUs
[    0.226640] smpboot: Max logical packages: 1
[    0.226640] smpboot: Total of 8 processors activated (54403.07 BogoMIPS)
[    0.228781] devtmpfs: initialized
[    0.228781] ACPI: PM: Registering ACPI NVS region [mem 0x8ed33000-0x8ed5efff] (180224 bytes)
[    0.228781] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.228781] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.228781] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.228781] thermal_sys: Registered thermal governor 'step_wise'
[    0.228781] thermal_sys: Registered thermal governor 'user_space'
[    0.228781] cpuidle: using governor ladder
[    0.228781] cpuidle: using governor menu
[    0.228781] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.228781] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.228781] PCI: not using MMCONFIG
[    0.228781] PCI: Using configuration type 1 for base access
[    0.228781] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.233834] ACPI: Disabled all _OSI OS vendors
[    0.233834] ACPI: Added _OSI(Module Device)
[    0.233834] ACPI: Added _OSI(Processor Device)
[    0.233834] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.233834] ACPI: Added _OSI(Processor Aggregator Device)
[    0.233834] ACPI: Added _OSI(Linux-Dell-Video)
[    0.233834] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.233834] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.233834] ACPI: Added _OSI(Darwin)
[    0.235646] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.235849] ACPI: EC: EC started
[    0.235851] ACPI: EC: interrupt blocked
[    0.236899] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.236902] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.237032] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.237166] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.237369] ACPI: Dynamic OEM Table Load:
[    0.237376] ACPI: SSDT 0xFFFF888100379800 000781 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.237697] ACPI: Dynamic OEM Table Load:
[    0.237703] ACPI: SSDT 0xFFFF88810036E800 0003A4 (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.237939] ACPI: Dynamic OEM Table Load:
[    0.237944] ACPI: SSDT 0xFFFF8881000FA600 000119 (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.238729] ACPI: Interpreter enabled
[    0.238744] ACPI: PM: (supports S0 S3 S4 S5)
[    0.238746] ACPI: Using IOAPIC for interrupt routing
[    0.238763] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.238973] PCI: MMCONFIG at [mem 0xe0000000-0xefbfffff] reserved in ACPI motherboard resources
[    0.238985] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.239079] ACPI: Enabled 6 GPEs in block 00 to 3F
[    0.241935] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.241942] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.241947] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-fb] only partially covers this bridge
[    0.242083] PCI host bridge to bus 0000:00
[    0.242086] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.242089] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.242092] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.242095] pci_bus 0000:00: root bus resource [mem 0x8f900000-0xfeafffff window]
[    0.242097] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.242101] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.242110] pci 0000:00:00.0: [8086:0100] type 00 class 0x060000
[    0.242172] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
[    0.242200] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.242256] pci 0000:00:02.0: [8086:0102] type 00 class 0x038000
[    0.242264] pci 0000:00:02.0: reg 0x10: [mem 0xa8000000-0xa83fffff 64bit]
[    0.242269] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xa7ffffff 64bit pref]
[    0.242274] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.242345] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.242364] pci 0000:00:16.0: reg 0x10: [mem 0xa8907100-0xa890710f 64bit]
[    0.242431] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.242477] pci 0000:00:1a.0: [8086:1c2c] type 00 class 0x0c0300
[    0.242515] pci 0000:00:1a.0: reg 0x20: [io  0x3140-0x315f]
[    0.242597] pci 0000:00:1a.7: [8086:1c2d] type 00 class 0x0c0320
[    0.242613] pci 0000:00:1a.7: reg 0x10: [mem 0xa8906c00-0xa8906fff]
[    0.243318] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.243484] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.243499] pci 0000:00:1b.0: reg 0x10: [mem 0xa8900000-0xa8903fff 64bit]
[    0.243561] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.243620] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.243700] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.243766] pci 0000:00:1c.1: [8086:1c12] type 01 class 0x060400
[    0.243846] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.243910] pci 0000:00:1c.2: [8086:1c14] type 01 class 0x060400
[    0.243988] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.244054] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    0.244133] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.244196] pci 0000:00:1d.0: [8086:1c27] type 00 class 0x0c0300
[    0.244235] pci 0000:00:1d.0: reg 0x20: [io  0x30e0-0x30ff]
[    0.244317] pci 0000:00:1d.7: [8086:1c26] type 00 class 0x0c0320
[    0.244333] pci 0000:00:1d.7: reg 0x10: [mem 0xa8906800-0xa8906bff]
[    0.244408] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.244571] pci 0000:00:1f.0: [8086:1c44] type 00 class 0x060100
[    0.244712] pci 0000:00:1f.2: [8086:1c02] type 00 class 0x010601
[    0.244725] pci 0000:00:1f.2: reg 0x10: [io  0x3168-0x316f]
[    0.244732] pci 0000:00:1f.2: reg 0x14: [io  0x317c-0x317f]
[    0.244740] pci 0000:00:1f.2: reg 0x18: [io  0x3160-0x3167]
[    0.244747] pci 0000:00:1f.2: reg 0x1c: [io  0x3178-0x317b]
[    0.244754] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
[    0.244761] pci 0000:00:1f.2: reg 0x24: [mem 0xa8906000-0xa89067ff]
[    0.244796] pci 0000:00:1f.2: PME# supported from D3hot
[    0.244842] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    0.244857] pci 0000:00:1f.3: reg 0x10: [mem 0xa8907000-0xa89070ff 64bit]
[    0.244871] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.244974] pci 0000:01:00.0: [1002:6720] type 00 class 0x030000
[    0.244990] pci 0000:01:00.0: reg 0x10: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.245001] pci 0000:01:00.0: reg 0x18: [mem 0xa8800000-0xa881ffff 64bit]
[    0.245009] pci 0000:01:00.0: reg 0x20: [io  0x2000-0x20ff]
[    0.245021] pci 0000:01:00.0: reg 0x30: [mem 0xa8820000-0xa883ffff pref]
[    0.245028] pci 0000:01:00.0: enabling Extended Tags
[    0.245038] pci 0000:01:00.0: BAR 0: assigned to efifb
[    0.245068] pci 0000:01:00.0: supports D1 D2
[    0.245156] pci 0000:01:00.1: [1002:aa88] type 00 class 0x040300
[    0.245171] pci 0000:01:00.1: reg 0x10: [mem 0xa8840000-0xa8843fff 64bit]
[    0.245196] pci 0000:01:00.1: enabling Extended Tags
[    0.245231] pci 0000:01:00.1: supports D1 D2
[    0.245322] pci 0000:00:01.0: PCI bridge to [bus 01-ff]
[    0.245326] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.245329] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.245332] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.245336] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.245410] pci 0000:02:00.0: [14e4:16b4] type 00 class 0x020000
[    0.245443] pci 0000:02:00.0: reg 0x10: [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.245466] pci 0000:02:00.0: reg 0x18: [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.245623] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.245738] pci 0000:00:1c.0: PCI bridge to [bus 02-ff]
[    0.245745] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.245751] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.245754] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    0.245826] pci 0000:03:00.0: [168c:0030] type 00 class 0x028000
[    0.245857] pci 0000:03:00.0: reg 0x10: [mem 0xa8600000-0xa861ffff 64bit]
[    0.245917] pci 0000:03:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    0.246008] pci 0000:03:00.0: supports D1 D2
[    0.246010] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246110] pci 0000:00:1c.1: PCI bridge to [bus 03-ff]
[    0.246117] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.246123] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.246195] pci 0000:04:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.246229] pci 0000:04:00.0: reg 0x10: [mem 0xa8500000-0xa8500fff 64bit]
[    0.246392] pci 0000:04:00.0: supports D1 D2
[    0.246394] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246589] pci 0000:00:1c.2: PCI bridge to [bus 04-ff]
[    0.246596] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.246602] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.246676] pci 0000:05:00.0: [8086:1513] type 01 class 0x060400
[    0.246741] pci 0000:05:00.0: enabling Extended Tags
[    0.246836] pci 0000:05:00.0: supports D1 D2
[    0.246838] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246965] pci 0000:00:1c.4: PCI bridge to [bus 05-ff]
[    0.246970] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.246974] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.246980] pci 0000:00:1c.4:   bridge window [mem 0xacf00000-0xb10fffff 64bit pref]
[    0.247065] acpiphp: Slot [3] registered
[    0.247087] acpiphp: Slot [4] registered
[    0.247128] pci 0000:06:00.0: [8086:1513] type 01 class 0x060400
[    0.247198] pci 0000:06:00.0: enabling Extended Tags
[    0.247298] pci 0000:06:00.0: supports D1 D2
[    0.247300] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247411] pci 0000:06:03.0: [8086:1513] type 01 class 0x060400
[    0.247481] pci 0000:06:03.0: enabling Extended Tags
[    0.247582] pci 0000:06:03.0: supports D1 D2
[    0.247584] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247690] pci 0000:06:04.0: [8086:1513] type 01 class 0x060400
[    0.247760] pci 0000:06:04.0: enabling Extended Tags
[    0.247861] pci 0000:06:04.0: supports D1 D2
[    0.247863] pci 0000:06:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247971] pci 0000:06:05.0: [8086:1513] type 01 class 0x060400
[    0.248041] pci 0000:06:05.0: enabling Extended Tags
[    0.248141] pci 0000:06:05.0: supports D1 D2
[    0.248144] pci 0000:06:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248253] pci 0000:06:06.0: [8086:1513] type 01 class 0x060400
[    0.248323] pci 0000:06:06.0: enabling Extended Tags
[    0.248424] pci 0000:06:06.0: supports D1 D2
[    0.248426] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248543] pci 0000:05:00.0: PCI bridge to [bus 06-ff]
[    0.248555] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.248564] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.248663] acpiphp: Slot [1] registered
[    0.248704] pci 0000:07:00.0: [8086:1513] type 00 class 0x088000
[    0.248732] pci 0000:07:00.0: reg 0x10: [mem 0xa8a00000-0xa8a3ffff]
[    0.248748] pci 0000:07:00.0: reg 0x14: [mem 0xa8a40000-0xa8a40fff]
[    0.248828] pci 0000:07:00.0: enabling Extended Tags
[    0.248953] pci 0000:07:00.0: supports D1 D2
[    0.248955] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.249098] pci 0000:06:00.0: PCI bridge to [bus 07-ff]
[    0.249110] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.249119] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    0.249176] pci 0000:06:03.0: PCI bridge to [bus 08-ff]
[    0.249188] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.249197] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 17
[    0.249310] pci 0000:18:00.0: [8086:1513] type 01 class 0x060400
[    0.249428] pci 0000:18:00.0: enabling Extended Tags
[    0.249604] pci 0000:18:00.0: supports D1 D2
[    0.249606] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.273372] pci 0000:06:04.0: PCI bridge to [bus 18-ff]
[    0.273390] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.273403] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.273412] pci 0000:18:00.0: bridge configuration invalid ([bus 3a-49]), reconfiguring
[    0.273578] pci 0000:19:00.0: [8086:1513] type 01 class 0x060400
[    0.273702] pci 0000:19:00.0: enabling Extended Tags
[    0.273883] pci 0000:19:00.0: supports D1 D2
[    0.273885] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274042] pci 0000:19:01.0: [8086:1513] type 01 class 0x060400
[    0.274166] pci 0000:19:01.0: enabling Extended Tags
[    0.274346] pci 0000:19:01.0: supports D1 D2
[    0.274348] pci 0000:19:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274504] pci 0000:19:02.0: [8086:1513] type 01 class 0x060400
[    0.274628] pci 0000:19:02.0: enabling Extended Tags
[    0.274808] pci 0000:19:02.0: supports D1 D2
[    0.274810] pci 0000:19:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274971] pci 0000:19:04.0: [8086:1513] type 01 class 0x060400
[    0.275095] pci 0000:19:04.0: enabling Extended Tags
[    0.275278] pci 0000:19:04.0: supports D1 D2
[    0.275280] pci 0000:19:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275440] pci 0000:19:05.0: [8086:1513] type 01 class 0x060400
[    0.275547] pci 0000:19:05.0: enabling Extended Tags
[    0.275730] pci 0000:19:05.0: supports D1 D2
[    0.275732] pci 0000:19:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275912] pci 0000:18:00.0: PCI bridge to [bus 19-ff]
[    0.275931] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.275945] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.275951] pci 0000:19:00.0: bridge configuration invalid ([bus 3b-3d]), reconfiguring
[    0.275968] pci 0000:19:01.0: bridge configuration invalid ([bus 3e-3e]), reconfiguring
[    0.275985] pci 0000:19:02.0: bridge configuration invalid ([bus 3f-3f]), reconfiguring
[    0.276002] pci 0000:19:04.0: bridge configuration invalid ([bus 40-48]), reconfiguring
[    0.276018] pci 0000:19:05.0: bridge configuration invalid ([bus 49-49]), reconfiguring
[    0.276172] pci 0000:1a:00.0: [12d8:400c] type 01 class 0x060400
[    0.276560] pci 0000:1a:00.0: supports D1 D2
[    0.276562] pci 0000:1a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.303347] pci 0000:19:00.0: PCI bridge to [bus 1a-ff]
[    0.303372] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.303394] pci 0000:1a:00.0: bridge configuration invalid ([bus 3c-3d]), reconfiguring
[    0.303629] pci 0000:1b:03.0: [12d8:400c] type 01 class 0x060400
[    0.303964] pci 0000:1b:03.0: supports D1 D2
[    0.303966] pci 0000:1b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304168] pci 0000:1a:00.0: PCI bridge to [bus 1b-ff]
[    0.304193] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.304214] pci 0000:1b:03.0: bridge configuration invalid ([bus 3d-3d]), reconfiguring
[    0.304418] pci 0000:1c:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.304470] pci 0000:1c:00.0: reg 0x10: [mem 0xa9401000-0xa9401fff]
[    0.304783] pci 0000:1c:00.0: supports D1 D2
[    0.304785] pci 0000:1c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304940] pci 0000:1c:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.304992] pci 0000:1c:00.1: reg 0x10: [mem 0xa9400000-0xa9400fff]
[    0.305304] pci 0000:1c:00.1: supports D1 D2
[    0.305307] pci 0000:1c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.305433] pci 0000:1c:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.305485] pci 0000:1c:00.2: reg 0x10: [mem 0xa9402000-0xa94020ff]
[    0.305797] pci 0000:1c:00.2: supports D1 D2
[    0.305799] pci 0000:1c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.306056] pci 0000:1b:03.0: PCI bridge to [bus 1c-ff]
[    0.306081] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.306099] pci_bus 0000:1c: busn_res: [bus 1c-ff] end is updated to 1c
[    0.306109] pci_bus 0000:1b: busn_res: [bus 1b-ff] end is updated to 1c
[    0.306120] pci_bus 0000:1a: busn_res: [bus 1a-ff] end is updated to 1c
[    0.306266] pci 0000:1d:00.0: [14e4:16b0] type 00 class 0x020000
[    0.306335] pci 0000:1d:00.0: reg 0x10: [mem 0xad000000-0xad00ffff 64bit pref]
[    0.306381] pci 0000:1d:00.0: reg 0x18: [mem 0xad010000-0xad01ffff 64bit pref]
[    0.306723] pci 0000:1d:00.0: PME# supported from D0 D3hot D3cold
[    0.333367] pci 0000:19:01.0: PCI bridge to [bus 1d-ff]
[    0.333391] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.333409] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.333416] pci_bus 0000:1d: busn_res: [bus 1d-ff] end is updated to 1d
[    0.333570] pci 0000:1e:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.333640] pci 0000:1e:00.0: reg 0x10: [mem 0xa9200000-0xa9200fff 64bit]
[    0.333993] pci 0000:1e:00.0: supports D1 D2
[    0.333995] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.363366] pci 0000:19:02.0: PCI bridge to [bus 1e-ff]
[    0.363391] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.363409] pci_bus 0000:1e: busn_res: [bus 1e-ff] end is updated to 1e
[    0.363590] pci 0000:1f:00.0: [8086:1513] type 01 class 0x060400
[    0.363760] pci 0000:1f:00.0: enabling Extended Tags
[    0.364018] pci 0000:1f:00.0: supports D1 D2
[    0.364020] pci 0000:1f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.393354] pci 0000:19:04.0: PCI bridge to [bus 1f-ff]
[    0.393378] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.393396] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.393406] pci 0000:1f:00.0: bridge configuration invalid ([bus 41-48]), reconfiguring
[    0.393635] pci 0000:20:00.0: [8086:1513] type 01 class 0x060400
[    0.393814] pci 0000:20:00.0: enabling Extended Tags
[    0.394073] pci 0000:20:00.0: supports D1 D2
[    0.394075] pci 0000:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394294] pci 0000:20:01.0: [8086:1513] type 01 class 0x060400
[    0.394472] pci 0000:20:01.0: enabling Extended Tags
[    0.394731] pci 0000:20:01.0: supports D1 D2
[    0.394733] pci 0000:20:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394949] pci 0000:20:02.0: [8086:1513] type 01 class 0x060400
[    0.395127] pci 0000:20:02.0: enabling Extended Tags
[    0.395387] pci 0000:20:02.0: supports D1 D2
[    0.395389] pci 0000:20:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.395614] pci 0000:20:04.0: [8086:1513] type 01 class 0x060400
[    0.395769] pci 0000:20:04.0: enabling Extended Tags
[    0.396033] pci 0000:20:04.0: supports D1 D2
[    0.396035] pci 0000:20:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.396261] pci 0000:20:05.0: [8086:1513] type 01 class 0x060400
[    0.396415] pci 0000:20:05.0: enabling Extended Tags
[    0.396679] pci 0000:20:05.0: supports D1 D2
[    0.396681] pci 0000:20:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.396935] pci 0000:1f:00.0: PCI bridge to [bus 20-ff]
[    0.396962] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.396980] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.396988] pci 0000:20:00.0: bridge configuration invalid ([bus 42-44]), reconfiguring
[    0.397011] pci 0000:20:01.0: bridge configuration invalid ([bus 45-45]), reconfiguring
[    0.397034] pci 0000:20:02.0: bridge configuration invalid ([bus 46-46]), reconfiguring
[    0.397057] pci 0000:20:04.0: bridge configuration invalid ([bus 47-47]), reconfiguring
[    0.397080] pci 0000:20:05.0: bridge configuration invalid ([bus 48-48]), reconfiguring
[    0.397293] pci 0000:21:00.0: [12d8:400c] type 01 class 0x060400
[    0.397813] pci 0000:21:00.0: supports D1 D2
[    0.397815] pci 0000:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.398083] pci 0000:20:00.0: PCI bridge to [bus 21-ff]
[    0.398110] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.398134] pci 0000:21:00.0: bridge configuration invalid ([bus 43-44]), reconfiguring
[    0.398431] pci 0000:22:03.0: [12d8:400c] type 01 class 0x060400
[    0.398880] pci 0000:22:03.0: supports D1 D2
[    0.398882] pci 0000:22:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.399146] pci 0000:21:00.0: PCI bridge to [bus 22-ff]
[    0.399179] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.399207] pci 0000:22:03.0: bridge configuration invalid ([bus 44-44]), reconfiguring
[    0.399479] pci 0000:23:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.399547] pci 0000:23:00.0: reg 0x10: [mem 0xa9101000-0xa9101fff]
[    0.399964] pci 0000:23:00.0: supports D1 D2
[    0.399966] pci 0000:23:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400173] pci 0000:23:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.400242] pci 0000:23:00.1: reg 0x10: [mem 0xa9100000-0xa9100fff]
[    0.400659] pci 0000:23:00.1: supports D1 D2
[    0.400661] pci 0000:23:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400824] pci 0000:23:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.400892] pci 0000:23:00.2: reg 0x10: [mem 0xa9102000-0xa91020ff]
[    0.401309] pci 0000:23:00.2: supports D1 D2
[    0.401311] pci 0000:23:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.401663] pci 0000:22:03.0: PCI bridge to [bus 23-ff]
[    0.401696] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.401719] pci_bus 0000:23: busn_res: [bus 23-ff] end is updated to 23
[    0.401732] pci_bus 0000:22: busn_res: [bus 22-ff] end is updated to 23
[    0.401745] pci_bus 0000:21: busn_res: [bus 21-ff] end is updated to 23
[    0.401946] pci 0000:24:00.0: [14e4:16b0] type 00 class 0x020000
[    0.402038] pci 0000:24:00.0: reg 0x10: [mem 0xacf00000-0xacf0ffff 64bit pref]
[    0.402098] pci 0000:24:00.0: reg 0x18: [mem 0xacf10000-0xacf1ffff 64bit pref]
[    0.402550] pci 0000:24:00.0: PME# supported from D0 D3hot D3cold
[    0.402867] pci 0000:20:01.0: PCI bridge to [bus 24-ff]
[    0.402894] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.402913] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.402916] pci_bus 0000:24: busn_res: [bus 24-ff] end is updated to 24
[    0.403112] pci 0000:25:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.403204] pci 0000:25:00.0: reg 0x10: [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.403672] pci 0000:25:00.0: supports D1 D2
[    0.403674] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.403971] pci 0000:20:02.0: PCI bridge to [bus 25-ff]
[    0.403998] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.404017] pci_bus 0000:25: busn_res: [bus 25-ff] end is updated to 25
[    0.404150] pci 0000:20:04.0: PCI bridge to [bus 26-ff]
[    0.404177] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.404196] pci_bus 0000:26: busn_res: [bus 26-ff] end is updated to 35
[    0.404328] pci 0000:20:05.0: PCI bridge to [bus 36-ff]
[    0.404355] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.404374] pci_bus 0000:36: busn_res: [bus 36-ff] end is updated to 45
[    0.404385] pci_bus 0000:20: busn_res: [bus 20-ff] end is updated to 45
[    0.404396] pci_bus 0000:1f: busn_res: [bus 1f-ff] end is updated to 45
[    0.404489] pci 0000:19:05.0: PCI bridge to [bus 46-ff]
[    0.404509] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.404522] pci_bus 0000:46: busn_res: [bus 46-ff] end is updated to 55
[    0.404531] pci_bus 0000:19: busn_res: [bus 19-ff] end is updated to 55
[    0.404539] pci_bus 0000:18: busn_res: [bus 18-ff] end is updated to 55
[    0.404601] pci 0000:06:05.0: PCI bridge to [bus 56-ff]
[    0.404613] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.404622] pci_bus 0000:56: busn_res: [bus 56-ff] end is updated to 65
[    0.404678] pci 0000:06:06.0: PCI bridge to [bus 66-ff]
[    0.404690] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.404699] pci_bus 0000:66: busn_res: [bus 66-ff] end is updated to 75
[    0.404705] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 75
[    0.404710] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 75
[    0.404715] pci_bus 0000:00: on NUMA node 0
[    0.404980] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.404983] ACPI: PCI: Interrupt link LNKA disabled
[    0.405014] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.405016] ACPI: PCI: Interrupt link LNKB disabled
[    0.405045] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.405047] ACPI: PCI: Interrupt link LNKC disabled
[    0.405075] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.405078] ACPI: PCI: Interrupt link LNKD disabled
[    0.405106] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.405108] ACPI: PCI: Interrupt link LNKE disabled
[    0.405136] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.405138] ACPI: PCI: Interrupt link LNKF disabled
[    0.405166] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.405169] ACPI: PCI: Interrupt link LNKG disabled
[    0.405196] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.405199] ACPI: PCI: Interrupt link LNKH disabled
[    0.405285] ACPI: EC: interrupt unblocked
[    0.405288] ACPI: EC: event unblocked
[    0.405292] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.405294] ACPI: EC: GPE=0x17
[    0.405296] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.405299] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.405329] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.405329] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.405329] pci 0000:01:00.0: vgaarb: setting as boot device
[    0.405329] vgaarb: loaded
[    0.405329] SCSI subsystem initialized
[    0.405329] libata version 3.00 loaded.
[    0.405329] Registered efivars operations
[    0.405329] PCI: Using ACPI for IRQ routing
[    0.416017] PCI: pci_cache_line_size set to 64 bytes
[    0.416020] pci 0000:00:1c.4: can't claim BAR 9 [mem 0xacf00000-0xb10fffff 64bit pref]: address conflict with PCI Bus 0000:05 [mem 0xa8a00000-0xad6fffff]
[    0.416300] e820: reserve RAM buffer [mem 0x0008e000-0x0008ffff]
[    0.416302] e820: reserve RAM buffer [mem 0x89102018-0x8bffffff]
[    0.416303] e820: reserve RAM buffer [mem 0x891a0018-0x8bffffff]
[    0.416304] e820: reserve RAM buffer [mem 0x8ed33000-0x8fffffff]
[    0.416306] e820: reserve RAM buffer [mem 0x8ed71000-0x8fffffff]
[    0.416307] e820: reserve RAM buffer [mem 0x8ee5a000-0x8fffffff]
[    0.416308] e820: reserve RAM buffer [mem 0x8eed7000-0x8fffffff]
[    0.416309] e820: reserve RAM buffer [mem 0x8efa3000-0x8fffffff]
[    0.416310] e820: reserve RAM buffer [mem 0x86ff00000-0x86fffffff]
[    0.417207] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.417219] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.419260] clocksource: Switched to clocksource tsc-early
[    0.419297] VFS: Disk quotas dquot_6.6.0
[    0.419308] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.419339] pnp: PnP ACPI init
[    0.419446] system 00:00: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.419490] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.419493] system 00:01: [io  0x1000-0x100f] has been reserved
[    0.419496] system 00:01: [io  0xffff] has been reserved
[    0.419499] system 00:01: [io  0xffff] has been reserved
[    0.419501] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.419503] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.419506] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.419656] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.419659] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.419663] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.419666] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.419668] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.419671] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.419674] system 00:03: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.419676] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.419679] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[    0.419682] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.419762] pnp: PnP ACPI: found 4 devices
[    0.419777] pci 0000:01:00.0: assigning 75 device properties
[    0.419777] pci 0000:04:00.0: assigning 2 device properties
[    0.419777] pci 0000:07:00.0: assigning 5 device properties
[    0.419777] pci 0000:1e:00.0: assigning 2 device properties
[    0.419777] pci 0000:25:00.0: assigning 2 device properties
[    0.419777] pci 0000:00:1b.0: assigning 4 device properties
[    0.419777] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.419777] NET: Registered PF_INET protocol family
[    0.419777] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.421142] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.421183] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.421448] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.421538] TCP: Hash tables configured (established 262144 bind 65536)
[    0.421565] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.421623] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.421700] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.421708] pci 0000:03:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[    0.421716] pci_bus 0000:00: max bus depth: 9 pci_try_num: 10
[    0.421729] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.421732] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.421736] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.421739] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.421744] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.421749] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.421753] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.421761] pci 0000:03:00.0: BAR 6: assigned [mem 0xa8620000-0xa862ffff pref]
[    0.421765] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.421769] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.421777] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.421782] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.421790] pci 0000:05:00.0: BAR 7: no space for [io  size 0x8000]
[    0.421793] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x8000]
[    0.421798] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421801] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421804] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421807] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421811] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421814] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421816] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.421819] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421822] pci 0000:06:04.0: BAR 7: no space for [io  size 0x5000]
[    0.421824] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.421826] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.421829] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421832] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.421835] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421838] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.421845] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.421856] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.421863] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.421875] pci 0000:18:00.0: BAR 7: no space for [io  size 0x4000]
[    0.421878] pci 0000:18:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.421881] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421884] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421887] pci 0000:19:04.0: BAR 7: no space for [io  size 0x3000]
[    0.421890] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.421892] pci 0000:19:05.0: BAR 7: no space for [io  size 0x1000]
[    0.421894] pci 0000:19:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421897] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.421911] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.421936] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.421949] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.421974] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.421985] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422004] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.422015] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.422023] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.422037] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.422047] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.422067] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.422069] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.422073] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422076] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422080] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422083] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422085] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[    0.422088] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422090] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422092] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422095] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.422113] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422146] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.422163] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422196] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.422210] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422237] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.422252] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.422262] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422282] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.422296] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.422323] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.422338] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.422365] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.422379] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.422406] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.422420] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.422431] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422450] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.422460] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.422468] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422482] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.422493] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.422512] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.422523] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.422530] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422544] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.422551] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.422557] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422566] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.422572] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.422584] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.422591] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.422603] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.422609] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.422615] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422624] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.422627] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.422632] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.422640] pci_bus 0000:00: No. 2 try to assign unassigned res
[    0.422648] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.422650] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.422653] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.422656] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.422660] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.422665] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.422669] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.422675] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.422680] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.422688] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.422693] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.422701] pci 0000:05:00.0: BAR 7: no space for [io  size 0x8000]
[    0.422703] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x8000]
[    0.422707] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422710] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422713] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422716] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422719] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422722] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422725] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.422727] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422730] pci 0000:06:04.0: BAR 7: no space for [io  size 0x5000]
[    0.422732] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.422734] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422737] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422739] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.422741] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422744] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.422751] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.422762] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.422769] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.422781] pci 0000:18:00.0: BAR 7: no space for [io  size 0x4000]
[    0.422783] pci 0000:18:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.422787] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422790] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422793] pci 0000:19:04.0: BAR 7: no space for [io  size 0x3000]
[    0.422795] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.422797] pci 0000:19:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422800] pci 0000:19:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422802] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.422816] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422840] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.422854] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422879] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.422889] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422909] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.422919] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.422927] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.422941] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.422952] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.422971] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.422973] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.422977] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422979] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422983] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422986] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422989] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[    0.422991] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422993] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422996] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422998] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.423015] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423048] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.423065] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423098] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.423112] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423139] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.423154] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.423164] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423183] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.423198] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.423224] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.423239] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.423266] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.423280] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.423307] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.423321] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.423331] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423350] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.423361] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.423369] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423383] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.423393] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.423413] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.423423] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.423431] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423445] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.423452] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.423457] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423466] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.423473] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.423485] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.423491] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.423503] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.423510] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.423515] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423524] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.423527] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.423532] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.423540] pci_bus 0000:00: No. 3 try to assign unassigned res
[    0.423542] release child resource [mem 0xa9100000-0xa9100fff]
[    0.423543] release child resource [mem 0xa9101000-0xa9101fff]
[    0.423544] release child resource [mem 0xa9102000-0xa91020ff]
[    0.423545] pci 0000:22:03.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423548] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.423560] pci 0000:21:00.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423562] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.423575] pci 0000:20:00.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423577] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.423587] release child resource [mem 0xacf00000-0xacf0ffff 64bit pref]
[    0.423588] release child resource [mem 0xacf10000-0xacf1ffff 64bit pref]
[    0.423589] pci 0000:20:01.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423592] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.423614] release child resource [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.423615] pci 0000:20:02.0: resource 8 [mem 0xa8f00000-0xa8ffffff] released
[    0.423618] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.423628] pci 0000:20:04.0: resource 8 [mem 0xa8e00000-0xa8efffff] released
[    0.423631] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.423641] pci 0000:20:05.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.423644] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.423654] pci 0000:1f:00.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423657] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.423680] release child resource [mem 0xa9400000-0xa9400fff]
[    0.423680] release child resource [mem 0xa9401000-0xa9401fff]
[    0.423681] release child resource [mem 0xa9402000-0xa94020ff]
[    0.423682] pci 0000:1b:03.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423684] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.423694] pci 0000:1a:00.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423696] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.423706] pci 0000:19:00.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423709] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.423716] release child resource [mem 0xad000000-0xad00ffff 64bit pref]
[    0.423717] release child resource [mem 0xad010000-0xad01ffff 64bit pref]
[    0.423718] pci 0000:19:01.0: resource 9 [mem 0xad000000-0xad0fffff 64bit pref] released
[    0.423721] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.423737] release child resource [mem 0xa9200000-0xa9200fff 64bit]
[    0.423738] pci 0000:19:02.0: resource 8 [mem 0xa9200000-0xa92fffff] released
[    0.423740] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.423748] pci 0000:19:04.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423751] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.423767] pci 0000:19:05.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.423770] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.423778] pci 0000:18:00.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423780] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.423797] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.423798] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.423799] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.423801] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.423807] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xa8bfffff] released
[    0.423809] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.423815] pci 0000:06:04.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423818] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.423828] pci 0000:06:05.0: resource 8 [mem 0xa9500000-0xa95fffff] released
[    0.423830] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.423835] pci 0000:06:06.0: resource 8 [mem 0xa9600000-0xa96fffff] released
[    0.423838] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.423843] pci 0000:05:00.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423846] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.423857] pci 0000:00:1c.4: resource 7 [io  0x4000-0x4fff] released
[    0.423859] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.423874] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.423877] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.423881] pci 0000:00:1c.4: BAR 7: assigned [io  0x4000-0xbfff]
[    0.423884] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.423886] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.423889] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.423892] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.423896] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.423901] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.423905] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.423912] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.423916] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.423924] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.423929] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.423938] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.423940] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.423944] pci 0000:05:00.0: BAR 7: assigned [io  0x4000-0xbfff]
[    0.423947] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.423950] pci 0000:06:03.0: BAR 8: no space for [mem size 0x08000000]
[    0.423952] pci 0000:06:03.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.423955] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423958] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423962] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.423964] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.423967] pci 0000:06:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.423970] pci 0000:06:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.423973] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423976] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423979] pci 0000:06:06.0: BAR 8: no space for [mem size 0x08000000]
[    0.423981] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.423984] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423987] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423990] pci 0000:06:03.0: BAR 7: assigned [io  0x4000-0x4fff]
[    0.423992] pci 0000:06:04.0: BAR 7: assigned [io  0x5000-0x9fff]
[    0.423995] pci 0000:06:05.0: BAR 7: assigned [io  0xa000-0xafff]
[    0.423997] pci 0000:06:06.0: BAR 7: assigned [io  0xb000-0xbfff]
[    0.424000] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.424007] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.424013] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.424020] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.424032] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.424035] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.424052] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.424055] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.424058] pci 0000:18:00.0: BAR 7: assigned [io  0x5000-0x8fff]
[    0.424061] pci 0000:19:00.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424064] pci 0000:19:01.0: BAR 9: assigned [mem 0xa9200000-0xa92fffff 64bit pref]
[    0.424067] pci 0000:19:02.0: BAR 8: assigned [mem 0xa9400000-0xa94fffff]
[    0.424070] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.424073] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.424076] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424078] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424081] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424084] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424087] pci 0000:19:04.0: BAR 7: assigned [io  0x5000-0x7fff]
[    0.424090] pci 0000:19:05.0: BAR 7: assigned [io  0x8000-0x8fff]
[    0.424092] pci 0000:1a:00.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424095] pci 0000:1b:03.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424098] pci 0000:1c:00.0: BAR 0: assigned [mem 0xa8c00000-0xa8c00fff]
[    0.424109] pci 0000:1c:00.1: BAR 0: assigned [mem 0xa8c01000-0xa8c01fff]
[    0.424119] pci 0000:1c:00.2: BAR 0: assigned [mem 0xa8c02000-0xa8c020ff]
[    0.424129] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.424142] pci 0000:1b:03.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424167] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.424181] pci 0000:1a:00.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424206] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.424216] pci 0000:19:00.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424236] pci 0000:1d:00.0: BAR 0: assigned [mem 0xa9200000-0xa920ffff 64bit pref]
[    0.424267] pci 0000:1d:00.0: BAR 2: assigned [mem 0xa9210000-0xa921ffff 64bit pref]
[    0.424297] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.424308] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.424315] pci 0000:19:01.0:   bridge window [mem 0xa9200000-0xa92fffff 64bit pref]
[    0.424330] pci 0000:1e:00.0: BAR 0: assigned [mem 0xa9400000-0xa9400fff 64bit]
[    0.424360] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.424371] pci 0000:19:02.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.424391] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.424393] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.424397] pci 0000:1f:00.0: BAR 7: assigned [io  0x5000-0x6fff]
[    0.424400] pci 0000:20:00.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424403] pci 0000:20:01.0: BAR 9: assigned [mem 0xa8e00000-0xa8efffff 64bit pref]
[    0.424406] pci 0000:20:02.0: BAR 8: assigned [mem 0xa8f00000-0xa8ffffff]
[    0.424409] pci 0000:20:04.0: BAR 8: no space for [mem size 0x08000000]
[    0.424411] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424414] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424417] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424420] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424422] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424425] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424428] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424431] pci 0000:20:04.0: BAR 7: assigned [io  0x5000-0x5fff]
[    0.424433] pci 0000:20:05.0: BAR 7: assigned [io  0x6000-0x6fff]
[    0.424436] pci 0000:21:00.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424439] pci 0000:22:03.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424442] pci 0000:23:00.0: BAR 0: assigned [mem 0xa8d00000-0xa8d00fff]
[    0.424455] pci 0000:23:00.1: BAR 0: assigned [mem 0xa8d01000-0xa8d01fff]
[    0.424468] pci 0000:23:00.2: BAR 0: assigned [mem 0xa8d02000-0xa8d020ff]
[    0.424480] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.424497] pci 0000:22:03.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424530] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.424547] pci 0000:21:00.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424580] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.424594] pci 0000:20:00.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424621] pci 0000:24:00.0: BAR 0: assigned [mem 0xa8e00000-0xa8e0ffff 64bit pref]
[    0.424661] pci 0000:24:00.0: BAR 2: assigned [mem 0xa8e10000-0xa8e1ffff 64bit pref]
[    0.424700] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.424714] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.424725] pci 0000:20:01.0:   bridge window [mem 0xa8e00000-0xa8efffff 64bit pref]
[    0.424744] pci 0000:25:00.0: BAR 0: assigned [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.424784] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.424798] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.424825] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.424831] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.424870] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.424876] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.424915] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.424921] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.424936] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.424962] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.424967] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.424978] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.424997] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.425002] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.425029] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.425034] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.425045] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.425064] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.425067] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.425074] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.425086] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.425090] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.425106] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.425110] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.425126] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.425130] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.425136] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.425148] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.425151] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.425155] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.425163] pci_bus 0000:00: No. 4 try to assign unassigned res
[    0.425166] release child resource [mem 0xa8d00000-0xa8d00fff]
[    0.425166] release child resource [mem 0xa8d01000-0xa8d01fff]
[    0.425167] release child resource [mem 0xa8d02000-0xa8d020ff]
[    0.425168] pci 0000:22:03.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425170] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.425182] pci 0000:21:00.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425185] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.425197] pci 0000:20:00.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425200] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.425210] release child resource [mem 0xa8e00000-0xa8e0ffff 64bit pref]
[    0.425211] release child resource [mem 0xa8e10000-0xa8e1ffff 64bit pref]
[    0.425212] pci 0000:20:01.0: resource 9 [mem 0xa8e00000-0xa8efffff 64bit pref] released
[    0.425215] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.425237] release child resource [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.425238] pci 0000:20:02.0: resource 8 [mem 0xa8f00000-0xa8ffffff] released
[    0.425240] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.425250] release child resource [mem 0xa9000000-0xa90fffff]
[    0.425251] pci 0000:1f:00.0: resource 8 [mem 0xa8d00000-0xa91fffff] released
[    0.425254] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.425264] pci 0000:19:04.0: resource 8 [mem 0xa8d00000-0xa91fffff] released
[    0.425267] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.425274] release child resource [mem 0xa8c00000-0xa8c00fff]
[    0.425275] release child resource [mem 0xa8c01000-0xa8c01fff]
[    0.425276] release child resource [mem 0xa8c02000-0xa8c020ff]
[    0.425277] pci 0000:1b:03.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425279] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.425289] pci 0000:1a:00.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425291] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.425301] pci 0000:19:00.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425303] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.425311] release child resource [mem 0xa9200000-0xa920ffff 64bit pref]
[    0.425311] release child resource [mem 0xa9210000-0xa921ffff 64bit pref]
[    0.425312] pci 0000:19:01.0: resource 9 [mem 0xa9200000-0xa92fffff 64bit pref] released
[    0.425315] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.425331] release child resource [mem 0xa9400000-0xa9400fff 64bit]
[    0.425332] pci 0000:19:02.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.425335] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.425342] release child resource [mem 0xa9300000-0xa93fffff]
[    0.425343] pci 0000:18:00.0: resource 8 [mem 0xa8c00000-0xa94fffff] released
[    0.425346] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.425354] pci 0000:06:04.0: resource 8 [mem 0xa8c00000-0xa94fffff] released
[    0.425356] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.425362] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.425362] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.425363] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.425366] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.425371] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xa96fffff] released
[    0.425374] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.425380] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xad6fffff] released
[    0.425383] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.425387] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425388] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.425391] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425394] release child resource [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.425395] release child resource [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.425396] pci 0000:00:1c.0: resource 9 [mem 0xa8400000-0xa84fffff 64bit pref] released
[    0.425399] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.425405] release child resource [mem 0xa8600000-0xa861ffff 64bit]
[    0.425406] release child resource [mem 0xa8620000-0xa862ffff pref]
[    0.425407] pci 0000:00:1c.1: resource 8 [mem 0xa8600000-0xa86fffff] released
[    0.425410] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.425413] release child resource [mem 0xa8500000-0xa8500fff 64bit]
[    0.425414] pci 0000:00:1c.2: resource 8 [mem 0xa8500000-0xa85fffff] released
[    0.425417] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.425430] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425434] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.425437] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.425440] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.425443] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.425447] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.425450] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.425454] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425462] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425464] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.425467] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.425470] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425474] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.425490] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.425506] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.425510] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.425515] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.425522] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.425536] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.425539] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.425544] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.425552] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.425568] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.425572] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.425581] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.425583] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.425586] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.425590] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.425593] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.425596] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425599] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425602] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.425604] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.425607] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.425610] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.425613] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425616] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425619] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.425622] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425625] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425628] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.425635] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.425641] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.425648] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.425660] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.425663] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.425670] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.425682] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.425685] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.425688] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.425692] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425694] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.425697] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.425700] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.425703] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.425706] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.425709] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.425712] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.425714] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.425717] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425720] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425723] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425726] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425729] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.425739] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.425749] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.425759] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.425773] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425798] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.425811] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425836] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.425847] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425866] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.425897] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.425927] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.425937] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.425945] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.425960] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.425990] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.426001] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.426020] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.426023] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.426026] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.426030] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426032] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.426035] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.426038] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.426041] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.426044] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.426046] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.426050] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.426052] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.426055] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.426058] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.426061] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426064] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426067] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.426079] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.426092] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.426105] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.426122] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426155] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.426172] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426205] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.426219] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426246] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.426286] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.426325] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.426339] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.426350] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.426369] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.426409] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.426423] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.426450] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.426456] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.426471] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.426498] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.426504] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.426543] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.426549] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.426563] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.426590] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.426595] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.426606] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.426625] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.426630] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.426657] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.426662] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.426673] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.426692] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.426695] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.426702] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.426714] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.426718] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.426725] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.426737] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.426740] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.426747] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.426759] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.426762] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.426769] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.426781] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.426784] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.426789] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.426797] pci_bus 0000:00: No. 5 try to assign unassigned res
[    0.426799] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.426799] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.426800] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.426801] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426803] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.426815] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426818] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.426830] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426833] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.426843] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.426844] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.426845] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.426848] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.426870] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.426871] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.426873] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.426884] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.426886] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.426896] release child resource [mem 0xb1000000-0xb10fffff]
[    0.426897] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.426900] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.426910] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.426913] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.426920] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.426921] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.426922] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.426922] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426925] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.426934] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426937] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.426947] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426949] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.426957] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.426957] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.426958] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.426961] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.426977] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.426978] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.426981] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.426988] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.426989] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.426992] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427000] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427002] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427008] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427008] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427009] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427012] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427017] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427019] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427025] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427027] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427033] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427035] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427040] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427043] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427049] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427051] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427055] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427056] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427059] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427063] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427064] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427064] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427067] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427074] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427075] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427076] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427078] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427082] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427083] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427085] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427097] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427101] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427104] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427107] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427110] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427114] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427117] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427120] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427128] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427130] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427133] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427136] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427141] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427157] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427172] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427177] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427181] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427188] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427202] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427205] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427210] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427218] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427234] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427239] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427247] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427249] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427252] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427256] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427259] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427262] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427264] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427267] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427270] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427273] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427276] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427279] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427282] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427285] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427288] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427291] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427294] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427300] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427307] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427313] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427325] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427329] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427336] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427348] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427351] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427354] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427357] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427360] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427363] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427366] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427366] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427366] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427366] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427366] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427366] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427366] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427366] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427366] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427366] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427366] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427366] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427366] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427366] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427366] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427366] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427366] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427366] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427366] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427366] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427366] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427366] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427366] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427366] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427366] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427366] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427366] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427366] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427366] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427366] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427366] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427366] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427366] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427366] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427366] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427366] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427366] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427366] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427366] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427366] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427366] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427366] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427366] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427366] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427366] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427366] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427366] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427366] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427366] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427366] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427366] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427366] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427366] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427366] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427366] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427366] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427366] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427366] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427366] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427366] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427366] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci_bus 0000:00: No. 6 try to assign unassigned res
[    0.427366] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427366] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427366] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427366] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427366] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427366] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427366] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427366] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427366] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427366] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427366] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427366] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427366] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427366] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427366] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427366] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427366] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427366] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427366] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427366] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427366] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427366] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427366] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427366] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427366] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427366] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427366] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427366] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427366] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427366] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427366] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427366] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427366] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427366] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427366] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427366] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427366] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427366] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427366] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427366] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427366] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427366] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427366] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427366] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427366] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427366] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427366] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427366] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427366] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427366] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427366] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427366] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427366] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427366] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427366] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427366] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427366] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427366] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427366] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427366] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427366] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427366] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427366] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427366] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427366] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427366] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427366] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427366] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427366] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427366] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427366] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427366] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427366] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427366] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427366] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427366] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427366] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427366] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427366] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427366] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427366] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427366] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427366] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427366] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427366] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427366] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427366] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427366] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427366] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427366] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427366] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427366] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427366] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427366] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427366] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427366] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427366] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427366] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427366] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427366] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427366] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427366] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427366] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427366] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427366] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427366] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427366] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427366] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427366] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427366] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427366] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427366] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427366] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427366] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427366] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427366] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427366] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427366] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427366] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427366] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427366] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427366] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427366] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427366] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427366] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427366] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427366] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427366] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427366] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427366] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427366] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427366] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427366] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427366] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427366] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427366] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427366] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427366] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427366] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427366] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427366] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427366] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427366] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427366] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427366] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427366] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427366] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427366] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427366] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427366] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427366] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427366] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427366] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427366] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427366] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427366] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427366] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427366] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427366] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427366] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427366] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427366] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci_bus 0000:00: No. 7 try to assign unassigned res
[    0.427366] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427366] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427366] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427366] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427366] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427366] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427366] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427366] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427366] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427366] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427366] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427366] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427366] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427366] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427366] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427366] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427366] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427366] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427366] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427366] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427366] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427366] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427366] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427366] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427366] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427366] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427366] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427366] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427366] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427366] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427366] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427366] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427366] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427366] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427366] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427366] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427366] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427366] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427366] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427366] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427366] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427366] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427366] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427366] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427366] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427366] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427366] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427366] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427366] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427366] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427366] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427366] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427366] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427366] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427366] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427366] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427366] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427366] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427366] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427366] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427366] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427366] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427366] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427366] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427366] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427366] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427366] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427366] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427366] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427366] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427366] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427366] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427366] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427366] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427366] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427366] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427366] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427366] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427366] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427366] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427366] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427366] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427366] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427366] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427366] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427366] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427366] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427366] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427366] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427366] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427366] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427366] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427366] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427366] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427366] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427366] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427366] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427366] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427366] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427366] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427366] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427366] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427366] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427366] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427366] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427366] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427366] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427366] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427366] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427366] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427366] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427366] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427366] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427366] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427366] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427366] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427366] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427366] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427366] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427366] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427366] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427366] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427366] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427366] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427366] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427366] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427366] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427366] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427366] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427366] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427366] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427366] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427366] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427366] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427366] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427366] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427366] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427366] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427366] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427366] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427366] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427366] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427366] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427366] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427366] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427366] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427366] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427366] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427366] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427366] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427366] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427366] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427366] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427366] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427366] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427366] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427366] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427366] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427366] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427366] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427366] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427366] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci_bus 0000:00: No. 8 try to assign unassigned res
[    0.427366] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427366] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427366] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427366] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427366] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427366] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427366] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427366] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427366] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427366] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427366] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427366] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427366] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427366] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427366] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427366] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427366] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427366] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427366] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427366] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427366] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427366] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427366] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427366] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427366] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427366] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427366] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427366] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427366] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427366] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427366] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427366] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427366] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427366] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427366] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427366] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427366] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427366] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427366] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427366] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427366] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427366] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427366] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427366] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427366] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427366] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427366] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427366] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427366] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427366] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427366] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427366] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427366] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427366] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427366] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427366] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427366] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427366] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427366] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427366] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427366] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427366] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427366] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427366] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427366] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427366] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427366] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427366] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427366] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427366] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427366] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427366] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427366] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427366] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427366] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427366] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427366] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427366] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427366] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427366] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427366] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427366] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427366] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427366] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427366] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427366] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427366] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427366] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427366] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427366] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427366] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427366] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427366] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427366] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427366] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427366] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427366] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427366] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427366] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427366] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427366] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427366] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427366] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427366] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427366] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427366] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427366] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427366] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427366] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427366] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427366] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427366] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427366] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427366] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427366] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427366] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427366] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427366] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427366] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427366] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427366] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427366] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427366] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427366] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427366] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427366] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427366] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427366] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427366] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427366] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427366] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427366] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427366] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427366] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427366] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427366] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427366] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427366] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427366] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427366] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427366] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427366] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427366] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427366] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427366] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427366] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427366] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427366] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427366] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427366] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427366] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427366] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427366] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427366] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427366] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427366] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427366] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427366] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.433320] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.433332] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.433351] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.433355] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.433361] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.433373] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.433377] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.433384] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.433396] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.433399] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.433406] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.433418] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.433422] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.433428] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.433440] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.433443] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.433448] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.433455] pci_bus 0000:00: No. 9 try to assign unassigned res
[    0.433458] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.433458] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.433459] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.433460] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433462] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.433475] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433477] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.433489] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433492] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.433502] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.433503] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.433504] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.433507] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.433529] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.433530] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.433533] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.433543] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.433545] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.433556] release child resource [mem 0xb1000000-0xb10fffff]
[    0.433556] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.433559] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.433569] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.433572] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.433580] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.433580] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.433581] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.433582] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433584] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.433594] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433596] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.433606] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433609] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.433616] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.433617] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.433618] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.433621] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.433637] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.433638] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.433640] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.433648] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.433649] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.433651] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.433660] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.433662] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.433667] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.433668] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.433669] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.433671] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.433677] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.433679] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.433685] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.433687] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.433692] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.433695] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.433700] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.433702] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.433709] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.433711] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.433715] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433716] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.433719] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433722] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.433723] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.433724] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.433727] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.433734] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.433734] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.433735] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.433738] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.433741] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.433742] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.433745] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.433764] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433770] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.433775] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.433780] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.433785] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.433789] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.433792] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.433801] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433810] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433812] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.433815] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.433818] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433823] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.433839] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.433854] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.433859] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.433863] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.433870] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.433884] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.433887] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.433892] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.433900] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.433916] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.433921] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.433929] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.433932] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.433934] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.433938] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.433941] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.433944] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433946] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433950] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.433952] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.433955] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.433958] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.433961] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433964] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433967] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.433970] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433972] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433976] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.433982] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.433989] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.433996] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.434007] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.434011] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.434018] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.434030] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.434033] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.434036] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.434039] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434042] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.434045] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.434048] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.434050] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.434053] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.434056] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.434059] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.434062] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.434064] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434067] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434070] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434073] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434076] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.434086] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.434096] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.434107] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.434120] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434145] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.434158] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434183] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.434194] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434213] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.434244] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.434274] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.434285] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.434293] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.434307] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.434338] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.434348] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.434368] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.434371] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.434374] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.434377] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434380] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.434383] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.434386] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.434388] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.434391] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434394] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434397] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.434399] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.434402] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434405] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434408] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434411] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434414] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.434427] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.434439] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.434452] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.434469] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434502] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.434519] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434552] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.434567] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434594] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.434634] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.434673] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.434687] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.434698] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.434718] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.434757] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.434771] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.434798] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.434805] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.434819] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.434846] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.434852] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.434891] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.434898] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.434912] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.434939] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.434943] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.434954] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.434973] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.434978] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.435006] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.435011] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.435021] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.435040] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.435044] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.435051] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.435063] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.435066] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.435073] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.435085] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.435088] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.435095] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.435107] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.435111] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.435117] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.435129] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.435132] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.435137] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.435145] pci_bus 0000:00: No. 10 try to assign unassigned res
[    0.435147] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.435148] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.435148] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.435149] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435152] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.435164] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435166] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.435179] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435181] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.435191] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.435192] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.435193] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.435196] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.435219] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.435220] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.435222] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.435232] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.435235] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.435245] release child resource [mem 0xb1000000-0xb10fffff]
[    0.435246] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.435248] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.435259] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.435261] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.435269] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.435270] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.435270] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.435271] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435274] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.435283] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435286] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.435295] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435298] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.435305] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.435306] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.435307] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.435310] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.435326] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.435327] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.435329] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.435337] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.435338] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.435340] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.435349] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.435351] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.435356] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.435357] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.435358] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.435360] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.435365] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.435368] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.435373] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.435376] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.435381] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.435384] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.435389] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.435391] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.435398] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.435400] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.435404] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435405] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.435408] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.435411] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.435412] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.435413] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.435416] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.435422] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.435423] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.435424] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.435426] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.435430] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.435431] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.435433] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.435446] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435450] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.435453] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.435456] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.435459] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.435463] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.435466] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.435469] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435477] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.435480] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.435483] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.435486] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435490] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.435506] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.435521] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.435526] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.435530] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.435537] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.435552] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.435554] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.435559] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.435567] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.435583] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.435588] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.435596] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.435599] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.435602] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.435605] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.435608] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.435611] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435614] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435617] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.435619] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.435622] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.435625] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.435628] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435631] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435634] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.435637] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435640] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435643] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.435649] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.435656] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.435663] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.435675] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.435678] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.435685] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.435697] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.435700] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.435703] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.435707] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435709] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.435712] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.435715] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.435718] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.435720] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.435723] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.435726] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.435729] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.435732] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435734] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435738] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435740] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435743] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.435753] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.435764] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.435774] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.435787] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435812] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.435825] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435850] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.435861] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435880] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.435911] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.435941] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.435952] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.435960] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.435974] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.436004] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.436015] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.436034] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.436037] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.436040] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.436044] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436046] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.436049] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436052] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.436055] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.436058] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.436060] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.436063] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.436066] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.436069] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.436072] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.436075] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436077] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436080] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.436093] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.436106] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.436119] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.436136] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436168] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.436186] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436218] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.436232] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436260] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.436299] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.436338] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.436353] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.436363] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436382] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.436422] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.436436] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.436463] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.436469] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.436484] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.436511] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.436517] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.436556] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.436562] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.436576] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.436603] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.436608] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.436618] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.436638] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.436642] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.436670] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.436675] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.436685] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.436704] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.436708] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.436715] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.436726] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.436730] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.436737] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.436749] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.436752] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.436759] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.436771] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.436775] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.436782] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.436793] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.436796] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.436801] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.436809] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.436812] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.436814] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.436817] pci_bus 0000:00: resource 7 [mem 0x8f900000-0xfeafffff window]
[    0.436819] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff window]
[    0.436822] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.436824] pci_bus 0000:01: resource 1 [mem 0xa8800000-0xa88fffff]
[    0.436826] pci_bus 0000:01: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.436829] pci_bus 0000:02: resource 1 [mem 0xa8700000-0xa87fffff]
[    0.436832] pci_bus 0000:02: resource 2 [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.436834] pci_bus 0000:03: resource 1 [mem 0x8fa00000-0x8fafffff]
[    0.436837] pci_bus 0000:04: resource 1 [mem 0x8fb00000-0x8fbfffff]
[    0.436839] pci_bus 0000:05: resource 0 [io  0x4000-0xbfff]
[    0.436841] pci_bus 0000:05: resource 1 [mem 0xa8a00000-0xd90fffff]
[    0.436844] pci_bus 0000:06: resource 0 [io  0x4000-0xbfff]
[    0.436846] pci_bus 0000:06: resource 1 [mem 0xa8a00000-0xd90fffff]
[    0.436848] pci_bus 0000:07: resource 1 [mem 0xa8a00000-0xa8afffff]
[    0.436850] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    0.436853] pci_bus 0000:08: resource 1 [mem 0xa8b00000-0xb0afffff]
[    0.436855] pci_bus 0000:18: resource 0 [io  0x5000-0x9fff]
[    0.436857] pci_bus 0000:18: resource 1 [mem 0xb0b00000-0xc90fffff]
[    0.436859] pci_bus 0000:19: resource 0 [io  0x5000-0x8fff]
[    0.436862] pci_bus 0000:19: resource 1 [mem 0xb0b00000-0xc90fffff]
[    0.436864] pci_bus 0000:1a: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436866] pci_bus 0000:1b: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436869] pci_bus 0000:1c: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436871] pci_bus 0000:1d: resource 1 [mem 0xb0c00000-0xb0cfffff]
[    0.436873] pci_bus 0000:1d: resource 2 [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.436876] pci_bus 0000:1e: resource 1 [mem 0xb0e00000-0xb0efffff]
[    0.436878] pci_bus 0000:1f: resource 0 [io  0x5000-0x7fff]
[    0.436881] pci_bus 0000:1f: resource 1 [mem 0xb0f00000-0xc11fffff]
[    0.436883] pci_bus 0000:20: resource 0 [io  0x5000-0x6fff]
[    0.436885] pci_bus 0000:20: resource 1 [mem 0xb0f00000-0xc11fffff]
[    0.436888] pci_bus 0000:21: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436890] pci_bus 0000:22: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436892] pci_bus 0000:23: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436895] pci_bus 0000:24: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.436897] pci_bus 0000:24: resource 2 [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436900] pci_bus 0000:25: resource 1 [mem 0xb1200000-0xb12fffff]
[    0.436902] pci_bus 0000:26: resource 0 [io  0x5000-0x5fff]
[    0.436904] pci_bus 0000:26: resource 1 [mem 0xb1300000-0xb92fffff]
[    0.436906] pci_bus 0000:36: resource 0 [io  0x6000-0x6fff]
[    0.436909] pci_bus 0000:46: resource 0 [io  0x8000-0x8fff]
[    0.436911] pci_bus 0000:56: resource 0 [io  0xa000-0xafff]
[    0.436913] pci_bus 0000:56: resource 1 [mem 0xc9100000-0xd10fffff]
[    0.436916] pci_bus 0000:66: resource 0 [io  0xb000-0xbfff]
[    0.436918] pci_bus 0000:66: resource 1 [mem 0xd1100000-0xd90fffff]
[    0.437351] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.437367] pci 0000:05:00.0: CLS mismatch (256 != 128), using 64 bytes
[    0.437380] pci 0000:1c:00.0: MSI is not implemented on this device, disabling it
[    0.437383] pci 0000:1c:00.0: PME# is unreliable, disabling it
[    0.437675] pci 0000:1c:00.1: MSI is not implemented on this device, disabling it
[    0.437678] pci 0000:1c:00.1: PME# is unreliable, disabling it
[    0.437756] pci 0000:1c:00.2: MSI is not implemented on this device, disabling it
[    0.437759] pci 0000:1c:00.2: PME# is unreliable, disabling it
[    0.437814] pci 0000:1c:00.2: EHCI: unrecognized capability 00
[    0.437852] pci 0000:23:00.0: MSI is not implemented on this device, disabling it
[    0.437855] pci 0000:23:00.0: PME# is unreliable, disabling it
[    0.438107] pci 0000:23:00.1: MSI is not implemented on this device, disabling it
[    0.438111] pci 0000:23:00.1: PME# is unreliable, disabling it
[    0.438204] pci 0000:23:00.2: MSI is not implemented on this device, disabling it
[    0.438207] pci 0000:23:00.2: PME# is unreliable, disabling it
[    0.438274] pci 0000:23:00.2: EHCI: unrecognized capability 00
[    0.438313] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.438316] software IO TLB: mapped [mem 0x0000000083000000-0x0000000087000000] (64MB)
[    0.438324] ACPI: bus type thunderbolt registered
[    0.438342] Trying to unpack rootfs image as initramfs...
[    0.438402] thunderbolt 0000:07:00.0: total paths: 32
[    0.438580] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.438599] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.438612] thunderbolt 0000:07:00.0: control channel created
[    0.438615] thunderbolt 0000:07:00.0: ICM not supported on this controller
[    0.438624] thunderbolt 0000:07:00.0: freeing RX ring 0
[    0.438631] thunderbolt 0000:07:00.0: freeing TX ring 0
[    0.438640] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.438648] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.438656] thunderbolt 0000:07:00.0: control channel created
[    0.438659] thunderbolt 0000:07:00.0: using software connection manager
[    0.438672] thunderbolt 0000:07:00.0: created link from 0000:06:03.0
[    0.438693] thunderbolt 0000:07:00.0: created link from 0000:06:04.0
[    0.438702] thunderbolt 0000:07:00.0: created link from 0000:06:05.0
[    0.438711] thunderbolt 0000:07:00.0: created link from 0000:06:06.0
[    0.438766] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[    0.438767] thunderbolt 0000:07:00.0: control channel starting...
[    0.438768] thunderbolt 0000:07:00.0: starting TX ring 0
[    0.438777] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.438779] thunderbolt 0000:07:00.0: starting RX ring 0
[    0.438787] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38204 bit 0 (0x0 -> 0x1)
[    0.438790] thunderbolt 0000:07:00.0: security level set to user
[    0.438945] thunderbolt 0000:07:00.0: current switch config:
[    0.438947] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.438949] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.438950] thunderbolt 0000:07:00.0:   Config:
[    0.438951] thunderbolt 0000:07:00.0:    Upstream Port Number: 6 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.438953] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.443555] thunderbolt 0000:07:00.0: initializing Switch at 0x0 (depth: 0, up port: 6)
[    0.444065] thunderbolt 0000:07:00.0: 0: DROM version: 1
[    0.445599] thunderbolt 0000:07:00.0: 0: uid: 0x1000a13f2da20
[    0.448543] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.448546] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.448547] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.448548] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.448549] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.451487] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.451489] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.451490] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.451491] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.451492] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.454430] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.454432] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.454433] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.454434] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.454435] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.455069] random: fast init done
[    0.457374] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.457376] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.457377] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.457378] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.457379] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.457380] thunderbolt 0000:07:00.0: 0:5: disabled by eeprom
[    0.458270] thunderbolt 0000:07:00.0:  Port 6: 8086:1513 (Revision: 2, TB Version: 1, Type: NHI (0x2))
[    0.458272] thunderbolt 0000:07:00.0:   Max hop id (in/out): 31/31
[    0.458273] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.458274] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.458275] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.459166] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.459168] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.459169] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.459170] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.459171] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.460062] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.460064] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.460065] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.460065] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.460066] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.460958] thunderbolt 0000:07:00.0:  Port 9: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.460960] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.460961] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.460962] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.460963] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.461854] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.461856] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.461857] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.461858] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.461859] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.463006] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    0.463008] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.463009] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.463010] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.463011] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.463902] thunderbolt 0000:07:00.0:  Port 12: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.463904] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.463905] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.463906] thunderbolt 0000:07:00.0:   NFC Credits: 0x700005
[    0.463907] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.464798] thunderbolt 0000:07:00.0:  Port 13: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.464800] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.464801] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.464801] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.464802] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.480854] thunderbolt 0000:07:00.0: 0: TMU: current mode: HiFi
[    0.480982] thunderbolt 0000:07:00.0: 0:1: is unplugged (state: 7)
[    0.481109] thunderbolt 0000:07:00.0: 0:3: is connected, link is up (state: 2)
[    0.481365] thunderbolt 0000:07:00.0: current switch config:
[    0.481367] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.481368] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.481369] thunderbolt 0000:07:00.0:   Config:
[    0.481370] thunderbolt 0000:07:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1, PlugEventsDelay: 255ms
[    0.481372] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.485974] thunderbolt 0000:07:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[    0.503382] thunderbolt 0000:07:00.0: 3: reading drom (length: 0x97)
[    0.708103] Freeing initrd memory: 27904K
[    0.997052] thunderbolt 0000:07:00.0: 3: DROM version: 1
[    0.998076] thunderbolt 0000:07:00.0: 3: uid: 0x1000100189170
[    1.001019] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.001023] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.001026] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.001028] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.001030] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.003963] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.003966] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.003969] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.003971] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c0000e
[    1.003973] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.006906] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.006910] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.006912] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.006914] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.006916] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.009850] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.009854] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.009856] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.009858] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.009860] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.009862] thunderbolt 0000:07:00.0: 3:5: disabled by eeprom
[    1.009865] thunderbolt 0000:07:00.0: 3:6: disabled by eeprom
[    1.010746] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.010750] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.010752] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.010754] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.010756] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.011642] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.011646] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.011648] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.011650] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.011652] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.011654] thunderbolt 0000:07:00.0: 3:9: disabled by eeprom
[    1.012538] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.012542] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.012544] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.012546] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.012548] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.013690] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.013694] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.013696] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.013698] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.013700] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.013702] thunderbolt 0000:07:00.0: 3:c: disabled by eeprom
[    1.013704] thunderbolt 0000:07:00.0: 3:d: disabled by eeprom
[    1.031975] thunderbolt 0000:07:00.0: 3: TMU: current mode: bi-directional, HiFi
[    1.032006] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[    1.032015] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[    1.032111] thunderbolt 0000:07:00.0: 3:3: is connected, link is up (state: 2)
[    1.032370] thunderbolt 0000:07:00.0: current switch config:
[    1.032372] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    1.032375] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    1.032377] thunderbolt 0000:07:00.0:   Config:
[    1.032379] thunderbolt 0000:07:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x303 Enabled: 1, PlugEventsDelay: 255ms
[    1.032383] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.036979] thunderbolt 0000:07:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[    1.054384] thunderbolt 0000:07:00.0: 303: reading drom (length: 0x97)
[    1.309348] random: crng init done
[    1.548054] thunderbolt 0000:07:00.0: 303: DROM version: 1
[    1.549078] thunderbolt 0000:07:00.0: 303: uid: 0x100010102a740
[    1.552022] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.552026] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.552028] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.552030] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.552032] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.554965] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.554969] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.554971] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.554973] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.554975] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.557909] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.557913] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.557915] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.557917] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.557919] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.560853] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.560856] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.560858] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.560860] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.560862] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.560865] thunderbolt 0000:07:00.0: 303:5: disabled by eeprom
[    1.560867] thunderbolt 0000:07:00.0: 303:6: disabled by eeprom
[    1.561749] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.561752] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.561754] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.561756] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.561758] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.562645] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.562648] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.562650] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.562652] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.562654] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.562656] thunderbolt 0000:07:00.0: 303:9: disabled by eeprom
[    1.563540] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.563544] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.563546] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.563548] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.563550] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.564693] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.564696] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.564699] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.564701] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.564703] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.564705] thunderbolt 0000:07:00.0: 303:c: disabled by eeprom
[    1.564707] thunderbolt 0000:07:00.0: 303:d: disabled by eeprom
[    1.582598] thunderbolt 0000:07:00.0: 303: TMU: current mode: bi-directional, HiFi
[    1.582619] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[    1.582627] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[    1.582723] thunderbolt 0000:07:00.0: 303:1: is unplugged (state: 7)
[    1.582983] thunderbolt 0000:07:00.0: 303:b: DP adapter HPD set, queuing hotplug
[    1.583751] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 0:7
[    1.583880] thunderbolt 0000:07:00.0: 0:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.583883] thunderbolt 0000:07:00.0: 0:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.583886] thunderbolt 0000:07:00.0: 0:7:    Counter enabled: 1 Counter index: 0
[    1.583889] thunderbolt 0000:07:00.0: 0:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.583893] thunderbolt 0000:07:00.0: 0:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.584007] thunderbolt 0000:07:00.0: 3:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.584010] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.584013] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 1 Counter index: 0
[    1.584016] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.584019] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.584022] thunderbolt 0000:07:00.0: path discovery complete
[    1.584519] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 3:10
[    1.584647] thunderbolt 0000:07:00.0: 3:a:  In HopID: 8 => Out port: 1 Out HopID: 8
[    1.584650] thunderbolt 0000:07:00.0: 3:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.584653] thunderbolt 0000:07:00.0: 3:a:    Counter enabled: 1 Counter index: 0
[    1.584655] thunderbolt 0000:07:00.0: 3:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.584658] thunderbolt 0000:07:00.0: 3:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.584775] thunderbolt 0000:07:00.0: 0:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[    1.584778] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.584781] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 1 Counter index: 0
[    1.584783] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.584786] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.584789] thunderbolt 0000:07:00.0: path discovery complete
[    1.584903] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): discovered
[    1.585670] thunderbolt 0000:07:00.0: discovering Video path starting from 0:12
[    1.585799] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 4 Out HopID: 9
[    1.585802] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 2 Drop: 0
[    1.585805] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 1 Counter index: 0
[    1.585807] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.585810] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.585927] thunderbolt 0000:07:00.0: 3:2:  In HopID: 9 => Out port: 11 Out HopID: 9
[    1.585930] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.585933] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 1 Counter index: 0
[    1.585935] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.585938] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.585941] thunderbolt 0000:07:00.0: path discovery complete
[    1.586182] thunderbolt 0000:07:00.0: discovering AUX TX path starting from 0:12
[    1.586311] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 4 Out HopID: 8
[    1.586314] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.586317] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 1 Counter index: 1
[    1.586320] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.586322] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.586439] thunderbolt 0000:07:00.0: 3:2:  In HopID: 8 => Out port: 11 Out HopID: 8
[    1.586442] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.586445] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 1 Counter index: 1
[    1.586447] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.586450] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.586453] thunderbolt 0000:07:00.0: path discovery complete
[    1.586950] thunderbolt 0000:07:00.0: discovering AUX RX path starting from 3:11
[    1.587079] thunderbolt 0000:07:00.0: 3:b:  In HopID: 8 => Out port: 2 Out HopID: 8
[    1.587082] thunderbolt 0000:07:00.0: 3:b:   Weight: 1 Priority: 2 Credits: 7 Drop: 0
[    1.587084] thunderbolt 0000:07:00.0: 3:b:    Counter enabled: 1 Counter index: 0
[    1.587087] thunderbolt 0000:07:00.0: 3:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.587090] thunderbolt 0000:07:00.0: 3:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.587207] thunderbolt 0000:07:00.0: 0:4:  In HopID: 8 => Out port: 12 Out HopID: 8
[    1.587210] thunderbolt 0000:07:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.587213] thunderbolt 0000:07:00.0: 0:4:    Counter enabled: 1 Counter index: 0
[    1.587215] thunderbolt 0000:07:00.0: 0:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.587218] thunderbolt 0000:07:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.587221] thunderbolt 0000:07:00.0: path discovery complete
[    1.587462] thunderbolt 0000:07:00.0: 0:c <-> 3:b (DP): discovered
[    1.587974] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 3:7
[    1.588103] thunderbolt 0000:07:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.588106] thunderbolt 0000:07:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.588109] thunderbolt 0000:07:00.0: 3:7:    Counter enabled: 1 Counter index: 0
[    1.588111] thunderbolt 0000:07:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.588114] thunderbolt 0000:07:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.588230] thunderbolt 0000:07:00.0: 303:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.588234] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.588237] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 1 Counter index: 0
[    1.588239] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.588242] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.588245] thunderbolt 0000:07:00.0: path discovery complete
[    1.588742] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 303:10
[    1.588870] thunderbolt 0000:07:00.0: 303:a:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.588874] thunderbolt 0000:07:00.0: 303:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.588877] thunderbolt 0000:07:00.0: 303:a:    Counter enabled: 1 Counter index: 0
[    1.588879] thunderbolt 0000:07:00.0: 303:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.588882] thunderbolt 0000:07:00.0: 303:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.588998] thunderbolt 0000:07:00.0: 3:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[    1.589002] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.589004] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 1 Counter index: 0
[    1.589007] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.589010] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.589013] thunderbolt 0000:07:00.0: path discovery complete
[    1.589126] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): discovered
[    1.589513] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.589515] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
[    1.589638] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[    1.589642] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[    1.589706] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
[    1.589710] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    1.589712] RAPL PMU: hw unit of domain package 2^-16 Joules
[    1.589714] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[    1.589765] thunderbolt 0000:07:00.0: 0:c: in use
[    1.589899] thunderbolt 0000:07:00.0: 0:d: DP IN available
[    1.590020] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[    1.590022] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 13
[    1.590024] thunderbolt 0000:07:00.0: 303:b: calculating available bandwidth
[    1.590107] Initialise system trusted keyrings
[    1.590131] workingset: timestamp_bits=62 max_order=23 bucket_order=0
[    1.590147] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[    1.590149] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[    1.590274] thunderbolt 0000:07:00.0: 3:3: link total bandwidth 9000 Mb/s
[    1.590275] thunderbolt 0000:07:00.0: 303:3: link total bandwidth 9000 Mb/s
[    1.590277] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    1.590283] thunderbolt 0000:07:00.0: 0:d <-> 303:b (DP): activating
[    1.590285] thunderbolt 0000:07:00.0: activating Video path from 0:13 to 303:11
[    1.590287] thunderbolt 0000:07:00.0: 303:3: adding 12 NFC credits to 0
[    1.590402] thunderbolt 0000:07:00.0: 3:1: adding 12 NFC credits to 0
[    1.590530] thunderbolt 0000:07:00.0: 0:d: adding 5 NFC credits to 0
[    1.590786] thunderbolt 0000:07:00.0: 303:3: Writing hop 2
[    1.590788] thunderbolt 0000:07:00.0: 303:3:  In HopID: 9 => Out port: 11 Out HopID: 9
[    1.590789] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.590791] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[    1.590792] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.590794] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.590835] Key type asymmetric registered
[    1.590838] Asymmetric key parser 'x509' registered
[    1.590850] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    1.591042] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[    1.591044] thunderbolt 0000:07:00.0: 3:1:  In HopID: 9 => Out port: 3 Out HopID: 9
[    1.591045] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.591047] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[    1.591048] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.591050] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.591299] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[    1.591301] thunderbolt 0000:07:00.0: 0:d:  In HopID: 9 => Out port: 3 Out HopID: 9
[    1.591304] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.591307] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[    1.591309] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.591312] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.591426] thunderbolt 0000:07:00.0: path activation complete
[    1.591427] thunderbolt 0000:07:00.0: activating AUX TX path from 0:13 to 303:11
[    1.591554] thunderbolt 0000:07:00.0: 303:3: Writing hop 2
[    1.591556] thunderbolt 0000:07:00.0: 303:3:  In HopID: 10 => Out port: 11 Out HopID: 8
[    1.591557] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.591559] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[    1.591560] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.591561] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.591689] pcieport 0000:06:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.591811] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[    1.591813] thunderbolt 0000:07:00.0: 3:1:  In HopID: 10 => Out port: 3 Out HopID: 10
[    1.591814] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.591816] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[    1.591817] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.591818] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.591883] pcieport 0000:06:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.592066] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[    1.592068] thunderbolt 0000:07:00.0: 0:d:  In HopID: 8 => Out port: 3 Out HopID: 10
[    1.592069] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.592071] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[    1.592072] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.592073] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.592099] pcieport 0000:06:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.592194] thunderbolt 0000:07:00.0: path activation complete
[    1.592196] thunderbolt 0000:07:00.0: activating AUX RX path from 303:11 to 0:13
[    1.592311] pcieport 0000:06:06.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.592322] thunderbolt 0000:07:00.0: 0:3: Writing hop 2
[    1.592324] thunderbolt 0000:07:00.0: 0:3:  In HopID: 9 => Out port: 13 Out HopID: 8
[    1.592325] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.592327] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[    1.592328] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.592329] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.592578] thunderbolt 0000:07:00.0: 3:3: Writing hop 1
[    1.592580] thunderbolt 0000:07:00.0: 3:3:  In HopID: 9 => Out port: 1 Out HopID: 9
[    1.592581] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.592582] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[    1.592584] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.592585] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.592834] thunderbolt 0000:07:00.0: 303:b: Writing hop 0
[    1.592836] thunderbolt 0000:07:00.0: 303:b:  In HopID: 8 => Out port: 3 Out HopID: 9
[    1.592837] thunderbolt 0000:07:00.0: 303:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.592839] thunderbolt 0000:07:00.0: 303:b:    Counter enabled: 0 Counter index: 2047
[    1.592840] thunderbolt 0000:07:00.0: 303:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.592841] thunderbolt 0000:07:00.0: 303:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.592962] thunderbolt 0000:07:00.0: path activation complete
[    1.593610] pcieport 0000:19:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.593830] pcieport 0000:19:05.0: enabling device (0000 -> 0001)
[    1.593934] pcieport 0000:19:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.593994] thunderbolt 0000:07:00.0: Used link no : 0
[    1.595837] pcieport 0000:20:04.0: enabling device (0000 -> 0003)
[    1.595959] pcieport 0000:20:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.596256] pcieport 0000:20:05.0: enabling device (0000 -> 0001)
[    1.596378] pcieport 0000:20:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.606621] brd: module loaded
[    1.606889] Intel(R) 2.5G Ethernet Linux Driver
[    1.606895] Copyright(c) 2018 Intel Corporation.
[    1.606946] i8042: PNP: No PS/2 controller found.
[    1.606990] mousedev: PS/2 mouse device common for all mice
[    1.607059] intel_pstate: Intel P-state driver initializing
[    1.607182] efifb: probing for efifb
[    1.607197] efifb: framebuffer at 0x90010000, using 14400k, total 14400k
[    1.607200] efifb: mode is 2560x1440x32, linelength=10240, pages=1
[    1.607203] efifb: scrolling: redraw
[    1.607204] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.616826] Console: switching to colour frame buffer device 320x90
[    1.626003] fb0: EFI VGA frame buffer device
[    1.626093] Key type dns_resolver registered
[    1.626145] microcode: sig=0x206a7, pf=0x2, revision=0x2f
[    1.626339] microcode: Microcode Update Driver: v2.2.
[    1.626341] IPI shorthand broadcast: enabled
[    1.626385] sched_clock: Marking stable (1625902703, 433044)->(1637191332, -10855585)
[    1.626475] registered taskstats version 1
[    1.626492] Loading compiled-in X.509 certificates
[    1.627411] Freeing unused kernel image (initmem) memory: 956K
[    1.753621] Write protecting the kernel read-only data: 12288k
[    1.754144] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.754305] Freeing unused kernel image (rodata/data gap) memory: 204K
[    1.754335] Run /init as init process
[    1.754350]   with arguments:
[    1.754351]     /init
[    1.754352]   with environment:
[    1.754352]     HOME=/
[    1.754353]     TERM=linux
[    1.754354]     netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da
[    1.797874] udevd[874]: starting version 3.2.9
[    1.798577] udevd[875]: starting eudev-3.2.9
[    1.813369] ACPI: bus type USB registered
[    1.813427] usbcore: registered new interface driver usbfs
[    1.813462] usbcore: registered new interface driver hub
[    1.813499] usbcore: registered new device driver usb
[    1.815361] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.815404] ACPI: bus type drm_connector registered
[    1.815768] ehci-pci: EHCI PCI platform driver
[    1.815960] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    1.815968] uhci_hcd: USB Universal Host Controller Interface driver
[    1.815997] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    1.816067] ehci-pci 0000:00:1a.7: debug port 2
[    1.816163] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.819327] ahci 0000:00:1f.2: version 3.0
[    1.819549] cryptd: max_cpu_qlen set to 1000
[    1.820050] ehci-pci 0000:00:1a.7: irq 23, io mem 0xa8906c00
[    1.820893] AVX version of gcm_enc/dec engaged.
[    1.820944] AES CTR mode by8 optimization enabled
[    1.827038] radeon: unknown parameter 'pm' ignored
[    1.827190] [drm] radeon kernel modesetting enabled.
[    1.827247] checking generic (90010000 e10000) vs hw (90000000 10000000)
[    1.827248] fb0: switching to radeon from EFI VGA
[    1.827408] Console: switching to colour dummy device 80x25
[    1.827460] radeon 0000:01:00.0: vgaarb: deactivate vga console
[    1.827634] [drm] initializing kernel modesetting (BARTS 0x1002:0x6720 0x106B:0x0B00 0x00).
[    1.829865] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x7 impl SATA mode
[    1.829872] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst
[    1.853123] tg3 0000:02:00.0 eth0: Tigon3 [partno(BCM957765) rev 57785100] (PCI Express) MAC address 3c:07:54:14:b2:08
[    1.853131] tg3 0000:02:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.853135] tg3 0000:02:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.853138] tg3 0000:02:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.853345] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.853574] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.853580] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.853583] usb usb1: Product: EHCI Host Controller
[    1.853586] usb usb1: Manufacturer: Linux 5.17.1bkc1+ ehci_hcd
[    1.853588] usb usb1: SerialNumber: 0000:00:1a.7
[    1.853778] hub 1-0:1.0: USB hub found
[    1.853788] hub 1-0:1.0: 6 ports detected
[    1.854169] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.854341] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 2
[    1.854465] uhci_hcd 0000:00:1a.0: detected 2 ports
[    1.854596] uhci_hcd 0000:00:1a.0: irq 21, io port 0x00003140
[    1.854725] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    1.854730] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.854733] usb usb2: Product: UHCI Host Controller
[    1.854735] usb usb2: Manufacturer: Linux 5.17.1bkc1+ uhci_hcd
[    1.854737] usb usb2: SerialNumber: 0000:00:1a.0
[    1.854822] hub 2-0:1.0: USB hub found
[    1.854830] hub 2-0:1.0: 2 ports detected
[    1.854966] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.854975] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 3
[    1.855074] ehci-pci 0000:00:1d.7: debug port 2
[    1.859140] ehci-pci 0000:00:1d.7: irq 22, io mem 0xa8906800
[    1.893374] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.893568] firewire_ohci 0000:04:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    1.893840] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.893847] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.893851] usb usb3: Product: EHCI Host Controller
[    1.893855] usb usb3: Manufacturer: Linux 5.17.1bkc1+ ehci_hcd
[    1.893858] usb usb3: SerialNumber: 0000:00:1d.7
[    1.893961] hub 3-0:1.0: USB hub found
[    1.893969] hub 3-0:1.0: 8 ports detected
[    1.894632] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.894645] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    1.894704] uhci_hcd 0000:00:1d.0: detected 2 ports
[    1.894932] scsi host0: ahci
[    1.894959] uhci_hcd 0000:00:1d.0: irq 19, io port 0x000030e0
[    1.895170] scsi host1: ahci
[    1.895366] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    1.895373] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.895379] scsi host2: ahci
[    1.895385] usb usb4: Product: UHCI Host Controller
[    1.895390] usb usb4: Manufacturer: Linux 5.17.1bkc1+ uhci_hcd
[    1.895394] usb usb4: SerialNumber: 0000:00:1d.0
[    1.895523] scsi host3: ahci
[    1.895552] hub 4-0:1.0: USB hub found
[    1.895563] hub 4-0:1.0: 2 ports detected
[    1.895744] ehci-pci 0000:1c:00.2: EHCI Host Controller
[    1.895759] ehci-pci 0000:1c:00.2: new USB bus registered, assigned bus number 5
[    1.895765] scsi host4: ahci
[    1.895986] scsi host5: ahci
[    1.896105] ata1: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906100 irq 52
[    1.896123] ata2: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906180 irq 52
[    1.896160] ata3: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906200 irq 52
[    1.896178] ehci-pci 0000:1c:00.2: irq 17, io mem 0xb0b02000
[    1.896185] ata4: DUMMY
[    1.896189] ata5: DUMMY
[    1.896207] ata6: DUMMY
[    1.923369] ehci-pci 0000:1c:00.2: USB 2.0 started, EHCI 1.00
[    1.923628] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.923635] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.923655] usb usb5: Product: EHCI Host Controller
[    1.923658] usb usb5: Manufacturer: Linux 5.17.1bkc1+ ehci_hcd
[    1.923660] usb usb5: SerialNumber: 0000:1c:00.2
[    1.923868] hub 5-0:1.0: USB hub found
[    1.923920] hub 5-0:1.0: 4 ports detected
[    1.924800] ehci-pci 0000:23:00.2: EHCI Host Controller
[    1.924807] ehci-pci 0000:23:00.2: new USB bus registered, assigned bus number 6
[    1.925161] ehci-pci 0000:23:00.2: irq 17, io mem 0xb0f02000
[    1.946501] tg3 0000:1d:00.0 eth1: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[    1.946507] tg3 0000:1d:00.0 eth1: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.946511] tg3 0000:1d:00.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.946514] tg3 0000:1d:00.0 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.963464] ehci-pci 0000:23:00.2: USB 2.0 started, EHCI 1.00
[    1.963737] firewire_ohci 0000:1e:00.0: added OHCI v1.10 device as card 1, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    1.963754] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.963757] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.963759] usb usb6: Product: EHCI Host Controller
[    1.963760] usb usb6: Manufacturer: Linux 5.17.1bkc1+ ehci_hcd
[    1.963761] usb usb6: SerialNumber: 0000:23:00.2
[    1.963889] hub 6-0:1.0: USB hub found
[    1.963937] hub 6-0:1.0: 4 ports detected
[    2.033710] firewire_ohci 0000:25:00.0: added OHCI v1.10 device as card 2, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    2.037622] tg3 0000:24:00.0 eth2: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[    2.037629] tg3 0000:24:00.0 eth2: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.037632] tg3 0000:24:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.037636] tg3 0000:24:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.158438] ATOM BIOS: Apple
[    2.158584] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.158588] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    2.158594] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.158596] [drm] RAM width 256bits DDR
[    2.158612] [drm] radeon: 1024M of VRAM memory ready
[    2.158614] [drm] radeon: 1024M of GTT memory ready.
[    2.158618] [drm] Loading BARTS Microcode
[    2.158668] [drm] External GPIO thermal controller with fan control
[    2.158682] == power state 0 ==
[    2.158684] 	ui class: none
[    2.158685] 	internal class: boot
[    2.158688] 	caps:
[    2.158689] 	uvd    vclk: 0 dclk: 0
[    2.158691] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.158693] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.158695] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.158697] 	status: c r b
[    2.158699] == power state 1 ==
[    2.158700] 	ui class: performance
[    2.158702] 	internal class: none
[    2.158703] 	caps:
[    2.158704] 	uvd    vclk: 0 dclk: 0
[    2.158706] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.158708] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    2.158710] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.158711] 	status:
[    2.158713] == power state 2 ==
[    2.158714] 	ui class: none
[    2.158715] 	internal class: uvd
[    2.158717] 	caps: video
[    2.158718] 	uvd    vclk: 54000 dclk: 40000
[    2.158720] 		power level 0    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    2.158722] 		power level 1    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    2.158724] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.158726] 	status:
[    2.158727] == power state 3 ==
[    2.158728] 	ui class: none
[    2.158729] 	internal class: uvd_mvc
[    2.158731] 	caps: video
[    2.158732] 	uvd    vclk: 70000 dclk: 56000
[    2.158734] 		power level 0    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    2.158736] 		power level 1    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    2.158737] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.158739] 	status:
[    2.158740] == power state 4 ==
[    2.158742] 	ui class: battery
[    2.158743] 	internal class: none
[    2.158744] 	caps:
[    2.158745] 	uvd    vclk: 0 dclk: 0
[    2.158747] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.158748] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.158750] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.158752] 	status:
[    2.163327] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    2.163702] [drm] radeon: dpm initialized
[    2.163766] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    2.164144] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    2.182525] [drm] PCIE GART of 1024M enabled (table at 0x0000000000162000).
[    2.182626] radeon 0000:01:00.0: WB enabled
[    2.182629] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00
[    2.182632] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c
[    2.183406] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118
[    2.183844] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    2.183880] radeon 0000:01:00.0: radeon: using MSI.
[    2.183910] [drm] radeon: irq initialized.
[    2.193339] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    2.200268] [drm] ring test on 0 succeeded in 3 usecs
[    2.200280] [drm] ring test on 3 succeeded in 7 usecs
[    2.224645] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.224666] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.224819] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.226238] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.226336] ata1.00: supports DRM functions and may not be fully accessible
[    2.226340] ata1.00: ATA-9: Samsung SSD 850 PRO 256GB, EXM03B6Q, max UDMA/133
[    2.226413] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.226504] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.226512] ata3.00: ATAPI: OPTIARC DVD RW AD-5690H, 4AH5, max UDMA/100
[    2.226523] ata2.00: supports DRM functions and may not be fully accessible
[    2.226528] ata2.00: ATA-9: Samsung SSD 850 EVO 500GB, EMT02B6Q, max UDMA/133
[    2.227075] ata1.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.227158] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.228670] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.228678] ata3.00: configured for UDMA/100
[    2.229075] ata1.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    2.229161] ata2.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    2.229404] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.229477] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.229486] ata1.00: supports DRM functions and may not be fully accessible
[    2.229531] ata2.00: supports DRM functions and may not be fully accessible
[    2.232290] ata2.00: configured for UDMA/133
[    2.232312] ata1.00: configured for UDMA/133
[    2.232392] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 850  3B6Q PQ: 0 ANSI: 5
[    2.232651] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 850  2B6Q PQ: 0 ANSI: 5
[    2.234094] scsi 2:0:0:0: CD-ROM            OPTIARC  DVD RW AD-5690H  4AH5 PQ: 0 ANSI: 5
[    2.363786] usb 1-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    2.363792] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.364018] hub 1-1:1.0: USB hub found
[    2.364123] hub 1-1:1.0: 3 ports detected
[    2.377398] [drm] ring test on 5 succeeded in 1 usecs
[    2.377426] [drm] UVD initialized successfully.
[    2.377619] usb 5-1: new high-speed USB device number 2 using ehci-pci
[    2.377715] [drm] ib test on ring 0 succeeded in 0 usecs
[    2.377881] [drm] ib test on ring 3 succeeded in 0 usecs
[    2.393751] usb 3-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    2.393757] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.394034] hub 3-1:1.0: USB hub found
[    2.394129] hub 3-1:1.0: 4 ports detected
[    2.403449] firewire_core 0000:04:00.0: created device fw0: GUID a4b197fffe3f2da2, S800
[    2.403466] firewire_core 0000:04:00.0: phy config: new root=ffc0, gap_count=63
[    2.443316] usb 6-1: new high-speed USB device number 2 using ehci-pci
[    2.473378] firewire_core 0000:1e:00.0: created device fw1: GUID 000a27020040c4ba, S800
[    2.473394] firewire_core 0000:1e:00.0: phy config: new root=ffc0, gap_count=63
[    2.513321] usb 1-2: new high-speed USB device number 3 using ehci-pci
[    2.543505] firewire_core 0000:25:00.0: created device fw2: GUID 000a2702006cfdfb, S800
[    2.543517] firewire_core 0000:25:00.0: phy config: new root=ffc0, gap_count=63
[    2.574162] usb 5-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[    2.574168] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.574494] hub 5-1:1.0: USB hub found
[    2.574684] hub 5-1:1.0: 7 ports detected
[    2.574748] ohci-pci: OHCI PCI platform driver
[    2.574845] ohci-pci 0000:1c:00.0: OHCI PCI host controller
[    2.574852] ohci-pci 0000:1c:00.0: new USB bus registered, assigned bus number 7
[    2.574879] ohci-pci 0000:1c:00.0: irq 19, io mem 0xb0b00000
[    2.577529] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    2.577530] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    2.577538] sd 0:0:0:0: [sda] Write Protect is off
[    2.577541] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.577553] sd 1:0:0:0: [sdb] Write Protect is off
[    2.577555] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.577558] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.577582] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.580094] sd 1:0:0:0: [sdb] supports TCG Opal
[    2.580098] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.580153]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[    2.581064] sd 0:0:0:0: [sda] supports TCG Opal
[    2.581069] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.581530] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.581580] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.581600] sr 2:0:0:0: Attached scsi generic sg2 type 5
[    2.643364] tsc: Refined TSC clocksource calibration: 3400.023 MHz
[    2.643383] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x31026473058, max_idle_ns: 440795314252 ns
[    2.647515] clocksource: Switched to clocksource tsc
[    2.647735] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.647753] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.647755] usb usb7: Product: OHCI PCI host controller
[    2.647758] usb usb7: Manufacturer: Linux 5.17.1bkc1+ ohci_hcd
[    2.647760] usb usb7: SerialNumber: 0000:1c:00.0
[    2.647920] hub 7-0:1.0: USB hub found
[    2.647947] hub 7-0:1.0: 2 ports detected
[    2.647956] usb 6-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[    2.647963] usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.648207] hub 6-1:1.0: USB hub found
[    2.648215] ohci-pci 0000:1c:00.1: OHCI PCI host controller
[    2.648221] ohci-pci 0000:1c:00.1: new USB bus registered, assigned bus number 8
[    2.648261] ohci-pci 0000:1c:00.1: irq 16, io mem 0xb0b01000
[    2.648558] hub 6-1:1.0: 7 ports detected
[    2.715360] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda caddy
[    2.715366] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.717451] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.717457] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.717459] usb usb8: Product: OHCI PCI host controller
[    2.717461] usb usb8: Manufacturer: Linux 5.17.1bkc1+ ohci_hcd
[    2.717463] usb usb8: SerialNumber: 0000:1c:00.1
[    2.717595] hub 8-0:1.0: USB hub found
[    2.717610] hub 8-0:1.0: 2 ports detected
[    2.717762] ohci-pci 0000:23:00.0: OHCI PCI host controller
[    2.717767] ohci-pci 0000:23:00.0: new USB bus registered, assigned bus number 9
[    2.717793] ohci-pci 0000:23:00.0: irq 19, io mem 0xb0f00000
[    2.723363] usb 3-1.1: new high-speed USB device number 3 using ehci-pci
[    2.738895] usb 1-2: New USB device found, idVendor=05ac, idProduct=850b, bcdDevice= 7.55
[    2.738916] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.738919] usb 1-2: Product: FaceTime HD Camera (Built-in)
[    2.738921] usb 1-2: Manufacturer: Apple Inc.
[    2.738923] usb 1-2: SerialNumber: CCGB8K062WDDJRLX
[    2.794439] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    2.797507] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.797512] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.797515] usb usb9: Product: OHCI PCI host controller
[    2.797518] usb usb9: Manufacturer: Linux 5.17.1bkc1+ ohci_hcd
[    2.797520] usb usb9: SerialNumber: 0000:23:00.0
[    2.797637] hub 9-0:1.0: USB hub found
[    2.797655] hub 9-0:1.0: 2 ports detected
[    2.797803] ohci-pci 0000:23:00.1: OHCI PCI host controller
[    2.797809] ohci-pci 0000:23:00.1: new USB bus registered, assigned bus number 10
[    2.797835] ohci-pci 0000:23:00.1: irq 16, io mem 0xb0f01000
[    2.833353] usb 1-1.1: new full-speed USB device number 4 using ehci-pci
[    2.867499] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.867504] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.867507] usb usb10: Product: OHCI PCI host controller
[    2.867510] usb usb10: Manufacturer: Linux 5.17.1bkc1+ ohci_hcd
[    2.867512] usb usb10: SerialNumber: 0000:23:00.1
[    2.867629] hub 10-0:1.0: USB hub found
[    2.867646] hub 10-0:1.0: 2 ports detected
[    2.888367] usb 3-1.1: New USB device found, idVendor=05ac, idProduct=8403, bcdDevice=98.33
[    2.888380] usb 3-1.1: New USB device strings: Mfr=3, Product=4, SerialNumber=2
[    2.888387] usb 3-1.1: Product: Card Reader
[    2.888391] usb 3-1.1: Manufacturer: Apple
[    2.888396] usb 3-1.1: SerialNumber: 000000009833
[    2.890304] usb-storage 3-1.1:1.0: USB Mass Storage device detected
[    2.890375] scsi host6: usb-storage 3-1.1:1.0
[    2.890427] usbcore: registered new interface driver usb-storage
[    2.890677] usbcore: registered new interface driver uas
[    2.903322] usb 5-1.4: new full-speed USB device number 3 using ehci-pci
[    2.973362] usb 6-1.4: new full-speed USB device number 3 using ehci-pci
[    2.983343] usb 3-1.2: new low-speed USB device number 4 using ehci-pci
[    2.985733] usb 1-1.1: New USB device found, idVendor=0a5c, idProduct=4500, bcdDevice= 1.00
[    2.985740] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.985743] usb 1-1.1: Product: BRCM2046 Hub
[    2.985745] usb 1-1.1: Manufacturer: Apple Inc.
[    2.986015] hub 1-1.1:1.0: USB hub found
[    2.986203] hub 1-1.1:1.0: 3 ports detected
[    3.033489] [drm] ib test on ring 5 succeeded
[    3.063127] usb 5-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[    3.063141] usb 5-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.063148] usb 5-1.4: Product: Display Audio
[    3.063152] usb 5-1.4: Manufacturer: Apple Inc.
[    3.063156] usb 5-1.4: SerialNumber: 152303D9
[    3.065527] hid: raw HID events driver (C) Jiri Kosina
[    3.076921] usbcore: registered new interface driver usbhid
[    3.076925] usbhid: USB HID core driver
[    3.077763] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:00.0/0000:1a:00.0/0000:1b:03.0/0000:1c:00.2/usb5/5-1/5-1.4/5-1.4:1.3/0003:05AC:1107.0001/input/input0
[    3.077841] hid-generic 0003:05AC:1107.0001: input,hidraw0: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:1c:00.2-1.4/input3
[    3.093370] usb 1-1.2: new high-speed USB device number 5 using ehci-pci
[    3.113355] [drm] radeon atom DIG backlight initialized
[    3.113370] [drm] Radeon Display Connectors
[    3.113374] [drm] Connector 0:
[    3.113377] [drm]   eDP-1
[    3.113381] [drm]   HPD3
[    3.113383] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[    3.113390] [drm]   Encoders:
[    3.113393] [drm]     LCD1: INTERNAL_UNIPHY2
[    3.113397] [drm] Connector 1:
[    3.113399] [drm]   DP-1
[    3.113402] [drm]   HPD1
[    3.113405] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    3.113411] [drm]   Encoders:
[    3.113413] [drm]     DFP1: INTERNAL_UNIPHY1
[    3.113416] [drm] Connector 2:
[    3.113419] [drm]   DP-2
[    3.113422] [drm]   HPD2
[    3.113424] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[    3.113430] [drm]   Encoders:
[    3.113433] [drm]     DFP2: INTERNAL_UNIPHY1
[    3.113436] [drm] Connector 3:
[    3.113439] [drm]   DP-3
[    3.113449] [drm]   HPD4
[    3.113450] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[    3.113453] [drm]   Encoders:
[    3.113454] [drm]     DFP3: INTERNAL_UNIPHY2
[    3.113455] [drm] Connector 4:
[    3.113456] [drm]   DP-4
[    3.113457] [drm]   HPD5
[    3.113459] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 0x647c 0x647c
[    3.113461] [drm]   Encoders:
[    3.113462] [drm]     DFP4: INTERNAL_UNIPHY
[    3.113464] [drm] Connector 5:
[    3.113465] [drm]   VGA-1
[    3.113466] [drm]   DDC: 0x64d8 0x64d8 0x64dc 0x64dc 0x64e0 0x64e0 0x64e4 0x64e4
[    3.113468] [drm]   Encoders:
[    3.113470] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    3.143794] usb 6-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[    3.143812] usb 6-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.143813] switching from power state:
[    3.143815] usb 6-1.4: Product: Display Audio
[    3.143816] usb 6-1.4: Manufacturer: Apple Inc.
[    3.143819] 	ui class: none
[    3.143820] usb 6-1.4: SerialNumber: 1A0E0738
[    3.143821] 	internal class: boot
[    3.143826] 	caps:
[    3.143827] 	uvd    vclk: 0 dclk: 0
[    3.143829] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.143831] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.143833] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.143835] 	status: c b
[    3.143837] switching to power state:
[    3.143839] 	ui class: performance
[    3.143840] 	internal class: none
[    3.143842] 	caps:
[    3.143843] 	uvd    vclk: 0 dclk: 0
[    3.143844] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    3.143846] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    3.143848] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    3.143850] 	status: r
[    3.155801] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:04.0/0000:1f:00.0/0000:20:00.0/0000:21:00.0/0000:22:03.0/0000:23:00.2/usb6/6-1/6-1.4/6-1.4:1.3/0003:05AC:1107.0002/input/input1
[    3.155838] hid-generic 0003:05AC:1107.0002: input,hidraw1: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:23:00.2-1.4/input3
[    3.159867] usb 3-1.2: New USB device found, idVendor=05ac, idProduct=8242, bcdDevice= 0.16
[    3.159881] usb 3-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.159888] usb 3-1.2: Product: IR Receiver
[    3.159893] usb 3-1.2: Manufacturer: Apple Computer, Inc.
[    3.165131] input: Apple Computer, Inc. IR Receiver as /devices/pci0000:00/0000:00:1d.7/usb3/3-1/3-1.2/3-1.2:1.0/0003:05AC:8242.0003/input/input2
[    3.173319] usb 5-1.5: new high-speed USB device number 4 using ehci-pci
[    3.233510] appleir 0003:05AC:8242.0003: input,hiddev96,hidraw2: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.7-1.2/input0
[    3.251952] usb 1-1.2: New USB device found, idVendor=05ac, idProduct=1006, bcdDevice=96.15
[    3.251958] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.251961] usb 1-1.2: Product: Keyboard Hub
[    3.251963] usb 1-1.2: Manufacturer: Apple, Inc.
[    3.251965] usb 1-1.2: SerialNumber: 000000000000
[    3.252146] hub 1-1.2:1.0: USB hub found
[    3.252236] hub 1-1.2:1.0: 3 ports detected
[    3.253319] usb 6-1.5: new high-speed USB device number 4 using ehci-pci
[    3.263320] usb 3-1.4: new low-speed USB device number 5 using ehci-pci
[    3.340552] usb 5-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[    3.340558] usb 5-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.340561] usb 5-1.5: Product: FaceTime HD Camera (Display)
[    3.340563] usb 5-1.5: Manufacturer: Apple Inc.
[    3.340565] usb 5-1.5: SerialNumber: CCGB690CKUDJ9DFX
[    3.343341] usb 1-1.1.1: new full-speed USB device number 6 using ehci-pci
[    3.418877] usb 3-1.4: New USB device found, idVendor=047d, idProduct=1020, bcdDevice= 1.06
[    3.418883] usb 3-1.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.418886] usb 3-1.4: Product: Kensington Expert Mouse
[    3.420777] usb 6-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[    3.420783] usb 6-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.420787] usb 6-1.5: Product: FaceTime HD Camera (Display)
[    3.420789] usb 6-1.5: Manufacturer: Apple Inc.
[    3.420791] usb 6-1.5: SerialNumber: CC2G3101FFDJ9FLP
[    3.421905] input: Kensington Expert Mouse as /devices/pci0000:00/0000:00:1d.7/usb3/3-1/3-1.4/3-1.4:1.0/0003:047D:1020.0004/input/input3
[    3.422044] hid-generic 0003:047D:1020.0004: input,hidraw3: USB HID v1.11 Mouse [Kensington Expert Mouse] on usb-0000:00:1d.7-1.4/input0
[    3.443331] usb 5-1.7: new full-speed USB device number 5 using ehci-pci
[    3.498127] usb 1-1.1.1: New USB device found, idVendor=05ac, idProduct=8215, bcdDevice= 2.08
[    3.498133] usb 1-1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.498136] usb 1-1.1.1: Product: Bluetooth USB Host Controller
[    3.498138] usb 1-1.1.1: Manufacturer: Apple Inc.
[    3.498140] usb 1-1.1.1: SerialNumber: 3451C9ED7F9B
[    3.523321] usb 6-1.7: new full-speed USB device number 5 using ehci-pci
[    3.593322] usb 1-1.3: new full-speed USB device number 7 using ehci-pci
[    3.595952] usb 5-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.37
[    3.595958] usb 5-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.595961] usb 5-1.7: Product: Apple Thunderbolt Display
[    3.595963] usb 5-1.7: Manufacturer: Apple Inc.
[    3.595965] usb 5-1.7: SerialNumber: 152303D9
[    3.597970] hid-generic 0003:05AC:9227.0005: hiddev97,hidraw4: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:1c:00.2-1.7/input0
[    3.676075] usb 6-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.39
[    3.676081] usb 6-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.676084] usb 6-1.7: Product: Apple Thunderbolt Display
[    3.676086] usb 6-1.7: Manufacturer: Apple Inc.
[    3.676087] usb 6-1.7: SerialNumber: 1A0E0738
[    3.678216] hid-generic 0003:05AC:9227.0006: hiddev98,hidraw5: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:23:00.2-1.7/input0
[    3.744354] usb 1-1.3: New USB device found, idVendor=067b, idProduct=2303, bcdDevice= 4.00
[    3.744360] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.744363] usb 1-1.3: Product: USB-Serial Controller C
[    3.744365] usb 1-1.3: Manufacturer: Prolific Technology Inc.
[    3.843321] usb 1-1.2.2: new low-speed USB device number 8 using ehci-pci
[    3.915021] scsi 6:0:0:0: Direct-Access     APPLE    SD Card Reader   1.00 PQ: 0 ANSI: 0
[    3.915179] sd 6:0:0:0: Attached scsi generic sg3 type 0
[    3.915861] sd 6:0:0:0: [sdc] Media removed, stopped polling
[    3.916609] sd 6:0:0:0: [sdc] Attached SCSI removable disk
[    4.000372] usb 1-1.2.2: New USB device found, idVendor=05ac, idProduct=0220, bcdDevice= 0.71
[    4.000378] usb 1-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.000381] usb 1-1.2.2: Product: Apple Keyboard
[    4.000383] usb 1-1.2.2: Manufacturer: Apple, Inc
[    4.008455] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.0/0003:05AC:0220.0007/input/input4
[    4.073438] apple 0003:05AC:0220.0007: input,hidraw6: USB HID v1.11 Keyboard [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input0
[    4.073521] apple 0003:05AC:0220.0008: Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling
[    4.073544] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.1/0003:05AC:0220.0008/input/input5
[    4.093321] usb 1-1.1.2: new full-speed USB device number 9 using ehci-pci
[    4.143436] apple 0003:05AC:0220.0008: input,hidraw7: USB HID v1.11 Device [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input1
[    4.247266] usb 1-1.1.2: New USB device found, idVendor=05ac, idProduct=820a, bcdDevice= 1.00
[    4.247282] usb 1-1.1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.249159] input: HID 05ac:820a as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:05AC:820A.0009/input/input6
[    4.313408] hid-generic 0003:05AC:820A.0009: input,hidraw8: USB HID v1.11 Keyboard [HID 05ac:820a] on usb-0000:00:1a.7-1.1.2/input0
[    4.413334] usb 1-1.1.3: new full-speed USB device number 10 using ehci-pci
[    4.536820] [drm] fb mappable at 0x90363000
[    4.536824] [drm] vram apper at 0x90000000
[    4.536825] [drm] size 14745600
[    4.536827] [drm] fb depth is 24
[    4.536828] [drm]    pitch is 10240
[    4.536919] fbcon: radeondrmfb (fb0) is primary device
[    4.566871] usb 1-1.1.3: New USB device found, idVendor=05ac, idProduct=820b, bcdDevice= 1.00
[    4.566873] usb 1-1.1.3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.568606] input: HID 05ac:820b as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.0/0003:05AC:820B.000A/input/input7
[    4.568648] hid-generic 0003:05AC:820B.000A: input,hidraw9: USB HID v1.11 Mouse [HID 05ac:820b] on usb-0000:00:1a.7-1.1.3/input0
[    5.227723] switching from power state:
[    5.227724] 	ui class: performance
[    5.227725] 	internal class: none
[    5.227726] 	caps:
[    5.227727] 	uvd    vclk: 0 dclk: 0
[    5.227728] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    5.227729] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    5.227730] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    5.227730] 	status: c r
[    5.227731] switching to power state:
[    5.227731] 	ui class: performance
[    5.227732] 	internal class: none
[    5.227732] 	caps:
[    5.227733] 	uvd    vclk: 0 dclk: 0
[    5.227733] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    5.227734] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    5.227735] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    5.227735] 	status: c r
[    6.343798] switching from power state:
[    6.343799] 	ui class: performance
[    6.343800] 	internal class: none
[    6.343801] 	caps:
[    6.343802] 	uvd    vclk: 0 dclk: 0
[    6.343802] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    6.343803] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    6.343804] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    6.343805] 	status: c r
[    6.343806] switching to power state:
[    6.343806] 	ui class: performance
[    6.343806] 	internal class: none
[    6.343807] 	caps:
[    6.343807] 	uvd    vclk: 0 dclk: 0
[    6.343808] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    6.343809] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    6.343809] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    6.343810] 	status: c r
[    6.453961] Console: switching to colour frame buffer device 320x90
[    6.460786] radeon 0000:01:00.0: [drm] fb0: radeondrmfb frame buffer device
[    6.503390] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[    6.529745] [drm] amdgpu kernel modesetting enabled.
[    6.605203] netpoll: netconsole: local port 6666
[    6.605224] netpoll: netconsole: local IPv4 address 192.168.2.87
[    6.605245] netpoll: netconsole: interface 'eth0'
[    6.605260] netpoll: netconsole: remote port 6666
[    6.605275] netpoll: netconsole: remote IPv4 address 192.168.2.208
[    6.605294] netpoll: netconsole: remote ethernet address dc:a6:32:61:33:da
[    6.605318] netpoll: netconsole: device eth0 not up yet, forcing it
[   10.164780] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   10.164803] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   10.164824] tg3 0000:02:00.0 eth0: EEE is enabled
[   10.203785] printk: console [netcon0] enabled
[   10.203802] netconsole: network logging started
[   17.321242]  sdb: sdb1
[   17.374513] process '/usr/bin/fstype' started with executable stack
[   17.421491] EXT4-fs (sda6): mounted filesystem with ordered data mode. Quota mode: none.
[   17.601034] udevd[1276]: starting version 3.2.9
[   17.623788] udevd[1277]: starting eudev-3.2.9
[   17.656078] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input8
[   17.658268] ACPI: button: Power Button [PWRB]
[   17.660490] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input9
[   17.662796] ACPI: button: Sleep Button [SLPB]
[   17.664562] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input10
[   17.673340] udevd[1330]: Error changing net interface name eth1 to eth2: File exists
[   17.675262] udevd[1330]: could not rename interface '3' from 'eth1' to 'eth2': File exists
[   17.691247] mc: Linux media interface: v0.10
[   17.691612] udevd[1331]: Error changing net interface name eth2 to eth1: File exists
[   17.694940] udevd[1331]: could not rename interface '4' from 'eth2' to 'eth1': File exists
[   17.697949] videodev: Linux video capture interface: v2.00
[   17.703826] ACPI: button: Power Button [PWRF]
[   17.704434] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[   17.707592] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[   17.714729] usb 1-2: Found UVC 1.00 device FaceTime HD Camera (Built-in) (05ac:850b)
[   17.719879] usbcore: registered new interface driver usbserial_generic
[   17.721997] usbserial: USB Serial support registered for generic
[   17.724992] usb 5-1.4: 1:1: cannot get freq at ep 0x4
[   17.725075] usbcore: registered new interface driver pl2303
[   17.726969] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input11
[   17.729856] usbserial: USB Serial support registered for pl2303
[   17.732596] pl2303 1-1.3:1.0: pl2303 converter detected
[   17.735643] snd_hda_codec_cirrus hdaudioC0D0: autoconfig for CS4206: line_outs=2 (0x9/0xb/0x0/0x0/0x0) type:speaker
[   17.736302] usb 1-1.3: pl2303 converter now attached to ttyUSB0
[   17.737791] snd_hda_codec_cirrus hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   17.741865] input: FaceTime HD Camera (Built-in):  as /devices/pci0000:00/0000:00:1a.7/usb1/1-2/1-2:1.0/input/input12
[   17.742035] snd_hda_codec_cirrus hdaudioC0D0:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[   17.745265] usb 5-1.5: Found UVC 1.00 device FaceTime HD Camera (Display) (05ac:1112)
[   17.745733] snd_hda_codec_cirrus hdaudioC0D0:    mono: mono_out=0x0
[   17.749324] snd_hda_codec_cirrus hdaudioC0D0:    dig-out=0x10/0x0
[   17.750764] snd_hda_codec_cirrus hdaudioC0D0:    inputs:
[   17.752213] snd_hda_codec_cirrus hdaudioC0D0:      Mic=0xd
[   17.754417] Bluetooth: Core ver 2.22
[   17.754542] snd_hda_codec_cirrus hdaudioC0D0:      Line=0xc
[   17.756567] NET: Registered PF_BLUETOOTH protocol family
[   17.758711] snd_hda_codec_cirrus hdaudioC0D0:    dig-in=0xf
[   17.761804] Bluetooth: HCI device and connection manager initialized
[   17.763367] Bluetooth: HCI socket layer initialized
[   17.764982] Bluetooth: L2CAP socket layer initialized
[   17.766931] Bluetooth: SCO socket layer initialized
[   17.771204] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   17.772743] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   17.774274] input: HDA Intel PCH SPDIF In as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   17.779051] usbcore: registered new interface driver btusb
[   17.802584] applesmc: key=332 fan=3 temp=50 index=49 acc=0 lux=2 kbd=0
[   17.804989] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   17.825107] usb 1-1.1.2: USB disconnect, device number 9
[   17.894263] usb 5-1.4: 1:2: cannot get freq at ep 0x4
[   17.898882] input: FaceTime HD Camera (Display): F as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:00.0/0000:1a:00.0/0000:1b:03.0/0000:1c:00.2/usb5/5-1/5-1.5/5-1.5:1.0/input/input16
[   17.903293] usb 5-1.4: 2:1: cannot get freq at ep 0x84
[   17.906426] Bluetooth: hci0: BCM: chip id 254 build 0518
[   17.909407] Bluetooth: hci0: BCM: product 05ac:8215
[   17.912408] Bluetooth: hci0: BCM: features 0x00
[   17.930379] Bluetooth: hci0: Bluetooth USB Host Controller
[   17.946112] usb 5-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   17.947654] usb 5-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   17.983033] usb 5-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   17.985296] usb 5-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   17.999895] usb 6-1.4: 1:1: cannot get freq at ep 0x4
[   18.034865] usb 6-1.5: Found UVC 1.00 device FaceTime HD Camera (Display) (05ac:1112)
[   18.169853] usb 6-1.4: 1:2: cannot get freq at ep 0x4
[   18.174480] input: FaceTime HD Camera (Display): F as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:04.0/0000:1f:00.0/0000:20:00.0/0000:21:00.0/0000:22:03.0/0000:23:00.2/usb6/6-1/6-1.5/6-1.5:1.0/input/input17
[   18.176246] usbcore: registered new interface driver uvcvideo
[   18.178820] usb 6-1.4: 2:1: cannot get freq at ep 0x84
[   18.218703] usb 6-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   18.220350] usb 6-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   18.255833] usb 6-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   18.257541] usb 6-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   18.259594] usbcore: registered new interface driver snd-usb-audio
[   18.263725] usb 1-1.1.3: USB disconnect, device number 10
[   18.586466] Adding 16777212k swap on /dev/sda5.  Priority:-2 extents:1 across:16777212k SS
[   18.600939] EXT4-fs (sda6): re-mounted. Quota mode: none.
[   18.688391] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
[   21.868276] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Quota mode: none.
[   22.398472] NET: Registered PF_PACKET protocol family
[   25.302647] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   25.304141] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   25.305629] tg3 0000:02:00.0 eth0: EEE is enabled
[   30.913667] RPC: Registered named UNIX socket transport module.
[   30.915102] RPC: Registered udp transport module.
[   30.916547] RPC: Registered tcp transport module.
[   30.917967] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   30.922055] FS-Cache: Loaded
[   30.935962] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   30.957347] NFS: Registering the id_resolver key type
[   30.958864] Key type id_resolver registered
[   30.960350] Key type id_legacy registered
[   32.653208] elogind-daemon[3141]: New seat seat0.
[   34.199874] switching from power state:
[   34.199881] 	ui class: performance
[   34.199883] 	internal class: none
[   34.199885] 	caps:
[   34.199887] 	uvd    vclk: 0 dclk: 0
[   34.199888] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   34.199890] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[   34.199892] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[   34.199894] 	status: c
[   34.199896] switching to power state:
[   34.199896] 	ui class: battery
[   34.199897] 	internal class: none
[   34.199899] 	caps:
[   34.199900] 	uvd    vclk: 0 dclk: 0
[   34.199901] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   34.199903] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   34.199905] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   34.199906] 	status: r
[   42.521168] elogind-daemon[3141]: New session c1 of user brad.
[   54.326490] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   54.326503] thunderbolt 0000:07:00.0: acking hot unplug event on 0:4
[   54.326512] thunderbolt 0000:07:00.0: 0:3: switch unplugged
[   54.326517] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): deactivating
[   54.326559] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 3:10 to 0:7
[   54.373181] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
[   54.373421] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 0:7 to 3:10
[   54.374767] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
[   54.423101] ohci-pci 0000:1c:00.1: HC died; cleaning up
[   54.473019] ohci-pci 0000:23:00.1: HC died; cleaning up
[   54.473033] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
[   54.473036] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
[   54.473042] pcieport 0000:06:04.0: pciehp: Slot(4-1): Link Down
[   54.473044] pcieport 0000:06:04.0: pciehp: Slot(4-1): Card not present
[   54.473053] pcieport 0000:19:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   54.473252] thunderbolt 0000:07:00.0: 0:c <-> 3:b (DP): deactivating
[   54.473259] pcieport 0000:20:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   54.487136] pcieport 0000:20:04.0: can't change power state from D3cold to D0 (config space inaccessible)
[   54.487674] thunderbolt 0000:07:00.0: deactivating Video path from 0:12 to 3:11
[   54.488055] thunderbolt 0000:07:00.0: 0:c: adding -5 NFC credits to 5
[   54.488181] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:12 to 3:11
[   54.488565] thunderbolt 0000:07:00.0: deactivating AUX RX path from 3:11 to 0:12
[   54.488949] thunderbolt 0000:07:00.0: 0: released DP resource for port 12
[   54.488953] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): deactivating
[   54.488954] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 303:10 to 3:7
[   54.488956] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 3:7 to 303:10
[   54.490501] thunderbolt 0000:07:00.0: 0:d <-> 303:b (DP): deactivating
[   54.491152] thunderbolt 0000:07:00.0: deactivating Video path from 0:13 to 303:11
[   54.491536] thunderbolt 0000:07:00.0: 0:d: adding -5 NFC credits to 5
[   54.682718] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:13 to 303:11
[   54.682789] firewire_ohci 0000:25:00.0: removed fw-ohci device
[   54.683076] thunderbolt 0000:07:00.0: deactivating AUX RX path from 303:11 to 0:13
[   54.683461] thunderbolt 0000:07:00.0: 0: released DP resource for port 13
[   54.683467] thunderbolt 0000:07:00.0: 303:b: DP OUT resource unavailable
[   54.683522] thunderbolt 0-303: device disconnected
[   54.684197] thunderbolt 0-3: device disconnected
[   54.685834] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   54.690232] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   54.690354] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   54.690355] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
[   54.690358] thunderbolt 0000:07:00.0: 0:4: got unplug event for disconnected port, ignoring
[   54.812462] ehci-pci 0000:23:00.2: HC died; cleaning up
[   54.862410] ehci-pci 0000:23:00.2: remove, state 1
[   54.863634] usb usb6: USB disconnect, device number 1
[   54.863636] usb 6-1: USB disconnect, device number 2
[   54.863637] usb 6-1.4: USB disconnect, device number 3
[   54.907612] usb 6-1.5: USB disconnect, device number 4
[   55.087688] usb 6-1.7: USB disconnect, device number 5
[   55.591186] ehci-pci 0000:23:00.2: USB bus 6 deregistered
[   55.592537] ohci-pci 0000:23:00.1: remove, state 4
[   55.593772] usb usb10: USB disconnect, device number 1
[   56.240004] ohci-pci 0000:23:00.1: USB bus 10 deregistered
[   56.289886] ohci-pci 0000:23:00.0: HC died; cleaning up
[   56.289905] ohci-pci 0000:23:00.0: remove, state 4
[   56.289907] usb usb9: USB disconnect, device number 1
[   56.339797] sched: RT throttling activated
[   56.938778] ohci-pci 0000:23:00.0: USB bus 9 deregistered
[   57.138485] firewire_ohci 0000:1e:00.0: removed fw-ohci device
[   57.194600] switching from power state:
[   57.195865] 	ui class: battery
[   57.197086] 	internal class: none
[   57.198280] 	caps:
[   57.199473] 	uvd    vclk: 0 dclk: 0
[   57.200661] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   57.201871] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   57.203072] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   57.204271] 	status: c r
[   57.205455] switching to power state:
[   57.206654] 	ui class: battery
[   57.207851] 	internal class: none
[   57.207852] 	caps:
[   57.207853] 	uvd    vclk: 0 dclk: 0
[   57.207853] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   57.207854] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   57.207855] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   57.207855] 	status: c r
[   57.308106] ehci-pci 0000:1c:00.2: HC died; cleaning up
[   57.358050] ehci-pci 0000:1c:00.2: remove, state 1
[   57.359102] usb usb5: USB disconnect, device number 1
[   57.359104] usb 5-1: USB disconnect, device number 2
[   57.359105] usb 5-1.4: USB disconnect, device number 3
[   57.456495] usb 5-1.5: USB disconnect, device number 4
[   57.616580] usb 5-1.7: USB disconnect, device number 5
[   58.116648] ehci-pci 0000:1c:00.2: USB bus 5 deregistered
[   58.116749] ohci-pci 0000:1c:00.1: remove, state 4
[   58.116753] usb usb8: USB disconnect, device number 1
[   58.765466] ohci-pci 0000:1c:00.1: USB bus 8 deregistered
[   58.815349] ohci-pci 0000:1c:00.0: HC died; cleaning up
[   58.816403] ohci-pci 0000:1c:00.0: remove, state 4
[   58.817442] usb usb7: USB disconnect, device number 1
[   59.464196] ohci-pci 0000:1c:00.0: USB bus 7 deregistered
[   59.466252] pci_bus 0000:1c: busn_res: [bus 1c] is released
[   59.467528] pci_bus 0000:1b: busn_res: [bus 1b-1c] is released
[   59.468688] pci_bus 0000:1a: busn_res: [bus 1a-1c] is released
[   59.469898] pci_bus 0000:1d: busn_res: [bus 1d] is released
[   59.471070] pci_bus 0000:1e: busn_res: [bus 1e] is released
[   59.472715] pci_bus 0000:23: busn_res: [bus 23] is released
[   59.473960] pci_bus 0000:22: busn_res: [bus 22-23] is released
[   59.475077] pci_bus 0000:21: busn_res: [bus 21-23] is released
[   59.475481] pci_bus 0000:24: busn_res: [bus 24] is released
[   59.477417] pci_bus 0000:25: busn_res: [bus 25] is released
[   59.477910] pci_bus 0000:26: busn_res: [bus 26-35] is released
[   59.478486] pci_bus 0000:36: busn_res: [bus 36-45] is released
[   59.479051] pci_bus 0000:20: busn_res: [bus 20-45] is released
[   59.483149] pci_bus 0000:1f: busn_res: [bus 1f-45] is released
[   59.483509] pci_bus 0000:46: busn_res: [bus 46-55] is released
[   59.483753] pci_bus 0000:19: busn_res: [bus 19-55] is released
[   63.149034] thunderbolt 0000:07:00.0: acking hot plug event on 0:4
[   63.149153] thunderbolt 0000:07:00.0: 0:4: hotplug: scanning
[   63.149157] thunderbolt 0000:07:00.0: 0:4: hotplug: no switch found
[   63.168156] thunderbolt 0000:07:00.0: acking hot plug event on 0:3
[   63.168278] thunderbolt 0000:07:00.0: 0:3: hotplug: scanning
[   63.168360] thunderbolt 0000:07:00.0: 0:3: is connected, link is up (state: 2)
[   63.168611] thunderbolt 0000:07:00.0: current switch config:
[   63.168619] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   63.168624] thunderbolt 0000:07:00.0:   Max Port Number: 13
[   63.168627] thunderbolt 0000:07:00.0:   Config:
[   63.168629] thunderbolt 0000:07:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[   63.168633] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[   63.173196] thunderbolt 0000:07:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[   63.190569] thunderbolt 0000:07:00.0: 3: reading drom (length: 0x97)
[   63.686949] thunderbolt 0000:07:00.0: 3: DROM version: 1
[   63.687973] thunderbolt 0000:07:00.0: 3: uid: 0x1000100189170
[   63.690916] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   63.690921] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   63.690924] thunderbolt 0000:07:00.0:   Max counters: 32
[   63.690926] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   63.690928] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   63.693857] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   63.693860] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   63.693862] thunderbolt 0000:07:00.0:   Max counters: 32
[   63.693863] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   63.693864] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   63.705552] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   63.705554] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   63.705554] thunderbolt 0000:07:00.0:   Max counters: 32
[   63.705555] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   63.705556] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   63.708495] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   63.708497] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   63.708498] thunderbolt 0000:07:00.0:   Max counters: 32
[   63.708499] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   63.708499] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   63.708500] thunderbolt 0000:07:00.0: 3:5: disabled by eeprom
[   63.708501] thunderbolt 0000:07:00.0: 3:6: disabled by eeprom
[   63.709391] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   63.709393] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   63.709394] thunderbolt 0000:07:00.0:   Max counters: 1
[   63.709395] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   63.709396] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   63.710287] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   63.710289] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   63.710290] thunderbolt 0000:07:00.0:   Max counters: 1
[   63.710290] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   63.710291] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   63.710292] thunderbolt 0000:07:00.0: 3:9: disabled by eeprom
[   63.711183] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   63.711185] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   63.711186] thunderbolt 0000:07:00.0:   Max counters: 1
[   63.711187] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   63.711187] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   63.712335] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   63.712337] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[   63.712338] thunderbolt 0000:07:00.0:   Max counters: 2
[   63.712339] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   63.712339] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   63.712340] thunderbolt 0000:07:00.0: 3:c: disabled by eeprom
[   63.712341] thunderbolt 0000:07:00.0: 3:d: disabled by eeprom
[   63.730198] thunderbolt 0000:07:00.0: 3: TMU: current mode: bi-directional, HiFi
[   63.730230] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[   63.730231] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[   63.730477] thunderbolt 0000:07:00.0: 3:3: is connected, link is up (state: 2)
[   63.730619] thunderbolt 0000:07:00.0: current switch config:
[   63.730620] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   63.730622] thunderbolt 0000:07:00.0:   Max Port Number: 13
[   63.730623] thunderbolt 0000:07:00.0:   Config:
[   63.730623] thunderbolt 0000:07:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[   63.730625] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[   63.735228] thunderbolt 0000:07:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[   63.752635] thunderbolt 0000:07:00.0: 303: reading drom (length: 0x97)
[   63.878586] thunderbolt 0000:07:00.0: acking hot plug event on 3:b
[   63.878590] thunderbolt 0000:07:00.0: acking hot plug event on 3:b
[   63.979833] thunderbolt 0000:07:00.0: acking hot plug event on 303:b
[   63.979837] thunderbolt 0000:07:00.0: acking hot plug event on 303:b
[   64.246328] thunderbolt 0000:07:00.0: 303: DROM version: 1
[   64.247352] thunderbolt 0000:07:00.0: 303: uid: 0x100010102a740
[   64.250295] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   64.250298] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   64.250299] thunderbolt 0000:07:00.0:   Max counters: 32
[   64.250300] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   64.250301] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   64.253271] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   64.253273] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   64.253274] thunderbolt 0000:07:00.0:   Max counters: 32
[   64.253275] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   64.253275] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   64.256184] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   64.256187] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   64.256188] thunderbolt 0000:07:00.0:   Max counters: 32
[   64.256189] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   64.256190] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   64.259127] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   64.259129] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   64.259130] thunderbolt 0000:07:00.0:   Max counters: 32
[   64.259131] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   64.259132] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   64.259133] thunderbolt 0000:07:00.0: 303:5: disabled by eeprom
[   64.259134] thunderbolt 0000:07:00.0: 303:6: disabled by eeprom
[   64.260023] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   64.260025] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   64.260026] thunderbolt 0000:07:00.0:   Max counters: 1
[   64.260026] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   64.260027] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   64.260919] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   64.260921] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   64.260921] thunderbolt 0000:07:00.0:   Max counters: 1
[   64.260922] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   64.260923] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   64.260924] thunderbolt 0000:07:00.0: 303:9: disabled by eeprom
[   64.261815] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   64.261817] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   64.261817] thunderbolt 0000:07:00.0:   Max counters: 1
[   64.261818] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   64.261819] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   64.262967] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   64.262969] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[   64.262970] thunderbolt 0000:07:00.0:   Max counters: 2
[   64.262971] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   64.262972] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   64.262972] thunderbolt 0000:07:00.0: 303:c: disabled by eeprom
[   64.262973] thunderbolt 0000:07:00.0: 303:d: disabled by eeprom
[   64.281381] thunderbolt 0000:07:00.0: 303: TMU: current mode: bi-directional, HiFi
[   64.281400] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[   64.281402] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[   64.281510] thunderbolt 0000:07:00.0: 303:1: is unplugged (state: 7)
[   64.281785] thunderbolt 0000:07:00.0: 303:b: DP adapter HPD set, queuing hotplug
[   64.282021] thunderbolt 0000:07:00.0: 3:b: DP adapter HPD set, queuing hotplug
[   64.282185] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): activating
[   64.282188] thunderbolt 0000:07:00.0: activating PCIe Down path from 0:7 to 3:10
[   64.282277] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   64.284493] thunderbolt 0000:07:00.0: 3:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[   64.284495] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   64.284496] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   64.284498] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   64.284499] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.284696] thunderbolt 0000:07:00.0: 0:7: Writing hop 0
[   64.284699] thunderbolt 0000:07:00.0: 0:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[   64.284700] thunderbolt 0000:07:00.0: 0:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   64.284702] thunderbolt 0000:07:00.0: 0:7:    Counter enabled: 0 Counter index: 2047
[   64.284703] thunderbolt 0000:07:00.0: 0:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   64.284704] thunderbolt 0000:07:00.0: 0:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.284824] thunderbolt 0000:07:00.0: path activation complete
[   64.284826] thunderbolt 0000:07:00.0: activating PCIe Up path from 3:10 to 0:7
[   64.284952] thunderbolt 0000:07:00.0: 0:3: Writing hop 1
[   64.284954] thunderbolt 0000:07:00.0: 0:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[   64.284955] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   64.284957] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   64.284958] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   64.284959] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.285186] thunderbolt 0000:07:00.0: 3:a: Writing hop 0
[   64.285188] thunderbolt 0000:07:00.0: 3:a:  In HopID: 8 => Out port: 1 Out HopID: 8
[   64.285189] thunderbolt 0000:07:00.0: 3:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   64.285190] thunderbolt 0000:07:00.0: 3:a:    Counter enabled: 0 Counter index: 2047
[   64.285191] thunderbolt 0000:07:00.0: 3:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   64.285192] thunderbolt 0000:07:00.0: 3:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.285314] thunderbolt 0000:07:00.0: path activation complete
[   64.285345] pcieport 0000:06:04.0: pciehp: Slot(4-1): Card present
[   64.285699] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
[   64.285702] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   64.285919] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   64.285936] thunderbolt 0000:07:00.0: 3:b: DP OUT available
[   64.285938] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 12
[   64.285940] thunderbolt 0000:07:00.0: 3:b: calculating available bandwidth
[   64.286063] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[   64.287644] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[   64.287646] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[   64.287653] thunderbolt 0000:07:00.0: 0:c <-> 3:b (DP): activating
[   64.287656] thunderbolt 0000:07:00.0: activating Video path from 0:12 to 3:11
[   64.287658] thunderbolt 0000:07:00.0: 3:2: adding 12 NFC credits to 0
[   64.287673] thunderbolt 0000:07:00.0: 0:c: adding 5 NFC credits to 0
[   64.287928] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[   64.287930] thunderbolt 0000:07:00.0: 3:2:  In HopID: 8 => Out port: 11 Out HopID: 9
[   64.287933] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   64.287935] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   64.287937] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   64.287939] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.288184] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[   64.288186] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 4 Out HopID: 8
[   64.288188] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   64.288190] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[   64.288192] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   64.288194] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.288312] thunderbolt 0000:07:00.0: path activation complete
[   64.288314] thunderbolt 0000:07:00.0: activating AUX TX path from 0:12 to 3:11
[   64.291251] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[   64.291253] thunderbolt 0000:07:00.0: 3:2:  In HopID: 9 => Out port: 11 Out HopID: 8
[   64.291255] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   64.291257] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   64.291259] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   64.291261] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.291506] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[   64.291508] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 4 Out HopID: 9
[   64.291510] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   64.291512] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[   64.291514] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   64.291516] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.291634] thunderbolt 0000:07:00.0: path activation complete
[   64.291635] thunderbolt 0000:07:00.0: activating AUX RX path from 3:11 to 0:12
[   64.291762] thunderbolt 0000:07:00.0: 0:4: Writing hop 1
[   64.291764] thunderbolt 0000:07:00.0: 0:4:  In HopID: 8 => Out port: 12 Out HopID: 8
[   64.291766] thunderbolt 0000:07:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   64.291768] thunderbolt 0000:07:00.0: 0:4:    Counter enabled: 0 Counter index: 2047
[   64.291770] thunderbolt 0000:07:00.0: 0:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   64.291772] thunderbolt 0000:07:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.292018] thunderbolt 0000:07:00.0: 3:b: Writing hop 0
[   64.292020] thunderbolt 0000:07:00.0: 3:b:  In HopID: 8 => Out port: 2 Out HopID: 8
[   64.292024] thunderbolt 0000:07:00.0: 3:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   64.292026] thunderbolt 0000:07:00.0: 3:b:    Counter enabled: 0 Counter index: 2047
[   64.292027] thunderbolt 0000:07:00.0: 3:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   64.292030] thunderbolt 0000:07:00.0: 3:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.292146] thunderbolt 0000:07:00.0: path activation complete
[   64.293171] thunderbolt 0000:07:00.0: Used link no : 1
[   64.293301] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): activating
[   64.293304] thunderbolt 0000:07:00.0: activating PCIe Down path from 3:7 to 303:10
[   64.293426] thunderbolt 0000:07:00.0: 303:3: Writing hop 1
[   64.293427] thunderbolt 0000:07:00.0: 303:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[   64.293428] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   64.293430] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   64.293431] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   64.293432] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.293681] thunderbolt 0000:07:00.0: 3:7: Writing hop 0
[   64.293683] thunderbolt 0000:07:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[   64.293684] thunderbolt 0000:07:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   64.293685] thunderbolt 0000:07:00.0: 3:7:    Counter enabled: 0 Counter index: 2047
[   64.293686] thunderbolt 0000:07:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   64.293687] thunderbolt 0000:07:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.293809] thunderbolt 0000:07:00.0: path activation complete
[   64.293810] thunderbolt 0000:07:00.0: activating PCIe Up path from 303:10 to 3:7
[   64.293937] thunderbolt 0000:07:00.0: 3:3: Writing hop 1
[   64.293938] thunderbolt 0000:07:00.0: 3:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[   64.293940] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   64.293941] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[   64.293942] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   64.293943] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.294193] thunderbolt 0000:07:00.0: 303:a: Writing hop 0
[   64.294194] thunderbolt 0000:07:00.0: 303:a:  In HopID: 8 => Out port: 3 Out HopID: 8
[   64.294196] thunderbolt 0000:07:00.0: 303:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   64.294197] thunderbolt 0000:07:00.0: 303:a:    Counter enabled: 0 Counter index: 2047
[   64.294198] thunderbolt 0000:07:00.0: 303:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   64.294199] thunderbolt 0000:07:00.0: 303:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.294321] thunderbolt 0000:07:00.0: path activation complete
[   64.294835] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[   64.294837] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   64.294962] thunderbolt 0000:07:00.0: 0:c: in use
[   64.295092] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   64.295219] thunderbolt 0000:07:00.0: 3:b: in use
[   64.295347] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[   64.295348] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 13
[   64.295350] thunderbolt 0000:07:00.0: 303:b: calculating available bandwidth
[   64.295474] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[   64.295477] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[   64.295603] thunderbolt 0000:07:00.0: 3:3: link total bandwidth 9000 Mb/s
[   64.295605] thunderbolt 0000:07:00.0: 303:3: link total bandwidth 9000 Mb/s
[   64.295607] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[   64.295612] thunderbolt 0000:07:00.0: 0:d <-> 303:b (DP): activating
[   64.295615] thunderbolt 0000:07:00.0: activating Video path from 0:13 to 303:11
[   64.295617] thunderbolt 0000:07:00.0: 303:3: adding 12 NFC credits to 0
[   64.295730] thunderbolt 0000:07:00.0: 3:1: adding 12 NFC credits to 0
[   64.295858] thunderbolt 0000:07:00.0: 0:d: adding 5 NFC credits to 0
[   64.296114] thunderbolt 0000:07:00.0: 303:3: Writing hop 2
[   64.296116] thunderbolt 0000:07:00.0: 303:3:  In HopID: 9 => Out port: 11 Out HopID: 9
[   64.296118] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   64.296121] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   64.296123] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   64.296125] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.296370] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   64.296372] thunderbolt 0000:07:00.0: 3:1:  In HopID: 9 => Out port: 3 Out HopID: 9
[   64.296374] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   64.296376] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   64.296378] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   64.296380] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.296626] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[   64.296628] thunderbolt 0000:07:00.0: 0:d:  In HopID: 9 => Out port: 3 Out HopID: 9
[   64.296630] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   64.296632] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[   64.296634] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   64.296636] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.296754] thunderbolt 0000:07:00.0: path activation complete
[   64.296755] thunderbolt 0000:07:00.0: activating AUX TX path from 0:13 to 303:11
[   64.296882] thunderbolt 0000:07:00.0: 303:3: Writing hop 2
[   64.296883] thunderbolt 0000:07:00.0: 303:3:  In HopID: 10 => Out port: 11 Out HopID: 8
[   64.296886] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   64.296888] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   64.296890] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   64.296892] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.297138] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   64.297140] thunderbolt 0000:07:00.0: 3:1:  In HopID: 10 => Out port: 3 Out HopID: 10
[   64.297142] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   64.297144] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   64.297146] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   64.297148] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.297394] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[   64.297396] thunderbolt 0000:07:00.0: 0:d:  In HopID: 8 => Out port: 3 Out HopID: 10
[   64.297398] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   64.297400] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[   64.297402] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   64.297404] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.297522] thunderbolt 0000:07:00.0: path activation complete
[   64.297523] thunderbolt 0000:07:00.0: activating AUX RX path from 303:11 to 0:13
[   64.297650] thunderbolt 0000:07:00.0: 0:3: Writing hop 2
[   64.297652] thunderbolt 0000:07:00.0: 0:3:  In HopID: 9 => Out port: 13 Out HopID: 8
[   64.297654] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   64.297656] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   64.297658] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   64.297660] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.297906] thunderbolt 0000:07:00.0: 3:3: Writing hop 1
[   64.297907] thunderbolt 0000:07:00.0: 3:3:  In HopID: 9 => Out port: 1 Out HopID: 9
[   64.297909] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   64.297912] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[   64.297913] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   64.297915] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.299955] thunderbolt 0000:07:00.0: 303:b: Writing hop 0
[   64.299957] thunderbolt 0000:07:00.0: 303:b:  In HopID: 8 => Out port: 3 Out HopID: 9
[   64.299959] thunderbolt 0000:07:00.0: 303:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   64.299961] thunderbolt 0000:07:00.0: 303:b:    Counter enabled: 0 Counter index: 2047
[   64.299963] thunderbolt 0000:07:00.0: 303:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   64.299965] thunderbolt 0000:07:00.0: 303:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   64.300082] thunderbolt 0000:07:00.0: path activation complete
[   64.301106] thunderbolt 0000:07:00.0: Used link no : 0
[   64.472424] pci 0000:18:00.0: [8086:1513] type 01 class 0x060400
[   64.472527] pci 0000:18:00.0: enabling Extended Tags
[   64.472708] pci 0000:18:00.0: supports D1 D2
[   64.472709] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.472881] pcieport 0000:06:04.0: ASPM: current common clock configuration is inconsistent, reconfiguring
[   64.502395] pci 0000:18:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.502566] pci 0000:19:00.0: [8086:1513] type 01 class 0x060400
[   64.502684] pci 0000:19:00.0: enabling Extended Tags
[   64.502874] pci 0000:19:00.0: supports D1 D2
[   64.502876] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.503127] pci 0000:19:01.0: [8086:1513] type 01 class 0x060400
[   64.503245] pci 0000:19:01.0: enabling Extended Tags
[   64.503433] pci 0000:19:01.0: supports D1 D2
[   64.512621] pci 0000:19:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.512816] pci 0000:19:02.0: [8086:1513] type 01 class 0x060400
[   64.515113] pci 0000:19:02.0: enabling Extended Tags
[   64.515294] pci 0000:19:02.0: supports D1 D2
[   64.515295] pci 0000:19:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.515463] pci 0000:19:04.0: [8086:1513] type 01 class 0x060400
[   64.515573] pci 0000:19:04.0: enabling Extended Tags
[   64.515763] pci 0000:19:04.0: supports D1 D2
[   64.515764] pci 0000:19:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.516019] pci 0000:19:05.0: [8086:1513] type 01 class 0x060400
[   64.516145] pci 0000:19:05.0: enabling Extended Tags
[   64.516367] pci 0000:19:05.0: supports D1 D2
[   64.516369] pci 0000:19:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.516556] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   64.530326] pci 0000:18:00.0:   bridge window [io  0x0000-0x0fff]
[   64.531470] pci 0000:18:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.531482] pci 0000:18:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.531487] pci 0000:19:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.535125] pci 0000:19:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.535140] pci 0000:19:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.535155] pci 0000:19:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.538692] pci 0000:19:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.538867] pci 0000:1a:00.0: [12d8:400c] type 01 class 0x060400
[   64.539250] pci 0000:1a:00.0: supports D1 D2
[   64.539252] pci 0000:1a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.562355] pci 0000:19:00.0: PCI bridge to [bus 1a-55]
[   64.562369] pci 0000:19:00.0:   bridge window [io  0x0000-0x0fff]
[   64.562376] pci 0000:19:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.562388] pci 0000:19:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.562393] pci 0000:1a:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.562627] pci 0000:1b:03.0: [12d8:400c] type 01 class 0x060400
[   64.562964] pci 0000:1b:03.0: supports D1 D2
[   64.562966] pci 0000:1b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.563202] pci 0000:1a:00.0: PCI bridge to [bus 1b-55]
[   64.563220] pci 0000:1a:00.0:   bridge window [io  0x0000-0x0fff]
[   64.563230] pci 0000:1a:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.563247] pci 0000:1a:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.563253] pci 0000:1b:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.563470] pci 0000:1c:00.0: [12d8:400e] type 00 class 0x0c0310
[   64.563523] pci 0000:1c:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   64.563806] pci 0000:1c:00.0: supports D1 D2
[   64.582209] pci 0000:1c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.582422] pci 0000:1c:00.1: [12d8:400e] type 00 class 0x0c0310
[   64.584674] pci 0000:1c:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   64.586087] pci 0000:1c:00.1: supports D1 D2
[   64.586088] pci 0000:1c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   64.586221] pci 0000:1c:00.2: [12d8:400f] type 00 class 0x0c0320
[   64.586265] pci 0000:1c:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   64.586543] pci 0000:1c:00.2: supports D1 D2
[   64.586545] pci 0000:1c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   64.586999] pci 0000:1b:03.0: PCI bridge to [bus 1c-55]
[   64.587018] pci 0000:1b:03.0:   bridge window [io  0x0000-0x0fff]
[   64.587027] pci 0000:1b:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.587045] pci 0000:1b:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.587048] pci_bus 0000:1c: busn_res: [bus 1c-55] end is updated to 1c
[   64.587059] pci_bus 0000:1b: busn_res: [bus 1b-55] end is updated to 1c
[   64.587069] pci_bus 0000:1a: busn_res: [bus 1a-55] end is updated to 1c
[   64.587233] pci 0000:1d:00.0: [14e4:16b0] type 00 class 0x020000
[   64.587297] pci 0000:1d:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   64.604381] pci 0000:1d:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   64.605844] pci 0000:1d:00.0: PME# supported from D0 D3hot D3cold
[   64.632343] pci 0000:19:01.0: PCI bridge to [bus 1d-55]
[   64.632357] pci 0000:19:01.0:   bridge window [io  0x0000-0x0fff]
[   64.632364] pci 0000:19:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.632376] pci 0000:19:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.632378] pci_bus 0000:1d: busn_res: [bus 1d-55] end is updated to 1d
[   64.632530] pci 0000:1e:00.0: [11c1:5901] type 00 class 0x0c0010
[   64.632594] pci 0000:1e:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   64.632924] pci 0000:1e:00.0: supports D1 D2
[   64.641984] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.662329] pci 0000:19:02.0: PCI bridge to [bus 1e-55]
[   64.662343] pci 0000:19:02.0:   bridge window [io  0x0000-0x0fff]
[   64.662350] pci 0000:19:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.662362] pci 0000:19:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.662363] pci_bus 0000:1e: busn_res: [bus 1e-55] end is updated to 1e
[   64.662544] pci 0000:1f:00.0: [8086:1513] type 01 class 0x060400
[   64.662704] pci 0000:1f:00.0: enabling Extended Tags
[   64.662975] pci 0000:1f:00.0: supports D1 D2
[   64.662977] pci 0000:1f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.702302] pci 0000:19:04.0: PCI bridge to [bus 1f-55]
[   64.702316] pci 0000:19:04.0:   bridge window [io  0x0000-0x0fff]
[   64.702323] pci 0000:19:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.702335] pci 0000:19:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.702340] pci 0000:1f:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.702570] pci 0000:20:00.0: [8086:1513] type 01 class 0x060400
[   64.702730] pci 0000:20:00.0: enabling Extended Tags
[   64.703006] pci 0000:20:00.0: supports D1 D2
[   64.703007] pci 0000:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.703371] pci 0000:20:01.0: [8086:1513] type 01 class 0x060400
[   64.714958] pci 0000:20:01.0: enabling Extended Tags
[   64.715220] pci 0000:20:01.0: supports D1 D2
[   64.715221] pci 0000:20:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.715448] pci 0000:20:02.0: [8086:1513] type 01 class 0x060400
[   64.715607] pci 0000:20:02.0: enabling Extended Tags
[   64.715877] pci 0000:20:02.0: supports D1 D2
[   64.715879] pci 0000:20:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.716241] pci 0000:20:04.0: [8086:1513] type 01 class 0x060400
[   64.725929] pci 0000:20:04.0: enabling Extended Tags
[   64.726197] pci 0000:20:04.0: supports D1 D2
[   64.726198] pci 0000:20:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.726434] pci 0000:20:05.0: [8086:1513] type 01 class 0x060400
[   64.726595] pci 0000:20:05.0: enabling Extended Tags
[   64.726870] pci 0000:20:05.0: supports D1 D2
[   64.726871] pci 0000:20:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.727240] pci 0000:1f:00.0: PCI bridge to [bus 20-55]
[   64.736634] pci 0000:1f:00.0:   bridge window [io  0x0000-0x0fff]
[   64.736644] pci 0000:1f:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.736661] pci 0000:1f:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.740183] pci 0000:20:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.740212] pci 0000:20:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.742629] pci 0000:20:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.742650] pci 0000:20:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.742679] pci 0000:20:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.746521] pci 0000:21:00.0: [12d8:400c] type 01 class 0x060400
[   64.747031] pci 0000:21:00.0: supports D1 D2
[   64.747033] pci 0000:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.747444] pci 0000:20:00.0: PCI bridge to [bus 21-55]
[   64.747464] pci 0000:20:00.0:   bridge window [io  0x0000-0x0fff]
[   64.747474] pci 0000:20:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.747493] pci 0000:20:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.747500] pci 0000:21:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.747813] pci 0000:22:03.0: [12d8:400c] type 01 class 0x060400
[   64.759072] pci 0000:22:03.0: supports D1 D2
[   64.759073] pci 0000:22:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.759346] pci 0000:21:00.0: PCI bridge to [bus 22-55]
[   64.759369] pci 0000:21:00.0:   bridge window [io  0x0000-0x0fff]
[   64.759381] pci 0000:21:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.759404] pci 0000:21:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.759411] pci 0000:22:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   64.759698] pci 0000:23:00.0: [12d8:400e] type 00 class 0x0c0310
[   64.759758] pci 0000:23:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   64.760129] pci 0000:23:00.0: supports D1 D2
[   64.771708] pci 0000:23:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.771946] pci 0000:23:00.1: [12d8:400e] type 00 class 0x0c0310
[   64.774258] pci 0000:23:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   64.774617] pci 0000:23:00.1: supports D1 D2
[   64.776695] pci 0000:23:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   64.776882] pci 0000:23:00.2: [12d8:400f] type 00 class 0x0c0320
[   64.779237] pci 0000:23:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   64.779610] pci 0000:23:00.2: supports D1 D2
[   64.779611] pci 0000:23:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   64.779978] pci 0000:22:03.0: PCI bridge to [bus 23-55]
[   64.780001] pci 0000:22:03.0:   bridge window [io  0x0000-0x0fff]
[   64.780013] pci 0000:22:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.780035] pci 0000:22:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.780037] pci_bus 0000:23: busn_res: [bus 23-55] end is updated to 23
[   64.780050] pci_bus 0000:22: busn_res: [bus 22-55] end is updated to 23
[   64.780062] pci_bus 0000:21: busn_res: [bus 21-55] end is updated to 23
[   64.780331] pci 0000:24:00.0: [14e4:16b0] type 00 class 0x020000
[   64.780414] pci 0000:24:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   64.780465] pci 0000:24:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   64.780909] pci 0000:24:00.0: PME# supported from D0 D3hot D3cold
[   64.797714] pci 0000:20:01.0: PCI bridge to [bus 24-55]
[   64.797734] pci 0000:20:01.0:   bridge window [io  0x0000-0x0fff]
[   64.797744] pci 0000:20:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.797763] pci 0000:20:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.797765] pci_bus 0000:24: busn_res: [bus 24-55] end is updated to 24
[   64.797984] pci 0000:25:00.0: [11c1:5901] type 00 class 0x0c0010
[   64.798067] pci 0000:25:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   64.798504] pci 0000:25:00.0: supports D1 D2
[   64.798506] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   64.798956] pci 0000:20:02.0: PCI bridge to [bus 25-55]
[   64.798975] pci 0000:20:02.0:   bridge window [io  0x0000-0x0fff]
[   64.811965] pci 0000:20:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.811990] pci 0000:20:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.811992] pci_bus 0000:25: busn_res: [bus 25-55] end is updated to 25
[   64.815746] pci 0000:20:04.0: PCI bridge to [bus 26-55]
[   64.815764] pci 0000:20:04.0:   bridge window [io  0x0000-0x0fff]
[   64.815773] pci 0000:20:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.815790] pci 0000:20:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.815792] pci_bus 0000:26: busn_res: [bus 26-55] end is updated to 35
[   64.815969] pci 0000:20:05.0: PCI bridge to [bus 36-55]
[   64.815988] pci 0000:20:05.0:   bridge window [io  0x0000-0x0fff]
[   64.815998] pci 0000:20:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.816024] pci 0000:20:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.816027] pci_bus 0000:36: busn_res: [bus 36-55] end is updated to 45
[   64.816038] pci_bus 0000:20: busn_res: [bus 20-55] end is updated to 45
[   64.816049] pci_bus 0000:1f: busn_res: [bus 1f-55] end is updated to 45
[   64.816201] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[   64.816215] pci 0000:19:05.0:   bridge window [io  0x0000-0x0fff]
[   64.816223] pci 0000:19:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   64.816236] pci 0000:19:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   64.816239] pci_bus 0000:46: busn_res: [bus 46-55] end is updated to 55
[   64.816247] pci_bus 0000:19: busn_res: [bus 19-55] end is updated to 55
[   64.816263] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 26-35] add_size 3ff00000 add_align 100000
[   64.816267] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 26-35] add_size 7f00000 add_align 100000
[   64.816271] pci 0000:20:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 36-45] add_size 3ff00000 add_align 100000
[   64.816275] pci 0000:20:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 36-45] add_size 7f00000 add_align 100000
[   64.816279] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 20-45] add_size 7fe00000 add_align 100000
[   64.816282] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x005fffff] to [bus 20-45] add_size fe00000 add_align 100000
[   64.816286] pci 0000:19:04.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 1f-45] add_size bf900000 add_align 100000
[   64.816289] pci 0000:19:04.0: bridge window [mem 0x00100000-0x005fffff] to [bus 1f-45] add_size 17900000 add_align 100000
[   64.816292] pci 0000:19:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 46-55] add_size 3ff00000 add_align 100000
[   64.816295] pci 0000:19:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 46-55] add_size 7f00000 add_align 100000
[   64.816299] pci 0000:18:00.0: bridge window [mem 0x00100000-0x009fffff 64bit pref] to [bus 19-55] add_size ff800000 add_align 100000
[   64.816303] pci 0000:18:00.0: bridge window [mem 0x00100000-0x009fffff] to [bus 19-55] add_size 1f800000 add_align 100000
[   64.816307] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x009fffff 64bit pref] to [bus 18-55] add_size 13ef00000 add_align 100000
[   64.816317] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   64.816320] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   64.816323] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   64.816326] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   64.816329] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[   64.816332] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   64.816334] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   64.816337] pci 0000:18:00.0: BAR 7: assigned [io  0x5000-0x9fff]
[   64.816339] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[   64.816342] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   64.816343] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   64.816349] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   64.816352] pci 0000:19:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   64.816354] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0d00000-0xb0dfffff]
[   64.816356] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0e00000-0xb0efffff 64bit pref]
[   64.816358] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[   64.816360] pci 0000:19:02.0: BAR 9: assigned [mem 0xb1000000-0xb10fffff 64bit pref]
[   64.816363] pci 0000:19:04.0: BAR 8: assigned [mem 0xb1100000-0xbd27ffff]
[   64.816365] pci 0000:19:04.0: BAR 9: assigned [mem 0xbd300000-0xbd5fffff 64bit pref]
[   64.816367] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   64.816369] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   64.816371] pci 0000:19:05.0: BAR 9: assigned [mem 0xbd600000-0xbd8fffff 64bit pref]
[   64.816374] pci 0000:19:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   64.816375] pci 0000:19:01.0: BAR 7: assigned [io  0x6000-0x6fff]
[   64.816377] pci 0000:19:02.0: BAR 7: assigned [io  0x7000-0x7fff]
[   64.816379] pci 0000:19:04.0: BAR 7: assigned [io  0x8000-0x8fff]
[   64.816381] pci 0000:19:05.0: BAR 7: assigned [io  0x9000-0x9fff]
[   64.816384] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   64.816386] pci 0000:19:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   64.816388] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0d00000-0xb0dfffff]
[   64.816391] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0e00000-0xb0efffff 64bit pref]
[   64.816393] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[   64.816395] pci 0000:19:02.0: BAR 9: assigned [mem 0xb1000000-0xb10fffff 64bit pref]
[   64.816397] pci 0000:19:04.0: BAR 8: assigned [mem 0xb1100000-0xbd27ffff]
[   64.816399] pci 0000:19:04.0: BAR 9: assigned [mem 0xbd300000-0xbd5fffff 64bit pref]
[   64.816401] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   64.816403] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   64.816405] pci 0000:19:05.0: BAR 9: assigned [mem 0xbd600000-0xbd8fffff 64bit pref]
[   64.816408] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   64.816411] pci 0000:1a:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   64.816413] pci 0000:1a:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   64.816415] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   64.816417] pci 0000:1b:03.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   64.816419] pci 0000:1b:03.0: BAR 7: assigned [io  0x5000-0x5fff]
[   64.816422] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[   64.816432] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[   64.816449] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[   64.816459] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   64.816465] pci 0000:1b:03.0:   bridge window [io  0x5000-0x5fff]
[   64.816477] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   64.816487] pci 0000:1b:03.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   64.816504] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   64.816509] pci 0000:1a:00.0:   bridge window [io  0x5000-0x5fff]
[   64.816522] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   64.816531] pci 0000:1a:00.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   64.816547] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   64.816551] pci 0000:19:00.0:   bridge window [io  0x5000-0x5fff]
[   64.816560] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   64.816567] pci 0000:19:00.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   64.816580] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e0ffff 64bit pref]
[   64.816608] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0e10000-0xb0e1ffff 64bit pref]
[   64.816637] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   64.816641] pci 0000:19:01.0:   bridge window [io  0x6000-0x6fff]
[   64.816650] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[   64.816656] pci 0000:19:01.0:   bridge window [mem 0xb0e00000-0xb0efffff 64bit pref]
[   64.816669] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff 64bit]
[   64.816698] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   64.816701] pci 0000:19:02.0:   bridge window [io  0x7000-0x7fff]
[   64.816711] pci 0000:19:02.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[   64.816717] pci 0000:19:02.0:   bridge window [mem 0xb1000000-0xb10fffff 64bit pref]
[   64.816730] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb1100000-0xbd27ffff]
[   64.816731] pci 0000:1f:00.0: BAR 9: assigned [mem 0xbd300000-0xbd5fffff 64bit pref]
[   64.816732] pci 0000:1f:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   64.816735] pci 0000:20:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   64.816737] pci 0000:20:00.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   64.816738] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[   64.816739] pci 0000:20:01.0: BAR 9: assigned [mem 0xbd400000-0xbd4fffff 64bit pref]
[   64.816740] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1300000-0xb13fffff]
[   64.816742] pci 0000:20:02.0: BAR 9: assigned [mem 0xbd500000-0xbd5fffff 64bit pref]
[   64.816743] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1400000-0xb733ffff]
[   64.816745] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   64.816746] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   64.816747] pci 0000:20:05.0: BAR 8: assigned [mem 0xb7400000-0xbd27ffff]
[   64.816749] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   64.816750] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   64.816751] pci 0000:20:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   64.816752] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   64.816753] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   64.816754] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   64.816755] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   64.816756] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   64.816757] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   64.816758] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   64.816759] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   64.816761] pci 0000:20:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   64.816762] pci 0000:20:00.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   64.816764] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[   64.816765] pci 0000:20:01.0: BAR 9: assigned [mem 0xbd400000-0xbd4fffff 64bit pref]
[   64.816766] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1300000-0xb13fffff]
[   64.816767] pci 0000:20:02.0: BAR 9: assigned [mem 0xbd500000-0xbd5fffff 64bit pref]
[   64.816769] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1400000-0xb733ffff]
[   64.816770] pci 0000:20:04.0: BAR 9: assigned [mem 0xb7400000-0xb74fffff 64bit pref]
[   64.816772] pci 0000:20:05.0: BAR 8: no space for [mem size 0x05e80000]
[   64.816773] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x05e80000]
[   64.816774] pci 0000:20:05.0: BAR 9: assigned [mem 0xb7500000-0xb75fffff 64bit pref]
[   64.816775] pci 0000:20:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   64.816777] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   64.816778] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   64.816779] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   64.816780] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   64.816781] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   64.816782] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   64.816783] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   64.816784] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   64.816786] pci 0000:20:05.0: BAR 9: [mem 0xb7500000-0xb75fffff 64bit pref] (failed to expand by 0x3ff00000)
[   64.816788] pci 0000:20:05.0: failed to add 3ff00000 res[9]=[mem 0xb7500000-0xb75fffff 64bit pref]
[   64.816790] pci 0000:20:04.0: BAR 9: [mem 0xb7400000-0xb74fffff 64bit pref] (failed to expand by 0x3ff00000)
[   64.816791] pci 0000:20:04.0: failed to add 3ff00000 res[9]=[mem 0xb7400000-0xb74fffff 64bit pref]
[   64.816793] pci 0000:21:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   64.816795] pci 0000:21:00.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   64.816796] pci 0000:21:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   64.816797] pci 0000:22:03.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   64.816799] pci 0000:22:03.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   64.816800] pci 0000:22:03.0: BAR 7: assigned [io  0x8000-0x8fff]
[   64.816802] pci 0000:23:00.0: BAR 0: assigned [mem 0xb1100000-0xb1100fff]
[   64.816813] pci 0000:23:00.1: BAR 0: assigned [mem 0xb1101000-0xb1101fff]
[   64.816824] pci 0000:23:00.2: BAR 0: assigned [mem 0xb1102000-0xb11020ff]
[   64.816836] pci 0000:22:03.0: PCI bridge to [bus 23]
[   64.816841] pci 0000:22:03.0:   bridge window [io  0x8000-0x8fff]
[   64.816857] pci 0000:22:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   64.816868] pci 0000:22:03.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   64.816889] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   64.816895] pci 0000:21:00.0:   bridge window [io  0x8000-0x8fff]
[   64.816911] pci 0000:21:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   64.816922] pci 0000:21:00.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   64.816943] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   64.816948] pci 0000:20:00.0:   bridge window [io  0x8000-0x8fff]
[   64.816962] pci 0000:20:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   64.816971] pci 0000:20:00.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   64.816989] pci 0000:24:00.0: BAR 0: assigned [mem 0xbd400000-0xbd40ffff 64bit pref]
[   64.817026] pci 0000:24:00.0: BAR 2: assigned [mem 0xbd410000-0xbd41ffff 64bit pref]
[   64.817064] pci 0000:20:01.0: PCI bridge to [bus 24]
[   64.817077] pci 0000:20:01.0:   bridge window [mem 0xb1200000-0xb12fffff]
[   64.817086] pci 0000:20:01.0:   bridge window [mem 0xbd400000-0xbd4fffff 64bit pref]
[   64.817104] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1300000-0xb1300fff 64bit]
[   64.817142] pci 0000:20:02.0: PCI bridge to [bus 25]
[   64.817155] pci 0000:20:02.0:   bridge window [mem 0xb1300000-0xb13fffff]
[   64.817164] pci 0000:20:02.0:   bridge window [mem 0xbd500000-0xbd5fffff 64bit pref]
[   64.817182] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[   64.817195] pci 0000:20:04.0:   bridge window [mem 0xb1400000-0xb733ffff]
[   64.817204] pci 0000:20:04.0:   bridge window [mem 0xb7400000-0xb74fffff 64bit pref]
[   64.817222] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[   64.817243] pci 0000:20:05.0:   bridge window [mem 0xb7500000-0xb75fffff 64bit pref]
[   64.817261] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   64.817266] pci 0000:1f:00.0:   bridge window [io  0x8000-0x8fff]
[   64.817279] pci 0000:1f:00.0:   bridge window [mem 0xb1100000-0xbd27ffff]
[   64.817288] pci 0000:1f:00.0:   bridge window [mem 0xbd300000-0xbd5fffff 64bit pref]
[   64.817305] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[   65.013475] pci 0000:19:04.0:   bridge window [io  0x8000-0x8fff]
[   65.013485] pci 0000:19:04.0:   bridge window [mem 0xb1100000-0xbd27ffff]
[   65.013491] pci 0000:19:04.0:   bridge window [mem 0xbd300000-0xbd5fffff 64bit pref]
[   65.013504] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[   65.013508] pci 0000:19:05.0:   bridge window [io  0x9000-0x9fff]
[   65.018481] pci 0000:19:05.0:   bridge window [mem 0xbd600000-0xbd8fffff 64bit pref]
[   65.018493] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   65.020519] pci 0000:18:00.0:   bridge window [io  0x5000-0x9fff]
[   65.020536] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[   65.020553] pcieport 0000:06:04.0: PCI bridge to [bus 18-55]
[   65.020556] pcieport 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[   65.020561] pcieport 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[   65.020572] PCI: No. 2 try to assign unassigned res
[   65.025926] pci 0000:22:03.0: resource 7 [io  0x8000-0x8fff] released
[   65.025927] pci 0000:22:03.0: PCI bridge to [bus 23]
[   65.025948] pci 0000:21:00.0: resource 7 [io  0x8000-0x8fff] released
[   65.025949] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   65.025971] pci 0000:20:00.0: resource 7 [io  0x8000-0x8fff] released
[   65.031247] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   65.031272] pci 0000:1f:00.0: resource 7 [io  0x8000-0x8fff] released
[   65.031273] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   65.031290] release child resource [mem 0xb1100000-0xb1100fff]
[   65.031291] release child resource [mem 0xb1101000-0xb1101fff]
[   65.031292] release child resource [mem 0xb1102000-0xb11020ff]
[   65.031292] pci 0000:22:03.0: resource 8 [mem 0xb1100000-0xb11fffff] released
[   65.031293] pci 0000:22:03.0: PCI bridge to [bus 23]
[   65.031304] pci 0000:21:00.0: resource 8 [mem 0xb1100000-0xb11fffff] released
[   65.031305] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   65.031316] pci 0000:20:00.0: resource 8 [mem 0xb1100000-0xb11fffff] released
[   65.031317] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   65.031326] pci 0000:20:01.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[   65.031327] pci 0000:20:01.0: PCI bridge to [bus 24]
[   65.031336] release child resource [mem 0xb1300000-0xb1300fff 64bit]
[   65.031337] pci 0000:20:02.0: resource 8 [mem 0xb1300000-0xb13fffff] released
[   65.031346] pci 0000:20:02.0: PCI bridge to [bus 25]
[   65.031355] pci 0000:20:04.0: resource 8 [mem 0xb1400000-0xb733ffff] released
[   65.031356] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[   65.031365] release child resource [mem 0xb7400000-0xb74fffff 64bit pref]
[   65.031366] release child resource [mem 0xb7500000-0xb75fffff 64bit pref]
[   65.031367] pci 0000:1f:00.0: resource 8 [mem 0xb1100000-0xbd27ffff] released
[   65.031375] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   65.031384] release child resource [mem 0xb0b00000-0xb0b00fff]
[   65.031385] release child resource [mem 0xb0b01000-0xb0b01fff]
[   65.031385] release child resource [mem 0xb0b02000-0xb0b020ff]
[   65.031386] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[   65.031387] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   65.031395] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[   65.031396] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   65.031405] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[   65.031406] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   65.031412] pci 0000:19:01.0: resource 8 [mem 0xb0d00000-0xb0dfffff] released
[   65.031413] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   65.031420] release child resource [mem 0xb0f00000-0xb0f00fff 64bit]
[   65.031420] pci 0000:19:02.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[   65.031421] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   65.031428] pci 0000:19:04.0: resource 8 [mem 0xb1100000-0xbd27ffff] released
[   65.031429] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[   65.031436] release child resource [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   65.031436] release child resource [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   65.031437] release child resource [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   65.031437] release child resource [mem 0xb0e00000-0xb0e0ffff 64bit pref]
[   65.031438] release child resource [mem 0xb0e10000-0xb0e1ffff 64bit pref]
[   65.031438] release child resource [mem 0xb0e00000-0xb0efffff 64bit pref]
[   65.031439] release child resource [mem 0xb1000000-0xb10fffff 64bit pref]
[   65.031440] release child resource [mem 0xbd300000-0xbd3fffff 64bit pref]
[   65.031440] release child resource [mem 0xbd300000-0xbd3fffff 64bit pref]
[   65.031441] release child resource [mem 0xbd300000-0xbd3fffff 64bit pref]
[   65.031441] release child resource [mem 0xbd400000-0xbd40ffff 64bit pref]
[   65.031442] release child resource [mem 0xbd410000-0xbd41ffff 64bit pref]
[   65.031443] release child resource [mem 0xbd400000-0xbd4fffff 64bit pref]
[   65.031443] release child resource [mem 0xbd500000-0xbd5fffff 64bit pref]
[   65.031444] release child resource [mem 0xbd300000-0xbd5fffff 64bit pref]
[   65.031444] release child resource [mem 0xbd300000-0xbd5fffff 64bit pref]
[   65.031445] release child resource [mem 0xbd600000-0xbd8fffff 64bit pref]
[   65.031446] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[   65.031447] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   65.031454] pcieport 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[   65.031455] pcieport 0000:06:04.0: PCI bridge to [bus 18-55]
[   65.031459] release child resource [mem 0xa8a00000-0xa8a3ffff]
[   65.031459] release child resource [mem 0xa8a00000-0xa8a3ffff]
[   65.031460] release child resource [mem 0xa8a40000-0xa8a40fff]
[   65.031461] pcieport 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[   65.031462] pcieport 0000:06:00.0: PCI bridge to [bus 07]
[   65.031466] pcieport 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[   65.031467] pcieport 0000:06:03.0: PCI bridge to [bus 08-17]
[   65.031472] pcieport 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[   65.031472] pcieport 0000:06:05.0: PCI bridge to [bus 56-65]
[   65.031477] pcieport 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[   65.031478] pcieport 0000:06:06.0: PCI bridge to [bus 66-75]
[   65.031482] pcieport 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[   65.031483] pcieport 0000:05:00.0: PCI bridge to [bus 06-75]
[   65.031491] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 26-35] add_size 3ff00000 add_align 100000
[   65.031493] pci 0000:20:04.0: bridge window [mem 0x00100000-0x060fffff] to [bus 26-35] add_size 2000000 add_align 100000
[   65.031494] pci 0000:20:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 36-45] add_size 3ff00000 add_align 100000
[   65.031496] pci 0000:20:05.0: bridge window [mem 0x00100000-0x05ffffff] to [bus 36-45] add_size 2100000 add_align 100000
[   65.031498] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 20-45] add_size 7fe00000 add_align 100000
[   65.031500] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x0c2fffff] to [bus 20-45] add_size 4100000 add_align 100000
[   65.031501] pci 0000:19:04.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 1f-45] add_size bf900000 add_align 100000
[   65.031503] pci 0000:19:04.0: bridge window [mem 0x00100000-0x0c2fffff] to [bus 1f-45] add_size 4100000 add_align 100000
[   65.031504] pci 0000:19:05.0: bridge window [mem 0x00100000-0x003fffff 64bit pref] to [bus 46-55] add_size 3fd00000 add_align 100000
[   65.031506] pci 0000:18:00.0: bridge window [mem 0x00100000-0x00bfffff 64bit pref] to [bus 19-55] add_size ff600000 add_align 100000
[   65.031508] pci 0000:18:00.0: bridge window [mem 0x00100000-0x186fffff] to [bus 19-55] add_size 4100000 add_align 100000
[   65.031510] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x00bfffff 64bit pref] to [bus 18-55] add_size 13eb00000 add_align 100000
[   65.031511] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x186fffff] to [bus 18-55] add_size 4100000 add_align 100000
[   65.031515] pcieport 0000:06:04.0: BAR 8: no space for [mem size 0x18600000]
[   65.031516] pcieport 0000:06:04.0: BAR 8: failed to assign [mem size 0x18600000]
[   65.031518] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   65.031519] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   65.031520] pcieport 0000:06:04.0: BAR 8: no space for [mem size 0x18600000]
[   65.031521] pcieport 0000:06:04.0: BAR 8: failed to assign [mem size 0x18600000]
[   65.031522] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   65.031524] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   65.031525] pci 0000:18:00.0: BAR 8: no space for [mem size 0x18600000]
[   65.031526] pci 0000:18:00.0: BAR 8: failed to assign [mem size 0x18600000]
[   65.031527] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   65.031528] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   65.031529] pci 0000:18:00.0: BAR 8: no space for [mem size 0x18600000]
[   65.031530] pci 0000:18:00.0: BAR 8: failed to assign [mem size 0x18600000]
[   65.031532] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   65.031533] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   65.031535] pci 0000:19:00.0: BAR 8: no space for [mem size 0x00100000]
[   65.031536] pci 0000:19:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031537] pci 0000:19:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031538] pci 0000:19:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031539] pci 0000:19:01.0: BAR 8: no space for [mem size 0x00100000]
[   65.031540] pci 0000:19:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031541] pci 0000:19:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031543] pci 0000:19:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031544] pci 0000:19:02.0: BAR 8: no space for [mem size 0x00100000]
[   65.031545] pci 0000:19:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031546] pci 0000:19:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031547] pci 0000:19:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031548] pci 0000:19:04.0: BAR 8: no space for [mem size 0x0c180000]
[   65.031549] pci 0000:19:04.0: BAR 8: failed to assign [mem size 0x0c180000]
[   65.031550] pci 0000:19:04.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   65.031551] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   65.031552] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   65.031553] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   65.031554] pci 0000:19:05.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   65.031555] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   65.031557] pci 0000:19:00.0: BAR 8: no space for [mem size 0x00100000]
[   65.031558] pci 0000:19:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031559] pci 0000:19:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031560] pci 0000:19:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031561] pci 0000:19:01.0: BAR 8: no space for [mem size 0x00100000]
[   65.031562] pci 0000:19:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031563] pci 0000:19:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031564] pci 0000:19:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031565] pci 0000:19:02.0: BAR 8: no space for [mem size 0x00100000]
[   65.031566] pci 0000:19:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031567] pci 0000:19:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031568] pci 0000:19:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031569] pci 0000:19:04.0: BAR 8: no space for [mem size 0x0c180000]
[   65.031570] pci 0000:19:04.0: BAR 8: failed to assign [mem size 0x0c180000]
[   65.031571] pci 0000:19:04.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   65.031572] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   65.031573] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   65.031574] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   65.031576] pci 0000:19:05.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   65.031577] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   65.031578] pci 0000:1a:00.0: BAR 8: no space for [mem size 0x00100000]
[   65.031579] pci 0000:1a:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031580] pci 0000:1a:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031581] pci 0000:1a:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031582] pci 0000:1a:00.0: BAR 8: no space for [mem size 0x00100000]
[   65.031583] pci 0000:1a:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031584] pci 0000:1a:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031585] pci 0000:1a:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031587] pci 0000:1b:03.0: BAR 8: no space for [mem size 0x00100000]
[   65.031588] pci 0000:1b:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031589] pci 0000:1b:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031590] pci 0000:1b:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031591] pci 0000:1b:03.0: BAR 8: no space for [mem size 0x00100000]
[   65.031592] pci 0000:1b:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031593] pci 0000:1b:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031594] pci 0000:1b:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031595] pci 0000:1c:00.0: BAR 0: no space for [mem size 0x00001000]
[   65.031596] pci 0000:1c:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   65.031597] pci 0000:1c:00.1: BAR 0: no space for [mem size 0x00001000]
[   65.031598] pci 0000:1c:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   65.031599] pci 0000:1c:00.2: BAR 0: no space for [mem size 0x00000100]
[   65.031600] pci 0000:1c:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   65.031602] pci 0000:1c:00.0: BAR 0: no space for [mem size 0x00001000]
[   65.031603] pci 0000:1c:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   65.031604] pci 0000:1c:00.1: BAR 0: no space for [mem size 0x00001000]
[   65.031605] pci 0000:1c:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   65.031606] pci 0000:1c:00.2: BAR 0: no space for [mem size 0x00000100]
[   65.031607] pci 0000:1c:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   65.031608] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   65.031612] pci 0000:1b:03.0:   bridge window [io  0x5000-0x5fff]
[   65.031647] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   65.031652] pci 0000:1a:00.0:   bridge window [io  0x5000-0x5fff]
[   65.031687] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   65.031690] pci 0000:19:00.0:   bridge window [io  0x5000-0x5fff]
[   65.031717] pci 0000:1d:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   65.031718] pci 0000:1d:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   65.031719] pci 0000:1d:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   65.031720] pci 0000:1d:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   65.031721] pci 0000:1d:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   65.031722] pci 0000:1d:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   65.031724] pci 0000:1d:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   65.031725] pci 0000:1d:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   65.031726] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   65.031729] pci 0000:19:01.0:   bridge window [io  0x6000-0x6fff]
[   65.031756] pci 0000:1e:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   65.031757] pci 0000:1e:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   65.031758] pci 0000:1e:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   65.031759] pci 0000:1e:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   65.031760] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   65.031763] pci 0000:19:02.0:   bridge window [io  0x7000-0x7fff]
[   65.031790] pci 0000:1f:00.0: BAR 8: no space for [mem size 0x0c180000]
[   65.031791] pci 0000:1f:00.0: BAR 8: failed to assign [mem size 0x0c180000]
[   65.031792] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   65.031793] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   65.031794] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2800]
[   65.031795] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2800]
[   65.031797] pci 0000:1f:00.0: BAR 8: no space for [mem size 0x0c180000]
[   65.031798] pci 0000:1f:00.0: BAR 8: failed to assign [mem size 0x0c180000]
[   65.031799] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   65.031800] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   65.031801] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2800]
[   65.031802] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2800]
[   65.031805] pci 0000:20:00.0: BAR 8: no space for [mem size 0x00100000]
[   65.031806] pci 0000:20:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031807] pci 0000:20:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031808] pci 0000:20:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031809] pci 0000:20:01.0: BAR 8: no space for [mem size 0x00100000]
[   65.031810] pci 0000:20:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031811] pci 0000:20:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031812] pci 0000:20:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031814] pci 0000:20:02.0: BAR 8: no space for [mem size 0x00100000]
[   65.031815] pci 0000:20:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031816] pci 0000:20:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031817] pci 0000:20:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031818] pci 0000:20:04.0: BAR 8: no space for [mem size 0x05f40000]
[   65.031819] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x05f40000]
[   65.031820] pci 0000:20:04.0: BAR 9: no space for [mem size 0x00080000 64bit pref]
[   65.031821] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x00080000 64bit pref]
[   65.031822] pci 0000:20:05.0: BAR 8: no space for [mem size 0x05e80000]
[   65.031823] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x05e80000]
[   65.031824] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   65.031825] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   65.031826] pci 0000:20:00.0: BAR 7: no space for [io  size 0x1000]
[   65.031827] pci 0000:20:00.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031828] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   65.031829] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031830] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   65.031831] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031832] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   65.031833] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031834] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   65.031835] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031836] pci 0000:20:00.0: BAR 8: no space for [mem size 0x00100000]
[   65.031837] pci 0000:20:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031838] pci 0000:20:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031839] pci 0000:20:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031841] pci 0000:20:01.0: BAR 8: no space for [mem size 0x00100000]
[   65.031842] pci 0000:20:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031843] pci 0000:20:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031844] pci 0000:20:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031845] pci 0000:20:02.0: BAR 8: no space for [mem size 0x00100000]
[   65.031846] pci 0000:20:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031847] pci 0000:20:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031848] pci 0000:20:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031849] pci 0000:20:04.0: BAR 8: no space for [mem size 0x05f40000]
[   65.031850] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x05f40000]
[   65.031851] pci 0000:20:04.0: BAR 9: no space for [mem size 0x00080000 64bit pref]
[   65.031852] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x00080000 64bit pref]
[   65.031853] pci 0000:20:05.0: BAR 8: no space for [mem size 0x05e80000]
[   65.031854] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x05e80000]
[   65.031855] pci 0000:20:05.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031856] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031857] pci 0000:20:00.0: BAR 7: no space for [io  size 0x1000]
[   65.031858] pci 0000:20:00.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031859] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   65.031860] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031861] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   65.031862] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031863] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   65.031864] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031865] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   65.031866] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031868] pci 0000:21:00.0: BAR 8: no space for [mem size 0x00100000]
[   65.031868] pci 0000:21:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031870] pci 0000:21:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031871] pci 0000:21:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031872] pci 0000:21:00.0: BAR 7: no space for [io  size 0x1000]
[   65.031873] pci 0000:21:00.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031874] pci 0000:22:03.0: BAR 8: no space for [mem size 0x00100000]
[   65.031875] pci 0000:22:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   65.031876] pci 0000:22:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   65.031877] pci 0000:22:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   65.031878] pci 0000:22:03.0: BAR 7: no space for [io  size 0x1000]
[   65.031879] pci 0000:22:03.0: BAR 7: failed to assign [io  size 0x1000]
[   65.031880] pci 0000:23:00.0: BAR 0: no space for [mem size 0x00001000]
[   65.031881] pci 0000:23:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   65.031882] pci 0000:23:00.1: BAR 0: no space for [mem size 0x00001000]
[   65.031883] pci 0000:23:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   65.031884] pci 0000:23:00.2: BAR 0: no space for [mem size 0x00000100]
[   65.031885] pci 0000:23:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   65.031886] pci 0000:22:03.0: PCI bridge to [bus 23]
[   65.031933] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   65.031980] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   65.032019] pci 0000:24:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   65.032020] pci 0000:24:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   65.032021] pci 0000:24:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   65.032022] pci 0000:24:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   65.032023] pci 0000:20:01.0: PCI bridge to [bus 24]
[   65.032061] pci 0000:25:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   65.032062] pci 0000:25:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   65.032063] pci 0000:20:02.0: PCI bridge to [bus 25]
[   65.032114] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[   65.032152] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[   65.032190] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   65.032228] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[   65.032231] pci 0000:19:04.0:   bridge window [io  0x8000-0x8fff]
[   65.032258] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[   65.032261] pci 0000:19:05.0:   bridge window [io  0x9000-0x9fff]
[   65.032288] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   65.032291] pci 0000:18:00.0:   bridge window [io  0x5000-0x9fff]
[   65.032317] pcieport 0000:06:04.0: PCI bridge to [bus 18-55]
[   65.032319] pcieport 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[   65.032364] pcieport 0000:18:00.0: enabling device (0000 -> 0001)
[   65.032686] pcieport 0000:19:00.0: enabling device (0000 -> 0001)
[   65.112483] switching from power state:
[   65.113726] pcieport 0000:19:01.0: enabling device (0000 -> 0001)
[   65.114809] 	ui class: battery
[   65.116507] pcieport 0000:19:02.0: enabling device (0000 -> 0001)
[   65.117556] 	internal class: none
[   65.119233] pcieport 0000:19:04.0: enabling device (0000 -> 0001)

[   65.120296] 	caps:
[   65.121749] pcieport 0000:19:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   65.123018] 	uvd    vclk: 0 dclk: 0
[   65.123019] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   65.123020] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   65.124696] pcieport 0000:19:05.0: enabling device (0000 -> 0001)
[   65.125898] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   65.127324] pcieport 0000:19:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   65.128572] 	status: c r
[   65.130192] pcieport 0000:1a:00.0: enabling device (0000 -> 0001)

[   65.131353] switching to power state:
[   65.132789] pcieport 0000:1b:03.0: enabling device (0000 -> 0001)
[   65.134041] 	ui class: battery
[   65.135490] pci 0000:1c:00.0: MSI is not implemented on this device, disabling it
[   65.136693] 	internal class: none
[   65.138007] pci 0000:1c:00.0: PME# is unreliable, disabling it

[   65.140743] ohci-pci 0000:1c:00.0: init 0000:1c:00.0 fail, -16
[   65.141883] 	caps:
[   65.143183] ohci-pci: probe of 0000:1c:00.0 failed with error -16
[   65.144491] 	uvd    vclk: 0 dclk: 0
[   65.145768] pci 0000:1c:00.1: MSI is not implemented on this device, disabling it
[   65.147040] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   65.148313] pci 0000:1c:00.1: PME# is unreliable, disabling it
[   65.149588] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   65.150971] ohci-pci 0000:1c:00.1: init 0000:1c:00.1 fail, -16
[   65.152168] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   65.153456] ohci-pci: probe of 0000:1c:00.1 failed with error -16
[   65.154728] 	status:
[   65.155999] pci 0000:1c:00.2: MSI is not implemented on this device, disabling it
[   65.157264]  c
[   65.158531] pci 0000:1c:00.2: PME# is unreliable, disabling it
[   65.159800]  r
[   65.161616] ehci-pci 0000:1c:00.2: init 0000:1c:00.2 fail, -16

[   65.403446] ehci-pci: probe of 0000:1c:00.2 failed with error -16
[   65.403516] tg3 0000:1d:00.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
[   65.406094] tg3 0000:1d:00.0: Cannot map device registers, aborting
[   65.406120] tg3: probe of 0000:1d:00.0 failed with error -12
[   65.406176] firewire_ohci 0000:1e:00.0: invalid MMIO resource
[   65.412745] pcieport 0000:20:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   65.413418] pcieport 0000:20:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   65.414275] pci 0000:23:00.0: MSI is not implemented on this device, disabling it
[   65.414278] pci 0000:23:00.0: PME# is unreliable, disabling it
[   65.414471] ohci-pci 0000:23:00.0: init 0000:23:00.0 fail, -16
[   65.421289] ohci-pci: probe of 0000:23:00.0 failed with error -16
[   65.421294] pci 0000:23:00.1: MSI is not implemented on this device, disabling it
[   65.421295] pci 0000:23:00.1: PME# is unreliable, disabling it
[   65.421443] ohci-pci 0000:23:00.1: init 0000:23:00.1 fail, -16
[   65.426751] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
[   65.427006] ohci-pci: probe of 0000:23:00.1 failed with error -16
[   65.428422] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed
[   65.429813] pci 0000:23:00.2: MSI is not implemented on this device, disabling it
[   65.429814] pci 0000:23:00.2: PME# is unreliable, disabling it
[   65.429955] ehci-pci 0000:23:00.2: init 0000:23:00.2 fail, -16
[   65.435574] ehci-pci: probe of 0000:23:00.2 failed with error -16
[   65.435640] tg3 0000:24:00.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
[   65.438472] tg3 0000:24:00.0: Cannot map device registers, aborting
[   65.438498] tg3: probe of 0000:24:00.0 failed with error -12
[   65.438572] firewire_ohci 0000:25:00.0: invalid MMIO resource
[   65.778129] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
[   65.778158] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed


This is cold boot and plug the chain in at the bootloader phase. EFI does not set up the first head. Wait for it to settle, unplug/replug and both heads come up.


[    0.000000] Linux version 5.17.1bkc1+ (brad@bkmac) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #28 SMP PREEMPT Wed Apr 6 10:31:18 AWST 2022
[    0.000000] Command line: ro root=UUID=de35d1a6-e0e1-40b0-b46a-3974a04adf4b libata.allow_tpm=1 netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da oops=panic panic=10 thunderbolt.dyndbg pci=assign-busses,realloc,hpbussize=0x10,hpmmiosize=128M,hpmmioprefsize=1G initrd=boot\initrd.img-5.17.1bkc1+
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] reserving inaccessible SNB gfx pages
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008e000-0x000000000008ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040200000-0x000000008ed32fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ed33000-0x000000008ed5efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000008ed5f000-0x000000008ed70fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ed71000-0x000000008ed8efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000008ed8f000-0x000000008ee59fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ee5a000-0x000000008ee8efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008ee8f000-0x000000008eed6fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008eed7000-0x000000008eefefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008eeff000-0x000000008efa2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008efa3000-0x000000008f8fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffed8000-0x00000000ffefffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000086fefffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x890c7018-0x890e2c57] usable ==> usable
[    0.000000] e820: update [mem 0x890c7018-0x890e2c57] usable ==> usable
[    0.000000] e820: update [mem 0x89a45018-0x89a568eb] usable ==> usable
[    0.000000] e820: update [mem 0x89a45018-0x89a568eb] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000008dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008e000-0x000000000008ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000040000000-0x00000000401fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000040200000-0x00000000890c7017] usable
[    0.000000] reserve setup_data: [mem 0x00000000890c7018-0x00000000890e2c57] usable
[    0.000000] reserve setup_data: [mem 0x00000000890e2c58-0x0000000089a45017] usable
[    0.000000] reserve setup_data: [mem 0x0000000089a45018-0x0000000089a568eb] usable
[    0.000000] reserve setup_data: [mem 0x0000000089a568ec-0x000000008ed32fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ed33000-0x000000008ed5efff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000008ed5f000-0x000000008ed70fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ed71000-0x000000008ed8efff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000008ed8f000-0x000000008ee59fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ee5a000-0x000000008ee8efff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008ee8f000-0x000000008eed6fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008eed7000-0x000000008eefefff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008eeff000-0x000000008efa2fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008efa3000-0x000000008f8fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ffed8000-0x00000000ffefffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000086fefffff] usable
[    0.000000] efi: EFI v1.10 by Apple
[    0.000000] efi: ACPI=0x8ed8e000 ACPI 2.0=0x8ed8e014 SMBIOS=0x8ed3b000
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Apple Inc. iMac12,2/Mac-942B59F58194171B, BIOS 87.0.0.0.0 06/14/2019
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3399.727 MHz processor
[    0.000097] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000099] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000105] last_pfn = 0x86ff00 max_arch_pfn = 0x400000000
[    0.000754] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001371] last_pfn = 0x8efa3 max_arch_pfn = 0x400000000
[    0.002473] Secure boot disabled
[    0.002474] RAMDISK: [mem 0x7e4c0000-0x7fffffff]
[    0.002478] ACPI: Early table checksum verification disabled
[    0.002482] ACPI: RSDP 0x000000008ED8E014 000024 (v02 APPLE )
[    0.002486] ACPI: XSDT 0x000000008ED8E1C0 0000A4 (v01 APPLE  Apple00  0000F000      01000013)
[    0.002490] ACPI: FACP 0x000000008ED8C000 0000F4 (v04 APPLE  Apple00  0000F000 Loki 0000005F)
[    0.002495] ACPI: DSDT 0x000000008ED81000 0053FB (v01 APPLE  iMac     00210001 INTL 20061109)
[    0.002498] ACPI: FACS 0x000000008ED3E000 000040
[    0.002500] ACPI: FACS 0x000000008ED3E000 000040
[    0.002502] ACPI: HPET 0x000000008ED8B000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002505] ACPI: APIC 0x000000008ED8A000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002507] ACPI: SBST 0x000000008ED88000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002510] ACPI: ECDT 0x000000008ED87000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002512] ACPI: SSDT 0x000000008ED7E000 00020D (v01 APPLE  SataAhci 00001000 INTL 20061109)
[    0.002515] ACPI: SSDT 0x000000008ED7C000 0000B1 (v01 APPLE  SmcDppt  00001000 INTL 20061109)
[    0.002518] ACPI: SSDT 0x000000008ED7A000 000646 (v01 APPLE  UsbNoRmh 00001000 INTL 20061109)
[    0.002521] ACPI: SSDT 0x000000008ED78000 00013D (v01 APPLE  SataPrt1 00001000 INTL 20061109)
[    0.002523] ACPI: SSDT 0x000000008ED77000 0000A0 (v02 APPLE  IGHda    00001000 INTL 20061109)
[    0.002526] ACPI: SSDT 0x000000008ED75000 000032 (v01 APPLE  SsdtS3   00001000 INTL 20061109)
[    0.002528] ACPI: SSDT 0x000000008ED74000 000548 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.002531] ACPI: SSDT 0x000000008ED73000 0009B1 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.002534] ACPI: SSDT 0x000000008ED72000 000315 (v01 PmRef  Cpu0Tst  00003000 INTL 20061109)
[    0.002536] ACPI: SSDT 0x000000008ED71000 00037A (v01 PmRef  ApTst    00003000 INTL 20061109)
[    0.002539] ACPI: MCFG 0x000000008ED89000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002541] ACPI: Reserving FACP table memory at [mem 0x8ed8c000-0x8ed8c0f3]
[    0.002542] ACPI: Reserving DSDT table memory at [mem 0x8ed81000-0x8ed863fa]
[    0.002544] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002545] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002546] ACPI: Reserving HPET table memory at [mem 0x8ed8b000-0x8ed8b037]
[    0.002547] ACPI: Reserving APIC table memory at [mem 0x8ed8a000-0x8ed8a0bb]
[    0.002548] ACPI: Reserving SBST table memory at [mem 0x8ed88000-0x8ed8802f]
[    0.002549] ACPI: Reserving ECDT table memory at [mem 0x8ed87000-0x8ed87052]
[    0.002550] ACPI: Reserving SSDT table memory at [mem 0x8ed7e000-0x8ed7e20c]
[    0.002551] ACPI: Reserving SSDT table memory at [mem 0x8ed7c000-0x8ed7c0b0]
[    0.002552] ACPI: Reserving SSDT table memory at [mem 0x8ed7a000-0x8ed7a645]
[    0.002553] ACPI: Reserving SSDT table memory at [mem 0x8ed78000-0x8ed7813c]
[    0.002554] ACPI: Reserving SSDT table memory at [mem 0x8ed77000-0x8ed7709f]
[    0.002556] ACPI: Reserving SSDT table memory at [mem 0x8ed75000-0x8ed75031]
[    0.002557] ACPI: Reserving SSDT table memory at [mem 0x8ed74000-0x8ed74547]
[    0.002558] ACPI: Reserving SSDT table memory at [mem 0x8ed73000-0x8ed739b0]
[    0.002559] ACPI: Reserving SSDT table memory at [mem 0x8ed72000-0x8ed72314]
[    0.002560] ACPI: Reserving SSDT table memory at [mem 0x8ed71000-0x8ed71379]
[    0.002561] ACPI: Reserving MCFG table memory at [mem 0x8ed89000-0x8ed8903b]
[    0.002568] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.002595] Zone ranges:
[    0.002596]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002598]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002599]   Normal   [mem 0x0000000100000000-0x000000086fefffff]
[    0.002600] Movable zone start for each node
[    0.002601] Early memory node ranges
[    0.002602]   node   0: [mem 0x0000000000001000-0x000000000008dfff]
[    0.002603]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.002604]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.002605]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.002606]   node   0: [mem 0x0000000040200000-0x000000008ed32fff]
[    0.002607]   node   0: [mem 0x000000008ed5f000-0x000000008ed70fff]
[    0.002608]   node   0: [mem 0x000000008ed8f000-0x000000008ee59fff]
[    0.002609]   node   0: [mem 0x000000008ee8f000-0x000000008eed6fff]
[    0.002610]   node   0: [mem 0x000000008eeff000-0x000000008efa2fff]
[    0.002611]   node   0: [mem 0x0000000100000000-0x000000086fefffff]
[    0.002614] Initmem setup node 0 [mem 0x0000000000001000-0x000000086fefffff]
[    0.002617] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002619] On node 0, zone DMA: 2 pages in unavailable ranges
[    0.002638] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.004138] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006376] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006381] On node 0, zone DMA32: 44 pages in unavailable ranges
[    0.006383] On node 0, zone DMA32: 30 pages in unavailable ranges
[    0.006385] On node 0, zone DMA32: 53 pages in unavailable ranges
[    0.006388] On node 0, zone DMA32: 40 pages in unavailable ranges
[    0.060524] On node 0, zone Normal: 4189 pages in unavailable ranges
[    0.060531] On node 0, zone Normal: 256 pages in unavailable ranges
[    0.060695] ACPI: PM-Timer IO Port: 0x408
[    0.060701] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.060702] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.060703] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.060704] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.060705] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.060706] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.060707] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.060708] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.060717] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.060719] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.060721] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.060724] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.060726] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.060729] TSC deadline timer available
[    0.060730] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.060752] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.060754] PM: hibernation: Registered nosave memory: [mem 0x0008e000-0x0008ffff]
[    0.060756] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
[    0.060757] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.060759] PM: hibernation: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.060761] PM: hibernation: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.060762] PM: hibernation: Registered nosave memory: [mem 0x890c7000-0x890c7fff]
[    0.060764] PM: hibernation: Registered nosave memory: [mem 0x890e2000-0x890e2fff]
[    0.060766] PM: hibernation: Registered nosave memory: [mem 0x89a45000-0x89a45fff]
[    0.060768] PM: hibernation: Registered nosave memory: [mem 0x89a56000-0x89a56fff]
[    0.060770] PM: hibernation: Registered nosave memory: [mem 0x8ed33000-0x8ed5efff]
[    0.060772] PM: hibernation: Registered nosave memory: [mem 0x8ed71000-0x8ed8efff]
[    0.060773] PM: hibernation: Registered nosave memory: [mem 0x8ee5a000-0x8ee8efff]
[    0.060775] PM: hibernation: Registered nosave memory: [mem 0x8eed7000-0x8eefefff]
[    0.060777] PM: hibernation: Registered nosave memory: [mem 0x8efa3000-0x8f8fffff]
[    0.060778] PM: hibernation: Registered nosave memory: [mem 0x8f900000-0xe00f7fff]
[    0.060779] PM: hibernation: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.060780] PM: hibernation: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff]
[    0.060781] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.060781] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xffed7fff]
[    0.060782] PM: hibernation: Registered nosave memory: [mem 0xffed8000-0xffefffff]
[    0.060783] PM: hibernation: Registered nosave memory: [mem 0xfff00000-0xffffffff]
[    0.060785] [mem 0x8f900000-0xe00f7fff] available for PCI devices
[    0.060789] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.063068] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.063235] percpu: Embedded 44 pages/cpu s139416 r8192 d32616 u262144
[    0.063241] pcpu-alloc: s139416 r8192 d32616 u262144 alloc=1*2097152
[    0.063243] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.063265] Built 1 zonelists, mobility grouping on.  Total pages: 8251732
[    0.063267] Kernel command line: ro root=UUID=de35d1a6-e0e1-40b0-b46a-3974a04adf4b libata.allow_tpm=1 netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da oops=panic panic=10 thunderbolt.dyndbg pci=assign-busses,realloc,hpbussize=0x10,hpmmiosize=128M,hpmmioprefsize=1G initrd=boot\initrd.img-5.17.1bkc1+
[    0.063331] Unknown kernel command line parameters "netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da", will be passed to user space.
[    0.064952] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.065775] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.065840] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.152452] Memory: 32768300K/33531492K available (8192K kernel code, 2299K rwdata, 1844K rodata, 956K init, 2632K bss, 762936K reserved, 0K cma-reserved)
[    0.152487] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.152698] Dynamic Preempt: voluntary
[    0.152723] rcu: Preemptible hierarchical RCU implementation.
[    0.152725] 	Trampoline variant of Tasks RCU enabled.
[    0.152725] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.152734] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
[    0.152935] random: get_random_bytes called from start_kernel+0x443/0x5f6 with crng_init=0
[    0.152960] Console: colour dummy device 80x25
[    0.153238] printk: console [tty0] enabled
[    0.153247] ACPI: Core revision 20211217
[    0.153331] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.153346] APIC: Switch to symmetric I/O mode setup
[    0.153725] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.203350] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x31014cc2238, max_idle_ns: 440795368492 ns
[    0.203355] Calibrating delay loop (skipped), value calculated using timer frequency.. 6799.45 BogoMIPS (lpj=33997270)
[    0.203359] pid_max: default: 32768 minimum: 301
[    0.207395] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.207459] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.207581] CPU0: Thermal monitoring enabled (TM1)
[    0.207585] process: using mwait in idle threads
[    0.207587] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.207590] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.207592] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.207596] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.207596] Spectre V2 : Vulnerable
[    0.207599] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.207602] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.207604] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.207606] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.207609] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.207612] MDS: Mitigation: Clear CPU buffers
[    0.207767] Freeing SMP alternatives memory: 24K
[    0.208039] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1054
[    0.208046] smpboot: CPU0: Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz (family: 0x6, model: 0x2a, stepping: 0x7)
[    0.208102] cblist_init_generic: Setting adjustable number of callback queues.
[    0.208106] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.208116] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.208129] ... version:                3
[    0.208131] ... bit width:              48
[    0.208132] ... generic registers:      4
[    0.208134] ... value mask:             0000ffffffffffff
[    0.208136] ... max period:             00007fffffffffff
[    0.208137] ... fixed-purpose events:   3
[    0.208139] ... event mask:             000000070000000f
[    0.208217] rcu: Hierarchical SRCU implementation.
[    0.208315] smp: Bringing up secondary CPUs ...
[    0.208359] x86: Booting SMP configuration:
[    0.208361] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.216906] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.216906]  #5 #6 #7
[    0.226685] smp: Brought up 1 node, 8 CPUs
[    0.226685] smpboot: Max logical packages: 1
[    0.226685] smpboot: Total of 8 processors activated (54395.63 BogoMIPS)
[    0.228825] devtmpfs: initialized
[    0.228825] ACPI: PM: Registering ACPI NVS region [mem 0x8ed33000-0x8ed5efff] (180224 bytes)
[    0.228825] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.228825] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.228825] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.228825] thermal_sys: Registered thermal governor 'step_wise'
[    0.228825] thermal_sys: Registered thermal governor 'user_space'
[    0.228825] cpuidle: using governor ladder
[    0.228825] cpuidle: using governor menu
[    0.228825] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.228825] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.228825] PCI: not using MMCONFIG
[    0.228825] PCI: Using configuration type 1 for base access
[    0.228825] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.233876] ACPI: Disabled all _OSI OS vendors
[    0.233876] ACPI: Added _OSI(Module Device)
[    0.233876] ACPI: Added _OSI(Processor Device)
[    0.233876] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.233876] ACPI: Added _OSI(Processor Aggregator Device)
[    0.233876] ACPI: Added _OSI(Linux-Dell-Video)
[    0.233876] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.233876] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.233876] ACPI: Added _OSI(Darwin)
[    0.235694] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.235897] ACPI: EC: EC started
[    0.235899] ACPI: EC: interrupt blocked
[    0.236404] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.236407] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.236538] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.236673] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.236876] ACPI: Dynamic OEM Table Load:
[    0.236884] ACPI: SSDT 0xFFFF8881003B9800 000781 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.237205] ACPI: Dynamic OEM Table Load:
[    0.237211] ACPI: SSDT 0xFFFF8881003AE800 0003A4 (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.237448] ACPI: Dynamic OEM Table Load:
[    0.237453] ACPI: SSDT 0xFFFF8881000FA600 000119 (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.238237] ACPI: Interpreter enabled
[    0.238251] ACPI: PM: (supports S0 S3 S4 S5)
[    0.238253] ACPI: Using IOAPIC for interrupt routing
[    0.238270] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.238480] PCI: MMCONFIG at [mem 0xe0000000-0xefbfffff] reserved in ACPI motherboard resources
[    0.238493] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.238587] ACPI: Enabled 6 GPEs in block 00 to 3F
[    0.241443] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.241449] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.241454] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-fb] only partially covers this bridge
[    0.241590] PCI host bridge to bus 0000:00
[    0.241593] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.241596] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.241599] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.241602] pci_bus 0000:00: root bus resource [mem 0x8f900000-0xfeafffff window]
[    0.241605] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.241608] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.241618] pci 0000:00:00.0: [8086:0100] type 00 class 0x060000
[    0.241679] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
[    0.241708] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.241763] pci 0000:00:02.0: [8086:0102] type 00 class 0x038000
[    0.241771] pci 0000:00:02.0: reg 0x10: [mem 0xa8000000-0xa83fffff 64bit]
[    0.241777] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xa7ffffff 64bit pref]
[    0.241782] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.241852] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.241872] pci 0000:00:16.0: reg 0x10: [mem 0xa8907100-0xa890710f 64bit]
[    0.241938] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.241984] pci 0000:00:1a.0: [8086:1c2c] type 00 class 0x0c0300
[    0.242022] pci 0000:00:1a.0: reg 0x20: [io  0x3140-0x315f]
[    0.242106] pci 0000:00:1a.7: [8086:1c2d] type 00 class 0x0c0320
[    0.242121] pci 0000:00:1a.7: reg 0x10: [mem 0xa8906c00-0xa8906fff]
[    0.242197] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.242363] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.242379] pci 0000:00:1b.0: reg 0x10: [mem 0xa8900000-0xa8903fff 64bit]
[    0.242441] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.242501] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.242581] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.242647] pci 0000:00:1c.1: [8086:1c12] type 01 class 0x060400
[    0.242726] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.243417] pci 0000:00:1c.2: [8086:1c14] type 01 class 0x060400
[    0.243497] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.243563] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    0.243643] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.243706] pci 0000:00:1d.0: [8086:1c27] type 00 class 0x0c0300
[    0.243745] pci 0000:00:1d.0: reg 0x20: [io  0x30e0-0x30ff]
[    0.243827] pci 0000:00:1d.7: [8086:1c26] type 00 class 0x0c0320
[    0.243843] pci 0000:00:1d.7: reg 0x10: [mem 0xa8906800-0xa8906bff]
[    0.243918] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.244081] pci 0000:00:1f.0: [8086:1c44] type 00 class 0x060100
[    0.244222] pci 0000:00:1f.2: [8086:1c02] type 00 class 0x010601
[    0.244234] pci 0000:00:1f.2: reg 0x10: [io  0x3168-0x316f]
[    0.244242] pci 0000:00:1f.2: reg 0x14: [io  0x317c-0x317f]
[    0.244249] pci 0000:00:1f.2: reg 0x18: [io  0x3160-0x3167]
[    0.244256] pci 0000:00:1f.2: reg 0x1c: [io  0x3178-0x317b]
[    0.244264] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
[    0.244271] pci 0000:00:1f.2: reg 0x24: [mem 0xa8906000-0xa89067ff]
[    0.244306] pci 0000:00:1f.2: PME# supported from D3hot
[    0.244352] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    0.244367] pci 0000:00:1f.3: reg 0x10: [mem 0xa8907000-0xa89070ff 64bit]
[    0.244382] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.244485] pci 0000:01:00.0: [1002:6720] type 00 class 0x030000
[    0.244500] pci 0000:01:00.0: reg 0x10: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.244511] pci 0000:01:00.0: reg 0x18: [mem 0xa8800000-0xa881ffff 64bit]
[    0.244519] pci 0000:01:00.0: reg 0x20: [io  0x2000-0x20ff]
[    0.244531] pci 0000:01:00.0: reg 0x30: [mem 0xa8820000-0xa883ffff pref]
[    0.244538] pci 0000:01:00.0: enabling Extended Tags
[    0.244548] pci 0000:01:00.0: BAR 0: assigned to efifb
[    0.244577] pci 0000:01:00.0: supports D1 D2
[    0.244666] pci 0000:01:00.1: [1002:aa88] type 00 class 0x040300
[    0.244681] pci 0000:01:00.1: reg 0x10: [mem 0xa8840000-0xa8843fff 64bit]
[    0.244706] pci 0000:01:00.1: enabling Extended Tags
[    0.244742] pci 0000:01:00.1: supports D1 D2
[    0.244833] pci 0000:00:01.0: PCI bridge to [bus 01-ff]
[    0.244837] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.244840] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.244844] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.244847] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.244921] pci 0000:02:00.0: [14e4:16b4] type 00 class 0x020000
[    0.244955] pci 0000:02:00.0: reg 0x10: [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.244977] pci 0000:02:00.0: reg 0x18: [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.245134] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.245249] pci 0000:00:1c.0: PCI bridge to [bus 02-ff]
[    0.245256] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.245262] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.245265] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    0.245335] pci 0000:03:00.0: [168c:0030] type 00 class 0x028000
[    0.245366] pci 0000:03:00.0: reg 0x10: [mem 0xa8600000-0xa861ffff 64bit]
[    0.245427] pci 0000:03:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    0.245518] pci 0000:03:00.0: supports D1 D2
[    0.245520] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.245620] pci 0000:00:1c.1: PCI bridge to [bus 03-ff]
[    0.245626] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.245633] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.245704] pci 0000:04:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.245738] pci 0000:04:00.0: reg 0x10: [mem 0xa8500000-0xa8500fff 64bit]
[    0.245901] pci 0000:04:00.0: supports D1 D2
[    0.245903] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246098] pci 0000:00:1c.2: PCI bridge to [bus 04-ff]
[    0.246105] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.246111] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.246184] pci 0000:05:00.0: [8086:1513] type 01 class 0x060400
[    0.246249] pci 0000:05:00.0: enabling Extended Tags
[    0.246345] pci 0000:05:00.0: supports D1 D2
[    0.246347] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246474] pci 0000:00:1c.4: PCI bridge to [bus 05-ff]
[    0.246479] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.246483] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.246489] pci 0000:00:1c.4:   bridge window [mem 0xacf00000-0xb10fffff 64bit pref]
[    0.246574] acpiphp: Slot [3] registered
[    0.246596] acpiphp: Slot [4] registered
[    0.246637] pci 0000:06:00.0: [8086:1513] type 01 class 0x060400
[    0.246708] pci 0000:06:00.0: enabling Extended Tags
[    0.246809] pci 0000:06:00.0: supports D1 D2
[    0.246811] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246923] pci 0000:06:03.0: [8086:1513] type 01 class 0x060400
[    0.246994] pci 0000:06:03.0: enabling Extended Tags
[    0.247095] pci 0000:06:03.0: supports D1 D2
[    0.247097] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247203] pci 0000:06:04.0: [8086:1513] type 01 class 0x060400
[    0.247274] pci 0000:06:04.0: enabling Extended Tags
[    0.247375] pci 0000:06:04.0: supports D1 D2
[    0.247377] pci 0000:06:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247485] pci 0000:06:05.0: [8086:1513] type 01 class 0x060400
[    0.247555] pci 0000:06:05.0: enabling Extended Tags
[    0.247656] pci 0000:06:05.0: supports D1 D2
[    0.247658] pci 0000:06:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247768] pci 0000:06:06.0: [8086:1513] type 01 class 0x060400
[    0.247838] pci 0000:06:06.0: enabling Extended Tags
[    0.247939] pci 0000:06:06.0: supports D1 D2
[    0.247941] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248060] pci 0000:05:00.0: PCI bridge to [bus 06-ff]
[    0.248072] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.248080] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.248180] acpiphp: Slot [1] registered
[    0.248221] pci 0000:07:00.0: [8086:1513] type 00 class 0x088000
[    0.248249] pci 0000:07:00.0: reg 0x10: [mem 0xa8a00000-0xa8a3ffff]
[    0.248265] pci 0000:07:00.0: reg 0x14: [mem 0xa8a40000-0xa8a40fff]
[    0.248345] pci 0000:07:00.0: enabling Extended Tags
[    0.248470] pci 0000:07:00.0: supports D1 D2
[    0.248472] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248615] pci 0000:06:00.0: PCI bridge to [bus 07-ff]
[    0.248627] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.248636] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    0.248694] pci 0000:06:03.0: PCI bridge to [bus 08-ff]
[    0.248705] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.248714] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 17
[    0.248828] pci 0000:18:00.0: [8086:1513] type 01 class 0x060400
[    0.248946] pci 0000:18:00.0: enabling Extended Tags
[    0.249123] pci 0000:18:00.0: supports D1 D2
[    0.249125] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.273416] pci 0000:06:04.0: PCI bridge to [bus 18-ff]
[    0.273435] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.273447] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.273457] pci 0000:18:00.0: bridge configuration invalid ([bus 3a-49]), reconfiguring
[    0.273623] pci 0000:19:00.0: [8086:1513] type 01 class 0x060400
[    0.273747] pci 0000:19:00.0: enabling Extended Tags
[    0.273929] pci 0000:19:00.0: supports D1 D2
[    0.273931] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274088] pci 0000:19:01.0: [8086:1513] type 01 class 0x060400
[    0.274213] pci 0000:19:01.0: enabling Extended Tags
[    0.274394] pci 0000:19:01.0: supports D1 D2
[    0.274396] pci 0000:19:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274552] pci 0000:19:02.0: [8086:1513] type 01 class 0x060400
[    0.274676] pci 0000:19:02.0: enabling Extended Tags
[    0.274857] pci 0000:19:02.0: supports D1 D2
[    0.274859] pci 0000:19:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275020] pci 0000:19:04.0: [8086:1513] type 01 class 0x060400
[    0.275144] pci 0000:19:04.0: enabling Extended Tags
[    0.275327] pci 0000:19:04.0: supports D1 D2
[    0.275329] pci 0000:19:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275491] pci 0000:19:05.0: [8086:1513] type 01 class 0x060400
[    0.275598] pci 0000:19:05.0: enabling Extended Tags
[    0.275781] pci 0000:19:05.0: supports D1 D2
[    0.275783] pci 0000:19:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275964] pci 0000:18:00.0: PCI bridge to [bus 19-ff]
[    0.275983] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.275997] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.276003] pci 0000:19:00.0: bridge configuration invalid ([bus 3b-3d]), reconfiguring
[    0.276020] pci 0000:19:01.0: bridge configuration invalid ([bus 3e-3e]), reconfiguring
[    0.276037] pci 0000:19:02.0: bridge configuration invalid ([bus 3f-3f]), reconfiguring
[    0.276054] pci 0000:19:04.0: bridge configuration invalid ([bus 40-48]), reconfiguring
[    0.276071] pci 0000:19:05.0: bridge configuration invalid ([bus 49-49]), reconfiguring
[    0.276226] pci 0000:1a:00.0: [12d8:400c] type 01 class 0x060400
[    0.276616] pci 0000:1a:00.0: supports D1 D2
[    0.276619] pci 0000:1a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.303391] pci 0000:19:00.0: PCI bridge to [bus 1a-ff]
[    0.303416] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.303438] pci 0000:1a:00.0: bridge configuration invalid ([bus 3c-3d]), reconfiguring
[    0.303675] pci 0000:1b:03.0: [12d8:400c] type 01 class 0x060400
[    0.304012] pci 0000:1b:03.0: supports D1 D2
[    0.304014] pci 0000:1b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304218] pci 0000:1a:00.0: PCI bridge to [bus 1b-ff]
[    0.304243] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.304265] pci 0000:1b:03.0: bridge configuration invalid ([bus 3d-3d]), reconfiguring
[    0.304470] pci 0000:1c:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.304522] pci 0000:1c:00.0: reg 0x10: [mem 0xa9401000-0xa9401fff]
[    0.304837] pci 0000:1c:00.0: supports D1 D2
[    0.304839] pci 0000:1c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304995] pci 0000:1c:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.305047] pci 0000:1c:00.1: reg 0x10: [mem 0xa9400000-0xa9400fff]
[    0.305361] pci 0000:1c:00.1: supports D1 D2
[    0.305363] pci 0000:1c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.305491] pci 0000:1c:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.305543] pci 0000:1c:00.2: reg 0x10: [mem 0xa9402000-0xa94020ff]
[    0.305856] pci 0000:1c:00.2: supports D1 D2
[    0.305858] pci 0000:1c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.306116] pci 0000:1b:03.0: PCI bridge to [bus 1c-ff]
[    0.306141] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.306159] pci_bus 0000:1c: busn_res: [bus 1c-ff] end is updated to 1c
[    0.306170] pci_bus 0000:1b: busn_res: [bus 1b-ff] end is updated to 1c
[    0.306180] pci_bus 0000:1a: busn_res: [bus 1a-ff] end is updated to 1c
[    0.306327] pci 0000:1d:00.0: [14e4:16b0] type 00 class 0x020000
[    0.306396] pci 0000:1d:00.0: reg 0x10: [mem 0xad000000-0xad00ffff 64bit pref]
[    0.306443] pci 0000:1d:00.0: reg 0x18: [mem 0xad010000-0xad01ffff 64bit pref]
[    0.306786] pci 0000:1d:00.0: PME# supported from D0 D3hot D3cold
[    0.333411] pci 0000:19:01.0: PCI bridge to [bus 1d-ff]
[    0.333436] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.333453] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.333460] pci_bus 0000:1d: busn_res: [bus 1d-ff] end is updated to 1d
[    0.333615] pci 0000:1e:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.333685] pci 0000:1e:00.0: reg 0x10: [mem 0xa9200000-0xa9200fff 64bit]
[    0.334039] pci 0000:1e:00.0: supports D1 D2
[    0.334041] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.363410] pci 0000:19:02.0: PCI bridge to [bus 1e-ff]
[    0.363435] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.363453] pci_bus 0000:1e: busn_res: [bus 1e-ff] end is updated to 1e
[    0.363634] pci 0000:1f:00.0: [8086:1513] type 01 class 0x060400
[    0.363806] pci 0000:1f:00.0: enabling Extended Tags
[    0.364063] pci 0000:1f:00.0: supports D1 D2
[    0.364065] pci 0000:1f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.393398] pci 0000:19:04.0: PCI bridge to [bus 1f-ff]
[    0.393422] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.393440] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.393450] pci 0000:1f:00.0: bridge configuration invalid ([bus 41-48]), reconfiguring
[    0.393680] pci 0000:20:00.0: [8086:1513] type 01 class 0x060400
[    0.393859] pci 0000:20:00.0: enabling Extended Tags
[    0.394120] pci 0000:20:00.0: supports D1 D2
[    0.394122] pci 0000:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394342] pci 0000:20:01.0: [8086:1513] type 01 class 0x060400
[    0.394521] pci 0000:20:01.0: enabling Extended Tags
[    0.394782] pci 0000:20:01.0: supports D1 D2
[    0.394784] pci 0000:20:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.395002] pci 0000:20:02.0: [8086:1513] type 01 class 0x060400
[    0.395181] pci 0000:20:02.0: enabling Extended Tags
[    0.395442] pci 0000:20:02.0: supports D1 D2
[    0.395444] pci 0000:20:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.395672] pci 0000:20:04.0: [8086:1513] type 01 class 0x060400
[    0.395827] pci 0000:20:04.0: enabling Extended Tags
[    0.396092] pci 0000:20:04.0: supports D1 D2
[    0.396094] pci 0000:20:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.396320] pci 0000:20:05.0: [8086:1513] type 01 class 0x060400
[    0.396475] pci 0000:20:05.0: enabling Extended Tags
[    0.396740] pci 0000:20:05.0: supports D1 D2
[    0.396743] pci 0000:20:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.396997] pci 0000:1f:00.0: PCI bridge to [bus 20-ff]
[    0.397024] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.397043] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.397050] pci 0000:20:00.0: bridge configuration invalid ([bus 42-44]), reconfiguring
[    0.397074] pci 0000:20:01.0: bridge configuration invalid ([bus 45-45]), reconfiguring
[    0.397097] pci 0000:20:02.0: bridge configuration invalid ([bus 46-46]), reconfiguring
[    0.397120] pci 0000:20:04.0: bridge configuration invalid ([bus 47-47]), reconfiguring
[    0.397143] pci 0000:20:05.0: bridge configuration invalid ([bus 48-48]), reconfiguring
[    0.397357] pci 0000:21:00.0: [12d8:400c] type 01 class 0x060400
[    0.397879] pci 0000:21:00.0: supports D1 D2
[    0.397881] pci 0000:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.398148] pci 0000:20:00.0: PCI bridge to [bus 21-ff]
[    0.398176] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.398200] pci 0000:21:00.0: bridge configuration invalid ([bus 43-44]), reconfiguring
[    0.398497] pci 0000:22:03.0: [12d8:400c] type 01 class 0x060400
[    0.398946] pci 0000:22:03.0: supports D1 D2
[    0.398948] pci 0000:22:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.399212] pci 0000:21:00.0: PCI bridge to [bus 22-ff]
[    0.399245] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.399272] pci 0000:22:03.0: bridge configuration invalid ([bus 44-44]), reconfiguring
[    0.399544] pci 0000:23:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.399612] pci 0000:23:00.0: reg 0x10: [mem 0xa9101000-0xa9101fff]
[    0.400030] pci 0000:23:00.0: supports D1 D2
[    0.400033] pci 0000:23:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400240] pci 0000:23:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.400309] pci 0000:23:00.1: reg 0x10: [mem 0xa9100000-0xa9100fff]
[    0.400727] pci 0000:23:00.1: supports D1 D2
[    0.400729] pci 0000:23:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400892] pci 0000:23:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.400961] pci 0000:23:00.2: reg 0x10: [mem 0xa9102000-0xa91020ff]
[    0.401379] pci 0000:23:00.2: supports D1 D2
[    0.401381] pci 0000:23:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.401735] pci 0000:22:03.0: PCI bridge to [bus 23-ff]
[    0.401767] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.401790] pci_bus 0000:23: busn_res: [bus 23-ff] end is updated to 23
[    0.401803] pci_bus 0000:22: busn_res: [bus 22-ff] end is updated to 23
[    0.401816] pci_bus 0000:21: busn_res: [bus 21-ff] end is updated to 23
[    0.402018] pci 0000:24:00.0: [14e4:16b0] type 00 class 0x020000
[    0.402110] pci 0000:24:00.0: reg 0x10: [mem 0xacf00000-0xacf0ffff 64bit pref]
[    0.402169] pci 0000:24:00.0: reg 0x18: [mem 0xacf10000-0xacf1ffff 64bit pref]
[    0.402623] pci 0000:24:00.0: PME# supported from D0 D3hot D3cold
[    0.402941] pci 0000:20:01.0: PCI bridge to [bus 24-ff]
[    0.402968] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.402987] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.402990] pci_bus 0000:24: busn_res: [bus 24-ff] end is updated to 24
[    0.403187] pci 0000:25:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.403279] pci 0000:25:00.0: reg 0x10: [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.403749] pci 0000:25:00.0: supports D1 D2
[    0.403751] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.404049] pci 0000:20:02.0: PCI bridge to [bus 25-ff]
[    0.404076] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.404096] pci_bus 0000:25: busn_res: [bus 25-ff] end is updated to 25
[    0.404229] pci 0000:20:04.0: PCI bridge to [bus 26-ff]
[    0.404256] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.404275] pci_bus 0000:26: busn_res: [bus 26-ff] end is updated to 35
[    0.404408] pci 0000:20:05.0: PCI bridge to [bus 36-ff]
[    0.404435] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.404454] pci_bus 0000:36: busn_res: [bus 36-ff] end is updated to 45
[    0.404465] pci_bus 0000:20: busn_res: [bus 20-ff] end is updated to 45
[    0.404475] pci_bus 0000:1f: busn_res: [bus 1f-ff] end is updated to 45
[    0.404569] pci 0000:19:05.0: PCI bridge to [bus 46-ff]
[    0.404589] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.404603] pci_bus 0000:46: busn_res: [bus 46-ff] end is updated to 55
[    0.404611] pci_bus 0000:19: busn_res: [bus 19-ff] end is updated to 55
[    0.404619] pci_bus 0000:18: busn_res: [bus 18-ff] end is updated to 55
[    0.404682] pci 0000:06:05.0: PCI bridge to [bus 56-ff]
[    0.404694] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.404702] pci_bus 0000:56: busn_res: [bus 56-ff] end is updated to 65
[    0.404759] pci 0000:06:06.0: PCI bridge to [bus 66-ff]
[    0.404771] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.404780] pci_bus 0000:66: busn_res: [bus 66-ff] end is updated to 75
[    0.404786] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 75
[    0.404791] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 75
[    0.404796] pci_bus 0000:00: on NUMA node 0
[    0.405060] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.405063] ACPI: PCI: Interrupt link LNKA disabled
[    0.405093] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.405096] ACPI: PCI: Interrupt link LNKB disabled
[    0.405125] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.405127] ACPI: PCI: Interrupt link LNKC disabled
[    0.405155] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.405158] ACPI: PCI: Interrupt link LNKD disabled
[    0.405186] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.405188] ACPI: PCI: Interrupt link LNKE disabled
[    0.405216] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.405219] ACPI: PCI: Interrupt link LNKF disabled
[    0.405247] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.405249] ACPI: PCI: Interrupt link LNKG disabled
[    0.405277] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.405279] ACPI: PCI: Interrupt link LNKH disabled
[    0.405366] ACPI: EC: interrupt unblocked
[    0.405368] ACPI: EC: event unblocked
[    0.405373] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.405375] ACPI: EC: GPE=0x17
[    0.405376] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.405379] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.405408] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.405408] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.405408] pci 0000:01:00.0: vgaarb: setting as boot device
[    0.405408] vgaarb: loaded
[    0.405408] SCSI subsystem initialized
[    0.405408] libata version 3.00 loaded.
[    0.405408] Registered efivars operations
[    0.405408] PCI: Using ACPI for IRQ routing
[    0.416084] PCI: pci_cache_line_size set to 64 bytes
[    0.416086] pci 0000:00:1c.4: can't claim BAR 9 [mem 0xacf00000-0xb10fffff 64bit pref]: address conflict with PCI Bus 0000:05 [mem 0xa8a00000-0xad6fffff]
[    0.416367] e820: reserve RAM buffer [mem 0x0008e000-0x0008ffff]
[    0.416369] e820: reserve RAM buffer [mem 0x890c7018-0x8bffffff]
[    0.416370] e820: reserve RAM buffer [mem 0x89a45018-0x8bffffff]
[    0.416371] e820: reserve RAM buffer [mem 0x8ed33000-0x8fffffff]
[    0.416372] e820: reserve RAM buffer [mem 0x8ed71000-0x8fffffff]
[    0.416374] e820: reserve RAM buffer [mem 0x8ee5a000-0x8fffffff]
[    0.416375] e820: reserve RAM buffer [mem 0x8eed7000-0x8fffffff]
[    0.416376] e820: reserve RAM buffer [mem 0x8efa3000-0x8fffffff]
[    0.416377] e820: reserve RAM buffer [mem 0x86ff00000-0x86fffffff]
[    0.417275] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.417286] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.419328] clocksource: Switched to clocksource tsc-early
[    0.419365] VFS: Disk quotas dquot_6.6.0
[    0.419376] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.419408] pnp: PnP ACPI init
[    0.419515] system 00:00: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.419559] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.419562] system 00:01: [io  0x1000-0x100f] has been reserved
[    0.419565] system 00:01: [io  0xffff] has been reserved
[    0.419567] system 00:01: [io  0xffff] has been reserved
[    0.419569] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.419572] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.419574] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.419724] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.419727] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.419731] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.419733] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.419736] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.419739] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.419741] system 00:03: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.419744] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.419747] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[    0.419749] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.419829] pnp: PnP ACPI: found 4 devices
[    0.419844] pci 0000:01:00.0: assigning 74 device properties
[    0.419844] pci 0000:04:00.0: assigning 2 device properties
[    0.419844] pci 0000:07:00.0: assigning 5 device properties
[    0.419844] pci 0000:00:1b.0: assigning 4 device properties
[    0.419844] pci 0000:1e:00.0: assigning 2 device properties
[    0.419844] pci 0000:25:00.0: assigning 2 device properties
[    0.419844] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.419844] NET: Registered PF_INET protocol family
[    0.419844] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.421190] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.421231] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.421495] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.421585] TCP: Hash tables configured (established 262144 bind 65536)
[    0.421612] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.421671] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.421749] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.421757] pci 0000:03:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[    0.421764] pci_bus 0000:00: max bus depth: 9 pci_try_num: 10
[    0.421776] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.421780] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.421784] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.421787] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.421792] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.421796] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.421801] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.421809] pci 0000:03:00.0: BAR 6: assigned [mem 0xa8620000-0xa862ffff pref]
[    0.421813] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.421817] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.421825] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.421830] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.421839] pci 0000:05:00.0: BAR 7: no space for [io  size 0x8000]
[    0.421841] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x8000]
[    0.421846] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421849] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421853] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421855] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421859] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421862] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421865] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.421867] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421870] pci 0000:06:04.0: BAR 7: no space for [io  size 0x5000]
[    0.421872] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.421874] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.421877] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421880] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.421882] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421886] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.421892] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.421904] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.421911] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.421923] pci 0000:18:00.0: BAR 7: no space for [io  size 0x4000]
[    0.421926] pci 0000:18:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.421930] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421932] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421935] pci 0000:19:04.0: BAR 7: no space for [io  size 0x3000]
[    0.421938] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.421940] pci 0000:19:05.0: BAR 7: no space for [io  size 0x1000]
[    0.421942] pci 0000:19:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421946] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.421959] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.421984] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.421998] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422023] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.422034] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422054] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.422064] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.422072] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.422086] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.422097] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.422117] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.422119] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.422123] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422126] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422129] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422132] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422135] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[    0.422137] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422139] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422142] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422145] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.422162] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422195] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.422212] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422245] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.422259] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422286] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.422301] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.422311] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422331] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.422345] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.422372] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.422387] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.422414] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.422428] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.422455] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.422469] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.422480] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422499] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.422509] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.422517] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422532] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.422542] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.422561] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.422572] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.422580] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422594] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.422601] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.422606] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422615] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.422622] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.422634] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.422641] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.422653] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.422659] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.422665] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422674] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.422677] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.422682] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.422690] pci_bus 0000:00: No. 2 try to assign unassigned res
[    0.422698] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.422700] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.422703] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.422706] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.422710] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.422715] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.422719] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.422726] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.422731] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.422738] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.422743] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.422751] pci 0000:05:00.0: BAR 7: no space for [io  size 0x8000]
[    0.422754] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x8000]
[    0.422757] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422760] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422763] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422766] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422770] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422772] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422775] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.422778] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422780] pci 0000:06:04.0: BAR 7: no space for [io  size 0x5000]
[    0.422782] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.422785] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422787] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422789] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.422792] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422794] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.422801] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.422813] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.422820] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.422832] pci 0000:18:00.0: BAR 7: no space for [io  size 0x4000]
[    0.422834] pci 0000:18:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.422838] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422840] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422843] pci 0000:19:04.0: BAR 7: no space for [io  size 0x3000]
[    0.422846] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.422848] pci 0000:19:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422850] pci 0000:19:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422853] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.422866] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422891] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.422905] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422930] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.422941] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422960] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.422970] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.422979] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.422993] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.423003] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.423023] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.423025] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.423028] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423031] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423035] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423038] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423040] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[    0.423043] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.423045] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[    0.423047] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.423050] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.423067] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423100] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.423117] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423150] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.423164] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423191] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.423206] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.423216] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423236] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.423250] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.423277] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.423291] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.423318] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.423333] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.423360] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.423374] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.423384] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423403] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.423414] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.423422] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423436] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.423447] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.423466] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.423476] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.423484] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423498] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.423505] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.423511] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423520] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.423527] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.423538] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.423545] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.423557] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.423564] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.423569] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423578] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.423581] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.423586] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.423594] pci_bus 0000:00: No. 3 try to assign unassigned res
[    0.423596] release child resource [mem 0xa9100000-0xa9100fff]
[    0.423597] release child resource [mem 0xa9101000-0xa9101fff]
[    0.423598] release child resource [mem 0xa9102000-0xa91020ff]
[    0.423599] pci 0000:22:03.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423601] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.423614] pci 0000:21:00.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423616] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.423628] pci 0000:20:00.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423631] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.423641] release child resource [mem 0xacf00000-0xacf0ffff 64bit pref]
[    0.423642] release child resource [mem 0xacf10000-0xacf1ffff 64bit pref]
[    0.423643] pci 0000:20:01.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423646] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.423668] release child resource [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.423669] pci 0000:20:02.0: resource 8 [mem 0xa8f00000-0xa8ffffff] released
[    0.423672] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.423682] pci 0000:20:04.0: resource 8 [mem 0xa8e00000-0xa8efffff] released
[    0.423685] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.423695] pci 0000:20:05.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.423698] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.423708] pci 0000:1f:00.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423711] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.423734] release child resource [mem 0xa9400000-0xa9400fff]
[    0.423735] release child resource [mem 0xa9401000-0xa9401fff]
[    0.423735] release child resource [mem 0xa9402000-0xa94020ff]
[    0.423736] pci 0000:1b:03.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423739] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.423748] pci 0000:1a:00.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423751] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.423761] pci 0000:19:00.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423763] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.423771] release child resource [mem 0xad000000-0xad00ffff 64bit pref]
[    0.423772] release child resource [mem 0xad010000-0xad01ffff 64bit pref]
[    0.423772] pci 0000:19:01.0: resource 9 [mem 0xad000000-0xad0fffff 64bit pref] released
[    0.423776] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.423791] release child resource [mem 0xa9200000-0xa9200fff 64bit]
[    0.423792] pci 0000:19:02.0: resource 8 [mem 0xa9200000-0xa92fffff] released
[    0.423795] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.423803] pci 0000:19:04.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423806] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.423822] pci 0000:19:05.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.423824] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.423832] pci 0000:18:00.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423835] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.423852] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.423853] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.423854] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.423856] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.423861] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xa8bfffff] released
[    0.423864] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.423869] pci 0000:06:04.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423872] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.423882] pci 0000:06:05.0: resource 8 [mem 0xa9500000-0xa95fffff] released
[    0.423885] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.423890] pci 0000:06:06.0: resource 8 [mem 0xa9600000-0xa96fffff] released
[    0.423893] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.423898] pci 0000:05:00.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423901] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.423911] pci 0000:00:1c.4: resource 7 [io  0x4000-0x4fff] released
[    0.423914] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.423929] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.423932] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.423936] pci 0000:00:1c.4: BAR 7: assigned [io  0x4000-0xbfff]
[    0.423938] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.423941] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.423944] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.423947] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.423951] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.423956] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.423960] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.423966] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.423971] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.423979] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.423984] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.423992] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.423995] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.423998] pci 0000:05:00.0: BAR 7: assigned [io  0x4000-0xbfff]
[    0.424002] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.424005] pci 0000:06:03.0: BAR 8: no space for [mem size 0x08000000]
[    0.424007] pci 0000:06:03.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424010] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424013] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424016] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.424019] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.424022] pci 0000:06:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424025] pci 0000:06:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424028] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424030] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424033] pci 0000:06:06.0: BAR 8: no space for [mem size 0x08000000]
[    0.424036] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424039] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424042] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424044] pci 0000:06:03.0: BAR 7: assigned [io  0x4000-0x4fff]
[    0.424047] pci 0000:06:04.0: BAR 7: assigned [io  0x5000-0x9fff]
[    0.424050] pci 0000:06:05.0: BAR 7: assigned [io  0xa000-0xafff]
[    0.424052] pci 0000:06:06.0: BAR 7: assigned [io  0xb000-0xbfff]
[    0.424055] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.424061] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.424068] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.424075] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.424087] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.424090] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.424107] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.424110] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.424113] pci 0000:18:00.0: BAR 7: assigned [io  0x5000-0x8fff]
[    0.424116] pci 0000:19:00.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424120] pci 0000:19:01.0: BAR 9: assigned [mem 0xa9200000-0xa92fffff 64bit pref]
[    0.424123] pci 0000:19:02.0: BAR 8: assigned [mem 0xa9400000-0xa94fffff]
[    0.424125] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.424128] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.424131] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424134] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424136] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424139] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424142] pci 0000:19:04.0: BAR 7: assigned [io  0x5000-0x7fff]
[    0.424145] pci 0000:19:05.0: BAR 7: assigned [io  0x8000-0x8fff]
[    0.424147] pci 0000:1a:00.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424150] pci 0000:1b:03.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424153] pci 0000:1c:00.0: BAR 0: assigned [mem 0xa8c00000-0xa8c00fff]
[    0.424164] pci 0000:1c:00.1: BAR 0: assigned [mem 0xa8c01000-0xa8c01fff]
[    0.424174] pci 0000:1c:00.2: BAR 0: assigned [mem 0xa8c02000-0xa8c020ff]
[    0.424184] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.424197] pci 0000:1b:03.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424222] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.424236] pci 0000:1a:00.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424261] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.424272] pci 0000:19:00.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424292] pci 0000:1d:00.0: BAR 0: assigned [mem 0xa9200000-0xa920ffff 64bit pref]
[    0.424323] pci 0000:1d:00.0: BAR 2: assigned [mem 0xa9210000-0xa921ffff 64bit pref]
[    0.424353] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.424364] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.424372] pci 0000:19:01.0:   bridge window [mem 0xa9200000-0xa92fffff 64bit pref]
[    0.424386] pci 0000:1e:00.0: BAR 0: assigned [mem 0xa9400000-0xa9400fff 64bit]
[    0.424417] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.424428] pci 0000:19:02.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.424447] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.424450] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.424453] pci 0000:1f:00.0: BAR 7: assigned [io  0x5000-0x6fff]
[    0.424456] pci 0000:20:00.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424459] pci 0000:20:01.0: BAR 9: assigned [mem 0xa8e00000-0xa8efffff 64bit pref]
[    0.424462] pci 0000:20:02.0: BAR 8: assigned [mem 0xa8f00000-0xa8ffffff]
[    0.424465] pci 0000:20:04.0: BAR 8: no space for [mem size 0x08000000]
[    0.424468] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424470] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424473] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424476] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424479] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424482] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424484] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424487] pci 0000:20:04.0: BAR 7: assigned [io  0x5000-0x5fff]
[    0.424490] pci 0000:20:05.0: BAR 7: assigned [io  0x6000-0x6fff]
[    0.424493] pci 0000:21:00.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424496] pci 0000:22:03.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424498] pci 0000:23:00.0: BAR 0: assigned [mem 0xa8d00000-0xa8d00fff]
[    0.424511] pci 0000:23:00.1: BAR 0: assigned [mem 0xa8d01000-0xa8d01fff]
[    0.424524] pci 0000:23:00.2: BAR 0: assigned [mem 0xa8d02000-0xa8d020ff]
[    0.424537] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.424554] pci 0000:22:03.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424587] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.424604] pci 0000:21:00.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424637] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.424651] pci 0000:20:00.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424679] pci 0000:24:00.0: BAR 0: assigned [mem 0xa8e00000-0xa8e0ffff 64bit pref]
[    0.424718] pci 0000:24:00.0: BAR 2: assigned [mem 0xa8e10000-0xa8e1ffff 64bit pref]
[    0.424758] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.424772] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.424783] pci 0000:20:01.0:   bridge window [mem 0xa8e00000-0xa8efffff 64bit pref]
[    0.424802] pci 0000:25:00.0: BAR 0: assigned [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.424842] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.424856] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.424883] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.424890] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.424929] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.424935] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.424974] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.424980] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.424995] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.425021] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.425026] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.425037] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.425057] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.425061] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.425089] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.425094] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.425105] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.425124] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.425127] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.425134] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.425146] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.425150] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.425166] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.425170] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.425186] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.425190] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.425197] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.425208] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.425211] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.425216] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.425224] pci_bus 0000:00: No. 4 try to assign unassigned res
[    0.425226] release child resource [mem 0xa8d00000-0xa8d00fff]
[    0.425227] release child resource [mem 0xa8d01000-0xa8d01fff]
[    0.425227] release child resource [mem 0xa8d02000-0xa8d020ff]
[    0.425228] pci 0000:22:03.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425231] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.425243] pci 0000:21:00.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425245] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.425258] pci 0000:20:00.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425260] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.425270] release child resource [mem 0xa8e00000-0xa8e0ffff 64bit pref]
[    0.425271] release child resource [mem 0xa8e10000-0xa8e1ffff 64bit pref]
[    0.425272] pci 0000:20:01.0: resource 9 [mem 0xa8e00000-0xa8efffff 64bit pref] released
[    0.425275] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.425297] release child resource [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.425298] pci 0000:20:02.0: resource 8 [mem 0xa8f00000-0xa8ffffff] released
[    0.425301] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.425311] release child resource [mem 0xa9000000-0xa90fffff]
[    0.425312] pci 0000:1f:00.0: resource 8 [mem 0xa8d00000-0xa91fffff] released
[    0.425314] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.425325] pci 0000:19:04.0: resource 8 [mem 0xa8d00000-0xa91fffff] released
[    0.425328] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.425335] release child resource [mem 0xa8c00000-0xa8c00fff]
[    0.425336] release child resource [mem 0xa8c01000-0xa8c01fff]
[    0.425337] release child resource [mem 0xa8c02000-0xa8c020ff]
[    0.425337] pci 0000:1b:03.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425340] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.425350] pci 0000:1a:00.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425352] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.425362] pci 0000:19:00.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425364] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.425372] release child resource [mem 0xa9200000-0xa920ffff 64bit pref]
[    0.425373] release child resource [mem 0xa9210000-0xa921ffff 64bit pref]
[    0.425374] pci 0000:19:01.0: resource 9 [mem 0xa9200000-0xa92fffff 64bit pref] released
[    0.425377] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.425393] release child resource [mem 0xa9400000-0xa9400fff 64bit]
[    0.425394] pci 0000:19:02.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.425396] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.425404] release child resource [mem 0xa9300000-0xa93fffff]
[    0.425405] pci 0000:18:00.0: resource 8 [mem 0xa8c00000-0xa94fffff] released
[    0.425407] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.425416] pci 0000:06:04.0: resource 8 [mem 0xa8c00000-0xa94fffff] released
[    0.425418] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.425423] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.425424] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.425425] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.425427] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.425433] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xa96fffff] released
[    0.425435] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.425442] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xad6fffff] released
[    0.425444] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.425448] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425449] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.425452] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425456] release child resource [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.425456] release child resource [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.425457] pci 0000:00:1c.0: resource 9 [mem 0xa8400000-0xa84fffff 64bit pref] released
[    0.425460] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.425467] release child resource [mem 0xa8600000-0xa861ffff 64bit]
[    0.425467] release child resource [mem 0xa8620000-0xa862ffff pref]
[    0.425468] pci 0000:00:1c.1: resource 8 [mem 0xa8600000-0xa86fffff] released
[    0.425471] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.425475] release child resource [mem 0xa8500000-0xa8500fff 64bit]
[    0.425475] pci 0000:00:1c.2: resource 8 [mem 0xa8500000-0xa85fffff] released
[    0.425478] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.425491] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425495] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.425498] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.425501] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.425504] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.425508] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.425511] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.425514] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425523] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425525] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.425528] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.425531] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425535] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.425551] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.425567] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.425572] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.425576] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.425583] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.425598] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.425601] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.425605] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.425613] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.425629] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.425634] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.425642] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.425645] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.425648] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.425651] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.425654] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.425657] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425660] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425663] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.425666] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.425669] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.425672] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.425675] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425677] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425680] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.425683] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425686] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425689] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.425696] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.425702] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.425709] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.425721] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.425725] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.425732] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.425744] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.425747] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.425750] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.425753] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425756] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.425759] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.425762] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.425765] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.425767] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.425770] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.425773] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.425776] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.425779] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425781] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425785] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425787] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425790] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.425801] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.425811] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.425821] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.425834] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425859] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.425873] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425898] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.425909] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425928] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.425959] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.425990] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.426000] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.426008] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.426023] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.426053] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.426064] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.426083] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.426086] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.426089] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.426093] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426095] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.426098] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.426101] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.426104] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.426107] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.426109] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.426112] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.426115] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.426118] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.426121] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.426124] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426127] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426129] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.426142] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.426155] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.426168] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.426185] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426218] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.426235] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426268] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.426282] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426309] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.426349] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.426388] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.426403] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.426413] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.426433] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.426472] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.426487] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.426514] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.426520] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.426534] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.426561] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.426567] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.426606] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.426613] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.426627] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.426654] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.426659] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.426669] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.426689] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.426694] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.426721] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.426726] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.426737] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.426756] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.426759] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.426766] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.426778] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.426782] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.426789] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.426801] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.426804] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.426811] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.426823] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.426826] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.426833] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.426845] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.426848] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.426853] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.426860] pci_bus 0000:00: No. 5 try to assign unassigned res
[    0.426863] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.426863] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.426864] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.426865] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426867] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.426879] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426882] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.426894] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426897] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.426907] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.426908] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.426909] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.426912] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.426934] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.426935] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.426938] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.426948] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.426950] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.426960] release child resource [mem 0xb1000000-0xb10fffff]
[    0.426961] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.426964] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.426974] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.426977] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.426984] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.426985] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.426986] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.426987] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426989] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.426999] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427001] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427011] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427013] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427021] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427022] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427023] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427026] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427042] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427043] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427045] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427053] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427054] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427056] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427064] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427067] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427072] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427073] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427074] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427076] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427081] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427084] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427089] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427092] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427097] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427099] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427105] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427107] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427113] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427116] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427120] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427121] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427124] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427127] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427128] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427129] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427132] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427138] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427139] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427140] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427142] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427146] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427147] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427149] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427161] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427165] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427168] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427171] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427174] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427178] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427181] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427184] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427192] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427195] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427198] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427201] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427205] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427221] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427236] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427241] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427245] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427252] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427267] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427270] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427275] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427283] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427299] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427303] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427311] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427314] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427317] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427321] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427324] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427326] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427329] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427335] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427338] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427341] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427344] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427347] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427350] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427352] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427355] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427359] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427365] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427372] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427378] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427387] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427387] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427387] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427387] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427387] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427387] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427387] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427387] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427387] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427387] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427387] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427387] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427387] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427387] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427387] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427387] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427387] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427387] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427387] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427387] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427387] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427387] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427387] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427387] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427387] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427387] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427387] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427387] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427387] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427387] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427387] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427387] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427387] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427387] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427387] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427387] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427387] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427387] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427387] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427387] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427387] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427387] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427387] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427387] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427387] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427387] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427387] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427387] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427387] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427387] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427387] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427387] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427387] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427387] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427387] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427387] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427387] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427387] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427387] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427387] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427387] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427387] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427387] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427387] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci_bus 0000:00: No. 6 try to assign unassigned res
[    0.427387] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427387] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427387] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427387] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427387] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427387] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427387] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427387] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427387] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427387] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427387] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427387] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427387] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427387] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427387] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427387] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427387] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427387] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427387] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427387] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427387] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427387] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427387] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427387] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427387] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427387] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427387] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427387] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427387] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427387] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427387] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427387] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427387] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427387] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427387] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427387] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427387] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427387] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427387] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427387] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427387] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427387] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427387] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427387] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427387] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427387] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427387] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427387] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427387] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427387] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427387] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427387] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427387] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427387] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427387] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427387] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427387] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427387] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427387] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427387] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427387] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427387] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427387] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427387] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427387] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427387] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427387] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427387] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427387] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427387] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427387] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427387] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427387] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427387] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427387] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427387] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427387] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427387] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427387] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427387] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427387] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427387] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427387] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427387] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427387] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427387] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427387] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427387] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427387] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427387] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427387] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427387] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427387] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427387] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427387] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427387] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427387] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427387] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427387] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427387] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427387] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427387] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427387] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427387] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427387] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427387] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427387] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427387] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427387] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427387] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427387] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427387] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427387] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427387] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427387] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427387] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427387] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427387] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427387] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427387] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427387] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427387] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427387] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427387] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427387] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427387] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427387] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427387] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427387] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427387] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427387] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427387] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427387] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427387] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427387] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427387] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427387] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427387] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427387] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427387] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427387] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427387] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427387] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427387] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427387] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427387] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427387] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427387] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427387] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427387] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427387] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427387] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427387] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427387] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427387] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427387] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427387] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427387] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427387] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci_bus 0000:00: No. 7 try to assign unassigned res
[    0.427387] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427387] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427387] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427387] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427387] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427387] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427387] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427387] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427387] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427387] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427387] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427387] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427387] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427387] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427387] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427387] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427387] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427387] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427387] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427387] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427387] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427387] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427387] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427387] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427387] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427387] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427387] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427387] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427387] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427387] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427387] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427387] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427387] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427387] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427387] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427387] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427387] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427387] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427387] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427387] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427387] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427387] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427387] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427387] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427387] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427387] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427387] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427387] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427387] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427387] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427387] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427387] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427387] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427387] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427387] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427387] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427387] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427387] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427387] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427387] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427387] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427387] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427387] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427387] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427387] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427387] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427387] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427387] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427387] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427387] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427387] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427387] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427387] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427387] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427387] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427387] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427387] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427387] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427387] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427387] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427387] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427387] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427387] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427387] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427387] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427387] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427387] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427387] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427387] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427387] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427387] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427387] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427387] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427387] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427387] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427387] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427387] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427387] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427387] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427387] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427387] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427387] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427387] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427387] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427387] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427387] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427387] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427387] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427387] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427387] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427387] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427387] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427387] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427387] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427387] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427387] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427387] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427387] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427387] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427387] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427387] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427387] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427387] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427387] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427387] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427387] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427387] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427387] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427387] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427387] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427387] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427387] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427387] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427387] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427387] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427387] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427387] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427387] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427387] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427387] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427387] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427387] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427387] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427387] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427387] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427387] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427387] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427387] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427387] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427387] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427387] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427387] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427387] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427387] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427387] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427387] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427387] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427387] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427387] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci_bus 0000:00: No. 8 try to assign unassigned res
[    0.427387] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427387] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427387] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427387] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427387] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427387] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427387] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427387] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427387] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427387] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427387] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427387] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427387] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427387] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427387] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427387] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427387] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427387] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427387] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427387] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427387] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427387] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427387] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427387] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427387] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427387] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427387] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427387] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427387] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427387] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427387] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427387] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427387] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427387] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427387] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427387] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427387] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427387] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427387] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427387] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427387] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427387] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427387] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427387] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427387] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427387] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427387] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427387] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427387] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427387] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427387] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427387] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427387] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427387] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427387] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427387] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427387] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427387] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427387] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427387] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427387] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427387] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427387] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427387] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427387] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427387] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427387] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427387] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427387] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427387] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427387] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427387] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427387] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427387] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427387] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427387] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427387] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427387] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427387] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427387] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427387] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427387] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427387] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427387] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427387] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427387] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427387] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427387] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427387] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427387] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427387] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427387] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427387] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427387] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427387] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427387] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427387] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427387] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427387] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427387] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427387] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427387] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427387] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427387] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427387] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427387] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427387] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427387] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427387] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427387] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427387] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427387] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427387] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427387] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427387] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427387] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427387] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427387] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427387] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427387] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427387] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427387] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427387] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427387] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427387] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427387] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427387] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427387] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427387] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427387] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427387] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427387] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427387] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427387] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427387] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427387] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427387] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427387] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427387] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427387] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427387] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427387] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427387] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427387] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427387] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427387] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427387] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427387] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427387] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427387] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427387] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427387] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427387] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427387] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427387] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.433364] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.433369] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.433397] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.433402] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.433413] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.433432] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.433435] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.433442] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.433454] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.433458] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.433465] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.433476] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.433480] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.433487] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.433499] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.433503] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.433509] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.433521] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.433524] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.433529] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.433537] pci_bus 0000:00: No. 9 try to assign unassigned res
[    0.433539] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.433540] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.433540] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.433541] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433544] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.433556] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433559] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.433571] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433573] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.433583] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.433584] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.433585] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.433588] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.433611] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.433612] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.433614] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.433624] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.433627] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.433637] release child resource [mem 0xb1000000-0xb10fffff]
[    0.433638] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.433641] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.433651] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.433654] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.433661] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.433662] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.433663] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.433664] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433666] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.433676] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433678] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.433688] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433690] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.433698] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.433699] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.433700] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.433703] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.433719] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.433720] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.433722] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.433730] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.433731] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.433733] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.433742] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.433744] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.433749] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.433750] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.433751] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.433753] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.433759] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.433761] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.433767] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.433769] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.433774] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.433777] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.433782] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.433785] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.433791] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.433793] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.433797] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433798] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.433801] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433804] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.433805] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.433806] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.433809] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.433815] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.433816] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.433817] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.433820] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.433823] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.433824] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.433827] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.433846] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433852] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.433857] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.433862] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.433867] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.433871] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.433874] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.433883] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433892] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433895] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.433898] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.433901] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433905] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.433921] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.433937] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.433941] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.433946] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.433952] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.433967] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.433970] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.433974] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.433983] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.433999] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.434003] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.434011] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.434014] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.434017] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.434021] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.434023] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.434026] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434029] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434032] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.434035] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.434038] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.434041] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.434044] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434046] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434049] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.434052] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434055] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434058] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.434065] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.434071] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.434078] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.434090] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.434094] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.434101] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.434113] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.434115] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.434118] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.434122] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434125] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.434127] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.434130] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.434133] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.434136] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.434139] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.434142] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.434144] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.434147] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434150] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434153] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434156] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434159] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.434169] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.434179] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.434189] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.434202] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434227] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.434241] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434266] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.434277] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434296] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.434327] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.434357] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.434368] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.434376] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.434391] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.434421] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.434432] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.434452] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.434454] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.434457] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.434461] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434463] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.434466] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.434469] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.434472] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.434475] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434478] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434481] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.434483] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.434486] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434489] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434492] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434495] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434498] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.434511] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.434523] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.434536] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.434553] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434586] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.434603] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434636] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.434650] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434678] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.434717] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.434757] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.434771] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.434782] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.434801] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.434841] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.434855] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.434882] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.434888] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.434903] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.434930] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.434936] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.434975] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.434981] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.434996] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.435022] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.435027] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.435038] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.435057] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.435062] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.435090] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.435095] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.435105] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.435124] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.435128] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.435135] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.435147] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.435151] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.435157] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.435169] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.435173] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.435180] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.435192] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.435195] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.435202] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.435213] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.435216] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.435221] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.435229] pci_bus 0000:00: No. 10 try to assign unassigned res
[    0.435232] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.435232] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.435233] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.435234] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435236] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.435249] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435251] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.435263] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435266] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.435276] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.435277] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.435278] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.435281] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.435303] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.435304] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.435307] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.435317] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.435319] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.435330] release child resource [mem 0xb1000000-0xb10fffff]
[    0.435331] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.435333] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.435344] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.435346] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.435354] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.435354] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.435355] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.435356] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435358] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.435368] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435371] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.435380] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435383] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.435390] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.435391] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.435392] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.435395] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.435411] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.435412] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.435414] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.435422] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.435423] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.435426] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.435434] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.435436] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.435441] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.435442] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.435443] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.435446] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.435451] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.435453] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.435459] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.435461] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.435467] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.435469] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.435474] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.435477] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.435483] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.435485] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.435489] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435490] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.435493] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.435497] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.435497] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.435498] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.435501] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.435508] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.435508] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.435509] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.435512] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.435516] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.435516] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.435519] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.435532] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435536] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.435539] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.435541] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.435544] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.435548] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.435551] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.435555] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435563] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.435565] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.435568] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.435571] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435575] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.435591] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.435606] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.435611] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.435615] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.435622] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.435637] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.435640] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.435644] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.435652] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.435668] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.435673] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.435681] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.435684] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.435687] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.435691] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.435693] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.435696] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435699] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435702] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.435705] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.435708] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.435711] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.435713] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435716] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435719] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.435722] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435725] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435728] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.435735] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.435741] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.435748] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.435760] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.435763] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.435770] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.435783] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.435785] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.435788] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.435792] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435794] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.435797] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.435800] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.435803] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.435806] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.435809] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.435812] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.435814] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.435817] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435820] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435823] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435826] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435829] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.435839] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.435849] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.435859] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.435873] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435898] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.435911] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435936] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.435947] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435966] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.435997] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.436028] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.436038] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.436046] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.436061] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.436091] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.436102] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.436121] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.436124] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.436127] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.436130] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436133] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.436136] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436139] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.436141] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.436144] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.436147] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.436150] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.436153] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.436155] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.436158] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.436161] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436164] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436167] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.436180] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.436193] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.436205] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.436223] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436255] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.436273] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436305] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.436320] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436347] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.436386] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.436426] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.436440] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.436451] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436470] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.436510] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.436524] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.436551] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.436557] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.436572] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.436599] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.436605] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.436644] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.436651] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.436665] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.436692] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.436697] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.436707] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.436727] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.436732] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.436759] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.436764] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.436775] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.436794] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.436798] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.436805] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.436816] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.436820] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.436827] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.436839] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.436843] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.436849] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.436861] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.436865] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.436872] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.436883] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.436886] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.436891] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.436899] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.436902] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.436904] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.436907] pci_bus 0000:00: resource 7 [mem 0x8f900000-0xfeafffff window]
[    0.436909] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff window]
[    0.436912] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.436914] pci_bus 0000:01: resource 1 [mem 0xa8800000-0xa88fffff]
[    0.436916] pci_bus 0000:01: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.436919] pci_bus 0000:02: resource 1 [mem 0xa8700000-0xa87fffff]
[    0.436921] pci_bus 0000:02: resource 2 [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.436924] pci_bus 0000:03: resource 1 [mem 0x8fa00000-0x8fafffff]
[    0.436927] pci_bus 0000:04: resource 1 [mem 0x8fb00000-0x8fbfffff]
[    0.436929] pci_bus 0000:05: resource 0 [io  0x4000-0xbfff]
[    0.436931] pci_bus 0000:05: resource 1 [mem 0xa8a00000-0xd90fffff]
[    0.436933] pci_bus 0000:06: resource 0 [io  0x4000-0xbfff]
[    0.436936] pci_bus 0000:06: resource 1 [mem 0xa8a00000-0xd90fffff]
[    0.436938] pci_bus 0000:07: resource 1 [mem 0xa8a00000-0xa8afffff]
[    0.436940] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    0.436943] pci_bus 0000:08: resource 1 [mem 0xa8b00000-0xb0afffff]
[    0.436945] pci_bus 0000:18: resource 0 [io  0x5000-0x9fff]
[    0.436947] pci_bus 0000:18: resource 1 [mem 0xb0b00000-0xc90fffff]
[    0.436949] pci_bus 0000:19: resource 0 [io  0x5000-0x8fff]
[    0.436952] pci_bus 0000:19: resource 1 [mem 0xb0b00000-0xc90fffff]
[    0.436954] pci_bus 0000:1a: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436956] pci_bus 0000:1b: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436959] pci_bus 0000:1c: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436961] pci_bus 0000:1d: resource 1 [mem 0xb0c00000-0xb0cfffff]
[    0.436963] pci_bus 0000:1d: resource 2 [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.436966] pci_bus 0000:1e: resource 1 [mem 0xb0e00000-0xb0efffff]
[    0.436968] pci_bus 0000:1f: resource 0 [io  0x5000-0x7fff]
[    0.436971] pci_bus 0000:1f: resource 1 [mem 0xb0f00000-0xc11fffff]
[    0.436973] pci_bus 0000:20: resource 0 [io  0x5000-0x6fff]
[    0.436975] pci_bus 0000:20: resource 1 [mem 0xb0f00000-0xc11fffff]
[    0.436977] pci_bus 0000:21: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436980] pci_bus 0000:22: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436982] pci_bus 0000:23: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436984] pci_bus 0000:24: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.436987] pci_bus 0000:24: resource 2 [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436989] pci_bus 0000:25: resource 1 [mem 0xb1200000-0xb12fffff]
[    0.436992] pci_bus 0000:26: resource 0 [io  0x5000-0x5fff]
[    0.436994] pci_bus 0000:26: resource 1 [mem 0xb1300000-0xb92fffff]
[    0.436996] pci_bus 0000:36: resource 0 [io  0x6000-0x6fff]
[    0.436999] pci_bus 0000:46: resource 0 [io  0x8000-0x8fff]
[    0.437001] pci_bus 0000:56: resource 0 [io  0xa000-0xafff]
[    0.437003] pci_bus 0000:56: resource 1 [mem 0xc9100000-0xd10fffff]
[    0.437005] pci_bus 0000:66: resource 0 [io  0xb000-0xbfff]
[    0.437008] pci_bus 0000:66: resource 1 [mem 0xd1100000-0xd90fffff]
[    0.437443] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.437459] pci 0000:05:00.0: CLS mismatch (256 != 128), using 64 bytes
[    0.437472] pci 0000:1c:00.0: MSI is not implemented on this device, disabling it
[    0.437474] pci 0000:1c:00.0: PME# is unreliable, disabling it
[    0.437767] pci 0000:1c:00.1: MSI is not implemented on this device, disabling it
[    0.437771] pci 0000:1c:00.1: PME# is unreliable, disabling it
[    0.437849] pci 0000:1c:00.2: MSI is not implemented on this device, disabling it
[    0.437852] pci 0000:1c:00.2: PME# is unreliable, disabling it
[    0.437907] pci 0000:1c:00.2: EHCI: unrecognized capability 00
[    0.437945] pci 0000:23:00.0: MSI is not implemented on this device, disabling it
[    0.437948] pci 0000:23:00.0: PME# is unreliable, disabling it
[    0.438201] pci 0000:23:00.1: MSI is not implemented on this device, disabling it
[    0.438204] pci 0000:23:00.1: PME# is unreliable, disabling it
[    0.438298] pci 0000:23:00.2: MSI is not implemented on this device, disabling it
[    0.438301] pci 0000:23:00.2: PME# is unreliable, disabling it
[    0.438367] pci 0000:23:00.2: EHCI: unrecognized capability 00
[    0.438407] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.438410] software IO TLB: mapped [mem 0x0000000083000000-0x0000000087000000] (64MB)
[    0.438417] ACPI: bus type thunderbolt registered
[    0.438435] Trying to unpack rootfs image as initramfs...
[    0.438504] thunderbolt 0000:07:00.0: total paths: 32
[    0.438680] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.438698] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.438711] thunderbolt 0000:07:00.0: control channel created
[    0.438714] thunderbolt 0000:07:00.0: ICM not supported on this controller
[    0.438723] thunderbolt 0000:07:00.0: freeing RX ring 0
[    0.438729] thunderbolt 0000:07:00.0: freeing TX ring 0
[    0.438739] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.438747] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.438756] thunderbolt 0000:07:00.0: control channel created
[    0.438757] thunderbolt 0000:07:00.0: using software connection manager
[    0.438772] thunderbolt 0000:07:00.0: created link from 0000:06:03.0
[    0.438799] thunderbolt 0000:07:00.0: created link from 0000:06:04.0
[    0.438810] thunderbolt 0000:07:00.0: created link from 0000:06:05.0
[    0.438824] thunderbolt 0000:07:00.0: created link from 0000:06:06.0
[    0.438879] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[    0.438881] thunderbolt 0000:07:00.0: control channel starting...
[    0.438882] thunderbolt 0000:07:00.0: starting TX ring 0
[    0.438890] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.438892] thunderbolt 0000:07:00.0: starting RX ring 0
[    0.438900] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38204 bit 0 (0x0 -> 0x1)
[    0.438903] thunderbolt 0000:07:00.0: security level set to user
[    0.439059] thunderbolt 0000:07:00.0: current switch config:
[    0.439061] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.439063] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.439064] thunderbolt 0000:07:00.0:   Config:
[    0.439065] thunderbolt 0000:07:00.0:    Upstream Port Number: 6 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.439067] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.443668] thunderbolt 0000:07:00.0: initializing Switch at 0x0 (depth: 0, up port: 6)
[    0.444179] thunderbolt 0000:07:00.0: 0: DROM version: 1
[    0.445714] thunderbolt 0000:07:00.0: 0: uid: 0x1000a13f2da20
[    0.448658] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.448661] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.448662] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.448664] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.448665] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.451602] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.451604] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.451605] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.451606] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.451607] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.454546] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.454548] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.454549] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.454550] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.454551] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.455186] random: fast init done
[    0.457491] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.457492] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.457493] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.457494] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.457495] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.457496] thunderbolt 0000:07:00.0: 0:5: disabled by eeprom
[    0.458387] thunderbolt 0000:07:00.0:  Port 6: 8086:1513 (Revision: 2, TB Version: 1, Type: NHI (0x2))
[    0.458388] thunderbolt 0000:07:00.0:   Max hop id (in/out): 31/31
[    0.458390] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.458390] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.458391] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.459283] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.459285] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.459286] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.459287] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.459288] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.460179] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.460181] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.460182] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.460182] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.460183] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.461075] thunderbolt 0000:07:00.0:  Port 9: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.461077] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.461078] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.461079] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.461080] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.461971] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.461973] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.461974] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.461975] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.461976] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.463123] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    0.463125] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.463126] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.463127] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.463128] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.464019] thunderbolt 0000:07:00.0:  Port 12: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.464022] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.464023] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.464023] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.464024] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.464915] thunderbolt 0000:07:00.0:  Port 13: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.464917] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.464918] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.464919] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.464920] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.480715] thunderbolt 0000:07:00.0: 0: TMU: current mode: HiFi
[    0.480843] thunderbolt 0000:07:00.0: 0:1: is unplugged (state: 7)
[    0.480970] thunderbolt 0000:07:00.0: 0:3: is connected, link is up (state: 2)
[    0.481227] thunderbolt 0000:07:00.0: current switch config:
[    0.481228] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.481229] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.481230] thunderbolt 0000:07:00.0:   Config:
[    0.481231] thunderbolt 0000:07:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1, PlugEventsDelay: 255ms
[    0.481233] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.485836] thunderbolt 0000:07:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[    0.503245] thunderbolt 0000:07:00.0: 3: reading drom (length: 0x97)
[    0.708197] Freeing initrd memory: 27904K
[    0.996984] thunderbolt 0000:07:00.0: 3: DROM version: 1
[    0.998008] thunderbolt 0000:07:00.0: 3: uid: 0x1000100189170
[    1.000951] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.000956] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.000958] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.000960] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.000963] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.003895] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.003899] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.003901] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.003903] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.003906] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.006839] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.006843] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.006845] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.006847] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.006849] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.009783] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.009787] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.009789] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.009791] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.009793] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.009795] thunderbolt 0000:07:00.0: 3:5: disabled by eeprom
[    1.009798] thunderbolt 0000:07:00.0: 3:6: disabled by eeprom
[    1.010680] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.010683] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.010686] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.010688] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.010690] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.011576] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.011579] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.011581] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.011583] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.011585] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.011587] thunderbolt 0000:07:00.0: 3:9: disabled by eeprom
[    1.012472] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.012475] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.012478] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.012479] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.012481] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.013624] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.013628] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.013630] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.013632] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.013634] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.013636] thunderbolt 0000:07:00.0: 3:c: disabled by eeprom
[    1.013638] thunderbolt 0000:07:00.0: 3:d: disabled by eeprom
[    1.031902] thunderbolt 0000:07:00.0: 3: TMU: current mode: bi-directional, HiFi
[    1.031934] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[    1.031942] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[    1.032038] thunderbolt 0000:07:00.0: 3:3: is connected, link is up (state: 2)
[    1.032296] thunderbolt 0000:07:00.0: current switch config:
[    1.032299] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    1.032302] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    1.032304] thunderbolt 0000:07:00.0:   Config:
[    1.032306] thunderbolt 0000:07:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x303 Enabled: 1, PlugEventsDelay: 255ms
[    1.032310] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.036907] thunderbolt 0000:07:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[    1.054314] thunderbolt 0000:07:00.0: 303: reading drom (length: 0x97)
[    1.309313] random: crng init done
[    1.548051] thunderbolt 0000:07:00.0: 303: DROM version: 1
[    1.549076] thunderbolt 0000:07:00.0: 303: uid: 0x100010102a740
[    1.552019] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.552023] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.552026] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.552028] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.552030] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.554963] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.554967] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.554969] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.554971] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.554973] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.557907] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.557911] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.557913] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.557915] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.557917] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.560852] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.560855] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.560857] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.560859] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.560861] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.560864] thunderbolt 0000:07:00.0: 303:5: disabled by eeprom
[    1.560866] thunderbolt 0000:07:00.0: 303:6: disabled by eeprom
[    1.561748] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.561751] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.561754] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.561756] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.561758] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.562644] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.562648] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.562650] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.562652] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.562654] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.562656] thunderbolt 0000:07:00.0: 303:9: disabled by eeprom
[    1.563540] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.563544] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.563546] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.563548] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.563550] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.564692] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.564696] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.564698] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.564700] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.564702] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.564704] thunderbolt 0000:07:00.0: 303:c: disabled by eeprom
[    1.564706] thunderbolt 0000:07:00.0: 303:d: disabled by eeprom
[    1.582632] thunderbolt 0000:07:00.0: 303: TMU: current mode: bi-directional, HiFi
[    1.582652] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[    1.582659] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[    1.582757] thunderbolt 0000:07:00.0: 303:1: is unplugged (state: 7)
[    1.583015] thunderbolt 0000:07:00.0: 303:b: DP adapter HPD set, queuing hotplug
[    1.583271] thunderbolt 0000:07:00.0: 3:b: DP adapter HPD set, queuing hotplug
[    1.583783] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 0:7
[    1.583912] thunderbolt 0000:07:00.0: 0:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.583916] thunderbolt 0000:07:00.0: 0:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.583919] thunderbolt 0000:07:00.0: 0:7:    Counter enabled: 1 Counter index: 0
[    1.583922] thunderbolt 0000:07:00.0: 0:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.583925] thunderbolt 0000:07:00.0: 0:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.584040] thunderbolt 0000:07:00.0: 3:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.584043] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.584046] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 1 Counter index: 0
[    1.584049] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.584051] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.584055] thunderbolt 0000:07:00.0: path discovery complete
[    1.584551] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 3:10
[    1.584679] thunderbolt 0000:07:00.0: 3:a:  In HopID: 8 => Out port: 1 Out HopID: 8
[    1.584683] thunderbolt 0000:07:00.0: 3:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.584686] thunderbolt 0000:07:00.0: 3:a:    Counter enabled: 1 Counter index: 0
[    1.584688] thunderbolt 0000:07:00.0: 3:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.584691] thunderbolt 0000:07:00.0: 3:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.584808] thunderbolt 0000:07:00.0: 0:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[    1.584811] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.584814] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 1 Counter index: 0
[    1.584816] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.584819] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.584822] thunderbolt 0000:07:00.0: path discovery complete
[    1.584936] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): discovered
[    1.585959] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 3:7
[    1.586088] thunderbolt 0000:07:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.586091] thunderbolt 0000:07:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.586094] thunderbolt 0000:07:00.0: 3:7:    Counter enabled: 1 Counter index: 0
[    1.586096] thunderbolt 0000:07:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.586099] thunderbolt 0000:07:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.586215] thunderbolt 0000:07:00.0: 303:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.586219] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.586222] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 1 Counter index: 0
[    1.586225] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.586228] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.586230] thunderbolt 0000:07:00.0: path discovery complete
[    1.586727] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 303:10
[    1.586855] thunderbolt 0000:07:00.0: 303:a:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.586858] thunderbolt 0000:07:00.0: 303:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.586861] thunderbolt 0000:07:00.0: 303:a:    Counter enabled: 1 Counter index: 0
[    1.586864] thunderbolt 0000:07:00.0: 303:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.586867] thunderbolt 0000:07:00.0: 303:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.586983] thunderbolt 0000:07:00.0: 3:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[    1.586986] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.586989] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 1 Counter index: 0
[    1.586992] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.586995] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.586997] thunderbolt 0000:07:00.0: path discovery complete
[    1.587111] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): discovered
[    1.587498] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.587500] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
[    1.587623] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[    1.587627] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[    1.587689] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
[    1.587693] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    1.587695] RAPL PMU: hw unit of domain package 2^-16 Joules
[    1.587697] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[    1.587751] thunderbolt 0000:07:00.0: 0:c: DP IN available
[    1.587878] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[    1.587881] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 12
[    1.587883] thunderbolt 0000:07:00.0: 303:b: calculating available bandwidth
[    1.588006] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[    1.588010] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[    1.588132] Initialise system trusted keyrings
[    1.588134] thunderbolt 0000:07:00.0: 3:3: link total bandwidth 9000 Mb/s
[    1.588137] thunderbolt 0000:07:00.0: 303:3: link total bandwidth 9000 Mb/s
[    1.588139] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    1.588144] thunderbolt 0000:07:00.0: 0:c <-> 303:b (DP): activating
[    1.588146] thunderbolt 0000:07:00.0: activating Video path from 0:12 to 303:11
[    1.588148] thunderbolt 0000:07:00.0: 303:4: adding 12 NFC credits to 0
[    1.588156] workingset: timestamp_bits=62 max_order=23 bucket_order=0
[    1.588260] thunderbolt 0000:07:00.0: 3:2: adding 12 NFC credits to 0
[    1.588388] thunderbolt 0000:07:00.0: 0:c: adding 5 NFC credits to 0
[    1.588644] thunderbolt 0000:07:00.0: 303:4: Writing hop 2
[    1.588645] thunderbolt 0000:07:00.0: 303:4:  In HopID: 8 => Out port: 11 Out HopID: 9
[    1.588647] thunderbolt 0000:07:00.0: 303:4:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.588648] thunderbolt 0000:07:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[    1.588650] thunderbolt 0000:07:00.0: 303:4:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.588651] thunderbolt 0000:07:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.588860] Key type asymmetric registered
[    1.588864] Asymmetric key parser 'x509' registered
[    1.588875] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    1.588901] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[    1.588902] thunderbolt 0000:07:00.0: 3:2:  In HopID: 8 => Out port: 4 Out HopID: 8
[    1.588904] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.588905] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[    1.588907] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.588908] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.589156] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[    1.589158] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 4 Out HopID: 8
[    1.589159] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.589161] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[    1.589162] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.589163] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.589284] thunderbolt 0000:07:00.0: path activation complete
[    1.589285] thunderbolt 0000:07:00.0: activating AUX TX path from 0:12 to 303:11
[    1.589412] thunderbolt 0000:07:00.0: 303:4: Writing hop 2
[    1.589413] thunderbolt 0000:07:00.0: 303:4:  In HopID: 9 => Out port: 11 Out HopID: 8
[    1.589415] thunderbolt 0000:07:00.0: 303:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.589416] thunderbolt 0000:07:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[    1.589417] thunderbolt 0000:07:00.0: 303:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.589419] thunderbolt 0000:07:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.589668] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[    1.589670] thunderbolt 0000:07:00.0: 3:2:  In HopID: 9 => Out port: 4 Out HopID: 9
[    1.589671] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.589673] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[    1.589674] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.589675] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.589717] pcieport 0000:06:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.589910] pcieport 0000:06:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.589928] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[    1.589931] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 4 Out HopID: 9
[    1.589934] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.589936] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[    1.589938] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.589940] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.590052] thunderbolt 0000:07:00.0: path activation complete
[    1.590054] thunderbolt 0000:07:00.0: activating AUX RX path from 303:11 to 0:12
[    1.590123] pcieport 0000:06:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.590182] thunderbolt 0000:07:00.0: 0:4: Writing hop 2
[    1.590184] thunderbolt 0000:07:00.0: 0:4:  In HopID: 8 => Out port: 12 Out HopID: 8
[    1.590185] thunderbolt 0000:07:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.590187] thunderbolt 0000:07:00.0: 0:4:    Counter enabled: 0 Counter index: 2047
[    1.590188] thunderbolt 0000:07:00.0: 0:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.590189] thunderbolt 0000:07:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.590336] pcieport 0000:06:06.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.590437] thunderbolt 0000:07:00.0: 3:4: Writing hop 1
[    1.590439] thunderbolt 0000:07:00.0: 3:4:  In HopID: 8 => Out port: 2 Out HopID: 8
[    1.590440] thunderbolt 0000:07:00.0: 3:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.590441] thunderbolt 0000:07:00.0: 3:4:    Counter enabled: 0 Counter index: 2047
[    1.590443] thunderbolt 0000:07:00.0: 3:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.590444] thunderbolt 0000:07:00.0: 3:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.590693] thunderbolt 0000:07:00.0: 303:b: Writing hop 0
[    1.590694] thunderbolt 0000:07:00.0: 303:b:  In HopID: 8 => Out port: 4 Out HopID: 8
[    1.590695] thunderbolt 0000:07:00.0: 303:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.590697] thunderbolt 0000:07:00.0: 303:b:    Counter enabled: 0 Counter index: 2047
[    1.590698] thunderbolt 0000:07:00.0: 303:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.590699] thunderbolt 0000:07:00.0: 303:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.590822] thunderbolt 0000:07:00.0: path activation complete
[    1.591618] pcieport 0000:19:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.591826] pcieport 0000:19:05.0: enabling device (0000 -> 0001)
[    1.591845] thunderbolt 0000:07:00.0: Used link no : 1
[    1.591921] pcieport 0000:19:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.591974] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
[    1.591976] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[    1.592101] thunderbolt 0000:07:00.0: 0:c: in use
[    1.592228] thunderbolt 0000:07:00.0: 0:d: DP IN available
[    1.592356] thunderbolt 0000:07:00.0: 303:b: in use
[    1.592484] thunderbolt 0000:07:00.0: 3:b: DP OUT available
[    1.592486] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 13
[    1.592487] thunderbolt 0000:07:00.0: 3:b: calculating available bandwidth
[    1.592612] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[    1.592614] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[    1.592615] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    1.592619] thunderbolt 0000:07:00.0: 0:d <-> 3:b (DP): activating
[    1.592621] thunderbolt 0000:07:00.0: activating Video path from 0:13 to 3:11
[    1.592622] thunderbolt 0000:07:00.0: 3:1: adding 12 NFC credits to 0
[    1.592740] thunderbolt 0000:07:00.0: 0:d: adding 5 NFC credits to 0
[    1.592996] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[    1.592998] thunderbolt 0000:07:00.0: 3:1:  In HopID: 9 => Out port: 11 Out HopID: 9
[    1.592999] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.593000] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[    1.593002] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.593003] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.593253] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[    1.593254] thunderbolt 0000:07:00.0: 0:d:  In HopID: 9 => Out port: 3 Out HopID: 9
[    1.593255] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.593257] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[    1.593258] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.593259] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.593380] thunderbolt 0000:07:00.0: path activation complete
[    1.593381] thunderbolt 0000:07:00.0: activating AUX TX path from 0:13 to 3:11
[    1.593509] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[    1.593510] thunderbolt 0000:07:00.0: 3:1:  In HopID: 10 => Out port: 11 Out HopID: 8
[    1.593512] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.593513] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[    1.593514] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.593515] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.593764] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[    1.593766] thunderbolt 0000:07:00.0: 0:d:  In HopID: 8 => Out port: 3 Out HopID: 10
[    1.593767] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.593768] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[    1.593770] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.593771] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.593825] pcieport 0000:20:04.0: enabling device (0000 -> 0003)
[    1.593893] thunderbolt 0000:07:00.0: path activation complete
[    1.593894] thunderbolt 0000:07:00.0: activating AUX RX path from 3:11 to 0:13
[    1.593948] pcieport 0000:20:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.594021] thunderbolt 0000:07:00.0: 0:3: Writing hop 1
[    1.594023] thunderbolt 0000:07:00.0: 0:3:  In HopID: 9 => Out port: 13 Out HopID: 8
[    1.594024] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.594025] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[    1.594027] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.594028] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.594240] pcieport 0000:20:05.0: enabling device (0000 -> 0001)
[    1.594277] thunderbolt 0000:07:00.0: 3:b: Writing hop 0
[    1.594278] thunderbolt 0000:07:00.0: 3:b:  In HopID: 8 => Out port: 1 Out HopID: 9
[    1.594279] thunderbolt 0000:07:00.0: 3:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.594281] thunderbolt 0000:07:00.0: 3:b:    Counter enabled: 0 Counter index: 2047
[    1.594282] thunderbolt 0000:07:00.0: 3:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.594283] thunderbolt 0000:07:00.0: 3:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.594361] pcieport 0000:20:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.594406] thunderbolt 0000:07:00.0: path activation complete
[    1.595441] thunderbolt 0000:07:00.0: Used link no : 0
[    1.603740] brd: module loaded
[    1.603992] Intel(R) 2.5G Ethernet Linux Driver
[    1.603997] Copyright(c) 2018 Intel Corporation.
[    1.604054] i8042: PNP: No PS/2 controller found.
[    1.604086] mousedev: PS/2 mouse device common for all mice
[    1.604148] intel_pstate: Intel P-state driver initializing
[    1.604271] efifb: probing for efifb
[    1.604286] efifb: framebuffer at 0x90010000, using 14400k, total 14400k
[    1.604289] efifb: mode is 2560x1440x32, linelength=10240, pages=1
[    1.604291] efifb: scrolling: redraw
[    1.604292] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.613918] Console: switching to colour frame buffer device 320x90
[    1.623080] fb0: EFI VGA frame buffer device
[    1.623165] Key type dns_resolver registered
[    1.623218] microcode: sig=0x206a7, pf=0x2, revision=0x2f
[    1.623270] microcode: Microcode Update Driver: v2.2.
[    1.623273] IPI shorthand broadcast: enabled
[    1.623316] sched_clock: Marking stable (1622827346, 439879)->(1634544671, -11277446)
[    1.623388] registered taskstats version 1
[    1.623412] Loading compiled-in X.509 certificates
[    1.624537] Freeing unused kernel image (initmem) memory: 956K
[    1.673548] Write protecting the kernel read-only data: 12288k
[    1.674047] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.674178] Freeing unused kernel image (rodata/data gap) memory: 204K
[    1.674209] Run /init as init process
[    1.674224]   with arguments:
[    1.674225]     /init
[    1.674226]   with environment:
[    1.674226]     HOME=/
[    1.674227]     TERM=linux
[    1.674228]     netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da
[    1.718798] udevd[874]: starting version 3.2.9
[    1.719502] udevd[875]: starting eudev-3.2.9
[    1.733762] ACPI: bus type USB registered
[    1.733818] usbcore: registered new interface driver usbfs
[    1.733909] usbcore: registered new interface driver hub
[    1.733960] usbcore: registered new device driver usb
[    1.735822] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.735861] ACPI: bus type drm_connector registered
[    1.736160] ehci-pci: EHCI PCI platform driver
[    1.736350] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    1.736386] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    1.736436] ehci-pci 0000:00:1a.7: debug port 2
[    1.736524] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.737163] uhci_hcd: USB Universal Host Controller Interface driver
[    1.739643] cryptd: max_cpu_qlen set to 1000
[    1.740130] ahci 0000:00:1f.2: version 3.0
[    1.740379] ehci-pci 0000:00:1a.7: irq 23, io mem 0xa8906c00
[    1.741137] AVX version of gcm_enc/dec engaged.
[    1.741182] AES CTR mode by8 optimization enabled
[    1.747717] radeon: unknown parameter 'pm' ignored
[    1.747824] [drm] radeon kernel modesetting enabled.
[    1.747873] checking generic (90010000 e10000) vs hw (90000000 10000000)
[    1.747874] fb0: switching to radeon from EFI VGA
[    1.747956] Console: switching to colour dummy device 80x25
[    1.748019] radeon 0000:01:00.0: vgaarb: deactivate vga console
[    1.748171] [drm] initializing kernel modesetting (BARTS 0x1002:0x6720 0x106B:0x0B00 0x00).
[    1.750684] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x7 impl SATA mode
[    1.750694] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst
[    1.763453] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.763778] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.763784] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.763787] usb usb1: Product: EHCI Host Controller
[    1.763789] usb usb1: Manufacturer: Linux 5.17.1bkc1+ ehci_hcd
[    1.763792] usb usb1: SerialNumber: 0000:00:1a.7
[    1.763969] hub 1-0:1.0: USB hub found
[    1.763981] hub 1-0:1.0: 6 ports detected
[    1.764174] tg3 0000:02:00.0 eth0: Tigon3 [partno(BCM957765) rev 57785100] (PCI Express) MAC address 3c:07:54:14:b2:08
[    1.764184] tg3 0000:02:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.764192] tg3 0000:02:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.764198] tg3 0000:02:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.764372] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.764385] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 2
[    1.764430] uhci_hcd 0000:00:1a.0: detected 2 ports
[    1.764604] uhci_hcd 0000:00:1a.0: irq 21, io port 0x00003140
[    1.764761] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    1.764769] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.764775] usb usb2: Product: UHCI Host Controller
[    1.764779] usb usb2: Manufacturer: Linux 5.17.1bkc1+ uhci_hcd
[    1.764783] usb usb2: SerialNumber: 0000:00:1a.0
[    1.764880] hub 2-0:1.0: USB hub found
[    1.764892] hub 2-0:1.0: 2 ports detected
[    1.765269] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.765302] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 3
[    1.765489] ehci-pci 0000:00:1d.7: debug port 2
[    1.769560] ehci-pci 0000:00:1d.7: irq 22, io mem 0xa8906800
[    1.793404] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.793473] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.793477] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.793480] usb usb3: Product: EHCI Host Controller
[    1.793482] usb usb3: Manufacturer: Linux 5.17.1bkc1+ ehci_hcd
[    1.793484] usb usb3: SerialNumber: 0000:00:1d.7
[    1.793605] hub 3-0:1.0: USB hub found
[    1.793680] hub 3-0:1.0: 8 ports detected
[    1.794017] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.794025] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    1.794070] uhci_hcd 0000:00:1d.0: detected 2 ports
[    1.794210] uhci_hcd 0000:00:1d.0: irq 19, io port 0x000030e0
[    1.794331] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    1.794336] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.794339] usb usb4: Product: UHCI Host Controller
[    1.794341] usb usb4: Manufacturer: Linux 5.17.1bkc1+ uhci_hcd
[    1.794343] usb usb4: SerialNumber: 0000:00:1d.0
[    1.794434] hub 4-0:1.0: USB hub found
[    1.794499] hub 4-0:1.0: 2 ports detected
[    1.794769] ehci-pci 0000:1c:00.2: EHCI Host Controller
[    1.794779] ehci-pci 0000:1c:00.2: new USB bus registered, assigned bus number 5
[    1.795103] ehci-pci 0000:1c:00.2: irq 17, io mem 0xb0b02000
[    1.803709] firewire_ohci 0000:04:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    1.813900] scsi host0: ahci
[    1.814329] scsi host1: ahci
[    1.815268] scsi host2: ahci
[    1.816148] scsi host3: ahci
[    1.816999] scsi host4: ahci
[    1.817838] scsi host5: ahci
[    1.818277] ata1: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906100 irq 52
[    1.818347] ata2: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906180 irq 52
[    1.818379] ata3: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906200 irq 52
[    1.818408] ata4: DUMMY
[    1.818420] ata5: DUMMY
[    1.818447] ata6: DUMMY
[    1.833398] ehci-pci 0000:1c:00.2: USB 2.0 started, EHCI 1.00
[    1.833719] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.833725] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.833728] usb usb5: Product: EHCI Host Controller
[    1.833730] usb usb5: Manufacturer: Linux 5.17.1bkc1+ ehci_hcd
[    1.833732] usb usb5: SerialNumber: 0000:1c:00.2
[    1.833909] hub 5-0:1.0: USB hub found
[    1.833948] hub 5-0:1.0: 4 ports detected
[    1.834595] ehci-pci 0000:23:00.2: EHCI Host Controller
[    1.834601] ehci-pci 0000:23:00.2: new USB bus registered, assigned bus number 6
[    1.834977] ehci-pci 0000:23:00.2: irq 17, io mem 0xb0f02000
[    1.856608] tg3 0000:1d:00.0 eth1: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[    1.856620] tg3 0000:1d:00.0 eth1: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.856626] tg3 0000:1d:00.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.856632] tg3 0000:1d:00.0 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.863391] ehci-pci 0000:23:00.2: USB 2.0 started, EHCI 1.00
[    1.863747] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.863753] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.863756] usb usb6: Product: EHCI Host Controller
[    1.863758] usb usb6: Manufacturer: Linux 5.17.1bkc1+ ehci_hcd
[    1.863760] usb usb6: SerialNumber: 0000:23:00.2
[    1.863858] hub 6-0:1.0: USB hub found
[    1.863891] hub 6-0:1.0: 4 ports detected
[    1.873647] firewire_ohci 0000:1e:00.0: added OHCI v1.10 device as card 1, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    1.937666] tg3 0000:24:00.0 eth2: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[    1.937672] tg3 0000:24:00.0 eth2: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.937676] tg3 0000:24:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.937679] tg3 0000:24:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.953613] firewire_ohci 0000:25:00.0: added OHCI v1.10 device as card 2, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    2.073580] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    2.079213] ATOM BIOS: Apple
[    2.079378] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.079383] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    2.079389] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.079391] [drm] RAM width 256bits DDR
[    2.079405] [drm] radeon: 1024M of VRAM memory ready
[    2.079407] [drm] radeon: 1024M of GTT memory ready.
[    2.079411] [drm] Loading BARTS Microcode
[    2.079463] [drm] External GPIO thermal controller with fan control
[    2.079476] == power state 0 ==
[    2.079478] 	ui class: none
[    2.079479] 	internal class: boot
[    2.079482] 	caps:
[    2.079483] 	uvd    vclk: 0 dclk: 0
[    2.079485] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.079487] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.079489] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.079491] 	status: c r b
[    2.079493] == power state 1 ==
[    2.079495] 	ui class: performance
[    2.079496] 	internal class: none
[    2.079498] 	caps:
[    2.079499] 	uvd    vclk: 0 dclk: 0
[    2.079500] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.079502] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    2.079504] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.079506] 	status:
[    2.079507] == power state 2 ==
[    2.079509] 	ui class: none
[    2.079510] 	internal class: uvd
[    2.079511] 	caps: video
[    2.079513] 	uvd    vclk: 54000 dclk: 40000
[    2.079514] 		power level 0    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    2.079516] 		power level 1    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    2.079518] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.079520] 	status:
[    2.079521] == power state 3 ==
[    2.079523] 	ui class: none
[    2.079524] 	internal class: uvd_mvc
[    2.079525] 	caps: video
[    2.079527] 	uvd    vclk: 70000 dclk: 56000
[    2.079528] 		power level 0    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    2.079530] 		power level 1    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    2.079532] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.079534] 	status:
[    2.079535] == power state 4 ==
[    2.079536] 	ui class: battery
[    2.079537] 	internal class: none
[    2.079539] 	caps:
[    2.079540] 	uvd    vclk: 0 dclk: 0
[    2.079541] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.079543] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.079545] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.079547] 	status:
[    2.084407] [drm] radeon: dpm initialized
[    2.084462] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    2.084820] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    2.088483] [drm] PCIE GART of 1024M enabled (table at 0x0000000000162000).
[    2.088583] radeon 0000:01:00.0: WB enabled
[    2.088586] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00
[    2.088589] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c
[    2.089360] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118
[    2.089901] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    2.089938] radeon 0000:01:00.0: radeon: using MSI.
[    2.089967] [drm] radeon: irq initialized.
[    2.103377] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    2.106310] [drm] ring test on 0 succeeded in 3 usecs
[    2.106322] [drm] ring test on 3 succeeded in 7 usecs
[    2.143371] usb 5-1: new high-speed USB device number 2 using ehci-pci
[    2.144719] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.144740] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.146252] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.146312] ata1.00: supports DRM functions and may not be fully accessible
[    2.146317] ata1.00: ATA-9: Samsung SSD 850 PRO 256GB, EXM03B6Q, max UDMA/133
[    2.146562] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.146568] ata3.00: ATAPI: OPTIARC DVD RW AD-5690H, 4AH5, max UDMA/100
[    2.146888] ata1.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.148619] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.148627] ata3.00: configured for UDMA/100
[    2.148949] ata1.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    2.149235] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.149307] ata1.00: supports DRM functions and may not be fully accessible
[    2.152215] ata1.00: configured for UDMA/133
[    2.152396] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 850  3B6Q PQ: 0 ANSI: 5
[    2.154666] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.156248] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.156305] ata2.00: supports DRM functions and may not be fully accessible
[    2.156310] ata2.00: ATA-9: Samsung SSD 850 EVO 500GB, EMT02B6Q, max UDMA/133
[    2.156921] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.158898] ata2.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    2.159197] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.159251] ata2.00: supports DRM functions and may not be fully accessible
[    2.162083] ata2.00: configured for UDMA/133
[    2.162208] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 850  2B6Q PQ: 0 ANSI: 5
[    2.163362] usb 6-1: new high-speed USB device number 2 using ehci-pci
[    2.273807] usb 1-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    2.273813] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.274077] hub 1-1:1.0: USB hub found
[    2.274145] hub 1-1:1.0: 3 ports detected
[    2.283436] [drm] ring test on 5 succeeded in 2 usecs
[    2.283454] [drm] UVD initialized successfully.
[    2.283579] [drm] ib test on ring 0 succeeded in 0 usecs
[    2.283683] [drm] ib test on ring 3 succeeded in 0 usecs
[    2.284263] scsi 2:0:0:0: CD-ROM            OPTIARC  DVD RW AD-5690H  4AH5 PQ: 0 ANSI: 5
[    2.303794] usb 3-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    2.303800] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.304076] hub 3-1:1.0: USB hub found
[    2.304120] hub 3-1:1.0: 4 ports detected
[    2.313439] firewire_core 0000:04:00.0: created device fw0: GUID a4b197fffe3f2da2, S800
[    2.313459] firewire_core 0000:04:00.0: phy config: new root=ffc0, gap_count=63
[    2.344085] usb 5-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[    2.344091] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.344476] hub 5-1:1.0: USB hub found
[    2.344691] hub 5-1:1.0: 7 ports detected
[    2.364311] usb 6-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[    2.364317] usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.364721] hub 6-1:1.0: USB hub found
[    2.364934] hub 6-1:1.0: 7 ports detected
[    2.433364] usb 1-2: new high-speed USB device number 3 using ehci-pci
[    2.463467] firewire_core 0000:25:00.0: created device fw1: GUID 000a2702006cfdfb, S800
[    2.463484] firewire_core 0000:25:00.0: phy config: new root=ffc0, gap_count=63
[    2.524970] ohci-pci: OHCI PCI platform driver
[    2.525076] ohci-pci 0000:1c:00.0: OHCI PCI host controller
[    2.525087] ohci-pci 0000:1c:00.0: new USB bus registered, assigned bus number 7
[    2.525117] ohci-pci 0000:1c:00.0: irq 19, io mem 0xb0b00000
[    2.527336] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    2.527352] sd 0:0:0:0: [sda] Write Protect is off
[    2.527358] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.527377] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.527378] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    2.527397] sd 1:0:0:0: [sdb] Write Protect is off
[    2.527403] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.527426] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.529810] sd 1:0:0:0: [sdb] supports TCG Opal
[    2.529814] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.529826]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[    2.530680] sd 0:0:0:0: [sda] supports TCG Opal
[    2.530684] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.531202] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.531287] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.531353] sr 2:0:0:0: Attached scsi generic sg2 type 5
[    2.583580] firewire_core 0000:1e:00.0: created device fw2: GUID 000a27020040c4ba, S800
[    2.583611] firewire_core 0000:1e:00.0: phy config: new root=ffc0, gap_count=63
[    2.597512] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.597518] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.597521] usb usb7: Product: OHCI PCI host controller
[    2.597523] usb usb7: Manufacturer: Linux 5.17.1bkc1+ ohci_hcd
[    2.597525] usb usb7: SerialNumber: 0000:1c:00.0
[    2.597653] hub 7-0:1.0: USB hub found
[    2.597668] hub 7-0:1.0: 2 ports detected
[    2.597854] ohci-pci 0000:1c:00.1: OHCI PCI host controller
[    2.597860] ohci-pci 0000:1c:00.1: new USB bus registered, assigned bus number 8
[    2.597887] ohci-pci 0000:1c:00.1: irq 16, io mem 0xb0b01000
[    2.605504] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda caddy
[    2.605510] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.623397] usb 3-1.1: new high-speed USB device number 3 using ehci-pci
[    2.633393] tsc: Refined TSC clocksource calibration: 3400.023 MHz
[    2.633409] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x31026473058, max_idle_ns: 440795314252 ns
[    2.633518] clocksource: Switched to clocksource tsc
[    2.647443] usb 1-2: New USB device found, idVendor=05ac, idProduct=850b, bcdDevice= 7.55
[    2.647449] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.647451] usb 1-2: Product: FaceTime HD Camera (Built-in)
[    2.647453] usb 1-2: Manufacturer: Apple Inc.
[    2.647455] usb 1-2: SerialNumber: CCGB8K062WDDJRLX
[    2.663384] usb 5-1.4: new full-speed USB device number 3 using ehci-pci
[    2.677469] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.677475] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.677478] usb usb8: Product: OHCI PCI host controller
[    2.677480] usb usb8: Manufacturer: Linux 5.17.1bkc1+ ohci_hcd
[    2.677482] usb usb8: SerialNumber: 0000:1c:00.1
[    2.677604] hub 8-0:1.0: USB hub found
[    2.677620] hub 8-0:1.0: 2 ports detected
[    2.677813] ohci-pci 0000:23:00.0: OHCI PCI host controller
[    2.677818] ohci-pci 0000:23:00.0: new USB bus registered, assigned bus number 9
[    2.677844] ohci-pci 0000:23:00.0: irq 19, io mem 0xb0f00000
[    2.683394] usb 6-1.4: new full-speed USB device number 3 using ehci-pci
[    2.724493] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    2.733395] usb 1-1.1: new full-speed USB device number 4 using ehci-pci
[    2.747523] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.747528] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.747531] usb usb9: Product: OHCI PCI host controller
[    2.747533] usb usb9: Manufacturer: Linux 5.17.1bkc1+ ohci_hcd
[    2.747535] usb usb9: SerialNumber: 0000:23:00.0
[    2.747660] hub 9-0:1.0: USB hub found
[    2.747678] hub 9-0:1.0: 2 ports detected
[    2.747872] ohci-pci 0000:23:00.1: OHCI PCI host controller
[    2.747878] ohci-pci 0000:23:00.1: new USB bus registered, assigned bus number 10
[    2.747903] ohci-pci 0000:23:00.1: irq 16, io mem 0xb0f01000
[    2.779184] usb 3-1.1: New USB device found, idVendor=05ac, idProduct=8403, bcdDevice=98.33
[    2.779189] usb 3-1.1: New USB device strings: Mfr=3, Product=4, SerialNumber=2
[    2.779192] usb 3-1.1: Product: Card Reader
[    2.779194] usb 3-1.1: Manufacturer: Apple
[    2.779196] usb 3-1.1: SerialNumber: 000000009833
[    2.817537] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.817543] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.817546] usb usb10: Product: OHCI PCI host controller
[    2.817548] usb usb10: Manufacturer: Linux 5.17.1bkc1+ ohci_hcd
[    2.817550] usb usb10: SerialNumber: 0000:23:00.1
[    2.817672] hub 10-0:1.0: USB hub found
[    2.817691] hub 10-0:1.0: 2 ports detected
[    2.822973] usb 5-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[    2.822979] usb 5-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.822982] usb 5-1.4: Product: Display Audio
[    2.822984] usb 5-1.4: Manufacturer: Apple Inc.
[    2.822986] usb 5-1.4: SerialNumber: 152303D9
[    2.824712] hid: raw HID events driver (C) Jiri Kosina
[    2.836474] usbcore: registered new interface driver usbhid
[    2.836478] usbhid: USB HID core driver
[    2.837084] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:00.0/0000:1a:00.0/0000:1b:03.0/0000:1c:00.2/usb5/5-1/5-1.4/5-1.4:1.3/0003:05AC:1107.0001/input/input0
[    2.837110] hid-generic 0003:05AC:1107.0001: input,hidraw0: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:1c:00.2-1.4/input3
[    2.843091] usb 6-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[    2.843097] usb 6-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.843100] usb 6-1.4: Product: Display Audio
[    2.843102] usb 6-1.4: Manufacturer: Apple Inc.
[    2.843104] usb 6-1.4: SerialNumber: 1A0E0738
[    2.854944] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:04.0/0000:1f:00.0/0000:20:00.0/0000:21:00.0/0000:22:03.0/0000:23:00.2/usb6/6-1/6-1.4/6-1.4:1.3/0003:05AC:1107.0002/input/input1
[    2.854982] hid-generic 0003:05AC:1107.0002: input,hidraw1: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:23:00.2-1.4/input3
[    2.873398] usb 3-1.2: new low-speed USB device number 4 using ehci-pci
[    2.895818] usb 1-1.1: New USB device found, idVendor=0a5c, idProduct=4500, bcdDevice= 1.00
[    2.895832] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.895838] usb 1-1.1: Product: BRCM2046 Hub
[    2.895843] usb 1-1.1: Manufacturer: Apple Inc.
[    2.896114] hub 1-1.1:1.0: USB hub found
[    2.896301] hub 1-1.1:1.0: 3 ports detected
[    2.923395] usb 5-1.5: new high-speed USB device number 4 using ehci-pci
[    2.943439] [drm] ib test on ring 5 succeeded
[    2.953407] usb 6-1.5: new high-speed USB device number 4 using ehci-pci
[    2.993395] usb 1-1.2: new high-speed USB device number 5 using ehci-pci
[    3.013402] [drm] radeon atom DIG backlight initialized
[    3.013413] [drm] Radeon Display Connectors
[    3.013417] [drm] Connector 0:
[    3.013420] [drm]   eDP-1
[    3.013424] [drm]   HPD3
[    3.013426] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[    3.013433] [drm]   Encoders:
[    3.013436] [drm]     LCD1: INTERNAL_UNIPHY2
[    3.013439] [drm] Connector 1:
[    3.013442] [drm]   DP-1
[    3.013445] [drm]   HPD1
[    3.013447] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    3.013453] [drm]   Encoders:
[    3.013456] [drm]     DFP1: INTERNAL_UNIPHY1
[    3.013459] [drm] Connector 2:
[    3.013462] [drm]   DP-2
[    3.013464] [drm]   HPD2
[    3.013467] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[    3.013473] [drm]   Encoders:
[    3.013475] [drm]     DFP2: INTERNAL_UNIPHY1
[    3.013478] [drm] Connector 3:
[    3.013481] [drm]   DP-3
[    3.013483] [drm]   HPD4
[    3.013493] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[    3.013495] [drm]   Encoders:
[    3.013496] [drm]     DFP3: INTERNAL_UNIPHY2
[    3.013498] [drm] Connector 4:
[    3.013499] [drm]   DP-4
[    3.013500] [drm]   HPD5
[    3.013501] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 0x647c 0x647c
[    3.013503] [drm]   Encoders:
[    3.013505] [drm]     DFP4: INTERNAL_UNIPHY
[    3.013506] [drm] Connector 5:
[    3.013507] [drm]   VGA-1
[    3.013508] [drm]   DDC: 0x64d8 0x64d8 0x64dc 0x64dc 0x64e0 0x64e0 0x64e4 0x64e4
[    3.013510] [drm]   Encoders:
[    3.013512] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    3.030183] usb 3-1.2: New USB device found, idVendor=05ac, idProduct=8242, bcdDevice= 0.16
[    3.030189] usb 3-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.030192] usb 3-1.2: Product: IR Receiver
[    3.030194] usb 3-1.2: Manufacturer: Apple Computer, Inc.
[    3.043784] switching from power state:
[    3.043788] 	ui class: none
[    3.043790] 	internal class: boot
[    3.043792] 	caps:
[    3.043793] 	uvd    vclk: 0 dclk: 0
[    3.043795] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.043797] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.043799] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.043801] 	status: c b
[    3.043803] switching to power state:
[    3.043804] 	ui class: performance
[    3.043806] 	internal class: none
[    3.043807] 	caps:
[    3.043808] 	uvd    vclk: 0 dclk: 0
[    3.043810] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    3.043812] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    3.043814] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    3.043816] 	status: r
[    3.090659] usb 5-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[    3.090665] usb 5-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.090668] usb 5-1.5: Product: FaceTime HD Camera (Display)
[    3.090670] usb 5-1.5: Manufacturer: Apple Inc.
[    3.090672] usb 5-1.5: SerialNumber: CCGB690CKUDJ9DFX
[    3.120778] usb 6-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[    3.120785] usb 6-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.120788] usb 6-1.5: Product: FaceTime HD Camera (Display)
[    3.120790] usb 6-1.5: Manufacturer: Apple Inc.
[    3.120792] usb 6-1.5: SerialNumber: CC2G3101FFDJ9FLP
[    3.153394] usb 3-1.4: new low-speed USB device number 5 using ehci-pci
[    3.161894] usb 1-1.2: New USB device found, idVendor=05ac, idProduct=1006, bcdDevice=96.15
[    3.161899] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.161903] usb 1-1.2: Product: Keyboard Hub
[    3.161905] usb 1-1.2: Manufacturer: Apple, Inc.
[    3.161907] usb 1-1.2: SerialNumber: 000000000000
[    3.162056] hub 1-1.2:1.0: USB hub found
[    3.162144] hub 1-1.2:1.0: 3 ports detected
[    3.193369] usb 5-1.7: new full-speed USB device number 5 using ehci-pci
[    3.223381] usb 6-1.7: new full-speed USB device number 5 using ehci-pci
[    3.253372] usb 1-1.1.1: new full-speed USB device number 6 using ehci-pci
[    3.329172] usb 3-1.4: New USB device found, idVendor=047d, idProduct=1020, bcdDevice= 1.06
[    3.329179] usb 3-1.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.329190] usb 3-1.4: Product: Kensington Expert Mouse
[    3.332083] input: Kensington Expert Mouse as /devices/pci0000:00/0000:00:1d.7/usb3/3-1/3-1.4/3-1.4:1.0/0003:047D:1020.0004/input/input2
[    3.332133] hid-generic 0003:047D:1020.0004: input,hidraw2: USB HID v1.11 Mouse [Kensington Expert Mouse] on usb-0000:00:1d.7-1.4/input0
[    3.333638] input: Apple Computer, Inc. IR Receiver as /devices/pci0000:00/0000:00:1d.7/usb3/3-1/3-1.2/3-1.2:1.0/0003:05AC:8242.0003/input/input3
[    3.334172] usb-storage 3-1.1:1.0: USB Mass Storage device detected
[    3.334319] scsi host6: usb-storage 3-1.1:1.0
[    3.334445] usbcore: registered new interface driver usb-storage
[    3.334742] usbcore: registered new interface driver uas
[    3.345287] usb 5-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.37
[    3.345292] usb 5-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.345295] usb 5-1.7: Product: Apple Thunderbolt Display
[    3.345298] usb 5-1.7: Manufacturer: Apple Inc.
[    3.345300] usb 5-1.7: SerialNumber: 152303D9
[    3.347303] hid-generic 0003:05AC:9227.0005: hiddev96,hidraw3: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:1c:00.2-1.7/input0
[    3.375560] usb 6-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.39
[    3.375566] usb 6-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.375569] usb 6-1.7: Product: Apple Thunderbolt Display
[    3.375571] usb 6-1.7: Manufacturer: Apple Inc.
[    3.375573] usb 6-1.7: SerialNumber: 1A0E0738
[    3.377584] hid-generic 0003:05AC:9227.0006: hiddev97,hidraw4: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:23:00.2-1.7/input0
[    3.403421] appleir 0003:05AC:8242.0003: input,hiddev98,hidraw5: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.7-1.2/input0
[    3.407391] usb 1-1.1.1: New USB device found, idVendor=05ac, idProduct=8215, bcdDevice= 2.08
[    3.407397] usb 1-1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.407400] usb 1-1.1.1: Product: Bluetooth USB Host Controller
[    3.407403] usb 1-1.1.1: Manufacturer: Apple Inc.
[    3.407405] usb 1-1.1.1: SerialNumber: 3451C9ED7F9B
[    3.503360] usb 1-1.3: new full-speed USB device number 7 using ehci-pci
[    3.654139] usb 1-1.3: New USB device found, idVendor=067b, idProduct=2303, bcdDevice= 4.00
[    3.654144] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.654148] usb 1-1.3: Product: USB-Serial Controller C
[    3.654150] usb 1-1.3: Manufacturer: Prolific Technology Inc.
[    3.753360] usb 1-1.2.2: new low-speed USB device number 8 using ehci-pci
[    3.910139] usb 1-1.2.2: New USB device found, idVendor=05ac, idProduct=0220, bcdDevice= 0.71
[    3.910144] usb 1-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.910147] usb 1-1.2.2: Product: Apple Keyboard
[    3.910150] usb 1-1.2.2: Manufacturer: Apple, Inc
[    3.917881] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.0/0003:05AC:0220.0007/input/input4
[    3.983422] apple 0003:05AC:0220.0007: input,hidraw6: USB HID v1.11 Keyboard [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input0
[    3.983495] apple 0003:05AC:0220.0008: Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling
[    3.983525] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.1/0003:05AC:0220.0008/input/input5
[    4.003364] usb 1-1.1.2: new full-speed USB device number 9 using ehci-pci
[    4.053398] apple 0003:05AC:0220.0008: input,hidraw7: USB HID v1.11 Device [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input1
[    4.156952] usb 1-1.1.2: New USB device found, idVendor=05ac, idProduct=820a, bcdDevice= 1.00
[    4.156958] usb 1-1.1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.158811] input: HID 05ac:820a as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:05AC:820A.0009/input/input6
[    4.223436] hid-generic 0003:05AC:820A.0009: input,hidraw8: USB HID v1.11 Keyboard [HID 05ac:820a] on usb-0000:00:1a.7-1.1.2/input0
[    4.323381] usb 1-1.1.3: new full-speed USB device number 10 using ehci-pci
[    4.395456] scsi 6:0:0:0: Direct-Access     APPLE    SD Card Reader   1.00 PQ: 0 ANSI: 0
[    4.395617] sd 6:0:0:0: Attached scsi generic sg3 type 0
[    4.396291] sd 6:0:0:0: [sdc] Media removed, stopped polling
[    4.397154] sd 6:0:0:0: [sdc] Attached SCSI removable disk
[    4.446863] [drm] fb mappable at 0x90363000
[    4.446867] [drm] vram apper at 0x90000000
[    4.446868] [drm] size 14745600
[    4.446869] [drm] fb depth is 24
[    4.446871] [drm]    pitch is 10240
[    4.446963] fbcon: radeondrmfb (fb0) is primary device
[    4.486791] usb 1-1.1.3: New USB device found, idVendor=05ac, idProduct=820b, bcdDevice= 1.00
[    4.486794] usb 1-1.1.3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.488506] input: HID 05ac:820b as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.0/0003:05AC:820B.000A/input/input7
[    4.488555] hid-generic 0003:05AC:820B.000A: input,hidraw9: USB HID v1.11 Mouse [HID 05ac:820b] on usb-0000:00:1a.7-1.1.3/input0
[    5.129427] switching from power state:
[    5.129428] 	ui class: performance
[    5.129429] 	internal class: none
[    5.129430] 	caps:
[    5.129431] 	uvd    vclk: 0 dclk: 0
[    5.129432] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    5.129440] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    5.129441] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    5.129442] 	status: c r
[    5.129443] switching to power state:
[    5.129443] 	ui class: performance
[    5.129443] 	internal class: none
[    5.129444] 	caps:
[    5.129444] 	uvd    vclk: 0 dclk: 0
[    5.129445] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    5.129446] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    5.129446] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    5.129447] 	status: c r
[    6.243864] switching from power state:
[    6.243865] 	ui class: performance
[    6.243866] 	internal class: none
[    6.243867] 	caps:
[    6.243867] 	uvd    vclk: 0 dclk: 0
[    6.243868] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    6.243869] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    6.243870] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    6.243871] 	status: c r
[    6.243871] switching to power state:
[    6.243872] 	ui class: performance
[    6.243872] 	internal class: none
[    6.243873] 	caps:
[    6.243873] 	uvd    vclk: 0 dclk: 0
[    6.243874] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    6.243874] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    6.243875] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    6.243876] 	status: c r
[    6.356048] Console: switching to colour frame buffer device 320x90
[    6.362874] radeon 0000:01:00.0: [drm] fb0: radeondrmfb frame buffer device
[    6.393508] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[    6.420994] [drm] amdgpu kernel modesetting enabled.
[    6.455429] netpoll: netconsole: local port 6666
[    6.455450] netpoll: netconsole: local IPv4 address 192.168.2.87
[    6.455471] netpoll: netconsole: interface 'eth0'
[    6.455486] netpoll: netconsole: remote port 6666
[    6.455501] netpoll: netconsole: remote IPv4 address 192.168.2.208
[    6.455520] netpoll: netconsole: remote ethernet address dc:a6:32:61:33:da
[    6.455545] netpoll: netconsole: device eth0 not up yet, forcing it
[   10.151283] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   10.151306] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   10.151327] tg3 0000:02:00.0 eth0: EEE is enabled
[   10.183122] printk: console [netcon0] enabled
[   10.183139] netconsole: network logging started
[   17.367570]  sdb: sdb1
[   17.394559] process '/usr/bin/fstype' started with executable stack
[   17.429243] EXT4-fs (sda6): mounted filesystem with ordered data mode. Quota mode: none.
[   17.588020] udevd[1277]: starting version 3.2.9
[   17.610785] udevd[1278]: starting eudev-3.2.9
[   17.643563] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input8
[   17.646302] ACPI: button: Power Button [PWRB]
[   17.648898] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input9
[   17.651273] ACPI: button: Sleep Button [SLPB]
[   17.652974] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input10
[   17.659137] udevd[1328]: Error changing net interface name eth1 to eth2: File exists
[   17.661043] udevd[1328]: could not rename interface '3' from 'eth1' to 'eth2': File exists
[   17.677219] mc: Linux media interface: v0.10
[   17.682802] videodev: Linux video capture interface: v2.00
[   17.687852] udevd[1328]: Error changing net interface name eth2 to eth1: File exists
[   17.689825] udevd[1328]: could not rename interface '4' from 'eth2' to 'eth1': File exists
[   17.692682] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[   17.694583] ACPI: button: Power Button [PWRF]
[   17.696235] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[   17.699646] usb 1-2: Found UVC 1.00 device FaceTime HD Camera (Built-in) (05ac:850b)
[   17.707845] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input11
[   17.710642] usbcore: registered new interface driver usbserial_generic
[   17.712664] usb 5-1.4: 1:1: cannot get freq at ep 0x4
[   17.712769] usbserial: USB Serial support registered for generic
[   17.717023] Bluetooth: Core ver 2.22
[   17.718696] NET: Registered PF_BLUETOOTH protocol family
[   17.720105] Bluetooth: HCI device and connection manager initialized
[   17.722035] Bluetooth: HCI socket layer initialized
[   17.723960] Bluetooth: L2CAP socket layer initialized
[   17.724050] usbcore: registered new interface driver pl2303
[   17.726040] Bluetooth: SCO socket layer initialized
[   17.728087] usbserial: USB Serial support registered for pl2303
[   17.730796] input: FaceTime HD Camera (Built-in):  as /devices/pci0000:00/0000:00:1a.7/usb1/1-2/1-2:1.0/input/input12
[   17.732092] pl2303 1-1.3:1.0: pl2303 converter detected
[   17.734736] snd_hda_codec_cirrus hdaudioC0D0: autoconfig for CS4206: line_outs=2 (0x9/0xb/0x0/0x0/0x0) type:speaker
[   17.735440] usb 5-1.5: Found UVC 1.00 device FaceTime HD Camera (Display) (05ac:1112)
[   17.737973] usb 1-1.3: pl2303 converter now attached to ttyUSB0
[   17.739496] snd_hda_codec_cirrus hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   17.743848] snd_hda_codec_cirrus hdaudioC0D0:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[   17.745581] snd_hda_codec_cirrus hdaudioC0D0:    mono: mono_out=0x0
[   17.747409] snd_hda_codec_cirrus hdaudioC0D0:    dig-out=0x10/0x0
[   17.749122] snd_hda_codec_cirrus hdaudioC0D0:    inputs:
[   17.750651] snd_hda_codec_cirrus hdaudioC0D0:      Mic=0xd
[   17.752311] snd_hda_codec_cirrus hdaudioC0D0:      Line=0xc
[   17.754464] snd_hda_codec_cirrus hdaudioC0D0:    dig-in=0xf
[   17.759997] usbcore: registered new interface driver btusb
[   17.766057] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   17.768168] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   17.770188] input: HDA Intel PCH SPDIF In as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   17.797074] applesmc: key=332 fan=3 temp=50 index=49 acc=0 lux=2 kbd=0
[   17.797204] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   17.871085] usb 1-1.1.2: USB disconnect, device number 9
[   17.884700] usb 5-1.4: 1:2: cannot get freq at ep 0x4
[   17.889386] input: FaceTime HD Camera (Display): F as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:00.0/0000:1a:00.0/0000:1b:03.0/0000:1c:00.2/usb5/5-1/5-1.5/5-1.5:1.0/input/input16
[   17.892182] usb 6-1.5: Found UVC 1.00 device FaceTime HD Camera (Display) (05ac:1112)
[   17.893708] usb 5-1.4: 2:1: cannot get freq at ep 0x84
[   17.894702] Bluetooth: hci0: BCM: chip id 254 build 0518
[   17.898677] Bluetooth: hci0: BCM: product 05ac:8215
[   17.901707] Bluetooth: hci0: BCM: features 0x00
[   17.918204] input: FaceTime HD Camera (Display): F as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:04.0/0000:1f:00.0/0000:20:00.0/0000:21:00.0/0000:22:03.0/0000:23:00.2/usb6/6-1/6-1.5/6-1.5:1.0/input/input17
[   17.919711] Bluetooth: hci0: Bluetooth USB Host Controller
[   17.933718] usb 5-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   17.935359] usb 5-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   17.972797] usb 5-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   17.974548] usb 5-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   17.989178] usb 6-1.4: 1:1: cannot get freq at ep 0x4
[   18.159210] usb 6-1.4: 1:2: cannot get freq at ep 0x4
[   18.169216] usb 6-1.4: 2:1: cannot get freq at ep 0x84
[   18.173543] usbcore: registered new interface driver uvcvideo
[   18.209101] usb 6-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   18.210688] usb 6-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   18.248209] usb 6-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   18.249802] usb 6-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   18.251719] usbcore: registered new interface driver snd-usb-audio
[   18.373821] usb 1-1.1.3: USB disconnect, device number 10
[   19.337596] Adding 16777212k swap on /dev/sda5.  Priority:-2 extents:1 across:16777212k SS
[   19.357009] EXT4-fs (sda6): re-mounted. Quota mode: none.
[   19.445476] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
[   22.642957] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Quota mode: none.
[   23.168011] NET: Registered PF_PACKET protocol family
[   26.350010] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   26.351504] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   26.352974] tg3 0000:02:00.0 eth0: EEE is enabled
[   30.216074] RPC: Registered named UNIX socket transport module.
[   30.217542] RPC: Registered udp transport module.
[   30.219020] RPC: Registered tcp transport module.
[   30.220490] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   30.225006] FS-Cache: Loaded
[   30.238954] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   30.260263] NFS: Registering the id_resolver key type
[   30.261693] Key type id_resolver registered
[   30.263074] Key type id_legacy registered
[   31.740721] elogind-daemon[3137]: New seat seat0.
[   33.328265] switching from power state:
[   33.328272] 	ui class: performance
[   33.328274] 	internal class: none
[   33.328277] 	caps:
[   33.328278] 	uvd    vclk: 0 dclk: 0
[   33.328280] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   33.328282] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[   33.328283] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[   33.328285] 	status: c
[   33.328286] switching to power state:
[   33.328287] 	ui class: battery
[   33.328289] 	internal class: none
[   33.328290] 	caps:
[   33.328292] 	uvd    vclk: 0 dclk: 0
[   33.328293] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   33.328295] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   33.328296] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   33.328297] 	status: r
[   40.140157] elogind-daemon[3137]: New session c1 of user brad.
[   52.259837] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   52.259850] thunderbolt 0000:07:00.0: acking hot unplug event on 0:4
[   52.303768] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
[   52.303804] thunderbolt 0000:07:00.0: 0:3: switch unplugged
[   52.305249] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
[   52.305250] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): deactivating
[   52.353830] ohci-pci 0000:1c:00.1: HC died; cleaning up
[   52.403883] ohci-pci 0000:23:00.1: HC died; cleaning up
[   52.403894] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
[   52.403896] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
[   52.403908] pcieport 0000:06:04.0: pciehp: Slot(4-1): Link Down
[   52.403917] pcieport 0000:06:04.0: pciehp: Slot(4-1): Card not present
[   52.403921] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 3:10 to 0:7
[   52.403925] pcieport 0000:19:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   52.404145] pcieport 0000:20:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   52.405122] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 0:7 to 3:10
[   52.405531] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): deactivating
[   52.405535] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 303:10 to 3:7
[   52.405537] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 3:7 to 303:10
[   52.405539] thunderbolt 0000:07:00.0: 0:c <-> 303:b (DP): deactivating
[   52.406269] thunderbolt 0000:07:00.0: deactivating Video path from 0:12 to 303:11
[   52.407648] pcieport 0000:20:04.0: can't change power state from D3cold to D0 (config space inaccessible)
[   52.409396] thunderbolt 0000:07:00.0: 0:c: adding -5 NFC credits to 5
[   52.604345] firewire_ohci 0000:25:00.0: removed fw-ohci device
[   52.605254] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:12 to 303:11
[   52.614561] thunderbolt 0000:07:00.0: deactivating AUX RX path from 303:11 to 0:12
[   52.614930] thunderbolt 0000:07:00.0: 0: released DP resource for port 12
[   52.614937] thunderbolt 0000:07:00.0: 0:d <-> 3:b (DP): deactivating
[   52.615723] thunderbolt 0000:07:00.0: deactivating Video path from 0:13 to 3:11
[   52.616107] thunderbolt 0000:07:00.0: 0:d: adding -5 NFC credits to 5
[   52.616233] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:13 to 3:11
[   52.616618] thunderbolt 0000:07:00.0: deactivating AUX RX path from 3:11 to 0:13
[   52.617001] thunderbolt 0000:07:00.0: 0: released DP resource for port 13
[   52.617005] thunderbolt 0000:07:00.0: 303:b: DP OUT resource unavailable
[   52.617006] thunderbolt 0000:07:00.0: 3:b: DP OUT resource unavailable
[   52.617057] thunderbolt 0-303: device disconnected
[   52.617101] thunderbolt 0-3: device disconnected
[   52.617136] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   52.617149] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   52.617361] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   52.617363] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
[   52.617367] thunderbolt 0000:07:00.0: 0:4: got unplug event for disconnected port, ignoring
[   52.724230] ehci-pci 0000:23:00.2: HC died; cleaning up
[   52.774314] ehci-pci 0000:23:00.2: remove, state 1
[   52.775501] usb usb6: USB disconnect, device number 1
[   52.775503] usb 6-1: USB disconnect, device number 2
[   52.775504] usb 6-1.4: USB disconnect, device number 3
[   52.834421] usb 6-1.5: USB disconnect, device number 4
[   52.955083] usb 6-1.7: USB disconnect, device number 5
[   53.404884] clocksource: timekeeping watchdog on CPU1: hpet retried 2 times before success
[   53.454897] ehci-pci 0000:23:00.2: USB bus 6 deregistered
[   53.457640] ohci-pci 0000:23:00.1: remove, state 4
[   53.457643] usb usb10: USB disconnect, device number 1
[   53.905080] clocksource: timekeeping watchdog on CPU2: hpet retried 2 times before success
[   54.105211] ohci-pci 0000:23:00.1: USB bus 10 deregistered
[   54.155234] ohci-pci 0000:23:00.0: HC died; cleaning up
[   54.156638] ohci-pci 0000:23:00.0: remove, state 4
[   54.156640] usb usb9: USB disconnect, device number 1
[   54.205250] sched: RT throttling activated
[   54.804554] ohci-pci 0000:23:00.0: USB bus 9 deregistered
[   55.004306] firewire_ohci 0000:1e:00.0: removed fw-ohci device
[   55.091236] switching from power state:
[   55.092520] 	ui class: battery
[   55.093808] 	internal class: none
[   55.095133] 	caps:
[   55.096443] 	uvd    vclk: 0 dclk: 0
[   55.096444] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   55.096445] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   55.096446] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   55.096447] 	status: c r
[   55.096448] switching to power state:
[   55.096448] 	ui class: battery
[   55.096448] 	internal class: none
[   55.096449] 	caps:
[   55.096450] 	uvd    vclk: 0 dclk: 0
[   55.096450] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   55.096451] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   55.096451] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   55.096460] 	status: c r
[   55.144085] ehci-pci 0000:1c:00.2: HC died; cleaning up
[   55.204094] ehci-pci 0000:1c:00.2: remove, state 1
[   55.204097] usb usb5: USB disconnect, device number 1
[   55.204099] usb 5-1: USB disconnect, device number 2
[   55.204100] usb 5-1.4: USB disconnect, device number 3
[   55.274533] usb 5-1.5: USB disconnect, device number 4
[   55.474887] usb 5-1.7: USB disconnect, device number 5
[   55.974179] ehci-pci 0000:1c:00.2: USB bus 5 deregistered
[   55.974266] ohci-pci 0000:1c:00.1: remove, state 4
[   55.974270] usb usb8: USB disconnect, device number 1
[   56.624866] ohci-pci 0000:1c:00.1: USB bus 8 deregistered
[   56.674897] ohci-pci 0000:1c:00.0: HC died; cleaning up
[   56.676005] ohci-pci 0000:1c:00.0: remove, state 4
[   56.677114] usb usb7: USB disconnect, device number 1
[   57.325627] ohci-pci 0000:1c:00.0: USB bus 7 deregistered
[   57.328782] pci_bus 0000:1c: busn_res: [bus 1c] is released
[   57.328869] pci_bus 0000:1b: busn_res: [bus 1b-1c] is released
[   57.328967] pci_bus 0000:1a: busn_res: [bus 1a-1c] is released
[   57.329248] pci_bus 0000:1d: busn_res: [bus 1d] is released
[   57.329462] pci_bus 0000:1e: busn_res: [bus 1e] is released
[   57.329919] pci_bus 0000:23: busn_res: [bus 23] is released
[   57.337128] pci_bus 0000:22: busn_res: [bus 22-23] is released
[   57.337201] pci_bus 0000:21: busn_res: [bus 21-23] is released
[   57.339548] pci_bus 0000:24: busn_res: [bus 24] is released
[   57.339661] pci_bus 0000:25: busn_res: [bus 25] is released
[   57.340350] pci_bus 0000:26: busn_res: [bus 26-35] is released
[   57.340941] pci_bus 0000:36: busn_res: [bus 36-45] is released
[   57.341415] pci_bus 0000:20: busn_res: [bus 20-45] is released
[   57.341940] pci_bus 0000:1f: busn_res: [bus 1f-45] is released
[   57.348065] pci_bus 0000:46: busn_res: [bus 46-55] is released
[   57.348094] pci_bus 0000:19: busn_res: [bus 19-55] is released
[   65.303796] thunderbolt 0000:07:00.0: acking hot plug event on 0:4
[   65.303926] thunderbolt 0000:07:00.0: 0:4: hotplug: scanning
[   65.303929] thunderbolt 0000:07:00.0: 0:4: hotplug: no switch found
[   65.319235] thunderbolt 0000:07:00.0: acking hot plug event on 0:3
[   65.319362] thunderbolt 0000:07:00.0: 0:3: hotplug: scanning
[   65.319445] thunderbolt 0000:07:00.0: 0:3: is connected, link is up (state: 2)
[   65.319733] thunderbolt 0000:07:00.0: current switch config:
[   65.319739] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   65.319744] thunderbolt 0000:07:00.0:   Max Port Number: 13
[   65.319753] thunderbolt 0000:07:00.0:   Config:
[   65.319754] thunderbolt 0000:07:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[   65.319756] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[   65.324455] thunderbolt 0000:07:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[   65.350998] thunderbolt 0000:07:00.0: 3: reading drom (length: 0x97)
[   65.421826] thunderbolt 0000:07:00.0: acking hot plug event on 3:4
[   65.425278] thunderbolt 0000:07:00.0: acking hot plug event on 3:3
[   65.846126] thunderbolt 0000:07:00.0: 3: DROM version: 1
[   65.847153] thunderbolt 0000:07:00.0: 3: uid: 0x1000100189170
[   65.850062] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   65.850070] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   65.850073] thunderbolt 0000:07:00.0:   Max counters: 32
[   65.850075] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   65.850077] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   65.853004] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   65.853008] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   65.853010] thunderbolt 0000:07:00.0:   Max counters: 32
[   65.853012] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   65.853014] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   65.867434] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   65.867449] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   65.867450] thunderbolt 0000:07:00.0:   Max counters: 32
[   65.867451] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   65.867452] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   65.870314] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   65.870322] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   65.870325] thunderbolt 0000:07:00.0:   Max counters: 32
[   65.870327] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   65.870330] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   65.870332] thunderbolt 0000:07:00.0: 3:5: disabled by eeprom
[   65.870335] thunderbolt 0000:07:00.0: 3:6: disabled by eeprom
[   65.871208] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   65.871213] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   65.871215] thunderbolt 0000:07:00.0:   Max counters: 1
[   65.871217] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   65.871219] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   65.872104] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   65.872108] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   65.872111] thunderbolt 0000:07:00.0:   Max counters: 1
[   65.872112] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   65.872115] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   65.872117] thunderbolt 0000:07:00.0: 3:9: disabled by eeprom
[   65.873000] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   65.873004] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   65.873006] thunderbolt 0000:07:00.0:   Max counters: 1
[   65.873008] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   65.873010] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   65.874155] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   65.874162] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[   65.874166] thunderbolt 0000:07:00.0:   Max counters: 2
[   65.874169] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   65.874172] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   65.874176] thunderbolt 0000:07:00.0: 3:c: disabled by eeprom
[   65.874179] thunderbolt 0000:07:00.0: 3:d: disabled by eeprom
[   65.892324] thunderbolt 0000:07:00.0: 3: TMU: current mode: bi-directional, HiFi
[   65.892355] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[   65.892357] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[   65.892621] thunderbolt 0000:07:00.0: 3:3: is connected, link is up (state: 2)
[   65.892763] thunderbolt 0000:07:00.0: current switch config:
[   65.892764] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   65.892766] thunderbolt 0000:07:00.0:   Max Port Number: 13
[   65.892767] thunderbolt 0000:07:00.0:   Config:
[   65.892767] thunderbolt 0000:07:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[   65.892769] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[   65.897372] thunderbolt 0000:07:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[   65.914808] thunderbolt 0000:07:00.0: 303: reading drom (length: 0x97)
[   66.059033] thunderbolt 0000:07:00.0: acking hot plug event on 3:b
[   66.059038] thunderbolt 0000:07:00.0: acking hot plug event on 3:b
[   66.160280] thunderbolt 0000:07:00.0: acking hot plug event on 303:b
[   66.160285] thunderbolt 0000:07:00.0: acking hot plug event on 303:b
[   66.408501] thunderbolt 0000:07:00.0: 303: DROM version: 1
[   66.409497] thunderbolt 0000:07:00.0: 303: uid: 0x100010102a740
[   66.412439] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   66.412442] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   66.412443] thunderbolt 0000:07:00.0:   Max counters: 32
[   66.412444] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   66.412445] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   66.415384] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   66.415388] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   66.415389] thunderbolt 0000:07:00.0:   Max counters: 32
[   66.415390] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   66.415391] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   66.418328] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   66.418331] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   66.418333] thunderbolt 0000:07:00.0:   Max counters: 32
[   66.418333] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   66.418334] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   66.421271] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   66.421273] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   66.421274] thunderbolt 0000:07:00.0:   Max counters: 32
[   66.421275] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   66.421276] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   66.421277] thunderbolt 0000:07:00.0: 303:5: disabled by eeprom
[   66.421278] thunderbolt 0000:07:00.0: 303:6: disabled by eeprom
[   66.422167] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   66.422169] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   66.422170] thunderbolt 0000:07:00.0:   Max counters: 1
[   66.422171] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   66.422172] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   66.423063] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   66.423065] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   66.423066] thunderbolt 0000:07:00.0:   Max counters: 1
[   66.423066] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   66.423067] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   66.423068] thunderbolt 0000:07:00.0: 303:9: disabled by eeprom
[   66.423959] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   66.423961] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   66.423962] thunderbolt 0000:07:00.0:   Max counters: 1
[   66.423962] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   66.423963] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   66.425112] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   66.425114] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[   66.425115] thunderbolt 0000:07:00.0:   Max counters: 2
[   66.425115] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   66.425116] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   66.425117] thunderbolt 0000:07:00.0: 303:c: disabled by eeprom
[   66.425118] thunderbolt 0000:07:00.0: 303:d: disabled by eeprom
[   66.443584] thunderbolt 0000:07:00.0: 303: TMU: current mode: bi-directional, HiFi
[   66.443604] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[   66.443606] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[   66.443713] thunderbolt 0000:07:00.0: 303:1: is unplugged (state: 7)
[   66.443968] thunderbolt 0000:07:00.0: 303:b: DP adapter HPD set, queuing hotplug
[   66.444256] thunderbolt 0000:07:00.0: 3:b: DP adapter HPD set, queuing hotplug
[   66.446344] thunderbolt 0000:07:00.0: 3:4: got plug event for connected port, ignoring
[   66.446345] thunderbolt 0000:07:00.0: 3:3: got plug event for connected port, ignoring
[   66.446406] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
[   66.446409] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   66.446541] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   66.446673] thunderbolt 0000:07:00.0: 3:b: DP OUT available
[   66.446676] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 12
[   66.446677] thunderbolt 0000:07:00.0: 3:b: calculating available bandwidth
[   66.446800] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[   66.446803] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[   66.446804] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[   66.446809] thunderbolt 0000:07:00.0: 0:c <-> 3:b (DP): activating
[   66.446811] thunderbolt 0000:07:00.0: activating Video path from 0:12 to 3:11
[   66.446812] thunderbolt 0000:07:00.0: 3:2: adding 12 NFC credits to 0
[   66.446935] thunderbolt 0000:07:00.0: 0:c: adding 5 NFC credits to 0
[   66.447132] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[   66.447134] thunderbolt 0000:07:00.0: 3:2:  In HopID: 8 => Out port: 11 Out HopID: 9
[   66.447136] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   66.447138] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   66.447139] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   66.447140] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.447407] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[   66.447408] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 4 Out HopID: 8
[   66.447410] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   66.447411] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[   66.447412] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   66.447413] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.447515] thunderbolt 0000:07:00.0: path activation complete
[   66.447515] thunderbolt 0000:07:00.0: activating AUX TX path from 0:12 to 3:11
[   66.447643] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[   66.447644] thunderbolt 0000:07:00.0: 3:2:  In HopID: 9 => Out port: 11 Out HopID: 8
[   66.447645] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   66.447646] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   66.447647] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   66.447648] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.447899] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[   66.447900] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 4 Out HopID: 9
[   66.447901] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   66.447902] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[   66.447903] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   66.447904] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.448026] thunderbolt 0000:07:00.0: path activation complete
[   66.448027] thunderbolt 0000:07:00.0: activating AUX RX path from 3:11 to 0:12
[   66.448155] thunderbolt 0000:07:00.0: 0:4: Writing hop 1
[   66.448156] thunderbolt 0000:07:00.0: 0:4:  In HopID: 8 => Out port: 12 Out HopID: 8
[   66.448157] thunderbolt 0000:07:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   66.448158] thunderbolt 0000:07:00.0: 0:4:    Counter enabled: 0 Counter index: 2047
[   66.448159] thunderbolt 0000:07:00.0: 0:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   66.448160] thunderbolt 0000:07:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.448410] thunderbolt 0000:07:00.0: 3:b: Writing hop 0
[   66.448411] thunderbolt 0000:07:00.0: 3:b:  In HopID: 8 => Out port: 2 Out HopID: 8
[   66.448412] thunderbolt 0000:07:00.0: 3:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   66.448414] thunderbolt 0000:07:00.0: 3:b:    Counter enabled: 0 Counter index: 2047
[   66.448415] thunderbolt 0000:07:00.0: 3:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   66.448416] thunderbolt 0000:07:00.0: 3:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.448538] thunderbolt 0000:07:00.0: path activation complete
[   66.449562] thunderbolt 0000:07:00.0: Used link no : 1
[   66.449724] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): activating
[   66.449727] thunderbolt 0000:07:00.0: activating PCIe Down path from 0:7 to 3:10
[   66.449848] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   66.449850] thunderbolt 0000:07:00.0: 3:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[   66.449852] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   66.449854] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   66.449855] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   66.449856] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.450105] thunderbolt 0000:07:00.0: 0:7: Writing hop 0
[   66.450107] thunderbolt 0000:07:00.0: 0:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[   66.450109] thunderbolt 0000:07:00.0: 0:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   66.450110] thunderbolt 0000:07:00.0: 0:7:    Counter enabled: 0 Counter index: 2047
[   66.450112] thunderbolt 0000:07:00.0: 0:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   66.450113] thunderbolt 0000:07:00.0: 0:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.450232] thunderbolt 0000:07:00.0: path activation complete
[   66.450234] thunderbolt 0000:07:00.0: activating PCIe Up path from 3:10 to 0:7
[   66.450362] thunderbolt 0000:07:00.0: 0:3: Writing hop 1
[   66.450364] thunderbolt 0000:07:00.0: 0:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[   66.450366] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   66.450367] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   66.450368] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   66.450370] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.450587] thunderbolt 0000:07:00.0: 3:a: Writing hop 0
[   66.450588] thunderbolt 0000:07:00.0: 3:a:  In HopID: 8 => Out port: 1 Out HopID: 8
[   66.450589] thunderbolt 0000:07:00.0: 3:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   66.450590] thunderbolt 0000:07:00.0: 3:a:    Counter enabled: 0 Counter index: 2047
[   66.450591] thunderbolt 0000:07:00.0: 3:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   66.450593] thunderbolt 0000:07:00.0: 3:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.450714] thunderbolt 0000:07:00.0: path activation complete
[   66.450740] pcieport 0000:06:04.0: pciehp: Slot(4-1): Card present
[   66.451227] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[   66.452063] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   66.452079] thunderbolt 0000:07:00.0: 0:c: in use
[   66.452204] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   66.452331] thunderbolt 0000:07:00.0: 3:b: in use
[   66.452459] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[   66.452461] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 13
[   66.452462] thunderbolt 0000:07:00.0: 303:b: calculating available bandwidth
[   66.452587] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[   66.452589] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[   66.452715] thunderbolt 0000:07:00.0: 3:3: link total bandwidth 9000 Mb/s
[   66.452716] thunderbolt 0000:07:00.0: 303:3: link total bandwidth 9000 Mb/s
[   66.452717] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[   66.452721] thunderbolt 0000:07:00.0: 0:d <-> 303:b (DP): activating
[   66.452723] thunderbolt 0000:07:00.0: activating Video path from 0:13 to 303:11
[   66.452724] thunderbolt 0000:07:00.0: 303:3: adding 12 NFC credits to 0
[   66.452843] thunderbolt 0000:07:00.0: 3:1: adding 12 NFC credits to 0
[   66.452971] thunderbolt 0000:07:00.0: 0:d: adding 5 NFC credits to 0
[   66.453227] thunderbolt 0000:07:00.0: 303:3: Writing hop 2
[   66.453228] thunderbolt 0000:07:00.0: 303:3:  In HopID: 8 => Out port: 11 Out HopID: 9
[   66.453229] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   66.453231] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   66.453232] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   66.453233] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.453483] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   66.453484] thunderbolt 0000:07:00.0: 3:1:  In HopID: 9 => Out port: 3 Out HopID: 8
[   66.453485] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   66.453487] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   66.453488] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   66.453489] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.453739] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[   66.453740] thunderbolt 0000:07:00.0: 0:d:  In HopID: 9 => Out port: 3 Out HopID: 9
[   66.453741] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   66.453743] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[   66.453744] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   66.453745] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.453867] thunderbolt 0000:07:00.0: path activation complete
[   66.453868] thunderbolt 0000:07:00.0: activating AUX TX path from 0:13 to 303:11
[   66.456654] thunderbolt 0000:07:00.0: 303:3: Writing hop 2
[   66.456656] thunderbolt 0000:07:00.0: 303:3:  In HopID: 9 => Out port: 11 Out HopID: 8
[   66.456657] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   66.456658] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   66.456659] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   66.456660] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.456909] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   66.456910] thunderbolt 0000:07:00.0: 3:1:  In HopID: 10 => Out port: 3 Out HopID: 9
[   66.456911] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   66.456912] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   66.456913] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   66.456914] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.457165] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[   66.457166] thunderbolt 0000:07:00.0: 0:d:  In HopID: 8 => Out port: 3 Out HopID: 10
[   66.457167] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   66.457168] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[   66.457169] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   66.457171] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.457293] thunderbolt 0000:07:00.0: path activation complete
[   66.457294] thunderbolt 0000:07:00.0: activating AUX RX path from 303:11 to 0:13
[   66.457421] thunderbolt 0000:07:00.0: 0:3: Writing hop 2
[   66.457422] thunderbolt 0000:07:00.0: 0:3:  In HopID: 9 => Out port: 13 Out HopID: 8
[   66.457423] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   66.457424] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   66.457425] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   66.457426] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.457677] thunderbolt 0000:07:00.0: 3:3: Writing hop 1
[   66.457678] thunderbolt 0000:07:00.0: 3:3:  In HopID: 8 => Out port: 1 Out HopID: 9
[   66.457679] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   66.457680] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[   66.457681] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   66.457683] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.457933] thunderbolt 0000:07:00.0: 303:b: Writing hop 0
[   66.457934] thunderbolt 0000:07:00.0: 303:b:  In HopID: 8 => Out port: 3 Out HopID: 8
[   66.457935] thunderbolt 0000:07:00.0: 303:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   66.457936] thunderbolt 0000:07:00.0: 303:b:    Counter enabled: 0 Counter index: 2047
[   66.457937] thunderbolt 0000:07:00.0: 303:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   66.457939] thunderbolt 0000:07:00.0: 303:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.458061] thunderbolt 0000:07:00.0: path activation complete
[   66.459085] thunderbolt 0000:07:00.0: Used link no : 0
[   66.459472] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): activating
[   66.459475] thunderbolt 0000:07:00.0: activating PCIe Down path from 3:7 to 303:10
[   66.459597] thunderbolt 0000:07:00.0: 303:3: Writing hop 1
[   66.459598] thunderbolt 0000:07:00.0: 303:3:  In HopID: 10 => Out port: 10 Out HopID: 8
[   66.459599] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   66.459601] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   66.459602] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   66.459603] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.459852] thunderbolt 0000:07:00.0: 3:7: Writing hop 0
[   66.459854] thunderbolt 0000:07:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 10
[   66.459855] thunderbolt 0000:07:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   66.459856] thunderbolt 0000:07:00.0: 3:7:    Counter enabled: 0 Counter index: 2047
[   66.459857] thunderbolt 0000:07:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   66.459858] thunderbolt 0000:07:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.459980] thunderbolt 0000:07:00.0: path activation complete
[   66.459981] thunderbolt 0000:07:00.0: activating PCIe Up path from 303:10 to 3:7
[   66.460108] thunderbolt 0000:07:00.0: 3:3: Writing hop 1
[   66.460109] thunderbolt 0000:07:00.0: 3:3:  In HopID: 9 => Out port: 7 Out HopID: 8
[   66.460110] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   66.460112] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[   66.460113] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   66.460114] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.460364] thunderbolt 0000:07:00.0: 303:a: Writing hop 0
[   66.460365] thunderbolt 0000:07:00.0: 303:a:  In HopID: 8 => Out port: 3 Out HopID: 9
[   66.460366] thunderbolt 0000:07:00.0: 303:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   66.460367] thunderbolt 0000:07:00.0: 303:a:    Counter enabled: 0 Counter index: 2047
[   66.460368] thunderbolt 0000:07:00.0: 303:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   66.460370] thunderbolt 0000:07:00.0: 303:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   66.460492] thunderbolt 0000:07:00.0: path activation complete
[   66.654186] pci 0000:18:00.0: [8086:1513] type 01 class 0x060400
[   66.654289] pci 0000:18:00.0: enabling Extended Tags
[   66.656622] pci 0000:18:00.0: supports D1 D2
[   66.656623] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.656794] pcieport 0000:06:04.0: ASPM: current common clock configuration is inconsistent, reconfiguring
[   66.684159] pci 0000:18:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.684329] pci 0000:19:00.0: [8086:1513] type 01 class 0x060400
[   66.684436] pci 0000:19:00.0: enabling Extended Tags
[   66.684626] pci 0000:19:00.0: supports D1 D2
[   66.689038] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.689211] pci 0000:19:01.0: [8086:1513] type 01 class 0x060400
[   66.691457] pci 0000:19:01.0: enabling Extended Tags
[   66.691644] pci 0000:19:01.0: supports D1 D2
[   66.691645] pci 0000:19:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.691811] pci 0000:19:02.0: [8086:1513] type 01 class 0x060400
[   66.691917] pci 0000:19:02.0: enabling Extended Tags
[   66.692104] pci 0000:19:02.0: supports D1 D2
[   66.692104] pci 0000:19:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.692273] pci 0000:19:04.0: [8086:1513] type 01 class 0x060400
[   66.692379] pci 0000:19:04.0: enabling Extended Tags
[   66.692569] pci 0000:19:04.0: supports D1 D2
[   66.692569] pci 0000:19:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.692738] pci 0000:19:05.0: [8086:1513] type 01 class 0x060400
[   66.706857] pci 0000:19:05.0: enabling Extended Tags
[   66.707042] pci 0000:19:05.0: supports D1 D2
[   66.707043] pci 0000:19:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.707227] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   66.707241] pci 0000:18:00.0:   bridge window [io  0x0000-0x0fff]
[   66.707247] pci 0000:18:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.707260] pci 0000:18:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.707264] pci 0000:19:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.707280] pci 0000:19:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.707295] pci 0000:19:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.707310] pci 0000:19:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.707325] pci 0000:19:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.707519] pci 0000:1a:00.0: [12d8:400c] type 01 class 0x060400
[   66.707893] pci 0000:1a:00.0: supports D1 D2
[   66.707894] pci 0000:1a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.734173] pci 0000:19:00.0: PCI bridge to [bus 1a-55]
[   66.734186] pci 0000:19:00.0:   bridge window [io  0x0000-0x0fff]
[   66.734193] pci 0000:19:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.734206] pci 0000:19:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.734211] pci 0000:1a:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.734451] pci 0000:1b:03.0: [12d8:400c] type 01 class 0x060400
[   66.734774] pci 0000:1b:03.0: supports D1 D2
[   66.742819] pci 0000:1b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.743035] pci 0000:1a:00.0: PCI bridge to [bus 1b-55]
[   66.745207] pci 0000:1a:00.0:   bridge window [io  0x0000-0x0fff]
[   66.745223] pci 0000:1a:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.745239] pci 0000:1a:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.748864] pci 0000:1b:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.749092] pci 0000:1c:00.0: [12d8:400e] type 00 class 0x0c0310
[   66.751379] pci 0000:1c:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   66.751661] pci 0000:1c:00.0: supports D1 D2
[   66.751662] pci 0000:1c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.751829] pci 0000:1c:00.1: [12d8:400e] type 00 class 0x0c0310
[   66.751872] pci 0000:1c:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   66.752146] pci 0000:1c:00.1: supports D1 D2
[   66.752146] pci 0000:1c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   66.752281] pci 0000:1c:00.2: [12d8:400f] type 00 class 0x0c0320
[   66.752323] pci 0000:1c:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   66.752597] pci 0000:1c:00.2: supports D1 D2
[   66.752598] pci 0000:1c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   66.752864] pci 0000:1b:03.0: PCI bridge to [bus 1c-55]
[   66.767031] pci 0000:1b:03.0:   bridge window [io  0x0000-0x0fff]
[   66.767039] pci 0000:1b:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.767055] pci 0000:1b:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.770533] pci_bus 0000:1c: busn_res: [bus 1c-55] end is updated to 1c
[   66.770542] pci_bus 0000:1b: busn_res: [bus 1b-55] end is updated to 1c
[   66.770559] pci_bus 0000:1a: busn_res: [bus 1a-55] end is updated to 1c
[   66.770730] pci 0000:1d:00.0: [14e4:16b0] type 00 class 0x020000
[   66.775224] pci 0000:1d:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   66.775291] pci 0000:1d:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   66.777924] pci 0000:1d:00.0: PME# supported from D0 D3hot D3cold
[   66.804192] pci 0000:19:01.0: PCI bridge to [bus 1d-55]
[   66.804206] pci 0000:19:01.0:   bridge window [io  0x0000-0x0fff]
[   66.804213] pci 0000:19:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.804225] pci 0000:19:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.804227] pci_bus 0000:1d: busn_res: [bus 1d-55] end is updated to 1d
[   66.804386] pci 0000:1e:00.0: [11c1:5901] type 00 class 0x0c0010
[   66.811383] pci 0000:1e:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   66.811713] pci 0000:1e:00.0: supports D1 D2
[   66.811714] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.834193] pci 0000:19:02.0: PCI bridge to [bus 1e-55]
[   66.834207] pci 0000:19:02.0:   bridge window [io  0x0000-0x0fff]
[   66.834214] pci 0000:19:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.834227] pci 0000:19:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.834228] pci_bus 0000:1e: busn_res: [bus 1e-55] end is updated to 1e
[   66.834414] pci 0000:1f:00.0: [8086:1513] type 01 class 0x060400
[   66.834561] pci 0000:1f:00.0: enabling Extended Tags
[   66.834827] pci 0000:1f:00.0: supports D1 D2
[   66.844598] pci 0000:1f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.874182] pci 0000:19:04.0: PCI bridge to [bus 1f-55]
[   66.874196] pci 0000:19:04.0:   bridge window [io  0x0000-0x0fff]
[   66.874203] pci 0000:19:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.874216] pci 0000:19:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.874221] pci 0000:1f:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.874455] pci 0000:20:00.0: [8086:1513] type 01 class 0x060400
[   66.874622] pci 0000:20:00.0: enabling Extended Tags
[   66.874885] pci 0000:20:00.0: supports D1 D2
[   66.874886] pci 0000:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.875120] pci 0000:20:01.0: [8086:1513] type 01 class 0x060400
[   66.875275] pci 0000:20:01.0: enabling Extended Tags
[   66.875543] pci 0000:20:01.0: supports D1 D2
[   66.875543] pci 0000:20:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.875771] pci 0000:20:02.0: [8086:1513] type 01 class 0x060400
[   66.892801] pci 0000:20:02.0: enabling Extended Tags
[   66.893062] pci 0000:20:02.0: supports D1 D2
[   66.893063] pci 0000:20:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.893301] pci 0000:20:04.0: [8086:1513] type 01 class 0x060400
[   66.893454] pci 0000:20:04.0: enabling Extended Tags
[   66.893725] pci 0000:20:04.0: supports D1 D2
[   66.893726] pci 0000:20:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.893961] pci 0000:20:05.0: [8086:1513] type 01 class 0x060400
[   66.903532] pci 0000:20:05.0: enabling Extended Tags
[   66.903797] pci 0000:20:05.0: supports D1 D2
[   66.903797] pci 0000:20:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.904061] pci 0000:1f:00.0: PCI bridge to [bus 20-55]
[   66.904079] pci 0000:1f:00.0:   bridge window [io  0x0000-0x0fff]
[   66.904088] pci 0000:1f:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.904113] pci 0000:1f:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.904118] pci 0000:20:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.904144] pci 0000:20:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.904167] pci 0000:20:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.904196] pci 0000:20:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.904217] pci 0000:20:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.904447] pci 0000:21:00.0: [12d8:400c] type 01 class 0x060400
[   66.904945] pci 0000:21:00.0: supports D1 D2
[   66.920223] pci 0000:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.920523] pci 0000:20:00.0: PCI bridge to [bus 21-55]
[   66.922474] pci 0000:20:00.0:   bridge window [io  0x0000-0x0fff]
[   66.922483] pci 0000:20:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.924698] pci 0000:20:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.924704] pci 0000:21:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.925048] pci 0000:22:03.0: [12d8:400c] type 01 class 0x060400
[   66.928631] pci 0000:22:03.0: supports D1 D2
[   66.928632] pci 0000:22:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.928900] pci 0000:21:00.0: PCI bridge to [bus 22-55]
[   66.928922] pci 0000:21:00.0:   bridge window [io  0x0000-0x0fff]
[   66.928933] pci 0000:21:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.928954] pci 0000:21:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.928960] pci 0000:22:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   66.929231] pci 0000:23:00.0: [12d8:400e] type 00 class 0x0c0310
[   66.929288] pci 0000:23:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   66.929645] pci 0000:23:00.0: supports D1 D2
[   66.940715] pci 0000:23:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.940949] pci 0000:23:00.1: [12d8:400e] type 00 class 0x0c0310
[   66.943067] pci 0000:23:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   66.943441] pci 0000:23:00.1: supports D1 D2
[   66.943442] pci 0000:23:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   66.943614] pci 0000:23:00.2: [12d8:400f] type 00 class 0x0c0320
[   66.943671] pci 0000:23:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   66.944028] pci 0000:23:00.2: supports D1 D2
[   66.944029] pci 0000:23:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   66.944423] pci 0000:22:03.0: PCI bridge to [bus 23-55]
[   66.953512] pci 0000:22:03.0:   bridge window [io  0x0000-0x0fff]
[   66.953524] pci 0000:22:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.953545] pci 0000:22:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.957244] pci_bus 0000:23: busn_res: [bus 23-55] end is updated to 23
[   66.957256] pci_bus 0000:22: busn_res: [bus 22-55] end is updated to 23
[   66.959655] pci_bus 0000:21: busn_res: [bus 21-55] end is updated to 23
[   66.959860] pci 0000:24:00.0: [14e4:16b0] type 00 class 0x020000
[   66.959940] pci 0000:24:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   66.959988] pci 0000:24:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   66.960418] pci 0000:24:00.0: PME# supported from D0 D3hot D3cold
[   66.960743] pci 0000:20:01.0: PCI bridge to [bus 24-55]
[   66.960760] pci 0000:20:01.0:   bridge window [io  0x0000-0x0fff]
[   66.960770] pci 0000:20:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.960788] pci 0000:20:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.960789] pci_bus 0000:24: busn_res: [bus 24-55] end is updated to 24
[   66.961002] pci 0000:25:00.0: [11c1:5901] type 00 class 0x0c0010
[   66.974099] pci 0000:25:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   66.974554] pci 0000:25:00.0: supports D1 D2
[   66.974555] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   66.974866] pci 0000:20:02.0: PCI bridge to [bus 25-55]
[   66.974883] pci 0000:20:02.0:   bridge window [io  0x0000-0x0fff]
[   66.974893] pci 0000:20:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.974910] pci 0000:20:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.974911] pci_bus 0000:25: busn_res: [bus 25-55] end is updated to 25
[   66.975045] pci 0000:20:04.0: PCI bridge to [bus 26-55]
[   66.975063] pci 0000:20:04.0:   bridge window [io  0x0000-0x0fff]
[   66.975072] pci 0000:20:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.975097] pci 0000:20:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.975098] pci_bus 0000:26: busn_res: [bus 26-55] end is updated to 35
[   66.975241] pci 0000:20:05.0: PCI bridge to [bus 36-55]
[   66.975266] pci 0000:20:05.0:   bridge window [io  0x0000-0x0fff]
[   66.975275] pci 0000:20:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   66.975293] pci 0000:20:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   66.975294] pci_bus 0000:36: busn_res: [bus 36-55] end is updated to 45
[   66.975303] pci_bus 0000:20: busn_res: [bus 20-55] end is updated to 45
[   66.975313] pci_bus 0000:1f: busn_res: [bus 1f-55] end is updated to 45
[   66.975452] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[   67.000098] pci 0000:19:05.0:   bridge window [io  0x0000-0x0fff]
[   67.001263] pci 0000:19:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   67.001276] pci 0000:19:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   67.001277] pci_bus 0000:46: busn_res: [bus 46-55] end is updated to 55
[   67.004907] pci_bus 0000:19: busn_res: [bus 19-55] end is updated to 55
[   67.004918] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 26-35] add_size 3ff00000 add_align 100000
[   67.004920] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 26-35] add_size 7f00000 add_align 100000
[   67.004929] pci 0000:20:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 36-45] add_size 3ff00000 add_align 100000
[   67.004931] pci 0000:20:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 36-45] add_size 7f00000 add_align 100000
[   67.004933] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 20-45] add_size 7fe00000 add_align 100000
[   67.004935] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x005fffff] to [bus 20-45] add_size fe00000 add_align 100000
[   67.004936] pci 0000:19:04.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 1f-45] add_size bf900000 add_align 100000
[   67.004938] pci 0000:19:04.0: bridge window [mem 0x00100000-0x005fffff] to [bus 1f-45] add_size 17900000 add_align 100000
[   67.004939] pci 0000:19:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 46-55] add_size 3ff00000 add_align 100000
[   67.004941] pci 0000:19:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 46-55] add_size 7f00000 add_align 100000
[   67.004943] pci 0000:18:00.0: bridge window [mem 0x00100000-0x009fffff 64bit pref] to [bus 19-55] add_size ff800000 add_align 100000
[   67.004945] pci 0000:18:00.0: bridge window [mem 0x00100000-0x009fffff] to [bus 19-55] add_size 1f800000 add_align 100000
[   67.020931] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x009fffff 64bit pref] to [bus 18-55] add_size 13ef00000 add_align 100000
[   67.020938] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   67.020939] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   67.020941] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   67.020942] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   67.020952] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[   67.020953] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   67.020954] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   67.020956] pci 0000:18:00.0: BAR 7: assigned [io  0x5000-0x9fff]
[   67.020957] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[   67.020958] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   67.020960] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   67.020964] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   67.020966] pci 0000:19:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   67.020967] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0d00000-0xb0dfffff]
[   67.020968] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0e00000-0xb0efffff 64bit pref]
[   67.020970] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[   67.020971] pci 0000:19:02.0: BAR 9: assigned [mem 0xb1000000-0xb10fffff 64bit pref]
[   67.020972] pci 0000:19:04.0: BAR 8: assigned [mem 0xb1100000-0xbd27ffff]
[   67.020974] pci 0000:19:04.0: BAR 9: assigned [mem 0xbd300000-0xbd5fffff 64bit pref]
[   67.020975] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   67.020976] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   67.020977] pci 0000:19:05.0: BAR 9: assigned [mem 0xbd600000-0xbd8fffff 64bit pref]
[   67.020979] pci 0000:19:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   67.020980] pci 0000:19:01.0: BAR 7: assigned [io  0x6000-0x6fff]
[   67.020981] pci 0000:19:02.0: BAR 7: assigned [io  0x7000-0x7fff]
[   67.020982] pci 0000:19:04.0: BAR 7: assigned [io  0x8000-0x8fff]
[   67.020983] pci 0000:19:05.0: BAR 7: assigned [io  0x9000-0x9fff]
[   67.020985] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   67.020987] pci 0000:19:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   67.020988] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0d00000-0xb0dfffff]
[   67.020989] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0e00000-0xb0efffff 64bit pref]
[   67.020990] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[   67.020992] pci 0000:19:02.0: BAR 9: assigned [mem 0xb1000000-0xb10fffff 64bit pref]
[   67.020993] pci 0000:19:04.0: BAR 8: assigned [mem 0xb1100000-0xbd27ffff]
[   67.020994] pci 0000:19:04.0: BAR 9: assigned [mem 0xbd300000-0xbd5fffff 64bit pref]
[   67.020995] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   67.020996] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   67.020998] pci 0000:19:05.0: BAR 9: assigned [mem 0xbd600000-0xbd8fffff 64bit pref]
[   67.021000] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   67.021001] pci 0000:1a:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   67.021002] pci 0000:1a:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   67.021004] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   67.021005] pci 0000:1b:03.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   67.021006] pci 0000:1b:03.0: BAR 7: assigned [io  0x5000-0x5fff]
[   67.021008] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[   67.021017] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[   67.021033] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[   67.021042] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   67.021047] pci 0000:1b:03.0:   bridge window [io  0x5000-0x5fff]
[   67.021066] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   67.021075] pci 0000:1b:03.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   67.021091] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   67.021096] pci 0000:1a:00.0:   bridge window [io  0x5000-0x5fff]
[   67.021108] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   67.021116] pci 0000:1a:00.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   67.021132] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   67.021136] pci 0000:19:00.0:   bridge window [io  0x5000-0x5fff]
[   67.021145] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   67.021152] pci 0000:19:00.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   67.021165] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e0ffff 64bit pref]
[   67.021193] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0e10000-0xb0e1ffff 64bit pref]
[   67.021222] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   67.021225] pci 0000:19:01.0:   bridge window [io  0x6000-0x6fff]
[   67.021234] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[   67.021241] pci 0000:19:01.0:   bridge window [mem 0xb0e00000-0xb0efffff 64bit pref]
[   67.021254] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff 64bit]
[   67.021282] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   67.021286] pci 0000:19:02.0:   bridge window [io  0x7000-0x7fff]
[   67.021295] pci 0000:19:02.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[   67.021302] pci 0000:19:02.0:   bridge window [mem 0xb1000000-0xb10fffff 64bit pref]
[   67.021315] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb1100000-0xbd27ffff]
[   67.021316] pci 0000:1f:00.0: BAR 9: assigned [mem 0xbd300000-0xbd5fffff 64bit pref]
[   67.021317] pci 0000:1f:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   67.021320] pci 0000:20:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   67.021321] pci 0000:20:00.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   67.021322] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[   67.021324] pci 0000:20:01.0: BAR 9: assigned [mem 0xbd400000-0xbd4fffff 64bit pref]
[   67.021325] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1300000-0xb13fffff]
[   67.021326] pci 0000:20:02.0: BAR 9: assigned [mem 0xbd500000-0xbd5fffff 64bit pref]
[   67.021327] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1400000-0xb733ffff]
[   67.021329] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   67.021330] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   67.021332] pci 0000:20:05.0: BAR 8: assigned [mem 0xb7400000-0xbd27ffff]
[   67.021333] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   67.021335] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   67.021336] pci 0000:20:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   67.021337] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   67.021338] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   67.021339] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   67.021340] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   67.021341] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   67.021342] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   67.021343] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   67.021344] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   67.021346] pci 0000:20:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   67.021347] pci 0000:20:00.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   67.021348] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[   67.021350] pci 0000:20:01.0: BAR 9: assigned [mem 0xbd400000-0xbd4fffff 64bit pref]
[   67.021351] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1300000-0xb13fffff]
[   67.021352] pci 0000:20:02.0: BAR 9: assigned [mem 0xbd500000-0xbd5fffff 64bit pref]
[   67.021353] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1400000-0xb733ffff]
[   67.021355] pci 0000:20:04.0: BAR 9: assigned [mem 0xb7400000-0xb74fffff 64bit pref]
[   67.021356] pci 0000:20:05.0: BAR 8: no space for [mem size 0x05e80000]
[   67.021357] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x05e80000]
[   67.021359] pci 0000:20:05.0: BAR 9: assigned [mem 0xb7500000-0xb75fffff 64bit pref]
[   67.021360] pci 0000:20:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   67.021361] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   67.021362] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   67.021363] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   67.021364] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   67.021365] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   67.021366] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   67.021367] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   67.021368] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   67.021370] pci 0000:20:05.0: BAR 9: [mem 0xb7500000-0xb75fffff 64bit pref] (failed to expand by 0x3ff00000)
[   67.021371] pci 0000:20:05.0: failed to add 3ff00000 res[9]=[mem 0xb7500000-0xb75fffff 64bit pref]
[   67.021374] pci 0000:20:04.0: BAR 9: [mem 0xb7400000-0xb74fffff 64bit pref] (failed to expand by 0x3ff00000)
[   67.021375] pci 0000:20:04.0: failed to add 3ff00000 res[9]=[mem 0xb7400000-0xb74fffff 64bit pref]
[   67.021377] pci 0000:21:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   67.021378] pci 0000:21:00.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   67.021379] pci 0000:21:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   67.021381] pci 0000:22:03.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   67.021382] pci 0000:22:03.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   67.021383] pci 0000:22:03.0: BAR 7: assigned [io  0x8000-0x8fff]
[   67.021385] pci 0000:23:00.0: BAR 0: assigned [mem 0xb1100000-0xb1100fff]
[   67.021396] pci 0000:23:00.1: BAR 0: assigned [mem 0xb1101000-0xb1101fff]
[   67.021407] pci 0000:23:00.2: BAR 0: assigned [mem 0xb1102000-0xb11020ff]
[   67.021418] pci 0000:22:03.0: PCI bridge to [bus 23]
[   67.021424] pci 0000:22:03.0:   bridge window [io  0x8000-0x8fff]
[   67.021440] pci 0000:22:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   67.021451] pci 0000:22:03.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   67.021472] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   67.021478] pci 0000:21:00.0:   bridge window [io  0x8000-0x8fff]
[   67.021494] pci 0000:21:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   67.021505] pci 0000:21:00.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   67.021527] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   67.021532] pci 0000:20:00.0:   bridge window [io  0x8000-0x8fff]
[   67.021545] pci 0000:20:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   67.021554] pci 0000:20:00.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   67.021572] pci 0000:24:00.0: BAR 0: assigned [mem 0xbd400000-0xbd40ffff 64bit pref]
[   67.021609] pci 0000:24:00.0: BAR 2: assigned [mem 0xbd410000-0xbd41ffff 64bit pref]
[   67.021647] pci 0000:20:01.0: PCI bridge to [bus 24]
[   67.021660] pci 0000:20:01.0:   bridge window [mem 0xb1200000-0xb12fffff]
[   67.021669] pci 0000:20:01.0:   bridge window [mem 0xbd400000-0xbd4fffff 64bit pref]
[   67.021687] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1300000-0xb1300fff 64bit]
[   67.021725] pci 0000:20:02.0: PCI bridge to [bus 25]
[   67.021738] pci 0000:20:02.0:   bridge window [mem 0xb1300000-0xb13fffff]
[   67.021747] pci 0000:20:02.0:   bridge window [mem 0xbd500000-0xbd5fffff 64bit pref]
[   67.021764] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[   67.021777] pci 0000:20:04.0:   bridge window [mem 0xb1400000-0xb733ffff]
[   67.021786] pci 0000:20:04.0:   bridge window [mem 0xb7400000-0xb74fffff 64bit pref]
[   67.021804] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[   67.021825] pci 0000:20:05.0:   bridge window [mem 0xb7500000-0xb75fffff 64bit pref]
[   67.021842] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   67.021847] pci 0000:1f:00.0:   bridge window [io  0x8000-0x8fff]
[   67.021860] pci 0000:1f:00.0:   bridge window [mem 0xb1100000-0xbd27ffff]
[   67.021869] pci 0000:1f:00.0:   bridge window [mem 0xbd300000-0xbd5fffff 64bit pref]
[   67.021886] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[   67.021890] pci 0000:19:04.0:   bridge window [io  0x8000-0x8fff]
[   67.021899] pci 0000:19:04.0:   bridge window [mem 0xb1100000-0xbd27ffff]
[   67.021906] pci 0000:19:04.0:   bridge window [mem 0xbd300000-0xbd5fffff 64bit pref]
[   67.021918] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[   67.021922] pci 0000:19:05.0:   bridge window [io  0x9000-0x9fff]
[   67.021937] pci 0000:19:05.0:   bridge window [mem 0xbd600000-0xbd8fffff 64bit pref]
[   67.021949] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   67.021952] pci 0000:18:00.0:   bridge window [io  0x5000-0x9fff]
[   67.021961] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[   67.021979] pcieport 0000:06:04.0: PCI bridge to [bus 18-55]
[   67.021982] pcieport 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[   67.021987] pcieport 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[   67.021997] PCI: No. 2 try to assign unassigned res
[   67.021998] pci 0000:22:03.0: resource 7 [io  0x8000-0x8fff] released
[   67.021999] pci 0000:22:03.0: PCI bridge to [bus 23]
[   67.022021] pci 0000:21:00.0: resource 7 [io  0x8000-0x8fff] released
[   67.022022] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   67.022043] pci 0000:20:00.0: resource 7 [io  0x8000-0x8fff] released
[   67.022043] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   67.022061] pci 0000:1f:00.0: resource 7 [io  0x8000-0x8fff] released
[   67.022062] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   67.022079] release child resource [mem 0xb1100000-0xb1100fff]
[   67.022080] release child resource [mem 0xb1101000-0xb1101fff]
[   67.022080] release child resource [mem 0xb1102000-0xb11020ff]
[   67.022081] pci 0000:22:03.0: resource 8 [mem 0xb1100000-0xb11fffff] released
[   67.022082] pci 0000:22:03.0: PCI bridge to [bus 23]
[   67.022093] pci 0000:21:00.0: resource 8 [mem 0xb1100000-0xb11fffff] released
[   67.022094] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   67.022105] pci 0000:20:00.0: resource 8 [mem 0xb1100000-0xb11fffff] released
[   67.022106] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   67.022115] pci 0000:20:01.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[   67.022116] pci 0000:20:01.0: PCI bridge to [bus 24]
[   67.022125] release child resource [mem 0xb1300000-0xb1300fff 64bit]
[   67.022125] pci 0000:20:02.0: resource 8 [mem 0xb1300000-0xb13fffff] released
[   67.022126] pci 0000:20:02.0: PCI bridge to [bus 25]
[   67.022135] pci 0000:20:04.0: resource 8 [mem 0xb1400000-0xb733ffff] released
[   67.022136] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[   67.022145] release child resource [mem 0xb7400000-0xb74fffff 64bit pref]
[   67.022146] release child resource [mem 0xb7500000-0xb75fffff 64bit pref]
[   67.022146] pci 0000:1f:00.0: resource 8 [mem 0xb1100000-0xbd27ffff] released
[   67.022147] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   67.022156] release child resource [mem 0xb0b00000-0xb0b00fff]
[   67.022157] release child resource [mem 0xb0b01000-0xb0b01fff]
[   67.022157] release child resource [mem 0xb0b02000-0xb0b020ff]
[   67.022158] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[   67.022159] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   67.022167] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[   67.022168] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   67.022177] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[   67.022178] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   67.022184] pci 0000:19:01.0: resource 8 [mem 0xb0d00000-0xb0dfffff] released
[   67.022185] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   67.022191] release child resource [mem 0xb0f00000-0xb0f00fff 64bit]
[   67.022192] pci 0000:19:02.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[   67.022193] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   67.022200] pci 0000:19:04.0: resource 8 [mem 0xb1100000-0xbd27ffff] released
[   67.022201] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[   67.022207] release child resource [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   67.022208] release child resource [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   67.022208] release child resource [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   67.022209] release child resource [mem 0xb0e00000-0xb0e0ffff 64bit pref]
[   67.022209] release child resource [mem 0xb0e10000-0xb0e1ffff 64bit pref]
[   67.022210] release child resource [mem 0xb0e00000-0xb0efffff 64bit pref]
[   67.022210] release child resource [mem 0xb1000000-0xb10fffff 64bit pref]
[   67.022211] release child resource [mem 0xbd300000-0xbd3fffff 64bit pref]
[   67.022212] release child resource [mem 0xbd300000-0xbd3fffff 64bit pref]
[   67.022212] release child resource [mem 0xbd300000-0xbd3fffff 64bit pref]
[   67.022213] release child resource [mem 0xbd400000-0xbd40ffff 64bit pref]
[   67.022213] release child resource [mem 0xbd410000-0xbd41ffff 64bit pref]
[   67.022214] release child resource [mem 0xbd400000-0xbd4fffff 64bit pref]
[   67.022214] release child resource [mem 0xbd500000-0xbd5fffff 64bit pref]
[   67.022215] release child resource [mem 0xbd300000-0xbd5fffff 64bit pref]
[   67.022216] release child resource [mem 0xbd300000-0xbd5fffff 64bit pref]
[   67.022216] release child resource [mem 0xbd600000-0xbd8fffff 64bit pref]
[   67.022217] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[   67.022218] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   67.022224] pcieport 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[   67.022225] pcieport 0000:06:04.0: PCI bridge to [bus 18-55]
[   67.022230] release child resource [mem 0xa8a00000-0xa8a3ffff]
[   67.022230] release child resource [mem 0xa8a00000-0xa8a3ffff]
[   67.022231] release child resource [mem 0xa8a40000-0xa8a40fff]
[   67.022231] pcieport 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[   67.022232] pcieport 0000:06:00.0: PCI bridge to [bus 07]
[   67.022236] pcieport 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[   67.022237] pcieport 0000:06:03.0: PCI bridge to [bus 08-17]
[   67.022242] pcieport 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[   67.022243] pcieport 0000:06:05.0: PCI bridge to [bus 56-65]
[   67.022247] pcieport 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[   67.022248] pcieport 0000:06:06.0: PCI bridge to [bus 66-75]
[   67.022252] pcieport 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[   67.022253] pcieport 0000:05:00.0: PCI bridge to [bus 06-75]
[   67.022260] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 26-35] add_size 3ff00000 add_align 100000
[   67.022262] pci 0000:20:04.0: bridge window [mem 0x00100000-0x060fffff] to [bus 26-35] add_size 2000000 add_align 100000
[   67.022263] pci 0000:20:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 36-45] add_size 3ff00000 add_align 100000
[   67.022265] pci 0000:20:05.0: bridge window [mem 0x00100000-0x05ffffff] to [bus 36-45] add_size 2100000 add_align 100000
[   67.022266] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 20-45] add_size 7fe00000 add_align 100000
[   67.022268] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x0c2fffff] to [bus 20-45] add_size 4100000 add_align 100000
[   67.022270] pci 0000:19:04.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 1f-45] add_size bf900000 add_align 100000
[   67.022271] pci 0000:19:04.0: bridge window [mem 0x00100000-0x0c2fffff] to [bus 1f-45] add_size 4100000 add_align 100000
[   67.022273] pci 0000:19:05.0: bridge window [mem 0x00100000-0x003fffff 64bit pref] to [bus 46-55] add_size 3fd00000 add_align 100000
[   67.022275] pci 0000:18:00.0: bridge window [mem 0x00100000-0x00bfffff 64bit pref] to [bus 19-55] add_size ff600000 add_align 100000
[   67.022276] pci 0000:18:00.0: bridge window [mem 0x00100000-0x186fffff] to [bus 19-55] add_size 4100000 add_align 100000
[   67.022278] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x00bfffff 64bit pref] to [bus 18-55] add_size 13eb00000 add_align 100000
[   67.022279] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x186fffff] to [bus 18-55] add_size 4100000 add_align 100000
[   67.022282] pcieport 0000:06:04.0: BAR 8: no space for [mem size 0x18600000]
[   67.022284] pcieport 0000:06:04.0: BAR 8: failed to assign [mem size 0x18600000]
[   67.022285] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   67.022286] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   67.022287] pcieport 0000:06:04.0: BAR 8: no space for [mem size 0x18600000]
[   67.022288] pcieport 0000:06:04.0: BAR 8: failed to assign [mem size 0x18600000]
[   67.022290] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   67.022291] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   67.022292] pci 0000:18:00.0: BAR 8: no space for [mem size 0x18600000]
[   67.022293] pci 0000:18:00.0: BAR 8: failed to assign [mem size 0x18600000]
[   67.022294] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   67.022295] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   67.022296] pci 0000:18:00.0: BAR 8: no space for [mem size 0x18600000]
[   67.022297] pci 0000:18:00.0: BAR 8: failed to assign [mem size 0x18600000]
[   67.022298] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   67.022300] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   67.084574] switching from power state:
[   67.084882] pci 0000:19:00.0: BAR 8: no space for [mem size 0x00100000]
[   67.086010] 	ui class: battery
[   67.087114] pci 0000:19:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.088220] 	internal class:
[   67.089322] pci 0000:19:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.090429]  none
[   67.091538] pci 0000:19:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]

[   67.093741] pci 0000:19:01.0: BAR 8: no space for [mem size 0x00100000]
[   67.094876] 	caps:
[   67.095999] pci 0000:19:01.0: BAR 8: failed to assign [mem size 0x00100000]

[   67.098217] pci 0000:19:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.099313] 	uvd    vclk: 0 dclk: 0
[   67.100410] pci 0000:19:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.101499] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   67.102591] pci 0000:19:02.0: BAR 8: no space for [mem size 0x00100000]
[   67.103675] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   67.104806] pci 0000:19:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.105930] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   67.107041] pci 0000:19:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.108142] 	status:
[   67.109223] pci 0000:19:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.110284]  c
[   67.111327] pci 0000:19:04.0: BAR 8: no space for [mem size 0x0c180000]
[   67.112376]  r
[   67.113401] pci 0000:19:04.0: BAR 8: failed to assign [mem size 0x0c180000]

[   67.114440] switching to power state:
[   67.114440] 	ui class: battery
[   67.114440] 	internal class: none
[   67.114441] 	caps:
[   67.115507] pci 0000:19:04.0: BAR 9: no space for [mem size 0x00400000 64bit pref]

[   67.116519] 	uvd    vclk: 0 dclk: 0
[   67.117516] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   67.118511] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   67.119497] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   67.120480] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   67.121459] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   67.122436] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   67.123403] pci 0000:19:05.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   67.124392] 	status: c
[   67.125383] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   67.126308]  r
[   67.127220] pci 0000:19:00.0: BAR 8: no space for [mem size 0x00100000]

[   67.129040] pci 0000:19:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.356041] pci 0000:19:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.356042] pci 0000:19:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.356043] pci 0000:19:01.0: BAR 8: no space for [mem size 0x00100000]
[   67.356044] pci 0000:19:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.356045] pci 0000:19:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.356046] pci 0000:19:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.356047] pci 0000:19:02.0: BAR 8: no space for [mem size 0x00100000]
[   67.356048] pci 0000:19:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.356049] pci 0000:19:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.356058] pci 0000:19:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.356059] pci 0000:19:04.0: BAR 8: no space for [mem size 0x0c180000]
[   67.356060] pci 0000:19:04.0: BAR 8: failed to assign [mem size 0x0c180000]
[   67.356061] pci 0000:19:04.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   67.356062] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   67.356063] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   67.356064] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   67.356065] pci 0000:19:05.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   67.356066] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   67.356068] pci 0000:1a:00.0: BAR 8: no space for [mem size 0x00100000]
[   67.356069] pci 0000:1a:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.356070] pci 0000:1a:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.356071] pci 0000:1a:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.356072] pci 0000:1a:00.0: BAR 8: no space for [mem size 0x00100000]
[   67.389604] pci 0000:1a:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.389605] pci 0000:1a:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.389607] pci 0000:1a:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.389608] pci 0000:1b:03.0: BAR 8: no space for [mem size 0x00100000]
[   67.395283] pci 0000:1b:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.395284] pci 0000:1b:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.395285] pci 0000:1b:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.395286] pci 0000:1b:03.0: BAR 8: no space for [mem size 0x00100000]
[   67.395287] pci 0000:1b:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.395288] pci 0000:1b:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.395289] pci 0000:1b:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.395299] pci 0000:1c:00.0: BAR 0: no space for [mem size 0x00001000]
[   67.395300] pci 0000:1c:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   67.395301] pci 0000:1c:00.1: BAR 0: no space for [mem size 0x00001000]
[   67.395302] pci 0000:1c:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   67.395303] pci 0000:1c:00.2: BAR 0: no space for [mem size 0x00000100]
[   67.395304] pci 0000:1c:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   67.395305] pci 0000:1c:00.0: BAR 0: no space for [mem size 0x00001000]
[   67.395306] pci 0000:1c:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   67.395307] pci 0000:1c:00.1: BAR 0: no space for [mem size 0x00001000]
[   67.395308] pci 0000:1c:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   67.419398] pci 0000:1c:00.2: BAR 0: no space for [mem size 0x00000100]
[   67.419399] pci 0000:1c:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   67.419401] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   67.419406] pci 0000:1b:03.0:   bridge window [io  0x5000-0x5fff]
[   67.424998] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   67.425004] pci 0000:1a:00.0:   bridge window [io  0x5000-0x5fff]
[   67.425061] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   67.425065] pci 0000:19:00.0:   bridge window [io  0x5000-0x5fff]
[   67.425107] pci 0000:1d:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   67.425109] pci 0000:1d:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   67.425110] pci 0000:1d:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   67.425111] pci 0000:1d:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   67.425112] pci 0000:1d:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   67.425113] pci 0000:1d:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   67.425114] pci 0000:1d:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   67.425115] pci 0000:1d:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   67.425116] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   67.425120] pci 0000:19:01.0:   bridge window [io  0x6000-0x6fff]
[   67.425147] pci 0000:1e:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   67.425148] pci 0000:1e:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   67.425149] pci 0000:1e:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   67.425150] pci 0000:1e:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   67.425151] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   67.425155] pci 0000:19:02.0:   bridge window [io  0x7000-0x7fff]
[   67.425182] pci 0000:1f:00.0: BAR 8: no space for [mem size 0x0c180000]
[   67.425183] pci 0000:1f:00.0: BAR 8: failed to assign [mem size 0x0c180000]
[   67.425184] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   67.425185] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   67.425187] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2800]
[   67.425188] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2800]
[   67.425189] pci 0000:1f:00.0: BAR 8: no space for [mem size 0x0c180000]
[   67.425190] pci 0000:1f:00.0: BAR 8: failed to assign [mem size 0x0c180000]
[   67.425191] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   67.425192] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   67.425193] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2800]
[   67.425194] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2800]
[   67.425198] pci 0000:20:00.0: BAR 8: no space for [mem size 0x00100000]
[   67.425199] pci 0000:20:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.425200] pci 0000:20:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.425201] pci 0000:20:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.425202] pci 0000:20:01.0: BAR 8: no space for [mem size 0x00100000]
[   67.425203] pci 0000:20:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.425204] pci 0000:20:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.425205] pci 0000:20:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.425206] pci 0000:20:02.0: BAR 8: no space for [mem size 0x00100000]
[   67.425207] pci 0000:20:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.425208] pci 0000:20:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.425209] pci 0000:20:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.425210] pci 0000:20:04.0: BAR 8: no space for [mem size 0x05f40000]
[   67.425211] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x05f40000]
[   67.425212] pci 0000:20:04.0: BAR 9: no space for [mem size 0x00080000 64bit pref]
[   67.425213] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x00080000 64bit pref]
[   67.425214] pci 0000:20:05.0: BAR 8: no space for [mem size 0x05e80000]
[   67.425215] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x05e80000]
[   67.425216] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   67.425217] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   67.425219] pci 0000:20:00.0: BAR 7: no space for [io  size 0x1000]
[   67.425219] pci 0000:20:00.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425220] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   67.425221] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425222] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   67.425223] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425224] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   67.425225] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425226] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   67.425227] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425229] pci 0000:20:00.0: BAR 8: no space for [mem size 0x00100000]
[   67.425230] pci 0000:20:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.425231] pci 0000:20:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.425232] pci 0000:20:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.425233] pci 0000:20:01.0: BAR 8: no space for [mem size 0x00100000]
[   67.425234] pci 0000:20:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.425235] pci 0000:20:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.425236] pci 0000:20:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.425237] pci 0000:20:02.0: BAR 8: no space for [mem size 0x00100000]
[   67.425238] pci 0000:20:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.425239] pci 0000:20:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.425240] pci 0000:20:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.425241] pci 0000:20:04.0: BAR 8: no space for [mem size 0x05f40000]
[   67.425242] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x05f40000]
[   67.425243] pci 0000:20:04.0: BAR 9: no space for [mem size 0x00080000 64bit pref]
[   67.425244] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x00080000 64bit pref]
[   67.425245] pci 0000:20:05.0: BAR 8: no space for [mem size 0x05e80000]
[   67.425246] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x05e80000]
[   67.425247] pci 0000:20:05.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.425248] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.425249] pci 0000:20:00.0: BAR 7: no space for [io  size 0x1000]
[   67.425250] pci 0000:20:00.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425251] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   67.425252] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425253] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   67.425254] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425255] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   67.425256] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425257] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   67.425258] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425260] pci 0000:21:00.0: BAR 8: no space for [mem size 0x00100000]
[   67.425261] pci 0000:21:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.425262] pci 0000:21:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.425263] pci 0000:21:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.425264] pci 0000:21:00.0: BAR 7: no space for [io  size 0x1000]
[   67.425265] pci 0000:21:00.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425266] pci 0000:22:03.0: BAR 8: no space for [mem size 0x00100000]
[   67.425267] pci 0000:22:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   67.425268] pci 0000:22:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   67.425269] pci 0000:22:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   67.425270] pci 0000:22:03.0: BAR 7: no space for [io  size 0x1000]
[   67.425271] pci 0000:22:03.0: BAR 7: failed to assign [io  size 0x1000]
[   67.425272] pci 0000:23:00.0: BAR 0: no space for [mem size 0x00001000]
[   67.425273] pci 0000:23:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   67.425274] pci 0000:23:00.1: BAR 0: no space for [mem size 0x00001000]
[   67.425275] pci 0000:23:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   67.425276] pci 0000:23:00.2: BAR 0: no space for [mem size 0x00000100]
[   67.425277] pci 0000:23:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   67.425278] pci 0000:22:03.0: PCI bridge to [bus 23]
[   67.425327] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   67.425376] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   67.425416] pci 0000:24:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   67.425417] pci 0000:24:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   67.425418] pci 0000:24:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   67.425419] pci 0000:24:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   67.425420] pci 0000:20:01.0: PCI bridge to [bus 24]
[   67.425460] pci 0000:25:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   67.425461] pci 0000:25:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   67.425462] pci 0000:20:02.0: PCI bridge to [bus 25]
[   67.425502] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[   67.425542] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[   67.425583] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   67.425622] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[   67.425626] pci 0000:19:04.0:   bridge window [io  0x8000-0x8fff]
[   67.425653] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[   67.425657] pci 0000:19:05.0:   bridge window [io  0x9000-0x9fff]
[   67.425684] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   67.425687] pci 0000:18:00.0:   bridge window [io  0x5000-0x9fff]
[   67.425714] pcieport 0000:06:04.0: PCI bridge to [bus 18-55]
[   67.425716] pcieport 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[   67.425759] pcieport 0000:18:00.0: enabling device (0000 -> 0001)
[   67.426102] pcieport 0000:19:00.0: enabling device (0000 -> 0001)
[   67.426428] pcieport 0000:19:01.0: enabling device (0000 -> 0001)
[   67.426861] pcieport 0000:19:02.0: enabling device (0000 -> 0001)
[   67.580384] pcieport 0000:19:04.0: enabling device (0000 -> 0001)
[   67.580593] pcieport 0000:19:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   67.581015] pcieport 0000:19:05.0: enabling device (0000 -> 0001)
[   67.581219] pcieport 0000:19:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   67.581582] pcieport 0000:1a:00.0: enabling device (0000 -> 0001)
[   67.581708] pcieport 0000:1b:03.0: enabling device (0000 -> 0001)
[   67.581859] pci 0000:1c:00.0: MSI is not implemented on this device, disabling it
[   67.581860] pci 0000:1c:00.0: PME# is unreliable, disabling it
[   67.581998] ohci-pci 0000:1c:00.0: init 0000:1c:00.0 fail, -16
[   67.591703] ohci-pci: probe of 0000:1c:00.0 failed with error -16
[   67.591707] pci 0000:1c:00.1: MSI is not implemented on this device, disabling it
[   67.591708] pci 0000:1c:00.1: PME# is unreliable, disabling it
[   67.591842] ohci-pci 0000:1c:00.1: init 0000:1c:00.1 fail, -16
[   67.596204] ohci-pci: probe of 0000:1c:00.1 failed with error -16
[   67.596208] pci 0000:1c:00.2: MSI is not implemented on this device, disabling it
[   67.596209] pci 0000:1c:00.2: PME# is unreliable, disabling it
[   67.596784] ehci-pci 0000:1c:00.2: init 0000:1c:00.2 fail, -16
[   67.600713] ehci-pci: probe of 0000:1c:00.2 failed with error -16
[   67.600776] tg3 0000:1d:00.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
[   67.603079] tg3 0000:1d:00.0: Cannot map device registers, aborting
[   67.603111] tg3: probe of 0000:1d:00.0 failed with error -12
[   67.603174] firewire_ohci 0000:1e:00.0: invalid MMIO resource
[   67.608988] pcieport 0000:20:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   67.609725] pcieport 0000:20:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   67.610485] pci 0000:23:00.0: MSI is not implemented on this device, disabling it
[   67.614221] pci 0000:23:00.0: PME# is unreliable, disabling it
[   67.614403] ohci-pci 0000:23:00.0: init 0000:23:00.0 fail, -16
[   67.616784] ohci-pci: probe of 0000:23:00.0 failed with error -16
[   67.616789] pci 0000:23:00.1: MSI is not implemented on this device, disabling it
[   67.616789] pci 0000:23:00.1: PME# is unreliable, disabling it
[   67.616915] ohci-pci 0000:23:00.1: init 0000:23:00.1 fail, -16
[   67.621680] ohci-pci: probe of 0000:23:00.1 failed with error -16
[   67.621684] pci 0000:23:00.2: MSI is not implemented on this device, disabling it
[   67.621685] pci 0000:23:00.2: PME# is unreliable, disabling it
[   67.621828] ehci-pci 0000:23:00.2: init 0000:23:00.2 fail, -16
[   67.626804] ehci-pci: probe of 0000:23:00.2 failed with error -16
[   67.626869] tg3 0000:24:00.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
[   67.629370] tg3 0000:24:00.0: Cannot map device registers, aborting
[   67.629404] tg3: probe of 0000:24:00.0 failed with error -12
[   67.629478] firewire_ohci 0000:25:00.0: invalid MMIO resource
