Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE184ED671
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiCaJGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiCaJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:06:05 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4EA304
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:04:11 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1nZqit-0004sl-FE; Thu, 31 Mar 2022 19:04:08 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=44uB6JpFT+yZToiTwZEZph2aAC4EHUqeRKfwIHsxCZg=; b=wKMuxXRT+VJFrcPCAeKCyUyMjN
        51x3ylb33tAEXBAfNyJVbt2uZNW9amBij2nBvQfRgzTWm49bQrUxUTBJOqfACu/TSLk7kg5mrr4HN
        EruScKqlBXkULq8lHrAj42qOk4TOvW4uCkJmnEi8p/ckscmibDTSQ2nUbsWmNJlWTzRM=;
Message-ID: <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
Date:   Thu, 31 Mar 2022 17:02:58 +0800
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
 <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
 <YkQuk7E8AbSEiw59@lahna>
 <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
 <YkRebADER3J9ooPM@lahna>
 <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
 <YkRtf2HiXBOWGjna@lahna>
Content-Language: en-US
In-Reply-To: <YkRtf2HiXBOWGjna@lahna>
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

On 30/3/22 22:47, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Mar 30, 2022 at 10:24:35PM +0800, Brad Campbell wrote:
>> Nope, that did the same thing. I wonder though. I'm testing it on the laptop and that reports :
>> [    0.442832] thunderbolt 0000:07:00.0:  Thunderbolt 2 Switch: 8086:156d (Revision: 0, TB Version: 2)
>>
>> Changing "if (in->sw->generation == 1)" to "if (in->sw->generation == 2)" on the laptop solves that.
> 
> Heh, indeed I forgot that this is Falcon Ridge.
> 
>> I can't test hotplug properly on the iMac due to the radeon training issue.
>>
>> The laptop still has the issue of a cold boot working in one socket
>> and not the other, but hot plug is working correctly.
> 
> Let's try this one next:
> 
> diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> index a473cc7d9a8d..7150b5bc5403 100644
> --- a/drivers/thunderbolt/tunnel.c
> +++ b/drivers/thunderbolt/tunnel.c
> @@ -865,6 +865,8 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
>   	struct tb_tunnel *tunnel;
>   	struct tb_path **paths;
>   	struct tb_path *path;
> +	struct tb_port *port;
> +	int link_nr;
>   

On the iMac, it cold boots on either port.

On the Laptop it is the same as the previous in that it cold boots on one port and not the other. Hotplug works in all cases I did try (in->sw->generation < 3) just in case, but it didn't change anything on the Laptop.

Testing from here down is on the iMac.

I've re-tested the original patch and aside from the thunderbolt controller locking up, the radeon doesn't fail clock recovery.

Further investigation on the iMac shows we don't see port 11. I added a debug for discovered port.

So my next thing is to try and figure out if there is a correlation between which link is paired with which DP source.

I've changed link_nr = in->port == 11 ? 1 : 0; to 12 ? 1 : 0; and that boots, but hotplug still fails if the EFI sets up a display first. I've also tried reversing the 1 : 0, but that fails out of the gate.

I've just done a test now by booting with the chain disconnected, then plugging it in just before the bootloader loads which prevents the EFI from getting involved. 

This works (wait until just before bootloader to plug the chain): 

brad@bkmac:~$ dmesg | egrep '(Tunnel|in->|in use|DP .* available)'
[    1.618277] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.618280] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
[    1.618403] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[    1.618529] thunderbolt 0000:07:00.0: 0:c: DP IN available
[    1.618656] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[    1.618916] thunderbolt 0000:07:00.0: in->port 12
[    1.618920] thunderbolt 0000:07:00.0: Tunnel 1
[    1.622751] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
[    1.622880] thunderbolt 0000:07:00.0: 0:c: in use
[    1.623007] thunderbolt 0000:07:00.0: 0:d: DP IN available
[    1.623135] thunderbolt 0000:07:00.0: 303:b: in use
[    1.623263] thunderbolt 0000:07:00.0: 3:b: DP OUT available
[    1.623399] thunderbolt 0000:07:00.0: in->port 13
[    1.623402] thunderbolt 0000:07:00.0: Tunnel 0

Both displays are working at this point.
Unplug -> Replug
[   45.799923] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   45.800051] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   45.800053] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
[   54.606243] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[   54.606371] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   54.606497] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[   54.606763] thunderbolt 0000:07:00.0: in->port 12
[   54.606768] thunderbolt 0000:07:00.0: Tunnel 1
[   54.615067] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
[   54.615176] thunderbolt 0000:07:00.0: 0:c: in use
[   54.615309] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   54.615434] thunderbolt 0000:07:00.0: 303:b: in use
[   54.615561] thunderbolt 0000:07:00.0: 3:b: DP OUT available
[   54.615692] thunderbolt 0000:07:00.0: in->port 13
[   54.615694] thunderbolt 0000:07:00.0: Tunnel 0

Both displays are working

This doesn't (standard cold boot):

brad@bkmac:~$ dmesg | egrep '(Tunnel|in->|in use|DP .* available)'
[    1.611396] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.611399] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
[    1.611521] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[    1.611648] thunderbolt 0000:07:00.0: 0:c: in use
[    1.611777] thunderbolt 0000:07:00.0: 0:d: DP IN available
[    1.611904] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[    1.612162] thunderbolt 0000:07:00.0: in->port 13
[    1.612166] thunderbolt 0000:07:00.0: Tunnel 0

Both displays are working at this point.
Unplug -> Replug
[   72.181366] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   72.181487] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   72.181489] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
[   81.369074] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
[   81.369207] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   81.369335] thunderbolt 0000:07:00.0: 3:b: DP OUT available
[   81.369468] thunderbolt 0000:07:00.0: in->port 12
[   81.369471] thunderbolt 0000:07:00.0: Tunnel 1
[   81.376542] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[   81.376669] thunderbolt 0000:07:00.0: 0:c: in use
[   81.376797] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   81.376925] thunderbolt 0000:07:00.0: 3:b: in use
[   81.377058] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[   81.377320] thunderbolt 0000:07:00.0: in->port 13
[   81.377328] thunderbolt 0000:07:00.0: Tunnel 0

First display in the chain fails clock recovery.

Full dmesg of failure here :

[    0.000000] Linux version 5.17.0+ (brad@bkmac) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #48 SMP PREEMPT_DYNAMIC Thu Mar 31 16:31:24 AWST 2022
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
[    0.000000] e820: update [mem 0x89109018-0x89124c57] usable ==> usable
[    0.000000] e820: update [mem 0x89109018-0x89124c57] usable ==> usable
[    0.000000] e820: update [mem 0x891a7018-0x891b8c3d] usable ==> usable
[    0.000000] e820: update [mem 0x891a7018-0x891b8c3d] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000008dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008e000-0x000000000008ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000040000000-0x00000000401fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000040200000-0x0000000089109017] usable
[    0.000000] reserve setup_data: [mem 0x0000000089109018-0x0000000089124c57] usable
[    0.000000] reserve setup_data: [mem 0x0000000089124c58-0x00000000891a7017] usable
[    0.000000] reserve setup_data: [mem 0x00000000891a7018-0x00000000891b8c3d] usable
[    0.000000] reserve setup_data: [mem 0x00000000891b8c3e-0x000000008ed32fff] usable
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
[    0.000000] tsc: Detected 3400.327 MHz processor
[    0.000095] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000097] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000103] last_pfn = 0x86ff00 max_arch_pfn = 0x400000000
[    0.000754] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001371] last_pfn = 0x8efa3 max_arch_pfn = 0x400000000
[    0.002471] Secure boot disabled
[    0.002472] RAMDISK: [mem 0x7e4ad000-0x7fffffff]
[    0.002476] ACPI: Early table checksum verification disabled
[    0.002480] ACPI: RSDP 0x000000008ED8E014 000024 (v02 APPLE )
[    0.002484] ACPI: XSDT 0x000000008ED8E1C0 0000A4 (v01 APPLE  Apple00  0000F000      01000013)
[    0.002488] ACPI: FACP 0x000000008ED8C000 0000F4 (v04 APPLE  Apple00  0000F000 Loki 0000005F)
[    0.002493] ACPI: DSDT 0x000000008ED81000 0053FB (v01 APPLE  iMac     00210001 INTL 20061109)
[    0.002496] ACPI: FACS 0x000000008ED3E000 000040
[    0.002498] ACPI: FACS 0x000000008ED3E000 000040
[    0.002500] ACPI: HPET 0x000000008ED8B000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002503] ACPI: APIC 0x000000008ED8A000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002505] ACPI: SBST 0x000000008ED88000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002508] ACPI: ECDT 0x000000008ED87000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002510] ACPI: SSDT 0x000000008ED7E000 00020D (v01 APPLE  SataAhci 00001000 INTL 20061109)
[    0.002513] ACPI: SSDT 0x000000008ED7C000 0000B1 (v01 APPLE  SmcDppt  00001000 INTL 20061109)
[    0.002516] ACPI: SSDT 0x000000008ED7A000 000646 (v01 APPLE  UsbNoRmh 00001000 INTL 20061109)
[    0.002518] ACPI: SSDT 0x000000008ED78000 00013D (v01 APPLE  SataPrt1 00001000 INTL 20061109)
[    0.002521] ACPI: SSDT 0x000000008ED77000 0000A0 (v02 APPLE  IGHda    00001000 INTL 20061109)
[    0.002523] ACPI: SSDT 0x000000008ED75000 000032 (v01 APPLE  SsdtS3   00001000 INTL 20061109)
[    0.002526] ACPI: SSDT 0x000000008ED74000 000548 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.002528] ACPI: SSDT 0x000000008ED73000 0009B1 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.002531] ACPI: SSDT 0x000000008ED72000 000315 (v01 PmRef  Cpu0Tst  00003000 INTL 20061109)
[    0.002534] ACPI: SSDT 0x000000008ED71000 00037A (v01 PmRef  ApTst    00003000 INTL 20061109)
[    0.002536] ACPI: MCFG 0x000000008ED89000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002538] ACPI: Reserving FACP table memory at [mem 0x8ed8c000-0x8ed8c0f3]
[    0.002540] ACPI: Reserving DSDT table memory at [mem 0x8ed81000-0x8ed863fa]
[    0.002541] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002542] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002543] ACPI: Reserving HPET table memory at [mem 0x8ed8b000-0x8ed8b037]
[    0.002544] ACPI: Reserving APIC table memory at [mem 0x8ed8a000-0x8ed8a0bb]
[    0.002545] ACPI: Reserving SBST table memory at [mem 0x8ed88000-0x8ed8802f]
[    0.002546] ACPI: Reserving ECDT table memory at [mem 0x8ed87000-0x8ed87052]
[    0.002547] ACPI: Reserving SSDT table memory at [mem 0x8ed7e000-0x8ed7e20c]
[    0.002549] ACPI: Reserving SSDT table memory at [mem 0x8ed7c000-0x8ed7c0b0]
[    0.002550] ACPI: Reserving SSDT table memory at [mem 0x8ed7a000-0x8ed7a645]
[    0.002551] ACPI: Reserving SSDT table memory at [mem 0x8ed78000-0x8ed7813c]
[    0.002552] ACPI: Reserving SSDT table memory at [mem 0x8ed77000-0x8ed7709f]
[    0.002553] ACPI: Reserving SSDT table memory at [mem 0x8ed75000-0x8ed75031]
[    0.002554] ACPI: Reserving SSDT table memory at [mem 0x8ed74000-0x8ed74547]
[    0.002555] ACPI: Reserving SSDT table memory at [mem 0x8ed73000-0x8ed739b0]
[    0.002556] ACPI: Reserving SSDT table memory at [mem 0x8ed72000-0x8ed72314]
[    0.002557] ACPI: Reserving SSDT table memory at [mem 0x8ed71000-0x8ed71379]
[    0.002559] ACPI: Reserving MCFG table memory at [mem 0x8ed89000-0x8ed8903b]
[    0.002565] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.002592] Zone ranges:
[    0.002593]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002595]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002597]   Normal   [mem 0x0000000100000000-0x000000086fefffff]
[    0.002598] Movable zone start for each node
[    0.002599] Early memory node ranges
[    0.002599]   node   0: [mem 0x0000000000001000-0x000000000008dfff]
[    0.002601]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.002602]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.002603]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.002604]   node   0: [mem 0x0000000040200000-0x000000008ed32fff]
[    0.002605]   node   0: [mem 0x000000008ed5f000-0x000000008ed70fff]
[    0.002606]   node   0: [mem 0x000000008ed8f000-0x000000008ee59fff]
[    0.002606]   node   0: [mem 0x000000008ee8f000-0x000000008eed6fff]
[    0.002607]   node   0: [mem 0x000000008eeff000-0x000000008efa2fff]
[    0.002608]   node   0: [mem 0x0000000100000000-0x000000086fefffff]
[    0.002611] Initmem setup node 0 [mem 0x0000000000001000-0x000000086fefffff]
[    0.002615] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002616] On node 0, zone DMA: 2 pages in unavailable ranges
[    0.002635] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.004133] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006371] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006376] On node 0, zone DMA32: 44 pages in unavailable ranges
[    0.006379] On node 0, zone DMA32: 30 pages in unavailable ranges
[    0.006381] On node 0, zone DMA32: 53 pages in unavailable ranges
[    0.006383] On node 0, zone DMA32: 40 pages in unavailable ranges
[    0.060514] On node 0, zone Normal: 4189 pages in unavailable ranges
[    0.060521] On node 0, zone Normal: 256 pages in unavailable ranges
[    0.060682] ACPI: PM-Timer IO Port: 0x408
[    0.060688] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.060690] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.060691] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.060692] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.060692] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.060693] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.060694] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.060695] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.060704] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.060706] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.060708] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.060711] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.060712] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.060716] TSC deadline timer available
[    0.060717] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.060739] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.060741] PM: hibernation: Registered nosave memory: [mem 0x0008e000-0x0008ffff]
[    0.060743] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
[    0.060744] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.060746] PM: hibernation: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.060748] PM: hibernation: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.060749] PM: hibernation: Registered nosave memory: [mem 0x89109000-0x89109fff]
[    0.060751] PM: hibernation: Registered nosave memory: [mem 0x89124000-0x89124fff]
[    0.060753] PM: hibernation: Registered nosave memory: [mem 0x891a7000-0x891a7fff]
[    0.060755] PM: hibernation: Registered nosave memory: [mem 0x891b8000-0x891b8fff]
[    0.060757] PM: hibernation: Registered nosave memory: [mem 0x8ed33000-0x8ed5efff]
[    0.060759] PM: hibernation: Registered nosave memory: [mem 0x8ed71000-0x8ed8efff]
[    0.060760] PM: hibernation: Registered nosave memory: [mem 0x8ee5a000-0x8ee8efff]
[    0.060762] PM: hibernation: Registered nosave memory: [mem 0x8eed7000-0x8eefefff]
[    0.060764] PM: hibernation: Registered nosave memory: [mem 0x8efa3000-0x8f8fffff]
[    0.060765] PM: hibernation: Registered nosave memory: [mem 0x8f900000-0xe00f7fff]
[    0.060766] PM: hibernation: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.060767] PM: hibernation: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff]
[    0.060768] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.060768] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xffed7fff]
[    0.060769] PM: hibernation: Registered nosave memory: [mem 0xffed8000-0xffefffff]
[    0.060770] PM: hibernation: Registered nosave memory: [mem 0xfff00000-0xffffffff]
[    0.060772] [mem 0x8f900000-0xe00f7fff] available for PCI devices
[    0.060775] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.063067] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.063235] percpu: Embedded 44 pages/cpu s139880 r8192 d32152 u262144
[    0.063242] pcpu-alloc: s139880 r8192 d32152 u262144 alloc=1*2097152
[    0.063244] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.063265] Built 1 zonelists, mobility grouping on.  Total pages: 8251732
[    0.063267] Kernel command line: ro root=UUID=de35d1a6-e0e1-40b0-b46a-3974a04adf4b libata.allow_tpm=1 netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da oops=panic panic=10 thunderbolt.dyndbg pci=assign-busses,realloc,hpbussize=0x10,hpmmiosize=128M,hpmmioprefsize=1G initrd=boot\initrd.img-5.17.0+
[    0.063328] Unknown kernel command line parameters "netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da", will be passed to user space.
[    0.064951] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.065775] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.065840] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.152473] Memory: 32768252K/33531492K available (8192K kernel code, 2298K rwdata, 1860K rodata, 956K init, 2628K bss, 762984K reserved, 0K cma-reserved)
[    0.152508] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.152722] Dynamic Preempt: voluntary
[    0.152746] rcu: Preemptible hierarchical RCU implementation.
[    0.152748] 	Trampoline variant of Tasks RCU enabled.
[    0.152749] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.152757] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
[    0.152949] random: get_random_bytes called from start_kernel+0x443/0x5fb with crng_init=0
[    0.152974] Console: colour dummy device 80x25
[    0.153243] printk: console [tty0] enabled
[    0.153251] ACPI: Core revision 20211217
[    0.153334] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.153349] APIC: Switch to symmetric I/O mode setup
[    0.153727] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.203344] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3103833a219, max_idle_ns: 440795222021 ns
[    0.203349] Calibrating delay loop (skipped), value calculated using timer frequency.. 6800.65 BogoMIPS (lpj=34003270)
[    0.203353] pid_max: default: 32768 minimum: 301
[    0.207271] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.207335] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.207455] CPU0: Thermal monitoring enabled (TM1)
[    0.207459] process: using mwait in idle threads
[    0.207462] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.207464] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.207467] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.207470] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.207471] Spectre V2 : Vulnerable
[    0.207474] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.207476] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.207478] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.207481] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.207483] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.207486] MDS: Mitigation: Clear CPU buffers
[    0.207645] Freeing SMP alternatives memory: 24K
[    0.207914] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1054
[    0.207920] smpboot: CPU0: Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz (family: 0x6, model: 0x2a, stepping: 0x7)
[    0.207986] cblist_init_generic: Setting adjustable number of callback queues.
[    0.207990] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.208000] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.208013] ... version:                3
[    0.208015] ... bit width:              48
[    0.208016] ... generic registers:      4
[    0.208018] ... value mask:             0000ffffffffffff
[    0.208019] ... max period:             00007fffffffffff
[    0.208021] ... fixed-purpose events:   3
[    0.208023] ... event mask:             000000070000000f
[    0.208100] rcu: Hierarchical SRCU implementation.
[    0.208201] smp: Bringing up secondary CPUs ...
[    0.208246] x86: Booting SMP configuration:
[    0.208248] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.216799] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.216799]  #5 #6 #7
[    0.226677] smp: Brought up 1 node, 8 CPUs
[    0.226677] smpboot: Max logical packages: 1
[    0.226677] smpboot: Total of 8 processors activated (54405.23 BogoMIPS)
[    0.228844] devtmpfs: initialized
[    0.228844] ACPI: PM: Registering ACPI NVS region [mem 0x8ed33000-0x8ed5efff] (180224 bytes)
[    0.228844] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.228844] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.228844] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.228844] thermal_sys: Registered thermal governor 'step_wise'
[    0.228844] thermal_sys: Registered thermal governor 'user_space'
[    0.228844] cpuidle: using governor ladder
[    0.228844] cpuidle: using governor menu
[    0.228844] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.228844] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.228844] PCI: not using MMCONFIG
[    0.228844] PCI: Using configuration type 1 for base access
[    0.228844] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.233850] ACPI: Disabled all _OSI OS vendors
[    0.233850] ACPI: Added _OSI(Module Device)
[    0.233850] ACPI: Added _OSI(Processor Device)
[    0.233850] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.233850] ACPI: Added _OSI(Processor Aggregator Device)
[    0.233850] ACPI: Added _OSI(Linux-Dell-Video)
[    0.233850] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.233850] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.233850] ACPI: Added _OSI(Darwin)
[    0.235674] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.235875] ACPI: EC: EC started
[    0.235878] ACPI: EC: interrupt blocked
[    0.236365] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.236368] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.236496] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.236629] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.236829] ACPI: Dynamic OEM Table Load:
[    0.236837] ACPI: SSDT 0xFFFF888100379800 000781 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.237154] ACPI: Dynamic OEM Table Load:
[    0.237160] ACPI: SSDT 0xFFFF88810036E800 0003A4 (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.237392] ACPI: Dynamic OEM Table Load:
[    0.237397] ACPI: SSDT 0xFFFF8881000FA600 000119 (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.238178] ACPI: Interpreter enabled
[    0.238192] ACPI: PM: (supports S0 S3 S4 S5)
[    0.238194] ACPI: Using IOAPIC for interrupt routing
[    0.238211] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.238423] PCI: MMCONFIG at [mem 0xe0000000-0xefbfffff] reserved in ACPI motherboard resources
[    0.238435] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.238529] ACPI: Enabled 6 GPEs in block 00 to 3F
[    0.241387] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.241393] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.241398] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-fb] only partially covers this bridge
[    0.241534] PCI host bridge to bus 0000:00
[    0.241537] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.241540] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.241543] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.241546] pci_bus 0000:00: root bus resource [mem 0x8f900000-0xfeafffff window]
[    0.241548] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.241551] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.241561] pci 0000:00:00.0: [8086:0100] type 00 class 0x060000
[    0.241623] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
[    0.241651] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.241706] pci 0000:00:02.0: [8086:0102] type 00 class 0x038000
[    0.241714] pci 0000:00:02.0: reg 0x10: [mem 0xa8000000-0xa83fffff 64bit]
[    0.241719] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xa7ffffff 64bit pref]
[    0.241724] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.241795] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.241814] pci 0000:00:16.0: reg 0x10: [mem 0xa8907100-0xa890710f 64bit]
[    0.241881] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.241926] pci 0000:00:1a.0: [8086:1c2c] type 00 class 0x0c0300
[    0.241964] pci 0000:00:1a.0: reg 0x20: [io  0x3140-0x315f]
[    0.242047] pci 0000:00:1a.7: [8086:1c2d] type 00 class 0x0c0320
[    0.242063] pci 0000:00:1a.7: reg 0x10: [mem 0xa8906c00-0xa8906fff]
[    0.242138] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.242304] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.242319] pci 0000:00:1b.0: reg 0x10: [mem 0xa8900000-0xa8903fff 64bit]
[    0.242380] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.242438] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.242518] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.242584] pci 0000:00:1c.1: [8086:1c12] type 01 class 0x060400
[    0.242662] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.242727] pci 0000:00:1c.2: [8086:1c14] type 01 class 0x060400
[    0.243413] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.243479] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    0.243557] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.243621] pci 0000:00:1d.0: [8086:1c27] type 00 class 0x0c0300
[    0.243659] pci 0000:00:1d.0: reg 0x20: [io  0x30e0-0x30ff]
[    0.243742] pci 0000:00:1d.7: [8086:1c26] type 00 class 0x0c0320
[    0.243757] pci 0000:00:1d.7: reg 0x10: [mem 0xa8906800-0xa8906bff]
[    0.243833] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.243995] pci 0000:00:1f.0: [8086:1c44] type 00 class 0x060100
[    0.244137] pci 0000:00:1f.2: [8086:1c02] type 00 class 0x010601
[    0.244150] pci 0000:00:1f.2: reg 0x10: [io  0x3168-0x316f]
[    0.244157] pci 0000:00:1f.2: reg 0x14: [io  0x317c-0x317f]
[    0.244164] pci 0000:00:1f.2: reg 0x18: [io  0x3160-0x3167]
[    0.244172] pci 0000:00:1f.2: reg 0x1c: [io  0x3178-0x317b]
[    0.244179] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
[    0.244186] pci 0000:00:1f.2: reg 0x24: [mem 0xa8906000-0xa89067ff]
[    0.244221] pci 0000:00:1f.2: PME# supported from D3hot
[    0.244267] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    0.244281] pci 0000:00:1f.3: reg 0x10: [mem 0xa8907000-0xa89070ff 64bit]
[    0.244296] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.244398] pci 0000:01:00.0: [1002:6720] type 00 class 0x030000
[    0.244413] pci 0000:01:00.0: reg 0x10: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.244424] pci 0000:01:00.0: reg 0x18: [mem 0xa8800000-0xa881ffff 64bit]
[    0.244432] pci 0000:01:00.0: reg 0x20: [io  0x2000-0x20ff]
[    0.244445] pci 0000:01:00.0: reg 0x30: [mem 0xa8820000-0xa883ffff pref]
[    0.244451] pci 0000:01:00.0: enabling Extended Tags
[    0.244461] pci 0000:01:00.0: BAR 0: assigned to efifb
[    0.244491] pci 0000:01:00.0: supports D1 D2
[    0.244579] pci 0000:01:00.1: [1002:aa88] type 00 class 0x040300
[    0.244593] pci 0000:01:00.1: reg 0x10: [mem 0xa8840000-0xa8843fff 64bit]
[    0.244618] pci 0000:01:00.1: enabling Extended Tags
[    0.244653] pci 0000:01:00.1: supports D1 D2
[    0.244745] pci 0000:00:01.0: PCI bridge to [bus 01-ff]
[    0.244748] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.244751] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.244755] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.244758] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.244831] pci 0000:02:00.0: [14e4:16b4] type 00 class 0x020000
[    0.244865] pci 0000:02:00.0: reg 0x10: [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.244888] pci 0000:02:00.0: reg 0x18: [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.245044] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.245158] pci 0000:00:1c.0: PCI bridge to [bus 02-ff]
[    0.245165] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.245171] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.245174] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    0.245244] pci 0000:03:00.0: [168c:0030] type 00 class 0x028000
[    0.245275] pci 0000:03:00.0: reg 0x10: [mem 0xa8600000-0xa861ffff 64bit]
[    0.245336] pci 0000:03:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    0.245427] pci 0000:03:00.0: supports D1 D2
[    0.245429] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.245528] pci 0000:00:1c.1: PCI bridge to [bus 03-ff]
[    0.245535] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.245541] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.245612] pci 0000:04:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.245646] pci 0000:04:00.0: reg 0x10: [mem 0xa8500000-0xa8500fff 64bit]
[    0.245808] pci 0000:04:00.0: supports D1 D2
[    0.245810] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246004] pci 0000:00:1c.2: PCI bridge to [bus 04-ff]
[    0.246011] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.246017] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.246089] pci 0000:05:00.0: [8086:1513] type 01 class 0x060400
[    0.246154] pci 0000:05:00.0: enabling Extended Tags
[    0.246249] pci 0000:05:00.0: supports D1 D2
[    0.246251] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246376] pci 0000:00:1c.4: PCI bridge to [bus 05-ff]
[    0.246381] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.246385] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.246391] pci 0000:00:1c.4:   bridge window [mem 0xacf00000-0xb10fffff 64bit pref]
[    0.246475] acpiphp: Slot [3] registered
[    0.246497] acpiphp: Slot [4] registered
[    0.246539] pci 0000:06:00.0: [8086:1513] type 01 class 0x060400
[    0.246609] pci 0000:06:00.0: enabling Extended Tags
[    0.246709] pci 0000:06:00.0: supports D1 D2
[    0.246711] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246823] pci 0000:06:03.0: [8086:1513] type 01 class 0x060400
[    0.246893] pci 0000:06:03.0: enabling Extended Tags
[    0.246995] pci 0000:06:03.0: supports D1 D2
[    0.246997] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247102] pci 0000:06:04.0: [8086:1513] type 01 class 0x060400
[    0.247172] pci 0000:06:04.0: enabling Extended Tags
[    0.247273] pci 0000:06:04.0: supports D1 D2
[    0.247275] pci 0000:06:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247383] pci 0000:06:05.0: [8086:1513] type 01 class 0x060400
[    0.247453] pci 0000:06:05.0: enabling Extended Tags
[    0.247554] pci 0000:06:05.0: supports D1 D2
[    0.247556] pci 0000:06:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247665] pci 0000:06:06.0: [8086:1513] type 01 class 0x060400
[    0.247735] pci 0000:06:06.0: enabling Extended Tags
[    0.247836] pci 0000:06:06.0: supports D1 D2
[    0.247838] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247955] pci 0000:05:00.0: PCI bridge to [bus 06-ff]
[    0.247966] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.247975] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.248074] acpiphp: Slot [1] registered
[    0.248115] pci 0000:07:00.0: [8086:1513] type 00 class 0x088000
[    0.248142] pci 0000:07:00.0: reg 0x10: [mem 0xa8a00000-0xa8a3ffff]
[    0.248158] pci 0000:07:00.0: reg 0x14: [mem 0xa8a40000-0xa8a40fff]
[    0.248238] pci 0000:07:00.0: enabling Extended Tags
[    0.248362] pci 0000:07:00.0: supports D1 D2
[    0.248364] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248505] pci 0000:06:00.0: PCI bridge to [bus 07-ff]
[    0.248517] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.248526] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    0.248583] pci 0000:06:03.0: PCI bridge to [bus 08-ff]
[    0.248595] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.248604] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 17
[    0.248716] pci 0000:18:00.0: [8086:1513] type 01 class 0x060400
[    0.248834] pci 0000:18:00.0: enabling Extended Tags
[    0.249011] pci 0000:18:00.0: supports D1 D2
[    0.249013] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.273408] pci 0000:06:04.0: PCI bridge to [bus 18-ff]
[    0.273426] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.273439] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.273448] pci 0000:18:00.0: bridge configuration invalid ([bus 3a-49]), reconfiguring
[    0.273613] pci 0000:19:00.0: [8086:1513] type 01 class 0x060400
[    0.273738] pci 0000:19:00.0: enabling Extended Tags
[    0.273919] pci 0000:19:00.0: supports D1 D2
[    0.273921] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274078] pci 0000:19:01.0: [8086:1513] type 01 class 0x060400
[    0.274202] pci 0000:19:01.0: enabling Extended Tags
[    0.274382] pci 0000:19:01.0: supports D1 D2
[    0.274384] pci 0000:19:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274539] pci 0000:19:02.0: [8086:1513] type 01 class 0x060400
[    0.274663] pci 0000:19:02.0: enabling Extended Tags
[    0.274843] pci 0000:19:02.0: supports D1 D2
[    0.274845] pci 0000:19:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275006] pci 0000:19:04.0: [8086:1513] type 01 class 0x060400
[    0.275130] pci 0000:19:04.0: enabling Extended Tags
[    0.275313] pci 0000:19:04.0: supports D1 D2
[    0.275315] pci 0000:19:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275476] pci 0000:19:05.0: [8086:1513] type 01 class 0x060400
[    0.275583] pci 0000:19:05.0: enabling Extended Tags
[    0.275767] pci 0000:19:05.0: supports D1 D2
[    0.275769] pci 0000:19:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275949] pci 0000:18:00.0: PCI bridge to [bus 19-ff]
[    0.275968] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.275982] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.275988] pci 0000:19:00.0: bridge configuration invalid ([bus 3b-3d]), reconfiguring
[    0.276005] pci 0000:19:01.0: bridge configuration invalid ([bus 3e-3e]), reconfiguring
[    0.276022] pci 0000:19:02.0: bridge configuration invalid ([bus 3f-3f]), reconfiguring
[    0.276039] pci 0000:19:04.0: bridge configuration invalid ([bus 40-48]), reconfiguring
[    0.276056] pci 0000:19:05.0: bridge configuration invalid ([bus 49-49]), reconfiguring
[    0.276210] pci 0000:1a:00.0: [12d8:400c] type 01 class 0x060400
[    0.276598] pci 0000:1a:00.0: supports D1 D2
[    0.276600] pci 0000:1a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.303386] pci 0000:19:00.0: PCI bridge to [bus 1a-ff]
[    0.303410] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.303432] pci 0000:1a:00.0: bridge configuration invalid ([bus 3c-3d]), reconfiguring
[    0.303668] pci 0000:1b:03.0: [12d8:400c] type 01 class 0x060400
[    0.304004] pci 0000:1b:03.0: supports D1 D2
[    0.304006] pci 0000:1b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304208] pci 0000:1a:00.0: PCI bridge to [bus 1b-ff]
[    0.304233] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.304254] pci 0000:1b:03.0: bridge configuration invalid ([bus 3d-3d]), reconfiguring
[    0.304458] pci 0000:1c:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.304510] pci 0000:1c:00.0: reg 0x10: [mem 0xa9401000-0xa9401fff]
[    0.304823] pci 0000:1c:00.0: supports D1 D2
[    0.304825] pci 0000:1c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304980] pci 0000:1c:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.305032] pci 0000:1c:00.1: reg 0x10: [mem 0xa9400000-0xa9400fff]
[    0.305344] pci 0000:1c:00.1: supports D1 D2
[    0.305347] pci 0000:1c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.305473] pci 0000:1c:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.305525] pci 0000:1c:00.2: reg 0x10: [mem 0xa9402000-0xa94020ff]
[    0.305837] pci 0000:1c:00.2: supports D1 D2
[    0.305839] pci 0000:1c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.306096] pci 0000:1b:03.0: PCI bridge to [bus 1c-ff]
[    0.306121] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.306139] pci_bus 0000:1c: busn_res: [bus 1c-ff] end is updated to 1c
[    0.306149] pci_bus 0000:1b: busn_res: [bus 1b-ff] end is updated to 1c
[    0.306160] pci_bus 0000:1a: busn_res: [bus 1a-ff] end is updated to 1c
[    0.306306] pci 0000:1d:00.0: [14e4:16b0] type 00 class 0x020000
[    0.306376] pci 0000:1d:00.0: reg 0x10: [mem 0xad000000-0xad00ffff 64bit pref]
[    0.306422] pci 0000:1d:00.0: reg 0x18: [mem 0xad010000-0xad01ffff 64bit pref]
[    0.306764] pci 0000:1d:00.0: PME# supported from D0 D3hot D3cold
[    0.333405] pci 0000:19:01.0: PCI bridge to [bus 1d-ff]
[    0.333429] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.333447] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.333461] pci_bus 0000:1d: busn_res: [bus 1d-ff] end is updated to 1d
[    0.333605] pci 0000:1e:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.333675] pci 0000:1e:00.0: reg 0x10: [mem 0xa9200000-0xa9200fff 64bit]
[    0.334029] pci 0000:1e:00.0: supports D1 D2
[    0.334031] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.363404] pci 0000:19:02.0: PCI bridge to [bus 1e-ff]
[    0.363429] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.363447] pci_bus 0000:1e: busn_res: [bus 1e-ff] end is updated to 1e
[    0.363627] pci 0000:1f:00.0: [8086:1513] type 01 class 0x060400
[    0.363799] pci 0000:1f:00.0: enabling Extended Tags
[    0.364057] pci 0000:1f:00.0: supports D1 D2
[    0.364059] pci 0000:1f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.393391] pci 0000:19:04.0: PCI bridge to [bus 1f-ff]
[    0.393415] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.393433] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.393443] pci 0000:1f:00.0: bridge configuration invalid ([bus 41-48]), reconfiguring
[    0.393672] pci 0000:20:00.0: [8086:1513] type 01 class 0x060400
[    0.393851] pci 0000:20:00.0: enabling Extended Tags
[    0.394113] pci 0000:20:00.0: supports D1 D2
[    0.394115] pci 0000:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394335] pci 0000:20:01.0: [8086:1513] type 01 class 0x060400
[    0.394514] pci 0000:20:01.0: enabling Extended Tags
[    0.394775] pci 0000:20:01.0: supports D1 D2
[    0.394777] pci 0000:20:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394995] pci 0000:20:02.0: [8086:1513] type 01 class 0x060400
[    0.395174] pci 0000:20:02.0: enabling Extended Tags
[    0.395435] pci 0000:20:02.0: supports D1 D2
[    0.395437] pci 0000:20:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.395663] pci 0000:20:04.0: [8086:1513] type 01 class 0x060400
[    0.395818] pci 0000:20:04.0: enabling Extended Tags
[    0.396083] pci 0000:20:04.0: supports D1 D2
[    0.396086] pci 0000:20:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.396313] pci 0000:20:05.0: [8086:1513] type 01 class 0x060400
[    0.396468] pci 0000:20:05.0: enabling Extended Tags
[    0.396734] pci 0000:20:05.0: supports D1 D2
[    0.396736] pci 0000:20:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.396991] pci 0000:1f:00.0: PCI bridge to [bus 20-ff]
[    0.397018] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.397037] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.397044] pci 0000:20:00.0: bridge configuration invalid ([bus 42-44]), reconfiguring
[    0.397067] pci 0000:20:01.0: bridge configuration invalid ([bus 45-45]), reconfiguring
[    0.397090] pci 0000:20:02.0: bridge configuration invalid ([bus 46-46]), reconfiguring
[    0.397113] pci 0000:20:04.0: bridge configuration invalid ([bus 47-47]), reconfiguring
[    0.397137] pci 0000:20:05.0: bridge configuration invalid ([bus 48-48]), reconfiguring
[    0.397350] pci 0000:21:00.0: [12d8:400c] type 01 class 0x060400
[    0.397873] pci 0000:21:00.0: supports D1 D2
[    0.397875] pci 0000:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.398143] pci 0000:20:00.0: PCI bridge to [bus 21-ff]
[    0.398170] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.398194] pci 0000:21:00.0: bridge configuration invalid ([bus 43-44]), reconfiguring
[    0.398492] pci 0000:22:03.0: [12d8:400c] type 01 class 0x060400
[    0.398941] pci 0000:22:03.0: supports D1 D2
[    0.398943] pci 0000:22:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.399208] pci 0000:21:00.0: PCI bridge to [bus 22-ff]
[    0.399241] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.399269] pci 0000:22:03.0: bridge configuration invalid ([bus 44-44]), reconfiguring
[    0.399540] pci 0000:23:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.399608] pci 0000:23:00.0: reg 0x10: [mem 0xa9101000-0xa9101fff]
[    0.400028] pci 0000:23:00.0: supports D1 D2
[    0.400030] pci 0000:23:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400238] pci 0000:23:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.400306] pci 0000:23:00.1: reg 0x10: [mem 0xa9100000-0xa9100fff]
[    0.400724] pci 0000:23:00.1: supports D1 D2
[    0.400727] pci 0000:23:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400890] pci 0000:23:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.400959] pci 0000:23:00.2: reg 0x10: [mem 0xa9102000-0xa91020ff]
[    0.401377] pci 0000:23:00.2: supports D1 D2
[    0.401379] pci 0000:23:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.401733] pci 0000:22:03.0: PCI bridge to [bus 23-ff]
[    0.401766] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.401788] pci_bus 0000:23: busn_res: [bus 23-ff] end is updated to 23
[    0.401801] pci_bus 0000:22: busn_res: [bus 22-ff] end is updated to 23
[    0.401814] pci_bus 0000:21: busn_res: [bus 21-ff] end is updated to 23
[    0.402017] pci 0000:24:00.0: [14e4:16b0] type 00 class 0x020000
[    0.402108] pci 0000:24:00.0: reg 0x10: [mem 0xacf00000-0xacf0ffff 64bit pref]
[    0.402168] pci 0000:24:00.0: reg 0x18: [mem 0xacf10000-0xacf1ffff 64bit pref]
[    0.402622] pci 0000:24:00.0: PME# supported from D0 D3hot D3cold
[    0.402940] pci 0000:20:01.0: PCI bridge to [bus 24-ff]
[    0.402967] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.402986] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.402989] pci_bus 0000:24: busn_res: [bus 24-ff] end is updated to 24
[    0.403186] pci 0000:25:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.403278] pci 0000:25:00.0: reg 0x10: [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.403742] pci 0000:25:00.0: supports D1 D2
[    0.403745] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.404043] pci 0000:20:02.0: PCI bridge to [bus 25-ff]
[    0.404070] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.404089] pci_bus 0000:25: busn_res: [bus 25-ff] end is updated to 25
[    0.404222] pci 0000:20:04.0: PCI bridge to [bus 26-ff]
[    0.404249] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.404268] pci_bus 0000:26: busn_res: [bus 26-ff] end is updated to 35
[    0.404401] pci 0000:20:05.0: PCI bridge to [bus 36-ff]
[    0.404428] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.404447] pci_bus 0000:36: busn_res: [bus 36-ff] end is updated to 45
[    0.404458] pci_bus 0000:20: busn_res: [bus 20-ff] end is updated to 45
[    0.404469] pci_bus 0000:1f: busn_res: [bus 1f-ff] end is updated to 45
[    0.404562] pci 0000:19:05.0: PCI bridge to [bus 46-ff]
[    0.404581] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.404595] pci_bus 0000:46: busn_res: [bus 46-ff] end is updated to 55
[    0.404603] pci_bus 0000:19: busn_res: [bus 19-ff] end is updated to 55
[    0.404612] pci_bus 0000:18: busn_res: [bus 18-ff] end is updated to 55
[    0.404673] pci 0000:06:05.0: PCI bridge to [bus 56-ff]
[    0.404685] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.404694] pci_bus 0000:56: busn_res: [bus 56-ff] end is updated to 65
[    0.404750] pci 0000:06:06.0: PCI bridge to [bus 66-ff]
[    0.404762] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.404771] pci_bus 0000:66: busn_res: [bus 66-ff] end is updated to 75
[    0.404777] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 75
[    0.404782] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 75
[    0.404787] pci_bus 0000:00: on NUMA node 0
[    0.405054] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.405057] ACPI: PCI: Interrupt link LNKA disabled
[    0.405088] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.405091] ACPI: PCI: Interrupt link LNKB disabled
[    0.405120] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.405122] ACPI: PCI: Interrupt link LNKC disabled
[    0.405150] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.405152] ACPI: PCI: Interrupt link LNKD disabled
[    0.405181] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.405183] ACPI: PCI: Interrupt link LNKE disabled
[    0.405211] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.405213] ACPI: PCI: Interrupt link LNKF disabled
[    0.405241] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.405243] ACPI: PCI: Interrupt link LNKG disabled
[    0.405271] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.405273] ACPI: PCI: Interrupt link LNKH disabled
[    0.405359] ACPI: EC: interrupt unblocked
[    0.405362] ACPI: EC: event unblocked
[    0.405366] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.405368] ACPI: EC: GPE=0x17
[    0.405370] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.405373] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.405426] SCSI subsystem initialized
[    0.405434] libata version 3.00 loaded.
[    0.405434] Registered efivars operations
[    0.405434] PCI: Using ACPI for IRQ routing
[    0.416094] PCI: pci_cache_line_size set to 64 bytes
[    0.416097] pci 0000:00:1c.4: can't claim BAR 9 [mem 0xacf00000-0xb10fffff 64bit pref]: address conflict with PCI Bus 0000:05 [mem 0xa8a00000-0xad6fffff]
[    0.416377] e820: reserve RAM buffer [mem 0x0008e000-0x0008ffff]
[    0.416379] e820: reserve RAM buffer [mem 0x89109018-0x8bffffff]
[    0.416380] e820: reserve RAM buffer [mem 0x891a7018-0x8bffffff]
[    0.416381] e820: reserve RAM buffer [mem 0x8ed33000-0x8fffffff]
[    0.416382] e820: reserve RAM buffer [mem 0x8ed71000-0x8fffffff]
[    0.416384] e820: reserve RAM buffer [mem 0x8ee5a000-0x8fffffff]
[    0.416385] e820: reserve RAM buffer [mem 0x8eed7000-0x8fffffff]
[    0.416386] e820: reserve RAM buffer [mem 0x8efa3000-0x8fffffff]
[    0.416387] e820: reserve RAM buffer [mem 0x86ff00000-0x86fffffff]
[    0.416396] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.416396] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.416396] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.416396] vgaarb: loaded
[    0.416396] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.416396] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.416396] clocksource: Switched to clocksource tsc-early
[    0.416396] VFS: Disk quotas dquot_6.6.0
[    0.416396] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.416396] pnp: PnP ACPI init
[    0.416502] system 00:00: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.416546] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.416549] system 00:01: [io  0x1000-0x100f] has been reserved
[    0.416552] system 00:01: [io  0xffff] has been reserved
[    0.416554] system 00:01: [io  0xffff] has been reserved
[    0.416557] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.416559] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.416562] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.416714] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.416718] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.416720] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.416723] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.416726] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.416729] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.416731] system 00:03: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.416734] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.416736] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[    0.416739] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.416823] pnp: PnP ACPI: found 4 devices
[    0.416838] pci 0000:01:00.0: assigning 75 device properties
[    0.416838] pci 0000:04:00.0: assigning 2 device properties
[    0.416838] pci 0000:07:00.0: assigning 5 device properties
[    0.416838] pci 0000:1e:00.0: assigning 2 device properties
[    0.416838] pci 0000:25:00.0: assigning 2 device properties
[    0.416838] pci 0000:00:1b.0: assigning 4 device properties
[    0.419158] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.419179] NET: Registered PF_INET protocol family
[    0.419337] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.421195] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.421233] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.421498] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.421585] TCP: Hash tables configured (established 262144 bind 65536)
[    0.421610] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.421670] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.421749] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.421757] pci 0000:03:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[    0.421765] pci_bus 0000:00: max bus depth: 9 pci_try_num: 10
[    0.421778] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.421782] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.421785] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.421788] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.421793] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.421798] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.421802] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.421810] pci 0000:03:00.0: BAR 6: assigned [mem 0xa8620000-0xa862ffff pref]
[    0.421814] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.421819] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.421827] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.421831] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.421840] pci 0000:05:00.0: BAR 7: no space for [io  size 0x8000]
[    0.421842] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x8000]
[    0.421847] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421850] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421853] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421856] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421859] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421862] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421865] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.421867] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421870] pci 0000:06:04.0: BAR 7: no space for [io  size 0x5000]
[    0.421872] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.421875] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.421877] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421880] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.421882] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421886] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.421893] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.421904] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.421911] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.421923] pci 0000:18:00.0: BAR 7: no space for [io  size 0x4000]
[    0.421925] pci 0000:18:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.421929] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421932] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421935] pci 0000:19:04.0: BAR 7: no space for [io  size 0x3000]
[    0.421937] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.421940] pci 0000:19:05.0: BAR 7: no space for [io  size 0x1000]
[    0.421942] pci 0000:19:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421945] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.421958] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.421984] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.421997] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422022] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.422033] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422052] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.422062] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.422071] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.422085] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.422095] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.422115] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.422117] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.422121] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422123] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422127] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422130] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422133] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[    0.422135] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422137] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422140] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422142] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.422159] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422192] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.422210] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422242] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.422257] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422284] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.422298] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.422309] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422328] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.422343] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.422370] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.422384] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.422411] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.422425] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.422452] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.422467] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.422477] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422496] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.422507] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.422514] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422529] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.422539] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.422558] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.422569] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.422577] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422590] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.422597] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.422602] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422611] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.422618] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.422630] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.422637] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.422648] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.422655] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.422660] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422669] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.422672] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.422677] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.422685] pci_bus 0000:00: No. 2 try to assign unassigned res
[    0.422693] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.422696] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.422698] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.422701] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.422705] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.422710] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.422714] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.422721] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.422725] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.422733] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.422738] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.422746] pci 0000:05:00.0: BAR 7: no space for [io  size 0x8000]
[    0.422748] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x8000]
[    0.422752] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422754] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422758] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422760] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422764] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422766] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422769] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.422772] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422774] pci 0000:06:04.0: BAR 7: no space for [io  size 0x5000]
[    0.422776] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.422779] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422781] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422783] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.422786] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422788] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.422795] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.422807] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.422814] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.422825] pci 0000:18:00.0: BAR 7: no space for [io  size 0x4000]
[    0.422828] pci 0000:18:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.422831] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422834] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422836] pci 0000:19:04.0: BAR 7: no space for [io  size 0x3000]
[    0.422839] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.422841] pci 0000:19:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422843] pci 0000:19:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422846] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.422859] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422884] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.422898] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422923] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.422933] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422952] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.422963] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.422971] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.422985] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.422995] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.423015] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.423017] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.423020] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423023] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423026] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423029] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423032] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[    0.423034] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.423037] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[    0.423039] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.423042] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.423059] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423092] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.423109] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423141] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.423156] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423183] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.423197] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.423208] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423227] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.423241] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.423268] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.423283] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.423310] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.423324] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.423351] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.423365] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.423376] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423395] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.423405] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.423413] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423427] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.423437] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.423457] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.423467] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.423475] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423489] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.423495] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.423501] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423510] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.423517] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.423528] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.423535] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.423547] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.423553] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.423559] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423567] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.423570] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.423575] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.423583] pci_bus 0000:00: No. 3 try to assign unassigned res
[    0.423586] release child resource [mem 0xa9100000-0xa9100fff]
[    0.423587] release child resource [mem 0xa9101000-0xa9101fff]
[    0.423587] release child resource [mem 0xa9102000-0xa91020ff]
[    0.423588] pci 0000:22:03.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423591] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.423603] pci 0000:21:00.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423605] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.423618] pci 0000:20:00.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423620] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.423630] release child resource [mem 0xacf00000-0xacf0ffff 64bit pref]
[    0.423631] release child resource [mem 0xacf10000-0xacf1ffff 64bit pref]
[    0.423632] pci 0000:20:01.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423635] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.423658] release child resource [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.423659] pci 0000:20:02.0: resource 8 [mem 0xa8f00000-0xa8ffffff] released
[    0.423661] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.423671] pci 0000:20:04.0: resource 8 [mem 0xa8e00000-0xa8efffff] released
[    0.423674] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.423684] pci 0000:20:05.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.423686] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.423697] pci 0000:1f:00.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423700] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.423722] release child resource [mem 0xa9400000-0xa9400fff]
[    0.423723] release child resource [mem 0xa9401000-0xa9401fff]
[    0.423724] release child resource [mem 0xa9402000-0xa94020ff]
[    0.423725] pci 0000:1b:03.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423727] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.423737] pci 0000:1a:00.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423739] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.423749] pci 0000:19:00.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423751] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.423759] release child resource [mem 0xad000000-0xad00ffff 64bit pref]
[    0.423760] release child resource [mem 0xad010000-0xad01ffff 64bit pref]
[    0.423760] pci 0000:19:01.0: resource 9 [mem 0xad000000-0xad0fffff 64bit pref] released
[    0.423763] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.423779] release child resource [mem 0xa9200000-0xa9200fff 64bit]
[    0.423780] pci 0000:19:02.0: resource 8 [mem 0xa9200000-0xa92fffff] released
[    0.423783] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.423791] pci 0000:19:04.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423794] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.423810] pci 0000:19:05.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.423812] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.423820] pci 0000:18:00.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423823] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.423839] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.423840] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.423841] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.423843] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.423849] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xa8bfffff] released
[    0.423851] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.423857] pci 0000:06:04.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423859] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.423869] pci 0000:06:05.0: resource 8 [mem 0xa9500000-0xa95fffff] released
[    0.423872] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.423877] pci 0000:06:06.0: resource 8 [mem 0xa9600000-0xa96fffff] released
[    0.423879] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.423885] pci 0000:05:00.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423888] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.423898] pci 0000:00:1c.4: resource 7 [io  0x4000-0x4fff] released
[    0.423900] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.423915] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.423918] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.423922] pci 0000:00:1c.4: BAR 7: assigned [io  0x4000-0xbfff]
[    0.423925] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.423927] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.423930] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.423933] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.423937] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.423942] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.423946] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.423952] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.423957] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.423965] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.423969] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.423978] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.423980] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.423984] pci 0000:05:00.0: BAR 7: assigned [io  0x4000-0xbfff]
[    0.423987] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.423990] pci 0000:06:03.0: BAR 8: no space for [mem size 0x08000000]
[    0.423992] pci 0000:06:03.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.423995] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423998] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424001] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.424004] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.424007] pci 0000:06:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424010] pci 0000:06:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424012] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424015] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424018] pci 0000:06:06.0: BAR 8: no space for [mem size 0x08000000]
[    0.424021] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424023] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424026] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424029] pci 0000:06:03.0: BAR 7: assigned [io  0x4000-0x4fff]
[    0.424032] pci 0000:06:04.0: BAR 7: assigned [io  0x5000-0x9fff]
[    0.424034] pci 0000:06:05.0: BAR 7: assigned [io  0xa000-0xafff]
[    0.424036] pci 0000:06:06.0: BAR 7: assigned [io  0xb000-0xbfff]
[    0.424039] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.424046] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.424052] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.424059] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.424071] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.424074] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.424091] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.424094] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.424097] pci 0000:18:00.0: BAR 7: assigned [io  0x5000-0x8fff]
[    0.424100] pci 0000:19:00.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424103] pci 0000:19:01.0: BAR 9: assigned [mem 0xa9200000-0xa92fffff 64bit pref]
[    0.424106] pci 0000:19:02.0: BAR 8: assigned [mem 0xa9400000-0xa94fffff]
[    0.424109] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.424111] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.424114] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424117] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424119] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424122] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424125] pci 0000:19:04.0: BAR 7: assigned [io  0x5000-0x7fff]
[    0.424127] pci 0000:19:05.0: BAR 7: assigned [io  0x8000-0x8fff]
[    0.424130] pci 0000:1a:00.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424133] pci 0000:1b:03.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424136] pci 0000:1c:00.0: BAR 0: assigned [mem 0xa8c00000-0xa8c00fff]
[    0.424146] pci 0000:1c:00.1: BAR 0: assigned [mem 0xa8c01000-0xa8c01fff]
[    0.424156] pci 0000:1c:00.2: BAR 0: assigned [mem 0xa8c02000-0xa8c020ff]
[    0.424166] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.424180] pci 0000:1b:03.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424205] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.424218] pci 0000:1a:00.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424243] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.424254] pci 0000:19:00.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424274] pci 0000:1d:00.0: BAR 0: assigned [mem 0xa9200000-0xa920ffff 64bit pref]
[    0.424304] pci 0000:1d:00.0: BAR 2: assigned [mem 0xa9210000-0xa921ffff 64bit pref]
[    0.424334] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.424345] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.424353] pci 0000:19:01.0:   bridge window [mem 0xa9200000-0xa92fffff 64bit pref]
[    0.424367] pci 0000:1e:00.0: BAR 0: assigned [mem 0xa9400000-0xa9400fff 64bit]
[    0.424398] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.424408] pci 0000:19:02.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.424428] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.424431] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.424434] pci 0000:1f:00.0: BAR 7: assigned [io  0x5000-0x6fff]
[    0.424437] pci 0000:20:00.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424440] pci 0000:20:01.0: BAR 9: assigned [mem 0xa8e00000-0xa8efffff 64bit pref]
[    0.424443] pci 0000:20:02.0: BAR 8: assigned [mem 0xa8f00000-0xa8ffffff]
[    0.424445] pci 0000:20:04.0: BAR 8: no space for [mem size 0x08000000]
[    0.424448] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424450] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424453] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424456] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424459] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424461] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424464] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424467] pci 0000:20:04.0: BAR 7: assigned [io  0x5000-0x5fff]
[    0.424469] pci 0000:20:05.0: BAR 7: assigned [io  0x6000-0x6fff]
[    0.424472] pci 0000:21:00.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424475] pci 0000:22:03.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424478] pci 0000:23:00.0: BAR 0: assigned [mem 0xa8d00000-0xa8d00fff]
[    0.424491] pci 0000:23:00.1: BAR 0: assigned [mem 0xa8d01000-0xa8d01fff]
[    0.424503] pci 0000:23:00.2: BAR 0: assigned [mem 0xa8d02000-0xa8d020ff]
[    0.424516] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.424533] pci 0000:22:03.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424566] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.424583] pci 0000:21:00.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424616] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.424630] pci 0000:20:00.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424658] pci 0000:24:00.0: BAR 0: assigned [mem 0xa8e00000-0xa8e0ffff 64bit pref]
[    0.424697] pci 0000:24:00.0: BAR 2: assigned [mem 0xa8e10000-0xa8e1ffff 64bit pref]
[    0.424736] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.424751] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.424761] pci 0000:20:01.0:   bridge window [mem 0xa8e00000-0xa8efffff 64bit pref]
[    0.424781] pci 0000:25:00.0: BAR 0: assigned [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.424821] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.424835] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.424862] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.424868] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.424907] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.424913] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.424953] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.424959] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.424973] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.425000] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.425005] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.425015] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.425035] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.425040] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.425067] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.425072] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.425082] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.425101] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.425105] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.425112] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.425124] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.425127] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.425143] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.425147] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.425163] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.425167] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.425174] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.425185] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.425188] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.425193] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.425200] pci_bus 0000:00: No. 4 try to assign unassigned res
[    0.425203] release child resource [mem 0xa8d00000-0xa8d00fff]
[    0.425203] release child resource [mem 0xa8d01000-0xa8d01fff]
[    0.425204] release child resource [mem 0xa8d02000-0xa8d020ff]
[    0.425205] pci 0000:22:03.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425207] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.425219] pci 0000:21:00.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425222] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.425234] pci 0000:20:00.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425237] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.425247] release child resource [mem 0xa8e00000-0xa8e0ffff 64bit pref]
[    0.425247] release child resource [mem 0xa8e10000-0xa8e1ffff 64bit pref]
[    0.425248] pci 0000:20:01.0: resource 9 [mem 0xa8e00000-0xa8efffff 64bit pref] released
[    0.425251] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.425274] release child resource [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.425275] pci 0000:20:02.0: resource 8 [mem 0xa8f00000-0xa8ffffff] released
[    0.425277] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.425287] release child resource [mem 0xa9000000-0xa90fffff]
[    0.425288] pci 0000:1f:00.0: resource 8 [mem 0xa8d00000-0xa91fffff] released
[    0.425290] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.425301] pci 0000:19:04.0: resource 8 [mem 0xa8d00000-0xa91fffff] released
[    0.425303] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.425311] release child resource [mem 0xa8c00000-0xa8c00fff]
[    0.425312] release child resource [mem 0xa8c01000-0xa8c01fff]
[    0.425312] release child resource [mem 0xa8c02000-0xa8c020ff]
[    0.425313] pci 0000:1b:03.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425316] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.425325] pci 0000:1a:00.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425327] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.425337] pci 0000:19:00.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425340] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.425347] release child resource [mem 0xa9200000-0xa920ffff 64bit pref]
[    0.425348] release child resource [mem 0xa9210000-0xa921ffff 64bit pref]
[    0.425349] pci 0000:19:01.0: resource 9 [mem 0xa9200000-0xa92fffff 64bit pref] released
[    0.425352] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.425368] release child resource [mem 0xa9400000-0xa9400fff 64bit]
[    0.425369] pci 0000:19:02.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.425371] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.425379] release child resource [mem 0xa9300000-0xa93fffff]
[    0.425379] pci 0000:18:00.0: resource 8 [mem 0xa8c00000-0xa94fffff] released
[    0.425382] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.425390] pci 0000:06:04.0: resource 8 [mem 0xa8c00000-0xa94fffff] released
[    0.425392] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.425398] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.425398] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.425399] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.425401] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.425407] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xa96fffff] released
[    0.425409] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.425416] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xad6fffff] released
[    0.425419] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.425422] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425423] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.425426] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425430] release child resource [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.425430] release child resource [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.425431] pci 0000:00:1c.0: resource 9 [mem 0xa8400000-0xa84fffff 64bit pref] released
[    0.425434] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.425441] release child resource [mem 0xa8600000-0xa861ffff 64bit]
[    0.425441] release child resource [mem 0xa8620000-0xa862ffff pref]
[    0.425442] pci 0000:00:1c.1: resource 8 [mem 0xa8600000-0xa86fffff] released
[    0.425445] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.425448] release child resource [mem 0xa8500000-0xa8500fff 64bit]
[    0.425449] pci 0000:00:1c.2: resource 8 [mem 0xa8500000-0xa85fffff] released
[    0.425452] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.425465] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425469] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.425472] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.425475] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.425478] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.425481] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.425484] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.425488] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425496] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425498] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.425501] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.425504] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425509] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.425524] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.425540] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.425544] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.425549] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.425555] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.425570] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.425573] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.425577] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.425586] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.425601] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.425606] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.425614] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.425616] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.425619] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.425623] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.425625] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.425628] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425631] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425634] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.425637] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.425640] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.425643] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.425645] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425648] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425651] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.425654] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425656] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425660] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.425666] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.425672] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.425679] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.425691] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.425695] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.425702] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.425714] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.425716] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.425719] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.425723] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425725] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.425728] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.425731] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.425734] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.425736] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.425739] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.425742] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.425744] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.425747] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425750] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425753] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425756] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425759] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.425769] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.425779] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.425789] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.425802] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425827] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.425840] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425865] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.425876] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425896] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.425926] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.425956] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.425967] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.425975] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.425989] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.426020] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.426030] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.426050] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.426052] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.426055] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.426059] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426061] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.426064] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.426067] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.426070] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.426072] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.426075] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.426078] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.426080] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.426083] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.426086] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.426089] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426092] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426094] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.426107] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.426120] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.426133] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.426150] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426182] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.426200] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426233] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.426247] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426274] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.426314] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.426353] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.426367] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.426378] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.426398] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.426437] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.426451] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.426478] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.426485] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.426499] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.426526] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.426532] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.426571] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.426578] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.426592] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.426619] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.426624] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.426634] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.426653] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.426658] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.426686] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.426691] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.426701] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.426720] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.426724] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.426731] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.426742] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.426746] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.426753] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.426765] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.426768] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.426775] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.426787] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.426790] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.426797] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.426808] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.426811] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.426816] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.426824] pci_bus 0000:00: No. 5 try to assign unassigned res
[    0.426826] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.426827] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.426827] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.426828] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426831] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.426843] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426845] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.426858] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426860] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.426870] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.426871] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.426872] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.426875] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.426897] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.426898] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.426900] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.426911] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.426913] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.426923] release child resource [mem 0xb1000000-0xb10fffff]
[    0.426924] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.426927] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.426937] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.426939] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.426947] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.426948] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.426948] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.426949] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426952] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.426961] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426963] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.426973] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426975] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.426983] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.426984] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.426985] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.426988] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427003] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427004] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427007] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427014] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427015] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427018] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427026] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427028] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427033] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427034] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427035] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427037] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427042] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427045] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427050] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427053] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427058] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427060] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427066] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427068] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427074] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427077] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427080] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427081] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427084] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427087] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427088] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427089] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427092] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427098] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427099] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427100] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427102] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427106] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427107] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427109] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427121] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427125] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427128] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427131] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427134] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427137] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427140] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427144] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427152] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427154] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427157] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427160] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427164] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427180] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427196] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427200] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427204] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427211] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427225] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427228] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427233] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427241] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427256] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427261] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427269] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427272] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427275] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427278] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427281] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427284] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427286] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427289] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427292] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427295] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427298] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427301] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427303] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427306] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427309] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427312] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427315] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427321] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427328] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427331] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427331] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427331] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427331] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427331] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427331] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427331] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427331] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427331] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427331] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427331] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427331] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427331] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427331] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427331] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427331] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427331] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427331] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427331] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427331] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427331] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427331] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427331] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427331] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427331] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427331] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427331] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427331] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427331] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427331] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427331] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427331] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427331] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427331] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427331] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427331] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427331] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427331] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427331] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427331] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427331] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427331] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427331] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427331] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427331] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427331] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427331] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427331] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427331] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427331] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427331] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427331] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427331] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427331] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427331] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427331] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427331] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427331] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427331] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427331] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427331] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427331] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427331] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427331] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427331] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci_bus 0000:00: No. 6 try to assign unassigned res
[    0.427331] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427331] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427331] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427331] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427331] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427331] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427331] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427331] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427331] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427331] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427331] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427331] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427331] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427331] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427331] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427331] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427331] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427331] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427331] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427331] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427331] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427331] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427331] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427331] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427331] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427331] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427331] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427331] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427331] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427331] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427331] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427331] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427331] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427331] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427331] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427331] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427331] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427331] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427331] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427331] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427331] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427331] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427331] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427331] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427331] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427331] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427331] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427331] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427331] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427331] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427331] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427331] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427331] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427331] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427331] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427331] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427331] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427331] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427331] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427331] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427331] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427331] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427331] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427331] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427331] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427331] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427331] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427331] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427331] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427331] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427331] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427331] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427331] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427331] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427331] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427331] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427331] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427331] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427331] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427331] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427331] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427331] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427331] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427331] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427331] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427331] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427331] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427331] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427331] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427331] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427331] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427331] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427331] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427331] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427331] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427331] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427331] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427331] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427331] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427331] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427331] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427331] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427331] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427331] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427331] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427331] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427331] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427331] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427331] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427331] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427331] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427331] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427331] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427331] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427331] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427331] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427331] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427331] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427331] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427331] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427331] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427331] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427331] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427331] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427331] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427331] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427331] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427331] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427331] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427331] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427331] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427331] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427331] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427331] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427331] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427331] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427331] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427331] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427331] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427331] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427331] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427331] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427331] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427331] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427331] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427331] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427331] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427331] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427331] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427331] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427331] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427331] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427331] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427331] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427331] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427331] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427331] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427331] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427331] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci_bus 0000:00: No. 7 try to assign unassigned res
[    0.427331] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427331] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427331] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427331] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427331] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427331] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427331] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427331] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427331] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427331] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427331] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427331] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427331] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427331] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427331] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427331] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427331] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427331] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427331] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427331] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427331] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427331] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427331] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427331] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427331] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427331] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427331] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427331] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427331] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427331] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427331] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427331] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427331] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427331] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427331] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427331] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427331] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427331] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427331] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427331] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427331] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427331] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427331] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427331] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427331] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427331] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427331] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427331] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427331] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427331] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427331] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427331] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427331] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427331] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427331] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427331] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427331] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427331] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427331] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427331] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427331] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427331] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427331] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427331] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427331] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427331] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427331] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427331] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427331] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427331] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427331] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427331] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427331] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427331] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427331] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427331] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427331] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427331] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427331] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427331] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427331] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427331] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427331] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427331] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427331] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427331] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427331] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427331] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427331] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427331] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427331] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427331] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427331] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427331] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427331] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427331] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427331] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427331] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427331] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427331] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427331] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427331] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427331] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427331] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427331] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427331] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427331] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427331] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427331] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427331] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427331] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427331] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427331] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427331] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427331] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427331] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427331] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427331] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427331] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427331] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427331] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427331] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427331] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427331] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427331] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427331] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427331] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427331] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427331] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427331] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427331] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427331] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427331] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427331] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427331] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427331] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427331] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427331] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427331] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427331] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427331] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427331] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427331] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427331] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427331] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427331] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427331] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427331] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427331] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427331] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427331] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427331] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427331] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427331] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427331] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427331] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427331] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427331] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427331] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci_bus 0000:00: No. 8 try to assign unassigned res
[    0.427331] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427331] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427331] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427331] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427331] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427331] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427331] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427331] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427331] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427331] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427331] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427331] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427331] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427331] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427331] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427331] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427331] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427331] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427331] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427331] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427331] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427331] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427331] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427331] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427331] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427331] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427331] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427331] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427331] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427331] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427331] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427331] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427331] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427331] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427331] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427331] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427331] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427331] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427331] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427331] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427331] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427331] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427331] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427331] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427331] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427331] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427331] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427331] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427331] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427331] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427331] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427331] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427331] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427331] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427331] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427331] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427331] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427331] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427331] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427331] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427331] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427331] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427331] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427331] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427331] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427331] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427331] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427331] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427331] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427331] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427331] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427331] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427331] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427331] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427331] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427331] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427331] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427331] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427331] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427331] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427331] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427331] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427331] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427331] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427331] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427331] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427331] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427331] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427331] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427331] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427331] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427331] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427331] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427331] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427331] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427331] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427331] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427331] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427331] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427331] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427331] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427331] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427331] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427331] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427331] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427331] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427331] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427331] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427331] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427331] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427331] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427331] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427331] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427331] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427331] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427331] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427331] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427331] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427331] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427331] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427331] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427331] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427331] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427331] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427331] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427331] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427331] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427331] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427331] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427331] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427331] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427331] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427331] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427331] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427331] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427331] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427331] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427331] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427331] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427331] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427331] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427331] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427331] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427331] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427331] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427331] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427331] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427331] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427331] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427331] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427331] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427331] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427331] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427331] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427331] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427331] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427331] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427331] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427331] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427331] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427331] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.433359] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.433364] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.433371] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.433382] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.433386] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.433393] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.433405] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.433408] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.433415] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.433426] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.433429] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.433434] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.433442] pci_bus 0000:00: No. 9 try to assign unassigned res
[    0.433444] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.433445] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.433445] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.433446] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433449] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.433461] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433463] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.433476] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433478] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.433488] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.433489] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.433490] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.433493] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.433515] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.433516] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.433518] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.433529] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.433531] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.433541] release child resource [mem 0xb1000000-0xb10fffff]
[    0.433542] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.433545] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.433555] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.433557] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.433565] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.433566] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.433566] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.433567] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433570] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.433579] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433582] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.433591] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433594] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.433601] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.433602] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.433603] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.433606] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.433622] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.433623] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.433625] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.433633] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.433634] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.433636] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.433644] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.433647] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.433652] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.433652] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.433653] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.433656] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.433661] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.433663] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.433669] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.433671] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.433676] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.433679] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.433684] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.433686] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.433693] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.433695] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.433699] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433700] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.433703] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433706] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.433707] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.433708] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.433710] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.433717] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.433717] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.433718] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.433721] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.433724] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.433725] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.433728] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.433747] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433753] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.433757] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.433762] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.433767] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.433772] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.433775] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.433784] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433792] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433795] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.433798] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.433801] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433805] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.433821] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.433836] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.433841] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.433845] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.433852] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.433866] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.433869] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.433874] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.433882] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.433897] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.433902] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.433910] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.433913] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.433916] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.433919] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.433922] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.433925] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433927] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433930] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.433933] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.433936] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.433939] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.433942] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433944] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433947] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.433950] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433953] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433956] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.433962] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.433969] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.433975] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.433987] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.433991] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.433998] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.434010] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.434012] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.434015] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.434018] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434021] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.434024] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.434027] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.434029] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.434032] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.434035] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.434038] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.434040] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.434043] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434046] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434049] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434052] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434054] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.434065] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.434075] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.434085] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.434098] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434123] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.434136] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434161] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.434172] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434191] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.434222] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.434252] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.434263] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.434270] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.434285] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.434315] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.434326] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.434345] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.434348] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.434351] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.434354] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434357] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.434360] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.434362] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.434365] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.434368] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434370] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434373] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.434376] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.434378] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434381] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434384] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434387] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434390] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.434403] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.434415] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.434428] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.434445] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434478] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.434495] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434528] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.434542] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434569] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.434609] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.434648] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.434662] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.434673] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.434692] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.434732] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.434746] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.434773] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.434779] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.434794] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.434821] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.434827] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.434866] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.434872] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.434887] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.434914] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.434918] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.434929] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.434948] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.434953] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.434981] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.434986] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.434996] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.435015] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.435019] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.435026] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.435038] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.435041] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.435048] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.435060] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.435063] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.435070] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.435082] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.435086] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.435092] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.435104] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.435107] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.435111] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.435119] pci_bus 0000:00: No. 10 try to assign unassigned res
[    0.435121] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.435122] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.435123] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.435124] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435126] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.435138] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435141] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.435153] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435155] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.435165] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.435166] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.435167] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.435170] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.435192] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.435193] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.435196] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.435206] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.435208] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.435219] release child resource [mem 0xb1000000-0xb10fffff]
[    0.435220] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.435222] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.435232] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.435235] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.435242] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.435243] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.435244] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.435245] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435247] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.435257] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435259] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.435269] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435271] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.435279] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.435279] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.435280] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.435283] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.435299] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.435300] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.435302] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.435310] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.435311] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.435313] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.435321] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.435324] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.435329] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.435330] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.435330] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.435333] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.435338] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.435340] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.435346] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.435348] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.435354] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.435356] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.435361] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.435364] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.435370] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.435372] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.435376] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435377] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.435380] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.435383] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.435384] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.435385] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.435388] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.435394] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.435395] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.435395] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.435398] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.435402] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.435402] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.435405] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.435417] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435421] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.435424] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.435427] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.435430] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.435434] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.435436] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.435440] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435448] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.435450] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.435453] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.435456] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435460] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.435476] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.435491] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.435496] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.435500] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.435507] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.435521] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.435524] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.435529] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.435537] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.435552] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.435557] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.435565] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.435568] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.435571] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.435574] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.435577] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.435580] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435582] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435585] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.435588] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.435591] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.435594] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.435597] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435599] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435602] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.435605] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435608] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435611] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.435617] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.435624] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.435630] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.435642] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.435646] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.435653] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.435665] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.435668] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.435670] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.435674] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435676] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.435679] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.435682] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.435685] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.435687] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.435690] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.435693] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.435695] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.435698] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435701] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435704] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435707] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435710] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.435720] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.435730] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.435740] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.435753] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435778] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.435791] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435816] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.435827] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435846] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.435877] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.435907] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.435918] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.435926] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.435940] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.435970] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.435981] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.436000] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.436003] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.436006] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.436009] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436012] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.436014] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436017] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.436020] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.436023] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.436026] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.436029] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.436031] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.436034] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.436037] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.436040] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436042] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436045] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.436058] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.436071] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.436083] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.436100] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436133] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.436151] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436183] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.436198] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436225] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.436264] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.436304] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.436318] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.436329] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436348] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.436388] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.436402] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.436429] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.436435] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.436450] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.436477] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.436483] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.436522] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.436528] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.436543] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.436569] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.436574] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.436585] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.436604] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.436609] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.436637] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.436642] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.436652] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.436671] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.436675] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.436682] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.436693] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.436697] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.436704] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.436716] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.436719] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.436726] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.436738] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.436741] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.436748] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.436759] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.436762] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.436767] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.436775] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.436778] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.436780] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.436782] pci_bus 0000:00: resource 7 [mem 0x8f900000-0xfeafffff window]
[    0.436785] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff window]
[    0.436787] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.436790] pci_bus 0000:01: resource 1 [mem 0xa8800000-0xa88fffff]
[    0.436792] pci_bus 0000:01: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.436795] pci_bus 0000:02: resource 1 [mem 0xa8700000-0xa87fffff]
[    0.436797] pci_bus 0000:02: resource 2 [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.436800] pci_bus 0000:03: resource 1 [mem 0x8fa00000-0x8fafffff]
[    0.436802] pci_bus 0000:04: resource 1 [mem 0x8fb00000-0x8fbfffff]
[    0.436805] pci_bus 0000:05: resource 0 [io  0x4000-0xbfff]
[    0.436807] pci_bus 0000:05: resource 1 [mem 0xa8a00000-0xd90fffff]
[    0.436809] pci_bus 0000:06: resource 0 [io  0x4000-0xbfff]
[    0.436811] pci_bus 0000:06: resource 1 [mem 0xa8a00000-0xd90fffff]
[    0.436814] pci_bus 0000:07: resource 1 [mem 0xa8a00000-0xa8afffff]
[    0.436816] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    0.436818] pci_bus 0000:08: resource 1 [mem 0xa8b00000-0xb0afffff]
[    0.436820] pci_bus 0000:18: resource 0 [io  0x5000-0x9fff]
[    0.436823] pci_bus 0000:18: resource 1 [mem 0xb0b00000-0xc90fffff]
[    0.436825] pci_bus 0000:19: resource 0 [io  0x5000-0x8fff]
[    0.436827] pci_bus 0000:19: resource 1 [mem 0xb0b00000-0xc90fffff]
[    0.436829] pci_bus 0000:1a: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436832] pci_bus 0000:1b: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436834] pci_bus 0000:1c: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436836] pci_bus 0000:1d: resource 1 [mem 0xb0c00000-0xb0cfffff]
[    0.436839] pci_bus 0000:1d: resource 2 [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.436841] pci_bus 0000:1e: resource 1 [mem 0xb0e00000-0xb0efffff]
[    0.436844] pci_bus 0000:1f: resource 0 [io  0x5000-0x7fff]
[    0.436846] pci_bus 0000:1f: resource 1 [mem 0xb0f00000-0xc11fffff]
[    0.436848] pci_bus 0000:20: resource 0 [io  0x5000-0x6fff]
[    0.436851] pci_bus 0000:20: resource 1 [mem 0xb0f00000-0xc11fffff]
[    0.436853] pci_bus 0000:21: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436855] pci_bus 0000:22: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436857] pci_bus 0000:23: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436860] pci_bus 0000:24: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.436862] pci_bus 0000:24: resource 2 [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436865] pci_bus 0000:25: resource 1 [mem 0xb1200000-0xb12fffff]
[    0.436867] pci_bus 0000:26: resource 0 [io  0x5000-0x5fff]
[    0.436869] pci_bus 0000:26: resource 1 [mem 0xb1300000-0xb92fffff]
[    0.436872] pci_bus 0000:36: resource 0 [io  0x6000-0x6fff]
[    0.436874] pci_bus 0000:46: resource 0 [io  0x8000-0x8fff]
[    0.436876] pci_bus 0000:56: resource 0 [io  0xa000-0xafff]
[    0.436878] pci_bus 0000:56: resource 1 [mem 0xc9100000-0xd10fffff]
[    0.436881] pci_bus 0000:66: resource 0 [io  0xb000-0xbfff]
[    0.436883] pci_bus 0000:66: resource 1 [mem 0xd1100000-0xd90fffff]
[    0.437317] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.437334] pci 0000:05:00.0: CLS mismatch (256 != 128), using 64 bytes
[    0.437348] pci 0000:1c:00.0: MSI is not implemented on this device, disabling it
[    0.437350] pci 0000:1c:00.0: PME# is unreliable, disabling it
[    0.437646] pci 0000:1c:00.1: MSI is not implemented on this device, disabling it
[    0.437650] pci 0000:1c:00.1: PME# is unreliable, disabling it
[    0.437728] pci 0000:1c:00.2: MSI is not implemented on this device, disabling it
[    0.437731] pci 0000:1c:00.2: PME# is unreliable, disabling it
[    0.437786] pci 0000:1c:00.2: EHCI: unrecognized capability 00
[    0.437825] pci 0000:23:00.0: MSI is not implemented on this device, disabling it
[    0.437828] pci 0000:23:00.0: PME# is unreliable, disabling it
[    0.438082] pci 0000:23:00.1: MSI is not implemented on this device, disabling it
[    0.438085] pci 0000:23:00.1: PME# is unreliable, disabling it
[    0.438179] pci 0000:23:00.2: MSI is not implemented on this device, disabling it
[    0.438182] pci 0000:23:00.2: PME# is unreliable, disabling it
[    0.438248] pci 0000:23:00.2: EHCI: unrecognized capability 00
[    0.438287] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.438290] software IO TLB: mapped [mem 0x0000000083000000-0x0000000087000000] (64MB)
[    0.438299] ACPI: bus type thunderbolt registered
[    0.438325] Trying to unpack rootfs image as initramfs...
[    0.438382] thunderbolt 0000:07:00.0: total paths: 32
[    0.438557] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.438575] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.438588] thunderbolt 0000:07:00.0: control channel created
[    0.438591] thunderbolt 0000:07:00.0: ICM not supported on this controller
[    0.438600] thunderbolt 0000:07:00.0: freeing RX ring 0
[    0.438607] thunderbolt 0000:07:00.0: freeing TX ring 0
[    0.438616] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.438624] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.438632] thunderbolt 0000:07:00.0: control channel created
[    0.438634] thunderbolt 0000:07:00.0: using software connection manager
[    0.438650] thunderbolt 0000:07:00.0: created link from 0000:06:03.0
[    0.438674] thunderbolt 0000:07:00.0: created link from 0000:06:04.0
[    0.438689] thunderbolt 0000:07:00.0: created link from 0000:06:05.0
[    0.438701] thunderbolt 0000:07:00.0: created link from 0000:06:06.0
[    0.438756] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[    0.438758] thunderbolt 0000:07:00.0: control channel starting...
[    0.438759] thunderbolt 0000:07:00.0: starting TX ring 0
[    0.438767] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.438769] thunderbolt 0000:07:00.0: starting RX ring 0
[    0.438777] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38204 bit 0 (0x0 -> 0x1)
[    0.438780] thunderbolt 0000:07:00.0: security level set to user
[    0.438934] thunderbolt 0000:07:00.0: current switch config:
[    0.438935] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.438938] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.438939] thunderbolt 0000:07:00.0:   Config:
[    0.438940] thunderbolt 0000:07:00.0:    Upstream Port Number: 6 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.438942] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.465845] thunderbolt 0000:07:00.0: initializing Switch at 0x0 (depth: 0, up port: 6)
[    0.466356] thunderbolt 0000:07:00.0: 0: DROM version: 1
[    0.467890] thunderbolt 0000:07:00.0: 0: uid: 0x1000a13f2da20
[    0.470833] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.470836] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.470837] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.470838] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.470839] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.473777] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.473779] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.473780] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.473781] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.473782] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.476720] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.476722] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.476723] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.476724] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.476725] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.477360] random: fast init done
[    0.479664] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.479666] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.479667] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.479668] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.479669] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.479670] thunderbolt 0000:07:00.0: 0:5: disabled by eeprom
[    0.480560] thunderbolt 0000:07:00.0:  Port 6: 8086:1513 (Revision: 2, TB Version: 1, Type: NHI (0x2))
[    0.480562] thunderbolt 0000:07:00.0:   Max hop id (in/out): 31/31
[    0.480563] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.480564] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.480565] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.481456] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.481458] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.481459] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.481460] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.481461] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.482352] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.482354] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.482355] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.482356] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.482357] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.483248] thunderbolt 0000:07:00.0:  Port 9: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.483250] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.483251] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.483252] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.483253] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.484144] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.484146] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.484147] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.484148] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.484149] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.485296] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    0.485298] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.485299] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.485300] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.485301] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.486191] thunderbolt 0000:07:00.0:  Port 12: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.486193] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.486194] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.486195] thunderbolt 0000:07:00.0:   NFC Credits: 0x700005
[    0.486196] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.487087] thunderbolt 0000:07:00.0:  Port 13: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.487089] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.487090] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.487091] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.487092] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.502480] thunderbolt 0000:07:00.0: 0: TMU: current mode: HiFi
[    0.502609] thunderbolt 0000:07:00.0: 0:1: is unplugged (state: 7)
[    0.502735] thunderbolt 0000:07:00.0: 0:3: is connected, link is up (state: 2)
[    0.502991] thunderbolt 0000:07:00.0: current switch config:
[    0.502992] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.502994] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.502995] thunderbolt 0000:07:00.0:   Config:
[    0.502996] thunderbolt 0000:07:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1, PlugEventsDelay: 255ms
[    0.502997] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.507599] thunderbolt 0000:07:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[    0.525006] thunderbolt 0000:07:00.0: 3: reading drom (length: 0x97)
[    0.706037] Freeing initrd memory: 27980K
[    1.018658] thunderbolt 0000:07:00.0: 3: DROM version: 1
[    1.019682] thunderbolt 0000:07:00.0: 3: uid: 0x1000100189170
[    1.022624] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.022629] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.022631] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.022633] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.022636] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.025568] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.025572] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.025574] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.025576] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c0000e
[    1.025578] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.028511] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.028514] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.028516] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.028518] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.028520] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.031455] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.031458] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.031460] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.031462] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.031464] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.031466] thunderbolt 0000:07:00.0: 3:5: disabled by eeprom
[    1.031469] thunderbolt 0000:07:00.0: 3:6: disabled by eeprom
[    1.032351] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.032355] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.032357] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.032359] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.032361] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.033247] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.033250] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.033252] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.033254] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.033256] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.033258] thunderbolt 0000:07:00.0: 3:9: disabled by eeprom
[    1.034143] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.034146] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.034149] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.034151] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.034152] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.035295] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.035298] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.035301] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.035302] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.035304] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.035307] thunderbolt 0000:07:00.0: 3:c: disabled by eeprom
[    1.035309] thunderbolt 0000:07:00.0: 3:d: disabled by eeprom
[    1.053696] thunderbolt 0000:07:00.0: 3: TMU: current mode: bi-directional, HiFi
[    1.053738] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[    1.053746] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[    1.053843] thunderbolt 0000:07:00.0: 3:3: is connected, link is up (state: 2)
[    1.054102] thunderbolt 0000:07:00.0: current switch config:
[    1.054104] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    1.054107] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    1.054109] thunderbolt 0000:07:00.0:   Config:
[    1.054111] thunderbolt 0000:07:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x303 Enabled: 1, PlugEventsDelay: 255ms
[    1.054115] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.058710] thunderbolt 0000:07:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[    1.076115] thunderbolt 0000:07:00.0: 303: reading drom (length: 0x97)
[    1.535850] random: crng init done
[    1.569765] thunderbolt 0000:07:00.0: 303: DROM version: 1
[    1.570790] thunderbolt 0000:07:00.0: 303: uid: 0x100010102a740
[    1.573733] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.573737] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.573739] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.573741] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.573743] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.576676] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.576680] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.576682] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.576684] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.576686] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.579620] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.579624] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.579626] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.579628] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.579630] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.582564] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.582567] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.582569] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.582571] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.582573] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.582575] thunderbolt 0000:07:00.0: 303:5: disabled by eeprom
[    1.582578] thunderbolt 0000:07:00.0: 303:6: disabled by eeprom
[    1.583460] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.583464] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.583466] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.583468] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.583470] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.584355] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.584359] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.584361] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.584363] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.584365] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.584367] thunderbolt 0000:07:00.0: 303:9: disabled by eeprom
[    1.585251] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.585255] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.585257] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.585259] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.585261] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.586403] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.586407] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.586409] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.586411] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.586413] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.586415] thunderbolt 0000:07:00.0: 303:c: disabled by eeprom
[    1.586417] thunderbolt 0000:07:00.0: 303:d: disabled by eeprom
[    1.604483] thunderbolt 0000:07:00.0: 303: TMU: current mode: bi-directional, HiFi
[    1.604504] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[    1.604511] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[    1.604607] thunderbolt 0000:07:00.0: 303:1: is unplugged (state: 7)
[    1.604866] thunderbolt 0000:07:00.0: 303:b: DP adapter HPD set, queuing hotplug
[    1.606787] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): discovered
[    1.609346] thunderbolt 0000:07:00.0: 0:c <-> 3:b (DP): discovered
[    1.611010] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): discovered
[    1.611396] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.611399] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
[    1.611521] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[    1.611525] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[    1.611579] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
[    1.611583] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    1.611585] RAPL PMU: hw unit of domain package 2^-16 Joules
[    1.611587] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[    1.611648] thunderbolt 0000:07:00.0: 0:c: in use
[    1.611777] thunderbolt 0000:07:00.0: 0:d: DP IN available
[    1.611904] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[    1.611906] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 13
[    1.611908] thunderbolt 0000:07:00.0: 303:b: calculating available bandwidth
[    1.611982] Initialise system trusted keyrings
[    1.612004] workingset: timestamp_bits=62 max_order=23 bucket_order=0
[    1.612031] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[    1.612033] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[    1.612158] thunderbolt 0000:07:00.0: 3:3: link total bandwidth 9000 Mb/s
[    1.612159] thunderbolt 0000:07:00.0: 303:3: link total bandwidth 9000 Mb/s
[    1.612160] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    1.612162] thunderbolt 0000:07:00.0: in->port 13
[    1.612166] thunderbolt 0000:07:00.0: Tunnel 0
[    1.612167] thunderbolt 0000:07:00.0: 0:d <-> 303:b (DP): activating
[    1.612169] thunderbolt 0000:07:00.0: activating Video path from 0:13 to 303:11
[    1.612171] thunderbolt 0000:07:00.0: 303:3: adding 12 NFC credits to 0
[    1.612286] thunderbolt 0000:07:00.0: 3:1: adding 12 NFC credits to 0
[    1.612413] thunderbolt 0000:07:00.0: 0:d: adding 5 NFC credits to 0
[    1.612670] thunderbolt 0000:07:00.0: 303:3: Writing hop 2
[    1.612671] thunderbolt 0000:07:00.0: 303:3:  In HopID: 9 => Out port: 11 Out HopID: 9
[    1.612673] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.612674] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[    1.612676] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.612677] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.612710] Key type asymmetric registered
[    1.612713] Asymmetric key parser 'x509' registered
[    1.612724] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    1.612926] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[    1.612928] thunderbolt 0000:07:00.0: 3:1:  In HopID: 9 => Out port: 3 Out HopID: 9
[    1.612929] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.612930] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[    1.612932] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.612933] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.613182] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[    1.613185] thunderbolt 0000:07:00.0: 0:d:  In HopID: 9 => Out port: 3 Out HopID: 9
[    1.613187] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.613190] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[    1.613192] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.613194] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.613310] thunderbolt 0000:07:00.0: path activation complete
[    1.613311] thunderbolt 0000:07:00.0: activating AUX TX path from 0:13 to 303:11
[    1.613438] thunderbolt 0000:07:00.0: 303:3: Writing hop 2
[    1.613440] thunderbolt 0000:07:00.0: 303:3:  In HopID: 10 => Out port: 11 Out HopID: 8
[    1.613442] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.613443] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[    1.613444] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.613446] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.613582] pcieport 0000:06:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.613694] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[    1.613696] thunderbolt 0000:07:00.0: 3:1:  In HopID: 10 => Out port: 3 Out HopID: 10
[    1.613697] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.613699] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[    1.613700] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.613701] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.613774] pcieport 0000:06:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.613950] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[    1.613952] thunderbolt 0000:07:00.0: 0:d:  In HopID: 8 => Out port: 3 Out HopID: 10
[    1.613953] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.613955] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[    1.613956] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.613957] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.613972] pcieport 0000:06:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.614078] thunderbolt 0000:07:00.0: path activation complete
[    1.614079] thunderbolt 0000:07:00.0: activating AUX RX path from 303:11 to 0:13
[    1.614177] pcieport 0000:06:06.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.614207] thunderbolt 0000:07:00.0: 0:3: Writing hop 2
[    1.614209] thunderbolt 0000:07:00.0: 0:3:  In HopID: 9 => Out port: 13 Out HopID: 8
[    1.614210] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.614211] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[    1.614213] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.614214] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.614462] thunderbolt 0000:07:00.0: 3:3: Writing hop 1
[    1.614464] thunderbolt 0000:07:00.0: 3:3:  In HopID: 9 => Out port: 1 Out HopID: 9
[    1.614465] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.614466] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[    1.614467] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.614469] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.614718] thunderbolt 0000:07:00.0: 303:b: Writing hop 0
[    1.614720] thunderbolt 0000:07:00.0: 303:b:  In HopID: 8 => Out port: 3 Out HopID: 9
[    1.614721] thunderbolt 0000:07:00.0: 303:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.614722] thunderbolt 0000:07:00.0: 303:b:    Counter enabled: 0 Counter index: 2047
[    1.614724] thunderbolt 0000:07:00.0: 303:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.614725] thunderbolt 0000:07:00.0: 303:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.614846] thunderbolt 0000:07:00.0: path activation complete
[    1.615456] pcieport 0000:19:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.615669] pcieport 0000:19:05.0: enabling device (0000 -> 0001)
[    1.615775] pcieport 0000:19:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.617669] pcieport 0000:20:04.0: enabling device (0000 -> 0003)
[    1.617794] pcieport 0000:20:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.618088] pcieport 0000:20:05.0: enabling device (0000 -> 0001)
[    1.618209] pcieport 0000:20:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.627153] brd: module loaded
[    1.627416] Intel(R) 2.5G Ethernet Linux Driver
[    1.627422] Copyright(c) 2018 Intel Corporation.
[    1.627480] i8042: PNP: No PS/2 controller found.
[    1.627519] mousedev: PS/2 mouse device common for all mice
[    1.627584] intel_pstate: Intel P-state driver initializing
[    1.627705] efifb: probing for efifb
[    1.627721] efifb: framebuffer at 0x90010000, using 14400k, total 14400k
[    1.627724] efifb: mode is 2560x1440x32, linelength=10240, pages=1
[    1.627726] efifb: scrolling: redraw
[    1.627728] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.637233] Console: switching to colour frame buffer device 320x90
[    1.646311] fb0: EFI VGA frame buffer device
[    1.646415] Key type dns_resolver registered
[    1.646489] microcode: sig=0x206a7, pf=0x2, revision=0x2f
[    1.646675] microcode: Microcode Update Driver: v2.2.
[    1.646677] IPI shorthand broadcast: enabled
[    1.646720] sched_clock: Marking stable (1646262973, 409135)->(1657804218, -11132110)
[    1.646818] registered taskstats version 1
[    1.646835] Loading compiled-in X.509 certificates
[    1.647438] Freeing unused kernel image (initmem) memory: 956K
[    1.703408] Write protecting the kernel read-only data: 12288k
[    1.704064] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.704155] Freeing unused kernel image (rodata/data gap) memory: 188K
[    1.704184] Run /init as init process
[    1.704199]   with arguments:
[    1.704200]     /init
[    1.704201]   with environment:
[    1.704202]     HOME=/
[    1.704202]     TERM=linux
[    1.704203]     netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da
[    1.749015] udevd[875]: starting version 3.2.9
[    1.749714] udevd[876]: starting eudev-3.2.9
[    1.763961] ACPI: bus type USB registered
[    1.764006] usbcore: registered new interface driver usbfs
[    1.764034] usbcore: registered new interface driver hub
[    1.764063] usbcore: registered new device driver usb
[    1.764779] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.766495] ehci-pci: EHCI PCI platform driver
[    1.766500] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.766501] uhci_hcd: USB Universal Host Controller Interface driver
[    1.766534] ACPI: bus type drm_connector registered
[    1.766773] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.766807] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    1.766851] uhci_hcd 0000:00:1a.0: detected 2 ports
[    1.766919] uhci_hcd 0000:00:1a.0: irq 21, io port 0x00003140
[    1.767016] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    1.767058] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.767093] usb usb1: Product: UHCI Host Controller
[    1.767119] usb usb1: Manufacturer: Linux 5.17.0+ uhci_hcd
[    1.767147] usb usb1: SerialNumber: 0000:00:1a.0
[    1.767313] hub 1-0:1.0: USB hub found
[    1.767342] hub 1-0:1.0: 2 ports detected
[    1.767639] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    1.767665] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 2
[    1.767704] ehci-pci 0000:00:1a.7: debug port 2
[    1.769304] ahci 0000:00:1f.2: version 3.0
[    1.769970] cryptd: max_cpu_qlen set to 1000
[    1.771097] AVX version of gcm_enc/dec engaged.
[    1.771142] AES CTR mode by8 optimization enabled
[    1.771654] ehci-pci 0000:00:1a.7: irq 23, io mem 0xa8906c00
[    1.779535] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x7 impl SATA mode
[    1.779586] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
[    1.779648] radeon: unknown parameter 'pm' ignored
[    1.779756] [drm] radeon kernel modesetting enabled.
[    1.779822] checking generic (90010000 e10000) vs hw (90000000 10000000)
[    1.779824] fb0: switching to radeon from EFI VGA
[    1.779951] Console: switching to colour dummy device 80x25
[    1.780037] radeon 0000:01:00.0: vgaarb: deactivate vga console
[    1.780201] [drm] initializing kernel modesetting (BARTS 0x1002:0x6720 0x106B:0x0B00 0x00).
[    1.780207] radeon 0000:01:00.0: vram limit (0) must be a power of 2
[    1.803171] tg3 0000:02:00.0 eth0: Tigon3 [partno(BCM957765) rev 57785100] (PCI Express) MAC address 3c:07:54:14:b2:08
[    1.803178] tg3 0000:02:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.803182] tg3 0000:02:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.803185] tg3 0000:02:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.803395] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.803428] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.803432] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.803435] usb usb2: Product: EHCI Host Controller
[    1.803437] usb usb2: Manufacturer: Linux 5.17.0+ ehci_hcd
[    1.803439] usb usb2: SerialNumber: 0000:00:1a.7
[    1.803675] hub 2-0:1.0: USB hub found
[    1.803697] hub 2-0:1.0: 6 ports detected
[    1.833662] firewire_ohci 0000:04:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    1.843456] hub 1-0:1.0: USB hub found
[    1.843468] hub 1-0:1.0: 2 ports detected
[    1.843540] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.843549] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
[    1.843610] uhci_hcd 0000:00:1d.0: detected 2 ports
[    1.843852] uhci_hcd 0000:00:1d.0: irq 19, io port 0x000030e0
[    1.844127] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    1.844151] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.844156] usb usb3: Product: UHCI Host Controller
[    1.844161] usb usb3: Manufacturer: Linux 5.17.0+ uhci_hcd
[    1.844163] usb usb3: SerialNumber: 0000:00:1d.0
[    1.844251] hub 3-0:1.0: USB hub found
[    1.844263] hub 3-0:1.0: 2 ports detected
[    1.844495] scsi host0: ahci
[    1.844583] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.844661] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 4
[    1.844792] ehci-pci 0000:00:1d.7: debug port 2
[    1.845107] scsi host1: ahci
[    1.845775] scsi host2: ahci
[    1.846235] scsi host3: ahci
[    1.846600] scsi host4: ahci
[    1.847195] scsi host5: ahci
[    1.847513] ata1: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906100 irq 52
[    1.847573] ata2: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906180 irq 52
[    1.847614] ata3: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906200 irq 52
[    1.847654] ata4: DUMMY
[    1.847674] ata5: DUMMY
[    1.847694] ata6: DUMMY
[    1.848967] ehci-pci 0000:00:1d.7: irq 22, io mem 0xa8906800
[    1.873390] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.873429] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.873433] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.873436] usb usb4: Product: EHCI Host Controller
[    1.873438] usb usb4: Manufacturer: Linux 5.17.0+ ehci_hcd
[    1.873440] usb usb4: SerialNumber: 0000:00:1d.7
[    1.873671] hub 4-0:1.0: USB hub found
[    1.873677] hub 4-0:1.0: 8 ports detected
[    1.896547] tg3 0000:1d:00.0 eth1: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[    1.896553] tg3 0000:1d:00.0 eth1: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.896557] tg3 0000:1d:00.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.896560] tg3 0000:1d:00.0 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.903651] firewire_ohci 0000:1e:00.0: added OHCI v1.10 device as card 1, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    1.913514] hub 3-0:1.0: USB hub found
[    1.913564] hub 3-0:1.0: 2 ports detected
[    1.913827] ehci-pci 0000:1c:00.2: EHCI Host Controller
[    1.913833] ehci-pci 0000:1c:00.2: new USB bus registered, assigned bus number 5
[    1.914110] ehci-pci 0000:1c:00.2: irq 17, io mem 0xb0b02000
[    1.953401] ehci-pci 0000:1c:00.2: USB 2.0 started, EHCI 1.00
[    1.953501] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.953522] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.953538] usb usb5: Product: EHCI Host Controller
[    1.953541] usb usb5: Manufacturer: Linux 5.17.0+ ehci_hcd
[    1.953544] usb usb5: SerialNumber: 0000:1c:00.2
[    1.953808] hub 5-0:1.0: USB hub found
[    1.953828] hub 5-0:1.0: 4 ports detected
[    1.954800] ehci-pci 0000:23:00.2: EHCI Host Controller
[    1.954806] ehci-pci 0000:23:00.2: new USB bus registered, assigned bus number 6
[    1.955145] ehci-pci 0000:23:00.2: irq 17, io mem 0xb0f02000
[    1.973819] firewire_ohci 0000:25:00.0: added OHCI v1.10 device as card 2, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    1.987756] tg3 0000:24:00.0 eth2: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[    1.987762] tg3 0000:24:00.0 eth2: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.987765] tg3 0000:24:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.987769] tg3 0000:24:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.103373] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    2.110672] ATOM BIOS: Apple
[    2.110843] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.110855] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    2.110861] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.110863] [drm] RAM width 256bits DDR
[    2.110878] [drm] radeon: 1024M of VRAM memory ready
[    2.110880] [drm] radeon: 1024M of GTT memory ready.
[    2.110886] [drm] Loading BARTS Microcode
[    2.110936] [drm] External GPIO thermal controller with fan control
[    2.110950] == power state 0 ==
[    2.110952] 	ui class: none
[    2.110953] 	internal class: boot
[    2.110956] 	caps:
[    2.110957] 	uvd    vclk: 0 dclk: 0
[    2.110958] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.110961] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.110962] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.110964] 	status: c r b
[    2.110967] == power state 1 ==
[    2.110968] 	ui class: performance
[    2.110969] 	internal class: none
[    2.110971] 	caps:
[    2.110972] 	uvd    vclk: 0 dclk: 0
[    2.110973] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.110975] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    2.110977] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.110979] 	status:
[    2.110980] == power state 2 ==
[    2.110981] 	ui class: none
[    2.110983] 	internal class: uvd
[    2.110984] 	caps: video
[    2.110986] 	uvd    vclk: 54000 dclk: 40000
[    2.110987] 		power level 0    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    2.110989] 		power level 1    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    2.110991] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.110993] 	status:
[    2.110994] == power state 3 ==
[    2.110995] 	ui class: none
[    2.110996] 	internal class: uvd_mvc
[    2.110998] 	caps: video
[    2.110999] 	uvd    vclk: 70000 dclk: 56000
[    2.111001] 		power level 0    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    2.111003] 		power level 1    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    2.111004] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.111006] 	status:
[    2.111007] == power state 4 ==
[    2.111009] 	ui class: battery
[    2.111010] 	internal class: none
[    2.111011] 	caps:
[    2.111012] 	uvd    vclk: 0 dclk: 0
[    2.111014] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.111016] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.111017] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.111019] 	status:
[    2.115924] [drm] radeon: dpm initialized
[    2.115998] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    2.116397] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    2.133011] [drm] PCIE GART of 1024M enabled (table at 0x0000000000162000).
[    2.133115] radeon 0000:01:00.0: WB enabled
[    2.133119] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00
[    2.133122] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c
[    2.133401] ehci-pci 0000:23:00.2: USB 2.0 started, EHCI 1.00
[    2.133507] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    2.133514] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.133527] usb usb6: Product: EHCI Host Controller
[    2.133538] usb usb6: Manufacturer: Linux 5.17.0+ ehci_hcd
[    2.133541] usb usb6: SerialNumber: 0000:23:00.2
[    2.133663] hub 6-0:1.0: USB hub found
[    2.133673] hub 6-0:1.0: 4 ports detected
[    2.133942] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118
[    2.134046] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    2.134088] radeon 0000:01:00.0: radeon: using MSI.
[    2.134118] [drm] radeon: irq initialized.
[    2.150455] [drm] ring test on 0 succeeded in 3 usecs
[    2.150468] [drm] ring test on 3 succeeded in 7 usecs
[    2.174710] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.174802] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.174820] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.176419] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.176478] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.176486] ata2.00: supports DRM functions and may not be fully accessible
[    2.176491] ata2.00: ATA-9: Samsung SSD 850 EVO 500GB, EMT02B6Q, max UDMA/133
[    2.176562] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.176569] ata3.00: ATAPI: OPTIARC DVD RW AD-5690H, 4AH5, max UDMA/100
[    2.176579] ata1.00: supports DRM functions and may not be fully accessible
[    2.176585] ata1.00: ATA-9: Samsung SSD 850 PRO 256GB, EXM03B6Q, max UDMA/133
[    2.177127] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.177186] ata1.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.178637] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.178644] ata3.00: configured for UDMA/100
[    2.179102] ata2.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    2.179204] ata1.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    2.179375] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.179444] ata2.00: supports DRM functions and may not be fully accessible
[    2.179509] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.179570] ata1.00: supports DRM functions and may not be fully accessible
[    2.182186] ata2.00: configured for UDMA/133
[    2.182358] ata1.00: configured for UDMA/133
[    2.182448] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 850  3B6Q PQ: 0 ANSI: 5
[    2.182627] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 850  2B6Q PQ: 0 ANSI: 5
[    2.184035] scsi 2:0:0:0: CD-ROM            OPTIARC  DVD RW AD-5690H  4AH5 PQ: 0 ANSI: 5
[    2.283387] usb 4-1: new high-speed USB device number 2 using ehci-pci
[    2.293354] usb 5-1: new high-speed USB device number 2 using ehci-pci
[    2.327575] [drm] ring test on 5 succeeded in 2 usecs
[    2.327585] [drm] UVD initialized successfully.
[    2.327693] [drm] ib test on ring 0 succeeded in 0 usecs
[    2.327796] [drm] ib test on ring 3 succeeded in 0 usecs
[    2.333715] usb 2-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    2.333722] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.333991] hub 2-1:1.0: USB hub found
[    2.334071] hub 2-1:1.0: 3 ports detected
[    2.343512] firewire_core 0000:04:00.0: created device fw0: GUID a4b197fffe3f2da2, S800
[    2.343522] firewire_core 0000:04:00.0: phy config: new root=ffc0, gap_count=63
[    2.344630] ohci-pci: OHCI PCI platform driver
[    2.344734] ohci-pci 0000:1c:00.0: OHCI PCI host controller
[    2.344745] ohci-pci 0000:1c:00.0: new USB bus registered, assigned bus number 7
[    2.344779] ohci-pci 0000:1c:00.0: irq 19, io mem 0xb0b00000
[    2.346809] sd 0:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    2.346809] sd 1:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    2.346822] sd 0:0:0:0: [sdb] Write Protect is off
[    2.346828] sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.346828] sd 1:0:0:0: [sda] Write Protect is off
[    2.346836] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.346841] sd 0:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.346849] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.349248] sd 1:0:0:0: [sda] supports TCG Opal
[    2.349253] sd 1:0:0:0: [sda] Attached SCSI disk
[    2.349383]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6
[    2.350250] sd 0:0:0:0: [sdb] supports TCG Opal
[    2.350254] sd 0:0:0:0: [sdb] Attached SCSI disk
[    2.350637] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.350655] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.350673] sr 2:0:0:0: Attached scsi generic sg2 type 5
[    2.413531] firewire_core 0000:1e:00.0: created device fw1: GUID 000a27020040c4ba, S800
[    2.413553] firewire_core 0000:1e:00.0: phy config: new root=ffc0, gap_count=63
[    2.417487] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.417493] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.417496] usb usb7: Product: OHCI PCI host controller
[    2.417498] usb usb7: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.417500] usb usb7: SerialNumber: 0000:1c:00.0
[    2.417633] hub 7-0:1.0: USB hub found
[    2.417649] hub 7-0:1.0: 2 ports detected
[    2.417837] ohci-pci 0000:1c:00.1: OHCI PCI host controller
[    2.417843] ohci-pci 0000:1c:00.1: new USB bus registered, assigned bus number 8
[    2.417870] ohci-pci 0000:1c:00.1: irq 16, io mem 0xb0b01000
[    2.423364] usb 6-1: new high-speed USB device number 2 using ehci-pci
[    2.483375] usb 2-2: new high-speed USB device number 3 using ehci-pci
[    2.483815] usb 4-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    2.483821] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.484112] hub 4-1:1.0: USB hub found
[    2.484179] hub 4-1:1.0: 4 ports detected
[    2.485415] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda caddy
[    2.485422] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.487474] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.487478] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.487481] usb usb8: Product: OHCI PCI host controller
[    2.487483] usb usb8: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.487485] usb usb8: SerialNumber: 0000:1c:00.1
[    2.487604] hub 8-0:1.0: USB hub found
[    2.487620] hub 8-0:1.0: 2 ports detected
[    2.487768] ohci-pci 0000:23:00.0: OHCI PCI host controller
[    2.487774] ohci-pci 0000:23:00.0: new USB bus registered, assigned bus number 9
[    2.487800] ohci-pci 0000:23:00.0: irq 19, io mem 0xb0f00000
[    2.493433] firewire_core 0000:25:00.0: created device fw2: GUID 000a2702006cfdfb, S800
[    2.493455] firewire_core 0000:25:00.0: phy config: new root=ffc0, gap_count=63
[    2.504104] usb 5-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[    2.504118] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.504521] hub 5-1:1.0: USB hub found
[    2.504711] hub 5-1:1.0: 7 ports detected
[    2.554399] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    2.557538] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.557543] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.557546] usb usb9: Product: OHCI PCI host controller
[    2.557548] usb usb9: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.557550] usb usb9: SerialNumber: 0000:23:00.0
[    2.557668] hub 9-0:1.0: USB hub found
[    2.557686] hub 9-0:1.0: 2 ports detected
[    2.557834] ohci-pci 0000:23:00.1: OHCI PCI host controller
[    2.557839] ohci-pci 0000:23:00.1: new USB bus registered, assigned bus number 10
[    2.557865] ohci-pci 0000:23:00.1: irq 16, io mem 0xb0f01000
[    2.624139] usb 6-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[    2.624146] usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.624423] hub 6-1:1.0: USB hub found
[    2.624638] hub 6-1:1.0: 7 ports detected
[    2.627526] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.627532] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.627535] usb usb10: Product: OHCI PCI host controller
[    2.627538] usb usb10: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.627540] usb usb10: SerialNumber: 0000:23:00.1
[    2.627609] hub 10-0:1.0: USB hub found
[    2.627625] hub 10-0:1.0: 2 ports detected
[    2.633358] tsc: Refined TSC clocksource calibration: 3400.025 MHz
[    2.633373] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x31026635618, max_idle_ns: 440795254572 ns
[    2.633406] clocksource: Switched to clocksource tsc
[    2.698958] usb 2-2: New USB device found, idVendor=05ac, idProduct=850b, bcdDevice= 7.55
[    2.698977] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.698979] usb 2-2: Product: FaceTime HD Camera (Built-in)
[    2.698981] usb 2-2: Manufacturer: Apple Inc.
[    2.698983] usb 2-2: SerialNumber: CCGB8K062WDDJRLX
[    2.783396] usb 2-1.1: new full-speed USB device number 4 using ehci-pci
[    2.803387] usb 4-1.1: new high-speed USB device number 3 using ehci-pci
[    2.823388] usb 5-1.4: new full-speed USB device number 3 using ehci-pci
[    2.936147] usb 2-1.1: New USB device found, idVendor=0a5c, idProduct=4500, bcdDevice= 1.00
[    2.936153] usb 2-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.936156] usb 2-1.1: Product: BRCM2046 Hub
[    2.936158] usb 2-1.1: Manufacturer: Apple Inc.
[    2.936547] hub 2-1.1:1.0: USB hub found
[    2.936906] hub 2-1.1:1.0: 3 ports detected
[    2.953392] usb 6-1.4: new full-speed USB device number 3 using ehci-pci
[    2.958914] usb 4-1.1: New USB device found, idVendor=05ac, idProduct=8403, bcdDevice=98.33
[    2.958920] usb 4-1.1: New USB device strings: Mfr=3, Product=4, SerialNumber=2
[    2.958923] usb 4-1.1: Product: Card Reader
[    2.958925] usb 4-1.1: Manufacturer: Apple
[    2.958927] usb 4-1.1: SerialNumber: 000000009833
[    2.960753] usb-storage 4-1.1:1.0: USB Mass Storage device detected
[    2.960838] scsi host6: usb-storage 4-1.1:1.0
[    2.960896] usbcore: registered new interface driver usb-storage
[    2.961187] usbcore: registered new interface driver uas
[    2.982758] usb 5-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[    2.982764] usb 5-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.982767] usb 5-1.4: Product: Display Audio
[    2.982769] usb 5-1.4: Manufacturer: Apple Inc.
[    2.982770] usb 5-1.4: SerialNumber: 152303D9
[    2.983412] [drm] ib test on ring 5 succeeded
[    2.984472] hid: raw HID events driver (C) Jiri Kosina
[    2.995814] usbcore: registered new interface driver usbhid
[    2.995818] usbhid: USB HID core driver
[    2.996570] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:00.0/0000:1a:00.0/0000:1b:03.0/0000:1c:00.2/usb5/5-1/5-1.4/5-1.4:1.3/0003:05AC:1107.0001/input/input0
[    2.996602] hid-generic 0003:05AC:1107.0001: input,hidraw0: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:1c:00.2-1.4/input3
[    3.033387] usb 2-1.2: new high-speed USB device number 5 using ehci-pci
[    3.053387] usb 4-1.2: new low-speed USB device number 4 using ehci-pci
[    3.063370] [drm] radeon atom DIG backlight initialized
[    3.063391] [drm] Radeon Display Connectors
[    3.063397] [drm] Connector 0:
[    3.063400] [drm]   eDP-1
[    3.063403] [drm]   HPD3
[    3.063406] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[    3.063413] [drm]   Encoders:
[    3.063415] [drm]     LCD1: INTERNAL_UNIPHY2
[    3.063419] [drm] Connector 1:
[    3.063422] [drm]   DP-1
[    3.063424] [drm]   HPD1
[    3.063427] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    3.063433] [drm]   Encoders:
[    3.063435] [drm]     DFP1: INTERNAL_UNIPHY1
[    3.063438] [drm] Connector 2:
[    3.063441] [drm]   DP-2
[    3.063443] [drm]   HPD2
[    3.063446] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[    3.063457] [drm]   Encoders:
[    3.063458] [drm]     DFP2: INTERNAL_UNIPHY1
[    3.063459] [drm] Connector 3:
[    3.063460] [drm]   DP-3
[    3.063461] [drm]   HPD4
[    3.063462] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[    3.063465] [drm]   Encoders:
[    3.063466] [drm]     DFP3: INTERNAL_UNIPHY2
[    3.063467] [drm] Connector 4:
[    3.063468] [drm]   DP-4
[    3.063470] [drm]   HPD5
[    3.063471] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 0x647c 0x647c
[    3.063473] [drm]   Encoders:
[    3.063474] [drm]     DFP4: INTERNAL_UNIPHY
[    3.063476] [drm] Connector 5:
[    3.063477] [drm]   VGA-1
[    3.063478] [drm]   DDC: 0x64d8 0x64d8 0x64dc 0x64dc 0x64e0 0x64e0 0x64e4 0x64e4
[    3.063481] [drm]   Encoders:
[    3.063482] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    3.083393] usb 5-1.5: new high-speed USB device number 4 using ehci-pci
[    3.093824] switching from power state:
[    3.093828] 	ui class: none
[    3.093830] 	internal class: boot
[    3.093832] 	caps:
[    3.093833] 	uvd    vclk: 0 dclk: 0
[    3.093835] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.093837] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.093839] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.093841] 	status: c b
[    3.093843] switching to power state:
[    3.093844] 	ui class: performance
[    3.093845] 	internal class: none
[    3.093847] 	caps:
[    3.093848] 	uvd    vclk: 0 dclk: 0
[    3.093850] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    3.093852] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    3.093853] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    3.093855] 	status: r
[    3.123278] usb 6-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[    3.123292] usb 6-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.123299] usb 6-1.4: Product: Display Audio
[    3.123304] usb 6-1.4: Manufacturer: Apple Inc.
[    3.123308] usb 6-1.4: SerialNumber: 1A0E0738
[    3.135264] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:04.0/0000:1f:00.0/0000:20:00.0/0000:21:00.0/0000:22:03.0/0000:23:00.2/usb6/6-1/6-1.4/6-1.4:1.3/0003:05AC:1107.0002/input/input1
[    3.135331] hid-generic 0003:05AC:1107.0002: input,hidraw1: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:23:00.2-1.4/input3
[    3.192036] usb 2-1.2: New USB device found, idVendor=05ac, idProduct=1006, bcdDevice=96.15
[    3.192042] usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.192045] usb 2-1.2: Product: Keyboard Hub
[    3.192047] usb 2-1.2: Manufacturer: Apple, Inc.
[    3.192049] usb 2-1.2: SerialNumber: 000000000000
[    3.192209] hub 2-1.2:1.0: USB hub found
[    3.192285] hub 2-1.2:1.0: 3 ports detected
[    3.209410] usb 4-1.2: New USB device found, idVendor=05ac, idProduct=8242, bcdDevice= 0.16
[    3.209416] usb 4-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.209426] usb 4-1.2: Product: IR Receiver
[    3.209428] usb 4-1.2: Manufacturer: Apple Computer, Inc.
[    3.214520] input: Apple Computer, Inc. IR Receiver as /devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.2/4-1.2:1.0/0003:05AC:8242.0003/input/input2
[    3.233356] usb 6-1.5: new high-speed USB device number 4 using ehci-pci
[    3.260798] usb 5-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[    3.260804] usb 5-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.260807] usb 5-1.5: Product: FaceTime HD Camera (Display)
[    3.260809] usb 5-1.5: Manufacturer: Apple Inc.
[    3.260811] usb 5-1.5: SerialNumber: CCGB690CKUDJ9DFX
[    3.283366] usb 2-1.1.1: new full-speed USB device number 6 using ehci-pci
[    3.283577] appleir 0003:05AC:8242.0003: input,hiddev96,hidraw2: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.7-1.2/input0
[    3.313364] usb 4-1.4: new low-speed USB device number 5 using ehci-pci
[    3.363359] usb 5-1.7: new full-speed USB device number 5 using ehci-pci
[    3.400094] usb 6-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[    3.400100] usb 6-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.400111] usb 6-1.5: Product: FaceTime HD Camera (Display)
[    3.400114] usb 6-1.5: Manufacturer: Apple Inc.
[    3.400116] usb 6-1.5: SerialNumber: CC2G3101FFDJ9FLP
[    3.447783] usb 2-1.1.1: New USB device found, idVendor=05ac, idProduct=8215, bcdDevice= 2.08
[    3.447789] usb 2-1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.447800] usb 2-1.1.1: Product: Bluetooth USB Host Controller
[    3.447802] usb 2-1.1.1: Manufacturer: Apple Inc.
[    3.447804] usb 2-1.1.1: SerialNumber: 3451C9ED7F9B
[    3.468933] usb 4-1.4: New USB device found, idVendor=047d, idProduct=1020, bcdDevice= 1.06
[    3.468939] usb 4-1.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.468941] usb 4-1.4: Product: Kensington Expert Mouse
[    3.472048] input: Kensington Expert Mouse as /devices/pci0000:00/0000:00:1d.7/usb4/4-1/4-1.4/4-1.4:1.0/0003:047D:1020.0004/input/input3
[    3.472096] hid-generic 0003:047D:1020.0004: input,hidraw3: USB HID v1.11 Mouse [Kensington Expert Mouse] on usb-0000:00:1d.7-1.4/input0
[    3.503356] usb 6-1.7: new full-speed USB device number 5 using ehci-pci
[    3.515577] usb 5-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.37
[    3.515583] usb 5-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.515587] usb 5-1.7: Product: Apple Thunderbolt Display
[    3.515589] usb 5-1.7: Manufacturer: Apple Inc.
[    3.515591] usb 5-1.7: SerialNumber: 152303D9
[    3.517332] hid-generic 0003:05AC:9227.0005: hiddev97,hidraw4: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:1c:00.2-1.7/input0
[    3.543356] usb 2-1.2.2: new low-speed USB device number 7 using ehci-pci
[    3.655495] usb 6-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.39
[    3.655501] usb 6-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.655511] usb 6-1.7: Product: Apple Thunderbolt Display
[    3.655515] usb 6-1.7: Manufacturer: Apple Inc.
[    3.655517] usb 6-1.7: SerialNumber: 1A0E0738
[    3.657595] hid-generic 0003:05AC:9227.0006: hiddev98,hidraw5: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:23:00.2-1.7/input0
[    3.700003] usb 2-1.2.2: New USB device found, idVendor=05ac, idProduct=0220, bcdDevice= 0.71
[    3.700007] usb 2-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.700011] usb 2-1.2.2: Product: Apple Keyboard
[    3.700013] usb 2-1.2.2: Manufacturer: Apple, Inc
[    3.707444] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb2/2-1/2-1.2/2-1.2.2/2-1.2.2:1.0/0003:05AC:0220.0007/input/input4
[    3.773475] apple 0003:05AC:0220.0007: input,hidraw6: USB HID v1.11 Keyboard [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input0
[    3.773550] apple 0003:05AC:0220.0008: Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling
[    3.773583] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb2/2-1/2-1.2/2-1.2.2/2-1.2.2:1.1/0003:05AC:0220.0008/input/input5
[    3.793362] usb 2-1.1.2: new full-speed USB device number 8 using ehci-pci
[    3.843474] apple 0003:05AC:0220.0008: input,hidraw7: USB HID v1.11 Device [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input1
[    3.946781] usb 2-1.1.2: New USB device found, idVendor=05ac, idProduct=820a, bcdDevice= 1.00
[    3.946787] usb 2-1.1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.948561] input: HID 05ac:820a as /devices/pci0000:00/0000:00:1a.7/usb2/2-1/2-1.1/2-1.1.2/2-1.1.2:1.0/0003:05AC:820A.0009/input/input6
[    3.995065] scsi 6:0:0:0: Direct-Access     APPLE    SD Card Reader   1.00 PQ: 0 ANSI: 0
[    3.995245] sd 6:0:0:0: Attached scsi generic sg3 type 0
[    3.995962] sd 6:0:0:0: [sdc] Media removed, stopped polling
[    3.996803] sd 6:0:0:0: [sdc] Attached SCSI removable disk
[    4.013441] hid-generic 0003:05AC:820A.0009: input,hidraw8: USB HID v1.11 Keyboard [HID 05ac:820a] on usb-0000:00:1a.7-1.1.2/input0
[    4.113359] usb 2-1.1.3: new full-speed USB device number 9 using ehci-pci
[    4.266917] usb 2-1.1.3: New USB device found, idVendor=05ac, idProduct=820b, bcdDevice= 1.00
[    4.266931] usb 2-1.1.3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.268979] input: HID 05ac:820b as /devices/pci0000:00/0000:00:1a.7/usb2/2-1/2-1.1/2-1.1.3/2-1.1.3:1.0/0003:05AC:820B.000A/input/input7
[    4.269217] hid-generic 0003:05AC:820B.000A: input,hidraw9: USB HID v1.11 Mouse [HID 05ac:820b] on usb-0000:00:1a.7-1.1.3/input0
[    4.496855] [drm] fb mappable at 0x90363000
[    4.496859] [drm] vram apper at 0x90000000
[    4.496860] [drm] size 14745600
[    4.496861] [drm] fb depth is 24
[    4.496863] [drm]    pitch is 10240
[    4.496954] fbcon: radeondrmfb (fb0) is primary device
[    5.179266] switching from power state:
[    5.179268] 	ui class: performance
[    5.179269] 	internal class: none
[    5.179270] 	caps:
[    5.179270] 	uvd    vclk: 0 dclk: 0
[    5.179271] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    5.179272] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    5.179273] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    5.179274] 	status: c r
[    5.179275] switching to power state:
[    5.179275] 	ui class: performance
[    5.179275] 	internal class: none
[    5.179276] 	caps:
[    5.179276] 	uvd    vclk: 0 dclk: 0
[    5.179277] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    5.179277] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    5.179278] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    5.179279] 	status: c r
[    6.293830] switching from power state:
[    6.293831] 	ui class: performance
[    6.293831] 	internal class: none
[    6.293832] 	caps:
[    6.293833] 	uvd    vclk: 0 dclk: 0
[    6.293834] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    6.293835] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    6.293835] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    6.293836] 	status: c r
[    6.293837] switching to power state:
[    6.293837] 	ui class: performance
[    6.293838] 	internal class: none
[    6.293838] 	caps:
[    6.293839] 	uvd    vclk: 0 dclk: 0
[    6.293839] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    6.293840] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    6.293840] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    6.293841] 	status: c r
[    6.405901] Console: switching to colour frame buffer device 320x90
[    6.410293] radeon 0000:01:00.0: [drm] fb0: radeondrmfb frame buffer device
[    6.443430] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[    6.470119] [drm] amdgpu kernel modesetting enabled.
[    6.505432] netpoll: netconsole: local port 6666
[    6.505449] netpoll: netconsole: local IPv4 address 192.168.2.87
[    6.505463] netpoll: netconsole: interface 'eth0'
[    6.505473] netpoll: netconsole: remote port 6666
[    6.505483] netpoll: netconsole: remote IPv4 address 192.168.2.208
[    6.505496] netpoll: netconsole: remote ethernet address dc:a6:32:61:33:da
[    6.505513] netpoll: netconsole: device eth0 not up yet, forcing it
[   10.158425] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   10.158442] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   10.158457] tg3 0000:02:00.0 eth0: EEE is enabled
[   10.170898] printk: console [netcon0] enabled
[   10.170911] netconsole: network logging started
[   17.270550]  sda: sda1
[   17.354552] process '/usr/bin/fstype' started with executable stack
[   17.378014] EXT4-fs (sdb6): mounted filesystem with ordered data mode. Quota mode: none.
[   17.559109] udevd[1274]: starting version 3.2.9
[   17.582042] udevd[1275]: starting eudev-3.2.9
[   17.614963] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input8
[   17.616914] ACPI: button: Power Button [PWRB]
[   17.618474] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input9
[   17.619511] ACPI: button: Sleep Button [SLPB]
[   17.620985] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input10
[   17.627865] udevd[1311]: Error changing net interface name eth1 to eth2: File exists
[   17.628882] udevd[1311]: could not rename interface '3' from 'eth1' to 'eth2': File exists
[   17.636355] udevd[1300]: Error changing net interface name eth2 to eth1: File exists
[   17.637440] udevd[1300]: could not rename interface '4' from 'eth2' to 'eth1': File exists
[   17.650764] mc: Linux media interface: v0.10
[   17.654513] ACPI: button: Power Button [PWRF]
[   17.657812] videodev: Linux video capture interface: v2.00
[   17.665345] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[   17.666576] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[   17.668836] usb 2-2: Found UVC 1.00 device FaceTime HD Camera (Built-in) (05ac:850b)
[   17.675061] Bluetooth: Core ver 2.22
[   17.676124] NET: Registered PF_BLUETOOTH protocol family
[   17.676972] Bluetooth: HCI device and connection manager initialized
[   17.677803] Bluetooth: HCI socket layer initialized
[   17.678653] Bluetooth: L2CAP socket layer initialized
[   17.679507] Bluetooth: SCO socket layer initialized
[   17.679807] usb 5-1.4: 1:1: cannot get freq at ep 0x4
[   17.684120] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input11
[   17.687246] usbcore: registered new interface driver btusb
[   17.689129] snd_hda_codec_cirrus hdaudioC0D0: autoconfig for CS4206: line_outs=2 (0x9/0xb/0x0/0x0/0x0) type:speaker
[   17.690251] snd_hda_codec_cirrus hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   17.691319] snd_hda_codec_cirrus hdaudioC0D0:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[   17.692402] snd_hda_codec_cirrus hdaudioC0D0:    mono: mono_out=0x0
[   17.693516] snd_hda_codec_cirrus hdaudioC0D0:    dig-out=0x10/0x0
[   17.694539] snd_hda_codec_cirrus hdaudioC0D0:    inputs:
[   17.695739] snd_hda_codec_cirrus hdaudioC0D0:      Mic=0xd
[   17.696700] snd_hda_codec_cirrus hdaudioC0D0:      Line=0xc
[   17.697580] snd_hda_codec_cirrus hdaudioC0D0:    dig-in=0xf
[   17.701545] input: FaceTime HD Camera (Built-in):  as /devices/pci0000:00/0000:00:1a.7/usb2/2-2/2-2:1.0/input/input12
[   17.703601] usb 5-1.5: Found UVC 1.00 device FaceTime HD Camera (Display) (05ac:1112)
[   17.705978] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   17.707089] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   17.708341] input: HDA Intel PCH SPDIF In as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   17.752574] applesmc: key=332 fan=3 temp=50 index=49 acc=0 lux=2 kbd=0
[   17.753632] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   17.774057] usb 2-1.1.2: USB disconnect, device number 8
[   17.804923] Bluetooth: hci0: BCM: chip id 254 build 0518
[   17.806923] Bluetooth: hci0: BCM: product 05ac:8215
[   17.808931] Bluetooth: hci0: BCM: features 0x00
[   17.826918] Bluetooth: hci0: Bluetooth USB Host Controller
[   17.848980] usb 5-1.4: 1:2: cannot get freq at ep 0x4
[   17.853079] input: FaceTime HD Camera (Display): F as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:00.0/0000:1a:00.0/0000:1b:03.0/0000:1c:00.2/usb5/5-1/5-1.5/5-1.5:1.0/input/input16
[   17.858084] usb 5-1.4: 2:1: cannot get freq at ep 0x84
[   17.896954] usb 5-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   17.897855] usb 5-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   17.932984] usb 5-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   17.933916] usb 5-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   17.948437] usb 6-1.4: 1:1: cannot get freq at ep 0x4
[   18.034743] usb 6-1.5: Found UVC 1.00 device FaceTime HD Camera (Display) (05ac:1112)
[   18.117332] usb 6-1.4: 1:2: cannot get freq at ep 0x4
[   18.121797] input: FaceTime HD Camera (Display): F as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:04.0/0000:1f:00.0/0000:20:00.0/0000:21:00.0/0000:22:03.0/0000:23:00.2/usb6/6-1/6-1.5/6-1.5:1.0/input/input17
[   18.122883] usbcore: registered new interface driver uvcvideo
[   18.126340] usb 6-1.4: 2:1: cannot get freq at ep 0x84
[   18.165235] usb 6-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   18.166176] usb 6-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   18.203385] usb 6-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   18.204366] usb 6-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   18.205684] usbcore: registered new interface driver snd-usb-audio
[   18.263803] usb 2-1.1.3: USB disconnect, device number 9
[   19.305417] Adding 16777212k swap on /dev/sdb5.  Priority:-2 extents:1 across:16777212k SS
[   19.318561] EXT4-fs (sdb6): re-mounted. Quota mode: none.
[   19.405321] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[   22.316952] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
[   22.896878] NET: Registered PF_PACKET protocol family
[   25.821282] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   25.822297] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   25.823301] tg3 0000:02:00.0 eth0: EEE is enabled
[   28.811553] FS-Cache: Loaded
[   28.817338] RPC: Registered named UNIX socket transport module.
[   28.818207] RPC: Registered udp transport module.
[   28.819051] RPC: Registered tcp transport module.
[   28.819885] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   28.832135] NFS: Registering the id_resolver key type
[   28.833010] Key type id_resolver registered
[   28.833849] Key type id_legacy registered
[   30.194549] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   30.611020] elogind-daemon[3134]: New seat seat0.
[   32.179775] switching from power state:
[   32.179783] 	ui class: performance
[   32.179785] 	internal class: none
[   32.179788] 	caps:
[   32.179789] 	uvd    vclk: 0 dclk: 0
[   32.179791] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   32.179793] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[   32.179795] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[   32.179796] 	status: c
[   32.179798] switching to power state:
[   32.179799] 	ui class: battery
[   32.179800] 	internal class: none
[   32.179802] 	caps:
[   32.179804] 	uvd    vclk: 0 dclk: 0
[   32.179805] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   32.179807] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   32.179808] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   32.179809] 	status: r
[   37.089379] elogind-daemon[3134]: New session c1 of user brad.
[   71.827896] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[   71.827910] thunderbolt 0000:07:00.0: acking hot unplug event on 0:4
[   71.877166] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
[   71.877202] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
[   71.877203] thunderbolt 0000:07:00.0: 0:3: switch unplugged
[   71.877229] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): deactivating
[   71.927226] ohci-pci 0000:1c:00.1: HC died; cleaning up
[   71.927248] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 3:10 to 0:7
[   71.977285] ohci-pci 0000:23:00.1: HC died; cleaning up
[   71.977316] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
[   71.977346] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
[   71.977366] pcieport 0000:06:04.0: pciehp: Slot(4-1): Link Down
[   71.977394] pcieport 0000:06:04.0: pciehp: Slot(4-1): Card not present
[   71.977420] pcieport 0000:19:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   71.977531] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 0:7 to 3:10
[   71.977585] pcieport 0000:20:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[   71.977672] pcieport 0000:20:04.0: can't change power state from D3cold to D0 (config space inaccessible)
[   71.977839] thunderbolt 0000:07:00.0: 0:c <-> 3:b (DP): deactivating
[   72.177643] firewire_ohci 0000:25:00.0: removed fw-ohci device
[   72.177747] thunderbolt 0000:07:00.0: deactivating Video path from 0:12 to 3:11
[   72.178130] thunderbolt 0000:07:00.0: 0:c: adding -5 NFC credits to 5
[   72.178263] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:12 to 3:11
[   72.178644] thunderbolt 0000:07:00.0: deactivating AUX RX path from 3:11 to 0:12
[   72.179029] thunderbolt 0000:07:00.0: 0: released DP resource for port 12
[   72.179036] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): deactivating
[   72.179038] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 303:10 to 3:7
[   72.179040] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 3:7 to 303:10
[   72.179043] thunderbolt 0000:07:00.0: 0:d <-> 303:b (DP): deactivating
[   72.179796] thunderbolt 0000:07:00.0: deactivating Video path from 0:13 to 303:11
[   72.180204] thunderbolt 0000:07:00.0: 0:d: adding -5 NFC credits to 5
[   72.180332] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:13 to 303:11
[   72.180737] thunderbolt 0000:07:00.0: deactivating AUX RX path from 303:11 to 0:13
[   72.181071] thunderbolt 0000:07:00.0: 0: released DP resource for port 13
[   72.181077] thunderbolt 0000:07:00.0: 303:b: DP OUT resource unavailable
[   72.181128] thunderbolt 0-303: device disconnected
[   72.181198] thunderbolt 0-3: device disconnected
[   72.181242] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   72.181366] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   72.181487] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   72.181489] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
[   72.181492] thunderbolt 0000:07:00.0: 0:4: got unplug event for disconnected port, ignoring
[   72.347877] ehci-pci 0000:23:00.2: HC died; cleaning up
[   72.398002] ehci-pci 0000:23:00.2: remove, state 1
[   72.398018] usb usb6: USB disconnect, device number 1
[   72.398042] usb 6-1: USB disconnect, device number 2
[   72.398058] usb 6-1.4: USB disconnect, device number 3
[   72.444728] usb 6-1.5: USB disconnect, device number 4
[   72.615112] usb 6-1.7: USB disconnect, device number 5
[   73.119192] ehci-pci 0000:23:00.2: USB bus 6 deregistered
[   73.119336] ohci-pci 0000:23:00.1: remove, state 4
[   73.119355] usb usb10: USB disconnect, device number 1
[   73.770172] ohci-pci 0000:23:00.1: USB bus 10 deregistered
[   73.820227] ohci-pci 0000:23:00.0: HC died; cleaning up
[   73.820248] sched: RT throttling activated
[   73.827942] ohci-pci 0000:23:00.0: remove, state 4
[   73.827978] usb usb9: USB disconnect, device number 1
[   74.470958] ohci-pci 0000:23:00.0: USB bus 9 deregistered
[   74.671315] firewire_ohci 0000:1e:00.0: removed fw-ohci device
[   74.711172] switching from power state:
[   74.711190] 	ui class: battery
[   74.711198] 	internal class: none
[   74.711207] 	caps:
[   74.711212] 	uvd    vclk: 0 dclk: 0
[   74.711220] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   74.711233] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   74.711245] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   74.711258] 	status: c r
[   74.711265] switching to power state:
[   74.711273] 	ui class: battery
[   74.711279] 	internal class: none
[   74.711286] 	caps:
[   74.711292] 	uvd    vclk: 0 dclk: 0
[   74.711299] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   74.711312] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   74.711325] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   74.711337] 	status: c r
[   74.811349] ehci-pci 0000:1c:00.2: HC died; cleaning up
[   74.861448] ehci-pci 0000:1c:00.2: remove, state 1
[   74.861466] usb usb5: USB disconnect, device number 1
[   74.861489] usb 5-1: USB disconnect, device number 2
[   74.861505] usb 5-1.4: USB disconnect, device number 3
[   74.924899] usb 5-1.5: USB disconnect, device number 4
[   75.045511] usb 5-1.7: USB disconnect, device number 5
[   75.542473] ehci-pci 0000:1c:00.2: USB bus 5 deregistered
[   75.542544] ohci-pci 0000:1c:00.1: remove, state 4
[   75.542557] usb usb8: USB disconnect, device number 1
[   76.193420] ohci-pci 0000:1c:00.1: USB bus 8 deregistered
[   76.243480] ohci-pci 0000:1c:00.0: HC died; cleaning up
[   76.243507] ohci-pci 0000:1c:00.0: remove, state 4
[   76.243528] usb usb7: USB disconnect, device number 1
[   76.894465] ohci-pci 0000:1c:00.0: USB bus 7 deregistered
[   76.895333] pci_bus 0000:1c: busn_res: [bus 1c] is released
[   76.896509] pci_bus 0000:1b: busn_res: [bus 1b-1c] is released
[   76.897353] pci_bus 0000:1a: busn_res: [bus 1a-1c] is released
[   76.898267] pci_bus 0000:1d: busn_res: [bus 1d] is released
[   76.899085] pci_bus 0000:1e: busn_res: [bus 1e] is released
[   76.900204] pci_bus 0000:23: busn_res: [bus 23] is released
[   76.901094] pci_bus 0000:22: busn_res: [bus 22-23] is released
[   76.901859] pci_bus 0000:21: busn_res: [bus 21-23] is released
[   76.902666] pci_bus 0000:24: busn_res: [bus 24] is released
[   76.903411] pci_bus 0000:25: busn_res: [bus 25] is released
[   76.904161] pci_bus 0000:26: busn_res: [bus 26-35] is released
[   76.904905] pci_bus 0000:36: busn_res: [bus 36-45] is released
[   76.905596] pci_bus 0000:20: busn_res: [bus 20-45] is released
[   76.906305] pci_bus 0000:1f: busn_res: [bus 1f-45] is released
[   76.906996] pci_bus 0000:46: busn_res: [bus 46-55] is released
[   76.907700] pci_bus 0000:19: busn_res: [bus 19-55] is released
[   80.244057] thunderbolt 0000:07:00.0: acking hot plug event on 0:4
[   80.244179] thunderbolt 0000:07:00.0: 0:4: hotplug: scanning
[   80.244182] thunderbolt 0000:07:00.0: 0:4: hotplug: no switch found
[   80.260116] thunderbolt 0000:07:00.0: acking hot plug event on 0:3
[   80.260252] thunderbolt 0000:07:00.0: 0:3: hotplug: scanning
[   80.260359] thunderbolt 0000:07:00.0: 0:3: is connected, link is up (state: 2)
[   80.260601] thunderbolt 0000:07:00.0: current switch config:
[   80.260604] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   80.260606] thunderbolt 0000:07:00.0:   Max Port Number: 13
[   80.260607] thunderbolt 0000:07:00.0:   Config:
[   80.260608] thunderbolt 0000:07:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[   80.260609] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[   80.265222] thunderbolt 0000:07:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[   80.282730] thunderbolt 0000:07:00.0: 3: reading drom (length: 0x97)
[   80.409114] thunderbolt 0000:07:00.0: acking hot plug event on 3:4
[   80.415315] thunderbolt 0000:07:00.0: acking hot plug event on 3:3
[   80.777587] thunderbolt 0000:07:00.0: 3: DROM version: 1
[   80.778611] thunderbolt 0000:07:00.0: 3: uid: 0x1000100189170
[   80.781554] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.781560] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   80.781563] thunderbolt 0000:07:00.0:   Max counters: 32
[   80.781565] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   80.781567] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   80.784499] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.784503] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   80.784505] thunderbolt 0000:07:00.0:   Max counters: 32
[   80.784507] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   80.784509] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   80.787442] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.787446] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   80.787448] thunderbolt 0000:07:00.0:   Max counters: 32
[   80.787450] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   80.787452] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   80.790385] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.790389] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   80.790391] thunderbolt 0000:07:00.0:   Max counters: 32
[   80.790393] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   80.790395] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   80.790397] thunderbolt 0000:07:00.0: 3:5: disabled by eeprom
[   80.790400] thunderbolt 0000:07:00.0: 3:6: disabled by eeprom
[   80.791282] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   80.791286] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   80.791288] thunderbolt 0000:07:00.0:   Max counters: 1
[   80.791290] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   80.791292] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   80.792178] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   80.792181] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   80.792184] thunderbolt 0000:07:00.0:   Max counters: 1
[   80.792185] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   80.792187] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   80.792189] thunderbolt 0000:07:00.0: 3:9: disabled by eeprom
[   80.793074] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   80.793078] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   80.793080] thunderbolt 0000:07:00.0:   Max counters: 1
[   80.793082] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   80.793083] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   80.794226] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   80.794230] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[   80.794232] thunderbolt 0000:07:00.0:   Max counters: 2
[   80.794234] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   80.794236] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   80.794238] thunderbolt 0000:07:00.0: 3:c: disabled by eeprom
[   80.794240] thunderbolt 0000:07:00.0: 3:d: disabled by eeprom
[   80.813045] thunderbolt 0000:07:00.0: 3: TMU: current mode: bi-directional, HiFi
[   80.813094] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[   80.813781] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[   80.814489] thunderbolt 0000:07:00.0: 3:3: is connected, link is up (state: 2)
[   80.814802] thunderbolt 0000:07:00.0: current switch config:
[   80.814804] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   80.814806] thunderbolt 0000:07:00.0:   Max Port Number: 13
[   80.814807] thunderbolt 0000:07:00.0:   Config:
[   80.814808] thunderbolt 0000:07:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[   80.814809] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[   80.819353] thunderbolt 0000:07:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[   80.836760] thunderbolt 0000:07:00.0: 303: reading drom (length: 0x97)
[   81.048725] thunderbolt 0000:07:00.0: acking hot plug event on 3:b
[   81.048730] thunderbolt 0000:07:00.0: acking hot plug event on 3:b
[   81.150390] thunderbolt 0000:07:00.0: acking hot plug event on 303:b
[   81.150395] thunderbolt 0000:07:00.0: acking hot plug event on 303:b
[   81.330485] thunderbolt 0000:07:00.0: 303: DROM version: 1
[   81.331476] thunderbolt 0000:07:00.0: 303: uid: 0x100010102a740
[   81.334420] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   81.334422] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   81.334423] thunderbolt 0000:07:00.0:   Max counters: 32
[   81.334424] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   81.334430] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   81.337396] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   81.337399] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   81.337400] thunderbolt 0000:07:00.0:   Max counters: 32
[   81.337401] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   81.337402] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   81.340307] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   81.340309] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   81.340310] thunderbolt 0000:07:00.0:   Max counters: 32
[   81.340311] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   81.340312] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   81.343251] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   81.343253] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[   81.343254] thunderbolt 0000:07:00.0:   Max counters: 32
[   81.343255] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[   81.343256] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[   81.343257] thunderbolt 0000:07:00.0: 303:5: disabled by eeprom
[   81.343258] thunderbolt 0000:07:00.0: 303:6: disabled by eeprom
[   81.344147] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   81.344149] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   81.344150] thunderbolt 0000:07:00.0:   Max counters: 1
[   81.344151] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   81.344152] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   81.345077] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   81.345081] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   81.345083] thunderbolt 0000:07:00.0:   Max counters: 1
[   81.345084] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   81.345085] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   81.345086] thunderbolt 0000:07:00.0: 303:9: disabled by eeprom
[   81.345940] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   81.345944] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[   81.345946] thunderbolt 0000:07:00.0:   Max counters: 1
[   81.345947] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   81.345948] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   81.347124] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   81.347127] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[   81.347128] thunderbolt 0000:07:00.0:   Max counters: 2
[   81.347129] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[   81.347130] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[   81.347131] thunderbolt 0000:07:00.0: 303:c: disabled by eeprom
[   81.347132] thunderbolt 0000:07:00.0: 303:d: disabled by eeprom
[   81.365194] thunderbolt 0000:07:00.0: 303: TMU: current mode: bi-directional, HiFi
[   81.365216] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[   81.365865] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[   81.366584] thunderbolt 0000:07:00.0: 303:1: is unplugged (state: 7)
[   81.366834] thunderbolt 0000:07:00.0: 303:b: DP adapter HPD set, queuing hotplug
[   81.367133] thunderbolt 0000:07:00.0: 3:b: DP adapter HPD set, queuing hotplug
[   81.367288] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): activating
[   81.367296] thunderbolt 0000:07:00.0: activating PCIe Down path from 0:7 to 3:10
[   81.367395] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   81.367403] thunderbolt 0000:07:00.0: 3:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[   81.367406] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   81.367410] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   81.367413] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   81.367416] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.367761] thunderbolt 0000:07:00.0: 0:7: Writing hop 0
[   81.367764] thunderbolt 0000:07:00.0: 0:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[   81.367766] thunderbolt 0000:07:00.0: 0:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   81.367767] thunderbolt 0000:07:00.0: 0:7:    Counter enabled: 0 Counter index: 2047
[   81.367769] thunderbolt 0000:07:00.0: 0:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   81.367770] thunderbolt 0000:07:00.0: 0:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.367808] thunderbolt 0000:07:00.0: path activation complete
[   81.367810] thunderbolt 0000:07:00.0: activating PCIe Up path from 3:10 to 0:7
[   81.367955] thunderbolt 0000:07:00.0: 0:3: Writing hop 1
[   81.367962] thunderbolt 0000:07:00.0: 0:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[   81.367966] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   81.367969] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   81.367972] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   81.367975] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.368212] thunderbolt 0000:07:00.0: 3:a: Writing hop 0
[   81.368218] thunderbolt 0000:07:00.0: 3:a:  In HopID: 8 => Out port: 1 Out HopID: 8
[   81.368222] thunderbolt 0000:07:00.0: 3:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   81.368225] thunderbolt 0000:07:00.0: 3:a:    Counter enabled: 0 Counter index: 2047
[   81.368228] thunderbolt 0000:07:00.0: 3:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   81.368231] thunderbolt 0000:07:00.0: 3:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.368299] thunderbolt 0000:07:00.0: path activation complete
[   81.368331] pcieport 0000:06:04.0: pciehp: Slot(4-1): Card present
[   81.368590] thunderbolt 0000:07:00.0: 3:4: got plug event for connected port, ignoring
[   81.369035] thunderbolt 0000:07:00.0: 3:3: got plug event for connected port, ignoring
[   81.369074] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
[   81.369077] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   81.369207] thunderbolt 0000:07:00.0: 0:c: DP IN available
[   81.369335] thunderbolt 0000:07:00.0: 3:b: DP OUT available
[   81.369338] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 12
[   81.369340] thunderbolt 0000:07:00.0: 3:b: calculating available bandwidth
[   81.369461] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[   81.369465] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[   81.369466] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[   81.369468] thunderbolt 0000:07:00.0: in->port 12
[   81.369471] thunderbolt 0000:07:00.0: Tunnel 1
[   81.369472] thunderbolt 0000:07:00.0: 0:c <-> 3:b (DP): activating
[   81.369474] thunderbolt 0000:07:00.0: activating Video path from 0:12 to 3:11
[   81.369476] thunderbolt 0000:07:00.0: 3:2: adding 12 NFC credits to 0
[   81.369590] thunderbolt 0000:07:00.0: 0:c: adding 5 NFC credits to 0
[   81.369816] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[   81.369818] thunderbolt 0000:07:00.0: 3:2:  In HopID: 8 => Out port: 11 Out HopID: 9
[   81.369819] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   81.369821] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   81.369822] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   81.369823] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.370072] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[   81.370073] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 4 Out HopID: 8
[   81.370074] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   81.370075] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[   81.370077] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   81.370078] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.370200] thunderbolt 0000:07:00.0: path activation complete
[   81.370201] thunderbolt 0000:07:00.0: activating AUX TX path from 0:12 to 3:11
[   81.370348] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[   81.370349] thunderbolt 0000:07:00.0: 3:2:  In HopID: 9 => Out port: 11 Out HopID: 8
[   81.370351] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   81.370352] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   81.370353] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   81.370354] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.370584] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[   81.370585] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 4 Out HopID: 9
[   81.370587] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   81.370588] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[   81.370589] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   81.370590] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.370712] thunderbolt 0000:07:00.0: path activation complete
[   81.370713] thunderbolt 0000:07:00.0: activating AUX RX path from 3:11 to 0:12
[   81.370840] thunderbolt 0000:07:00.0: 0:4: Writing hop 1
[   81.370841] thunderbolt 0000:07:00.0: 0:4:  In HopID: 8 => Out port: 12 Out HopID: 8
[   81.370842] thunderbolt 0000:07:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   81.370843] thunderbolt 0000:07:00.0: 0:4:    Counter enabled: 0 Counter index: 2047
[   81.370844] thunderbolt 0000:07:00.0: 0:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   81.370846] thunderbolt 0000:07:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.371096] thunderbolt 0000:07:00.0: 3:b: Writing hop 0
[   81.371097] thunderbolt 0000:07:00.0: 3:b:  In HopID: 8 => Out port: 2 Out HopID: 8
[   81.371098] thunderbolt 0000:07:00.0: 3:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   81.371099] thunderbolt 0000:07:00.0: 3:b:    Counter enabled: 0 Counter index: 2047
[   81.371100] thunderbolt 0000:07:00.0: 3:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   81.371102] thunderbolt 0000:07:00.0: 3:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.371224] thunderbolt 0000:07:00.0: path activation complete
[   81.375013] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): activating
[   81.375020] thunderbolt 0000:07:00.0: activating PCIe Down path from 3:7 to 303:10
[   81.375143] thunderbolt 0000:07:00.0: 303:3: Writing hop 1
[   81.375145] thunderbolt 0000:07:00.0: 303:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[   81.375146] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   81.375148] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   81.375157] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   81.375158] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.375390] thunderbolt 0000:07:00.0: 3:7: Writing hop 0
[   81.375393] thunderbolt 0000:07:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[   81.375396] thunderbolt 0000:07:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   81.375399] thunderbolt 0000:07:00.0: 3:7:    Counter enabled: 0 Counter index: 2047
[   81.375402] thunderbolt 0000:07:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   81.375405] thunderbolt 0000:07:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.375518] thunderbolt 0000:07:00.0: path activation complete
[   81.375520] thunderbolt 0000:07:00.0: activating PCIe Up path from 303:10 to 3:7
[   81.375646] thunderbolt 0000:07:00.0: 3:3: Writing hop 1
[   81.375649] thunderbolt 0000:07:00.0: 3:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[   81.375651] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   81.375654] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[   81.375657] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   81.375660] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.375902] thunderbolt 0000:07:00.0: 303:a: Writing hop 0
[   81.375905] thunderbolt 0000:07:00.0: 303:a:  In HopID: 8 => Out port: 3 Out HopID: 8
[   81.375908] thunderbolt 0000:07:00.0: 303:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   81.375911] thunderbolt 0000:07:00.0: 303:a:    Counter enabled: 0 Counter index: 2047
[   81.375913] thunderbolt 0000:07:00.0: 303:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   81.375916] thunderbolt 0000:07:00.0: 303:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.376030] thunderbolt 0000:07:00.0: path activation complete
[   81.376542] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[   81.376546] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[   81.376669] thunderbolt 0000:07:00.0: 0:c: in use
[   81.376797] thunderbolt 0000:07:00.0: 0:d: DP IN available
[   81.376925] thunderbolt 0000:07:00.0: 3:b: in use
[   81.377058] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[   81.377061] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 13
[   81.377065] thunderbolt 0000:07:00.0: 303:b: calculating available bandwidth
[   81.377184] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[   81.377188] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[   81.377311] thunderbolt 0000:07:00.0: 3:3: link total bandwidth 9000 Mb/s
[   81.377314] thunderbolt 0000:07:00.0: 303:3: link total bandwidth 9000 Mb/s
[   81.377316] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[   81.377320] thunderbolt 0000:07:00.0: in->port 13
[   81.377328] thunderbolt 0000:07:00.0: Tunnel 0
[   81.377330] thunderbolt 0000:07:00.0: 0:d <-> 303:b (DP): activating
[   81.377333] thunderbolt 0000:07:00.0: activating Video path from 0:13 to 303:11
[   81.377337] thunderbolt 0000:07:00.0: 303:3: adding 12 NFC credits to 0
[   81.377439] thunderbolt 0000:07:00.0: 3:1: adding 12 NFC credits to 0
[   81.377566] thunderbolt 0000:07:00.0: 0:d: adding 5 NFC credits to 0
[   81.377823] thunderbolt 0000:07:00.0: 303:3: Writing hop 2
[   81.377826] thunderbolt 0000:07:00.0: 303:3:  In HopID: 9 => Out port: 11 Out HopID: 9
[   81.377829] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   81.377832] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   81.377835] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   81.377838] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.378079] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   81.378081] thunderbolt 0000:07:00.0: 3:1:  In HopID: 9 => Out port: 3 Out HopID: 9
[   81.378084] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   81.378087] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   81.378090] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   81.378093] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.378334] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[   81.378337] thunderbolt 0000:07:00.0: 0:d:  In HopID: 9 => Out port: 3 Out HopID: 9
[   81.378340] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   81.378343] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[   81.378345] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   81.378348] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.378462] thunderbolt 0000:07:00.0: path activation complete
[   81.378465] thunderbolt 0000:07:00.0: activating AUX TX path from 0:13 to 303:11
[   81.378590] thunderbolt 0000:07:00.0: 303:3: Writing hop 2
[   81.378593] thunderbolt 0000:07:00.0: 303:3:  In HopID: 10 => Out port: 11 Out HopID: 8
[   81.378596] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   81.378599] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   81.378602] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   81.378605] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.381696] thunderbolt 0000:07:00.0: 3:1: Writing hop 1
[   81.381699] thunderbolt 0000:07:00.0: 3:1:  In HopID: 10 => Out port: 3 Out HopID: 10
[   81.381702] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   81.381705] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   81.381707] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   81.381710] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.381952] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[   81.381955] thunderbolt 0000:07:00.0: 0:d:  In HopID: 8 => Out port: 3 Out HopID: 10
[   81.381957] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   81.381960] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[   81.381963] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   81.381965] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.382080] thunderbolt 0000:07:00.0: path activation complete
[   81.382082] thunderbolt 0000:07:00.0: activating AUX RX path from 303:11 to 0:13
[   81.382208] thunderbolt 0000:07:00.0: 0:3: Writing hop 2
[   81.382211] thunderbolt 0000:07:00.0: 0:3:  In HopID: 9 => Out port: 13 Out HopID: 8
[   81.382213] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   81.382216] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   81.382219] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   81.382222] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.382464] thunderbolt 0000:07:00.0: 3:3: Writing hop 1
[   81.382466] thunderbolt 0000:07:00.0: 3:3:  In HopID: 9 => Out port: 1 Out HopID: 9
[   81.382469] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   81.382472] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[   81.382475] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   81.382477] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.382720] thunderbolt 0000:07:00.0: 303:b: Writing hop 0
[   81.382723] thunderbolt 0000:07:00.0: 303:b:  In HopID: 8 => Out port: 3 Out HopID: 9
[   81.382725] thunderbolt 0000:07:00.0: 303:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   81.382728] thunderbolt 0000:07:00.0: 303:b:    Counter enabled: 0 Counter index: 2047
[   81.382731] thunderbolt 0000:07:00.0: 303:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   81.382734] thunderbolt 0000:07:00.0: 303:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   81.382848] thunderbolt 0000:07:00.0: path activation complete
[   81.554557] pci 0000:18:00.0: [8086:1513] type 01 class 0x060400
[   81.555309] pci 0000:18:00.0: enabling Extended Tags
[   81.556131] pci 0000:18:00.0: supports D1 D2
[   81.556751] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.557571] pcieport 0000:06:04.0: ASPM: current common clock configuration is inconsistent, reconfiguring
[   81.584502] pci 0000:18:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.585350] pci 0000:19:00.0: [8086:1513] type 01 class 0x060400
[   81.586128] pci 0000:19:00.0: enabling Extended Tags
[   81.586939] pci 0000:19:00.0: supports D1 D2
[   81.587564] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.588374] pci 0000:19:01.0: [8086:1513] type 01 class 0x060400
[   81.589142] pci 0000:19:01.0: enabling Extended Tags
[   81.589960] pci 0000:19:01.0: supports D1 D2
[   81.590585] pci 0000:19:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.591389] pci 0000:19:02.0: [8086:1513] type 01 class 0x060400
[   81.592162] pci 0000:19:02.0: enabling Extended Tags
[   81.592969] pci 0000:19:02.0: supports D1 D2
[   81.593595] pci 0000:19:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.594404] pci 0000:19:04.0: [8086:1513] type 01 class 0x060400
[   81.595214] pci 0000:19:04.0: enabling Extended Tags
[   81.596035] pci 0000:19:04.0: supports D1 D2
[   81.596673] pci 0000:19:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.597477] pci 0000:19:05.0: [8086:1513] type 01 class 0x060400
[   81.598227] pci 0000:19:05.0: enabling Extended Tags
[   81.599054] pci 0000:19:05.0: supports D1 D2
[   81.599704] pci 0000:19:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.600548] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   81.601231] pci 0000:18:00.0:   bridge window [io  0x0000-0x0fff]
[   81.601904] pci 0000:18:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.602559] pci 0000:18:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.603204] pci 0000:19:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.603861] pci 0000:19:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.604539] pci 0000:19:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.605202] pci 0000:19:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.605851] pci 0000:19:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.606641] pci 0000:1a:00.0: [12d8:400c] type 01 class 0x060400
[   81.607655] pci 0000:1a:00.0: supports D1 D2
[   81.608274] pci 0000:1a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.634558] pci 0000:19:00.0: PCI bridge to [bus 1a-55]
[   81.635210] pci 0000:19:00.0:   bridge window [io  0x0000-0x0fff]
[   81.635863] pci 0000:19:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.636516] pci 0000:19:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.637167] pci 0000:1a:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.638069] pci 0000:1b:03.0: [12d8:400c] type 01 class 0x060400
[   81.639024] pci 0000:1b:03.0: supports D1 D2
[   81.639657] pci 0000:1b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.640539] pci 0000:1a:00.0: PCI bridge to [bus 1b-55]
[   81.641206] pci 0000:1a:00.0:   bridge window [io  0x0000-0x0fff]
[   81.641858] pci 0000:1a:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.642530] pci 0000:1a:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.643173] pci 0000:1b:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.644061] pci 0000:1c:00.0: [12d8:400e] type 00 class 0x0c0310
[   81.644778] pci 0000:1c:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   81.645714] pci 0000:1c:00.0: supports D1 D2
[   81.646358] pci 0000:1c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.647180] pci 0000:1c:00.1: [12d8:400e] type 00 class 0x0c0310
[   81.647903] pci 0000:1c:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   81.648832] pci 0000:1c:00.1: supports D1 D2
[   81.649479] pci 0000:1c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   81.650294] pci 0000:1c:00.2: [12d8:400f] type 00 class 0x0c0320
[   81.651013] pci 0000:1c:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   81.651951] pci 0000:1c:00.2: supports D1 D2
[   81.652607] pci 0000:1c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   81.653563] pci 0000:1b:03.0: PCI bridge to [bus 1c-55]
[   81.654252] pci 0000:1b:03.0:   bridge window [io  0x0000-0x0fff]
[   81.654956] pci 0000:1b:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.655654] pci 0000:1b:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.656319] pci_bus 0000:1c: busn_res: [bus 1c-55] end is updated to 1c
[   81.657009] pci_bus 0000:1b: busn_res: [bus 1b-55] end is updated to 1c
[   81.657693] pci_bus 0000:1a: busn_res: [bus 1a-55] end is updated to 1c
[   81.658534] pci 0000:1d:00.0: [14e4:16b0] type 00 class 0x020000
[   81.659265] pci 0000:1d:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   81.659986] pci 0000:1d:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   81.661002] pci 0000:1d:00.0: PME# supported from D0 D3hot D3cold
[   81.684513] pci 0000:19:01.0: PCI bridge to [bus 1d-55]
[   81.685228] pci 0000:19:01.0:   bridge window [io  0x0000-0x0fff]
[   81.685926] pci 0000:19:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.686629] pci 0000:19:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.687323] pci_bus 0000:1d: busn_res: [bus 1d-55] end is updated to 1d
[   81.688194] pci 0000:1e:00.0: [11c1:5901] type 00 class 0x0c0010
[   81.688954] pci 0000:1e:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   81.690000] pci 0000:1e:00.0: supports D1 D2
[   81.690700] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.714518] pci 0000:19:02.0: PCI bridge to [bus 1e-55]
[   81.715272] pci 0000:19:02.0:   bridge window [io  0x0000-0x0fff]
[   81.715994] pci 0000:19:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.716707] pci 0000:19:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.717421] pci_bus 0000:1e: busn_res: [bus 1e-55] end is updated to 1e
[   81.718336] pci 0000:1f:00.0: [8086:1513] type 01 class 0x060400
[   81.719205] pci 0000:1f:00.0: enabling Extended Tags
[   81.720176] pci 0000:1f:00.0: supports D1 D2
[   81.720871] pci 0000:1f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.721844] pci 0000:19:04.0: PCI bridge to [bus 1f-55]
[   81.722567] pci 0000:19:04.0:   bridge window [io  0x0000-0x0fff]
[   81.723281] pci 0000:19:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.723993] pci 0000:19:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.724731] pci 0000:1f:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.725705] pci 0000:20:00.0: [8086:1513] type 01 class 0x060400
[   81.726559] pci 0000:20:00.0: enabling Extended Tags
[   81.727511] pci 0000:20:00.0: supports D1 D2
[   81.728201] pci 0000:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.729118] pci 0000:20:01.0: [8086:1513] type 01 class 0x060400
[   81.729989] pci 0000:20:01.0: enabling Extended Tags
[   81.730945] pci 0000:20:01.0: supports D1 D2
[   81.731624] pci 0000:20:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.732566] pci 0000:20:02.0: [8086:1513] type 01 class 0x060400
[   81.733434] pci 0000:20:02.0: enabling Extended Tags
[   81.734384] pci 0000:20:02.0: supports D1 D2
[   81.735091] pci 0000:20:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.736041] pci 0000:20:04.0: [8086:1513] type 01 class 0x060400
[   81.736894] pci 0000:20:04.0: enabling Extended Tags
[   81.737855] pci 0000:20:04.0: supports D1 D2
[   81.738536] pci 0000:20:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.739486] pci 0000:20:05.0: [8086:1513] type 01 class 0x060400
[   81.740355] pci 0000:20:05.0: enabling Extended Tags
[   81.741317] pci 0000:20:05.0: supports D1 D2
[   81.741996] pci 0000:20:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.742976] pci 0000:1f:00.0: PCI bridge to [bus 20-55]
[   81.743691] pci 0000:1f:00.0:   bridge window [io  0x0000-0x0fff]
[   81.744407] pci 0000:1f:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.745138] pci 0000:1f:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.745851] pci 0000:20:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.746570] pci 0000:20:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.747290] pci 0000:20:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.748010] pci 0000:20:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.748721] pci 0000:20:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.749676] pci 0000:21:00.0: [12d8:400c] type 01 class 0x060400
[   81.750874] pci 0000:21:00.0: supports D1 D2
[   81.751555] pci 0000:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.752518] pci 0000:20:00.0: PCI bridge to [bus 21-55]
[   81.753246] pci 0000:20:00.0:   bridge window [io  0x0000-0x0fff]
[   81.753953] pci 0000:20:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.754681] pci 0000:20:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.755386] pci 0000:21:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.756383] pci 0000:22:03.0: [12d8:400c] type 01 class 0x060400
[   81.757499] pci 0000:22:03.0: supports D1 D2
[   81.758181] pci 0000:22:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.759147] pci 0000:21:00.0: PCI bridge to [bus 22-55]
[   81.759876] pci 0000:21:00.0:   bridge window [io  0x0000-0x0fff]
[   81.760578] pci 0000:21:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.761287] pci 0000:21:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.761977] pci 0000:22:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   81.762935] pci 0000:23:00.0: [12d8:400e] type 00 class 0x0c0310
[   81.763715] pci 0000:23:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   81.764797] pci 0000:23:00.0: supports D1 D2
[   81.765507] pci 0000:23:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.766460] pci 0000:23:00.1: [12d8:400e] type 00 class 0x0c0310
[   81.767215] pci 0000:23:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   81.768267] pci 0000:23:00.1: supports D1 D2
[   81.768957] pci 0000:23:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   81.769844] pci 0000:23:00.2: [12d8:400f] type 00 class 0x0c0320
[   81.770600] pci 0000:23:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   81.771672] pci 0000:23:00.2: supports D1 D2
[   81.772352] pci 0000:23:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   81.773427] pci 0000:22:03.0: PCI bridge to [bus 23-55]
[   81.774147] pci 0000:22:03.0:   bridge window [io  0x0000-0x0fff]
[   81.774893] pci 0000:22:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.775608] pci 0000:22:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.776314] pci_bus 0000:23: busn_res: [bus 23-55] end is updated to 23
[   81.777021] pci_bus 0000:22: busn_res: [bus 22-55] end is updated to 23
[   81.777736] pci_bus 0000:21: busn_res: [bus 21-55] end is updated to 23
[   81.778657] pci 0000:24:00.0: [14e4:16b0] type 00 class 0x020000
[   81.779434] pci 0000:24:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   81.780187] pci 0000:24:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   81.781323] pci 0000:24:00.0: PME# supported from D0 D3hot D3cold
[   81.782352] pci 0000:20:01.0: PCI bridge to [bus 24-55]
[   81.783068] pci 0000:20:01.0:   bridge window [io  0x0000-0x0fff]
[   81.783782] pci 0000:20:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.784531] pci 0000:20:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.785223] pci_bus 0000:24: busn_res: [bus 24-55] end is updated to 24
[   81.786124] pci 0000:25:00.0: [11c1:5901] type 00 class 0x0c0010
[   81.786906] pci 0000:25:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   81.788038] pci 0000:25:00.0: supports D1 D2
[   81.788721] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   81.789743] pci 0000:20:02.0: PCI bridge to [bus 25-55]
[   81.790462] pci 0000:20:02.0:   bridge window [io  0x0000-0x0fff]
[   81.791178] pci 0000:20:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.791898] pci 0000:20:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.792597] pci_bus 0000:25: busn_res: [bus 25-55] end is updated to 25
[   81.793438] pci 0000:20:04.0: PCI bridge to [bus 26-55]
[   81.794169] pci 0000:20:04.0:   bridge window [io  0x0000-0x0fff]
[   81.794901] pci 0000:20:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.795611] pci 0000:20:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.796295] pci_bus 0000:26: busn_res: [bus 26-55] end is updated to 35
[   81.797146] pci 0000:20:05.0: PCI bridge to [bus 36-55]
[   81.797872] pci 0000:20:05.0:   bridge window [io  0x0000-0x0fff]
[   81.798583] pci 0000:20:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.799299] pci 0000:20:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.799999] pci_bus 0000:36: busn_res: [bus 36-55] end is updated to 45
[   81.800707] pci_bus 0000:20: busn_res: [bus 20-55] end is updated to 45
[   81.801412] pci_bus 0000:1f: busn_res: [bus 1f-55] end is updated to 45
[   81.802208] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[   81.802923] pci 0000:19:05.0:   bridge window [io  0x0000-0x0fff]
[   81.803622] pci 0000:19:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   81.804325] pci 0000:19:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   81.805033] pci_bus 0000:46: busn_res: [bus 46-55] end is updated to 55
[   81.805730] pci_bus 0000:19: busn_res: [bus 19-55] end is updated to 55
[   81.806414] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 26-35] add_size 3ff00000 add_align 100000
[   81.807106] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 26-35] add_size 7f00000 add_align 100000
[   81.807799] pci 0000:20:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 36-45] add_size 3ff00000 add_align 100000
[   81.808496] pci 0000:20:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 36-45] add_size 7f00000 add_align 100000
[   81.809195] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 20-45] add_size 7fe00000 add_align 100000
[   81.809900] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x005fffff] to [bus 20-45] add_size fe00000 add_align 100000
[   81.810611] pci 0000:19:04.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 1f-45] add_size bf900000 add_align 100000
[   81.811329] pci 0000:19:04.0: bridge window [mem 0x00100000-0x005fffff] to [bus 1f-45] add_size 17900000 add_align 100000
[   81.812045] pci 0000:19:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 46-55] add_size 3ff00000 add_align 100000
[   81.812767] pci 0000:19:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 46-55] add_size 7f00000 add_align 100000
[   81.813489] pci 0000:18:00.0: bridge window [mem 0x00100000-0x009fffff 64bit pref] to [bus 19-55] add_size ff800000 add_align 100000
[   81.814220] pci 0000:18:00.0: bridge window [mem 0x00100000-0x009fffff] to [bus 19-55] add_size 1f800000 add_align 100000
[   81.814975] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x009fffff 64bit pref] to [bus 18-55] add_size 13ef00000 add_align 100000
[   81.815738] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   81.816501] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   81.817248] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   81.818002] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   81.818762] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[   81.819533] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   81.820303] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   81.821076] pci 0000:18:00.0: BAR 7: assigned [io  0x5000-0x9fff]
[   81.821845] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[   81.822612] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00900000 64bit pref]
[   81.823383] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00900000 64bit pref]
[   81.824160] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   81.824965] pci 0000:19:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   81.825766] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0d00000-0xb0dfffff]
[   81.826539] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0e00000-0xb0efffff 64bit pref]
[   81.827304] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[   81.828068] pci 0000:19:02.0: BAR 9: assigned [mem 0xb1000000-0xb10fffff 64bit pref]
[   81.828829] pci 0000:19:04.0: BAR 8: assigned [mem 0xb1100000-0xbd27ffff]
[   81.829591] pci 0000:19:04.0: BAR 9: assigned [mem 0xbd300000-0xbd5fffff 64bit pref]
[   81.830370] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   81.831137] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   81.831901] pci 0000:19:05.0: BAR 9: assigned [mem 0xbd600000-0xbd8fffff 64bit pref]
[   81.832664] pci 0000:19:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   81.833433] pci 0000:19:01.0: BAR 7: assigned [io  0x6000-0x6fff]
[   81.834224] pci 0000:19:02.0: BAR 7: assigned [io  0x7000-0x7fff]
[   81.835004] pci 0000:19:04.0: BAR 7: assigned [io  0x8000-0x8fff]
[   81.835770] pci 0000:19:05.0: BAR 7: assigned [io  0x9000-0x9fff]
[   81.836517] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   81.837281] pci 0000:19:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   81.838029] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0d00000-0xb0dfffff]
[   81.838790] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0e00000-0xb0efffff 64bit pref]
[   81.839536] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[   81.840296] pci 0000:19:02.0: BAR 9: assigned [mem 0xb1000000-0xb10fffff 64bit pref]
[   81.841039] pci 0000:19:04.0: BAR 8: assigned [mem 0xb1100000-0xbd27ffff]
[   81.841777] pci 0000:19:04.0: BAR 9: assigned [mem 0xbd300000-0xbd5fffff 64bit pref]
[   81.842518] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   81.843262] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   81.844040] pci 0000:19:05.0: BAR 9: assigned [mem 0xbd600000-0xbd8fffff 64bit pref]
[   81.844811] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   81.845575] pci 0000:1a:00.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   81.846330] pci 0000:1a:00.0: BAR 7: assigned [io  0x5000-0x5fff]
[   81.847079] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[   81.847827] pci 0000:1b:03.0: BAR 9: assigned [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   81.848578] pci 0000:1b:03.0: BAR 7: assigned [io  0x5000-0x5fff]
[   81.849327] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[   81.850100] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[   81.850863] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[   81.851624] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   81.852385] pci 0000:1b:03.0:   bridge window [io  0x5000-0x5fff]
[   81.853150] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   81.853909] pci 0000:1b:03.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   81.854713] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   81.855466] pci 0000:1a:00.0:   bridge window [io  0x5000-0x5fff]
[   81.856237] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   81.856983] pci 0000:1a:00.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   81.857737] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   81.858479] pci 0000:19:00.0:   bridge window [io  0x5000-0x5fff]
[   81.859232] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[   81.859992] pci 0000:19:00.0:   bridge window [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   81.860744] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e0ffff 64bit pref]
[   81.861515] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0e10000-0xb0e1ffff 64bit pref]
[   81.862284] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   81.863028] pci 0000:19:01.0:   bridge window [io  0x6000-0x6fff]
[   81.863777] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[   81.864547] pci 0000:19:01.0:   bridge window [mem 0xb0e00000-0xb0efffff 64bit pref]
[   81.865307] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff 64bit]
[   81.866095] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   81.866849] pci 0000:19:02.0:   bridge window [io  0x7000-0x7fff]
[   81.867608] pci 0000:19:02.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[   81.868364] pci 0000:19:02.0:   bridge window [mem 0xb1000000-0xb10fffff 64bit pref]
[   81.869132] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb1100000-0xbd27ffff]
[   81.869884] pci 0000:1f:00.0: BAR 9: assigned [mem 0xbd300000-0xbd5fffff 64bit pref]
[   81.870641] pci 0000:1f:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   81.871396] pci 0000:20:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   81.872153] pci 0000:20:00.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   81.872908] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[   81.873665] pci 0000:20:01.0: BAR 9: assigned [mem 0xbd400000-0xbd4fffff 64bit pref]
[   81.874413] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1300000-0xb13fffff]
[   81.875180] pci 0000:20:02.0: BAR 9: assigned [mem 0xbd500000-0xbd5fffff 64bit pref]
[   81.875920] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1400000-0xb733ffff]
[   81.876656] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   81.877388] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   81.878104] pci 0000:20:05.0: BAR 8: assigned [mem 0xb7400000-0xbd27ffff]
[   81.878832] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   81.879559] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   81.880283] pci 0000:20:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   81.881003] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   81.881717] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   81.882427] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   81.883127] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   81.883819] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   81.884527] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   81.885217] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   81.885905] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   81.886588] pci 0000:20:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   81.887271] pci 0000:20:00.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   81.887952] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[   81.888630] pci 0000:20:01.0: BAR 9: assigned [mem 0xbd400000-0xbd4fffff 64bit pref]
[   81.889310] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1300000-0xb13fffff]
[   81.889987] pci 0000:20:02.0: BAR 9: assigned [mem 0xbd500000-0xbd5fffff 64bit pref]
[   81.890663] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1400000-0xb733ffff]
[   81.891336] pci 0000:20:04.0: BAR 9: assigned [mem 0xb7400000-0xb74fffff 64bit pref]
[   81.892011] pci 0000:20:05.0: BAR 8: no space for [mem size 0x05e80000]
[   81.892686] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x05e80000]
[   81.893361] pci 0000:20:05.0: BAR 9: assigned [mem 0xb7500000-0xb75fffff 64bit pref]
[   81.894039] pci 0000:20:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   81.894750] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   81.895437] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   81.896109] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   81.896776] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   81.897444] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   81.898112] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   81.898776] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   81.899450] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   81.900128] pci 0000:20:05.0: BAR 9: [mem 0xb7500000-0xb75fffff 64bit pref] (failed to expand by 0x3ff00000)
[   81.900818] pci 0000:20:05.0: failed to add 3ff00000 res[9]=[mem 0xb7500000-0xb75fffff 64bit pref]
[   81.901518] pci 0000:20:04.0: BAR 9: [mem 0xb7400000-0xb74fffff 64bit pref] (failed to expand by 0x3ff00000)
[   81.902219] pci 0000:20:04.0: failed to add 3ff00000 res[9]=[mem 0xb7400000-0xb74fffff 64bit pref]
[   81.902927] pci 0000:21:00.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   81.903634] pci 0000:21:00.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   81.904344] pci 0000:21:00.0: BAR 7: assigned [io  0x8000-0x8fff]
[   81.905062] pci 0000:22:03.0: BAR 8: assigned [mem 0xb1100000-0xb11fffff]
[   81.905774] pci 0000:22:03.0: BAR 9: assigned [mem 0xbd300000-0xbd3fffff 64bit pref]
[   81.906486] pci 0000:22:03.0: BAR 7: assigned [io  0x8000-0x8fff]
[   81.907196] pci 0000:23:00.0: BAR 0: assigned [mem 0xb1100000-0xb1100fff]
[   81.907916] pci 0000:23:00.1: BAR 0: assigned [mem 0xb1101000-0xb1101fff]
[   81.908630] pci 0000:23:00.2: BAR 0: assigned [mem 0xb1102000-0xb11020ff]
[   81.909342] pci 0000:22:03.0: PCI bridge to [bus 23]
[   81.910049] pci 0000:22:03.0:   bridge window [io  0x8000-0x8fff]
[   81.910764] pci 0000:22:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   81.911473] pci 0000:22:03.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   81.912192] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   81.912897] pci 0000:21:00.0:   bridge window [io  0x8000-0x8fff]
[   81.913609] pci 0000:21:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   81.914317] pci 0000:21:00.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   81.915063] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   81.915763] pci 0000:20:00.0:   bridge window [io  0x8000-0x8fff]
[   81.916475] pci 0000:20:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[   81.917171] pci 0000:20:00.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[   81.917892] pci 0000:24:00.0: BAR 0: assigned [mem 0xbd400000-0xbd40ffff 64bit pref]
[   81.918632] pci 0000:24:00.0: BAR 2: assigned [mem 0xbd410000-0xbd41ffff 64bit pref]
[   81.919366] pci 0000:20:01.0: PCI bridge to [bus 24]
[   81.920074] pci 0000:20:01.0:   bridge window [mem 0xb1200000-0xb12fffff]
[   81.920783] pci 0000:20:01.0:   bridge window [mem 0xbd400000-0xbd4fffff 64bit pref]
[   81.921501] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1300000-0xb1300fff 64bit]
[   81.922239] pci 0000:20:02.0: PCI bridge to [bus 25]
[   81.922953] pci 0000:20:02.0:   bridge window [mem 0xb1300000-0xb13fffff]
[   81.923665] pci 0000:20:02.0:   bridge window [mem 0xbd500000-0xbd5fffff 64bit pref]
[   81.924388] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[   81.925123] pci 0000:20:04.0:   bridge window [mem 0xb1400000-0xb733ffff]
[   81.925835] pci 0000:20:04.0:   bridge window [mem 0xb7400000-0xb74fffff 64bit pref]
[   81.926545] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[   81.927258] pci 0000:20:05.0:   bridge window [mem 0xb7500000-0xb75fffff 64bit pref]
[   81.927974] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   81.928675] pci 0000:1f:00.0:   bridge window [io  0x8000-0x8fff]
[   81.929394] pci 0000:1f:00.0:   bridge window [mem 0xb1100000-0xbd27ffff]
[   81.930104] pci 0000:1f:00.0:   bridge window [mem 0xbd300000-0xbd5fffff 64bit pref]
[   81.930825] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[   81.931533] pci 0000:19:04.0:   bridge window [io  0x8000-0x8fff]
[   81.932248] pci 0000:19:04.0:   bridge window [mem 0xb1100000-0xbd27ffff]
[   81.932957] pci 0000:19:04.0:   bridge window [mem 0xbd300000-0xbd5fffff 64bit pref]
[   81.933673] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[   81.934377] pci 0000:19:05.0:   bridge window [io  0x9000-0x9fff]
[   81.935121] pci 0000:19:05.0:   bridge window [mem 0xbd600000-0xbd8fffff 64bit pref]
[   81.935849] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   81.936553] pci 0000:18:00.0:   bridge window [io  0x5000-0x9fff]
[   81.937261] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[   81.937976] pcieport 0000:06:04.0: PCI bridge to [bus 18-55]
[   81.938678] pcieport 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[   81.939392] pcieport 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[   81.940110] PCI: No. 2 try to assign unassigned res
[   81.940111] pci 0000:22:03.0: resource 7 [io  0x8000-0x8fff] released
[   81.940820] pci 0000:22:03.0: PCI bridge to [bus 23]
[   81.941545] pci 0000:21:00.0: resource 7 [io  0x8000-0x8fff] released
[   81.942252] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   81.942979] pci 0000:20:00.0: resource 7 [io  0x8000-0x8fff] released
[   81.943684] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   81.944408] pci 0000:1f:00.0: resource 7 [io  0x8000-0x8fff] released
[   81.945151] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   81.945894] release child resource [mem 0xb1100000-0xb1100fff]
[   81.945895] release child resource [mem 0xb1101000-0xb1101fff]
[   81.945896] release child resource [mem 0xb1102000-0xb11020ff]
[   81.945897] pci 0000:22:03.0: resource 8 [mem 0xb1100000-0xb11fffff] released
[   81.946607] pci 0000:22:03.0: PCI bridge to [bus 23]
[   81.947324] pci 0000:21:00.0: resource 8 [mem 0xb1100000-0xb11fffff] released
[   81.948036] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   81.948760] pci 0000:20:00.0: resource 8 [mem 0xb1100000-0xb11fffff] released
[   81.949481] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   81.950210] pci 0000:20:01.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[   81.950938] pci 0000:20:01.0: PCI bridge to [bus 24]
[   81.951672] release child resource [mem 0xb1300000-0xb1300fff 64bit]
[   81.951673] pci 0000:20:02.0: resource 8 [mem 0xb1300000-0xb13fffff] released
[   81.952404] pci 0000:20:02.0: PCI bridge to [bus 25]
[   81.953142] pci 0000:20:04.0: resource 8 [mem 0xb1400000-0xb733ffff] released
[   81.953877] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[   81.954646] release child resource [mem 0xb7400000-0xb74fffff 64bit pref]
[   81.954647] release child resource [mem 0xb7500000-0xb75fffff 64bit pref]
[   81.954648] pci 0000:1f:00.0: resource 8 [mem 0xb1100000-0xbd27ffff] released
[   81.955397] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   81.956149] release child resource [mem 0xb0b00000-0xb0b00fff]
[   81.956150] release child resource [mem 0xb0b01000-0xb0b01fff]
[   81.956150] release child resource [mem 0xb0b02000-0xb0b020ff]
[   81.956151] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[   81.956887] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   81.957625] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[   81.958359] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   81.959102] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[   81.959842] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   81.960592] pci 0000:19:01.0: resource 8 [mem 0xb0d00000-0xb0dfffff] released
[   81.961341] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   81.962094] release child resource [mem 0xb0f00000-0xb0f00fff 64bit]
[   81.962095] pci 0000:19:02.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[   81.962849] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   81.963608] pci 0000:19:04.0: resource 8 [mem 0xb1100000-0xbd27ffff] released
[   81.964365] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[   81.965134] release child resource [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   81.965135] release child resource [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   81.965135] release child resource [mem 0xb0c00000-0xb0cfffff 64bit pref]
[   81.965136] release child resource [mem 0xb0e00000-0xb0e0ffff 64bit pref]
[   81.965137] release child resource [mem 0xb0e10000-0xb0e1ffff 64bit pref]
[   81.965137] release child resource [mem 0xb0e00000-0xb0efffff 64bit pref]
[   81.965138] release child resource [mem 0xb1000000-0xb10fffff 64bit pref]
[   81.965139] release child resource [mem 0xbd300000-0xbd3fffff 64bit pref]
[   81.965139] release child resource [mem 0xbd300000-0xbd3fffff 64bit pref]
[   81.965148] release child resource [mem 0xbd300000-0xbd3fffff 64bit pref]
[   81.965148] release child resource [mem 0xbd400000-0xbd40ffff 64bit pref]
[   81.965149] release child resource [mem 0xbd410000-0xbd41ffff 64bit pref]
[   81.965150] release child resource [mem 0xbd400000-0xbd4fffff 64bit pref]
[   81.965150] release child resource [mem 0xbd500000-0xbd5fffff 64bit pref]
[   81.965151] release child resource [mem 0xbd300000-0xbd5fffff 64bit pref]
[   81.965152] release child resource [mem 0xbd300000-0xbd5fffff 64bit pref]
[   81.965152] release child resource [mem 0xbd600000-0xbd8fffff 64bit pref]
[   81.965153] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[   81.965908] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   81.966660] pcieport 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[   81.967409] pcieport 0000:06:04.0: PCI bridge to [bus 18-55]
[   81.968155] release child resource [mem 0xa8a00000-0xa8a3ffff]
[   81.968155] release child resource [mem 0xa8a00000-0xa8a3ffff]
[   81.968156] release child resource [mem 0xa8a40000-0xa8a40fff]
[   81.968157] pcieport 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[   81.968905] pcieport 0000:06:00.0: PCI bridge to [bus 07]
[   81.969654] pcieport 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[   81.970402] pcieport 0000:06:03.0: PCI bridge to [bus 08-17]
[   81.971154] pcieport 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[   81.971906] pcieport 0000:06:05.0: PCI bridge to [bus 56-65]
[   81.972659] pcieport 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[   81.973417] pcieport 0000:06:06.0: PCI bridge to [bus 66-75]
[   81.974181] pcieport 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[   81.974967] pcieport 0000:05:00.0: PCI bridge to [bus 06-75]
[   81.975748] pci 0000:20:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 26-35] add_size 3ff00000 add_align 100000
[   81.976535] pci 0000:20:04.0: bridge window [mem 0x00100000-0x060fffff] to [bus 26-35] add_size 2000000 add_align 100000
[   81.977331] pci 0000:20:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 36-45] add_size 3ff00000 add_align 100000
[   81.978129] pci 0000:20:05.0: bridge window [mem 0x00100000-0x05ffffff] to [bus 36-45] add_size 2100000 add_align 100000
[   81.978931] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 20-45] add_size 7fe00000 add_align 100000
[   81.979741] pci 0000:1f:00.0: bridge window [mem 0x00100000-0x0c2fffff] to [bus 20-45] add_size 4100000 add_align 100000
[   81.980551] pci 0000:19:04.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 1f-45] add_size bf900000 add_align 100000
[   81.981363] pci 0000:19:04.0: bridge window [mem 0x00100000-0x0c2fffff] to [bus 1f-45] add_size 4100000 add_align 100000
[   81.982177] pci 0000:19:05.0: bridge window [mem 0x00100000-0x003fffff 64bit pref] to [bus 46-55] add_size 3fd00000 add_align 100000
[   81.983000] pci 0000:18:00.0: bridge window [mem 0x00100000-0x00bfffff 64bit pref] to [bus 19-55] add_size ff600000 add_align 100000
[   81.983824] pci 0000:18:00.0: bridge window [mem 0x00100000-0x186fffff] to [bus 19-55] add_size 4100000 add_align 100000
[   81.984678] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x00bfffff 64bit pref] to [bus 18-55] add_size 13eb00000 add_align 100000
[   81.985521] pcieport 0000:06:04.0: bridge window [mem 0x00100000-0x186fffff] to [bus 18-55] add_size 4100000 add_align 100000
[   81.986366] pcieport 0000:06:04.0: BAR 8: no space for [mem size 0x18600000]
[   81.987196] pcieport 0000:06:04.0: BAR 8: failed to assign [mem size 0x18600000]
[   81.988039] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   81.988883] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   81.989726] pcieport 0000:06:04.0: BAR 8: no space for [mem size 0x18600000]
[   81.990570] pcieport 0000:06:04.0: BAR 8: failed to assign [mem size 0x18600000]
[   81.991416] pcieport 0000:06:04.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   81.992259] pcieport 0000:06:04.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   81.993104] pci 0000:18:00.0: BAR 8: no space for [mem size 0x18600000]
[   81.993953] pci 0000:18:00.0: BAR 8: failed to assign [mem size 0x18600000]
[   81.994832] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   81.995693] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   81.996554] pci 0000:18:00.0: BAR 8: no space for [mem size 0x18600000]
[   81.997394] pci 0000:18:00.0: BAR 8: failed to assign [mem size 0x18600000]
[   81.998240] pci 0000:18:00.0: BAR 9: no space for [mem size 0x00b00000 64bit pref]
[   81.999087] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0x00b00000 64bit pref]
[   81.999936] pci 0000:19:00.0: BAR 8: no space for [mem size 0x00100000]
[   82.000788] pci 0000:19:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.001642] pci 0000:19:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.002501] pci 0000:19:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.003360] pci 0000:19:01.0: BAR 8: no space for [mem size 0x00100000]
[   82.004220] pci 0000:19:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.005102] pci 0000:19:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.005976] pci 0000:19:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.006824] pci 0000:19:02.0: BAR 8: no space for [mem size 0x00100000]
[   82.007675] pci 0000:19:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.008540] pci 0000:19:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.009406] pci 0000:19:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.010275] pci 0000:19:04.0: BAR 8: no space for [mem size 0x0c180000]
[   82.011140] pci 0000:19:04.0: BAR 8: failed to assign [mem size 0x0c180000]
[   82.012007] pci 0000:19:04.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   82.012875] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   82.013744] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   82.014640] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   82.015510] pci 0000:19:05.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   82.016382] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   82.017256] pci 0000:19:00.0: BAR 8: no space for [mem size 0x00100000]
[   82.018128] pci 0000:19:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.019000] pci 0000:19:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.019872] pci 0000:19:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.020743] pci 0000:19:01.0: BAR 8: no space for [mem size 0x00100000]
[   82.021614] pci 0000:19:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.022484] pci 0000:19:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.023355] pci 0000:19:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.024227] pci 0000:19:02.0: BAR 8: no space for [mem size 0x00100000]
[   82.025117] pci 0000:19:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.026012] pci 0000:19:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.026875] pci 0000:19:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.027741] pci 0000:19:04.0: BAR 8: no space for [mem size 0x0c180000]
[   82.028608] pci 0000:19:04.0: BAR 8: failed to assign [mem size 0x0c180000]
[   82.029477] pci 0000:19:04.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   82.030346] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   82.031215] pci 0000:19:05.0: BAR 8: no space for [mem size 0x0c100000]
[   82.032082] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x0c100000]
[   82.032948] pci 0000:19:05.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   82.033814] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   82.034706] pci 0000:1a:00.0: BAR 8: no space for [mem size 0x00100000]
[   82.035580] pci 0000:1a:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.036452] pci 0000:1a:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.037318] pci 0000:1a:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.038188] pci 0000:1a:00.0: BAR 8: no space for [mem size 0x00100000]
[   82.039053] pci 0000:1a:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.039919] pci 0000:1a:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.040782] pci 0000:1a:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.041649] pci 0000:1b:03.0: BAR 8: no space for [mem size 0x00100000]
[   82.042510] pci 0000:1b:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.043371] pci 0000:1b:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.044233] pci 0000:1b:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.045117] pci 0000:1b:03.0: BAR 8: no space for [mem size 0x00100000]
[   82.045992] pci 0000:1b:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.046853] pci 0000:1b:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.047715] pci 0000:1b:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.048582] pci 0000:1c:00.0: BAR 0: no space for [mem size 0x00001000]
[   82.049446] pci 0000:1c:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   82.050309] pci 0000:1c:00.1: BAR 0: no space for [mem size 0x00001000]
[   82.051168] pci 0000:1c:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   82.052027] pci 0000:1c:00.2: BAR 0: no space for [mem size 0x00000100]
[   82.052875] pci 0000:1c:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   82.053720] pci 0000:1c:00.0: BAR 0: no space for [mem size 0x00001000]
[   82.054583] pci 0000:1c:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   82.055421] pci 0000:1c:00.1: BAR 0: no space for [mem size 0x00001000]
[   82.056253] pci 0000:1c:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   82.057067] pci 0000:1c:00.2: BAR 0: no space for [mem size 0x00000100]
[   82.057893] pci 0000:1c:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   82.058716] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[   82.059538] pci 0000:1b:03.0:   bridge window [io  0x5000-0x5fff]
[   82.060394] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[   82.061216] pci 0000:1a:00.0:   bridge window [io  0x5000-0x5fff]
[   82.062057] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[   82.062860] pci 0000:19:00.0:   bridge window [io  0x5000-0x5fff]
[   82.063680] pci 0000:1d:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   82.064505] pci 0000:1d:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   82.065291] pci 0000:1d:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   82.066091] pci 0000:1d:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   82.066891] pci 0000:1d:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   82.067692] pci 0000:1d:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   82.068493] pci 0000:1d:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   82.069296] pci 0000:1d:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   82.070095] pci 0000:19:01.0: PCI bridge to [bus 1d]
[   82.070899] pci 0000:19:01.0:   bridge window [io  0x6000-0x6fff]
[   82.071725] pci 0000:1e:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   82.072528] pci 0000:1e:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   82.073328] pci 0000:1e:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   82.074129] pci 0000:1e:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   82.074948] pci 0000:19:02.0: PCI bridge to [bus 1e]
[   82.075750] pci 0000:19:02.0:   bridge window [io  0x7000-0x7fff]
[   82.076578] pci 0000:1f:00.0: BAR 8: no space for [mem size 0x0c180000]
[   82.077379] pci 0000:1f:00.0: BAR 8: failed to assign [mem size 0x0c180000]
[   82.078176] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   82.078973] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   82.079769] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2800]
[   82.080565] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2800]
[   82.081358] pci 0000:1f:00.0: BAR 8: no space for [mem size 0x0c180000]
[   82.082151] pci 0000:1f:00.0: BAR 8: failed to assign [mem size 0x0c180000]
[   82.082941] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x00400000 64bit pref]
[   82.083732] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]
[   82.084550] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2800]
[   82.085341] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2800]
[   82.086130] pci 0000:20:00.0: BAR 8: no space for [mem size 0x00100000]
[   82.086915] pci 0000:20:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.087698] pci 0000:20:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.088487] pci 0000:20:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.089271] pci 0000:20:01.0: BAR 8: no space for [mem size 0x00100000]
[   82.090057] pci 0000:20:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.090841] pci 0000:20:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.091626] pci 0000:20:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.092409] pci 0000:20:02.0: BAR 8: no space for [mem size 0x00100000]
[   82.093193] pci 0000:20:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.093977] pci 0000:20:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.094794] pci 0000:20:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.095580] pci 0000:20:04.0: BAR 8: no space for [mem size 0x05f40000]
[   82.096380] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x05f40000]
[   82.097159] pci 0000:20:04.0: BAR 9: no space for [mem size 0x00080000 64bit pref]
[   82.097937] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x00080000 64bit pref]
[   82.098716] pci 0000:20:05.0: BAR 8: no space for [mem size 0x05e80000]
[   82.099502] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x05e80000]
[   82.100284] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[   82.101068] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[   82.101851] pci 0000:20:00.0: BAR 7: no space for [io  size 0x1000]
[   82.102633] pci 0000:20:00.0: BAR 7: failed to assign [io  size 0x1000]
[   82.103415] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   82.104194] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   82.104990] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   82.105767] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   82.106527] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   82.107284] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   82.108037] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   82.108789] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   82.109548] pci 0000:20:00.0: BAR 8: no space for [mem size 0x00100000]
[   82.110305] pci 0000:20:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.111057] pci 0000:20:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.111815] pci 0000:20:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.112571] pci 0000:20:01.0: BAR 8: no space for [mem size 0x00100000]
[   82.113328] pci 0000:20:01.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.114083] pci 0000:20:01.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.114857] pci 0000:20:01.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.115620] pci 0000:20:02.0: BAR 8: no space for [mem size 0x00100000]
[   82.116388] pci 0000:20:02.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.117133] pci 0000:20:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.117883] pci 0000:20:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.118630] pci 0000:20:04.0: BAR 8: no space for [mem size 0x05f40000]
[   82.119386] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x05f40000]
[   82.120136] pci 0000:20:04.0: BAR 9: no space for [mem size 0x00080000 64bit pref]
[   82.120889] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x00080000 64bit pref]
[   82.121644] pci 0000:20:05.0: BAR 8: no space for [mem size 0x05e80000]
[   82.122398] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x05e80000]
[   82.123152] pci 0000:20:05.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.123909] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.124695] pci 0000:20:00.0: BAR 7: no space for [io  size 0x1000]
[   82.125466] pci 0000:20:00.0: BAR 7: failed to assign [io  size 0x1000]
[   82.126237] pci 0000:20:01.0: BAR 7: no space for [io  size 0x1000]
[   82.126989] pci 0000:20:01.0: BAR 7: failed to assign [io  size 0x1000]
[   82.127754] pci 0000:20:02.0: BAR 7: no space for [io  size 0x1000]
[   82.128519] pci 0000:20:02.0: BAR 7: failed to assign [io  size 0x1000]
[   82.129279] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[   82.130040] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[   82.130802] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[   82.131562] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[   82.132325] pci 0000:21:00.0: BAR 8: no space for [mem size 0x00100000]
[   82.133087] pci 0000:21:00.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.133848] pci 0000:21:00.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.134629] pci 0000:21:00.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.135406] pci 0000:21:00.0: BAR 7: no space for [io  size 0x1000]
[   82.136167] pci 0000:21:00.0: BAR 7: failed to assign [io  size 0x1000]
[   82.136914] pci 0000:22:03.0: BAR 8: no space for [mem size 0x00100000]
[   82.137674] pci 0000:22:03.0: BAR 8: failed to assign [mem size 0x00100000]
[   82.138430] pci 0000:22:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]
[   82.139188] pci 0000:22:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]
[   82.139943] pci 0000:22:03.0: BAR 7: no space for [io  size 0x1000]
[   82.140698] pci 0000:22:03.0: BAR 7: failed to assign [io  size 0x1000]
[   82.141450] pci 0000:23:00.0: BAR 0: no space for [mem size 0x00001000]
[   82.142203] pci 0000:23:00.0: BAR 0: failed to assign [mem size 0x00001000]
[   82.142957] pci 0000:23:00.1: BAR 0: no space for [mem size 0x00001000]
[   82.143711] pci 0000:23:00.1: BAR 0: failed to assign [mem size 0x00001000]
[   82.144483] pci 0000:23:00.2: BAR 0: no space for [mem size 0x00000100]
[   82.145234] pci 0000:23:00.2: BAR 0: failed to assign [mem size 0x00000100]
[   82.145996] pci 0000:22:03.0: PCI bridge to [bus 23]
[   82.146778] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[   82.147569] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[   82.148347] pci 0000:24:00.0: BAR 0: no space for [mem size 0x00010000 64bit pref]
[   82.149092] pci 0000:24:00.0: BAR 0: failed to assign [mem size 0x00010000 64bit pref]
[   82.149840] pci 0000:24:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
[   82.150588] pci 0000:24:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
[   82.151335] pci 0000:20:01.0: PCI bridge to [bus 24]
[   82.152122] pci 0000:25:00.0: BAR 0: no space for [mem size 0x00001000 64bit]
[   82.152875] pci 0000:25:00.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[   82.153626] pci 0000:20:02.0: PCI bridge to [bus 25]
[   82.154418] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[   82.155223] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[   82.156011] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[   82.156790] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[   82.157513] pci 0000:19:04.0:   bridge window [io  0x8000-0x8fff]
[   82.158272] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[   82.159007] pci 0000:19:05.0:   bridge window [io  0x9000-0x9fff]
[   82.159764] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[   82.160496] pci 0000:18:00.0:   bridge window [io  0x5000-0x9fff]
[   82.161247] pcieport 0000:06:04.0: PCI bridge to [bus 18-55]
[   82.161976] pcieport 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[   82.162744] pcieport 0000:18:00.0: enabling device (0000 -> 0001)
[   82.163806] pcieport 0000:19:00.0: enabling device (0000 -> 0001)
[   82.164932] pcieport 0000:19:01.0: enabling device (0000 -> 0001)
[   82.166017] pcieport 0000:19:02.0: enabling device (0000 -> 0001)
[   82.167074] pcieport 0000:19:04.0: enabling device (0000 -> 0001)
[   82.167887] pcieport 0000:19:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   82.168963] pcieport 0000:19:05.0: enabling device (0000 -> 0001)
[   82.169804] pcieport 0000:19:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   82.170932] pcieport 0000:1a:00.0: enabling device (0000 -> 0001)
[   82.171783] pcieport 0000:1b:03.0: enabling device (0000 -> 0001)
[   82.172658] pci 0000:1c:00.0: MSI is not implemented on this device, disabling it
[   82.173412] pci 0000:1c:00.0: PME# is unreliable, disabling it
[   82.174310] ohci-pci 0000:1c:00.0: init 0000:1c:00.0 fail, -16
[   82.175082] ohci-pci: probe of 0000:1c:00.0 failed with error -16
[   82.175855] pci 0000:1c:00.1: MSI is not implemented on this device, disabling it
[   82.176621] pci 0000:1c:00.1: PME# is unreliable, disabling it
[   82.177500] ohci-pci 0000:1c:00.1: init 0000:1c:00.1 fail, -16
[   82.178261] ohci-pci: probe of 0000:1c:00.1 failed with error -16
[   82.179033] pci 0000:1c:00.2: MSI is not implemented on this device, disabling it
[   82.179809] pci 0000:1c:00.2: PME# is unreliable, disabling it
[   82.181138] ehci-pci 0000:1c:00.2: init 0000:1c:00.2 fail, -16
[   82.181900] ehci-pci: probe of 0000:1c:00.2 failed with error -16
[   82.182729] tg3 0000:1d:00.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
[   82.183511] tg3 0000:1d:00.0: Cannot map device registers, aborting
[   82.184314] tg3: probe of 0000:1d:00.0 failed with error -12
[   82.185176] firewire_ohci 0000:1e:00.0: invalid MMIO resource
[   82.187928] pcieport 0000:20:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   82.189217] pcieport 0000:20:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   82.190682] pci 0000:23:00.0: MSI is not implemented on this device, disabling it
[   82.191482] pci 0000:23:00.0: PME# is unreliable, disabling it
[   82.192415] ohci-pci 0000:23:00.0: init 0000:23:00.0 fail, -16
[   82.193213] ohci-pci: probe of 0000:23:00.0 failed with error -16
[   82.194014] pci 0000:23:00.1: MSI is not implemented on this device, disabling it
[   82.194840] pci 0000:23:00.1: PME# is unreliable, disabling it
[   82.195801] ohci-pci 0000:23:00.1: init 0000:23:00.1 fail, -16
[   82.196609] ohci-pci: probe of 0000:23:00.1 failed with error -16
[   82.197412] pci 0000:23:00.2: MSI is not implemented on this device, disabling it
[   82.198221] pci 0000:23:00.2: PME# is unreliable, disabling it
[   82.199148] ehci-pci 0000:23:00.2: init 0000:23:00.2 fail, -16
[   82.199955] ehci-pci: probe of 0000:23:00.2 failed with error -16
[   82.200828] tg3 0000:24:00.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
[   82.201648] tg3 0000:24:00.0: Cannot map device registers, aborting
[   82.202487] tg3: probe of 0000:24:00.0 failed with error -12
[   82.203371] firewire_ohci 0000:25:00.0: invalid MMIO resource
[   82.284904] switching from power state:
[   82.285705] 	ui class: battery
[   82.286528] 	internal class: none
[   82.287331] 	caps:
[   82.288129] 	uvd    vclk: 0 dclk: 0
[   82.288928] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   82.289739] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   82.290549] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   82.291352] 	status: c r
[   82.292154] switching to power state:
[   82.292951] 	ui class: battery
[   82.293750] 	internal class: none
[   82.294559] 	caps:
[   82.295387] 	uvd    vclk: 0 dclk: 0
[   82.296189] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   82.296982] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   82.297769] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   82.298552] 	status: c r
[   82.608080] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
[   82.608983] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed
[   82.963620] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
[   82.964529] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed
[   89.850757] elogind-daemon[3134]: New session c2 of user brad.
[  285.363920] elogind-daemon[3134]: Removed session c2.
[  592.984761] elogind-daemon[3134]: New session c3 of user brad.
brad@bkmac:~$ 
