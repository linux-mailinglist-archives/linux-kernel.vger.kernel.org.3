Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477D84EE7DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbiDAFvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbiDAFu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:50:58 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C87F36B67
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:49:06 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1naA9e-0005Xj-GL; Fri, 01 Apr 2022 15:49:03 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6Avjcwh5xjeiGheFQklyjFXXQEST2Hk2glKDfGAmmOw=; b=iGn75uyLRYwt3Pfq/2rKHX9Cs6
        BCuA82KE6fd734DrXXW7x9pHqn+CYypUOMgqKok/WZ1PSxHf7OoHJeksBiwQrxXYR3LWwNz0F4K96
        40MRjdn9BGPCJdEC3Pv+HdAmxkDCXLPWe/W82ReWIVqViHv0VpeGs7hmM5yVxUF/XSuI=;
Message-ID: <5dcee6f7-cc8c-e3ce-920c-4ad3f5d77e14@fnarfbargle.com>
Date:   Fri, 1 Apr 2022 13:48:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-AU
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <YkLt+/kJ54fwCYgy@lahna>
 <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
 <YkMC4XnfIZix6kBn@lahna>
 <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
 <YkQuk7E8AbSEiw59@lahna>
 <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
 <YkRebADER3J9ooPM@lahna>
 <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
 <YkRtf2HiXBOWGjna@lahna>
 <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
 <YkXYdcUZ1E18ENle@lahna>
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YkXYdcUZ1E18ENle@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Mika,

On 1/4/22 00:36, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Mar 31, 2022 at 05:02:58PM +0800, Brad Campbell wrote:
>> On 30/3/22 22:47, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Wed, Mar 30, 2022 at 10:24:35PM +0800, Brad Campbell wrote:
>>>> Nope, that did the same thing. I wonder though. I'm testing it on the laptop and that reports :
>>>> [    0.442832] thunderbolt 0000:07:00.0:  Thunderbolt 2 Switch: 8086:156d (Revision: 0, TB Version: 2)
>>>>
>>>> Changing "if (in->sw->generation == 1)" to "if (in->sw->generation == 2)" on the laptop solves that.
>>>
>>> Heh, indeed I forgot that this is Falcon Ridge.
>>>
>>>> I can't test hotplug properly on the iMac due to the radeon training issue.
>>>>
>>>> The laptop still has the issue of a cold boot working in one socket
>>>> and not the other, but hot plug is working correctly.
>>>
>>> Let's try this one next:
>>>
>>> diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
>>> index a473cc7d9a8d..7150b5bc5403 100644
>>> --- a/drivers/thunderbolt/tunnel.c
>>> +++ b/drivers/thunderbolt/tunnel.c
>>> @@ -865,6 +865,8 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
>>>    	struct tb_tunnel *tunnel;
>>>    	struct tb_path **paths;
>>>    	struct tb_path *path;
>>> +	struct tb_port *port;
>>> +	int link_nr;
>>>    
>>
>> On the iMac, it cold boots on either port.
>>
>> On the Laptop it is the same as the previous in that it cold boots on
>> one port and not the other. Hotplug works in all cases I did try
>> (in->sw->generation < 3) just in case, but it didn't change anything
>> on the Laptop.
>>
>> Testing from here down is on the iMac.
>>
>> I've re-tested the original patch and aside from the thunderbolt
>> controller locking up, the radeon doesn't fail clock recovery.
>>
>> Further investigation on the iMac shows we don't see port 11. I added
>> a debug for discovered port.
>>
>> So my next thing is to try and figure out if there is a correlation between which link is paired with which DP source.
>>
>> I've changed link_nr = in->port == 11 ? 1 : 0; to 12 ? 1 : 0; and that boots, but hotplug still fails if the EFI sets up a display first. I've also tried reversing the 1 : 0, but that fails out of the gate.
>>
>> I've just done a test now by booting with the chain disconnected, then
>> plugging it in just before the bootloader loads which prevents the EFI
>> from getting involved.
>>
>> This works (wait until just before bootloader to plug the chain):
>>
>> brad@bkmac:~$ dmesg | egrep '(Tunnel|in->|in use|DP .* available)'
>> [    1.618277] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
>> [    1.618280] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
>> [    1.618403] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
>> [    1.618529] thunderbolt 0000:07:00.0: 0:c: DP IN available
>> [    1.618656] thunderbolt 0000:07:00.0: 303:b: DP OUT available
>> [    1.618916] thunderbolt 0000:07:00.0: in->port 12
>> [    1.618920] thunderbolt 0000:07:00.0: Tunnel 1
>> [    1.622751] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
>> [    1.622880] thunderbolt 0000:07:00.0: 0:c: in use
>> [    1.623007] thunderbolt 0000:07:00.0: 0:d: DP IN available
>> [    1.623135] thunderbolt 0000:07:00.0: 303:b: in use
>> [    1.623263] thunderbolt 0000:07:00.0: 3:b: DP OUT available
>> [    1.623399] thunderbolt 0000:07:00.0: in->port 13
>> [    1.623402] thunderbolt 0000:07:00.0: Tunnel 0
>>
>> Both displays are working at this point.
>> Unplug -> Replug
>> [   45.799923] thunderbolt 0000:07:00.0: 0:c: DP IN available
>> [   45.800051] thunderbolt 0000:07:00.0: 0:d: DP IN available
>> [   45.800053] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
>> [   54.606243] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
>> [   54.606371] thunderbolt 0000:07:00.0: 0:c: DP IN available
>> [   54.606497] thunderbolt 0000:07:00.0: 303:b: DP OUT available
>> [   54.606763] thunderbolt 0000:07:00.0: in->port 12
>> [   54.606768] thunderbolt 0000:07:00.0: Tunnel 1
>> [   54.615067] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
>> [   54.615176] thunderbolt 0000:07:00.0: 0:c: in use
>> [   54.615309] thunderbolt 0000:07:00.0: 0:d: DP IN available
>> [   54.615434] thunderbolt 0000:07:00.0: 303:b: in use
>> [   54.615561] thunderbolt 0000:07:00.0: 3:b: DP OUT available
>> [   54.615692] thunderbolt 0000:07:00.0: in->port 13
>> [   54.615694] thunderbolt 0000:07:00.0: Tunnel 0
>>
>> Both displays are working
>>
>> This doesn't (standard cold boot):
>>
>> brad@bkmac:~$ dmesg | egrep '(Tunnel|in->|in use|DP .* available)'
>> [    1.611396] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
>> [    1.611399] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
>> [    1.611521] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
>> [    1.611648] thunderbolt 0000:07:00.0: 0:c: in use
>> [    1.611777] thunderbolt 0000:07:00.0: 0:d: DP IN available
>> [    1.611904] thunderbolt 0000:07:00.0: 303:b: DP OUT available
>> [    1.612162] thunderbolt 0000:07:00.0: in->port 13
>> [    1.612166] thunderbolt 0000:07:00.0: Tunnel 0
>>
>> Both displays are working at this point.
>> Unplug -> Replug
>> [   72.181366] thunderbolt 0000:07:00.0: 0:c: DP IN available
>> [   72.181487] thunderbolt 0000:07:00.0: 0:d: DP IN available
>> [   72.181489] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
>> [   81.369074] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
>> [   81.369207] thunderbolt 0000:07:00.0: 0:c: DP IN available
>> [   81.369335] thunderbolt 0000:07:00.0: 3:b: DP OUT available
>> [   81.369468] thunderbolt 0000:07:00.0: in->port 12
>> [   81.369471] thunderbolt 0000:07:00.0: Tunnel 1
>> [   81.376542] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
>> [   81.376669] thunderbolt 0000:07:00.0: 0:c: in use
>> [   81.376797] thunderbolt 0000:07:00.0: 0:d: DP IN available
>> [   81.376925] thunderbolt 0000:07:00.0: 3:b: in use
>> [   81.377058] thunderbolt 0000:07:00.0: 303:b: DP OUT available
>> [   81.377320] thunderbolt 0000:07:00.0: in->port 13
>> [   81.377328] thunderbolt 0000:07:00.0: Tunnel 0
>>
>> First display in the chain fails clock recovery.
> 
> Okay, thanks for testing. I think at this point we need to look a what
> the Apple boot firmware actually configures for these paths. Can you
> drop my previous patch and apply the below? Then on both problematic
> systems boot up with the monitors connected and then send me dmesg.
> 
> If possible do this so that you have the chain connected to each port on
> the system. I'm hoping we find some pattern here ;-)
> 
> diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
> index 299712accfe9..ee03fd75a472 100644
> --- a/drivers/thunderbolt/path.c
> +++ b/drivers/thunderbolt/path.c
> @@ -166,6 +166,9 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
>   		return NULL;
>   	}
>   
> +	tb_dbg(path->tb, "discovering %s path starting from %llx:%u\n",
> +	       path->name, tb_route(src->sw), src->port);
> +
>   	p = src;
>   	h = src_hopid;
>   
> @@ -198,10 +201,13 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
>   		path->hops[i].out_port = out_port;
>   		path->hops[i].next_hop_index = next_hop;
>   
> +		tb_dump_hop(&path->hops[i], &hop);
> +
>   		h = next_hop;
>   		p = out_port->remote;
>   	}
>   
> +	tb_dbg(path->tb, "path discovery complete\n");
>   	return path;
>   
>   err:
> 

That I can do. I didn't crop or grep as I wasn't sure what might be additionally relevant.
2 machines, 2 ports, 4 cold boots. Each time just the Thnuderbolt displays chained.


MacBookPro - Front port :
[    0.000000] Linux version 5.17.0+ (brad@bklaptop) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #45 SMP PREEMPT_DYNAMIC Fri Apr 1 13:30:02 AWST 2022
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
[    0.000000] e820: update [mem 0x73d4c190-0x73d5c1cf] usable ==> usable
[    0.000000] e820: update [mem 0x73d4c190-0x73d5c1cf] usable ==> usable
[    0.000000] e820: update [mem 0x73d6f190-0x73d6fd98] usable ==> usable
[    0.000000] e820: update [mem 0x73d6f190-0x73d6fd98] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000008efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000073d4c18f] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d4c190-0x0000000073d5c1cf] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d5c1d0-0x0000000073d6f18f] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d6f190-0x0000000073d6fd98] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d6fd99-0x000000008ad0ffff] usable
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
[    0.000000] tsc: Detected 2599.997 MHz processor
[    0.000116] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000119] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000127] last_pfn = 0x46f600 max_arch_pfn = 0x400000000
[    0.000214] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001095] last_pfn = 0x8b000 max_arch_pfn = 0x400000000
[    0.001143] Using GB pages for direct mapping
[    0.001748] Secure boot disabled
[    0.001749] RAMDISK: [mem 0x7076e000-0x70e90fff]
[    0.001752] ACPI: Early table checksum verification disabled
[    0.001755] ACPI: RSDP 0x000000008AD8E014 000024 (v02 APPLE )
[    0.001759] ACPI: XSDT 0x000000008AD8E1C0 0000A4 (v01 APPLE  Apple00  00000000      01000013)
[    0.001764] ACPI: FACP 0x000000008AD8C000 0000F4 (v05 APPLE  Apple00  00000000 Loki 0000005F)
[    0.001769] ACPI: DSDT 0x000000008AD7F000 007681 (v03 APPLE  MacBookP 00110001 INTL 20100915)
[    0.001773] ACPI: FACS 0x000000008AD18000 000040
[    0.001775] ACPI: FACS 0x000000008AD18000 000040
[    0.001778] ACPI: HPET 0x000000008AD8B000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.001781] ACPI: APIC 0x000000008AD8A000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.001784] ACPI: SBST 0x000000008AD88000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.001786] ACPI: ECDT 0x000000008AD87000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.001789] ACPI: SSDT 0x000000008AD7E000 00010B (v01 APPLE  SataAhci 00001000 INTL 20100915)
[    0.001792] ACPI: SSDT 0x000000008AD7D000 000024 (v01 APPLE  SmcDppt  00001000 INTL 20100915)
[    0.001795] ACPI: SSDT 0x000000008AD7A000 000FE9 (v01 APPLE  SDUsbLpt 00001000 INTL 20100915)
[    0.001798] ACPI: SSDT 0x000000008AD76000 000032 (v01 APPLE  SsdtS3   00001000 INTL 20100915)
[    0.001801] ACPI: SSDT 0x000000008AD73000 0028B2 (v01 APPLE  PcieTbt  00001000 INTL 20100915)
[    0.001804] ACPI: SSDT 0x000000008AD66000 0000B8 (v01 APPLE  Sdxc     00001000 INTL 20100915)
[    0.001807] ACPI: SSDT 0x000000008AD65000 0003E0 (v01 APPLE  SaHdaCdc 00001000 INTL 20100915)
[    0.001810] ACPI: SSDT 0x000000008AD64000 000594 (v01 PmRef  Cpu0Ist  00003000 INTL 20100915)
[    0.001813] ACPI: SSDT 0x000000008AD63000 000B83 (v01 PmRef  CpuPm    00003000 INTL 20100915)
[    0.001817] ACPI: DMAR 0x000000008AD62000 000088 (v01 APPLE  HSW      00000001 AAPL 00000001)
[    0.001820] ACPI: MCFG 0x000000008AD89000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.001822] ACPI: Reserving FACP table memory at [mem 0x8ad8c000-0x8ad8c0f3]
[    0.001824] ACPI: Reserving DSDT table memory at [mem 0x8ad7f000-0x8ad86680]
[    0.001825] ACPI: Reserving FACS table memory at [mem 0x8ad18000-0x8ad1803f]
[    0.001827] ACPI: Reserving FACS table memory at [mem 0x8ad18000-0x8ad1803f]
[    0.001828] ACPI: Reserving HPET table memory at [mem 0x8ad8b000-0x8ad8b037]
[    0.001829] ACPI: Reserving APIC table memory at [mem 0x8ad8a000-0x8ad8a0bb]
[    0.001830] ACPI: Reserving SBST table memory at [mem 0x8ad88000-0x8ad8802f]
[    0.001831] ACPI: Reserving ECDT table memory at [mem 0x8ad87000-0x8ad87052]
[    0.001832] ACPI: Reserving SSDT table memory at [mem 0x8ad7e000-0x8ad7e10a]
[    0.001834] ACPI: Reserving SSDT table memory at [mem 0x8ad7d000-0x8ad7d023]
[    0.001835] ACPI: Reserving SSDT table memory at [mem 0x8ad7a000-0x8ad7afe8]
[    0.001836] ACPI: Reserving SSDT table memory at [mem 0x8ad76000-0x8ad76031]
[    0.001837] ACPI: Reserving SSDT table memory at [mem 0x8ad73000-0x8ad758b1]
[    0.001838] ACPI: Reserving SSDT table memory at [mem 0x8ad66000-0x8ad660b7]
[    0.001839] ACPI: Reserving SSDT table memory at [mem 0x8ad65000-0x8ad653df]
[    0.001841] ACPI: Reserving SSDT table memory at [mem 0x8ad64000-0x8ad64593]
[    0.001842] ACPI: Reserving SSDT table memory at [mem 0x8ad63000-0x8ad63b82]
[    0.001843] ACPI: Reserving DMAR table memory at [mem 0x8ad62000-0x8ad62087]
[    0.001844] ACPI: Reserving MCFG table memory at [mem 0x8ad89000-0x8ad8903b]
[    0.001851] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.001872] Zone ranges:
[    0.001872]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.001875]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.001876]   Normal   [mem 0x0000000100000000-0x000000046f5fffff]
[    0.001878] Movable zone start for each node
[    0.001879] Early memory node ranges
[    0.001880]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.001881]   node   0: [mem 0x0000000000059000-0x000000000008efff]
[    0.001883]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.001884]   node   0: [mem 0x0000000000100000-0x000000008ad0ffff]
[    0.001885]   node   0: [mem 0x000000008ad53000-0x000000008ad61fff]
[    0.001886]   node   0: [mem 0x000000008ad8f000-0x000000008ae38fff]
[    0.001887]   node   0: [mem 0x000000008ae8f000-0x000000008aed1fff]
[    0.001888]   node   0: [mem 0x000000008aeff000-0x000000008af83fff]
[    0.001889]   node   0: [mem 0x000000008aff0000-0x000000008affffff]
[    0.001890]   node   0: [mem 0x0000000100000000-0x000000046f5fffff]
[    0.001892] Initmem setup node 0 [mem 0x0000000000001000-0x000000046f5fffff]
[    0.001896] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.001898] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.001899] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.001924] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.005692] On node 0, zone DMA32: 67 pages in unavailable ranges
[    0.005697] On node 0, zone DMA32: 45 pages in unavailable ranges
[    0.005700] On node 0, zone DMA32: 86 pages in unavailable ranges
[    0.005702] On node 0, zone DMA32: 45 pages in unavailable ranges
[    0.005704] On node 0, zone DMA32: 108 pages in unavailable ranges
[    0.029854] On node 0, zone Normal: 20480 pages in unavailable ranges
[    0.029882] On node 0, zone Normal: 2560 pages in unavailable ranges
[    0.029890] Reserving Intel graphics memory at [mem 0x8ba00000-0x8f9fffff]
[    0.030010] ACPI: PM-Timer IO Port: 0x1808
[    0.030017] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.030019] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.030020] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.030021] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.030022] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.030023] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.030024] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.030025] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.030035] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-39
[    0.030038] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.030040] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.030044] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.030045] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.030048] TSC deadline timer available
[    0.030050] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.030070] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.030073] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.030075] PM: hibernation: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.030078] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
[    0.030079] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.030081] PM: hibernation: Registered nosave memory: [mem 0x73d4c000-0x73d4cfff]
[    0.030083] PM: hibernation: Registered nosave memory: [mem 0x73d5c000-0x73d5cfff]
[    0.030085] PM: hibernation: Registered nosave memory: [mem 0x73d6f000-0x73d6ffff]
[    0.030087] PM: hibernation: Registered nosave memory: [mem 0x73d6f000-0x73d6ffff]
[    0.030089] PM: hibernation: Registered nosave memory: [mem 0x8ad10000-0x8ad52fff]
[    0.030091] PM: hibernation: Registered nosave memory: [mem 0x8ad62000-0x8ad8efff]
[    0.030093] PM: hibernation: Registered nosave memory: [mem 0x8ae39000-0x8ae8efff]
[    0.030096] PM: hibernation: Registered nosave memory: [mem 0x8aed2000-0x8aefefff]
[    0.030098] PM: hibernation: Registered nosave memory: [mem 0x8af84000-0x8afeffff]
[    0.030100] PM: hibernation: Registered nosave memory: [mem 0x8b000000-0x8f9fffff]
[    0.030101] PM: hibernation: Registered nosave memory: [mem 0x8fa00000-0xe00f7fff]
[    0.030102] PM: hibernation: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.030103] PM: hibernation: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff]
[    0.030104] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.030105] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xffe0ffff]
[    0.030106] PM: hibernation: Registered nosave memory: [mem 0xffe10000-0xffe3ffff]
[    0.030107] PM: hibernation: Registered nosave memory: [mem 0xffe40000-0xffffffff]
[    0.030109] [mem 0x8fa00000-0xe00f7fff] available for PCI devices
[    0.030113] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.030119] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.030300] percpu: Embedded 52 pages/cpu s173096 r8192 d31704 u524288
[    0.030309] pcpu-alloc: s173096 r8192 d31704 u524288 alloc=1*2097152
[    0.030311] pcpu-alloc: [0] 0 1 2 3
[    0.030333] Built 1 zonelists, mobility grouping on.  Total pages: 4105486
[    0.030335] Kernel command line: ro root=UUID=c500d66c-50ec-42a2-a333-eb48d6c9d97b thunderbolt.dyndbg initrd=boot\initrd.img-5.17.0+
[    0.031200] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.031615] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.031655] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.079682] Memory: 15923600K/16683256K available (10248K kernel code, 2251K rwdata, 2740K rodata, 996K init, 740K bss, 759396K reserved, 0K cma-reserved)
[    0.079713] random: get_random_u64 called from cache_random_seq_create+0x63/0x150 with crng_init=0
[    0.079780] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.080413] Dynamic Preempt: voluntary
[    0.080438] rcu: Preemptible hierarchical RCU implementation.
[    0.080440] 	Trampoline variant of Tasks RCU enabled.
[    0.080441] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.081406] NR_IRQS: 4352, nr_irqs: 728, preallocated irqs: 16
[    0.081630] Console: colour dummy device 80x25
[    0.081958] printk: console [tty0] enabled
[    0.081968] ACPI: Core revision 20211217
[    0.082065] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.082068] APIC: Switch to symmetric I/O mode setup
[    0.082071] DMAR: Host address width 39
[    0.082073] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.082080] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020660462 ecap f0101a
[    0.082084] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.082090] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008020660462 ecap f010da
[    0.082093] DMAR: RMRR base: 0x0000008b800000 end: 0x0000008f9fffff
[    0.082097] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.082100] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.082698] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.083185] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x257a391c223, max_idle_ns: 440795220104 ns
[    0.083195] Calibrating delay loop (skipped), value calculated using timer frequency.. 5199.99 BogoMIPS (lpj=25999970)
[    0.083200] pid_max: default: 32768 minimum: 301
[    0.093191] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.093191] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.093191] CPU0: Thermal monitoring enabled (TM1)
[    0.093191] process: using mwait in idle threads
[    0.093191] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.093191] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.093191] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.093191] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.093191] Spectre V2 : Vulnerable
[    0.093191] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.093191] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.093191] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.093191] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.093191] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.093191] SRBDS: Mitigation: Microcode
[    0.093191] MDS: Mitigation: Clear CPU buffers
[    0.093191] Freeing SMP alternatives memory: 28K
[    0.093191] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1220
[    0.093191] smpboot: CPU0: Intel(R) Core(TM) i5-4278U CPU @ 2.60GHz (family: 0x6, model: 0x45, stepping: 0x1)
[    0.093191] cblist_init_generic: Setting adjustable number of callback queues.
[    0.093191] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.093191] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.093191] ... version:                3
[    0.093191] ... bit width:              48
[    0.093191] ... generic registers:      4
[    0.093191] ... value mask:             0000ffffffffffff
[    0.093191] ... max period:             00007fffffffffff
[    0.093191] ... fixed-purpose events:   3
[    0.093191] ... event mask:             000000070000000f
[    0.093191] rcu: Hierarchical SRCU implementation.
[    0.093191] smp: Bringing up secondary CPUs ...
[    0.093191] x86: Booting SMP configuration:
[    0.093191] .... node  #0, CPUs:      #1 #2
[    0.093191] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.093191]  #3
[    0.093191] smp: Brought up 1 node, 4 CPUs
[    0.093191] smpboot: Max logical packages: 1
[    0.093191] smpboot: Total of 4 processors activated (20799.97 BogoMIPS)
[    0.093191] devtmpfs: initialized
[    0.093191] ACPI: PM: Registering ACPI NVS region [mem 0x8ad10000-0x8ad52fff] (274432 bytes)
[    0.093191] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.093191] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.093191] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.093191] thermal_sys: Registered thermal governor 'step_wise'
[    0.093191] thermal_sys: Registered thermal governor 'user_space'
[    0.093191] cpuidle: using governor ladder
[    0.093191] cpuidle: using governor menu
[    0.093191] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.093191] PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem 0xe0000000-0xe9bfffff] (base 0xe0000000)
[    0.093191] PCI: not using MMCONFIG
[    0.093191] PCI: Using configuration type 1 for base access
[    0.093191] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.093191] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.093191] cryptd: max_cpu_qlen set to 1000
[    0.093191] ACPI: Disabled all _OSI OS vendors
[    0.093191] ACPI: Added _OSI(Module Device)
[    0.093191] ACPI: Added _OSI(Processor Device)
[    0.093191] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.093191] ACPI: Added _OSI(Processor Aggregator Device)
[    0.093191] ACPI: Added _OSI(Linux-Dell-Video)
[    0.093191] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.093191] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.093191] ACPI: Added _OSI(Darwin)
[    0.094987] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.095354] ACPI: EC: EC started
[    0.095356] ACPI: EC: interrupt blocked
[    0.096435] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.096439] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.096622] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.096936] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.096973] ACPI Error: Needed type [Reference], found [Integer] 0000000035db64a3 (20211217/exresop-69)
[    0.096973] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20211217/dswexec-434)
[    0.096973] ACPI Error: Aborting method \_PR.CPU0._PDC due to previous error (AE_AML_OPERAND_TYPE) (20211217/psparse-531)
[    0.096973] ACPI: Dynamic OEM Table Load:
[    0.096973] ACPI: SSDT 0xFFFFA0DE40AF7800 00067C (v01 PmRef  ApIst    00003000 INTL 20100915)
[    0.096973] ACPI: Dynamic OEM Table Load:
[    0.096973] ACPI: SSDT 0xFFFFA0DE40C8F600 000119 (v01 PmRef  ApCst    00003000 INTL 20100915)
[    0.096973] ACPI: Interpreter enabled
[    0.096973] ACPI: PM: (supports S0 S3 S4 S5)
[    0.096973] ACPI: Using IOAPIC for interrupt routing
[    0.096973] PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem 0xe0000000-0xe9bfffff] (base 0xe0000000)
[    0.096973] PCI: MMCONFIG at [mem 0xe0000000-0xe9bfffff] reserved in ACPI motherboard resources
[    0.096973] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.096973] ACPI: Enabled 4 GPEs in block 00 to 7F
[    0.106802] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.106809] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.106815] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-9b] only partially covers this bridge
[    0.106971] PCI host bridge to bus 0000:00
[    0.106975] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.106978] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.106981] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.106984] pci_bus 0000:00: root bus resource [mem 0x8fa00000-0xfeafffff window]
[    0.106987] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.106990] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.107001] pci 0000:00:00.0: [8086:0a04] type 00 class 0x060000
[    0.107079] pci 0000:00:02.0: [8086:0a2e] type 00 class 0x030000
[    0.107089] pci 0000:00:02.0: reg 0x10: [mem 0xb0000000-0xb03fffff 64bit]
[    0.107096] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xafffffff 64bit pref]
[    0.107101] pci 0000:00:02.0: reg 0x20: [io  0x2000-0x203f]
[    0.107113] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.107117] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.107206] pci 0000:00:03.0: [8086:0a0c] type 00 class 0x040300
[    0.107215] pci 0000:00:03.0: reg 0x10: [mem 0xb0c10000-0xb0c13fff 64bit]
[    0.107330] pci 0000:00:14.0: [8086:9c31] type 00 class 0x0c0330
[    0.107346] pci 0000:00:14.0: reg 0x10: [mem 0xb0c00000-0xb0c0ffff 64bit]
[    0.107396] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.107578] pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
[    0.107597] pci 0000:00:16.0: reg 0x10: [mem 0xb0c2a100-0xb0c2a11f 64bit]
[    0.107657] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.107709] pci 0000:00:1b.0: [8086:9c20] type 00 class 0x040300
[    0.107724] pci 0000:00:1b.0: reg 0x10: [mem 0xb0c14000-0xb0c17fff 64bit]
[    0.107785] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.107843] pci 0000:00:1c.0: [8086:9c10] type 01 class 0x060400
[    0.107902] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.107919] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    0.107922] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    0.108013] pci 0000:00:1c.1: [8086:9c12] type 01 class 0x060400
[    0.108079] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.108096] pci 0000:00:1c.1: Enabling MPC IRBNCE
[    0.108098] pci 0000:00:1c.1: Intel PCH root port ACS workaround enabled
[    0.108189] pci 0000:00:1c.2: [8086:9c14] type 01 class 0x060400
[    0.108255] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.108271] pci 0000:00:1c.2: Enabling MPC IRBNCE
[    0.108274] pci 0000:00:1c.2: Intel PCH root port ACS workaround enabled
[    0.108361] pci 0000:00:1c.4: [8086:9c18] type 01 class 0x060400
[    0.108427] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.108443] pci 0000:00:1c.4: Enabling MPC IRBNCE
[    0.108446] pci 0000:00:1c.4: Intel PCH root port ACS workaround enabled
[    0.108540] pci 0000:00:1c.5: [8086:9c1a] type 01 class 0x060400
[    0.108606] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.108622] pci 0000:00:1c.5: Enabling MPC IRBNCE
[    0.108625] pci 0000:00:1c.5: Intel PCH root port ACS workaround enabled
[    0.108718] pci 0000:00:1f.0: [8086:9c43] type 00 class 0x060100
[    0.108867] pci 0000:00:1f.3: [8086:9c22] type 00 class 0x0c0500
[    0.108882] pci 0000:00:1f.3: reg 0x10: [mem 0xb0c2a000-0xb0c2a0ff 64bit]
[    0.108901] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.108983] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.109043] pci 0000:02:00.0: [14e4:1570] type 00 class 0x048000
[    0.109066] pci 0000:02:00.0: reg 0x10: [mem 0xb0b00000-0xb0b0ffff 64bit]
[    0.109082] pci 0000:02:00.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.109098] pci 0000:02:00.0: reg 0x20: [mem 0xb0a00000-0xb0afffff 64bit]
[    0.109191] pci 0000:02:00.0: supports D1
[    0.109194] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.109297] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.109302] pci 0000:00:1c.1:   bridge window [mem 0xb0a00000-0xb0bfffff]
[    0.109308] pci 0000:00:1c.1:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.109366] pci 0000:03:00.0: [14e4:43ba] type 00 class 0x028000
[    0.109389] pci 0000:03:00.0: reg 0x10: [mem 0xb0800000-0xb0807fff 64bit]
[    0.109404] pci 0000:03:00.0: reg 0x18: [mem 0xb0400000-0xb07fffff 64bit]
[    0.109525] pci 0000:03:00.0: supports D1 D2
[    0.109527] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.109668] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.109674] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb08fffff]
[    0.109738] pci 0000:05:00.0: [8086:156d] type 01 class 0x060400
[    0.109792] pci 0000:05:00.0: enabling Extended Tags
[    0.109874] pci 0000:05:00.0: supports D1 D2
[    0.109876] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.133220] pci 0000:00:1c.4: PCI bridge to [bus 05-6b]
[    0.133226] pci 0000:00:1c.4:   bridge window [io  0x3000-0x5fff]
[    0.133230] pci 0000:00:1c.4:   bridge window [mem 0xb0d00000-0xbd1fffff]
[    0.133235] pci 0000:00:1c.4:   bridge window [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.133339] pci 0000:06:00.0: [8086:156d] type 01 class 0x060400
[    0.133397] pci 0000:06:00.0: enabling Extended Tags
[    0.133481] pci 0000:06:00.0: supports D1 D2
[    0.133483] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.133594] pci 0000:06:03.0: [8086:156d] type 01 class 0x060400
[    0.133651] pci 0000:06:03.0: enabling Extended Tags
[    0.133734] pci 0000:06:03.0: supports D1 D2
[    0.133736] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.133844] pci 0000:06:04.0: [8086:156d] type 01 class 0x060400
[    0.133894] pci 0000:06:04.0: enabling Extended Tags
[    0.133981] pci 0000:06:04.0: supports D1 D2
[    0.133983] pci 0000:06:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134086] pci 0000:06:05.0: [8086:156d] type 01 class 0x060400
[    0.134136] pci 0000:06:05.0: enabling Extended Tags
[    0.134222] pci 0000:06:05.0: supports D1 D2
[    0.134224] pci 0000:06:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134328] pci 0000:06:06.0: [8086:156d] type 01 class 0x060400
[    0.134377] pci 0000:06:06.0: enabling Extended Tags
[    0.134463] pci 0000:06:06.0: supports D1 D2
[    0.134465] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134575] pci 0000:05:00.0: PCI bridge to [bus 06-6b]
[    0.134582] pci 0000:05:00.0:   bridge window [io  0x3000-0x4fff]
[    0.134587] pci 0000:05:00.0:   bridge window [mem 0xb0d00000-0xb91fffff]
[    0.134594] pci 0000:05:00.0:   bridge window [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.134671] pci 0000:07:00.0: [8086:156c] type 00 class 0x088000
[    0.134694] pci 0000:07:00.0: reg 0x10: [mem 0xb0d00000-0xb0d3ffff]
[    0.134708] pci 0000:07:00.0: reg 0x14: [mem 0xb0d40000-0xb0d40fff]
[    0.134774] pci 0000:07:00.0: enabling Extended Tags
[    0.134886] pci 0000:07:00.0: supports D1 D2
[    0.134888] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.163228] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.163240] pci 0000:06:00.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[    0.163358] pci 0000:08:00.0: [8086:1513] type 01 class 0x060400
[    0.163462] pci 0000:08:00.0: enabling Extended Tags
[    0.163616] pci 0000:08:00.0: supports D1 D2
[    0.163619] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.193227] pci 0000:06:03.0: PCI bridge to [bus 08-38]
[    0.193236] pci 0000:06:03.0:   bridge window [io  0x3000-0x3fff]
[    0.193241] pci 0000:06:03.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[    0.193248] pci 0000:06:03.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.193339] acpiphp: Slot [1] registered
[    0.193363] acpiphp: Slot [2] registered
[    0.193387] acpiphp: Slot [3] registered
[    0.193410] acpiphp: Slot [4] registered
[    0.193433] acpiphp: Slot [5] registered
[    0.193488] pci 0000:09:00.0: [8086:1513] type 01 class 0x060400
[    0.193597] pci 0000:09:00.0: enabling Extended Tags
[    0.193756] pci 0000:09:00.0: supports D1 D2
[    0.193758] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.193930] pci 0000:09:01.0: [8086:1513] type 01 class 0x060400
[    0.194039] pci 0000:09:01.0: enabling Extended Tags
[    0.194197] pci 0000:09:01.0: supports D1 D2
[    0.194199] pci 0000:09:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.194353] pci 0000:09:02.0: [8086:1513] type 01 class 0x060400
[    0.194462] pci 0000:09:02.0: enabling Extended Tags
[    0.194620] pci 0000:09:02.0: supports D1 D2
[    0.194622] pci 0000:09:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.194781] pci 0000:09:04.0: [8086:1513] type 01 class 0x060400
[    0.194890] pci 0000:09:04.0: enabling Extended Tags
[    0.195050] pci 0000:09:04.0: supports D1 D2
[    0.195052] pci 0000:09:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.195225] pci 0000:09:05.0: [8086:1513] type 01 class 0x060400
[    0.195320] pci 0000:09:05.0: enabling Extended Tags
[    0.195480] pci 0000:09:05.0: supports D1 D2
[    0.195482] pci 0000:09:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.195670] pci 0000:08:00.0: PCI bridge to [bus 09-18]
[    0.195688] pci 0000:08:00.0:   bridge window [mem 0xb0e00000-0xb11fffff]
[    0.195700] pci 0000:08:00.0:   bridge window [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.195792] acpiphp: Slot [1-1] registered
[    0.195850] pci 0000:0a:00.0: [12d8:400c] type 01 class 0x060400
[    0.196205] pci 0000:0a:00.0: supports D1 D2
[    0.196207] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.223234] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[    0.223252] pci 0000:09:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.223425] pci 0000:0b:03.0: [12d8:400c] type 01 class 0x060400
[    0.223734] pci 0000:0b:03.0: supports D1 D2
[    0.223736] pci 0000:0b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.223930] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[    0.223953] pci 0000:0a:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.224110] pci 0000:0c:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.224158] pci 0000:0c:00.0: reg 0x10: [mem 0xb1101000-0xb1101fff]
[    0.224446] pci 0000:0c:00.0: supports D1 D2
[    0.224448] pci 0000:0c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.224597] pci 0000:0c:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.224644] pci 0000:0c:00.1: reg 0x10: [mem 0xb1100000-0xb1100fff]
[    0.224932] pci 0000:0c:00.1: supports D1 D2
[    0.224934] pci 0000:0c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.225059] pci 0000:0c:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.225106] pci 0000:0c:00.2: reg 0x10: [mem 0xb1102000-0xb11020ff]
[    0.225393] pci 0000:0c:00.2: supports D1 D2
[    0.225395] pci 0000:0c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.225635] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[    0.225658] pci 0000:0b:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.225820] pci 0000:0d:00.0: [14e4:16b0] type 00 class 0x020000
[    0.225883] pci 0000:0d:00.0: reg 0x10: [mem 0xbd300000-0xbd30ffff 64bit pref]
[    0.225926] pci 0000:0d:00.0: reg 0x18: [mem 0xbd310000-0xbd31ffff 64bit pref]
[    0.226236] pci 0000:0d:00.0: PME# supported from D0 D3hot D3cold
[    0.253249] pci 0000:09:01.0: PCI bridge to [bus 0d]
[    0.253277] pci 0000:09:01.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.253388] pci 0000:0e:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.253452] pci 0000:0e:00.0: reg 0x10: [mem 0xb1000000-0xb1000fff 64bit]
[    0.253777] pci 0000:0e:00.0: supports D1 D2
[    0.253779] pci 0000:0e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.283249] pci 0000:09:02.0: PCI bridge to [bus 0e]
[    0.283266] pci 0000:09:02.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.283441] pci 0000:0f:00.0: [8086:1513] type 01 class 0x060400
[    0.283599] pci 0000:0f:00.0: enabling Extended Tags
[    0.283835] pci 0000:0f:00.0: supports D1 D2
[    0.283837] pci 0000:0f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.313239] pci 0000:09:04.0: PCI bridge to [bus 0f-17]
[    0.313257] pci 0000:09:04.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.313270] pci 0000:09:04.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.313392] acpiphp: Slot [1-2] registered
[    0.313418] acpiphp: Slot [2-1] registered
[    0.313444] acpiphp: Slot [3-1] registered
[    0.313469] acpiphp: Slot [4-1] registered
[    0.313551] pci 0000:10:00.0: [8086:1513] type 01 class 0x060400
[    0.313716] pci 0000:10:00.0: enabling Extended Tags
[    0.313956] pci 0000:10:00.0: supports D1 D2
[    0.313959] pci 0000:10:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.314200] pci 0000:10:01.0: [8086:1513] type 01 class 0x060400
[    0.314365] pci 0000:10:01.0: enabling Extended Tags
[    0.314605] pci 0000:10:01.0: supports D1 D2
[    0.314607] pci 0000:10:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.314831] pci 0000:10:02.0: [8086:1513] type 01 class 0x060400
[    0.314995] pci 0000:10:02.0: enabling Extended Tags
[    0.315235] pci 0000:10:02.0: supports D1 D2
[    0.315237] pci 0000:10:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.315467] pci 0000:10:04.0: [8086:1513] type 01 class 0x060400
[    0.315608] pci 0000:10:04.0: enabling Extended Tags
[    0.315851] pci 0000:10:04.0: supports D1 D2
[    0.315853] pci 0000:10:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.316098] pci 0000:10:05.0: [8086:1513] type 01 class 0x060400
[    0.316240] pci 0000:10:05.0: enabling Extended Tags
[    0.316483] pci 0000:10:05.0: supports D1 D2
[    0.316485] pci 0000:10:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.316757] pci 0000:0f:00.0: PCI bridge to [bus 10-17]
[    0.316782] pci 0000:0f:00.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.316800] pci 0000:0f:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.316917] acpiphp: Slot [1-3] registered
[    0.316995] pci 0000:11:00.0: [12d8:400c] type 01 class 0x060400
[    0.317482] pci 0000:11:00.0: supports D1 D2
[    0.317484] pci 0000:11:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.317767] pci 0000:10:00.0: PCI bridge to [bus 11-13]
[    0.317792] pci 0000:10:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.318026] pci 0000:12:03.0: [12d8:400c] type 01 class 0x060400
[    0.318447] pci 0000:12:03.0: supports D1 D2
[    0.318449] pci 0000:12:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.318704] pci 0000:11:00.0: PCI bridge to [bus 12-13]
[    0.318735] pci 0000:11:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.318947] pci 0000:13:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.319011] pci 0000:13:00.0: reg 0x10: [mem 0xb0f01000-0xb0f01fff]
[    0.319404] pci 0000:13:00.0: supports D1 D2
[    0.319406] pci 0000:13:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.319607] pci 0000:13:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.319671] pci 0000:13:00.1: reg 0x10: [mem 0xb0f00000-0xb0f00fff]
[    0.320064] pci 0000:13:00.1: supports D1 D2
[    0.320067] pci 0000:13:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.320227] pci 0000:13:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.320291] pci 0000:13:00.2: reg 0x10: [mem 0xb0f02000-0xb0f020ff]
[    0.320684] pci 0000:13:00.2: supports D1 D2
[    0.320686] pci 0000:13:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.321021] pci 0000:12:03.0: PCI bridge to [bus 13]
[    0.321051] pci 0000:12:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.321276] pci 0000:14:00.0: [14e4:16b0] type 00 class 0x020000
[    0.321362] pci 0000:14:00.0: reg 0x10: [mem 0xbd200000-0xbd20ffff 64bit pref]
[    0.321419] pci 0000:14:00.0: reg 0x18: [mem 0xbd210000-0xbd21ffff 64bit pref]
[    0.321844] pci 0000:14:00.0: PME# supported from D0 D3hot D3cold
[    0.322161] pci 0000:10:01.0: PCI bridge to [bus 14]
[    0.322201] pci 0000:10:01.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.322355] pci 0000:15:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.322441] pci 0000:15:00.0: reg 0x10: [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.322881] pci 0000:15:00.0: supports D1 D2
[    0.322883] pci 0000:15:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.323176] pci 0000:10:02.0: PCI bridge to [bus 15]
[    0.323201] pci 0000:10:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.323340] pci 0000:10:04.0: PCI bridge to [bus 16]
[    0.323473] pci 0000:10:05.0: PCI bridge to [bus 17]
[    0.323675] pci 0000:09:05.0: PCI bridge to [bus 18]
[    0.323824] pci 0000:06:04.0: PCI bridge to [bus 39]
[    0.323894] pci 0000:06:05.0: PCI bridge to [bus 3a-6a]
[    0.323901] pci 0000:06:05.0:   bridge window [io  0x4000-0x4fff]
[    0.323906] pci 0000:06:05.0:   bridge window [mem 0xb5200000-0xb91fffff]
[    0.323914] pci 0000:06:05.0:   bridge window [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.323956] pci 0000:06:06.0: PCI bridge to [bus 6b]
[    0.324055] pci 0000:04:00.0: [1c5c:174a] type 00 class 0x010802
[    0.324080] pci 0000:04:00.0: reg 0x10: [mem 0xb0900000-0xb0903fff 64bit]
[    0.324091] pci 0000:04:00.0: reg 0x18: [mem 0xb0905000-0xb0905fff]
[    0.324102] pci 0000:04:00.0: reg 0x1c: [mem 0xb0904000-0xb0904fff]
[    0.324252] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:1c.5 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.324456] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.324462] pci 0000:00:1c.5:   bridge window [mem 0xb0900000-0xb09fffff]
[    0.324486] pci_bus 0000:00: on NUMA node 0
[    0.325225] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.325229] ACPI: PCI: Interrupt link LNKA disabled
[    0.325263] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.325265] ACPI: PCI: Interrupt link LNKB disabled
[    0.325296] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.325299] ACPI: PCI: Interrupt link LNKC disabled
[    0.325330] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.325332] ACPI: PCI: Interrupt link LNKD disabled
[    0.325363] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.325365] ACPI: PCI: Interrupt link LNKE disabled
[    0.325396] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.325399] ACPI: PCI: Interrupt link LNKF disabled
[    0.325431] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.325433] ACPI: PCI: Interrupt link LNKG disabled
[    0.325464] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.325466] ACPI: PCI: Interrupt link LNKH disabled
[    0.325615] ACPI: EC: interrupt unblocked
[    0.325618] ACPI: EC: event unblocked
[    0.325627] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.325630] ACPI: EC: GPE=0x4e
[    0.325633] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.325638] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.325693] iommu: Default domain type: Translated
[    0.325695] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.325738] SCSI subsystem initialized
[    0.325745] libata version 3.00 loaded.
[    0.325803] Registered efivars operations
[    0.325906] PCI: Using ACPI for IRQ routing
[    0.331085] PCI: pci_cache_line_size set to 64 bytes
[    0.331332] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.331334] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.331336] e820: reserve RAM buffer [mem 0x73d4c190-0x73ffffff]
[    0.331337] e820: reserve RAM buffer [mem 0x73d6f190-0x73ffffff]
[    0.331338] e820: reserve RAM buffer [mem 0x8ad10000-0x8bffffff]
[    0.331340] e820: reserve RAM buffer [mem 0x8ad62000-0x8bffffff]
[    0.331341] e820: reserve RAM buffer [mem 0x8ae39000-0x8bffffff]
[    0.331343] e820: reserve RAM buffer [mem 0x8aed2000-0x8bffffff]
[    0.331344] e820: reserve RAM buffer [mem 0x8af84000-0x8bffffff]
[    0.331345] e820: reserve RAM buffer [mem 0x8b000000-0x8bffffff]
[    0.331346] e820: reserve RAM buffer [mem 0x46f600000-0x46fffffff]
[    0.331359] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.331359] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.331359] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.331359] vgaarb: loaded
[    0.331359] clocksource: Switched to clocksource tsc-early
[    0.331359] pnp: PnP ACPI init
[    0.331359] system 00:00: [mem 0xfed00000-0xfed03fff] has been reserved
[    0.331359] system 00:01: [io  0xffff] has been reserved
[    0.331359] system 00:01: [io  0x1800-0x187f] has been reserved
[    0.331359] system 00:01: [io  0x0800-0x087f] has been reserved
[    0.331359] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.331359] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.331359] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.331359] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.331359] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.331359] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.331359] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.331359] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.331359] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[    0.331359] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.331359] system 00:04: [mem 0x20000000-0x201fffff] could not be reserved
[    0.331359] system 00:04: [mem 0x40000000-0x401fffff] could not be reserved
[    0.331359] pnp: PnP ACPI: found 5 devices
[    0.331359] pci 0000:00:02.0: assigning 3 device properties
[    0.331359] pci 0000:07:00.0: assigning 9 device properties
[    0.331359] pci 0000:08:00.0: assigning 3 device properties
[    0.331359] pci 0000:0f:00.0: assigning 3 device properties
[    0.331359] pci 0000:0e:00.0: assigning 2 device properties
[    0.331359] pci 0000:15:00.0: assigning 2 device properties
[    0.331359] pci 0000:00:1b.0: assigning 4 device properties
[    0.335246] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.335285] NET: Registered PF_INET protocol family
[    0.335448] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.338129] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.338166] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.338390] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.338533] TCP: Hash tables configured (established 131072 bind 65536)
[    0.338563] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.338607] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.338677] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.338751] RPC: Registered named UNIX socket transport module.
[    0.338755] RPC: Registered udp transport module.
[    0.338759] RPC: Registered tcp transport module.
[    0.338762] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.338774] pci 0000:06:00.0: bridge window [io  0x1000-0x0fff] to [bus 07] add_size 1000
[    0.338783] pci 0000:06:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 07] add_size 200000 add_align 100000
[    0.338797] pci 0000:10:04.0: bridge window [io  0x1000-0x0fff] to [bus 16] add_size 1000
[    0.338804] pci 0000:10:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 16] add_size 200000 add_align 100000
[    0.338812] pci 0000:10:04.0: bridge window [mem 0x00100000-0x000fffff] to [bus 16] add_size 200000 add_align 100000
[    0.338820] pci 0000:10:05.0: bridge window [io  0x1000-0x0fff] to [bus 17] add_size 1000
[    0.338826] pci 0000:10:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 17] add_size 200000 add_align 100000
[    0.338834] pci 0000:10:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 17] add_size 200000 add_align 100000
[    0.338842] pci 0000:0f:00.0: bridge window [io  0x1000-0x0fff] to [bus 10-17] add_size 2000
[    0.338849] pci 0000:09:04.0: bridge window [io  0x1000-0x0fff] to [bus 0f-17] add_size 3000
[    0.338856] pci 0000:09:05.0: bridge window [io  0x1000-0x0fff] to [bus 18] add_size 1000
[    0.338862] pci 0000:09:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 18] add_size 200000 add_align 100000
[    0.338870] pci 0000:09:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 18] add_size 200000 add_align 100000
[    0.338879] pci 0000:08:00.0: bridge window [io  0x1000-0x0fff] to [bus 09-18] add_size 4000
[    0.338886] pci 0000:06:04.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
[    0.338892] pci 0000:06:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
[    0.338900] pci 0000:06:04.0: bridge window [mem 0x00100000-0x000fffff] to [bus 39] add_size 200000 add_align 100000
[    0.338908] pci 0000:06:06.0: bridge window [io  0x1000-0x0fff] to [bus 6b] add_size 1000
[    0.338914] pci 0000:06:06.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6b] add_size 200000 add_align 100000
[    0.338921] pci 0000:06:06.0: bridge window [mem 0x00100000-0x000fffff] to [bus 6b] add_size 200000 add_align 100000
[    0.338934] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.338947] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.338954] pci 0000:00:1c.1:   bridge window [mem 0xb0a00000-0xb0bfffff]
[    0.338961] pci 0000:00:1c.1:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.338971] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.338977] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb08fffff]
[    0.338993] pci 0000:06:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339000] pci 0000:06:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339006] pci 0000:06:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339011] pci 0000:06:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339017] pci 0000:06:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339022] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339028] pci 0000:06:06.0: BAR 8: no space for [mem size 0x00200000]
[    0.339033] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339039] pci 0000:06:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339045] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339051] pci 0000:06:00.0: BAR 7: no space for [io  size 0x1000]
[    0.339056] pci 0000:06:00.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339061] pci 0000:06:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339066] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339071] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.339075] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339082] pci 0000:06:06.0: BAR 8: no space for [mem size 0x00200000]
[    0.339087] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339093] pci 0000:06:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339098] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339104] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.339109] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339114] pci 0000:06:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339119] pci 0000:06:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339125] pci 0000:06:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339131] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339137] pci 0000:06:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339141] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339148] pci 0000:06:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339153] pci 0000:06:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339159] pci 0000:06:00.0: BAR 7: no space for [io  size 0x1000]
[    0.339164] pci 0000:06:00.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339170] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.339178] pci 0000:06:00.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[    0.339192] pci 0000:08:00.0: BAR 7: no space for [io  size 0x4000]
[    0.339197] pci 0000:08:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.339202] pci 0000:08:00.0: BAR 7: no space for [io  size 0x4000]
[    0.339207] pci 0000:08:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.339213] pci 0000:09:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339218] pci 0000:09:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339225] pci 0000:09:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339230] pci 0000:09:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339236] pci 0000:09:04.0: BAR 7: no space for [io  size 0x3000]
[    0.339241] pci 0000:09:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.339246] pci 0000:09:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339250] pci 0000:09:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339256] pci 0000:09:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339261] pci 0000:09:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339267] pci 0000:09:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339273] pci 0000:09:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339278] pci 0000:09:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339283] pci 0000:09:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339288] pci 0000:09:04.0: BAR 7: no space for [io  size 0x3000]
[    0.339293] pci 0000:09:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.339299] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[    0.339314] pci 0000:0b:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339340] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[    0.339355] pci 0000:0a:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339381] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[    0.339393] pci 0000:09:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339414] pci 0000:09:01.0: PCI bridge to [bus 0d]
[    0.339431] pci 0000:09:01.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.339447] pci 0000:09:02.0: PCI bridge to [bus 0e]
[    0.339459] pci 0000:09:02.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.339480] pci 0000:0f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.339485] pci 0000:0f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.339490] pci 0000:0f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.339495] pci 0000:0f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.339502] pci 0000:10:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339507] pci 0000:10:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339513] pci 0000:10:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339519] pci 0000:10:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339524] pci 0000:10:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339529] pci 0000:10:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339535] pci 0000:10:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339541] pci 0000:10:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339546] pci 0000:10:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339551] pci 0000:10:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339556] pci 0000:10:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339561] pci 0000:10:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339566] pci 0000:10:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339571] pci 0000:10:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339577] pci 0000:10:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339583] pci 0000:10:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339589] pci 0000:10:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339593] pci 0000:10:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339598] pci 0000:10:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339603] pci 0000:10:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339609] pci 0000:10:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339615] pci 0000:10:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339620] pci 0000:10:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339625] pci 0000:10:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339631] pci 0000:12:03.0: PCI bridge to [bus 13]
[    0.339649] pci 0000:12:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.339683] pci 0000:11:00.0: PCI bridge to [bus 12-13]
[    0.339702] pci 0000:11:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.339736] pci 0000:10:00.0: PCI bridge to [bus 11-13]
[    0.339752] pci 0000:10:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.339780] pci 0000:10:01.0: PCI bridge to [bus 14]
[    0.339804] pci 0000:10:01.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.339825] pci 0000:10:02.0: PCI bridge to [bus 15]
[    0.339841] pci 0000:10:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.339869] pci 0000:10:04.0: PCI bridge to [bus 16]
[    0.339908] pci 0000:10:05.0: PCI bridge to [bus 17]
[    0.339947] pci 0000:0f:00.0: PCI bridge to [bus 10-17]
[    0.339963] pci 0000:0f:00.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.339976] pci 0000:0f:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.339996] pci 0000:09:04.0: PCI bridge to [bus 0f-17]
[    0.340009] pci 0000:09:04.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.340019] pci 0000:09:04.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340035] pci 0000:09:05.0: PCI bridge to [bus 18]
[    0.340063] pci 0000:08:00.0: PCI bridge to [bus 09-18]
[    0.340074] pci 0000:08:00.0:   bridge window [mem 0xb0e00000-0xb11fffff]
[    0.340084] pci 0000:08:00.0:   bridge window [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.340100] pci 0000:06:03.0: PCI bridge to [bus 08-38]
[    0.340106] pci 0000:06:03.0:   bridge window [io  0x3000-0x3fff]
[    0.340115] pci 0000:06:03.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[    0.340122] pci 0000:06:03.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.340133] pci 0000:06:04.0: PCI bridge to [bus 39]
[    0.340149] pci 0000:06:05.0: PCI bridge to [bus 3a-6a]
[    0.340155] pci 0000:06:05.0:   bridge window [io  0x4000-0x4fff]
[    0.340164] pci 0000:06:05.0:   bridge window [mem 0xb5200000-0xb91fffff]
[    0.340171] pci 0000:06:05.0:   bridge window [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.340182] pci 0000:06:06.0: PCI bridge to [bus 6b]
[    0.340198] pci 0000:05:00.0: PCI bridge to [bus 06-6b]
[    0.340204] pci 0000:05:00.0:   bridge window [io  0x3000-0x4fff]
[    0.340212] pci 0000:05:00.0:   bridge window [mem 0xb0d00000-0xb91fffff]
[    0.340220] pci 0000:05:00.0:   bridge window [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.340230] pci 0000:00:1c.4: PCI bridge to [bus 05-6b]
[    0.340235] pci 0000:00:1c.4:   bridge window [io  0x3000-0x5fff]
[    0.340242] pci 0000:00:1c.4:   bridge window [mem 0xb0d00000-0xbd1fffff]
[    0.340249] pci 0000:00:1c.4:   bridge window [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.340258] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.340265] pci 0000:00:1c.5:   bridge window [mem 0xb0900000-0xb09fffff]
[    0.340275] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.340280] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.340285] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.340291] pci_bus 0000:00: resource 7 [mem 0x8fa00000-0xfeafffff window]
[    0.340296] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff window]
[    0.340302] pci_bus 0000:02: resource 1 [mem 0xb0a00000-0xb0bfffff]
[    0.340306] pci_bus 0000:02: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.340312] pci_bus 0000:03: resource 1 [mem 0xb0400000-0xb08fffff]
[    0.340317] pci_bus 0000:05: resource 0 [io  0x3000-0x5fff]
[    0.340322] pci_bus 0000:05: resource 1 [mem 0xb0d00000-0xbd1fffff]
[    0.340327] pci_bus 0000:05: resource 2 [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.340333] pci_bus 0000:06: resource 0 [io  0x3000-0x4fff]
[    0.340337] pci_bus 0000:06: resource 1 [mem 0xb0d00000-0xb91fffff]
[    0.340342] pci_bus 0000:06: resource 2 [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.340348] pci_bus 0000:07: resource 1 [mem 0xb0d00000-0xb0dfffff]
[    0.340353] pci_bus 0000:08: resource 0 [io  0x3000-0x3fff]
[    0.340357] pci_bus 0000:08: resource 1 [mem 0xb0e00000-0xb51fffff]
[    0.340362] pci_bus 0000:08: resource 2 [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.340368] pci_bus 0000:09: resource 1 [mem 0xb0e00000-0xb11fffff]
[    0.340373] pci_bus 0000:09: resource 2 [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.340379] pci_bus 0000:0a: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340384] pci_bus 0000:0b: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340389] pci_bus 0000:0c: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340394] pci_bus 0000:0d: resource 2 [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.340400] pci_bus 0000:0e: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.340405] pci_bus 0000:0f: resource 1 [mem 0xb0e00000-0xb0ffffff]
[    0.340410] pci_bus 0000:0f: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340416] pci_bus 0000:10: resource 1 [mem 0xb0e00000-0xb0ffffff]
[    0.340421] pci_bus 0000:10: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340426] pci_bus 0000:11: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340431] pci_bus 0000:12: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340436] pci_bus 0000:13: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340441] pci_bus 0000:14: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340447] pci_bus 0000:15: resource 1 [mem 0xb0e00000-0xb0efffff]
[    0.340453] pci_bus 0000:3a: resource 0 [io  0x4000-0x4fff]
[    0.340458] pci_bus 0000:3a: resource 1 [mem 0xb5200000-0xb91fffff]
[    0.340463] pci_bus 0000:3a: resource 2 [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.340469] pci_bus 0000:04: resource 1 [mem 0xb0900000-0xb09fffff]
[    0.340862] pci 0000:05:00.0: CLS mismatch (256 != 128), using 64 bytes
[    0.340890] pci 0000:0c:00.0: MSI is not implemented on this device, disabling it
[    0.340895] pci 0000:0c:00.0: PME# is unreliable, disabling it
[    0.341278] pci 0000:0c:00.1: MSI is not implemented on this device, disabling it
[    0.341284] pci 0000:0c:00.1: PME# is unreliable, disabling it
[    0.341390] pci 0000:0c:00.2: MSI is not implemented on this device, disabling it
[    0.341395] pci 0000:0c:00.2: PME# is unreliable, disabling it
[    0.341460] pci 0000:0c:00.2: EHCI: unrecognized capability 00
[    0.341518] pci 0000:13:00.0: MSI is not implemented on this device, disabling it
[    0.341524] pci 0000:13:00.0: PME# is unreliable, disabling it
[    0.341844] pci 0000:13:00.1: MSI is not implemented on this device, disabling it
[    0.341849] pci 0000:13:00.1: PME# is unreliable, disabling it
[    0.341972] pci 0000:13:00.2: MSI is not implemented on this device, disabling it
[    0.341977] pci 0000:13:00.2: PME# is unreliable, disabling it
[    0.342054] pci 0000:13:00.2: EHCI: unrecognized capability 00
[    0.342134] DMAR: No ATSR found
[    0.342137] DMAR: No SATC found
[    0.342141] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.342143] DMAR: IOMMU feature sc_support inconsistent
[    0.342147] DMAR: IOMMU feature pass_through inconsistent
[    0.342151] DMAR: dmar0: Using Queued invalidation
[    0.342151] Unpacking initramfs...
[    0.342160] DMAR: dmar1: Using Queued invalidation
[    0.438295] pci 0000:00:00.0: Adding to iommu group 0
[    0.438327] pci 0000:00:02.0: Adding to iommu group 1
[    0.438349] pci 0000:00:03.0: Adding to iommu group 2
[    0.438370] pci 0000:00:14.0: Adding to iommu group 3
[    0.438401] pci 0000:00:16.0: Adding to iommu group 4
[    0.438420] pci 0000:00:1b.0: Adding to iommu group 5
[    0.438441] pci 0000:00:1c.0: Adding to iommu group 6
[    0.438461] pci 0000:00:1c.1: Adding to iommu group 7
[    0.438481] pci 0000:00:1c.2: Adding to iommu group 8
[    0.438502] pci 0000:00:1c.4: Adding to iommu group 9
[    0.438522] pci 0000:00:1c.5: Adding to iommu group 10
[    0.438558] pci 0000:00:1f.0: Adding to iommu group 11
[    0.438578] pci 0000:00:1f.3: Adding to iommu group 11
[    0.438597] pci 0000:02:00.0: Adding to iommu group 12
[    0.438617] pci 0000:03:00.0: Adding to iommu group 13
[    0.438637] pci 0000:05:00.0: Adding to iommu group 14
[    0.438658] pci 0000:06:00.0: Adding to iommu group 15
[    0.438678] pci 0000:06:03.0: Adding to iommu group 16
[    0.438699] pci 0000:06:04.0: Adding to iommu group 17
[    0.438719] pci 0000:06:05.0: Adding to iommu group 18
[    0.438740] pci 0000:06:06.0: Adding to iommu group 19
[    0.438749] pci 0000:07:00.0: Adding to iommu group 15
[    0.438758] pci 0000:08:00.0: Adding to iommu group 16
[    0.438767] pci 0000:09:00.0: Adding to iommu group 16
[    0.438776] pci 0000:09:01.0: Adding to iommu group 16
[    0.438786] pci 0000:09:02.0: Adding to iommu group 16
[    0.438794] pci 0000:09:04.0: Adding to iommu group 16
[    0.438803] pci 0000:09:05.0: Adding to iommu group 16
[    0.438813] pci 0000:0a:00.0: Adding to iommu group 16
[    0.438821] pci 0000:0b:03.0: Adding to iommu group 16
[    0.438830] pci 0000:0c:00.0: Adding to iommu group 16
[    0.438838] pci 0000:0c:00.1: Adding to iommu group 16
[    0.438846] pci 0000:0c:00.2: Adding to iommu group 16
[    0.438855] pci 0000:0d:00.0: Adding to iommu group 16
[    0.438863] pci 0000:0e:00.0: Adding to iommu group 16
[    0.438872] pci 0000:0f:00.0: Adding to iommu group 16
[    0.438882] pci 0000:10:00.0: Adding to iommu group 16
[    0.438890] pci 0000:10:01.0: Adding to iommu group 16
[    0.438899] pci 0000:10:02.0: Adding to iommu group 16
[    0.438907] pci 0000:10:04.0: Adding to iommu group 16
[    0.438915] pci 0000:10:05.0: Adding to iommu group 16
[    0.438924] pci 0000:11:00.0: Adding to iommu group 16
[    0.438933] pci 0000:12:03.0: Adding to iommu group 16
[    0.438942] pci 0000:13:00.0: Adding to iommu group 16
[    0.438951] pci 0000:13:00.1: Adding to iommu group 16
[    0.438959] pci 0000:13:00.2: Adding to iommu group 16
[    0.438968] pci 0000:14:00.0: Adding to iommu group 16
[    0.438977] pci 0000:15:00.0: Adding to iommu group 16
[    0.438996] pci 0000:04:00.0: Adding to iommu group 20
[    0.441096] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.441102] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.441105] software IO TLB: mapped [mem 0x000000006c76e000-0x000000007076e000] (64MB)
[    0.441116] ACPI: bus type thunderbolt registered
[    0.441288] thunderbolt 0000:07:00.0: total paths: 12
[    0.441553] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.441590] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.441613] thunderbolt 0000:07:00.0: control channel created
[    0.441617] thunderbolt 0000:07:00.0: ICM not supported on this controller
[    0.441629] thunderbolt 0000:07:00.0: freeing RX ring 0
[    0.441639] thunderbolt 0000:07:00.0: freeing TX ring 0
[    0.441653] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.441663] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.441674] thunderbolt 0000:07:00.0: control channel created
[    0.441677] thunderbolt 0000:07:00.0: using software connection manager
[    0.441680] thunderbolt 0000:07:00.0: device link creation from 0000:06:00.0 failed
[    0.441727] thunderbolt 0000:07:00.0: created link from 0000:06:03.0
[    0.441744] thunderbolt 0000:07:00.0: created link from 0000:06:04.0
[    0.441760] thunderbolt 0000:07:00.0: created link from 0000:06:05.0
[    0.441776] thunderbolt 0000:07:00.0: created link from 0000:06:06.0
[    0.441921] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[    0.441923] thunderbolt 0000:07:00.0: control channel starting...
[    0.441925] thunderbolt 0000:07:00.0: starting TX ring 0
[    0.441933] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.441937] thunderbolt 0000:07:00.0: starting RX ring 0
[    0.441944] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[    0.441949] thunderbolt 0000:07:00.0: security level set to user
[    0.442112] thunderbolt 0000:07:00.0: current switch config:
[    0.442114] thunderbolt 0000:07:00.0:  Thunderbolt 2 Switch: 8086:156d (Revision: 0, TB Version: 2)
[    0.442118] thunderbolt 0000:07:00.0:   Max Port Number: 12
[    0.442120] thunderbolt 0000:07:00.0:   Config:
[    0.442122] thunderbolt 0000:07:00.0:    Upstream Port Number: 5 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.442125] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.443932] Freeing initrd memory: 7308K
[    0.554991] thunderbolt 0000:07:00.0: initializing Switch at 0x0 (depth: 0, up port: 5)
[    0.555630] thunderbolt 0000:07:00.0: 0: DROM version: 1
[    0.557037] thunderbolt 0000:07:00.0: 0: uid: 0x1000f0811ee60
[    0.558957] thunderbolt 0000:07:00.0:  Port 1: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.558960] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.558962] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.558963] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.558964] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.560876] thunderbolt 0000:07:00.0:  Port 2: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.560878] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.560879] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.560880] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.560881] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.562795] thunderbolt 0000:07:00.0:  Port 3: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.562798] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.562799] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.562800] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.562801] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.564715] thunderbolt 0000:07:00.0:  Port 4: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.564718] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.564719] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.564720] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.564721] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.565483] thunderbolt 0000:07:00.0:  Port 5: 8086:156d (Revision: 0, TB Version: 1, Type: NHI (0x2))
[    0.565486] thunderbolt 0000:07:00.0:   Max hop id (in/out): 11/11
[    0.565487] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.565488] thunderbolt 0000:07:00.0:   NFC Credits: 0xf00000
[    0.565489] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.565739] thunderbolt 0000:07:00.0:  Port 6: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.565742] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.565743] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.565744] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.565746] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.565996] random: fast init done
[    0.565996] thunderbolt 0000:07:00.0:  Port 7: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566001] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566003] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566005] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566006] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566251] thunderbolt 0000:07:00.0:  Port 8: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566253] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566255] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566256] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566257] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566507] thunderbolt 0000:07:00.0:  Port 9: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566509] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566510] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566511] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566512] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566513] thunderbolt 0000:07:00.0: 0:a: disabled by eeprom
[    0.566763] thunderbolt 0000:07:00.0:  Port 11: 8086:156d (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.566765] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.566767] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566767] thunderbolt 0000:07:00.0:   NFC Credits: 0xf00000
[    0.566769] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.567019] thunderbolt 0000:07:00.0:  Port 12: 8086:156d (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.567021] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.567023] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.567023] thunderbolt 0000:07:00.0:   NFC Credits: 0xf0000b
[    0.567025] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.572011] thunderbolt 0000:07:00.0: 0: TMU: current mode: HiFi
[    0.572141] thunderbolt 0000:07:00.0: 0:1: is unplugged (state: 7)
[    0.572267] thunderbolt 0000:07:00.0: 0:3: is connected, link is up (state: 2)
[    0.572523] thunderbolt 0000:07:00.0: current switch config:
[    0.572524] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.572526] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.572527] thunderbolt 0000:07:00.0:   Config:
[    0.572528] thunderbolt 0000:07:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1, PlugEventsDelay: 255ms
[    0.572530] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.577131] thunderbolt 0000:07:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[    0.594537] thunderbolt 0000:07:00.0: 3: reading drom (length: 0x97)
[    1.088194] thunderbolt 0000:07:00.0: 3: DROM version: 1
[    1.089218] thunderbolt 0000:07:00.0: 3: uid: 0x1000100189170
[    1.092162] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.092164] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.092165] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.092166] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.092167] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.095105] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.095107] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.095108] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.095109] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c0000e
[    1.095110] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.098049] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.098050] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.098051] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.098052] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.098053] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.100993] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.100994] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.100995] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.100996] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.100997] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.100998] thunderbolt 0000:07:00.0: 3:5: disabled by eeprom
[    1.100999] thunderbolt 0000:07:00.0: 3:6: disabled by eeprom
[    1.101888] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.101890] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.101891] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.101892] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.101893] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.102785] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.102786] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.102787] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.102788] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.102789] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.102791] thunderbolt 0000:07:00.0: 3:9: disabled by eeprom
[    1.103681] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.103683] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.103684] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.103685] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.103686] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.104833] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.104835] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.104836] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.104837] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.104838] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.104839] thunderbolt 0000:07:00.0: 3:c: disabled by eeprom
[    1.104840] thunderbolt 0000:07:00.0: 3:d: disabled by eeprom
[    1.122677] thunderbolt 0000:07:00.0: 3: TMU: current mode: bi-directional, HiFi
[    1.122693] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[    1.122697] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[    1.123189] thunderbolt 0000:07:00.0: 3:3: is connected, link is up (state: 2)
[    1.123445] thunderbolt 0000:07:00.0: current switch config:
[    1.123446] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    1.123448] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    1.123449] thunderbolt 0000:07:00.0:   Config:
[    1.123450] thunderbolt 0000:07:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x303 Enabled: 1, PlugEventsDelay: 255ms
[    1.123452] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.128053] thunderbolt 0000:07:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[    1.145459] thunderbolt 0000:07:00.0: 303: reading drom (length: 0x97)
[    1.620944] random: crng init done
[    1.639116] thunderbolt 0000:07:00.0: 303: DROM version: 1
[    1.640140] thunderbolt 0000:07:00.0: 303: uid: 0x100010102a740
[    1.643083] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.643085] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.643086] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.643087] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.643089] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.646027] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.646029] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.646030] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.646031] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.646032] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.648970] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.648972] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.648973] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.648974] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.648975] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.651914] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.651916] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.651917] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.651918] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.651919] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.651920] thunderbolt 0000:07:00.0: 303:5: disabled by eeprom
[    1.651921] thunderbolt 0000:07:00.0: 303:6: disabled by eeprom
[    1.652810] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.652812] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.652813] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.652814] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.652815] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.653707] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.653710] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.653711] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.653712] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.653713] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.653714] thunderbolt 0000:07:00.0: 303:9: disabled by eeprom
[    1.654602] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.654604] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.654605] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.654606] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.654607] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.655754] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.655756] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.655757] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.655758] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.655759] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.655760] thunderbolt 0000:07:00.0: 303:c: disabled by eeprom
[    1.655761] thunderbolt 0000:07:00.0: 303:d: disabled by eeprom
[    1.673562] thunderbolt 0000:07:00.0: 303: TMU: current mode: bi-directional, HiFi
[    1.673577] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[    1.673581] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[    1.673692] thunderbolt 0000:07:00.0: 303:1: is unplugged (state: 7)
[    1.673946] thunderbolt 0000:07:00.0: 303:b: DP adapter HPD set, queuing hotplug
[    1.674586] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 0:6
[    1.674714] thunderbolt 0000:07:00.0: 0:6:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.674716] thunderbolt 0000:07:00.0: 0:6:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.674718] thunderbolt 0000:07:00.0: 0:6:    Counter enabled: 1 Counter index: 0
[    1.674719] thunderbolt 0000:07:00.0: 0:6:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.674721] thunderbolt 0000:07:00.0: 0:6:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.674842] thunderbolt 0000:07:00.0: 3:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.674844] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[    1.674845] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 1 Counter index: 0
[    1.674847] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.674848] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.674850] thunderbolt 0000:07:00.0: path discovery complete
[    1.675353] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 3:10
[    1.675482] thunderbolt 0000:07:00.0: 3:a:  In HopID: 8 => Out port: 1 Out HopID: 8
[    1.675483] thunderbolt 0000:07:00.0: 3:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.675485] thunderbolt 0000:07:00.0: 3:a:    Counter enabled: 1 Counter index: 0
[    1.675486] thunderbolt 0000:07:00.0: 3:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.675487] thunderbolt 0000:07:00.0: 3:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.675610] thunderbolt 0000:07:00.0: 0:3:  In HopID: 8 => Out port: 6 Out HopID: 8
[    1.675611] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[    1.675613] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 1 Counter index: 0
[    1.675614] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.675615] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.675617] thunderbolt 0000:07:00.0: path discovery complete
[    1.675738] thunderbolt 0000:07:00.0: 0:6 <-> 3:a (PCI): discovered
[    1.676634] thunderbolt 0000:07:00.0: discovering Video path starting from 0:12
[    1.676762] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 4 Out HopID: 8
[    1.676763] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.676765] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 1 Counter index: 1
[    1.676766] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.676767] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.676890] thunderbolt 0000:07:00.0: 3:2:  In HopID: 8 => Out port: 11 Out HopID: 9
[    1.676891] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.676892] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 1 Counter index: 1
[    1.676894] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.676895] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.676897] thunderbolt 0000:07:00.0: path discovery complete
[    1.677145] thunderbolt 0000:07:00.0: discovering AUX TX path starting from 0:12
[    1.677274] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 4 Out HopID: 9
[    1.677275] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 4 Drop: 0
[    1.677276] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 1 Counter index: 0
[    1.677278] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.677279] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.677402] thunderbolt 0000:07:00.0: 3:2:  In HopID: 9 => Out port: 11 Out HopID: 8
[    1.677403] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.677404] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 1 Counter index: 0
[    1.677406] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.677407] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.677408] thunderbolt 0000:07:00.0: path discovery complete
[    1.677913] thunderbolt 0000:07:00.0: discovering AUX RX path starting from 3:11
[    1.678042] thunderbolt 0000:07:00.0: 3:b:  In HopID: 8 => Out port: 2 Out HopID: 8
[    1.678043] thunderbolt 0000:07:00.0: 3:b:   Weight: 1 Priority: 2 Credits: 7 Drop: 0
[    1.678044] thunderbolt 0000:07:00.0: 3:b:    Counter enabled: 1 Counter index: 0
[    1.678046] thunderbolt 0000:07:00.0: 3:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.678047] thunderbolt 0000:07:00.0: 3:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.678170] thunderbolt 0000:07:00.0: 0:4:  In HopID: 8 => Out port: 12 Out HopID: 8
[    1.678171] thunderbolt 0000:07:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.678172] thunderbolt 0000:07:00.0: 0:4:    Counter enabled: 1 Counter index: 0
[    1.678174] thunderbolt 0000:07:00.0: 0:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.678175] thunderbolt 0000:07:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.678176] thunderbolt 0000:07:00.0: path discovery complete
[    1.678425] thunderbolt 0000:07:00.0: 0:c <-> 3:b (DP): discovered
[    1.678809] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 3:7
[    1.678937] thunderbolt 0000:07:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.678939] thunderbolt 0000:07:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.678940] thunderbolt 0000:07:00.0: 3:7:    Counter enabled: 1 Counter index: 0
[    1.678941] thunderbolt 0000:07:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.678943] thunderbolt 0000:07:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.679066] thunderbolt 0000:07:00.0: 303:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.679067] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[    1.679068] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 1 Counter index: 0
[    1.679070] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.679071] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.679073] thunderbolt 0000:07:00.0: path discovery complete
[    1.679577] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 303:10
[    1.679705] thunderbolt 0000:07:00.0: 303:a:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.679707] thunderbolt 0000:07:00.0: 303:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.679708] thunderbolt 0000:07:00.0: 303:a:    Counter enabled: 1 Counter index: 0
[    1.679710] thunderbolt 0000:07:00.0: 303:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.679711] thunderbolt 0000:07:00.0: 303:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.679833] thunderbolt 0000:07:00.0: 3:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[    1.679835] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[    1.679836] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 1 Counter index: 0
[    1.679838] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.679839] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.679840] thunderbolt 0000:07:00.0: path discovery complete
[    1.679961] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): discovered
[    1.680346] thunderbolt 0000:07:00.0: 0:b: DP IN resource available
[    1.680348] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.680476] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[    1.680480] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[    1.680488] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    1.680493] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    1.680495] RAPL PMU: hw unit of domain package 2^-14 Joules
[    1.680497] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    1.680499] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    1.680603] thunderbolt 0000:07:00.0: 0:b: DP IN available
[    1.680733] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[    1.680736] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 11
[    1.680740] thunderbolt 0000:07:00.0: 303:b: calculating available bandwidth
[    1.680861] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[    1.680865] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[    1.680990] thunderbolt 0000:07:00.0: 3:3: link total bandwidth 9000 Mb/s
[    1.680995] thunderbolt 0000:07:00.0: 303:3: link total bandwidth 9000 Mb/s
[    1.680998] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    1.681007] thunderbolt 0000:07:00.0: 0:b <-> 303:b (DP): activating
[    1.681011] thunderbolt 0000:07:00.0: activating Video path from 0:11 to 303:11
[    1.681014] thunderbolt 0000:07:00.0: 303:4: adding 12 NFC credits to 0
[    1.681117] thunderbolt 0000:07:00.0: 3:2: adding 12 NFC credits to 14
[    1.681244] thunderbolt 0000:07:00.0: 0:b: adding 12 NFC credits to 0
[    1.681309] Initialise system trusted keyrings
[    1.681339] workingset: timestamp_bits=62 max_order=22 bucket_order=0
[    1.682416] thunderbolt 0000:07:00.0: 303:4: Writing hop 2
[    1.682419] thunderbolt 0000:07:00.0: 303:4:  In HopID: 8 => Out port: 11 Out HopID: 9
[    1.682421] thunderbolt 0000:07:00.0: 303:4:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.682422] thunderbolt 0000:07:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[    1.682424] thunderbolt 0000:07:00.0: 303:4:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.682426] thunderbolt 0000:07:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.682468] NFS: Registering the id_resolver key type
[    1.682474] Key type id_resolver registered
[    1.682476] Key type id_legacy registered
[    1.682490] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.682528] Key type asymmetric registered
[    1.682530] Asymmetric key parser 'x509' registered
[    1.682670] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[    1.682671] thunderbolt 0000:07:00.0: 3:2:  In HopID: 10 => Out port: 4 Out HopID: 8
[    1.682673] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.682674] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[    1.682676] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.682677] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.682926] thunderbolt 0000:07:00.0: 0:b: Writing hop 0
[    1.682927] thunderbolt 0000:07:00.0: 0:b:  In HopID: 9 => Out port: 4 Out HopID: 10
[    1.682929] thunderbolt 0000:07:00.0: 0:b:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.682930] thunderbolt 0000:07:00.0: 0:b:    Counter enabled: 0 Counter index: 2047
[    1.682931] thunderbolt 0000:07:00.0: 0:b:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.682933] thunderbolt 0000:07:00.0: 0:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683056] thunderbolt 0000:07:00.0: path activation complete
[    1.683058] thunderbolt 0000:07:00.0: activating AUX TX path from 0:11 to 303:11
[    1.683184] thunderbolt 0000:07:00.0: 303:4: Writing hop 2
[    1.683186] thunderbolt 0000:07:00.0: 303:4:  In HopID: 9 => Out port: 11 Out HopID: 8
[    1.683187] thunderbolt 0000:07:00.0: 303:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.683190] thunderbolt 0000:07:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[    1.683201] thunderbolt 0000:07:00.0: 303:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.683204] thunderbolt 0000:07:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683441] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[    1.683444] thunderbolt 0000:07:00.0: 3:2:  In HopID: 11 => Out port: 4 Out HopID: 9
[    1.683447] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.683449] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[    1.683451] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.683452] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683696] thunderbolt 0000:07:00.0: 0:b: Writing hop 0
[    1.683698] thunderbolt 0000:07:00.0: 0:b:  In HopID: 8 => Out port: 4 Out HopID: 11
[    1.683699] thunderbolt 0000:07:00.0: 0:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.683701] thunderbolt 0000:07:00.0: 0:b:    Counter enabled: 0 Counter index: 2047
[    1.683702] thunderbolt 0000:07:00.0: 0:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.683704] thunderbolt 0000:07:00.0: 0:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683823] thunderbolt 0000:07:00.0: path activation complete
[    1.683825] thunderbolt 0000:07:00.0: activating AUX RX path from 303:11 to 0:11
[    1.683850] pcieport 0000:06:00.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.683953] thunderbolt 0000:07:00.0: 0:4: Writing hop 2
[    1.683957] thunderbolt 0000:07:00.0: 0:4:  In HopID: 9 => Out port: 11 Out HopID: 8
[    1.683960] thunderbolt 0000:07:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.683961] thunderbolt 0000:07:00.0: 0:4:    Counter enabled: 0 Counter index: 2047
[    1.683963] thunderbolt 0000:07:00.0: 0:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.683964] thunderbolt 0000:07:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.684090] pcieport 0000:06:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.684208] thunderbolt 0000:07:00.0: 3:4: Writing hop 1
[    1.684210] thunderbolt 0000:07:00.0: 3:4:  In HopID: 8 => Out port: 2 Out HopID: 9
[    1.684211] thunderbolt 0000:07:00.0: 3:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.684213] thunderbolt 0000:07:00.0: 3:4:    Counter enabled: 0 Counter index: 2047
[    1.684214] thunderbolt 0000:07:00.0: 3:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.684216] thunderbolt 0000:07:00.0: 3:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.684328] pcieport 0000:06:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.684465] thunderbolt 0000:07:00.0: 303:b: Writing hop 0
[    1.684467] thunderbolt 0000:07:00.0: 303:b:  In HopID: 8 => Out port: 4 Out HopID: 8
[    1.684468] thunderbolt 0000:07:00.0: 303:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.684470] thunderbolt 0000:07:00.0: 303:b:    Counter enabled: 0 Counter index: 2047
[    1.684471] thunderbolt 0000:07:00.0: 303:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.684473] thunderbolt 0000:07:00.0: 303:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.684488] pcieport 0000:06:05.0: enabling device (0000 -> 0003)
[    1.684604] pcieport 0000:06:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.684607] thunderbolt 0000:07:00.0: path activation complete
[    1.684867] pcieport 0000:06:06.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.687416] pcieport 0000:09:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.687739] pcieport 0000:09:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.691080] pcieport 0000:10:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.691500] pcieport 0000:10:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.692492] ACPI: AC: AC Adapter [ADP1] (off-line)
[    1.692565] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    1.692607] ACPI: button: Lid Switch [LID0]
[    1.692642] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.692670] ACPI: button: Power Button [PWRB]
[    1.692703] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    1.692729] ACPI: button: Sleep Button [SLPB]
[    1.692760] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.692794] ACPI: button: Power Button [PWRF]
[    1.693064] smbus_hc ACPI0001:00: SBS HC: offset = 0x20, query_bit = 0x10
[    2.093834] ACPI: Smart Battery System [SBS0]: Battery Slot [BAT0] (battery present)
[    2.103691] hpet_acpi_add: no address or irqs in _CRS
[    2.104863] loop: module loaded
[    2.105097] nvme nvme0: pci function 0000:04:00.0
[    2.105418] tun: Universal TUN/TAP device driver, 1.6
[    2.105493] mousedev: PS/2 mouse device common for all mice
[    2.105512] rtc_cmos 00:02: RTC can wake from S4
[    2.105766] rtc_cmos 00:02: registered as rtc0
[    2.105803] rtc_cmos 00:02: setting system clock to 2022-04-01T05:32:38 UTC (1648791158)
[    2.105808] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram
[    2.105992] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[    2.106002] intel_pstate: Intel P-state driver initializing
[    2.106105] efifb: probing for efifb
[    2.106116] efifb: framebuffer at 0xa0000000, using 16000k, total 16000k
[    2.106118] efifb: mode is 2560x1600x32, linelength=10240, pages=1
[    2.106121] efifb: scrolling: redraw
[    2.106122] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    2.109319] Console: switching to colour frame buffer device 320x100
[    2.112345] fb0: EFI VGA frame buffer device
[    2.112413] NET: Registered PF_PACKET protocol family
[    2.112433] Key type dns_resolver registered
[    2.112585] microcode: sig=0x40651, pf=0x40, revision=0x26
[    2.112621] microcode: Microcode Update Driver: v2.2.
[    2.112624] IPI shorthand broadcast: enabled
[    2.112645] AVX2 version of gcm_enc/dec engaged.
[    2.112681] AES CTR mode by8 optimization enabled
[    2.112804] sched_clock: Marking stable (2111200437, 1599381)->(2141753108, -28953290)
[    2.112863] registered taskstats version 1
[    2.112870] Loading compiled-in X.509 certificates
[    2.161001] nvme0: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2)
[    2.179197] nvme nvme0: 4/0/0 default/read/poll queues
[    2.184202]  nvme0n1: p1 p2 p3 p4 p5 p6 p7
[    2.351943] Freeing unused kernel image (initmem) memory: 996K
[    2.393251] Write protecting the kernel read-only data: 16384k
[    2.393605] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    2.393773] Freeing unused kernel image (rodata/data gap) memory: 1356K
[    2.393789] Run /init as init process
[    2.393797]   with arguments:
[    2.393798]     /init
[    2.393799]   with environment:
[    2.393800]     HOME=/
[    2.393800]     TERM=linux
[    2.446412] udevd[940]: starting version 3.2.9
[    2.447182] udevd[941]: starting eudev-3.2.9
[    2.466582] ACPI: bus type USB registered
[    2.466703] usbcore: registered new interface driver usbfs
[    2.466729] usbcore: registered new interface driver hub
[    2.466757] usbcore: registered new device driver usb
[    2.469261] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.469284] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.470385] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x000000000004b810
[    2.470581] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    2.470606] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.470627] usb usb1: Product: xHCI Host Controller
[    2.470641] usb usb1: Manufacturer: Linux 5.17.0+ xhci-hcd
[    2.470655] usb usb1: SerialNumber: 0000:00:14.0
[    2.470826] hub 1-0:1.0: USB hub found
[    2.470851] hub 1-0:1.0: 9 ports detected
[    2.471466] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.471487] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.471509] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.471700] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.17
[    2.471723] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.471743] usb usb2: Product: xHCI Host Controller
[    2.471757] usb usb2: Manufacturer: Linux 5.17.0+ xhci-hcd
[    2.471773] usb usb2: SerialNumber: 0000:00:14.0
[    2.472204] hub 2-0:1.0: USB hub found
[    2.472225] hub 2-0:1.0: 4 ports detected
[    2.474869] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    2.475049] i2c i2c-0: 2/2 memory slots populated (from DMI)
[    2.526851] applesmc: key=571 fan=1 temp=32 index=31 acc=0 lux=2 kbd=1
[    2.526986] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    2.546590] tg3 0000:0d:00.0 eth0: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[    2.546630] tg3 0000:0d:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.546662] tg3 0000:0d:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.546677] tg3 0000:0d:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.633876] tg3 0000:14:00.0 eth1: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[    2.633922] tg3 0000:14:00.0 eth1: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.633954] tg3 0000:14:00.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.633981] tg3 0000:14:00.0 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.723252] tsc: Refined TSC clocksource calibration: 2599.999 MHz
[    2.723277] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x257a3b2ad7e, max_idle_ns: 440795282337 ns
[    2.723314] clocksource: Switched to clocksource tsc
[    2.763254] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    2.946025] usb 1-3: New USB device found, idVendor=05ac, idProduct=8290, bcdDevice= 1.69
[    2.946030] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.946032] usb 1-3: Product: Bluetooth USB Host Controller
[    2.946033] usb 1-3: Manufacturer: Broadcom Corp.
[    2.952680] hid: raw HID events driver (C) Jiri Kosina
[    2.956920] usbcore: registered new interface driver usbhid
[    2.956923] usbhid: USB HID core driver
[    2.957550] input: Broadcom Corp. Bluetooth USB Host Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:05AC:8290.0001/input/input4
[    3.023333] hid-generic 0003:05AC:8290.0001: input,hidraw0: USB HID v1.11 Keyboard [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.0-3/input0
[    3.023456] input: Broadcom Corp. Bluetooth USB Host Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.1/0003:05AC:8290.0002/input/input5
[    3.024049] hid-generic 0003:05AC:8290.0002: input,hidraw1: USB HID v1.11 Mouse [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.0-3/input1
[    3.093419] usb 2-3: new SuperSpeed USB device number 2 using xhci_hcd
[    3.125625] usb 2-3: New USB device found, idVendor=05ac, idProduct=8406, bcdDevice= 8.20
[    3.125629] usb 2-3: New USB device strings: Mfr=3, Product=4, SerialNumber=5
[    3.125631] usb 2-3: Product: Card Reader
[    3.125632] usb 2-3: Manufacturer: Apple
[    3.125633] usb 2-3: SerialNumber: 000000000820
[    3.128714] usb-storage 2-3:1.0: USB Mass Storage device detected
[    3.128796] scsi host0: usb-storage 2-3:1.0
[    3.128872] usbcore: registered new interface driver usb-storage
[    3.129081] usbcore: registered new interface driver uas
[    3.273249] usb 1-5: new full-speed USB device number 3 using xhci_hcd
[    3.459439] usb 1-5: New USB device found, idVendor=05ac, idProduct=0259, bcdDevice= 2.24
[    3.459444] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.459446] usb 1-5: Product: Apple Internal Keyboard / Trackpad
[    3.459447] usb 1-5: Manufacturer: Apple Inc.
[    3.469354] input: Apple Inc. Apple Internal Keyboard / Trackpad as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/0003:05AC:0259.0003/input/input6
[    3.533315] apple 0003:05AC:0259.0003: input,hidraw2: USB HID v1.11 Keyboard [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-5/input0
[    3.533406] apple 0003:05AC:0259.0004: hidraw3: USB HID v1.11 Device [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-5/input1
[    4.165099] scsi 0:0:0:0: Direct-Access     APPLE    SD Card Reader   3.00 PQ: 0 ANSI: 6
[    4.165690] sd 0:0:0:0: [sda] Media removed, stopped polling
[    4.165806] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.166320] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    9.227663] process '/usr/bin/fstype' started with executable stack
[    9.308337] PM: Image not found (code -22)
[    9.310377] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[    9.310382] PM: hibernation: Marking nosave pages: [mem 0x00058000-0x00058fff]
[    9.310384] PM: hibernation: Marking nosave pages: [mem 0x0008f000-0x0008ffff]
[    9.310385] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
[    9.310387] PM: hibernation: Marking nosave pages: [mem 0x73d4c000-0x73d4cfff]
[    9.310388] PM: hibernation: Marking nosave pages: [mem 0x73d5c000-0x73d5cfff]
[    9.310389] PM: hibernation: Marking nosave pages: [mem 0x73d6f000-0x73d6ffff]
[    9.310390] PM: hibernation: Marking nosave pages: [mem 0x73d6f000-0x73d6ffff]
[    9.310391] PM: hibernation: Marking nosave pages: [mem 0x8ad10000-0x8ad52fff]
[    9.310392] PM: hibernation: Marking nosave pages: [mem 0x8ad62000-0x8ad8efff]
[    9.310394] PM: hibernation: Marking nosave pages: [mem 0x8ae39000-0x8ae8efff]
[    9.310396] PM: hibernation: Marking nosave pages: [mem 0x8aed2000-0x8aefefff]
[    9.310397] PM: hibernation: Marking nosave pages: [mem 0x8af84000-0x8afeffff]
[    9.310400] PM: hibernation: Marking nosave pages: [mem 0x8b000000-0xffffffff]
[    9.311431] PM: hibernation: Basic memory bitmaps created
[    9.312044] PM: hibernation: Basic memory bitmaps freed
[    9.488487] EXT4-fs (nvme0n1p4): mounted filesystem with ordered data mode. Quota mode: disabled.
[    9.626182] udevd[1202]: starting version 3.2.9
[    9.650687] udevd[1203]: starting eudev-3.2.9
[    9.715800] Linux agpgart interface v0.103
[    9.720345] ACPI: bus type drm_connector registered
[    9.723832] tg3 0000:0d:00.0 eth2: renamed from eth0
[    9.735068] input: bcm5974 as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.2/input/input7
[    9.736818] usbcore: registered new interface driver bcm5974
[    9.759499] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    9.761144] checking generic (a0000000 fa0000) vs hw (b0000000 400000)
[    9.761147] checking generic (a0000000 fa0000) vs hw (a0000000 10000000)
[    9.761149] fb0: switching to i915 from EFI VGA
[    9.763668] Console: switching to colour dummy device 80x25
[    9.763762] i915 0000:00:02.0: vgaarb: deactivate vga console
[    9.763815] i915 0000:00:02.0: [drm] Transparent Hugepage support is recommended for optimal performance when IOMMU is enabled!
[    9.763841] i915 0000:00:02.0: [drm] DMAR active, disabling use of stolen memory
[    9.765235] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    9.787412] snd_hda_codec_cirrus hdaudioC1D0: autoconfig for CS4208: line_outs=2 (0x12/0x13/0x0/0x0/0x0) type:speaker
[    9.787426] snd_hda_codec_cirrus hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    9.787432] snd_hda_codec_cirrus hdaudioC1D0:    hp_outs=1 (0x10/0x0/0x0/0x0/0x0)
[    9.787437] snd_hda_codec_cirrus hdaudioC1D0:    mono: mono_out=0x0
[    9.787440] snd_hda_codec_cirrus hdaudioC1D0:    dig-out=0x21/0x0
[    9.787444] snd_hda_codec_cirrus hdaudioC1D0:    inputs:
[    9.787448] snd_hda_codec_cirrus hdaudioC1D0:      Internal Mic=0x1c
[    9.787452] snd_hda_codec_cirrus hdaudioC1D0:      Mic=0x18
[    9.793855] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    9.796215] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input8
[    9.796273] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[    9.796321] input: HDA Intel PCH SPDIF as /devices/pci0000:00/0000:00:1b.0/sound/card1/input10
[    9.840183] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[    9.841031] ACPI: video: Video Device [IGPU] (multi-head: yes  rom: no  post: no)
[    9.841583] acpi device:02: registered as cooling_device4
[    9.841663] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input11
[    9.841944] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    9.848448] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    9.848605] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    9.848613] cfg80211: failed to load regulatory.db
[    9.873457] udevd[1239]: Unable to EVIOCGABS device "/dev/input/event6"
[    9.873469] udevd[1239]: Unable to EVIOCGABS device "/dev/input/event6"
[    9.873475] udevd[1239]: Unable to EVIOCGABS device "/dev/input/event6"
[    9.873481] udevd[1239]: Unable to EVIOCGABS device "/dev/input/event6"
[   10.000001] fbcon: i915drmfb (fb0) is primary device
[   11.524322] Console: switching to colour frame buffer device 320x90
[   11.543615] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[   11.676895] Bluetooth: Core ver 2.22
[   11.676936] brcmfmac 0000:03:00.0: enabling device (0000 -> 0002)
[   11.676943] NET: Registered PF_BLUETOOTH protocol family
[   11.676977] Bluetooth: HCI device and connection manager initialized
[   11.676999] Bluetooth: HCI socket layer initialized
[   11.677025] Bluetooth: L2CAP socket layer initialized
[   11.677052] Bluetooth: SCO socket layer initialized
[   11.679532] usbcore: registered new interface driver btusb
[   11.683987] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input12
[   11.684081] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input13
[   11.684429] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input14
[   11.685686] input: HDA Intel HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/sound/card0/input15
[   11.685898] input: HDA Intel HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.0/sound/card0/input16
[   11.793460] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43602-pcie for chip BCM43602/1
[   11.793969] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.Apple Inc.-MacBookPro11,1.bin failed with error -2
[   11.794817] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.Apple Inc.-MacBookPro11,1.txt failed with error -2
[   11.794856] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.txt failed with error -2
[   11.818432] Bluetooth: hci0: BCM: chip id 102 build 0729
[   11.819357] Bluetooth: hci0: BCM: product 05ac:8290
[   11.822359] Bluetooth: hci0: BCM: features 0x2f
[   11.838382] Bluetooth: hci0: BlueZ 5.50
[   11.915018] Adding 19528700k swap on /dev/mapper/swap.  Priority:-2 extents:1 across:19528700k SS
[   11.926745] EXT4-fs (nvme0n1p4): re-mounted. Quota mode: disabled.
[   12.314862] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43602-pcie for chip BCM43602/1
[   12.314891] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
[   12.315047] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43602/1 wl0: Nov 10 2015 06:38:10 version 7.35.177.61 (r598657) FWID 01-ea662a8c
[   28.830754] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Quota mode: disabled.
[   29.035598] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   32.768984] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   32.768988] Bluetooth: BNEP filters: protocol multicast
[   32.768992] Bluetooth: BNEP socket layer initialized
[   33.129703] broken atomic modeset userspace detected, disabling atomic
[   47.554508] ieee80211 phy0: brcmf_cfg80211_scan: Connecting: status (3)
[   48.554854] ieee80211 phy0: brcmf_cfg80211_scan: Connecting: status (3)
[   49.556163] ieee80211 phy0: brcmf_cfg80211_scan: Connecting: status (3)
[   54.078657] irq 9: nobody cared (try booting with the "irqpoll" option)
[   54.078676] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.17.0+ #45
[   54.078690] Hardware name: Apple Inc. MacBookPro11,1/Mac-189A3D4F975D5FFC, BIOS 432.60.3.0.0 10/27/2021
[   54.078707] Call Trace:
[   54.078716]  <IRQ>
[   54.078724]  dump_stack_lvl+0x38/0x49
[   54.078738]  dump_stack+0x10/0x12
[   54.078749]  __report_bad_irq+0x37/0xb1
[   54.078761]  note_interrupt.cold.11+0xb/0x5c
[   54.078773]  handle_irq_event_percpu+0x33/0x40
[   54.078786]  handle_irq_event+0x34/0x60
[   54.078797]  handle_fasteoi_irq+0x8b/0x130
[   54.078809]  __common_interrupt+0x39/0x90
[   54.078821]  common_interrupt+0x85/0xa0
[   54.078834]  </IRQ>
[   54.078841]  <TASK>
[   54.078849]  asm_common_interrupt+0x1e/0x40
[   54.078860] RIP: 0010:cpuidle_enter_state+0xc9/0x360
[   54.078875] Code: 89 c4 0f 1f 44 00 00 31 ff e8 23 dc b5 ff 80 7d d7 00 74 12 9c 58 f6 c4 02 0f 85 54 02 00 00 31 ff e8 1b 55 ba ff fb 45 85 ff <0f> 88 0e 01 00 00 49 63 cf 4c 2b 65 c8 48 89 c8 48 6b d1 68 48 c1
[   54.078902] RSP: 0018:ffffa0de401cfe60 EFLAGS: 00000202
[   54.078915] RAX: ffffa0e19f2a9140 RBX: 0000000000000001 RCX: 000000000000001f
[   54.078929] RDX: 0000000c975683a8 RSI: 00000000313b14ef RDI: 0000000000000000
[   54.078942] RBP: ffffa0de401cfe98 R08: 0000000000000002 R09: 0000000000028a00
[   54.078956] R10: 00000028f4f6becb R11: ffffa0e19f2a82a4 R12: 0000000c975683a8
[   54.078970] R13: ffffd9c0bfcb2d10 R14: ffffffff8b1aa760 R15: 0000000000000001
[   54.078984]  cpuidle_enter+0x29/0x40
[   54.078995]  call_cpuidle+0x1e/0x30
[   54.079006]  do_idle+0x1ed/0x210
[   54.079018]  cpu_startup_entry+0x18/0x20
[   54.079029]  start_secondary+0xed/0x110
[   54.079042]  secondary_startup_64_no_verify+0xc3/0xcb
[   54.079055]  </TASK>
[   54.079063] handlers:
[   54.079071] [<000000005d571592>] acpi_irq
[   54.079084] Disabling IRQ #9
[   55.748825] ieee80211 phy0: brcmf_inetaddr_changed: fail to get arp ip table err:-52

MacBookPro - Rear Port :
[    0.000000] Linux version 5.17.0+ (brad@bklaptop) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #45 SMP PREEMPT_DYNAMIC Fri Apr 1 13:30:02 AWST 2022
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
[    0.000000] e820: update [mem 0x73d4c190-0x73d5c1cf] usable ==> usable
[    0.000000] e820: update [mem 0x73d4c190-0x73d5c1cf] usable ==> usable
[    0.000000] e820: update [mem 0x73d6f190-0x73d6fd98] usable ==> usable
[    0.000000] e820: update [mem 0x73d6f190-0x73d6fd98] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000008efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000073d4c18f] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d4c190-0x0000000073d5c1cf] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d5c1d0-0x0000000073d6f18f] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d6f190-0x0000000073d6fd98] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d6fd99-0x000000008ad0ffff] usable
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
[    0.000000] tsc: Detected 2599.779 MHz processor
[    0.000103] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000106] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000114] last_pfn = 0x46f600 max_arch_pfn = 0x400000000
[    0.000201] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001081] last_pfn = 0x8b000 max_arch_pfn = 0x400000000
[    0.001127] Using GB pages for direct mapping
[    0.002100] Secure boot disabled
[    0.002101] RAMDISK: [mem 0x7076e000-0x70e90fff]
[    0.002104] ACPI: Early table checksum verification disabled
[    0.002106] ACPI: RSDP 0x000000008AD8E014 000024 (v02 APPLE )
[    0.002111] ACPI: XSDT 0x000000008AD8E1C0 0000A4 (v01 APPLE  Apple00  00000000      01000013)
[    0.002116] ACPI: FACP 0x000000008AD8C000 0000F4 (v05 APPLE  Apple00  00000000 Loki 0000005F)
[    0.002122] ACPI: DSDT 0x000000008AD7F000 007681 (v03 APPLE  MacBookP 00110001 INTL 20100915)
[    0.002125] ACPI: FACS 0x000000008AD18000 000040
[    0.002128] ACPI: FACS 0x000000008AD18000 000040
[    0.002131] ACPI: HPET 0x000000008AD8B000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002134] ACPI: APIC 0x000000008AD8A000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002137] ACPI: SBST 0x000000008AD88000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002140] ACPI: ECDT 0x000000008AD87000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002143] ACPI: SSDT 0x000000008AD7E000 00010B (v01 APPLE  SataAhci 00001000 INTL 20100915)
[    0.002146] ACPI: SSDT 0x000000008AD7D000 000024 (v01 APPLE  SmcDppt  00001000 INTL 20100915)
[    0.002149] ACPI: SSDT 0x000000008AD7A000 000FE9 (v01 APPLE  SDUsbLpt 00001000 INTL 20100915)
[    0.002152] ACPI: SSDT 0x000000008AD76000 000032 (v01 APPLE  SsdtS3   00001000 INTL 20100915)
[    0.002155] ACPI: SSDT 0x000000008AD73000 0028B2 (v01 APPLE  PcieTbt  00001000 INTL 20100915)
[    0.002158] ACPI: SSDT 0x000000008AD66000 0000B8 (v01 APPLE  Sdxc     00001000 INTL 20100915)
[    0.002161] ACPI: SSDT 0x000000008AD65000 0003E0 (v01 APPLE  SaHdaCdc 00001000 INTL 20100915)
[    0.002164] ACPI: SSDT 0x000000008AD64000 000594 (v01 PmRef  Cpu0Ist  00003000 INTL 20100915)
[    0.002167] ACPI: SSDT 0x000000008AD63000 000B83 (v01 PmRef  CpuPm    00003000 INTL 20100915)
[    0.002170] ACPI: DMAR 0x000000008AD62000 000088 (v01 APPLE  HSW      00000001 AAPL 00000001)
[    0.002173] ACPI: MCFG 0x000000008AD89000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002176] ACPI: Reserving FACP table memory at [mem 0x8ad8c000-0x8ad8c0f3]
[    0.002178] ACPI: Reserving DSDT table memory at [mem 0x8ad7f000-0x8ad86680]
[    0.002179] ACPI: Reserving FACS table memory at [mem 0x8ad18000-0x8ad1803f]
[    0.002180] ACPI: Reserving FACS table memory at [mem 0x8ad18000-0x8ad1803f]
[    0.002181] ACPI: Reserving HPET table memory at [mem 0x8ad8b000-0x8ad8b037]
[    0.002182] ACPI: Reserving APIC table memory at [mem 0x8ad8a000-0x8ad8a0bb]
[    0.002183] ACPI: Reserving SBST table memory at [mem 0x8ad88000-0x8ad8802f]
[    0.002185] ACPI: Reserving ECDT table memory at [mem 0x8ad87000-0x8ad87052]
[    0.002186] ACPI: Reserving SSDT table memory at [mem 0x8ad7e000-0x8ad7e10a]
[    0.002187] ACPI: Reserving SSDT table memory at [mem 0x8ad7d000-0x8ad7d023]
[    0.002188] ACPI: Reserving SSDT table memory at [mem 0x8ad7a000-0x8ad7afe8]
[    0.002189] ACPI: Reserving SSDT table memory at [mem 0x8ad76000-0x8ad76031]
[    0.002190] ACPI: Reserving SSDT table memory at [mem 0x8ad73000-0x8ad758b1]
[    0.002191] ACPI: Reserving SSDT table memory at [mem 0x8ad66000-0x8ad660b7]
[    0.002193] ACPI: Reserving SSDT table memory at [mem 0x8ad65000-0x8ad653df]
[    0.002194] ACPI: Reserving SSDT table memory at [mem 0x8ad64000-0x8ad64593]
[    0.002195] ACPI: Reserving SSDT table memory at [mem 0x8ad63000-0x8ad63b82]
[    0.002196] ACPI: Reserving DMAR table memory at [mem 0x8ad62000-0x8ad62087]
[    0.002197] ACPI: Reserving MCFG table memory at [mem 0x8ad89000-0x8ad8903b]
[    0.002204] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.002223] Zone ranges:
[    0.002224]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002226]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002228]   Normal   [mem 0x0000000100000000-0x000000046f5fffff]
[    0.002230] Movable zone start for each node
[    0.002231] Early memory node ranges
[    0.002232]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.002234]   node   0: [mem 0x0000000000059000-0x000000000008efff]
[    0.002235]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.002236]   node   0: [mem 0x0000000000100000-0x000000008ad0ffff]
[    0.002237]   node   0: [mem 0x000000008ad53000-0x000000008ad61fff]
[    0.002238]   node   0: [mem 0x000000008ad8f000-0x000000008ae38fff]
[    0.002239]   node   0: [mem 0x000000008ae8f000-0x000000008aed1fff]
[    0.002240]   node   0: [mem 0x000000008aeff000-0x000000008af83fff]
[    0.002241]   node   0: [mem 0x000000008aff0000-0x000000008affffff]
[    0.002242]   node   0: [mem 0x0000000100000000-0x000000046f5fffff]
[    0.002244] Initmem setup node 0 [mem 0x0000000000001000-0x000000046f5fffff]
[    0.002248] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002250] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002251] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002276] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.006040] On node 0, zone DMA32: 67 pages in unavailable ranges
[    0.006046] On node 0, zone DMA32: 45 pages in unavailable ranges
[    0.006048] On node 0, zone DMA32: 86 pages in unavailable ranges
[    0.006051] On node 0, zone DMA32: 45 pages in unavailable ranges
[    0.006053] On node 0, zone DMA32: 108 pages in unavailable ranges
[    0.030221] On node 0, zone Normal: 20480 pages in unavailable ranges
[    0.030252] On node 0, zone Normal: 2560 pages in unavailable ranges
[    0.030260] Reserving Intel graphics memory at [mem 0x8ba00000-0x8f9fffff]
[    0.030380] ACPI: PM-Timer IO Port: 0x1808
[    0.030387] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.030389] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.030390] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.030391] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.030392] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.030393] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.030394] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.030395] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.030405] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-39
[    0.030408] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.030411] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.030414] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.030416] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.030419] TSC deadline timer available
[    0.030420] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.030441] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.030444] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.030446] PM: hibernation: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.030448] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
[    0.030449] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.030451] PM: hibernation: Registered nosave memory: [mem 0x73d4c000-0x73d4cfff]
[    0.030454] PM: hibernation: Registered nosave memory: [mem 0x73d5c000-0x73d5cfff]
[    0.030456] PM: hibernation: Registered nosave memory: [mem 0x73d6f000-0x73d6ffff]
[    0.030458] PM: hibernation: Registered nosave memory: [mem 0x73d6f000-0x73d6ffff]
[    0.030460] PM: hibernation: Registered nosave memory: [mem 0x8ad10000-0x8ad52fff]
[    0.030462] PM: hibernation: Registered nosave memory: [mem 0x8ad62000-0x8ad8efff]
[    0.030464] PM: hibernation: Registered nosave memory: [mem 0x8ae39000-0x8ae8efff]
[    0.030466] PM: hibernation: Registered nosave memory: [mem 0x8aed2000-0x8aefefff]
[    0.030468] PM: hibernation: Registered nosave memory: [mem 0x8af84000-0x8afeffff]
[    0.030470] PM: hibernation: Registered nosave memory: [mem 0x8b000000-0x8f9fffff]
[    0.030471] PM: hibernation: Registered nosave memory: [mem 0x8fa00000-0xe00f7fff]
[    0.030472] PM: hibernation: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.030473] PM: hibernation: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff]
[    0.030474] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.030475] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xffe0ffff]
[    0.030476] PM: hibernation: Registered nosave memory: [mem 0xffe10000-0xffe3ffff]
[    0.030477] PM: hibernation: Registered nosave memory: [mem 0xffe40000-0xffffffff]
[    0.030479] [mem 0x8fa00000-0xe00f7fff] available for PCI devices
[    0.030484] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.030490] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.030670] percpu: Embedded 52 pages/cpu s173096 r8192 d31704 u524288
[    0.030679] pcpu-alloc: s173096 r8192 d31704 u524288 alloc=1*2097152
[    0.030681] pcpu-alloc: [0] 0 1 2 3
[    0.030703] Built 1 zonelists, mobility grouping on.  Total pages: 4105486
[    0.030705] Kernel command line: ro root=UUID=c500d66c-50ec-42a2-a333-eb48d6c9d97b thunderbolt.dyndbg initrd=boot\initrd.img-5.17.0+
[    0.031569] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.031982] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.032022] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.080053] Memory: 15923600K/16683256K available (10248K kernel code, 2251K rwdata, 2740K rodata, 996K init, 740K bss, 759396K reserved, 0K cma-reserved)
[    0.080085] random: get_random_u64 called from cache_random_seq_create+0x63/0x150 with crng_init=0
[    0.080154] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.080789] Dynamic Preempt: voluntary
[    0.080815] rcu: Preemptible hierarchical RCU implementation.
[    0.080817] 	Trampoline variant of Tasks RCU enabled.
[    0.080818] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.081785] NR_IRQS: 4352, nr_irqs: 728, preallocated irqs: 16
[    0.082010] Console: colour dummy device 80x25
[    0.082339] printk: console [tty0] enabled
[    0.082348] ACPI: Core revision 20211217
[    0.082447] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.082450] APIC: Switch to symmetric I/O mode setup
[    0.082453] DMAR: Host address width 39
[    0.082455] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.082461] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020660462 ecap f0101a
[    0.082466] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.082471] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008020660462 ecap f010da
[    0.082475] DMAR: RMRR base: 0x0000008b800000 end: 0x0000008f9fffff
[    0.082479] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.082481] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.083078] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.083566] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x25796b619e5, max_idle_ns: 440795290627 ns
[    0.083576] Calibrating delay loop (skipped), value calculated using timer frequency.. 5199.55 BogoMIPS (lpj=25997790)
[    0.083581] pid_max: default: 32768 minimum: 301
[    0.093573] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.093573] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.093573] CPU0: Thermal monitoring enabled (TM1)
[    0.093573] process: using mwait in idle threads
[    0.093573] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.093573] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.093573] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.093573] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.093573] Spectre V2 : Vulnerable
[    0.093573] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.093573] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.093573] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.093573] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.093573] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.093573] SRBDS: Mitigation: Microcode
[    0.093573] MDS: Mitigation: Clear CPU buffers
[    0.093573] Freeing SMP alternatives memory: 28K
[    0.093573] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1220
[    0.093573] smpboot: CPU0: Intel(R) Core(TM) i5-4278U CPU @ 2.60GHz (family: 0x6, model: 0x45, stepping: 0x1)
[    0.093573] cblist_init_generic: Setting adjustable number of callback queues.
[    0.093573] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.093573] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.093573] ... version:                3
[    0.093573] ... bit width:              48
[    0.093573] ... generic registers:      4
[    0.093573] ... value mask:             0000ffffffffffff
[    0.093573] ... max period:             00007fffffffffff
[    0.093573] ... fixed-purpose events:   3
[    0.093573] ... event mask:             000000070000000f
[    0.093573] rcu: Hierarchical SRCU implementation.
[    0.093573] smp: Bringing up secondary CPUs ...
[    0.093573] x86: Booting SMP configuration:
[    0.093573] .... node  #0, CPUs:      #1 #2
[    0.093573] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.093573]  #3
[    0.093573] smp: Brought up 1 node, 4 CPUs
[    0.093573] smpboot: Max logical packages: 1
[    0.093573] smpboot: Total of 4 processors activated (20798.23 BogoMIPS)
[    0.093573] devtmpfs: initialized
[    0.093573] ACPI: PM: Registering ACPI NVS region [mem 0x8ad10000-0x8ad52fff] (274432 bytes)
[    0.093573] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.093573] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.093573] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.093573] thermal_sys: Registered thermal governor 'step_wise'
[    0.093573] thermal_sys: Registered thermal governor 'user_space'
[    0.093573] cpuidle: using governor ladder
[    0.093573] cpuidle: using governor menu
[    0.093573] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.093573] PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem 0xe0000000-0xe9bfffff] (base 0xe0000000)
[    0.093573] PCI: not using MMCONFIG
[    0.093573] PCI: Using configuration type 1 for base access
[    0.093573] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.093573] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.093573] cryptd: max_cpu_qlen set to 1000
[    0.093573] ACPI: Disabled all _OSI OS vendors
[    0.093573] ACPI: Added _OSI(Module Device)
[    0.093573] ACPI: Added _OSI(Processor Device)
[    0.093573] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.093573] ACPI: Added _OSI(Processor Aggregator Device)
[    0.093573] ACPI: Added _OSI(Linux-Dell-Video)
[    0.093573] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.093573] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.093573] ACPI: Added _OSI(Darwin)
[    0.095353] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.095719] ACPI: EC: EC started
[    0.095722] ACPI: EC: interrupt blocked
[    0.097059] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.097062] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.097246] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.097561] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.097598] ACPI Error: Needed type [Reference], found [Integer] 000000004953a05e (20211217/exresop-69)
[    0.097598] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20211217/dswexec-434)
[    0.097598] ACPI Error: Aborting method \_PR.CPU0._PDC due to previous error (AE_AML_OPERAND_TYPE) (20211217/psparse-531)
[    0.097598] ACPI: Dynamic OEM Table Load:
[    0.097598] ACPI: SSDT 0xFFFF9195C0AF5000 00067C (v01 PmRef  ApIst    00003000 INTL 20100915)
[    0.097598] ACPI: Dynamic OEM Table Load:
[    0.097598] ACPI: SSDT 0xFFFF9195C0C8FE00 000119 (v01 PmRef  ApCst    00003000 INTL 20100915)
[    0.097598] ACPI: Interpreter enabled
[    0.097598] ACPI: PM: (supports S0 S3 S4 S5)
[    0.097598] ACPI: Using IOAPIC for interrupt routing
[    0.097598] PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem 0xe0000000-0xe9bfffff] (base 0xe0000000)
[    0.097598] PCI: MMCONFIG at [mem 0xe0000000-0xe9bfffff] reserved in ACPI motherboard resources
[    0.097598] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.097598] ACPI: Enabled 4 GPEs in block 00 to 7F
[    0.107437] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.107444] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.107450] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-9b] only partially covers this bridge
[    0.107606] PCI host bridge to bus 0000:00
[    0.107609] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.107612] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.107615] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.107618] pci_bus 0000:00: root bus resource [mem 0x8fa00000-0xfeafffff window]
[    0.107622] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.107625] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.107636] pci 0000:00:00.0: [8086:0a04] type 00 class 0x060000
[    0.107713] pci 0000:00:02.0: [8086:0a2e] type 00 class 0x030000
[    0.107722] pci 0000:00:02.0: reg 0x10: [mem 0xb0000000-0xb03fffff 64bit]
[    0.107729] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xafffffff 64bit pref]
[    0.107735] pci 0000:00:02.0: reg 0x20: [io  0x2000-0x203f]
[    0.107746] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.107750] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.107839] pci 0000:00:03.0: [8086:0a0c] type 00 class 0x040300
[    0.107848] pci 0000:00:03.0: reg 0x10: [mem 0xb0c10000-0xb0c13fff 64bit]
[    0.107964] pci 0000:00:14.0: [8086:9c31] type 00 class 0x0c0330
[    0.107980] pci 0000:00:14.0: reg 0x10: [mem 0xb0c00000-0xb0c0ffff 64bit]
[    0.108030] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.108213] pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
[    0.108231] pci 0000:00:16.0: reg 0x10: [mem 0xb0c2a100-0xb0c2a11f 64bit]
[    0.108292] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.108344] pci 0000:00:1b.0: [8086:9c20] type 00 class 0x040300
[    0.108359] pci 0000:00:1b.0: reg 0x10: [mem 0xb0c14000-0xb0c17fff 64bit]
[    0.108420] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.108479] pci 0000:00:1c.0: [8086:9c10] type 01 class 0x060400
[    0.108539] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.108555] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    0.108558] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    0.108648] pci 0000:00:1c.1: [8086:9c12] type 01 class 0x060400
[    0.108715] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.108731] pci 0000:00:1c.1: Enabling MPC IRBNCE
[    0.108734] pci 0000:00:1c.1: Intel PCH root port ACS workaround enabled
[    0.108824] pci 0000:00:1c.2: [8086:9c14] type 01 class 0x060400
[    0.108890] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.108906] pci 0000:00:1c.2: Enabling MPC IRBNCE
[    0.108909] pci 0000:00:1c.2: Intel PCH root port ACS workaround enabled
[    0.108997] pci 0000:00:1c.4: [8086:9c18] type 01 class 0x060400
[    0.109063] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.109078] pci 0000:00:1c.4: Enabling MPC IRBNCE
[    0.109081] pci 0000:00:1c.4: Intel PCH root port ACS workaround enabled
[    0.109175] pci 0000:00:1c.5: [8086:9c1a] type 01 class 0x060400
[    0.109242] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.109258] pci 0000:00:1c.5: Enabling MPC IRBNCE
[    0.109260] pci 0000:00:1c.5: Intel PCH root port ACS workaround enabled
[    0.109353] pci 0000:00:1f.0: [8086:9c43] type 00 class 0x060100
[    0.109503] pci 0000:00:1f.3: [8086:9c22] type 00 class 0x0c0500
[    0.109518] pci 0000:00:1f.3: reg 0x10: [mem 0xb0c2a000-0xb0c2a0ff 64bit]
[    0.109536] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.109619] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.109679] pci 0000:02:00.0: [14e4:1570] type 00 class 0x048000
[    0.109702] pci 0000:02:00.0: reg 0x10: [mem 0xb0b00000-0xb0b0ffff 64bit]
[    0.109718] pci 0000:02:00.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.109734] pci 0000:02:00.0: reg 0x20: [mem 0xb0a00000-0xb0afffff 64bit]
[    0.109827] pci 0000:02:00.0: supports D1
[    0.109830] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.109933] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.109939] pci 0000:00:1c.1:   bridge window [mem 0xb0a00000-0xb0bfffff]
[    0.109944] pci 0000:00:1c.1:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.110003] pci 0000:03:00.0: [14e4:43ba] type 00 class 0x028000
[    0.110027] pci 0000:03:00.0: reg 0x10: [mem 0xb0800000-0xb0807fff 64bit]
[    0.110042] pci 0000:03:00.0: reg 0x18: [mem 0xb0400000-0xb07fffff 64bit]
[    0.110164] pci 0000:03:00.0: supports D1 D2
[    0.110166] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.110308] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.110314] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb08fffff]
[    0.110378] pci 0000:05:00.0: [8086:156d] type 01 class 0x060400
[    0.110432] pci 0000:05:00.0: enabling Extended Tags
[    0.110515] pci 0000:05:00.0: supports D1 D2
[    0.110517] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.133601] pci 0000:00:1c.4: PCI bridge to [bus 05-6b]
[    0.133607] pci 0000:00:1c.4:   bridge window [io  0x3000-0x5fff]
[    0.133611] pci 0000:00:1c.4:   bridge window [mem 0xb0d00000-0xbd1fffff]
[    0.133617] pci 0000:00:1c.4:   bridge window [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.133721] pci 0000:06:00.0: [8086:156d] type 01 class 0x060400
[    0.133779] pci 0000:06:00.0: enabling Extended Tags
[    0.133863] pci 0000:06:00.0: supports D1 D2
[    0.133865] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.133977] pci 0000:06:03.0: [8086:156d] type 01 class 0x060400
[    0.134034] pci 0000:06:03.0: enabling Extended Tags
[    0.134118] pci 0000:06:03.0: supports D1 D2
[    0.134120] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134228] pci 0000:06:04.0: [8086:156d] type 01 class 0x060400
[    0.134278] pci 0000:06:04.0: enabling Extended Tags
[    0.134365] pci 0000:06:04.0: supports D1 D2
[    0.134367] pci 0000:06:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134471] pci 0000:06:05.0: [8086:156d] type 01 class 0x060400
[    0.134520] pci 0000:06:05.0: enabling Extended Tags
[    0.134607] pci 0000:06:05.0: supports D1 D2
[    0.134609] pci 0000:06:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134713] pci 0000:06:06.0: [8086:156d] type 01 class 0x060400
[    0.134763] pci 0000:06:06.0: enabling Extended Tags
[    0.134849] pci 0000:06:06.0: supports D1 D2
[    0.134851] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134961] pci 0000:05:00.0: PCI bridge to [bus 06-6b]
[    0.134968] pci 0000:05:00.0:   bridge window [io  0x3000-0x4fff]
[    0.134973] pci 0000:05:00.0:   bridge window [mem 0xb0d00000-0xb91fffff]
[    0.134981] pci 0000:05:00.0:   bridge window [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.135057] pci 0000:07:00.0: [8086:156c] type 00 class 0x088000
[    0.135081] pci 0000:07:00.0: reg 0x10: [mem 0xb0d00000-0xb0d3ffff]
[    0.135094] pci 0000:07:00.0: reg 0x14: [mem 0xb0d40000-0xb0d40fff]
[    0.135161] pci 0000:07:00.0: enabling Extended Tags
[    0.135272] pci 0000:07:00.0: supports D1 D2
[    0.135274] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.163610] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.163621] pci 0000:06:00.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[    0.163739] pci 0000:08:00.0: [8086:1513] type 01 class 0x060400
[    0.163844] pci 0000:08:00.0: enabling Extended Tags
[    0.163998] pci 0000:08:00.0: supports D1 D2
[    0.164000] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.193609] pci 0000:06:03.0: PCI bridge to [bus 08-38]
[    0.193617] pci 0000:06:03.0:   bridge window [io  0x3000-0x3fff]
[    0.193622] pci 0000:06:03.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[    0.193630] pci 0000:06:03.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.193720] acpiphp: Slot [1] registered
[    0.193745] acpiphp: Slot [2] registered
[    0.193769] acpiphp: Slot [3] registered
[    0.193792] acpiphp: Slot [4] registered
[    0.193815] acpiphp: Slot [5] registered
[    0.193870] pci 0000:09:00.0: [8086:1513] type 01 class 0x060400
[    0.193980] pci 0000:09:00.0: enabling Extended Tags
[    0.194138] pci 0000:09:00.0: supports D1 D2
[    0.194140] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.194313] pci 0000:09:01.0: [8086:1513] type 01 class 0x060400
[    0.194422] pci 0000:09:01.0: enabling Extended Tags
[    0.194580] pci 0000:09:01.0: supports D1 D2
[    0.194582] pci 0000:09:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.194736] pci 0000:09:02.0: [8086:1513] type 01 class 0x060400
[    0.194846] pci 0000:09:02.0: enabling Extended Tags
[    0.195003] pci 0000:09:02.0: supports D1 D2
[    0.195005] pci 0000:09:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.195165] pci 0000:09:04.0: [8086:1513] type 01 class 0x060400
[    0.195275] pci 0000:09:04.0: enabling Extended Tags
[    0.195436] pci 0000:09:04.0: supports D1 D2
[    0.195438] pci 0000:09:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.195611] pci 0000:09:05.0: [8086:1513] type 01 class 0x060400
[    0.195705] pci 0000:09:05.0: enabling Extended Tags
[    0.195866] pci 0000:09:05.0: supports D1 D2
[    0.195868] pci 0000:09:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.196057] pci 0000:08:00.0: PCI bridge to [bus 09-18]
[    0.196074] pci 0000:08:00.0:   bridge window [mem 0xb0e00000-0xb11fffff]
[    0.196087] pci 0000:08:00.0:   bridge window [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.196179] acpiphp: Slot [1-1] registered
[    0.196237] pci 0000:0a:00.0: [12d8:400c] type 01 class 0x060400
[    0.196592] pci 0000:0a:00.0: supports D1 D2
[    0.196594] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.223615] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[    0.223634] pci 0000:09:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.223806] pci 0000:0b:03.0: [12d8:400c] type 01 class 0x060400
[    0.224115] pci 0000:0b:03.0: supports D1 D2
[    0.224118] pci 0000:0b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.224312] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[    0.224335] pci 0000:0a:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.224493] pci 0000:0c:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.224540] pci 0000:0c:00.0: reg 0x10: [mem 0xb1101000-0xb1101fff]
[    0.224828] pci 0000:0c:00.0: supports D1 D2
[    0.224830] pci 0000:0c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.224979] pci 0000:0c:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.225027] pci 0000:0c:00.1: reg 0x10: [mem 0xb1100000-0xb1100fff]
[    0.225315] pci 0000:0c:00.1: supports D1 D2
[    0.225317] pci 0000:0c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.225441] pci 0000:0c:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.225488] pci 0000:0c:00.2: reg 0x10: [mem 0xb1102000-0xb11020ff]
[    0.225775] pci 0000:0c:00.2: supports D1 D2
[    0.225777] pci 0000:0c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.226017] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[    0.226040] pci 0000:0b:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.226202] pci 0000:0d:00.0: [14e4:16b0] type 00 class 0x020000
[    0.226266] pci 0000:0d:00.0: reg 0x10: [mem 0xbd300000-0xbd30ffff 64bit pref]
[    0.226308] pci 0000:0d:00.0: reg 0x18: [mem 0xbd310000-0xbd31ffff 64bit pref]
[    0.226620] pci 0000:0d:00.0: PME# supported from D0 D3hot D3cold
[    0.253630] pci 0000:09:01.0: PCI bridge to [bus 0d]
[    0.253658] pci 0000:09:01.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.253770] pci 0000:0e:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.253834] pci 0000:0e:00.0: reg 0x10: [mem 0xb1000000-0xb1000fff 64bit]
[    0.254158] pci 0000:0e:00.0: supports D1 D2
[    0.254160] pci 0000:0e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.283629] pci 0000:09:02.0: PCI bridge to [bus 0e]
[    0.283647] pci 0000:09:02.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.283822] pci 0000:0f:00.0: [8086:1513] type 01 class 0x060400
[    0.283980] pci 0000:0f:00.0: enabling Extended Tags
[    0.284217] pci 0000:0f:00.0: supports D1 D2
[    0.284219] pci 0000:0f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.313620] pci 0000:09:04.0: PCI bridge to [bus 0f-17]
[    0.313639] pci 0000:09:04.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.313651] pci 0000:09:04.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.313774] acpiphp: Slot [1-2] registered
[    0.313800] acpiphp: Slot [2-1] registered
[    0.313826] acpiphp: Slot [3-1] registered
[    0.313851] acpiphp: Slot [4-1] registered
[    0.313933] pci 0000:10:00.0: [8086:1513] type 01 class 0x060400
[    0.314098] pci 0000:10:00.0: enabling Extended Tags
[    0.314340] pci 0000:10:00.0: supports D1 D2
[    0.314342] pci 0000:10:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.314586] pci 0000:10:01.0: [8086:1513] type 01 class 0x060400
[    0.314751] pci 0000:10:01.0: enabling Extended Tags
[    0.314991] pci 0000:10:01.0: supports D1 D2
[    0.314994] pci 0000:10:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.315220] pci 0000:10:02.0: [8086:1513] type 01 class 0x060400
[    0.315385] pci 0000:10:02.0: enabling Extended Tags
[    0.315625] pci 0000:10:02.0: supports D1 D2
[    0.315627] pci 0000:10:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.315857] pci 0000:10:04.0: [8086:1513] type 01 class 0x060400
[    0.315999] pci 0000:10:04.0: enabling Extended Tags
[    0.316243] pci 0000:10:04.0: supports D1 D2
[    0.316245] pci 0000:10:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.316491] pci 0000:10:05.0: [8086:1513] type 01 class 0x060400
[    0.316634] pci 0000:10:05.0: enabling Extended Tags
[    0.316878] pci 0000:10:05.0: supports D1 D2
[    0.316880] pci 0000:10:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.317151] pci 0000:0f:00.0: PCI bridge to [bus 10-17]
[    0.317176] pci 0000:0f:00.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.317194] pci 0000:0f:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.317311] acpiphp: Slot [1-3] registered
[    0.317390] pci 0000:11:00.0: [12d8:400c] type 01 class 0x060400
[    0.317878] pci 0000:11:00.0: supports D1 D2
[    0.317880] pci 0000:11:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.318163] pci 0000:10:00.0: PCI bridge to [bus 11-13]
[    0.318188] pci 0000:10:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.318423] pci 0000:12:03.0: [12d8:400c] type 01 class 0x060400
[    0.318845] pci 0000:12:03.0: supports D1 D2
[    0.318847] pci 0000:12:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.319103] pci 0000:11:00.0: PCI bridge to [bus 12-13]
[    0.319134] pci 0000:11:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.319347] pci 0000:13:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.319411] pci 0000:13:00.0: reg 0x10: [mem 0xb0f01000-0xb0f01fff]
[    0.319805] pci 0000:13:00.0: supports D1 D2
[    0.319807] pci 0000:13:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.320009] pci 0000:13:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.320073] pci 0000:13:00.1: reg 0x10: [mem 0xb0f00000-0xb0f00fff]
[    0.320467] pci 0000:13:00.1: supports D1 D2
[    0.320469] pci 0000:13:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.320630] pci 0000:13:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.320693] pci 0000:13:00.2: reg 0x10: [mem 0xb0f02000-0xb0f020ff]
[    0.321087] pci 0000:13:00.2: supports D1 D2
[    0.321090] pci 0000:13:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.321425] pci 0000:12:03.0: PCI bridge to [bus 13]
[    0.321456] pci 0000:12:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.321681] pci 0000:14:00.0: [14e4:16b0] type 00 class 0x020000
[    0.321767] pci 0000:14:00.0: reg 0x10: [mem 0xbd200000-0xbd20ffff 64bit pref]
[    0.321823] pci 0000:14:00.0: reg 0x18: [mem 0xbd210000-0xbd21ffff 64bit pref]
[    0.322249] pci 0000:14:00.0: PME# supported from D0 D3hot D3cold
[    0.322565] pci 0000:10:01.0: PCI bridge to [bus 14]
[    0.322606] pci 0000:10:01.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.322761] pci 0000:15:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.322847] pci 0000:15:00.0: reg 0x10: [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.323286] pci 0000:15:00.0: supports D1 D2
[    0.323288] pci 0000:15:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.323582] pci 0000:10:02.0: PCI bridge to [bus 15]
[    0.323608] pci 0000:10:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.323746] pci 0000:10:04.0: PCI bridge to [bus 16]
[    0.323880] pci 0000:10:05.0: PCI bridge to [bus 17]
[    0.324082] pci 0000:09:05.0: PCI bridge to [bus 18]
[    0.324231] pci 0000:06:04.0: PCI bridge to [bus 39]
[    0.324301] pci 0000:06:05.0: PCI bridge to [bus 3a-6a]
[    0.324309] pci 0000:06:05.0:   bridge window [io  0x4000-0x4fff]
[    0.324314] pci 0000:06:05.0:   bridge window [mem 0xb5200000-0xb91fffff]
[    0.324321] pci 0000:06:05.0:   bridge window [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.324364] pci 0000:06:06.0: PCI bridge to [bus 6b]
[    0.324463] pci 0000:04:00.0: [1c5c:174a] type 00 class 0x010802
[    0.324488] pci 0000:04:00.0: reg 0x10: [mem 0xb0900000-0xb0903fff 64bit]
[    0.324499] pci 0000:04:00.0: reg 0x18: [mem 0xb0905000-0xb0905fff]
[    0.324511] pci 0000:04:00.0: reg 0x1c: [mem 0xb0904000-0xb0904fff]
[    0.324660] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:1c.5 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.324864] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.324870] pci 0000:00:1c.5:   bridge window [mem 0xb0900000-0xb09fffff]
[    0.324894] pci_bus 0000:00: on NUMA node 0
[    0.325634] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.325638] ACPI: PCI: Interrupt link LNKA disabled
[    0.325672] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.325674] ACPI: PCI: Interrupt link LNKB disabled
[    0.325706] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.325708] ACPI: PCI: Interrupt link LNKC disabled
[    0.325739] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.325741] ACPI: PCI: Interrupt link LNKD disabled
[    0.325772] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.325774] ACPI: PCI: Interrupt link LNKE disabled
[    0.325805] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.325808] ACPI: PCI: Interrupt link LNKF disabled
[    0.325840] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.325842] ACPI: PCI: Interrupt link LNKG disabled
[    0.325873] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.325875] ACPI: PCI: Interrupt link LNKH disabled
[    0.326024] ACPI: EC: interrupt unblocked
[    0.326027] ACPI: EC: event unblocked
[    0.326035] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.326039] ACPI: EC: GPE=0x4e
[    0.326042] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.326047] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.326103] iommu: Default domain type: Translated
[    0.326105] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.326147] SCSI subsystem initialized
[    0.326155] libata version 3.00 loaded.
[    0.326201] Registered efivars operations
[    0.326314] PCI: Using ACPI for IRQ routing
[    0.331503] PCI: pci_cache_line_size set to 64 bytes
[    0.331751] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.331753] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.331754] e820: reserve RAM buffer [mem 0x73d4c190-0x73ffffff]
[    0.331755] e820: reserve RAM buffer [mem 0x73d6f190-0x73ffffff]
[    0.331756] e820: reserve RAM buffer [mem 0x8ad10000-0x8bffffff]
[    0.331758] e820: reserve RAM buffer [mem 0x8ad62000-0x8bffffff]
[    0.331760] e820: reserve RAM buffer [mem 0x8ae39000-0x8bffffff]
[    0.331761] e820: reserve RAM buffer [mem 0x8aed2000-0x8bffffff]
[    0.331762] e820: reserve RAM buffer [mem 0x8af84000-0x8bffffff]
[    0.331763] e820: reserve RAM buffer [mem 0x8b000000-0x8bffffff]
[    0.331764] e820: reserve RAM buffer [mem 0x46f600000-0x46fffffff]
[    0.331779] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.331779] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.331779] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.331779] vgaarb: loaded
[    0.331779] clocksource: Switched to clocksource tsc-early
[    0.331779] pnp: PnP ACPI init
[    0.331779] system 00:00: [mem 0xfed00000-0xfed03fff] has been reserved
[    0.331779] system 00:01: [io  0xffff] has been reserved
[    0.331779] system 00:01: [io  0x1800-0x187f] has been reserved
[    0.331779] system 00:01: [io  0x0800-0x087f] has been reserved
[    0.331779] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.331779] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.331779] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.331779] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.331779] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.331779] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.331779] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.331779] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.331779] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[    0.331779] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.331779] system 00:04: [mem 0x20000000-0x201fffff] could not be reserved
[    0.331779] system 00:04: [mem 0x40000000-0x401fffff] could not be reserved
[    0.331779] pnp: PnP ACPI: found 5 devices
[    0.331779] pci 0000:00:02.0: assigning 3 device properties
[    0.331779] pci 0000:07:00.0: assigning 9 device properties
[    0.331779] pci 0000:08:00.0: assigning 3 device properties
[    0.331779] pci 0000:0f:00.0: assigning 3 device properties
[    0.331779] pci 0000:0e:00.0: assigning 2 device properties
[    0.331779] pci 0000:15:00.0: assigning 2 device properties
[    0.331779] pci 0000:00:1b.0: assigning 4 device properties
[    0.335657] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.335697] NET: Registered PF_INET protocol family
[    0.335860] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.338535] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.338572] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.338796] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.338940] TCP: Hash tables configured (established 131072 bind 65536)
[    0.338971] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.339013] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.339083] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.339158] RPC: Registered named UNIX socket transport module.
[    0.339162] RPC: Registered udp transport module.
[    0.339165] RPC: Registered tcp transport module.
[    0.339169] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.339181] pci 0000:06:00.0: bridge window [io  0x1000-0x0fff] to [bus 07] add_size 1000
[    0.339189] pci 0000:06:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 07] add_size 200000 add_align 100000
[    0.339203] pci 0000:10:04.0: bridge window [io  0x1000-0x0fff] to [bus 16] add_size 1000
[    0.339210] pci 0000:10:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 16] add_size 200000 add_align 100000
[    0.339217] pci 0000:10:04.0: bridge window [mem 0x00100000-0x000fffff] to [bus 16] add_size 200000 add_align 100000
[    0.339225] pci 0000:10:05.0: bridge window [io  0x1000-0x0fff] to [bus 17] add_size 1000
[    0.339231] pci 0000:10:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 17] add_size 200000 add_align 100000
[    0.339239] pci 0000:10:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 17] add_size 200000 add_align 100000
[    0.339247] pci 0000:0f:00.0: bridge window [io  0x1000-0x0fff] to [bus 10-17] add_size 2000
[    0.339254] pci 0000:09:04.0: bridge window [io  0x1000-0x0fff] to [bus 0f-17] add_size 3000
[    0.339261] pci 0000:09:05.0: bridge window [io  0x1000-0x0fff] to [bus 18] add_size 1000
[    0.339267] pci 0000:09:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 18] add_size 200000 add_align 100000
[    0.339275] pci 0000:09:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 18] add_size 200000 add_align 100000
[    0.339284] pci 0000:08:00.0: bridge window [io  0x1000-0x0fff] to [bus 09-18] add_size 4000
[    0.339291] pci 0000:06:04.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
[    0.339297] pci 0000:06:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
[    0.339305] pci 0000:06:04.0: bridge window [mem 0x00100000-0x000fffff] to [bus 39] add_size 200000 add_align 100000
[    0.339312] pci 0000:06:06.0: bridge window [io  0x1000-0x0fff] to [bus 6b] add_size 1000
[    0.339318] pci 0000:06:06.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6b] add_size 200000 add_align 100000
[    0.339326] pci 0000:06:06.0: bridge window [mem 0x00100000-0x000fffff] to [bus 6b] add_size 200000 add_align 100000
[    0.339338] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.339352] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.339359] pci 0000:00:1c.1:   bridge window [mem 0xb0a00000-0xb0bfffff]
[    0.339365] pci 0000:00:1c.1:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.339375] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.339381] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb08fffff]
[    0.339397] pci 0000:06:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339403] pci 0000:06:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339409] pci 0000:06:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339414] pci 0000:06:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339420] pci 0000:06:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339426] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339432] pci 0000:06:06.0: BAR 8: no space for [mem size 0x00200000]
[    0.339437] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339442] pci 0000:06:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339448] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339454] pci 0000:06:00.0: BAR 7: no space for [io  size 0x1000]
[    0.339459] pci 0000:06:00.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339464] pci 0000:06:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339469] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339474] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.339478] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339484] pci 0000:06:06.0: BAR 8: no space for [mem size 0x00200000]
[    0.339489] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339495] pci 0000:06:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339501] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339507] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.339511] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339516] pci 0000:06:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339521] pci 0000:06:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339527] pci 0000:06:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339533] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339539] pci 0000:06:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339543] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339549] pci 0000:06:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339555] pci 0000:06:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339561] pci 0000:06:00.0: BAR 7: no space for [io  size 0x1000]
[    0.339566] pci 0000:06:00.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339572] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.339580] pci 0000:06:00.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[    0.339594] pci 0000:08:00.0: BAR 7: no space for [io  size 0x4000]
[    0.339598] pci 0000:08:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.339603] pci 0000:08:00.0: BAR 7: no space for [io  size 0x4000]
[    0.339608] pci 0000:08:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.339615] pci 0000:09:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339620] pci 0000:09:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339626] pci 0000:09:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339632] pci 0000:09:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339637] pci 0000:09:04.0: BAR 7: no space for [io  size 0x3000]
[    0.339642] pci 0000:09:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.339647] pci 0000:09:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339652] pci 0000:09:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339657] pci 0000:09:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339662] pci 0000:09:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339668] pci 0000:09:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339673] pci 0000:09:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339679] pci 0000:09:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339684] pci 0000:09:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339689] pci 0000:09:04.0: BAR 7: no space for [io  size 0x3000]
[    0.339693] pci 0000:09:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.339699] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[    0.339714] pci 0000:0b:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339740] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[    0.339755] pci 0000:0a:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339781] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[    0.339793] pci 0000:09:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339814] pci 0000:09:01.0: PCI bridge to [bus 0d]
[    0.339831] pci 0000:09:01.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.339847] pci 0000:09:02.0: PCI bridge to [bus 0e]
[    0.339859] pci 0000:09:02.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.339880] pci 0000:0f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.339885] pci 0000:0f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.339890] pci 0000:0f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.339895] pci 0000:0f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.339901] pci 0000:10:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339906] pci 0000:10:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339913] pci 0000:10:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339918] pci 0000:10:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339924] pci 0000:10:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339929] pci 0000:10:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339935] pci 0000:10:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339941] pci 0000:10:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339946] pci 0000:10:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339951] pci 0000:10:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339956] pci 0000:10:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339961] pci 0000:10:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339966] pci 0000:10:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339971] pci 0000:10:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339977] pci 0000:10:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339982] pci 0000:10:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339988] pci 0000:10:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339993] pci 0000:10:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339998] pci 0000:10:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.340003] pci 0000:10:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.340009] pci 0000:10:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.340014] pci 0000:10:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.340020] pci 0000:10:04.0: BAR 7: no space for [io  size 0x1000]
[    0.340025] pci 0000:10:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.340031] pci 0000:12:03.0: PCI bridge to [bus 13]
[    0.340050] pci 0000:12:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.340084] pci 0000:11:00.0: PCI bridge to [bus 12-13]
[    0.340103] pci 0000:11:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.340137] pci 0000:10:00.0: PCI bridge to [bus 11-13]
[    0.340153] pci 0000:10:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.340181] pci 0000:10:01.0: PCI bridge to [bus 14]
[    0.340205] pci 0000:10:01.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340226] pci 0000:10:02.0: PCI bridge to [bus 15]
[    0.340242] pci 0000:10:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.340270] pci 0000:10:04.0: PCI bridge to [bus 16]
[    0.340309] pci 0000:10:05.0: PCI bridge to [bus 17]
[    0.340348] pci 0000:0f:00.0: PCI bridge to [bus 10-17]
[    0.340364] pci 0000:0f:00.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.340377] pci 0000:0f:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340398] pci 0000:09:04.0: PCI bridge to [bus 0f-17]
[    0.340410] pci 0000:09:04.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.340420] pci 0000:09:04.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340436] pci 0000:09:05.0: PCI bridge to [bus 18]
[    0.340464] pci 0000:08:00.0: PCI bridge to [bus 09-18]
[    0.340476] pci 0000:08:00.0:   bridge window [mem 0xb0e00000-0xb11fffff]
[    0.340486] pci 0000:08:00.0:   bridge window [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.340501] pci 0000:06:03.0: PCI bridge to [bus 08-38]
[    0.340507] pci 0000:06:03.0:   bridge window [io  0x3000-0x3fff]
[    0.340516] pci 0000:06:03.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[    0.340524] pci 0000:06:03.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.340535] pci 0000:06:04.0: PCI bridge to [bus 39]
[    0.340551] pci 0000:06:05.0: PCI bridge to [bus 3a-6a]
[    0.340556] pci 0000:06:05.0:   bridge window [io  0x4000-0x4fff]
[    0.340565] pci 0000:06:05.0:   bridge window [mem 0xb5200000-0xb91fffff]
[    0.340572] pci 0000:06:05.0:   bridge window [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.340583] pci 0000:06:06.0: PCI bridge to [bus 6b]
[    0.340600] pci 0000:05:00.0: PCI bridge to [bus 06-6b]
[    0.340605] pci 0000:05:00.0:   bridge window [io  0x3000-0x4fff]
[    0.340614] pci 0000:05:00.0:   bridge window [mem 0xb0d00000-0xb91fffff]
[    0.340621] pci 0000:05:00.0:   bridge window [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.340632] pci 0000:00:1c.4: PCI bridge to [bus 05-6b]
[    0.340637] pci 0000:00:1c.4:   bridge window [io  0x3000-0x5fff]
[    0.340644] pci 0000:00:1c.4:   bridge window [mem 0xb0d00000-0xbd1fffff]
[    0.340651] pci 0000:00:1c.4:   bridge window [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.340660] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.340667] pci 0000:00:1c.5:   bridge window [mem 0xb0900000-0xb09fffff]
[    0.340677] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.340682] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.340687] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.340693] pci_bus 0000:00: resource 7 [mem 0x8fa00000-0xfeafffff window]
[    0.340698] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff window]
[    0.340704] pci_bus 0000:02: resource 1 [mem 0xb0a00000-0xb0bfffff]
[    0.340709] pci_bus 0000:02: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.340714] pci_bus 0000:03: resource 1 [mem 0xb0400000-0xb08fffff]
[    0.340720] pci_bus 0000:05: resource 0 [io  0x3000-0x5fff]
[    0.340724] pci_bus 0000:05: resource 1 [mem 0xb0d00000-0xbd1fffff]
[    0.340729] pci_bus 0000:05: resource 2 [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.340735] pci_bus 0000:06: resource 0 [io  0x3000-0x4fff]
[    0.340740] pci_bus 0000:06: resource 1 [mem 0xb0d00000-0xb91fffff]
[    0.340744] pci_bus 0000:06: resource 2 [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.340750] pci_bus 0000:07: resource 1 [mem 0xb0d00000-0xb0dfffff]
[    0.340755] pci_bus 0000:08: resource 0 [io  0x3000-0x3fff]
[    0.340760] pci_bus 0000:08: resource 1 [mem 0xb0e00000-0xb51fffff]
[    0.340765] pci_bus 0000:08: resource 2 [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.340770] pci_bus 0000:09: resource 1 [mem 0xb0e00000-0xb11fffff]
[    0.340775] pci_bus 0000:09: resource 2 [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.340781] pci_bus 0000:0a: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340786] pci_bus 0000:0b: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340791] pci_bus 0000:0c: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340796] pci_bus 0000:0d: resource 2 [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.340802] pci_bus 0000:0e: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.340807] pci_bus 0000:0f: resource 1 [mem 0xb0e00000-0xb0ffffff]
[    0.340812] pci_bus 0000:0f: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340818] pci_bus 0000:10: resource 1 [mem 0xb0e00000-0xb0ffffff]
[    0.340822] pci_bus 0000:10: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340828] pci_bus 0000:11: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340833] pci_bus 0000:12: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340838] pci_bus 0000:13: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340843] pci_bus 0000:14: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340849] pci_bus 0000:15: resource 1 [mem 0xb0e00000-0xb0efffff]
[    0.340854] pci_bus 0000:3a: resource 0 [io  0x4000-0x4fff]
[    0.340859] pci_bus 0000:3a: resource 1 [mem 0xb5200000-0xb91fffff]
[    0.340863] pci_bus 0000:3a: resource 2 [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.340869] pci_bus 0000:04: resource 1 [mem 0xb0900000-0xb09fffff]
[    0.341265] pci 0000:05:00.0: CLS mismatch (256 != 128), using 64 bytes
[    0.341293] pci 0000:0c:00.0: MSI is not implemented on this device, disabling it
[    0.341298] pci 0000:0c:00.0: PME# is unreliable, disabling it
[    0.341682] pci 0000:0c:00.1: MSI is not implemented on this device, disabling it
[    0.341688] pci 0000:0c:00.1: PME# is unreliable, disabling it
[    0.341794] pci 0000:0c:00.2: MSI is not implemented on this device, disabling it
[    0.341799] pci 0000:0c:00.2: PME# is unreliable, disabling it
[    0.341864] pci 0000:0c:00.2: EHCI: unrecognized capability 00
[    0.341921] pci 0000:13:00.0: MSI is not implemented on this device, disabling it
[    0.341926] pci 0000:13:00.0: PME# is unreliable, disabling it
[    0.342247] pci 0000:13:00.1: MSI is not implemented on this device, disabling it
[    0.342253] pci 0000:13:00.1: PME# is unreliable, disabling it
[    0.342375] pci 0000:13:00.2: MSI is not implemented on this device, disabling it
[    0.342380] pci 0000:13:00.2: PME# is unreliable, disabling it
[    0.342457] pci 0000:13:00.2: EHCI: unrecognized capability 00
[    0.342537] DMAR: No ATSR found
[    0.342541] DMAR: No SATC found
[    0.342544] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.342546] DMAR: IOMMU feature sc_support inconsistent
[    0.342550] DMAR: IOMMU feature pass_through inconsistent
[    0.342553] Unpacking initramfs...
[    0.342554] DMAR: dmar0: Using Queued invalidation
[    0.342560] DMAR: dmar1: Using Queued invalidation
[    0.438762] pci 0000:00:00.0: Adding to iommu group 0
[    0.438795] pci 0000:00:02.0: Adding to iommu group 1
[    0.438815] pci 0000:00:03.0: Adding to iommu group 2
[    0.438836] pci 0000:00:14.0: Adding to iommu group 3
[    0.438868] pci 0000:00:16.0: Adding to iommu group 4
[    0.438887] pci 0000:00:1b.0: Adding to iommu group 5
[    0.438907] pci 0000:00:1c.0: Adding to iommu group 6
[    0.438927] pci 0000:00:1c.1: Adding to iommu group 7
[    0.438948] pci 0000:00:1c.2: Adding to iommu group 8
[    0.438968] pci 0000:00:1c.4: Adding to iommu group 9
[    0.438988] pci 0000:00:1c.5: Adding to iommu group 10
[    0.439025] pci 0000:00:1f.0: Adding to iommu group 11
[    0.439045] pci 0000:00:1f.3: Adding to iommu group 11
[    0.439064] pci 0000:02:00.0: Adding to iommu group 12
[    0.439083] pci 0000:03:00.0: Adding to iommu group 13
[    0.439103] pci 0000:05:00.0: Adding to iommu group 14
[    0.439123] pci 0000:06:00.0: Adding to iommu group 15
[    0.439142] pci 0000:06:03.0: Adding to iommu group 16
[    0.439163] pci 0000:06:04.0: Adding to iommu group 17
[    0.439184] pci 0000:06:05.0: Adding to iommu group 18
[    0.439204] pci 0000:06:06.0: Adding to iommu group 19
[    0.439213] pci 0000:07:00.0: Adding to iommu group 15
[    0.439222] pci 0000:08:00.0: Adding to iommu group 16
[    0.439230] pci 0000:09:00.0: Adding to iommu group 16
[    0.439239] pci 0000:09:01.0: Adding to iommu group 16
[    0.439249] pci 0000:09:02.0: Adding to iommu group 16
[    0.439258] pci 0000:09:04.0: Adding to iommu group 16
[    0.439267] pci 0000:09:05.0: Adding to iommu group 16
[    0.439276] pci 0000:0a:00.0: Adding to iommu group 16
[    0.439285] pci 0000:0b:03.0: Adding to iommu group 16
[    0.439293] pci 0000:0c:00.0: Adding to iommu group 16
[    0.439302] pci 0000:0c:00.1: Adding to iommu group 16
[    0.439310] pci 0000:0c:00.2: Adding to iommu group 16
[    0.439319] pci 0000:0d:00.0: Adding to iommu group 16
[    0.439327] pci 0000:0e:00.0: Adding to iommu group 16
[    0.439335] pci 0000:0f:00.0: Adding to iommu group 16
[    0.439345] pci 0000:10:00.0: Adding to iommu group 16
[    0.439354] pci 0000:10:01.0: Adding to iommu group 16
[    0.439362] pci 0000:10:02.0: Adding to iommu group 16
[    0.439370] pci 0000:10:04.0: Adding to iommu group 16
[    0.439379] pci 0000:10:05.0: Adding to iommu group 16
[    0.439387] pci 0000:11:00.0: Adding to iommu group 16
[    0.439396] pci 0000:12:03.0: Adding to iommu group 16
[    0.439404] pci 0000:13:00.0: Adding to iommu group 16
[    0.439413] pci 0000:13:00.1: Adding to iommu group 16
[    0.439421] pci 0000:13:00.2: Adding to iommu group 16
[    0.439430] pci 0000:14:00.0: Adding to iommu group 16
[    0.439438] pci 0000:15:00.0: Adding to iommu group 16
[    0.439458] pci 0000:04:00.0: Adding to iommu group 20
[    0.441558] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.441563] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.441567] software IO TLB: mapped [mem 0x000000006c76e000-0x000000007076e000] (64MB)
[    0.441578] ACPI: bus type thunderbolt registered
[    0.441752] thunderbolt 0000:07:00.0: total paths: 12
[    0.442017] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.442054] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.442077] thunderbolt 0000:07:00.0: control channel created
[    0.442081] thunderbolt 0000:07:00.0: ICM not supported on this controller
[    0.442093] thunderbolt 0000:07:00.0: freeing RX ring 0
[    0.442103] thunderbolt 0000:07:00.0: freeing TX ring 0
[    0.442117] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.442127] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.442138] thunderbolt 0000:07:00.0: control channel created
[    0.442141] thunderbolt 0000:07:00.0: using software connection manager
[    0.442144] thunderbolt 0000:07:00.0: device link creation from 0000:06:00.0 failed
[    0.442191] thunderbolt 0000:07:00.0: created link from 0000:06:03.0
[    0.442208] thunderbolt 0000:07:00.0: created link from 0000:06:04.0
[    0.442225] thunderbolt 0000:07:00.0: created link from 0000:06:05.0
[    0.442241] thunderbolt 0000:07:00.0: created link from 0000:06:06.0
[    0.442378] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[    0.442380] thunderbolt 0000:07:00.0: control channel starting...
[    0.442382] thunderbolt 0000:07:00.0: starting TX ring 0
[    0.442390] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.442394] thunderbolt 0000:07:00.0: starting RX ring 0
[    0.442402] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[    0.442407] thunderbolt 0000:07:00.0: security level set to user
[    0.442569] thunderbolt 0000:07:00.0: current switch config:
[    0.442572] thunderbolt 0000:07:00.0:  Thunderbolt 2 Switch: 8086:156d (Revision: 0, TB Version: 2)
[    0.442575] thunderbolt 0000:07:00.0:   Max Port Number: 12
[    0.442578] thunderbolt 0000:07:00.0:   Config:
[    0.442579] thunderbolt 0000:07:00.0:    Upstream Port Number: 5 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.442583] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.444320] Freeing initrd memory: 7308K
[    0.555451] thunderbolt 0000:07:00.0: initializing Switch at 0x0 (depth: 0, up port: 5)
[    0.556090] thunderbolt 0000:07:00.0: 0: DROM version: 1
[    0.557497] thunderbolt 0000:07:00.0: 0: uid: 0x1000f0811ee60
[    0.559417] thunderbolt 0000:07:00.0:  Port 1: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.559420] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.559422] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.559423] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.559424] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.561336] thunderbolt 0000:07:00.0:  Port 2: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.561338] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.561340] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.561341] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.561342] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.563256] thunderbolt 0000:07:00.0:  Port 3: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.563258] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.563259] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.563260] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.563261] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.565176] thunderbolt 0000:07:00.0:  Port 4: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.565178] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.565179] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.565180] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.565181] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.565944] thunderbolt 0000:07:00.0:  Port 5: 8086:156d (Revision: 0, TB Version: 1, Type: NHI (0x2))
[    0.565946] thunderbolt 0000:07:00.0:   Max hop id (in/out): 11/11
[    0.565947] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.565948] thunderbolt 0000:07:00.0:   NFC Credits: 0xf00000
[    0.565949] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.566200] thunderbolt 0000:07:00.0:  Port 6: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566202] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566203] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566204] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566205] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566457] random: fast init done
[    0.566457] thunderbolt 0000:07:00.0:  Port 7: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566462] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566464] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566465] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566466] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566712] thunderbolt 0000:07:00.0:  Port 8: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566714] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566715] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566716] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566717] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566968] thunderbolt 0000:07:00.0:  Port 9: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566970] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566971] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566972] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566973] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566974] thunderbolt 0000:07:00.0: 0:a: disabled by eeprom
[    0.567224] thunderbolt 0000:07:00.0:  Port 11: 8086:156d (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.567226] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.567227] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.567228] thunderbolt 0000:07:00.0:   NFC Credits: 0xf0000b
[    0.567230] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.567480] thunderbolt 0000:07:00.0:  Port 12: 8086:156d (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.567482] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.567483] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.567484] thunderbolt 0000:07:00.0:   NFC Credits: 0xf00000
[    0.567485] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.572473] thunderbolt 0000:07:00.0: 0: TMU: current mode: HiFi
[    0.572603] thunderbolt 0000:07:00.0: 0:1: is connected, link is up (state: 2)
[    0.572856] thunderbolt 0000:07:00.0: current switch config:
[    0.572857] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.572859] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.572861] thunderbolt 0000:07:00.0:   Config:
[    0.572862] thunderbolt 0000:07:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x1 Enabled: 1, PlugEventsDelay: 255ms
[    0.572864] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.577466] thunderbolt 0000:07:00.0: initializing Switch at 0x1 (depth: 1, up port: 1)
[    0.594873] thunderbolt 0000:07:00.0: 1: reading drom (length: 0x97)
[    1.088572] thunderbolt 0000:07:00.0: 1: DROM version: 1
[    1.089596] thunderbolt 0000:07:00.0: 1: uid: 0x1000100189170
[    1.092540] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.092542] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.092543] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.092544] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.092545] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.095483] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.095485] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.095486] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.095487] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c0000e
[    1.095488] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.098427] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.098429] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.098430] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.098431] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.098432] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.101371] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.101372] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.101373] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.101374] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.101375] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.101377] thunderbolt 0000:07:00.0: 1:5: disabled by eeprom
[    1.101378] thunderbolt 0000:07:00.0: 1:6: disabled by eeprom
[    1.102267] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.102268] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.102270] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.102271] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.102272] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.103163] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.103165] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.103166] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.103167] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.103168] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.103169] thunderbolt 0000:07:00.0: 1:9: disabled by eeprom
[    1.104059] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.104061] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.104062] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.104063] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.104064] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.105212] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.105214] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.105215] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.105216] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.105217] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.105218] thunderbolt 0000:07:00.0: 1:c: disabled by eeprom
[    1.105219] thunderbolt 0000:07:00.0: 1:d: disabled by eeprom
[    1.123968] thunderbolt 0000:07:00.0: 1: TMU: current mode: bi-directional, HiFi
[    1.123985] thunderbolt 0-1: new device found, vendor=0x1 device=0x8002
[    1.123989] thunderbolt 0-1: Apple, Inc. Thunderbolt Display
[    1.124480] thunderbolt 0000:07:00.0: 1:3: is connected, link is up (state: 2)
[    1.124736] thunderbolt 0000:07:00.0: current switch config:
[    1.124737] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    1.124739] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    1.124740] thunderbolt 0000:07:00.0:   Config:
[    1.124741] thunderbolt 0000:07:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x301 Enabled: 1, PlugEventsDelay: 255ms
[    1.124743] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.129345] thunderbolt 0000:07:00.0: initializing Switch at 0x301 (depth: 2, up port: 3)
[    1.146751] thunderbolt 0000:07:00.0: 301: reading drom (length: 0x97)
[    1.622405] random: crng init done
[    1.640450] thunderbolt 0000:07:00.0: 301: DROM version: 1
[    1.641474] thunderbolt 0000:07:00.0: 301: uid: 0x100010102a740
[    1.644418] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.644420] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.644421] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.644422] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.644424] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.647362] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.647364] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.647365] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.647366] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.647367] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.650306] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.650308] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.650309] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.650310] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.650311] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.653250] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.653252] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.653253] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.653254] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.653255] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.653256] thunderbolt 0000:07:00.0: 301:5: disabled by eeprom
[    1.653257] thunderbolt 0000:07:00.0: 301:6: disabled by eeprom
[    1.654146] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.654148] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.654149] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.654150] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.654151] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.655042] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.655044] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.655045] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.655046] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.655047] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.655048] thunderbolt 0000:07:00.0: 301:9: disabled by eeprom
[    1.655938] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.655940] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.655941] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.655942] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.655943] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.657090] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.657092] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.657093] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.657094] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.657095] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.657096] thunderbolt 0000:07:00.0: 301:c: disabled by eeprom
[    1.657097] thunderbolt 0000:07:00.0: 301:d: disabled by eeprom
[    1.675297] thunderbolt 0000:07:00.0: 301: TMU: current mode: bi-directional, HiFi
[    1.675312] thunderbolt 0-301: new device found, vendor=0x1 device=0x8002
[    1.675316] thunderbolt 0-301: Apple, Inc. Thunderbolt Display
[    1.675427] thunderbolt 0000:07:00.0: 301:1: is unplugged (state: 7)
[    1.675681] thunderbolt 0000:07:00.0: 301:b: DP adapter HPD set, queuing hotplug
[    1.676065] thunderbolt 0000:07:00.0: 0:3: is unplugged (state: 7)
[    1.676449] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 0:6
[    1.676578] thunderbolt 0000:07:00.0: 0:6:  In HopID: 8 => Out port: 1 Out HopID: 8
[    1.676579] thunderbolt 0000:07:00.0: 0:6:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.676581] thunderbolt 0000:07:00.0: 0:6:    Counter enabled: 1 Counter index: 0
[    1.676583] thunderbolt 0000:07:00.0: 0:6:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.676584] thunderbolt 0000:07:00.0: 0:6:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.676705] thunderbolt 0000:07:00.0: 1:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.676707] thunderbolt 0000:07:00.0: 1:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[    1.676709] thunderbolt 0000:07:00.0: 1:1:    Counter enabled: 1 Counter index: 0
[    1.676710] thunderbolt 0000:07:00.0: 1:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.676711] thunderbolt 0000:07:00.0: 1:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.676713] thunderbolt 0000:07:00.0: path discovery complete
[    1.677217] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 1:10
[    1.677345] thunderbolt 0000:07:00.0: 1:a:  In HopID: 8 => Out port: 1 Out HopID: 8
[    1.677347] thunderbolt 0000:07:00.0: 1:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.677348] thunderbolt 0000:07:00.0: 1:a:    Counter enabled: 1 Counter index: 0
[    1.677349] thunderbolt 0000:07:00.0: 1:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.677351] thunderbolt 0000:07:00.0: 1:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.677473] thunderbolt 0000:07:00.0: 0:1:  In HopID: 8 => Out port: 6 Out HopID: 8
[    1.677475] thunderbolt 0000:07:00.0: 0:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[    1.677476] thunderbolt 0000:07:00.0: 0:1:    Counter enabled: 1 Counter index: 0
[    1.677477] thunderbolt 0000:07:00.0: 0:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.677479] thunderbolt 0000:07:00.0: 0:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.677480] thunderbolt 0000:07:00.0: path discovery complete
[    1.677601] thunderbolt 0000:07:00.0: 0:6 <-> 1:a (PCI): discovered
[    1.678370] thunderbolt 0000:07:00.0: discovering Video path starting from 0:11
[    1.678497] thunderbolt 0000:07:00.0: 0:b:  In HopID: 9 => Out port: 2 Out HopID: 8
[    1.678499] thunderbolt 0000:07:00.0: 0:b:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.678500] thunderbolt 0000:07:00.0: 0:b:    Counter enabled: 1 Counter index: 1
[    1.678501] thunderbolt 0000:07:00.0: 0:b:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.678503] thunderbolt 0000:07:00.0: 0:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.678625] thunderbolt 0000:07:00.0: 1:2:  In HopID: 8 => Out port: 11 Out HopID: 9
[    1.678627] thunderbolt 0000:07:00.0: 1:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.678628] thunderbolt 0000:07:00.0: 1:2:    Counter enabled: 1 Counter index: 1
[    1.678629] thunderbolt 0000:07:00.0: 1:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.678631] thunderbolt 0000:07:00.0: 1:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.678632] thunderbolt 0000:07:00.0: path discovery complete
[    1.678881] thunderbolt 0000:07:00.0: discovering AUX TX path starting from 0:11
[    1.679009] thunderbolt 0000:07:00.0: 0:b:  In HopID: 8 => Out port: 2 Out HopID: 9
[    1.679011] thunderbolt 0000:07:00.0: 0:b:   Weight: 1 Priority: 2 Credits: 4 Drop: 0
[    1.679012] thunderbolt 0000:07:00.0: 0:b:    Counter enabled: 1 Counter index: 0
[    1.679013] thunderbolt 0000:07:00.0: 0:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.679015] thunderbolt 0000:07:00.0: 0:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.679137] thunderbolt 0000:07:00.0: 1:2:  In HopID: 9 => Out port: 11 Out HopID: 8
[    1.679139] thunderbolt 0000:07:00.0: 1:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.679140] thunderbolt 0000:07:00.0: 1:2:    Counter enabled: 1 Counter index: 0
[    1.679141] thunderbolt 0000:07:00.0: 1:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.679143] thunderbolt 0000:07:00.0: 1:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.679144] thunderbolt 0000:07:00.0: path discovery complete
[    1.679649] thunderbolt 0000:07:00.0: discovering AUX RX path starting from 1:11
[    1.679777] thunderbolt 0000:07:00.0: 1:b:  In HopID: 8 => Out port: 2 Out HopID: 8
[    1.679779] thunderbolt 0000:07:00.0: 1:b:   Weight: 1 Priority: 2 Credits: 7 Drop: 0
[    1.679780] thunderbolt 0000:07:00.0: 1:b:    Counter enabled: 1 Counter index: 0
[    1.679781] thunderbolt 0000:07:00.0: 1:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.679783] thunderbolt 0000:07:00.0: 1:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.679905] thunderbolt 0000:07:00.0: 0:2:  In HopID: 8 => Out port: 11 Out HopID: 8
[    1.679907] thunderbolt 0000:07:00.0: 0:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.679908] thunderbolt 0000:07:00.0: 0:2:    Counter enabled: 1 Counter index: 0
[    1.679909] thunderbolt 0000:07:00.0: 0:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.679911] thunderbolt 0000:07:00.0: 0:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.679912] thunderbolt 0000:07:00.0: path discovery complete
[    1.680161] thunderbolt 0000:07:00.0: 0:b <-> 1:b (DP): discovered
[    1.680673] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 1:7
[    1.680801] thunderbolt 0000:07:00.0: 1:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.680803] thunderbolt 0000:07:00.0: 1:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.680804] thunderbolt 0000:07:00.0: 1:7:    Counter enabled: 1 Counter index: 0
[    1.680805] thunderbolt 0000:07:00.0: 1:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.680807] thunderbolt 0000:07:00.0: 1:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.680929] thunderbolt 0000:07:00.0: 301:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.680931] thunderbolt 0000:07:00.0: 301:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[    1.680932] thunderbolt 0000:07:00.0: 301:3:    Counter enabled: 1 Counter index: 0
[    1.680934] thunderbolt 0000:07:00.0: 301:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.680935] thunderbolt 0000:07:00.0: 301:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.680936] thunderbolt 0000:07:00.0: path discovery complete
[    1.681441] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 301:10
[    1.681569] thunderbolt 0000:07:00.0: 301:a:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.681571] thunderbolt 0000:07:00.0: 301:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.681572] thunderbolt 0000:07:00.0: 301:a:    Counter enabled: 1 Counter index: 0
[    1.681573] thunderbolt 0000:07:00.0: 301:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.681575] thunderbolt 0000:07:00.0: 301:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.681697] thunderbolt 0000:07:00.0: 1:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[    1.681699] thunderbolt 0000:07:00.0: 1:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[    1.681700] thunderbolt 0000:07:00.0: 1:3:    Counter enabled: 1 Counter index: 0
[    1.681701] thunderbolt 0000:07:00.0: 1:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.681703] thunderbolt 0000:07:00.0: 1:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.681704] thunderbolt 0000:07:00.0: path discovery complete
[    1.681825] thunderbolt 0000:07:00.0: 1:7 <-> 301:a (PCI): discovered
[    1.682210] thunderbolt 0000:07:00.0: 0:b: DP IN resource available
[    1.682211] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.682340] thunderbolt 0000:07:00.0: 301:b: DP OUT resource available
[    1.682345] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[    1.682354] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    1.682359] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    1.682361] RAPL PMU: hw unit of domain package 2^-14 Joules
[    1.682363] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    1.682365] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    1.682469] thunderbolt 0000:07:00.0: 0:b: in use
[    1.682597] thunderbolt 0000:07:00.0: 0:c: DP IN available
[    1.682727] thunderbolt 0000:07:00.0: 301:b: DP OUT available
[    1.682731] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 12
[    1.682734] thunderbolt 0000:07:00.0: 301:b: calculating available bandwidth
[    1.682852] thunderbolt 0000:07:00.0: 0:1: link total bandwidth 9000 Mb/s
[    1.682856] thunderbolt 0000:07:00.0: 1:1: link total bandwidth 9000 Mb/s
[    1.682981] thunderbolt 0000:07:00.0: 1:3: link total bandwidth 9000 Mb/s
[    1.682985] thunderbolt 0000:07:00.0: 301:3: link total bandwidth 9000 Mb/s
[    1.682988] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    1.682996] thunderbolt 0000:07:00.0: 0:c <-> 301:b (DP): activating
[    1.683000] thunderbolt 0000:07:00.0: activating Video path from 0:12 to 301:11
[    1.683003] thunderbolt 0000:07:00.0: 301:4: adding 12 NFC credits to 0
[    1.683108] thunderbolt 0000:07:00.0: 1:2: adding 12 NFC credits to 14
[    1.683197] Initialise system trusted keyrings
[    1.683231] workingset: timestamp_bits=62 max_order=22 bucket_order=0
[    1.683234] thunderbolt 0000:07:00.0: 0:c: adding 12 NFC credits to 0
[    1.683487] thunderbolt 0000:07:00.0: 301:4: Writing hop 2
[    1.683489] thunderbolt 0000:07:00.0: 301:4:  In HopID: 8 => Out port: 11 Out HopID: 9
[    1.683490] thunderbolt 0000:07:00.0: 301:4:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.683492] thunderbolt 0000:07:00.0: 301:4:    Counter enabled: 0 Counter index: 2047
[    1.683494] thunderbolt 0000:07:00.0: 301:4:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.683495] thunderbolt 0000:07:00.0: 301:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683743] thunderbolt 0000:07:00.0: 1:2: Writing hop 1
[    1.683745] thunderbolt 0000:07:00.0: 1:2:  In HopID: 10 => Out port: 4 Out HopID: 8
[    1.683746] thunderbolt 0000:07:00.0: 1:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.683748] thunderbolt 0000:07:00.0: 1:2:    Counter enabled: 0 Counter index: 2047
[    1.683749] thunderbolt 0000:07:00.0: 1:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.683751] thunderbolt 0000:07:00.0: 1:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683999] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[    1.684000] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 2 Out HopID: 10
[    1.684002] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.684003] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[    1.684005] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.684006] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.684127] thunderbolt 0000:07:00.0: path activation complete
[    1.684129] thunderbolt 0000:07:00.0: activating AUX TX path from 0:12 to 301:11
[    1.684255] thunderbolt 0000:07:00.0: 301:4: Writing hop 2
[    1.684256] thunderbolt 0000:07:00.0: 301:4:  In HopID: 9 => Out port: 11 Out HopID: 8
[    1.684258] thunderbolt 0000:07:00.0: 301:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.684259] thunderbolt 0000:07:00.0: 301:4:    Counter enabled: 0 Counter index: 2047
[    1.684261] thunderbolt 0000:07:00.0: 301:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.684262] thunderbolt 0000:07:00.0: 301:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.684383] NFS: Registering the id_resolver key type
[    1.684389] Key type id_resolver registered
[    1.684391] Key type id_legacy registered
[    1.684405] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.684446] Key type asymmetric registered
[    1.684449] Asymmetric key parser 'x509' registered
[    1.684512] thunderbolt 0000:07:00.0: 1:2: Writing hop 1
[    1.684513] thunderbolt 0000:07:00.0: 1:2:  In HopID: 11 => Out port: 4 Out HopID: 9
[    1.684515] thunderbolt 0000:07:00.0: 1:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.684516] thunderbolt 0000:07:00.0: 1:2:    Counter enabled: 0 Counter index: 2047
[    1.684518] thunderbolt 0000:07:00.0: 1:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.684519] thunderbolt 0000:07:00.0: 1:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.684767] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[    1.684768] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 2 Out HopID: 11
[    1.684770] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.684771] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[    1.684772] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.684774] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.684895] thunderbolt 0000:07:00.0: path activation complete
[    1.684896] thunderbolt 0000:07:00.0: activating AUX RX path from 301:11 to 0:12
[    1.685026] thunderbolt 0000:07:00.0: 0:2: Writing hop 2
[    1.685028] thunderbolt 0000:07:00.0: 0:2:  In HopID: 9 => Out port: 12 Out HopID: 8
[    1.685030] thunderbolt 0000:07:00.0: 0:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.685031] thunderbolt 0000:07:00.0: 0:2:    Counter enabled: 0 Counter index: 2047
[    1.685032] thunderbolt 0000:07:00.0: 0:2:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.685034] thunderbolt 0000:07:00.0: 0:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.685281] thunderbolt 0000:07:00.0: 1:4: Writing hop 1
[    1.685283] thunderbolt 0000:07:00.0: 1:4:  In HopID: 8 => Out port: 2 Out HopID: 9
[    1.685284] thunderbolt 0000:07:00.0: 1:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.685286] thunderbolt 0000:07:00.0: 1:4:    Counter enabled: 0 Counter index: 2047
[    1.685287] thunderbolt 0000:07:00.0: 1:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.685288] thunderbolt 0000:07:00.0: 1:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.685537] thunderbolt 0000:07:00.0: 301:b: Writing hop 0
[    1.685539] thunderbolt 0000:07:00.0: 301:b:  In HopID: 8 => Out port: 4 Out HopID: 8
[    1.685540] thunderbolt 0000:07:00.0: 301:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.685542] thunderbolt 0000:07:00.0: 301:b:    Counter enabled: 0 Counter index: 2047
[    1.685543] thunderbolt 0000:07:00.0: 301:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.685545] thunderbolt 0000:07:00.0: 301:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.685665] thunderbolt 0000:07:00.0: path activation complete
[    1.685702] pcieport 0000:06:00.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.685935] pcieport 0000:06:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.686194] pcieport 0000:06:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.686351] pcieport 0000:06:05.0: enabling device (0000 -> 0003)
[    1.686462] pcieport 0000:06:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.686726] pcieport 0000:06:06.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.689253] pcieport 0000:09:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.689585] pcieport 0000:09:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.692943] pcieport 0000:10:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.693370] pcieport 0000:10:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.694341] ACPI: AC: AC Adapter [ADP1] (off-line)
[    1.694417] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    1.694454] ACPI: button: Lid Switch [LID0]
[    1.694497] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.694521] ACPI: button: Power Button [PWRB]
[    1.694557] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    1.694577] ACPI: button: Sleep Button [SLPB]
[    1.694612] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.694646] ACPI: button: Power Button [PWRF]
[    1.694960] smbus_hc ACPI0001:00: SBS HC: offset = 0x20, query_bit = 0x10
[    2.094631] ACPI: Smart Battery System [SBS0]: Battery Slot [BAT0] (battery present)
[    2.104334] hpet_acpi_add: no address or irqs in _CRS
[    2.105427] loop: module loaded
[    2.105660] nvme nvme0: pci function 0000:04:00.0
[    2.105985] tun: Universal TUN/TAP device driver, 1.6
[    2.106064] mousedev: PS/2 mouse device common for all mice
[    2.106083] rtc_cmos 00:02: RTC can wake from S4
[    2.106336] rtc_cmos 00:02: registered as rtc0
[    2.106373] rtc_cmos 00:02: setting system clock to 2022-04-01T05:31:32 UTC (1648791092)
[    2.106378] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram
[    2.106578] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[    2.106591] intel_pstate: Intel P-state driver initializing
[    2.106694] efifb: probing for efifb
[    2.106707] efifb: framebuffer at 0xa0000000, using 16000k, total 16000k
[    2.106710] efifb: mode is 2560x1600x32, linelength=10240, pages=1
[    2.106712] efifb: scrolling: redraw
[    2.106713] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    2.109913] Console: switching to colour frame buffer device 320x100
[    2.112938] fb0: EFI VGA frame buffer device
[    2.113011] NET: Registered PF_PACKET protocol family
[    2.113032] Key type dns_resolver registered
[    2.113205] microcode: sig=0x40651, pf=0x40, revision=0x26
[    2.113247] microcode: Microcode Update Driver: v2.2.
[    2.113252] IPI shorthand broadcast: enabled
[    2.113270] AVX2 version of gcm_enc/dec engaged.
[    2.113307] AES CTR mode by8 optimization enabled
[    2.113426] sched_clock: Marking stable (2111820690, 1600950)->(2142207081, -28785441)
[    2.113489] registered taskstats version 1
[    2.113497] Loading compiled-in X.509 certificates
[    2.161557] nvme0: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2)
[    2.179762] nvme nvme0: 4/0/0 default/read/poll queues
[    2.184729]  nvme0n1: p1 p2 p3 p4 p5 p6 p7
[    2.352295] Freeing unused kernel image (initmem) memory: 996K
[    2.373637] Write protecting the kernel read-only data: 16384k
[    2.374003] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    2.374182] Freeing unused kernel image (rodata/data gap) memory: 1356K
[    2.374199] Run /init as init process
[    2.374206]   with arguments:
[    2.374208]     /init
[    2.374209]   with environment:
[    2.374209]     HOME=/
[    2.374210]     TERM=linux
[    2.427563] udevd[941]: starting version 3.2.9
[    2.428323] udevd[942]: starting eudev-3.2.9
[    2.448558] ACPI: bus type USB registered
[    2.448594] usbcore: registered new interface driver usbfs
[    2.448619] usbcore: registered new interface driver hub
[    2.448648] usbcore: registered new device driver usb
[    2.450285] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.450308] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.451385] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x000000000004b810
[    2.451534] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    2.451549] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.451560] usb usb1: Product: xHCI Host Controller
[    2.451568] usb usb1: Manufacturer: Linux 5.17.0+ xhci-hcd
[    2.451580] usb usb1: SerialNumber: 0000:00:14.0
[    2.451749] hub 1-0:1.0: USB hub found
[    2.451766] hub 1-0:1.0: 9 ports detected
[    2.452146] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.452165] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.452186] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.452232] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.17
[    2.452245] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.452257] usb usb2: Product: xHCI Host Controller
[    2.452265] usb usb2: Manufacturer: Linux 5.17.0+ xhci-hcd
[    2.452273] usb usb2: SerialNumber: 0000:00:14.0
[    2.452407] hub 2-0:1.0: USB hub found
[    2.452421] hub 2-0:1.0: 4 ports detected
[    2.456067] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    2.456425] i2c i2c-0: 2/2 memory slots populated (from DMI)
[    2.514397] applesmc: key=571 fan=1 temp=32 index=31 acc=0 lux=2 kbd=1
[    2.514552] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    2.523786] tg3 0000:0d:00.0 eth0: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[    2.523826] tg3 0000:0d:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.523853] tg3 0000:0d:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.523868] tg3 0000:0d:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.614260] tg3 0000:14:00.0 eth1: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[    2.614305] tg3 0000:14:00.0 eth1: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.614338] tg3 0000:14:00.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.614364] tg3 0000:14:00.0 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.723635] tsc: Refined TSC clocksource calibration: 2599.999 MHz
[    2.723644] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x257a3b2ad7e, max_idle_ns: 440795282337 ns
[    2.723668] clocksource: Switched to clocksource tsc
[    2.743648] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    2.926341] usb 1-3: New USB device found, idVendor=05ac, idProduct=8290, bcdDevice= 1.69
[    2.926347] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.926348] usb 1-3: Product: Bluetooth USB Host Controller
[    2.926350] usb 1-3: Manufacturer: Broadcom Corp.
[    2.932968] hid: raw HID events driver (C) Jiri Kosina
[    2.937277] usbcore: registered new interface driver usbhid
[    2.937279] usbhid: USB HID core driver
[    2.937975] input: Broadcom Corp. Bluetooth USB Host Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:05AC:8290.0001/input/input4
[    3.003742] hid-generic 0003:05AC:8290.0001: input,hidraw0: USB HID v1.11 Keyboard [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.0-3/input0
[    3.003886] input: Broadcom Corp. Bluetooth USB Host Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.1/0003:05AC:8290.0002/input/input5
[    3.004674] hid-generic 0003:05AC:8290.0002: input,hidraw1: USB HID v1.11 Mouse [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.0-3/input1
[    3.073839] usb 2-3: new SuperSpeed USB device number 2 using xhci_hcd
[    3.106643] usb 2-3: New USB device found, idVendor=05ac, idProduct=8406, bcdDevice= 8.20
[    3.106648] usb 2-3: New USB device strings: Mfr=3, Product=4, SerialNumber=5
[    3.106650] usb 2-3: Product: Card Reader
[    3.106651] usb 2-3: Manufacturer: Apple
[    3.106653] usb 2-3: SerialNumber: 000000000820
[    3.109981] usb-storage 2-3:1.0: USB Mass Storage device detected
[    3.110062] scsi host0: usb-storage 2-3:1.0
[    3.110137] usbcore: registered new interface driver usb-storage
[    3.110359] usbcore: registered new interface driver uas
[    3.253633] usb 1-5: new full-speed USB device number 3 using xhci_hcd
[    3.439676] usb 1-5: New USB device found, idVendor=05ac, idProduct=0259, bcdDevice= 2.24
[    3.439681] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.439683] usb 1-5: Product: Apple Internal Keyboard / Trackpad
[    3.439684] usb 1-5: Manufacturer: Apple Inc.
[    3.448843] input: Apple Inc. Apple Internal Keyboard / Trackpad as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/0003:05AC:0259.0003/input/input6
[    3.513771] apple 0003:05AC:0259.0003: input,hidraw2: USB HID v1.11 Keyboard [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-5/input0
[    3.513971] apple 0003:05AC:0259.0004: hidraw3: USB HID v1.11 Device [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-5/input1
[    4.165607] scsi 0:0:0:0: Direct-Access     APPLE    SD Card Reader   3.00 PQ: 0 ANSI: 6
[    4.166288] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.166312] sd 0:0:0:0: [sda] Media removed, stopped polling
[    4.166889] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    6.497575] process '/usr/bin/fstype' started with executable stack
[    6.558496] PM: Image not found (code -22)
[    6.560499] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[    6.560503] PM: hibernation: Marking nosave pages: [mem 0x00058000-0x00058fff]
[    6.560505] PM: hibernation: Marking nosave pages: [mem 0x0008f000-0x0008ffff]
[    6.560506] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
[    6.560508] PM: hibernation: Marking nosave pages: [mem 0x73d4c000-0x73d4cfff]
[    6.560509] PM: hibernation: Marking nosave pages: [mem 0x73d5c000-0x73d5cfff]
[    6.560510] PM: hibernation: Marking nosave pages: [mem 0x73d6f000-0x73d6ffff]
[    6.560511] PM: hibernation: Marking nosave pages: [mem 0x73d6f000-0x73d6ffff]
[    6.560512] PM: hibernation: Marking nosave pages: [mem 0x8ad10000-0x8ad52fff]
[    6.560513] PM: hibernation: Marking nosave pages: [mem 0x8ad62000-0x8ad8efff]
[    6.560515] PM: hibernation: Marking nosave pages: [mem 0x8ae39000-0x8ae8efff]
[    6.560517] PM: hibernation: Marking nosave pages: [mem 0x8aed2000-0x8aefefff]
[    6.560518] PM: hibernation: Marking nosave pages: [mem 0x8af84000-0x8afeffff]
[    6.560520] PM: hibernation: Marking nosave pages: [mem 0x8b000000-0xffffffff]
[    6.561560] PM: hibernation: Basic memory bitmaps created
[    6.562140] PM: hibernation: Basic memory bitmaps freed
[    6.738550] EXT4-fs (nvme0n1p4): mounted filesystem with ordered data mode. Quota mode: disabled.
[    6.898325] udevd[1205]: starting version 3.2.9
[    6.922682] udevd[1206]: starting eudev-3.2.9
[    6.968194] Linux agpgart interface v0.103
[    6.985932] ACPI: bus type drm_connector registered
[    7.007817] tg3 0000:0d:00.0 eth2: renamed from eth0
[    7.023633] input: bcm5974 as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.2/input/input7
[    7.024851] usbcore: registered new interface driver bcm5974
[    7.029637] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    7.031707] checking generic (a0000000 fa0000) vs hw (b0000000 400000)
[    7.031712] checking generic (a0000000 fa0000) vs hw (a0000000 10000000)
[    7.031714] fb0: switching to i915 from EFI VGA
[    7.043369] Console: switching to colour dummy device 80x25
[    7.043419] i915 0000:00:02.0: vgaarb: deactivate vga console
[    7.043461] i915 0000:00:02.0: [drm] Transparent Hugepage support is recommended for optimal performance when IOMMU is enabled!
[    7.043480] i915 0000:00:02.0: [drm] DMAR active, disabling use of stolen memory
[    7.043980] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    7.044269] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    7.066951] snd_hda_codec_cirrus hdaudioC1D0: autoconfig for CS4208: line_outs=2 (0x12/0x13/0x0/0x0/0x0) type:speaker
[    7.066965] snd_hda_codec_cirrus hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    7.066971] snd_hda_codec_cirrus hdaudioC1D0:    hp_outs=1 (0x10/0x0/0x0/0x0/0x0)
[    7.066976] snd_hda_codec_cirrus hdaudioC1D0:    mono: mono_out=0x0
[    7.066980] snd_hda_codec_cirrus hdaudioC1D0:    dig-out=0x21/0x0
[    7.066984] snd_hda_codec_cirrus hdaudioC1D0:    inputs:
[    7.066988] snd_hda_codec_cirrus hdaudioC1D0:      Internal Mic=0x1c
[    7.066992] snd_hda_codec_cirrus hdaudioC1D0:      Mic=0x18
[    7.083364] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input8
[    7.083453] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[    7.089821] input: HDA Intel PCH SPDIF as /devices/pci0000:00/0000:00:1b.0/sound/card1/input10
[    7.123606] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[    7.124421] ACPI: video: Video Device [IGPU] (multi-head: yes  rom: no  post: no)
[    7.125005] acpi device:02: registered as cooling_device4
[    7.125101] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input11
[    7.125404] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    7.125686] Bluetooth: Core ver 2.22
[    7.125703] NET: Registered PF_BLUETOOTH protocol family
[    7.125706] Bluetooth: HCI device and connection manager initialized
[    7.125712] Bluetooth: HCI socket layer initialized
[    7.125715] Bluetooth: L2CAP socket layer initialized
[    7.125720] Bluetooth: SCO socket layer initialized
[    7.126478] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    7.126730] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    7.126739] cfg80211: failed to load regulatory.db
[    7.256360] udevd[1255]: Unable to EVIOCGABS device "/dev/input/event6"
[    7.256373] udevd[1255]: Unable to EVIOCGABS device "/dev/input/event6"
[    7.256379] udevd[1255]: Unable to EVIOCGABS device "/dev/input/event6"
[    7.256385] udevd[1255]: Unable to EVIOCGABS device "/dev/input/event6"
[    7.278017] fbcon: i915drmfb (fb0) is primary device
[    8.794719] Console: switching to colour frame buffer device 320x90
[    8.813993] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    8.856508] brcmfmac 0000:03:00.0: enabling device (0000 -> 0002)
[    8.857209] usbcore: registered new interface driver btusb
[    8.862310] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input12
[    8.862530] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input13
[    8.862982] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input14
[    8.863411] input: HDA Intel HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/sound/card0/input15
[    8.864245] input: HDA Intel HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.0/sound/card0/input16
[    8.973844] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43602-pcie for chip BCM43602/1
[    8.974526] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.Apple Inc.-MacBookPro11,1.bin failed with error -2
[    8.975409] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.Apple Inc.-MacBookPro11,1.txt failed with error -2
[    8.975455] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.txt failed with error -2
[    8.989701] Bluetooth: hci0: BCM: chip id 102 build 0729
[    8.990661] Bluetooth: hci0: BCM: product 05ac:8290
[    8.991662] Bluetooth: hci0: BCM: features 0x2f
[    9.009587] Bluetooth: hci0: BlueZ 5.50
[    9.103037] Adding 19528700k swap on /dev/mapper/swap.  Priority:-2 extents:1 across:19528700k SS
[    9.114617] EXT4-fs (nvme0n1p4): re-mounted. Quota mode: disabled.
[    9.495652] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43602-pcie for chip BCM43602/1
[    9.495681] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
[    9.496056] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43602/1 wl0: Nov 10 2015 06:38:10 version 7.35.177.61 (r598657) FWID 01-ea662a8c
[   15.263343] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Quota mode: disabled.
[   15.477567] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   19.299750] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   19.299754] Bluetooth: BNEP filters: protocol multicast
[   19.299757] Bluetooth: BNEP socket layer initialized
[   19.657996] broken atomic modeset userspace detected, disabling atomic
[   33.593101] ieee80211 phy0: brcmf_cfg80211_scan: Connecting: status (3)
[   34.593467] ieee80211 phy0: brcmf_cfg80211_scan: Connecting: status (3)

iMac - Left Port :
[    0.000000] Linux version 5.17.0+ (brad@bkmac) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #51 SMP PREEMPT_DYNAMIC Fri Apr 1 13:23:13 AWST 2022
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
[    0.000000] tsc: Detected 3400.284 MHz processor
[    0.000137] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000139] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000145] last_pfn = 0x86ff00 max_arch_pfn = 0x400000000
[    0.000796] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001414] last_pfn = 0x8efa3 max_arch_pfn = 0x400000000
[    0.002513] Secure boot disabled
[    0.002514] RAMDISK: [mem 0x7e4ad000-0x7fffffff]
[    0.002518] ACPI: Early table checksum verification disabled
[    0.002521] ACPI: RSDP 0x000000008ED8E014 000024 (v02 APPLE )
[    0.002525] ACPI: XSDT 0x000000008ED8E1C0 0000A4 (v01 APPLE  Apple00  0000F000      01000013)
[    0.002530] ACPI: FACP 0x000000008ED8C000 0000F4 (v04 APPLE  Apple00  0000F000 Loki 0000005F)
[    0.002534] ACPI: DSDT 0x000000008ED81000 0053FB (v01 APPLE  iMac     00210001 INTL 20061109)
[    0.002537] ACPI: FACS 0x000000008ED3E000 000040
[    0.002539] ACPI: FACS 0x000000008ED3E000 000040
[    0.002541] ACPI: HPET 0x000000008ED8B000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002544] ACPI: APIC 0x000000008ED8A000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002547] ACPI: SBST 0x000000008ED88000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002549] ACPI: ECDT 0x000000008ED87000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002552] ACPI: SSDT 0x000000008ED7E000 00020D (v01 APPLE  SataAhci 00001000 INTL 20061109)
[    0.002554] ACPI: SSDT 0x000000008ED7C000 0000B1 (v01 APPLE  SmcDppt  00001000 INTL 20061109)
[    0.002557] ACPI: SSDT 0x000000008ED7A000 000646 (v01 APPLE  UsbNoRmh 00001000 INTL 20061109)
[    0.002559] ACPI: SSDT 0x000000008ED78000 00013D (v01 APPLE  SataPrt1 00001000 INTL 20061109)
[    0.002562] ACPI: SSDT 0x000000008ED77000 0000A0 (v02 APPLE  IGHda    00001000 INTL 20061109)
[    0.002565] ACPI: SSDT 0x000000008ED75000 000032 (v01 APPLE  SsdtS3   00001000 INTL 20061109)
[    0.002567] ACPI: SSDT 0x000000008ED74000 000548 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.002570] ACPI: SSDT 0x000000008ED73000 0009B1 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.002572] ACPI: SSDT 0x000000008ED72000 000315 (v01 PmRef  Cpu0Tst  00003000 INTL 20061109)
[    0.002575] ACPI: SSDT 0x000000008ED71000 00037A (v01 PmRef  ApTst    00003000 INTL 20061109)
[    0.002578] ACPI: MCFG 0x000000008ED89000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002580] ACPI: Reserving FACP table memory at [mem 0x8ed8c000-0x8ed8c0f3]
[    0.002581] ACPI: Reserving DSDT table memory at [mem 0x8ed81000-0x8ed863fa]
[    0.002582] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002584] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002584] ACPI: Reserving HPET table memory at [mem 0x8ed8b000-0x8ed8b037]
[    0.002586] ACPI: Reserving APIC table memory at [mem 0x8ed8a000-0x8ed8a0bb]
[    0.002587] ACPI: Reserving SBST table memory at [mem 0x8ed88000-0x8ed8802f]
[    0.002588] ACPI: Reserving ECDT table memory at [mem 0x8ed87000-0x8ed87052]
[    0.002589] ACPI: Reserving SSDT table memory at [mem 0x8ed7e000-0x8ed7e20c]
[    0.002590] ACPI: Reserving SSDT table memory at [mem 0x8ed7c000-0x8ed7c0b0]
[    0.002591] ACPI: Reserving SSDT table memory at [mem 0x8ed7a000-0x8ed7a645]
[    0.002592] ACPI: Reserving SSDT table memory at [mem 0x8ed78000-0x8ed7813c]
[    0.002593] ACPI: Reserving SSDT table memory at [mem 0x8ed77000-0x8ed7709f]
[    0.002594] ACPI: Reserving SSDT table memory at [mem 0x8ed75000-0x8ed75031]
[    0.002595] ACPI: Reserving SSDT table memory at [mem 0x8ed74000-0x8ed74547]
[    0.002597] ACPI: Reserving SSDT table memory at [mem 0x8ed73000-0x8ed739b0]
[    0.002598] ACPI: Reserving SSDT table memory at [mem 0x8ed72000-0x8ed72314]
[    0.002599] ACPI: Reserving SSDT table memory at [mem 0x8ed71000-0x8ed71379]
[    0.002600] ACPI: Reserving MCFG table memory at [mem 0x8ed89000-0x8ed8903b]
[    0.002606] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.002634] Zone ranges:
[    0.002635]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002636]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002638]   Normal   [mem 0x0000000100000000-0x000000086fefffff]
[    0.002639] Movable zone start for each node
[    0.002640] Early memory node ranges
[    0.002641]   node   0: [mem 0x0000000000001000-0x000000000008dfff]
[    0.002642]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.002643]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.002644]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.002645]   node   0: [mem 0x0000000040200000-0x000000008ed32fff]
[    0.002646]   node   0: [mem 0x000000008ed5f000-0x000000008ed70fff]
[    0.002647]   node   0: [mem 0x000000008ed8f000-0x000000008ee59fff]
[    0.002648]   node   0: [mem 0x000000008ee8f000-0x000000008eed6fff]
[    0.002648]   node   0: [mem 0x000000008eeff000-0x000000008efa2fff]
[    0.002649]   node   0: [mem 0x0000000100000000-0x000000086fefffff]
[    0.002652] Initmem setup node 0 [mem 0x0000000000001000-0x000000086fefffff]
[    0.002656] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002657] On node 0, zone DMA: 2 pages in unavailable ranges
[    0.002675] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.004175] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006413] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006419] On node 0, zone DMA32: 44 pages in unavailable ranges
[    0.006421] On node 0, zone DMA32: 30 pages in unavailable ranges
[    0.006423] On node 0, zone DMA32: 53 pages in unavailable ranges
[    0.006425] On node 0, zone DMA32: 40 pages in unavailable ranges
[    0.060530] On node 0, zone Normal: 4189 pages in unavailable ranges
[    0.060537] On node 0, zone Normal: 256 pages in unavailable ranges
[    0.060699] ACPI: PM-Timer IO Port: 0x408
[    0.060705] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.060706] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.060707] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.060708] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.060709] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.060710] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.060711] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.060712] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.060721] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.060723] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.060725] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.060728] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.060729] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.060732] TSC deadline timer available
[    0.060733] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.060755] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.060757] PM: hibernation: Registered nosave memory: [mem 0x0008e000-0x0008ffff]
[    0.060759] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
[    0.060760] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.060762] PM: hibernation: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.060764] PM: hibernation: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.060766] PM: hibernation: Registered nosave memory: [mem 0x89109000-0x89109fff]
[    0.060767] PM: hibernation: Registered nosave memory: [mem 0x89124000-0x89124fff]
[    0.060769] PM: hibernation: Registered nosave memory: [mem 0x891a7000-0x891a7fff]
[    0.060771] PM: hibernation: Registered nosave memory: [mem 0x891b8000-0x891b8fff]
[    0.060773] PM: hibernation: Registered nosave memory: [mem 0x8ed33000-0x8ed5efff]
[    0.060775] PM: hibernation: Registered nosave memory: [mem 0x8ed71000-0x8ed8efff]
[    0.060777] PM: hibernation: Registered nosave memory: [mem 0x8ee5a000-0x8ee8efff]
[    0.060778] PM: hibernation: Registered nosave memory: [mem 0x8eed7000-0x8eefefff]
[    0.060780] PM: hibernation: Registered nosave memory: [mem 0x8efa3000-0x8f8fffff]
[    0.060781] PM: hibernation: Registered nosave memory: [mem 0x8f900000-0xe00f7fff]
[    0.060782] PM: hibernation: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.060783] PM: hibernation: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff]
[    0.060784] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.060785] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xffed7fff]
[    0.060785] PM: hibernation: Registered nosave memory: [mem 0xffed8000-0xffefffff]
[    0.060786] PM: hibernation: Registered nosave memory: [mem 0xfff00000-0xffffffff]
[    0.060788] [mem 0x8f900000-0xe00f7fff] available for PCI devices
[    0.060792] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.063080] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.063247] percpu: Embedded 44 pages/cpu s139880 r8192 d32152 u262144
[    0.063254] pcpu-alloc: s139880 r8192 d32152 u262144 alloc=1*2097152
[    0.063256] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.063277] Built 1 zonelists, mobility grouping on.  Total pages: 8251732
[    0.063279] Kernel command line: ro root=UUID=de35d1a6-e0e1-40b0-b46a-3974a04adf4b libata.allow_tpm=1 netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da oops=panic panic=10 thunderbolt.dyndbg pci=assign-busses,realloc,hpbussize=0x10,hpmmiosize=128M,hpmmioprefsize=1G initrd=boot\initrd.img-5.17.0+
[    0.063339] Unknown kernel command line parameters "netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da", will be passed to user space.
[    0.064959] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.065784] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.065849] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.152435] Memory: 32768252K/33531492K available (8192K kernel code, 2298K rwdata, 1860K rodata, 956K init, 2628K bss, 762984K reserved, 0K cma-reserved)
[    0.152470] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.152683] Dynamic Preempt: voluntary
[    0.152707] rcu: Preemptible hierarchical RCU implementation.
[    0.152709] 	Trampoline variant of Tasks RCU enabled.
[    0.152710] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.152718] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
[    0.152910] random: get_random_bytes called from start_kernel+0x443/0x5fb with crng_init=0
[    0.152935] Console: colour dummy device 80x25
[    0.153205] printk: console [tty0] enabled
[    0.153212] ACPI: Core revision 20211217
[    0.153297] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.153312] APIC: Switch to symmetric I/O mode setup
[    0.153690] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.203307] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x31035b584ad, max_idle_ns: 440795370328 ns
[    0.203312] Calibrating delay loop (skipped), value calculated using timer frequency.. 6800.56 BogoMIPS (lpj=34002840)
[    0.203316] pid_max: default: 32768 minimum: 301
[    0.207887] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.207951] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.208070] CPU0: Thermal monitoring enabled (TM1)
[    0.208074] process: using mwait in idle threads
[    0.208077] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.208079] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.208081] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.208085] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.208085] Spectre V2 : Vulnerable
[    0.208088] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.208090] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.208093] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.208095] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.208097] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.208100] MDS: Mitigation: Clear CPU buffers
[    0.208258] Freeing SMP alternatives memory: 24K
[    0.208524] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1054
[    0.208531] smpboot: CPU0: Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz (family: 0x6, model: 0x2a, stepping: 0x7)
[    0.208596] cblist_init_generic: Setting adjustable number of callback queues.
[    0.208600] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.208610] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.208623] ... version:                3
[    0.208625] ... bit width:              48
[    0.208626] ... generic registers:      4
[    0.208628] ... value mask:             0000ffffffffffff
[    0.208630] ... max period:             00007fffffffffff
[    0.208631] ... fixed-purpose events:   3
[    0.208633] ... event mask:             000000070000000f
[    0.208711] rcu: Hierarchical SRCU implementation.
[    0.208811] smp: Bringing up secondary CPUs ...
[    0.208856] x86: Booting SMP configuration:
[    0.208858] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.216861] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.216861]  #5 #6 #7
[    0.226637] smp: Brought up 1 node, 8 CPUs
[    0.226637] smpboot: Max logical packages: 1
[    0.226637] smpboot: Total of 8 processors activated (54404.54 BogoMIPS)
[    0.228822] devtmpfs: initialized
[    0.228822] ACPI: PM: Registering ACPI NVS region [mem 0x8ed33000-0x8ed5efff] (180224 bytes)
[    0.228822] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.228822] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.228822] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.228822] thermal_sys: Registered thermal governor 'step_wise'
[    0.228822] thermal_sys: Registered thermal governor 'user_space'
[    0.228822] cpuidle: using governor ladder
[    0.228822] cpuidle: using governor menu
[    0.228822] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.228822] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.228822] PCI: not using MMCONFIG
[    0.228822] PCI: Using configuration type 1 for base access
[    0.228822] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.233831] ACPI: Disabled all _OSI OS vendors
[    0.233831] ACPI: Added _OSI(Module Device)
[    0.233831] ACPI: Added _OSI(Processor Device)
[    0.233831] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.233831] ACPI: Added _OSI(Processor Aggregator Device)
[    0.233831] ACPI: Added _OSI(Linux-Dell-Video)
[    0.233831] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.233831] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.233831] ACPI: Added _OSI(Darwin)
[    0.235637] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.235839] ACPI: EC: EC started
[    0.235841] ACPI: EC: interrupt blocked
[    0.236656] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.236658] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.236786] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.236918] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.237119] ACPI: Dynamic OEM Table Load:
[    0.237127] ACPI: SSDT 0xFFFF888100379800 000781 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.237444] ACPI: Dynamic OEM Table Load:
[    0.237450] ACPI: SSDT 0xFFFF88810036E800 0003A4 (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.237681] ACPI: Dynamic OEM Table Load:
[    0.237686] ACPI: SSDT 0xFFFF8881000FA600 000119 (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.238467] ACPI: Interpreter enabled
[    0.238481] ACPI: PM: (supports S0 S3 S4 S5)
[    0.238483] ACPI: Using IOAPIC for interrupt routing
[    0.238500] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.238711] PCI: MMCONFIG at [mem 0xe0000000-0xefbfffff] reserved in ACPI motherboard resources
[    0.238724] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.238817] ACPI: Enabled 6 GPEs in block 00 to 3F
[    0.241671] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.241678] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.241683] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-fb] only partially covers this bridge
[    0.241820] PCI host bridge to bus 0000:00
[    0.241823] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.241826] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.241829] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.241832] pci_bus 0000:00: root bus resource [mem 0x8f900000-0xfeafffff window]
[    0.241834] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.241837] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.241847] pci 0000:00:00.0: [8086:0100] type 00 class 0x060000
[    0.241909] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
[    0.241937] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.241992] pci 0000:00:02.0: [8086:0102] type 00 class 0x038000
[    0.242000] pci 0000:00:02.0: reg 0x10: [mem 0xa8000000-0xa83fffff 64bit]
[    0.242006] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xa7ffffff 64bit pref]
[    0.242010] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.242081] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.242100] pci 0000:00:16.0: reg 0x10: [mem 0xa8907100-0xa890710f 64bit]
[    0.242167] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.242213] pci 0000:00:1a.0: [8086:1c2c] type 00 class 0x0c0300
[    0.242251] pci 0000:00:1a.0: reg 0x20: [io  0x3140-0x315f]
[    0.242334] pci 0000:00:1a.7: [8086:1c2d] type 00 class 0x0c0320
[    0.242349] pci 0000:00:1a.7: reg 0x10: [mem 0xa8906c00-0xa8906fff]
[    0.242425] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.242591] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.242606] pci 0000:00:1b.0: reg 0x10: [mem 0xa8900000-0xa8903fff 64bit]
[    0.242667] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.243350] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.243429] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.243495] pci 0000:00:1c.1: [8086:1c12] type 01 class 0x060400
[    0.243574] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.243639] pci 0000:00:1c.2: [8086:1c14] type 01 class 0x060400
[    0.243718] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.243783] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    0.243861] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.243924] pci 0000:00:1d.0: [8086:1c27] type 00 class 0x0c0300
[    0.243962] pci 0000:00:1d.0: reg 0x20: [io  0x30e0-0x30ff]
[    0.244044] pci 0000:00:1d.7: [8086:1c26] type 00 class 0x0c0320
[    0.244060] pci 0000:00:1d.7: reg 0x10: [mem 0xa8906800-0xa8906bff]
[    0.244135] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.244298] pci 0000:00:1f.0: [8086:1c44] type 00 class 0x060100
[    0.244440] pci 0000:00:1f.2: [8086:1c02] type 00 class 0x010601
[    0.244452] pci 0000:00:1f.2: reg 0x10: [io  0x3168-0x316f]
[    0.244460] pci 0000:00:1f.2: reg 0x14: [io  0x317c-0x317f]
[    0.244467] pci 0000:00:1f.2: reg 0x18: [io  0x3160-0x3167]
[    0.244474] pci 0000:00:1f.2: reg 0x1c: [io  0x3178-0x317b]
[    0.244482] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
[    0.244489] pci 0000:00:1f.2: reg 0x24: [mem 0xa8906000-0xa89067ff]
[    0.244523] pci 0000:00:1f.2: PME# supported from D3hot
[    0.244570] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    0.244584] pci 0000:00:1f.3: reg 0x10: [mem 0xa8907000-0xa89070ff 64bit]
[    0.244599] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.244702] pci 0000:01:00.0: [1002:6720] type 00 class 0x030000
[    0.244717] pci 0000:01:00.0: reg 0x10: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.244728] pci 0000:01:00.0: reg 0x18: [mem 0xa8800000-0xa881ffff 64bit]
[    0.244736] pci 0000:01:00.0: reg 0x20: [io  0x2000-0x20ff]
[    0.244748] pci 0000:01:00.0: reg 0x30: [mem 0xa8820000-0xa883ffff pref]
[    0.244755] pci 0000:01:00.0: enabling Extended Tags
[    0.244765] pci 0000:01:00.0: BAR 0: assigned to efifb
[    0.244795] pci 0000:01:00.0: supports D1 D2
[    0.244884] pci 0000:01:00.1: [1002:aa88] type 00 class 0x040300
[    0.244898] pci 0000:01:00.1: reg 0x10: [mem 0xa8840000-0xa8843fff 64bit]
[    0.244924] pci 0000:01:00.1: enabling Extended Tags
[    0.244960] pci 0000:01:00.1: supports D1 D2
[    0.245051] pci 0000:00:01.0: PCI bridge to [bus 01-ff]
[    0.245055] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.245058] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.245062] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.245065] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.245138] pci 0000:02:00.0: [14e4:16b4] type 00 class 0x020000
[    0.245171] pci 0000:02:00.0: reg 0x10: [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.245193] pci 0000:02:00.0: reg 0x18: [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.245348] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.245462] pci 0000:00:1c.0: PCI bridge to [bus 02-ff]
[    0.245468] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.245474] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.245477] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    0.245548] pci 0000:03:00.0: [168c:0030] type 00 class 0x028000
[    0.245579] pci 0000:03:00.0: reg 0x10: [mem 0xa8600000-0xa861ffff 64bit]
[    0.245639] pci 0000:03:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    0.245730] pci 0000:03:00.0: supports D1 D2
[    0.245732] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.245832] pci 0000:00:1c.1: PCI bridge to [bus 03-ff]
[    0.245839] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.245845] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.245917] pci 0000:04:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.245951] pci 0000:04:00.0: reg 0x10: [mem 0xa8500000-0xa8500fff 64bit]
[    0.246113] pci 0000:04:00.0: supports D1 D2
[    0.246115] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246309] pci 0000:00:1c.2: PCI bridge to [bus 04-ff]
[    0.246315] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.246322] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.246394] pci 0000:05:00.0: [8086:1513] type 01 class 0x060400
[    0.246459] pci 0000:05:00.0: enabling Extended Tags
[    0.246554] pci 0000:05:00.0: supports D1 D2
[    0.246556] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246685] pci 0000:00:1c.4: PCI bridge to [bus 05-ff]
[    0.246690] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.246694] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.246700] pci 0000:00:1c.4:   bridge window [mem 0xacf00000-0xb10fffff 64bit pref]
[    0.246785] acpiphp: Slot [3] registered
[    0.246807] acpiphp: Slot [4] registered
[    0.246848] pci 0000:06:00.0: [8086:1513] type 01 class 0x060400
[    0.246918] pci 0000:06:00.0: enabling Extended Tags
[    0.247018] pci 0000:06:00.0: supports D1 D2
[    0.247020] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247131] pci 0000:06:03.0: [8086:1513] type 01 class 0x060400
[    0.247201] pci 0000:06:03.0: enabling Extended Tags
[    0.247302] pci 0000:06:03.0: supports D1 D2
[    0.247304] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247409] pci 0000:06:04.0: [8086:1513] type 01 class 0x060400
[    0.247479] pci 0000:06:04.0: enabling Extended Tags
[    0.247580] pci 0000:06:04.0: supports D1 D2
[    0.247582] pci 0000:06:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247690] pci 0000:06:05.0: [8086:1513] type 01 class 0x060400
[    0.247760] pci 0000:06:05.0: enabling Extended Tags
[    0.247861] pci 0000:06:05.0: supports D1 D2
[    0.247863] pci 0000:06:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247972] pci 0000:06:06.0: [8086:1513] type 01 class 0x060400
[    0.248042] pci 0000:06:06.0: enabling Extended Tags
[    0.248143] pci 0000:06:06.0: supports D1 D2
[    0.248145] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248261] pci 0000:05:00.0: PCI bridge to [bus 06-ff]
[    0.248273] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.248281] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.248380] acpiphp: Slot [1] registered
[    0.248421] pci 0000:07:00.0: [8086:1513] type 00 class 0x088000
[    0.248449] pci 0000:07:00.0: reg 0x10: [mem 0xa8a00000-0xa8a3ffff]
[    0.248465] pci 0000:07:00.0: reg 0x14: [mem 0xa8a40000-0xa8a40fff]
[    0.248544] pci 0000:07:00.0: enabling Extended Tags
[    0.248668] pci 0000:07:00.0: supports D1 D2
[    0.248670] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248812] pci 0000:06:00.0: PCI bridge to [bus 07-ff]
[    0.248824] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.248833] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    0.248890] pci 0000:06:03.0: PCI bridge to [bus 08-ff]
[    0.248901] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.248910] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 17
[    0.249023] pci 0000:18:00.0: [8086:1513] type 01 class 0x060400
[    0.249140] pci 0000:18:00.0: enabling Extended Tags
[    0.249316] pci 0000:18:00.0: supports D1 D2
[    0.249318] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.273371] pci 0000:06:04.0: PCI bridge to [bus 18-ff]
[    0.273389] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.273402] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.273411] pci 0000:18:00.0: bridge configuration invalid ([bus 3a-49]), reconfiguring
[    0.273577] pci 0000:19:00.0: [8086:1513] type 01 class 0x060400
[    0.273700] pci 0000:19:00.0: enabling Extended Tags
[    0.273881] pci 0000:19:00.0: supports D1 D2
[    0.273883] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274039] pci 0000:19:01.0: [8086:1513] type 01 class 0x060400
[    0.274162] pci 0000:19:01.0: enabling Extended Tags
[    0.274341] pci 0000:19:01.0: supports D1 D2
[    0.274343] pci 0000:19:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274497] pci 0000:19:02.0: [8086:1513] type 01 class 0x060400
[    0.274621] pci 0000:19:02.0: enabling Extended Tags
[    0.274800] pci 0000:19:02.0: supports D1 D2
[    0.274802] pci 0000:19:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274962] pci 0000:19:04.0: [8086:1513] type 01 class 0x060400
[    0.275086] pci 0000:19:04.0: enabling Extended Tags
[    0.275268] pci 0000:19:04.0: supports D1 D2
[    0.275270] pci 0000:19:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275430] pci 0000:19:05.0: [8086:1513] type 01 class 0x060400
[    0.275537] pci 0000:19:05.0: enabling Extended Tags
[    0.275719] pci 0000:19:05.0: supports D1 D2
[    0.275721] pci 0000:19:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275900] pci 0000:18:00.0: PCI bridge to [bus 19-ff]
[    0.275919] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.275933] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.275939] pci 0000:19:00.0: bridge configuration invalid ([bus 3b-3d]), reconfiguring
[    0.275956] pci 0000:19:01.0: bridge configuration invalid ([bus 3e-3e]), reconfiguring
[    0.275973] pci 0000:19:02.0: bridge configuration invalid ([bus 3f-3f]), reconfiguring
[    0.275990] pci 0000:19:04.0: bridge configuration invalid ([bus 40-48]), reconfiguring
[    0.276006] pci 0000:19:05.0: bridge configuration invalid ([bus 49-49]), reconfiguring
[    0.276160] pci 0000:1a:00.0: [12d8:400c] type 01 class 0x060400
[    0.276548] pci 0000:1a:00.0: supports D1 D2
[    0.276550] pci 0000:1a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.303348] pci 0000:19:00.0: PCI bridge to [bus 1a-ff]
[    0.303373] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.303395] pci 0000:1a:00.0: bridge configuration invalid ([bus 3c-3d]), reconfiguring
[    0.303631] pci 0000:1b:03.0: [12d8:400c] type 01 class 0x060400
[    0.303967] pci 0000:1b:03.0: supports D1 D2
[    0.303969] pci 0000:1b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304170] pci 0000:1a:00.0: PCI bridge to [bus 1b-ff]
[    0.304195] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.304216] pci 0000:1b:03.0: bridge configuration invalid ([bus 3d-3d]), reconfiguring
[    0.304421] pci 0000:1c:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.304472] pci 0000:1c:00.0: reg 0x10: [mem 0xa9401000-0xa9401fff]
[    0.304785] pci 0000:1c:00.0: supports D1 D2
[    0.304787] pci 0000:1c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304942] pci 0000:1c:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.304994] pci 0000:1c:00.1: reg 0x10: [mem 0xa9400000-0xa9400fff]
[    0.305306] pci 0000:1c:00.1: supports D1 D2
[    0.305308] pci 0000:1c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.305435] pci 0000:1c:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.305486] pci 0000:1c:00.2: reg 0x10: [mem 0xa9402000-0xa94020ff]
[    0.305799] pci 0000:1c:00.2: supports D1 D2
[    0.305801] pci 0000:1c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.306058] pci 0000:1b:03.0: PCI bridge to [bus 1c-ff]
[    0.306083] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.306101] pci_bus 0000:1c: busn_res: [bus 1c-ff] end is updated to 1c
[    0.306111] pci_bus 0000:1b: busn_res: [bus 1b-ff] end is updated to 1c
[    0.306122] pci_bus 0000:1a: busn_res: [bus 1a-ff] end is updated to 1c
[    0.306269] pci 0000:1d:00.0: [14e4:16b0] type 00 class 0x020000
[    0.306338] pci 0000:1d:00.0: reg 0x10: [mem 0xad000000-0xad00ffff 64bit pref]
[    0.306384] pci 0000:1d:00.0: reg 0x18: [mem 0xad010000-0xad01ffff 64bit pref]
[    0.306727] pci 0000:1d:00.0: PME# supported from D0 D3hot D3cold
[    0.333368] pci 0000:19:01.0: PCI bridge to [bus 1d-ff]
[    0.333392] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.333410] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.333416] pci_bus 0000:1d: busn_res: [bus 1d-ff] end is updated to 1d
[    0.333571] pci 0000:1e:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.333641] pci 0000:1e:00.0: reg 0x10: [mem 0xa9200000-0xa9200fff 64bit]
[    0.333994] pci 0000:1e:00.0: supports D1 D2
[    0.333996] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.363367] pci 0000:19:02.0: PCI bridge to [bus 1e-ff]
[    0.363392] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.363409] pci_bus 0000:1e: busn_res: [bus 1e-ff] end is updated to 1e
[    0.363591] pci 0000:1f:00.0: [8086:1513] type 01 class 0x060400
[    0.363762] pci 0000:1f:00.0: enabling Extended Tags
[    0.364021] pci 0000:1f:00.0: supports D1 D2
[    0.364023] pci 0000:1f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.393353] pci 0000:19:04.0: PCI bridge to [bus 1f-ff]
[    0.393378] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.393395] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.393406] pci 0000:1f:00.0: bridge configuration invalid ([bus 41-48]), reconfiguring
[    0.393635] pci 0000:20:00.0: [8086:1513] type 01 class 0x060400
[    0.393814] pci 0000:20:00.0: enabling Extended Tags
[    0.394074] pci 0000:20:00.0: supports D1 D2
[    0.394076] pci 0000:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394295] pci 0000:20:01.0: [8086:1513] type 01 class 0x060400
[    0.394473] pci 0000:20:01.0: enabling Extended Tags
[    0.394733] pci 0000:20:01.0: supports D1 D2
[    0.394735] pci 0000:20:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394951] pci 0000:20:02.0: [8086:1513] type 01 class 0x060400
[    0.395130] pci 0000:20:02.0: enabling Extended Tags
[    0.395389] pci 0000:20:02.0: supports D1 D2
[    0.395391] pci 0000:20:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.395616] pci 0000:20:04.0: [8086:1513] type 01 class 0x060400
[    0.395771] pci 0000:20:04.0: enabling Extended Tags
[    0.396035] pci 0000:20:04.0: supports D1 D2
[    0.396036] pci 0000:20:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.396263] pci 0000:20:05.0: [8086:1513] type 01 class 0x060400
[    0.396417] pci 0000:20:05.0: enabling Extended Tags
[    0.396682] pci 0000:20:05.0: supports D1 D2
[    0.396684] pci 0000:20:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.396938] pci 0000:1f:00.0: PCI bridge to [bus 20-ff]
[    0.396964] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.396983] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.396990] pci 0000:20:00.0: bridge configuration invalid ([bus 42-44]), reconfiguring
[    0.397013] pci 0000:20:01.0: bridge configuration invalid ([bus 45-45]), reconfiguring
[    0.397037] pci 0000:20:02.0: bridge configuration invalid ([bus 46-46]), reconfiguring
[    0.397060] pci 0000:20:04.0: bridge configuration invalid ([bus 47-47]), reconfiguring
[    0.397083] pci 0000:20:05.0: bridge configuration invalid ([bus 48-48]), reconfiguring
[    0.397295] pci 0000:21:00.0: [12d8:400c] type 01 class 0x060400
[    0.397815] pci 0000:21:00.0: supports D1 D2
[    0.397817] pci 0000:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.398084] pci 0000:20:00.0: PCI bridge to [bus 21-ff]
[    0.398111] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.398135] pci 0000:21:00.0: bridge configuration invalid ([bus 43-44]), reconfiguring
[    0.398432] pci 0000:22:03.0: [12d8:400c] type 01 class 0x060400
[    0.398881] pci 0000:22:03.0: supports D1 D2
[    0.398883] pci 0000:22:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.399147] pci 0000:21:00.0: PCI bridge to [bus 22-ff]
[    0.399180] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.399208] pci 0000:22:03.0: bridge configuration invalid ([bus 44-44]), reconfiguring
[    0.399479] pci 0000:23:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.399547] pci 0000:23:00.0: reg 0x10: [mem 0xa9101000-0xa9101fff]
[    0.399965] pci 0000:23:00.0: supports D1 D2
[    0.399967] pci 0000:23:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400175] pci 0000:23:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.400243] pci 0000:23:00.1: reg 0x10: [mem 0xa9100000-0xa9100fff]
[    0.400660] pci 0000:23:00.1: supports D1 D2
[    0.400663] pci 0000:23:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400826] pci 0000:23:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.400894] pci 0000:23:00.2: reg 0x10: [mem 0xa9102000-0xa91020ff]
[    0.401311] pci 0000:23:00.2: supports D1 D2
[    0.401313] pci 0000:23:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.401664] pci 0000:22:03.0: PCI bridge to [bus 23-ff]
[    0.401697] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.401720] pci_bus 0000:23: busn_res: [bus 23-ff] end is updated to 23
[    0.401733] pci_bus 0000:22: busn_res: [bus 22-ff] end is updated to 23
[    0.401745] pci_bus 0000:21: busn_res: [bus 21-ff] end is updated to 23
[    0.401947] pci 0000:24:00.0: [14e4:16b0] type 00 class 0x020000
[    0.402038] pci 0000:24:00.0: reg 0x10: [mem 0xacf00000-0xacf0ffff 64bit pref]
[    0.402098] pci 0000:24:00.0: reg 0x18: [mem 0xacf10000-0xacf1ffff 64bit pref]
[    0.402550] pci 0000:24:00.0: PME# supported from D0 D3hot D3cold
[    0.402866] pci 0000:20:01.0: PCI bridge to [bus 24-ff]
[    0.402893] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.402912] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.402915] pci_bus 0000:24: busn_res: [bus 24-ff] end is updated to 24
[    0.403111] pci 0000:25:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.403202] pci 0000:25:00.0: reg 0x10: [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.403667] pci 0000:25:00.0: supports D1 D2
[    0.403669] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.403966] pci 0000:20:02.0: PCI bridge to [bus 25-ff]
[    0.403993] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.404012] pci_bus 0000:25: busn_res: [bus 25-ff] end is updated to 25
[    0.404144] pci 0000:20:04.0: PCI bridge to [bus 26-ff]
[    0.404171] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.404190] pci_bus 0000:26: busn_res: [bus 26-ff] end is updated to 35
[    0.404321] pci 0000:20:05.0: PCI bridge to [bus 36-ff]
[    0.404348] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.404367] pci_bus 0000:36: busn_res: [bus 36-ff] end is updated to 45
[    0.404378] pci_bus 0000:20: busn_res: [bus 20-ff] end is updated to 45
[    0.404389] pci_bus 0000:1f: busn_res: [bus 1f-ff] end is updated to 45
[    0.404482] pci 0000:19:05.0: PCI bridge to [bus 46-ff]
[    0.404501] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.404515] pci_bus 0000:46: busn_res: [bus 46-ff] end is updated to 55
[    0.404523] pci_bus 0000:19: busn_res: [bus 19-ff] end is updated to 55
[    0.404531] pci_bus 0000:18: busn_res: [bus 18-ff] end is updated to 55
[    0.404593] pci 0000:06:05.0: PCI bridge to [bus 56-ff]
[    0.404605] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.404614] pci_bus 0000:56: busn_res: [bus 56-ff] end is updated to 65
[    0.404670] pci 0000:06:06.0: PCI bridge to [bus 66-ff]
[    0.404682] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.404691] pci_bus 0000:66: busn_res: [bus 66-ff] end is updated to 75
[    0.404697] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 75
[    0.404702] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 75
[    0.404707] pci_bus 0000:00: on NUMA node 0
[    0.404973] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.404976] ACPI: PCI: Interrupt link LNKA disabled
[    0.405007] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.405009] ACPI: PCI: Interrupt link LNKB disabled
[    0.405038] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.405041] ACPI: PCI: Interrupt link LNKC disabled
[    0.405069] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.405071] ACPI: PCI: Interrupt link LNKD disabled
[    0.405100] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.405102] ACPI: PCI: Interrupt link LNKE disabled
[    0.405130] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.405132] ACPI: PCI: Interrupt link LNKF disabled
[    0.405160] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.405162] ACPI: PCI: Interrupt link LNKG disabled
[    0.405191] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.405193] ACPI: PCI: Interrupt link LNKH disabled
[    0.405279] ACPI: EC: interrupt unblocked
[    0.405282] ACPI: EC: event unblocked
[    0.405286] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.405288] ACPI: EC: GPE=0x17
[    0.405290] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.405293] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.405346] SCSI subsystem initialized
[    0.405353] libata version 3.00 loaded.
[    0.405353] Registered efivars operations
[    0.405353] PCI: Using ACPI for IRQ routing
[    0.415972] PCI: pci_cache_line_size set to 64 bytes
[    0.415975] pci 0000:00:1c.4: can't claim BAR 9 [mem 0xacf00000-0xb10fffff 64bit pref]: address conflict with PCI Bus 0000:05 [mem 0xa8a00000-0xad6fffff]
[    0.416254] e820: reserve RAM buffer [mem 0x0008e000-0x0008ffff]
[    0.416256] e820: reserve RAM buffer [mem 0x89109018-0x8bffffff]
[    0.416257] e820: reserve RAM buffer [mem 0x891a7018-0x8bffffff]
[    0.416258] e820: reserve RAM buffer [mem 0x8ed33000-0x8fffffff]
[    0.416259] e820: reserve RAM buffer [mem 0x8ed71000-0x8fffffff]
[    0.416261] e820: reserve RAM buffer [mem 0x8ee5a000-0x8fffffff]
[    0.416262] e820: reserve RAM buffer [mem 0x8eed7000-0x8fffffff]
[    0.416263] e820: reserve RAM buffer [mem 0x8efa3000-0x8fffffff]
[    0.416264] e820: reserve RAM buffer [mem 0x86ff00000-0x86fffffff]
[    0.416273] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.416273] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.416273] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.416273] vgaarb: loaded
[    0.416273] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.416273] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.416281] clocksource: Switched to clocksource tsc-early
[    0.416319] VFS: Disk quotas dquot_6.6.0
[    0.416329] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.416361] pnp: PnP ACPI init
[    0.416469] system 00:00: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.416513] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.416516] system 00:01: [io  0x1000-0x100f] has been reserved
[    0.416519] system 00:01: [io  0xffff] has been reserved
[    0.416522] system 00:01: [io  0xffff] has been reserved
[    0.416524] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.416526] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.416529] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.416681] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.416685] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.416687] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.416690] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.416693] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.416696] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.416698] system 00:03: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.416701] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.416703] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[    0.416706] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.416789] pnp: PnP ACPI: found 4 devices
[    0.416804] pci 0000:01:00.0: assigning 75 device properties
[    0.416804] pci 0000:04:00.0: assigning 2 device properties
[    0.416804] pci 0000:07:00.0: assigning 5 device properties
[    0.416804] pci 0000:1e:00.0: assigning 2 device properties
[    0.416804] pci 0000:25:00.0: assigning 2 device properties
[    0.416804] pci 0000:00:1b.0: assigning 4 device properties
[    0.419125] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.419146] NET: Registered PF_INET protocol family
[    0.419306] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.421162] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.421200] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.421467] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.421553] TCP: Hash tables configured (established 262144 bind 65536)
[    0.421579] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.421639] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.421718] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.421726] pci 0000:03:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[    0.421734] pci_bus 0000:00: max bus depth: 9 pci_try_num: 10
[    0.421745] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.421749] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.421753] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.421756] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.421760] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.421765] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.421769] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.421777] pci 0000:03:00.0: BAR 6: assigned [mem 0xa8620000-0xa862ffff pref]
[    0.421781] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.421786] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.421794] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.421798] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.421807] pci 0000:05:00.0: BAR 7: no space for [io  size 0x8000]
[    0.421809] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x8000]
[    0.421814] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421817] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421820] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421823] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421826] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421829] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421832] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.421834] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421837] pci 0000:06:04.0: BAR 7: no space for [io  size 0x5000]
[    0.421839] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.421841] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.421844] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421847] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.421849] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421853] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.421859] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.421871] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.421878] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.421890] pci 0000:18:00.0: BAR 7: no space for [io  size 0x4000]
[    0.421893] pci 0000:18:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.421896] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421899] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421902] pci 0000:19:04.0: BAR 7: no space for [io  size 0x3000]
[    0.421904] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.421907] pci 0000:19:05.0: BAR 7: no space for [io  size 0x1000]
[    0.421909] pci 0000:19:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421912] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.421925] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.421950] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.421964] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.421988] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.421999] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422018] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.422029] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.422037] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.422051] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.422061] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.422081] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.422083] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.422087] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422089] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422093] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422096] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422099] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[    0.422101] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422103] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422105] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422108] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.422125] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422158] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.422175] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422208] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.422222] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422249] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.422263] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.422274] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422293] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.422308] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.422334] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.422349] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.422375] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.422390] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.422416] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.422431] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.422441] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422460] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.422470] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.422478] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422492] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.422503] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.422522] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.422532] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.422540] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422554] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.422561] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.422566] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422575] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.422582] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.422593] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.422600] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.422612] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.422619] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.422624] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422633] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.422636] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.422640] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.422648] pci_bus 0000:00: No. 2 try to assign unassigned res
[    0.422656] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.422659] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.422662] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.422665] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.422669] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.422674] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.422678] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.422684] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.422689] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.422697] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.422701] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.422709] pci 0000:05:00.0: BAR 7: no space for [io  size 0x8000]
[    0.422711] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x8000]
[    0.422715] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422718] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422721] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422724] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422727] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422730] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422733] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.422735] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422737] pci 0000:06:04.0: BAR 7: no space for [io  size 0x5000]
[    0.422740] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.422742] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422744] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422747] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.422749] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422752] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.422758] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.422770] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.422777] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.422789] pci 0000:18:00.0: BAR 7: no space for [io  size 0x4000]
[    0.422791] pci 0000:18:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.422794] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422797] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422800] pci 0000:19:04.0: BAR 7: no space for [io  size 0x3000]
[    0.422802] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.422805] pci 0000:19:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422807] pci 0000:19:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422809] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.422823] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422848] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.422861] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422886] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.422896] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422915] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.422926] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.422934] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.422948] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.422958] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.422977] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.422980] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.422983] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422986] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422989] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422992] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422995] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[    0.422997] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.423000] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[    0.423002] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.423004] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.423022] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423054] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.423071] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423104] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.423118] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423145] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.423159] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.423170] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423189] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.423203] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.423230] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.423244] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.423271] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.423285] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.423312] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.423326] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.423337] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423355] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.423366] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.423374] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423388] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.423398] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.423418] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.423428] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.423436] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423449] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.423456] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.423462] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423471] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.423477] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.423489] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.423496] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.423508] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.423514] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.423519] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423528] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.423531] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.423536] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.423544] pci_bus 0000:00: No. 3 try to assign unassigned res
[    0.423546] release child resource [mem 0xa9100000-0xa9100fff]
[    0.423547] release child resource [mem 0xa9101000-0xa9101fff]
[    0.423548] release child resource [mem 0xa9102000-0xa91020ff]
[    0.423549] pci 0000:22:03.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423551] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.423563] pci 0000:21:00.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423566] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.423578] pci 0000:20:00.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423580] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.423591] release child resource [mem 0xacf00000-0xacf0ffff 64bit pref]
[    0.423591] release child resource [mem 0xacf10000-0xacf1ffff 64bit pref]
[    0.423592] pci 0000:20:01.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423595] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.423618] release child resource [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.423618] pci 0000:20:02.0: resource 8 [mem 0xa8f00000-0xa8ffffff] released
[    0.423621] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.423631] pci 0000:20:04.0: resource 8 [mem 0xa8e00000-0xa8efffff] released
[    0.423634] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.423644] pci 0000:20:05.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.423646] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.423657] pci 0000:1f:00.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423659] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.423682] release child resource [mem 0xa9400000-0xa9400fff]
[    0.423683] release child resource [mem 0xa9401000-0xa9401fff]
[    0.423684] release child resource [mem 0xa9402000-0xa94020ff]
[    0.423685] pci 0000:1b:03.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423687] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.423697] pci 0000:1a:00.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423699] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.423709] pci 0000:19:00.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423711] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.423719] release child resource [mem 0xad000000-0xad00ffff 64bit pref]
[    0.423720] release child resource [mem 0xad010000-0xad01ffff 64bit pref]
[    0.423720] pci 0000:19:01.0: resource 9 [mem 0xad000000-0xad0fffff 64bit pref] released
[    0.423723] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.423739] release child resource [mem 0xa9200000-0xa9200fff 64bit]
[    0.423740] pci 0000:19:02.0: resource 8 [mem 0xa9200000-0xa92fffff] released
[    0.423743] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.423750] pci 0000:19:04.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423753] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.423769] pci 0000:19:05.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.423772] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.423779] pci 0000:18:00.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423782] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.423799] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.423800] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.423801] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.423803] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.423808] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xa8bfffff] released
[    0.423811] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.423816] pci 0000:06:04.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423819] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.423829] pci 0000:06:05.0: resource 8 [mem 0xa9500000-0xa95fffff] released
[    0.423831] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.423837] pci 0000:06:06.0: resource 8 [mem 0xa9600000-0xa96fffff] released
[    0.423839] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.423844] pci 0000:05:00.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423847] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.423858] pci 0000:00:1c.4: resource 7 [io  0x4000-0x4fff] released
[    0.423860] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.423875] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.423878] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.423882] pci 0000:00:1c.4: BAR 7: assigned [io  0x4000-0xbfff]
[    0.423884] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.423887] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.423890] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.423893] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.423897] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.423902] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.423906] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.423912] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.423917] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.423924] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.423929] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.423938] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.423940] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.423943] pci 0000:05:00.0: BAR 7: assigned [io  0x4000-0xbfff]
[    0.423947] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.423950] pci 0000:06:03.0: BAR 8: no space for [mem size 0x08000000]
[    0.423952] pci 0000:06:03.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.423955] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423958] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423961] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.423964] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.423967] pci 0000:06:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.423969] pci 0000:06:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.423972] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423975] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423978] pci 0000:06:06.0: BAR 8: no space for [mem size 0x08000000]
[    0.423980] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.423983] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423986] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423989] pci 0000:06:03.0: BAR 7: assigned [io  0x4000-0x4fff]
[    0.423991] pci 0000:06:04.0: BAR 7: assigned [io  0x5000-0x9fff]
[    0.423994] pci 0000:06:05.0: BAR 7: assigned [io  0xa000-0xafff]
[    0.423996] pci 0000:06:06.0: BAR 7: assigned [io  0xb000-0xbfff]
[    0.423999] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.424006] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.424012] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.424019] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.424030] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.424034] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.424051] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.424054] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.424057] pci 0000:18:00.0: BAR 7: assigned [io  0x5000-0x8fff]
[    0.424060] pci 0000:19:00.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424063] pci 0000:19:01.0: BAR 9: assigned [mem 0xa9200000-0xa92fffff 64bit pref]
[    0.424066] pci 0000:19:02.0: BAR 8: assigned [mem 0xa9400000-0xa94fffff]
[    0.424069] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.424071] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.424074] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424077] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424079] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424082] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424085] pci 0000:19:04.0: BAR 7: assigned [io  0x5000-0x7fff]
[    0.424087] pci 0000:19:05.0: BAR 7: assigned [io  0x8000-0x8fff]
[    0.424090] pci 0000:1a:00.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424093] pci 0000:1b:03.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424096] pci 0000:1c:00.0: BAR 0: assigned [mem 0xa8c00000-0xa8c00fff]
[    0.424106] pci 0000:1c:00.1: BAR 0: assigned [mem 0xa8c01000-0xa8c01fff]
[    0.424117] pci 0000:1c:00.2: BAR 0: assigned [mem 0xa8c02000-0xa8c020ff]
[    0.424127] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.424140] pci 0000:1b:03.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424165] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.424178] pci 0000:1a:00.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424203] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.424214] pci 0000:19:00.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424233] pci 0000:1d:00.0: BAR 0: assigned [mem 0xa9200000-0xa920ffff 64bit pref]
[    0.424264] pci 0000:1d:00.0: BAR 2: assigned [mem 0xa9210000-0xa921ffff 64bit pref]
[    0.424294] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.424305] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.424313] pci 0000:19:01.0:   bridge window [mem 0xa9200000-0xa92fffff 64bit pref]
[    0.424327] pci 0000:1e:00.0: BAR 0: assigned [mem 0xa9400000-0xa9400fff 64bit]
[    0.424357] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.424368] pci 0000:19:02.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.424387] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.424390] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.424393] pci 0000:1f:00.0: BAR 7: assigned [io  0x5000-0x6fff]
[    0.424396] pci 0000:20:00.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424399] pci 0000:20:01.0: BAR 9: assigned [mem 0xa8e00000-0xa8efffff 64bit pref]
[    0.424402] pci 0000:20:02.0: BAR 8: assigned [mem 0xa8f00000-0xa8ffffff]
[    0.424405] pci 0000:20:04.0: BAR 8: no space for [mem size 0x08000000]
[    0.424407] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424410] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424413] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424416] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424418] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424421] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424424] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424427] pci 0000:20:04.0: BAR 7: assigned [io  0x5000-0x5fff]
[    0.424429] pci 0000:20:05.0: BAR 7: assigned [io  0x6000-0x6fff]
[    0.424432] pci 0000:21:00.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424435] pci 0000:22:03.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424438] pci 0000:23:00.0: BAR 0: assigned [mem 0xa8d00000-0xa8d00fff]
[    0.424450] pci 0000:23:00.1: BAR 0: assigned [mem 0xa8d01000-0xa8d01fff]
[    0.424463] pci 0000:23:00.2: BAR 0: assigned [mem 0xa8d02000-0xa8d020ff]
[    0.424475] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.424493] pci 0000:22:03.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424525] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.424543] pci 0000:21:00.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424575] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.424590] pci 0000:20:00.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424617] pci 0000:24:00.0: BAR 0: assigned [mem 0xa8e00000-0xa8e0ffff 64bit pref]
[    0.424656] pci 0000:24:00.0: BAR 2: assigned [mem 0xa8e10000-0xa8e1ffff 64bit pref]
[    0.424695] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.424710] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.424720] pci 0000:20:01.0:   bridge window [mem 0xa8e00000-0xa8efffff 64bit pref]
[    0.424740] pci 0000:25:00.0: BAR 0: assigned [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.424779] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.424793] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.424820] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.424826] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.424865] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.424872] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.424911] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.424917] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.424931] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.424958] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.424962] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.424973] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.424992] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.424997] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.425025] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.425029] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.425040] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.425059] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.425062] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.425069] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.425081] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.425085] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.425101] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.425105] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.425121] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.425124] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.425131] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.425142] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.425145] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.425150] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.425158] pci_bus 0000:00: No. 4 try to assign unassigned res
[    0.425160] release child resource [mem 0xa8d00000-0xa8d00fff]
[    0.425161] release child resource [mem 0xa8d01000-0xa8d01fff]
[    0.425161] release child resource [mem 0xa8d02000-0xa8d020ff]
[    0.425162] pci 0000:22:03.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425165] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.425177] pci 0000:21:00.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425179] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.425192] pci 0000:20:00.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425194] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.425204] release child resource [mem 0xa8e00000-0xa8e0ffff 64bit pref]
[    0.425205] release child resource [mem 0xa8e10000-0xa8e1ffff 64bit pref]
[    0.425206] pci 0000:20:01.0: resource 9 [mem 0xa8e00000-0xa8efffff 64bit pref] released
[    0.425209] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.425231] release child resource [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.425232] pci 0000:20:02.0: resource 8 [mem 0xa8f00000-0xa8ffffff] released
[    0.425234] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.425244] release child resource [mem 0xa9000000-0xa90fffff]
[    0.425245] pci 0000:1f:00.0: resource 8 [mem 0xa8d00000-0xa91fffff] released
[    0.425248] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.425258] pci 0000:19:04.0: resource 8 [mem 0xa8d00000-0xa91fffff] released
[    0.425261] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.425268] release child resource [mem 0xa8c00000-0xa8c00fff]
[    0.425269] release child resource [mem 0xa8c01000-0xa8c01fff]
[    0.425270] release child resource [mem 0xa8c02000-0xa8c020ff]
[    0.425271] pci 0000:1b:03.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425273] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.425283] pci 0000:1a:00.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425285] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.425295] pci 0000:19:00.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425297] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.425305] release child resource [mem 0xa9200000-0xa920ffff 64bit pref]
[    0.425305] release child resource [mem 0xa9210000-0xa921ffff 64bit pref]
[    0.425306] pci 0000:19:01.0: resource 9 [mem 0xa9200000-0xa92fffff 64bit pref] released
[    0.425309] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.425325] release child resource [mem 0xa9400000-0xa9400fff 64bit]
[    0.425326] pci 0000:19:02.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.425329] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.425336] release child resource [mem 0xa9300000-0xa93fffff]
[    0.425337] pci 0000:18:00.0: resource 8 [mem 0xa8c00000-0xa94fffff] released
[    0.425340] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.425348] pci 0000:06:04.0: resource 8 [mem 0xa8c00000-0xa94fffff] released
[    0.425350] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.425355] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.425356] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.425357] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.425359] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.425365] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xa96fffff] released
[    0.425367] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.425374] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xad6fffff] released
[    0.425376] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.425380] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425381] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.425384] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425387] release child resource [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.425388] release child resource [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.425389] pci 0000:00:1c.0: resource 9 [mem 0xa8400000-0xa84fffff 64bit pref] released
[    0.425392] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.425398] release child resource [mem 0xa8600000-0xa861ffff 64bit]
[    0.425399] release child resource [mem 0xa8620000-0xa862ffff pref]
[    0.425400] pci 0000:00:1c.1: resource 8 [mem 0xa8600000-0xa86fffff] released
[    0.425402] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.425406] release child resource [mem 0xa8500000-0xa8500fff 64bit]
[    0.425407] pci 0000:00:1c.2: resource 8 [mem 0xa8500000-0xa85fffff] released
[    0.425409] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.425422] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425426] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.425430] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.425432] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.425435] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.425439] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.425442] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.425446] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425454] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425456] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.425459] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.425462] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425466] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.425482] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.425497] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.425502] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.425506] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.425513] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.425527] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.425530] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.425535] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.425543] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.425559] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.425563] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.425571] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.425574] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.425577] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.425580] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.425583] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.425586] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425589] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425592] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.425594] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.425597] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.425600] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.425603] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425606] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425609] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.425611] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425614] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425617] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.425624] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.425630] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.425637] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.425648] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.425652] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.425659] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.425671] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.425674] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.425676] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.425680] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425683] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.425685] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.425688] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.425691] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.425694] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.425696] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.425699] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.425702] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.425705] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425707] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425710] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425713] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425716] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.425726] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.425736] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.425746] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.425760] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425784] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.425798] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425823] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.425833] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425853] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.425884] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.425914] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.425924] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.425932] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.425947] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.425977] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.425987] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.426007] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.426009] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.426012] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.426016] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426018] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.426021] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.426024] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.426027] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.426029] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.426032] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.426035] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.426038] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.426040] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.426043] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.426046] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426049] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426052] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.426064] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.426077] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.426090] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.426107] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426140] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.426157] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426189] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.426204] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426231] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.426270] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.426310] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.426324] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.426334] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.426354] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.426393] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.426408] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.426434] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.426441] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.426455] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.426482] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.426488] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.426527] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.426534] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.426548] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.426575] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.426579] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.426590] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.426610] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.426614] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.426642] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.426647] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.426657] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.426676] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.426680] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.426687] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.426699] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.426702] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.426709] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.426721] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.426725] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.426731] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.426743] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.426747] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.426754] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.426765] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.426768] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.426773] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.426781] pci_bus 0000:00: No. 5 try to assign unassigned res
[    0.426783] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.426783] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.426784] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.426785] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426787] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.426800] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426802] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.426814] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426817] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.426827] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.426828] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.426828] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.426831] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.426854] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.426855] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.426857] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.426867] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.426870] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.426880] release child resource [mem 0xb1000000-0xb10fffff]
[    0.426881] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.426883] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.426894] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.426896] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.426904] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.426904] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.426905] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.426906] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426908] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.426918] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426920] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.426930] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426932] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.426940] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.426941] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.426941] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.426944] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.426960] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.426961] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.426964] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.426971] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.426972] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.426975] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.426983] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.426985] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.426990] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.426991] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.426992] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.426994] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.426999] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427002] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427007] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427010] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427015] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427017] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427022] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427025] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427031] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427033] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427037] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427038] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427041] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427044] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427045] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427046] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427049] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427055] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427056] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427057] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427059] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427063] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427064] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427066] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427078] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427081] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427085] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427087] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427090] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427094] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427097] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427100] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427108] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427110] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427113] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427116] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427121] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427136] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427151] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427156] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427160] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427167] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427181] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427184] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427189] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427197] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427212] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427217] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427225] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427227] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427230] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427234] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427236] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427239] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427242] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427245] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427248] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427250] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427253] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427256] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427259] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427262] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427264] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427267] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427270] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427277] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427283] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427290] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427302] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427305] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427312] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427324] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427327] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427330] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427333] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427336] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427338] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427341] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427344] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427347] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427349] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427352] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427355] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427357] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427360] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427363] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427366] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427369] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427375] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427375] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427375] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427375] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427375] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427375] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427375] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427375] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427375] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427375] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427375] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427375] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427375] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427375] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427375] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427375] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427375] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427375] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427375] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427375] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427375] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427375] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427375] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427375] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427375] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427375] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427375] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427375] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427375] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427375] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427375] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427375] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427375] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427375] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427375] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427375] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427375] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427375] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427375] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427375] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427375] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427375] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427375] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427375] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427375] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427375] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427375] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427375] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427375] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427375] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427375] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427375] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427375] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427375] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427375] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427375] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427375] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci_bus 0000:00: No. 6 try to assign unassigned res
[    0.427375] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427375] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427375] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427375] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427375] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427375] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427375] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427375] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427375] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427375] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427375] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427375] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427375] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427375] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427375] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427375] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427375] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427375] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427375] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427375] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427375] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427375] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427375] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427375] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427375] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427375] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427375] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427375] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427375] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427375] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427375] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427375] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427375] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427375] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427375] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427375] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427375] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427375] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427375] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427375] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427375] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427375] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427375] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427375] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427375] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427375] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427375] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427375] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427375] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427375] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427375] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427375] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427375] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427375] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427375] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427375] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427375] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427375] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427375] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427375] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427375] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427375] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427375] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427375] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427375] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427375] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427375] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427375] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427375] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427375] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427375] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427375] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427375] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427375] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427375] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427375] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427375] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427375] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427375] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427375] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427375] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427375] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427375] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427375] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427375] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427375] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427375] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427375] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427375] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427375] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427375] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427375] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427375] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427375] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427375] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427375] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427375] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427375] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427375] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427375] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427375] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427375] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427375] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427375] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427375] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427375] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427375] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427375] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427375] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427375] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427375] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427375] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427375] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427375] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427375] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427375] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427375] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427375] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427375] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427375] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427375] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427375] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427375] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427375] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427375] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427375] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427375] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427375] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427375] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427375] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427375] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427375] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427375] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427375] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427375] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427375] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427375] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427375] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427375] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427375] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427375] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427375] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427375] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427375] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427375] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427375] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427375] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427375] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427375] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427375] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427375] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427375] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427375] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427375] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427375] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427375] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427375] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427375] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427375] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427375] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427375] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427375] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci_bus 0000:00: No. 7 try to assign unassigned res
[    0.427375] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427375] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427375] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427375] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427375] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427375] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427375] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427375] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427375] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427375] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427375] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427375] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427375] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427375] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427375] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427375] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427375] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427375] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427375] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427375] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427375] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427375] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427375] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427375] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427375] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427375] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427375] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427375] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427375] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427375] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427375] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427375] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427375] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427375] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427375] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427375] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427375] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427375] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427375] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427375] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427375] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427375] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427375] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427375] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427375] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427375] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427375] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427375] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427375] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427375] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427375] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427375] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427375] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427375] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427375] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427375] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427375] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427375] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427375] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427375] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427375] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427375] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427375] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427375] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427375] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427375] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427375] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427375] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427375] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427375] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427375] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427375] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427375] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427375] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427375] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427375] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427375] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427375] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427375] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427375] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427375] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427375] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427375] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427375] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427375] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427375] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427375] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427375] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427375] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427375] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427375] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427375] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427375] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427375] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427375] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427375] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427375] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427375] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427375] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427375] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427375] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427375] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427375] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427375] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427375] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427375] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427375] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427375] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427375] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427375] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427375] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427375] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427375] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427375] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427375] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427375] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427375] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427375] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427375] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427375] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427375] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427375] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427375] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427375] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427375] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427375] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427375] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427375] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427375] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427375] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427375] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427375] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427375] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427375] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427375] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427375] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427375] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427375] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427375] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427375] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427375] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427375] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427375] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427375] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427375] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427375] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427375] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427375] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427375] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427375] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427375] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427375] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427375] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427375] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427375] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427375] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427375] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427375] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427375] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427375] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427375] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427375] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci_bus 0000:00: No. 8 try to assign unassigned res
[    0.427375] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427375] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427375] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427375] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427375] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427375] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427375] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427375] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427375] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427375] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427375] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427375] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427375] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427375] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427375] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427375] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427375] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427375] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427375] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427375] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427375] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427375] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427375] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427375] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427375] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427375] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427375] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427375] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427375] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427375] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427375] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427375] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427375] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427375] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427375] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427375] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427375] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427375] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427375] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427375] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427375] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427375] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427375] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427375] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427375] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427375] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427375] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427375] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427375] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427375] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427375] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427375] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427375] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427375] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427375] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427375] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427375] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427375] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427375] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427375] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427375] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427375] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427375] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427375] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427375] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427375] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427375] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427375] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427375] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427375] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427375] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427375] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427375] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427375] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427375] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427375] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427375] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427375] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427375] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427375] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427375] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427375] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427375] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427375] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427375] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427375] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427375] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427375] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427375] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427375] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427375] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427375] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427375] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427375] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427375] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427375] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427375] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427375] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427375] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427375] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427375] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427375] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427375] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427375] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427375] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427375] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427375] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427375] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427375] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427375] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427375] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427375] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427375] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427375] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427375] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427375] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427375] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427375] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427375] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427375] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427375] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427375] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427375] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427375] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427375] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427375] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427375] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427375] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427375] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427375] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427375] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427375] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427375] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427375] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427375] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427375] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427375] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427375] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427375] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427375] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427375] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427375] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427375] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427375] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427375] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427375] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427375] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427375] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427375] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427375] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427375] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427375] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427375] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427375] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427375] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427375] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427375] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427375] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427375] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427375] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427375] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427375] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427375] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427375] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427375] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.433326] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.433330] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.433337] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.433349] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.433352] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.433359] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.433370] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.433373] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.433378] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.433386] pci_bus 0000:00: No. 9 try to assign unassigned res
[    0.433388] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.433389] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.433390] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.433391] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433393] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.433405] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433408] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.433420] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433422] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.433433] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.433433] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.433434] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.433437] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.433459] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.433460] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.433463] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.433473] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.433475] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.433486] release child resource [mem 0xb1000000-0xb10fffff]
[    0.433486] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.433489] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.433499] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.433502] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.433509] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.433510] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.433511] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.433512] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433514] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.433524] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433526] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.433535] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433538] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.433545] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.433546] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.433547] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.433550] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.433566] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.433567] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.433569] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.433577] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.433578] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.433580] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.433588] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.433591] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.433596] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.433597] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.433598] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.433600] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.433605] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.433608] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.433613] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.433615] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.433621] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.433623] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.433628] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.433631] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.433637] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.433639] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.433643] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433644] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.433647] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433650] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.433651] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.433652] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.433655] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.433661] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.433662] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.433663] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.433665] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.433669] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.433670] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.433672] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.433691] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433697] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.433702] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.433706] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.433712] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.433717] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.433720] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.433729] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433738] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433740] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.433743] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.433746] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433751] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.433766] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.433781] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.433786] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.433790] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.433797] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.433811] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.433814] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.433819] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.433827] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.433842] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.433847] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.433855] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.433858] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.433861] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.433864] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.433867] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.433870] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433872] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433875] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.433878] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.433881] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.433884] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.433887] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433889] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433892] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.433895] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433898] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433901] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.433907] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.433914] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.433920] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.433932] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.433936] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.433943] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.433955] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.433958] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.433960] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.433964] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.433966] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.433969] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.433972] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.433975] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.433977] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.433980] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.433983] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.433986] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.433988] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433991] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433994] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.433997] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434000] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.434010] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.434020] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.434030] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.434043] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434068] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.434081] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434106] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.434117] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434136] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.434167] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.434197] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.434208] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.434216] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.434230] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.434260] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.434271] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.434291] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.434293] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.434296] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.434299] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434302] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.434305] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.434308] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.434310] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.434313] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434316] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434319] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.434321] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.434324] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434327] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434330] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434332] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434335] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.434348] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.434361] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.434373] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.434390] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434423] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.434440] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434473] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.434488] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434515] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.434554] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.434593] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.434608] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.434618] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.434638] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.434677] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.434692] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.434719] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.434725] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.434739] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.434766] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.434773] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.434812] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.434818] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.434832] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.434859] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.434864] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.434874] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.434894] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.434899] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.434926] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.434931] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.434942] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.434961] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.434964] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.434971] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.434983] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.434986] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.434993] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.435005] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.435009] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.435016] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.435027] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.435031] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.435038] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.435049] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.435052] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.435057] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.435065] pci_bus 0000:00: No. 10 try to assign unassigned res
[    0.435067] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.435067] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.435068] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.435069] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435071] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.435084] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435086] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.435098] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435101] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.435111] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.435112] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.435113] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.435115] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.435138] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.435139] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.435141] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.435151] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.435154] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.435164] release child resource [mem 0xb1000000-0xb10fffff]
[    0.435165] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.435167] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.435178] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.435180] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.435188] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.435188] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.435189] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.435190] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435192] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.435202] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435204] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.435214] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435216] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.435224] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.435225] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.435226] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.435228] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.435244] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.435245] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.435248] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.435255] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.435256] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.435259] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.435267] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.435269] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.435274] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.435275] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.435276] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.435278] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.435283] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.435286] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.435291] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.435293] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.435299] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.435301] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.435306] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.435309] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.435315] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.435317] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.435321] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435322] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.435325] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.435328] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.435329] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.435330] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.435333] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.435339] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.435340] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.435341] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.435343] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.435347] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.435348] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.435350] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.435363] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435366] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.435370] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.435372] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.435375] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.435379] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.435382] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.435385] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435393] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.435396] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.435399] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.435402] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435406] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.435421] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.435436] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.435441] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.435445] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.435452] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.435466] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.435469] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.435474] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.435482] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.435497] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.435502] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.435510] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.435513] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.435515] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.435519] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.435522] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.435524] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435527] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435530] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.435533] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.435536] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.435539] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.435541] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435544] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435547] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.435550] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435553] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435556] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.435562] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.435568] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.435575] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.435587] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.435591] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.435597] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.435609] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.435612] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.435615] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.435618] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435621] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.435624] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.435627] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.435629] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.435632] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.435635] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.435638] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.435640] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.435643] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435645] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435649] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435651] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435654] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.435664] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.435674] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.435684] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.435698] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435723] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.435736] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435761] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.435771] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435791] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.435821] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.435851] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.435862] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.435870] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.435884] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.435915] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.435925] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.435944] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.435947] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.435950] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.435953] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.435956] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.435959] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.435962] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.435964] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.435967] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435970] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435973] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.435975] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.435978] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435981] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435984] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.435987] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.435989] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.436002] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.436015] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.436027] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.436044] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436077] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.436094] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436126] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.436141] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436168] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.436207] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.436247] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.436261] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.436271] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436291] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.436330] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.436344] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.436371] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.436377] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.436392] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.436419] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.436425] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.436464] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.436470] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.436484] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.436511] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.436516] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.436526] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.436545] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.436550] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.436578] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.436583] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.436593] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.436612] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.436616] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.436622] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.436634] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.436638] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.436645] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.436657] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.436660] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.436667] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.436679] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.436682] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.436689] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.436700] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.436703] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.436708] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.436716] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.436719] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.436721] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.436724] pci_bus 0000:00: resource 7 [mem 0x8f900000-0xfeafffff window]
[    0.436726] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff window]
[    0.436729] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.436731] pci_bus 0000:01: resource 1 [mem 0xa8800000-0xa88fffff]
[    0.436734] pci_bus 0000:01: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.436736] pci_bus 0000:02: resource 1 [mem 0xa8700000-0xa87fffff]
[    0.436739] pci_bus 0000:02: resource 2 [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.436741] pci_bus 0000:03: resource 1 [mem 0x8fa00000-0x8fafffff]
[    0.436744] pci_bus 0000:04: resource 1 [mem 0x8fb00000-0x8fbfffff]
[    0.436746] pci_bus 0000:05: resource 0 [io  0x4000-0xbfff]
[    0.436748] pci_bus 0000:05: resource 1 [mem 0xa8a00000-0xd90fffff]
[    0.436751] pci_bus 0000:06: resource 0 [io  0x4000-0xbfff]
[    0.436753] pci_bus 0000:06: resource 1 [mem 0xa8a00000-0xd90fffff]
[    0.436755] pci_bus 0000:07: resource 1 [mem 0xa8a00000-0xa8afffff]
[    0.436757] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    0.436760] pci_bus 0000:08: resource 1 [mem 0xa8b00000-0xb0afffff]
[    0.436762] pci_bus 0000:18: resource 0 [io  0x5000-0x9fff]
[    0.436764] pci_bus 0000:18: resource 1 [mem 0xb0b00000-0xc90fffff]
[    0.436766] pci_bus 0000:19: resource 0 [io  0x5000-0x8fff]
[    0.436769] pci_bus 0000:19: resource 1 [mem 0xb0b00000-0xc90fffff]
[    0.436771] pci_bus 0000:1a: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436773] pci_bus 0000:1b: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436776] pci_bus 0000:1c: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436778] pci_bus 0000:1d: resource 1 [mem 0xb0c00000-0xb0cfffff]
[    0.436780] pci_bus 0000:1d: resource 2 [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.436783] pci_bus 0000:1e: resource 1 [mem 0xb0e00000-0xb0efffff]
[    0.436785] pci_bus 0000:1f: resource 0 [io  0x5000-0x7fff]
[    0.436788] pci_bus 0000:1f: resource 1 [mem 0xb0f00000-0xc11fffff]
[    0.436790] pci_bus 0000:20: resource 0 [io  0x5000-0x6fff]
[    0.436792] pci_bus 0000:20: resource 1 [mem 0xb0f00000-0xc11fffff]
[    0.436794] pci_bus 0000:21: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436797] pci_bus 0000:22: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436799] pci_bus 0000:23: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436801] pci_bus 0000:24: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.436804] pci_bus 0000:24: resource 2 [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436806] pci_bus 0000:25: resource 1 [mem 0xb1200000-0xb12fffff]
[    0.436809] pci_bus 0000:26: resource 0 [io  0x5000-0x5fff]
[    0.436811] pci_bus 0000:26: resource 1 [mem 0xb1300000-0xb92fffff]
[    0.436813] pci_bus 0000:36: resource 0 [io  0x6000-0x6fff]
[    0.436815] pci_bus 0000:46: resource 0 [io  0x8000-0x8fff]
[    0.436818] pci_bus 0000:56: resource 0 [io  0xa000-0xafff]
[    0.436820] pci_bus 0000:56: resource 1 [mem 0xc9100000-0xd10fffff]
[    0.436822] pci_bus 0000:66: resource 0 [io  0xb000-0xbfff]
[    0.436824] pci_bus 0000:66: resource 1 [mem 0xd1100000-0xd90fffff]
[    0.437258] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.437275] pci 0000:05:00.0: CLS mismatch (256 != 128), using 64 bytes
[    0.437289] pci 0000:1c:00.0: MSI is not implemented on this device, disabling it
[    0.437291] pci 0000:1c:00.0: PME# is unreliable, disabling it
[    0.437587] pci 0000:1c:00.1: MSI is not implemented on this device, disabling it
[    0.437590] pci 0000:1c:00.1: PME# is unreliable, disabling it
[    0.437669] pci 0000:1c:00.2: MSI is not implemented on this device, disabling it
[    0.437672] pci 0000:1c:00.2: PME# is unreliable, disabling it
[    0.437727] pci 0000:1c:00.2: EHCI: unrecognized capability 00
[    0.437765] pci 0000:23:00.0: MSI is not implemented on this device, disabling it
[    0.437768] pci 0000:23:00.0: PME# is unreliable, disabling it
[    0.438020] pci 0000:23:00.1: MSI is not implemented on this device, disabling it
[    0.438023] pci 0000:23:00.1: PME# is unreliable, disabling it
[    0.438117] pci 0000:23:00.2: MSI is not implemented on this device, disabling it
[    0.438120] pci 0000:23:00.2: PME# is unreliable, disabling it
[    0.438187] pci 0000:23:00.2: EHCI: unrecognized capability 00
[    0.438226] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.438229] software IO TLB: mapped [mem 0x0000000083000000-0x0000000087000000] (64MB)
[    0.438238] ACPI: bus type thunderbolt registered
[    0.438263] Trying to unpack rootfs image as initramfs...
[    0.438322] thunderbolt 0000:07:00.0: total paths: 32
[    0.438496] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.438515] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.438528] thunderbolt 0000:07:00.0: control channel created
[    0.438530] thunderbolt 0000:07:00.0: ICM not supported on this controller
[    0.438539] thunderbolt 0000:07:00.0: freeing RX ring 0
[    0.438546] thunderbolt 0000:07:00.0: freeing TX ring 0
[    0.438556] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.438564] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.438572] thunderbolt 0000:07:00.0: control channel created
[    0.438573] thunderbolt 0000:07:00.0: using software connection manager
[    0.438589] thunderbolt 0000:07:00.0: created link from 0000:06:03.0
[    0.438614] thunderbolt 0000:07:00.0: created link from 0000:06:04.0
[    0.438627] thunderbolt 0000:07:00.0: created link from 0000:06:05.0
[    0.438640] thunderbolt 0000:07:00.0: created link from 0000:06:06.0
[    0.438695] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[    0.438696] thunderbolt 0000:07:00.0: control channel starting...
[    0.438697] thunderbolt 0000:07:00.0: starting TX ring 0
[    0.438705] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.438708] thunderbolt 0000:07:00.0: starting RX ring 0
[    0.438715] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38204 bit 0 (0x0 -> 0x1)
[    0.438719] thunderbolt 0000:07:00.0: security level set to user
[    0.438873] thunderbolt 0000:07:00.0: current switch config:
[    0.438875] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.438877] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.438878] thunderbolt 0000:07:00.0:   Config:
[    0.438879] thunderbolt 0000:07:00.0:    Upstream Port Number: 6 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.438881] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.465779] thunderbolt 0000:07:00.0: initializing Switch at 0x0 (depth: 0, up port: 6)
[    0.466290] thunderbolt 0000:07:00.0: 0: DROM version: 1
[    0.467824] thunderbolt 0000:07:00.0: 0: uid: 0x1000a13f2da20
[    0.470767] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.470770] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.470771] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.470772] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.470773] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.473711] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.473713] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.473714] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.473715] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.473716] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.476655] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.476656] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.476657] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.476658] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.476659] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.477294] random: fast init done
[    0.479598] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.479600] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.479601] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.479602] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.479603] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.479604] thunderbolt 0000:07:00.0: 0:5: disabled by eeprom
[    0.480494] thunderbolt 0000:07:00.0:  Port 6: 8086:1513 (Revision: 2, TB Version: 1, Type: NHI (0x2))
[    0.480496] thunderbolt 0000:07:00.0:   Max hop id (in/out): 31/31
[    0.480497] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.480498] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.480499] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.481390] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.481392] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.481393] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.481394] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.481395] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.482286] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.482288] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.482289] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.482290] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.482291] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.483182] thunderbolt 0000:07:00.0:  Port 9: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.483184] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.483185] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.483186] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.483187] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.484078] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.484080] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.484081] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.484082] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.484083] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.485230] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    0.485232] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.485233] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.485234] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.485235] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.486126] thunderbolt 0000:07:00.0:  Port 12: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.486128] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.486129] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.486130] thunderbolt 0000:07:00.0:   NFC Credits: 0x700005
[    0.486131] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.487022] thunderbolt 0000:07:00.0:  Port 13: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.487023] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.487024] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.487025] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.487026] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.503099] thunderbolt 0000:07:00.0: 0: TMU: current mode: HiFi
[    0.503227] thunderbolt 0000:07:00.0: 0:1: is unplugged (state: 7)
[    0.503354] thunderbolt 0000:07:00.0: 0:3: is connected, link is up (state: 2)
[    0.503610] thunderbolt 0000:07:00.0: current switch config:
[    0.503611] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.503613] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.503614] thunderbolt 0000:07:00.0:   Config:
[    0.503615] thunderbolt 0000:07:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1, PlugEventsDelay: 255ms
[    0.503616] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.508218] thunderbolt 0000:07:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[    0.525625] thunderbolt 0000:07:00.0: 3: reading drom (length: 0x97)
[    0.705946] Freeing initrd memory: 27980K
[    1.019283] thunderbolt 0000:07:00.0: 3: DROM version: 1
[    1.020307] thunderbolt 0000:07:00.0: 3: uid: 0x1000100189170
[    1.023249] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.023254] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.023257] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.023259] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.023261] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.026193] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.026197] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.026199] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.026201] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c0000e
[    1.026203] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.029136] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.029140] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.029142] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.029144] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.029146] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.032080] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.032084] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.032086] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.032088] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.032090] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.032092] thunderbolt 0000:07:00.0: 3:5: disabled by eeprom
[    1.032094] thunderbolt 0000:07:00.0: 3:6: disabled by eeprom
[    1.032976] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.032980] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.032982] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.032984] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.032986] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.033872] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.033876] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.033878] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.033880] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.033882] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.033884] thunderbolt 0000:07:00.0: 3:9: disabled by eeprom
[    1.034768] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.034772] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.034774] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.034776] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.034778] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.035920] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.035924] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.035926] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.035928] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.035930] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.035932] thunderbolt 0000:07:00.0: 3:c: disabled by eeprom
[    1.035934] thunderbolt 0000:07:00.0: 3:d: disabled by eeprom
[    1.054413] thunderbolt 0000:07:00.0: 3: TMU: current mode: bi-directional, HiFi
[    1.054442] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[    1.054450] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[    1.054548] thunderbolt 0000:07:00.0: 3:3: is connected, link is up (state: 2)
[    1.054806] thunderbolt 0000:07:00.0: current switch config:
[    1.054808] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    1.054812] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    1.054814] thunderbolt 0000:07:00.0:   Config:
[    1.054816] thunderbolt 0000:07:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x303 Enabled: 1, PlugEventsDelay: 255ms
[    1.054819] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.059415] thunderbolt 0000:07:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[    1.076820] thunderbolt 0000:07:00.0: 303: reading drom (length: 0x97)
[    1.536561] random: crng init done
[    1.570477] thunderbolt 0000:07:00.0: 303: DROM version: 1
[    1.571501] thunderbolt 0000:07:00.0: 303: uid: 0x100010102a740
[    1.574444] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.574448] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.574450] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.574452] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.574454] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.577387] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.577391] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.577393] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.577395] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.577397] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.580331] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.580335] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.580337] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.580339] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.580341] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.583275] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.583278] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.583281] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.583283] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.583285] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.583287] thunderbolt 0000:07:00.0: 303:5: disabled by eeprom
[    1.583289] thunderbolt 0000:07:00.0: 303:6: disabled by eeprom
[    1.584171] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.584174] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.584177] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.584179] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.584181] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.585067] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.585070] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.585073] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.585074] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.585076] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.585079] thunderbolt 0000:07:00.0: 303:9: disabled by eeprom
[    1.585963] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.585967] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.585969] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.585971] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.585972] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.587114] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.587118] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.587120] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.587122] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.587124] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.587126] thunderbolt 0000:07:00.0: 303:c: disabled by eeprom
[    1.587129] thunderbolt 0000:07:00.0: 303:d: disabled by eeprom
[    1.605357] thunderbolt 0000:07:00.0: 303: TMU: current mode: bi-directional, HiFi
[    1.605378] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[    1.605386] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[    1.605482] thunderbolt 0000:07:00.0: 303:1: is unplugged (state: 7)
[    1.605741] thunderbolt 0000:07:00.0: 303:b: DP adapter HPD set, queuing hotplug
[    1.606509] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 0:7
[    1.606638] thunderbolt 0000:07:00.0: 0:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.606641] thunderbolt 0000:07:00.0: 0:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.606644] thunderbolt 0000:07:00.0: 0:7:    Counter enabled: 1 Counter index: 0
[    1.606647] thunderbolt 0000:07:00.0: 0:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.606650] thunderbolt 0000:07:00.0: 0:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.606765] thunderbolt 0000:07:00.0: 3:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.606769] thunderbolt 0000:07:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.606772] thunderbolt 0000:07:00.0: 3:1:    Counter enabled: 1 Counter index: 0
[    1.606774] thunderbolt 0000:07:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.606777] thunderbolt 0000:07:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.606780] thunderbolt 0000:07:00.0: path discovery complete
[    1.607277] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 3:10
[    1.607405] thunderbolt 0000:07:00.0: 3:a:  In HopID: 8 => Out port: 1 Out HopID: 8
[    1.607408] thunderbolt 0000:07:00.0: 3:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.607411] thunderbolt 0000:07:00.0: 3:a:    Counter enabled: 1 Counter index: 0
[    1.607414] thunderbolt 0000:07:00.0: 3:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.607416] thunderbolt 0000:07:00.0: 3:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.607533] thunderbolt 0000:07:00.0: 0:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[    1.607536] thunderbolt 0000:07:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.607539] thunderbolt 0000:07:00.0: 0:3:    Counter enabled: 1 Counter index: 0
[    1.607542] thunderbolt 0000:07:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.607545] thunderbolt 0000:07:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.607547] thunderbolt 0000:07:00.0: path discovery complete
[    1.607661] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): discovered
[    1.608429] thunderbolt 0000:07:00.0: discovering Video path starting from 0:12
[    1.608557] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 4 Out HopID: 9
[    1.608560] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 2 Drop: 0
[    1.608563] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 1 Counter index: 0
[    1.608566] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.608568] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.608685] thunderbolt 0000:07:00.0: 3:2:  In HopID: 9 => Out port: 11 Out HopID: 9
[    1.608688] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.608691] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 1 Counter index: 0
[    1.608693] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.608696] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.608699] thunderbolt 0000:07:00.0: path discovery complete
[    1.608942] thunderbolt 0000:07:00.0: discovering AUX TX path starting from 0:12
[    1.609069] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 4 Out HopID: 8
[    1.609072] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.609075] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 1 Counter index: 1
[    1.609077] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.609080] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.609197] thunderbolt 0000:07:00.0: 3:2:  In HopID: 8 => Out port: 11 Out HopID: 8
[    1.609200] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.609203] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 1 Counter index: 1
[    1.609205] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.609208] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.609211] thunderbolt 0000:07:00.0: path discovery complete
[    1.609709] thunderbolt 0000:07:00.0: discovering AUX RX path starting from 3:11
[    1.609837] thunderbolt 0000:07:00.0: 3:b:  In HopID: 8 => Out port: 2 Out HopID: 8
[    1.609840] thunderbolt 0000:07:00.0: 3:b:   Weight: 1 Priority: 2 Credits: 7 Drop: 0
[    1.609843] thunderbolt 0000:07:00.0: 3:b:    Counter enabled: 1 Counter index: 0
[    1.609845] thunderbolt 0000:07:00.0: 3:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.609848] thunderbolt 0000:07:00.0: 3:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.609965] thunderbolt 0000:07:00.0: 0:4:  In HopID: 8 => Out port: 12 Out HopID: 8
[    1.609968] thunderbolt 0000:07:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.609971] thunderbolt 0000:07:00.0: 0:4:    Counter enabled: 1 Counter index: 0
[    1.609973] thunderbolt 0000:07:00.0: 0:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.609976] thunderbolt 0000:07:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.609979] thunderbolt 0000:07:00.0: path discovery complete
[    1.610220] thunderbolt 0000:07:00.0: 0:c <-> 3:b (DP): discovered
[    1.610733] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 3:7
[    1.610861] thunderbolt 0000:07:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.610864] thunderbolt 0000:07:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.610867] thunderbolt 0000:07:00.0: 3:7:    Counter enabled: 1 Counter index: 0
[    1.610869] thunderbolt 0000:07:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.610872] thunderbolt 0000:07:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.610989] thunderbolt 0000:07:00.0: 303:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.610992] thunderbolt 0000:07:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.610995] thunderbolt 0000:07:00.0: 303:3:    Counter enabled: 1 Counter index: 0
[    1.610997] thunderbolt 0000:07:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.611000] thunderbolt 0000:07:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.611003] thunderbolt 0000:07:00.0: path discovery complete
[    1.611500] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 303:10
[    1.611629] thunderbolt 0000:07:00.0: 303:a:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.611632] thunderbolt 0000:07:00.0: 303:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.611635] thunderbolt 0000:07:00.0: 303:a:    Counter enabled: 1 Counter index: 0
[    1.611637] thunderbolt 0000:07:00.0: 303:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.611640] thunderbolt 0000:07:00.0: 303:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.611757] thunderbolt 0000:07:00.0: 3:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[    1.611760] thunderbolt 0000:07:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.611763] thunderbolt 0000:07:00.0: 3:3:    Counter enabled: 1 Counter index: 0
[    1.611765] thunderbolt 0000:07:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.611768] thunderbolt 0000:07:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.611771] thunderbolt 0000:07:00.0: path discovery complete
[    1.611884] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): discovered
[    1.612271] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.612273] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
[    1.612400] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
[    1.612405] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[    1.612445] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
[    1.612449] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    1.612451] RAPL PMU: hw unit of domain package 2^-16 Joules
[    1.612452] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[    1.612522] thunderbolt 0000:07:00.0: 0:c: in use
[    1.612652] thunderbolt 0000:07:00.0: 0:d: DP IN available
[    1.612780] thunderbolt 0000:07:00.0: 303:b: DP OUT available
[    1.612782] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 13
[    1.612784] thunderbolt 0000:07:00.0: 303:b: calculating available bandwidth
[    1.612848] Initialise system trusted keyrings
[    1.612869] workingset: timestamp_bits=62 max_order=23 bucket_order=0
[    1.612905] thunderbolt 0000:07:00.0: 0:3: link total bandwidth 9000 Mb/s
[    1.612907] thunderbolt 0000:07:00.0: 3:1: link total bandwidth 9000 Mb/s
[    1.613032] thunderbolt 0000:07:00.0: 3:3: link total bandwidth 9000 Mb/s
[    1.613033] thunderbolt 0000:07:00.0: 303:3: link total bandwidth 9000 Mb/s
[    1.613035] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    1.613039] thunderbolt 0000:07:00.0: 0:d <-> 303:b (DP): activating
[    1.613041] thunderbolt 0000:07:00.0: activating Video path from 0:13 to 303:11
[    1.613043] thunderbolt 0000:07:00.0: 303:4: adding 12 NFC credits to 0
[    1.613160] thunderbolt 0000:07:00.0: 3:2: adding 12 NFC credits to 14
[    1.613288] thunderbolt 0000:07:00.0: 0:d: adding 5 NFC credits to 0
[    1.613544] thunderbolt 0000:07:00.0: 303:4: Writing hop 2
[    1.613546] thunderbolt 0000:07:00.0: 303:4:  In HopID: 8 => Out port: 11 Out HopID: 9
[    1.613547] thunderbolt 0000:07:00.0: 303:4:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.613549] thunderbolt 0000:07:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[    1.613550] thunderbolt 0000:07:00.0: 303:4:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.613552] thunderbolt 0000:07:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.613581] Key type asymmetric registered
[    1.613584] Asymmetric key parser 'x509' registered
[    1.613595] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    1.613801] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[    1.613802] thunderbolt 0000:07:00.0: 3:2:  In HopID: 10 => Out port: 4 Out HopID: 8
[    1.613804] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.613805] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[    1.613806] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.613808] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.614056] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[    1.614058] thunderbolt 0000:07:00.0: 0:d:  In HopID: 9 => Out port: 4 Out HopID: 10
[    1.614059] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.614060] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[    1.614062] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.614063] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.614184] thunderbolt 0000:07:00.0: path activation complete
[    1.614185] thunderbolt 0000:07:00.0: activating AUX TX path from 0:13 to 303:11
[    1.614312] thunderbolt 0000:07:00.0: 303:4: Writing hop 2
[    1.614314] thunderbolt 0000:07:00.0: 303:4:  In HopID: 9 => Out port: 11 Out HopID: 8
[    1.614315] thunderbolt 0000:07:00.0: 303:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.614316] thunderbolt 0000:07:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[    1.614318] thunderbolt 0000:07:00.0: 303:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.614319] thunderbolt 0000:07:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.614442] pcieport 0000:06:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.614569] thunderbolt 0000:07:00.0: 3:2: Writing hop 1
[    1.614570] thunderbolt 0000:07:00.0: 3:2:  In HopID: 11 => Out port: 4 Out HopID: 9
[    1.614572] thunderbolt 0000:07:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.614573] thunderbolt 0000:07:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[    1.614574] thunderbolt 0000:07:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.614576] thunderbolt 0000:07:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.614633] pcieport 0000:06:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.614824] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[    1.614826] thunderbolt 0000:07:00.0: 0:d:  In HopID: 8 => Out port: 4 Out HopID: 11
[    1.614827] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.614829] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[    1.614830] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.614831] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.614835] pcieport 0000:06:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.614953] thunderbolt 0000:07:00.0: path activation complete
[    1.614954] thunderbolt 0000:07:00.0: activating AUX RX path from 303:11 to 0:13
[    1.615039] pcieport 0000:06:06.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.615082] thunderbolt 0000:07:00.0: 0:4: Writing hop 2
[    1.615085] thunderbolt 0000:07:00.0: 0:4:  In HopID: 9 => Out port: 13 Out HopID: 8
[    1.615087] thunderbolt 0000:07:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.615089] thunderbolt 0000:07:00.0: 0:4:    Counter enabled: 0 Counter index: 2047
[    1.615091] thunderbolt 0000:07:00.0: 0:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.615092] thunderbolt 0000:07:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.615336] thunderbolt 0000:07:00.0: 3:4: Writing hop 1
[    1.615338] thunderbolt 0000:07:00.0: 3:4:  In HopID: 8 => Out port: 2 Out HopID: 9
[    1.615339] thunderbolt 0000:07:00.0: 3:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.615340] thunderbolt 0000:07:00.0: 3:4:    Counter enabled: 0 Counter index: 2047
[    1.615342] thunderbolt 0000:07:00.0: 3:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.615343] thunderbolt 0000:07:00.0: 3:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.615593] thunderbolt 0000:07:00.0: 303:b: Writing hop 0
[    1.615594] thunderbolt 0000:07:00.0: 303:b:  In HopID: 8 => Out port: 4 Out HopID: 8
[    1.615595] thunderbolt 0000:07:00.0: 303:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.615597] thunderbolt 0000:07:00.0: 303:b:    Counter enabled: 0 Counter index: 2047
[    1.615598] thunderbolt 0000:07:00.0: 303:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.615599] thunderbolt 0000:07:00.0: 303:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.615720] thunderbolt 0000:07:00.0: path activation complete
[    1.616318] pcieport 0000:19:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.616528] pcieport 0000:19:05.0: enabling device (0000 -> 0001)
[    1.616625] pcieport 0000:19:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.618511] pcieport 0000:20:04.0: enabling device (0000 -> 0003)
[    1.618632] pcieport 0000:20:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.618926] pcieport 0000:20:05.0: enabling device (0000 -> 0001)
[    1.619046] pcieport 0000:20:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.627945] brd: module loaded
[    1.628218] Intel(R) 2.5G Ethernet Linux Driver
[    1.628222] Copyright(c) 2018 Intel Corporation.
[    1.628272] i8042: PNP: No PS/2 controller found.
[    1.628312] mousedev: PS/2 mouse device common for all mice
[    1.628374] intel_pstate: Intel P-state driver initializing
[    1.628491] efifb: probing for efifb
[    1.628506] efifb: framebuffer at 0x90010000, using 14400k, total 14400k
[    1.628509] efifb: mode is 2560x1440x32, linelength=10240, pages=1
[    1.628511] efifb: scrolling: redraw
[    1.628512] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.638027] Console: switching to colour frame buffer device 320x90
[    1.647094] fb0: EFI VGA frame buffer device
[    1.647177] Key type dns_resolver registered
[    1.647232] microcode: sig=0x206a7, pf=0x2, revision=0x2f
[    1.647377] microcode: Microcode Update Driver: v2.2.
[    1.647379] IPI shorthand broadcast: enabled
[    1.647427] sched_clock: Marking stable (1646962658, 410898)->(1659159648, -11786092)
[    1.647501] registered taskstats version 1
[    1.647518] Loading compiled-in X.509 certificates
[    1.648242] Freeing unused kernel image (initmem) memory: 956K
[    1.733654] Write protecting the kernel read-only data: 12288k
[    1.734303] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.734364] Freeing unused kernel image (rodata/data gap) memory: 188K
[    1.734394] Run /init as init process
[    1.734409]   with arguments:
[    1.734410]     /init
[    1.734411]   with environment:
[    1.734412]     HOME=/
[    1.734412]     TERM=linux
[    1.734413]     netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da
[    1.777890] udevd[875]: starting version 3.2.9
[    1.778597] udevd[876]: starting eudev-3.2.9
[    1.793563] ACPI: bus type USB registered
[    1.793611] usbcore: registered new interface driver usbfs
[    1.793644] usbcore: registered new interface driver hub
[    1.793677] usbcore: registered new device driver usb
[    1.795344] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.795382] ACPI: bus type drm_connector registered
[    1.795607] ehci-pci: EHCI PCI platform driver
[    1.795799] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    1.795833] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    1.795877] ehci-pci 0000:00:1a.7: debug port 2
[    1.796028] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.796396] uhci_hcd: USB Universal Host Controller Interface driver
[    1.798871] ahci 0000:00:1f.2: version 3.0
[    1.799273] cryptd: max_cpu_qlen set to 1000
[    1.799831] ehci-pci 0000:00:1a.7: irq 23, io mem 0xa8906c00
[    1.800300] AVX version of gcm_enc/dec engaged.
[    1.800355] AES CTR mode by8 optimization enabled
[    1.808571] radeon: unknown parameter 'pm' ignored
[    1.808676] [drm] radeon kernel modesetting enabled.
[    1.808739] checking generic (90010000 e10000) vs hw (90000000 10000000)
[    1.808742] fb0: switching to radeon from EFI VGA
[    1.808835] Console: switching to colour dummy device 80x25
[    1.808917] radeon 0000:01:00.0: vgaarb: deactivate vga console
[    1.809084] [drm] initializing kernel modesetting (BARTS 0x1002:0x6720 0x106B:0x0B00 0x00).
[    1.809089] radeon 0000:01:00.0: vram limit (0) must be a power of 2
[    1.809092] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x7 impl SATA mode
[    1.809101] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst
[    1.823360] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.823614] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.823620] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.823623] usb usb1: Product: EHCI Host Controller
[    1.823626] usb usb1: Manufacturer: Linux 5.17.0+ ehci_hcd
[    1.823628] usb usb1: SerialNumber: 0000:00:1a.7
[    1.823787] hub 1-0:1.0: USB hub found
[    1.823797] hub 1-0:1.0: 6 ports detected
[    1.824050] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.824059] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 2
[    1.824105] uhci_hcd 0000:00:1a.0: detected 2 ports
[    1.824317] uhci_hcd 0000:00:1a.0: irq 21, io port 0x00003140
[    1.824455] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    1.824465] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.824502] usb usb2: Product: UHCI Host Controller
[    1.824505] usb usb2: Manufacturer: Linux 5.17.0+ uhci_hcd
[    1.824508] usb usb2: SerialNumber: 0000:00:1a.0
[    1.824629] hub 2-0:1.0: USB hub found
[    1.824634] hub 2-0:1.0: 2 ports detected
[    1.824775] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.824782] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 3
[    1.824912] ehci-pci 0000:00:1d.7: debug port 2
[    1.828979] ehci-pci 0000:00:1d.7: irq 22, io mem 0xa8906800
[    1.833550] tg3 0000:02:00.0 eth0: Tigon3 [partno(BCM957765) rev 57785100] (PCI Express) MAC address 3c:07:54:14:b2:08
[    1.833557] tg3 0000:02:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.833561] tg3 0000:02:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.833564] tg3 0000:02:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.853356] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.853402] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.853406] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.853409] usb usb3: Product: EHCI Host Controller
[    1.853431] usb usb3: Manufacturer: Linux 5.17.0+ ehci_hcd
[    1.853433] usb usb3: SerialNumber: 0000:00:1d.7
[    1.853511] hub 3-0:1.0: USB hub found
[    1.853516] hub 3-0:1.0: 8 ports detected
[    1.853769] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.853777] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    1.853810] uhci_hcd 0000:00:1d.0: detected 2 ports
[    1.853953] uhci_hcd 0000:00:1d.0: irq 19, io port 0x000030e0
[    1.854087] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    1.854093] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.854097] usb usb4: Product: UHCI Host Controller
[    1.854099] usb usb4: Manufacturer: Linux 5.17.0+ uhci_hcd
[    1.854101] usb usb4: SerialNumber: 0000:00:1d.0
[    1.854277] hub 4-0:1.0: USB hub found
[    1.854285] hub 4-0:1.0: 2 ports detected
[    1.854426] ehci-pci 0000:1c:00.2: EHCI Host Controller
[    1.854434] ehci-pci 0000:1c:00.2: new USB bus registered, assigned bus number 5
[    1.854762] ehci-pci 0000:1c:00.2: irq 17, io mem 0xb0b02000
[    1.863613] firewire_ohci 0000:04:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    1.864671] scsi host0: ahci
[    1.864946] scsi host1: ahci
[    1.865144] scsi host2: ahci
[    1.865270] scsi host3: ahci
[    1.865406] scsi host4: ahci
[    1.865604] scsi host5: ahci
[    1.865685] ata1: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906100 irq 52
[    1.865734] ata2: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906180 irq 52
[    1.865764] ata3: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906200 irq 52
[    1.865786] ata4: DUMMY
[    1.865788] ata5: DUMMY
[    1.865790] ata6: DUMMY
[    1.893357] ehci-pci 0000:1c:00.2: USB 2.0 started, EHCI 1.00
[    1.893388] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.893392] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.893395] usb usb5: Product: EHCI Host Controller
[    1.893397] usb usb5: Manufacturer: Linux 5.17.0+ ehci_hcd
[    1.893399] usb usb5: SerialNumber: 0000:1c:00.2
[    1.893467] hub 5-0:1.0: USB hub found
[    1.893472] hub 5-0:1.0: 4 ports detected
[    1.894201] ehci-pci 0000:23:00.2: EHCI Host Controller
[    1.894206] ehci-pci 0000:23:00.2: new USB bus registered, assigned bus number 6
[    1.894562] ehci-pci 0000:23:00.2: irq 17, io mem 0xb0f02000
[    1.916478] tg3 0000:1d:00.0 eth1: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[    1.916487] tg3 0000:1d:00.0 eth1: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.916494] tg3 0000:1d:00.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.916500] tg3 0000:1d:00.0 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.923362] ehci-pci 0000:23:00.2: USB 2.0 started, EHCI 1.00
[    1.923387] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.923391] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.923394] usb usb6: Product: EHCI Host Controller
[    1.923396] usb usb6: Manufacturer: Linux 5.17.0+ ehci_hcd
[    1.923398] usb usb6: SerialNumber: 0000:23:00.2
[    1.923538] hub 6-0:1.0: USB hub found
[    1.923542] hub 6-0:1.0: 4 ports detected
[    1.943630] firewire_ohci 0000:1e:00.0: added OHCI v1.10 device as card 1, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    2.002803] tg3 0000:24:00.0 eth2: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[    2.002878] tg3 0000:24:00.0 eth2: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.002941] tg3 0000:24:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.002994] tg3 0000:24:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.023608] firewire_ohci 0000:25:00.0: added OHCI v1.10 device as card 2, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    2.113336] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    2.138714] ATOM BIOS: Apple
[    2.138869] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.138873] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    2.138879] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.138881] [drm] RAM width 256bits DDR
[    2.138899] [drm] radeon: 1024M of VRAM memory ready
[    2.138901] [drm] radeon: 1024M of GTT memory ready.
[    2.138905] [drm] Loading BARTS Microcode
[    2.138957] [drm] External GPIO thermal controller with fan control
[    2.138971] == power state 0 ==
[    2.138973] 	ui class: none
[    2.138975] 	internal class: boot
[    2.138977] 	caps:
[    2.138978] 	uvd    vclk: 0 dclk: 0
[    2.138980] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.138982] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.138984] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.138986] 	status: c r b
[    2.138988] == power state 1 ==
[    2.138989] 	ui class: performance
[    2.138991] 	internal class: none
[    2.138993] 	caps:
[    2.138994] 	uvd    vclk: 0 dclk: 0
[    2.138995] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.138997] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    2.138999] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.139001] 	status:
[    2.139002] == power state 2 ==
[    2.139003] 	ui class: none
[    2.139005] 	internal class: uvd
[    2.139006] 	caps: video
[    2.139008] 	uvd    vclk: 54000 dclk: 40000
[    2.139009] 		power level 0    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    2.139011] 		power level 1    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    2.139013] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.139015] 	status:
[    2.139016] == power state 3 ==
[    2.139018] 	ui class: none
[    2.139019] 	internal class: uvd_mvc
[    2.139020] 	caps: video
[    2.139022] 	uvd    vclk: 70000 dclk: 56000
[    2.139023] 		power level 0    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    2.139025] 		power level 1    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    2.139027] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.139029] 	status:
[    2.139030] == power state 4 ==
[    2.139031] 	ui class: battery
[    2.139033] 	internal class: none
[    2.139034] 	caps:
[    2.139035] 	uvd    vclk: 0 dclk: 0
[    2.139037] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.139039] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.139041] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.139042] 	status:
[    2.143934] [drm] radeon: dpm initialized
[    2.144001] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    2.144411] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    2.152182] [drm] PCIE GART of 1024M enabled (table at 0x0000000000162000).
[    2.152286] radeon 0000:01:00.0: WB enabled
[    2.152289] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00
[    2.152292] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c
[    2.153039] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118
[    2.153173] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    2.153206] radeon 0000:01:00.0: radeon: using MSI.
[    2.153234] [drm] radeon: irq initialized.
[    2.153321] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    2.169583] [drm] ring test on 0 succeeded in 3 usecs
[    2.169596] [drm] ring test on 3 succeeded in 7 usecs
[    2.193327] usb 5-1: new high-speed USB device number 2 using ehci-pci
[    2.194691] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.194711] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.195057] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.196283] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.196345] ata2.00: supports DRM functions and may not be fully accessible
[    2.196349] ata2.00: ATA-9: Samsung SSD 850 EVO 500GB, EMT02B6Q, max UDMA/133
[    2.196532] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.196538] ata3.00: ATAPI: OPTIARC DVD RW AD-5690H, 4AH5, max UDMA/100
[    2.196633] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.196695] ata1.00: supports DRM functions and may not be fully accessible
[    2.196699] ata1.00: ATA-9: Samsung SSD 850 PRO 256GB, EXM03B6Q, max UDMA/133
[    2.196963] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.197305] ata1.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.198580] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.198590] ata3.00: configured for UDMA/100
[    2.198940] ata2.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    2.199242] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.199297] ata2.00: supports DRM functions and may not be fully accessible
[    2.199324] ata1.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    2.199624] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.199696] ata1.00: supports DRM functions and may not be fully accessible
[    2.202064] ata2.00: configured for UDMA/133
[    2.202463] ata1.00: configured for UDMA/133
[    2.202591] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 850  3B6Q PQ: 0 ANSI: 5
[    2.202860] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 850  2B6Q PQ: 0 ANSI: 5
[    2.204342] scsi 2:0:0:0: CD-ROM            OPTIARC  DVD RW AD-5690H  4AH5 PQ: 0 ANSI: 5
[    2.213326] usb 6-1: new high-speed USB device number 2 using ehci-pci
[    2.323637] usb 1-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    2.323651] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.323922] hub 1-1:1.0: USB hub found
[    2.324015] hub 1-1:1.0: 3 ports detected
[    2.346749] [drm] ring test on 5 succeeded in 2 usecs
[    2.346769] [drm] UVD initialized successfully.
[    2.346884] [drm] ib test on ring 0 succeeded in 0 usecs
[    2.346997] [drm] ib test on ring 3 succeeded in 0 usecs
[    2.353633] usb 3-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    2.353639] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.353913] hub 3-1:1.0: USB hub found
[    2.354011] hub 3-1:1.0: 4 ports detected
[    2.394038] usb 5-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[    2.394044] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.394438] hub 5-1:1.0: USB hub found
[    2.394645] hub 5-1:1.0: 7 ports detected
[    2.424059] usb 6-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[    2.424065] usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.424465] hub 6-1:1.0: USB hub found
[    2.424683] hub 6-1:1.0: 7 ports detected
[    2.453419] firewire_core 0000:1e:00.0: created device fw0: GUID 000a27020040c4ba, S800
[    2.453436] firewire_core 0000:1e:00.0: phy config: new root=ffc0, gap_count=63
[    2.473321] usb 1-2: new high-speed USB device number 3 using ehci-pci
[    2.498457] firewire_core 0000:04:00.0: created device fw1: GUID a4b197fffe3f2da2, S800
[    2.498465] firewire_core 0000:04:00.0: phy config: new root=ffc0, gap_count=63
[    2.514927] ohci-pci: OHCI PCI platform driver
[    2.515021] ohci-pci 0000:1c:00.0: OHCI PCI host controller
[    2.515027] ohci-pci 0000:1c:00.0: new USB bus registered, assigned bus number 7
[    2.515053] ohci-pci 0000:1c:00.0: irq 19, io mem 0xb0b00000
[    2.517519] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    2.517529] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    2.517538] sd 0:0:0:0: [sda] Write Protect is off
[    2.517545] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.517545] sd 1:0:0:0: [sdb] Write Protect is off
[    2.517548] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.517566] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.517567] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.521397]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[    2.521437] sd 1:0:0:0: [sdb] supports TCG Opal
[    2.521441] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.522243] sd 0:0:0:0: [sda] supports TCG Opal
[    2.522247] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.522713] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.522740] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.522764] sr 2:0:0:0: Attached scsi generic sg2 type 5
[    2.533434] firewire_core 0000:25:00.0: created device fw2: GUID 000a2702006cfdfb, S800
[    2.533447] firewire_core 0000:25:00.0: phy config: new root=ffc0, gap_count=63
[    2.587511] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.587520] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.587523] usb usb7: Product: OHCI PCI host controller
[    2.587525] usb usb7: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.587526] usb usb7: SerialNumber: 0000:1c:00.0
[    2.587618] hub 7-0:1.0: USB hub found
[    2.587632] hub 7-0:1.0: 2 ports detected
[    2.587844] ohci-pci 0000:1c:00.1: OHCI PCI host controller
[    2.587850] ohci-pci 0000:1c:00.1: new USB bus registered, assigned bus number 8
[    2.587875] ohci-pci 0000:1c:00.1: irq 16, io mem 0xb0b01000
[    2.633350] tsc: Refined TSC clocksource calibration: 3400.022 MHz
[    2.633371] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x310263dce6e, max_idle_ns: 440795334146 ns
[    2.633475] clocksource: Switched to clocksource tsc
[    2.635607] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda caddy
[    2.635623] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.657454] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.657460] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.657463] usb usb8: Product: OHCI PCI host controller
[    2.657465] usb usb8: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.657467] usb usb8: SerialNumber: 0000:1c:00.1
[    2.657553] hub 8-0:1.0: USB hub found
[    2.657566] hub 8-0:1.0: 2 ports detected
[    2.657748] ohci-pci 0000:23:00.0: OHCI PCI host controller
[    2.657753] ohci-pci 0000:23:00.0: new USB bus registered, assigned bus number 9
[    2.657787] ohci-pci 0000:23:00.0: irq 19, io mem 0xb0f00000
[    2.673359] usb 3-1.1: new high-speed USB device number 3 using ehci-pci
[    2.688860] usb 1-2: New USB device found, idVendor=05ac, idProduct=850b, bcdDevice= 7.55
[    2.688866] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.688869] usb 1-2: Product: FaceTime HD Camera (Built-in)
[    2.688871] usb 1-2: Manufacturer: Apple Inc.
[    2.688873] usb 1-2: SerialNumber: CCGB8K062WDDJRLX
[    2.713367] usb 5-1.4: new full-speed USB device number 3 using ehci-pci
[    2.727483] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.727489] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.727492] usb usb9: Product: OHCI PCI host controller
[    2.727494] usb usb9: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.727496] usb usb9: SerialNumber: 0000:23:00.0
[    2.727568] hub 9-0:1.0: USB hub found
[    2.727583] hub 9-0:1.0: 2 ports detected
[    2.727763] ohci-pci 0000:23:00.1: OHCI PCI host controller
[    2.727768] ohci-pci 0000:23:00.1: new USB bus registered, assigned bus number 10
[    2.727801] ohci-pci 0000:23:00.1: irq 16, io mem 0xb0f01000
[    2.743361] usb 6-1.4: new full-speed USB device number 3 using ehci-pci
[    2.744469] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    2.773355] usb 1-1.1: new full-speed USB device number 4 using ehci-pci
[    2.807485] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.807491] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.807494] usb usb10: Product: OHCI PCI host controller
[    2.807496] usb usb10: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.807498] usb usb10: SerialNumber: 0000:23:00.1
[    2.807562] hub 10-0:1.0: USB hub found
[    2.807577] hub 10-0:1.0: 2 ports detected
[    2.848501] usb 3-1.1: New USB device found, idVendor=05ac, idProduct=8403, bcdDevice=98.33
[    2.848515] usb 3-1.1: New USB device strings: Mfr=3, Product=4, SerialNumber=2
[    2.848522] usb 3-1.1: Product: Card Reader
[    2.848527] usb 3-1.1: Manufacturer: Apple
[    2.848531] usb 3-1.1: SerialNumber: 000000009833
[    2.850453] usb-storage 3-1.1:1.0: USB Mass Storage device detected
[    2.850528] scsi host6: usb-storage 3-1.1:1.0
[    2.850571] usbcore: registered new interface driver usb-storage
[    2.850821] usbcore: registered new interface driver uas
[    2.883181] usb 5-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[    2.883195] usb 5-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.883201] usb 5-1.4: Product: Display Audio
[    2.883206] usb 5-1.4: Manufacturer: Apple Inc.
[    2.883210] usb 5-1.4: SerialNumber: 152303D9
[    2.884899] hid: raw HID events driver (C) Jiri Kosina
[    2.895739] usbcore: registered new interface driver usbhid
[    2.895744] usbhid: USB HID core driver
[    2.896612] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:00.0/0000:1a:00.0/0000:1b:03.0/0000:1c:00.2/usb5/5-1/5-1.4/5-1.4:1.3/0003:05AC:1107.0001/input/input0
[    2.896689] hid-generic 0003:05AC:1107.0001: input,hidraw0: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:1c:00.2-1.4/input3
[    2.903801] usb 6-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[    2.903807] usb 6-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.903811] usb 6-1.4: Product: Display Audio
[    2.903813] usb 6-1.4: Manufacturer: Apple Inc.
[    2.903815] usb 6-1.4: SerialNumber: 1A0E0738
[    2.915035] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:04.0/0000:1f:00.0/0000:20:00.0/0000:21:00.0/0000:22:03.0/0000:23:00.2/usb6/6-1/6-1.4/6-1.4:1.3/0003:05AC:1107.0002/input/input1
[    2.915059] hid-generic 0003:05AC:1107.0002: input,hidraw1: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:23:00.2-1.4/input3
[    2.925990] usb 1-1.1: New USB device found, idVendor=0a5c, idProduct=4500, bcdDevice= 1.00
[    2.926004] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.926011] usb 1-1.1: Product: BRCM2046 Hub
[    2.926015] usb 1-1.1: Manufacturer: Apple Inc.
[    2.926304] hub 1-1.1:1.0: USB hub found
[    2.926484] hub 1-1.1:1.0: 3 ports detected
[    2.943356] usb 3-1.2: new low-speed USB device number 4 using ehci-pci
[    2.983365] usb 5-1.5: new high-speed USB device number 4 using ehci-pci
[    3.003396] [drm] ib test on ring 5 succeeded
[    3.013348] usb 6-1.5: new high-speed USB device number 4 using ehci-pci
[    3.023357] usb 1-1.2: new high-speed USB device number 5 using ehci-pci
[    3.073355] [drm] radeon atom DIG backlight initialized
[    3.073366] [drm] Radeon Display Connectors
[    3.073370] [drm] Connector 0:
[    3.073373] [drm]   eDP-1
[    3.073376] [drm]   HPD3
[    3.073379] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[    3.073386] [drm]   Encoders:
[    3.073388] [drm]     LCD1: INTERNAL_UNIPHY2
[    3.073392] [drm] Connector 1:
[    3.073395] [drm]   DP-1
[    3.073397] [drm]   HPD1
[    3.073400] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    3.073406] [drm]   Encoders:
[    3.073408] [drm]     DFP1: INTERNAL_UNIPHY1
[    3.073411] [drm] Connector 2:
[    3.073414] [drm]   DP-2
[    3.073416] [drm]   HPD2
[    3.073419] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[    3.073425] [drm]   Encoders:
[    3.073427] [drm]     DFP2: INTERNAL_UNIPHY1
[    3.073430] [drm] Connector 3:
[    3.073433] [drm]   DP-3
[    3.073435] [drm]   HPD4
[    3.073438] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[    3.073451] [drm]   Encoders:
[    3.073452] [drm]     DFP3: INTERNAL_UNIPHY2
[    3.073453] [drm] Connector 4:
[    3.073454] [drm]   DP-4
[    3.073455] [drm]   HPD5
[    3.073456] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 0x647c 0x647c
[    3.073459] [drm]   Encoders:
[    3.073460] [drm]     DFP4: INTERNAL_UNIPHY
[    3.073461] [drm] Connector 5:
[    3.073462] [drm]   VGA-1
[    3.073463] [drm]   DDC: 0x64d8 0x64d8 0x64dc 0x64dc 0x64e0 0x64e0 0x64e4 0x64e4
[    3.073466] [drm]   Encoders:
[    3.073467] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    3.099248] usb 3-1.2: New USB device found, idVendor=05ac, idProduct=8242, bcdDevice= 0.16
[    3.099262] usb 3-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.099269] usb 3-1.2: Product: IR Receiver
[    3.099274] usb 3-1.2: Manufacturer: Apple Computer, Inc.
[    3.103814] switching from power state:
[    3.103818] 	ui class: none
[    3.103820] 	internal class: boot
[    3.103822] 	caps:
[    3.103824] 	uvd    vclk: 0 dclk: 0
[    3.103825] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.103835] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.103837] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.103839] 	status: c b
[    3.103842] switching to power state:
[    3.103843] 	ui class: performance
[    3.103844] 	internal class: none
[    3.103846] 	caps:
[    3.103847] 	uvd    vclk: 0 dclk: 0
[    3.103849] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    3.103851] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    3.103853] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    3.103855] 	status: r
[    3.104580] input: Apple Computer, Inc. IR Receiver as /devices/pci0000:00/0000:00:1d.7/usb3/3-1/3-1.2/3-1.2:1.0/0003:05AC:8242.0003/input/input2
[    3.149857] usb 5-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[    3.149863] usb 5-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.149866] usb 5-1.5: Product: FaceTime HD Camera (Display)
[    3.149868] usb 5-1.5: Manufacturer: Apple Inc.
[    3.149870] usb 5-1.5: SerialNumber: CCGB690CKUDJ9DFX
[    3.173517] appleir 0003:05AC:8242.0003: input,hiddev96,hidraw2: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.7-1.2/input0
[    3.179248] usb 6-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[    3.179255] usb 6-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.179258] usb 6-1.5: Product: FaceTime HD Camera (Display)
[    3.179260] usb 6-1.5: Manufacturer: Apple Inc.
[    3.179262] usb 6-1.5: SerialNumber: CC2G3101FFDJ9FLP
[    3.182251] usb 1-1.2: New USB device found, idVendor=05ac, idProduct=1006, bcdDevice=96.15
[    3.182258] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.182261] usb 1-1.2: Product: Keyboard Hub
[    3.182263] usb 1-1.2: Manufacturer: Apple, Inc.
[    3.182265] usb 1-1.2: SerialNumber: 000000000000
[    3.182479] hub 1-1.2:1.0: USB hub found
[    3.182605] hub 1-1.2:1.0: 3 ports detected
[    3.203329] usb 3-1.4: new low-speed USB device number 5 using ehci-pci
[    3.243328] usb 5-1.7: new full-speed USB device number 5 using ehci-pci
[    3.273328] usb 1-1.1.1: new full-speed USB device number 6 using ehci-pci
[    3.273328] usb 6-1.7: new full-speed USB device number 5 using ehci-pci
[    3.358982] usb 3-1.4: New USB device found, idVendor=047d, idProduct=1020, bcdDevice= 1.06
[    3.358989] usb 3-1.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.358992] usb 3-1.4: Product: Kensington Expert Mouse
[    3.361995] input: Kensington Expert Mouse as /devices/pci0000:00/0000:00:1d.7/usb3/3-1/3-1.4/3-1.4:1.0/0003:047D:1020.0004/input/input3
[    3.362140] hid-generic 0003:047D:1020.0004: input,hidraw3: USB HID v1.11 Mouse [Kensington Expert Mouse] on usb-0000:00:1d.7-1.4/input0
[    3.395753] usb 5-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.37
[    3.395759] usb 5-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.395762] usb 5-1.7: Product: Apple Thunderbolt Display
[    3.395764] usb 5-1.7: Manufacturer: Apple Inc.
[    3.395766] usb 5-1.7: SerialNumber: 152303D9
[    3.397837] hid-generic 0003:05AC:9227.0005: hiddev97,hidraw4: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:1c:00.2-1.7/input0
[    3.425669] usb 6-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.39
[    3.425675] usb 6-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.425678] usb 6-1.7: Product: Apple Thunderbolt Display
[    3.425680] usb 6-1.7: Manufacturer: Apple Inc.
[    3.425682] usb 6-1.7: SerialNumber: 1A0E0738
[    3.427761] hid-generic 0003:05AC:9227.0006: hiddev98,hidraw5: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:23:00.2-1.7/input0
[    3.428112] usb 1-1.1.1: New USB device found, idVendor=05ac, idProduct=8215, bcdDevice= 2.08
[    3.428118] usb 1-1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.428121] usb 1-1.1.1: Product: Bluetooth USB Host Controller
[    3.428124] usb 1-1.1.1: Manufacturer: Apple Inc.
[    3.428126] usb 1-1.1.1: SerialNumber: 3451C9ED7F9B
[    3.523323] usb 1-1.2.2: new low-speed USB device number 7 using ehci-pci
[    3.680251] usb 1-1.2.2: New USB device found, idVendor=05ac, idProduct=0220, bcdDevice= 0.71
[    3.680257] usb 1-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.680260] usb 1-1.2.2: Product: Apple Keyboard
[    3.680262] usb 1-1.2.2: Manufacturer: Apple, Inc
[    3.687920] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.0/0003:05AC:0220.0007/input/input4
[    3.753423] apple 0003:05AC:0220.0007: input,hidraw6: USB HID v1.11 Keyboard [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input0
[    3.753493] apple 0003:05AC:0220.0008: Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling
[    3.753517] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.1/0003:05AC:0220.0008/input/input5
[    3.773324] usb 1-1.1.2: new full-speed USB device number 8 using ehci-pci
[    3.823347] apple 0003:05AC:0220.0008: input,hidraw7: USB HID v1.11 Device [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input1
[    3.926874] usb 1-1.1.2: New USB device found, idVendor=05ac, idProduct=820a, bcdDevice= 1.00
[    3.926880] usb 1-1.1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.928761] input: HID 05ac:820a as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:05AC:820A.0009/input/input6
[    3.993371] hid-generic 0003:05AC:820A.0009: input,hidraw8: USB HID v1.11 Keyboard [HID 05ac:820a] on usb-0000:00:1a.7-1.1.2/input0
[    4.093323] usb 1-1.1.3: new full-speed USB device number 9 using ehci-pci
[    4.150719] scsi 6:0:0:0: Direct-Access     APPLE    SD Card Reader   1.00 PQ: 0 ANSI: 0
[    4.150907] sd 6:0:0:0: Attached scsi generic sg3 type 0
[    4.151653] sd 6:0:0:0: [sdc] Media removed, stopped polling
[    4.152495] sd 6:0:0:0: [sdc] Attached SCSI removable disk
[    4.247616] usb 1-1.1.3: New USB device found, idVendor=05ac, idProduct=820b, bcdDevice= 1.00
[    4.247632] usb 1-1.1.3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.249734] input: HID 05ac:820b as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.0/0003:05AC:820B.000A/input/input7
[    4.249780] hid-generic 0003:05AC:820B.000A: input,hidraw9: USB HID v1.11 Mouse [HID 05ac:820b] on usb-0000:00:1a.7-1.1.3/input0
[    4.496801] [drm] fb mappable at 0x90363000
[    4.496805] [drm] vram apper at 0x90000000
[    4.496806] [drm] size 14745600
[    4.496807] [drm] fb depth is 24
[    4.496809] [drm]    pitch is 10240
[    4.496899] fbcon: radeondrmfb (fb0) is primary device
[    5.188942] switching from power state:
[    5.188943] 	ui class: performance
[    5.188944] 	internal class: none
[    5.188945] 	caps:
[    5.188946] 	uvd    vclk: 0 dclk: 0
[    5.188947] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    5.188948] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    5.188949] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    5.188949] 	status: c r
[    5.188950] switching to power state:
[    5.188951] 	ui class: performance
[    5.188951] 	internal class: none
[    5.188952] 	caps:
[    5.188952] 	uvd    vclk: 0 dclk: 0
[    5.188953] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    5.188953] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    5.188954] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    5.188955] 	status: c r
[    6.303805] switching from power state:
[    6.303806] 	ui class: performance
[    6.303807] 	internal class: none
[    6.303808] 	caps:
[    6.303808] 	uvd    vclk: 0 dclk: 0
[    6.303809] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    6.303810] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    6.303811] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    6.303812] 	status: c r
[    6.303813] switching to power state:
[    6.303813] 	ui class: performance
[    6.303813] 	internal class: none
[    6.303814] 	caps:
[    6.303814] 	uvd    vclk: 0 dclk: 0
[    6.303815] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    6.303815] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    6.303816] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    6.303817] 	status: c r
[    6.415432] Console: switching to colour frame buffer device 320x90
[    6.419824] radeon 0000:01:00.0: [drm] fb0: radeondrmfb frame buffer device
[    6.453392] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[    6.479978] [drm] amdgpu kernel modesetting enabled.
[    6.595321] netpoll: netconsole: local port 6666
[    6.595338] netpoll: netconsole: local IPv4 address 192.168.2.87
[    6.595352] netpoll: netconsole: interface 'eth0'
[    6.595362] netpoll: netconsole: remote port 6666
[    6.595372] netpoll: netconsole: remote IPv4 address 192.168.2.208
[    6.595384] netpoll: netconsole: remote ethernet address dc:a6:32:61:33:da
[    6.595402] netpoll: netconsole: device eth0 not up yet, forcing it
[   10.137635] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   10.137653] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   10.137667] tg3 0000:02:00.0 eth0: EEE is enabled
[   10.174647] printk: console [netcon0] enabled
[   10.174659] netconsole: network logging started
[   17.214245]  sdb: sdb1
[   17.264517] process '/usr/bin/fstype' started with executable stack
[   17.289903] EXT4-fs (sda6): mounted filesystem with ordered data mode. Quota mode: none.
[   17.467629] udevd[1276]: starting version 3.2.9
[   17.491485] udevd[1277]: starting eudev-3.2.9
[   17.523410] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input8
[   17.526292] ACPI: button: Power Button [PWRB]
[   17.528103] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input9
[   17.529165] ACPI: button: Sleep Button [SLPB]
[   17.531061] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input10
[   17.538805] udevd[1310]: Error changing net interface name eth1 to eth2: File exists
[   17.539805] udevd[1310]: could not rename interface '3' from 'eth1' to 'eth2': File exists
[   17.552596] udevd[1330]: Error changing net interface name eth2 to eth1: File exists
[   17.553632] udevd[1330]: could not rename interface '4' from 'eth2' to 'eth1': File exists
[   17.555956] mc: Linux media interface: v0.10
[   17.562492] videodev: Linux video capture interface: v2.00
[   17.563888] ACPI: button: Power Button [PWRF]
[   17.568693] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[   17.569891] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[   17.576667] usb 1-2: Found UVC 1.00 device FaceTime HD Camera (Built-in) (05ac:850b)
[   17.584048] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input11
[   17.587597] snd_hda_codec_cirrus hdaudioC0D0: autoconfig for CS4206: line_outs=2 (0x9/0xb/0x0/0x0/0x0) type:speaker
[   17.588634] snd_hda_codec_cirrus hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   17.589642] snd_hda_codec_cirrus hdaudioC0D0:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[   17.590667] snd_hda_codec_cirrus hdaudioC0D0:    mono: mono_out=0x0
[   17.591701] snd_hda_codec_cirrus hdaudioC0D0:    dig-out=0x10/0x0
[   17.592723] snd_hda_codec_cirrus hdaudioC0D0:    inputs:
[   17.593745] snd_hda_codec_cirrus hdaudioC0D0:      Mic=0xd
[   17.593752] usb 5-1.4: 1:1: cannot get freq at ep 0x4
[   17.594764] snd_hda_codec_cirrus hdaudioC0D0:      Line=0xc
[   17.596899] snd_hda_codec_cirrus hdaudioC0D0:    dig-in=0xf
[   17.602127] input: FaceTime HD Camera (Built-in):  as /devices/pci0000:00/0000:00:1a.7/usb1/1-2/1-2:1.0/input/input12
[   17.604843] usb 5-1.5: Found UVC 1.00 device FaceTime HD Camera (Display) (05ac:1112)
[   17.607387] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   17.608621] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   17.609766] input: HDA Intel PCH SPDIF In as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   17.612153] Bluetooth: Core ver 2.22
[   17.613258] NET: Registered PF_BLUETOOTH protocol family
[   17.614254] Bluetooth: HCI device and connection manager initialized
[   17.615345] Bluetooth: HCI socket layer initialized
[   17.616259] Bluetooth: L2CAP socket layer initialized
[   17.617129] Bluetooth: SCO socket layer initialized
[   17.622363] usbcore: registered new interface driver btusb
[   17.658466] applesmc: key=332 fan=3 temp=50 index=49 acc=0 lux=2 kbd=0
[   17.658628] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   17.674265] usb 1-1.1.2: USB disconnect, device number 8
[   17.745146] Bluetooth: hci0: BCM: chip id 254 build 0518
[   17.747137] Bluetooth: hci0: BCM: product 05ac:8215
[   17.749146] Bluetooth: hci0: BCM: features 0x00
[   17.763994] usb 5-1.4: 1:2: cannot get freq at ep 0x4
[   17.767149] Bluetooth: hci0: Bluetooth USB Host Controller
[   17.768408] input: FaceTime HD Camera (Display): F as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:00.0/0000:1a:00.0/0000:1b:03.0/0000:1c:00.2/usb5/5-1/5-1.5/5-1.5:1.0/input/input16
[   17.773140] usb 5-1.4: 2:1: cannot get freq at ep 0x84
[   17.812084] usb 5-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   17.812994] usb 5-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   17.848069] usb 5-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   17.848992] usb 5-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   17.863168] usb 6-1.4: 1:1: cannot get freq at ep 0x4
[   17.964646] usb 6-1.5: Found UVC 1.00 device FaceTime HD Camera (Display) (05ac:1112)
[   18.032194] usb 6-1.4: 1:2: cannot get freq at ep 0x4
[   18.036669] input: FaceTime HD Camera (Display): F as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:04.0/0000:1f:00.0/0000:20:00.0/0000:21:00.0/0000:22:03.0/0000:23:00.2/usb6/6-1/6-1.5/6-1.5:1.0/input/input17
[   18.037694] usbcore: registered new interface driver uvcvideo
[   18.041297] usb 6-1.4: 2:1: cannot get freq at ep 0x84
[   18.080294] usb 6-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   18.081293] usb 6-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   18.116409] usb 6-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   18.117355] usb 6-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   18.118765] usbcore: registered new interface driver snd-usb-audio
[   18.173885] usb 1-1.1.3: USB disconnect, device number 9
[   19.226204] Adding 16777212k swap on /dev/sda5.  Priority:-2 extents:1 across:16777212k SS
[   19.239012] EXT4-fs (sda6): re-mounted. Quota mode: none.
[   19.324569] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[   22.585669] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Quota mode: none.
[   23.104392] NET: Registered PF_PACKET protocol family
[   25.890900] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   25.891903] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   25.892898] tg3 0000:02:00.0 eth0: EEE is enabled
[   32.525008] FS-Cache: Loaded
[   32.530608] RPC: Registered named UNIX socket transport module.
[   32.531442] RPC: Registered udp transport module.
[   32.532264] RPC: Registered tcp transport module.
[   32.533093] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   32.545034] NFS: Registering the id_resolver key type
[   32.545905] Key type id_resolver registered
[   32.546738] Key type id_legacy registered
[   33.844664] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   34.262438] elogind-daemon[3137]: New seat seat0.
[   35.761481] switching from power state:
[   35.761489] 	ui class: performance
[   35.761491] 	internal class: none
[   35.761493] 	caps:
[   35.761495] 	uvd    vclk: 0 dclk: 0
[   35.761496] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   35.761498] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[   35.761500] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[   35.761502] 	status: c
[   35.761503] switching to power state:
[   35.761504] 	ui class: battery
[   35.761505] 	internal class: none
[   35.761506] 	caps:
[   35.761508] 	uvd    vclk: 0 dclk: 0
[   35.761509] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   35.761511] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   35.761512] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   35.761513] 	status: r
[   42.485854] elogind-daemon[3137]: New session c1 of user brad.

iMac - Right Port
[    0.000000] Linux version 5.17.0+ (brad@bkmac) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #51 SMP PREEMPT_DYNAMIC Fri Apr 1 13:23:13 AWST 2022
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
[    0.000000] tsc: Detected 3400.077 MHz processor
[    0.000095] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000097] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000103] last_pfn = 0x86ff00 max_arch_pfn = 0x400000000
[    0.000755] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001371] last_pfn = 0x8efa3 max_arch_pfn = 0x400000000
[    0.002473] Secure boot disabled
[    0.002474] RAMDISK: [mem 0x7e4ad000-0x7fffffff]
[    0.002478] ACPI: Early table checksum verification disabled
[    0.002481] ACPI: RSDP 0x000000008ED8E014 000024 (v02 APPLE )
[    0.002485] ACPI: XSDT 0x000000008ED8E1C0 0000A4 (v01 APPLE  Apple00  0000F000      01000013)
[    0.002490] ACPI: FACP 0x000000008ED8C000 0000F4 (v04 APPLE  Apple00  0000F000 Loki 0000005F)
[    0.002494] ACPI: DSDT 0x000000008ED81000 0053FB (v01 APPLE  iMac     00210001 INTL 20061109)
[    0.002497] ACPI: FACS 0x000000008ED3E000 000040
[    0.002499] ACPI: FACS 0x000000008ED3E000 000040
[    0.002502] ACPI: HPET 0x000000008ED8B000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002504] ACPI: APIC 0x000000008ED8A000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002507] ACPI: SBST 0x000000008ED88000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002509] ACPI: ECDT 0x000000008ED87000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002512] ACPI: SSDT 0x000000008ED7E000 00020D (v01 APPLE  SataAhci 00001000 INTL 20061109)
[    0.002514] ACPI: SSDT 0x000000008ED7C000 0000B1 (v01 APPLE  SmcDppt  00001000 INTL 20061109)
[    0.002517] ACPI: SSDT 0x000000008ED7A000 000646 (v01 APPLE  UsbNoRmh 00001000 INTL 20061109)
[    0.002519] ACPI: SSDT 0x000000008ED78000 00013D (v01 APPLE  SataPrt1 00001000 INTL 20061109)
[    0.002522] ACPI: SSDT 0x000000008ED77000 0000A0 (v02 APPLE  IGHda    00001000 INTL 20061109)
[    0.002524] ACPI: SSDT 0x000000008ED75000 000032 (v01 APPLE  SsdtS3   00001000 INTL 20061109)
[    0.002527] ACPI: SSDT 0x000000008ED74000 000548 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.002530] ACPI: SSDT 0x000000008ED73000 0009B1 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.002532] ACPI: SSDT 0x000000008ED72000 000315 (v01 PmRef  Cpu0Tst  00003000 INTL 20061109)
[    0.002535] ACPI: SSDT 0x000000008ED71000 00037A (v01 PmRef  ApTst    00003000 INTL 20061109)
[    0.002537] ACPI: MCFG 0x000000008ED89000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002539] ACPI: Reserving FACP table memory at [mem 0x8ed8c000-0x8ed8c0f3]
[    0.002541] ACPI: Reserving DSDT table memory at [mem 0x8ed81000-0x8ed863fa]
[    0.002542] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002543] ACPI: Reserving FACS table memory at [mem 0x8ed3e000-0x8ed3e03f]
[    0.002544] ACPI: Reserving HPET table memory at [mem 0x8ed8b000-0x8ed8b037]
[    0.002545] ACPI: Reserving APIC table memory at [mem 0x8ed8a000-0x8ed8a0bb]
[    0.002546] ACPI: Reserving SBST table memory at [mem 0x8ed88000-0x8ed8802f]
[    0.002547] ACPI: Reserving ECDT table memory at [mem 0x8ed87000-0x8ed87052]
[    0.002549] ACPI: Reserving SSDT table memory at [mem 0x8ed7e000-0x8ed7e20c]
[    0.002550] ACPI: Reserving SSDT table memory at [mem 0x8ed7c000-0x8ed7c0b0]
[    0.002551] ACPI: Reserving SSDT table memory at [mem 0x8ed7a000-0x8ed7a645]
[    0.002552] ACPI: Reserving SSDT table memory at [mem 0x8ed78000-0x8ed7813c]
[    0.002553] ACPI: Reserving SSDT table memory at [mem 0x8ed77000-0x8ed7709f]
[    0.002554] ACPI: Reserving SSDT table memory at [mem 0x8ed75000-0x8ed75031]
[    0.002555] ACPI: Reserving SSDT table memory at [mem 0x8ed74000-0x8ed74547]
[    0.002556] ACPI: Reserving SSDT table memory at [mem 0x8ed73000-0x8ed739b0]
[    0.002557] ACPI: Reserving SSDT table memory at [mem 0x8ed72000-0x8ed72314]
[    0.002558] ACPI: Reserving SSDT table memory at [mem 0x8ed71000-0x8ed71379]
[    0.002560] ACPI: Reserving MCFG table memory at [mem 0x8ed89000-0x8ed8903b]
[    0.002566] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.002593] Zone ranges:
[    0.002594]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002596]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002597]   Normal   [mem 0x0000000100000000-0x000000086fefffff]
[    0.002599] Movable zone start for each node
[    0.002599] Early memory node ranges
[    0.002600]   node   0: [mem 0x0000000000001000-0x000000000008dfff]
[    0.002601]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.002602]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.002603]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.002604]   node   0: [mem 0x0000000040200000-0x000000008ed32fff]
[    0.002605]   node   0: [mem 0x000000008ed5f000-0x000000008ed70fff]
[    0.002606]   node   0: [mem 0x000000008ed8f000-0x000000008ee59fff]
[    0.002607]   node   0: [mem 0x000000008ee8f000-0x000000008eed6fff]
[    0.002608]   node   0: [mem 0x000000008eeff000-0x000000008efa2fff]
[    0.002609]   node   0: [mem 0x0000000100000000-0x000000086fefffff]
[    0.002612] Initmem setup node 0 [mem 0x0000000000001000-0x000000086fefffff]
[    0.002615] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002617] On node 0, zone DMA: 2 pages in unavailable ranges
[    0.002635] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.004131] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006373] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.006378] On node 0, zone DMA32: 44 pages in unavailable ranges
[    0.006381] On node 0, zone DMA32: 30 pages in unavailable ranges
[    0.006383] On node 0, zone DMA32: 53 pages in unavailable ranges
[    0.006385] On node 0, zone DMA32: 40 pages in unavailable ranges
[    0.060508] On node 0, zone Normal: 4189 pages in unavailable ranges
[    0.060515] On node 0, zone Normal: 256 pages in unavailable ranges
[    0.060677] ACPI: PM-Timer IO Port: 0x408
[    0.060683] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.060685] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.060686] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.060687] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.060687] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.060688] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.060689] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.060690] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.060699] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.060702] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.060703] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.060707] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.060708] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.060711] TSC deadline timer available
[    0.060712] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.060734] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.060736] PM: hibernation: Registered nosave memory: [mem 0x0008e000-0x0008ffff]
[    0.060738] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
[    0.060739] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.060741] PM: hibernation: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.060743] PM: hibernation: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.060744] PM: hibernation: Registered nosave memory: [mem 0x89109000-0x89109fff]
[    0.060746] PM: hibernation: Registered nosave memory: [mem 0x89124000-0x89124fff]
[    0.060748] PM: hibernation: Registered nosave memory: [mem 0x891a7000-0x891a7fff]
[    0.060750] PM: hibernation: Registered nosave memory: [mem 0x891b8000-0x891b8fff]
[    0.060752] PM: hibernation: Registered nosave memory: [mem 0x8ed33000-0x8ed5efff]
[    0.060754] PM: hibernation: Registered nosave memory: [mem 0x8ed71000-0x8ed8efff]
[    0.060755] PM: hibernation: Registered nosave memory: [mem 0x8ee5a000-0x8ee8efff]
[    0.060757] PM: hibernation: Registered nosave memory: [mem 0x8eed7000-0x8eefefff]
[    0.060759] PM: hibernation: Registered nosave memory: [mem 0x8efa3000-0x8f8fffff]
[    0.060760] PM: hibernation: Registered nosave memory: [mem 0x8f900000-0xe00f7fff]
[    0.060761] PM: hibernation: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.060762] PM: hibernation: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff]
[    0.060763] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.060763] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xffed7fff]
[    0.060764] PM: hibernation: Registered nosave memory: [mem 0xffed8000-0xffefffff]
[    0.060765] PM: hibernation: Registered nosave memory: [mem 0xfff00000-0xffffffff]
[    0.060767] [mem 0x8f900000-0xe00f7fff] available for PCI devices
[    0.060771] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.063061] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.063229] percpu: Embedded 44 pages/cpu s139880 r8192 d32152 u262144
[    0.063235] pcpu-alloc: s139880 r8192 d32152 u262144 alloc=1*2097152
[    0.063237] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.063258] Built 1 zonelists, mobility grouping on.  Total pages: 8251732
[    0.063261] Kernel command line: ro root=UUID=de35d1a6-e0e1-40b0-b46a-3974a04adf4b libata.allow_tpm=1 netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da oops=panic panic=10 thunderbolt.dyndbg pci=assign-busses,realloc,hpbussize=0x10,hpmmiosize=128M,hpmmioprefsize=1G initrd=boot\initrd.img-5.17.0+
[    0.063321] Unknown kernel command line parameters "netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da", will be passed to user space.
[    0.064944] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.065768] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.065833] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.152443] Memory: 32768252K/33531492K available (8192K kernel code, 2298K rwdata, 1860K rodata, 956K init, 2628K bss, 762984K reserved, 0K cma-reserved)
[    0.152478] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.152692] Dynamic Preempt: voluntary
[    0.152716] rcu: Preemptible hierarchical RCU implementation.
[    0.152718] 	Trampoline variant of Tasks RCU enabled.
[    0.152719] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.152727] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
[    0.152920] random: get_random_bytes called from start_kernel+0x443/0x5fb with crng_init=0
[    0.152944] Console: colour dummy device 80x25
[    0.153213] printk: console [tty0] enabled
[    0.153221] ACPI: Core revision 20211217
[    0.153305] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.153319] APIC: Switch to symmetric I/O mode setup
[    0.153698] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.203318] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x310296e185b, max_idle_ns: 440795209360 ns
[    0.203323] Calibrating delay loop (skipped), value calculated using timer frequency.. 6800.15 BogoMIPS (lpj=34000770)
[    0.203327] pid_max: default: 32768 minimum: 301
[    0.208028] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.208092] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.208213] CPU0: Thermal monitoring enabled (TM1)
[    0.208217] process: using mwait in idle threads
[    0.208219] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.208221] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.208224] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.208228] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.208228] Spectre V2 : Vulnerable
[    0.208231] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.208233] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.208236] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.208238] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.208240] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.208243] MDS: Mitigation: Clear CPU buffers
[    0.208401] Freeing SMP alternatives memory: 24K
[    0.208668] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1054
[    0.208674] smpboot: CPU0: Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz (family: 0x6, model: 0x2a, stepping: 0x7)
[    0.208739] cblist_init_generic: Setting adjustable number of callback queues.
[    0.208743] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.208754] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.208766] ... version:                3
[    0.208768] ... bit width:              48
[    0.208769] ... generic registers:      4
[    0.208771] ... value mask:             0000ffffffffffff
[    0.208773] ... max period:             00007fffffffffff
[    0.208774] ... fixed-purpose events:   3
[    0.208776] ... event mask:             000000070000000f
[    0.208853] rcu: Hierarchical SRCU implementation.
[    0.208952] smp: Bringing up secondary CPUs ...
[    0.208996] x86: Booting SMP configuration:
[    0.208999] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.216870] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.216870]  #5 #6 #7
[    0.226649] smp: Brought up 1 node, 8 CPUs
[    0.226649] smpboot: Max logical packages: 1
[    0.226649] smpboot: Total of 8 processors activated (54401.23 BogoMIPS)
[    0.228849] devtmpfs: initialized
[    0.228849] ACPI: PM: Registering ACPI NVS region [mem 0x8ed33000-0x8ed5efff] (180224 bytes)
[    0.228849] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.228849] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.228849] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.228849] thermal_sys: Registered thermal governor 'step_wise'
[    0.228849] thermal_sys: Registered thermal governor 'user_space'
[    0.228849] cpuidle: using governor ladder
[    0.228849] cpuidle: using governor menu
[    0.228849] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.228849] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.228849] PCI: not using MMCONFIG
[    0.228849] PCI: Using configuration type 1 for base access
[    0.228849] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.233851] ACPI: Disabled all _OSI OS vendors
[    0.233851] ACPI: Added _OSI(Module Device)
[    0.233851] ACPI: Added _OSI(Processor Device)
[    0.233851] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.233851] ACPI: Added _OSI(Processor Aggregator Device)
[    0.233851] ACPI: Added _OSI(Linux-Dell-Video)
[    0.233851] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.233851] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.233851] ACPI: Added _OSI(Darwin)
[    0.235647] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.235849] ACPI: EC: EC started
[    0.235851] ACPI: EC: interrupt blocked
[    0.236666] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.236669] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.236797] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.236930] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.237131] ACPI: Dynamic OEM Table Load:
[    0.237138] ACPI: SSDT 0xFFFF888100379800 000781 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.237455] ACPI: Dynamic OEM Table Load:
[    0.237461] ACPI: SSDT 0xFFFF88810036E800 0003A4 (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.237693] ACPI: Dynamic OEM Table Load:
[    0.237698] ACPI: SSDT 0xFFFF8881000FA600 000119 (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.238479] ACPI: Interpreter enabled
[    0.238493] ACPI: PM: (supports S0 S3 S4 S5)
[    0.238495] ACPI: Using IOAPIC for interrupt routing
[    0.238513] PCI: MMCONFIG for domain 0000 [bus 00-fb] at [mem 0xe0000000-0xefbfffff] (base 0xe0000000)
[    0.238725] PCI: MMCONFIG at [mem 0xe0000000-0xefbfffff] reserved in ACPI motherboard resources
[    0.238737] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.238831] ACPI: Enabled 6 GPEs in block 00 to 3F
[    0.241687] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.241694] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.241698] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-fb] only partially covers this bridge
[    0.241835] PCI host bridge to bus 0000:00
[    0.241838] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.241841] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.241844] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.241847] pci_bus 0000:00: root bus resource [mem 0x8f900000-0xfeafffff window]
[    0.241850] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.241853] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.241863] pci 0000:00:00.0: [8086:0100] type 00 class 0x060000
[    0.241924] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
[    0.241953] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.242008] pci 0000:00:02.0: [8086:0102] type 00 class 0x038000
[    0.242015] pci 0000:00:02.0: reg 0x10: [mem 0xa8000000-0xa83fffff 64bit]
[    0.242021] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xa7ffffff 64bit pref]
[    0.242026] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.242097] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.242116] pci 0000:00:16.0: reg 0x10: [mem 0xa8907100-0xa890710f 64bit]
[    0.242182] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.242228] pci 0000:00:1a.0: [8086:1c2c] type 00 class 0x0c0300
[    0.242266] pci 0000:00:1a.0: reg 0x20: [io  0x3140-0x315f]
[    0.242349] pci 0000:00:1a.7: [8086:1c2d] type 00 class 0x0c0320
[    0.242365] pci 0000:00:1a.7: reg 0x10: [mem 0xa8906c00-0xa8906fff]
[    0.242440] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.242606] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.242621] pci 0000:00:1b.0: reg 0x10: [mem 0xa8900000-0xa8903fff 64bit]
[    0.242683] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.243376] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.243456] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.243523] pci 0000:00:1c.1: [8086:1c12] type 01 class 0x060400
[    0.243602] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.243667] pci 0000:00:1c.2: [8086:1c14] type 01 class 0x060400
[    0.243746] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.243811] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    0.243890] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.243954] pci 0000:00:1d.0: [8086:1c27] type 00 class 0x0c0300
[    0.243992] pci 0000:00:1d.0: reg 0x20: [io  0x30e0-0x30ff]
[    0.244074] pci 0000:00:1d.7: [8086:1c26] type 00 class 0x0c0320
[    0.244090] pci 0000:00:1d.7: reg 0x10: [mem 0xa8906800-0xa8906bff]
[    0.244165] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.244328] pci 0000:00:1f.0: [8086:1c44] type 00 class 0x060100
[    0.244470] pci 0000:00:1f.2: [8086:1c02] type 00 class 0x010601
[    0.244483] pci 0000:00:1f.2: reg 0x10: [io  0x3168-0x316f]
[    0.244490] pci 0000:00:1f.2: reg 0x14: [io  0x317c-0x317f]
[    0.244497] pci 0000:00:1f.2: reg 0x18: [io  0x3160-0x3167]
[    0.244505] pci 0000:00:1f.2: reg 0x1c: [io  0x3178-0x317b]
[    0.244512] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
[    0.244519] pci 0000:00:1f.2: reg 0x24: [mem 0xa8906000-0xa89067ff]
[    0.244554] pci 0000:00:1f.2: PME# supported from D3hot
[    0.244600] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    0.244615] pci 0000:00:1f.3: reg 0x10: [mem 0xa8907000-0xa89070ff 64bit]
[    0.244629] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.244732] pci 0000:01:00.0: [1002:6720] type 00 class 0x030000
[    0.244747] pci 0000:01:00.0: reg 0x10: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.244758] pci 0000:01:00.0: reg 0x18: [mem 0xa8800000-0xa881ffff 64bit]
[    0.244766] pci 0000:01:00.0: reg 0x20: [io  0x2000-0x20ff]
[    0.244778] pci 0000:01:00.0: reg 0x30: [mem 0xa8820000-0xa883ffff pref]
[    0.244785] pci 0000:01:00.0: enabling Extended Tags
[    0.244795] pci 0000:01:00.0: BAR 0: assigned to efifb
[    0.244824] pci 0000:01:00.0: supports D1 D2
[    0.244913] pci 0000:01:00.1: [1002:aa88] type 00 class 0x040300
[    0.244927] pci 0000:01:00.1: reg 0x10: [mem 0xa8840000-0xa8843fff 64bit]
[    0.244952] pci 0000:01:00.1: enabling Extended Tags
[    0.244987] pci 0000:01:00.1: supports D1 D2
[    0.245079] pci 0000:00:01.0: PCI bridge to [bus 01-ff]
[    0.245083] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.245086] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.245090] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.245093] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.245166] pci 0000:02:00.0: [14e4:16b4] type 00 class 0x020000
[    0.245200] pci 0000:02:00.0: reg 0x10: [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.245223] pci 0000:02:00.0: reg 0x18: [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.245379] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.245494] pci 0000:00:1c.0: PCI bridge to [bus 02-ff]
[    0.245501] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.245507] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.245510] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    0.245580] pci 0000:03:00.0: [168c:0030] type 00 class 0x028000
[    0.245611] pci 0000:03:00.0: reg 0x10: [mem 0xa8600000-0xa861ffff 64bit]
[    0.245671] pci 0000:03:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    0.245762] pci 0000:03:00.0: supports D1 D2
[    0.245764] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.245863] pci 0000:00:1c.1: PCI bridge to [bus 03-ff]
[    0.245869] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.245876] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.245948] pci 0000:04:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.245981] pci 0000:04:00.0: reg 0x10: [mem 0xa8500000-0xa8500fff 64bit]
[    0.246144] pci 0000:04:00.0: supports D1 D2
[    0.246146] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246341] pci 0000:00:1c.2: PCI bridge to [bus 04-ff]
[    0.246348] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.246354] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.246426] pci 0000:05:00.0: [8086:1513] type 01 class 0x060400
[    0.246491] pci 0000:05:00.0: enabling Extended Tags
[    0.246586] pci 0000:05:00.0: supports D1 D2
[    0.246588] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.246716] pci 0000:00:1c.4: PCI bridge to [bus 05-ff]
[    0.246721] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.246725] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.246731] pci 0000:00:1c.4:   bridge window [mem 0xacf00000-0xb10fffff 64bit pref]
[    0.246815] acpiphp: Slot [3] registered
[    0.246837] acpiphp: Slot [4] registered
[    0.246879] pci 0000:06:00.0: [8086:1513] type 01 class 0x060400
[    0.246949] pci 0000:06:00.0: enabling Extended Tags
[    0.247049] pci 0000:06:00.0: supports D1 D2
[    0.247051] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247162] pci 0000:06:03.0: [8086:1513] type 01 class 0x060400
[    0.247232] pci 0000:06:03.0: enabling Extended Tags
[    0.247333] pci 0000:06:03.0: supports D1 D2
[    0.247335] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247440] pci 0000:06:04.0: [8086:1513] type 01 class 0x060400
[    0.247510] pci 0000:06:04.0: enabling Extended Tags
[    0.247611] pci 0000:06:04.0: supports D1 D2
[    0.247613] pci 0000:06:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.247720] pci 0000:06:05.0: [8086:1513] type 01 class 0x060400
[    0.247790] pci 0000:06:05.0: enabling Extended Tags
[    0.247891] pci 0000:06:05.0: supports D1 D2
[    0.247893] pci 0000:06:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248003] pci 0000:06:06.0: [8086:1513] type 01 class 0x060400
[    0.248072] pci 0000:06:06.0: enabling Extended Tags
[    0.248173] pci 0000:06:06.0: supports D1 D2
[    0.248175] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248292] pci 0000:05:00.0: PCI bridge to [bus 06-ff]
[    0.248304] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.248313] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.248411] acpiphp: Slot [1] registered
[    0.248453] pci 0000:07:00.0: [8086:1513] type 00 class 0x088000
[    0.248480] pci 0000:07:00.0: reg 0x10: [mem 0xa8a00000-0xa8a3ffff]
[    0.248496] pci 0000:07:00.0: reg 0x14: [mem 0xa8a40000-0xa8a40fff]
[    0.248576] pci 0000:07:00.0: enabling Extended Tags
[    0.248701] pci 0000:07:00.0: supports D1 D2
[    0.248703] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.248845] pci 0000:06:00.0: PCI bridge to [bus 07-ff]
[    0.248857] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.248866] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    0.248922] pci 0000:06:03.0: PCI bridge to [bus 08-ff]
[    0.248934] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.248943] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 17
[    0.249055] pci 0000:18:00.0: [8086:1513] type 01 class 0x060400
[    0.249172] pci 0000:18:00.0: enabling Extended Tags
[    0.249348] pci 0000:18:00.0: supports D1 D2
[    0.249350] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.273383] pci 0000:06:04.0: PCI bridge to [bus 18-ff]
[    0.273401] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.273413] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.273422] pci 0000:18:00.0: bridge configuration invalid ([bus 3a-49]), reconfiguring
[    0.273588] pci 0000:19:00.0: [8086:1513] type 01 class 0x060400
[    0.273712] pci 0000:19:00.0: enabling Extended Tags
[    0.273893] pci 0000:19:00.0: supports D1 D2
[    0.273895] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274052] pci 0000:19:01.0: [8086:1513] type 01 class 0x060400
[    0.274176] pci 0000:19:01.0: enabling Extended Tags
[    0.274356] pci 0000:19:01.0: supports D1 D2
[    0.274358] pci 0000:19:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274513] pci 0000:19:02.0: [8086:1513] type 01 class 0x060400
[    0.274637] pci 0000:19:02.0: enabling Extended Tags
[    0.274817] pci 0000:19:02.0: supports D1 D2
[    0.274819] pci 0000:19:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.274980] pci 0000:19:04.0: [8086:1513] type 01 class 0x060400
[    0.275104] pci 0000:19:04.0: enabling Extended Tags
[    0.275286] pci 0000:19:04.0: supports D1 D2
[    0.275288] pci 0000:19:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275449] pci 0000:19:05.0: [8086:1513] type 01 class 0x060400
[    0.275556] pci 0000:19:05.0: enabling Extended Tags
[    0.275739] pci 0000:19:05.0: supports D1 D2
[    0.275741] pci 0000:19:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.275920] pci 0000:18:00.0: PCI bridge to [bus 19-ff]
[    0.275939] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.275953] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.275959] pci 0000:19:00.0: bridge configuration invalid ([bus 3b-3d]), reconfiguring
[    0.275976] pci 0000:19:01.0: bridge configuration invalid ([bus 3e-3e]), reconfiguring
[    0.275993] pci 0000:19:02.0: bridge configuration invalid ([bus 3f-3f]), reconfiguring
[    0.276009] pci 0000:19:04.0: bridge configuration invalid ([bus 40-48]), reconfiguring
[    0.276026] pci 0000:19:05.0: bridge configuration invalid ([bus 49-49]), reconfiguring
[    0.276180] pci 0000:1a:00.0: [12d8:400c] type 01 class 0x060400
[    0.276569] pci 0000:1a:00.0: supports D1 D2
[    0.276571] pci 0000:1a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.303359] pci 0000:19:00.0: PCI bridge to [bus 1a-ff]
[    0.303384] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.303406] pci 0000:1a:00.0: bridge configuration invalid ([bus 3c-3d]), reconfiguring
[    0.303643] pci 0000:1b:03.0: [12d8:400c] type 01 class 0x060400
[    0.303979] pci 0000:1b:03.0: supports D1 D2
[    0.303981] pci 0000:1b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304183] pci 0000:1a:00.0: PCI bridge to [bus 1b-ff]
[    0.304208] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.304229] pci 0000:1b:03.0: bridge configuration invalid ([bus 3d-3d]), reconfiguring
[    0.304433] pci 0000:1c:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.304484] pci 0000:1c:00.0: reg 0x10: [mem 0xa9401000-0xa9401fff]
[    0.304797] pci 0000:1c:00.0: supports D1 D2
[    0.304799] pci 0000:1c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304954] pci 0000:1c:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.305006] pci 0000:1c:00.1: reg 0x10: [mem 0xa9400000-0xa9400fff]
[    0.305318] pci 0000:1c:00.1: supports D1 D2
[    0.305321] pci 0000:1c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.305447] pci 0000:1c:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.305498] pci 0000:1c:00.2: reg 0x10: [mem 0xa9402000-0xa94020ff]
[    0.305810] pci 0000:1c:00.2: supports D1 D2
[    0.305812] pci 0000:1c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.306068] pci 0000:1b:03.0: PCI bridge to [bus 1c-ff]
[    0.306093] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.306110] pci_bus 0000:1c: busn_res: [bus 1c-ff] end is updated to 1c
[    0.306121] pci_bus 0000:1b: busn_res: [bus 1b-ff] end is updated to 1c
[    0.306131] pci_bus 0000:1a: busn_res: [bus 1a-ff] end is updated to 1c
[    0.306278] pci 0000:1d:00.0: [14e4:16b0] type 00 class 0x020000
[    0.306346] pci 0000:1d:00.0: reg 0x10: [mem 0xad000000-0xad00ffff 64bit pref]
[    0.306392] pci 0000:1d:00.0: reg 0x18: [mem 0xad010000-0xad01ffff 64bit pref]
[    0.306733] pci 0000:1d:00.0: PME# supported from D0 D3hot D3cold
[    0.333379] pci 0000:19:01.0: PCI bridge to [bus 1d-ff]
[    0.333403] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.333421] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.333427] pci_bus 0000:1d: busn_res: [bus 1d-ff] end is updated to 1d
[    0.333581] pci 0000:1e:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.333651] pci 0000:1e:00.0: reg 0x10: [mem 0xa9200000-0xa9200fff 64bit]
[    0.334004] pci 0000:1e:00.0: supports D1 D2
[    0.334006] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.363378] pci 0000:19:02.0: PCI bridge to [bus 1e-ff]
[    0.363403] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.363420] pci_bus 0000:1e: busn_res: [bus 1e-ff] end is updated to 1e
[    0.363601] pci 0000:1f:00.0: [8086:1513] type 01 class 0x060400
[    0.363773] pci 0000:1f:00.0: enabling Extended Tags
[    0.364031] pci 0000:1f:00.0: supports D1 D2
[    0.364033] pci 0000:1f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.393365] pci 0000:19:04.0: PCI bridge to [bus 1f-ff]
[    0.393389] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.393407] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.393417] pci 0000:1f:00.0: bridge configuration invalid ([bus 41-48]), reconfiguring
[    0.393646] pci 0000:20:00.0: [8086:1513] type 01 class 0x060400
[    0.393825] pci 0000:20:00.0: enabling Extended Tags
[    0.394087] pci 0000:20:00.0: supports D1 D2
[    0.394089] pci 0000:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394308] pci 0000:20:01.0: [8086:1513] type 01 class 0x060400
[    0.394488] pci 0000:20:01.0: enabling Extended Tags
[    0.394749] pci 0000:20:01.0: supports D1 D2
[    0.394751] pci 0000:20:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394968] pci 0000:20:02.0: [8086:1513] type 01 class 0x060400
[    0.395147] pci 0000:20:02.0: enabling Extended Tags
[    0.395408] pci 0000:20:02.0: supports D1 D2
[    0.395410] pci 0000:20:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.395636] pci 0000:20:04.0: [8086:1513] type 01 class 0x060400
[    0.395791] pci 0000:20:04.0: enabling Extended Tags
[    0.396056] pci 0000:20:04.0: supports D1 D2
[    0.396058] pci 0000:20:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.396285] pci 0000:20:05.0: [8086:1513] type 01 class 0x060400
[    0.396440] pci 0000:20:05.0: enabling Extended Tags
[    0.396706] pci 0000:20:05.0: supports D1 D2
[    0.396708] pci 0000:20:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.396962] pci 0000:1f:00.0: PCI bridge to [bus 20-ff]
[    0.396989] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.397007] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.397015] pci 0000:20:00.0: bridge configuration invalid ([bus 42-44]), reconfiguring
[    0.397038] pci 0000:20:01.0: bridge configuration invalid ([bus 45-45]), reconfiguring
[    0.397061] pci 0000:20:02.0: bridge configuration invalid ([bus 46-46]), reconfiguring
[    0.397084] pci 0000:20:04.0: bridge configuration invalid ([bus 47-47]), reconfiguring
[    0.397108] pci 0000:20:05.0: bridge configuration invalid ([bus 48-48]), reconfiguring
[    0.397321] pci 0000:21:00.0: [12d8:400c] type 01 class 0x060400
[    0.397842] pci 0000:21:00.0: supports D1 D2
[    0.397844] pci 0000:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.398111] pci 0000:20:00.0: PCI bridge to [bus 21-ff]
[    0.398138] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.398162] pci 0000:21:00.0: bridge configuration invalid ([bus 43-44]), reconfiguring
[    0.398459] pci 0000:22:03.0: [12d8:400c] type 01 class 0x060400
[    0.398908] pci 0000:22:03.0: supports D1 D2
[    0.398910] pci 0000:22:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.399176] pci 0000:21:00.0: PCI bridge to [bus 22-ff]
[    0.399208] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.399236] pci 0000:22:03.0: bridge configuration invalid ([bus 44-44]), reconfiguring
[    0.399508] pci 0000:23:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.399576] pci 0000:23:00.0: reg 0x10: [mem 0xa9101000-0xa9101fff]
[    0.399995] pci 0000:23:00.0: supports D1 D2
[    0.399997] pci 0000:23:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400205] pci 0000:23:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.400273] pci 0000:23:00.1: reg 0x10: [mem 0xa9100000-0xa9100fff]
[    0.400692] pci 0000:23:00.1: supports D1 D2
[    0.400694] pci 0000:23:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400858] pci 0000:23:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.400926] pci 0000:23:00.2: reg 0x10: [mem 0xa9102000-0xa91020ff]
[    0.401345] pci 0000:23:00.2: supports D1 D2
[    0.401347] pci 0000:23:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.401701] pci 0000:22:03.0: PCI bridge to [bus 23-ff]
[    0.401733] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.401756] pci_bus 0000:23: busn_res: [bus 23-ff] end is updated to 23
[    0.401769] pci_bus 0000:22: busn_res: [bus 22-ff] end is updated to 23
[    0.401782] pci_bus 0000:21: busn_res: [bus 21-ff] end is updated to 23
[    0.401984] pci 0000:24:00.0: [14e4:16b0] type 00 class 0x020000
[    0.402076] pci 0000:24:00.0: reg 0x10: [mem 0xacf00000-0xacf0ffff 64bit pref]
[    0.402136] pci 0000:24:00.0: reg 0x18: [mem 0xacf10000-0xacf1ffff 64bit pref]
[    0.402589] pci 0000:24:00.0: PME# supported from D0 D3hot D3cold
[    0.402906] pci 0000:20:01.0: PCI bridge to [bus 24-ff]
[    0.402933] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.402952] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.402955] pci_bus 0000:24: busn_res: [bus 24-ff] end is updated to 24
[    0.403152] pci 0000:25:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.403243] pci 0000:25:00.0: reg 0x10: [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.403711] pci 0000:25:00.0: supports D1 D2
[    0.403713] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.404010] pci 0000:20:02.0: PCI bridge to [bus 25-ff]
[    0.404038] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.404057] pci_bus 0000:25: busn_res: [bus 25-ff] end is updated to 25
[    0.404189] pci 0000:20:04.0: PCI bridge to [bus 26-ff]
[    0.404216] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.404235] pci_bus 0000:26: busn_res: [bus 26-ff] end is updated to 35
[    0.404368] pci 0000:20:05.0: PCI bridge to [bus 36-ff]
[    0.404395] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.404414] pci_bus 0000:36: busn_res: [bus 36-ff] end is updated to 45
[    0.404425] pci_bus 0000:20: busn_res: [bus 20-ff] end is updated to 45
[    0.404435] pci_bus 0000:1f: busn_res: [bus 1f-ff] end is updated to 45
[    0.404529] pci 0000:19:05.0: PCI bridge to [bus 46-ff]
[    0.404548] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.404562] pci_bus 0000:46: busn_res: [bus 46-ff] end is updated to 55
[    0.404570] pci_bus 0000:19: busn_res: [bus 19-ff] end is updated to 55
[    0.404578] pci_bus 0000:18: busn_res: [bus 18-ff] end is updated to 55
[    0.404640] pci 0000:06:05.0: PCI bridge to [bus 56-ff]
[    0.404652] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.404661] pci_bus 0000:56: busn_res: [bus 56-ff] end is updated to 65
[    0.404717] pci 0000:06:06.0: PCI bridge to [bus 66-ff]
[    0.404729] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.404737] pci_bus 0000:66: busn_res: [bus 66-ff] end is updated to 75
[    0.404743] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 75
[    0.404749] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 75
[    0.404754] pci_bus 0000:00: on NUMA node 0
[    0.405019] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.405022] ACPI: PCI: Interrupt link LNKA disabled
[    0.405053] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.405055] ACPI: PCI: Interrupt link LNKB disabled
[    0.405084] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.405086] ACPI: PCI: Interrupt link LNKC disabled
[    0.405114] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.405117] ACPI: PCI: Interrupt link LNKD disabled
[    0.405145] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.405147] ACPI: PCI: Interrupt link LNKE disabled
[    0.405175] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.405178] ACPI: PCI: Interrupt link LNKF disabled
[    0.405206] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.405208] ACPI: PCI: Interrupt link LNKG disabled
[    0.405236] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.405238] ACPI: PCI: Interrupt link LNKH disabled
[    0.405325] ACPI: EC: interrupt unblocked
[    0.405327] ACPI: EC: event unblocked
[    0.405331] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.405333] ACPI: EC: GPE=0x17
[    0.405335] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.405338] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.405391] SCSI subsystem initialized
[    0.405398] libata version 3.00 loaded.
[    0.405398] Registered efivars operations
[    0.405398] PCI: Using ACPI for IRQ routing
[    0.416036] PCI: pci_cache_line_size set to 64 bytes
[    0.416040] pci 0000:00:1c.4: can't claim BAR 9 [mem 0xacf00000-0xb10fffff 64bit pref]: address conflict with PCI Bus 0000:05 [mem 0xa8a00000-0xad6fffff]
[    0.416320] e820: reserve RAM buffer [mem 0x0008e000-0x0008ffff]
[    0.416322] e820: reserve RAM buffer [mem 0x89109018-0x8bffffff]
[    0.416323] e820: reserve RAM buffer [mem 0x891a7018-0x8bffffff]
[    0.416324] e820: reserve RAM buffer [mem 0x8ed33000-0x8fffffff]
[    0.416325] e820: reserve RAM buffer [mem 0x8ed71000-0x8fffffff]
[    0.416326] e820: reserve RAM buffer [mem 0x8ee5a000-0x8fffffff]
[    0.416328] e820: reserve RAM buffer [mem 0x8eed7000-0x8fffffff]
[    0.416329] e820: reserve RAM buffer [mem 0x8efa3000-0x8fffffff]
[    0.416330] e820: reserve RAM buffer [mem 0x86ff00000-0x86fffffff]
[    0.416338] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.416338] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.416338] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.416338] vgaarb: loaded
[    0.416338] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.416338] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.416338] clocksource: Switched to clocksource tsc-early
[    0.416338] VFS: Disk quotas dquot_6.6.0
[    0.416338] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.416369] pnp: PnP ACPI init
[    0.416480] system 00:00: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.416524] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.416528] system 00:01: [io  0x1000-0x100f] has been reserved
[    0.416530] system 00:01: [io  0xffff] has been reserved
[    0.416533] system 00:01: [io  0xffff] has been reserved
[    0.416535] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.416538] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.416540] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.416692] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.416696] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.416699] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.416701] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.416704] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.416707] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.416709] system 00:03: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.416712] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.416714] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[    0.416717] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.416800] pnp: PnP ACPI: found 4 devices
[    0.416815] pci 0000:01:00.0: assigning 75 device properties
[    0.416815] pci 0000:04:00.0: assigning 2 device properties
[    0.416815] pci 0000:07:00.0: assigning 5 device properties
[    0.416815] pci 0000:1e:00.0: assigning 2 device properties
[    0.416815] pci 0000:25:00.0: assigning 2 device properties
[    0.416815] pci 0000:00:1b.0: assigning 4 device properties
[    0.419135] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.419156] NET: Registered PF_INET protocol family
[    0.419313] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.421170] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.421207] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.421472] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.421559] TCP: Hash tables configured (established 262144 bind 65536)
[    0.421585] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.421644] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.421722] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.421730] pci 0000:03:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[    0.421738] pci_bus 0000:00: max bus depth: 9 pci_try_num: 10
[    0.421750] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.421753] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.421757] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.421760] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.421764] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.421769] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.421773] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.421782] pci 0000:03:00.0: BAR 6: assigned [mem 0xa8620000-0xa862ffff pref]
[    0.421785] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.421790] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.421798] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.421802] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.421811] pci 0000:05:00.0: BAR 7: no space for [io  size 0x8000]
[    0.421813] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x8000]
[    0.421818] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421821] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421824] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421827] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421830] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421833] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421836] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.421838] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421841] pci 0000:06:04.0: BAR 7: no space for [io  size 0x5000]
[    0.421843] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.421846] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.421848] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421851] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.421854] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421857] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.421864] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.421876] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.421883] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.421895] pci 0000:18:00.0: BAR 7: no space for [io  size 0x4000]
[    0.421897] pci 0000:18:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.421901] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.421903] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.421906] pci 0000:19:04.0: BAR 7: no space for [io  size 0x3000]
[    0.421909] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.421911] pci 0000:19:05.0: BAR 7: no space for [io  size 0x1000]
[    0.421913] pci 0000:19:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.421916] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.421930] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.421955] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.421968] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.421993] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.422004] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422023] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.422034] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.422042] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.422056] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.422066] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.422086] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.422088] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.422092] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422095] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422098] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422101] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422104] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[    0.422106] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422109] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422111] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422114] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.422131] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422164] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.422181] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422213] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.422228] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.422255] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.422269] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.422280] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422299] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.422314] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.422341] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.422355] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.422382] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.422397] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.422423] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.422438] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.422448] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422467] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.422478] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.422486] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.422500] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.422510] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.422530] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.422540] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.422548] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422561] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.422568] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.422574] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422582] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.422589] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.422601] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.422608] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.422620] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.422626] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.422631] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.422640] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.422643] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.422648] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.422656] pci_bus 0000:00: No. 2 try to assign unassigned res
[    0.422664] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.422666] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.422669] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.422672] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.422676] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.422681] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.422685] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.422691] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.422696] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.422704] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.422709] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.422717] pci 0000:05:00.0: BAR 7: no space for [io  size 0x8000]
[    0.422719] pci 0000:05:00.0: BAR 7: failed to assign [io  size 0x8000]
[    0.422722] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422725] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422728] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422731] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422734] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422737] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422740] pci 0000:06:03.0: BAR 7: no space for [io  size 0x1000]
[    0.422742] pci 0000:06:03.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422745] pci 0000:06:04.0: BAR 7: no space for [io  size 0x5000]
[    0.422747] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.422749] pci 0000:06:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422752] pci 0000:06:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422754] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.422756] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422759] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.422766] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.422777] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.422784] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xa8bfffff]
[    0.422796] pci 0000:18:00.0: BAR 7: no space for [io  size 0x4000]
[    0.422798] pci 0000:18:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.422802] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422804] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422807] pci 0000:19:04.0: BAR 7: no space for [io  size 0x3000]
[    0.422809] pci 0000:19:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.422812] pci 0000:19:05.0: BAR 7: no space for [io  size 0x1000]
[    0.422814] pci 0000:19:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.422817] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.422830] pci 0000:1b:03.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422855] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.422868] pci 0000:1a:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422893] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.422904] pci 0000:19:00.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.422923] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.422933] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.422941] pci 0000:19:01.0:   bridge window [mem 0xad000000-0xad0fffff 64bit pref]
[    0.422955] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.422966] pci 0000:19:02.0:   bridge window [mem 0xa9200000-0xa92fffff]
[    0.422985] pci 0000:1f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.422987] pci 0000:1f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.422991] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.422993] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.422997] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423000] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423002] pci 0000:20:04.0: BAR 7: no space for [io  size 0x1000]
[    0.423005] pci 0000:20:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.423007] pci 0000:20:05.0: BAR 7: no space for [io  size 0x1000]
[    0.423009] pci 0000:20:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.423012] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.423029] pci 0000:22:03.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423062] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.423079] pci 0000:21:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423112] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.423126] pci 0000:20:00.0:   bridge window [mem 0xa9100000-0xa91fffff]
[    0.423153] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.423168] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.423178] pci 0000:20:01.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423197] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.423212] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.423239] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.423253] pci 0000:20:04.0:   bridge window [mem 0xa8e00000-0xa8efffff]
[    0.423280] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.423294] pci 0000:20:05.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.423321] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.423336] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.423346] pci 0000:1f:00.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423365] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.423375] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.423383] pci 0000:19:04.0:   bridge window [mem 0xacf00000-0xacffffff 64bit pref]
[    0.423397] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.423408] pci 0000:19:05.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.423427] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.423437] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.423445] pci 0000:18:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423459] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.423466] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.423471] pci 0000:06:04.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423480] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.423487] pci 0000:06:05.0:   bridge window [mem 0xa9500000-0xa95fffff]
[    0.423498] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.423505] pci 0000:06:06.0:   bridge window [mem 0xa9600000-0xa96fffff]
[    0.423517] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.423523] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.423529] pci 0000:05:00.0:   bridge window [mem 0xacf00000-0xad0fffff 64bit pref]
[    0.423537] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.423540] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.423545] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.423553] pci_bus 0000:00: No. 3 try to assign unassigned res
[    0.423556] release child resource [mem 0xa9100000-0xa9100fff]
[    0.423557] release child resource [mem 0xa9101000-0xa9101fff]
[    0.423557] release child resource [mem 0xa9102000-0xa91020ff]
[    0.423558] pci 0000:22:03.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423561] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.423573] pci 0000:21:00.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423575] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.423588] pci 0000:20:00.0: resource 8 [mem 0xa9100000-0xa91fffff] released
[    0.423590] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.423600] release child resource [mem 0xacf00000-0xacf0ffff 64bit pref]
[    0.423601] release child resource [mem 0xacf10000-0xacf1ffff 64bit pref]
[    0.423602] pci 0000:20:01.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423605] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.423627] release child resource [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.423628] pci 0000:20:02.0: resource 8 [mem 0xa8f00000-0xa8ffffff] released
[    0.423631] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.423641] pci 0000:20:04.0: resource 8 [mem 0xa8e00000-0xa8efffff] released
[    0.423643] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.423654] pci 0000:20:05.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.423656] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.423666] pci 0000:1f:00.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423669] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.423692] release child resource [mem 0xa9400000-0xa9400fff]
[    0.423693] release child resource [mem 0xa9401000-0xa9401fff]
[    0.423694] release child resource [mem 0xa9402000-0xa94020ff]
[    0.423694] pci 0000:1b:03.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423697] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.423706] pci 0000:1a:00.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423709] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.423718] pci 0000:19:00.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.423721] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.423728] release child resource [mem 0xad000000-0xad00ffff 64bit pref]
[    0.423729] release child resource [mem 0xad010000-0xad01ffff 64bit pref]
[    0.423730] pci 0000:19:01.0: resource 9 [mem 0xad000000-0xad0fffff 64bit pref] released
[    0.423733] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.423749] release child resource [mem 0xa9200000-0xa9200fff 64bit]
[    0.423750] pci 0000:19:02.0: resource 8 [mem 0xa9200000-0xa92fffff] released
[    0.423752] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.423760] pci 0000:19:04.0: resource 9 [mem 0xacf00000-0xacffffff 64bit pref] released
[    0.423763] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.423779] pci 0000:19:05.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.423782] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.423789] pci 0000:18:00.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423792] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.423809] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.423810] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.423810] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.423813] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.423818] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xa8bfffff] released
[    0.423820] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.423826] pci 0000:06:04.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423829] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.423839] pci 0000:06:05.0: resource 8 [mem 0xa9500000-0xa95fffff] released
[    0.423841] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.423846] pci 0000:06:06.0: resource 8 [mem 0xa9600000-0xa96fffff] released
[    0.423849] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.423854] pci 0000:05:00.0: resource 9 [mem 0xacf00000-0xad0fffff 64bit pref] released
[    0.423857] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.423868] pci 0000:00:1c.4: resource 7 [io  0x4000-0x4fff] released
[    0.423870] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.423885] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.423888] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.423891] pci 0000:00:1c.4: BAR 7: assigned [io  0x4000-0xbfff]
[    0.423894] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.423896] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.423899] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.423902] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.423906] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.423911] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.423915] pci 0000:00:1c.0:   bridge window [mem 0xa8400000-0xa84fffff 64bit pref]
[    0.423922] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.423926] pci 0000:00:1c.1:   bridge window [mem 0xa8600000-0xa86fffff]
[    0.423934] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.423939] pci 0000:00:1c.2:   bridge window [mem 0xa8500000-0xa85fffff]
[    0.423948] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.423951] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.423954] pci 0000:05:00.0: BAR 7: assigned [io  0x4000-0xbfff]
[    0.423957] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.423960] pci 0000:06:03.0: BAR 8: no space for [mem size 0x08000000]
[    0.423962] pci 0000:06:03.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.423965] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423968] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423971] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.423974] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.423977] pci 0000:06:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.423979] pci 0000:06:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.423982] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423985] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423988] pci 0000:06:06.0: BAR 8: no space for [mem size 0x08000000]
[    0.423990] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.423993] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.423996] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.423999] pci 0000:06:03.0: BAR 7: assigned [io  0x4000-0x4fff]
[    0.424001] pci 0000:06:04.0: BAR 7: assigned [io  0x5000-0x9fff]
[    0.424004] pci 0000:06:05.0: BAR 7: assigned [io  0xa000-0xafff]
[    0.424006] pci 0000:06:06.0: BAR 7: assigned [io  0xb000-0xbfff]
[    0.424009] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.424015] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.424022] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.424029] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.424041] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.424044] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.424061] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.424064] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.424067] pci 0000:18:00.0: BAR 7: assigned [io  0x5000-0x8fff]
[    0.424070] pci 0000:19:00.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424073] pci 0000:19:01.0: BAR 9: assigned [mem 0xa9200000-0xa92fffff 64bit pref]
[    0.424076] pci 0000:19:02.0: BAR 8: assigned [mem 0xa9400000-0xa94fffff]
[    0.424079] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.424082] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.424085] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424087] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424090] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424093] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424096] pci 0000:19:04.0: BAR 7: assigned [io  0x5000-0x7fff]
[    0.424098] pci 0000:19:05.0: BAR 7: assigned [io  0x8000-0x8fff]
[    0.424101] pci 0000:1a:00.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424104] pci 0000:1b:03.0: BAR 8: assigned [mem 0xa8c00000-0xa8cfffff]
[    0.424107] pci 0000:1c:00.0: BAR 0: assigned [mem 0xa8c00000-0xa8c00fff]
[    0.424117] pci 0000:1c:00.1: BAR 0: assigned [mem 0xa8c01000-0xa8c01fff]
[    0.424127] pci 0000:1c:00.2: BAR 0: assigned [mem 0xa8c02000-0xa8c020ff]
[    0.424137] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.424150] pci 0000:1b:03.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424175] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.424189] pci 0000:1a:00.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424213] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.424224] pci 0000:19:00.0:   bridge window [mem 0xa8c00000-0xa8cfffff]
[    0.424244] pci 0000:1d:00.0: BAR 0: assigned [mem 0xa9200000-0xa920ffff 64bit pref]
[    0.424274] pci 0000:1d:00.0: BAR 2: assigned [mem 0xa9210000-0xa921ffff 64bit pref]
[    0.424304] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.424315] pci 0000:19:01.0:   bridge window [mem 0xa9300000-0xa93fffff]
[    0.424323] pci 0000:19:01.0:   bridge window [mem 0xa9200000-0xa92fffff 64bit pref]
[    0.424337] pci 0000:1e:00.0: BAR 0: assigned [mem 0xa9400000-0xa9400fff 64bit]
[    0.424368] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.424378] pci 0000:19:02.0:   bridge window [mem 0xa9400000-0xa94fffff]
[    0.424398] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.424400] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.424403] pci 0000:1f:00.0: BAR 7: assigned [io  0x5000-0x6fff]
[    0.424407] pci 0000:20:00.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424410] pci 0000:20:01.0: BAR 9: assigned [mem 0xa8e00000-0xa8efffff 64bit pref]
[    0.424413] pci 0000:20:02.0: BAR 8: assigned [mem 0xa8f00000-0xa8ffffff]
[    0.424415] pci 0000:20:04.0: BAR 8: no space for [mem size 0x08000000]
[    0.424418] pci 0000:20:04.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424420] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424423] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424426] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.424428] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.424431] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.424434] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.424437] pci 0000:20:04.0: BAR 7: assigned [io  0x5000-0x5fff]
[    0.424439] pci 0000:20:05.0: BAR 7: assigned [io  0x6000-0x6fff]
[    0.424442] pci 0000:21:00.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424445] pci 0000:22:03.0: BAR 8: assigned [mem 0xa8d00000-0xa8dfffff]
[    0.424448] pci 0000:23:00.0: BAR 0: assigned [mem 0xa8d00000-0xa8d00fff]
[    0.424461] pci 0000:23:00.1: BAR 0: assigned [mem 0xa8d01000-0xa8d01fff]
[    0.424473] pci 0000:23:00.2: BAR 0: assigned [mem 0xa8d02000-0xa8d020ff]
[    0.424486] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.424503] pci 0000:22:03.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424536] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.424553] pci 0000:21:00.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424586] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.424600] pci 0000:20:00.0:   bridge window [mem 0xa8d00000-0xa8dfffff]
[    0.424627] pci 0000:24:00.0: BAR 0: assigned [mem 0xa8e00000-0xa8e0ffff 64bit pref]
[    0.424667] pci 0000:24:00.0: BAR 2: assigned [mem 0xa8e10000-0xa8e1ffff 64bit pref]
[    0.424706] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.424721] pci 0000:20:01.0:   bridge window [mem 0xa9000000-0xa90fffff]
[    0.424731] pci 0000:20:01.0:   bridge window [mem 0xa8e00000-0xa8efffff 64bit pref]
[    0.424751] pci 0000:25:00.0: BAR 0: assigned [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.424790] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.424804] pci 0000:20:02.0:   bridge window [mem 0xa8f00000-0xa8ffffff]
[    0.424831] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.424838] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.424877] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.424883] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.424922] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.424928] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.424942] pci 0000:1f:00.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.424969] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.424974] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.424985] pci 0000:19:04.0:   bridge window [mem 0xa8d00000-0xa91fffff]
[    0.425004] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.425009] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.425036] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.425041] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.425052] pci 0000:18:00.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.425071] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.425074] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.425081] pci 0000:06:04.0:   bridge window [mem 0xa8c00000-0xa94fffff]
[    0.425093] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.425096] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.425113] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.425116] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.425133] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.425136] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.425143] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xa96fffff]
[    0.425154] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.425157] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.425162] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xad6fffff]
[    0.425170] pci_bus 0000:00: No. 4 try to assign unassigned res
[    0.425172] release child resource [mem 0xa8d00000-0xa8d00fff]
[    0.425173] release child resource [mem 0xa8d01000-0xa8d01fff]
[    0.425173] release child resource [mem 0xa8d02000-0xa8d020ff]
[    0.425174] pci 0000:22:03.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425177] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.425189] pci 0000:21:00.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425191] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.425204] pci 0000:20:00.0: resource 8 [mem 0xa8d00000-0xa8dfffff] released
[    0.425206] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.425216] release child resource [mem 0xa8e00000-0xa8e0ffff 64bit pref]
[    0.425217] release child resource [mem 0xa8e10000-0xa8e1ffff 64bit pref]
[    0.425218] pci 0000:20:01.0: resource 9 [mem 0xa8e00000-0xa8efffff 64bit pref] released
[    0.425221] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.425243] release child resource [mem 0xa8f00000-0xa8f00fff 64bit]
[    0.425244] pci 0000:20:02.0: resource 8 [mem 0xa8f00000-0xa8ffffff] released
[    0.425246] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.425257] release child resource [mem 0xa9000000-0xa90fffff]
[    0.425257] pci 0000:1f:00.0: resource 8 [mem 0xa8d00000-0xa91fffff] released
[    0.425260] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.425271] pci 0000:19:04.0: resource 8 [mem 0xa8d00000-0xa91fffff] released
[    0.425273] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.425281] release child resource [mem 0xa8c00000-0xa8c00fff]
[    0.425281] release child resource [mem 0xa8c01000-0xa8c01fff]
[    0.425282] release child resource [mem 0xa8c02000-0xa8c020ff]
[    0.425283] pci 0000:1b:03.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425285] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.425295] pci 0000:1a:00.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425297] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.425306] pci 0000:19:00.0: resource 8 [mem 0xa8c00000-0xa8cfffff] released
[    0.425309] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.425316] release child resource [mem 0xa9200000-0xa920ffff 64bit pref]
[    0.425317] release child resource [mem 0xa9210000-0xa921ffff 64bit pref]
[    0.425318] pci 0000:19:01.0: resource 9 [mem 0xa9200000-0xa92fffff 64bit pref] released
[    0.425321] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.425337] release child resource [mem 0xa9400000-0xa9400fff 64bit]
[    0.425338] pci 0000:19:02.0: resource 8 [mem 0xa9400000-0xa94fffff] released
[    0.425340] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.425348] release child resource [mem 0xa9300000-0xa93fffff]
[    0.425349] pci 0000:18:00.0: resource 8 [mem 0xa8c00000-0xa94fffff] released
[    0.425351] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.425359] pci 0000:06:04.0: resource 8 [mem 0xa8c00000-0xa94fffff] released
[    0.425362] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.425367] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.425368] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.425368] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.425371] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.425376] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xa96fffff] released
[    0.425379] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.425386] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xad6fffff] released
[    0.425388] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.425392] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425393] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.425396] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425399] release child resource [mem 0xa8400000-0xa840ffff 64bit pref]
[    0.425400] release child resource [mem 0xa8410000-0xa841ffff 64bit pref]
[    0.425401] pci 0000:00:1c.0: resource 9 [mem 0xa8400000-0xa84fffff 64bit pref] released
[    0.425404] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.425410] release child resource [mem 0xa8600000-0xa861ffff 64bit]
[    0.425411] release child resource [mem 0xa8620000-0xa862ffff pref]
[    0.425412] pci 0000:00:1c.1: resource 8 [mem 0xa8600000-0xa86fffff] released
[    0.425414] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.425418] release child resource [mem 0xa8500000-0xa8500fff 64bit]
[    0.425419] pci 0000:00:1c.2: resource 8 [mem 0xa8500000-0xa85fffff] released
[    0.425421] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.425434] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425438] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.425441] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.425444] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.425447] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.425451] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.425453] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.425457] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425465] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425467] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.425470] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.425473] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.425478] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.425493] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.425509] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.425514] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.425518] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.425525] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.425539] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.425542] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.425547] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.425555] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.425570] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.425575] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.425583] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.425586] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.425589] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.425592] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.425595] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.425598] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425601] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425604] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.425606] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.425609] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.425612] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.425615] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425618] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425621] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.425623] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.425626] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.425629] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.425636] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.425642] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.425649] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.425661] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.425665] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.425672] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.425683] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.425686] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.425689] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.425693] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.425695] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.425698] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.425701] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
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
[    0.425772] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425797] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.425810] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425835] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.425846] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.425865] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.425896] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.425926] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.425936] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.425944] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.425959] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.425989] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.426000] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.426019] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.426022] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.426025] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.426028] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426031] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.426033] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.426036] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.426039] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.426042] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.426044] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.426047] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.426050] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.426052] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.426055] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.426058] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426061] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.426064] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.426076] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.426089] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.426102] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.426119] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426152] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.426169] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426201] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.426216] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.426243] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.426283] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.426322] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.426336] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.426347] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.426366] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.426406] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.426420] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.426447] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.426453] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.426468] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.426495] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.426501] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.426540] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.426546] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.426561] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.426587] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.426592] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.426603] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.426622] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.426627] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.426654] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.426659] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.426670] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.426689] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.426692] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.426699] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.426711] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.426714] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.426721] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.426733] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.426737] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.426744] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.426755] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.426759] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.426766] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.426777] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.426780] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.426785] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.426793] pci_bus 0000:00: No. 5 try to assign unassigned res
[    0.426795] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.426795] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.426796] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.426797] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426799] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.426811] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426814] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.426826] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.426828] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.426839] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.426839] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.426840] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.426843] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.426866] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.426867] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.426869] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.426879] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.426882] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.426892] release child resource [mem 0xb1000000-0xb10fffff]
[    0.426893] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.426895] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.426906] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.426908] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.426916] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.426916] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.426917] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.426918] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426920] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.426930] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426932] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.426942] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.426944] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.426952] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.426952] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.426953] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.426956] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.426972] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.426973] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.426976] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.426983] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.426984] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.426986] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.426995] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.426997] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427002] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427003] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427004] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427006] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427011] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427013] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427019] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427021] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427027] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427029] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427034] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427037] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427043] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427045] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427049] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427050] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427053] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427056] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427057] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427058] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427061] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427067] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427068] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427069] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427071] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427075] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427076] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427078] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427090] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427094] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427097] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427099] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427102] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427106] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427109] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427112] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427120] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427122] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427125] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427128] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427133] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427148] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427164] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427168] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427173] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427179] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427194] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427197] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427201] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427209] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427225] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427229] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427237] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427240] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427243] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427246] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427249] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427252] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427254] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427257] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427260] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427263] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427266] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427269] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427271] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427274] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427277] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427280] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427283] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427289] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427296] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427302] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427314] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427318] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427325] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427332] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427332] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427332] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427332] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427332] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427332] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427332] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427332] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427332] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427332] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427332] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427332] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427332] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427332] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427332] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427332] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427332] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427332] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427332] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427332] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427332] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427332] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427332] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427332] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427332] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427332] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427332] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427332] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427332] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427332] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427332] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427332] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427332] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427332] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427332] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427332] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427332] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427332] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427332] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427332] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427332] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427332] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427332] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427332] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427332] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427332] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427332] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427332] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427332] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427332] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427332] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427332] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427332] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427332] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427332] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427332] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427332] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427332] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427332] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427332] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427332] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci_bus 0000:00: No. 6 try to assign unassigned res
[    0.427332] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427332] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427332] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427332] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427332] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427332] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427332] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427332] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427332] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427332] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427332] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427332] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427332] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427332] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427332] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427332] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427332] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427332] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427332] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427332] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427332] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427332] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427332] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427332] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427332] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427332] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427332] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427332] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427332] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427332] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427332] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427332] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427332] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427332] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427332] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427332] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427332] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427332] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427332] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427332] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427332] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427332] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427332] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427332] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427332] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427332] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427332] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427332] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427332] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427332] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427332] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427332] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427332] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427332] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427332] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427332] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427332] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427332] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427332] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427332] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427332] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427332] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427332] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427332] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427332] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427332] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427332] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427332] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427332] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427332] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427332] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427332] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427332] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427332] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427332] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427332] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427332] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427332] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427332] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427332] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427332] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427332] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427332] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427332] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427332] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427332] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427332] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427332] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427332] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427332] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427332] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427332] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427332] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427332] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427332] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427332] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427332] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427332] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427332] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427332] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427332] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427332] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427332] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427332] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427332] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427332] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427332] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427332] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427332] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427332] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427332] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427332] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427332] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427332] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427332] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427332] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427332] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427332] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427332] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427332] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427332] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427332] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427332] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427332] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427332] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427332] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427332] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427332] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427332] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427332] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427332] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427332] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427332] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427332] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427332] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427332] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427332] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427332] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427332] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427332] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427332] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427332] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427332] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427332] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427332] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427332] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427332] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427332] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427332] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427332] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427332] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427332] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427332] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427332] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427332] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427332] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427332] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427332] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427332] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci_bus 0000:00: No. 7 try to assign unassigned res
[    0.427332] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427332] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427332] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427332] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427332] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427332] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427332] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427332] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427332] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427332] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427332] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427332] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427332] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427332] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427332] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427332] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427332] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427332] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427332] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427332] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427332] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427332] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427332] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427332] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427332] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427332] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427332] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427332] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427332] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427332] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427332] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427332] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427332] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427332] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427332] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427332] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427332] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427332] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427332] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427332] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427332] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427332] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427332] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427332] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427332] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427332] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427332] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427332] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427332] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427332] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427332] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427332] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427332] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427332] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427332] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427332] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427332] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427332] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427332] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427332] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427332] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427332] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427332] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427332] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427332] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427332] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427332] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427332] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427332] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427332] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427332] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427332] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427332] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427332] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427332] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427332] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427332] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427332] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427332] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427332] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427332] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427332] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427332] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427332] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427332] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427332] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427332] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427332] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427332] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427332] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427332] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427332] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427332] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427332] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427332] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427332] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427332] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427332] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427332] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427332] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427332] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427332] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427332] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427332] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427332] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427332] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427332] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427332] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427332] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427332] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427332] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427332] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427332] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427332] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427332] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427332] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427332] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427332] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427332] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427332] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427332] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427332] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427332] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427332] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427332] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427332] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427332] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427332] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427332] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427332] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427332] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427332] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427332] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427332] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427332] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427332] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427332] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427332] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427332] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427332] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427332] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427332] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427332] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427332] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427332] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427332] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427332] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427332] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427332] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427332] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.427332] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.427332] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427332] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.427332] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.427332] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427332] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.427332] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427332] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.427332] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci_bus 0000:00: No. 8 try to assign unassigned res
[    0.427332] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.427332] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.427332] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.427332] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427332] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427332] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427332] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427332] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.427332] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427332] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427332] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427332] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.427332] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427332] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.427332] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.427332] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427332] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.427332] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427332] release child resource [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427332] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427332] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.427332] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427332] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.427332] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.427332] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.427332] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427332] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427332] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427332] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427332] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.427332] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427332] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427332] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427332] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.427332] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427332] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427332] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.427332] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427332] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427332] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427332] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.427332] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427332] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.427332] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.427332] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.427332] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427332] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.427332] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427332] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.427332] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427332] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.427332] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.427332] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427332] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.427332] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.427332] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.427332] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.427332] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427332] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427332] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427332] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.427332] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427332] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427332] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427332] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.427332] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427332] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427332] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.427332] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427332] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427332] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.427332] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.427332] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.427332] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.427332] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.427332] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.427332] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.427332] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.427332] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.427332] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.427332] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.427332] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.427332] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.427332] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.427332] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.427332] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.427332] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.427332] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.427332] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.427332] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.427332] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.427332] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.427332] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.427332] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.427332] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.427332] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.427332] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.427332] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.427332] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.427332] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.427332] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.427332] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.427332] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427332] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.427332] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427332] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427332] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.427332] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.427332] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.427332] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.427332] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.427332] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.427332] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.427332] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.427332] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.427332] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.427332] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.427332] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.427332] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.427332] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.427332] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.427332] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.427332] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427332] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.427332] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.427332] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.427332] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.427332] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.427332] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.427332] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.427332] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.427332] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.427332] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.427332] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.427332] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427332] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.427332] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.427332] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.427332] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.427332] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.427332] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.427332] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.427332] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.427332] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.427332] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.427332] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.427332] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.427332] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.427332] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.427332] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.427332] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.427332] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.427332] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.427332] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.427332] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.427332] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.427332] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.427332] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.427332] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.427332] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.427332] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.427332] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.433337] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.433350] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.433353] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.433360] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.433372] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.433376] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.433382] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.433394] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.433397] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.433402] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.433409] pci_bus 0000:00: No. 9 try to assign unassigned res
[    0.433412] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.433412] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.433413] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.433414] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433416] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.433428] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433431] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.433443] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.433446] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.433456] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.433457] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.433458] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.433460] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.433483] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.433484] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.433486] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.433497] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.433499] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.433509] release child resource [mem 0xb1000000-0xb10fffff]
[    0.433510] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.433512] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.433523] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.433525] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.433533] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.433534] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.433534] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.433535] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433537] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.433547] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433549] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.433559] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.433561] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.433569] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.433570] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.433571] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.433573] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.433589] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.433590] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.433593] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.433600] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.433601] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.433604] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.433612] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.433614] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.433619] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.433620] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.433621] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.433623] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.433628] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.433631] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.433636] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.433639] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.433644] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.433646] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.433651] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.433654] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.433660] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.433662] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.433666] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433667] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.433670] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433673] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.433674] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.433675] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.433678] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.433684] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.433685] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.433686] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.433688] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.433692] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.433693] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.433695] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.433715] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433721] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.433726] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.433730] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.433736] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.433740] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.433743] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.433752] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433760] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433763] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.433766] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.433769] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.433773] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.433789] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.433804] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.433809] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.433813] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.433820] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.433834] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.433837] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.433842] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.433850] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.433865] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.433870] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.433878] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.433881] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.433884] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.433887] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.433890] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.433893] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433895] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433898] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.433901] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.433904] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.433907] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.433910] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433912] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433915] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.433918] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.433921] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.433924] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.433931] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.433937] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.433944] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.433955] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.433959] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.433966] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.433978] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.433981] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.433983] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.433987] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.433989] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.433992] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.433995] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.433998] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.434000] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.434003] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.434006] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.434009] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.434011] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434014] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434017] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434020] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.434023] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.434033] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.434043] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.434053] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.434066] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434091] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.434104] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434129] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.434140] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.434160] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.434190] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.434220] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.434231] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.434238] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.434253] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.434283] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.434294] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.434313] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.434316] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.434319] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.434322] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434325] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.434327] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.434330] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.434333] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.434336] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434338] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434341] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.434344] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.434346] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.434349] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.434352] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434355] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.434358] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.434370] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.434383] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.434396] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.434413] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434446] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.434463] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434496] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.434510] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.434537] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.434577] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.434616] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.434631] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.434641] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.434661] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.434700] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.434715] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.434741] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.434748] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.434762] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.434789] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.434795] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.434834] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.434841] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.434855] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.434882] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.434886] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.434897] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.434916] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.434921] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.434949] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.434954] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.434964] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.434983] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.434987] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.434994] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.435005] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.435009] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.435016] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.435028] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.435031] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.435038] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.435050] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.435054] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.435060] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.435072] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.435075] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.435080] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.435088] pci_bus 0000:00: No. 10 try to assign unassigned res
[    0.435090] release child resource [mem 0xb0f00000-0xb0f00fff]
[    0.435090] release child resource [mem 0xb0f01000-0xb0f01fff]
[    0.435091] release child resource [mem 0xb0f02000-0xb0f020ff]
[    0.435092] pci 0000:22:03.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435094] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.435107] pci 0000:21:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435109] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.435121] pci 0000:20:00.0: resource 8 [mem 0xb0f00000-0xb0ffffff] released
[    0.435124] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.435134] release child resource [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.435135] release child resource [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.435136] pci 0000:20:01.0: resource 9 [mem 0xb1100000-0xb11fffff 64bit pref] released
[    0.435138] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.435161] release child resource [mem 0xb1200000-0xb1200fff 64bit]
[    0.435162] pci 0000:20:02.0: resource 8 [mem 0xb1200000-0xb12fffff] released
[    0.435164] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.435174] pci 0000:20:04.0: resource 8 [mem 0xb1300000-0xb92fffff] released
[    0.435177] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.435187] release child resource [mem 0xb1000000-0xb10fffff]
[    0.435188] pci 0000:1f:00.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.435190] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.435201] pci 0000:19:04.0: resource 8 [mem 0xb0f00000-0xc11fffff] released
[    0.435203] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.435211] release child resource [mem 0xb0b00000-0xb0b00fff]
[    0.435211] release child resource [mem 0xb0b01000-0xb0b01fff]
[    0.435212] release child resource [mem 0xb0b02000-0xb0b020ff]
[    0.435213] pci 0000:1b:03.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435215] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.435225] pci 0000:1a:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435227] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.435237] pci 0000:19:00.0: resource 8 [mem 0xb0b00000-0xb0bfffff] released
[    0.435239] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.435247] release child resource [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.435247] release child resource [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.435248] pci 0000:19:01.0: resource 9 [mem 0xb0d00000-0xb0dfffff 64bit pref] released
[    0.435251] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.435267] release child resource [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.435268] pci 0000:19:02.0: resource 8 [mem 0xb0e00000-0xb0efffff] released
[    0.435270] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.435278] release child resource [mem 0xb0c00000-0xb0cfffff]
[    0.435279] pci 0000:18:00.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.435281] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.435290] pci 0000:06:04.0: resource 8 [mem 0xb0b00000-0xc90fffff] released
[    0.435292] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.435297] release child resource [mem 0xa8a00000-0xa8a3ffff]
[    0.435298] release child resource [mem 0xa8a40000-0xa8a40fff]
[    0.435298] pci 0000:06:00.0: resource 8 [mem 0xa8a00000-0xa8afffff] released
[    0.435301] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.435306] pci 0000:06:03.0: resource 8 [mem 0xa8b00000-0xb0afffff] released
[    0.435308] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.435314] pci 0000:06:05.0: resource 8 [mem 0xc9100000-0xd10fffff] released
[    0.435316] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.435322] pci 0000:06:06.0: resource 8 [mem 0xd1100000-0xd90fffff] released
[    0.435324] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.435329] pci 0000:05:00.0: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.435331] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.435338] pci 0000:00:1c.4: resource 8 [mem 0xa8a00000-0xd90fffff] released
[    0.435340] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.435344] release child resource [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435345] pci 0000:00:01.0: resource 9 [mem 0x90000000-0x9fffffff 64bit pref] released
[    0.435347] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.435351] release child resource [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.435352] release child resource [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.435353] pci 0000:00:1c.0: resource 9 [mem 0x8f900000-0x8f9fffff 64bit pref] released
[    0.435355] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.435362] release child resource [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.435362] release child resource [mem 0x8fa20000-0x8fa2ffff pref]
[    0.435363] pci 0000:00:1c.1: resource 8 [mem 0x8fa00000-0x8fafffff] released
[    0.435366] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.435369] release child resource [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.435370] pci 0000:00:1c.2: resource 8 [mem 0x8fb00000-0x8fbfffff] released
[    0.435373] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.435385] pci 0000:00:01.0: BAR 9: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435389] pci 0000:00:1c.0: BAR 9: assigned [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.435392] pci 0000:00:1c.1: BAR 8: assigned [mem 0x8fa00000-0x8fafffff]
[    0.435395] pci 0000:00:1c.2: BAR 8: assigned [mem 0x8fb00000-0x8fbfffff]
[    0.435398] pci 0000:00:1c.4: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.435401] pci 0000:00:1c.4: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.435404] pci 0000:00:1c.4: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.435408] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435416] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.435418] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.435421] pci 0000:00:01.0:   bridge window [mem 0xa8800000-0xa88fffff]
[    0.435424] pci 0000:00:01.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.435428] pci 0000:02:00.0: BAR 0: assigned [mem 0x8f900000-0x8f90ffff 64bit pref]
[    0.435444] pci 0000:02:00.0: BAR 2: assigned [mem 0x8f910000-0x8f91ffff 64bit pref]
[    0.435459] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.435464] pci 0000:00:1c.0:   bridge window [mem 0xa8700000-0xa87fffff]
[    0.435468] pci 0000:00:1c.0:   bridge window [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.435475] pci 0000:03:00.0: BAR 0: assigned [mem 0x8fa00000-0x8fa1ffff 64bit]
[    0.435489] pci 0000:03:00.0: BAR 6: assigned [mem 0x8fa20000-0x8fa2ffff pref]
[    0.435492] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.435497] pci 0000:00:1c.1:   bridge window [mem 0x8fa00000-0x8fafffff]
[    0.435505] pci 0000:04:00.0: BAR 0: assigned [mem 0x8fb00000-0x8fb00fff 64bit]
[    0.435520] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.435525] pci 0000:00:1c.2:   bridge window [mem 0x8fb00000-0x8fbfffff]
[    0.435533] pci 0000:05:00.0: BAR 8: assigned [mem 0xa8a00000-0xd90fffff]
[    0.435536] pci 0000:05:00.0: BAR 9: no space for [mem size 0x180200000 64bit pref]
[    0.435538] pci 0000:05:00.0: BAR 9: failed to assign [mem size 0x180200000 64bit pref]
[    0.435542] pci 0000:06:00.0: BAR 8: assigned [mem 0xa8a00000-0xa8afffff]
[    0.435545] pci 0000:06:03.0: BAR 8: assigned [mem 0xa8b00000-0xb0afffff]
[    0.435547] pci 0000:06:03.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435550] pci 0000:06:03.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435553] pci 0000:06:04.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.435556] pci 0000:06:04.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.435559] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.435562] pci 0000:06:05.0: BAR 8: assigned [mem 0xc9100000-0xd10fffff]
[    0.435564] pci 0000:06:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435567] pci 0000:06:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435570] pci 0000:06:06.0: BAR 8: assigned [mem 0xd1100000-0xd90fffff]
[    0.435573] pci 0000:06:06.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435576] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435579] pci 0000:07:00.0: BAR 0: assigned [mem 0xa8a00000-0xa8a3ffff]
[    0.435586] pci 0000:07:00.0: BAR 1: assigned [mem 0xa8a40000-0xa8a40fff]
[    0.435592] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.435599] pci 0000:06:00.0:   bridge window [mem 0xa8a00000-0xa8afffff]
[    0.435610] pci 0000:06:03.0: PCI bridge to [bus 08-17]
[    0.435614] pci 0000:06:03.0:   bridge window [io  0x4000-0x4fff]
[    0.435621] pci 0000:06:03.0:   bridge window [mem 0xa8b00000-0xb0afffff]
[    0.435633] pci 0000:18:00.0: BAR 8: assigned [mem 0xb0b00000-0xc90fffff]
[    0.435636] pci 0000:18:00.0: BAR 9: no space for [mem size 0xc0200000 64bit pref]
[    0.435639] pci 0000:18:00.0: BAR 9: failed to assign [mem size 0xc0200000 64bit pref]
[    0.435642] pci 0000:19:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435645] pci 0000:19:01.0: BAR 8: assigned [mem 0xb0c00000-0xb0cfffff]
[    0.435648] pci 0000:19:01.0: BAR 9: assigned [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.435651] pci 0000:19:02.0: BAR 8: assigned [mem 0xb0e00000-0xb0efffff]
[    0.435653] pci 0000:19:04.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.435656] pci 0000:19:04.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.435659] pci 0000:19:04.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.435662] pci 0000:19:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.435664] pci 0000:19:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.435667] pci 0000:19:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435670] pci 0000:19:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435673] pci 0000:1a:00.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435675] pci 0000:1b:03.0: BAR 8: assigned [mem 0xb0b00000-0xb0bfffff]
[    0.435678] pci 0000:1c:00.0: BAR 0: assigned [mem 0xb0b00000-0xb0b00fff]
[    0.435688] pci 0000:1c:00.1: BAR 0: assigned [mem 0xb0b01000-0xb0b01fff]
[    0.435698] pci 0000:1c:00.2: BAR 0: assigned [mem 0xb0b02000-0xb0b020ff]
[    0.435708] pci 0000:1b:03.0: PCI bridge to [bus 1c]
[    0.435722] pci 0000:1b:03.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435746] pci 0000:1a:00.0: PCI bridge to [bus 1b-1c]
[    0.435760] pci 0000:1a:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435785] pci 0000:19:00.0: PCI bridge to [bus 1a-1c]
[    0.435795] pci 0000:19:00.0:   bridge window [mem 0xb0b00000-0xb0bfffff]
[    0.435815] pci 0000:1d:00.0: BAR 0: assigned [mem 0xb0d00000-0xb0d0ffff 64bit pref]
[    0.435845] pci 0000:1d:00.0: BAR 2: assigned [mem 0xb0d10000-0xb0d1ffff 64bit pref]
[    0.435875] pci 0000:19:01.0: PCI bridge to [bus 1d]
[    0.435886] pci 0000:19:01.0:   bridge window [mem 0xb0c00000-0xb0cfffff]
[    0.435894] pci 0000:19:01.0:   bridge window [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.435908] pci 0000:1e:00.0: BAR 0: assigned [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.435939] pci 0000:19:02.0: PCI bridge to [bus 1e]
[    0.435949] pci 0000:19:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.435969] pci 0000:1f:00.0: BAR 8: assigned [mem 0xb0f00000-0xc11fffff]
[    0.435971] pci 0000:1f:00.0: BAR 9: no space for [mem size 0x80100000 64bit pref]
[    0.435974] pci 0000:1f:00.0: BAR 9: failed to assign [mem size 0x80100000 64bit pref]
[    0.435977] pci 0000:20:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.435980] pci 0000:20:01.0: BAR 8: assigned [mem 0xb1000000-0xb10fffff]
[    0.435983] pci 0000:20:01.0: BAR 9: assigned [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.435986] pci 0000:20:02.0: BAR 8: assigned [mem 0xb1200000-0xb12fffff]
[    0.435988] pci 0000:20:04.0: BAR 8: assigned [mem 0xb1300000-0xb92fffff]
[    0.435991] pci 0000:20:04.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.435994] pci 0000:20:04.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.435997] pci 0000:20:05.0: BAR 8: no space for [mem size 0x08000000]
[    0.435999] pci 0000:20:05.0: BAR 8: failed to assign [mem size 0x08000000]
[    0.436002] pci 0000:20:05.0: BAR 9: no space for [mem size 0x40000000 64bit pref]
[    0.436005] pci 0000:20:05.0: BAR 9: failed to assign [mem size 0x40000000 64bit pref]
[    0.436008] pci 0000:21:00.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436011] pci 0000:22:03.0: BAR 8: assigned [mem 0xb0f00000-0xb0ffffff]
[    0.436013] pci 0000:23:00.0: BAR 0: assigned [mem 0xb0f00000-0xb0f00fff]
[    0.436026] pci 0000:23:00.1: BAR 0: assigned [mem 0xb0f01000-0xb0f01fff]
[    0.436039] pci 0000:23:00.2: BAR 0: assigned [mem 0xb0f02000-0xb0f020ff]
[    0.436051] pci 0000:22:03.0: PCI bridge to [bus 23]
[    0.436069] pci 0000:22:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436101] pci 0000:21:00.0: PCI bridge to [bus 22-23]
[    0.436119] pci 0000:21:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436151] pci 0000:20:00.0: PCI bridge to [bus 21-23]
[    0.436166] pci 0000:20:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.436193] pci 0000:24:00.0: BAR 0: assigned [mem 0xb1100000-0xb110ffff 64bit pref]
[    0.436232] pci 0000:24:00.0: BAR 2: assigned [mem 0xb1110000-0xb111ffff 64bit pref]
[    0.436272] pci 0000:20:01.0: PCI bridge to [bus 24]
[    0.436286] pci 0000:20:01.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.436297] pci 0000:20:01.0:   bridge window [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436316] pci 0000:25:00.0: BAR 0: assigned [mem 0xb1200000-0xb1200fff 64bit]
[    0.436356] pci 0000:20:02.0: PCI bridge to [bus 25]
[    0.436370] pci 0000:20:02.0:   bridge window [mem 0xb1200000-0xb12fffff]
[    0.436397] pci 0000:20:04.0: PCI bridge to [bus 26-35]
[    0.436403] pci 0000:20:04.0:   bridge window [io  0x5000-0x5fff]
[    0.436417] pci 0000:20:04.0:   bridge window [mem 0xb1300000-0xb92fffff]
[    0.436444] pci 0000:20:05.0: PCI bridge to [bus 36-45]
[    0.436450] pci 0000:20:05.0:   bridge window [io  0x6000-0x6fff]
[    0.436490] pci 0000:1f:00.0: PCI bridge to [bus 20-45]
[    0.436496] pci 0000:1f:00.0:   bridge window [io  0x5000-0x6fff]
[    0.436510] pci 0000:1f:00.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.436537] pci 0000:19:04.0: PCI bridge to [bus 1f-45]
[    0.436542] pci 0000:19:04.0:   bridge window [io  0x5000-0x7fff]
[    0.436552] pci 0000:19:04.0:   bridge window [mem 0xb0f00000-0xc11fffff]
[    0.436572] pci 0000:19:05.0: PCI bridge to [bus 46-55]
[    0.436577] pci 0000:19:05.0:   bridge window [io  0x8000-0x8fff]
[    0.436604] pci 0000:18:00.0: PCI bridge to [bus 19-55]
[    0.436609] pci 0000:18:00.0:   bridge window [io  0x5000-0x8fff]
[    0.436619] pci 0000:18:00.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.436638] pci 0000:06:04.0: PCI bridge to [bus 18-55]
[    0.436642] pci 0000:06:04.0:   bridge window [io  0x5000-0x9fff]
[    0.436649] pci 0000:06:04.0:   bridge window [mem 0xb0b00000-0xc90fffff]
[    0.436661] pci 0000:06:05.0: PCI bridge to [bus 56-65]
[    0.436664] pci 0000:06:05.0:   bridge window [io  0xa000-0xafff]
[    0.436671] pci 0000:06:05.0:   bridge window [mem 0xc9100000-0xd10fffff]
[    0.436683] pci 0000:06:06.0: PCI bridge to [bus 66-75]
[    0.436686] pci 0000:06:06.0:   bridge window [io  0xb000-0xbfff]
[    0.436693] pci 0000:06:06.0:   bridge window [mem 0xd1100000-0xd90fffff]
[    0.436705] pci 0000:05:00.0: PCI bridge to [bus 06-75]
[    0.436709] pci 0000:05:00.0:   bridge window [io  0x4000-0xbfff]
[    0.436715] pci 0000:05:00.0:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.436726] pci 0000:00:1c.4: PCI bridge to [bus 05-75]
[    0.436729] pci 0000:00:1c.4:   bridge window [io  0x4000-0xbfff]
[    0.436734] pci 0000:00:1c.4:   bridge window [mem 0xa8a00000-0xd90fffff]
[    0.436742] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.436745] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.436747] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.436750] pci_bus 0000:00: resource 7 [mem 0x8f900000-0xfeafffff window]
[    0.436752] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff window]
[    0.436755] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.436757] pci_bus 0000:01: resource 1 [mem 0xa8800000-0xa88fffff]
[    0.436759] pci_bus 0000:01: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.436762] pci_bus 0000:02: resource 1 [mem 0xa8700000-0xa87fffff]
[    0.436765] pci_bus 0000:02: resource 2 [mem 0x8f900000-0x8f9fffff 64bit pref]
[    0.436767] pci_bus 0000:03: resource 1 [mem 0x8fa00000-0x8fafffff]
[    0.436770] pci_bus 0000:04: resource 1 [mem 0x8fb00000-0x8fbfffff]
[    0.436772] pci_bus 0000:05: resource 0 [io  0x4000-0xbfff]
[    0.436774] pci_bus 0000:05: resource 1 [mem 0xa8a00000-0xd90fffff]
[    0.436777] pci_bus 0000:06: resource 0 [io  0x4000-0xbfff]
[    0.436779] pci_bus 0000:06: resource 1 [mem 0xa8a00000-0xd90fffff]
[    0.436781] pci_bus 0000:07: resource 1 [mem 0xa8a00000-0xa8afffff]
[    0.436784] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    0.436786] pci_bus 0000:08: resource 1 [mem 0xa8b00000-0xb0afffff]
[    0.436788] pci_bus 0000:18: resource 0 [io  0x5000-0x9fff]
[    0.436790] pci_bus 0000:18: resource 1 [mem 0xb0b00000-0xc90fffff]
[    0.436793] pci_bus 0000:19: resource 0 [io  0x5000-0x8fff]
[    0.436795] pci_bus 0000:19: resource 1 [mem 0xb0b00000-0xc90fffff]
[    0.436797] pci_bus 0000:1a: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436799] pci_bus 0000:1b: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436802] pci_bus 0000:1c: resource 1 [mem 0xb0b00000-0xb0bfffff]
[    0.436804] pci_bus 0000:1d: resource 1 [mem 0xb0c00000-0xb0cfffff]
[    0.436806] pci_bus 0000:1d: resource 2 [mem 0xb0d00000-0xb0dfffff 64bit pref]
[    0.436809] pci_bus 0000:1e: resource 1 [mem 0xb0e00000-0xb0efffff]
[    0.436812] pci_bus 0000:1f: resource 0 [io  0x5000-0x7fff]
[    0.436814] pci_bus 0000:1f: resource 1 [mem 0xb0f00000-0xc11fffff]
[    0.436816] pci_bus 0000:20: resource 0 [io  0x5000-0x6fff]
[    0.436818] pci_bus 0000:20: resource 1 [mem 0xb0f00000-0xc11fffff]
[    0.436821] pci_bus 0000:21: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436823] pci_bus 0000:22: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436825] pci_bus 0000:23: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.436827] pci_bus 0000:24: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.436830] pci_bus 0000:24: resource 2 [mem 0xb1100000-0xb11fffff 64bit pref]
[    0.436833] pci_bus 0000:25: resource 1 [mem 0xb1200000-0xb12fffff]
[    0.436835] pci_bus 0000:26: resource 0 [io  0x5000-0x5fff]
[    0.436837] pci_bus 0000:26: resource 1 [mem 0xb1300000-0xb92fffff]
[    0.436839] pci_bus 0000:36: resource 0 [io  0x6000-0x6fff]
[    0.436842] pci_bus 0000:46: resource 0 [io  0x8000-0x8fff]
[    0.436844] pci_bus 0000:56: resource 0 [io  0xa000-0xafff]
[    0.436846] pci_bus 0000:56: resource 1 [mem 0xc9100000-0xd10fffff]
[    0.436848] pci_bus 0000:66: resource 0 [io  0xb000-0xbfff]
[    0.436851] pci_bus 0000:66: resource 1 [mem 0xd1100000-0xd90fffff]
[    0.437285] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.437301] pci 0000:05:00.0: CLS mismatch (256 != 128), using 64 bytes
[    0.437316] pci 0000:1c:00.0: MSI is not implemented on this device, disabling it
[    0.437318] pci 0000:1c:00.0: PME# is unreliable, disabling it
[    0.437613] pci 0000:1c:00.1: MSI is not implemented on this device, disabling it
[    0.437617] pci 0000:1c:00.1: PME# is unreliable, disabling it
[    0.437695] pci 0000:1c:00.2: MSI is not implemented on this device, disabling it
[    0.437698] pci 0000:1c:00.2: PME# is unreliable, disabling it
[    0.437753] pci 0000:1c:00.2: EHCI: unrecognized capability 00
[    0.437792] pci 0000:23:00.0: MSI is not implemented on this device, disabling it
[    0.437795] pci 0000:23:00.0: PME# is unreliable, disabling it
[    0.438049] pci 0000:23:00.1: MSI is not implemented on this device, disabling it
[    0.438052] pci 0000:23:00.1: PME# is unreliable, disabling it
[    0.438146] pci 0000:23:00.2: MSI is not implemented on this device, disabling it
[    0.438149] pci 0000:23:00.2: PME# is unreliable, disabling it
[    0.438216] pci 0000:23:00.2: EHCI: unrecognized capability 00
[    0.438255] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.438258] software IO TLB: mapped [mem 0x0000000083000000-0x0000000087000000] (64MB)
[    0.438266] ACPI: bus type thunderbolt registered
[    0.438294] Trying to unpack rootfs image as initramfs...
[    0.438349] thunderbolt 0000:07:00.0: total paths: 32
[    0.438524] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.438544] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.438556] thunderbolt 0000:07:00.0: control channel created
[    0.438559] thunderbolt 0000:07:00.0: ICM not supported on this controller
[    0.438568] thunderbolt 0000:07:00.0: freeing RX ring 0
[    0.438575] thunderbolt 0000:07:00.0: freeing TX ring 0
[    0.438585] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.438593] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.438601] thunderbolt 0000:07:00.0: control channel created
[    0.438603] thunderbolt 0000:07:00.0: using software connection manager
[    0.438618] thunderbolt 0000:07:00.0: created link from 0000:06:03.0
[    0.438643] thunderbolt 0000:07:00.0: created link from 0000:06:04.0
[    0.438656] thunderbolt 0000:07:00.0: created link from 0000:06:05.0
[    0.438669] thunderbolt 0000:07:00.0: created link from 0000:06:06.0
[    0.438723] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[    0.438724] thunderbolt 0000:07:00.0: control channel starting...
[    0.438726] thunderbolt 0000:07:00.0: starting TX ring 0
[    0.438734] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.438736] thunderbolt 0000:07:00.0: starting RX ring 0
[    0.438744] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38204 bit 0 (0x0 -> 0x1)
[    0.438747] thunderbolt 0000:07:00.0: security level set to user
[    0.438901] thunderbolt 0000:07:00.0: current switch config:
[    0.438903] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.438905] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.438906] thunderbolt 0000:07:00.0:   Config:
[    0.438907] thunderbolt 0000:07:00.0:    Upstream Port Number: 6 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.438909] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.465828] thunderbolt 0000:07:00.0: initializing Switch at 0x0 (depth: 0, up port: 6)
[    0.466338] thunderbolt 0000:07:00.0: 0: DROM version: 1
[    0.467873] thunderbolt 0000:07:00.0: 0: uid: 0x1000a13f2da20
[    0.470817] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.470819] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.470820] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.470821] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.470822] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.473760] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.473762] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.473763] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.473764] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.473765] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.476704] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.476706] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.476707] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.476708] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.476709] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.477344] random: fast init done
[    0.479648] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    0.479650] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    0.479651] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.479652] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.479653] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.479654] thunderbolt 0000:07:00.0: 0:5: disabled by eeprom
[    0.480544] thunderbolt 0000:07:00.0:  Port 6: 8086:1513 (Revision: 2, TB Version: 1, Type: NHI (0x2))
[    0.480546] thunderbolt 0000:07:00.0:   Max hop id (in/out): 31/31
[    0.480547] thunderbolt 0000:07:00.0:   Max counters: 32
[    0.480548] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.480549] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.481440] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.481442] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.481443] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.481444] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.481445] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.482336] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.482338] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.482339] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.482340] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.482341] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.483232] thunderbolt 0000:07:00.0:  Port 9: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.483234] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.483235] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.483236] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.483237] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.484128] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    0.484130] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.484131] thunderbolt 0000:07:00.0:   Max counters: 1
[    0.484132] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.484133] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.485280] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    0.485283] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.485284] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.485284] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.485285] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.486176] thunderbolt 0000:07:00.0:  Port 12: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.486178] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.486179] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.486180] thunderbolt 0000:07:00.0:   NFC Credits: 0x700005
[    0.486181] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.487072] thunderbolt 0000:07:00.0:  Port 13: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.487074] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.487075] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.487076] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.487076] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.502670] thunderbolt 0000:07:00.0: 0: TMU: current mode: HiFi
[    0.502798] thunderbolt 0000:07:00.0: 0:1: is connected, link is up (state: 2)
[    0.503053] thunderbolt 0000:07:00.0: current switch config:
[    0.503054] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.503056] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.503057] thunderbolt 0000:07:00.0:   Config:
[    0.503058] thunderbolt 0000:07:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x1 Enabled: 1, PlugEventsDelay: 255ms
[    0.503059] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.507661] thunderbolt 0000:07:00.0: initializing Switch at 0x1 (depth: 1, up port: 1)
[    0.525070] thunderbolt 0000:07:00.0: 1: reading drom (length: 0x97)
[    0.706007] Freeing initrd memory: 27980K
[    1.036514] thunderbolt 0000:07:00.0: 1: DROM version: 1
[    1.037538] thunderbolt 0000:07:00.0: 1: uid: 0x1000100189170
[    1.040481] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.040485] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.040488] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.040490] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.040492] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.043425] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.043429] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.043431] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.043433] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c0000e
[    1.043435] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.046368] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.046372] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.046374] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.046376] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.046378] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.049312] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.049316] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.049318] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.049320] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.049322] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.049324] thunderbolt 0000:07:00.0: 1:5: disabled by eeprom
[    1.049326] thunderbolt 0000:07:00.0: 1:6: disabled by eeprom
[    1.050208] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.050212] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.050214] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.050216] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.050218] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.051104] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.051108] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.051110] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.051112] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.051114] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.051116] thunderbolt 0000:07:00.0: 1:9: disabled by eeprom
[    1.052000] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.052004] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.052006] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.052008] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.052010] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.053152] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.053156] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.053158] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.053160] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.053162] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.053164] thunderbolt 0000:07:00.0: 1:c: disabled by eeprom
[    1.053166] thunderbolt 0000:07:00.0: 1:d: disabled by eeprom
[    1.071082] thunderbolt 0000:07:00.0: 1: TMU: current mode: bi-directional, HiFi
[    1.071113] thunderbolt 0-1: new device found, vendor=0x1 device=0x8002
[    1.071120] thunderbolt 0-1: Apple, Inc. Thunderbolt Display
[    1.071218] thunderbolt 0000:07:00.0: 1:3: is connected, link is up (state: 2)
[    1.071477] thunderbolt 0000:07:00.0: current switch config:
[    1.071479] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    1.071483] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    1.071485] thunderbolt 0000:07:00.0:   Config:
[    1.071487] thunderbolt 0000:07:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x301 Enabled: 1, PlugEventsDelay: 255ms
[    1.071490] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.076086] thunderbolt 0000:07:00.0: initializing Switch at 0x301 (depth: 2, up port: 3)
[    1.093492] thunderbolt 0000:07:00.0: 301: reading drom (length: 0x97)
[    1.553515] random: crng init done
[    1.587179] thunderbolt 0000:07:00.0: 301: DROM version: 1
[    1.588203] thunderbolt 0000:07:00.0: 301: uid: 0x100010102a740
[    1.591146] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.591150] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.591153] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.591155] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.591157] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.594090] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.594094] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.594096] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.594098] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.594100] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.597034] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.597038] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.597040] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.597042] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.597044] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.599978] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.599981] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.599984] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.599985] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.599987] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.599989] thunderbolt 0000:07:00.0: 301:5: disabled by eeprom
[    1.599992] thunderbolt 0000:07:00.0: 301:6: disabled by eeprom
[    1.600874] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.600878] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.600880] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.600882] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.600884] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.601770] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.601773] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.601776] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.601777] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.601779] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.601781] thunderbolt 0000:07:00.0: 301:9: disabled by eeprom
[    1.602666] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.602670] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.602672] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.602674] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.602676] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.603818] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.603822] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.603824] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.603826] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.603828] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.603830] thunderbolt 0000:07:00.0: 301:c: disabled by eeprom
[    1.603832] thunderbolt 0000:07:00.0: 301:d: disabled by eeprom
[    1.622089] thunderbolt 0000:07:00.0: 301: TMU: current mode: bi-directional, HiFi
[    1.622110] thunderbolt 0-301: new device found, vendor=0x1 device=0x8002
[    1.622118] thunderbolt 0-301: Apple, Inc. Thunderbolt Display
[    1.622214] thunderbolt 0000:07:00.0: 301:1: is unplugged (state: 7)
[    1.622472] thunderbolt 0000:07:00.0: 301:b: DP adapter HPD set, queuing hotplug
[    1.622856] thunderbolt 0000:07:00.0: 0:3: is unplugged (state: 7)
[    1.623369] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 0:7
[    1.623497] thunderbolt 0000:07:00.0: 0:7:  In HopID: 8 => Out port: 1 Out HopID: 8
[    1.623501] thunderbolt 0000:07:00.0: 0:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.623504] thunderbolt 0000:07:00.0: 0:7:    Counter enabled: 1 Counter index: 0
[    1.623507] thunderbolt 0000:07:00.0: 0:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.623510] thunderbolt 0000:07:00.0: 0:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.623625] thunderbolt 0000:07:00.0: 1:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.623628] thunderbolt 0000:07:00.0: 1:1:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.623631] thunderbolt 0000:07:00.0: 1:1:    Counter enabled: 1 Counter index: 0
[    1.623633] thunderbolt 0000:07:00.0: 1:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.623636] thunderbolt 0000:07:00.0: 1:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.623639] thunderbolt 0000:07:00.0: path discovery complete
[    1.624136] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 1:10
[    1.624265] thunderbolt 0000:07:00.0: 1:a:  In HopID: 8 => Out port: 1 Out HopID: 8
[    1.624268] thunderbolt 0000:07:00.0: 1:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.624271] thunderbolt 0000:07:00.0: 1:a:    Counter enabled: 1 Counter index: 0
[    1.624273] thunderbolt 0000:07:00.0: 1:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.624276] thunderbolt 0000:07:00.0: 1:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.624393] thunderbolt 0000:07:00.0: 0:1:  In HopID: 8 => Out port: 7 Out HopID: 8
[    1.624396] thunderbolt 0000:07:00.0: 0:1:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.624398] thunderbolt 0000:07:00.0: 0:1:    Counter enabled: 1 Counter index: 0
[    1.624401] thunderbolt 0000:07:00.0: 0:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.624404] thunderbolt 0000:07:00.0: 0:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.624407] thunderbolt 0000:07:00.0: path discovery complete
[    1.624520] thunderbolt 0000:07:00.0: 0:7 <-> 1:a (PCI): discovered
[    1.625288] thunderbolt 0000:07:00.0: discovering Video path starting from 0:12
[    1.625417] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 2 Out HopID: 9
[    1.625420] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 2 Drop: 0
[    1.625423] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 1 Counter index: 0
[    1.625425] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.625428] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.625545] thunderbolt 0000:07:00.0: 1:2:  In HopID: 9 => Out port: 11 Out HopID: 9
[    1.625548] thunderbolt 0000:07:00.0: 1:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.625550] thunderbolt 0000:07:00.0: 1:2:    Counter enabled: 1 Counter index: 0
[    1.625553] thunderbolt 0000:07:00.0: 1:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.625556] thunderbolt 0000:07:00.0: 1:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.625558] thunderbolt 0000:07:00.0: path discovery complete
[    1.625803] thunderbolt 0000:07:00.0: discovering AUX TX path starting from 0:12
[    1.625929] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 2 Out HopID: 8
[    1.625932] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.625935] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 1 Counter index: 1
[    1.625937] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.625940] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.626057] thunderbolt 0000:07:00.0: 1:2:  In HopID: 8 => Out port: 11 Out HopID: 8
[    1.626060] thunderbolt 0000:07:00.0: 1:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.626062] thunderbolt 0000:07:00.0: 1:2:    Counter enabled: 1 Counter index: 1
[    1.626065] thunderbolt 0000:07:00.0: 1:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.626068] thunderbolt 0000:07:00.0: 1:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.626070] thunderbolt 0000:07:00.0: path discovery complete
[    1.626568] thunderbolt 0000:07:00.0: discovering AUX RX path starting from 1:11
[    1.626697] thunderbolt 0000:07:00.0: 1:b:  In HopID: 8 => Out port: 2 Out HopID: 8
[    1.626700] thunderbolt 0000:07:00.0: 1:b:   Weight: 1 Priority: 2 Credits: 7 Drop: 0
[    1.626702] thunderbolt 0000:07:00.0: 1:b:    Counter enabled: 1 Counter index: 0
[    1.626705] thunderbolt 0000:07:00.0: 1:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.626708] thunderbolt 0000:07:00.0: 1:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.626824] thunderbolt 0000:07:00.0: 0:2:  In HopID: 8 => Out port: 12 Out HopID: 8
[    1.626827] thunderbolt 0000:07:00.0: 0:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.626830] thunderbolt 0000:07:00.0: 0:2:    Counter enabled: 1 Counter index: 0
[    1.626833] thunderbolt 0000:07:00.0: 0:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.626836] thunderbolt 0000:07:00.0: 0:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.626838] thunderbolt 0000:07:00.0: path discovery complete
[    1.627080] thunderbolt 0000:07:00.0: 0:c <-> 1:b (DP): discovered
[    1.627592] thunderbolt 0000:07:00.0: discovering PCIe Up path starting from 1:7
[    1.627720] thunderbolt 0000:07:00.0: 1:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.627723] thunderbolt 0000:07:00.0: 1:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.627726] thunderbolt 0000:07:00.0: 1:7:    Counter enabled: 1 Counter index: 0
[    1.627729] thunderbolt 0000:07:00.0: 1:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.627732] thunderbolt 0000:07:00.0: 1:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.627848] thunderbolt 0000:07:00.0: 301:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[    1.627851] thunderbolt 0000:07:00.0: 301:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.627854] thunderbolt 0000:07:00.0: 301:3:    Counter enabled: 1 Counter index: 0
[    1.627857] thunderbolt 0000:07:00.0: 301:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.627860] thunderbolt 0000:07:00.0: 301:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.627863] thunderbolt 0000:07:00.0: path discovery complete
[    1.628360] thunderbolt 0000:07:00.0: discovering PCIe Down path starting from 301:10
[    1.628488] thunderbolt 0000:07:00.0: 301:a:  In HopID: 8 => Out port: 3 Out HopID: 8
[    1.628491] thunderbolt 0000:07:00.0: 301:a:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.628494] thunderbolt 0000:07:00.0: 301:a:    Counter enabled: 1 Counter index: 0
[    1.628497] thunderbolt 0000:07:00.0: 301:a:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.628500] thunderbolt 0000:07:00.0: 301:a:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.628616] thunderbolt 0000:07:00.0: 1:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[    1.628619] thunderbolt 0000:07:00.0: 1:3:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[    1.628622] thunderbolt 0000:07:00.0: 1:3:    Counter enabled: 1 Counter index: 0
[    1.628625] thunderbolt 0000:07:00.0: 1:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.628628] thunderbolt 0000:07:00.0: 1:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.628630] thunderbolt 0000:07:00.0: path discovery complete
[    1.628744] thunderbolt 0000:07:00.0: 1:7 <-> 301:a (PCI): discovered
[    1.629131] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.629133] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
[    1.629255] thunderbolt 0000:07:00.0: 301:b: DP OUT resource available
[    1.629258] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[    1.629316] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
[    1.629320] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    1.629322] RAPL PMU: hw unit of domain package 2^-16 Joules
[    1.629324] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[    1.629387] thunderbolt 0000:07:00.0: 0:c: in use
[    1.629513] thunderbolt 0000:07:00.0: 0:d: DP IN available
[    1.629640] thunderbolt 0000:07:00.0: 301:b: DP OUT available
[    1.629644] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 13
[    1.629646] thunderbolt 0000:07:00.0: 301:b: calculating available bandwidth
[    1.629708] Initialise system trusted keyrings
[    1.629730] workingset: timestamp_bits=62 max_order=23 bucket_order=0
[    1.629766] thunderbolt 0000:07:00.0: 0:1: link total bandwidth 9000 Mb/s
[    1.629768] thunderbolt 0000:07:00.0: 1:1: link total bandwidth 9000 Mb/s
[    1.629892] thunderbolt 0000:07:00.0: 1:3: link total bandwidth 9000 Mb/s
[    1.629894] thunderbolt 0000:07:00.0: 301:3: link total bandwidth 9000 Mb/s
[    1.629895] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    1.629900] thunderbolt 0000:07:00.0: 0:d <-> 301:b (DP): activating
[    1.629901] thunderbolt 0000:07:00.0: activating Video path from 0:13 to 301:11
[    1.629903] thunderbolt 0000:07:00.0: 301:4: adding 12 NFC credits to 0
[    1.630021] thunderbolt 0000:07:00.0: 1:2: adding 12 NFC credits to 14
[    1.630148] thunderbolt 0000:07:00.0: 0:d: adding 5 NFC credits to 0
[    1.630404] thunderbolt 0000:07:00.0: 301:4: Writing hop 2
[    1.630406] thunderbolt 0000:07:00.0: 301:4:  In HopID: 8 => Out port: 11 Out HopID: 9
[    1.630407] thunderbolt 0000:07:00.0: 301:4:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.630409] thunderbolt 0000:07:00.0: 301:4:    Counter enabled: 0 Counter index: 2047
[    1.630411] thunderbolt 0000:07:00.0: 301:4:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.630412] thunderbolt 0000:07:00.0: 301:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.630436] Key type asymmetric registered
[    1.630439] Asymmetric key parser 'x509' registered
[    1.630450] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    1.630662] thunderbolt 0000:07:00.0: 1:2: Writing hop 1
[    1.630663] thunderbolt 0000:07:00.0: 1:2:  In HopID: 10 => Out port: 4 Out HopID: 8
[    1.630665] thunderbolt 0000:07:00.0: 1:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.630666] thunderbolt 0000:07:00.0: 1:2:    Counter enabled: 0 Counter index: 2047
[    1.630667] thunderbolt 0000:07:00.0: 1:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.630669] thunderbolt 0000:07:00.0: 1:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.630917] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[    1.630919] thunderbolt 0000:07:00.0: 0:d:  In HopID: 9 => Out port: 2 Out HopID: 10
[    1.630920] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.630921] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[    1.630923] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.630924] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.631045] thunderbolt 0000:07:00.0: path activation complete
[    1.631046] thunderbolt 0000:07:00.0: activating AUX TX path from 0:13 to 301:11
[    1.631173] thunderbolt 0000:07:00.0: 301:4: Writing hop 2
[    1.631175] thunderbolt 0000:07:00.0: 301:4:  In HopID: 9 => Out port: 11 Out HopID: 8
[    1.631176] thunderbolt 0000:07:00.0: 301:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.631177] thunderbolt 0000:07:00.0: 301:4:    Counter enabled: 0 Counter index: 2047
[    1.631179] thunderbolt 0000:07:00.0: 301:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.631180] thunderbolt 0000:07:00.0: 301:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.631247] pcieport 0000:06:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.631429] thunderbolt 0000:07:00.0: 1:2: Writing hop 1
[    1.631431] thunderbolt 0000:07:00.0: 1:2:  In HopID: 11 => Out port: 4 Out HopID: 9
[    1.631432] thunderbolt 0000:07:00.0: 1:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.631434] thunderbolt 0000:07:00.0: 1:2:    Counter enabled: 0 Counter index: 2047
[    1.631435] thunderbolt 0000:07:00.0: 1:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.631436] thunderbolt 0000:07:00.0: 1:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.631459] pcieport 0000:06:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.631685] thunderbolt 0000:07:00.0: 0:d: Writing hop 0
[    1.631685] pcieport 0000:06:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.631686] thunderbolt 0000:07:00.0: 0:d:  In HopID: 8 => Out port: 2 Out HopID: 11
[    1.631688] thunderbolt 0000:07:00.0: 0:d:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.631692] thunderbolt 0000:07:00.0: 0:d:    Counter enabled: 0 Counter index: 2047
[    1.631693] thunderbolt 0000:07:00.0: 0:d:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.631695] thunderbolt 0000:07:00.0: 0:d:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.631813] thunderbolt 0000:07:00.0: path activation complete
[    1.631814] thunderbolt 0000:07:00.0: activating AUX RX path from 301:11 to 0:13
[    1.631902] pcieport 0000:06:06.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.631941] thunderbolt 0000:07:00.0: 0:2: Writing hop 2
[    1.631943] thunderbolt 0000:07:00.0: 0:2:  In HopID: 9 => Out port: 13 Out HopID: 8
[    1.631944] thunderbolt 0000:07:00.0: 0:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.631945] thunderbolt 0000:07:00.0: 0:2:    Counter enabled: 0 Counter index: 2047
[    1.631947] thunderbolt 0000:07:00.0: 0:2:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.631948] thunderbolt 0000:07:00.0: 0:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.632197] thunderbolt 0000:07:00.0: 1:4: Writing hop 1
[    1.632198] thunderbolt 0000:07:00.0: 1:4:  In HopID: 8 => Out port: 2 Out HopID: 9
[    1.632199] thunderbolt 0000:07:00.0: 1:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.632201] thunderbolt 0000:07:00.0: 1:4:    Counter enabled: 0 Counter index: 2047
[    1.632202] thunderbolt 0000:07:00.0: 1:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.632203] thunderbolt 0000:07:00.0: 1:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.632452] thunderbolt 0000:07:00.0: 301:b: Writing hop 0
[    1.632454] thunderbolt 0000:07:00.0: 301:b:  In HopID: 8 => Out port: 4 Out HopID: 8
[    1.632455] thunderbolt 0000:07:00.0: 301:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.632456] thunderbolt 0000:07:00.0: 301:b:    Counter enabled: 0 Counter index: 2047
[    1.632458] thunderbolt 0000:07:00.0: 301:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.632459] thunderbolt 0000:07:00.0: 301:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.632580] thunderbolt 0000:07:00.0: path activation complete
[    1.633249] pcieport 0000:19:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.633469] pcieport 0000:19:05.0: enabling device (0000 -> 0001)
[    1.633567] pcieport 0000:19:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.635468] pcieport 0000:20:04.0: enabling device (0000 -> 0003)
[    1.635591] pcieport 0000:20:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.635886] pcieport 0000:20:05.0: enabling device (0000 -> 0001)
[    1.636009] pcieport 0000:20:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.645047] brd: module loaded
[    1.645327] Intel(R) 2.5G Ethernet Linux Driver
[    1.645333] Copyright(c) 2018 Intel Corporation.
[    1.645377] i8042: PNP: No PS/2 controller found.
[    1.645418] mousedev: PS/2 mouse device common for all mice
[    1.645486] intel_pstate: Intel P-state driver initializing
[    1.645605] efifb: probing for efifb
[    1.645621] efifb: framebuffer at 0x90010000, using 14400k, total 14400k
[    1.645623] efifb: mode is 2560x1440x32, linelength=10240, pages=1
[    1.645626] efifb: scrolling: redraw
[    1.645627] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.655131] Console: switching to colour frame buffer device 320x90
[    1.664219] fb0: EFI VGA frame buffer device
[    1.664309] Key type dns_resolver registered
[    1.664365] microcode: sig=0x206a7, pf=0x2, revision=0x2f
[    1.664536] microcode: Microcode Update Driver: v2.2.
[    1.664538] IPI shorthand broadcast: enabled
[    1.664583] sched_clock: Marking stable (1664120354, 412859)->(1676496884, -11963671)
[    1.664678] registered taskstats version 1
[    1.664695] Loading compiled-in X.509 certificates
[    1.665188] Freeing unused kernel image (initmem) memory: 956K
[    1.803496] Write protecting the kernel read-only data: 12288k
[    1.804128] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.804258] Freeing unused kernel image (rodata/data gap) memory: 188K
[    1.804288] Run /init as init process
[    1.804303]   with arguments:
[    1.804304]     /init
[    1.804305]   with environment:
[    1.804305]     HOME=/
[    1.804306]     TERM=linux
[    1.804307]     netconsole=6666@192.168.2.87/eth0,6666@192.168.2.208/dc:a6:32:61:33:da
[    1.847610] udevd[875]: starting version 3.2.9
[    1.848303] udevd[876]: starting eudev-3.2.9
[    1.862905] ACPI: bus type USB registered
[    1.862968] usbcore: registered new interface driver usbfs
[    1.863001] usbcore: registered new interface driver hub
[    1.863035] usbcore: registered new device driver usb
[    1.864655] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.864685] ACPI: bus type drm_connector registered
[    1.864940] ehci-pci: EHCI PCI platform driver
[    1.865152] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    1.865184] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    1.865236] ehci-pci 0000:00:1a.7: debug port 2
[    1.865341] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.865679] uhci_hcd: USB Universal Host Controller Interface driver
[    1.869197] ehci-pci 0000:00:1a.7: irq 23, io mem 0xa8906c00
[    1.869371] ahci 0000:00:1f.2: version 3.0
[    1.870459] cryptd: max_cpu_qlen set to 1000
[    1.871703] AVX version of gcm_enc/dec engaged.
[    1.871738] AES CTR mode by8 optimization enabled
[    1.876635] radeon: unknown parameter 'pm' ignored
[    1.876745] [drm] radeon kernel modesetting enabled.
[    1.876797] checking generic (90010000 e10000) vs hw (90000000 10000000)
[    1.876798] fb0: switching to radeon from EFI VGA
[    1.876891] Console: switching to colour dummy device 80x25
[    1.876951] radeon 0000:01:00.0: vgaarb: deactivate vga console
[    1.877179] [drm] initializing kernel modesetting (BARTS 0x1002:0x6720 0x106B:0x0B00 0x00).
[    1.877184] radeon 0000:01:00.0: vram limit (0) must be a power of 2
[    1.879877] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x7 impl SATA mode
[    1.879885] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst
[    1.893409] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.893634] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.893642] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.893648] usb usb1: Product: EHCI Host Controller
[    1.893652] usb usb1: Manufacturer: Linux 5.17.0+ ehci_hcd
[    1.893656] usb usb1: SerialNumber: 0000:00:1a.7
[    1.893871] hub 1-0:1.0: USB hub found
[    1.893887] hub 1-0:1.0: 6 ports detected
[    1.894216] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.894227] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 2
[    1.894270] uhci_hcd 0000:00:1a.0: detected 2 ports
[    1.894434] uhci_hcd 0000:00:1a.0: irq 21, io port 0x00003140
[    1.894587] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    1.894603] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.894642] usb usb2: Product: UHCI Host Controller
[    1.894646] usb usb2: Manufacturer: Linux 5.17.0+ uhci_hcd
[    1.894649] usb usb2: SerialNumber: 0000:00:1a.0
[    1.894743] hub 2-0:1.0: USB hub found
[    1.894754] hub 2-0:1.0: 2 ports detected
[    1.894922] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.894934] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 3
[    1.895050] ehci-pci 0000:00:1d.7: debug port 2
[    1.899106] ehci-pci 0000:00:1d.7: irq 22, io mem 0xa8906800
[    1.903586] tg3 0000:02:00.0 eth0: Tigon3 [partno(BCM957765) rev 57785100] (PCI Express) MAC address 3c:07:54:14:b2:08
[    1.903593] tg3 0000:02:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.903597] tg3 0000:02:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.903600] tg3 0000:02:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.923502] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.923525] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.923528] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.923531] usb usb3: Product: EHCI Host Controller
[    1.923533] usb usb3: Manufacturer: Linux 5.17.0+ ehci_hcd
[    1.923535] usb usb3: SerialNumber: 0000:00:1d.7
[    1.923541] firewire_ohci 0000:04:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    1.923668] hub 3-0:1.0: USB hub found
[    1.923764] hub 3-0:1.0: 8 ports detected
[    1.924114] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.924127] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    1.924170] uhci_hcd 0000:00:1d.0: detected 2 ports
[    1.924373] uhci_hcd 0000:00:1d.0: irq 19, io port 0x000030e0
[    1.924501] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    1.924507] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.924510] usb usb4: Product: UHCI Host Controller
[    1.924512] usb usb4: Manufacturer: Linux 5.17.0+ uhci_hcd
[    1.924514] usb usb4: SerialNumber: 0000:00:1d.0
[    1.924612] hub 4-0:1.0: USB hub found
[    1.924621] hub 4-0:1.0: 2 ports detected
[    1.925214] ehci-pci 0000:1c:00.2: EHCI Host Controller
[    1.925219] ehci-pci 0000:1c:00.2: new USB bus registered, assigned bus number 5
[    1.925529] ehci-pci 0000:1c:00.2: irq 17, io mem 0xb0b02000
[    1.933815] scsi host0: ahci
[    1.933924] scsi host1: ahci
[    1.934027] scsi host2: ahci
[    1.934123] scsi host3: ahci
[    1.934202] scsi host4: ahci
[    1.934277] scsi host5: ahci
[    1.934325] ata1: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906100 irq 52
[    1.934346] ata2: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906180 irq 52
[    1.934366] ata3: SATA max UDMA/133 abar m2048@0xa8906000 port 0xa8906200 irq 52
[    1.934371] ata4: DUMMY
[    1.934374] ata5: DUMMY
[    1.934376] ata6: DUMMY
[    1.963497] ehci-pci 0000:1c:00.2: USB 2.0 started, EHCI 1.00
[    1.963576] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    1.963580] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.963583] usb usb5: Product: EHCI Host Controller
[    1.963585] usb usb5: Manufacturer: Linux 5.17.0+ ehci_hcd
[    1.963587] usb usb5: SerialNumber: 0000:1c:00.2
[    1.963754] hub 5-0:1.0: USB hub found
[    1.963801] hub 5-0:1.0: 4 ports detected
[    1.964734] ehci-pci 0000:23:00.2: EHCI Host Controller
[    1.964741] ehci-pci 0000:23:00.2: new USB bus registered, assigned bus number 6
[    1.965082] ehci-pci 0000:23:00.2: irq 17, io mem 0xb0f02000
[    1.986368] tg3 0000:1d:00.0 eth1: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[    1.986375] tg3 0000:1d:00.0 eth1: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.986378] tg3 0000:1d:00.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.986381] tg3 0000:1d:00.0 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.993555] firewire_ohci 0000:1e:00.0: added OHCI v1.10 device as card 1, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    2.003369] ehci-pci 0000:23:00.2: USB 2.0 started, EHCI 1.00
[    2.003419] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    2.003424] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.003427] usb usb6: Product: EHCI Host Controller
[    2.003448] usb usb6: Manufacturer: Linux 5.17.0+ ehci_hcd
[    2.003450] usb usb6: SerialNumber: 0000:23:00.2
[    2.003569] hub 6-0:1.0: USB hub found
[    2.003615] hub 6-0:1.0: 4 ports detected
[    2.063663] firewire_ohci 0000:25:00.0: added OHCI v1.10 device as card 2, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    2.077627] tg3 0000:24:00.0 eth2: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[    2.077633] tg3 0000:24:00.0 eth2: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.077637] tg3 0000:24:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.077640] tg3 0000:24:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.208240] ATOM BIOS: Apple
[    2.208373] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.208377] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    2.208384] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.208386] [drm] RAM width 256bits DDR
[    2.208401] [drm] radeon: 1024M of VRAM memory ready
[    2.208403] [drm] radeon: 1024M of GTT memory ready.
[    2.208409] [drm] Loading BARTS Microcode
[    2.208460] [drm] External GPIO thermal controller with fan control
[    2.208475] == power state 0 ==
[    2.208476] 	ui class: none
[    2.208478] 	internal class: boot
[    2.208480] 	caps:
[    2.208481] 	uvd    vclk: 0 dclk: 0
[    2.208483] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.208485] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.208487] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    2.208489] 	status: c r b
[    2.208492] == power state 1 ==
[    2.208493] 	ui class: performance
[    2.208494] 	internal class: none
[    2.208496] 	caps:
[    2.208497] 	uvd    vclk: 0 dclk: 0
[    2.208498] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.208500] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    2.208502] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.208504] 	status:
[    2.208505] == power state 2 ==
[    2.208507] 	ui class: none
[    2.208508] 	internal class: uvd
[    2.208509] 	caps: video
[    2.208511] 	uvd    vclk: 54000 dclk: 40000
[    2.208512] 		power level 0    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    2.208514] 		power level 1    sclk: 29800 mclk: 90000 vddc: 950 vddci: 1100
[    2.208516] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.208518] 	status:
[    2.208519] == power state 3 ==
[    2.208521] 	ui class: none
[    2.208522] 	internal class: uvd_mvc
[    2.208523] 	caps: video
[    2.208525] 	uvd    vclk: 70000 dclk: 56000
[    2.208526] 		power level 0    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    2.208528] 		power level 1    sclk: 50200 mclk: 90000 vddc: 1050 vddci: 1100
[    2.208530] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    2.208532] 	status:
[    2.208533] == power state 4 ==
[    2.208534] 	ui class: battery
[    2.208535] 	internal class: none
[    2.208537] 	caps:
[    2.208538] 	uvd    vclk: 0 dclk: 0
[    2.208539] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.208541] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.208543] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    2.208545] 	status:
[    2.213589] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    2.213594] [drm] radeon: dpm initialized
[    2.213672] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    2.214040] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    2.219201] [drm] PCIE GART of 1024M enabled (table at 0x0000000000162000).
[    2.219301] radeon 0000:01:00.0: WB enabled
[    2.219304] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00
[    2.219307] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c
[    2.220053] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118
[    2.220387] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    2.220417] radeon 0000:01:00.0: radeon: using MSI.
[    2.220443] [drm] radeon: irq initialized.
[    2.233340] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    2.236791] [drm] ring test on 0 succeeded in 3 usecs
[    2.236804] [drm] ring test on 3 succeeded in 7 usecs
[    2.264681] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.266552] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.266559] ata3.00: ATAPI: OPTIARC DVD RW AD-5690H, 4AH5, max UDMA/100
[    2.268702] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.268710] ata3.00: configured for UDMA/100
[    2.274653] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.274727] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.276215] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.276330] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.276339] ata2.00: supports DRM functions and may not be fully accessible
[    2.276343] ata2.00: ATA-9: Samsung SSD 850 EVO 500GB, EMT02B6Q, max UDMA/133
[    2.276434] ata1.00: supports DRM functions and may not be fully accessible
[    2.276438] ata1.00: ATA-9: Samsung SSD 850 PRO 256GB, EXM03B6Q, max UDMA/133
[    2.276958] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.277052] ata1.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.278896] ata2.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    2.279081] ata1.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    2.279164] ata2.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.279207] ata2.00: supports DRM functions and may not be fully accessible
[    2.279383] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    2.279443] ata1.00: supports DRM functions and may not be fully accessible
[    2.281768] ata2.00: configured for UDMA/133
[    2.282248] ata1.00: configured for UDMA/133
[    2.282379] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 850  3B6Q PQ: 0 ANSI: 5
[    2.282626] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 850  2B6Q PQ: 0 ANSI: 5
[    2.283331] usb 5-1: new high-speed USB device number 2 using ehci-pci
[    2.284107] scsi 2:0:0:0: CD-ROM            OPTIARC  DVD RW AD-5690H  4AH5 PQ: 0 ANSI: 5
[    2.313339] usb 6-1: new high-speed USB device number 2 using ehci-pci
[    2.413953] [drm] ring test on 5 succeeded in 2 usecs
[    2.413976] [drm] UVD initialized successfully.
[    2.414088] [drm] ib test on ring 0 succeeded in 0 usecs
[    2.414182] [drm] ib test on ring 3 succeeded in 0 usecs
[    2.423669] usb 1-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    2.423675] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.423947] hub 1-1:1.0: USB hub found
[    2.424048] hub 1-1:1.0: 3 ports detected
[    2.453663] usb 3-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 0.03
[    2.453669] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.453813] hub 3-1:1.0: USB hub found
[    2.453911] hub 3-1:1.0: 4 ports detected
[    2.494059] usb 5-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[    2.494065] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.494339] hub 5-1:1.0: USB hub found
[    2.494557] hub 5-1:1.0: 7 ports detected
[    2.503665] firewire_core 0000:1e:00.0: created device fw0: GUID 000a27020040c4ba, S800
[    2.503673] firewire_core 0000:1e:00.0: phy config: new root=ffc0, gap_count=63
[    2.514094] usb 6-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[    2.514108] usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.514382] hub 6-1:1.0: USB hub found
[    2.514594] hub 6-1:1.0: 7 ports detected
[    2.565352] firewire_core 0000:04:00.0: created device fw1: GUID a4b197fffe3f2da2, S800
[    2.565369] firewire_core 0000:04:00.0: phy config: new root=ffc0, gap_count=63
[    2.583351] usb 1-2: new high-speed USB device number 3 using ehci-pci
[    2.583425] firewire_core 0000:25:00.0: created device fw2: GUID 000a2702006cfdfb, S800
[    2.583451] firewire_core 0000:25:00.0: phy config: new root=ffc0, gap_count=63
[    2.584780] ohci-pci: OHCI PCI platform driver
[    2.584875] ohci-pci 0000:1c:00.0: OHCI PCI host controller
[    2.584888] ohci-pci 0000:1c:00.0: new USB bus registered, assigned bus number 7
[    2.584917] ohci-pci 0000:1c:00.0: irq 19, io mem 0xb0b00000
[    2.587303] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    2.587320] sd 0:0:0:0: [sda] Write Protect is off
[    2.587326] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.587330] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    2.587345] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.587345] sd 1:0:0:0: [sdb] Write Protect is off
[    2.587354] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.587370] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.589814] sd 1:0:0:0: [sdb] supports TCG Opal
[    2.589818] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.589955]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[    2.590810] sd 0:0:0:0: [sda] supports TCG Opal
[    2.590814] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.591241] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.591259] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.591276] sr 2:0:0:0: Attached scsi generic sg2 type 5
[    2.643339] tsc: Refined TSC clocksource calibration: 3400.022 MHz
[    2.643358] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x310263dce6e, max_idle_ns: 440795334146 ns
[    2.643475] clocksource: Switched to clocksource tsc
[    2.667477] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.667483] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.667486] usb usb7: Product: OHCI PCI host controller
[    2.667489] usb usb7: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.667491] usb usb7: SerialNumber: 0000:1c:00.0
[    2.667631] hub 7-0:1.0: USB hub found
[    2.667647] hub 7-0:1.0: 2 ports detected
[    2.667837] ohci-pci 0000:1c:00.1: OHCI PCI host controller
[    2.667843] ohci-pci 0000:1c:00.1: new USB bus registered, assigned bus number 8
[    2.667869] ohci-pci 0000:1c:00.1: irq 16, io mem 0xb0b01000
[    2.725583] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda caddy
[    2.725596] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.747469] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.747474] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.747477] usb usb8: Product: OHCI PCI host controller
[    2.747479] usb usb8: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.747481] usb usb8: SerialNumber: 0000:1c:00.1
[    2.747600] hub 8-0:1.0: USB hub found
[    2.747615] hub 8-0:1.0: 2 ports detected
[    2.747799] ohci-pci 0000:23:00.0: OHCI PCI host controller
[    2.747805] ohci-pci 0000:23:00.0: new USB bus registered, assigned bus number 9
[    2.747833] ohci-pci 0000:23:00.0: irq 19, io mem 0xb0f00000
[    2.783371] usb 3-1.1: new high-speed USB device number 3 using ehci-pci
[    2.817500] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.817506] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.817508] usb usb9: Product: OHCI PCI host controller
[    2.817510] usb usb9: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.817512] usb usb9: SerialNumber: 0000:23:00.0
[    2.817630] hub 9-0:1.0: USB hub found
[    2.817647] hub 9-0:1.0: 2 ports detected
[    2.817825] ohci-pci 0000:23:00.1: OHCI PCI host controller
[    2.817830] ohci-pci 0000:23:00.1: new USB bus registered, assigned bus number 10
[    2.817857] ohci-pci 0000:23:00.1: irq 16, io mem 0xb0f01000
[    2.828674] usb 1-2: New USB device found, idVendor=05ac, idProduct=850b, bcdDevice= 7.55
[    2.828688] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.828694] usb 1-2: Product: FaceTime HD Camera (Built-in)
[    2.828699] usb 1-2: Manufacturer: Apple Inc.
[    2.828703] usb 1-2: SerialNumber: CCGB8K062WDDJRLX
[    2.833334] usb 5-1.4: new full-speed USB device number 3 using ehci-pci
[    2.853374] usb 6-1.4: new full-speed USB device number 3 using ehci-pci
[    2.864512] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    2.887500] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    2.887506] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.887509] usb usb10: Product: OHCI PCI host controller
[    2.887511] usb usb10: Manufacturer: Linux 5.17.0+ ohci_hcd
[    2.887513] usb usb10: SerialNumber: 0000:23:00.1
[    2.887672] hub 10-0:1.0: USB hub found
[    2.887693] hub 10-0:1.0: 2 ports detected
[    2.923365] usb 1-1.1: new full-speed USB device number 4 using ehci-pci
[    2.958792] usb 3-1.1: New USB device found, idVendor=05ac, idProduct=8403, bcdDevice=98.33
[    2.958806] usb 3-1.1: New USB device strings: Mfr=3, Product=4, SerialNumber=2
[    2.958812] usb 3-1.1: Product: Card Reader
[    2.958817] usb 3-1.1: Manufacturer: Apple
[    2.958821] usb 3-1.1: SerialNumber: 000000009833
[    2.960712] usb-storage 3-1.1:1.0: USB Mass Storage device detected
[    2.960785] scsi host6: usb-storage 3-1.1:1.0
[    2.960830] usbcore: registered new interface driver usb-storage
[    2.961140] usbcore: registered new interface driver uas
[    3.023591] usb 5-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[    3.023597] usb 5-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.023600] usb 5-1.4: Product: Display Audio
[    3.023602] usb 5-1.4: Manufacturer: Apple Inc.
[    3.023603] usb 5-1.4: SerialNumber: 152303D9
[    3.026760] hid: raw HID events driver (C) Jiri Kosina
[    3.038254] usbcore: registered new interface driver usbhid
[    3.038258] usbhid: USB HID core driver
[    3.038922] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:00.0/0000:1a:00.0/0000:1b:03.0/0000:1c:00.2/usb5/5-1/5-1.4/5-1.4:1.3/0003:05AC:1107.0001/input/input0
[    3.038956] hid-generic 0003:05AC:1107.0001: input,hidraw0: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:1c:00.2-1.4/input3
[    3.043125] usb 6-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[    3.043131] usb 6-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.043134] usb 6-1.4: Product: Display Audio
[    3.043136] usb 6-1.4: Manufacturer: Apple Inc.
[    3.043138] usb 6-1.4: SerialNumber: 1A0E0738
[    3.054339] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:04.0/0000:1f:00.0/0000:20:00.0/0000:21:00.0/0000:22:03.0/0000:23:00.2/usb6/6-1/6-1.4/6-1.4:1.3/0003:05AC:1107.0002/input/input1
[    3.054379] hid-generic 0003:05AC:1107.0002: input,hidraw1: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:23:00.2-1.4/input3
[    3.063371] usb 3-1.2: new low-speed USB device number 4 using ehci-pci
[    3.073408] [drm] ib test on ring 5 succeeded
[    3.095380] usb 1-1.1: New USB device found, idVendor=0a5c, idProduct=4500, bcdDevice= 1.00
[    3.095394] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.095401] usb 1-1.1: Product: BRCM2046 Hub
[    3.095405] usb 1-1.1: Manufacturer: Apple Inc.
[    3.095730] hub 1-1.1:1.0: USB hub found
[    3.095892] hub 1-1.1:1.0: 3 ports detected
[    3.143382] usb 5-1.5: new high-speed USB device number 4 using ehci-pci
[    3.153365] [drm] radeon atom DIG backlight initialized
[    3.153376] [drm] Radeon Display Connectors
[    3.153380] [drm] Connector 0:
[    3.153383] [drm]   eDP-1
[    3.153386] [drm]   HPD3
[    3.153389] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[    3.153396] [drm]   Encoders:
[    3.153398] [drm]     LCD1: INTERNAL_UNIPHY2
[    3.153402] [drm] Connector 1:
[    3.153404] [drm]   DP-1
[    3.153407] [drm]   HPD1
[    3.153410] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    3.153416] [drm]   Encoders:
[    3.153418] [drm]     DFP1: INTERNAL_UNIPHY1
[    3.153421] [drm] Connector 2:
[    3.153424] [drm]   DP-2
[    3.153426] [drm]   HPD2
[    3.153429] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[    3.153434] [drm]   Encoders:
[    3.153437] [drm]     DFP2: INTERNAL_UNIPHY1
[    3.153440] [drm] Connector 3:
[    3.153442] [drm]   DP-3
[    3.153445] [drm]   HPD4
[    3.153447] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[    3.153453] [drm]   Encoders:
[    3.153463] [drm]     DFP3: INTERNAL_UNIPHY2
[    3.153464] [drm] Connector 4:
[    3.153465] [drm]   DP-4
[    3.153466] [drm]   HPD5
[    3.153467] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 0x647c 0x647c
[    3.153470] [drm]   Encoders:
[    3.153471] [drm]     DFP4: INTERNAL_UNIPHY
[    3.153472] [drm] Connector 5:
[    3.153473] [drm]   VGA-1
[    3.153474] [drm]   DDC: 0x64d8 0x64d8 0x64dc 0x64dc 0x64e0 0x64e0 0x64e4 0x64e4
[    3.153477] [drm]   Encoders:
[    3.153478] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    3.163374] usb 6-1.5: new high-speed USB device number 4 using ehci-pci
[    3.183802] switching from power state:
[    3.183806] 	ui class: none
[    3.183807] 	internal class: boot
[    3.183809] 	caps:
[    3.183811] 	uvd    vclk: 0 dclk: 0
[    3.183812] 		power level 0    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.183815] 		power level 1    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.183817] 		power level 2    sclk: 10000 mclk: 14900 vddc: 900 vddci: 950
[    3.183818] 	status: c b
[    3.183820] switching to power state:
[    3.183821] 	ui class: performance
[    3.183823] 	internal class: none
[    3.183824] 	caps:
[    3.183826] 	uvd    vclk: 0 dclk: 0
[    3.183827] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    3.183829] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    3.183831] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    3.183833] 	status: r
[    3.193355] usb 1-1.2: new high-speed USB device number 5 using ehci-pci
[    3.219789] usb 3-1.2: New USB device found, idVendor=05ac, idProduct=8242, bcdDevice= 0.16
[    3.219795] usb 3-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.219798] usb 3-1.2: Product: IR Receiver
[    3.219800] usb 3-1.2: Manufacturer: Apple Computer, Inc.
[    3.225225] input: Apple Computer, Inc. IR Receiver as /devices/pci0000:00/0000:00:1d.7/usb3/3-1/3-1.2/3-1.2:1.0/0003:05AC:8242.0003/input/input2
[    3.293560] appleir 0003:05AC:8242.0003: input,hiddev96,hidraw2: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.7-1.2/input0
[    3.310915] usb 5-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[    3.310921] usb 5-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.310924] usb 5-1.5: Product: FaceTime HD Camera (Display)
[    3.310926] usb 5-1.5: Manufacturer: Apple Inc.
[    3.310928] usb 5-1.5: SerialNumber: CCGB690CKUDJ9DFX
[    3.323335] usb 3-1.4: new low-speed USB device number 5 using ehci-pci
[    3.330345] usb 6-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[    3.330351] usb 6-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.330354] usb 6-1.5: Product: FaceTime HD Camera (Display)
[    3.330356] usb 6-1.5: Manufacturer: Apple Inc.
[    3.330358] usb 6-1.5: SerialNumber: CC2G3101FFDJ9FLP
[    3.352158] usb 1-1.2: New USB device found, idVendor=05ac, idProduct=1006, bcdDevice=96.15
[    3.352164] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.352167] usb 1-1.2: Product: Keyboard Hub
[    3.352169] usb 1-1.2: Manufacturer: Apple, Inc.
[    3.352171] usb 1-1.2: SerialNumber: 000000000000
[    3.352289] hub 1-1.2:1.0: USB hub found
[    3.352376] hub 1-1.2:1.0: 3 ports detected
[    3.413336] usb 5-1.7: new full-speed USB device number 5 using ehci-pci
[    3.433338] usb 6-1.7: new full-speed USB device number 5 using ehci-pci
[    3.443338] usb 1-1.1.1: new full-speed USB device number 6 using ehci-pci
[    3.478902] usb 3-1.4: New USB device found, idVendor=047d, idProduct=1020, bcdDevice= 1.06
[    3.478908] usb 3-1.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.478911] usb 3-1.4: Product: Kensington Expert Mouse
[    3.481792] input: Kensington Expert Mouse as /devices/pci0000:00/0000:00:1d.7/usb3/3-1/3-1.4/3-1.4:1.0/0003:047D:1020.0004/input/input3
[    3.481844] hid-generic 0003:047D:1020.0004: input,hidraw3: USB HID v1.11 Mouse [Kensington Expert Mouse] on usb-0000:00:1d.7-1.4/input0
[    3.565692] usb 5-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.37
[    3.565698] usb 5-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.565701] usb 5-1.7: Product: Apple Thunderbolt Display
[    3.565703] usb 5-1.7: Manufacturer: Apple Inc.
[    3.565705] usb 5-1.7: SerialNumber: 152303D9
[    3.567711] hid-generic 0003:05AC:9227.0005: hiddev97,hidraw4: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:1c:00.2-1.7/input0
[    3.585870] usb 6-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.39
[    3.585876] usb 6-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.585880] usb 6-1.7: Product: Apple Thunderbolt Display
[    3.585882] usb 6-1.7: Manufacturer: Apple Inc.
[    3.585884] usb 6-1.7: SerialNumber: 1A0E0738
[    3.587896] hid-generic 0003:05AC:9227.0006: hiddev98,hidraw5: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:23:00.2-1.7/input0
[    3.597780] usb 1-1.1.1: New USB device found, idVendor=05ac, idProduct=8215, bcdDevice= 2.08
[    3.597786] usb 1-1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.597789] usb 1-1.1.1: Product: Bluetooth USB Host Controller
[    3.597791] usb 1-1.1.1: Manufacturer: Apple Inc.
[    3.597793] usb 1-1.1.1: SerialNumber: 3451C9ED7F9B
[    3.693327] usb 1-1.2.2: new low-speed USB device number 7 using ehci-pci
[    3.849903] usb 1-1.2.2: New USB device found, idVendor=05ac, idProduct=0220, bcdDevice= 0.71
[    3.849908] usb 1-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.849919] usb 1-1.2.2: Product: Apple Keyboard
[    3.849922] usb 1-1.2.2: Manufacturer: Apple, Inc
[    3.857119] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.0/0003:05AC:0220.0007/input/input4
[    3.923430] apple 0003:05AC:0220.0007: input,hidraw6: USB HID v1.11 Keyboard [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input0
[    3.923519] apple 0003:05AC:0220.0008: Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling
[    3.923549] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.1/0003:05AC:0220.0008/input/input5
[    3.943333] usb 1-1.1.2: new full-speed USB device number 8 using ehci-pci
[    3.993373] apple 0003:05AC:0220.0008: input,hidraw7: USB HID v1.11 Device [Apple, Inc Apple Keyboard] on usb-0000:00:1a.7-1.2.2/input1
[    3.995094] scsi 6:0:0:0: Direct-Access     APPLE    SD Card Reader   1.00 PQ: 0 ANSI: 0
[    3.995361] sd 6:0:0:0: Attached scsi generic sg3 type 0
[    3.995905] sd 6:0:0:0: [sdc] Media removed, stopped polling
[    3.996625] sd 6:0:0:0: [sdc] Attached SCSI removable disk
[    4.097175] usb 1-1.1.2: New USB device found, idVendor=05ac, idProduct=820a, bcdDevice= 1.00
[    4.097182] usb 1-1.1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.098975] input: HID 05ac:820a as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:05AC:820A.0009/input/input6
[    4.163450] hid-generic 0003:05AC:820A.0009: input,hidraw8: USB HID v1.11 Keyboard [HID 05ac:820a] on usb-0000:00:1a.7-1.1.2/input0
[    4.263367] usb 1-1.1.3: new full-speed USB device number 9 using ehci-pci
[    4.416910] usb 1-1.1.3: New USB device found, idVendor=05ac, idProduct=820b, bcdDevice= 1.00
[    4.416924] usb 1-1.1.3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.418721] input: HID 05ac:820b as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.0/0003:05AC:820B.000A/input/input7
[    4.418756] hid-generic 0003:05AC:820B.000A: input,hidraw9: USB HID v1.11 Mouse [HID 05ac:820b] on usb-0000:00:1a.7-1.1.3/input0
[    4.586817] [drm] fb mappable at 0x90363000
[    4.586821] [drm] vram apper at 0x90000000
[    4.586822] [drm] size 14745600
[    4.586824] [drm] fb depth is 24
[    4.586825] [drm]    pitch is 10240
[    4.586917] fbcon: radeondrmfb (fb0) is primary device
[    5.267032] switching from power state:
[    5.267033] 	ui class: performance
[    5.267034] 	internal class: none
[    5.267036] 	caps:
[    5.267036] 	uvd    vclk: 0 dclk: 0
[    5.267037] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    5.267038] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    5.267039] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    5.267039] 	status: c r
[    5.267040] switching to power state:
[    5.267041] 	ui class: performance
[    5.267041] 	internal class: none
[    5.267042] 	caps:
[    5.267042] 	uvd    vclk: 0 dclk: 0
[    5.267043] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    5.267043] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    5.267044] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    5.267045] 	status: c r
[    6.383790] switching from power state:
[    6.383791] 	ui class: performance
[    6.383791] 	internal class: none
[    6.383793] 	caps:
[    6.383793] 	uvd    vclk: 0 dclk: 0
[    6.383794] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    6.383795] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    6.383795] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    6.383796] 	status: c r
[    6.383797] switching to power state:
[    6.383797] 	ui class: performance
[    6.383798] 	internal class: none
[    6.383798] 	caps:
[    6.383799] 	uvd    vclk: 0 dclk: 0
[    6.383799] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[    6.383800] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[    6.383801] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[    6.383801] 	status: c r
[    6.492628] Console: switching to colour frame buffer device 320x90
[    6.497082] radeon 0000:01:00.0: [drm] fb0: radeondrmfb frame buffer device
[    6.533472] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[    6.559724] [drm] amdgpu kernel modesetting enabled.
[    6.645483] netpoll: netconsole: local port 6666
[    6.645499] netpoll: netconsole: local IPv4 address 192.168.2.87
[    6.645513] netpoll: netconsole: interface 'eth0'
[    6.645523] netpoll: netconsole: remote port 6666
[    6.645533] netpoll: netconsole: remote IPv4 address 192.168.2.208
[    6.645546] netpoll: netconsole: remote ethernet address dc:a6:32:61:33:da
[    6.645562] netpoll: netconsole: device eth0 not up yet, forcing it
[   10.315613] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   10.315631] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   10.315645] tg3 0000:02:00.0 eth0: EEE is enabled
[   10.335794] printk: console [netcon0] enabled
[   10.335807] netconsole: network logging started
[   17.413258]  sdb: sdb1
[   17.484448] process '/usr/bin/fstype' started with executable stack
[   17.509027] EXT4-fs (sda6): mounted filesystem with ordered data mode. Quota mode: none.
[   17.707306] udevd[1275]: starting version 3.2.9
[   17.731045] udevd[1276]: starting eudev-3.2.9
[   17.763564] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input8
[   17.766857] ACPI: button: Power Button [PWRB]
[   17.769613] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input9
[   17.771373] ACPI: button: Sleep Button [SLPB]
[   17.772933] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input10
[   17.780099] udevd[1335]: Error changing net interface name eth1 to eth2: File exists
[   17.781163] udevd[1335]: could not rename interface '3' from 'eth1' to 'eth2': File exists
[   17.792778] udevd[1328]: Error changing net interface name eth2 to eth1: File exists
[   17.793868] udevd[1328]: could not rename interface '4' from 'eth2' to 'eth1': File exists
[   17.797367] mc: Linux media interface: v0.10
[   17.802396] videodev: Linux video capture interface: v2.00
[   17.806969] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[   17.808853] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[   17.814156] ACPI: button: Power Button [PWRF]
[   17.816275] usb 1-2: Found UVC 1.00 device FaceTime HD Camera (Built-in) (05ac:850b)
[   17.820576] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input11
[   17.825874] Bluetooth: Core ver 2.22
[   17.826502] usb 5-1.4: 1:1: cannot get freq at ep 0x4
[   17.826789] NET: Registered PF_BLUETOOTH protocol family
[   17.828669] Bluetooth: HCI device and connection manager initialized
[   17.829522] Bluetooth: HCI socket layer initialized
[   17.830352] Bluetooth: L2CAP socket layer initialized
[   17.831177] Bluetooth: SCO socket layer initialized
[   17.835268] usbcore: registered new interface driver btusb
[   17.839657] snd_hda_codec_cirrus hdaudioC0D0: autoconfig for CS4206: line_outs=2 (0x9/0xb/0x0/0x0/0x0) type:speaker
[   17.840688] snd_hda_codec_cirrus hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   17.841322] input: FaceTime HD Camera (Built-in):  as /devices/pci0000:00/0000:00:1a.7/usb1/1-2/1-2:1.0/input/input12
[   17.841766] snd_hda_codec_cirrus hdaudioC0D0:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[   17.843824] snd_hda_codec_cirrus hdaudioC0D0:    mono: mono_out=0x0
[   17.844066] usb 5-1.5: Found UVC 1.00 device FaceTime HD Camera (Display) (05ac:1112)
[   17.844815] snd_hda_codec_cirrus hdaudioC0D0:    dig-out=0x10/0x0
[   17.846915] snd_hda_codec_cirrus hdaudioC0D0:    inputs:
[   17.848090] snd_hda_codec_cirrus hdaudioC0D0:      Mic=0xd
[   17.849148] snd_hda_codec_cirrus hdaudioC0D0:      Line=0xc
[   17.850172] snd_hda_codec_cirrus hdaudioC0D0:    dig-in=0xf
[   17.861495] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   17.862723] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   17.864025] input: HDA Intel PCH SPDIF In as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   17.871660] usb 1-1.1.2: USB disconnect, device number 8
[   17.905760] applesmc: key=332 fan=3 temp=50 index=49 acc=0 lux=2 kbd=0
[   17.906799] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   17.954596] Bluetooth: hci0: BCM: chip id 254 build 0518
[   17.956584] Bluetooth: hci0: BCM: product 05ac:8215
[   17.958583] Bluetooth: hci0: BCM: features 0x00
[   17.976629] Bluetooth: hci0: Bluetooth USB Host Controller
[   17.995601] usb 5-1.4: 1:2: cannot get freq at ep 0x4
[   17.999948] input: FaceTime HD Camera (Display): F as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:00.0/0000:1a:00.0/0000:1b:03.0/0000:1c:00.2/usb5/5-1/5-1.5/5-1.5:1.0/input/input16
[   18.004568] usb 5-1.4: 2:1: cannot get freq at ep 0x84
[   18.043572] usb 5-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   18.044518] usb 5-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   18.081794] usb 5-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   18.082714] usb 5-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   18.084616] usb 6-1.5: Found UVC 1.00 device FaceTime HD Camera (Display) (05ac:1112)
[   18.096581] usb 6-1.4: 1:1: cannot get freq at ep 0x4
[   18.265544] usb 6-1.4: 1:2: cannot get freq at ep 0x4
[   18.270126] input: FaceTime HD Camera (Display): F as /devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:04.0/0000:18:00.0/0000:19:04.0/0000:1f:00.0/0000:20:00.0/0000:21:00.0/0000:22:03.0/0000:23:00.2/usb6/6-1/6-1.5/6-1.5:1.0/input/input17
[   18.271241] usbcore: registered new interface driver uvcvideo
[   18.275487] usb 6-1.4: 2:1: cannot get freq at ep 0x84
[   18.303840] usb 1-1.1.3: USB disconnect, device number 9
[   18.314619] usb 6-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   18.315568] usb 6-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   18.350623] usb 6-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   18.351575] usb 6-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   18.352671] usbcore: registered new interface driver snd-usb-audio
[   19.466533] Adding 16777212k swap on /dev/sda5.  Priority:-2 extents:1 across:16777212k SS
[   19.479522] EXT4-fs (sda6): re-mounted. Quota mode: none.
[   19.567488] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[   22.736999] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Quota mode: none.
[   23.306417] NET: Registered PF_PACKET protocol family
[   26.092695] tg3 0000:02:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   26.093702] tg3 0000:02:00.0 eth0: Flow control is off for TX and off for RX
[   26.094700] tg3 0000:02:00.0 eth0: EEE is enabled
[   32.095886] FS-Cache: Loaded
[   32.101681] RPC: Registered named UNIX socket transport module.
[   32.102524] RPC: Registered udp transport module.
[   32.103401] RPC: Registered tcp transport module.
[   32.104228] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   32.116581] NFS: Registering the id_resolver key type
[   32.117441] Key type id_resolver registered
[   32.118257] Key type id_legacy registered
[   33.404416] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   33.825723] elogind-daemon[3139]: New seat seat0.
[   35.485777] switching from power state:
[   35.485784] 	ui class: performance
[   35.485786] 	internal class: none
[   35.485789] 	caps:
[   35.485790] 	uvd    vclk: 0 dclk: 0
[   35.485791] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   35.485793] 		power level 1    sclk: 39800 mclk: 90000 vddc: 1000 vddci: 1100
[   35.485795] 		power level 2    sclk: 68000 mclk: 90000 vddc: 1100 vddci: 1100
[   35.485797] 	status: c
[   35.485798] switching to power state:
[   35.485799] 	ui class: battery
[   35.485800] 	internal class: none
[   35.485802] 	caps:
[   35.485804] 	uvd    vclk: 0 dclk: 0
[   35.485805] 		power level 0    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   35.485807] 		power level 1    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   35.485808] 		power level 2    sclk: 20000 mclk: 30000 vddc: 950 vddci: 950
[   35.485810] 	status: r
[   42.450996] elogind-daemon[3139]: New session c1 of user brad.t :
