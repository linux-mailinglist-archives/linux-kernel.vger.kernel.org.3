Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC044EAF07
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbiC2OIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiC2OIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:08:32 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DB61C6492
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:06:44 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1nZCUb-0003i3-1f; Wed, 30 Mar 2022 00:06:41 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UDNbxh51GjBoWAGjj0HnqU5FtqDujNRgM1/hR1z2sWs=; b=uV9XfhnCAURrdCS33HOQoDKtUW
        GPawJ3Y3pZHDSvRxYo7k0abr82r0ywB7SDo11ZYaY+klTLOSPG0SpqTQYYseD6kCYJ1zQw5H+ZuMA
        F87PnlDU8ctOcMBMpET2aOzQWJXGcTvganvl4T7/aYrJQMvH6dlU7q6aH725nwaJwtgY=;
Message-ID: <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
Date:   Tue, 29 Mar 2022 22:06:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: Apple Thunderbolt Display chaining
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <acbb3a86-ea15-47ec-90fa-72fbd94921b1@fnarfbargle.com>
 <YkLt+/kJ54fwCYgy@lahna>
 <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
 <YkMC4XnfIZix6kBn@lahna>
Content-Language: en-AU
In-Reply-To: <YkMC4XnfIZix6kBn@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

G'day,

On 29/3/22 21:00, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Mar 29, 2022 at 08:35:49PM +0800, Brad Campbell wrote:
>> On 29/3/22 19:31, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Tue, Mar 29, 2022 at 07:09:36PM +0800, Brad Campbell wrote:
>>>> G'day Mika,
>>>>
>>>> Back in 2019 you assisted me with an issue on an iMac with a "Light Ridge"
>>>> controller running a pair of Apple 27" Thunderbolt displays. At the time I
>>>> commented they worked when plugged into a port each, however they don't work
>>>> when chained.
>>>>
>>>> Back then things crashed horribly. Now they don't crash, and the PCI devices
>>>> all work but there is an issue with the display.
>>>>
>>>> I'm currently testing on vanilla git-head commit
>>>> ae085d7f9365de7da27ab5c0d16b12d51ea7fca9 (Sunday March 27th). A recent
>>>> kernel with all the "for 5.18" patches.
>>>>
>>>> On both the iMac with the "Light Ridge" controller and a MacBookPro with a
>>>> "Falcon Ridge" controller the result is the same.
>>>>
>>>> Plugged into a port each, they work perfectly.
>>>
>>> Right, this is because both get their own 10Gb/s lane.
>>>
>>>> If I chain them, the first one plugged in works and when the second is
>>>> plugged in it's almost like the link is being starved of bandwidth.
>>>> Graphical displays like a desktop, or a terminal break up, tear or exhibit
>>>> almost white noise/snow on both displays. Solid colours with no gradient
>>>> sometimes displays cleanly until something else is displayed and then it
>>>> breaks up.
>>>
>>> I think this is related to bandwidth management. When you chain two TBT1
>>> devices you end up having a single 10Gb/s lane used for both DisplayPort
>>> tunnels (this is how Linux does it now). There are no hardware mechanism
>>> to negotiate the bandwidth so the first DP tunnel gets dominated over
>>> the second one.
>>>
>>> I'm not entirely sure how macOS handles this. It may be that it uses one
>>> lane for both PCIe and first DP tunnel and the second lane for the
>>> second DP tunnel where as Linux just puts all DP through the second
>>> lane.
>>>
>>> The below completely untested hack patch tries to use different lane for
>>> both tunnels. Can you try it out?
>>>
>>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>>> index cbd0ad85ffb1..6ea4968d3629 100644
>>> --- a/drivers/thunderbolt/tb.c
>>
>> For all forms of hot-plug this works perfectly! Got it in one.
>>
>> I've tried all of the obvious permutations of plug and unplug. Once
>> they are up and running it's all good.
> 
> Okay good to know.
> 
>> Where it falls down is if the machine is booted with the displays
>> plugged in. I've attached the dmesg for that at the end. If I leave
>> the chain unplugged until the kernel has started to boot and then plug
>> it in, it all detects up and runs well.
> 
> Indeed, I did not add this to the "discovery" path yet.
> 
> I wonder what happens if you change this:
> 
> +       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
> +                                   first ? 0 : 1);
> 
> to this in your tree:
> 
> +       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
> +                                   first ? 1 : 0);
> 

Here's where it gets all "Apple..y". On the iMac this does the job no matter which
port the chain is plugged into. Boots and displays correctly first time, every time.

It turns out on the laptop, one port works and the other doesn't. Changing the order
simply changes which port works. So I assume the EFI sets up the first display using
the first lane if it's in the first port, and the second if it's in the second.

That means had I managed to perform the first test in the "other port" consistently,
it would have worked there also.

> There are probably other things to consider too but let's check this one
> first.
> 
>> There is an additional issue that I bumped up against on the laptop once, but it's easier to hit on the iMac. This is the relevant bit of dmesg for that.
>> When a (single or chain) display is unplugged, the thunderbolt controller stops seeing plug events. It's effectively dead until rebooted.
>>
.....
>> [  153.039753] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
>>
>> Once it gets to here, nothing I plug in gets detected.
> 
> It is hard to tell what might be wrong here. Apple systems are not
> exactly the most standard ones and it could be that we are simply
> missing some magic step. The
> 
>    [  145.093518] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x39
> 
> tells that the DP adapter config write fails and we do have a quirk in
> capabilities (cap.c) for some of the TBT1 controllers. Can you share the
> full dmesg from this system so I can check if we cover this controller
> in the quirk?


I'm also seeing DP errors from time to time on one head on re-plug. Once it's dead, it takes a reboot to bring it back. That's another whole kettle of fish. This iMac is possessed.

[   74.513327] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
[   74.513409] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed
[   74.833164] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
[   74.833238] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed

This is a "Boot with nothing plugged in, plug, settle, unplug" on the iMac.

[    0.000000] Linux version 5.17.0+ (brad@bkmac) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #38 SMP PREEMPT_DYNAMIC Tue Mar 29 21:41:20 AWST 2022
[    0.000000] Command line: ro root=UUID=de35d1a6-e0e1-40b0-b46a-3974a04adf4b libata.allow_tpm=1 netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da oops=panic panic=10 thunderbolt.dyndbg pci=assign-busses,realloc,hpbussize=0x10,hpmmiosize=128M,hpmmioprefsize=1G initrd=boot\initrd.img-5.17.0+
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
[    0.000000] BIOS-e820: [mem 0x000000008ed8f000-0x000000008ee5afff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ee5b000-0x000000008ee8efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008ee8f000-0x000000008eed6fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008eed7000-0x000000008eefefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008eeff000-0x000000008efa2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008efa3000-0x000000008f8fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffed8000-0x00000000ffefffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000086fefffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x899b1018-0x899ccc57] usable ==> usable
[    0.000000] e820: update [mem 0x899b1018-0x899ccc57] usable ==> usable
[    0.000000] e820: update [mem 0x89a4f018-0x89a6033f] usable ==> usable
[    0.000000] e820: update [mem 0x89a4f018-0x89a6033f] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000008dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008e000-0x000000000008ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000040000000-0x00000000401fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000040200000-0x00000000899b1017] usable
[    0.000000] reserve setup_data: [mem 0x00000000899b1018-0x00000000899ccc57] usable
[    0.000000] reserve setup_data: [mem 0x00000000899ccc58-0x0000000089a4f017] usable
[    0.000000] reserve setup_data: [mem 0x0000000089a4f018-0x0000000089a6033f] usable
[    0.000000] reserve setup_data: [mem 0x0000000089a60340-0x000000008ed32fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ed33000-0x000000008ed5efff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000008ed5f000-0x000000008ed70fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ed71000-0x000000008ed8efff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000008ed8f000-0x000000008ee5afff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ee5b000-0x000000008ee8efff] reserved
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
[    0.000000] tsc: Detected 3399.741 MHz processor
[    0.000096] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000098] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000104] last_pfn = 0x86ff00 max_arch_pfn = 0x400000000
[    0.000753] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001371] last_pfn = 0x8efa3 max_arch_pfn = 0x400000000
[    0.002466] Secure boot disabled
[    0.002467] RAMDISK: [mem 0x7e4ad000-0x7fffffff]
[    0.002471] ACPI: Early table checksum verification disabled
[    0.002474] ACPI: RSDP 0x000000008ED8E014 000024 (v02 APPLE )
[    0.002478] ACPI: XSDT 0x000000008ED8E1C0 0000A4 (v01 APPLE  Apple00  0000F000      01000013)
[    0.002482] ACPI: FACP 0x000000008ED8C000 0000F4 (v04 APPLE  Apple00  0000F000 Loki 0000005F)
[    0.002487] ACPI: DSDT 0x000000008ED81000 0053FB (v01 APPLE  iMac     00210001 INTL 20061109)
[    0.002490] ACPI: FACS 0x000000008ED3E000 000040
[    0.002492] ACPI: FACS 0x000000008ED3E000 000040
[    0.002494] ACPI: HPET 0x000000008ED8B000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002497] ACPI: APIC 0x000000008ED8A000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002499] ACPI: SBST 0x000000008ED88000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002502] ACPI: ECDT 0x000000008ED87000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002505] ACPI: SSDT 0x000000008ED7E000 00020D (v01 APPLE  SataAhci 00001000 INTL 20061109)
[    0.002507] ACPI: SSDT 0x000000008ED7C000 0000B1 (v01 APPLE  SmcDppt  00001000 INTL 20061109)
[    0.002510] ACPI: SSDT 0x000000008ED7A000 000646 (v01 APPLE  UsbNoRmh 00001000 INTL 20061109)
[    0.002512] ACPI: SSDT 0x000000008ED78000 00013D (v01 APPLE  SataPrt1 00001000 INTL 20061109)
[    0.002515] ACPI: SSDT 0x000000008ED77000 0000A0 (v02 APPLE  IGHda    00001000 INTL 20061109)
[    0.002517] ACPI: SSDT 0x000000008ED75000 000032 (v01 APPLE  SsdtS3   00001000 INTL 20061109)
[    0.002520] ACPI: SSDT 0x000000008ED74000 000548 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.002522] ACPI: SSDT 0x000000008ED73000 0009B1 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.002525] ACPI: SSDT 0x000000008ED72000 000315 (v01 PmRef  Cpu0Tst  00003000 INTL 20061109)
[    0.002528] ACPI: SSDT 0x000000008ED71000 00037A (v01 PmRef  ApTst    00003000 INTL 20061109)
[    0.002530] ACPI: MCFG 0x000000008ED89000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002532] ACPI: Reserving FACP table memory at [mem 0x8ed8c000-0x8ed8c0f3]
[    0.002534] ACPI: Reserving DSDT table memory at [mem 0x8ed81000-0x8ed863fa]
[    0.002535] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002536] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002537] ACPI: Reserving HPET table memory at [mem 0x8ed8b000-0x8ed8b037]
[    0.002538] ACPI: Reserving APIC table memory at [mem 0x8ed8a000-0x8ed8a0bb]
[    0.002539] ACPI: Reserving SBST table memory at [mem 0x8ed88000-0x8ed8802f]
[    0.002540] ACPI: Reserving ECDT table memory at [mem 0x8ed87000-0x8ed87052]
[    0.002541] ACPI: Reserving SSDT table memory at [mem 0x8ed7e000-0x8ed7e20c]
[    0.002542] ACPI: Reserving SSDT table memory at [mem 0x8ed7c000-0x8ed7c0b0]
[    0.002544] ACPI: Reserving SSDT table memory at [mem 0x8ed7a000-0x8ed7a645]
[    0.002545] ACPI: Reserving SSDT table memory at [mem 0x8ed78000-0x8ed7813c]
[    0.002546] ACPI: Reserving SSDT table memory at [mem 0x8ed77000-0x8ed7709f]
[    0.002547] ACPI: Reserving SSDT table memory at [mem 0x8ed75000-0x8ed75031]
[    0.002548] ACPI: Reserving SSDT table memory at [mem 0x8ed74000-0x8ed74547]
[    0.002549] ACPI: Reserving SSDT table memory at [mem 0x8ed73000-0x8ed739b0]
[    0.002550] ACPI: Reserving SSDT table memory at [mem 0x8ed72000-0x8ed72314]
[    0.002551] ACPI: Reserving SSDT table memory at [mem 0x8ed71000-0x8ed71379]
[    0.002552] ACPI: Reserving MCFG table memory at [mem 0x8ed89000-0x8ed8903b]
[    0.002559] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.002585] Zone ranges:
[    0.002586]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002588]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002589]   Normal   [mem 0x0000000100000000-0x000000086fefffff]
[    0.002590] Movable zone start for each node
[    0.002591] Early memory node ranges
[    0.002592]   node   0: [mem 0x0000000000001000-0x000000000008dfff]
[    0.002593]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.002594]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.002595]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.002596]   node   0: [mem 0x0000000040200000-0x000000008ed32fff]
[    0.002597]   node   0: [mem 0x000000008ed5f000-0x000000008ed70fff]
[    0.002598]   node   0: [mem 0x000000008ed8f000-0x000000008ee5afff]
[    0.002599]   node   0: [mem 0x000000008ee8f000-0x000000008eed6fff]
[    0.002600]   node   0: [mem 0x000000008eeff000-0x000000008efa2fff]
[    0.002601]   node   0: [mem 0x0000000100000000-0x000000086fefffff]
[    0.002604] Initmem setup node 0 [mem 0x0000000000001000-0x000000086fefffff]
[    0.002608] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002609] On node 0, zone DMA: 2 pages in unavailable ranges
[    0.002628] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.004122] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006366] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006372] On node 0, zone DMA32: 44 pages in unavailable ranges
[    0.006374] On node 0, zone DMA32: 30 pages in unavailable ranges
[    0.006376] On node 0, zone DMA32: 52 pages in unavailable ranges
[    0.006378] On node 0, zone DMA32: 40 pages in unavailable ranges
[    0.060489] On node 0, zone Normal: 4189 pages in unavailable ranges
[    0.060496] On node 0, zone Normal: 256 pages in unavailable ranges
[    0.060658] ACPI: PM-Timer IO Port: 0x408
[    0.060664] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.060666] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.060667] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.060668] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.060669] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.060670] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.060670] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.060671] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.060680] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.060683] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.060684] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.060688] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.060689] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.060692] TSC deadline timer available
[    0.060693] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.060714] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.060716] PM: hibernation: Registered nosave memory: [mem 0x0008e000-0x0008ffff]
[    0.060718] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
[    0.060719] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.060721] PM: hibernation: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.060723] PM: hibernation: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.060725] PM: hibernation: Registered nosave memory: [mem 0x899b1000-0x899b1fff]
[    0.060726] PM: hibernation: Registered nosave memory: [mem 0x899cc000-0x899ccfff]
[    0.060728] PM: hibernation: Registered nosave memory: [mem 0x89a4f000-0x89a4ffff]
[    0.060730] PM: hibernation: Registered nosave memory: [mem 0x89a60000-0x89a60fff]
[    0.060732] PM: hibernation: Registered nosave memory: [mem 0x8ed33000-0x8ed5efff]
[    0.060734] PM: hibernation: Registered nosave memory: [mem 0x8ed71000-0x8ed8efff]
[    0.060735] PM: hibernation: Registered nosave memory: [mem 0x8ee5b000-0x8ee8efff]
[    0.060737] PM: hibernation: Registered nosave memory: [mem 0x8eed7000-0x8eefefff]
[    0.060739] PM: hibernation: Registered nosave memory: [mem 0x8efa3000-0x8f8fffff]
[    0.060740] PM: hibernation: Registered nosave memory: [mem 0x8f900000-0xe00f7fff]
[    0.060741] PM: hibernation: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.060742] PM: hibernation: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff]
[    0.060743] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.060743] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xffed7fff]
[    0.060744] PM: hibernation: Registered nosave memory: [mem 0xffed8000-0xffefffff]
[    0.060745] PM: hibernation: Registered nosave memory: [mem 0xfff00000-0xffffffff]
[    0.060747] [mem 0x8f900000-0xe00f7fff] available for PCI devices
[    0.060750] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.063046] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.063213] percpu: Embedded 44 pages/cpu s139880 r8192 d32152 u262144
[    0.063220] pcpu-alloc: s139880 r8192 d32152 u262144 alloc=1*2097152
[    0.063222] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.063243] Built 1 zonelists, mobility grouping on.  Total pages: 8251733
[    0.063245] Kernel command line: ro root=UUID=de35d1a6-e0e1-40b0-b46a-3974a04adf4b libata.allow_tpm=1 netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da oops=panic panic=10 thunderbolt.dyndbg pci=assign-busses,realloc,hpbussize=0x10,hpmmiosize=128M,hpmmioprefsize=1G initrd=boot\initrd.img-5.17.0+
[    0.063305] Unknown kernel command line parameters "netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da", will be passed to user space.
[    0.064928] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.065750] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.065814] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.152435] Memory: 32777104K/33531496K available (8192K kernel code, 2298K rwdata, 1860K rodata, 956K init, 2628K bss, 754136K reserved, 0K cma-reserved)
[    0.152469] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.152683] Dynamic Preempt: voluntary
[    0.152706] rcu: Preemptible hierarchical RCU implementation.
[    0.152708] 	Trampoline variant of Tasks RCU enabled.
[    0.152709] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.152718] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
[    0.152909] random: get_random_bytes called from start_kernel+0x443/0x5fb with crng_init=0
[    0.152933] Console: colour dummy device 80x25
[    0.153202] printk: console [tty0] enabled
[    0.153210] ACPI: Core revision 20211217
[    0.153295] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.153310] APIC: Switch to symmetric I/O mode setup
[    0.153689] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.203313] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x31015a3e4e5, max_idle_ns: 440795312435 ns
[    0.203318] Calibrating delay loop (skipped), value calculated using timer frequency.. 6799.48 BogoMIPS (lpj=33997410)
[    0.203322] pid_max: default: 32768 minimum: 301
[    0.207607] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.207671] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.207790] CPU0: Thermal monitoring enabled (TM1)
[    0.207794] process: using mwait in idle threads
[    0.207797] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.207799] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.207802] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.207805] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.207806] Spectre V2 : Vulnerable
[    0.207809] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.207811] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.207813] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.207816] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.207818] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.207821] MDS: Mitigation: Clear CPU buffers
[    0.207979] Freeing SMP alternatives memory: 24K
[    0.208248] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1054
[    0.208255] smpboot: CPU0: Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz (family: 0x6, model: 0x2a, stepping: 0x7)
[    0.208319] cblist_init_generic: Setting adjustable number of callback queues.
[    0.208324] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.208334] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.208347] ... version:                3
[    0.208349] ... bit width:              48
[    0.208351] ... generic registers:      4
[    0.208352] ... value mask:             0000ffffffffffff
[    0.208354] ... max period:             00007fffffffffff
[    0.208356] ... fixed-purpose events:   3
[    0.208357] ... event mask:             000000070000000f
[    0.208434] rcu: Hierarchical SRCU implementation.
[    0.208533] smp: Bringing up secondary CPUs ...
[    0.208578] x86: Booting SMP configuration:
[    0.208580] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.216851] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.216851]  #5 #6 #7
[    0.226647] smp: Brought up 1 node, 8 CPUs
[    0.226647] smpboot: Max logical packages: 1
[    0.226647] smpboot: Total of 8 processors activated (54395.85 BogoMIPS)
[    0.228833] devtmpfs: initialized
[    0.228833] ACPI: PM: Registering ACPI NVS region [mem 0x8ed33000-0x8ed5efff] (180224 bytes)
[    0.228833] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.228833] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.228833] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.228833] thermal_sys: Registered thermal governor 'step_wise'
[    0.228833] thermal_sys: Registered thermal governor 'user_space'
[    0.228833] cpuidle: using governor ladder
[    0.228833] cpuidle: using governor menu
[    0.228833] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.228833] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.228833] PCI: not using MMCONFIG
[    0.228833] PCI: Using configuration type 1 for base access
[    0.228833] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.233843] ACPI: Disabled all _OSI OS vendors
[    0.233843] ACPI: Added _OSI(Module Device)
[    0.233843] ACPI: Added _OSI(Processor Device)
[    0.233843] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.233843] ACPI: Added _OSI(Processor Aggregator Device)
[    0.233843] ACPI: Added _OSI(Linux-Dell-Video)
[    0.233843] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.233843] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.233843] ACPI: Added _OSI(Darwin)
[    0.235643] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.235845] ACPI: EC: EC started
[    0.235847] ACPI: EC: interrupt blocked
[    0.236349] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.236351] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.236480] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.236612] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.236814] ACPI: Dynamic OEM Table Load:
[    0.236821] ACPI: SSDT 0xFFFF888100379800 000781 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.237138] ACPI: Dynamic OEM Table Load:
[    0.237144] ACPI: SSDT 0xFFFF88810036E800 0003A4 (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.237376] ACPI: Dynamic OEM Table Load:
[    0.237381] ACPI: SSDT 0xFFFF8881000FA600 000119 (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.238160] ACPI: Interpreter enabled
[    0.238174] ACPI: PM: (supports S0 S3 S4 S5)
[    0.238176] ACPI: Using IOAPIC for interrupt routing
[    0.238194] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.238404] PCI: MMCONFIG at [mem 0xe0000000-0xefbfffff] reserved in ACPI motherboard resources
[    0.238417] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.238510] ACPI: Enabled 6 GPEs in block 00 to 3F
[    0.241368] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.241374] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.241379] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-fb] only partially covers this bridge
[    0.241515] PCI host bridge to bus 0000:00
[    0.241518] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.241521] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.241524] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.241527] pci_bus 0000:00: root bus resource [mem 0x8f900000-0xfeafffff window]
[    0.241530] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.241533] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.241543] pci 0000:00:00.0: [8086:0100] type 00 class 0x060000
[    0.241605] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
[    0.241633] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.241688] pci 0000:00:02.0: [8086:0102] type 00 class 0x038000
[    0.241696] pci 0000:00:02.0: reg 0x10: [mem 0xa8000000-0xa83fffff 64bit]
[    0.241701] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xa7ffffff 64bit pref]
[    0.241706] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.241776] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.241796] pci 0000:00:16.0: reg 0x10: [mem 0xa8907100-0xa890710f 64bit]
[    0.241862] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.241908] pci 0000:00:1a.0: [8086:1c2c] type 00 class 0x0c0300
[    0.241946] pci 0000:00:1a.0: reg 0x20: [io  0x3140-0x315f]
[    0.242029] pci 0000:00:1a.7: [8086:1c2d] type 00 class 0x0c0320
[    0.242045] pci 0000:00:1a.7: reg 0x10: [mem 0xa8906c00-0xa8906fff]
[    0.242121] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.242287] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.242303] pci 0000:00:1b.0: reg 0x10: [mem 0xa8900000-0xa8903fff 64bit]
[    0.242364] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.242422] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.242501] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.242568] pci 0000:00:1c.1: [8086:1c12] type 01 class 0x060400
[    0.242647] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.243346] pci 0000:00:1c.2: [8086:1c14] type 01 class 0x060400
[    0.243426] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.243491] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    0.243570] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.243634] pci 0000:00:1d.0: [8086:1c27] type 00 class 0x0c0300
[    0.243672] pci 0000:00:1d.0: reg 0x20: [io  0x30e0-0x30ff]
[    0.243755] pci 0000:00:1d.7: [8086:1c26] type 00 class 0x0c0320
[    0.243770] pci 0000:00:1d.7: reg 0x10: [mem 0xa8906800-0xa8906bff]
[    0.243846] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.244009] pci 0000:00:1f.0: [8086:1c44] type 00 class 0x060100
[    0.244152] pci 0000:00:1f.2: [8086:1c02] type 00 class 0x010601
[    0.244165] pci 0000:00:1f.2: reg 0x10: [io  0x3168-0x316f]
[    0.244172] pci 0000:00:1f.2: reg 0x14: [io  0x317c-0x317f]
[    0.244180] pci 0000:00:1f.2: reg 0x18: [io  0x3160-0x3167]
[    0.244187] pci 0000:00:1f.2: reg 0x1c: [io  0x3178-0x317b]
[    0.244194] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
[    0.244202] pci 0000:00:1f.2: reg 0x24: [mem 0xa8906000-0xa89067ff]
[    0.244236] pci 0000:00:1f.2: PME# supported from D3hot
[    0.244282] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    0.244297] pci 0000:00:1f.3: reg 0x10: [mem 0xa8907000-0xa89070ff 64bit]
[    0.244312] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.244414] pci 0000:01:00.0: [1002:6720] type 00 class 0x030000
[    0.244430] pci 0000:01:00.0: reg 0x10: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.244441] pci 0000:01:00.0: reg 0x18: [mem 0xa8800000-0xa881ffff 64bit]
[    0.244448] pci 0000:01:00.0: reg 0x20: [io  0x2000-0x20ff]
[    0.244461] pci 0000:01:00.0: reg 0x30: [mem 0xa8820000-0xa883ffff pref]
[    0.244468] pci 0000:01:00.0: enabling Extended Tags
[    0.244478] pci 0000:01:00.0: BAR 0: assigned to efifb
[    0.244507] pci 0000:01:00.0: supports D1 D2
[    0.244595] pci 0000:01:00.1: [1002:aa88] type 00 class 0x040300
[    0.244609] pci 0000:01:00.1: reg 0x10: [mem 0xa8840000-0xa8843fff 64bit]
[    0.244634] pci 0000:01:00.1: enabling Extended Tags
[    0.244670] pci 0000:01:00.1: supports D1 D2
[    0.244762] pci 0000:00:01.0: PCI bridge to [bus 01-ff]
[    0.244765] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.244768] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.244772] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.244775] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.244848] pci 0000:02:00.0: [14e4:16b4] type 00 class 0x020000
[    0.244882] pci 0000:02:00.0: reg 0x10: [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.244904] pci 0000:02:00.0: reg 0x18: [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.245059] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.245173] pci 0000:00:1c.0: PCI bridge to [bus 02-ff]
[    0.245180] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.245186] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.245189] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    0.245260] pci 0000:03:00.0: [168c:0030] type 00 class 0x028000
[    0.245291] pci 0000:03:00.0: reg 0x10: [mem 0xa8600000-0xa861ffff 64bit]
[    0.245351] pci 0000:03:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    0.245442] pci 0000:03:00.0: supports D1 D2
[    0.245444] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.245544] pci 0000:00:1c.1: PCI bridge to [bus 03-ff]
[    0.245550] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.245557] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.245628] pci 0000:04:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.245662] pci 0000:04:00.0: reg 0x10: [mem 0xa8500000-0xa8500fff 64bit]
[    0.245824] pci 0000:04:00.0: supports D1 D2
[    0.245827] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246021] pci 0000:00:1c.2: PCI bridge to [bus 04-ff]
[    0.246028] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.246034] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.246107] pci 0000:05:00.0: [8086:1513] type 01 class 0x060400
[    0.246172] pci 0000:05:00.0: enabling Extended Tags
[    0.246267] pci 0000:05:00.0: supports D1 D2
[    0.246269] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246395] pci 0000:00:1c.4: PCI bridge to [bus 05-ff]
[    0.246400] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.246404] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xacefffff]
[    0.246410] pci 0000:00:1c.4:   bridge window [mem 0xacf00000-0xb0efffff 64bit pref]
[    0.246495] acpiphp: Slot [3] registered
[    0.246517] acpiphp: Slot [4] registered
[    0.246558] pci 0000:06:00.0: [8086:1513] type 01 class 0x060400
[    0.246629] pci 0000:06:00.0: enabling Extended Tags
[    0.246729] pci 0000:06:00.0: supports D1 D2
[    0.246731] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246843] pci 0000:06:03.0: [8086:1513] type 01 class 0x060400
[    0.246904] pci 0000:06:03.0: enabling Extended Tags
[    0.247005] pci 0000:06:03.0: supports D1 D2
[    0.247007] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247113] pci 0000:06:04.0: [8086:1513] type 01 class 0x060400
[    0.247173] pci 0000:06:04.0: enabling Extended Tags
[    0.247275] pci 0000:06:04.0: supports D1 D2
[    0.247277] pci 0000:06:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247384] pci 0000:06:05.0: [8086:1513] type 01 class 0x060400
[    0.247444] pci 0000:06:05.0: enabling Extended Tags
[    0.247546] pci 0000:06:05.0: supports D1 D2
[    0.247548] pci 0000:06:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247657] pci 0000:06:06.0: [8086:1513] type 01 class 0x060400
[    0.247718] pci 0000:06:06.0: enabling Extended Tags
[    0.247819] pci 0000:06:06.0: supports D1 D2
[    0.247821] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247937] pci 0000:05:00.0: PCI bridge to [bus 06-ff]
[    0.247949] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa8efffff]
[    0.248054] acpiphp: Slot [1] registered
[    0.248095] pci 0000:07:00.0: [8086:1513] type 00 class 0x088000
[    0.248123] pci 0000:07:00.0: reg 0x10: [mem 0xa8a00000-0xa8a3ffff]
[    0.248139] pci 0000:07:00.0: reg 0x14: [mem 0xa8a40000-0xa8a40fff]
[    0.248219] pci 0000:07:00.0: enabling Extended Tags
[    0.248344] pci 0000:07:00.0: supports D1 D2
[    0.248346] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248487] pci 0000:06:00.0: PCI bridge to [bus 07-ff]
[    0.248500] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.248508] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    0.248565] pci 0000:06:03.0: PCI bridge to [bus 08-ff]
[    0.248577] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.248586] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 17
[    0.248647] pci 0000:06:04.0: PCI bridge to [bus 18-ff]
[    0.248659] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.248668] pci_bus 0000:18: busn_res: [bus 18-ff] end is updated to 27
[    0.248728] pci 0000:06:05.0: PCI bridge to [bus 28-ff]
[    0.248740] pci 0000:06:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.248749] pci_bus 0000:28: busn_res: [bus 28-ff] end is updated to 37
[    0.248805] pci 0000:06:06.0: PCI bridge to [bus 38-ff]
[    0.248817] pci 0000:06:06.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.248826] pci_bus 0000:38: busn_res: [bus 38-ff] end is updated to 47
[    0.248832] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 47
[    0.248838] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 47
[    0.248842] pci_bus 0000:00: on NUMA node 0
[    0.249094] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.249097] ACPI: PCI: Interrupt link LNKA disabled
[    0.249128] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.249131] ACPI: PCI: Interrupt link LNKB disabled
[    0.249160] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.249162] ACPI: PCI: Interrupt link LNKC disabled
[    0.249191] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.249193] ACPI: PCI: Interrupt link LNKD disabled
[    0.249221] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.249224] ACPI: PCI: Interrupt link LNKE disabled
[    0.249252] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.249254] ACPI: PCI: Interrupt link LNKF disabled
[    0.249282] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.249284] ACPI: PCI: Interrupt link LNKG disabled
[    0.249312] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.249315] ACPI: PCI: Interrupt link LNKH disabled
[    0.249400] ACPI: EC: interrupt unblocked
[    0.249402] ACPI: EC: event unblocked
[    0.249407] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.249409] ACPI: EC: GPE=0x17
[    0.249410] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.249413] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.249469] SCSI subsystem initialized
[    0.249475] libata version 3.00 loaded.
[    0.249475] Registered efivars operations
[    0.249475] PCI: Using ACPI for IRQ routing
[    0.256644] PCI: pci_cache_line_size set to 64 bytes
[    0.256712] e820: reserve RAM buffer [mem 0x0008e000-0x0008ffff]
[    0.256714] e820: reserve RAM buffer [mem 0x899b1018-0x8bffffff]
[    0.256715] e820: reserve RAM buffer [mem 0x89a4f018-0x8bffffff]
[    0.256716] e820: reserve RAM buffer [mem 0x8ed33000-0x8fffffff]
[    0.256717] e820: reserve RAM buffer [mem 0x8ed71000-0x8fffffff]
[    0.256719] e820: reserve RAM buffer [mem 0x8ee5b000-0x8fffffff]
[    0.256720] e820: reserve RAM buffer [mem 0x8eed7000-0x8fffffff]
[    0.256721] e820: reserve RAM buffer [mem 0x8efa3000-0x8fffffff]
[    0.256722] e820: reserve RAM buffer [mem 0x86ff00000-0x86fffffff]
[    0.256731] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.256731] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.256731] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.256731] vgaarb: loaded
[    0.256731] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.256731] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.256731] clocksource: Switched to clocksource tsc-early
[    0.256731] VFS: Disk quotas dquot_6.6.0
[    0.256731] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.256731] pnp: PnP ACPI init
[    0.256731] system 00:00: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.256731] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.256731] system 00:01: [io  0x1000-0x100f] has been reserved
[    0.256731] system 00:01: [io  0xffff] has been reserved
[    0.256731] system 00:01: [io  0xffff] has been reserved
[    0.256731] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.256731] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.256731] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.256731] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.256731] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.256731] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.256731] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.256731] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.256731] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.256731] system 00:03: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.256731] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.256731] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[    0.256731] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.256760] pnp: PnP ACPI: found 4 devices
[    0.256776] pci 0000:01:00.0: assigning 74 device properties
[    0.256776] pci 0000:04:00.0: assigning 2 device properties
[    0.256776] pci 0000:07:00.0: assigning 3 device properties
[    0.256776] pci 0000:00:1b.0: assigning 4 device properties
[    0.259086] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.259108] NET: Registered PF_INET protocol family
[    0.259266] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.261123] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.261161] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.261427] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.261513] TCP: Hash tables configured (established 262144 bind 65536)
[    0.261539] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.261600] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.261681] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.261689] pci 0000:03:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[    0.261695] pci_bus 0000:00: max bus depth: 3 pci_try_num: 4
[    0.261704] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.261707] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.261711] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.261714] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.261719] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.261724] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.261728] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.261736] pci 0000:03:00.0: BAR 6: assigned [mem 0xa8620000-0xa862ffff pref]
[    0.261739] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.261744] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.261752] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.261757] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.261766] pci 0000:05:00.0: BAR 9: no space for [mem size 0x100000000 64bit pref]
[    0.261769] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x100000000 64bit pref]
[    0.261773] pci 0000:05:00.0: BAR 7: no space for [io  size 0x4000]
[    0.261775] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.261779] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.261782] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.261785] pci 0000:06:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.261788] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.261791] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.261794] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.261797] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.261800] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.261803] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.261805] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.261807] pci 0000:06:04.0: BAR 7: no space for [io  size 0x1000]
[    0.261810] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.261812] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.261814] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.261817] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.261819] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.261822] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.261829] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.261841] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.261847] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.261859] pci 0000:06:04.0: PCI bridge to [bus 18-27]
[    0.261866] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.261878] pci 0000:06:05.0: PCI bridge to [bus 28-37]
[    0.261885] pci 0000:06:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.261896] pci 0000:06:06.0: PCI bridge to [bus 38-47]
[    0.261903] pci 0000:06:06.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.261915] pci 0000:05:00.0: PCI bridge to [bus 06-47]
[    0.261922] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa8efffff]
[    0.261933] pci 0000:00:1c.4: PCI bridge to [bus 05-47]
[    0.261936] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.261941] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xacefffff]
[    0.261945] pci 0000:00:1c.4:   bridge window [mem 0xacf00000-0xb0efffff 64bit pref]
[    0.261952] pci_bus 0000:00: No. 2 try to assign unassigned res
[    0.261957] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.261959] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.261962] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.261965] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.261969] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.261974] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.261978] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.261985] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.261989] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.261997] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.262002] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.262010] pci 0000:05:00.0: BAR 9: no space for [mem size 0x100000000 64bit pref]
[    0.262013] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x100000000 64bit pref]
[    0.262016] pci 0000:05:00.0: BAR 7: no space for [io  size 0x4000]
[    0.262019] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.262022] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262025] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262028] pci 0000:06:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262031] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262034] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262036] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262039] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262042] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262045] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.262047] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.262050] pci 0000:06:04.0: BAR 7: no space for [io  size 0x1000]
[    0.262052] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.262054] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.262057] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.262059] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.262061] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.262064] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.262071] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.262083] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.262089] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.262101] pci 0000:06:04.0: PCI bridge to [bus 18-27]
[    0.262108] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.262120] pci 0000:06:05.0: PCI bridge to [bus 28-37]
[    0.262126] pci 0000:06:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.262138] pci 0000:06:06.0: PCI bridge to [bus 38-47]
[    0.262145] pci 0000:06:06.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.262157] pci 0000:05:00.0: PCI bridge to [bus 06-47]
[    0.262163] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa8efffff]
[    0.262175] pci 0000:00:1c.4: PCI bridge to [bus 05-47]
[    0.262178] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.262182] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xacefffff]
[    0.262187] pci 0000:00:1c.4:   bridge window [mem 0xacf00000-0xb0efffff 64bit pref]
[    0.262193] pci_bus 0000:00: No. 3 try to assign unassigned res
[    0.262195] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.262196] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.262197] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.262200] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.262205] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xa8bfffff] released
[    0.262207] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.262213] pci 0000:06:04.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.262215] pci 0000:06:04.0: PCI bridge to [bus 18-27]
[    0.262220] pci 0000:06:05.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.262223] pci 0000:06:05.0: PCI bridge to [bus 28-37]
[    0.262228] pci 0000:06:06.0: resource 8 [mem 0xa8e00000-0xa8efffff] released
[    0.262230] pci 0000:06:06.0: PCI bridge to [bus 38-47]
[    0.262235] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xa8efffff] released
[    0.262238] pci 0000:05:00.0: PCI bridge to [bus 06-47]
[    0.262243] pci 0000:00:1c.4: resource 7 [io  0x4000-0x4fff] released
[    0.262246] pci 0000:00:1c.4: PCI bridge to [bus 05-47]
[    0.262252] pci 0000:00:1c.4: resource 9 [mem 0xacf00000-0xb0efffff 64bit pref] released
[    0.262255] pci 0000:00:1c.4: PCI bridge to [bus 05-47]
[    0.262266] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x100000000 64bit pref]
[    0.262270] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x100000000 64bit pref]
[    0.262273] pci 0000:00:1c.4: BAR 7: assigned [io  0x4000-0x7fff]
[    0.262276] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.262278] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.262281] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.262284] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.262288] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.262293] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.262297] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.262303] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.262308] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.262316] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.262320] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.262329] pci 0000:05:00.0: BAR 8: no space for [mem size 0x20100000]
[    0.262331] pci 0000:05:00.0: BAR 8: failed to assign [mem size 0x20100000]
[    0.262334] pci 0000:05:00.0: BAR 9: no space for [mem size 0x100000000 64bit pref]
[    0.262337] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x100000000 64bit pref]
[    0.262340] pci 0000:05:00.0: BAR 7: assigned [io  0x4000-0x7fff]
[    0.262343] pci 0000:06:00.0: BAR 8: no space for [mem size 0x00100000]
[    0.262345] pci 0000:06:00.0: BAR 8: failed to assign [mem size 0x00100000]
[    0.262348] pci 0000:06:03.0: BAR 8: no space for [mem size 0x08000000]
[    0.262350] pci 0000:06:03.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.262353] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262356] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262358] pci 0000:06:04.0: BAR 8: no space for [mem size 0x08000000]
[    0.262361] pci 0000:06:04.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.262363] pci 0000:06:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262366] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262369] pci 0000:06:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.262371] pci 0000:06:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.262374] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262377] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262380] pci 0000:06:06.0: BAR 8: no space for [mem size 0x08000000]
[    0.262382] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.262385] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262387] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262390] pci 0000:06:03.0: BAR 7: assigned [io  0x4000-0x4fff]
[    0.262393] pci 0000:06:04.0: BAR 7: assigned [io  0x5000-0x5fff]
[    0.262395] pci 0000:06:05.0: BAR 7: assigned [io  0x6000-0x6fff]
[    0.262398] pci 0000:06:06.0: BAR 7: assigned [io  0x7000-0x7fff]
[    0.262400] pci 0000:07:00.0: BAR 0: no space for [mem size 0x00040000]
[    0.262403] pci 0000:07:00.0: BAR 0: failed to assign [mem size 0x00040000]
[    0.262405] pci 0000:07:00.0: BAR 1: no space for [mem size 0x00001000]
[    0.262408] pci 0000:07:00.0: BAR 1: failed to assign [mem size 0x00001000]
[    0.262410] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.262426] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.262430] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.262446] pci 0000:06:04.0: PCI bridge to [bus 18-27]
[    0.262450] pci 0000:06:04.0:   bridge window [io  0x5000-0x5fff]
[    0.262466] pci 0000:06:05.0: PCI bridge to [bus 28-37]
[    0.262470] pci 0000:06:05.0:   bridge window [io  0x6000-0x6fff]
[    0.262486] pci 0000:06:06.0: PCI bridge to [bus 38-47]
[    0.262490] pci 0000:06:06.0:   bridge window [io  0x7000-0x7fff]
[    0.262506] pci 0000:05:00.0: PCI bridge to [bus 06-47]
[    0.262510] pci 0000:05:00.0:   bridge window [io  0x4000-0x7fff]
[    0.262526] pci 0000:00:1c.4: PCI bridge to [bus 05-47]
[    0.262529] pci 0000:00:1c.4:   bridge window [io  0x4000-0x7fff]
[    0.262533] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xacefffff]
[    0.262541] pci_bus 0000:00: No. 4 try to assign unassigned res
[    0.262544] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xacefffff] released
[    0.262547] pci 0000:00:1c.4: PCI bridge to [bus 05-47]
[    0.262551] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.262552] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.262554] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.262558] release child resource [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.262559] release child resource [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.262560] pci 0000:00:1c.0: resource 9 [mem 0xa8400000-0xa84fffff 64bit pref] released
[    0.262562] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.262569] release child resource [mem 0xa8600000-0xa861ffff 64bit]
[    0.262570] release child resource [mem 0xa8620000-0xa862ffff pref]
[    0.262571] pci 0000:00:1c.1: resource 8 [mem 0xa8600000-0xa86fffff] released
[    0.262573] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.262577] release child resource [mem 0xa8500000-0xa8500fff 64bit]
[    0.262578] pci 0000:00:1c.2: resource 8 [mem 0xa8500000-0xa85fffff] released
[    0.262580] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.262589] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.262593] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.262596] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.262599] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.262602] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xc8afffff]
[    0.262606] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x100000000 64bit pref]
[    0.262609] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x100000000 64bit pref]
[    0.262612] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.262621] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.262623] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.262626] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.262629] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.262633] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.262649] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.262664] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.262669] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.262673] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.262680] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.262694] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.262697] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.262702] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.262710] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.262725] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.262730] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.262738] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xc8afffff]
[    0.262741] pci 0000:05:00.0: BAR 9: no space for [mem size 0x100000000 64bit pref]
[    0.262744] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x100000000 64bit pref]
[    0.262748] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.262750] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.262753] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262756] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262759] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xb8afffff]
[    0.262761] pci 0000:06:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262764] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262767] pci 0000:06:05.0: BAR 8: assigned [mem 0xb8b00000-0xc0afffff]
[    0.262770] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262773] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262776] pci 0000:06:06.0: BAR 8: assigned [mem 0xc0b00000-0xc8afffff]
[    0.262778] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.262781] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.262785] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.262791] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.262797] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.262804] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.262816] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.262820] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.262826] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.262838] pci 0000:06:04.0: PCI bridge to [bus 18-27]
[    0.262842] pci 0000:06:04.0:   bridge window [io  0x5000-0x5fff]
[    0.262849] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xb8afffff]
[    0.262860] pci 0000:06:05.0: PCI bridge to [bus 28-37]
[    0.262864] pci 0000:06:05.0:   bridge window [io  0x6000-0x6fff]
[    0.262871] pci 0000:06:05.0:   bridge window [mem 0xb8b00000-0xc0afffff]
[    0.262883] pci 0000:06:06.0: PCI bridge to [bus 38-47]
[    0.262886] pci 0000:06:06.0:   bridge window [io  0x7000-0x7fff]
[    0.262893] pci 0000:06:06.0:   bridge window [mem 0xc0b00000-0xc8afffff]
[    0.262905] pci 0000:05:00.0: PCI bridge to [bus 06-47]
[    0.262908] pci 0000:05:00.0:   bridge window [io  0x4000-0x7fff]
[    0.262915] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xc8afffff]
[    0.262926] pci 0000:00:1c.4: PCI bridge to [bus 05-47]
[    0.262929] pci 0000:00:1c.4:   bridge window [io  0x4000-0x7fff]
[    0.262934] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xc8afffff]
[    0.262942] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.262945] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.262947] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.262950] pci_bus 0000:00: resource 7 [mem 0x8f900000-0xfeafffff window]
[    0.262953] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff window]
[    0.262955] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.262957] pci_bus 0000:01: resource 1 [mem 0xa8800000-0xa88fffff]
[    0.262960] pci_bus 0000:01: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.262963] pci_bus 0000:02: resource 1 [mem 0xa8700000-0xa87fffff]
[    0.262965] pci_bus 0000:02: resource 2 [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.262968] pci_bus 0000:03: resource 1 [mem 0x8fa00000-0x8fafffff]
[    0.262970] pci_bus 0000:04: resource 1 [mem 0x8fb00000-0x8fbfffff]
[    0.262972] pci_bus 0000:05: resource 0 [io  0x4000-0x7fff]
[    0.262975] pci_bus 0000:05: resource 1 [mem 0xa8a00000-0xc8afffff]
[    0.262977] pci_bus 0000:06: resource 0 [io  0x4000-0x7fff]
[    0.262979] pci_bus 0000:06: resource 1 [mem 0xa8a00000-0xc8afffff]
[    0.262982] pci_bus 0000:07: resource 1 [mem 0xa8a00000-0xa8afffff]
[    0.262984] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    0.262986] pci_bus 0000:08: resource 1 [mem 0xa8b00000-0xb0afffff]
[    0.262988] pci_bus 0000:18: resource 0 [io  0x5000-0x5fff]
[    0.262991] pci_bus 0000:18: resource 1 [mem 0xb0b00000-0xb8afffff]
[    0.262993] pci_bus 0000:28: resource 0 [io  0x6000-0x6fff]
[    0.262995] pci_bus 0000:28: resource 1 [mem 0xb8b00000-0xc0afffff]
[    0.262998] pci_bus 0000:38: resource 0 [io  0x7000-0x7fff]
[    0.263000] pci_bus 0000:38: resource 1 [mem 0xc0b00000-0xc8afffff]
[    0.263430] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.263462] PCI: CLS 256 bytes, default 64
[    0.263501] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.263504] software IO TLB: mapped [mem 0x0000000083000000-0x0000000087000000] (64MB)
[    0.263511] ACPI: bus type thunderbolt registered
[    0.263531] Trying to unpack rootfs image as initramfs...
[    0.263655] thunderbolt 0000:07:00.0: total paths: 32
[    0.263829] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.263849] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.263861] thunderbolt 0000:07:00.0: control channel created
[    0.263864] thunderbolt 0000:07:00.0: ICM not supported on this controller
[    0.263874] thunderbolt 0000:07:00.0: freeing RX ring 0
[    0.263881] thunderbolt 0000:07:00.0: freeing TX ring 0
[    0.263891] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.263899] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.263907] thunderbolt 0000:07:00.0: control channel created
[    0.263908] thunderbolt 0000:07:00.0: using software connection manager
[    0.263923] thunderbolt 0000:07:00.0: created link from 0000:06:03.0
[    0.263935] thunderbolt 0000:07:00.0: created link from 0000:06:04.0
[    0.263945] thunderbolt 0000:07:00.0: created link from 0000:06:05.0
[    0.263956] thunderbolt 0000:07:00.0: created link from 0000:06:06.0
[    0.264007] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[    0.264009] thunderbolt 0000:07:00.0: control channel starting...
[    0.264010] thunderbolt 0000:07:00.0: starting TX ring 0
[    0.264018] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.264020] thunderbolt 0000:07:00.0: starting RX ring 0
[    0.264028] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38204 bit 0 (0x0 -> 0x1)
[    0.264031] thunderbolt 0000:07:00.0: security level set to user
[    0.264186] thunderbolt 0000:07:00.0: current switch config:
[    0.264188] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.264190] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.264192] thunderbolt 0000:07:00.0:   Config:
[    0.264192] thunderbolt 0000:07:00.0:    Upstream Port Number: 6 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.264194] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.268795] thunderbolt 0000:07:00.0: initializing Switch at 0x0 (depth: 0, up port: 6)
[    0.269307] thunderbolt 0000:07:00.0: 0: DROM version: 1
[    0.270842] thunderbolt 0000:07:00.0: 0: uid: 0x1000a13f2da20
[    0.273786] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.273788] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.273790] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.273791] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.273792] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.276729] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.276731] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.276732] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.276733] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.276734] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.279673] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.279675] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.279676] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.279677] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.279678] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.280314] random: fast init done
[    0.282618] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.282620] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.282621] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.282622] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.282622] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.282624] thunderbolt 0000:07:00.0: 0:5: disabled by eeprom
[    0.283514] thunderbolt 0000:07:00.0:  Port 6: 8086:1513 (Revision: 2, TB Version: 1, Type: NHI (0x2))
[    0.283516] thunderbolt 0000:07:00.0:   Max hop id (in/out): 31/31
[    0.283517] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.283518] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.283519] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.284410] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.284412] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.284413] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.284414] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.284415] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.285306] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.285308] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.285309] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.285309] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.285310] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.286202] thunderbolt 0000:07:00.0:  Port 9: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.286204] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.286205] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.286206] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.286206] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.287098] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.287100] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.287101] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.287102] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.287103] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.288250] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    0.288252] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.288253] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.288254] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.288255] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.289146] thunderbolt 0000:07:00.0:  Port 12: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.289148] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.289149] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.289150] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.289151] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.290042] thunderbolt 0000:07:00.0:  Port 13: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.290044] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.290045] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.290046] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.290047] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.306383] thunderbolt 0000:07:00.0: 0: TMU: current mode: HiFi
[    0.306511] thunderbolt 0000:07:00.0: 0:1: is unplugged (state: 7)
[    0.306638] thunderbolt 0000:07:00.0: 0:3: is unplugged (state: 7)
[    0.307535] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    0.307536] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
[    0.307704] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
[    0.307711] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    0.307713] RAPL PMU: hw unit of domain package 2^-16 Joules
[    0.307715] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[    0.308322] Initialise system trusted keyrings
[    0.308342] workingset: timestamp_bits=62 max_order=23 bucket_order=0
[    0.309043] Key type asymmetric registered
[    0.309046] Asymmetric key parser 'x509' registered
[    0.309057] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    0.309888] pcieport 0000:06:03.0: enabling device (0000 -> 0003)
[    0.309973] pcieport 0000:06:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    0.310128] pcieport 0000:06:04.0: enabling device (0000 -> 0003)
[    0.310200] pcieport 0000:06:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    0.310346] pcieport 0000:06:05.0: enabling device (0000 -> 0003)
[    0.310416] pcieport 0000:06:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    0.310558] pcieport 0000:06:06.0: enabling device (0000 -> 0003)
[    0.310626] pcieport 0000:06:06.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    0.319731] brd: module loaded
[    0.319979] Intel(R) 2.5G Ethernet Linux Driver
[    0.319983] Copyright(c) 2018 Intel Corporation.
[    0.320034] i8042: PNP: No PS/2 controller found.
[    0.320071] mousedev: PS/2 mouse device common for all mice
[    0.320196] intel_pstate: Intel P-state driver initializing
[    0.320314] efifb: probing for efifb
[    0.320331] efifb: framebuffer at 0x90010000, using 14400k, total 14400k
[    0.320333] efifb: mode is 2560x1440x32, linelength=10240, pages=1
[    0.320336] efifb: scrolling: redraw
[    0.320337] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.329847] Console: switching to colour frame buffer device 320x90
[    0.338924] fb0: EFI VGA frame buffer device
[    0.339018] Key type dns_resolver registered
[    0.339081] microcode: sig=0x206a7, pf=0x2, revision=0x2f
[    0.339244] microcode: Microcode Update Driver: v2.2.
[    0.339247] IPI shorthand broadcast: enabled
[    0.339304] sched_clock: Marking stable (338821064, 418411)->(351133395, -11893920)
[    0.339365] registered taskstats version 1
[    0.339390] Loading compiled-in X.509 certificates
[    0.509968] Freeing initrd memory: 27980K
[    0.510364] Freeing unused kernel image (initmem) memory: 956K
[    0.573487] Write protecting the kernel read-only data: 12288k
[    0.574175] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    0.574237] Freeing unused kernel image (rodata/data gap) memory: 188K
[    0.574268] Run /init as init process
[    0.574283]   with arguments:
[    0.574284]     /init
[    0.574285]   with environment:
[    0.574285]     HOME=/
[    0.574286]     TERM=linux
[    0.574287]     netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da
[    0.618160] udevd[818]: starting version 3.2.9
[    0.618352] random: udevd: uninitialized urandom read (16 bytes read)
[    0.618397] random: udevd: uninitialized urandom read (16 bytes read)
[    0.618941] udevd[819]: starting eudev-3.2.9
[    0.626378] random: udevd: uninitialized urandom read (16 bytes read)
[    0.633744] ACPI: bus type USB registered
[    0.633793] usbcore: registered new interface driver usbfs
[    0.633827] usbcore: registered new interface driver hub
[    0.633861] usbcore: registered new device driver usb
[    0.635165] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.635198] ACPI: bus type drm_connector registered
[    0.635420] ehci-pci: EHCI PCI platform driver
[    0.635556] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.635596] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.635639] ehci-pci 0000:00:1a.7: debug port 2
[    0.635656] uhci_hcd: USB Universal Host Controller Interface driver
[    0.635690] ahci 0000:00:1f.2: version 3.0
[    0.636016] cryptd: max_cpu_qlen set to 1000
[    0.637174] AVX version of gcm_enc/dec engaged.
[    0.637218] AES CTR mode by8 optimization enabled
[    0.639598] ehci-pci 0000:00:1a.7: irq 23, io mem 0xa8906c00
[    0.646071] radeon: unknown parameter 'pm' ignored
[    0.646158] [drm] radeon kernel modesetting enabled.
[    0.646206] checking generic (90010000 e10000) vs hw (90000000 10000000)
[    0.646207] fb0: switching to radeon from EFI VGA
[    0.646304] Console: switching to colour dummy device 80x25
[    0.646358] radeon 0000:01:00.0: vgaarb: deactivate vga console
[    0.646522] [drm] initializing kernel modesetting (BARTS 0x1002:0x6720 0x106B:0x0B00 0x00).
[    0.646527] radeon 0000:01:00.0: vram limit (0) must be a power of 2
[    0.653595] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x7 impl SATA mode
[    0.653706] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst
[    0.663346] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.663377] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    0.663382] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.663385] usb usb1: Product: EHCI Host Controller
[    0.663387] usb usb1: Manufacturer: Linux 5.17.0+ ehci_hcd
[    0.663389] usb usb1: SerialNumber: 0000:00:1a.7
[    0.663506] hub 1-0:1.0: USB hub found
[    0.663559] hub 1-0:1.0: 6 ports detected
[    0.663772] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.663783] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 2
[    0.663824] uhci_hcd 0000:00:1a.0: detected 2 ports
[    0.663953] uhci_hcd 0000:00:1a.0: irq 21, io port 0x00003140
[    0.664073] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    0.664078] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.664081] usb usb2: Product: UHCI Host Controller
[    0.664083] usb usb2: Manufacturer: Linux 5.17.0+ uhci_hcd
[    0.664085] usb usb2: SerialNumber: 0000:00:1a.0
[    0.664159] hub 2-0:1.0: USB hub found
[    0.664169] hub 2-0:1.0: 2 ports detected
[    0.664365] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    0.664373] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 3
[    0.664482] ehci-pci 0000:00:1d.7: debug port 2
[    0.668523] ehci-pci 0000:00:1d.7: irq 22, io mem 0xa8906800
[    0.693361] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.693432] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    0.693437] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.693440] usb usb3: Product: EHCI Host Controller
[    0.693442] usb usb3: Manufacturer: Linux 5.17.0+ ehci_hcd
[    0.693444] usb usb3: SerialNumber: 0000:00:1d.7
[    0.693707] hub 3-0:1.0: USB hub found
[    0.693716] hub 3-0:1.0: 8 ports detected
[    0.694057] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.694066] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    0.694102] uhci_hcd 0000:00:1d.0: detected 2 ports
[    0.694225] uhci_hcd 0000:00:1d.0: irq 19, io port 0x000030e0
[    0.694373] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    0.694379] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.694385] usb usb4: Product: UHCI Host Controller
[    0.694388] usb usb4: Manufacturer: Linux 5.17.0+ uhci_hcd
[    0.694392] usb usb4: SerialNumber: 0000:00:1d.0
[    0.694597] hub 4-0:1.0: USB hub found
[    0.694609] hub 4-0:1.0: 2 ports detected
[    0.703534] firewire_ohci 0000:04:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    0.714061] scsi host0: ahci
[    0.714248] scsi host1: ahci
[    0.714550] scsi host2: ahci
[    0.714715] scsi host3: ahci
[    0.714828] scsi host4: ahci
[    0.714906] scsi host5: ahci
[    0.714947] ata1: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906100 irq 44
[    0.714959] ata2: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906180 irq 44
[    0.714970] ata3: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906200 irq 44
[    0.714974] ata4: DUMMY
[    0.714977] ata5: DUMMY
[    0.714980] ata6: DUMMY
[    0.948048] ATOM BIOS: Apple
[    0.948194] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    0.948198] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    0.948204] [drm] Detected VRAM RAM=1024M, BAR=256M
[    0.948206] [drm] RAM width 256bits DDR
[    0.948223] [drm] radeon: 1024M of VRAM memory ready
[    0.948225] [drm] radeon: 1024M of GTT memory ready.
[    0.948231] [drm] Loading BARTS Microcode
[    0.948281] [drm] External GPIO thermal controller with fan control
[    0.948295] == power state 0 ==
[    0.948297] 	ui class: none
[    0.948299] 	internal class: boot
[    0.948301] 	caps:
[    0.948302] 	uvd    vclk: 0 dclk: 0
[    0.948304] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    0.948306] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    0.948308] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    0.948309] 	status: c r b
[    0.948312] == power state 1 ==
[    0.948313] 	ui class: performance
[    0.948314] 	internal class: none
[    0.948316] 	caps:
[    0.948317] 	uvd    vclk: 0 dclk: 0
[    0.948318] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    0.948320] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    0.948322] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    0.948324] 	status:
[    0.948325] == power state 2 ==
[    0.948326] 	ui class: none
[    0.948327] 	internal class: uvd
[    0.948329] 	caps: video
[    0.948330] 	uvd    vclk: 54000 dclk: 40000
[    0.948332] 		power level 0    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    0.948334] 		power level 1    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    0.948336] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    0.948337] 	status:
[    0.948339] == power state 3 ==
[    0.948340] 	ui class: none
[    0.948341] 	internal class: uvd_mvc
[    0.948342] 	caps: video
[    0.948344] 	uvd    vclk: 70000 dclk: 56000
[    0.948345] 		power level 0    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    0.948347] 		power level 1    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    0.948349] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    0.948351] 	status:
[    0.948352] == power state 4 ==
[    0.948353] 	ui class: battery
[    0.948354] 	internal class: none
[    0.948356] 	caps:
[    0.948357] 	uvd    vclk: 0 dclk: 0
[    0.948358] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    0.948360] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    0.948362] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    0.948364] 	status:
[    0.953223] [drm] radeon: dpm initialized
[    0.953276] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    0.953703] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    0.965568] [drm] PCIE GART of 1024M enabled (table at 0x0000000000162000).
[    0.965668] radeon 0000:01:00.0: WB enabled
[    0.965671] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00
[    0.965673] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c
[    0.966420] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118
[    0.966936] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    0.966985] radeon 0000:01:00.0: radeon: using MSI.
[    0.967014] [drm] radeon: irq initialized.
[    0.983325] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    0.983341] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    0.983379] [drm] ring test on 0 succeeded in 1 usecs
[    0.983391] [drm] ring test on 3 succeeded in 6 usecs
[    1.053339] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.053361] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.053386] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.054986] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    1.055062] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    1.055070] ata2.00: supports DRM functions and may not be fully accessible
[    1.055075] ata2.00: ATA-9: Samsung SSD 850 EVO 500GB, EMT02B6Q, max UDMA/133
[    1.055116] ata1.00: supports DRM functions and may not be fully accessible
[    1.055121] ata1.00: ATA-9: Samsung SSD 850 PRO 256GB, EXM03B6Q, max UDMA/133
[    1.055228] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    1.055234] ata3.00: ATAPI: OPTIARC DVD RW AD-5690H, 4AH5, max UDMA/100
[    1.055695] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.055745] ata1.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.057329] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    1.057338] ata3.00: configured for UDMA/100
[    1.057661] ata2.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    1.057780] ata1.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    1.057994] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    1.058080] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    1.058087] ata2.00: supports DRM functions and may not be fully accessible
[    1.058116] ata1.00: supports DRM functions and may not be fully accessible
[    1.060745] ata1.00: configured for UDMA/133
[    1.060857] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 850  3B6Q PQ: 0 ANSI: 5
[    1.060885] ata2.00: configured for UDMA/133
[    1.061105] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 850  2B6Q PQ: 0 ANSI: 5
[    1.062539] scsi 2:0:0:0: CD-ROM            OPTIARC  DVD RW AD-5690H  4AH5 PQ: 0 ANSI: 5
[    1.160524] [drm] ring test on 5 succeeded in 2 usecs
[    1.160536] [drm] UVD initialized successfully.
[    1.160659] [drm] ib test on ring 0 succeeded in 0 usecs
[    1.160764] [drm] ib test on ring 3 succeeded in 0 usecs
[    1.183782] usb 3-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    1.183788] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.184057] hub 3-1:1.0: USB hub found
[    1.184265] hub 3-1:1.0: 4 ports detected
[    1.213408] firewire_core 0000:04:00.0: created device fw0: GUID a4b197fffe3f2da2, S800
[    1.213418] firewire_core 0000:04:00.0: phy config: new root=ffc0, gap_count=63
[    1.225131] tg3 0000:02:00.0 eth0: Tigon3 [partno(BCM957765) rev 57785100] (PCI Express) MAC address 3c:07:54:14:b2:08
[    1.225138] tg3 0000:02:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.225141] tg3 0000:02:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.225145] tg3 0000:02:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.353372] tsc: Refined TSC clocksource calibration: 3400.023 MHz
[    1.353390] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x31026473058, max_idle_ns: 440795314252 ns
[    1.353502] clocksource: Switched to clocksource tsc
[    1.354006] usb 1-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    1.354012] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.354303] hub 1-1:1.0: USB hub found
[    1.354388] hub 1-1:1.0: 3 ports detected
[    1.356445] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    1.356461] sd 0:0:0:0: [sda] Write Protect is off
[    1.356467] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.356474] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    1.356483] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.356485] sd 1:0:0:0: [sdb] Write Protect is off
[    1.356493] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.356502] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.358800] sd 1:0:0:0: [sdb] supports TCG Opal
[    1.358804] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.358939]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[    1.359813] sd 0:0:0:0: [sda] supports TCG Opal
[    1.359817] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.360297] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.360324] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    1.360350] sr 2:0:0:0: Attached scsi generic sg2 type 5
[    1.455637] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda caddy
[    1.455646] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.503373] usb 3-1.1: new high-speed USB device number 3 using ehci-pci
[    1.503375] usb 1-2: new high-speed USB device number 3 using ehci-pci
[    1.524492] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    1.659016] usb 3-1.1: New USB device found, idVendor=05ac, idProduct=8403, bcdDevice=98.33
[    1.659022] usb 3-1.1: New USB device strings: Mfr=3, Product=4, SerialNumber=2
[    1.659025] usb 3-1.1: Product: Card Reader
[    1.659027] usb 3-1.1: Manufacturer: Apple
[    1.659029] usb 3-1.1: SerialNumber: 000000009833
[    1.661033] usb-storage 3-1.1:1.0: USB Mass Storage device detected
[    1.661105] scsi host6: usb-storage 3-1.1:1.0
[    1.661177] usbcore: registered new interface driver usb-storage
[    1.661435] usbcore: registered new interface driver uas
[    1.716763] usb 1-2: New USB device found, idVendor=05ac, idProduct=850b, bcdDevice= 7.55
[    1.716769] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.716772] usb 1-2: Product: FaceTime HD Camera (Built-in)
[    1.716774] usb 1-2: Manufacturer: Apple Inc.
[    1.716776] usb 1-2: SerialNumber: CCGB8K062WDDJRLX
[    1.753372] usb 3-1.2: new low-speed USB device number 4 using ehci-pci
[    1.803371] usb 1-1.1: new full-speed USB device number 4 using ehci-pci
[    1.813527] [drm] ib test on ring 5 succeeded
[    1.883371] [drm] radeon atom DIG backlight initialized
[    1.883382] [drm] Radeon Display Connectors
[    1.883386] [drm] Connector 0:
[    1.883390] [drm]   eDP-1
[    1.883393] [drm]   HPD3
[    1.883396] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[    1.883402] [drm]   Encoders:
[    1.883405] [drm]     LCD1: INTERNAL_UNIPHY2
[    1.883408] [drm] Connector 1:
[    1.883411] [drm]   DP-1
[    1.883413] [drm]   HPD1
[    1.883416] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    1.883422] [drm]   Encoders:
[    1.883425] [drm]     DFP1: INTERNAL_UNIPHY1
[    1.883428] [drm] Connector 2:
[    1.883430] [drm]   DP-2
[    1.883433] [drm]   HPD2
[    1.883435] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[    1.883441] [drm]   Encoders:
[    1.883444] [drm]     DFP2: INTERNAL_UNIPHY1
[    1.883447] [drm] Connector 3:
[    1.883449] [drm]   DP-3
[    1.883452] [drm]   HPD4
[    1.883454] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[    1.883460] [drm]   Encoders:
[    1.883462] [drm]     DFP3: INTERNAL_UNIPHY2
[    1.883465] [drm] Connector 4:
[    1.883468] [drm]   DP-4
[    1.883478] [drm]   HPD5
[    1.883479] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 0x647c 0x647c
[    1.883481] [drm]   Encoders:
[    1.883483] [drm]     DFP4: INTERNAL_UNIPHY
[    1.883484] [drm] Connector 5:
[    1.883485] [drm]   VGA-1
[    1.883486] [drm]   DDC: 0x64d8 0x64d8 0x64dc 0x64dc 0x64e0 0x64e0 0x64e4 0x64e4
[    1.883488] [drm]   Encoders:
[    1.883489] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    1.910390] usb 3-1.2: New USB device found, idVendor=05ac, idProduct=8242, bcdDevice= 0.16
[    1.910396] usb 3-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.910399] usb 3-1.2: Product: IR Receiver
[    1.910401] usb 3-1.2: Manufacturer: Apple Computer, Inc.
[    1.913641] hid: raw HID events driver (C) Jiri Kosina
[    1.913729] switching from power state:
[    1.913736] 	ui class: none
[    1.913739] 	internal class: boot
[    1.913744] 	caps:
[    1.913746] 	uvd    vclk: 0 dclk: 0
[    1.913749] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    1.913751] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    1.913753] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    1.913755] 	status: c b
[    1.913757] switching to power state:
[    1.913759] 	ui class: performance
[    1.913760] 	internal class: none
[    1.913764] 	caps:
[    1.913767] 	uvd    vclk: 0 dclk: 0
[    1.913770] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    1.913774] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    1.913776] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    1.913778] 	status: r
[    1.916040] usbcore: registered new interface driver usbhid
[    1.916044] usbhid: USB HID core driver
[    1.916839] input: Apple Computer, Inc. IR Receiver as /devices/pci0000:00/0000:00:1d.7/usb3/3-1/3-1.2/3-1.2:1.0/0003:05AC:8242.0001/input/input0
[    1.955731] usb 1-1.1: New USB device found, idVendor=0a5c, idProduct=4500, bcdDevice= 1.00
[    1.955745] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.955751] usb 1-1.1: Product: BRCM2046 Hub
[    1.955756] usb 1-1.1: Manufacturer: Apple Inc.
[    1.956041] hub 1-1.1:1.0: USB hub found
[    1.956258] hub 1-1.1:1.0: 3 ports detected
[    1.983417] appleir 0003:05AC:8242.0001: input,hiddev96,hidraw0: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.7-1.2/input0
[    2.003323] usb 3-1.4: new low-speed USB device number 5 using ehci-pci
[    2.053327] usb 1-1.2: new high-speed USB device number 5 using ehci-pci
[    2.159005] usb 3-1.4: New USB device found, idVendor=047d, idProduct=1020, bcdDevice= 1.06
[    2.159010] usb 3-1.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.159021] usb 3-1.4: Product: Kensington Expert Mouse
[    2.162134] input: Kensington Expert Mouse as /devices/pci0000:00/0000:00:1d.7/usb3/3-1/3-1.4/3-1.4:1.0/0003:047D:1020.0002/input/input1
[    2.162254] hid-generic 0003:047D:1020.0002: input,hidraw1: USB HID v1.11 Mouse [Kensington Expert Mouse] on usb-0000:00:1d.7-1.4/input0
[    2.212129] usb 1-1.2: New USB device found, idVendor=05ac, idProduct=1006, bcdDevice=96.15
[    2.212135] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.212146] usb 1-1.2: Product: Keyboard Hub
[    2.212149] usb 1-1.2: Manufacturer: Apple, Inc.
[    2.212151] usb 1-1.2: SerialNumber: 000000000000
[    2.212384] hub 1-1.2:1.0: USB hub found
[    2.212475] hub 1-1.2:1.0: 3 ports detected
[    2.303330] usb 1-1.1.1: new full-speed USB device number 6 using ehci-pci
[    2.458041] usb 1-1.1.1: New USB device found, idVendor=05ac, idProduct=8215, bcdDevice= 2.08
[    2.458047] usb 1-1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.458050] usb 1-1.1.1: Product: Bluetooth USB Host Controller
[    2.458052] usb 1-1.1.1: Manufacturer: Apple Inc.
[    2.458054] usb 1-1.1.1: SerialNumber: 3451C9ED7F9B
[    2.553327] usb 1-1.2.2: new low-speed USB device number 7 using ehci-pci
[    2.705215] scsi 6:0:0:0: Direct-Access     APPLE    SD Card Reader   1.00 PQ: 0 ANSI: 0
[    2.705422] sd 6:0:0:0: Attached scsi generic sg3 type 0
[    2.706171] sd 6:0:0:0: [sdc] Media removed, stopped polling
[    2.707037] sd 6:0:0:0: [sdc] Attached SCSI removable disk
[    2.710129] usb 1-1.2.2: New USB device found, idVendor=05ac, idProduct=0220, bcdDevice= 0.71
[    2.710135] usb 1-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.710139] usb 1-1.2.2: Product: Apple Keyboard
[    2.710141] usb 1-1.2.2: Manufacturer: Apple, Inc
[    2.716730] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.0/0003:05AC:0220.0003/input/input2
[    2.783446] apple 0003:05AC:0220.0003: input,hidraw2: USB HID v1.11 Keyboard [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input0
[    2.783515] apple 0003:05AC:0220.0004: Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling
[    2.783538] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.1/0003:05AC:0220.0004/input/input3
[    2.803327] usb 1-1.1.2: new full-speed USB device number 8 using ehci-pci
[    2.853435] apple 0003:05AC:0220.0004: input,hidraw3: USB HID v1.11 Device [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input1
[    2.956914] usb 1-1.1.2: New USB device found, idVendor=05ac, idProduct=820a, bcdDevice= 1.00
[    2.956920] usb 1-1.1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.958791] input: HID 05ac:820a as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:05AC:820A.0005/input/input4
[    3.023513] hid-generic 0003:05AC:820A.0005: input,hidraw4: USB HID v1.11 Keyboard [HID 05ac:820a] on usb-0000:00:1a.7-1.1.2/input0
[    3.143358] usb 1-1.1.3: new full-speed USB device number 9 using ehci-pci
[    3.156821] [drm] fb mappable at 0x90363000
[    3.156825] [drm] vram apper at 0x90000000
[    3.156827] [drm] size 14745600
[    3.156828] [drm] fb depth is 24
[    3.156829] [drm]    pitch is 10240
[    3.156922] fbcon: radeondrmfb (fb0) is primary device
[    3.296894] usb 1-1.1.3: New USB device found, idVendor=05ac, idProduct=820b, bcdDevice= 1.00
[    3.296896] usb 1-1.1.3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.298761] input: HID 05ac:820b as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.0/0003:05AC:820B.0006/input/input5
[    3.298942] hid-generic 0003:05AC:820B.0006: input,hidraw5: USB HID v1.11 Mouse [HID 05ac:820b] on usb-0000:00:1a.7-1.1.3/input0
[    3.998003] switching from power state:
[    3.998005] 	ui class: performance
[    3.998006] 	internal class: none
[    3.998007] 	caps:
[    3.998007] 	uvd    vclk: 0 dclk: 0
[    3.998008] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    3.998009] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    3.998010] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    3.998011] 	status: c r
[    3.998012] switching to power state:
[    3.998012] 	ui class: performance
[    3.998012] 	internal class: none
[    3.998013] 	caps:
[    3.998013] 	uvd    vclk: 0 dclk: 0
[    3.998014] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    3.998015] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    3.998015] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    3.998016] 	status: c r
[    5.113858] Console: switching to colour frame buffer device 320x90
[    5.117515] radeon 0000:01:00.0: [drm] fb0: radeondrmfb frame buffer device
[    5.173472] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[    5.200405] [drm] amdgpu kernel modesetting enabled.
[    5.265466] netpoll: netconsole: local port 6666
[    5.265482] netpoll: netconsole: local IPv4 address 192.168.2.87
[    5.265494] netpoll: netconsole: interface 'eth0'
[    5.265503] netpoll: netconsole: remote port 6666
[    5.265512] netpoll: netconsole: remote IPv4 address 192.168.2.208
[    5.265523] netpoll: netconsole: remote ethernet address dc:a6:32:61:33:da
[    5.265539] netpoll: netconsole: device eth0 not up yet, forcing it
[    8.974159] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[    8.974175] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[    8.974188] tg3 0000:02:00.0 eth0: EEE is enabled
[    8.987693] printk: console [netcon0] enabled
[    8.987705] netconsole: network logging started
[   10.125434] thunderbolt 0000:07:00.0: acking hot plug event on 0:4
[   10.125567] thunderbolt 0000:07:00.0: 0:4: hotplug: scanning
[   10.125581] thunderbolt 0000:07:00.0: 0:4: hotplug: no switch found
[   10.142591] thunderbolt 0000:07:00.0: acking hot plug event on 0:3
[   10.142719] thunderbolt 0000:07:00.0: 0:3: hotplug: scanning
[   10.142805] thunderbolt 0000:07:00.0: 0:3: is connected, link is up (state: 2)
[   10.143036] thunderbolt 0000:07:00.0: current switch config:
[   10.143043] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   10.143048] thunderbolt 0000:07:00.0:   Max Port Number: 13
[   10.143051] thunderbolt 0000:07:00.0:   Config:
[   10.143053] thunderbolt 0000:07:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[   10.143057] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[   10.147638] thunderbolt 0000:07:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[   10.165137] thunderbolt 0000:07:00.0: 3: reading drom (length: 0x97)
[   10.659751] thunderbolt 0000:07:00.0: 3: DROM version: 1
[   10.660774] thunderbolt 0000:07:00.0: 3: uid: 0x1000100189170
[   10.663717] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   10.663725] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   10.663728] thunderbolt 0000:07:00.0:   Max counters: 32
[   10.663730] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   10.663732] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   10.666660] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   10.666668] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   10.666671] thunderbolt 0000:07:00.0:   Max counters: 32
[   10.666673] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   10.666676] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   10.669602] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   10.669607] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   10.669609] thunderbolt 0000:07:00.0:   Max counters: 32
[   10.669611] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   10.669613] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   10.672546] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   10.672550] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   10.672552] thunderbolt 0000:07:00.0:   Max counters: 32
[   10.672554] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   10.672556] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   10.672559] thunderbolt 0000:07:00.0: 3:5: disabled by eeprom
[   10.672561] thunderbolt 0000:07:00.0: 3:6: disabled by eeprom
[   10.673443] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   10.673447] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   10.673450] thunderbolt 0000:07:00.0:   Max counters: 1
[   10.673452] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   10.673454] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   10.674338] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   10.674342] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   10.674344] thunderbolt 0000:07:00.0:   Max counters: 1
[   10.674346] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   10.674348] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   10.674350] thunderbolt 0000:07:00.0: 3:9: disabled by eeprom
[   10.675234] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   10.675238] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   10.675240] thunderbolt 0000:07:00.0:   Max counters: 1
[   10.675242] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   10.675244] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   10.676386] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   10.676390] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[   10.676392] thunderbolt 0000:07:00.0:   Max counters: 2
[   10.676394] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   10.676396] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   10.676398] thunderbolt 0000:07:00.0: 3:c: disabled by eeprom
[   10.676400] thunderbolt 0000:07:00.0: 3:d: disabled by eeprom
[   10.694741] thunderbolt 0000:07:00.0: 3: TMU: current mode: bi-directional, HiFi
[   10.694798] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[   10.694835] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[   10.694926] thunderbolt 0000:07:00.0: 3:3: is connected, link is up (state: 2)
[   10.695182] thunderbolt 0000:07:00.0: current switch config:
[   10.695183] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   10.695185] thunderbolt 0000:07:00.0:   Max Port Number: 13
[   10.695186] thunderbolt 0000:07:00.0:   Config:
[   10.695187] thunderbolt 0000:07:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[   10.695196] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[   10.699794] thunderbolt 0000:07:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[   10.717244] thunderbolt 0000:07:00.0: 303: reading drom (length: 0x97)
[   10.958752] thunderbolt 0000:07:00.0: acking hot plug event on 303:b
[   10.958761] thunderbolt 0000:07:00.0: acking hot plug event on 303:b
[   11.010979] random: crng init done
[   11.011005] random: 1 urandom warning(s) missed due to ratelimiting
[   11.212737] thunderbolt 0000:07:00.0: 303: DROM version: 1
[   11.213799] thunderbolt 0000:07:00.0: 303: uid: 0x100010102a740
[   11.216752] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   11.216760] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   11.216763] thunderbolt 0000:07:00.0:   Max counters: 32
[   11.216765] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   11.216767] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   11.219694] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   11.219698] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   11.219701] thunderbolt 0000:07:00.0:   Max counters: 32
[   11.219702] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   11.219704] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   11.222638] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   11.222641] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   11.222644] thunderbolt 0000:07:00.0:   Max counters: 32
[   11.222646] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   11.222648] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   11.225582] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   11.225586] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   11.225588] thunderbolt 0000:07:00.0:   Max counters: 32
[   11.225590] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   11.225592] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   11.225594] thunderbolt 0000:07:00.0: 303:5: disabled by eeprom
[   11.225597] thunderbolt 0000:07:00.0: 303:6: disabled by eeprom
[   11.226478] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   11.226482] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   11.226484] thunderbolt 0000:07:00.0:   Max counters: 1
[   11.226486] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   11.226488] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   11.227374] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   11.227378] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   11.227380] thunderbolt 0000:07:00.0:   Max counters: 1
[   11.227381] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   11.227383] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   11.227385] thunderbolt 0000:07:00.0: 303:9: disabled by eeprom
[   11.228270] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   11.228274] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   11.228276] thunderbolt 0000:07:00.0:   Max counters: 1
[   11.228278] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   11.228280] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   11.229422] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   11.229426] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[   11.229428] thunderbolt 0000:07:00.0:   Max counters: 2
[   11.229430] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   11.229432] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   11.229434] thunderbolt 0000:07:00.0: 303:c: disabled by eeprom
[   11.229436] thunderbolt 0000:07:00.0: 303:d: disabled by eeprom
[   11.247507] thunderbolt 0000:07:00.0: 303: TMU: current mode: bi-directional, HiFi
[   11.247552] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[   11.247586] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[   11.247678] thunderbolt 0000:07:00.0: 303:1: is unplugged (state: 7)
[   11.247937] thunderbolt 0000:07:00.0: 303:b: DP adapter HPD set, queuing hotplug
[   11.248192] thunderbolt 0000:07:00.0: 3:b: DP adapter HPD set, queuing hotplug
[   11.248320] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[   11.248324] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   11.248449] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   11.248578] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[   11.248581] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 12
[   11.248584] thunderbolt 0000:07:00.0: 303:b: calculating available bandwidth
[   11.248704] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[   11.248707] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[   11.248832] thunderbolt 0000:07:00.0: 3:3: link total bandwidth 9000 Mb/s
[   11.248834] thunderbolt 0000:07:00.0: 303:3: link total bandwidth 9000 Mb/s
[   11.248837] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[   11.248847] thunderbolt 0000:07:00.0: 0:c <-> 303:b (DP): activating
[   11.248851] thunderbolt 0000:07:00.0: activating Video path from 0:12 to 303:11
[   11.248854] thunderbolt 0000:07:00.0: 303:4: adding 12 NFC credits to 0
[   11.248960] thunderbolt 0000:07:00.0: 3:2: adding 12 NFC credits to 0
[   11.249087] thunderbolt 0000:07:00.0: 0:c: adding 5 NFC credits to 0
[   11.249344] thunderbolt 0000:07:00.0: 303:4: Writing hop 2
[   11.249347] thunderbolt 0000:07:00.0: 303:4:  In HopID: 8 => Out port: 11 Out HopID: 9
[   11.249350] thunderbolt 0000:07:00.0: 303:4:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   11.249353] thunderbolt 0000:07:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[   11.249356] thunderbolt 0000:07:00.0: 303:4:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   11.249359] thunderbolt 0000:07:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.249600] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[   11.249602] thunderbolt 0000:07:00.0: 3:2:  In HopID: 8 => Out port: 4 Out HopID: 8
[   11.249605] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   11.249608] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   11.249611] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   11.249614] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.249855] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[   11.249858] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 4 Out HopID: 8
[   11.249861] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   11.249864] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[   11.249866] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   11.249869] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.249983] thunderbolt 0000:07:00.0: path activation complete
[   11.249986] thunderbolt 0000:07:00.0: activating AUX TX path from 0:12 to 303:11
[   11.250111] thunderbolt 0000:07:00.0: 303:4: Writing hop 2
[   11.250114] thunderbolt 0000:07:00.0: 303:4:  In HopID: 9 => Out port: 11 Out HopID: 8
[   11.250117] thunderbolt 0000:07:00.0: 303:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   11.250120] thunderbolt 0000:07:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[   11.250122] thunderbolt 0000:07:00.0: 303:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   11.250125] thunderbolt 0000:07:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.250368] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[   11.250370] thunderbolt 0000:07:00.0: 3:2:  In HopID: 9 => Out port: 4 Out HopID: 9
[   11.250373] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   11.250376] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   11.250378] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   11.250381] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.250623] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[   11.250626] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 4 Out HopID: 9
[   11.250629] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   11.250632] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[   11.250634] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   11.250637] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.250751] thunderbolt 0000:07:00.0: path activation complete
[   11.250753] thunderbolt 0000:07:00.0: activating AUX RX path from 303:11 to 0:12
[   11.250879] thunderbolt 0000:07:00.0: 0:4: Writing hop 2
[   11.250882] thunderbolt 0000:07:00.0: 0:4:  In HopID: 8 => Out port: 12 Out HopID: 8
[   11.250885] thunderbolt 0000:07:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   11.250888] thunderbolt 0000:07:00.0: 0:4:    Counter enabled: 0 Counter index: 2047
[   11.250890] thunderbolt 0000:07:00.0: 0:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   11.250893] thunderbolt 0000:07:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.251135] thunderbolt 0000:07:00.0: 3:4: Writing hop 1
[   11.251138] thunderbolt 0000:07:00.0: 3:4:  In HopID: 8 => Out port: 2 Out HopID: 8
[   11.251141] thunderbolt 0000:07:00.0: 3:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   11.251143] thunderbolt 0000:07:00.0: 3:4:    Counter enabled: 0 Counter index: 2047
[   11.251146] thunderbolt 0000:07:00.0: 3:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   11.251149] thunderbolt 0000:07:00.0: 3:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.251392] thunderbolt 0000:07:00.0: 303:b: Writing hop 0
[   11.251394] thunderbolt 0000:07:00.0: 303:b:  In HopID: 8 => Out port: 4 Out HopID: 8
[   11.251397] thunderbolt 0000:07:00.0: 303:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   11.251400] thunderbolt 0000:07:00.0: 303:b:    Counter enabled: 0 Counter index: 2047
[   11.251402] thunderbolt 0000:07:00.0: 303:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   11.251405] thunderbolt 0000:07:00.0: 303:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.251519] thunderbolt 0000:07:00.0: path activation complete
[   11.252928] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
[   11.252931] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   11.253055] thunderbolt 0000:07:00.0: 0:c: in use
[   11.253183] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   11.253311] thunderbolt 0000:07:00.0: 303:b: in use
[   11.253441] thunderbolt 0000:07:00.0: 3:b: DP OUT available
[   11.253444] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 13
[   11.253446] thunderbolt 0000:07:00.0: 3:b: calculating available bandwidth
[   11.253568] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[   11.253571] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[   11.253574] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[   11.253580] thunderbolt 0000:07:00.0: 0:d <-> 3:b (DP): activating
[   11.253583] thunderbolt 0000:07:00.0: activating Video path from 0:13 to 3:11
[   11.253586] thunderbolt 0000:07:00.0: 3:1: adding 12 NFC credits to 0
[   11.253696] thunderbolt 0000:07:00.0: 0:d: adding 5 NFC credits to 0
[   11.253951] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   11.253954] thunderbolt 0000:07:00.0: 3:1:  In HopID: 8 => Out port: 11 Out HopID: 9
[   11.253957] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   11.253960] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   11.253962] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   11.253965] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.254207] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[   11.254210] thunderbolt 0000:07:00.0: 0:d:  In HopID: 9 => Out port: 3 Out HopID: 8
[   11.254213] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   11.254216] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[   11.254218] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   11.254221] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.254335] thunderbolt 0000:07:00.0: path activation complete
[   11.254337] thunderbolt 0000:07:00.0: activating AUX TX path from 0:13 to 3:11
[   11.254464] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   11.254466] thunderbolt 0000:07:00.0: 3:1:  In HopID: 9 => Out port: 11 Out HopID: 8
[   11.254469] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   11.254472] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   11.254474] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   11.254477] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.254719] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[   11.254722] thunderbolt 0000:07:00.0: 0:d:  In HopID: 8 => Out port: 3 Out HopID: 9
[   11.254725] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   11.254728] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[   11.254730] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   11.254733] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.254847] thunderbolt 0000:07:00.0: path activation complete
[   11.254849] thunderbolt 0000:07:00.0: activating AUX RX path from 3:11 to 0:13
[   11.254975] thunderbolt 0000:07:00.0: 0:3: Writing hop 1
[   11.254978] thunderbolt 0000:07:00.0: 0:3:  In HopID: 8 => Out port: 13 Out HopID: 8
[   11.254981] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   11.254984] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   11.254986] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   11.254989] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.255231] thunderbolt 0000:07:00.0: 3:b: Writing hop 0
[   11.255234] thunderbolt 0000:07:00.0: 3:b:  In HopID: 8 => Out port: 1 Out HopID: 8
[   11.255237] thunderbolt 0000:07:00.0: 3:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   11.255240] thunderbolt 0000:07:00.0: 3:b:    Counter enabled: 0 Counter index: 2047
[   11.255242] thunderbolt 0000:07:00.0: 3:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   11.255245] thunderbolt 0000:07:00.0: 3:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   11.255359] thunderbolt 0000:07:00.0: path activation complete
[   12.053721] switching from power state:
[   12.053734] 	ui class: performance
[   12.053742] 	internal class: none
[   12.053751] 	caps:
[   12.053756] 	uvd    vclk: 0 dclk: 0
[   12.053763] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   12.053776] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[   12.053789] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[   12.053802] 	status: c r
[   12.053808] switching to power state:
[   12.054617] 	ui class: performance
[   12.055420] 	internal class: none
[   12.056214] 	caps:
[   12.057002] 	uvd    vclk: 0 dclk: 0
[   12.057786] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   12.058580] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[   12.059340] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[   12.060092] 	status: c r
[   16.064929]  sdb: sdb1
[   16.114586] process '/usr/bin/fstype' started with executable stack
[   16.139070] EXT4-fs (sda6): mounted filesystem with ordered data mode. Quota mode: none.
[   16.317180] udevd[1211]: starting version 3.2.9
[   16.340923] udevd[1212]: starting eudev-3.2.9
[   16.371186] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input6
[   16.372498] ACPI: button: Power Button [PWRB]
[   16.373686] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input7
[   16.375361] ACPI: button: Sleep Button [SLPB]
[   16.376505] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input8
[   16.385176] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): activating
[   16.385182] thunderbolt 0000:07:00.0: activating PCIe Down path from 0:7 to 3:10
[   16.385491] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   16.385494] thunderbolt 0000:07:00.0: 3:1:  In HopID: 10 => Out port: 10 Out HopID: 8
[   16.385497] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   16.385499] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   16.385501] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   16.385504] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   16.385767] thunderbolt 0000:07:00.0: 0:7: Writing hop 0
[   16.385770] thunderbolt 0000:07:00.0: 0:7:  In HopID: 8 => Out port: 3 Out HopID: 10
[   16.385771] thunderbolt 0000:07:00.0: 0:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   16.385773] thunderbolt 0000:07:00.0: 0:7:    Counter enabled: 0 Counter index: 2047
[   16.385774] thunderbolt 0000:07:00.0: 0:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   16.385775] thunderbolt 0000:07:00.0: 0:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   16.385793] thunderbolt 0000:07:00.0: path activation complete
[   16.385795] thunderbolt 0000:07:00.0: activating PCIe Up path from 3:10 to 0:7
[   16.385980] thunderbolt 0000:07:00.0: 0:3: Writing hop 1
[   16.385983] thunderbolt 0000:07:00.0: 0:3:  In HopID: 9 => Out port: 7 Out HopID: 8
[   16.385985] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   16.385987] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   16.385990] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   16.385992] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   16.386220] thunderbolt 0000:07:00.0: 3:a: Writing hop 0
[   16.386222] thunderbolt 0000:07:00.0: 3:a:  In HopID: 8 => Out port: 1 Out HopID: 9
[   16.386225] thunderbolt 0000:07:00.0: 3:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   16.386228] thunderbolt 0000:07:00.0: 3:a:    Counter enabled: 0 Counter index: 2047
[   16.386230] thunderbolt 0000:07:00.0: 3:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   16.386232] thunderbolt 0000:07:00.0: 3:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   16.386303] thunderbolt 0000:07:00.0: path activation complete
[   16.386334] pcieport 0000:06:04.0: pciehp: Slot(4-1): Card present
[   16.388174] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): activating
[   16.388179] thunderbolt 0000:07:00.0: activating PCIe Down path from 3:7 to 303:10
[   16.388446] thunderbolt 0000:07:00.0: 303:3: Writing hop 1
[   16.388450] thunderbolt 0000:07:00.0: 303:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[   16.388452] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   16.388456] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   16.388458] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   16.388461] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   16.388664] thunderbolt 0000:07:00.0: 3:7: Writing hop 0
[   16.388668] thunderbolt 0000:07:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[   16.388671] thunderbolt 0000:07:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   16.388673] thunderbolt 0000:07:00.0: 3:7:    Counter enabled: 0 Counter index: 2047
[   16.388675] thunderbolt 0000:07:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   16.388678] thunderbolt 0000:07:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   16.389008] thunderbolt 0000:07:00.0: path activation complete
[   16.389011] thunderbolt 0000:07:00.0: activating PCIe Up path from 303:10 to 3:7
[   16.389029] thunderbolt 0000:07:00.0: 3:3: Writing hop 1
[   16.389031] thunderbolt 0000:07:00.0: 3:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[   16.389034] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   16.389036] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[   16.389039] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   16.389041] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   16.392253] thunderbolt 0000:07:00.0: 303:a: Writing hop 0
[   16.392258] thunderbolt 0000:07:00.0: 303:a:  In HopID: 8 => Out port: 3 Out HopID: 8
[   16.392261] thunderbolt 0000:07:00.0: 303:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   16.392263] thunderbolt 0000:07:00.0: 303:a:    Counter enabled: 0 Counter index: 2047
[   16.392265] thunderbolt 0000:07:00.0: 303:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   16.392268] thunderbolt 0000:07:00.0: 303:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   16.392473] thunderbolt 0000:07:00.0: path activation complete
[   16.409513] mc: Linux media interface: v0.10
[   16.414093] videodev: Linux video capture interface: v2.00
[   16.416723] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[   16.417835] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[   16.421006] Bluetooth: Core ver 2.22
[   16.422147] NET: Registered PF_BLUETOOTH protocol family
[   16.423253] Bluetooth: HCI device and connection manager initialized
[   16.423357] ACPI: button: Power Button [PWRF]
[   16.424424] Bluetooth: HCI socket layer initialized
[   16.426528] Bluetooth: L2CAP socket layer initialized
[   16.427643] Bluetooth: SCO socket layer initialized
[   16.430278] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input9
[   16.434556] usbcore: registered new interface driver btusb
[   16.435894] usb 1-2: Found UVC 1.00 device FaceTime HD Camera (Built-in) (05ac:850b)
[   16.440269] snd_hda_codec_cirrus hdaudioC0D0: autoconfig for CS4206: line_outs=2 (0x9/0xb/0x0/0x0/0x0) type:speaker
[   16.441325] snd_hda_codec_cirrus hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   16.442357] snd_hda_codec_cirrus hdaudioC0D0:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[   16.443388] snd_hda_codec_cirrus hdaudioC0D0:    mono: mono_out=0x0
[   16.444394] snd_hda_codec_cirrus hdaudioC0D0:    dig-out=0x10/0x0
[   16.445409] snd_hda_codec_cirrus hdaudioC0D0:    inputs:
[   16.446319] snd_hda_codec_cirrus hdaudioC0D0:      Mic=0xd
[   16.447316] snd_hda_codec_cirrus hdaudioC0D0:      Line=0xc
[   16.448343] snd_hda_codec_cirrus hdaudioC0D0:    dig-in=0xf
[   16.456480] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   16.457685] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   16.458900] input: HDA Intel PCH SPDIF In as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   16.461199] input: FaceTime HD Camera (Built-in):  as /devices/pci0000:00/0000:00:1a.7/usb1/1-2/1-2:1.0/input/input13
[   16.462476] usbcore: registered new interface driver uvcvideo
[   16.514159] usb 1-1.1.2: USB disconnect, device number 8
[   16.565031] Bluetooth: hci0: BCM: chip id 254 build 0518
[   16.567037] Bluetooth: hci0: BCM: product 05ac:8215
[   16.569079] Bluetooth: hci0: BCM: features 0x00
[   16.573427] pci 0000:18:00.0: [8086:1513] type 01 class 0x060400
[   16.574591] pci 0000:18:00.0: enabling Extended Tags
[   16.575643] pci 0000:18:00.0: supports D1 D2
[   16.576455] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.586909] Bluetooth: hci0: Bluetooth USB Host Controller
[   16.594461] applesmc: key=332 fan=3 temp=50 index=49 acc=0 lux=2 kbd=0
[   16.595435] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   16.603389] pci 0000:18:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.604428] pci 0000:19:00.0: [8086:1513] type 01 class 0x060400
[   16.605426] pci 0000:19:00.0: enabling Extended Tags
[   16.606433] pci 0000:19:00.0: supports D1 D2
[   16.607243] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.608246] pci 0000:19:01.0: [8086:1513] type 01 class 0x060400
[   16.609321] pci 0000:19:01.0: enabling Extended Tags
[   16.610333] pci 0000:19:01.0: supports D1 D2
[   16.611158] pci 0000:19:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.612157] pci 0000:19:02.0: [8086:1513] type 01 class 0x060400
[   16.613194] pci 0000:19:02.0: enabling Extended Tags
[   16.614227] pci 0000:19:02.0: supports D1 D2
[   16.615048] pci 0000:19:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.616048] pci 0000:19:04.0: [8086:1513] type 01 class 0x060400
[   16.617075] pci 0000:19:04.0: enabling Extended Tags
[   16.618095] pci 0000:19:04.0: supports D1 D2
[   16.618914] pci 0000:19:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.619927] pci 0000:19:05.0: [8086:1513] type 01 class 0x060400
[   16.620942] pci 0000:19:05.0: enabling Extended Tags
[   16.621969] pci 0000:19:05.0: supports D1 D2
[   16.622791] pci 0000:19:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.623860] pci 0000:18:00.0: PCI bridge to [bus 19-27]
[   16.624824] pci 0000:18:00.0:   bridge window [io  0x0000-0x0fff]
[   16.625667] pci 0000:18:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.626515] pci 0000:18:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.627350] pci 0000:19:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.628206] pci 0000:19:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.629061] pci 0000:19:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.629901] pci 0000:19:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.630730] pci 0000:19:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.631723] pci 0000:1a:00.0: [12d8:400c] type 01 class 0x060400
[   16.633018] pci 0000:1a:00.0: supports D1 D2
[   16.633853] pci 0000:1a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.673403] pci 0000:19:00.0: PCI bridge to [bus 1a-27]
[   16.674252] pci 0000:19:00.0:   bridge window [io  0x0000-0x0fff]
[   16.675046] pci 0000:19:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.675844] pci 0000:19:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.676634] pci 0000:1a:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.677667] pci 0000:1b:03.0: [12d8:400c] type 01 class 0x060400
[   16.678859] pci 0000:1b:03.0: supports D1 D2
[   16.679638] pci 0000:1b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.680642] pci 0000:1a:00.0: PCI bridge to [bus 1b-27]
[   16.681536] pci 0000:1a:00.0:   bridge window [io  0x0000-0x0fff]
[   16.682320] pci 0000:1a:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.683103] pci 0000:1a:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.683889] pci 0000:1b:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.684861] pci 0000:1c:00.0: [12d8:400e] type 00 class 0x0c0310
[   16.685741] pci 0000:1c:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   16.686759] pci 0000:1c:00.0: supports D1 D2
[   16.687500] pci 0000:1c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.688413] pci 0000:1c:00.1: [12d8:400e] type 00 class 0x0c0310
[   16.689326] pci 0000:1c:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   16.690516] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   16.690570] pci 0000:1c:00.1: supports D1 D2
[   16.692399] pci 0000:1c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   16.693628] ohci-pci: OHCI PCI platform driver
[   16.693650] pci 0000:1c:00.2: [12d8:400f] type 00 class 0x0c0320
[   16.695576] pci 0000:1c:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   16.696632] pci 0000:1c:00.2: supports D1 D2
[   16.697393] pci 0000:1c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   16.698442] pci 0000:1b:03.0: PCI bridge to [bus 1c-27]
[   16.699311] pci 0000:1b:03.0:   bridge window [io  0x0000-0x0fff]
[   16.700091] pci 0000:1b:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.700852] pci 0000:1b:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.701594] pci_bus 0000:1c: busn_res: [bus 1c-27] end is updated to 1c
[   16.702336] pci_bus 0000:1b: busn_res: [bus 1b-27] end is updated to 1c
[   16.703073] pci_bus 0000:1a: busn_res: [bus 1a-27] end is updated to 1c
[   16.704018] pci 0000:1d:00.0: [14e4:16b0] type 00 class 0x020000
[   16.704898] pci 0000:1d:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   16.705689] pci 0000:1d:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   16.706748] pci 0000:1d:00.0: PME# supported from D0 D3hot D3cold
[   16.733429] pci 0000:19:01.0: PCI bridge to [bus 1d-27]
[   16.734193] pci 0000:19:01.0:   bridge window [io  0x0000-0x0fff]
[   16.734924] pci 0000:19:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.735654] pci 0000:19:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.736368] pci_bus 0000:1d: busn_res: [bus 1d-27] end is updated to 1d
[   16.737239] pci 0000:1e:00.0: [11c1:5901] type 00 class 0x0c0010
[   16.738087] pci 0000:1e:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   16.739112] pci 0000:1e:00.0: supports D1 D2
[   16.739812] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.763425] pci 0000:19:02.0: PCI bridge to [bus 1e-27]
[   16.764175] pci 0000:19:02.0:   bridge window [io  0x0000-0x0fff]
[   16.764887] pci 0000:19:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.765602] pci 0000:19:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.766304] pci_bus 0000:1e: busn_res: [bus 1e-27] end is updated to 1e
[   16.767204] pci 0000:1f:00.0: [8086:1513] type 01 class 0x060400
[   16.768126] pci 0000:1f:00.0: enabling Extended Tags
[   16.769089] pci 0000:1f:00.0: supports D1 D2
[   16.769786] pci 0000:1f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.793413] pci 0000:19:04.0: PCI bridge to [bus 1f-27]
[   16.794142] pci 0000:19:04.0:   bridge window [io  0x0000-0x0fff]
[   16.794824] pci 0000:19:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.795511] pci 0000:19:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.796188] pci 0000:1f:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.797105] pci 0000:20:00.0: [8086:1513] type 01 class 0x060400
[   16.798009] pci 0000:20:00.0: enabling Extended Tags
[   16.798948] pci 0000:20:00.0: supports D1 D2
[   16.799619] pci 0000:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.800539] pci 0000:20:01.0: [8086:1513] type 01 class 0x060400
[   16.801470] pci 0000:20:01.0: enabling Extended Tags
[   16.802407] pci 0000:20:01.0: supports D1 D2
[   16.803079] pci 0000:20:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.804039] pci 0000:20:02.0: [8086:1513] type 01 class 0x060400
[   16.804970] pci 0000:20:02.0: enabling Extended Tags
[   16.805908] pci 0000:20:02.0: supports D1 D2
[   16.806580] pci 0000:20:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.807500] pci 0000:20:04.0: [8086:1513] type 01 class 0x060400
[   16.808431] pci 0000:20:04.0: enabling Extended Tags
[   16.809372] pci 0000:20:04.0: supports D1 D2
[   16.810044] pci 0000:20:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.810966] pci 0000:20:05.0: [8086:1513] type 01 class 0x060400
[   16.811895] pci 0000:20:05.0: enabling Extended Tags
[   16.812837] pci 0000:20:05.0: supports D1 D2
[   16.813537] pci 0000:20:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.814511] pci 0000:1f:00.0: PCI bridge to [bus 20-27]
[   16.815302] pci 0000:1f:00.0:   bridge window [io  0x0000-0x0fff]
[   16.815994] pci 0000:1f:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.816693] pci 0000:1f:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.817384] pci 0000:20:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.818099] pci 0000:20:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.818808] pci 0000:20:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.819509] pci 0000:20:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.820206] pci 0000:20:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.821110] pci 0000:21:00.0: [12d8:400c] type 01 class 0x060400
[   16.822356] pci 0000:21:00.0: supports D1 D2
[   16.823031] pci 0000:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.824042] pci 0000:20:00.0: PCI bridge to [bus 21-27]
[   16.824843] pci 0000:20:00.0:   bridge window [io  0x0000-0x0fff]
[   16.825529] pci 0000:20:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.826219] pci 0000:20:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.826895] pci 0000:21:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.827885] pci 0000:22:03.0: [12d8:400c] type 01 class 0x060400
[   16.829059] pci 0000:22:03.0: supports D1 D2
[   16.829734] pci 0000:22:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.830703] pci 0000:21:00.0: PCI bridge to [bus 22-27]
[   16.831507] pci 0000:21:00.0:   bridge window [io  0x0000-0x0fff]
[   16.832192] pci 0000:21:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.832888] pci 0000:21:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.833592] pci 0000:22:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   16.834568] pci 0000:23:00.0: [12d8:400e] type 00 class 0x0c0310
[   16.835391] pci 0000:23:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   16.836427] pci 0000:23:00.0: supports D1 D2
[   16.837096] pci 0000:23:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.837991] pci 0000:23:00.1: [12d8:400e] type 00 class 0x0c0310
[   16.838842] pci 0000:23:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   16.839868] pci 0000:23:00.1: supports D1 D2
[   16.840529] pci 0000:23:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   16.841373] pci 0000:23:00.2: [12d8:400f] type 00 class 0x0c0320
[   16.842221] pci 0000:23:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   16.843247] pci 0000:23:00.2: supports D1 D2
[   16.843934] pci 0000:23:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   16.844996] pci 0000:22:03.0: PCI bridge to [bus 23-27]
[   16.845786] pci 0000:22:03.0:   bridge window [io  0x0000-0x0fff]
[   16.846467] pci 0000:22:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.847153] pci 0000:22:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.847821] pci_bus 0000:23: busn_res: [bus 23-27] end is updated to 23
[   16.848505] pci_bus 0000:22: busn_res: [bus 22-27] end is updated to 23
[   16.849182] pci_bus 0000:21: busn_res: [bus 21-27] end is updated to 23
[   16.850067] pci 0000:24:00.0: [14e4:16b0] type 00 class 0x020000
[   16.850891] pci 0000:24:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   16.851608] pci 0000:24:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   16.852700] pci 0000:24:00.0: PME# supported from D0 D3hot D3cold
[   16.853775] pci 0000:20:01.0: PCI bridge to [bus 24-27]
[   16.854565] pci 0000:20:01.0:   bridge window [io  0x0000-0x0fff]
[   16.855245] pci 0000:20:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.855929] pci 0000:20:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.856592] pci_bus 0000:24: busn_res: [bus 24-27] end is updated to 24
[   16.857470] pci 0000:25:00.0: [11c1:5901] type 00 class 0x0c0010
[   16.858290] pci 0000:25:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   16.859374] pci 0000:25:00.0: supports D1 D2
[   16.860036] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   16.861029] pci 0000:20:02.0: PCI bridge to [bus 25-27]
[   16.861818] pci 0000:20:02.0:   bridge window [io  0x0000-0x0fff]
[   16.862500] pci 0000:20:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.863183] pci 0000:20:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.863877] pci_bus 0000:25: busn_res: [bus 25-27] end is updated to 25
[   16.864704] pci 0000:20:04.0: PCI bridge to [bus 26-27]
[   16.865477] pci 0000:20:04.0:   bridge window [io  0x0000-0x0fff]
[   16.866152] pci 0000:20:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   16.866832] pci 0000:20:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   16.867493] pci_bus 0000:26: busn_res: [bus 26-27] end is updated to 27
[   16.868211] pci_bus 0000:28: busn_res: [bus 28-37] end is updated to 37
[   16.868880] pci 0000:20:05.0: devices behind bridge are unusable because [bus 28-37] cannot be assigned for them
[   16.869560] pci_bus 0000:20: busn_res: [bus 20-27] end can not be updated to 37
[   16.870245] pci_bus 0000:1f: busn_res: [bus 1f-27] end can not be updated to 37
[   16.870956] pci_bus 0000:38: busn_res: [bus 38-47] end is updated to 47
[   16.871633] pci 0000:19:05.0: devices behind bridge are unusable because [bus 38-47] cannot be assigned for them
[   16.872322] pci_bus 0000:19: busn_res: [bus 19-27] end can not be updated to 47
[   16.873020] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 26-27] add_size 3ff00000 add_align 100000
[   16.873754] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 26-27] add_size 7f00000 add_align 100000
[   16.874477] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x004fffff 64bit pref] to [bus 20-27] add_size 3ff00000 add_align 100000
[   16.875187] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x004fffff] to [bus 20-27] add_size 7f00000 add_align 100000
[   16.875896] pci 0000:19:04.0: bridge window [mem 0x00100000-0x004fffff 64bit pref] to [bus 1f-27] add_size 7fb00000 add_align 100000
[   16.876609] pci 0000:19:04.0: bridge window [mem 0x00100000-0x004fffff] to [bus 1f-27] add_size fb00000 add_align 100000
[   16.877322] pci 0000:18:00.0: bridge window [mem 0x00100000-0x007fffff 64bit pref] to [bus 19-27] add_size 7fb00000 add_align 100000
[   16.878043] pci 0000:18:00.0: bridge window [mem 0x00100000-0x007fffff] to [bus 19-27] add_size fb00000 add_align 100000
[   16.878763] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x007fffff 64bit pref] to [bus 18-27] add_size bf400000 add_align 100000
[   16.879497] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00700000 64bit pref]
[   16.880231] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00700000 64bit pref]
[   16.880960] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00700000 64bit pref]
[   16.881690] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00700000 64bit pref]
[   16.882421] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xb8afffff]
[   16.883154] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00700000 64bit pref]
[   16.883920] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00700000 64bit pref]
[   16.884684] pci 0000:18:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   16.885435] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xb8afffff]
[   16.886173] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00700000 64bit pref]
[   16.886911] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00700000 64bit pref]
[   16.887651] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   16.888395] pci 0000:19:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   16.889145] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0d00000-0xb0dfffff]
[   16.889895] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0e00000-0xb0efffff 64bit pref]
[   16.890649] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[   16.891398] pci 0000:19:02.0: BAR 9: assigned [mem 0xb1000000-0xb10fffff 64bit pref]
[   16.892146] pci 0000:19:04.0: BAR 8: assigned [mem 0xb1100000-0xb4f7ffff]
[   16.892892] pci 0000:19:04.0: BAR 9: assigned [mem 0xb5000000-0xb51fffff 64bit pref]
[   16.893663] pci 0000:19:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   16.894424] pci 0000:19:01.0: BAR 7: no space for [io  size 0x1000]
[   16.895169] pci 0000:19:01.0: BAR 7: failed to assign [io  size 0x1000]
[   16.895917] pci 0000:19:02.0: BAR 7: no space for [io  size 0x1000]
[   16.896663] pci 0000:19:02.0: BAR 7: failed to assign [io  size 0x1000]
[   16.897405] pci 0000:19:04.0: BAR 7: no space for [io  size 0x4000]
[   16.898159] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x4000]
[   16.898901] pci 0000:19:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   16.899638] pci 0000:19:01.0: BAR 7: no space for [io  size 0x1000]
[   16.900373] pci 0000:19:01.0: BAR 7: failed to assign [io  size 0x1000]
[   16.901110] pci 0000:19:02.0: BAR 7: no space for [io  size 0x1000]
[   16.901849] pci 0000:19:02.0: BAR 7: failed to assign [io  size 0x1000]
[   16.902588] pci 0000:19:04.0: BAR 7: no space for [io  size 0x4000]
[   16.903333] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x4000]
[   16.904092] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   16.904826] pci 0000:1a:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   16.905559] pci 0000:1a:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   16.906291] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   16.907022] pci 0000:1b:03.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   16.907754] pci 0000:1b:03.0: BAR 7: assigned [io  0x5000-0x5fff]
[   16.908483] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[   16.909219] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[   16.909953] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[   16.910684] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   16.911409] pci 0000:1b:03.0:   bridge window [io  0x5000-0x5fff]
[   16.912139] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   16.912868] pci 0000:1b:03.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   16.913641] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   16.914377] pci 0000:1a:00.0:   bridge window [io  0x5000-0x5fff]
[   16.915110] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   16.915841] pci 0000:1a:00.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   16.916583] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   16.917310] pci 0000:19:00.0:   bridge window [io  0x5000-0x5fff]
[   16.918042] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   16.918775] pci 0000:19:00.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   16.919513] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e0ffff 64bit pref]
[   16.920265] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0e10000-0xb0e1ffff 64bit pref]
[   16.921015] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   16.921747] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[   16.922479] pci 0000:19:01.0:   bridge window [mem 0xb0e00000-0xb0efffff 64bit pref]
[   16.923213] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff 64bit]
[   16.923997] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   16.924732] pci 0000:19:02.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[   16.925461] pci 0000:19:02.0:   bridge window [mem 0xb1000000-0xb10fffff 64bit pref]
[   16.926195] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb1100000-0xb4f7ffff]
[   16.926915] pci 0000:1f:00.0: BAR 9: assigned [mem 0xb5000000-0xb51fffff 64bit pref]
[   16.927635] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x4000]
[   16.928358] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x4000]
[   16.929083] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x4000]
[   16.929803] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x4000]
[   16.930522] pci 0000:20:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   16.931238] pci 0000:20:00.0: BAR 9: assigned [mem 0xb5000000-0xb50fffff 64bit pref]
[   16.931956] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[   16.932676] pci 0000:20:01.0: BAR 9: assigned [mem 0xb5100000-0xb51fffff 64bit pref]
[   16.933418] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1300000-0xb13fffff]
[   16.934154] pci 0000:20:02.0: BAR 9: assigned [mem 0xb1400000-0xb14fffff 64bit pref]
[   16.934864] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1500000-0xb32bffff]
[   16.935567] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   16.936273] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   16.936980] pci 0000:20:00.0: BAR 7: no space for [io  size 0x1000]
[   16.937678] pci 0000:20:00.0: BAR 7: failed to assign [io  size 0x1000]
[   16.938370] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   16.939051] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   16.939729] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   16.940402] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   16.941074] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   16.941741] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   16.942406] pci 0000:20:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   16.943068] pci 0000:20:00.0: BAR 9: assigned [mem 0xb5000000-0xb50fffff 64bit pref]
[   16.943757] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[   16.944423] pci 0000:20:01.0: BAR 9: assigned [mem 0xb5100000-0xb51fffff 64bit pref]
[   16.945066] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1300000-0xb13fffff]
[   16.945709] pci 0000:20:02.0: BAR 9: assigned [mem 0xb1400000-0xb14fffff 64bit pref]
[   16.946351] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1500000-0xb32bffff]
[   16.946993] pci 0000:20:04.0: BAR 9: assigned [mem 0xb3300000-0xb33fffff 64bit pref]
[   16.947632] pci 0000:20:00.0: BAR 7: no space for [io  size 0x1000]
[   16.948269] pci 0000:20:00.0: BAR 7: failed to assign [io  size 0x1000]
[   16.948906] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   16.949539] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   16.950173] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   16.950804] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   16.951434] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   16.952061] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   16.952691] pci 0000:20:04.0: BAR 9: [mem 0xb3300000-0xb33fffff 64bit pref] (failed to expand by 0x3ff00000)
[   16.953346] pci 0000:20:04.0: failed to add 3ff00000 res[9]=[mem 0xb3300000-0xb33fffff 64bit pref]
[   16.954013] pci 0000:21:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   16.954660] pci 0000:21:00.0: BAR 9: assigned [mem 0xb5000000-0xb50fffff 64bit pref]
[   16.955307] pci 0000:21:00.0: BAR 7: no space for [io  size 0x1000]
[   16.955954] pci 0000:21:00.0: BAR 7: failed to assign [io  size 0x1000]
[   16.956601] pci 0000:22:03.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   16.957248] pci 0000:22:03.0: BAR 9: assigned [mem 0xb5000000-0xb50fffff 64bit pref]
[   16.957894] pci 0000:22:03.0: BAR 7: no space for [io  size 0x1000]
[   16.958540] pci 0000:22:03.0: BAR 7: failed to assign [io  size 0x1000]
[   16.959189] pci 0000:23:00.0: BAR 0: assigned [mem 0xb1100000-0xb1100fff]
[   16.959850] pci 0000:23:00.1: BAR 0: assigned [mem 0xb1101000-0xb1101fff]
[   16.960506] pci 0000:23:00.2: BAR 0: assigned [mem 0xb1102000-0xb11020ff]
[   16.961159] pci 0000:22:03.0: PCI bridge to [bus 23]
[   16.961821] pci 0000:22:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   16.962477] pci 0000:22:03.0:   bridge window [mem 0xb5000000-0xb50fffff 64bit pref]
[   16.963143] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   16.963838] pci 0000:21:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   16.964506] pci 0000:21:00.0:   bridge window [mem 0xb5000000-0xb50fffff 64bit pref]
[   16.965175] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   16.965836] pci 0000:20:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   16.966495] pci 0000:20:00.0:   bridge window [mem 0xb5000000-0xb50fffff 64bit pref]
[   16.967163] pci 0000:24:00.0: BAR 0: assigned [mem 0xb5100000-0xb510ffff 64bit pref]
[   16.967850] pci 0000:24:00.0: BAR 2: assigned [mem 0xb5110000-0xb511ffff 64bit pref]
[   16.968530] pci 0000:20:01.0: PCI bridge to [bus 24]
[   16.969188] pci 0000:20:01.0:   bridge window [mem 0xb1200000-0xb12fffff]
[   16.969841] pci 0000:20:01.0:   bridge window [mem 0xb5100000-0xb51fffff 64bit pref]
[   16.970503] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1300000-0xb1300fff 64bit]
[   16.971189] pci 0000:20:02.0: PCI bridge to [bus 25]
[   16.971853] pci 0000:20:02.0:   bridge window [mem 0xb1300000-0xb13fffff]
[   16.972512] pci 0000:20:02.0:   bridge window [mem 0xb1400000-0xb14fffff 64bit pref]
[   16.973181] pci 0000:20:04.0: PCI bridge to [bus 26-27]
[   16.973881] pci 0000:20:04.0:   bridge window [mem 0xb1500000-0xb32bffff]
[   16.974553] pci 0000:20:04.0:   bridge window [mem 0xb3300000-0xb33fffff 64bit pref]
[   16.975224] pci 0000:1f:00.0: PCI bridge to [bus 20-27]
[   16.975890] pci 0000:1f:00.0:   bridge window [mem 0xb1100000-0xb4f7ffff]
[   16.976556] pci 0000:1f:00.0:   bridge window [mem 0xb5000000-0xb51fffff 64bit pref]
[   16.977233] pci 0000:19:04.0: PCI bridge to [bus 1f-27]
[   16.977898] pci 0000:19:04.0:   bridge window [mem 0xb1100000-0xb4f7ffff]
[   16.978562] pci 0000:19:04.0:   bridge window [mem 0xb5000000-0xb51fffff 64bit pref]
[   16.979232] pci 0000:18:00.0: PCI bridge to [bus 19-27]
[   16.979898] pci 0000:18:00.0:   bridge window [io  0x5000-0x5fff]
[   16.980568] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xb8afffff]
[   16.981248] pcieport 0000:06:04.0: PCI bridge to [bus 18-27]
[   16.981912] pcieport 0000:06:04.0:   bridge window [io  0x5000-0x5fff]
[   16.982578] pcieport 0000:06:04.0:   bridge window [mem 0xb0b00000-0xb8afffff]
[   16.983250] PCI: No. 2 try to assign unassigned res
[   16.983252] pci 0000:1b:03.0: resource 7 [io  0x5000-0x5fff] released
[   16.983951] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   16.984643] pci 0000:1a:00.0: resource 7 [io  0x5000-0x5fff] released
[   16.985307] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   16.985987] pci 0000:19:00.0: resource 7 [io  0x5000-0x5fff] released
[   16.986652] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   16.987328] pci 0000:18:00.0: resource 7 [io  0x5000-0x5fff] released
[   16.987993] pci 0000:18:00.0: PCI bridge to [bus 19-27]
[   16.988670] pci 0000:1b:03.0: resource 9 [mem 0xb0c00000-0xb0cfffff 64bit pref] released
[   16.989343] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   16.990038] pci 0000:1a:00.0: resource 9 [mem 0xb0c00000-0xb0cfffff 64bit pref] released
[   16.990722] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   16.991426] pci 0000:19:00.0: resource 9 [mem 0xb0c00000-0xb0cfffff 64bit pref] released
[   16.992118] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   16.992824] release child resource [mem 0xb0e00000-0xb0e0ffff 64bit pref]
[   16.992825] release child resource [mem 0xb0e10000-0xb0e1ffff 64bit pref]
[   16.992826] pci 0000:19:01.0: resource 9 [mem 0xb0e00000-0xb0efffff 64bit pref] released
[   16.993551] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   16.994279] pci 0000:19:02.0: resource 9 [mem 0xb1000000-0xb10fffff 64bit pref] released
[   16.994986] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   16.995706] pci 0000:22:03.0: resource 9 [mem 0xb5000000-0xb50fffff 64bit pref] released
[   16.996419] pci 0000:22:03.0: PCI bridge to [bus 23]
[   16.997155] pci 0000:21:00.0: resource 9 [mem 0xb5000000-0xb50fffff 64bit pref] released
[   16.997874] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   16.998618] pci 0000:20:00.0: resource 9 [mem 0xb5000000-0xb50fffff 64bit pref] released
[   16.999345] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   17.000092] release child resource [mem 0xb5100000-0xb510ffff 64bit pref]
[   17.000092] release child resource [mem 0xb5110000-0xb511ffff 64bit pref]
[   17.000093] pci 0000:20:01.0: resource 9 [mem 0xb5100000-0xb51fffff 64bit pref] released
[   17.000829] pci 0000:20:01.0: PCI bridge to [bus 24]
[   17.001586] pci 0000:20:02.0: resource 9 [mem 0xb1400000-0xb14fffff 64bit pref] released
[   17.002332] pci 0000:20:02.0: PCI bridge to [bus 25]
[   17.003094] pci 0000:20:04.0: resource 9 [mem 0xb3300000-0xb33fffff 64bit pref] released
[   17.003881] pci 0000:20:04.0: PCI bridge to [bus 26-27]
[   17.004670] pci 0000:1f:00.0: resource 9 [mem 0xb5000000-0xb51fffff 64bit pref] released
[   17.005430] pci 0000:1f:00.0: PCI bridge to [bus 20-27]
[   17.006210] pci 0000:19:04.0: resource 9 [mem 0xb5000000-0xb51fffff 64bit pref] released
[   17.006979] pci 0000:19:04.0: PCI bridge to [bus 1f-27]
[   17.007759] release child resource [mem 0xb0b00000-0xb0b00fff]
[   17.007759] release child resource [mem 0xb0b01000-0xb0b01fff]
[   17.007760] release child resource [mem 0xb0b02000-0xb0b020ff]
[   17.007760] release child resource [mem 0xb0b00000-0xb0bfffff]
[   17.007761] release child resource [mem 0xb0b00000-0xb0bfffff]
[   17.007762] release child resource [mem 0xb0b00000-0xb0bfffff]
[   17.007762] release child resource [mem 0xb0d00000-0xb0dfffff]
[   17.007763] release child resource [mem 0xb0f00000-0xb0f00fff 64bit]
[   17.007763] release child resource [mem 0xb0f00000-0xb0ffffff]
[   17.007764] release child resource [mem 0xb1100000-0xb1100fff]
[   17.007765] release child resource [mem 0xb1101000-0xb1101fff]
[   17.007765] release child resource [mem 0xb1102000-0xb11020ff]
[   17.007766] release child resource [mem 0xb1100000-0xb11fffff]
[   17.007766] release child resource [mem 0xb1100000-0xb11fffff]
[   17.007767] release child resource [mem 0xb1100000-0xb11fffff]
[   17.007768] release child resource [mem 0xb1200000-0xb12fffff]
[   17.007768] release child resource [mem 0xb1300000-0xb1300fff 64bit]
[   17.007769] release child resource [mem 0xb1300000-0xb13fffff]
[   17.007769] release child resource [mem 0xb1500000-0xb32bffff]
[   17.007770] release child resource [mem 0xb1100000-0xb4f7ffff]
[   17.007771] release child resource [mem 0xb1100000-0xb4f7ffff]
[   17.007771] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xb8afffff] released
[   17.008542] pci 0000:18:00.0: PCI bridge to [bus 19-27]
[   17.009317] pcieport 0000:06:04.0: resource 8 [mem 0xb0b00000-0xb8afffff] released
[   17.010092] pcieport 0000:06:04.0: PCI bridge to [bus 18-27]
[   17.010871] release child resource [mem 0xa8a00000-0xa8a3ffff]
[   17.010872] release child resource [mem 0xa8a00000-0xa8a3ffff]
[   17.010872] release child resource [mem 0xa8a40000-0xa8a40fff]
[   17.010873] pcieport 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[   17.011653] pcieport 0000:06:00.0: PCI bridge to [bus 07]
[   17.012434] pcieport 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[   17.013217] pcieport 0000:06:03.0: PCI bridge to [bus 08-17]
[   17.014029] pcieport 0000:06:05.0: resource 8 [mem 0xb8b00000-0xc0afffff] released
[   17.014832] pcieport 0000:06:05.0: PCI bridge to [bus 28-37]
[   17.015615] pcieport 0000:06:06.0: resource 8 [mem 0xc0b00000-0xc8afffff] released
[   17.016395] pcieport 0000:06:06.0: PCI bridge to [bus 38-47]
[   17.017174] pcieport 0000:05:00.0: resource 8 [mem 0xa8a00000-0xc8afffff] released
[   17.017951] pcieport 0000:05:00.0: PCI bridge to [bus 06-47]
[   17.018734] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 26-27] add_size 3ff00000 add_align 100000
[   17.019533] pci 0000:20:04.0: bridge window [mem 0x00100000-0x01efffff] to [bus 26-27] add_size 6200000 add_align 100000
[   17.020332] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x004fffff 64bit pref] to [bus 20-27] add_size 3ff00000 add_align 100000
[   17.021136] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x03ffffff] to [bus 20-27] add_size 6200000 add_align 100000
[   17.021941] pci 0000:19:04.0: bridge window [mem 0x00100000-0x004fffff 64bit pref] to [bus 1f-27] add_size 7fb00000 add_align 100000
[   17.022747] pci 0000:19:04.0: bridge window [mem 0x00100000-0x03ffffff] to [bus 1f-27] add_size a300000 add_align 100000
[   17.023591] pci 0000:18:00.0: bridge window [mem 0x00100000-0x007fffff 64bit pref] to [bus 19-27] add_size 7fb00000 add_align 100000
[   17.024427] pci 0000:18:00.0: bridge window [mem 0x00100000-0x080fffff] to [bus 19-27] add_size a300000 add_align 100000
[   17.025252] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x007fffff 64bit pref] to [bus 18-27] add_size bf400000 add_align 100000
[   17.026098] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x080fffff] to [bus 18-27] add_size a300000 add_align 100000
[   17.026935] pcieport 0000:06:04.0: BAR 8: no space for [mem size 0x08000000]
[   17.027772] pcieport 0000:06:04.0: BAR 8: failed to assign [mem size 0x08000000]
[   17.028607] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00700000 64bit pref]
[   17.029443] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00700000 64bit pref]
[   17.030281] pcieport 0000:06:04.0: BAR 8: no space for [mem size 0x08000000]
[   17.031115] pcieport 0000:06:04.0: BAR 8: failed to assign [mem size 0x08000000]
[   17.031968] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00700000 64bit pref]
[   17.032805] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00700000 64bit pref]
[   17.033674] pci 0000:18:00.0: BAR 8: no space for [mem size 0x08000000]
[   17.034536] pci 0000:18:00.0: BAR 8: failed to assign [mem size 0x08000000]
[   17.035379] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00700000 64bit pref]
[   17.036228] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00700000 64bit pref]
[   17.037077] pci 0000:18:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   17.037926] pci 0000:18:00.0: BAR 8: no space for [mem size 0x08000000]
[   17.038772] pci 0000:18:00.0: BAR 8: failed to assign [mem size 0x08000000]
[   17.039620] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00700000 64bit pref]
[   17.040470] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00700000 64bit pref]
[   17.041319] pci 0000:19:00.0: BAR 8: no space for [mem size 0x00100000]
[   17.042172] pci 0000:19:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.043025] pci 0000:19:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.044110] pci 0000:19:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.045267] pci 0000:19:01.0: BAR 8: no space for [mem size 0x00100000]
[   17.046174] pci 0000:19:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.047054] pci 0000:19:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.047942] pci 0000:19:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.048801] pci 0000:19:02.0: BAR 8: no space for [mem size 0x00100000]
[   17.049657] pci 0000:19:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.050517] pci 0000:19:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.051396] pci 0000:19:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.052270] pci 0000:19:04.0: BAR 8: no space for [mem size 0x03e80000]
[   17.053146] pci 0000:19:04.0: BAR 8: failed to assign [mem size 0x03e80000]
[   17.054042] pci 0000:19:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[   17.054926] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[   17.055794] pci 0000:19:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   17.056661] pci 0000:19:01.0: BAR 7: no space for [io  size 0x1000]
[   17.057524] pci 0000:19:01.0: BAR 7: failed to assign [io  size 0x1000]
[   17.058388] pci 0000:19:02.0: BAR 7: no space for [io  size 0x1000]
[   17.059249] pci 0000:19:02.0: BAR 7: failed to assign [io  size 0x1000]
[   17.060109] pci 0000:19:04.0: BAR 7: no space for [io  size 0x4000]
[   17.060967] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x4000]
[   17.061822] pci 0000:19:00.0: BAR 8: no space for [mem size 0x00100000]
[   17.062674] pci 0000:19:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.063547] pci 0000:19:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.064408] pci 0000:19:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.065252] pci 0000:19:01.0: BAR 8: no space for [mem size 0x00100000]
[   17.066095] pci 0000:19:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.066935] pci 0000:19:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.067773] pci 0000:19:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.068605] pci 0000:19:02.0: BAR 8: no space for [mem size 0x00100000]
[   17.069437] pci 0000:19:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.070267] pci 0000:19:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.071096] pci 0000:19:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.071922] pci 0000:19:04.0: BAR 8: no space for [mem size 0x03e80000]
[   17.072746] pci 0000:19:04.0: BAR 8: failed to assign [mem size 0x03e80000]
[   17.073591] pci 0000:19:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[   17.074424] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[   17.075238] pci 0000:19:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   17.076050] pci 0000:19:01.0: BAR 7: no space for [io  size 0x1000]
[   17.076857] pci 0000:19:01.0: BAR 7: failed to assign [io  size 0x1000]
[   17.077661] pci 0000:19:02.0: BAR 7: no space for [io  size 0x1000]
[   17.078459] pci 0000:19:02.0: BAR 7: failed to assign [io  size 0x1000]
[   17.079255] pci 0000:19:04.0: BAR 7: no space for [io  size 0x4000]
[   17.080047] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x4000]
[   17.080834] pci 0000:1a:00.0: BAR 8: no space for [mem size 0x00100000]
[   17.081617] pci 0000:1a:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.082397] pci 0000:1a:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.083177] pci 0000:1a:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.083981] pci 0000:1a:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   17.084771] pci 0000:1a:00.0: BAR 8: no space for [mem size 0x00100000]
[   17.085544] pci 0000:1a:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.086317] pci 0000:1a:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.087090] pci 0000:1a:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.087865] pci 0000:1b:03.0: BAR 8: no space for [mem size 0x00100000]
[   17.088639] pci 0000:1b:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.089410] pci 0000:1b:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.090183] pci 0000:1b:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.090956] pci 0000:1b:03.0: BAR 7: assigned [io  0x5000-0x5fff]
[   17.091726] pci 0000:1b:03.0: BAR 8: no space for [mem size 0x00100000]
[   17.092493] pci 0000:1b:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.093263] pci 0000:1b:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.094065] pci 0000:1b:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.094838] pci 0000:1c:00.0: BAR 0: no space for [mem size 0x00001000]
[   17.095593] pci 0000:1c:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   17.096348] pci 0000:1c:00.1: BAR 0: no space for [mem size 0x00001000]
[   17.097096] pci 0000:1c:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   17.097841] pci 0000:1c:00.2: BAR 0: no space for [mem size 0x00000100]
[   17.098583] pci 0000:1c:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   17.099325] pci 0000:1c:00.0: BAR 0: no space for [mem size 0x00001000]
[   17.100055] pci 0000:1c:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   17.100783] pci 0000:1c:00.1: BAR 0: no space for [mem size 0x00001000]
[   17.101532] pci 0000:1c:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   17.102252] pci 0000:1c:00.2: BAR 0: no space for [mem size 0x00000100]
[   17.102971] pci 0000:1c:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   17.103716] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   17.104453] pci 0000:1b:03.0:   bridge window [io  0x5000-0x5fff]
[   17.105205] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   17.105925] pci 0000:1a:00.0:   bridge window [io  0x5000-0x5fff]
[   17.106673] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   17.107384] pci 0000:19:00.0:   bridge window [io  0x5000-0x5fff]
[   17.108118] pci 0000:1d:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   17.108830] pci 0000:1d:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   17.109542] pci 0000:1d:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   17.110254] pci 0000:1d:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   17.110967] pci 0000:1d:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   17.111679] pci 0000:1d:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   17.112391] pci 0000:1d:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   17.113104] pci 0000:1d:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   17.113840] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   17.114592] pci 0000:1e:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   17.115307] pci 0000:1e:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   17.116022] pci 0000:1e:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   17.116734] pci 0000:1e:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   17.117446] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   17.118180] pci 0000:1f:00.0: BAR 8: no space for [mem size 0x03e80000]
[   17.118893] pci 0000:1f:00.0: BAR 8: failed to assign [mem size 0x03e80000]
[   17.119603] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[   17.120314] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[   17.121024] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x4000]
[   17.121734] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x4000]
[   17.122439] pci 0000:1f:00.0: BAR 8: no space for [mem size 0x03e80000]
[   17.123145] pci 0000:1f:00.0: BAR 8: failed to assign [mem size 0x03e80000]
[   17.123875] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[   17.124594] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[   17.125297] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x4000]
[   17.126000] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x4000]
[   17.126706] pci 0000:20:00.0: BAR 8: no space for [mem size 0x00100000]
[   17.127408] pci 0000:20:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.128112] pci 0000:20:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.128819] pci 0000:20:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.129530] pci 0000:20:01.0: BAR 8: no space for [mem size 0x00100000]
[   17.130241] pci 0000:20:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.130953] pci 0000:20:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.131665] pci 0000:20:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.132376] pci 0000:20:02.0: BAR 8: no space for [mem size 0x00100000]
[   17.133085] pci 0000:20:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.133824] pci 0000:20:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.134551] pci 0000:20:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.135263] pci 0000:20:04.0: BAR 8: no space for [mem size 0x01dc0000]
[   17.135973] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x01dc0000]
[   17.136683] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   17.137396] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   17.138108] pci 0000:20:00.0: BAR 7: no space for [io  size 0x1000]
[   17.138818] pci 0000:20:00.0: BAR 7: failed to assign [io  size 0x1000]
[   17.139526] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   17.140231] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   17.140935] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   17.141639] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   17.142342] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   17.143045] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   17.143777] pci 0000:20:00.0: BAR 8: no space for [mem size 0x00100000]
[   17.144496] pci 0000:20:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.145201] pci 0000:20:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.145909] pci 0000:20:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.146617] pci 0000:20:01.0: BAR 8: no space for [mem size 0x00100000]
[   17.147328] pci 0000:20:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.148038] pci 0000:20:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.148750] pci 0000:20:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.149462] pci 0000:20:02.0: BAR 8: no space for [mem size 0x00100000]
[   17.150176] pci 0000:20:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.150891] pci 0000:20:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.151606] pci 0000:20:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.152321] pci 0000:20:04.0: BAR 8: no space for [mem size 0x01dc0000]
[   17.153034] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x01dc0000]
[   17.153789] pci 0000:20:04.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.154538] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.155260] pci 0000:20:00.0: BAR 7: no space for [io  size 0x1000]
[   17.155981] pci 0000:20:00.0: BAR 7: failed to assign [io  size 0x1000]
[   17.156703] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   17.157422] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   17.158146] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   17.158856] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   17.159560] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   17.160308] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   17.161011] pci 0000:21:00.0: BAR 8: no space for [mem size 0x00100000]
[   17.161716] pci 0000:21:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.162420] pci 0000:21:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.163128] pci 0000:21:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.163863] pci 0000:21:00.0: BAR 7: no space for [io  size 0x1000]
[   17.164596] pci 0000:21:00.0: BAR 7: failed to assign [io  size 0x1000]
[   17.165306] pci 0000:22:03.0: BAR 8: no space for [mem size 0x00100000]
[   17.166016] pci 0000:22:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   17.166724] pci 0000:22:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   17.167436] pci 0000:22:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   17.168145] pci 0000:22:03.0: BAR 7: no space for [io  size 0x1000]
[   17.168853] pci 0000:22:03.0: BAR 7: failed to assign [io  size 0x1000]
[   17.169564] pci 0000:23:00.0: BAR 0: no space for [mem size 0x00001000]
[   17.170277] pci 0000:23:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   17.170988] pci 0000:23:00.1: BAR 0: no space for [mem size 0x00001000]
[   17.171700] pci 0000:23:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   17.172408] pci 0000:23:00.2: BAR 0: no space for [mem size 0x00000100]
[   17.173119] pci 0000:23:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   17.173960] pci 0000:22:03.0: PCI bridge to [bus 23]
[   17.174739] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   17.175491] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   17.176231] pci 0000:24:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   17.176934] pci 0000:24:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   17.177638] pci 0000:24:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   17.178339] pci 0000:24:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   17.179042] pci 0000:20:01.0: PCI bridge to [bus 24]
[   17.179781] pci 0000:25:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   17.180489] pci 0000:25:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   17.181196] pci 0000:20:02.0: PCI bridge to [bus 25]
[   17.181938] pci 0000:20:04.0: PCI bridge to [bus 26-27]
[   17.182674] pci 0000:1f:00.0: PCI bridge to [bus 20-27]
[   17.183450] pci 0000:19:04.0: PCI bridge to [bus 1f-27]
[   17.184170] pci 0000:18:00.0: PCI bridge to [bus 19-27]
[   17.184862] pci 0000:18:00.0:   bridge window [io  0x5000-0x5fff]
[   17.185576] pcieport 0000:06:04.0: PCI bridge to [bus 18-27]
[   17.186268] pcieport 0000:06:04.0:   bridge window [io  0x5000-0x5fff]
[   17.187003] pcieport 0000:18:00.0: enabling device (0000 -> 0001)
[   17.188054] pcieport 0000:19:00.0: enabling device (0000 -> 0001)
[   17.190354] pcieport 0000:19:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   17.191581] pcieport 0000:19:05.0: pciehp: Hotplug bridge without secondary bus, ignoring
[   17.192608] pcieport 0000:1a:00.0: enabling device (0000 -> 0001)
[   17.193592] pcieport 0000:1b:03.0: enabling device (0000 -> 0001)
[   17.194459] pci 0000:1c:00.0: MSI is not implemented on this device, disabling it
[   17.195285] pci 0000:1c:00.0: PME# is unreliable, disabling it
[   17.196148] ohci-pci 0000:1c:00.0: init 0000:1c:00.0 fail, -16
[   17.196888] ohci-pci: probe of 0000:1c:00.0 failed with error -16
[   17.197623] pci 0000:1c:00.1: MSI is not implemented on this device, disabling it
[   17.198358] pci 0000:1c:00.1: PME# is unreliable, disabling it
[   17.199182] ohci-pci 0000:1c:00.1: init 0000:1c:00.1 fail, -16
[   17.199905] ohci-pci: probe of 0000:1c:00.1 failed with error -16
[   17.200645] pci 0000:1c:00.2: MSI is not implemented on this device, disabling it
[   17.201389] pci 0000:1c:00.2: PME# is unreliable, disabling it
[   17.202664] ehci-pci 0000:1c:00.2: init 0000:1c:00.2 fail, -16
[   17.203421] ehci-pci: probe of 0000:1c:00.2 failed with error -16
[   17.204206] tg3 0000:1d:00.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
[   17.204934] tg3 0000:1d:00.0: Cannot map device registers, aborting
[   17.205681] tg3: probe of 0000:1d:00.0 failed with error -12
[   17.206461] firewire_ohci 0000:1e:00.0: invalid MMIO resource
[   17.209658] pcieport 0000:20:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   17.211045] pcieport 0000:20:05.0: pciehp: Hotplug bridge without secondary bus, ignoring
[   17.212446] pci 0000:23:00.0: MSI is not implemented on this device, disabling it
[   17.213254] pci 0000:23:00.0: PME# is unreliable, disabling it
[   17.214188] ohci-pci 0000:23:00.0: init 0000:23:00.0 fail, -16
[   17.214970] ohci-pci: probe of 0000:23:00.0 failed with error -16
[   17.215751] pci 0000:23:00.1: MSI is not implemented on this device, disabling it
[   17.216538] pci 0000:23:00.1: PME# is unreliable, disabling it
[   17.217446] ohci-pci 0000:23:00.1: init 0000:23:00.1 fail, -16
[   17.218238] ohci-pci: probe of 0000:23:00.1 failed with error -16
[   17.219025] pci 0000:23:00.2: MSI is not implemented on this device, disabling it
[   17.219818] pci 0000:23:00.2: PME# is unreliable, disabling it
[   17.220725] ehci-pci 0000:23:00.2: init 0000:23:00.2 fail, -16
[   17.221513] ehci-pci: probe of 0000:23:00.2 failed with error -16
[   17.222361] tg3 0000:24:00.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
[   17.223157] tg3 0000:24:00.0: Cannot map device registers, aborting
[   17.224002] tg3: probe of 0000:24:00.0 failed with error -12
[   17.224875] firewire_ohci 0000:25:00.0: invalid MMIO resource
[   17.253913] usb 1-1.1.3: USB disconnect, device number 9
[   17.555863] Adding 16777212k swap on /dev/sda5.  Priority:-2 extents:1 across:16777212k SS
[   17.568627] EXT4-fs (sda6): re-mounted. Quota mode: none.
[   17.653178] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[   20.396814] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Quota mode: none.
[   20.923922] NET: Registered PF_PACKET protocol family
[   23.867672] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   23.868577] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   23.869465] tg3 0000:02:00.0 eth0: EEE is enabled
[   27.035537] FS-Cache: Loaded
[   27.041268] RPC: Registered named UNIX socket transport module.
[   27.042065] RPC: Registered udp transport module.
[   27.042867] RPC: Registered tcp transport module.
[   27.043656] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   27.056203] NFS: Registering the id_resolver key type
[   27.057040] Key type id_resolver registered
[   27.057814] Key type id_legacy registered
[   28.173383] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   28.624610] elogind-daemon[3017]: New seat seat0.
[   30.139163] switching from power state:
[   30.139170] 	ui class: performance
[   30.139172] 	internal class: none
[   30.139175] 	caps:
[   30.139176] 	uvd    vclk: 0 dclk: 0
[   30.139177] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   30.139179] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[   30.139181] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[   30.139182] 	status: c
[   30.139184] switching to power state:
[   30.139185] 	ui class: battery
[   30.139186] 	internal class: none
[   30.139187] 	caps:
[   30.139189] 	uvd    vclk: 0 dclk: 0
[   30.139190] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   30.139191] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   30.139193] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   30.139194] 	status: r
[   39.516464] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   39.516477] thunderbolt 0000:07:00.0: acking hot unplug event on 0:4
[   39.562792] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
[   39.562813] thunderbolt 0000:07:00.0: 0:3: switch unplugged
[   39.562834] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
[   39.562834] thunderbolt 0000:07:00.0: 0:c <-> 303:b (DP): deactivating
[   39.562875] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
[   39.562898] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
[   39.562923] pcieport 0000:06:04.0: pciehp: Slot(4-1): Link Down
[   39.562935] pcieport 0000:06:04.0: pciehp: Slot(4-1): Card not present
[   39.562954] pcieport 0000:19:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   39.563107] pcieport 0000:20:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   39.563203] pcieport 0000:20:04.0: can't change power state from D3cold to D0 (config space inaccessible)
[   39.568680] pci_bus 0000:1c: busn_res: [bus 1c] is released
[   39.568929] pci_bus 0000:1b: busn_res: [bus 1b-1c] is released
[   39.569058] pci_bus 0000:1a: busn_res: [bus 1a-1c] is released
[   39.569522] pci_bus 0000:1d: busn_res: [bus 1d] is released
[   39.569627] pci_bus 0000:1e: busn_res: [bus 1e] is released
[   39.569972] pci_bus 0000:23: busn_res: [bus 23] is released
[   39.570014] pci_bus 0000:22: busn_res: [bus 22-23] is released
[   39.570071] pci_bus 0000:21: busn_res: [bus 21-23] is released
[   39.570148] pci_bus 0000:24: busn_res: [bus 24] is released
[   39.570209] pci_bus 0000:25: busn_res: [bus 25] is released
[   39.570246] pci_bus 0000:26: busn_res: [bus 26-27] is released
[   39.570307] pci_bus 0000:20: busn_res: [bus 20-27] is released
[   39.570355] pci_bus 0000:1f: busn_res: [bus 1f-27] is released
[   39.570410] pci_bus 0000:19: busn_res: [bus 19-27] is released
[   39.784861] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   39.993714] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x3c
[   40.053288] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   40.321705] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   40.433723] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[   40.590165] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   40.858598] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   40.873734] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[   40.873773] thunderbolt 0000:07:00.0: deactivating Video path from 0:12 to 303:11
[   41.127016] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   41.313743] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x12
[   41.313782] thunderbolt 0000:07:00.0: 0:c: hop deactivation failed for hop 0, index 9
[   41.313810] thunderbolt 0000:07:00.0: 0:c: adding -5 NFC credits to 5
[   41.395444] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   41.753753] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x4
[   41.753791] thunderbolt 0000:07:00.0: 0:c: nfc credits deallocation failed for hop 0
[   41.753819] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:12 to 303:11
[   42.193762] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
[   42.193801] thunderbolt 0000:07:00.0: 0:c: hop deactivation failed for hop 0, index 8
[   42.193829] thunderbolt 0000:07:00.0: deactivating AUX RX path from 303:11 to 0:12
[   42.633773] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
[   42.633813] thunderbolt 0000:07:00.0: 0:4: hop deactivation failed for hop 2, index 8
[   42.633841] thunderbolt 0000:07:00.0: 0: released DP resource for port 12
[   42.633851] thunderbolt 0000:07:00.0: 0:d <-> 3:b (DP): deactivating
[   43.073780] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x3c
[   43.513791] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[   43.953800] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[   43.953839] thunderbolt 0000:07:00.0: deactivating Video path from 0:13 to 3:11
[   44.393809] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x12
[   44.393848] thunderbolt 0000:07:00.0: 0:d: hop deactivation failed for hop 0, index 9
[   44.393875] thunderbolt 0000:07:00.0: 0:d: adding -5 NFC credits to 5
[   44.833817] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x4
[   44.833855] thunderbolt 0000:07:00.0: 0:d: nfc credits deallocation failed for hop 0
[   44.833882] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:13 to 3:11
[   45.273827] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
[   45.273866] thunderbolt 0000:07:00.0: 0:d: hop deactivation failed for hop 0, index 8
[   45.273894] thunderbolt 0000:07:00.0: deactivating AUX RX path from 3:11 to 0:13
[   45.713836] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
[   45.713875] thunderbolt 0000:07:00.0: 0:3: hop deactivation failed for hop 1, index 8
[   45.713904] thunderbolt 0000:07:00.0: 0: released DP resource for port 13
[   45.713912] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): deactivating
[   46.153849] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x39
[   46.153887] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 0:7 to 3:10
[   46.593827] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
[   46.593866] thunderbolt 0000:07:00.0: 0:7: hop deactivation failed for hop 0, index 8
[   46.593894] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 3:10 to 0:7
[   47.033864] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x12
[   47.033903] thunderbolt 0000:07:00.0: 0:3: hop deactivation failed for hop 1, index 9
[   47.033934] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): deactivating
[   47.033939] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 3:7 to 303:10
[   47.033943] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 303:10 to 3:7
[   47.033949] thunderbolt 0000:07:00.0: 303:b: DP OUT resource unavailable
[   47.033952] thunderbolt 0000:07:00.0: 3:b: DP OUT resource unavailable
[   47.034018] thunderbolt 0-303: device disconnected
[   47.034090] thunderbolt 0-3: device disconnected
[   47.034131] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   47.473874] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[   47.473913] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   47.913883] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[   47.913922] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   47.913925] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
[   47.913931] thunderbolt 0000:07:00.0: 0:4: got unplug event for disconnected port, ignoring
[   47.913934] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[   47.913937] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[   47.913940] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[   47.913943] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[   47.913945] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[   47.913948] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[   47.913951] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[   73.974036] elogind-daemon[3017]: New session c1 of user brad.

